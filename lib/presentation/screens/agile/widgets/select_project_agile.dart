import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tabler_icons/tabler_icons.dart';
import 'package:avangmine_riverpod/config/config.dart';
import 'package:avangmine_riverpod/domain/domain.dart';
import 'package:avangmine_riverpod/presentation/providers/providers.dart';

class SelectProjectWidget extends ConsumerWidget {
  const SelectProjectWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context).colorScheme;
    final textTheme =
        Theme.of(context).textTheme.apply(displayColor: theme.onSurface);

    final projects = ref.watch(getProjectsUserProvider);
    final selectedProject =
        ref.watch(selectProjectAgileProvider) ?? projects.first;

    final size = MediaQuery.of(context).size;
    return DropdownButtonFormField<Project?>(
        menuMaxHeight: size.height * .65,
        value: selectedProject,
        dropdownColor: theme.onSecondary,
        isExpanded: true,
        isDense: true,
        hint: Row(
          children: [
            Expanded(
                child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(TablerIcons.box),
                const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    '${selectedProject.name}',
                    softWrap: true,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.bodyLarge,
                  ),
                ),
              ],
            )),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              margin: const EdgeInsets.only(left: 8),
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: warningYellow6),
                  color: warningYellow3,
                  borderRadius: BorderRadius.circular(48)),
              child: ref
                  .watch(getCountDashBoardProvider(selectedProject.id))
                  .when(
                      data: (data) => Text('$data',
                          style: const TextStyle(color: Colors.black)),
                      loading: () => const Text('?',
                          style: TextStyle(color: Colors.black)),
                      error: (error, stackTrace) => const Text(
                            '?',
                            style: TextStyle(color: Colors.red),
                          )),
            ),
          ],
        ),
        decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none),
          filled: true,
          isDense: true,
        ),
        items: projects.map((Project? p) {
          return DropdownMenuItem<Project?>(
            value: p,
            child: Row(
              children: [
                Expanded(
                    child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(TablerIcons.box),
                    const SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        '${p?.name}',
                        softWrap: true,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.bodyLarge,
                      ),
                    ),
                  ],
                )),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  margin: const EdgeInsets.only(left: 8),
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: warningYellow6),
                      color: warningYellow3,
                      borderRadius: BorderRadius.circular(48)),
                  child: ref.watch(getCountDashBoardProvider(p!.id)).when(
                      data: (data) => Text('$data',
                          style: const TextStyle(color: Colors.black)),
                      loading: () => const Text('?',
                          style: TextStyle(color: Colors.black)),
                      error: (error, stackTrace) => const Text(
                            '?',
                            style: TextStyle(color: Colors.red),
                          )),
                ),
              ],
            ),
          );
        }).toList(),
        onChanged: (p) async {
          if (p?.id != selectedProject.id) {
            final status = await ref.read(getStatusListProvider.future);
            ref.read(selectProjectAgileProvider.notifier).changeSelected(p!);
            ref
                .read(selectStatusAgileProvider.notifier)
                .changeCurrentStatus(status!.first);
            ref.refresh(agileListProvider.notifier).reset();
            ref
                .read(scrollStatusProvider)
                .animateTo(0, duration: 200.ms, curve: Curves.easeInOut);
          }
        });
  }
}
