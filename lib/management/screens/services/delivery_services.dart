import 'dart:convert';
import 'dart:io';

import 'package:fastflow_app/management/models/delivery.dart';
import 'package:http/http.dart' as http;

class DeliveriesService {
  final String baseUrl = "https://safe-flow-api.sfo1.zeabur.app/api/safe-flow/v1/deliveries";

  Future<List<Deliveries>> getAllDeliveries() async {
    final http.Response response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == HttpStatus.ok) {
      final List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Deliveries.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load deliveries');
    }
  }

  Future<Deliveries> getDeliveryById(int id) async {
    final http.Response response = await http.get(Uri.parse('$baseUrl/$id'));

    if (response.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(response.body);
      return Deliveries.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to load delivery details');
    }
  }

  Future<void> deleteDelivery(int id) async {
    final http.Response response = await http.delete(Uri.parse('$baseUrl/$id'));

    if (response.statusCode != HttpStatus.noContent) {
      throw Exception('Failed to delete delivery');
    }
  }
}
