import 'package:flutter/material.dart';
import 'package:avangmine_riverpod/presentation/providers/providers.dart';
import 'package:avangmine_riverpod/config/config.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:avangmine_riverpod/presentation/screens/dashboard/widgets/widgets_dashboard.dart';

class DashBoardScreen extends ConsumerStatefulWidget {
  const DashBoardScreen({super.key, required this.animationController});
  final AnimationController animationController;

  @override
  ConsumerState<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends ConsumerState<DashBoardScreen> {
  List<Widget> listViews = <Widget>[];

  Future<bool> _getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
    return true;
  }

  @override
  void initState() {
    addAllListData();
    super.initState();
  }

  void addAllListData() {
    const int count = 3;
    listViews.add(
      TopInfoDashBoardWidget(
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
              parent: widget.animationController,
              curve: const Interval((1 / count) * 0, 1.0,
                  curve: Curves.fastOutSlowIn)),
        ),
        animationController: widget.animationController,
      ),
    );
    listViews.add(ListCardDashBoardWidgets(
      animation: Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: widget.animationController,
            curve: const Interval((1 / count) * 2, 1.0,
                curve: Curves.fastOutSlowIn)),
      ),
      animationController: widget.animationController,
    ));
    listViews.add(ListProjectWidget(
      animation: Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: widget.animationController,
            curve: const Interval((1 / count) * 3, 1.0,
                curve: Curves.fastOutSlowIn)),
      ),
      animationController: widget.animationController,
    ));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return SafeArea(
      child: RefreshIndicator(
        backgroundColor: theme.onPrimaryContainer,
        color: theme.primaryContainer,
        onRefresh: () {
          return Future.wait([
            ref.refresh(getIssueToMeProvider.future),
            ref.refresh(getIssuesCreatorMeProvider.future),
            ref.refresh(getIssuesOverdueProvider.future),
            ref.refresh(getHoursThisMonthProvider.future),
            for (var p in ref.read(getProjectsUserProvider)) ...[
              ref.refresh(getCountDashBoardProvider(p.id).future)
            ]
          ]);
        },
        child: Align(
          alignment: Alignment.center,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: mediumWidthBreakpoint),
            child: FutureBuilder(
              future: _getData(),
              builder: (_, snapshot) {
                if (!snapshot.hasData) {
                  return const SizedBox.shrink();
                } else {
                  return ListView.builder(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    itemCount: listViews.length,
                    itemBuilder: (_, index) {
                      widget.animationController.forward();
                      return listViews[index];
                    },
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
