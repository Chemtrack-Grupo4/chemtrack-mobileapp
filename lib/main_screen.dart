import 'package:fastflow_app/incidents/screens/incident_list_screen.dart';
import 'package:fastflow_app/management/screens/servicios_list.dart';
import 'package:flutter/material.dart';

import 'package:fastflow_app/management/screens/deliveries_list_screen.dart';

import 'package:fastflow_app/shared/bottom_navigation_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  // Lista de pantallas que corresponden a cada ítem de la barra de navegación
  final List<Widget> _screens = [
    ServiciosListScreen(),
    DeliveriesListScreen(),
    IncidentsListScreen(),
    //ProfileScreen(), // Puedes crear una pantalla de perfil básica
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
      ),
    );
  }
}
