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
    apiKey: 'AIzaSyDwOgMSQ_C2BuE9nPOjaO2gwxYwUJWHPiA',
    appId: '1:619432707652:web:7914bb02c880587bf55e11',
    messagingSenderId: '619432707652',
    projectId: 'flutter-firebase-d4468',
    authDomain: 'flutter-firebase-d4468.firebaseapp.com',
    databaseURL: 'https://flutter-firebase-d4468-default-rtdb.firebaseio.com',
    storageBucket: 'flutter-firebase-d4468.firebasestorage.app',
    measurementId: 'G-5VEZSN9Z1C',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD-ec_zK3uzrDJ_0Mk8-9-bCAz_IgWwraA',
    appId: '1:619432707652:android:57a414b05b6f2f49f55e11',
    messagingSenderId: '619432707652',
    projectId: 'flutter-firebase-d4468',
    databaseURL: 'https://flutter-firebase-d4468-default-rtdb.firebaseio.com',
    storageBucket: 'flutter-firebase-d4468.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyATrPIH42Pzcqcy89h-cj71YOKooqOs3XE',
    appId: '1:619432707652:ios:cbb3785bbdc8ba08f55e11',
    messagingSenderId: '619432707652',
    projectId: 'flutter-firebase-d4468',
    databaseURL: 'https://flutter-firebase-d4468-default-rtdb.firebaseio.com',
    storageBucket: 'flutter-firebase-d4468.firebasestorage.app',
    androidClientId: '619432707652-2qvnnhc964pvd6gsadfusntt0d64vmk6.apps.googleusercontent.com',
    iosClientId: '619432707652-tfdes16l9qf4ninfb57j61sjk0j5nbr7.apps.googleusercontent.com',
    iosBundleId: 'com.example.qmsApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyATrPIH42Pzcqcy89h-cj71YOKooqOs3XE',
    appId: '1:619432707652:ios:cbb3785bbdc8ba08f55e11',
    messagingSenderId: '619432707652',
    projectId: 'flutter-firebase-d4468',
    databaseURL: 'https://flutter-firebase-d4468-default-rtdb.firebaseio.com',
    storageBucket: 'flutter-firebase-d4468.firebasestorage.app',
    androidClientId: '619432707652-2qvnnhc964pvd6gsadfusntt0d64vmk6.apps.googleusercontent.com',
    iosClientId: '619432707652-tfdes16l9qf4ninfb57j61sjk0j5nbr7.apps.googleusercontent.com',
    iosBundleId: 'com.example.qmsApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDwOgMSQ_C2BuE9nPOjaO2gwxYwUJWHPiA',
    appId: '1:619432707652:web:a95304b3c97d1fd5f55e11',
    messagingSenderId: '619432707652',
    projectId: 'flutter-firebase-d4468',
    authDomain: 'flutter-firebase-d4468.firebaseapp.com',
    databaseURL: 'https://flutter-firebase-d4468-default-rtdb.firebaseio.com',
    storageBucket: 'flutter-firebase-d4468.firebasestorage.app',
    measurementId: 'G-G9NSSKCZQ5',
  );
}
