import React, { useEffect, useRef } from 'react';
import { View, Text, StyleSheet, Animated } from 'react-native';
import { FontAwesome5 } from '@expo/vector-icons';

export default function CargandoPlanta({ mensaje = "Sincronizando datos..." }: any) {
  // Valores iniciales de la animación
  const escala = useRef(new Animated.Value(0.5)).current;
  const opacidad = useRef(new Animated.Value(0.3)).current;

  useEffect(() => {
    // Animación de crecer y encogerse
    const animacionEscala = Animated.sequence([
      Animated.timing(escala, { toValue: 1.2, duration: 1000, useNativeDriver: true }),
      Animated.timing(escala, { toValue: 0.8, duration: 1000, useNativeDriver: true })
    ]);

    // Animación de brillar y atenuarse
    const animacionOpacidad = Animated.sequence([
      Animated.timing(opacidad, { toValue: 1, duration: 1000, useNativeDriver: true }),
      Animated.timing(opacidad, { toValue: 0.5, duration: 1000, useNativeDriver: true })
    ]);

    // Ejecutar ambas animaciones en bucle infinito
    Animated.loop(
      Animated.parallel([animacionEscala, animacionOpacidad])
    ).start();
  }, []);

  return (
    <View style={styles.contenedor}>
      <Animated.View style={{ transform: [{ scale: escala }], opacity: opacidad }}>
        <FontAwesome5 name="seedling" size={80} color="#00615C" />
      </Animated.View>
      <Text style={styles.texto}>{mensaje}</Text>
    </View>
  );
}

const styles = StyleSheet.create({
  contenedor: {
    flex: 1,
    backgroundColor: '#F4F6F8', // Fondo global EPSEA
    justifyContent: 'center',
    alignItems: 'center',
  },
  texto: {
    marginTop: 30,
    fontSize: 16,
    color: '#00615C',
    fontWeight: 'bold',
    letterSpacing: 1,
  }
});