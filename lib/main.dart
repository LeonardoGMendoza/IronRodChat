import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'ui/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey: "AIzaSyCLZbkO8d1o3U6KBatSnEIXdM4NtDgj6DE",
        authDomain: "ironrodchat-web.firebaseapp.com",
        projectId: "ironrodchat-web",
        storageBucket: "ironrodchat-web.firebasestorage.app",
        messagingSenderId: "397470848541",
        appId: "1:397470848541:web:a80bda5ab834b9daabd8f4"
    ),
  );

  runApp(IronRodChatApp());
}

class IronRodChatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IronRodChat',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
