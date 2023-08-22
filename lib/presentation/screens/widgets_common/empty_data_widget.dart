import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:tabler_icons/tabler_icons.dart';

class NoDisplayData extends StatelessWidget {
  const NoDisplayData({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final textTheme =
        Theme.of(context).textTheme.apply(displayColor: theme.onSurface);
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: SizedBox(
        height: 450,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Icon(
              TablerIcons.report_search,
              color: theme.outline.withOpacity(.5),
              size: 80,
            ).animate(delay: 200.ms).fade(delay: 200.ms).shake(delay: 300.ms),
            const SizedBox(height: 8),
            Text(
              'No data to display',
              textAlign: TextAlign.center,
              style: textTheme.titleLarge!.copyWith(color: theme.outline),
            ).animate(delay: 200.ms).fade(delay: 200.ms).shakeX(delay: 300.ms)
          ],
        ),
      ),
    );
  }
}
