import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tabler_icons/tabler_icons.dart';
import 'package:avangmine_riverpod/presentation/providers/providers.dart';

class SecondScreen extends ConsumerWidget {
  const SecondScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context).colorScheme;
    final textTheme =
        Theme.of(context).textTheme.apply(displayColor: theme.onSurface);
    final state = ref.watch(secondAgileProvider);
    if (state.loading) {
      return const SafeArea(
        left: false,
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Loading...'),
            SizedBox(height: 8),
            CircularProgressIndicator(),
          ],
        )),
      );
    }
    if (state.issue == null) {
      return Center(
          child: Text('Selected a issue', style: textTheme.titleLarge));
    }

    late String? assignedToLetter;
    late String? authorLetter;
    try {
      authorLetter = state.issue?.author?.name
          ?.split(' ')
          .map((e) => e.trim()[0])
          .toList()
          .getRange(0, 2)
          .join()
          .toUpperCase();
    } catch (_) {
      authorLetter = state.issue?.author?.name?[0].toUpperCase();
    }
    try {
      assignedToLetter = state.issue?.assignedTo?.name
          ?.split(' ')
          .map((e) => e.trim()[0])
          .toList()
          .getRange(0, 2)
          .join()
          .toUpperCase();
    } catch (_) {
      assignedToLetter = state.issue?.assignedTo?.name?[0].toUpperCase();
    }
    return Scaffold(
      body: FocusTraversalGroup(
        child: SafeArea(
          left: false,
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
            child: Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide(
                    width: .3,
                    color: theme.outline,
                  )),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text('Issue details', style: textTheme.titleLarge),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            OutlinedButton(
                                onPressed: () {},
                                child: Text(
                                  '#${state.issue?.id}',
                                  style: textTheme.bodyMedium,
                                )),
                            const SizedBox(width: 8),
                          ],
                        ),
                        Flexible(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              CircleAvatar(
                                child: Text('$assignedToLetter'),
                              ),
                              const SizedBox(width: 8),
                              Flexible(
                                child: Text(
                                  '${state.issue?.assignedTo?.name}',
                                  maxLines: 1,
                                  softWrap: true,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(TablerIcons.checklist, size: 28),
                        const SizedBox(width: 8),
                        Text('Subject', style: textTheme.titleMedium),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text('${state.issue?.subject}'),
                    if (state.issue?.description != null &&
                        state.issue!.description!.isNotEmpty) ...[
                      const SizedBox(height: 16),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(TablerIcons.file_description, size: 28),
                          const SizedBox(width: 8),
                          Text('Description', style: textTheme.titleMedium),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text('${state.issue?.description}'),
                    ],
                    const SizedBox(height: 16),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(TablerIcons.pencil_plus, size: 28),
                        const SizedBox(width: 8),
                        Text('Author', style: textTheme.titleMedium),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircleAvatar(child: Text('$authorLetter')),
                        const SizedBox(width: 8),
                        Text('${state.issue?.author?.name}'),
                      ],
                    ),

                    // Text('assignedTo: ${issue.assignedTo?.name}'),
                    // Text('createdOn: ${issue.createdOn}'),
                    // Text('updatedOn: ${issue.updatedOn}'),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
