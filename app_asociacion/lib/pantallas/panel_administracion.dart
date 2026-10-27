import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PanelAdministracionScreen extends StatelessWidget {
  const PanelAdministracionScreen({super.key});

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
                
                // OPCIONES DEL MENÚ
                _construirItemMenu(FontAwesomeIcons.building, 'Perfil Asociación', context, '/perfil_asociacion'),
                _construirItemMenu(FontAwesomeIcons.users, 'Productores', context, '/productores'),
                _construirItemMenu(FontAwesomeIcons.tractor, 'Inventario Productivo', context, null),
                _construirItemMenu(FontAwesomeIcons.fileInvoiceDollar, 'Gestión Contable', context, '/transacciones_costos'),
                _construirItemMenu(FontAwesomeIcons.bullhorn, 'Mercadeo', context, null),
                
                const Spacer(),
                
                // OPCIONES INFERIORES
                _construirItemMenu(FontAwesomeIcons.headset, 'Soporte', context, null),
                _construirItemMenu(FontAwesomeIcons.rightFromBracket, 'Salir', context, '/login', esSalida: true),
                const SizedBox(height: 20),
              ],
            ),
          ),

          // ÁREA PRINCIPAL
          Expanded(
            child: Column(
              children: [
                // BARRA SUPERIOR (Íconos)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  alignment: Alignment.centerRight,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const FaIcon(FontAwesomeIcons.envelope, color: Color(0xFF00615C)),
                        onPressed: () {},
                      ),
                      const SizedBox(width: 15),
                      IconButton(
                        icon: const FaIcon(FontAwesomeIcons.bell, color: Color(0xFF00615C)),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                
                // CONTENIDO CENTRAL (Banner y Bienvenida)
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
                              FaIcon(FontAwesomeIcons.image, size: 60, color: Colors.black26),
                              SizedBox(height: 15),
                              Text('Espacio para Banner Institucional', style: TextStyle(color: Colors.black54)),
                            ],
                          ),
                        ),
                        const SizedBox(height: 60),
                        
                        const Text(
                          '¡BIENVENIDO!',
                          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Color(0xFF00615C)),
                        ),
                        const SizedBox(height: 15),
                        const Text(
                          'Selecciona una opción del menú para comenzar a gestionar tu asociación.',
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

  // COMPONENTE: Ítems del menú lateral (Usa dynamic para el ícono)
  Widget _construirItemMenu(dynamic icono, String titulo, BuildContext context, String? ruta, {bool esSalida = false}) {
    return InkWell(
      onTap: () {
        if (ruta != null) {
          if (esSalida) {
            Navigator.pushReplacementNamed(context, ruta);
          } else {
            Navigator.pushNamed(context, ruta);
          }
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