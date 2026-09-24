import React from 'react';
import { View, Text, StyleSheet, TouchableOpacity, SafeAreaView, ScrollView } from 'react-native';
import { useNavigation } from '@react-navigation/native';
import { FontAwesome5 } from '@expo/vector-icons';

export default function PanelProductor() {
  const navigation = useNavigation<any>();
  const nombreProductor = "Juan Pérez"; // Esto vendrá luego del login conectado a SQL

  return (
    <SafeAreaView style={styles.contenedorPrincipal}>
      
      {/* ENCABEZADO Y SALUDO */}
      <View style={styles.encabezadoPerfil}>
        <View style={styles.infoUsuario}>
          <View style={styles.avatar}>
            <FontAwesome5 name="user-alt" size={24} color="#00615C" />
          </View>
          <View>
            <Text style={styles.saludo}>¡Hola de nuevo,</Text>
            <Text style={styles.nombre}>{nombreProductor}!</Text>
          </View>
        </View>
        <View style={styles.iconosDerecha}>
          {/* Botón temporal para cerrar sesión y volver al login */}
          <TouchableOpacity onPress={() => navigation.navigate('login')} style={{ marginRight: 15 }}>
            <FontAwesome5 name="sign-out-alt" size={20} color="#D32F2F" />
          </TouchableOpacity>
          <TouchableOpacity style={styles.botonCampana}>
            <FontAwesome5 name="bell" size={22} color="#00615C" />
            <View style={styles.puntoNotificacion} />
          </TouchableOpacity>
        </View>
      </View>

      <ScrollView style={styles.scrollArea} showsVerticalScrollIndicator={false}>
        
        {/* TARJETA DE ESTADO ACTUAL */}
        <View style={styles.tarjetaResumen}>
          <View style={styles.filaResumen}>
            <FontAwesome5 name="leaf" size={24} color="#2E7D32" />
            <Text style={styles.tituloResumen}>Mi Cultivo Actual</Text>
          </View>
          <Text style={styles.datoResumen}>Plátano Verde - Finca La Esperanza</Text>
          <View style={styles.barraProgresoFondo}>
            <View style={[styles.barraProgresoLleno, { width: '70%' }]} />
          </View>
          <Text style={styles.textoProgreso}>Etapa: Mantenimiento (70% hacia cosecha)</Text>
        </View>

        <Text style={styles.tituloSeccion}>¿Qué necesitas hacer hoy?</Text>

        {/* CUADRÍCULA DE ACCIONES RÁPIDAS */}
        <View style={styles.cuadriculaAcciones}>
          
          <TouchableOpacity style={styles.tarjetaAccion}>
            <View style={[styles.iconoAccionFondo, { backgroundColor: '#E8F5E9' }]}>
              <FontAwesome5 name="chart-line" size={24} color="#2E7D32" />
            </View>
            <Text style={styles.textoAccion}>Precios de{'\n'}Mercado</Text>
          </TouchableOpacity>

          <TouchableOpacity style={styles.tarjetaAccion}>
            <View style={[styles.iconoAccionFondo, { backgroundColor: '#E3F2FD' }]}>
              <FontAwesome5 name="hands-helping" size={24} color="#1565C0" />
            </View>
            <Text style={styles.textoAccion}>Solicitar{'\n'}Insumos</Text>
          </TouchableOpacity>

          {/* BOTÓN CONECTADO A LA INTELIGENCIA ARTIFICIAL */}
          <TouchableOpacity style={styles.tarjetaAccion} onPress={() => navigation.navigate('AsistenteIA')}>
            <View style={[styles.iconoAccionFondo, { backgroundColor: '#FFF3E0' }]}>
              <FontAwesome5 name="robot" size={24} color="#E65100" />
            </View>
            <Text style={styles.textoAccion}>Asistente{'\n'}Agrícola IA</Text>
          </TouchableOpacity>

          <TouchableOpacity style={styles.tarjetaAccion}>
            <View style={[styles.iconoAccionFondo, { backgroundColor: '#F3E5F5' }]}>
              <FontAwesome5 name="calendar-check" size={24} color="#6A1B9A" />
            </View>
            <Text style={styles.textoAccion}>Mis{'\n'}Entregas</Text>
          </TouchableOpacity>

        </View>

        {/* NOTICIA O AVISO DE LA ASOCIACIÓN */}
        <View style={styles.tarjetaAviso}>
          <View style={styles.avisoDecoracion} />
          <View style={styles.avisoContenido}>
            <Text style={styles.avisoTitulo}>Aviso de la Asociación</Text>
            <Text style={styles.avisoTexto}>
              Recuerde que el próximo viernes es la jornada de acopio de empaques vacíos en la sede principal.
            </Text>
          </View>
        </View>
        
        <View style={{ height: 40 }} />
      </ScrollView>

    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  contenedorPrincipal: { flex: 1, backgroundColor: '#F4F6F8' },
  encabezadoPerfil: { flexDirection: 'row', justifyContent: 'space-between', alignItems: 'center', backgroundColor: '#FFF', paddingHorizontal: 20, paddingTop: 30, paddingBottom: 20, borderBottomWidth: 1, borderColor: '#E0E0E0' },
  infoUsuario: { flexDirection: 'row', alignItems: 'center' },
  avatar: { width: 50, height: 50, borderRadius: 25, backgroundColor: 'rgba(0, 97, 92, 0.1)', justifyContent: 'center', alignItems: 'center', marginRight: 15 },
  saludo: { fontSize: 14, color: '#666' },
  nombre: { fontSize: 20, fontWeight: 'bold', color: '#00615C' },
  iconosDerecha: { flexDirection: 'row', alignItems: 'center' },
  botonCampana: { padding: 5, position: 'relative' },
  puntoNotificacion: { position: 'absolute', top: 3, right: 5, width: 10, height: 10, borderRadius: 5, backgroundColor: '#D32F2F', borderWidth: 2, borderColor: '#FFF' },
  
  scrollArea: { flex: 1, paddingHorizontal: 20, paddingTop: 20 },
  
  tarjetaResumen: { backgroundColor: '#FFF', borderRadius: 16, padding: 20, marginBottom: 25, shadowColor: '#000', shadowOpacity: 0.05, shadowRadius: 8, elevation: 3 },
  filaResumen: { flexDirection: 'row', alignItems: 'center', marginBottom: 10 },
  tituloResumen: { fontSize: 16, fontWeight: 'bold', color: '#333', marginLeft: 10 },
  datoResumen: { fontSize: 14, color: '#666', marginBottom: 15 },
  barraProgresoFondo: { height: 8, backgroundColor: '#E0E0E0', borderRadius: 4, marginBottom: 8 },
  barraProgresoLleno: { height: 8, backgroundColor: '#2E7D32', borderRadius: 4 },
  textoProgreso: { fontSize: 12, color: '#888', fontWeight: 'bold' },

  tituloSeccion: { fontSize: 18, fontWeight: 'bold', color: '#333', marginBottom: 15 },
  cuadriculaAcciones: { flexDirection: 'row', flexWrap: 'wrap', justifyContent: 'space-between', marginBottom: 20 },
  tarjetaAccion: { width: '48%', backgroundColor: '#FFF', borderRadius: 16, padding: 20, alignItems: 'center', marginBottom: 15, shadowColor: '#000', shadowOpacity: 0.03, shadowRadius: 5, elevation: 2 },
  iconoAccionFondo: { width: 56, height: 56, borderRadius: 28, justifyContent: 'center', alignItems: 'center', marginBottom: 10 },
  textoAccion: { fontSize: 14, fontWeight: 'bold', color: '#333', textAlign: 'center' },

  tarjetaAviso: { flexDirection: 'row', backgroundColor: '#FFF', borderRadius: 12, overflow: 'hidden', shadowColor: '#000', shadowOpacity: 0.05, shadowRadius: 5, elevation: 2 },
  avisoDecoracion: { width: 6, backgroundColor: '#F57C00' },
  avisoContenido: { flex: 1, padding: 15 },
  avisoTitulo: { fontSize: 14, fontWeight: 'bold', color: '#F57C00', marginBottom: 5 },
  avisoTexto: { fontSize: 13, color: '#666', lineHeight: 18 }
});