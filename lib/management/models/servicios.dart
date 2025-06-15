class Servicios {
  final int? id; // Cambiado a `int?` para permitir que sea nulo cuando se crea un nuevo servicio
  final String nameService;
  final String description;
  final String incidents;

  Servicios({
    this.id,
    required this.nameService,
    required this.description,
    required this.incidents,
  });

  Servicios.fromJson(Map<String, dynamic> map)
      : id = map["id"],
        nameService = map["nameService"],
        description = map["description"],
        incidents = map["incidents"];

  // Método para convertir el objeto a JSON
  Map<String, dynamic> toJson() {
    return {
      "nameService": nameService,
      "description": description,
      "incidents": incidents,
    };
  }
}
