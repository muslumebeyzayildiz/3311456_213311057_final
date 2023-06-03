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
    apiKey: 'AIzaSyDYJm3JT7zkqLFRZwbjKFvSpWSfueEJNLg',
    appId: '1:537684520386:web:4b03c391b578351e113a5b',
    messagingSenderId: '537684520386',
    projectId: 'domates-firebase-deneme',
    authDomain: 'domates-firebase-deneme.firebaseapp.com',
    storageBucket: 'domates-firebase-deneme.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCMxWgtEosugYImtdkjWdyS4gNgE7EIU9M',
    appId: '1:537684520386:android:7f1adb5a8b5570b6113a5b',
    messagingSenderId: '537684520386',
    projectId: 'domates-firebase-deneme',
    storageBucket: 'domates-firebase-deneme.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDoyMOfyypD6w9cTg7J8wgHPXVigEDpipM',
    appId: '1:537684520386:ios:cb3809d6709f2e65113a5b',
    messagingSenderId: '537684520386',
    projectId: 'domates-firebase-deneme',
    storageBucket: 'domates-firebase-deneme.appspot.com',
    iosClientId: '537684520386-6hbg6uknd0kvcg61g8o2oe7nci9t9l1j.apps.googleusercontent.com',
    iosBundleId: 'com.example.domates',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDoyMOfyypD6w9cTg7J8wgHPXVigEDpipM',
    appId: '1:537684520386:ios:cb3809d6709f2e65113a5b',
    messagingSenderId: '537684520386',
    projectId: 'domates-firebase-deneme',
    storageBucket: 'domates-firebase-deneme.appspot.com',
    iosClientId: '537684520386-6hbg6uknd0kvcg61g8o2oe7nci9t9l1j.apps.googleusercontent.com',
    iosBundleId: 'com.example.domates',
  );
}