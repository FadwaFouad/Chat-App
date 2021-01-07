import 'package:Chat/screens/auth_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:Chat/screens/chat_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
        super.initState();

    final fcm = FirebaseMessaging();
    fcm.requestNotificationPermissions();
    fcm.configure(
     
      onLaunch: (message) {
        print(message);
        return;
      },
      onResume: (message) {
        print('resume');
        print(message);

        return;
      },
      onMessage: (message) {
        print('message');
        print(message);

        return;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat',
      theme: ThemeData(
        backgroundColor: Colors.pink,
        primaryColor: Colors.purple,
        accentColor: Colors.pink,
        primarySwatch: Colors.purple,
        accentColorBrightness: Brightness.dark,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        buttonTheme: ButtonTheme.of(context).copyWith(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          buttonColor: Theme.of(context).primaryColor,
          textTheme: ButtonTextTheme.primary,
        ),
      ),
      home: FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(child: CircularProgressIndicator());
          else
            return StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (ctx, userSnapshot) {
                if (userSnapshot.connectionState == ConnectionState.waiting)
                  return Center(child: CircularProgressIndicator());
                else
                  return userSnapshot.hasData ? ChatScreen() : AuthScreen();
              },
            );
        },
      ),
    );
  }
}
