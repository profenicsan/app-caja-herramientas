import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:math' as math;

// 1. COMPONENTE: Hoja Flotante (Animación)
class HojaFlotante extends StatefulWidget {
  final double size;
  final int delay;
  final double startX;
  final int duration;

  const HojaFlotante({
    super.key,
    required this.size,
    required this.delay,
    required this.startX,
    required this.duration,
  });

  @override
  State<HojaFlotante> createState() => _HojaFlotanteState();
}

class _HojaFlotanteState extends State<HojaFlotante> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.duration),
    );

    Future.delayed(Duration(milliseconds: widget.delay), () {
      if (mounted) _controller.repeat();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final yPos = screenHeight - (_controller.value * (screenHeight + widget.size));
        final rotation = _controller.value * 2 * math.pi;

        return Positioned(
          left: widget.startX,
          top: yPos,
          child: Transform.rotate(
            angle: rotation,
            child: Opacity(
              opacity: 0.06,
              child: FaIcon(
                FontAwesomeIcons.leaf,
                size: widget.size,
                color: const Color(0xFF00615C),
              ),
            ),
          ),
        );
      },
    );
  }
}

// 2. PANTALLA PRINCIPAL: Login
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController cedulaController = TextEditingController();
  final TextEditingController pinController = TextEditingController();

  // FUNCIÓN DE LOGIN CORREGIDA Y CONECTADA AL MAIN.DART
  void manejarLogin() {
    final cedula = cedulaController.text.trim().toLowerCase();
    final pin = pinController.text.trim();

    if (cedula == 'admin' && pin == '1234') {
      Navigator.pushReplacementNamed(context, '/panel_administracion');
    } else if (cedula == 'productor' && pin == '1234') {
      Navigator.pushReplacementNamed(context, '/panel_productor');
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error', style: TextStyle(color: Color(0xFF00615C), fontWeight: FontWeight.bold)),
          content: const Text('Credenciales incorrectas. Intenta con admin/1234 o productor/1234'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK', style: TextStyle(color: Color(0xFF00615C))),
            ),
          ],
        ),
      );
    }
  }

  @override
  void dispose() {
    cedulaController.dispose();
    pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F8),
      body: Stack(
        children: [
          HojaFlotante(size: 45, delay: 0, startX: screenWidth * 0.1, duration: 15000),
          HojaFlotante(size: 25, delay: 2000, startX: screenWidth * 0.4, duration: 12000),
          HojaFlotante(size: 55, delay: 5000, startX: screenWidth * 0.7, duration: 18000),
          HojaFlotante(size: 30, delay: 8000, startX: screenWidth * 0.2, duration: 14000),
          HojaFlotante(size: 40, delay: 1000, startX: screenWidth * 0.8, duration: 16000),

          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Container(
                width: double.infinity,
                constraints: const BoxConstraints(maxWidth: 400),
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withValues(alpha: 0.1), offset: const Offset(0, 4), blurRadius: 10),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Center(
                      child: FaIcon(FontAwesomeIcons.seedling, size: 40, color: Color(0xFF00615C)),
                    ),
                    const SizedBox(height: 10),

                    const Text('AgroAsoc', textAlign: TextAlign.center, style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF00615C))),
                    const SizedBox(height: 5),
                    const Text('Plataforma de Gestión Agropecuaria', textAlign: TextAlign.center, style: TextStyle(fontSize: 14, color: Color(0xFF666666))),
                    const SizedBox(height: 30),

                    const Text('Usuario *', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF333333))),
                    const SizedBox(height: 5),
                    TextField(
                      controller: cedulaController,
                      decoration: InputDecoration(
                        hintText: 'Ingrese su cédula',
                        hintStyle: const TextStyle(color: Colors.grey),
                        filled: true,
                        fillColor: const Color(0xFFFAFAFA),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color(0xFFE0E0E0))),
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color(0xFF00615C))),
                      ),
                    ),
                    const SizedBox(height: 20),

                    const Text('Contraseña *', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF333333))),
                    const SizedBox(height: 5),
                    TextField(
                      controller: pinController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Ingrese su PIN',
                        hintStyle: const TextStyle(color: Colors.grey),
                        filled: true,
                        fillColor: const Color(0xFFFAFAFA),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color(0xFFE0E0E0))),
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color(0xFF00615C))),
                      ),
                    ),
                    const SizedBox(height: 30),

                    ElevatedButton(
                      onPressed: manejarLogin,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF00615C),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      child: const Text('Iniciar Sesión', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                    ),
                    const SizedBox(height: 25),

                    const Text('© 2026 Universidad Tecnológica de Pereira', textAlign: TextAlign.center, style: TextStyle(fontSize: 10, color: Color(0xFFAAAAAA))),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}