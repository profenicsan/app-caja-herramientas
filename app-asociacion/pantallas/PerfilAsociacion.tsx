import React, { useState, useEffect } from 'react';
import { View, Text, StyleSheet, TouchableOpacity, SafeAreaView, ScrollView, Image, Modal, TextInput, Alert, Platform } from 'react-native';
import { useNavigation } from '@react-navigation/native';
import { FontAwesome5 } from '@expo/vector-icons';
import * as ImagePicker from 'expo-image-picker';

import CargandoPlanta from './CargandoPlanta';

export default function PerfilAsociacion() {
  const navigation = useNavigation<any>();
  const [estaCargando, setEstaCargando] = useState(true);

  // Estado con toda la información institucional
  const [perfil, setPerfil] = useState({
    nombre: 'AgroAsoc Risaralda',
    nit: '900.123.456-7',
    ubicacion: 'Vereda La Florida, Pereira',
    telefono: '+57 320 123 4567',
    correo: 'contacto@agroasoc.com',
    linea: 'Café Especial de Origen',
    asociados: '45 Productores Activos',
    bannerUri: null as string | null,
    logoUri: null as string | null,
  });

  // Estados para el Modal de Edición
  const [modalEdicionVisible, setModalEdicionVisible] = useState(false);
  const [formEdit, setFormEdit] = useState(perfil);

  useEffect(() => {
    const temporizador = setTimeout(() => {
      setEstaCargando(false);
    }, 1200);
    return () => clearTimeout(temporizador);
  }, []);

  // Función para cambiar Banner o Logo desde la galería del dispositivo
  const cambiarImagen = async (tipo: 'banner' | 'logo') => {
    try {
      const resultado = await ImagePicker.launchImageLibraryAsync({
        mediaTypes: ImagePicker.MediaTypeOptions.Images,
        allowsEditing: true,
        aspect: tipo === 'banner' ? [16, 9] : [1, 1],
        quality: 0.8,
      });

      if (!resultado.canceled) {
        const uri = resultado.assets[0].uri;
        setPerfil(prev => ({
          ...prev,
          [tipo === 'banner' ? 'bannerUri' : 'logoUri']: uri
        }));
      }
    } catch (error) {
      Alert.alert("Error", "No se pudo seleccionar la imagen.");
    }
  };

  const guardarCambios = () => {
    setPerfil(formEdit);
    setModalEdicionVisible(false);
    Alert.alert("¡Éxito!", "Los datos de la asociación han sido actualizados.");
  };

  if (estaCargando) {
    return <CargandoPlanta mensaje="Cargando Perfil Institucional..." />;
  }

  return (
    <SafeAreaView style={styles.contenedorPrincipal}>
      
      {/* ENCABEZADO SUPERIOR */}
      <View style={styles.encabezado}>
        <TouchableOpacity onPress={() => navigation.goBack()} style={styles.botonVolver}>
          <FontAwesome5 name="arrow-left" size={20} color="#00615C" />
        </TouchableOpacity>
        <Text style={styles.tituloPantalla}>Perfil Asociación</Text>
        <TouchableOpacity style={styles.botonEditarEncabezado} onPress={() => { setFormEdit(perfil); setModalEdicionVisible(true); }}>
          <FontAwesome5 name="edit" size={18} color="#00615C" />
        </TouchableOpacity>
      </View>

      <ScrollView showsVerticalScrollIndicator={false} contentContainerStyle={styles.scrollContent}>
        <View style={styles.contenedorCentralizado}>
          
          {/* FOTO DE PORTADA / BANNER */}
          <View style={styles.contenedorPortada}>
            {perfil.bannerUri ? (
              <Image source={{ uri: perfil.bannerUri }} style={styles.portadaImagen} />
            ) : (
              <View style={styles.portadaFondo}>
                <FontAwesome5 name="mountain" size={60} color="rgba(255,255,255,0.3)" />
              </View>
            )}
            
            <TouchableOpacity style={styles.botonCambiarBanner} onPress={() => cambiarImagen('banner')}>
              <FontAwesome5 name="camera" size={12} color="#FFF" />
              <Text style={styles.textoBotonCamera}>Cambiar Banner</Text>
            </TouchableOpacity>

            {/* LOGO DE LA ASOCIACIÓN */}
            <TouchableOpacity style={styles.contenedorLogo} onPress={() => cambiarImagen('logo')}>
              {perfil.logoUri ? (
                <Image source={{ uri: perfil.logoUri }} style={styles.logoImagen} />
              ) : (
                <FontAwesome5 name="seedling" size={40} color="#00615C" />
              )}
              <View style={styles.badgeCamaraLogo}>
                <FontAwesome5 name="camera" size={9} color="#FFF" />
              </View>
            </TouchableOpacity>
          </View>

          {/* TARJETA DE INFORMACIÓN PRINCIPAL */}
          <View style={styles.tarjetaInfo}>
            <Text style={styles.nombreAsociacion}>{perfil.nombre}</Text>
            <Text style={styles.etiquetaEstado}>Asociación Activa</Text>

            <View style={styles.divisor} />

            {/* LISTA DE DATOS */}
            <View style={styles.filaDato}>
              <View style={styles.iconoDato}><FontAwesome5 name="id-card" size={18} color="#00615C" /></View>
              <View style={styles.infoTextoDato}>
                <Text style={styles.tituloDato}>NIT</Text>
                <Text style={styles.valorDato}>{perfil.nit}</Text>
              </View>
            </View>

            <View style={styles.filaDato}>
              <View style={styles.iconoDato}><FontAwesome5 name="map-marker-alt" size={18} color="#00615C" /></View>
              <View style={styles.infoTextoDato}>
                <Text style={styles.tituloDato}>Ubicación</Text>
                <Text style={styles.valorDato}>{perfil.ubicacion}</Text>
              </View>
            </View>

            <View style={styles.filaDato}>
              <View style={styles.iconoDato}><FontAwesome5 name="phone-alt" size={18} color="#00615C" /></View>
              <View style={styles.infoTextoDato}>
                <Text style={styles.tituloDato}>Teléfono de Contacto</Text>
                <Text style={styles.valorDato}>{perfil.telefono}</Text>
              </View>
            </View>

            <View style={styles.filaDato}>
              <View style={styles.iconoDato}><FontAwesome5 name="envelope" size={18} color="#00615C" /></View>
              <View style={styles.infoTextoDato}>
                <Text style={styles.tituloDato}>Correo Electrónico</Text>
                <Text style={styles.valorDato}>{perfil.correo}</Text>
              </View>
            </View>

            <View style={styles.filaDato}>
              <View style={styles.iconoDato}><FontAwesome5 name="leaf" size={18} color="#00615C" /></View>
              <View style={styles.infoTextoDato}>
                <Text style={styles.tituloDato}>Línea Productiva Principal</Text>
                <Text style={styles.valorDato}>{perfil.linea}</Text>
              </View>
            </View>

            <View style={styles.filaDato}>
              <View style={styles.iconoDato}><FontAwesome5 name="users" size={18} color="#00615C" /></View>
              <View style={styles.infoTextoDato}>
                <Text style={styles.tituloDato}>Cantidad de Asociados</Text>
                <Text style={styles.valorDato}>{perfil.asociados}</Text>
              </View>
            </View>

            {/* BOTÓN PARA ABRIR MODAL DE EDICIÓN */}
            <TouchableOpacity style={styles.botonModificar} onPress={() => { setFormEdit(perfil); setModalEdicionVisible(true); }}>
              <FontAwesome5 name="edit" size={16} color="#FFF" style={{ marginRight: 8 }} />
              <Text style={styles.textoBotonModificar}>Modificar Datos de la Asociación</Text>
            </TouchableOpacity>

          </View>
        </View>
      </ScrollView>

      {/* MODAL PARA EDITAR DATOS */}
      <Modal visible={modalEdicionVisible} animationType="slide" transparent={true}>
        <View style={styles.modalFondo}>
          <View style={styles.modalTarjeta}>
            <Text style={styles.modalTitulo}>Editar Datos de la Asociación</Text>

            <ScrollView showsVerticalScrollIndicator={false} style={{maxHeight: 400}}>
              <Text style={styles.labelFormulario}>Nombre de la Asociación</Text>
              <TextInput style={styles.input} value={formEdit.nombre} onChangeText={(t) => setFormEdit({...formEdit, nombre: t})} />

              <Text style={styles.labelFormulario}>NIT</Text>
              <TextInput style={styles.input} value={formEdit.nit} onChangeText={(t) => setFormEdit({...formEdit, nit: t})} />

              <Text style={styles.labelFormulario}>Ubicación</Text>
              <TextInput style={styles.input} value={formEdit.ubicacion} onChangeText={(t) => setFormEdit({...formEdit, ubicacion: t})} />

              <Text style={styles.labelFormulario}>Teléfono</Text>
              <TextInput style={styles.input} value={formEdit.telefono} keyboardType="phone-pad" onChangeText={(t) => setFormEdit({...formEdit, telefono: t})} />

              <Text style={styles.labelFormulario}>Correo Electrónico</Text>
              <TextInput style={styles.input} value={formEdit.correo} keyboardType="email-address" autoCapitalize="none" onChangeText={(t) => setFormEdit({...formEdit, correo: t})} />

              <Text style={styles.labelFormulario}>Línea Productiva</Text>
              <TextInput style={styles.input} value={formEdit.linea} onChangeText={(t) => setFormEdit({...formEdit, linea: t})} />

              <Text style={styles.labelFormulario}>Cantidad de Asociados</Text>
              <TextInput style={styles.input} value={formEdit.asociados} onChangeText={(t) => setFormEdit({...formEdit, asociados: t})} />
            </ScrollView>

            <View style={styles.contenedorBotonesForm}>
              <TouchableOpacity style={styles.botonCancelar} onPress={() => setModalEdicionVisible(false)}>
                <Text style={styles.textoBotonCancelar}>Cancelar</Text>
              </TouchableOpacity>
              <TouchableOpacity style={styles.botonGuardar} onPress={guardarCambios}>
                <Text style={styles.textoBotonGuardar}>Guardar Cambios</Text>
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
  encabezado: { flexDirection: 'row', alignItems: 'center', justifyContent: 'space-between', backgroundColor: '#FFFFFF', padding: 20, shadowColor: '#000', shadowOffset: { width: 0, height: 2 }, shadowOpacity: 0.05, elevation: 3, zIndex: 10 },
  botonVolver: { padding: 5 },
  tituloPantalla: { fontSize: 20, fontWeight: 'bold', color: '#00615C' },
  botonEditarEncabezado: { padding: 5 },
  scrollContent: { paddingVertical: 20 },
  contenedorCentralizado: { width: '100%', maxWidth: 700, alignSelf: 'center', paddingHorizontal: 20 },
  contenedorPortada: { alignItems: 'center', marginBottom: 50 },
  portadaFondo: { width: '100%', height: 160, backgroundColor: '#00615C', justifyContent: 'center', alignItems: 'center', borderRadius: 16 },
  portadaImagen: { width: '100%', height: 160, borderRadius: 16 },
  botonCambiarBanner: { position: 'absolute', top: 12, right: 12, backgroundColor: 'rgba(0,0,0,0.6)', flexDirection: 'row', alignItems: 'center', paddingVertical: 6, paddingHorizontal: 12, borderRadius: 20 },
  textoBotonCamera: { color: '#FFF', fontSize: 11, fontWeight: 'bold', marginLeft: 5 },
  contenedorLogo: { width: 90, height: 90, backgroundColor: '#FFFFFF', borderRadius: 45, justifyContent: 'center', alignItems: 'center', position: 'absolute', bottom: -40, shadowColor: '#000', shadowOffset: { width: 0, height: 4 }, shadowOpacity: 0.1, shadowRadius: 6, elevation: 5, borderWidth: 3, borderColor: '#F4F6F8' },
  logoImagen: { width: '100%', height: '100%', borderRadius: 45 },
  badgeCamaraLogo: { position: 'absolute', bottom: 0, right: 0, backgroundColor: '#00615C', width: 22, height: 22, borderRadius: 11, justifyContent: 'center', alignItems: 'center', borderWidth: 2, borderColor: '#FFF' },
  tarjetaInfo: { backgroundColor: '#FFFFFF', borderRadius: 16, padding: 25, shadowColor: '#000', shadowOffset: { width: 0, height: 4 }, shadowOpacity: 0.05, shadowRadius: 10, elevation: 4 },
  nombreAsociacion: { fontSize: 24, fontWeight: 'bold', color: '#333333', textAlign: 'center', marginTop: 15 },
  etiquetaEstado: { backgroundColor: '#E8F5E9', color: '#2E7D32', alignSelf: 'center', paddingHorizontal: 12, paddingVertical: 4, borderRadius: 12, fontSize: 12, fontWeight: 'bold', marginTop: 8, overflow: 'hidden' },
  divisor: { height: 1, backgroundColor: '#E0E0E0', marginVertical: 20 },
  filaDato: { flexDirection: 'row', alignItems: 'center', marginBottom: 20 },
  iconoDato: { width: 40, height: 40, backgroundColor: 'rgba(0, 97, 92, 0.1)', borderRadius: 20, justifyContent: 'center', alignItems: 'center', marginRight: 15 },
  infoTextoDato: { flex: 1 },
  tituloDato: { fontSize: 12, color: '#888888', marginBottom: 2 },
  valorDato: { fontSize: 16, fontWeight: '600', color: '#333333' },
  botonModificar: { flexDirection: 'row', backgroundColor: '#00615C', padding: 15, borderRadius: 12, justifyContent: 'center', alignItems: 'center', marginTop: 10 },
  textoBotonModificar: { color: '#FFF', fontWeight: 'bold', fontSize: 15 },
  modalFondo: { flex: 1, backgroundColor: 'rgba(0,0,0,0.5)', justifyContent: 'center', padding: 20 },
  modalTarjeta: { backgroundColor: '#FFF', borderRadius: 20, padding: 20, shadowColor: '#000', elevation: 10 },
  modalTitulo: { fontSize: 20, fontWeight: 'bold', color: '#00615C', marginBottom: 15, textAlign: 'center' },
  labelFormulario: { fontSize: 13, fontWeight: 'bold', color: '#333', marginBottom: 4, marginTop: 10 },
  input: { backgroundColor: '#F4F6F8', borderRadius: 8, paddingHorizontal: 12, paddingVertical: 10, fontSize: 14, color: '#333', borderWidth: 1, borderColor: '#E0E0E0' },
  contenedorBotonesForm: { flexDirection: 'row', justifyContent: 'space-between', marginTop: 20 },
  botonCancelar: { flex: 1, padding: 12, borderRadius: 8, backgroundColor: '#F4F6F8', marginRight: 10, alignItems: 'center' },
  textoBotonCancelar: { color: '#666', fontWeight: 'bold' },
  botonGuardar: { flex: 1, padding: 12, borderRadius: 8, backgroundColor: '#00615C', marginLeft: 10, alignItems: 'center' },
  textoBotonGuardar: { color: '#FFF', fontWeight: 'bold' }
});