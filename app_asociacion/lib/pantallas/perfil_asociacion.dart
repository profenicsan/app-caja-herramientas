import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';

class PerfilAsociacionScreen extends StatefulWidget {
  const PerfilAsociacionScreen({super.key});

  @override
  State<PerfilAsociacionScreen> createState() => _PerfilAsociacionScreenState();
}

class _PerfilAsociacionScreenState extends State<PerfilAsociacionScreen> {
  bool estaCargando = true;

  // Instancia del seleccionador de imágenes
  final ImagePicker _picker = ImagePicker();
  
  // Variables para almacenar las imágenes seleccionadas en memoria
  Uint8List? bannerBytes;
  Uint8List? logoBytes;

  // Estado con la información de la asociación
  Map<String, String> perfil = {
    'nombre': 'AgroAsoc Risaralda',
    'nit': '900.123.456-7',
    'ubicacion': 'Vereda La Florida, Pereira',
    'telefono': '+57 320 123 4567',
    'correo': 'contacto@agroasoc.com',
    'linea': 'Café Especial de Origen',
    'asociados': '45 Productores Activos',
  };

  late TextEditingController nombreCtrl;
  late TextEditingController nitCtrl;
  late TextEditingController ubicacionCtrl;
  late TextEditingController telefonoCtrl;
  late TextEditingController correoCtrl;
  late TextEditingController lineaCtrl;
  late TextEditingController asociadosCtrl;

  @override
  void initState() {
    super.initState();
    _inicializarControladores();
    
    Future.delayed(const Duration(milliseconds: 1200), () {
      if (mounted) setState(() => estaCargando = false);
    });
  }

  void _inicializarControladores() {
    nombreCtrl = TextEditingController(text: perfil['nombre']);
    nitCtrl = TextEditingController(text: perfil['nit']);
    ubicacionCtrl = TextEditingController(text: perfil['ubicacion']);
    telefonoCtrl = TextEditingController(text: perfil['telefono']);
    correoCtrl = TextEditingController(text: perfil['correo']);
    lineaCtrl = TextEditingController(text: perfil['linea']);
    asociadosCtrl = TextEditingController(text: perfil['asociados']);
  }

  @override
  void dispose() {
    nombreCtrl.dispose();
    nitCtrl.dispose();
    ubicacionCtrl.dispose();
    telefonoCtrl.dispose();
    correoCtrl.dispose();
    lineaCtrl.dispose();
    asociadosCtrl.dispose();
    super.dispose();
  }

  Future<void> cambiarImagen(String tipo) async {
    try {
      final XFile? imagenSeleccionada = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80, 
      );

      if (imagenSeleccionada != null) {
        final bytes = await imagenSeleccionada.readAsBytes();
        
        setState(() {
          if (tipo == 'banner') {
            bannerBytes = bytes;
          } else {
            logoBytes = bytes;
          }
        });
      }
    } catch (e) {
      // Verificamos si la pantalla sigue activa antes de mostrar la alerta
      if (!mounted) return;
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error al acceder a la galería.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void guardarCambios() {
    setState(() {
      perfil['nombre'] = nombreCtrl.text;
      perfil['nit'] = nitCtrl.text;
      perfil['ubicacion'] = ubicacionCtrl.text;
      perfil['telefono'] = telefonoCtrl.text;
      perfil['correo'] = correoCtrl.text;
      perfil['linea'] = lineaCtrl.text;
      perfil['asociados'] = asociadosCtrl.text;
    });
    Navigator.pop(context);
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('¡Éxito! Los datos de la asociación han sido actualizados.'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void mostrarModalEdicion() {
    _inicializarControladores();
    
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Container(
            padding: const EdgeInsets.all(20),
            constraints: const BoxConstraints(maxWidth: 400),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Editar Datos', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF00615C))),
                const SizedBox(height: 15),
                Flexible(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _construirInputFormulario('Nombre de la Asociación', nombreCtrl),
                        _construirInputFormulario('NIT', nitCtrl),
                        _construirInputFormulario('Ubicación', ubicacionCtrl),
                        _construirInputFormulario('Teléfono', telefonoCtrl, tipoTeclado: TextInputType.phone),
                        _construirInputFormulario('Correo Electrónico', correoCtrl, tipoTeclado: TextInputType.emailAddress),
                        _construirInputFormulario('Línea Productiva', lineaCtrl),
                        _construirInputFormulario('Cantidad de Asociados', asociadosCtrl),
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
                        style: TextButton.styleFrom(backgroundColor: const Color(0xFFF4F6F8), padding: const EdgeInsets.symmetric(vertical: 12), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                        child: const Text('Cancelar', style: TextStyle(color: Color(0xFF666666), fontWeight: FontWeight.bold)),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: guardarCambios,
                        style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF00615C), padding: const EdgeInsets.symmetric(vertical: 12), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                        child: const Text('Guardar', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _construirInputFormulario(String label, TextEditingController controlador, {TextInputType tipoTeclado = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF333333))),
          const SizedBox(height: 4),
          TextField(
            controller: controlador,
            keyboardType: tipoTeclado,
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xFFF4F6F8),
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
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
              Text('Cargando Perfil Institucional...', style: TextStyle(color: Color(0xFF00615C), fontWeight: FontWeight.bold)),
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
              decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), offset: const Offset(0, 2), blurRadius: 3)]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Color(0xFF00615C)), 
                    onPressed: () {
                      if (Navigator.canPop(context)) {
                        Navigator.pop(context);
                      }
                    }, 
                    padding: EdgeInsets.zero, 
                    constraints: const BoxConstraints()
                  ),
                  const Text('Perfil Asociación', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF00615C))),
                  IconButton(icon: const Icon(Icons.edit, size: 20, color: Color(0xFF00615C)), onPressed: mostrarModalEdicion, padding: EdgeInsets.zero, constraints: const BoxConstraints()),
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
                      children: [
                        SizedBox(
                          height: 200,
                          child: Stack(
                            alignment: Alignment.topCenter,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: bannerBytes != null
                                    ? Image.memory(bannerBytes!, height: 160, width: double.infinity, fit: BoxFit.cover)
                                    : Container(height: 160, width: double.infinity, color: const Color(0xFF00615C), child: const Icon(Icons.terrain, size: 60, color: Colors.white30)),
                              ),
                              Positioned(
                                top: 12,
                                right: 12,
                                child: GestureDetector(
                                  onTap: () => cambiarImagen('banner'),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                                    decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.6), borderRadius: BorderRadius.circular(20)),
                                    child: const Row(children: [Icon(Icons.camera_alt, size: 12, color: Colors.white), SizedBox(width: 5), Text('Cambiar Banner', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold))]),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                child: GestureDetector(
                                  onTap: () => cambiarImagen('logo'),
                                  child: Stack(
                                    alignment: Alignment.bottomRight,
                                    children: [
                                      Container(
                                        width: 90,
                                        height: 90,
                                        decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle, border: Border.all(color: const Color(0xFFF4F6F8), width: 3), boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.1), offset: const Offset(0, 4), blurRadius: 6)]),
                                        child: ClipOval(
                                          child: logoBytes != null
                                              ? Image.memory(logoBytes!, width: 90, height: 90, fit: BoxFit.cover)
                                              : const Icon(Icons.eco, size: 40, color: Color(0xFF00615C)),
                                        ),
                                      ),
                                      Container(width: 26, height: 26, decoration: BoxDecoration(color: const Color(0xFF00615C), shape: BoxShape.circle, border: Border.all(color: Colors.white, width: 2)), child: const Icon(Icons.camera_alt, size: 12, color: Colors.white)),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          padding: const EdgeInsets.all(25),
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), offset: const Offset(0, 4), blurRadius: 10)]),
                          child: Column(
                            children: [
                              Text(perfil['nombre']!, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF333333)), textAlign: TextAlign.center),
                              const SizedBox(height: 8),
                              Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4), decoration: BoxDecoration(color: const Color(0xFFE8F5E9), borderRadius: BorderRadius.circular(12)), child: const Text('Asociación Activa', style: TextStyle(color: Color(0xFF2E7D32), fontSize: 12, fontWeight: FontWeight.bold))),
                              const Padding(padding: EdgeInsets.symmetric(vertical: 20), child: Divider(color: Color(0xFFE0E0E0), height: 1)),
                              _construirFilaDato(Icons.badge, 'NIT', perfil['nit']!),
                              _construirFilaDato(Icons.location_on, 'Ubicación', perfil['ubicacion']!),
                              _construirFilaDato(Icons.phone, 'Teléfono de Contacto', perfil['telefono']!),
                              _construirFilaDato(Icons.email, 'Correo Electrónico', perfil['correo']!),
                              _construirFilaDato(Icons.local_florist, 'Línea Productiva Principal', perfil['linea']!),
                              _construirFilaDato(Icons.people, 'Cantidad de Asociados', perfil['asociados']!),
                              const SizedBox(height: 10),
                              ElevatedButton.icon(
                                onPressed: mostrarModalEdicion,
                                icon: const Icon(Icons.edit, size: 16, color: Colors.white),
                                label: const Text('Modificar Datos de la Asociación', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
                                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF00615C), padding: const EdgeInsets.all(15), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), minimumSize: const Size(double.infinity, 50)),
                              ),
                            ],
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

  Widget _construirFilaDato(IconData icono, String titulo, String valor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        children: [
          Container(width: 40, height: 40, decoration: BoxDecoration(color: const Color(0xFF00615C).withValues(alpha: 0.1), shape: BoxShape.circle), child: Icon(icono, size: 18, color: const Color(0xFF00615C))),
          const SizedBox(width: 15),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(titulo, style: const TextStyle(fontSize: 12, color: Color(0xFF888888))), const SizedBox(height: 2), Text(valor, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xFF333333)))])),
        ],
      ),
    );
  }
}