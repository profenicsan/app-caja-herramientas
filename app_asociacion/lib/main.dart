import 'package:flutter/material.dart';

// Importación de todas las pantallas migradas
import 'pantallas/login.dart';
import 'pantallas/panel_administracion.dart';
import 'pantallas/panel_productor.dart';
import 'pantallas/lista_productores.dart';
import 'pantallas/asistente_ia.dart';
import 'pantallas/modulo_tributario.dart';
import 'pantallas/transacciones_costos.dart';
import 'pantallas/perfil_asociacion.dart';

void main() {
  runApp(const AgroAsocApp());
}

class AgroAsocApp extends StatelessWidget {
  const AgroAsocApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AgroAsoc Plataforma',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF4F6F8),
        primaryColor: const Color(0xFF00615C),
        fontFamily: 'Roboto',
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/panel_administracion': (context) => const PanelAdministracionScreen(),
        '/panel_productor': (context) => const PanelProductorScreen(),
        '/productores': (context) => const ListaProductoresScreen(),
        '/asistente_ia': (context) => const AsistenteIAScreen(),
        '/modulo_tributario': (context) => const ModuloTributarioScreen(),
        '/transacciones_costos': (context) => const TransaccionesCostosScreen(),
        '/perfil_asociacion': (context) => const PerfilAsociacionScreen(),
      },
    );
  }
}