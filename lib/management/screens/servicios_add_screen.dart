import 'package:flutter/material.dart';
import 'package:fastflow_app/management/models/servicios.dart';
import 'package:fastflow_app/management/screens/services/servicios_service.dart';

class ServiciosAddScreen extends StatefulWidget {
  const ServiciosAddScreen({super.key});

  @override
  _ServiciosAddScreenState createState() => _ServiciosAddScreenState();
}

class _ServiciosAddScreenState extends State<ServiciosAddScreen> {
  final _formKey = GlobalKey<FormState>();
  final ServiciosService _serviciosService = ServiciosService();

  String nameService = '';
  String description = '';
  String incidents = '';
  final List<String> incidentOptions = ["No one", "Gas Leak", "High Temperature"];
  final TextEditingController _incidentsController = TextEditingController();

  @override
  void dispose() {
    _incidentsController.dispose();
    super.dispose();
  }

  Future<void> _saveService() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      Servicios newService = Servicios(
        nameService: nameService,
        description: description,
        incidents: incidents,
      );

      try {
        await _serviciosService.addService(newService);
        Navigator.pop(context, true); // Regresar y actualizar la lista
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to add service')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Service'),
        backgroundColor: Colors.lightGreen,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildStyledTextField(
                label: 'Service Name',
                onSaved: (value) => nameService = value!,
                validator: (value) => value!.isEmpty ? 'Please enter a service name' : null,
              ),
              const SizedBox(height: 16),
              _buildStyledTextField(
                label: 'Description',
                onSaved: (value) => description = value!,
                validator: (value) => value!.isEmpty ? 'Please enter a description' : null,
              ),
              const SizedBox(height: 16),
              _buildIncidentDropdownField(),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _saveService,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  backgroundColor: Colors.lightGreen,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 5,
                  shadowColor: Colors.black45,
                ),
                child: const Text(
                  'Save',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStyledTextField({
    required String label,
    required FormFieldSetter<String> onSaved,
    required FormFieldValidator<String> validator,
    TextEditingController? controller,
  }) {
    return Container(
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
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        ),
        onSaved: onSaved,
        validator: validator,
      ),
    );
  }

  Widget _buildIncidentDropdownField() {
    return Container(
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
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: DropdownButtonFormField<String>(
        value: null, // Valor inicial
        hint: Text(
          'Incidents',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.grey[600]),
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
        ),
        icon: const Icon(Icons.arrow_drop_down, color: Colors.lightGreen),
        items: incidentOptions.map((String option) {
          return DropdownMenuItem<String>(
            value: option,
            child: Text(option),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            _incidentsController.text = newValue!;
            incidents = newValue;
          });
        },
        validator: (value) => value == null || value.isEmpty ? 'Please select an incident' : null,
      ),
    );
  }
}
