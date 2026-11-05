import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SoporteScreen extends StatelessWidget {
  const SoporteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Listas dinámicas sin corchetes de tipado estricto
    List faqs = [
      {
        'pregunta': '¿Cómo actualizo la información de mi cultivo?',
        'respuesta': 'Dirígete a la sección "Mi Cultivo" en el menú principal y presiona el botón de editar en la esquina superior derecha.'
      },
      {
        'pregunta': '¿Qué hago si no puedo descargar un certificado de retención?',
        'respuesta': 'Verifica tu conexión a internet. Si el archivo no abre, contacta al administrador de la asociación a través del botón de WhatsApp en esta pantalla.'
      },
      {
        'pregunta': '¿Cuándo se actualiza el calendario tributario?',
        'respuesta': 'Las obligaciones y fechas límite son asignadas y actualizadas directamente por el equipo contable de la asociación.'
      }
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F8),
      appBar: AppBar(
        backgroundColor: const Color(0xFF00615C),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('Centro de Soporte', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('¿En qué podemos ayudarte?', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF333333))),
              const SizedBox(height: 10),
              const Text(
                'Encuentra respuestas rápidas o contáctanos directamente para recibir asistencia técnica con tu cuenta de AgroAsoc.', 
                style: TextStyle(fontSize: 14, color: Colors.grey)
              ),
              const SizedBox(height: 30),
              
              const Text('Contacto Directo', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF00615C))),
              const SizedBox(height: 15),
              _construirTarjetaContacto(FontAwesomeIcons.whatsapp, 'WhatsApp', 'Escríbenos para ayuda rápida', Colors.green, context),
              _construirTarjetaContacto(FontAwesomeIcons.envelope, 'Correo Electrónico', 'soporte@agroasoc.com', Colors.blue, context),
              _construirTarjetaContacto(FontAwesomeIcons.phone, 'Línea Telefónica', 'Llamar al administrador', Colors.orange, context),
              
              const SizedBox(height: 30),
              
              const Text('Preguntas Frecuentes', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF00615C))),
              const SizedBox(height: 15),
              ...faqs.map((faq) => _construirFAQ(faq['pregunta'].toString(), faq['respuesta'].toString())),
            ],
          ),
        ),
      ),
    );
  }

  // Se cambia IconData a dynamic para que acepte cualquier tipo de ícono sin errores
  Widget _construirTarjetaContacto(dynamic icono, String titulo, String subtitulo, Color color, BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: const BorderSide(color: Color(0xFFE0E0E0))),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: FaIcon(icono, color: color, size: 24),
        ),
        title: Text(titulo, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Text(subtitulo, style: const TextStyle(color: Colors.grey, fontSize: 13)),
        ),
        trailing: const FaIcon(FontAwesomeIcons.chevronRight, size: 16, color: Colors.grey),
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Abriendo canal de $titulo...'), backgroundColor: const Color(0xFF00615C)),
          );
        },
      ),
    );
  }

  Widget _construirFAQ(String pregunta, String respuesta) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: const BorderSide(color: Color(0xFFE0E0E0))),
      child: ExpansionTile(
        title: Text(pregunta, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xFF333333))),
        iconColor: const Color(0xFF00615C),
        collapsedIconColor: Colors.grey,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
            child: Text(respuesta, style: const TextStyle(color: Colors.grey, fontSize: 13, height: 1.5)),
          )
        ],
      ),
    );
  }
}