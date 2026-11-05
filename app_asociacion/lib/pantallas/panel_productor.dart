import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PanelProductorScreen extends StatelessWidget {
  const PanelProductorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F8),
      body: Row(
        children: [
          // BARRA LATERAL IZQUIERDA
          Container(
            width: 250,
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30),
                const Center(
                  child: Text(
                    'AgroAsoc',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF00615C)),
                  ),
                ),
                const SizedBox(height: 40),
                
                // OPCIONES PRINCIPALES DEL MENÚ
                _construirItemMenu(FontAwesomeIcons.user, 'Mi Perfil', context, null),
                _construirItemMenu(FontAwesomeIcons.seedling, 'Mi Cultivo', context, null),
                _construirItemMenu(FontAwesomeIcons.calendarDay, 'Calendario', context, '/calendario_productor'),
                _construirItemMenu(FontAwesomeIcons.bell, 'Avisos y Noticias', context, '/muro_avisos_productor'),
                _construirItemMenu(FontAwesomeIcons.fileInvoice, 'Mis Impuestos y Legal', context, '/modulo_tributario_productor'),
                
                // EMPUJA LAS OPCIONES INFERIORES HACIA ABAJO
                const Spacer(),
                
                // OPCIONES INFERIORES (Soporte único y Salir)
                _construirItemMenu(FontAwesomeIcons.headset, 'Soporte', context, '/soporte'),
                _construirItemMenu(FontAwesomeIcons.rightFromBracket, 'Salir', context, '/login', esSalida: true),
                const SizedBox(height: 20),
              ],
            ),
          ),

          // ÁREA PRINCIPAL DERECHA
          Expanded(
            child: Column(
              children: [
                // BARRA SUPERIOR
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  alignment: Alignment.centerRight,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const FaIcon(FontAwesomeIcons.bell, color: Color(0xFF00615C)),
                        onPressed: () => Navigator.pushNamed(context, '/muro_avisos_productor'), 
                      ),
                      const SizedBox(width: 15),
                      const CircleAvatar(
                        backgroundColor: Color(0xFF00615C),
                        child: FaIcon(FontAwesomeIcons.user, color: Colors.white, size: 16),
                      )
                    ],
                  ),
                ),
                
                // CONTENIDO CENTRAL (BIENVENIDA)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 300,
                          decoration: BoxDecoration(
                            color: const Color(0xFFE0E0E0),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FaIcon(FontAwesomeIcons.tractor, size: 60, color: Colors.black26),
                              SizedBox(height: 15),
                              Text('Panel del Productor', style: TextStyle(color: Colors.black54)),
                            ],
                          ),
                        ),
                        const SizedBox(height: 60),
                        
                        const Text(
                          '¡BIENVENIDO PRODUCTOR!',
                          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Color(0xFF00615C)),
                        ),
                        const SizedBox(height: 15),
                        const Text(
                          'Selecciona una opción del menú para ver tu información.',
                          style: TextStyle(fontSize: 16, color: Color(0xFF666666)),
                        ),
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // MÉTODO CONSTRUCTOR DE BOTONES DEL MENÚ
  Widget _construirItemMenu(dynamic icono, String titulo, BuildContext context, String? ruta, {bool esSalida = false}) {
    return InkWell(
      onTap: () {
        if (ruta != null) {
          if (esSalida) {
            Navigator.pushReplacementNamed(context, ruta);
          } else {
            Navigator.pushNamed(context, ruta);
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Módulo en desarrollo'),
              backgroundColor: Color(0xFF00615C),
              duration: Duration(seconds: 1),
            ),
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        child: Row(
          children: [
            FaIcon(icono, size: 20, color: esSalida ? const Color(0xFFD32F2F) : const Color(0xFF00615C)),
            const SizedBox(width: 20),
            Text(
              titulo,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: esSalida ? const Color(0xFFD32F2F) : const Color(0xFF333333),
              ),
            ),
          ],
        ),
      ),
    );
  }
}