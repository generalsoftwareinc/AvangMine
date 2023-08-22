import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
// import 'package:redmine_client/utils/locator.dart';

class LogicApp {
  initAll() async {
    // Initialized local Db
    await Hive.initFlutter();
    await Hive.openBox('settings');
    // Hive.deleteFromDisk();
    // registrar todos los adapter
    // await registrarAdapter();

    // Locale format date
    initializeDateFormatting();

    // Injector
    // await DependencyInjection.initialized();
  }
}