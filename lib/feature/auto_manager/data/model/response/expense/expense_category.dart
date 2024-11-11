// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'expense_category.freezed.dart';

part 'expense_category.g.dart';

@freezed
class ExpenseCategory with _$ExpenseCategory {
  const factory ExpenseCategory({
    @JsonKey(name: '_id') required String? id,
    String? name,
    String? description,
    String? createdBy,
    String? createdAt,
    String? updatedAt,
  }) = _ExpenseCategory;

  const ExpenseCategory._();

  factory ExpenseCategory.fromJson(Map<String, dynamic> json) => _$ExpenseCategoryFromJson(json);

  factory ExpenseCategory.empty() => const ExpenseCategory(
    id: '',
    name: '',
  );
}
