import React from 'react';
import { NavigationContainer } from '@react-navigation/native';
import { createNativeStackNavigator } from '@react-navigation/native-stack';

// Importamos las dos pantallas
import Login from './pantallas/login';
import ListaProductores from './pantallas/ListaProductores';

const Stack = createNativeStackNavigator();

export default function App() {
  return (
    <NavigationContainer>
      <Stack.Navigator initialRouteName="login">
        {/* Pantalla de Login (ocultamos la barra superior para que se vea más limpia) */}
        <Stack.Screen 
          name="login" 
          component={Login} 
          options={{ headerShown: false }} 
        />
        
        {/* Pantalla con la lista que conecta a la base de datos */}
        <Stack.Screen 
          name="Productores" 
          component={ListaProductores} 
          options={{ title: 'Productores Registrados' }} 
        />
      </Stack.Navigator>
    </NavigationContainer>
  );
}
