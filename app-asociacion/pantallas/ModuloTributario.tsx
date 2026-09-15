import React, { useState, useEffect } from 'react';
import { View, Text, StyleSheet, TouchableOpacity, SafeAreaView, ScrollView, Alert, Modal, Platform } from 'react-native';
import { useNavigation } from '@react-navigation/native';
import { FontAwesome5 } from '@expo/vector-icons';
import * as DocumentPicker from 'expo-document-picker';
import * as Sharing from 'expo-sharing';
import * as FileSystem from 'expo-file-system/legacy'; // <-- EL CAMBIO ESTÁ AQUÍ AL FINAL

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

const ItemDocumento = ({ nombre, fechaCarga, alPresionar }: any) => (
  <TouchableOpacity style={styles.itemDocumento} onPress={alPresionar}>
    <FontAwesome5 name="file-pdf" size={24} color="#00615C" />
    <View style={styles.infoDocumento}>
      <Text style={styles.nombreDocumento}>{nombre}</Text>
      <Text style={styles.fechaCarga}>Cargado: {fechaCarga}</Text>
    </View>
    <View style={styles.botonVer}>
      <FontAwesome5 name="eye" size={16} color="#00615C" />
    </View>
  </TouchableOpacity>
);

export default function ModuloTributario() {
  const navigation = useNavigation<any>();
  const [estaCargando, setEstaCargando] = useState(true);
  
  const [documentos, setDocumentos] = useState<any[]>([
    { id: '1', nombre: 'RUT_Actualizado_2026.pdf', fechaCarga: '02/09/2026', uri: null },
    { id: '2', nombre: 'Certificado_Representacion.pdf', fechaCarga: '15/08/2026', uri: null },
    { id: '3', nombre: 'Resolucion_Facturacion.pdf', fechaCarga: '10/01/2026', uri: null }
  ]);

  const [modalVisible, setModalVisible] = useState(false);
  const [docActual, setDocActual] = useState<any>(null);

  useEffect(() => {
    const temporizador = setTimeout(() => {
      setEstaCargando(false);
    }, 1500);
    return () => clearTimeout(temporizador);
  }, []);

  const manejarSubida = async () => {
    try {
      const resultado = await DocumentPicker.getDocumentAsync({
        type: ['application/pdf', 'image/jpeg', 'image/png'], 
        copyToCacheDirectory: true,
      });

      if (!resultado.canceled) {
        const archivo = resultado.assets[0];
        const fechaHoy = new Date().toLocaleDateString('es-CO', {
          day: '2-digit', month: '2-digit', year: 'numeric'
        });

        const nuevoDocumento = {
          id: Date.now().toString(), 
          nombre: archivo.name,
          fechaCarga: fechaHoy,
          uri: archivo.uri
        };

        setDocumentos([nuevoDocumento, ...documentos]);
      }
    } catch (error) {
      console.error("Error al seleccionar documento:", error);
      Alert.alert("Error", "Hubo un problema al intentar abrir los archivos.");
    }
  };

  const abrirDocumento = async (doc: any) => {
    if (!doc.uri) {
      setDocActual(doc);
      setModalVisible(true);
      return;
    }

    if (Platform.OS === 'web') {
      setDocActual(doc);
      setModalVisible(true);
    } else {
      try {
        const fs: any = FileSystem; 
        
        const nombreLimpio = doc.nombre.replace(/[^a-zA-Z0-9.]/g, '_');
        
        const directorioBase = fs.cacheDirectory || 'file:///';
        const rutaSegura = `${directorioBase}${nombreLimpio}`; 
        
        await fs.copyAsync({
          from: doc.uri,
          to: rutaSegura
        });

        const puedeCompartir = await Sharing.isAvailableAsync();
        if (puedeCompartir) {
          await Sharing.shareAsync(rutaSegura, {
            mimeType: 'application/pdf',
            dialogTitle: 'Abrir PDF'
          });
        }
      } catch (error: any) {
        console.error("Error detallado:", error);
        Alert.alert("Detalle del Error", error.message || "No se pudo abrir el documento.");
      }
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
        <TarjetaAlerta titulo="Renovación Cámara de Comercio" fecha="31 de Marzo, 2027" estado="advertencia" icono="building" />
        <TarjetaAlerta titulo="Declaración IVA Bimestral" fecha="15 de Septiembre, 2026" estado="urgente" icono="exclamation-triangle" />

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
          {documentos.map((doc, index) => (
            <React.Fragment key={doc.id}>
              <ItemDocumento 
                nombre={doc.nombre} 
                fechaCarga={doc.fechaCarga} 
                alPresionar={() => abrirDocumento(doc)}
              />
              {index < documentos.length - 1 && <View style={styles.divisor} />}
            </React.Fragment>
          ))}
        </View>

      </ScrollView>

      <Modal visible={modalVisible} animationType="slide" transparent={false}>
        <SafeAreaView style={styles.modalContenedor}>
          
          <View style={styles.modalEncabezado}>
            <TouchableOpacity onPress={() => setModalVisible(false)} style={styles.botonVolver}>
              <FontAwesome5 name="times" size={24} color="#333333" />
            </TouchableOpacity>
            <Text style={styles.tituloPantalla} numberOfLines={1} ellipsizeMode="middle">
              {docActual?.nombre || 'Documento'}
            </Text>
            <View style={{ width: 24 }} />
          </View>

          <View style={styles.modalCuerpoVisor}>
            {docActual?.uri && Platform.OS === 'web' ? (
              React.createElement('iframe', {
                src: docActual.uri,
                style: { width: '100%', height: '100%', border: 'none' }
              })
            ) : (
              <View style={styles.modalCuerpoVacio}>
                <FontAwesome5 name="file-pdf" size={80} color="#B0BEC5" />
                <Text style={styles.modalTituloMensaje}>Documento de Prueba</Text>
                <Text style={styles.modalTextoExplicativo}>
                  Este es un documento predeterminado sin archivo físico. Sube un documento real usando el botón de carga para visualizarlo aquí.
                </Text>
              </View>
            )}
          </View>

        </SafeAreaView>
      </Modal>

    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  contenedorPrincipal: { flex: 1, backgroundColor: '#F4F6F8' },
  encabezado: { flexDirection: 'row', alignItems: 'center', justifyContent: 'space-between', backgroundColor: '#FFFFFF', padding: 20, shadowColor: '#000', shadowOffset: { width: 0, height: 2 }, shadowOpacity: 0.05, elevation: 3 },
  botonVolver: { padding: 5 },
  tituloPantalla: { fontSize: 20, fontWeight: 'bold', color: '#00615C', flex: 1, textAlign: 'center', marginHorizontal: 10 },
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
  itemDocumento: { flexDirection: 'row', alignItems: 'center', paddingVertical: 12 },
  infoDocumento: { flex: 1, marginLeft: 15 },
  nombreDocumento: { fontSize: 15, fontWeight: '600', color: '#333333' },
  fechaCarga: { fontSize: 12, color: '#888888', marginTop: 3 },
  botonVer: { backgroundColor: 'rgba(0, 97, 92, 0.1)', padding: 8, borderRadius: 8 },
  divisor: { height: 1, backgroundColor: '#E0E0E0', marginVertical: 5 },
  modalContenedor: { flex: 1, backgroundColor: '#F4F6F8' },
  modalEncabezado: { flexDirection: 'row', alignItems: 'center', justifyContent: 'space-between', backgroundColor: '#FFFFFF', padding: 20, borderBottomWidth: 1, borderBottomColor: '#E0E0E0' },
  modalCuerpoVisor: { flex: 1, backgroundColor: '#E0E0E0' },
  modalCuerpoVacio: { flex: 1, justifyContent: 'center', alignItems: 'center', padding: 30, backgroundColor: '#F4F6F8' },
  modalTituloMensaje: { fontSize: 22, fontWeight: 'bold', color: '#333333', marginTop: 20, marginBottom: 10 },
  modalTextoExplicativo: { fontSize: 16, color: '#666666', textAlign: 'center', marginBottom: 30, lineHeight: 24 }
});