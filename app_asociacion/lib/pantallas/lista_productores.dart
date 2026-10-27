import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';

class ListaProductoresScreen extends StatefulWidget {
  const ListaProductoresScreen({super.key});

  @override
  State<ListaProductoresScreen> createState() => _ListaProductoresScreenState();
}

class _ListaProductoresScreenState extends State<ListaProductoresScreen> {
  bool estaCargando = true;
  final ImagePicker _picker = ImagePicker();

  // Estado principal de la lista de productores
  List<Map<String, dynamic>> productores = [
    {
      'id': '1',
      'nombre': 'Carlos Ramírez',
      'etapa': 'Cosecha',
      'telefono': '311 000 0000',
      'correo': 'carlos@agro.com',
      'finca': 'El Mirador',
      'hectareas': '5',
      'vereda': 'La Florida',
      'fotoBytes': null,
    },
    {
      'id': '2',
      'nombre': 'María Gómez',
      'etapa': 'Siembra',
      'telefono': '312 000 0000',
      'correo': 'maria@agro.com',
      'finca': 'La Esperanza',
      'hectareas': '3.5',
      'vereda': 'El Cedral',
      'fotoBytes': null,
    }
  ];

  // Controladores del formulario
  final TextEditingController nombreCtrl = TextEditingController();
  final TextEditingController fincaCtrl = TextEditingController();
  final TextEditingController hectareasCtrl = TextEditingController();
  final TextEditingController veredaCtrl = TextEditingController();
  final TextEditingController telefonoCtrl = TextEditingController();
  final TextEditingController correoCtrl = TextEditingController();
  
  String nuevaEtapa = 'Preparación';
  Uint8List? nuevaFotoBytes;
  
  final List<String> etapasDisponibles = ['Preparación', 'Siembra', 'Mantenimiento', 'Cosecha'];

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 1200), () {
      if (mounted) setState(() => estaCargando = false);
    });
  }

  @override
  void dispose() {
    nombreCtrl.dispose();
    fincaCtrl.dispose();
    hectareasCtrl.dispose();
    veredaCtrl.dispose();
    telefonoCtrl.dispose();
    correoCtrl.dispose();
    super.dispose();
  }

  void limpiarFormulario() {
    nombreCtrl.clear();
    fincaCtrl.clear();
    hectareasCtrl.clear();
    veredaCtrl.clear();
    telefonoCtrl.clear();
    correoCtrl.clear();
    nuevaEtapa = 'Preparación';
    nuevaFotoBytes = null;
  }

  Future<void> seleccionarFoto(StateSetter setDialogState) async {
    try {
      final XFile? imagen = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );

      if (imagen != null) {
        final bytes = await imagen.readAsBytes();
        setDialogState(() {
          nuevaFotoBytes = bytes;
        });
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error al acceder a la galería.'), backgroundColor: Colors.red),
      );
    }
  }

  void guardarProductor() {
    if (nombreCtrl.text.trim().isEmpty) return;

    final nuevoRegistro = {
      'id': DateTime.now().millisecondsSinceEpoch.toString(),
      'nombre': nombreCtrl.text,
      'telefono': telefonoCtrl.text,
      'correo': correoCtrl.text,
      'finca': fincaCtrl.text,
      'hectareas': hectareasCtrl.text,
      'vereda': veredaCtrl.text,
      'etapa': nuevaEtapa,
      'fotoBytes': nuevaFotoBytes,
    };

    setState(() {
      productores.insert(0, nuevoRegistro);
    });

    limpiarFormulario();
    Navigator.pop(context); 
  }

  void mostrarModalRegistro() {
    limpiarFormulario();
    
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return Dialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              alignment: Alignment.bottomCenter,
              insetPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Container(
                constraints: const BoxConstraints(maxWidth: 500),
                padding: const EdgeInsets.all(25),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('Registrar Productor', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF00615C))),
                    const SizedBox(height: 15),
                    
                    Flexible(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Column(
                                children: [
                                  GestureDetector(
                                    onTap: () => seleccionarFoto(setDialogState),
                                    child: Stack(
                                      alignment: Alignment.bottomRight,
                                      children: [
                                        Container(
                                          width: 80,
                                          height: 80,
                                          decoration: BoxDecoration(
                                            color: const Color(0xFF00615C).withValues(alpha: 0.05),
                                            shape: BoxShape.circle,
                                            border: Border.all(color: const Color(0xFF00615C), width: 2, style: BorderStyle.solid),
                                          ),
                                          child: ClipOval(
                                            child: nuevaFotoBytes != null
                                                ? Image.memory(nuevaFotoBytes!, fit: BoxFit.cover, width: 80, height: 80)
                                                : const Center(child: FaIcon(FontAwesomeIcons.userPlus, size: 30, color: Color(0xFF00615C))),
                                          ),
                                        ),
                                        Container(
                                          width: 26,
                                          height: 26,
                                          decoration: BoxDecoration(color: const Color(0xFF00615C), shape: BoxShape.circle, border: Border.all(color: Colors.white, width: 2)),
                                          child: const Center(child: FaIcon(FontAwesomeIcons.camera, size: 10, color: Colors.white)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(nuevaFotoBytes != null ? 'Cambiar Foto' : 'Agregar Foto', style: const TextStyle(fontSize: 12, color: Color(0xFF00615C), fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                            const SizedBox(height: 15),

                            _construirInput('Nombre Completo', 'Ej. Juan Pérez', nombreCtrl),
                            _construirInput('Nombre de la Finca', 'Ej. La Bendición', fincaCtrl),
                            
                            Row(
                              children: [
                                Expanded(child: _construirInput('Hectáreas', 'Ej. 2.5', hectareasCtrl, tipoTeclado: TextInputType.number)),
                                const SizedBox(width: 10),
                                Expanded(child: _construirInput('Vereda', 'Ej. La Florida', veredaCtrl)),
                              ],
                            ),

                            _construirInput('Teléfono', 'Ej. 300 000 0000', telefonoCtrl, tipoTeclado: TextInputType.phone),
                            _construirInput('Correo Electrónico', 'ejemplo@correo.com', correoCtrl, tipoTeclado: TextInputType.emailAddress),
                            
                            const Padding(
                              padding: EdgeInsets.only(top: 12, bottom: 8),
                              child: Text('Etapa Productiva Actual', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF333333))),
                            ),
                            
                            Wrap(
                              spacing: 10,
                              runSpacing: 10,
                              children: etapasDisponibles.map((etapa) {
                                final bool esActiva = nuevaEtapa == etapa;
                                return GestureDetector(
                                  onTap: () {
                                    setDialogState(() {
                                      nuevaEtapa = etapa;
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                    decoration: BoxDecoration(
                                      color: esActiva ? const Color(0xFF00615C) : const Color(0xFFF4F6F8),
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(color: esActiva ? const Color(0xFF00615C) : const Color(0xFFE0E0E0)),
                                    ),
                                    child: Text(
                                      etapa,
                                      style: TextStyle(fontSize: 12, color: esActiva ? Colors.white : const Color(0xFF666666), fontWeight: esActiva ? FontWeight.bold : FontWeight.normal),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    
                    Row(
                      children: [
                        Expanded(
                          child: TextButton(
                            onPressed: () => Navigator.pop(context),
                            style: TextButton.styleFrom(backgroundColor: const Color(0xFFF4F6F8), padding: const EdgeInsets.symmetric(vertical: 15), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                            child: const Text('Cancelar', style: TextStyle(color: Color(0xFF666666), fontWeight: FontWeight.bold)),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: guardarProductor,
                            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF00615C), padding: const EdgeInsets.symmetric(vertical: 15), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                            child: const Text('Guardar', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          }
        );
      },
    );
  }

  Widget _construirInput(String label, String hint, TextEditingController controlador, {TextInputType tipoTeclado = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF333333))),
          const SizedBox(height: 5),
          TextField(
            controller: controlador,
            keyboardType: tipoTeclado,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(color: Colors.grey, fontSize: 13),
              filled: true,
              fillColor: const Color(0xFFF4F6F8),
              contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color(0xFFE0E0E0))),
              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color(0xFF00615C))),
            ),
          ),
        ],
      ),
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
              Text('Cargando Directorio...', style: TextStyle(color: Color(0xFF00615C), fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F8),
      floatingActionButton: FloatingActionButton(
        onPressed: mostrarModalRegistro,
        backgroundColor: const Color(0xFF00615C),
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: const FaIcon(FontAwesomeIcons.plus, color: Colors.white),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), offset: const Offset(0, 2), blurRadius: 3)]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const FaIcon(FontAwesomeIcons.arrowLeft, color: Color(0xFF00615C), size: 20),
                    onPressed: () {
                      if (Navigator.canPop(context)) Navigator.pop(context);
                    },
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                  const Text('Productores', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF00615C))),
                  const SizedBox(width: 20), 
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Center(
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 700),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Total de asociados: ${productores.length}', style: const TextStyle(fontSize: 14, color: Color(0xFF666666), fontWeight: FontWeight.bold)),
                        const SizedBox(height: 15),

                        ...productores.map((prod) {
                          return Container(
                            margin: const EdgeInsets.only(bottom: 15),
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), offset: const Offset(0, 2), blurRadius: 5)],
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 45,
                                      height: 45,
                                      decoration: BoxDecoration(
                                        color: prod['fotoBytes'] != null ? Colors.transparent : const Color(0xFF00615C).withValues(alpha: 0.1),
                                        shape: BoxShape.circle,
                                      ),
                                      child: ClipOval(
                                        child: prod['fotoBytes'] != null
                                            ? Image.memory(prod['fotoBytes'], fit: BoxFit.cover, width: 45, height: 45)
                                            : const Center(child: FaIcon(FontAwesomeIcons.user, size: 20, color: Color(0xFF00615C))), // Actualizado a user
                                      ),
                                    ),
                                    const SizedBox(width: 15),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(prod['nombre'], style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF333333))),
                                          const SizedBox(height: 3),
                                          Text('Etapa: ${prod['etapa']}', style: const TextStyle(fontSize: 12, color: Color(0xFFF57C00), fontWeight: FontWeight.bold)),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                const Padding(padding: EdgeInsets.symmetric(vertical: 12), child: Divider(color: Color(0xFFE0E0E0), height: 1)),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(children: [const FaIcon(FontAwesomeIcons.house, size: 12, color: Color(0xFF00615C)), const SizedBox(width: 5), Text('Finca ${prod['finca']} (${prod['hectareas']} ha)', style: const TextStyle(fontSize: 12, color: Color(0xFF666666)))]), // Actualizado a house
                                    Row(children: [const FaIcon(FontAwesomeIcons.locationDot, size: 12, color: Color(0xFF00615C)), const SizedBox(width: 5), Text(prod['vereda'], style: const TextStyle(fontSize: 12, color: Color(0xFF666666)))]), // Actualizado a locationDot
                                  ],
                                ),
                                const Padding(padding: EdgeInsets.symmetric(vertical: 8), child: Divider(color: Color(0xFFE0E0E0), height: 1)),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(children: [const FaIcon(FontAwesomeIcons.phone, size: 12, color: Color(0xFF888888)), const SizedBox(width: 5), Text(prod['telefono'], style: const TextStyle(fontSize: 12, color: Color(0xFF666666)))]),
                                    Row(children: [const FaIcon(FontAwesomeIcons.envelope, size: 12, color: Color(0xFF888888)), const SizedBox(width: 5), Text(prod['correo'], style: const TextStyle(fontSize: 12, color: Color(0xFF666666)))]),
                                  ],
                                ),
                              ],
                            ),
                          );
                        }),
                        const SizedBox(height: 80), 
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
}