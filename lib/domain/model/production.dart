import 'package:freezed_annotation/freezed_annotation.dart';

part 'production.freezed.dart';

part 'production.g.dart';

@unfreezed
class Production with _$Production {
  factory Production({
    String? uidOwner,
    String? partName,
    required String transitoryFarmingId,
    required DateTime createDate,
    required String unitOfMeasurement,
    required String quantity,
    required String price,
    String? totalValue,
    String? id,
  }) = _Production;

  factory Production.fromJson(Map<String, Object?> json) =>
      _$ProductionFromJson(json);
}
