// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_sale_request.freezed.dart';

part 'add_sale_request.g.dart';

@freezed
class AddSaleRequest with _$AddSaleRequest {
  const factory AddSaleRequest({
    required String vehicleId,
    required String driverId,
    required double amount,
    String? date,
  }) = _AddSaleRequest;

  const AddSaleRequest._();

  factory AddSaleRequest.fromJson(Map<String, dynamic> json) =>
      _$AddSaleRequestFromJson(json);


}
