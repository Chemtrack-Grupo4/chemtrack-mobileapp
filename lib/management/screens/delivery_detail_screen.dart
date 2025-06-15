import 'package:flutter/material.dart';
import 'package:fastflow_app/management/models/delivery.dart';
import 'package:fastflow_app/management/screens/services/delivery_services.dart';

class DeliveryDetailScreen extends StatefulWidget {
  final int deliveryId;

  const DeliveryDetailScreen({required this.deliveryId, super.key});

  @override
  _DeliveryDetailScreenState createState() => _DeliveryDetailScreenState();
}

class _DeliveryDetailScreenState extends State<DeliveryDetailScreen> {
  final DeliveriesService _deliveriesService = DeliveriesService();
  Deliveries? _delivery;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchDeliveryDetails();
  }

  Future<void> _fetchDeliveryDetails() async {
    try {
      Deliveries delivery = await _deliveriesService.getDeliveryById(widget.deliveryId);
      setState(() {
        _delivery = delivery;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      // Manejo de errores, podrías mostrar un Snackbar o alerta
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Delivery Details'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _delivery == null
              ? const Center(child: Text('No details available'))
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView(
                    children: [
                      Text(
                        _delivery!.destination,
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _delivery!.packageDescription,
                        style: const TextStyle(fontSize: 16, color: Colors.black87),
                      ),
                      const Divider(height: 32, color: Colors.lightGreen),
                      const Text(
                        'Route Details',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text('Exit Point: ${_delivery!.exitPoint}'),
                      Text('Route: ${_delivery!.route}'),
                      Text('Stop: ${_delivery!.stop}'),
                      const Divider(height: 32, color: Colors.lightGreen),
                      const Text(
                        'Combustible Type',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text(_delivery!.combustibleType),
                      const Divider(height: 32, color: Colors.lightGreen),
                      const Text(
                        'Warnings',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _delivery!.warnings,
                        style: TextStyle(
                          color: (_delivery!.warnings.contains('Gas Leak') || _delivery!.warnings.contains('High Temperature'))
                              ? Colors.red
                              : Colors.black,
                        ),
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: () {
                          // Lógica para iniciar la entrega
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.lightGreen,
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                        ),
                        child: const Text('START', style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                ),
    );
  }
}
