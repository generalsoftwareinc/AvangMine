import 'package:avangmine_riverpod/domain/domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'state_second_agile.freezed.dart';

@freezed
class StateSecondAgile with _$StateSecondAgile {
  factory StateSecondAgile({
    List<Issue>? issues,
    @Default(false) bool loading,
    Issue? issue,
  }) = _StateSecondAgile;
}
