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
    apiKey: 'AIzaSyCoBGpOy3Hx3GF1EW3hSHd0fgAxIuA35PY',
    appId: '1:977252719187:web:77a158a61ffb9193c544a6',
    messagingSenderId: '977252719187',
    projectId: 'figma-724f6',
    authDomain: 'figma-724f6.firebaseapp.com',
    storageBucket: 'figma-724f6.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCH_KIsY8cgt6YqYI74Y9bjrQfAXE1WcFw',
    appId: '1:977252719187:android:e54a21327cba366ec544a6',
    messagingSenderId: '977252719187',
    projectId: 'figma-724f6',
    storageBucket: 'figma-724f6.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDrg9x5fbJpXCfMIuN1DM8p31_xLCwMtg8',
    appId: '1:977252719187:ios:d377d02f1bfba280c544a6',
    messagingSenderId: '977252719187',
    projectId: 'figma-724f6',
    storageBucket: 'figma-724f6.appspot.com',
    androidClientId: '977252719187-d5q8ksgrh062671s14bb7rmt0aku891b.apps.googleusercontent.com',
    iosClientId: '977252719187-0nckgi8l4lgh1qeiv4p5ngvu2agploe5.apps.googleusercontent.com',
    iosBundleId: 'com.example.figma',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDrg9x5fbJpXCfMIuN1DM8p31_xLCwMtg8',
    appId: '1:977252719187:ios:7e7caf403b86681dc544a6',
    messagingSenderId: '977252719187',
    projectId: 'figma-724f6',
    storageBucket: 'figma-724f6.appspot.com',
    androidClientId: '977252719187-d5q8ksgrh062671s14bb7rmt0aku891b.apps.googleusercontent.com',
    iosClientId: '977252719187-3oksfi391mojfs9ag499u4ofq3j3lole.apps.googleusercontent.com',
    iosBundleId: 'com.example.figma.RunnerTests',
  );
}