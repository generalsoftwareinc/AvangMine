import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tabler_icons/tabler_icons.dart';
import 'package:avangmine_riverpod/presentation/providers/providers.dart';

class DetailsScreen extends ConsumerWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context).colorScheme;
    final textTheme =
        Theme.of(context).textTheme.apply(displayColor: theme.onSurface);
    final state = ref.watch(secondAgileProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Issue details'),
        centerTitle: false,
      ),
      body: SafeArea(
        child: IndexedStack(
          index: state.loading ? 0 : 1,
          children: [
            const Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Loading...'),
                SizedBox(height: 8),
                CircularProgressIndicator(),
              ],
            )),
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Card(
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
                                      child: Text(
                                          '${state.issue?.assignedTo?.name?.split(' ').map((e) => e[0]).join().toUpperCase()}'),
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
                            children: [
                              const Icon(TablerIcons.checklist, size: 28),
                              const SizedBox(width: 8),
                              Text(
                                'Subject',
                                style: textTheme.titleMedium,
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text('${state.issue?.subject}'),
                          if (state.issue?.description != null &&
                              state.issue!.description!.isNotEmpty) ...[
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                const Icon(TablerIcons.file_description,
                                    size: 28),
                                const SizedBox(width: 8),
                                Text(
                                  'Description',
                                  style: textTheme.titleMedium,
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text('${state.issue?.description}'),
                          ],
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              const Icon(TablerIcons.pencil_plus, size: 28),
                              const SizedBox(width: 8),
                              Text(
                                'Author',
                                style: textTheme.titleMedium,
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              CircleAvatar(
                                child: Text(
                                    '${state.issue?.author?.name?.split(' ').map((e) => e[0]).join().toUpperCase()}'),
                              ),
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
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
