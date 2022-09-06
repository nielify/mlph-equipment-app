import 'package:flutter/material.dart';
import 'package:mlph_equipments/screens/equipments/assigned_equipments.dart';
import 'package:mlph_equipments/screens/equipments/available_equipments.dart';
import 'package:mlph_equipments/widgets/custom_appbar.dart';
import 'package:mlph_equipments/utils/constants.dart';

class Equipments extends StatefulWidget {
  const Equipments({super.key});

  @override
  State<Equipments> createState() => _Equipments();
}

class _Equipments extends State<Equipments> {

  int _selectedIndex = 0;

  final List<Widget> _equipmentLists = [
    const AvailableEquipments(),
    const AssignedEquipments(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Equipments'),
      body: _equipmentLists.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Open',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Assigned',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: kprimaryColor,
      ),
    );
  }
}
