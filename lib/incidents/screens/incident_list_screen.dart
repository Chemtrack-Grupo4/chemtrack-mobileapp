import 'package:fastflow_app/incidents/models/incident.dart';
import 'package:fastflow_app/incidents/screens/add_incident_screen.dart';
import 'package:fastflow_app/incidents/services/incident_service.dart';
import 'package:flutter/material.dart';


class IncidentsListScreen extends StatefulWidget {
  const IncidentsListScreen({super.key});

  @override
  _IncidentsListScreenState createState() => _IncidentsListScreenState();
}

class _IncidentsListScreenState extends State<IncidentsListScreen> {
  final IncidentsService _incidentsService = IncidentsService();
  List<Incident> _incidents = [];
  List<Incident> _searchResults = [];
  bool _isLoading = true;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchIncidents();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _fetchIncidents() async {
    setState(() {
      _isLoading = true;
    });
    try {
      List<Incident> incidents = await _incidentsService.getAllIncidents();
      setState(() {
        _incidents = incidents;
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
      _searchResults = _incidents.where((incident) {
        return incident.incidentPlace.toLowerCase().contains(searchQuery) ||
               incident.description.toLowerCase().contains(searchQuery);
      }).toList();
    });
  }

  Future<void> _navigateToAddIncident() async {
    bool? added = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddIncidentScreen()),
    );

    if (added == true) {
      _fetchIncidents(); // Actualiza la lista después de añadir un incidente
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Incidents', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {},
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Search for incidents...',
                        prefixIcon: const Icon(Icons.search, color: Colors.grey),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 16.0),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: _searchResults.isNotEmpty || _searchController.text.isNotEmpty
                      ? _buildIncidentsList(_searchResults)
                      : _buildIncidentsList(_incidents),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddIncident,
        backgroundColor: Colors.lightGreen,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildIncidentsList(List<Incident> incidents) {
    return ListView.builder(
      itemCount: incidents.length,
      itemBuilder: (context, index) {
        return _buildIncidentCard(incidents[index]);
      },
    );
  }

  Widget _buildIncidentCard(Incident incident) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 28,
              backgroundColor: Colors.red,
              child: Icon(Icons.warning_amber_rounded, color: Colors.white, size: 30),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    incident.incidentPlace,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Description: ${incident.description}",
                    style: const TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Text(
              incident.date,
              style: TextStyle(color: Colors.grey[600], fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
