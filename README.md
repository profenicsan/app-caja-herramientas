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