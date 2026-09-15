import React from 'react';
import { NavigationContainer } from '@react-navigation/native';
import { createNativeStackNavigator } from '@react-navigation/native-stack';

// 1. Importamos todas las pantallas de nuestra carpeta
import Login from './pantallas/login';
import PanelAdministracion from './pantallas/PanelAdministracion';
import ModuloTributario from './pantallas/ModuloTributario';
import PerfilAsociacion from './pantallas/PerfilAsociacion';
import ListaProductores from './pantallas/ListaProductores';
import TransaccionesCostos from './pantallas/TransaccionesCostos'; // <-- NUEVO MÓDULO IMPORTADO

const Stack = createNativeStackNavigator();

export default function App() {
  return (
    <NavigationContainer>
      <Stack.Navigator 
        initialRouteName="login"
        screenOptions={{
          headerShown: false, // Ocultamos la barra superior por defecto
          animation: 'fade',  // Transición suave
        }}
      >
        {/* Rutas de Acceso y Panel */}
        <Stack.Screen name="login" component={Login} />
        <Stack.Screen name="PanelAdministracion" component={PanelAdministracion} />
        
        {/* Módulos Operativos */}
        <Stack.Screen name="ModuloTributario" component={ModuloTributario} />
        <Stack.Screen name="PerfilAsociacion" component={PerfilAsociacion} />
        <Stack.Screen name="ListaProductores" component={ListaProductores} />
        
        {/* 2. Registramos la nueva ruta financiera */}
        <Stack.Screen name="TransaccionesCostos" component={TransaccionesCostos} />
        
      </Stack.Navigator>
    </NavigationContainer>
  );
}