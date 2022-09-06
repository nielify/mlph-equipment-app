import 'package:flutter/material.dart';
import 'package:mlph_equipments/utils/constants.dart';

class EquipmentTitle extends StatelessWidget {
  const EquipmentTitle({
    super.key, 
    required this.description,
    required this.code, 
    this.bottomMargin = 0, 
  });

  final String description;
  final String code;

  final double bottomMargin;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: bottomMargin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            description,
            style: const TextStyle(
              color: kprimaryColor,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'code: $code',
            style: const TextStyle(
              fontSize: 16,
              fontStyle: FontStyle.italic,
              color: kgrey,
            ),
          ),
        ],
      ),
    );
  }
}