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
        return windows;
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
    apiKey: 'AIzaSyCEuHkvDQHQuVoNzlxkKeBFcSUlRePuuz4',
    appId: '1:628743363909:web:bd44703ef2ad4c56f3322c',
    messagingSenderId: '628743363909',
    projectId: 'sih-2024-43192',
    authDomain: 'sih-2024-43192.firebaseapp.com',
    storageBucket: 'sih-2024-43192.appspot.com',
    measurementId: 'G-WX8J01SWZ0',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCsuflCNbV-1QvPpC2nUE0o9pOp8pO-ufw',
    appId: '1:628743363909:android:b7e0626edbbc46d2f3322c',
    messagingSenderId: '628743363909',
    projectId: 'sih-2024-43192',
    storageBucket: 'sih-2024-43192.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCvIIIBd3YVA3Bvz8yRuMoh739W0WJ_kOw',
    appId: '1:628743363909:ios:76916b2c4141b209f3322c',
    messagingSenderId: '628743363909',
    projectId: 'sih-2024-43192',
    storageBucket: 'sih-2024-43192.appspot.com',
    iosBundleId: 'com.example.SIH2024',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCvIIIBd3YVA3Bvz8yRuMoh739W0WJ_kOw',
    appId: '1:628743363909:ios:6aea38e6dbdbe15bf3322c',
    messagingSenderId: '628743363909',
    projectId: 'sih-2024-43192',
    storageBucket: 'sih-2024-43192.appspot.com',
    iosBundleId: 'com.example.loginSignupPagesMaster',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCEuHkvDQHQuVoNzlxkKeBFcSUlRePuuz4',
    appId: '1:628743363909:web:8ce7a8f2c7fdbfdff3322c',
    messagingSenderId: '628743363909',
    projectId: 'sih-2024-43192',
    authDomain: 'sih-2024-43192.firebaseapp.com',
    storageBucket: 'sih-2024-43192.appspot.com',
    measurementId: 'G-3L98C33WWT',
  );
}
