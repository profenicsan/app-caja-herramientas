# Plataforma de Caja de Herramientas Gestión Agrícola y Tributaria

Plataforma integral desarrollada para facilitar el registro operativo, la gestión financiera y el control tributario de productores agrícolas mediante un sistema de roles y credenciales seguras.

## 🛠️ Stack Tecnológico
* **Frontend:** React Native (Expo)
* **Backend:** NestJS (Node.js)
* **Base de Datos:** Relacional / TypeORM
* **Seguridad:** Autenticación por PIN cifrado (bcrypt)

## 📌 Estado de Desarrollo (Fase 1)
* [x] Estructuración de arquitectura frontend y backend.
* [x] Pantalla de inicio de sesión optimizada (Cédula y PIN numérico).
* [x] Módulo backend de pre-registro administrativo.
* [x] Generación y cifrado de credenciales temporales.

## 🚀 Instrucciones de Ejecución Local

**1. Inicializar el Servidor (Backend)**
Abre una terminal y ejecuta:
\`\`\`bash
cd backend-asociacion
npm install
npm run start:dev
\`\`\`

**2. Inicializar la Aplicación (Frontend)**
Abre una segunda terminal y ejecuta:
\`\`\`bash
cd app-asociacion
npm install
npx expo start
\`\`\`

## 🚀 Avances Recientes: Interfaz, UX y Bóveda Digital (Frontend) al 10 de septiembre del 2026

### 0. Identidad del Proyecto
* **Nombramiento (Naming):** Se definió oficialmente el nombre de la aplicación como **AgroAsoc**. Tras una revisión estratégica, se confirmó que este nombre se encuentra **disponible** para su uso, lo que garantiza la viabilidad de la marca y futuros procesos de registro o despliegue comercial para la asociación rural.

### 1. Arquitectura y Experiencia de Usuario (UX)
* **Navegación Fluida:** Se implementó la transición global de desvanecimiento (`animation: 'fade'`) en `React Navigation`, eliminando los cortes bruscos por defecto del sistema operativo y brindando una sensación premium.
* **Animaciones Nativas (Sin dependencias externas):** Se desarrolló el componente reutilizable `<CargandoPlanta />` utilizando la API nativa `Animated` de React Native (escala y opacidad). Esto evita la sobrecarga de librerías de terceros (como Lottie) manteniendo la aplicación ligera.
* **Identidad Visual:** Integración estricta de la paleta de colores institucional (Color principal: `#00615C`) y uso de iconografía coherente mediante `@expo/vector-icons`.

### 2. Módulo de Autenticación y Panel Administrativo
* **Login Adaptativo:** Corrección en el teclado del dispositivo (`keyboardType="default"`, `autoCapitalize="none"`) para permitir la entrada de credenciales alfanuméricas, indispensable para los perfiles de administradores (ej. usuario "admin").
* **Estructura del Dashboard:** Refactorización del menú lateral en `PanelAdministracion.tsx`. Se dividió la gestión contable en módulos específicos:
  * *Transacciones y Costos* (Para el Libro Diario y Calculadora de Costos).
  * *Bóveda y Legal DIAN* (Para la gestión documental y alertas tributarias).

### 3. Módulo Tributario y Legal (Gestión DIAN)
Se construyó la pantalla `ModuloTributario.tsx` con las siguientes características operativas:
* **Tablero Contributivo:** Renderizado de tarjetas de alerta visual para el control de próximos vencimientos legales (Cámara de Comercio, RUT, IVA).
* **Gestor Documental (Bóveda Digital):** Integración de carga de archivos locales mediante la zona de carga (Dropzone). El sistema captura metadatos del archivo y actualiza la lista dinámica del estado (`useState`) de forma inmediata.
* **Visor de Documentos Híbrido (Multiplataforma):** Se implementó un modal de previsualización de documentos (PDF/Imágenes) con lógica condicional según el entorno de ejecución:
  * **Móvil (Android/iOS):** Utiliza `react-native-webview` para renderizar el archivo de manera nativa.
  * **Web (Navegador):** Inyecta una etiqueta estándar `iframe` garantizando la compatibilidad multiplataforma sin errores.

### 📦 Nuevas Dependencias Instaladas
* `expo-document-picker`: Para el acceso al sistema de archivos del dispositivo.
* `react-native-webview`: Para la visualización nativa de documentos en dispositivos móviles.