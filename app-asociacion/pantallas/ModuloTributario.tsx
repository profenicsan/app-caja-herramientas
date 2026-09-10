import React, { useState, useEffect } from 'react';
import { View, Text, StyleSheet, TouchableOpacity, SafeAreaView, ScrollView, Alert } from 'react-native';
import { useNavigation } from '@react-navigation/native';
import { FontAwesome5 } from '@expo/vector-icons';
import * as DocumentPicker from 'expo-document-picker'; // <-- NUEVA LIBRERÍA IMPORTADA

import CargandoPlanta from './CargandoPlanta';

const TarjetaAlerta = ({ titulo, fecha, estado, icono }: any) => (
  <View style={[styles.tarjeta, styles.tarjetaAlerta]}>
    <View style={styles.filaAlerta}>
      <FontAwesome5 name={icono} size={24} color={estado === 'urgente' ? '#D32F2F' : '#F57C00'} />
      <View style={styles.infoAlerta}>
        <Text style={styles.tituloAlerta}>{titulo}</Text>
        <Text style={styles.fechaAlerta}>Vence: {fecha}</Text>
      </View>
    </View>
  </View>
);

const ItemDocumento = ({ nombre, fechaCarga }: any) => (
  <View style={styles.itemDocumento}>
    <FontAwesome5 name="file-pdf" size={24} color="#00615C" />
    <View style={styles.infoDocumento}>
      <Text style={styles.nombreDocumento}>{nombre}</Text>
      <Text style={styles.fechaCarga}>Cargado: {fechaCarga}</Text>
    </View>
    <TouchableOpacity>
      <FontAwesome5 name="download" size={20} color="#666" />
    </TouchableOpacity>
  </View>
);

export default function ModuloTributario() {
  const navigation = useNavigation<any>();
  const [estaCargando, setEstaCargando] = useState(true);

  useEffect(() => {
    const temporizador = setTimeout(() => {
      setEstaCargando(false);
    }, 1500);
    return () => clearTimeout(temporizador);
  }, []);

  // LÓGICA REAL PARA SUBIR ARCHIVOS
  const manejarSubida = async () => {
    try {
      const resultado = await DocumentPicker.getDocumentAsync({
        // Filtramos para que solo deje subir PDFs e imágenes
        type: ['application/pdf', 'image/jpeg', 'image/png'], 
        copyToCacheDirectory: true,
      });

      if (!resultado.canceled) {
        const archivo = resultado.assets[0];
        // Mostramos una alerta confirmando que atrapamos el archivo
        Alert.alert(
          "¡Archivo Seleccionado!",
          `Has elegido: ${archivo.name}\n\n(Este es el archivo que enviaremos a la IA de NestJS en nuestra próxima sesión)`
        );
      }
    } catch (error) {
      console.error("Error al seleccionar documento:", error);
      Alert.alert("Error", "Hubo un problema al intentar abrir los archivos.");
    }
  };

  if (estaCargando) {
    return <CargandoPlanta mensaje="Conectando con la Bóveda..." />;
  }

  return (
    <SafeAreaView style={styles.contenedorPrincipal}>
      
      <View style={styles.encabezado}>
        <TouchableOpacity onPress={() => navigation.goBack()} style={styles.botonVolver}>
          <FontAwesome5 name="arrow-left" size={20} color="#00615C" />
        </TouchableOpacity>
        <Text style={styles.tituloPantalla}>Gestión DIAN y Bóveda</Text>
        <View style={{ width: 20 }} /> 
      </View>

      <ScrollView style={styles.scrollArea} showsVerticalScrollIndicator={false}>
        
        <Text style={styles.tituloSeccion}>Próximos Vencimientos</Text>
        <TarjetaAlerta 
          titulo="Renovación Cámara de Comercio" 
          fecha="31 de Marzo, 2027" 
          estado="advertencia" 
          icono="building" 
        />
        <TarjetaAlerta 
          titulo="Declaración IVA Bimestral" 
          fecha="15 de Septiembre, 2026" 
          estado="urgente" 
          icono="exclamation-triangle" 
        />

        <View style={styles.encabezadoBoveda}>
          <Text style={styles.tituloSeccion}>Bóveda Digital</Text>
          <TouchableOpacity style={styles.botonIA}>
            <FontAwesome5 name="robot" size={16} color="#FFF" style={{ marginRight: 8 }} />
            <Text style={styles.textoBotonIA}>Analizar con IA</Text>
          </TouchableOpacity>
        </View>

        <TouchableOpacity style={styles.zonaCarga} onPress={manejarSubida}>
          <FontAwesome5 name="cloud-upload-alt" size={32} color="#00615C" />
          <Text style={styles.textoZonaCarga}>Subir nuevo documento</Text>
          <Text style={styles.subtextoZonaCarga}>Toca aquí para seleccionar un archivo PDF o JPG</Text>
        </TouchableOpacity>

        <View style={styles.tarjeta}>
          <ItemDocumento nombre="RUT_Actualizado_2026.pdf" fechaCarga="02/09/2026" />
          <View style={styles.divisor} />
          <ItemDocumento nombre="Certificado_Representacion.pdf" fechaCarga="15/08/2026" />
          <View style={styles.divisor} />
          <ItemDocumento nombre="Resolucion_Facturacion.pdf" fechaCarga="10/01/2026" />
        </View>

      </ScrollView>
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  contenedorPrincipal: { flex: 1, backgroundColor: '#F4F6F8' },
  encabezado: { flexDirection: 'row', alignItems: 'center', justifyContent: 'space-between', backgroundColor: '#FFFFFF', padding: 20, shadowColor: '#000', shadowOffset: { width: 0, height: 2 }, shadowOpacity: 0.05, elevation: 3 },
  botonVolver: { padding: 5 },
  tituloPantalla: { fontSize: 20, fontWeight: 'bold', color: '#00615C' },
  scrollArea: { padding: 20 },
  tituloSeccion: { fontSize: 18, fontWeight: 'bold', color: '#333333', marginBottom: 15, marginTop: 10 },
  encabezadoBoveda: { flexDirection: 'row', justifyContent: 'space-between', alignItems: 'center', marginTop: 20, marginBottom: 15 },
  botonIA: { flexDirection: 'row', backgroundColor: '#00615C', paddingVertical: 10, paddingHorizontal: 15, borderRadius: 8, alignItems: 'center' },
  textoBotonIA: { color: '#FFFFFF', fontWeight: 'bold', fontSize: 14 },
  zonaCarga: { borderWidth: 2, borderColor: '#00615C', borderStyle: 'dashed', borderRadius: 16, backgroundColor: 'rgba(0, 97, 92, 0.05)', padding: 25, alignItems: 'center', justifyContent: 'center', marginBottom: 15 },
  textoZonaCarga: { marginTop: 10, fontSize: 16, fontWeight: 'bold', color: '#00615C' },
  subtextoZonaCarga: { marginTop: 5, fontSize: 12, color: '#666666' },
  tarjeta: { backgroundColor: '#FFFFFF', borderRadius: 16, padding: 20, marginBottom: 40, shadowColor: '#000', shadowOffset: { width: 0, height: 4 }, shadowOpacity: 0.05, shadowRadius: 10, elevation: 4 },
  tarjetaAlerta: { borderLeftWidth: 5, borderLeftColor: '#F57C00' },
  filaAlerta: { flexDirection: 'row', alignItems: 'center' },
  infoAlerta: { marginLeft: 15 },
  tituloAlerta: { fontSize: 16, fontWeight: 'bold', color: '#333333' },
  fechaAlerta: { fontSize: 14, color: '#666666', marginTop: 5 },
  itemDocumento: { flexDirection: 'row', alignItems: 'center', justifyContent: 'space-between', paddingVertical: 10 },
  infoDocumento: { flex: 1, marginLeft: 15 },
  nombreDocumento: { fontSize: 15, fontWeight: '600', color: '#333333' },
  fechaCarga: { fontSize: 12, color: '#888888', marginTop: 3 },
  divisor: { height: 1, backgroundColor: '#E0E0E0', marginVertical: 5 },
});