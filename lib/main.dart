import 'package:flutter/material.dart';
import "package:firebase_core/firebase_core.dart";

import 'auth/auth_login/login_page.dart';
import 'auth/auth_login/login_UI.dart';
import 'auth/auth_login/login_sys.dart';

void main() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    runApp(const MyApp());
}

class MyApp extends StatelessWidget {
    const MyApp({super.key});

    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            title: "BADA",
            theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),
            home: const LoginPage(),
        );
    }
}
