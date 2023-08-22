import 'package:avangmine_riverpod/domain/domain.dart';
import 'package:avangmine_riverpod/presentation/providers/api_tools.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:intl/intl.dart';

part 'dashboard_providers.g.dart';

@Riverpod(keepAlive: true)
Future<Issues?> getIssueToMe(GetIssueToMeRef ref) async {
  final apiTools = ref.watch(apiToolProvider);
  return await getAssignedToMe(apiTools);
}

@Riverpod(keepAlive: true)
Future<Issues?> getIssuesCreatorMe(GetIssuesCreatorMeRef ref) async {
  final apiTools = ref.watch(apiToolProvider);
  final args = {'author_id': 'me', 'status_id': 'open'};
  ResponseIssue response = await getIssuesService(args, apiTools);
  return response.issues;
}

@Riverpod(keepAlive: true)
Future<Issues?> getIssuesOverdue(GetIssuesOverdueRef ref) async {
  final apiTools = ref.watch(apiToolProvider);
  DateTime now = DateTime.now().subtract(const Duration(days: 1));
  String formatDate = DateFormat('yyyy-MM-dd').format(now);
  return await getOverdueTasks(formatDate, apiTools);
}

@Riverpod(keepAlive: true)
Future<double?> getHoursThisMonth(GetHoursThisMonthRef ref) async {
  final apiTools = ref.watch(apiToolProvider);
  final now = DateTime.now();
  final initMonth = DateTime(now.year, now.month);
  final formattedDate = DateFormat('yyyy-MM-dd').format(initMonth);
  final args = {'author_id': 'me', 'from': formattedDate, 'limit': '100'};
  final timeEntries = await getTimesEntriesService(args, apiTools);
  if (timeEntries == null ||
      timeEntries.timeEntries == null ||
      timeEntries.timeEntries!.isEmpty) {
    return 0;
  }
  return timeEntries.timeEntries!
      .map((e) => e.hours ?? 0)
      .fold<double>(0.0, (sum, hours) => sum + hours);
}

@Riverpod(keepAlive: true)
Future<int?> getCountDashBoard(GetCountDashBoardRef ref, int idProject) async {
  final apiTools = ref.watch(apiToolProvider);
  // final idProject = ref.watch(projectIDDashProvider);
  return await getIssueXProjectAssigned(idProject, apiTools);
}

// @Riverpod(keepAlive: true)
// class ProjectIDDash extends _$ProjectIDDash {
//   @override
//   int? build() => null;

//   changeIdCount(int idProject) {
//     state = idProject;
//   }
// }
