import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tabler_icons/tabler_icons.dart';
import 'package:avangmine_riverpod/presentation/providers/providers.dart';
import 'package:avangmine_riverpod/config/config.dart';
import 'package:avangmine_riverpod/domain/domain.dart';
// import 'package:timeago/timeago.dart' as timeago;

class ItemIssueWidget extends ConsumerWidget {
  const ItemIssueWidget({
    Key? key,
    required this.issue,
    required this.isOverdue,
    this.isManager = false,
    required this.railAnimation,
  }) : super(key: key);
  final Issue issue;
  final bool isOverdue;
  final bool isManager;
  final Animation<double> railAnimation;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context).colorScheme;
    final textTheme =
        Theme.of(context).textTheme.apply(displayColor: theme.onSurface);
    late Color bgTracker;
    try {
      bgTracker = colorsTracker
          .firstWhere((e) => e.label == issue.tracker!.name!)
          .color;
    } catch (_) {
      bgTracker = Colors.blue;
    }
    return GestureDetector(
      onTap: () {
        ref.read(secondAgileProvider.notifier).select(issue);
        if (railAnimation.value == 0.0) {
          ref.read(appRouterRefProvider).push('/details', extra: issue);
        }
      },
      child: Card(
        elevation: isOverdue ? .5 : 0,
        shadowColor: isOverdue ? theme.error : null,
        surfaceTintColor: isOverdue ? theme.error : null,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(
              width: isOverdue ? .6 : .3,
              color: isOverdue ? theme.error : theme.outline,
            )),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Wrap(
                    clipBehavior: Clip.antiAlias,
                    spacing: -7,
                    children: [
                      if (issue.parent?.parent != null) ...[
                        IconButton.outlined(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          onPressed: () {},
                          icon: Icon(TablerIcons.dots, color: theme.onSurface),
                        ),
                      ],
                      if (issue.parent != null) ...[
                        OutlinedButton(
                            style: OutlinedButton.styleFrom(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                backgroundColor: theme.background),
                            onPressed: () {},
                            child: Text('#${issue.parent?.id}',
                                style: textTheme.bodyLarge)),
                      ],
                      OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              backgroundColor: theme.background),
                          onPressed: () {},
                          child:
                              Text('#${issue.id}', style: textTheme.bodyLarge)),
                    ],
                  ),
                  Flexible(
                    child: FilledButton(
                        style: FilledButton.styleFrom(
                            backgroundColor: bgTracker,
                            padding: const EdgeInsets.symmetric(horizontal: 8)),
                        onPressed: () {},
                        child: Text(
                          '${issue.tracker?.name}',
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: textTheme.bodyMedium!.copyWith(
                              color: theme.surface,
                              fontWeight: FontWeight.bold),
                        )),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              // Text('${issue.project?.name}', style: textTheme.bodyLarge!.copyWith(color: Colors.red, fontWeight: FontWeight.bold),),
              // const SizedBox(height: 8),
              Text(
                '${issue.subject}',
                style: textTheme.bodyLarge,
              ),
              // SizedBox(height: 8),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Flexible(child: Text('${issue.status?.name}')),
              //     Row(
              //       children: [
              //         CircleAvatar(),
              //         CircleAvatar(),
              //         CircleAvatar(),
              //       ],
              //     )
              //   ],
              // ),
              Text('Author: ${issue.author?.name}'),
              Text('Assignee: ${issue.assignedTo?.name}'),
              Text('Status: ${issue.status?.name}'),
              Text('Priority: ${issue.priority?.name}'),
              Text('updatedOn: ${issue.updatedOn}'),
              if (issue.closedOn != null) ...[
                Text('closedOn: ${issue.closedOn}'),
              ],
              if (issue.dueDate != null) ...[
                Text('Due Date: ${issue.dueDate}'),
              ],
              Text('Updated: ${issue.updatedOn}'),
            ],
          ),
        ),
      ),
    );
  }
}
