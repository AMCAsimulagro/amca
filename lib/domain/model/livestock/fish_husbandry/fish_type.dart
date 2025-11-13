/// {@category Domain}
/// Modelo simple para representar un tipo de pez (especie) usado en piscicultura.
library;

class FishType {
  final String? id;
  final String name;

  FishType({this.id, required this.name});

  factory FishType.fromJson(Map<String, dynamic> json) => FishType(
        id: json['id'] as String?,
        name: (json['name'] ?? '') as String,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };

  FishType copyWith({String? id, String? name}) {
    return FishType(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }
}
