import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tabler_icons/tabler_icons.dart';
import 'package:avangmine_riverpod/presentation/providers/dashboard_providers.dart';
import 'widgets_dashboard.dart';

class ListCardDashBoardWidgets extends ConsumerWidget {
  const ListCardDashBoardWidgets(
      {Key? key, required this.animation, required this.animationController})
      : super(key: key);
  final Animation<double> animation;
  final AnimationController animationController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AnimatedBuilder(
        animation: animationController,
        builder: (context, child) {
          return FadeTransition(
            opacity: animation,
            child: Transform(
                transform: Matrix4.translationValues(
                    0.0, 30 * (1.0 - animation.value), 0.0),
                child: Wrap(
                  runSpacing: 8,
                  spacing: 8,
                  children: _children(context, ref),
                )),
          );
        });
  }

  List<Widget> _children(BuildContext context, WidgetRef ref) {
    LinearGradient avangenioGradient = const LinearGradient(colors: [
      Color.fromRGBO(10, 67, 110, 1),
      Color.fromRGBO(5, 93, 129, 1),
    ]);
    Color warningYellow = const Color.fromRGBO(246, 223, 143, 1);
    return <Widget>[
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: ref.watch(getIssueToMeProvider).when(
                  data: (data) => CardDashboardWidget(
                      counter: '${data?.totalCount}',
                      description: 'Issues asigned to me',
                      icon: TablerIcons.list_details,
                      colorCard: avangenioGradient),
                  error: (error, stackTrace) => CardDashboardWidget(
                      counter: '?',
                      description: 'Issues asigned to me',
                      icon: TablerIcons.list_details,
                      colorCard: avangenioGradient),
                  loading: () => CardDashboardWidget(
                      counter: '?',
                      description: 'Issues asigned to me',
                      icon: TablerIcons.list_details,
                      colorCard: avangenioGradient),
                ),
          ),
          const SizedBox(width: 8),
          Flexible(
            child: ref.watch(getIssuesCreatorMeProvider).when(
                  data: (data) => CardDashboardWidget(
                      counter: '${data?.totalCount}',
                      description: 'Reported issues',
                      icon: TablerIcons.list_details,
                      colorCard: avangenioGradient),
                  error: (error, stackTrace) => CardDashboardWidget(
                      counter: '?',
                      description: 'Reported issues',
                      icon: TablerIcons.list_details,
                      colorCard: avangenioGradient),
                  loading: () => CardDashboardWidget(
                      counter: '?',
                      description: 'Reported issues',
                      icon: TablerIcons.list_details,
                      colorCard: avangenioGradient),
                ),
          ),
        ],
      ),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: ref.watch(getIssuesOverdueProvider).when(
                  data: (data) => CardDashboardWidget(
                      counter: '${data?.totalCount}',
                      description: 'Overdue tasks',
                      icon: TablerIcons.clock_stop,
                      colorCard: warningYellow),
                  error: (error, stackTrace) => CardDashboardWidget(
                      counter: '?',
                      description: 'Overdue tasks',
                      icon: TablerIcons.clock_stop,
                      colorCard: warningYellow),
                  loading: () => CardDashboardWidget(
                      counter: '?',
                      description: 'Overdue tasks',
                      icon: TablerIcons.clock_stop,
                      colorCard: warningYellow),
                ),
          ),
          const SizedBox(width: 8),
          Flexible(
            child: ref.watch(getHoursThisMonthProvider).when(
                  data: (data) => CardDashboardWidget(
                      counter: '$data',
                      error: true,
                      description: 'Reported hours this month',
                      icon: TablerIcons.clock_2,
                      colorCard: avangenioGradient),
                  error: (error, stackTrace) => CardDashboardWidget(
                      counter: '?',
                      error: true,
                      description: 'Reported hours this month',
                      icon: TablerIcons.clock_2,
                      colorCard: avangenioGradient),
                  loading: () => CardDashboardWidget(
                      counter: '?',
                      description: 'Reported hours this month',
                      icon: TablerIcons.clock_2,
                      colorCard: avangenioGradient),
                ),
          ),
        ],
      ),
    ];
  }
}
