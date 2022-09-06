import 'package:flutter/material.dart';
import 'package:mlph_equipments/utils/constants.dart';

class SchedulePicker extends StatelessWidget {
  const SchedulePicker({
    super.key, 
    required this.pickDateRange, 
    required this.dateRange
  });

  final Function() pickDateRange;
  final String dateRange;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      height: 70,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        margin: const EdgeInsets.symmetric(vertical: 5),
        child: InkWell(
          onTap: () { pickDateRange(); },
          customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          child: ListTile(
            leading: const Icon(Icons.calendar_month),
            title: Text(dateRange,
              style: TextStyle(
                fontSize: 16,
                color: dateRange == 'Select Schedule' ? kgrey : kblack
              ),
            ),
            trailing: const Text('Change',
              style: TextStyle(
                fontSize: 16,
                color: kprimaryColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}