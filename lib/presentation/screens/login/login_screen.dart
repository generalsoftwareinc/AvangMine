import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:avangmine_riverpod/presentation/screens/widgets_common/widgets_common.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'widgets/widget_logins.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context).colorScheme;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(statusBarBrightness: Brightness.dark),
      child: Scaffold(
        body: Stack(
          children: [
            backgroundLogin(context),
            Align(
              alignment: Alignment.center,
              child: SingleChildScrollView(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 500),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(width: .25, color: theme.primary),
                    ),
                    margin: const EdgeInsets.all(16),
                    elevation: 0,
                    color: theme.onSecondary,
                    child: const FormLogin(),
                  ).animate().fadeIn().scaleXY(
                      begin: 2,
                      end: 1,
                      duration: 300.ms) // runs after the above w/new duration
                  ,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
