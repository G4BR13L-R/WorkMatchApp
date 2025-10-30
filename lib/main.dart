import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:work_match_app/core/services/secure_storage_service.dart';
import 'package:work_match_app/ui/screens/auth/account_type.dart';
import 'package:work_match_app/ui/screens/auth/login.dart';
import 'package:work_match_app/ui/screens/avaliar_usuario.dart';
import 'package:work_match_app/ui/screens/contratado/home_contratado.dart';
import 'package:work_match_app/ui/screens/contratado/profile_contratado.dart';
import 'package:work_match_app/ui/screens/contratado/register_contratado.dart';
import 'package:work_match_app/ui/screens/contratado/security_account_contratado.dart';
import 'package:work_match_app/ui/screens/contratante/candidaturas_contratante.dart';
import 'package:work_match_app/ui/screens/contratante/home_contratante.dart';
import 'package:work_match_app/ui/screens/contratante/oferta_contratante.dart';
import 'package:work_match_app/ui/screens/contratante/oferta_finalizada_contratante.dart';
import 'package:work_match_app/ui/screens/contratante/profile_contratante.dart';
import 'package:work_match_app/ui/screens/contratante/register_contratante.dart';
import 'package:work_match_app/ui/screens/contratante/security_account_contratante.dart';
import 'package:work_match_app/ui/screens/contratante/visualizar_candidatura_contratante.dart';
import 'package:work_match_app/ui/screens/contratante/visualizar_oferta_contratante.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  final authData = await SecureStorageService.getAuthData();
  runApp(MyApp(userType: authData['type'] ?? ''));
}

class MyApp extends StatelessWidget {
  final String? userType;

  const MyApp({super.key, this.userType});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Work Match',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.amber, fontFamily: 'Roboto'),
      initialRoute: (userType == null || userType!.isEmpty) ? '/' : '/$userType/home',
      routes: {
        '/': (context) => const LoginScreen(),
        '/account_type': (context) => const AccountType(),
        '/avaliar_usuario': (context) => const AvaliarUsuario(),

        // Contratante
        '/contratante/register': (context) => const RegisterContratante(),
        '/contratante/home': (context) => const HomeContratante(),
        '/contratante/profile': (context) => const ProfileContratante(),
        '/contratante/security_account': (context) => const SecurityAccountContratante(),
        '/contratante/oferta': (context) => const OfertaContratante(),
        '/contratante/oferta_finalizada': (context) => const OfertaFinalizadaContratante(),
        '/contratante/visualizar_oferta': (context) => const VisualizarOfertaContratante(),
        '/contratante/candidaturas': (context) => CandidaturasContratante(),
        '/contratante/visualizar_candidatura': (context) => VisualizarCandidaturaContratante(),

        // Contratado
        '/contratado/register': (context) => const RegisterContratado(),
        '/contratado/home': (context) => const HomeContratado(),
        '/contratado/profile': (context) => const ProfileContratado(),
        '/contratado/security_account': (context) => const SecurityAccountContratado(),
      },
    );
  }
}
