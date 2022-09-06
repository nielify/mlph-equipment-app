import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mlph_equipments/screens/admin_request_list.dart';
import 'package:mlph_equipments/widgets/custom_appbar.dart';

class AdminEquipmentList extends StatelessWidget {
  const AdminEquipmentList({super.key});

  @override
  Widget build(BuildContext context) {
    final Query equipments =  
      FirebaseFirestore.instance.collection('equipments').where('hasRequests', isEqualTo: true);

    return Scaffold(
      appBar: const CustomAppBar(title: 'Requested Equipments'),
      body: StreamBuilder(
        stream: equipments.snapshots(),
        builder: (_, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
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
                        MaterialPageRoute(builder: (_) => AdminRequestList(equipment: documentSnapshot)),
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
      )
    );
  }
}

