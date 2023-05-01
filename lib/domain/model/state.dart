class State {
  int? id;
  String? departamento;
  List<String>? ciudades;

  State({this.id, this.departamento, this.ciudades});

  State.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    departamento = json['departamento'];
    ciudades = json['ciudades'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['departamento'] = departamento;
    data['ciudades'] = ciudades;
    return data;
  }
}