import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tabler_icons/tabler_icons.dart';
import 'package:avangmine_riverpod/config/config.dart';
import 'package:avangmine_riverpod/domain/domain.dart';
import 'package:avangmine_riverpod/presentation/providers/providers.dart';
import 'package:avangmine_riverpod/presentation/screens/widgets_common/widgets_common.dart';

class ItemProjectDashboardWidget extends ConsumerWidget {
  const ItemProjectDashboardWidget({
    super.key,
    required this.project,
    required this.animationController,
  });
  final AnimationController animationController;
  final Project project;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context).colorScheme;
    // final isPM = context.select<HomeViewModel, bool>((c) => c.isProjectManager);
    // List<Destination> aux = isPM ? destinationsPM : destinations;
    final count = ref.watch(getCountDashBoardProvider(project.id));
    return GestureDetector(
      onTap: () async {
        int? indexAgile;
        try {
          indexAgile =
              destinations.indexWhere((e) => e.label.contains('Agile'));
          if (ref.read(selectProjectAgileProvider) != project) {
            ref
                .read(selectProjectAgileProvider.notifier)
                .changeSelected(project);
            final status = await ref.read(getStatusListProvider.future);
            ref
                .read(selectStatusAgileProvider.notifier)
                .changeCurrentStatus(status!.first);
            ref.refresh(agileListProvider.notifier).reset();
          }
          // viewModel.selectedStatusAgile = viewModel.statusLists!.first;
          animationController.reverse().then<dynamic>((_) async {
            ref
                .read(selectDestinationsProvider.notifier)
                .changeSelected(indexAgile ?? 0);

            // viewModel.selectedHomeIndex = indexAgile ?? 0;
          });
        } catch (_) {}
      },
      child: Card(
        margin: const EdgeInsets.only(top: 16),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(
              width: 0.35,
              color: theme.outline,
            )),
        elevation: 0,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      '${project.name}',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: theme.onPrimaryContainer),
                      softWrap: true,
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 5),
                        decoration: BoxDecoration(
                            border: Border.all(width: 1, color: warningYellow6),
                            color: warningYellow3,
                            borderRadius: BorderRadius.circular(48)),
                        child: count.when(
                          data: (data) => CounterWidget(
                            count: data!.toDouble(),
                            textStyle: const TextStyle(color: Colors.black),
                            trailingText: ' Issues',
                          ),
                          error: (error, stackTrace) => const Text(
                            '? Issues',
                            style: TextStyle(color: Colors.red),
                          ),
                          loading: () => const Text(
                            '? Issues',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),

                        // Column(
                        //   children: [
                        //     Selector<HomeViewModel, List<CountIssue>?>(
                        //       selector: (_, c) => c.countsIssue,
                        //       builder: (context, value, child) {
                        //         final count =
                        //             viewModel.getCountDash(widget.project);
                        //         if (count != null) {
                        //           return CounterWidget(
                        //             count: count.toDouble(),
                        //             textStyle:
                        //                 const TextStyle(color: Colors.black),
                        //             trailingText: ' Issues',
                        //           );
                        //         } else {
                        //           return const Text(
                        //             '? Issues',
                        //             style: TextStyle(color: Colors.black),
                        //           );
                        //         }
                        //       },
                        //     )
                        //   ],
                        // ),
                      ),
                      const SizedBox(width: 8),
                      Icon(
                        TablerIcons.chevron_right,
                        color: theme.outline,
                        size: 20,
                      )
                          .animate(
                              onPlay: (controller) =>
                                  controller.repeat(reverse: true))
                          .slideX(
                              begin: -0.05,
                              end: 0.1,
                              duration: 800.ms,
                              curve: Curves.linear)
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
