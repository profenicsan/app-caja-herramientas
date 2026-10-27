import React, { useState, useEffect } from 'react';
import { View, Text, StyleSheet, TouchableOpacity, SafeAreaView, ScrollView, TextInput, Modal, Image, Alert } from 'react-native';
import { useNavigation } from '@react-navigation/native';
import { FontAwesome5 } from '@expo/vector-icons';
import * as ImagePicker from 'expo-image-picker'; 

import CargandoPlanta from './CargandoPlanta';

export default function ListaProductores() {
  const navigation = useNavigation<any>();
  const [estaCargando, setEstaCargando] = useState(true);
  
  // EL ARREGLO: Agregamos <any[]> para que TypeScript no sea tan estricto con los tipos
  const [productores, setProductores] = useState<any[]>([
    { id: '1', nombre: 'Carlos Ramírez', etapa: 'Cosecha', telefono: '311 000 0000', correo: 'carlos@agro.com', finca: 'El Mirador', hectareas: '5', vereda: 'La Florida', fotoUri: null },
    { id: '2', nombre: 'María Gómez', etapa: 'Siembra', telefono: '312 000 0000', correo: 'maria@agro.com', finca: 'La Esperanza', hectareas: '3.5', vereda: 'El Cedral', fotoUri: null }
  ]);

  const [modalVisible, setModalVisible] = useState(false);
  
  const [nuevoNombre, setNuevoNombre] = useState('');
  const [nuevoTelefono, setNuevoTelefono] = useState('');
  const [nuevoCorreo, setNuevoCorreo] = useState('');
  const [nuevaFinca, setNuevaFinca] = useState('');
  const [nuevasHectareas, setNuevasHectareas] = useState('');
  const [nuevaVereda, setNuevaVereda] = useState('');
  const [nuevaEtapa, setNuevaEtapa] = useState('Preparación');
  const [nuevaFoto, setNuevaFoto] = useState<string | null>(null); 

  const etapasDisponibles = ['Preparación', 'Siembra', 'Mantenimiento', 'Cosecha'];

  useEffect(() => {
    const temporizador = setTimeout(() => {
      setEstaCargando(false);
    }, 1200);
    return () => clearTimeout(temporizador);
  }, []);

  const seleccionarFoto = async () => {
    try {
      const resultado = await ImagePicker.launchImageLibraryAsync({
        mediaTypes: ImagePicker.MediaTypeOptions.Images,
        allowsEditing: true,
        aspect: [1, 1],
        quality: 0.8,
      });

      if (!resultado.canceled) {
        setNuevaFoto(resultado.assets[0].uri);
      }
    } catch (error) {
      Alert.alert("Error", "No se pudo seleccionar la imagen.");
    }
  };

  const guardarProductor = () => {
    if (nuevoNombre.trim() === '') return;

    const nuevoRegistro = {
      id: Date.now().toString(),
      nombre: nuevoNombre,
      telefono: nuevoTelefono,
      correo: nuevoCorreo,
      finca: nuevaFinca,
      hectareas: nuevasHectareas,
      vereda: nuevaVereda,
      etapa: nuevaEtapa,
      fotoUri: nuevaFoto 
    };

    setProductores([nuevoRegistro, ...productores]);
    
    setNuevoNombre('');
    setNuevoTelefono('');
    setNuevoCorreo('');
    setNuevaFinca('');
    setNuevasHectareas('');
    setNuevaVereda('');
    setNuevaEtapa('Preparación');
    setNuevaFoto(null);
    setModalVisible(false);
  };

  if (estaCargando) {
    return <CargandoPlanta mensaje="Cargando Directorio de Productores..." />;
  }

  return (
    <SafeAreaView style={styles.contenedorPrincipal}>
      
      <View style={styles.encabezado}>
        <TouchableOpacity onPress={() => navigation.goBack()} style={styles.botonVolver}>
          <FontAwesome5 name="arrow-left" size={20} color="#00615C" />
        </TouchableOpacity>
        <Text style={styles.tituloPantalla}>Productores</Text>
        <View style={{ width: 20 }} /> 
      </View>

      <ScrollView style={styles.scrollArea} contentContainerStyle={styles.scrollContent}>
        <View style={styles.contenedorCentralizado}>
          <Text style={styles.resumenTexto}>Total de asociados: {productores.length}</Text>

          {productores.map((prod) => (
            <View key={prod.id} style={styles.tarjetaProductor}>
              <View style={styles.infoPrincipal}>
                
                <View style={[styles.avatar, prod.fotoUri ? {backgroundColor: 'transparent'} : {}]}>
                  {prod.fotoUri ? (
                    <Image source={{ uri: prod.fotoUri }} style={styles.imagenAvatar} />
                  ) : (
                    <FontAwesome5 name="user-alt" size={20} color="#00615C" />
                  )}
                </View>

                <View style={{ flex: 1 }}>
                  <Text style={styles.nombreProductor}>{prod.nombre}</Text>
                  <Text style={styles.etiquetaEtapa}>Etapa: {prod.etapa}</Text>
                </View>
              </View>
              
              <View style={styles.divisor} />
              
              <View style={styles.infoContacto}>
                <Text style={styles.textoContacto}><FontAwesome5 name="home" size={12} color="#00615C" /> Finca {prod.finca} ({prod.hectareas} ha)</Text>
                <Text style={styles.textoContacto}><FontAwesome5 name="map-marker-alt" size={12} color="#00615C" /> {prod.vereda}</Text>
              </View>

              <View style={[styles.divisor, { marginVertical: 8 }]} />

              <View style={styles.infoContacto}>
                <Text style={styles.textoContacto}><FontAwesome5 name="phone" size={12} color="#888" /> {prod.telefono}</Text>
                <Text style={styles.textoContacto}><FontAwesome5 name="envelope" size={12} color="#888" /> {prod.correo}</Text>
              </View>
            </View>
          ))}
        </View>
        <View style={{ height: 80 }} />
      </ScrollView>

      <TouchableOpacity style={styles.botonFlotante} onPress={() => setModalVisible(true)}>
        <FontAwesome5 name="plus" size={24} color="#FFF" />
      </TouchableOpacity>

      <Modal visible={modalVisible} animationType="slide" transparent={true}>
        <View style={styles.modalFondo}>
          <View style={styles.modalTarjeta}>
            <Text style={styles.modalTitulo}>Registrar Productor</Text>
            
            <ScrollView showsVerticalScrollIndicator={false} style={{ maxHeight: 400 }}>
              
              <View style={styles.contenedorFotoFormulario}>
                <TouchableOpacity onPress={seleccionarFoto} style={styles.botonFotoFormulario}>
                  {nuevaFoto ? (
                    <Image source={{ uri: nuevaFoto }} style={styles.fotoFormulario} />
                  ) : (
                    <FontAwesome5 name="user-plus" size={30} color="#00615C" />
                  )}
                  <View style={styles.badgeCamaraForm}>
                    <FontAwesome5 name="camera" size={12} color="#FFF" />
                  </View>
                </TouchableOpacity>
                <Text style={styles.textoHintFoto}>{nuevaFoto ? 'Cambiar Foto' : 'Agregar Foto'}</Text>
              </View>

              <Text style={styles.labelFormulario}>Nombre Completo</Text>
              <TextInput style={styles.input} placeholder="Ej. Juan Pérez" value={nuevoNombre} onChangeText={setNuevoNombre} />

              <Text style={styles.labelFormulario}>Nombre de la Finca</Text>
              <TextInput style={styles.input} placeholder="Ej. La Bendición" value={nuevaFinca} onChangeText={setNuevaFinca} />

              <View style={styles.filaDobleInput}>
                <View style={{ flex: 1, marginRight: 10 }}>
                  <Text style={styles.labelFormulario}>Hectáreas</Text>
                  <TextInput style={styles.input} placeholder="Ej. 2.5" keyboardType="numeric" value={nuevasHectareas} onChangeText={setNuevasHectareas} />
                </View>
                <View style={{ flex: 1 }}>
                  <Text style={styles.labelFormulario}>Vereda</Text>
                  <TextInput style={styles.input} placeholder="Ej. La Florida" value={nuevaVereda} onChangeText={setNuevaVereda} />
                </View>
              </View>

              <Text style={styles.labelFormulario}>Teléfono</Text>
              <TextInput style={styles.input} placeholder="Ej. 300 000 0000" keyboardType="phone-pad" value={nuevoTelefono} onChangeText={setNuevoTelefono} />

              <Text style={styles.labelFormulario}>Correo Electrónico</Text>
              <TextInput style={styles.input} placeholder="ejemplo@correo.com" keyboardType="email-address" autoCapitalize="none" value={nuevoCorreo} onChangeText={setNuevoCorreo} />

              <Text style={styles.labelFormulario}>Etapa Productiva Actual</Text>
              <View style={styles.contenedorEtiquetas}>
                {etapasDisponibles.map((etapa) => (
                  <TouchableOpacity 
                    key={etapa} 
                    style={[styles.etiquetaBoton, nuevaEtapa === etapa && styles.etiquetaActiva]} 
                    onPress={() => setNuevaEtapa(etapa)}
                  >
                    <Text style={[styles.textoEtiqueta, nuevaEtapa === etapa && styles.textoEtiquetaActiva]}>{etapa}</Text>
                  </TouchableOpacity>
                ))}
              </View>
            </ScrollView>

            <View style={styles.contenedorBotonesForm}>
              <TouchableOpacity style={styles.botonCancelar} onPress={() => setModalVisible(false)}>
                <Text style={styles.textoBotonCancelar}>Cancelar</Text>
              </TouchableOpacity>
              <TouchableOpacity style={styles.botonGuardar} onPress={guardarProductor}>
                <Text style={styles.textoBotonGuardar}>Guardar</Text>
              </TouchableOpacity>
            </View>

          </View>
        </View>
      </Modal>

    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  contenedorPrincipal: { flex: 1, backgroundColor: '#F4F6F8' },
  encabezado: { flexDirection: 'row', alignItems: 'center', justifyContent: 'space-between', backgroundColor: '#FFFFFF', padding: 20, shadowColor: '#000', shadowOffset: { width: 0, height: 2 }, shadowOpacity: 0.05, elevation: 3 },
  botonVolver: { padding: 5 },
  tituloPantalla: { fontSize: 20, fontWeight: 'bold', color: '#00615C' },
  scrollArea: { flex: 1 },
  scrollContent: { paddingVertical: 20 },
  contenedorCentralizado: { width: '100%', maxWidth: 700, alignSelf: 'center', paddingHorizontal: 20 },
  resumenTexto: { fontSize: 14, color: '#666', marginBottom: 15, fontWeight: 'bold' },
  tarjetaProductor: { backgroundColor: '#FFFFFF', borderRadius: 12, padding: 15, marginBottom: 15, shadowColor: '#000', shadowOffset: { width: 0, height: 2 }, shadowOpacity: 0.05, elevation: 2 },
  infoPrincipal: { flexDirection: 'row', alignItems: 'center' },
  avatar: { width: 45, height: 45, backgroundColor: 'rgba(0, 97, 92, 0.1)', borderRadius: 25, justifyContent: 'center', alignItems: 'center', marginRight: 15 },
  imagenAvatar: { width: 45, height: 45, borderRadius: 25 },
  nombreProductor: { fontSize: 16, fontWeight: 'bold', color: '#333' },
  etiquetaEtapa: { fontSize: 12, color: '#F57C00', fontWeight: 'bold', marginTop: 3 },
  divisor: { height: 1, backgroundColor: '#E0E0E0', marginVertical: 12 },
  infoContacto: { flexDirection: 'row', justifyContent: 'space-between', alignItems: 'center' },
  textoContacto: { fontSize: 12, color: '#666' },
  botonFlotante: { position: 'absolute', bottom: 30, right: 25, width: 60, height: 60, backgroundColor: '#00615C', borderRadius: 30, justifyContent: 'center', alignItems: 'center', elevation: 5, shadowColor: '#000', shadowOffset: { width: 0, height: 4 }, shadowOpacity: 0.3, shadowRadius: 4 },
  
  modalFondo: { flex: 1, backgroundColor: 'rgba(0,0,0,0.5)', justifyContent: 'flex-end' },
  modalTarjeta: { backgroundColor: '#FFF', borderTopLeftRadius: 20, borderTopRightRadius: 20, padding: 25, paddingBottom: 35, shadowColor: '#000', elevation: 10 },
  modalTitulo: { fontSize: 20, fontWeight: 'bold', color: '#00615C', marginBottom: 15, textAlign: 'center' },
  contenedorFotoFormulario: { alignItems: 'center', marginBottom: 15, marginTop: 5 },
  botonFotoFormulario: { width: 80, height: 80, backgroundColor: 'rgba(0, 97, 92, 0.05)', borderRadius: 40, justifyContent: 'center', alignItems: 'center', borderWidth: 2, borderColor: '#00615C', borderStyle: 'dashed' },
  fotoFormulario: { width: '100%', height: '100%', borderRadius: 40 },
  badgeCamaraForm: { position: 'absolute', bottom: 0, right: -5, backgroundColor: '#00615C', width: 26, height: 26, borderRadius: 13, justifyContent: 'center', alignItems: 'center', borderWidth: 2, borderColor: '#FFF' },
  textoHintFoto: { fontSize: 12, color: '#00615C', fontWeight: 'bold', marginTop: 8 },
  labelFormulario: { fontSize: 13, fontWeight: 'bold', color: '#333', marginBottom: 5, marginTop: 12 },
  input: { backgroundColor: '#F4F6F8', borderRadius: 8, paddingHorizontal: 15, paddingVertical: 12, fontSize: 14, color: '#333', borderWidth: 1, borderColor: '#E0E0E0' },
  filaDobleInput: { flexDirection: 'row', justifyContent: 'space-between' },
  contenedorEtiquetas: { flexDirection: 'row', flexWrap: 'wrap', marginTop: 5 },
  etiquetaBoton: { backgroundColor: '#F4F6F8', paddingHorizontal: 12, paddingVertical: 8, borderRadius: 20, marginRight: 10, marginBottom: 10, borderWidth: 1, borderColor: '#E0E0E0' },
  etiquetaActiva: { backgroundColor: '#00615C', borderColor: '#00615C' },
  textoEtiqueta: { fontSize: 12, color: '#666' },
  textoEtiquetaActiva: { color: '#FFF', fontWeight: 'bold' },
  contenedorBotonesForm: { flexDirection: 'row', justifyContent: 'space-between', marginTop: 20 },
  botonCancelar: { flex: 1, padding: 15, borderRadius: 8, backgroundColor: '#F4F6F8', marginRight: 10, alignItems: 'center' },
  textoBotonCancelar: { color: '#666', fontWeight: 'bold' },
  botonGuardar: { flex: 1, padding: 15, borderRadius: 8, backgroundColor: '#00615C', marginLeft: 10, alignItems: 'center' },
  textoBotonGuardar: { color: '#FFF', fontWeight: 'bold' }
});