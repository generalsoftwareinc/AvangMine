import 'package:flutter/material.dart';

class CounterWidget extends StatefulWidget {
  const CounterWidget({
    Key? key,
    required this.count,
    required this.textStyle,
    this.floating = 0,
    this.trailingText = '',
  }) : super(key: key);

  final double count;
  final TextStyle textStyle;
  final int floating;
  final String? trailingText;

  @override
  State<CounterWidget> createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: widget.count),
      curve: Curves.linearToEaseOut,
      duration: Duration(milliseconds: widget.floating == 0 ? 800 : 1200),
      builder: (_, value, __) {
        return Text(
            '${value.toStringAsFixed(widget.floating > 2 ? 2 : widget.floating)}${widget.trailingText}',
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: widget.textStyle);
      },
    );
  }
}
