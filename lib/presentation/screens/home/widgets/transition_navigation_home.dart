import 'package:flutter/material.dart';
import 'widgets_home.dart';

class NavigationTransition extends StatefulWidget {
  const NavigationTransition(
      {super.key,
      required this.animationController,
      required this.railAnimation,
      required this.navigationRail,
      required this.navigationBar,
      required this.body});

  final AnimationController animationController;
  final CurvedAnimation railAnimation;
  final Widget navigationRail;
  final Widget navigationBar;
  final Widget body;

  @override
  State<NavigationTransition> createState() => _NavigationTransitionState();
}

class _NavigationTransitionState extends State<NavigationTransition> {
  late final AnimationController controller = widget.animationController;
  late final CurvedAnimation railAnimation = widget.railAnimation;
  late final ReverseAnimation barAnimation = ReverseAnimation(
    CurvedAnimation(
      parent: controller,
      curve: const Interval(0.0, 0.5),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final ColorScheme theme = Theme.of(context).colorScheme;
    return Scaffold(
      body: Row(
        children: <Widget>[
          RailTransition(
            animation: railAnimation,
            backgroundColor: theme.surface,
            child: widget.navigationRail,
          ),
          widget.body,
        ],
      ),
      bottomNavigationBar: BottomBarTransition(
        animation: barAnimation,
        backgroundColor: theme.surface,
        child: widget.navigationBar,
      ),
    );
  }
}
