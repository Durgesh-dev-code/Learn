// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA2oj43n2xy7oikNg27maT9mMgi4kyy9CA',
    appId: '1:204470263610:android:37505d11ca7b82758afa03',
    messagingSenderId: '204470263610',
    projectId: 'flutter-chat-app-1601f',
    storageBucket: 'flutter-chat-app-1601f.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCBWlQD9GR7N9oAqAR4TjcqaYqyNi1G0yk',
    appId: '1:204470263610:ios:0cfb7236d8538bb18afa03',
    messagingSenderId: '204470263610',
    projectId: 'flutter-chat-app-1601f',
    storageBucket: 'flutter-chat-app-1601f.firebasestorage.app',
    iosBundleId: 'com.example.chatApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCBWlQD9GR7N9oAqAR4TjcqaYqyNi1G0yk',
    appId: '1:204470263610:ios:0cfb7236d8538bb18afa03',
    messagingSenderId: '204470263610',
    projectId: 'flutter-chat-app-1601f',
    storageBucket: 'flutter-chat-app-1601f.firebasestorage.app',
    iosBundleId: 'com.example.chatApp',
  );
}
