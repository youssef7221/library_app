
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
    apiKey: 'AIzaSyC2yw5O7xcqW0tou9dx2xgtKsfrR488N7U',
    appId: '1:790858559343:web:d5ff64d911ed4424ff029a',
    messagingSenderId: '790858559343',
    projectId: 'libraryapp-81f28',
    authDomain: 'libraryapp-81f28.firebaseapp.com',
    storageBucket: 'libraryapp-81f28.appspot.com',
    measurementId: 'G-1QKHF81MGY',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBI7pjz2olcgwI6xNTn4uFxbiLHPYhdwOA',
    appId: '1:790858559343:android:1fa758d87dbdab2fff029a',
    messagingSenderId: '790858559343',
    projectId: 'libraryapp-81f28',
    storageBucket: 'libraryapp-81f28.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC9ee3dQIJq96j7T_QNdKyN20_1s3vw8gg',
    appId: '1:790858559343:ios:8096b4669a178e82ff029a',
    messagingSenderId: '790858559343',
    projectId: 'libraryapp-81f28',
    storageBucket: 'libraryapp-81f28.appspot.com',
    iosBundleId: 'com.example.libraryApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC9ee3dQIJq96j7T_QNdKyN20_1s3vw8gg',
    appId: '1:790858559343:ios:8096b4669a178e82ff029a',
    messagingSenderId: '790858559343',
    projectId: 'libraryapp-81f28',
    storageBucket: 'libraryapp-81f28.appspot.com',
    iosBundleId: 'com.example.libraryApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyC2yw5O7xcqW0tou9dx2xgtKsfrR488N7U',
    appId: '1:790858559343:web:6160115c2f4c1cf7ff029a',
    messagingSenderId: '790858559343',
    projectId: 'libraryapp-81f28',
    authDomain: 'libraryapp-81f28.firebaseapp.com',
    storageBucket: 'libraryapp-81f28.appspot.com',
    measurementId: 'G-SX6WR7LMD2',
  );
}
