import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CalendarioProductorScreen extends StatelessWidget {
  const CalendarioProductorScreen({super.key});

  // Datos simulados (Se alimentarán de lo que asigne el administrador)
  final List<Map<String, dynamic>> agenda = const [
    {'actividad': 'Siembra de Maíz Secundario', 'fecha': '05 Nov - 10 Nov 2026', 'fase': 'Siembra', 'estado': 'Próximo', 'color': Colors.blue},
    {'actividad': 'Abonado General de Cafetales', 'fecha': '15 Nov - 20 Nov 2026', 'fase': 'Mantenimiento', 'estado': 'Programado', 'color': Colors.orange},
    {'actividad': 'Cosecha Principal de Café', 'fecha': '01 Dic - 30 Dic 2026', 'fase': 'Cosecha', 'estado': 'En espera', 'color': Colors.green},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F8),
      appBar: AppBar(
        backgroundColor: const Color(0xFF00615C),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('Mi Agenda Productiva', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(bottom: BorderSide(color: Color(0xFFE0E0E0), width: 1)),
              ),
              child: const Text(
                'Aquí puedes consultar las fechas clave y actividades programadas por la asociación para tu cultivo.',
                style: TextStyle(color: Color(0xFF666666), fontSize: 14),
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(20),
                itemCount: agenda.length,
                itemBuilder: (context, index) {
                  final evento = agenda[index];
                  final colorFase = evento['color'] as Color;

                  return Container(
                    margin: const EdgeInsets.only(bottom: 15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(color: Colors.black.withValues(alpha: 0.03), offset: const Offset(0, 4), blurRadius: 8)
                      ],
                    ),
                    child: IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Línea indicadora de color a la izquierda
                          Container(
                            width: 8,
                            decoration: BoxDecoration(
                              color: colorFase,
                              borderRadius: const BorderRadius.only(topLeft: Radius.circular(12), bottomLeft: Radius.circular(12)),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(evento['fase'], style: TextStyle(color: colorFase, fontWeight: FontWeight.bold, fontSize: 12)),
                                      Text(evento['estado'], style: const TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.w500)),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Text(evento['actividad'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF333333))),
                                  const SizedBox(height: 12),
                                  Row(
                                    children: [
                                      const FaIcon(FontAwesomeIcons.calendarDay, size: 14, color: Colors.grey),
                                      const SizedBox(width: 8),
                                      Text(evento['fecha'], style: const TextStyle(color: Color(0xFF666666), fontSize: 13)),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}