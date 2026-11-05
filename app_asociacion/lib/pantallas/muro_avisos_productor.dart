import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MuroAvisosProductorScreen extends StatelessWidget {
  const MuroAvisosProductorScreen({super.key});

  // Datos simulados (Estos llegarán desde la base de datos que llena el administrador)
  final List<Map<String, dynamic>> avisos = const [
    {
      'titulo': 'Actualización de Precios del Café',
      'fecha': '26 Oct 2026',
      'prioridad': 'Alta',
      'mensaje': 'Se informa a todos los productores que el precio de carga ha sido actualizado en la cartelera virtual.'
    },
    {
      'titulo': 'Reunión de Asamblea General',
      'fecha': '20 Oct 2026',
      'prioridad': 'Urgente',
      'mensaje': 'Convocatoria obligatoria para la asamblea anual este viernes a las 8:00 AM en la sede principal.'
    },
    {
      'titulo': 'Llegada de Fertilizantes',
      'fecha': '15 Oct 2026',
      'prioridad': 'Normal',
      'mensaje': 'Ya se encuentra disponible el abono orgánico en la bodega. Acercarse en horario de oficina.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F8),
      appBar: AppBar(
        backgroundColor: const Color(0xFF00615C),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('Cartelera de Avisos', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      body: SafeArea(
        child: ListView.builder(
          padding: const EdgeInsets.all(20),
          itemCount: avisos.length,
          itemBuilder: (context, index) {
            final aviso = avisos[index];
            Color badgeColor = aviso['prioridad'] == 'Urgente' ? Colors.red : (aviso['prioridad'] == 'Alta' ? Colors.orange : Colors.green);

            return Card(
              elevation: 2,
              margin: const EdgeInsets.only(bottom: 15),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(color: badgeColor.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(20)),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              FaIcon(FontAwesomeIcons.circleExclamation, size: 10, color: badgeColor),
                              const SizedBox(width: 5),
                              Text(aviso['prioridad'], style: TextStyle(color: badgeColor, fontSize: 12, fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                        Text(aviso['fecha'], style: const TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.w500)),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Text(aviso['titulo'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Color(0xFF333333))),
                    const SizedBox(height: 10),
                    Text(aviso['mensaje'], style: const TextStyle(color: Color(0xFF666666), fontSize: 15, height: 1.4)),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}