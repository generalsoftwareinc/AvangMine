import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:avangmine_riverpod/config/config.dart';
import 'package:avangmine_riverpod/presentation/screens/settings/widgets/widgets_settings.dart';

class SettingsScreen extends StatefulHookConsumerWidget {
  const SettingsScreen({super.key, required this.animationController});
  final AnimationController animationController;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  List<Widget> listViews = <Widget>[];

  @override
  void initState() {
    addAllListData();
    super.initState();
  }

  void addAllListData() {
    const int count = 2;
    listViews.add(DarkModeSettigns(
      animation: Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: widget.animationController,
            curve: const Interval((1 / count) * 0, 1.0,
                curve: Curves.fastOutSlowIn)),
      ),
      animationController: widget.animationController,
    ));
    listViews.add(LogoutSettingsWidget(
      animation: Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: widget.animationController,
            curve: const Interval((1 / count) * 2, 1.0,
                curve: Curves.fastOutSlowIn)),
      ),
      animationController: widget.animationController,
    ));
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Align(
        alignment: Alignment.center,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: mediumWidthBreakpoint),
          child: FutureBuilder(
            future: getData(),
            builder: (_, snapshot) {
              if (!snapshot.hasData) {
                return const SizedBox.shrink();
              } else {
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 8),
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
    ));
  }
}
