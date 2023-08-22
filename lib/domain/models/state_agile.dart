import 'package:avangmine_riverpod/domain/domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'state_agile.freezed.dart';

@freezed
class StateAgile with _$StateAgile {
  factory StateAgile({
    List<Issue>? issues,
    @Default(0) int pageAgile,
    @Default(true) bool loadingPagination,
    @Default(false) bool isLastIssue,
    @Default(false) bool errorLoading,
  }) = _StateAgile;
}
