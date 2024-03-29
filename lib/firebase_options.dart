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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyDmMarJ1a89dzREfz3gVAyUA-kXVHvyPRI',
    appId: '1:954358220128:web:2eab08397ace4e48d3ca05',
    messagingSenderId: '954358220128',
    projectId: 'application-tracker-1d9a0',
    authDomain: 'application-tracker-1d9a0.firebaseapp.com',
    storageBucket: 'application-tracker-1d9a0.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBrM39aYOb_QhoW00Y-sTXHh3jmk0kotfc',
    appId: '1:954358220128:android:93a1ae721fbfdf1cd3ca05',
    messagingSenderId: '954358220128',
    projectId: 'application-tracker-1d9a0',
    storageBucket: 'application-tracker-1d9a0.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC8Y3JPSdJfFcqt-bTLad7d5eY0wBbnWHk',
    appId: '1:954358220128:ios:b8011b4d6d39c9b9d3ca05',
    messagingSenderId: '954358220128',
    projectId: 'application-tracker-1d9a0',
    storageBucket: 'application-tracker-1d9a0.appspot.com',
    iosBundleId: 'com.example.applicationsTracker',
  );
}
