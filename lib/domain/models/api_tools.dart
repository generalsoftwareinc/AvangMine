import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_tools.freezed.dart';

@freezed
class ApiTools with _$ApiTools {
  factory ApiTools({
    @Default('') String apiKey,
    @Default('') String sheme,
    @Default('') String host,
  }) = _ApiTools;
}
