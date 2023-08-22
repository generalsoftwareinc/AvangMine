import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:avangmine_riverpod/domain/domain.dart';

final apiToolProvider =
    StateNotifierProvider<ApiToolsNotifier, ApiTools>((ref) {
  return ApiToolsNotifier();
});

class ApiToolsNotifier extends StateNotifier<ApiTools> {
  ApiToolsNotifier() : super(ApiTools());

  void initialized(String apiKey, String sheme, String host) {
    state = ApiTools(apiKey: apiKey, host: host, sheme: sheme);
  }
}
