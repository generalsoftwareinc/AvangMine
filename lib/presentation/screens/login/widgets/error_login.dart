import 'package:flutter/material.dart';
import 'package:tabler_icons/tabler_icons.dart';

class ErrorLoginWidget extends StatelessWidget {
  const ErrorLoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final textTheme =
        Theme.of(context).textTheme.apply(displayColor: theme.onSurface);
    return Column(
      children: [
        Card(
          elevation: 0,
          color: theme.errorContainer,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Flex(
              direction: Axis.horizontal,
              children: [
                Icon(
                  TablerIcons.exclamation_circle,
                  color: theme.error,
                ),
                const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    'Unsuccessful login',
                    style: textTheme.labelLarge!.copyWith(color: theme.error),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
