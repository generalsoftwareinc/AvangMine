// ignore_for_file: unused_result
import 'dart:developer';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:avangmine_riverpod/presentation/providers/providers.dart';

part 'settings_providers.g.dart';

@riverpod
Future<bool> logoutSttings(LogoutSttingsRef ref) async {
  try {
    final box = Hive.box('settings');
    await box.delete('apiKey');
    await box.delete('auth');
    ref.refresh(loginNotifierProvider.notifier);
    ref.refresh(apiToolProvider.notifier);
    return true;
  } catch (e) {
    log('onPressedLogout: $e');
    return false;
  }
}
