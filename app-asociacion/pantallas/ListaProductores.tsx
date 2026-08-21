import React, { useEffect, useState } from 'react';
import { SafeAreaView, Text, FlatList, View, StyleSheet } from 'react-native';

// 1. Definimos la estructura exacta de nuestros datos (La ventaja de TypeScript)
interface Productor {
  id: number;
  nombre_completo: string;
  cedula: string;
  telefono: string;
  direccion: string;
}

export default function App() {
  // 2. Le decimos a useState que este arreglo contendrá objetos de tipo "Productor"
  const [productores, setProductores] = useState<Productor[]>([]);

  useEffect(() => {
    // URL de tu backend en NestJS
    // Importante: Si pruebas en un emulador de Android, cambia "localhost" por "10.0.2.2"
    const apiUrl = 'http://localhost:3000/productores';

    fetch(apiUrl)
      .then(response => response.json())
      .then(data => setProductores(data))
      .catch(error => console.error('Error de conexión:', error));
  }, []);

  return (
    <SafeAreaView style={styles.container}>
      <Text style={styles.titulo}>Productores Agrícolas</Text>
      
      <FlatList
        data={productores}
        keyExtractor={(item) => item.id.toString()}
        renderItem={({ item }) => (
          <View style={styles.tarjeta}>
            <Text style={styles.nombre}>{item.nombre_completo}</Text>
            <Text style={styles.texto}>Cédula: {item.cedula}</Text>
            <Text style={styles.texto}>Teléfono: {item.telefono}</Text>
            <Text style={styles.texto}>Dirección: {item.direccion}</Text>
          </View>
        )}
      />
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  container: { 
    flex: 1, 
    padding: 20, 
    backgroundColor: '#f4f6f8',
    marginTop: 30
  },
  titulo: { 
    fontSize: 24, 
    fontWeight: 'bold', 
    marginBottom: 20, 
    textAlign: 'center',
    color: '#2c3e50'
  },
  tarjeta: { 
    backgroundColor: 'white', 
    padding: 15, 
    marginBottom: 12, 
    borderRadius: 10, 
    elevation: 3, // Sombra en Android
    shadowColor: '#000', // Sombra en iOS
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.1,
    shadowRadius: 4,
  },
  nombre: {
    fontSize: 18,
    fontWeight: 'bold',
    color: '#27ae60',
    marginBottom: 5
  },
  texto: {
    fontSize: 14,
    color: '#34495e',
    marginBottom: 2
  }
});