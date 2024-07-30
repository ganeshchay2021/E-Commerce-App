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
    apiKey: 'AIzaSyAKSkimo-tuUxH7sFMunl5g4dixcaTeXQg',
    appId: '1:224140023832:web:ca64e7faad5b7f93774b6d',
    messagingSenderId: '224140023832',
    projectId: 'ecommerceapp-806f5',
    authDomain: 'ecommerceapp-806f5.firebaseapp.com',
    storageBucket: 'ecommerceapp-806f5.appspot.com',
    measurementId: 'G-58HTNTDFY5',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDxSga5qezzqiSTRJCg26cejY3Jd82hPLY',
    appId: '1:224140023832:android:96a57b49c24d47cf774b6d',
    messagingSenderId: '224140023832',
    projectId: 'ecommerceapp-806f5',
    storageBucket: 'ecommerceapp-806f5.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCMQjfmtfwaZwk39KHISDAxAQnxXAsroIA',
    appId: '1:224140023832:ios:dfc7721e3b0ddafa774b6d',
    messagingSenderId: '224140023832',
    projectId: 'ecommerceapp-806f5',
    storageBucket: 'ecommerceapp-806f5.appspot.com',
    iosBundleId: 'com.example.myecomapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCMQjfmtfwaZwk39KHISDAxAQnxXAsroIA',
    appId: '1:224140023832:ios:dfc7721e3b0ddafa774b6d',
    messagingSenderId: '224140023832',
    projectId: 'ecommerceapp-806f5',
    storageBucket: 'ecommerceapp-806f5.appspot.com',
    iosBundleId: 'com.example.myecomapp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAKSkimo-tuUxH7sFMunl5g4dixcaTeXQg',
    appId: '1:224140023832:web:b4c53ded0d5b29f7774b6d',
    messagingSenderId: '224140023832',
    projectId: 'ecommerceapp-806f5',
    authDomain: 'ecommerceapp-806f5.firebaseapp.com',
    storageBucket: 'ecommerceapp-806f5.appspot.com',
    measurementId: 'G-QS70N6GXPR',
  );
}
