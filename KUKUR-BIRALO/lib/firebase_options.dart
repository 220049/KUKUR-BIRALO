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
    apiKey: 'AIzaSyBp8DYrjWqwLwilJTDElpIYE8EF1TRw9rQ',
    appId: '1:295239658146:android:589bc25ce63e429a5a05fb',
    messagingSenderId: '295239658146',
    projectId: 'j-commerce-c06f8',
    storageBucket: 'j-commerce-c06f8.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCDlWiJ89iCoWH9zbp7lW3u0tQJsS6EhgA',
    appId: '1:295239658146:ios:e9a78c543ea0c02b5a05fb',
    messagingSenderId: '295239658146',
    projectId: 'j-commerce-c06f8',
    storageBucket: 'j-commerce-c06f8.appspot.com',
    iosClientId: '295239658146-9lg8kme5svo1sutsafoq5qmo9e3phr9t.apps.googleusercontent.com',
    iosBundleId: 'com.example.nBaz',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCDlWiJ89iCoWH9zbp7lW3u0tQJsS6EhgA',
    appId: '1:295239658146:ios:e9a78c543ea0c02b5a05fb',
    messagingSenderId: '295239658146',
    projectId: 'j-commerce-c06f8',
    storageBucket: 'j-commerce-c06f8.appspot.com',
    iosClientId: '295239658146-9lg8kme5svo1sutsafoq5qmo9e3phr9t.apps.googleusercontent.com',
    iosBundleId: 'com.example.nBaz',
  );
}
