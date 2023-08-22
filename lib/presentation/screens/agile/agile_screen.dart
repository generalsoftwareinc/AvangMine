import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:avangmine_riverpod/presentation/screens/widgets_common/widgets_common.dart';
import 'package:avangmine_riverpod/presentation/providers/providers.dart';
import 'widgets/widgets_agile.dart';

class AgileScreen extends ConsumerWidget {
  const AgileScreen({
    super.key,
    required this.animationController,
    required this.railAnimation,
  });

  final AnimationController animationController;
  final CurvedAnimation railAnimation;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context).colorScheme;
    final currentUser =
        ref.watch(loginNotifierProvider.select((state) => state.currentUser));
    final projects = currentUser?.getUserProjects();
    if (projects == null || projects.isEmpty) {
      return EmptyProjects(railAnimation: railAnimation);
    }

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: railAnimation.value == 1 ? 125 : 115,
        surfaceTintColor: theme.surface,
        shadowColor: theme.outline,
        flexibleSpace: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: railAnimation.value == 1 ? 10 : 0),
                  const SelectProjectWidget().animate().slideY(),
                  const SizedBox(height: 8),
                  const ListStatusWidget().animate().moveX(),
                ]),
          ),
        ),
      ),
      body: ListDetailTransition(
        animation: railAnimation,
        one: ListIsseusWidget(railAnimation: railAnimation),
        two: const SecondScreen(),
      ),
    );
  }
}
