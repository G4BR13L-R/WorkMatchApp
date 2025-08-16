import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:work_match_app/ui/screens/auth/login.dart';
import 'package:work_match_app/ui/screens/auth/account_type.dart';
import 'package:work_match_app/ui/screens/contratante/contratante_register.dart';
import 'package:work_match_app/ui/screens/contratante/home_contratante.dart';
import 'package:work_match_app/ui/screens/contratante/profile_contratante.dart';
import 'package:work_match_app/ui/screens/contratante/change_password_contratante.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Work Match',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.amber, fontFamily: 'Roboto'),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/account_type': (context) => const AccountType(),
        '/contratante/register': (context) => const ContratanteRegister(),
        '/contratante/home': (context) => const HomeContratante(),
        '/contratante/profile': (context) => const ProfileContratante(),
        '/contratante/change_password': (context) => const ChangePasswordContratante(),
      },
    );
  }
}
