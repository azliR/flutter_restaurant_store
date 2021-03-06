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
        return windows;
      case TargetPlatform.linux:
        return linux;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBC1ogdklGgz86CdT6ylaOW4obelcFt7qc',
    appId: '1:604627191517:web:5dc6648af62d8555307d34',
    messagingSenderId: '604627191517',
    projectId: 'restaurant-70076',
    authDomain: 'restaurant-70076.firebaseapp.com',
    storageBucket: 'restaurant-70076.appspot.com',
    measurementId: 'G-5LZXDZZPVP',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCfIQFNju-sqE_z_Llq9UcmMjpUnBc2U8Y',
    appId: '1:604627191517:android:863392568a658a13307d34',
    messagingSenderId: '604627191517',
    projectId: 'restaurant-70076',
    storageBucket: 'restaurant-70076.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDcSknQPOdEM-PKlhYTJ4aJsUia4PXRMgg',
    appId: '1:604627191517:ios:b307e0a46c733454307d34',
    messagingSenderId: '604627191517',
    projectId: 'restaurant-70076',
    storageBucket: 'restaurant-70076.appspot.com',
    androidClientId: '604627191517-30av0r43v5ivgm1627ocert4fno5711e.apps.googleusercontent.com',
    iosClientId: '604627191517-3opi4t0lcpo04u3i26vh8r76d1ll3us6.apps.googleusercontent.com',
    iosBundleId: 'com.azlir.restaurant.store',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDAPN8WUX40-3ZWhf0QVvcneivvyLiDuS4',
    appId: '1:604627191517:web:69a9ae45975acd59307d34',
    messagingSenderId: '604627191517',
    projectId: 'restaurant-70076',
    authDomain: 'restaurant-70076.firebaseapp.com',
    storageBucket: 'restaurant-70076.appspot.com',
    measurementId: 'G-RBDE2JX58S',
  );

  static const FirebaseOptions linux = FirebaseOptions(
    apiKey: 'AIzaSyDAPN8WUX40-3ZWhf0QVvcneivvyLiDuS4',
    appId: '1:604627191517:web:e7ac369b9322bad8307d34',
    messagingSenderId: '604627191517',
    projectId: 'restaurant-70076',
    authDomain: 'restaurant-70076.firebaseapp.com',
    storageBucket: 'restaurant-70076.appspot.com',
    measurementId: 'G-91KV95FCDY',
  );
}
