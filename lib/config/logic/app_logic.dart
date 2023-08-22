import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LogicApp {
  initAll() async {
    const secureStorage = FlutterSecureStorage();
    // if key not exists return null
    final encryptionKeyString = await secureStorage.read(key: 'secret-key');
    if (encryptionKeyString == null) {
      final key = Hive.generateSecureKey();
      await secureStorage.write(key: 'secret-key', value: base64UrlEncode(key));
    }
    final key = await secureStorage.read(key: 'secret-key');
    final encryptionKey = base64Url.decode(key!);
    // Initialized local Db
    await Hive.initFlutter();
    await Hive.openBox('settings',
        encryptionCipher: HiveAesCipher(encryptionKey));

    // Locale format date
    initializeDateFormatting();
  }
}
