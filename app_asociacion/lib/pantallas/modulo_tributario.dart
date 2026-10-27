import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:file_picker/file_picker.dart';

class ModuloTributarioScreen extends StatefulWidget {
  const ModuloTributarioScreen({super.key});

  @override
  State<ModuloTributarioScreen> createState() => _ModuloTributarioScreenState();
}

class _ModuloTributarioScreenState extends State<ModuloTributarioScreen> {
  bool estaCargando = true;

  List<Map<String, dynamic>> documentos = [
    {'id': '1', 'nombre': 'RUT_Actualizado_2026.pdf', 'fechaCarga': '02/09/2026', 'bytes': null},
    {'id': '2', 'nombre': 'Certificado_Representacion.pdf', 'fechaCarga': '15/08/2026', 'bytes': null},
    {'id': '3', 'nombre': 'Resolucion_Facturacion.pdf', 'fechaCarga': '10/01/2026', 'bytes': null}
  ];

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) setState(() => estaCargando = false);
    });
  }

  Future<void> manejarSubida() async {
    try {
      FilePickerResult? resultado = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
        withData: true, 
      );

      if (resultado != null) {
        final archivo = resultado.files.first;
        final ahora = DateTime.now();
        final fechaHoy = "${ahora.day.toString().padLeft(2, '0')}/${ahora.month.toString().padLeft(2, '0')}/${ahora.year}";

        setState(() {
          documentos.insert(0, {
            'id': DateTime.now().millisecondsSinceEpoch.toString(),
            'nombre': archivo.name,
            'fechaCarga': fechaHoy,
            'bytes': archivo.bytes,
          });
        });
      }
    } catch (error) {
      debugPrint("Error al seleccionar documento: $error");
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Hubo un problema al intentar abrir los archivos.'), backgroundColor: Colors.red),
      );
    }
  }

  void abrirDocumento(Map<String, dynamic> doc) {
    showDialog(
      context: context,
      useSafeArea: false,
      builder: (context) {
        return Scaffold(
          backgroundColor: const Color(0xFFF4F6F8),
          body: SafeArea(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    border: Border(bottom: BorderSide(color: Color(0xFFE0E0E0), width: 1)),
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const FaIcon(FontAwesomeIcons.xmark, color: Color(0xFF333333), size: 24),
                        onPressed: () => Navigator.pop(context),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Text(
                          doc['nombre'] ?? 'Documento',
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF00615C)),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    color: const Color(0xFFF4F6F8),
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const FaIcon(FontAwesomeIcons.filePdf, size: 80, color: Color(0xFFB0BEC5)),
                        const SizedBox(height: 20),
                        const Text('Documento de Prueba', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF333333))),
                        const SizedBox(height: 10),
                        const Text(
                          'Este es un documento predeterminado. La previsualización nativa de PDFs requerirá un visor especializado en la versión final.',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16, color: Color(0xFF666666), height: 1.5),
                        ),
                        const SizedBox(height: 30),
                        if (doc['bytes'] != null)
                          const Text(
                            '¡El archivo fue cargado exitosamente en memoria!',
                            style: TextStyle(color: Color(0xFF00615C), fontWeight: FontWeight.bold),
                          )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (estaCargando) {
      return const Scaffold(
        backgroundColor: Color(0xFFF4F6F8),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(color: Color(0xFF00615C)),
              SizedBox(height: 16),
              Text('Conectando con la Bóveda...', style: TextStyle(color: Color(0xFF00615C), fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F8),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), offset: const Offset(0, 2), blurRadius: 3)],
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: const FaIcon(FontAwesomeIcons.arrowLeft, color: Color(0xFF00615C), size: 20),
                    onPressed: () {
                      if (Navigator.canPop(context)) Navigator.pop(context);
                    },
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                  const Expanded(
                    child: Text(
                      'Gestión DIAN y Bóveda',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF00615C)),
                    ),
                  ),
                  const SizedBox(width: 20), 
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Center(
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 700),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 10, bottom: 15),
                          child: Text('Próximos Vencimientos', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF333333))),
                        ),
                        
                        _construirTarjetaAlerta('Renovación Cámara de Comercio', '31 de Marzo, 2027', 'advertencia', FontAwesomeIcons.building),
                        _construirTarjetaAlerta('Declaración IVA Bimestral', '15 de Septiembre, 2026', 'urgente', FontAwesomeIcons.triangleExclamation),

                        Padding(
                          padding: const EdgeInsets.only(top: 20, bottom: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Bóveda Digital', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF333333))),
                              GestureDetector(
                                onTap: () => Navigator.pushNamed(context, '/asistente_ia'),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                                  decoration: BoxDecoration(color: const Color(0xFF00615C), borderRadius: BorderRadius.circular(8)),
                                  child: const Row(
                                    children: [
                                      FaIcon(FontAwesomeIcons.robot, size: 16, color: Colors.white),
                                      SizedBox(width: 8),
                                      Text('Analizar con IA', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        GestureDetector(
                          onTap: manejarSubida,
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 15),
                            padding: const EdgeInsets.all(25),
                            decoration: BoxDecoration(
                              color: const Color(0xFF00615C).withValues(alpha: 0.05),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: const Color(0xFF00615C), width: 2),
                            ),
                            child: const Center(
                              child: Column(
                                children: [
                                  FaIcon(FontAwesomeIcons.cloudArrowUp, size: 32, color: Color(0xFF00615C)),
                                  SizedBox(height: 10),
                                  Text('Subir nuevo documento', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF00615C))),
                                  SizedBox(height: 5),
                                  Text('Toca aquí para seleccionar un archivo PDF o JPG', style: TextStyle(fontSize: 12, color: Color(0xFF666666))),
                                ],
                              ),
                            ),
                          ),
                        ),

                        Container(
                          padding: const EdgeInsets.all(20),
                          margin: const EdgeInsets.only(bottom: 40),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), offset: const Offset(0, 4), blurRadius: 10)],
                          ),
                          child: Column(
                            children: documentos.asMap().entries.map((entrada) {
                              final index = entrada.key;
                              final doc = entrada.value;
                              return Column(
                                children: [
                                  _construirItemDocumento(doc),
                                  if (index < documentos.length - 1)
                                    const Padding(
                                      padding: EdgeInsets.symmetric(vertical: 5),
                                      child: Divider(color: Color(0xFFE0E0E0), height: 1),
                                    ),
                                ],
                              );
                            }).toList(),
                          ),
                        ),
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

  // Se usa 'dynamic' para evitar el conflicto entre FaIconData e IconData nativo
  Widget _construirTarjetaAlerta(String titulo, String fecha, String estado, dynamic icono) {
    final colorEstado = estado == 'urgente' ? const Color(0xFFD32F2F) : const Color(0xFFF57C00);
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), offset: const Offset(0, 4), blurRadius: 10)],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: IntrinsicHeight(
          child: Row(
            children: [
              Container(width: 5, color: colorEstado),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    children: [
                      FaIcon(icono, size: 24, color: colorEstado),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(titulo, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF333333))),
                            const SizedBox(height: 5),
                            Text('Vence: $fecha', style: const TextStyle(fontSize: 14, color: Color(0xFF666666))),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _construirItemDocumento(Map<String, dynamic> doc) {
    return InkWell(
      onTap: () => abrirDocumento(doc),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            const FaIcon(FontAwesomeIcons.filePdf, size: 24, color: Color(0xFF00615C)),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(doc['nombre'], style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Color(0xFF333333))),
                  const SizedBox(height: 3),
                  Text('Cargado: ${doc['fechaCarga']}', style: const TextStyle(fontSize: 12, color: Color(0xFF888888))),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFF00615C).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const FaIcon(FontAwesomeIcons.eye, size: 16, color: Color(0xFF00615C)),
            ),
          ],
        ),
      ),
    );
  }
}