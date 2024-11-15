// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_expense_request.freezed.dart';

part 'update_expense_request.g.dart';

@freezed
class UpdateExpenseRequest with _$UpdateExpenseRequest {
  const factory UpdateExpenseRequest({
    required String id,
     String? category,
     double? amount,
    String? description,
    String? incurredBy,
    String? vehicleId,
    String? date,
  }) = _UpdateExpenseRequest;

  const UpdateExpenseRequest._();

  factory UpdateExpenseRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateExpenseRequestFromJson(json);


}
