import 'package:flutter/material.dart';
import 'package:avangmine_riverpod/config/config.dart';

class BottomNavigationBars extends StatelessWidget {
  const BottomNavigationBars({
    super.key,
    required this.onSelectItem,
    required this.selectedIndex,
  });

  final int selectedIndex;
  final ValueChanged<int>? onSelectItem;

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: selectedIndex,
      onDestinationSelected: onSelectItem,
      destinations: destinations
          .map((e) => NavigationDestination(
                icon: Icon(e.icon),
                label: e.label,
                tooltip: e.label,
                selectedIcon: Icon(e.selectedIcon),
              ))
          .toList(),
    );
  }
}
