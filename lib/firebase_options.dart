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
    apiKey: 'AIzaSyAuj3YW7OtV2lotkqxrSVXzfwT-JvHbQ1w',
    appId: '1:311749890155:web:d01972fc6e6430ad92212e',
    messagingSenderId: '311749890155',
    projectId: 'wallzy-3a7fe',
    authDomain: 'wallzy-3a7fe.firebaseapp.com',
    storageBucket: 'wallzy-3a7fe.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBdYg4o8ejWch2SHOetWvRvBugpMf5Pav8',
    appId: '1:311749890155:android:c4ae8fcc953a5d9792212e',
    messagingSenderId: '311749890155',
    projectId: 'wallzy-3a7fe',
    storageBucket: 'wallzy-3a7fe.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDN65QUw_XyfeZKoTo22kezSe7ORIk9yc8',
    appId: '1:311749890155:ios:12a8c66a3e4fe2f492212e',
    messagingSenderId: '311749890155',
    projectId: 'wallzy-3a7fe',
    storageBucket: 'wallzy-3a7fe.appspot.com',
    iosBundleId: 'com.example.wallzy',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDN65QUw_XyfeZKoTo22kezSe7ORIk9yc8',
    appId: '1:311749890155:ios:12a8c66a3e4fe2f492212e',
    messagingSenderId: '311749890155',
    projectId: 'wallzy-3a7fe',
    storageBucket: 'wallzy-3a7fe.appspot.com',
    iosBundleId: 'com.example.wallzy',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAuj3YW7OtV2lotkqxrSVXzfwT-JvHbQ1w',
    appId: '1:311749890155:web:265a3f448350c34592212e',
    messagingSenderId: '311749890155',
    projectId: 'wallzy-3a7fe',
    authDomain: 'wallzy-3a7fe.firebaseapp.com',
    storageBucket: 'wallzy-3a7fe.appspot.com',
  );
}