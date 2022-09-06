import 'package:flutter/material.dart';

class Picture extends StatelessWidget {
  const Picture({super.key, required this.picture});

  final String picture;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      picture,
      loadingBuilder: (_, child, progress) {
        return progress == null 
          ? child
          : const Padding(
              padding:  EdgeInsets.symmetric(vertical: 107),
              child:  CircularProgressIndicator(),
            );
      },
      width: MediaQuery.of(context).size.width,
      height: 250,
      fit: BoxFit.cover,
    );
  }
}