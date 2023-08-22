import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:avangmine_riverpod/domain/domain.dart';
import 'package:avangmine_riverpod/presentation/providers/providers.dart';

part 'agile_providers.g.dart';

@Riverpod(keepAlive: true)
class SelectProjectAgile extends _$SelectProjectAgile {
  @override
  Project? build() => null;

  changeSelected(Project project) {
    state = project;
  }
}

@Riverpod(keepAlive: true)
class SelectStatusAgile extends _$SelectStatusAgile {
  @override
  IssueStatus? build() => null;

  changeCurrentStatus(IssueStatus statu) {
    state = statu;
  }
}

final agileListProvider =
    StateNotifierProvider<AgileListNotifier, StateAgile>((ref) {
  return AgileListNotifier(ref);
});

class AgileListNotifier extends StateNotifier<StateAgile> {
  AgileListNotifier(this.ref) : super(StateAgile());
  final Ref ref;

  Future<void> reset() async {
    state = StateAgile();
  }

  Future<void> getList() async {
    final apiTools = ref.watch(apiToolProvider);
    final projects = ref.watch(getProjectsUserProvider);
    final status = await ref.watch(getStatusListProvider.future);
    if (!mounted) return;
    final selectedProject =
        ref.watch(selectProjectAgileProvider) ?? projects.first;
    final selectedStatus = ref.read(selectStatusAgileProvider) ?? status?.first;
    final args = {
      'status_id': '${selectedStatus?.id}',
      'project_id': '${selectedProject.id}',
      'assigned_to_id': 'me',
      'offset': '${state.pageAgile * 25}',
      'limit': '25'
    };
    final responseIssues = await getIssuesService(args, apiTools);
    if (!mounted) return;
    state = state.copyWith(pageAgile: state.pageAgile + 1);
    if (responseIssues.error) {
      state = state.copyWith(errorLoading: true);
    } else {
      state = state.copyWith(
        isLastIssue: (responseIssues.issues?.issues?.length ?? 0) < 25,
        issues: [...state.issues ?? [], ...responseIssues.issues?.issues ?? []],
      );
    }
    state = state.copyWith(loadingPagination: false);
  }
}

@Riverpod(keepAlive: true)
class ScrollStatus extends _$ScrollStatus {
  @override
  ScrollController build() => ScrollController();
}

final secondAgileProvider =
    StateNotifierProvider<SecondAgileNotifier, StateSecondAgile>((ref) {
  return SecondAgileNotifier(ref);
});

class SecondAgileNotifier extends StateNotifier<StateSecondAgile> {
  SecondAgileNotifier(this.ref) : super(StateSecondAgile());
  final Ref ref;

  void select(Issue issueParams) async {
    state = state.copyWith(loading: true);
    // Arreglar
    final issue = await ref.read(getIssueByIDProvider(issueParams.id!).future);
    state = state.copyWith(loading: false, issue: issue);
  }
}

@Riverpod(keepAlive: true)
Future<Issue?> getIssueByID(GetIssueByIDRef ref, int idIssue) async {
  final apiTools = ref.watch(apiToolProvider);
  return await getIssuesXIDService(idIssue, apiTools);
}
