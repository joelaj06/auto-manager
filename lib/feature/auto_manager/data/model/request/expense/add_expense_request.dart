// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_expense_request.freezed.dart';

part 'add_expense_request.g.dart';

@freezed
class AddExpenseRequest with _$AddExpenseRequest {
  const factory AddExpenseRequest({
    required String category,
    required double amount,
    String? description,
    String? incurredBy,
    String? vehicleId,
    String? date,
  }) = _AddExpenseRequest;

  const AddExpenseRequest._();

  factory AddExpenseRequest.fromJson(Map<String, dynamic> json) =>
      _$AddExpenseRequestFromJson(json);


}
