import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AvisosAdminScreen extends StatefulWidget {
  const AvisosAdminScreen({super.key});

  @override
  State<AvisosAdminScreen> createState() => _AvisosAdminScreenState();
}

class _AvisosAdminScreenState extends State<AvisosAdminScreen> {
  final TextEditingController tituloController = TextEditingController();
  final TextEditingController mensajeController = TextEditingController();
  String prioridadSeleccionada = 'Normal';
  String destinatarioSeleccionado = 'Todos los Productores';
  bool enviarPorWhatsapp = false;

  final List<Map<String, dynamic>> historialAvisos = [
    {
      'titulo': 'Actualización de Precios del Café',
      'fecha': '26 Oct 2026',
      'prioridad': 'Alta',
      'destinatarios': 'Productores de Café',
      'whatsapp': true,
      'mensaje': 'Se informa a todos los productores que el precio de carga ha sido actualizado en la cartelera virtual.'
    },
    {
      'titulo': 'Reunión de Asamblea General',
      'fecha': '20 Oct 2026',
      'prioridad': 'Urgente',
      'destinatarios': 'Todos los Productores',
      'whatsapp': false,
      'mensaje': 'Convocatoria obligatoria para la asamblea anual este viernes a las 8:00 AM en la sede principal.'
    },
  ];

  void enviarAviso() {
    if (tituloController.text.isEmpty || mensajeController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor llena todos los campos obligatorios'), backgroundColor: Colors.red),
      );
      return;
    }

    setState(() {
      historialAvisos.insert(0, {
        'titulo': tituloController.text,
        'fecha': 'Hoy',
        'prioridad': prioridadSeleccionada,
        'destinatarios': destinatarioSeleccionado,
        'whatsapp': enviarPorWhatsapp,
        'mensaje': mensajeController.text,
      });
    });

    tituloController.clear();
    mensajeController.clear();
    setState(() {
      prioridadSeleccionada = 'Normal';
      destinatarioSeleccionado = 'Todos los Productores';
      enviarPorWhatsapp = false;
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Aviso programado para envío exitosamente'), backgroundColor: Color(0xFF00615C)),
    );
  }

  @override
  void dispose() {
    tituloController.dispose();
    mensajeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F8),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: const IconThemeData(color: Color(0xFF00615C)),
        title: const Text('Gestión de Avisos', style: TextStyle(color: Color(0xFF00615C), fontWeight: FontWeight.bold)),
      ),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // PANEL IZQUIERDO: Formulario de Envío
            Expanded(
              flex: 4,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(30),
                child: Container(
                  padding: const EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.02), blurRadius: 10, offset: const Offset(0, 4))],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          FaIcon(FontAwesomeIcons.bullhorn, color: Color(0xFF00615C), size: 24),
                          SizedBox(width: 15),
                          Text('Redactar Nuevo Aviso', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF333333))),
                        ],
                      ),
                      const SizedBox(height: 30),

                      const Text('Título del Comunicado *', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                      const SizedBox(height: 8),
                      TextField(
                        controller: tituloController,
                        decoration: InputDecoration(
                          hintText: 'Ej. Jornada de vacunación bovina',
                          filled: true,
                          fillColor: const Color(0xFFF9FAFB),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
                        ),
                      ),
                      const SizedBox(height: 20),

                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Destinatarios *', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                                const SizedBox(height: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 15),
                                  decoration: BoxDecoration(color: const Color(0xFFF9FAFB), borderRadius: BorderRadius.circular(8)),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      value: destinatarioSeleccionado,
                                      isExpanded: true,
                                      items: ['Todos los Productores', 'Productores de Café', 'Productores de Plátano', 'Selección Manual (Lista)'].map((String value) {
                                        return DropdownMenuItem<String>(value: value, child: Text(value));
                                      }).toList(),
                                      onChanged: (String? newValue) {
                                        if (newValue != null) setState(() => destinatarioSeleccionado = newValue);
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Nivel de Prioridad', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                                const SizedBox(height: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 15),
                                  decoration: BoxDecoration(color: const Color(0xFFF9FAFB), borderRadius: BorderRadius.circular(8)),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      value: prioridadSeleccionada,
                                      isExpanded: true,
                                      items: ['Normal', 'Alta', 'Urgente'].map((String value) {
                                        return DropdownMenuItem<String>(value: value, child: Text(value));
                                      }).toList(),
                                      onChanged: (String? newValue) {
                                        if (newValue != null) setState(() => prioridadSeleccionada = newValue);
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      const Text('Mensaje *', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                      const SizedBox(height: 8),
                      TextField(
                        controller: mensajeController,
                        maxLines: 5,
                        decoration: InputDecoration(
                          hintText: 'Escribe los detalles aquí...',
                          filled: true,
                          fillColor: const Color(0xFFF9FAFB),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // INTEGRACIÓN WHATSAPP (UI)
                      Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: enviarPorWhatsapp ? const Color(0xFFE8F5E9) : const Color(0xFFF9FAFB),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: enviarPorWhatsapp ? Colors.green : Colors.transparent),
                        ),
                        child: Row(
                          children: [
                            Checkbox(
                              value: enviarPorWhatsapp,
                              activeColor: Colors.green,
                              onChanged: (bool? value) {
                                setState(() => enviarPorWhatsapp = value ?? false);
                              },
                            ),
                            const FaIcon(FontAwesomeIcons.whatsapp, color: Colors.green, size: 24),
                            const SizedBox(width: 15),
                            const Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Enviar copia por WhatsApp', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                                  Text('Se enviará un mensaje directo al número registrado de los destinatarios.', style: TextStyle(color: Colors.grey, fontSize: 12)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),

                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: enviarAviso,
                          icon: const FaIcon(FontAwesomeIcons.paperPlane, size: 16, color: Colors.white),
                          label: const Text('Publicar y Enviar Aviso', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF00615C),
                            padding: const EdgeInsets.symmetric(vertical: 18),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // PANEL DERECHO: Historial de Avisos
            Expanded(
              flex: 3,
              child: Container(
                color: const Color(0xFFE8ECEF).withValues(alpha: 0.5),
                padding: const EdgeInsets.all(30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Historial de Envíos', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF333333))),
                    const SizedBox(height: 20),
                    Expanded(
                      child: ListView.builder(
                        itemCount: historialAvisos.length,
                        itemBuilder: (context, index) {
                          final aviso = historialAvisos[index];
                          Color badgeColor = aviso['prioridad'] == 'Urgente' ? Colors.red : (aviso['prioridad'] == 'Alta' ? Colors.orange : Colors.green);
                          
                          return Card(
                            elevation: 0,
                            margin: const EdgeInsets.only(bottom: 15),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
                                        child: Text(aviso['prioridad'], style: TextStyle(color: badgeColor, fontSize: 12, fontWeight: FontWeight.bold)),
                                      ),
                                      Text(aviso['fecha'], style: const TextStyle(color: Colors.grey, fontSize: 12)),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Text(aviso['titulo'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      const FaIcon(FontAwesomeIcons.users, size: 12, color: Colors.grey),
                                      const SizedBox(width: 5),
                                      Text(aviso['destinatarios'], style: const TextStyle(color: Colors.grey, fontSize: 12)),
                                      if (aviso['whatsapp'] == true) ...[
                                        const SizedBox(width: 10),
                                        const FaIcon(FontAwesomeIcons.whatsapp, size: 14, color: Colors.green),
                                      ]
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Text(aviso['mensaje'], style: const TextStyle(color: Color(0xFF666666), fontSize: 14)),
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
            ),
          ],
        ),
      ),
    );
  }
}