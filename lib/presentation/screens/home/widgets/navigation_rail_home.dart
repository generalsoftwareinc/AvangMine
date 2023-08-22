import 'package:flutter/material.dart';
import 'package:avangmine_riverpod/config/config.dart';

class NavigationRailSection extends StatelessWidget {
  const NavigationRailSection({
    super.key,
    required this.onDestinationSelected,
    required this.selectedIndex,
    required this.extended,
  });
  final bool extended;
  final ValueChanged<int>? onDestinationSelected;
  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    final ColorScheme theme = Theme.of(context).colorScheme;
    return NavigationRail(
        extended: extended,
        backgroundColor: theme.primary.withOpacity(.14),
        selectedIndex: selectedIndex,
        labelType: !extended ? NavigationRailLabelType.all : null,
        onDestinationSelected: onDestinationSelected,
        groupAlignment: -0.85,
        destinations: destinations.map((e) {
          return NavigationRailDestination(
            icon: Icon(e.icon),
            label: Text(e.label),
            selectedIcon: Icon(e.selectedIcon),
          );
        }).toList());
  }
}
