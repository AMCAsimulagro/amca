import 'package:freezed_annotation/freezed_annotation.dart';

part 'crop_types.freezed.dart';

part 'crop_types.g.dart';

@freezed
class CropTypes with _$CropTypes {
  factory CropTypes({
    required List<String> cultivo,
    required String tipo,
    String? id,
  }) = _CropTypes;

  factory CropTypes.fromJson(Map<String, Object?> json) =>
      _$CropTypesFromJson(json);

}
