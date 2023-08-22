import 'package:avangmine_riverpod/domain/domain.dart';
import 'package:avangmine_riverpod/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_provider.g.dart';

@riverpod
class SelectDestinations extends _$SelectDestinations {
  @override
  int build() => 0;

  changeSelected(int value) {
    state = value;
  }
}

@Riverpod(keepAlive: true)
class ScrollAgile extends _$ScrollAgile {
  @override
  ScrollController build() => ScrollController();
}

@Riverpod(keepAlive: true)
Future<List<IssueStatus>?> getStatusList(GetStatusListRef ref) async {
  final apiTools = ref.watch(apiToolProvider);
  final status = await getIssuesStatusService(apiTools);
  if (status != null && status.isNotEmpty) {
    ref
        .watch(selectStatusAgileProvider.notifier)
        .changeCurrentStatus(status.first);
  }
  return status;
}

@Riverpod(keepAlive: true)
List<Project> getProjectsUser(GetProjectsUserRef ref) {
  final projects = ref
      .watch(loginNotifierProvider.select((state) => state.currentUser))
      ?.getUserProjects();
  return projects ?? [];
}
