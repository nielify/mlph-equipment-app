import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mlph_equipments/widgets/equipment_list.dart';

class AvailableEquipments extends StatefulWidget {
  const AvailableEquipments({super.key});

  @override
  State<AvailableEquipments> createState() => _AvailableEquipmentsState();
}

class _AvailableEquipmentsState extends State<AvailableEquipments> {
  final Query _availableEquipments =  FirebaseFirestore.instance.collection('equipments').where('status', isEqualTo: 'open');

  @override
  Widget build(BuildContext context) {
    return EquipmentList(equipments: _availableEquipments);
  }
}

