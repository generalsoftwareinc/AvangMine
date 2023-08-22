import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:avangmine_riverpod/config/config.dart';
import 'package:avangmine_riverpod/presentation/providers/providers.dart';
import 'package:avangmine_riverpod/presentation/screens/home/widgets/widgets_home.dart';
import 'package:avangmine_riverpod/presentation/screens/screens.dart';

class HomeScreen extends StatefulHookConsumerWidget {
  const HomeScreen({super.key});

  @override
  createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen>
    with TickerProviderStateMixin {
  late AnimationController aniContScreen =
      AnimationController(duration: 550.ms, vsync: this);
  late AnimationController aniContNavigation = AnimationController(
      duration: 1000.ms, vsync: this, reverseDuration: 1250.ms);
  late final CurvedAnimation railAnimation = CurvedAnimation(
    parent: aniContNavigation,
    curve: const Interval(0.5, 1.0),
  );
  bool controllerInitialized = false;
  bool showLargeSizeLayout = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final double width = MediaQuery.of(context).size.width;
    final AnimationStatus status = aniContNavigation.status;
    if (width > mediumWidthBreakpoint) {
      if (width > largeWidthBreakpoint) {
        showLargeSizeLayout = true;
      } else {
        showLargeSizeLayout = false;
      }
      if (status != AnimationStatus.forward &&
          status != AnimationStatus.completed) {
        aniContNavigation.forward();
      }
    } else {
      showLargeSizeLayout = false;
      if (status != AnimationStatus.reverse &&
          status != AnimationStatus.dismissed) {
        aniContNavigation.reverse();
      }
    }
    if (!controllerInitialized) {
      controllerInitialized = true;
      aniContNavigation.value = width > mediumWidthBreakpoint ? 1 : 0;
    }
  }

  @override
  void initState() {
    ref.read(getStatusListProvider);
    ref.read(getProjectsUserProvider);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final darkMode = Theme.of(context).brightness == Brightness.dark;
    final selected = ref.watch(selectDestinationsProvider);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
          statusBarBrightness: darkMode ? Brightness.dark : Brightness.light),
      child: WillPopScope(
        onWillPop: _tryExitApp,
        child: AnimatedBuilder(
          animation: aniContNavigation,
          builder: (context, body) {
            return NavigationTransition(
              animationController: aniContNavigation,
              railAnimation: railAnimation,
              body: Expanded(
                child: [
                  DashBoardScreen(animationController: aniContScreen),
                  AgileScreen(
                    animationController: aniContScreen,
                    railAnimation: railAnimation,
                  ),
                  SettingsScreen(animationController: aniContScreen)
                ][selected],
              ),
              navigationRail: NavigationRailSection(
                selectedIndex: selected,
                extended: showLargeSizeLayout,
                onDestinationSelected: _onSelectedIndex,
              ),
              navigationBar: BottomNavigationBars(
                selectedIndex: selected,
                onSelectItem: _onSelectedIndex,
              ),
            );
          },
        ),
      ),
    );
  }

  Future<bool> _tryExitApp() async {
    final selected = ref.read(selectDestinationsProvider);
    if (selected == 0) {
      return myDialogPlatform(
        context: context,
        title: 'Alert',
        content:
            'You are about to exit the application. Are you sure you want to?',
        cancel: 'Dismmiss',
        confirm: 'Exit',
        isDestructiveAction: true,
      );
    } else {
      aniContScreen.reverse().then((_) async {
        ref.read(selectDestinationsProvider.notifier).changeSelected(0);
      });
      return false;
    }
  }

  _onSelectedIndex(int index) {
    final selected = ref.read(selectDestinationsProvider);
    try {
      int? indexAgile =
          destinations.indexWhere((e) => e.label.contains('Agile'));
      if (selected == indexAgile && index == indexAgile) {
        ref
            .read(scrollAgileProvider)
            .animateTo(0, duration: 300.ms, curve: Curves.fastOutSlowIn);
      }
    } catch (_) {}

    if (index != selected) {
      aniContScreen.reverse().then((_) async {
        ref.read(selectDestinationsProvider.notifier).changeSelected(index);
      });
    }
  }
}
