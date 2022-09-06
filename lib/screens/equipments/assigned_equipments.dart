import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mlph_equipments/widgets/equipment_list.dart';

class AssignedEquipments extends StatefulWidget {
  const AssignedEquipments({super.key});

  @override
  State<AssignedEquipments> createState() => _AssignedEquipmentsState();
}

class _AssignedEquipmentsState extends State<AssignedEquipments> {
  final Query _assignedEquipments =  FirebaseFirestore.instance.collection('equipments').where('status', isEqualTo: 'assigned');
  
  @override
  Widget build(BuildContext context) {
    return EquipmentList(equipments: _assignedEquipments);
  }
}