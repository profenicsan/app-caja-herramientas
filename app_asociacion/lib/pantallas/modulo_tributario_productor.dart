import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ModuloTributarioProductorScreen extends StatelessWidget {
  const ModuloTributarioProductorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Declaración sin corchetes de tipado (< >) para que el analizador no colapse
    List certificados = [
      {'nombre': 'Certificado_Retencion_2026.pdf', 'emisor': 'AgroAsoc', 'fecha': '10 Feb 2026'},
      {'nombre': 'RUT_Actualizado.pdf', 'emisor': 'DIAN', 'fecha': '15 Ene 2026'},
    ];

    List obligaciones = [
      {'titulo': 'Actualización RUT Anual', 'fecha': '31 Mar 2027', 'estado': 'Próximo'},
      {'titulo': 'Declaración de Renta Persona Natural', 'fecha': '15 Ago 2026', 'estado': 'Pendiente'},
    ];

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color(0xFFF4F6F8),
        appBar: AppBar(
          backgroundColor: const Color(0xFF00615C),
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text('Mis Impuestos y Legal', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
          bottom: const TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            indicatorColor: Colors.orange,
            indicatorWeight: 3,
            tabs: [
              Tab(icon: FaIcon(FontAwesomeIcons.fileInvoice, size: 18), text: 'Certificados'),
              Tab(icon: FaIcon(FontAwesomeIcons.calendarCheck, size: 18), text: 'Vencimientos'),
            ],
          ),
        ),
        body: SafeArea(
          child: TabBarView(
            children: [
              _construirVistaCertificados(context, certificados),
              _construirVistaObligaciones(context, obligaciones),
            ],
          ),
        ),
      ),
    );
  }

  // Parámetro ajustado a una lista simple
  Widget _construirVistaCertificados(BuildContext context, List certificados) {
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: certificados.length,
      itemBuilder: (context, index) {
        final cert = certificados[index];
        return Card(
          elevation: 0,
          margin: const EdgeInsets.only(bottom: 15),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: const BorderSide(color: Color(0xFFE0E0E0))),
          child: ListTile(
            contentPadding: const EdgeInsets.all(15),
            leading: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFD32F2F).withValues(alpha: 0.1), 
                borderRadius: BorderRadius.circular(8)
              ),
              child: const FaIcon(FontAwesomeIcons.filePdf, color: Color(0xFFD32F2F), size: 24),
            ),
            title: Text(cert['nombre'].toString(), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Text('Emitido por: ${cert['emisor']} \nFecha: ${cert['fecha']}', style: const TextStyle(fontSize: 12, color: Colors.grey)),
            ),
            trailing: IconButton(
              icon: const FaIcon(FontAwesomeIcons.cloudArrowDown, color: Color(0xFF00615C)),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Simulación: Descargando ${cert['nombre']}...'), backgroundColor: const Color(0xFF00615C)),
                );
              },
            ),
          ),
        );
      },
    );
  }

  // Parámetro ajustado a una lista simple
  Widget _construirVistaObligaciones(BuildContext context, List obligaciones) {
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: obligaciones.length,
      itemBuilder: (context, index) {
        final oblig = obligaciones[index];
        final bool pendiente = oblig['estado'] == 'Pendiente';
        
        return Card(
          elevation: 0,
          margin: const EdgeInsets.only(bottom: 15),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: const BorderSide(color: Color(0xFFE0E0E0))),
          child: ListTile(
            contentPadding: const EdgeInsets.all(15),
            leading: const FaIcon(FontAwesomeIcons.circleExclamation, color: Colors.orange, size: 24),
            title: Text(oblig['titulo'].toString(), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Text('Vence: ${oblig['fecha']}', style: const TextStyle(fontSize: 13, color: Colors.grey)),
            ),
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: pendiente ? Colors.red.withValues(alpha: 0.1) : Colors.orange.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                oblig['estado'].toString(),
                style: TextStyle(color: pendiente ? Colors.red : Colors.orange, fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        );
      },
    );
  }
}