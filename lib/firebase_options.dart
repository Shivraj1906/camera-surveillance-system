// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCuKMPXE4vMK74m8DXbvF4vZIQmroFWOpc',
    appId: '1:865485596816:web:3c3e169f1a56e2464f9015',
    messagingSenderId: '865485596816',
    projectId: 'iot-project-1cd7a',
    authDomain: 'iot-project-1cd7a.firebaseapp.com',
    storageBucket: 'iot-project-1cd7a.appspot.com',
    measurementId: 'G-F4DQJZGMKT',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAjPclR3KauYcFngBdPBKzzfyGuXq1YXEs',
    appId: '1:865485596816:android:dc1ac12c1f24d6234f9015',
    messagingSenderId: '865485596816',
    projectId: 'iot-project-1cd7a',
    storageBucket: 'iot-project-1cd7a.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBCpQv3cSR5wZFzArCCFmP6oj9Zm1v-ieU',
    appId: '1:865485596816:ios:41a694959d15d5a24f9015',
    messagingSenderId: '865485596816',
    projectId: 'iot-project-1cd7a',
    storageBucket: 'iot-project-1cd7a.appspot.com',
    iosBundleId: 'com.example.iotProject',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBCpQv3cSR5wZFzArCCFmP6oj9Zm1v-ieU',
    appId: '1:865485596816:ios:ecefa34c345633214f9015',
    messagingSenderId: '865485596816',
    projectId: 'iot-project-1cd7a',
    storageBucket: 'iot-project-1cd7a.appspot.com',
    iosBundleId: 'com.example.iotProject.RunnerTests',
  );
}
