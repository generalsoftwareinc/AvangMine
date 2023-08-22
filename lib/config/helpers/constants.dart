import 'package:flutter/material.dart';

const Color indigo = Color(0xff0A436E);
const Color indigoOther = Color(0xff0A436E);
const Color warningYellow3 = Color.fromRGBO(246, 223, 143, 1);
const Color warningYellow6 = Color.fromRGBO(237, 192, 32, 1);

const double mediumWidthBreakpoint = 840;
const double largeWidthBreakpoint = 1200;

// const List<IssueStatus> statusDefault = [
//   IssueStatus(id: 1, name: 'TO DO'),
//   IssueStatus(id: 2, name: 'IN PROGRESS'),
// ];

class ColorSeed {
  const ColorSeed(this.label, this.color);
  final String label;
  final Color color;
}

List<ColorSeed> colorsTracker = [
  const ColorSeed('Bugs', Colors.red), // 1Bugs
  const ColorSeed('Bug', Colors.red), // 1Bugs
  ColorSeed('Task', Colors.orange.shade300), // 2 Task
  ColorSeed('Agreements', Colors.green.shade200), // 7Agreements
  const ColorSeed('Incidence', Colors.amber), // 8Incidence
  ColorSeed('User Story', Colors.lightBlue.shade400), // 9User Story
  const ColorSeed('Goal', Colors.green), // 10Goal
  ColorSeed('Risk', Colors.amber.shade200), // 11Risk
  ColorSeed('Meeting', Colors.blue.shade800), // 12Meeting
  ColorSeed('Change Request', Colors.orange.shade700), // 13Change Request
  // 14Lesson
  // 15Service Request
  // 16Nonconformity
  // 17Pull Request
  // ,18Delivery Request
];

// 2Task,9User Story,10Goal,8Incidence,1Bugs,7Agreements,11Risk,12Meeting,13Change Request,14Lesson learned,15Service Request,16Nonconformity,17Pull Request,18Delivery Request
