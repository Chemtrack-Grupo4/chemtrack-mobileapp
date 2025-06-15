class Deliveries {
  final int? id; // `id` es opcional para cuando se crea una nueva entrega
  final String destination;
  final String packageDescription;
  final String exitPoint;
  final String route;
  final String stop;
  final String combustibleType;
  final String warnings;

  Deliveries({
    this.id,
    required this.destination,
    required this.packageDescription,
    required this.exitPoint,
    required this.route,
    required this.stop,
    required this.combustibleType,
    required this.warnings,
  });

  // Constructor para crear una instancia desde JSON
  factory Deliveries.fromJson(Map<String, dynamic> json) {
    return Deliveries(
      id: json['id'],
      destination: json['destination'],
      packageDescription: json['packageDescription'],
      exitPoint: json['exitPoint'],
      route: json['route'],
      stop: json['stop'],
      combustibleType: json['combustibleType'],
      warnings: json['warnings'],
    );
  }

  // Método para convertir el objeto a JSON
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "destination": destination,
      "packageDescription": packageDescription,
      "exitPoint": exitPoint,
      "route": route,
      "stop": stop,
      "combustibleType": combustibleType,
      "warnings": warnings,
    };
  }
}
