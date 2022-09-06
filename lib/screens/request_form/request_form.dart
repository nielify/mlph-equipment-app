import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mlph_equipments/screens/equipments/equipments.dart';
import 'package:mlph_equipments/widgets/custom_appbar.dart';
import 'package:mlph_equipments/widgets/custom_elevated_button.dart';
import 'package:mlph_equipments/widgets/equipment_title.dart';
import 'package:mlph_equipments/screens/request_form/schedule_picker.dart';
import 'package:mlph_equipments/widgets/custom_textfield.dart';

class RequestForm extends StatefulWidget {
  const RequestForm({super.key, required this.equipment, });

  final DocumentSnapshot equipment;

  @override
  State<RequestForm> createState() => _RequestFormState();
}

class _RequestFormState extends State<RequestForm> {
  final CollectionReference _equipments = FirebaseFirestore.instance.collection('equipments');

  DateTimeRange dateRange = DateTimeRange(
    start: DateTime.now(), 
    end: DateTime(DateTime.now().year + 1, 12, 31)
  );
  String dateRangeString = 'Select Schedule';

  String employeeId = '';
  String employee = '';
  String purpose = '';
  String startDate = '';
  String endDate = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const CustomAppBar(title: 'Request Details'),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            EquipmentTitle(
              description: widget.equipment['description'],
              code: widget.equipment['code'],
              bottomMargin: 20,
            ),
            CustomTextField(
              label: 'Employee ID', 
              onChanged: (value) {setState(() => employeeId = value);}
            ),
            CustomTextField(
              label: 'Employee Name', 
              onChanged: (value) {setState(() => employee = value);}
            ),
            CustomTextField(
              label: 'Purpose', 
              onChanged: (value) {setState(() => purpose = value);}
            ),
            SchedulePicker(pickDateRange: _pickDateRange, dateRange: dateRangeString,),
            CustomElevatedButton(
              label: 'SUBMIT', 
              onPressed: () {
                _sendRequest(employeeId, employee, purpose, startDate, endDate);
              },
            )
          ],
        ),
      ),
    );
  }

  Future _pickDateRange() async {
    DateTimeRange? newDateRange = await showDateRangePicker(
      context: context, 
      firstDate: dateRange.start, 
      lastDate: dateRange.end,
    );

    if (newDateRange == null) return ;

    setState(() {
      dateRangeString = '${newDateRange.start.month}/${newDateRange.start.day}/${newDateRange.start.year} - '
        '${newDateRange.end.month}/${newDateRange.end.day}/${newDateRange.end.year}';
      startDate = '${newDateRange.start.month}/${newDateRange.start.day}/${newDateRange.start.year}';
      endDate = '${newDateRange.end.month}/${newDateRange.end.day}/${newDateRange.end.year}';
    });
  }

  bool _valdateFields(Map<String, dynamic> requestInfo) {
    bool hasNoEmptyField = false;

    for (var key in requestInfo.keys) {
      hasNoEmptyField = requestInfo[key].isNotEmpty;
      if (!hasNoEmptyField) break;
    }

    return hasNoEmptyField;
  }

  void _sendRequest(
    String employeeId, 
    String employee, 
    String purpose, 
    String startDate, 
    String endDate,
  ) async {
    Map<String, dynamic> requestInfo = {
      'employeeId': employeeId,
      'employee': employee,
      'purpose': purpose,
      'startDate': startDate,
      'endDate': endDate,
      'status': "pending",
      'createdAt': DateTime.now().toString(),
    };


    if (_valdateFields(requestInfo)) {
      List requests = [];
      requests.add(requestInfo);

      final snapshot = await _equipments.doc(widget.equipment.id).get();
      if (snapshot.exists) {
        if ((snapshot.data() as Map)['requests'].isEmpty) {
          _equipments.doc(widget.equipment.id).update({
            'requests': FieldValue.arrayUnion(requests),
            'hasRequests': true,
          });
          _navigateToHomeScreen();
        }
        else {
          (snapshot.data() as Map)['requests'].forEach((request) => {
            if (request['employeeId'] != this.employeeId) {
              _equipments.doc(widget.equipment.id).update({
                'requests': FieldValue.arrayUnion(requests),
                'hasRequests': true,
              }),
              _navigateToHomeScreen(),
            } 
            else {
              _showSnackbar('You have already requested for this equipment.'),
            }
          });
        } 
      } 
    } else {
      _showSnackbar('All fields are required.');
    }
  }

  void _showSnackbar(String text) {
    final snackBar = SnackBar(
      content: Text(text),
      action: SnackBarAction(
        label: 'Close',
        onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _navigateToHomeScreen() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (c) => const Equipments()),
      (route) => false
    );
  }
}



