import 'dart:io';

import 'package:flutter/material.dart';

class PhotoPreview extends StatelessWidget {
  final File file;
  const PhotoPreview({super.key, required this.file});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.file(
          file,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
