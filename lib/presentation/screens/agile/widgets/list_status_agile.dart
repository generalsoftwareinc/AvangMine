import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:avangmine_riverpod/presentation/providers/providers.dart';
import 'package:avangmine_riverpod/presentation/screens/widgets_common/widgets_common.dart';

class ListStatusWidget extends ConsumerWidget {
  const ListStatusWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final status = ref.watch(getStatusListProvider);
    final selected = ref.watch(selectStatusAgileProvider);
    return status.when(
      data: (data) => SelectStatusWidget(
        status: data,
        currentStatus: selected,
      ),
      error: (error, stackTrace) => const SizedBox(
        height: 50,
        child: Icon(Icons.error, color: Colors.red),
      ),
      loading: () => const SizedBox(height: 50, child: LoadingWidget()),
    );
  }
}
