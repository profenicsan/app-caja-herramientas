# AgroAsoc - Plataforma de Gestión Agropecuaria

AgroAsoc es una plataforma integral multiplataforma (Web y Móvil) diseñada para la administración eficiente de asociaciones agrícolas y la gestión operativa de productores. El sistema cuenta con interfaces adaptativas, ofreciendo un entorno de escritorio para la administración y una vista móvil optimizada para el trabajo en campo.

Desarrollado en alineación con los requerimientos operativos y de extensión rural del EPSEA (Universidad Tecnológica de Pereira).

## 🚀 Stack Tecnológico

El proyecto ha sido migrado a **Flutter** para unificar el desarrollo multiplataforma mediante un código base robusto.

* **Framework:** Flutter / Dart
* **Manejo de Íconos:** `font_awesome_flutter`
* **Gestión de Documentos:** `file_picker` (Módulo Tributario/DIAN)
* **Conectividad:** Paquete `http` nativo (Integración de Asistente IA con Ollama/Mistral)

## 🗺️ Estructura de Rutas

El enrutamiento está centralizado en `lib/main.dart` utilizando el sistema de navegación por nombres de Flutter:

* `/login` - Pantalla de autenticación y control de roles.
* `/panel_administracion` - Dashboard de escritorio con barra lateral de navegación.
* `/panel_productor` - Interfaz móvil con acciones rápidas para agricultores.
* `/perfil_asociacion` - Configuración de datos institucionales.
* `/productores` - Directorio interactivo de asociados.
* `/modulo_tributario` - Bóveda legal y visor de documentos DIAN.
* `/transacciones_costos` - Motor contable con cálculo en tiempo real.
* `/asistente_ia` - Chatbot integrado de asistencia agronómica.

## 🛠️ Comandos de Ejecución

**1. Limpieza e instalación de dependencias:**
```bash
flutter clean
flutter pub get

**2. Ejecución en entorno de desarrollo web:**

flutter run -d web-server

**3. Compilación para Producción (Web)**
flutter build web

**Desarrollo:**
Nicolás Sánchez Rojas