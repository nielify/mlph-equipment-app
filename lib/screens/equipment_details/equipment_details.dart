import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mlph_equipments/screens/equipment_details/assigned_employee.dart';
import 'package:mlph_equipments/screens/equipment_details/picture.dart';
import 'package:mlph_equipments/screens/request_form/request_form.dart';
import 'package:mlph_equipments/widgets/custom_appbar.dart';
import 'package:mlph_equipments/widgets/custom_elevated_button.dart';
import 'package:mlph_equipments/widgets/equipment_title.dart';
import 'package:mlph_equipments/utils/constants.dart';

class EquipmentDetails extends StatefulWidget {
  const EquipmentDetails({super.key, required this.equipment});

  final DocumentSnapshot equipment;

  @override
  State<EquipmentDetails> createState() => _EquipmentDetailsState();
}

class _EquipmentDetailsState extends State<EquipmentDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Details'),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Picture(picture: widget.equipment['picture']),
              Container(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    EquipmentTitle(description: widget.equipment['description'], code: widget.equipment['code']),
                    _Specifications(specs: widget.equipment['specs']),
                    _Status(status: widget.equipment['status']),
                    widget.equipment['status'] == 'open' 
                    ? CustomElevatedButton(
                        label: 'REQUEST', 
                        onPressed: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RequestForm(equipment: widget.equipment)
                            ),
                          )
                        }, 
                      )
                    : AssignedEmployee(
                        employee: widget.equipment['assignedEmployee']['employee'], 
                        purpose: widget.equipment['assignedEmployee']['purpose'], 
                        startDate: widget.equipment['assignedEmployee']['startDate'], 
                        endDate: widget.equipment['assignedEmployee']['endDate'],
                      ),
                  ]
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Specifications extends StatelessWidget {
  const _Specifications({required this.specs});

  final List<dynamic> specs;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _Subtitle(subtitle: 'Specifications'),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: specs.length,
            itemBuilder: (_, i) {
              return Text(
                '- ${specs[i]}',
                style: const TextStyle(
                  fontSize: 17
                ),
              );
            }),
        ],
      ),
    );
  }
}

class _Status extends StatelessWidget {
  const _Status({required this.status});

  final String status;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          const _Subtitle(subtitle: 'Status: '),
          _NormalText(text: status),
        ],
      ),
    );
  }
}

class _Subtitle extends StatelessWidget {
  const _Subtitle({required this.subtitle});

  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Text(subtitle,
      style: const TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.bold,
        color: kblackLight,
      ),
    );
  }
}

class _NormalText extends StatelessWidget {
  const _NormalText({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 17,
      ),
    );
  }
}