import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:file_picker/file_picker.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ModuloTributarioAdminScreen extends StatefulWidget {
  const ModuloTributarioAdminScreen({super.key});

  @override
  State<ModuloTributarioAdminScreen> createState() => _ModuloTributarioAdminScreenState();
}

class _ModuloTributarioAdminScreenState extends State<ModuloTributarioAdminScreen> {
  // Declaración simplificada y casteo 'as dynamic' para obligar a Dart a aceptar archivos físicos
  List documentos = [
    {'nombre': 'RUT_Asociacion_2026.pdf', 'tipo': 'RUT', 'fecha': '15 Ene 2026', 'peso': '245 KB', 'bytes': null as dynamic},
    {'nombre': 'Camara_Comercio_Actualizada.pdf', 'tipo': 'Legal', 'fecha': '10 Mar 2026', 'peso': '1.2 MB', 'bytes': null as dynamic},
    {'nombre': 'Resolucion_Facturacion_DIAN.pdf', 'tipo': 'DIAN', 'fecha': '05 Abr 2026', 'peso': '500 KB', 'bytes': null as dynamic},
  ];

  List obligaciones = [
    {'titulo': 'Declaración de Renta Persona Jurídica', 'fecha': '12 Abr 2027', 'estado': 'Pendiente', 'prioridad': 'Alta'},
    {'titulo': 'Reporte de Información Exógena', 'fecha': '25 May 2027', 'estado': 'Pendiente', 'prioridad': 'Media'},
    {'titulo': 'Pago Retención en la Fuente', 'fecha': '10 Nov 2026', 'estado': 'Próximo', 'prioridad': 'Alta'},
  ];

  Future<void> _subirDocumento() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
      withData: true, 
    );

    if (result != null) {
      setState(() {
        documentos.insert(0, {
          'nombre': result.files.single.name,
          'tipo': 'Cargado',
          'fecha': 'Hoy',
          'peso': '${(result.files.single.size / 1024).toStringAsFixed(0)} KB',
          'bytes': result.files.single.bytes, 
        });
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Documento agregado exitosamente'), backgroundColor: Color(0xFF00615C)),
        );
      }
    }
  }

  void _abrirDocumento(dynamic doc) {
    if (doc['bytes'] != null) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: Text(doc['nombre'].toString(), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis)),
              IconButton(
                icon: const FaIcon(FontAwesomeIcons.xmark, color: Colors.grey),
                onPressed: () => Navigator.pop(context),
              )
            ],
          ),
          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.6,
            height: MediaQuery.of(context).size.height * 0.8,
            child: SfPdfViewer.memory(doc['bytes'] as Uint8List),
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Este es un documento de prueba y no tiene un PDF real adjunto.'), backgroundColor: Color(0xFFD32F2F)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color(0xFFF4F6F8),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 1,
          iconTheme: const IconThemeData(color: Color(0xFF00615C)),
          title: const Text('Bóveda y Legal DIAN', style: TextStyle(color: Color(0xFF00615C), fontWeight: FontWeight.bold)),
          bottom: const TabBar(
            labelColor: Color(0xFF00615C),
            unselectedLabelColor: Colors.grey,
            indicatorColor: Color(0xFF00615C),
            indicatorWeight: 3,
            tabs: [
              Tab(icon: FaIcon(FontAwesomeIcons.vault, size: 20), text: 'Bóveda Documental'),
              Tab(icon: FaIcon(FontAwesomeIcons.calendarDay, size: 20), text: 'Calendario Tributario'),
            ],
          ),
        ),
        body: SafeArea(
          child: TabBarView(
            children: [
              _construirBovedaLegal(),
              _construirCalendarioDian(),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => Navigator.pushNamed(context, '/asistente_ia'),
          backgroundColor: const Color(0xFF00615C),
          icon: const FaIcon(FontAwesomeIcons.robot, color: Colors.white, size: 20),
          label: const Text('Asistente IA', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }

  Widget _construirBovedaLegal() {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Documentos Institucionales', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF333333))),
              ElevatedButton.icon(
                onPressed: _subirDocumento, 
                icon: const FaIcon(FontAwesomeIcons.cloudArrowUp, size: 14, color: Colors.white),
                label: const Text('Subir Documento (PDF)', style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF00615C)),
              )
            ],
          ),
          const SizedBox(height: 20),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 350,
                childAspectRatio: 2.8,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
              ),
              itemCount: documentos.length,
              itemBuilder: (context, index) {
                final doc = documentos[index];
                return GestureDetector(
                  onTap: () => _abrirDocumento(doc), 
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFE0E0E0)),
                      boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.02), blurRadius: 5, offset: const Offset(0, 2))],
                    ),
                    child: Row(
                      children: [
                        const FaIcon(FontAwesomeIcons.filePdf, size: 40, color: Color(0xFFD32F2F)),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(doc['nombre'].toString(), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13), maxLines: 1, overflow: TextOverflow.ellipsis),
                              const SizedBox(height: 5),
                              Text('${doc['tipo']} • ${doc['peso']}', style: const TextStyle(color: Colors.grey, fontSize: 12)),
                              Text('Actualizado: ${doc['fecha']}', style: const TextStyle(color: Color(0xFF00615C), fontSize: 11, fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const FaIcon(FontAwesomeIcons.trashCan, size: 16, color: Colors.grey),
                          onPressed: () {
                            setState(() => documentos.removeAt(index));
                          },
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
    );
  }

  Widget _construirCalendarioDian() {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Vencimientos y Obligaciones', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF333333))),
              ElevatedButton.icon(
                onPressed: () {},
                icon: const FaIcon(FontAwesomeIcons.plus, size: 14, color: Colors.white),
                label: const Text('Agregar Vencimiento', style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF00615C)),
              )
            ],
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: obligaciones.length,
              itemBuilder: (context, index) {
                final obligacion = obligaciones[index];
                Color badgeColor = obligacion['prioridad'] == 'Alta' ? Colors.red : Colors.orange;
                
                return Card(
                  elevation: 0,
                  margin: const EdgeInsets.only(bottom: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(20),
                    leading: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(color: badgeColor.withValues(alpha: 0.1), shape: BoxShape.circle),
                      child: Center(child: FaIcon(FontAwesomeIcons.buildingColumns, color: badgeColor, size: 20)),
                    ),
                    title: Text(obligacion['titulo'].toString(), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        children: [
                          const FaIcon(FontAwesomeIcons.calendarDay, size: 12, color: Colors.grey),
                          const SizedBox(width: 5),
                          Text('Vence: ${obligacion['fecha']}', style: const TextStyle(color: Colors.grey, fontSize: 13, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    trailing: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(color: const Color(0xFFF9FAFB), borderRadius: BorderRadius.circular(8), border: Border.all(color: const Color(0xFFE0E0E0))),
                      child: Text(obligacion['estado'].toString(), style: const TextStyle(fontSize: 12, color: Color(0xFF333333), fontWeight: FontWeight.bold)),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}