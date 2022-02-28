import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_farm_backstage/core/auth/auth_nav.dart';
import 'package:local_farm_backstage/modules/dashboard/dashboard.dart';
import 'package:local_farm_backstage/modules/login/login_page.dart';

import 'core/auth/auth_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyDCevz7D4YZ9ganUGjplhZI1ZboaLtlDmQ",
        authDomain: "local-farm-ff7b7.firebaseapp.com",
        databaseURL:
            "https://local-farm-ff7b7-default-rtdb.asia-southeast1.firebasedatabase.app",
        projectId: "local-farm-ff7b7",
        storageBucket: "local-farm-ff7b7.appspot.com",
        messagingSenderId: "591234143954",
        appId: "1:591234143954:web:4a06972c3ffada641fbf0b"),
  );

  FirebaseDatabase database = FirebaseDatabase.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  // await FirebaseAuth.instance.setPersistence(Persistence.NONE);

  runApp(
    BlocProvider(
      lazy: false,
      create: (context) => AuthBloc()..add(AddFirebaseAuthListener()),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Local Farm Backstage',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: "NotoSansTC",
      ),
      // home: const AuthNav(),
      home: Dashboard(),
    );
  }
}
