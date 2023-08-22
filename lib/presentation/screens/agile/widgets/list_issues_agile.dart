import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:avangmine_riverpod/domain/domain.dart';
import 'package:avangmine_riverpod/presentation/screens/widgets_common/widgets_common.dart';
import 'package:avangmine_riverpod/presentation/providers/providers.dart';

class ListIsseusWidget extends ConsumerWidget {
  const ListIsseusWidget({
    Key? key,
    required this.railAnimation,
  }) : super(key: key);
  final Animation<double> railAnimation;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    DateTime now = DateTime.now().subtract(const Duration(days: 1));
    final theme = Theme.of(context).colorScheme;
    final state = ref.watch(agileListProvider);
    if (!state.isLastIssue && state.issues == null) {
      ref.watch(agileListProvider.notifier).getList();
    }

    final scroll = ref.watch(scrollAgileProvider);
    Widget? aux;
    if (state.issues == null || state.issues!.isEmpty) {
      if (state.loadingPagination) {
        aux = const SizedBox(
            height: 100,
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: LoadingWidget()));
      } else if (state.errorLoading) {
        aux = SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Container(
              color: theme.surface,
              height: 500,
            ));
      } else {
        aux = const NoDisplayData();
      }
    } else {
      aux = ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        controller: scroll,
        itemCount: state.issues?.length ?? 0 + (state.isLastIssue ? 0 : 1),
        itemBuilder: (context, i) {
          if (i == state.issues!.length - 3 && !state.isLastIssue) {
            ref.read(agileListProvider.notifier).getList();
          }
          if (i == state.issues!.length) {
            if (state.errorLoading) {
              return const SizedBox.shrink();
            }
            return const SizedBox(height: 50, child: LoadingWidget());
          }
          Issue issue = state.issues![i];
          int? isOverdue =
              issue.dueDate != null ? now.compareTo(issue.dueDate!) : null;
          return ItemIssueWidget(
            issue: issue,
            isOverdue: isOverdue == 1,
            railAnimation: railAnimation,
          );
        },
      )
          .animate()
          .fade()
          .slideY(begin: 1, end: 0, curve: Curves.fastLinearToSlowEaseIn);
    }

    return RefreshIndicator(
        backgroundColor: theme.onPrimaryContainer,
        color: theme.primaryContainer,
        onRefresh: () => Future.wait([
              ref.refresh(agileListProvider.notifier).reset(),
              for (var p in ref.read(getProjectsUserProvider)) ...[
                ref.refresh(getCountDashBoardProvider(p.id).future)
              ]
            ]),
        child: aux);
  }
}
