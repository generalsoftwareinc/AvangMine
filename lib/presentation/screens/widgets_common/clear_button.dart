import 'package:flutter/material.dart';
import 'package:tabler_icons/tabler_icons.dart';

class ClearButton extends StatelessWidget {
  const ClearButton({super.key, required this.controller});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) => IconButton(
        icon: const Icon(TablerIcons.x),
        onPressed: () => controller.clear(),
      );
}
