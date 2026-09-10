import React from 'react';
import { NavigationContainer } from '@react-navigation/native';
import { createNativeStackNavigator } from '@react-navigation/native-stack';

//Importación de pantallas
import Login from './pantallas/login';
import ListaProductores from './pantallas/ListaProductores';
import PanelAdministracion from './pantallas/PanelAdministracion';
import ModuloTributario from './pantallas/ModuloTributario';

const Stack = createNativeStackNavigator();

export default function App() {
  return (
    <NavigationContainer>
      <Stack.Navigator initialRouteName="login">
        
        {/* Pantalla de Login */}
        <Stack.Screen
          name="login"
          component={Login}
          options={{ headerShown: false }}
        />

        {/* 2. Registramos oficialmente el Panel de Administración */}
        <Stack.Screen
          name="PanelAdministracion"
          component={PanelAdministracion}
          options={{ headerShown: false }} 
        />

        <Stack.Screen
        name="ModuloTributario"
        component={ModuloTributario}
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