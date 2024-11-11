// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../authentication/data/models/models.dart';
import '../../model.dart';
import 'expense_category.dart';

part 'expense_model.freezed.dart';

part 'expense_model.g.dart';

@freezed
class Expense with _$Expense {
  const factory Expense({
    @JsonKey(name: '_id') required String id,
    ExpenseCategory? category,
    String? status,
    String? company,
    int? amount,
    String? description,
    User? incurredBy,
    Vehicle? vehicle,
    String? date,
    String? createdAt,
    String? updatedAt,
  }) = _Expense;

  const Expense._();

  factory Expense.fromJson(Map<String, dynamic> json) => _$ExpenseFromJson(json);

  factory Expense.empty() =>  Expense(
    id: '',
    category: ExpenseCategory.empty(),
    status: '',
  );
}
