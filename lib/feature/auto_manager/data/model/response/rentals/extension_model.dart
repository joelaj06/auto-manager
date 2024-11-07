// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'extension_model.freezed.dart';

part 'extension_model.g.dart';

@freezed
class RentalExtension with _$RentalExtension {
  const factory RentalExtension({
    double? extendedAmount,
    String? extendedDate,
    String? extendedNote,
    String? extendedBy,
  }) = _RentalExtension;

  const RentalExtension._();

  factory RentalExtension.fromJson(Map<String, dynamic> json) =>
      _$RentalExtensionFromJson(json);

  factory RentalExtension.empty() => const RentalExtension(
    extendedAmount: 0,
    extendedDate: '',
    extendedNote: '',
    extendedBy: '',
  );
}
