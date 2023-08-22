import 'package:freezed_annotation/freezed_annotation.dart';

part 'state_form_login.freezed.dart';

@freezed
class StateFormLogin with _$StateFormLogin {
  factory StateFormLogin({
    @Default('') String server,
    @Default('') String user,
    @Default('') String password,
  }) = _StateFormLogin;
}
