import 'package:flutter/material.dart';
import 'package:avangmine_riverpod/domain/domain.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:avangmine_riverpod/presentation/providers/providers.dart';

class SelectStatusWidget extends ConsumerWidget {
  const SelectStatusWidget({
    Key? key,
    required this.status,
    required this.currentStatus,
    this.isManager = false,
  }) : super(key: key);
  final List<IssueStatus>? status;
  final IssueStatus? currentStatus;
  final bool isManager;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context).colorScheme;

    return SingleChildScrollView(
      controller: ref.watch(scrollStatusProvider),
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: status!.map((e) {
          final selected = e == currentStatus;
          return Container(
            margin: const EdgeInsets.only(right: 3),
            child: FilterChip(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              side: BorderSide(color: theme.primary),
              selectedColor: theme.primary,
              checkmarkColor: theme.background,
              label: Text(
                '${e.name}',
                style: TextStyle(
                    color: selected ? theme.surface : theme.onSurface),
              ),
              selected: selected,
              onSelected: (_) async {
                if (e != currentStatus) {
                  // TODO: Arreglar
                  ref
                      .read(selectStatusAgileProvider.notifier)
                      .changeCurrentStatus(e);

                  ref.refresh(agileListProvider.notifier).reset();
                  // viewModelHome.resetValuesAgile();
                  // viewModelHome.selectedStatusAgile = e;
                  // viewModelHome.getIssuesXStatus(
                  //     idProject: viewModelHome.selectedProjectAgile!.id,
                  //     idStatus: e.id);
                  // if (isManager) {
                  //   viewModelHome.resetValuesManager();
                  //   viewModelHome.selectedStatusManager = e;
                  //   viewModelHome.getIssuesXStatusManager(
                  //       idProject: viewModelHome.selectedProjectManager!.id,
                  //       idStatus: e.id);
                  // } else {
                  //   viewModelHome.resetValuesAgile();
                  //   viewModelHome.selectedStatusAgile = e;
                  //   viewModelHome.getIssuesXStatus(
                  //       idProject: viewModelHome.selectedProjectAgile!.id,
                  //       idStatus: e.id);
                  // }
                }
              },
            ),
          );
        }).toList(),
      ),
    );
  }
}
