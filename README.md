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

### 4. Gestión de Productores (Directorio)
* **Control de Asociados:** Interfaz lista para listar y registrar productores, alineada a la estructura SQL con campos específicos como Nombre de la Finca, Hectáreas y Vereda.
* **Personalización Visual:** Integración de la librería `expo-image-picker` para permitir la carga y asignación de fotografías de perfil por cada agricultor.

### 5. Perfil de la Asociación
* **Identidad Institucional:** Interfaz dedicada para visualizar y editar información clave (NIT, contacto, ubicación y línea productiva).
* **Gestión de Marca:** Funcionalidad dinámica para modificar el logo y el banner principal de la asociación accediendo a la galería del dispositivo.

### 6. Módulo de Transacciones y Costos (Finanzas)
* **Tablero Financiero:** Dashboard integrado que calcula en tiempo real el balance neto (Ingresos vs Costos/Egresos).
* **Lógica Contable Automatizada:** Formulario de registro adaptado a la lógica de negocio en Excel. Incluye cálculos automáticos de importe para ingresos `(Cantidad × Precio) + Envío` y categorización de gastos.

### 🛠 Mejoras Técnicas, UX y Solución de Bugs
* **Panel Responsivo:** Refactorización del Menú Lateral (Sidebar) en `PanelAdministracion.tsx`, implementando un menú tipo "hamburguesa" retráctil para pantallas móviles (teléfonos) y fijo para tablets/PC.
* **Visor de PDFs Nativo (Android/iOS):** Se solucionó el bloqueo de seguridad de Android al abrir archivos locales. Se integraron `expo-file-system/legacy` y `expo-sharing` para generar copias seguras en caché y utilizar el lector de PDF nativo del dispositivo.
* **Carga Unificada:** Despliegue global del componente de transición `<CargandoPlanta />` en todas las pantallas operativas.
* **Identidad Visual UTP/EPSEA:** Unificación de los logos institucionales en un solo recurso gráfico (`logo-utp-epsea.png`) adaptable y responsivo en la franja inferior del menú.

---
**🔜 Próximos Pasos (Fase Backend):**
El Frontend se encuentra operativamente estructurado. La siguiente etapa consiste en la construcción del servidor utilizando **NestJS** y la conexión con la base de datos **SQL** para dotar a estos módulos de persistencia real de datos.

### 7. Panel del Productor (Operación en Campo)
* **Interfaz UX/UI Adaptada:** Dashboard diseñado específicamente para el agricultor, con tipografía clara y accesos rápidos a utilidades diarias.
* **Seguimiento de Cultivos:** Indicadores visuales (barras de progreso) para monitorear el estado actual de la siembra o cosecha.

### 8. Inteligencia Artificial Local (Seguridad y Privacidad)
* **Motor de Inferencia Soberano:** Integración con **Ollama** ejecutándose de forma local en los servidores, garantizando la política de "Cero Retención de Datos" (Zero Data Retention) en la nube.
* **Modelo Especializado (Mistral):** Uso de LLM optimizado para procesamiento en español nativo, sin dependencias de APIs pagas de terceros.
* **Asesor Agrícola Virtual:** Chatbot interactivo condicionado mediante *System Prompts* para actuar como extensionista agrícola, entregando respuestas accionables, precisas y sin jerga técnica.
* **Enrutamiento Dinámico:** Preparación del sistema para adaptar el comportamiento de la IA según el rol del usuario (Productor vs. Administrador).

### 🛠 Mejoras Técnicas y Solución de Bugs
* **Restauración de Lector PDF:** Se consolidó el bypass de seguridad en `ModuloTributario` usando `expo-file-system/legacy` y `expo-sharing` para forzar la lectura nativa de documentos sin bloqueos de Android.
* **Depuración de Caché TypeScript:** Resolución de problemas de rastreo de módulos y enrutamiento en `App.tsx` al enlazar nuevas pantallas.

---
**🔜 Próximos Pasos (Arquitectura Backend):**
1. Definición de entidades y despliegue del servidor en **NestJS**.
2. Estructuración de la base de datos SQL para persistencia de productores y transacciones.
3. Evaluación de lineamientos de infraestructura para despliegue en servidores de la Universidad Tecnológica de Pereira (UTP).