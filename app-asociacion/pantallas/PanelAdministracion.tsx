import React, { useState } from 'react';
import { View, Text, StyleSheet, TouchableOpacity, SafeAreaView, Dimensions, Image } from 'react-native';
import { useNavigation } from '@react-navigation/native';
import { FontAwesome5 } from '@expo/vector-icons';

const { width } = Dimensions.get('window');
const esMovil = width < 768;

const OpcionMenu = ({ icono, texto, accion, colorIcono = "#00615C" }: any) => (
  <TouchableOpacity style={styles.botonMenu} onPress={accion}>
    <View style={styles.contenedorIcono}>
      <FontAwesome5 name={icono} size={20} color={colorIcono} />
    </View>
    <Text style={styles.textoMenu}>{texto}</Text>
  </TouchableOpacity>
);

export default function PanelAdministrador() {
  const navigation = useNavigation<any>();
  const [menuAbierto, setMenuAbierto] = useState(!esMovil); 

  const alternarMenu = () => setMenuAbierto(!menuAbierto);

  const cerrarSesion = () => {
    navigation.navigate('login');
  };

  return (
    <SafeAreaView style={styles.contenedorPrincipal}>
      
      {/* MENÚ LATERAL DESPLEGABLE */}
      {menuAbierto && (
        <View style={[styles.menuLateral, esMovil && styles.menuLateralMovil]}>
          <View style={styles.seccionSuperior}>
            <View style={styles.contenedorLogo}>
              <FontAwesome5 name="seedling" size={28} color="#00615C" />
              <Text style={styles.tituloSidebar}>AgroAsoc</Text>
              {esMovil && (
                <TouchableOpacity onPress={alternarMenu} style={{ position: 'absolute', right: 0 }}>
                  <FontAwesome5 name="times" size={24} color="#333333" />
                </TouchableOpacity>
              )}
            </View>
            
            {/* RUTAS CONECTADAS */}
            <OpcionMenu icono="id-card" texto="Perfil Asociación" accion={() => navigation.navigate('PerfilAsociacion')} />
            <OpcionMenu icono="users" texto="Productores" accion={() => navigation.navigate('ListaProductores')} />
            <OpcionMenu icono="file-invoice-dollar" texto="Transacciones y Costos" accion={() => navigation.navigate('TransaccionesCostos')} />
            <OpcionMenu icono="building" texto="Bóveda y Legal DIAN" accion={() => navigation.navigate('ModuloTributario')} />
            
            {/* RUTAS PENDIENTES */}
            <OpcionMenu icono="tractor" texto="Inventario Productivo" />
            <OpcionMenu icono="bullhorn" texto="Mercadeo" />
          </View>

          <View style={styles.seccionInferior}>
            <View style={styles.divisor} />
            <OpcionMenu icono="headset" texto="Soporte" />
            <OpcionMenu icono="sign-out-alt" texto="Salir" accion={cerrarSesion} colorIcono="#D32F2F" />
          </View>
        </View>
      )}

      {/* ÁREA CENTRAL */}
      <View style={styles.areaCentral}>
        
        {/* Encabezado con Botón Hamburguesa */}
        <View style={styles.encabezado}>
          {esMovil && (
            <TouchableOpacity onPress={alternarMenu} style={styles.botonHamburguesa}>
              <FontAwesome5 name="bars" size={24} color="#00615C" />
            </TouchableOpacity>
          )}
          <View style={styles.iconosDerecha}>
            <TouchableOpacity style={styles.iconoEncabezado}>
              <FontAwesome5 name="envelope" size={24} color="#00615C" />
            </TouchableOpacity>
            <TouchableOpacity style={styles.iconoEncabezado}>
              <FontAwesome5 name="bell" size={24} color="#00615C" />
            </TouchableOpacity>
          </View>
        </View>

        <View style={styles.banner}>
          <FontAwesome5 name="image" size={50} color="#B0BEC5" />
          <Text style={styles.textoBanner}>Espacio para Banner Institucional</Text>
        </View>

        <View style={styles.contenedorBienvenida}>
          <Text style={styles.textoBienvenida}>¡BIENVENIDO!</Text>
          <Text style={styles.subtextoBienvenida}>Selecciona una opción del menú para comenzar.</Text>
        </View>

        {/* FRANJA INSTITUCIONAL INFERIOR */}
        <View style={styles.franjaInstitucional}>
          <Image 
            source={require('../assets/logo-utp-epsea.png')} 
            style={styles.imagenLogos}
            resizeMode="contain"
          />
        </View>

      </View>
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  contenedorPrincipal: { flex: 1, flexDirection: 'row', backgroundColor: '#F4F6F8' },
  menuLateral: { width: 250, backgroundColor: '#FFFFFF', paddingVertical: 20, paddingHorizontal: 15, justifyContent: 'space-between', elevation: 5, zIndex: 10 },
  menuLateralMovil: { position: 'absolute', height: '100%', left: 0, top: 0 },
  seccionSuperior: { flex: 1 },
  contenedorLogo: { flexDirection: 'row', alignItems: 'center', justifyContent: 'center', marginBottom: 30, position: 'relative' },
  tituloSidebar: { fontSize: 24, fontWeight: 'bold', color: '#00615C', marginLeft: 10 },
  botonMenu: { flexDirection: 'row', alignItems: 'center', paddingVertical: 12, marginBottom: 10, borderRadius: 8 },
  contenedorIcono: { width: 30, alignItems: 'center', marginRight: 15 },
  textoMenu: { fontSize: 15, color: '#333333', fontWeight: '500' },
  seccionInferior: { paddingBottom: 10 },
  divisor: { height: 1, backgroundColor: '#E0E0E0', marginBottom: 15 },
  areaCentral: { flex: 1, padding: 20, justifyContent: 'space-between' },
  encabezado: { flexDirection: 'row', justifyContent: 'space-between', alignItems: 'center', marginBottom: 20 },
  botonHamburguesa: { padding: 5 },
  iconosDerecha: { flexDirection: 'row', flex: 1, justifyContent: 'flex-end' },
  iconoEncabezado: { marginLeft: 20, padding: 5 },
  banner: { height: 150, backgroundColor: '#E0E0E0', borderRadius: 16, justifyContent: 'center', alignItems: 'center', marginBottom: 20 },
  textoBanner: { color: '#666666', marginTop: 10 },
  contenedorBienvenida: { flex: 1, alignItems: 'center', justifyContent: 'center' },
  textoBienvenida: { fontSize: esMovil ? 32 : 48, fontWeight: 'bold', color: '#00615C', marginBottom: 15, textAlign: 'center' },
  subtextoBienvenida: { fontSize: 16, color: '#666666', textAlign: 'center' },
  franjaInstitucional: { 
    backgroundColor: '#00615C', 
    borderRadius: 12, 
    padding: 10, 
    justifyContent: 'center', 
    alignItems: 'center', 
    marginTop: 20,
    height: 80 
  },
  imagenLogos: {
    width: '100%',
    height: '100%'
  }
});