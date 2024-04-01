import 'dart:io';

import 'package:flutter/material.dart';
import 'package:iot_project/photo_preview.dart';
import 'package:path_provider/path_provider.dart';

class Gallery extends StatefulWidget {
  const Gallery({super.key});

  @override
  State<Gallery> createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  Future<List<FileSystemEntity>> _getImages() async {
    Directory? directory = await getExternalStorageDirectory();
    List<FileSystemEntity> files = directory!.listSync();
    return files;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: _getImages(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return SafeArea(
          child: GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 5,
            crossAxisSpacing: 5,
            padding: const EdgeInsets.all(10),
            children: snapshot.data!.map((e) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => PhotoPreview(file: e),
                    ),
                  );
                },
                child: Image.file(
                  e as File,
                  fit: BoxFit.cover,
                ),
              );
            }).toList(),
          ),
        );
      },
    ));
  }
}
