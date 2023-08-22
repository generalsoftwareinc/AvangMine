import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tabler_icons/tabler_icons.dart';

class DarkModeSettigns extends ConsumerWidget {
  const DarkModeSettigns(
      {Key? key, required this.animation, required this.animationController})
      : super(key: key);
  final Animation<double> animation;
  final AnimationController animationController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final MaterialStateProperty<Icon?> thumbIcon =
        MaterialStateProperty.resolveWith<Icon?>((states) {
      if (states.contains(MaterialState.selected)) {
        return const Icon(TablerIcons.moon_filled);
      }
      return Icon(TablerIcons.sun_filled,
          size: 26, color: Colors.orange.shade700);
    });

    return AnimatedBuilder(
      animation: animationController,
      builder: (context, child) {
        return FadeTransition(
          opacity: animation,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 30 * (1.0 - animation.value), 0.0),
            child: ValueListenableBuilder(
              valueListenable:
                  Hive.box('settings').listenable(keys: ['darkMode']),
              builder: (_, box, __) {
                bool darkMode = box.get('darkMode', defaultValue: false);
                return SwitchListTile(
                  title: const Text('Dark mode'),
                  secondary: const Icon(TablerIcons.moon),
                  value: darkMode,
                  trackOutlineColor: MaterialStateProperty.resolveWith<Color>(
                    (states) => states.contains(MaterialState.selected)
                        ? Colors.blueAccent
                        : Colors.blue.shade200,
                  ),
                  inactiveThumbColor: Colors.blue.shade50,
                  inactiveTrackColor: Colors.blue.shade50,
                  thumbIcon: thumbIcon,
                  onChanged: (_) async => await box.put('darkMode', !darkMode),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
