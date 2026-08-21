import React, { useState } from 'react';
import { View, Text, TextInput, TouchableOpacity, StyleSheet, Alert } from 'react-native';

export default function Login({ navigation }: any) {
  const [cedula, setCedula] = useState('');
  const [pin, setPin] = useState('');

  const manejarLogin = () => {
    // Para el prototipo rápido de la próxima semana, haremos una validación local temporal.
    // Más adelante conectaremos esto a la base de datos real.
    if (cedula === '123456789' && pin === '1234') {
      // Si los datos son correctos, navegamos a la pantalla principal
      navigation.replace('Productores');
    } else {
      Alert.alert('Error', 'Cédula o PIN incorrectos');
    }
  };

  return (
    <View style={styles.container}>
      <View style={styles.cajaLogo}>
        <Text style={styles.logoTexto}>Caja de Herramientas</Text>
        <Text style={styles.subtitulo}>Acceso para Productores</Text>
      </View>

      <View style={styles.formulario}>
        <Text style={styles.label}>Cédula</Text>
        <TextInput
          style={styles.input}
          placeholder="Ej: 123456789"
          keyboardType="numeric"
          value={cedula}
          onChangeText={setCedula}
        />

        <Text style={styles.label}>PIN de seguridad</Text>
        <TextInput
          style={styles.input}
          placeholder="****"
          keyboardType="numeric"
          secureTextEntry // Esto oculta los números como contraseña
          value={pin}
          onChangeText={setPin}
        />

        <TouchableOpacity style={styles.boton} onPress={manejarLogin}>
          <Text style={styles.botonTexto}>Ingresar</Text>
        </TouchableOpacity>
      </View>
    </View>
  );
}

const styles = StyleSheet.create({
  container: { flex: 1, backgroundColor: '#f4f6f8', justifyContent: 'center', padding: 20 },
  cajaLogo: { alignItems: 'center', marginBottom: 40 },
  logoTexto: { fontSize: 28, fontWeight: 'bold', color: '#2c3e50' },
  subtitulo: { fontSize: 16, color: '#7f8c8d', marginTop: 5 },
  formulario: { backgroundColor: 'white', padding: 20, borderRadius: 10, elevation: 2, shadowColor: '#000', shadowOpacity: 0.1, shadowRadius: 4 },
  label: { fontSize: 14, fontWeight: 'bold', color: '#34495e', marginBottom: 5 },
  input: { borderWidth: 1, borderColor: '#bdc3c7', borderRadius: 8, padding: 12, marginBottom: 20, fontSize: 16 },
  boton: { backgroundColor: '#27ae60', padding: 15, borderRadius: 8, alignItems: 'center' },
  botonTexto: { color: 'white', fontSize: 16, fontWeight: 'bold' }
});