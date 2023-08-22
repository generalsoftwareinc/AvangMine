import 'package:flutter/material.dart';
import 'package:tabler_icons/tabler_icons.dart';

class Destination {
  final String label;
  final IconData icon;
  final IconData selectedIcon;
  const Destination(this.label, this.icon, this.selectedIcon);
}

const List<Destination> destinations = <Destination>[
  Destination('Dashboard', Icons.dashboard_outlined, Icons.dashboard),
  Destination('Agile', TablerIcons.layout_kanban, TablerIcons.layout_kanban),
  Destination('Settings', TablerIcons.settings, TablerIcons.settings_filled),
];

// const List<Destination> destinationsPM = <Destination>[
//   Destination('Dashboard', Icons.dashboard_outlined, Icons.dashboard),
//   Destination('Manager', TablerIcons.box, TablerIcons.box_seam),
//   Destination('Agile', TablerIcons.layout_kanban, TablerIcons.layout_kanban),
//   Destination('Settings', TablerIcons.settings, TablerIcons.settings_filled),
// ];
