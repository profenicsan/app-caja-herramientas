import React, { useState, useRef } from 'react';
import { View, Text, StyleSheet, TextInput, TouchableOpacity, SafeAreaView, ScrollView, KeyboardAvoidingView, Platform, ActivityIndicator } from 'react-native';
import { useNavigation } from '@react-navigation/native';
import { FontAwesome5 } from '@expo/vector-icons';

interface Mensaje {
  id: string;
  texto: string;
  remitente: 'usuario' | 'ia';
}

export default function AsistenteIA() {
  const navigation = useNavigation<any>();
  const scrollViewRef = useRef<ScrollView>(null);
  
  const [inputMensaje, setInputMensaje] = useState('');
  const [estaEscribiendo, setEstaEscribiendo] = useState(false);
  
  const [mensajes, setMensajes] = useState<Mensaje[]>([
    {
      id: '1',
      texto: '¡Hola! Soy tu Asistente Agrícola impulsado por Mistral. ¿En qué te puedo ayudar hoy en tu finca?',
      remitente: 'ia'
    }
  ]);

  // CONFIGURACIÓN DE CONEXIÓN A OLLAMA LOCAL
  // Emulador Android usa 10.0.2.2. Web usa localhost. Celular físico requiere tu IP de WiFi.
  const OLLAMA_URL = Platform.OS === 'android' ? 'http://10.0.2.2:11434/api/chat' : 'http://localhost:11434/api/chat';

  // EL CEREBRO DE LA IA:
  const SYSTEM_PROMPT = `
    Eres el Asistente Técnico Agrícola oficial de AgroAsoc, respaldado por la EPSEA.
    Tu objetivo es ayudar a los agricultores en su trabajo diario en la finca.
    Reglas:
    1. Háblale al productor de forma directa, amable y respetuosa en español nativo.
    2. Tus respuestas deben ser accionables y enfocadas en la solución inmediata.
    3. No uses jerga compleja, administrativa o financiera.
    4. Estructura tus respuestas de forma breve y concisa.
  `;

  const enviarMensaje = async () => {
    if (inputMensaje.trim() === '') return;

    const textoUsuario = inputMensaje.trim();
    const nuevoMensajeUsuario: Mensaje = {
      id: Date.now().toString(),
      texto: textoUsuario,
      remitente: 'usuario'
    };

    setMensajes(prev => [...prev, nuevoMensajeUsuario]);
    setInputMensaje('');
    setEstaEscribiendo(true);

    setTimeout(() => scrollViewRef.current?.scrollToEnd({ animated: true }), 100);

    try {
      // LLAMADA REAL AL MOTOR DE INTELIGENCIA ARTIFICIAL
      const response = await fetch(OLLAMA_URL, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          model: 'mistral',
          messages: [
            { role: 'system', content: SYSTEM_PROMPT },
            { role: 'user', content: textoUsuario }
          ],
          stream: false // Para recibir la respuesta completa de una vez
        })
      });

      if (!response.ok) {
        throw new Error(`Error de conexión HTTP: ${response.status}`);
      }

      const data = await response.json();
      
      const respuestaIA: Mensaje = {
        id: (Date.now() + 1).toString(),
        texto: data.message.content,
        remitente: 'ia'
      };
      
      setMensajes(prev => [...prev, respuestaIA]);

    } catch (error) {
      console.error("Error de IA:", error);
      const errorMensaje: Mensaje = {
        id: (Date.now() + 1).toString(),
        texto: "Lo siento, no pude conectar con el motor local de IA. Verifica que Ollama (Mistral) esté en ejecución en tu computador.",
        remitente: 'ia'
      };
      setMensajes(prev => [...prev, errorMensaje]);
    } finally {
      setEstaEscribiendo(false);
      setTimeout(() => scrollViewRef.current?.scrollToEnd({ animated: true }), 100);
    }
  };

  return (
    <SafeAreaView style={styles.contenedorPrincipal}>
      
      <View style={styles.encabezado}>
        <TouchableOpacity onPress={() => navigation.goBack()} style={styles.botonVolver}>
          <FontAwesome5 name="arrow-left" size={20} color="#00615C" />
        </TouchableOpacity>
        <View style={styles.infoEncabezado}>
          <Text style={styles.tituloPantalla}>Asistente Agrícola</Text>
          <Text style={styles.subtituloPantalla}>IA Local Activa (Mistral)</Text>
        </View>
        <View style={styles.avatarIA}>
          <FontAwesome5 name="robot" size={18} color="#FFF" />
        </View>
      </View>

      <KeyboardAvoidingView 
        style={styles.contenedorTeclado} 
        behavior={Platform.OS === 'ios' ? 'padding' : undefined}
      >
        <ScrollView 
          ref={scrollViewRef}
          style={styles.areaChat} 
          contentContainerStyle={styles.contenidoChat}
          showsVerticalScrollIndicator={false}
        >
          {mensajes.map((msg) => (
            <View 
              key={msg.id} 
              style={[
                styles.burbujaMensaje, 
                msg.remitente === 'usuario' ? styles.burbujaUsuario : styles.burbujaIA
              ]}
            >
              {msg.remitente === 'ia' && (
                <FontAwesome5 name="seedling" size={12} color="#00615C" style={styles.iconoBurbujaIA} />
              )}
              <Text style={[
                styles.textoMensaje, 
                msg.remitente === 'usuario' ? styles.textoUsuario : styles.textoIA
              ]}>
                {msg.texto}
              </Text>
            </View>
          ))}

          {estaEscribiendo && (
            <View style={[styles.burbujaMensaje, styles.burbujaIA, styles.burbujaEscribiendo]}>
              <ActivityIndicator size="small" color="#00615C" />
              <Text style={styles.textoEscribiendo}>Mistral está analizando...</Text>
            </View>
          )}
        </ScrollView>

        <View style={styles.barraEntrada}>
          <TextInput
            style={styles.input}
            placeholder="Escribe tu consulta agrícola..."
            placeholderTextColor="#888"
            value={inputMensaje}
            onChangeText={setInputMensaje}
            multiline
            maxLength={300}
          />
          <TouchableOpacity 
            style={[styles.botonEnviar, inputMensaje.trim() === '' ? styles.botonEnviarInactivo : null]} 
            onPress={enviarMensaje}
            disabled={inputMensaje.trim() === '' || estaEscribiendo}
          >
            <FontAwesome5 name="paper-plane" size={16} color="#FFF" />
          </TouchableOpacity>
        </View>
      </KeyboardAvoidingView>

    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  contenedorPrincipal: { flex: 1, backgroundColor: '#F4F6F8' },
  encabezado: { flexDirection: 'row', alignItems: 'center', justifyContent: 'space-between', backgroundColor: '#FFFFFF', padding: 15, paddingHorizontal: 20, shadowColor: '#000', shadowOffset: { width: 0, height: 2 }, shadowOpacity: 0.05, elevation: 3, zIndex: 10 },
  botonVolver: { padding: 5, marginRight: 10 },
  infoEncabezado: { flex: 1 },
  tituloPantalla: { fontSize: 18, fontWeight: 'bold', color: '#00615C' },
  subtituloPantalla: { fontSize: 12, color: '#666' },
  avatarIA: { width: 36, height: 36, borderRadius: 18, backgroundColor: '#00615C', justifyContent: 'center', alignItems: 'center' },
  
  contenedorTeclado: { flex: 1 },
  areaChat: { flex: 1, paddingHorizontal: 15 },
  contenidoChat: { paddingVertical: 20 },
  
  burbujaMensaje: { maxWidth: '80%', padding: 15, borderRadius: 20, marginBottom: 15, shadowColor: '#000', shadowOpacity: 0.05, shadowRadius: 3, elevation: 1 },
  burbujaUsuario: { backgroundColor: '#00615C', alignSelf: 'flex-end', borderBottomRightRadius: 5 },
  burbujaIA: { backgroundColor: '#FFFFFF', alignSelf: 'flex-start', borderBottomLeftRadius: 5, flexDirection: 'row', alignItems: 'flex-start' },
  burbujaEscribiendo: { alignItems: 'center', paddingVertical: 10, paddingHorizontal: 20 },
  
  iconoBurbujaIA: { marginRight: 8, marginTop: 2 },
  textoMensaje: { fontSize: 15, lineHeight: 22 },
  textoUsuario: { color: '#FFFFFF' },
  textoIA: { color: '#333333', flex: 1 },
  textoEscribiendo: { marginLeft: 10, color: '#666', fontSize: 14, fontStyle: 'italic' },
  
  barraEntrada: { flexDirection: 'row', alignItems: 'flex-end', backgroundColor: '#FFFFFF', padding: 10, paddingHorizontal: 15, borderTopWidth: 1, borderColor: '#E0E0E0' },
  input: { flex: 1, backgroundColor: '#F4F6F8', borderRadius: 20, paddingHorizontal: 15, paddingTop: 12, paddingBottom: 12, maxHeight: 100, fontSize: 15, color: '#333' },
  botonEnviar: { width: 44, height: 44, borderRadius: 22, backgroundColor: '#00615C', justifyContent: 'center', alignItems: 'center', marginLeft: 10, marginBottom: 2 },
  botonEnviarInactivo: { backgroundColor: '#B0BEC5' }
});