/// {@category Domain}
/// This file contains the definition of a State class representing a state with its properties,
/// including an id, departamento (department), and a list of ciudades (cities). It also includes
/// methods for serializing and deserializing JSON data.

/// This class represents a State with its properties including an id, departamento, and a list of cities.
class State {
  int? id;
  String? departamento;
  List<String>? ciudades;

  /// Constructor for creating a State object.
  State({this.id, this.departamento, this.ciudades});

  /// Factory method to create a State object from a JSON map.
  State.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    departamento = json['departamento'];
    ciudades = json['ciudades'].cast<String>();
  }

  /// Method to convert a State object to a JSON map.
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['departamento'] = departamento;
    data['ciudades'] = ciudades;
    return data;
  }
}