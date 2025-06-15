import 'dart:async';
import 'package:fastflow_app/management/models/servicios.dart';
import 'package:fastflow_app/management/screens/services/servicios_service.dart';
import 'package:fastflow_app/management/screens/servicios_add_screen.dart';
import 'package:fastflow_app/shared/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

class ServiciosListScreen extends StatefulWidget {
  const ServiciosListScreen({super.key});

  @override
  _ServiciosListScreenState createState() => _ServiciosListScreenState();
}

class _ServiciosListScreenState extends State<ServiciosListScreen> {
  final ServiciosService _serviciosService = ServiciosService();
  List<Servicios> _services = [];
  List<Servicios> _searchResults = [];
  bool _isLoading = true;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchServices();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _fetchServices() async {
    try {
      List<Servicios> services = await _serviciosService.getAll();
      setState(() {
        _services = services;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _onSearchChanged() {
    String searchQuery = _searchController.text.toLowerCase();
    setState(() {
      if (searchQuery.isEmpty) {
        _searchResults.clear();
      } else {
        _searchResults = _services.where((service) {
          return service.nameService.toLowerCase().contains(searchQuery);
        }).toList();
      }
    });
  }

  Future<void> _navigateToAddService() async {
    bool? added = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ServiciosAddScreen()),
    );

    if (added == true) {
      _fetchServices(); // Actualiza la lista después de añadir un servicio
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Welcome',
                      style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Colors.lightGreen,
                        borderRadius: BorderRadius.circular(12.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 8,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          const Text(
                            'Find your service',
                            style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: _searchController,
                                  decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    filled: true,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    hintText: 'Search for a service...',
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.search, color: Colors.white),
                                onPressed: _onSearchChanged,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Services On Going',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                    ),
                  ),
                  _searchController.text.isNotEmpty
                      ? _buildSearchResults()
                      : _buildServicesList(),
                ],
              ),
            ),

      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddService,
        backgroundColor: Colors.lightGreen,
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget _buildSearchResults() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _searchResults.length,
      itemBuilder: (context, index) {
        return _buildServiceTile(_searchResults[index]);
      },
    );
  }

  Widget _buildServicesList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _services.length,
      itemBuilder: (context, index) {
        return _buildServiceTile(_services[index]);
      },
    );
  }

  Widget _buildServiceTile(Servicios service) {
    // Definir el color del texto y la imagen según el valor de incidents
    Color textColor;
    String? imagePath;

    if (service.incidents == "No one") {
      textColor = Colors.green;
      imagePath = 'assets/safe.png';
    } else if (service.incidents == "Gas Leak" || service.incidents == "High Temperature") {
      textColor = Colors.red;
      imagePath = 'assets/warn.png';
    } else {
      textColor = Colors.grey; // Color por defecto si no coincide con ninguna condición
      imagePath = null; // No mostrar imagen adicional
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16.0),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              service.nameService,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 4),
            Text(
              service.description.length > 50
                  ? '${service.description.substring(0, 50)}...'
                  : service.description,
              style: const TextStyle(color: Colors.grey, fontSize: 14),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(
                  Icons.warning,
                  color: textColor,
                  size: 16,
                ),
                const SizedBox(width: 4),
                Text(
                  "Incidents: ${service.incidents}",
                  style: TextStyle(color: textColor, fontWeight: FontWeight.w500, fontSize: 14),
                ),
              ],
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipOval(
              child: Image.asset(
                'assets/service_placeholder.png',
                width: 48,
                height: 48,
                fit: BoxFit.cover,
              ),
            ),
            if (imagePath != null) ...[
              const SizedBox(width: 8),
              Image.asset(
                imagePath,
                width: 24,
                height: 24,
                fit: BoxFit.cover,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
