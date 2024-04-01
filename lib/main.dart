import 'dart:io';

import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:iot_project/gallery.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final cameras = await availableCameras();
  final firstCamera = cameras.first;
  runApp(MyApp(
    camera: firstCamera,
  ));
}

class MyApp extends StatelessWidget {
  final CameraDescription camera;
  const MyApp({super.key, required this.camera});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(camera: camera),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final CameraDescription camera;
  const MyHomePage({super.key, required this.camera});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.medium,
    );

    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    FirebaseDatabase database = FirebaseDatabase.instance;
    DatabaseReference ref = database.ref('sensor_data/');
    bool flag = false;

    Future<void> storeImage() async {
      //update the flag
      await database.ref().update({
        'sensor_data': {'data': false}
      });

      // take the picture
      XFile image = await _controller.takePicture();

      // get external storage path and save image there
      Directory? externalStorageDirectory = await getExternalStorageDirectory();
      String imagePath = path.join(
        externalStorageDirectory!.path,
        path.basename(image.path),
      );
      await image.saveTo(imagePath);

      // show snackbar
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('image was saved at location $imagePath'),
          ),
        );
      }
    }

    return Scaffold(
      body: StreamBuilder<DatabaseEvent>(
          stream: ref.onValue,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final data = snapshot.data?.snapshot.value as Map?;
              flag = data!['data'] as bool;
              debugPrint(flag.toString());
              return FutureBuilder<void>(
                future: _initializeControllerFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (flag) {
                      storeImage();
                    }
                    return Column(
                      children: [
                        CameraPreview(_controller),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).primaryColor,
                              textStyle: const TextStyle(color: Colors.white)),
                          child: const Text("gallery"),
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const Gallery(),
                              ),
                            );
                          },
                        )
                      ],
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              );
            }
            if (snapshot.hasError) {
              debugPrint(snapshot.error.toString());
              return Text(snapshot.error.toString());
            }

            return const Text('...');
          }),
    );
  }
}
