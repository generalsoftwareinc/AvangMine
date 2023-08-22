import 'dart:io';
import 'package:flutter/cupertino.dart';
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
  return await showDialog(
          context: context,
          builder: (_) {
            if (Platform.isAndroid) {
              return AlertDialog(
                title: Text(title),
                content: Text(content),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(_, false),
                    child: Text(cancel),
                  ),
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
                ],
              ).animate().fade().slide();
            }
            return CupertinoAlertDialog(
              title: Text(title),
              content: Text(
                content,
                style: const TextStyle(fontSize: 14),
              ),
              actions: [
                CupertinoDialogAction(
                  child: Text(cancel),
                  onPressed: () => Navigator.pop(_, false),
                ),
                CupertinoDialogAction(
                  isDefaultAction: true,
                  isDestructiveAction: isDestructiveAction,
                  onPressed: () => Navigator.pop(_, true),
                  child: Text(confirm),
                ),
              ],
            ).animate().fade().slide();
          }) ??
      false;
}
