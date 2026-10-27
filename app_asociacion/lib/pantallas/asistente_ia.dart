import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;

class Mensaje {
  final String id;
  final String texto;
  final String remitente; // 'usuario' | 'ia'

  Mensaje({required this.id, required this.texto, required this.remitente});
}

class AsistenteIAScreen extends StatefulWidget {
  const AsistenteIAScreen({super.key});

  @override
  State<AsistenteIAScreen> createState() => _AsistenteIAScreenState();
}

class _AsistenteIAScreenState extends State<AsistenteIAScreen> {
  final TextEditingController inputCtrl = TextEditingController();
  final ScrollController scrollCtrl = ScrollController();
  
  bool estaEscribiendo = false;

  List<Mensaje> mensajes = [
    Mensaje(
      id: '1',
      texto: '¡Hola! Soy tu Asistente Agrícola impulsado por Mistral. ¿En qué te puedo ayudar hoy en tu finca?',
      remitente: 'ia',
    )
  ];

  String get ollamaUrl {
    if (kIsWeb) return 'http://localhost:11434/api/chat';
    if (Platform.isAndroid) return 'http://10.0.2.2:11434/api/chat';
    return 'http://localhost:11434/api/chat'; 
  }

  final String systemPrompt = '''
    Eres el Asistente Técnico Agrícola oficial de AgroAsoc, respaldado por la EPSEA.
    Tu objetivo es ayudar a los agricultores en su trabajo diario en la finca.
    Reglas:
    1. Háblale al productor de forma directa, amable y respetuosa en español nativo.
    2. Tus respuestas deben ser accionables y enfocadas en la solución inmediata.
    3. No uses jerga compleja, administrativa o financiera.
    4. Estructura tus respuestas de forma breve y concisa.
  ''';

  @override
  void dispose() {
    inputCtrl.dispose();
    scrollCtrl.dispose();
    super.dispose();
  }

  void _bajarScroll() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (scrollCtrl.hasClients) {
        scrollCtrl.animateTo(
          scrollCtrl.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Future<void> enviarMensaje() async {
    final textoUsuario = inputCtrl.text.trim();
    if (textoUsuario.isEmpty) return;

    final nuevoMensajeUsuario = Mensaje(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      texto: textoUsuario,
      remitente: 'usuario',
    );

    setState(() {
      mensajes.add(nuevoMensajeUsuario);
      estaEscribiendo = true;
    });
    
    inputCtrl.clear();
    _bajarScroll();

    try {
      final response = await http.post(
        Uri.parse(ollamaUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'model': 'mistral',
          'messages': [
            {'role': 'system', 'content': systemPrompt},
            {'role': 'user', 'content': textoUsuario}
          ],
          'stream': false
        }),
      );

      if (response.statusCode != 200) {
        throw Exception('Error HTTP: ${response.statusCode}');
      }

      final data = jsonDecode(response.body);
      
      final respuestaIA = Mensaje(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        texto: data['message']['content'],
        remitente: 'ia',
      );

      if (mounted) {
        setState(() {
          mensajes.add(respuestaIA);
        });
      }
    } catch (error) {
      debugPrint("Error de IA: $error");
      final errorMensaje = Mensaje(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        texto: "Lo siento, no pude conectar con el motor local de IA. Verifica que Ollama (Mistral) esté en ejecución en tu computador.",
        remitente: 'ia',
      );
      if (mounted) {
        setState(() {
          mensajes.add(errorMensaje);
        });
      }
    } finally {
      if (mounted) {
        setState(() {
          estaEscribiendo = false;
        });
        _bajarScroll();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F8),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
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
                  const SizedBox(width: 15),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Asistente Agrícola', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF00615C))),
                        Text('IA Local Activa (Mistral)', style: TextStyle(fontSize: 12, color: Color(0xFF666666))),
                      ],
                    ),
                  ),
                  Container(
                    width: 36,
                    height: 36,
                    decoration: const BoxDecoration(color: Color(0xFF00615C), shape: BoxShape.circle),
                    child: const Center(child: FaIcon(FontAwesomeIcons.robot, size: 18, color: Colors.white)),
                  )
                ],
              ),
            ),

            Expanded(
              child: ListView.builder(
                controller: scrollCtrl,
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                itemCount: mensajes.length + (estaEscribiendo ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == mensajes.length && estaEscribiendo) {
                    return _construirBurbujaEscribiendo();
                  }

                  final msg = mensajes[index];
                  final esUsuario = msg.remitente == 'usuario';

                  return Align(
                    alignment: esUsuario ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      // AQUÍ ESTÁ LA SOLUCIÓN: Usamos constraints en lugar de maxWidth directo
                      constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.8),
                      margin: const EdgeInsets.only(bottom: 15),
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: esUsuario ? const Color(0xFF00615C) : Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(20),
                          topRight: const Radius.circular(20),
                          bottomLeft: Radius.circular(esUsuario ? 20 : 5),
                          bottomRight: Radius.circular(esUsuario ? 5 : 20),
                        ),
                        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 3, offset: const Offset(0, 1))],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (!esUsuario)
                            const Padding(
                              padding: EdgeInsets.only(right: 8.0, top: 2.0),
                              child: FaIcon(FontAwesomeIcons.seedling, size: 12, color: Color(0xFF00615C)),
                            ),
                          Flexible(
                            child: Text(
                              msg.texto,
                              style: TextStyle(
                                fontSize: 15,
                                height: 1.4,
                                color: esUsuario ? Colors.white : const Color(0xFF333333),
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

            Container(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 15),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(top: BorderSide(color: Color(0xFFE0E0E0), width: 1)),
              ),
              child: SafeArea(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFF4F6F8),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: TextField(
                          controller: inputCtrl,
                          minLines: 1,
                          maxLines: 4,
                          textInputAction: TextInputAction.newline,
                          style: const TextStyle(fontSize: 15, color: Color(0xFF333333)),
                          decoration: const InputDecoration(
                            hintText: 'Escribe tu consulta agrícola...',
                            hintStyle: TextStyle(color: Color(0xFF888888)),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                          ),
                          onChanged: (text) {
                            setState(() {}); 
                          },
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: (inputCtrl.text.trim().isEmpty || estaEscribiendo) ? null : enviarMensaje,
                      child: Container(
                        width: 44,
                        height: 44,
                        margin: const EdgeInsets.only(bottom: 2),
                        decoration: BoxDecoration(
                          color: (inputCtrl.text.trim().isEmpty || estaEscribiendo) ? const Color(0xFFB0BEC5) : const Color(0xFF00615C),
                          shape: BoxShape.circle,
                        ),
                        child: const Center(
                          child: FaIcon(FontAwesomeIcons.paperPlane, size: 16, color: Colors.white),
                        ),
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

  Widget _construirBurbujaEscribiendo() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomLeft: Radius.circular(5),
            bottomRight: Radius.circular(20),
          ),
          boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 3, offset: const Offset(0, 1))],
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(strokeWidth: 2, color: Color(0xFF00615C)),
            ),
            SizedBox(width: 10),
            Text('Mistral está analizando...', style: TextStyle(color: Color(0xFF666666), fontSize: 14, fontStyle: FontStyle.italic)),
          ],
        ),
      ),
    );
  }
}