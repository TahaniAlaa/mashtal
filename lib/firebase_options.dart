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
    apiKey: 'AIzaSyDVuttBcT1QWGoNoFAtWXQMeAHxrESRvQg',
    appId: '1:202121639516:web:098e20a4029a8cfd66d899',
    messagingSenderId: '202121639516',
    projectId: 'ecommer-7f3bb',
    authDomain: 'ecommer-7f3bb.firebaseapp.com',
    storageBucket: 'ecommer-7f3bb.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDkbHUM_BBJCx3ACtGfNdT1yHv_ZsLEXmw',
    appId: '1:202121639516:android:4a9efd79bfcfeeff66d899',
    messagingSenderId: '202121639516',
    projectId: 'ecommer-7f3bb',
    storageBucket: 'ecommer-7f3bb.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBMFJrRiVKsDHDFN4fuvY9WdzJNuDS7eYA',
    appId: '1:202121639516:ios:0335a7a1ef53af3166d899',
    messagingSenderId: '202121639516',
    projectId: 'ecommer-7f3bb',
    storageBucket: 'ecommer-7f3bb.appspot.com',
    iosClientId: '202121639516-t8bbt36e2mishkmeva03fuv3lc414qjk.apps.googleusercontent.com',
    iosBundleId: 'com.example.plantation',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBMFJrRiVKsDHDFN4fuvY9WdzJNuDS7eYA',
    appId: '1:202121639516:ios:0335a7a1ef53af3166d899',
    messagingSenderId: '202121639516',
    projectId: 'ecommer-7f3bb',
    storageBucket: 'ecommer-7f3bb.appspot.com',
    iosClientId: '202121639516-t8bbt36e2mishkmeva03fuv3lc414qjk.apps.googleusercontent.com',
    iosBundleId: 'com.example.plantation',
  );
}
