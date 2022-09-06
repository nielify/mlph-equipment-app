import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mlph_equipments/screens/equipment_details/equipment_details.dart';

class EquipmentList extends StatelessWidget {
  const EquipmentList({super.key, required this.equipments});

   final Query equipments;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: equipments.snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
        if (streamSnapshot.hasData) {
          return ListView.builder(
            itemCount: streamSnapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final DocumentSnapshot documentSnapshot = streamSnapshot.data!.docs[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: ListTile(
                  title: Text(documentSnapshot['description']),
                  subtitle: Text('code: ${documentSnapshot['code']}'),
                  onTap: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EquipmentDetails(equipment: documentSnapshot)),
                    )
                  }
                ),
              );
            }
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}