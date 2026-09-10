import React from 'react';
import { View, Text, StyleSheet, TouchableOpacity, SafeAreaView } from 'react-native';
import { useNavigation } from '@react-navigation/native';
import { FontAwesome5 } from '@expo/vector-icons';

// Componente reutilizable para los botones del menú
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

  const cerrarSesion = () => {
    navigation.navigate('login');
  };

  return (
    <SafeAreaView style={styles.contenedorPrincipal}>
      
      {/* 1. MENÚ LATERAL (Sidebar) */}
      <View style={styles.menuLateral}>
        <View style={styles.seccionSuperior}>
          
          {/* Contenedor que agrupa el ícono y el título en fila */}
          <View style={styles.contenedorLogo}>
            <FontAwesome5 name="seedling" size={28} color="#00615C" />
            <Text style={styles.tituloSidebar}>AgroAsoc</Text>
          </View>
          
          {/* Opciones del menú adaptadas al nuevo esquema */}
          <OpcionMenu icono="id-card" texto="Perfil Asociación" />
          <OpcionMenu icono="users" texto="Productores" />
          <OpcionMenu icono="tractor" texto="Inventario Productivo" />
          
          {/* Módulos Financieros y Legales */}
          <OpcionMenu icono="file-invoice-dollar" texto="Transacciones y Costos" />
          <OpcionMenu 
            icono="building" 
            texto="Bóveda y Legal DIAN" 
            accion={() => navigation.navigate('ModuloTributario')} 
          />
          
          <OpcionMenu icono="bullhorn" texto="Mercadeo" />
        </View>

        <View style={styles.seccionInferior}>
          <View style={styles.divisor} />
          <OpcionMenu icono="headset" texto="Soporte" />
          <OpcionMenu icono="sign-out-alt" texto="Salir" accion={cerrarSesion} colorIcono="#D32F2F" />
        </View>
      </View>

      {/* 2. ÁREA CENTRAL (Main Content) */}
      <View style={styles.areaCentral}>
        
        {/* Encabezado con notificaciones */}
        <View style={styles.encabezado}>
          <TouchableOpacity style={styles.iconoEncabezado}>
            <FontAwesome5 name="envelope" size={24} color="#00615C" />
          </TouchableOpacity>
          <TouchableOpacity style={styles.iconoEncabezado}>
            <FontAwesome5 name="bell" size={24} color="#00615C" />
          </TouchableOpacity>
        </View>

        {/* Banner principal */}
        <View style={styles.banner}>
          <FontAwesome5 name="image" size={50} color="#B0BEC5" />
          <Text style={styles.textoBanner}>Espacio para Banner Institucional</Text>
        </View>

        {/* Mensaje de Bienvenida */}
        <View style={styles.contenedorBienvenida}>
          <Text style={styles.textoBienvenida}>¡BIENVENIDO!</Text>
          <Text style={styles.subtextoBienvenida}>Selecciona una opción del menú para comenzar a gestionar tu asociación.</Text>
        </View>

      </View>

    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  contenedorPrincipal: {
    flex: 1,
    flexDirection: 'row',
    backgroundColor: '#F4F6F8', 
  },
  menuLateral: {
    width: 250,
    backgroundColor: '#FFFFFF',
    paddingVertical: 20,
    paddingHorizontal: 15,
    justifyContent: 'space-between',
    shadowColor: '#000',
    shadowOffset: { width: 4, height: 0 },
    shadowOpacity: 0.05,
    shadowRadius: 10,
    elevation: 5,
  },
  seccionSuperior: {
    flex: 1,
  },
  contenedorLogo: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'center',
    marginBottom: 30,
  },
  tituloSidebar: {
    fontSize: 24,
    fontWeight: 'bold',
    color: '#00615C',
    marginLeft: 10, 
  },
  botonMenu: {
    flexDirection: 'row',
    alignItems: 'center',
    paddingVertical: 12,
    marginBottom: 10,
    borderRadius: 8,
  },
  contenedorIcono: {
    width: 30,
    alignItems: 'center',
    marginRight: 15,
  },
  textoMenu: {
    fontSize: 15,
    color: '#333333',
    fontWeight: '500',
  },
  seccionInferior: {
    paddingBottom: 10,
  },
  divisor: {
    height: 1,
    backgroundColor: '#E0E0E0',
    marginBottom: 15,
  },
  areaCentral: {
    flex: 1,
    padding: 30,
  },
  encabezado: {
    flexDirection: 'row',
    justifyContent: 'flex-end',
    marginBottom: 20,
  },
  iconoEncabezado: {
    marginLeft: 20,
    padding: 5,
  },
  banner: {
    height: 200,
    backgroundColor: '#E0E0E0', 
    borderRadius: 16,
    justifyContent: 'center',
    alignItems: 'center',
    marginBottom: 40,
  },
  textoBanner: {
    color: '#666666',
    marginTop: 10,
  },
  contenedorBienvenida: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
  },
  textoBienvenida: {
    fontSize: 48,
    fontWeight: 'bold',
    color: '#00615C',
    marginBottom: 15,
  },
  subtextoBienvenida: {
    fontSize: 16,
    color: '#666666',
  }
});