import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mlph_equipments/widgets/custom_appbar.dart';
import 'package:mlph_equipments/widgets/equipment_title.dart';

class AdminRequestList extends StatelessWidget {
  const AdminRequestList({super.key, required this.equipment});

  final DocumentSnapshot equipment;

  @override
  Widget build(BuildContext context) {
    final CollectionReference equipments = FirebaseFirestore.instance.collection('equipments');

    return Scaffold(
      appBar: const CustomAppBar(title: 'Requests'),
      body: Container(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            EquipmentTitle(description: equipment['description'], code: equipment['code']),
            Expanded(
              child: ListView.builder(
                itemCount: equipment['requests'].length,
                itemBuilder: (_, index) {
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      child: Row(
                        children: [
                          _RequestInfo(
                            employeeId: equipment['requests'][index]['employeeId'],
                            employee: equipment['requests'][index]['employee'],
                            purpose: equipment['requests'][index]['purpose'],
                            startDate: equipment['requests'][index]['startDate'],
                            endDate: equipment['requests'][index]['endDate'],
                          ),
                          TextButton(
                            onPressed: () async {
                              acceptRequest(
                                equipments,
                                equipment['requests'][index]['employeeId'], 
                                equipment['requests'][index]['employee'], 
                                equipment['requests'][index]['purpose'], 
                                equipment['requests'][index]['startDate'],
                                equipment['requests'][index]['endDate']
                              );
                              Navigator.pop(context);
                            }, child: const Text('Accept')
                          )
                        ],
                      ),
                    )
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  void acceptRequest(
    CollectionReference equipments,
    String employeeId,
    String employee,
    String purpose,
    String startDate,
    String endDate,
  ) {
    equipments.doc(equipment.id).update({
      'assignedEmployee': {
        'employeeId': employeeId,
        'employee': employee,
        'purpose': purpose,
        'startDate': startDate,
        'endDate': endDate,
        'assignedAt': DateTime.now(),
      },
      'hasRequests': false,
      'status': 'assigned',
    });
  }
}

class _RequestInfo extends StatelessWidget {
  const _RequestInfo({
    required this.employeeId, 
    required this.employee, 
    required this.purpose, 
    required this.startDate, 
    required this.endDate
  });

  final String employeeId;
  final String employee;
  final String purpose;
  final String startDate;
  final String endDate;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Employeee ID: $employeeId'),
          Text('Name: $employee'),
          Text('Purpose: $purpose'),
          Text('Start Date: $startDate'),
          Text('End Date: $endDate'),
        ],
      ),
    );
  }
}