import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tabler_icons/tabler_icons.dart';
import 'package:avangmine_riverpod/config/config.dart';
import 'package:avangmine_riverpod/presentation/providers/providers.dart';
import 'package:avangmine_riverpod/presentation/screens/widgets_common/widgets_common.dart';

class LogoutSettingsWidget extends StatefulHookConsumerWidget {
  const LogoutSettingsWidget(
      {Key? key, required this.animation, required this.animationController})
      : super(key: key);
  final Animation<double> animation;
  final AnimationController animationController;

  @override
  ConsumerState<LogoutSettingsWidget> createState() =>
      _LogoutSettingsWidgetState();
}

class _LogoutSettingsWidgetState extends ConsumerState<LogoutSettingsWidget> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return AnimatedBuilder(
      animation: widget.animationController,
      builder: (context, child) {
        return FadeTransition(
          opacity: widget.animation,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 30 * (1.0 - widget.animation.value), 0.0),
            child: ListTile(
              leading: const Icon(TablerIcons.logout),
              title: const Text('Logout'),
              trailing:
                  Icon(TablerIcons.chevron_right, color: theme.onBackground),
              onTap: () async {
                final dialog = await myDialogPlatform(
                    context: context,
                    title: 'Alert',
                    content:
                        'You are about to log off. Are you sure you want to do it?',
                    cancel: 'Dismiss',
                    confirm: 'Logout',
                    isDestructiveAction: true);
                if (dialog) {
                  // await viewModel.onPressedLogout();
                  final isOK = await ref.read(logoutSttingsProvider.future);
                  if (isOK) {
                    if (!mounted) return;
                    ref.read(appRouterRefProvider).pushReplacement('/');
                  }
                  // Navigator.pushReplacementNamed(context, Routes.login);
                }
              },
            ),
          ),
        );
      },
    );
  }
}
