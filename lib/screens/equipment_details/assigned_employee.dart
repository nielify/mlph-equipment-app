import 'package:flutter/material.dart';
import 'package:mlph_equipments/utils/constants.dart';

class AssignedEmployee extends StatelessWidget {
  const AssignedEmployee({
    super.key, 
    required this.employee, 
    required this.purpose, 
    required this.startDate, 
    required this.endDate
  });

  final String employee;
  final String purpose;
  final String startDate;
  final String endDate;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _Title(title:'Assigned Employee:'),
        _TextInfo(label: 'Name', info: employee),
        _TextInfo(label: 'Purpose', info: purpose),
        _TextInfo(label: 'Start Date', info: startDate),
        _TextInfo(label: 'End Date:', info: endDate),
      ],
    );
  }
} 

class _Title extends StatelessWidget {
  const _Title({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(title,
      style: const TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.bold,
        color: kblackLight,
      ),
    );
  }
}

class _TextInfo extends StatelessWidget {
  const _TextInfo({required this.label, required this.info});

  final String label;
  final String info;

  @override
  Widget build(BuildContext context) {
    return Text('$label: $info',
      style: const TextStyle(
        fontSize: 17
      ),
    );
  }
}