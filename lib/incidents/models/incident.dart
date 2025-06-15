class Incident {
  final int? id; // `id` es opcional para permitir nuevos incidentes
  final String incidentPlace;
  final String date;
  final String description;

  Incident({
    this.id,
    required this.incidentPlace,
    required this.date,
    required this.description,
  });

  // Constructor para crear una instancia desde JSON
  factory Incident.fromJson(Map<String, dynamic> json) {
    return Incident(
      id: json['id'],
      incidentPlace: json['incidentPlace'],
      date: json['date'],
      description: json['description'],
    );
  }

  // Método para convertir el objeto a JSON
  Map<String, dynamic> toJson() {
    return {
      "incidentPlace": incidentPlace,
      "date": date,
      "description": description,
    };
  }
}
