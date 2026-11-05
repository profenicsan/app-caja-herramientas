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
```bash
flutter run -d web-server

**3. Compilación para Producción (Web)**
```bash
flutter build web

# 🚜 AgroAsoc - Plataforma de Gestión para Asociaciones Productoras

AgroAsoc es una solución tecnológica integral (Móvil y Web) diseñada para centralizar la gestión administrativa, contable, tributaria y operativa de las asociaciones de productores rurales. Este proyecto es desarrollado bajo la coordinación de EPSEA - Universidad Tecnológica de Pereira (UTP).

## 🚀 Estado Actual y Novedades (Sprint Actual)

Se han estabilizado e integrado los módulos de gestión legal y atención al productor en la vista web:

* **Módulo Tributario (Administrador):** Implementación de la *Bóveda Documental* y el *Calendario DIAN*. Permite la carga, gestión y previsualización nativa de documentos PDF en memoria directamente desde el navegador, sin bloqueos de seguridad.
* **Módulo Tributario (Productor):** Interfaz simplificada de solo lectura para que los agricultores consulten y descarguen sus certificados de retención y verifiquen sus próximos vencimientos.
* **Centro de Soporte:** Nueva pantalla de ayuda transversal con integración de canales de contacto directo (WhatsApp, Correo, Teléfono) y panel interactivo de Preguntas Frecuentes (FAQ).

## 🏗️ Arquitectura y Tecnologías

El proyecto sigue una arquitectura cliente-servidor orientada a la soberanía de los datos de las asociaciones:

### Frontend (Panel Web y App)
* **Framework:** Flutter (Web y Mobile).
* **Renderizado Web:** CanvasKit / HTML.
* **Visor de Documentos:** `syncfusion_flutter_pdfviewer`.
* **Motor PDF Base:** Inyección de `pdf.js` v2.11.338 en el `index.html` para procesamiento seguro de flujos de bytes (`Uint8List`).

### Backend y Base de Datos (Infraestructura Local)
Para garantizar la privacidad y control total de la información financiera y legal, se descartan soluciones BaaS públicas (como Supabase) a favor de un entorno local y autocontenido:
* **Base de Datos:** PostgreSQL alojado localmente.
* **API REST:** Servidor construido en Node.js.
* **Despliegue y Orquestación:** Contenedores Docker y Docker Compose gestionados sobre un entorno Linux (WSL2/Ubuntu en desarrollo local).
* **Servidor Web:** Nginx / Apache para servir los archivos estáticos compilados de Flutter Web.

## 🛠️ Configuración del Entorno de Desarrollo (Web)

Para ejecutar el panel de administración web con soporte completo para la lectura de documentos:

1. Clonar el repositorio.
2. Instalar dependencias:
   ```bash
   flutter pub get