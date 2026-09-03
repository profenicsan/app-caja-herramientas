import React, { useState, useEffect, useRef } from 'react';
import { View, Text, TextInput, TouchableOpacity, StyleSheet, Alert, SafeAreaView, Animated, Dimensions } from 'react-native';
import { useNavigation } from '@react-navigation/native';
import { FontAwesome5 } from '@expo/vector-icons';

const { width, height } = Dimensions.get('window');

// 1. Componente: HojaFlotante
const HojaFlotante = ({ size, delay, startX, duration }: any) => {
  const animacionY = useRef(new Animated.Value(height)).current;
  const rotacion = useRef(new Animated.Value(0)).current;

  useEffect(() => {
    const mover = Animated.timing(animacionY, {
      toValue: -size, 
      duration: duration,
      delay: delay,
      useNativeDriver: true,
    });
    
    const rotar = Animated.timing(rotacion, {
      toValue: 1,
      duration: duration,
      delay: delay,
      useNativeDriver: true,
    });

    Animated.loop(Animated.parallel([mover, rotar])).start();
  }, []);

  const rotacionInterpolada = rotacion.interpolate({
    inputRange: [0, 1],
    outputRange: ['0deg', '360deg'],
  });

  return (
    <Animated.View
      style={{
        position: 'absolute',
        left: startX,
        opacity: 0.06,
        transform: [{ translateY: animacionY }, { rotate: rotacionInterpolada }],
      }}
    >
      <FontAwesome5 name="leaf" size={size} color="#00615C" />
    </Animated.View>
  );
};

export default function Login() {
  const [cedula, setCedula] = useState('');
  const [pin, setPin] = useState('');
  const navigation = useNavigation<any>();

  const manejarLogin = () => {
    if (cedula === 'admin' && pin === '1234') {
      navigation.navigate('PanelAdministracion');
    } else if (cedula === 'productor' && pin === '1234') {
      navigation.navigate('PanelProductor');
    } else {
      Alert.alert('Error', 'Credenciales incorrectas');
    }
  };

  return (
    <SafeAreaView style={styles.fondoGlobal}>
      
      {/* 2. Renderizamos las hojas */}
      <HojaFlotante size={45} delay={0} startX={width * 0.1} duration={15000} />
      <HojaFlotante size={25} delay={2000} startX={width * 0.4} duration={12000} />
      <HojaFlotante size={55} delay={5000} startX={width * 0.7} duration={18000} />
      <HojaFlotante size={30} delay={8000} startX={width * 0.2} duration={14000} />
      <HojaFlotante size={40} delay={1000} startX={width * 0.8} duration={16000} />

      {/* 3. Tarjeta de Formulario */}
      <View style={styles.tarjetaLogin}>
        
        <View style={styles.logoContainer}>
          <FontAwesome5 name="seedling" size={40} color="#00615C" />
        </View>

        <Text style={styles.titulo}>AgroAsoc</Text>
        <Text style={styles.subtitulo}>Plataforma de Gestión Agropecuaria</Text>

        <Text style={styles.label}>Usuario *</Text>
        <TextInput
          style={styles.input}
          placeholder="Ingrese su cédula"
          placeholderTextColor="#888"
          value={cedula}
          onChangeText={setCedula}
          keyboardType="numeric"
        />

        <Text style={styles.label}>Contraseña *</Text>
        <TextInput
          style={styles.input}
          placeholder="Ingrese su PIN"
          placeholderTextColor="#888"
          value={pin}
          onChangeText={setPin}
          secureTextEntry
          keyboardType="numeric"
        />

        <TouchableOpacity style={styles.botonPrimario} onPress={manejarLogin}>
          <Text style={styles.textoBoton}>Iniciar Sesión</Text>
        </TouchableOpacity>

        <Text style={styles.piePagina}>© 2026 Universidad Tecnológica de Pereira</Text>
      </View>

    </SafeAreaView>
  );
}

// 4. BLOQUE DE ESTILOS (El que estaba faltando)
const styles = StyleSheet.create({
  fondoGlobal: {
    flex: 1,
    backgroundColor: '#F4F6F8',
    justifyContent: 'center',
    alignItems: 'center',
    padding: 20,
  },
  tarjetaLogin: {
    backgroundColor: '#FFFFFF',
    width: '100%',
    maxWidth: 400,
    borderRadius: 16,
    padding: 30,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 4 },
    shadowOpacity: 0.1,
    shadowRadius: 10,
    elevation: 8,
  },
  logoContainer: {
    alignItems: 'center',
    marginBottom: 10,
  },
  titulo: {
    fontSize: 28,
    fontWeight: 'bold',
    color: '#00615C',
    textAlign: 'center',
    marginBottom: 5,
  },
  subtitulo: {
    fontSize: 14,
    color: '#666666',
    textAlign: 'center',
    marginBottom: 30,
  },
  label: {
    fontSize: 12,
    color: '#333333',
    fontWeight: '600',
    marginBottom: 5,
    marginLeft: 2,
  },
  input: {
    borderWidth: 1,
    borderColor: '#E0E0E0',
    borderRadius: 8,
    paddingHorizontal: 15,
    paddingVertical: 12,
    fontSize: 14,
    color: '#333333',
    marginBottom: 20,
    backgroundColor: '#FAFAFA',
  },
  botonPrimario: {
    backgroundColor: '#00615C',
    borderRadius: 8,
    paddingVertical: 14,
    alignItems: 'center',
    marginTop: 10,
  },
  textoBoton: {
    color: '#FFFFFF',
    fontSize: 16,
    fontWeight: 'bold',
  },
  piePagina: {
    textAlign: 'center',
    color: '#AAAAAA',
    fontSize: 10,
    marginTop: 25,
  }
});