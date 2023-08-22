import 'package:avangmine_riverpod/presentation/providers/login_providers.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:flutter_gravatar/flutter_gravatar.dart';

class TopInfoDashBoardWidget extends ConsumerWidget {
  const TopInfoDashBoardWidget(
      {super.key, required this.animation, required this.animationController});
  final Animation<double> animation;
  final AnimationController animationController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context).colorScheme;
    final textTheme =
        Theme.of(context).textTheme.apply(displayColor: theme.onSurface);
    final stateLogin = ref.watch(loginNotifierProvider);
    return AnimatedBuilder(
      animation: animationController,
      builder: (context, child) {
        // final gravatar = Gravatar('${viewmodel.current.mail}');
        return FadeTransition(
          opacity: animation,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 30 * (1.0 - animation.value), 0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // CircleAvatar(
                    //   radius: 16,
                    //   // foregroundImage: NetworkImage(gravatar.imageUrl()),
                    //   child: Text(
                    //       '${viewmodel.current.firstname?[0].toUpperCase()}${viewmodel.current.lastname?[0].toUpperCase()}'),
                    // ),
                    // const SizedBox(width: 8),
                    Text(
                      'Welcome back, ${stateLogin.currentUser?.firstname?.trim()}!',
                      style: textTheme.titleMedium,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'Stay organized, assign tasks, track your progress, and collaborate with ease.',
                  style: textTheme.bodyMedium!.copyWith(color: theme.outline),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        );
      },
    );
  }
}
