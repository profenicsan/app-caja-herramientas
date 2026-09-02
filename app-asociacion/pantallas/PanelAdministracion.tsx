import react, {useState} from 'react';
import {View, Text, TextInput, Button, StyleSheet, Alert} from 'react-native';

export default function PanelAdministracion(){
    //Estados para guardar lo que el usuario escribe.
    const [cedula, setCedula] = useState('');
    const [nombre, setNombre] = useState('');
    const [direccion, setDireccion] = useState('');
    const [telefono, setTelefono] = useState('');

    //Función temporal para validar antes de enviar al servidor
    const manejarRegistro = () => {
        //Se validan los campos obligatorios
        if (!cedula || !nombre){
            Alert.alert('Error', 'La cédula y el nombre son campos obligatorios.');
            return;
        }

        //Aquí es donde se conecta con NestJS en el siguiente paso
        Alert.alert('Todo listo', 'Se registrará a: ${nombre}');
    };

    return(
        <View style={styles.container}>
            <Text style={styles.titulo}>Registro de Nuevo Productor</Text>

            <TextInput
                style={styles.input}
                placeholder="Cédula (Obligatorio) *"
                keyboardType="numeric"
                value={cedula}
                onChangeText={setCedula}
            />

            <TextInput
        style={styles.input}
        placeholder="Nombre Completo (Obligatorio) *"
        value={nombre}
        onChangeText={setNombre}
      />
      
      <TextInput
        style={styles.input}
        placeholder="Dirección"
        value={direccion}
        onChangeText={setDireccion}
      />
      
      <TextInput
        style={styles.input}
        placeholder="Teléfono"
        keyboardType="phone-pad"
        value={telefono}
        onChangeText={setTelefono}
      />

      <View style={styles.botonContainer}>
        <Button 
          title="Pre-registrar Productor" 
          color="#2e7d32" 
          onPress={manejarRegistro} 
        />
        </View>
    </View>
    );
}

// 3. Estilos básicos para que se vea ordenado y profesional
const styles = StyleSheet.create({
  container: {
    flex: 1,
    padding: 20,
    backgroundColor: '#ffffff',
    justifyContent: 'center',
  },
  titulo: {
    fontSize: 22,
    fontWeight: 'bold',
    color: '#333',
    marginBottom: 25,
    textAlign: 'center',
  },
  input: {
    borderWidth: 1,
    borderColor: '#cccccc',
    borderRadius: 8,
    padding: 12,
    marginBottom: 15,
    fontSize: 16,
  },
  botonContainer: {
    marginTop: 10,
  }
});