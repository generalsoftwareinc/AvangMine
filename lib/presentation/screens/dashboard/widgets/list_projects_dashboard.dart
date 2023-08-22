import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:avangmine_riverpod/presentation/providers/providers.dart';
import 'widgets_dashboard.dart';

class ListProjectWidget extends ConsumerWidget {
  const ListProjectWidget(
      {Key? key, required this.animation, required this.animationController})
      : super(key: key);

  final Animation<double> animation;
  final AnimationController animationController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final projects = ref.watch(getProjectsUserProvider);
    List<Widget> listViews = <Widget>[];
    if (projects.isNotEmpty) {
      for (var i = 0; i < projects.length; i++) {
        listViews.add(
          ItemProjectDashboardWidget(
            project: projects[i],
            animationController: animationController,
          ),
        );
      }
    }

    return AnimatedBuilder(
      animation: animationController,
      builder: (context, child) {
        return FadeTransition(
          opacity: animation,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 30 * (1.0 - animation.value), 0.0),
            child: Column(
              children: [
                const SizedBox(height: 8),
                if (projects.isEmpty) ...[
                  const SizedBox.shrink()
                ] else ...[
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: listViews
                          .animate(interval: 100.ms)
                          .fade(duration: 250.ms)
                          .moveX(begin: 50))
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
