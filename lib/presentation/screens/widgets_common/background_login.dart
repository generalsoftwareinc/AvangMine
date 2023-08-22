import 'package:flutter/material.dart';
import 'package:avangmine_riverpod/config/config.dart';

Widget backgroundLogin(BuildContext context) {
  final theme = Theme.of(context).colorScheme;

  return Positioned.fill(
      child: Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Expanded(
          child: DecoratedBox(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: const AssetImage('assets/Isolation_Mode.png'),
                colorFilter:
                    ColorFilter.mode(theme.background, BlendMode.srcIn),
                fit: BoxFit.cover),
            gradient: LinearGradient(
                colors: [indigo, indigoOther, theme.background],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter)),
      )),
      Expanded(child: Container(color: theme.surface)),
    ],
  ));
}
