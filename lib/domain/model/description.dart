import 'package:freezed_annotation/freezed_annotation.dart';

part 'description.freezed.dart';

part 'description.g.dart';

@freezed
class Description with _$Description {
  factory Description({
    required String description,
    required String costOrExpense,
    required String type,
  }) = _Description;

  factory Description.fromJson(Map<String, Object?> json) =>
      _$DescriptionFromJson(json);
}
