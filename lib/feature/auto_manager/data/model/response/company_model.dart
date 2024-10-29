// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

import 'address_model.dart';

part 'company_model.freezed.dart';

part 'company_model.g.dart';

@freezed
class Company with _$Company {
  const factory Company({
    @JsonKey(name: '_id') required String? id,
    String? name,
    String? industry,
    Address? address,
    String? phone,
    String? email,
    String? website,
    String? registrationNumber,
    String? taxIdentificationNumber,
    String? companyType,
    bool? isActive,
    bool? isVerified,
    String? ownerId,
    int? employeesCount,
    String? logoUrl,
    String? description,
    String? subscriptionPlan,
    String? motto,
    String? createdAt,
    String? createdBy,

  }) = _Company;

  const Company._();

  factory Company.fromJson(Map<String, dynamic> json) =>
      _$CompanyFromJson(json);

  factory Company.empty() => const Company(
    id: '',
  );
}
