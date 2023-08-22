import 'package:avangmine_riverpod/domain/domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'state_login.freezed.dart';

@freezed
class StateLogin with _$StateLogin {
  factory StateLogin({
    @Default(false) bool? loading,
    @Default(false) bool? error,
    @Default(false) bool? isAuth,
    @Default(true) bool? hidePassword,
    User? currentUser,
  }) = _StateLogin;
}
