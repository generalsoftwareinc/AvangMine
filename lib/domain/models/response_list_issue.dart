import 'package:avangmine_riverpod/domain/domain.dart';

class ResponseIssue {
  final Issues? issues;
  final bool error;
  ResponseIssue({required this.issues, required this.error});
}
