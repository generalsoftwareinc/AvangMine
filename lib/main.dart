import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:avangmine_riverpod/config/config.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await LogicApp().initAll();
  runApp(const ProviderScope(child: MainApp()));
  FlutterNativeSplash.remove();
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appRouter = ref.watch(appRouterRefProvider);
    return ValueListenableBuilder(
        valueListenable: Hive.box('settings').listenable(keys: ['darkMode']),
        builder: (_, box, __) {
          bool darkMode = box.get('darkMode', defaultValue: false);
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'AvangMine',
            theme: AppTheme(isDarkmode: darkMode).getTheme(),
            routerConfig: appRouter,
          );
        });
  }
}
