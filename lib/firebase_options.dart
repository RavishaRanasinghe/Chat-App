import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'dart:io' show Platform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (Platform.isAndroid) {
      return android;
    }
    throw UnsupportedError(
      'DefaultFirebaseOptions have only been configured for Android in this manual setup.',
    );
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: '',
    appId: '1:517437551080:android:bbdbe9379e83f15537b45d',
    messagingSenderId: '',
    projectId: 'simple-chat-app-8614a',
    storageBucket: 'simple-chat-app-8614a.firebasestorage.app',
  );
}
