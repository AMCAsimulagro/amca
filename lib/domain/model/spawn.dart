import 'package:freezed_annotation/freezed_annotation.dart';
part 'spawn.freezed.dart';

part 'spawn.g.dart';
@freezed
class Spawn with _$Spawn {
  factory Spawn({
    required List<String> tipo,
  }) = _Spawn;

  factory Spawn.fromJson(Map<String, Object?> json) =>
      _$SpawnFromJson(json);
}
