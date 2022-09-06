import 'package:flutter/material.dart';
import 'package:mlph_equipments/utils/constants.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar({Key? key, required this.title}) : preferredSize = const Size.fromHeight(kToolbarHeight), super(key: key);

  final String title;

  @override
  final Size preferredSize; 

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar>{
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        widget.title,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold,),
      ),
      backgroundColor: kprimaryColor,
      elevation: 0,
    );
  }
}