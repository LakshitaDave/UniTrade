import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DisplayImageScreen extends StatelessWidget {
  final String imagePath;
  const DisplayImageScreen({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            child:imagePath != null
                ? Image.file(File(imagePath))
                : Text('No image captured') ,
          )
        ],
      ),
    );
  }
}
