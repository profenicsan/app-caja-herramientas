import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PanelProductorScreen extends StatelessWidget {
  const PanelProductorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Esto vendrá luego del login conectado a SQL
    const String nombreProductor = "Juan Pérez";

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F8),
      body: SafeArea(
        child: Column(
          children: [
            // ENCABEZADO Y SALUDO
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                border: const Border(bottom: BorderSide(color: Color(0xFFE0E0E0), width: 1)),
                boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.02), offset: const Offset(0, 2), blurRadius: 4)],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: const Color(0xFF00615C).withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                        child: const Center(
                          child: FaIcon(FontAwesomeIcons.user, size: 24, color: Color(0xFF00615C)),
                        ),
                      ),
                      const SizedBox(width: 15),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('¡Hola de nuevo,', style: TextStyle(fontSize: 14, color: Color(0xFF666666))),
                          Text(nombreProductor, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF00615C))),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      // Botón temporal para cerrar sesión y volver al login
                      IconButton(
                        icon: const FaIcon(FontAwesomeIcons.rightFromBracket, size: 20, color: Color(0xFFD32F2F)),
                        onPressed: () => Navigator.pushReplacementNamed(context, '/login'),
                        constraints: const BoxConstraints(),
                        padding: const EdgeInsets.only(right: 15),
                      ),
                      Stack(
                        children: [
                          IconButton(
                            icon: const FaIcon(FontAwesomeIcons.bell, size: 22, color: Color(0xFF00615C)),
                            onPressed: () {},
                            constraints: const BoxConstraints(),
                            padding: EdgeInsets.zero,
                          ),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: Container(
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                color: const Color(0xFFD32F2F),
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.white, width: 2),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // ÁREA DESLIZABLE
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Center(
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 700),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // TARJETA DE ESTADO ACTUAL
                        Container(
                          padding: const EdgeInsets.all(20),
                          margin: const EdgeInsets.only(bottom: 25),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), offset: const Offset(0, 4), blurRadius: 8)],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Row(
                                children: [
                                  FaIcon(FontAwesomeIcons.leaf, size: 20, color: Color(0xFF2E7D32)),
                                  SizedBox(width: 10),
                                  Text('Mi Cultivo Actual', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF333333))),
                                ],
                              ),
                              const SizedBox(height: 10),
                              const Text('Plátano Verde - Finca La Esperanza', style: TextStyle(fontSize: 14, color: Color(0xFF666666))),
                              const SizedBox(height: 15),
                              Container(
                                height: 8,
                                width: double.infinity,
                                decoration: BoxDecoration(color: const Color(0xFFE0E0E0), borderRadius: BorderRadius.circular(4)),
                                child: Row(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width * 0.7 > 700 ? 700 * 0.7 : (MediaQuery.of(context).size.width - 80) * 0.7, // Ajuste para el 70%
                                      decoration: BoxDecoration(color: const Color(0xFF2E7D32), borderRadius: BorderRadius.circular(4)),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Text('Etapa: Mantenimiento (70% hacia cosecha)', style: TextStyle(fontSize: 12, color: Color(0xFF888888), fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),

                        const Text('¿Qué necesitas hacer hoy?', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF333333))),
                        const SizedBox(height: 15),

                        // CUADRÍCULA DE ACCIONES RÁPIDAS
                        Row(
                          children: [
                            Expanded(
                              child: _construirTarjetaAccion(
                                iconoWidget: const FaIcon(FontAwesomeIcons.chartLine, size: 24, color: Color(0xFF2E7D32)),
                                colorFondo: const Color(0xFFE8F5E9),
                                texto: 'Precios de\nMercado',
                                accion: () {},
                              ),
                            ),
                            const SizedBox(width: 15),
                            Expanded(
                              child: _construirTarjetaAccion(
                                iconoWidget: const FaIcon(FontAwesomeIcons.handshakeAngle, size: 24, color: Color(0xFF1565C0)),
                                colorFondo: const Color(0xFFE3F2FD),
                                texto: 'Solicitar\nInsumos',
                                accion: () {},
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Row(
                          children: [
                            Expanded(
                              child: _construirTarjetaAccion(
                                iconoWidget: const FaIcon(FontAwesomeIcons.robot, size: 24, color: Color(0xFFE65100)),
                                colorFondo: const Color(0xFFFFF3E0),
                                texto: 'Asistente\nAgrícola IA',
                                accion: () => Navigator.pushNamed(context, '/asistente_ia'),
                              ),
                            ),
                            const SizedBox(width: 15),
                            Expanded(
                              child: _construirTarjetaAccion(
                                iconoWidget: const FaIcon(FontAwesomeIcons.calendarCheck, size: 24, color: Color(0xFF6A1B9A)),
                                colorFondo: const Color(0xFFF3E5F5),
                                texto: 'Mis\nEntregas',
                                accion: () {},
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 25),

                        // NOTICIA O AVISO DE LA ASOCIACIÓN
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), offset: const Offset(0, 2), blurRadius: 5)],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: IntrinsicHeight(
                              child: Row(
                                children: [
                                  Container(width: 6, color: const Color(0xFFF57C00)),
                                  const Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.all(15),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('Aviso de la Asociación', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFFF57C00))),
                                          SizedBox(height: 5),
                                          Text('Recuerde que el próximo viernes es la jornada de acopio de empaques vacíos en la sede principal.', style: TextStyle(fontSize: 13, color: Color(0xFF666666), height: 1.4)),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // COMPONENTE: Tarjeta de Acción Rápida (Ajustado para recibir el Widget completo)
  Widget _construirTarjetaAccion({required Widget iconoWidget, required Color colorFondo, required String texto, required VoidCallback accion}) {
    return GestureDetector(
      onTap: accion,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.03), offset: const Offset(0, 2), blurRadius: 5)],
        ),
        child: Column(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(color: colorFondo, shape: BoxShape.circle),
              child: Center(child: iconoWidget), // Renderizamos el widget directamente
            ),
            const SizedBox(height: 10),
            Text(texto, textAlign: TextAlign.center, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF333333))),
          ],
        ),
      ),
    );
  }
}