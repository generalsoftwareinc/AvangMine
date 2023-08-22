import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:tabler_icons/tabler_icons.dart';

class EmptyProjects extends StatelessWidget {
  const EmptyProjects({super.key, required this.railAnimation});
  final Animation<double> railAnimation;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final textTheme =
        Theme.of(context).textTheme.apply(displayColor: theme.onSurface);
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: SizedBox(
        height: size.height - (railAnimation.value == 0 ? 100 : 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Icon(
              TablerIcons.sitemap,
              color: theme.outline.withOpacity(.5),
              size: 80,
            ).animate().fade(delay: 200.ms).shake(delay: 300.ms),
            const SizedBox(height: 8),
            Text(
              'No projects',
              textAlign: TextAlign.center,
              style: textTheme.titleLarge!.copyWith(color: theme.outline),
            ).animate().fade(delay: 200.ms).shakeX(delay: 300.ms),
          ],
        ),
      ),
    );
  }
}
