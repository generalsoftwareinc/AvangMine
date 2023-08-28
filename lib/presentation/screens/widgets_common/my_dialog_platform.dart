import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

Future<bool> myDialogPlatform({
  required BuildContext context,
  required String title,
  required String content,
  required String cancel,
  required String confirm,
  bool isDestructiveAction = false,
}) async {
  final theme = Theme.of(context).colorScheme;
  return await showAdaptiveDialog(
          barrierDismissible: true,
          context: context,
          builder: (_) {
            return AlertDialog.adaptive(
              title: Text(title),
              content: Text(content),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(_, false),
                  child: Text(cancel),
                ),
                if (Platform.isAndroid) ...{
                  FilledButton(
                    style: FilledButton.styleFrom(
                        backgroundColor:
                            isDestructiveAction ? theme.error : null),
                    onPressed: () => Navigator.pop(_, true),
                    child: Text(
                      confirm,
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ),
                } else ...{
                  TextButton(
                    onPressed: () => Navigator.pop(_, true),
                    child: Text(
                      confirm,
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: isDestructiveAction ? theme.error : null),
                    ),
                  ),
                },
              ],
            ).animate().fade().slide();
          }) ??
      false;
}
