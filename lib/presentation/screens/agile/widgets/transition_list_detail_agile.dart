import 'package:flutter/material.dart';
import 'package:avangmine_riverpod/config/config.dart';

class ListDetailTransition extends StatefulWidget {
  const ListDetailTransition({
    Key? key,
    required this.animation,
    required this.one,
    required this.two,
  }) : super(key: key);

  final Animation<double> animation;
  final Widget one;
  final Widget two;

  @override
  State<ListDetailTransition> createState() => _ListDetailTransitionState();
}

class _ListDetailTransitionState extends State<ListDetailTransition> {
  late final Animation<Offset> offsetAnimation = Tween<Offset>(
    begin: const Offset(1, 0),
    end: Offset.zero,
  ).animate(OffsetAnimation(parent: widget.animation));
  late final Animation<double> widthAnimation = Tween<double>(
    begin: 0,
    end: mediumWidthBreakpoint,
  ).animate(SizeAnimation(parent: widget.animation));

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          flex: mediumWidthBreakpoint.toInt(),
          child: widget.one,
        ),
        if (widthAnimation.value.toInt() > 0) ...[
          Flexible(
            flex: widthAnimation.value.toInt(),
            child: FractionalTranslation(
              translation: offsetAnimation.value,
              child: widget.two,
            ),
          )
        ],
      ],
    );
  }
}
