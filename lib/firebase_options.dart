import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) return _web();
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return _android();
      case TargetPlatform.iOS:
        return _ios();
      case TargetPlatform.macOS:
        return _macos();
      case TargetPlatform.windows:
        return _windows();
      case TargetPlatform.linux:
        throw UnsupportedError('No config for Linux.');
      default:
        throw UnsupportedError('Platform not supported.');
    }
  }

  static FirebaseOptions _android() => FirebaseOptions(
    apiKey: dotenv.env['KEY_ANDROID'] ?? '',
    appId: dotenv.env['ID_ANDROID'] ?? '',
    messagingSenderId: dotenv.env['MESSAGINGSENDER_ID'] ?? '',
    projectId: dotenv.env['PROJECT_ID'] ?? '',
    storageBucket: dotenv.env['STORAGE_BUCKET'] ?? '',
  );

  static FirebaseOptions _ios() => FirebaseOptions(
    apiKey: dotenv.env['KEY_IOS'] ?? '',
    appId: dotenv.env['ID_IOS'] ?? '',
    messagingSenderId: dotenv.env['MESSAGINGSENDER_ID'] ?? '',
    projectId: dotenv.env['PROJECT_ID'] ?? '',
    storageBucket: dotenv.env['STORAGE_BUCKET'] ?? '',
    iosBundleId: dotenv.env['IOSBUNDLE_ID'] ?? '',
  );

  static FirebaseOptions _macos() => FirebaseOptions(
    apiKey: dotenv.env['KEY_MACOS'] ?? '',
    appId: dotenv.env['ID_MACOS'] ?? '',
    messagingSenderId: dotenv.env['MESSAGINGSENDER_ID'] ?? '',
    projectId: dotenv.env['PROJECT_ID'] ?? '',
    storageBucket: dotenv.env['STORAGE_BUCKET'] ?? '',
    iosBundleId: dotenv.env['IOSBUNDLE_ID'] ?? '',
  );

  static FirebaseOptions _windows() => FirebaseOptions(
    apiKey: dotenv.env['KEY_WINDOWS'] ?? '',
    appId: dotenv.env['ID_WINDOWS'] ?? '',
    messagingSenderId: dotenv.env['MESSAGINGSENDER_ID'] ?? '',
    projectId: dotenv.env['PROJECT_ID'] ?? '',
    storageBucket: dotenv.env['STORAGE_BUCKET'] ?? '',
    authDomain: dotenv.env['AUTHDOMAIN_WINDOWS'] ?? '',
    measurementId: dotenv.env['MEASUREMENT_ID_WINDOWS'] ?? '',
  );

  static FirebaseOptions _web() => FirebaseOptions(
    apiKey: dotenv.env['KEY_WEB'] ?? '',
    appId: dotenv.env['ID_WEB'] ?? '',
    messagingSenderId: dotenv.env['MESSAGINGSENDER_ID'] ?? '',
    projectId: dotenv.env['PROJECT_ID'] ?? '',
    storageBucket: dotenv.env['STORAGE_BUCKET'] ?? '',
    authDomain: dotenv.env['AUTHDOMAIN_WEB'] ?? '',
    measurementId: dotenv.env['MEASUREMENT_ID_WEB'] ?? '',
  );
}
