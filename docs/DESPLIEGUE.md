Manual de Despliegue - AgroAsoc

Este documento detalla los requerimientos de infraestructura y los pasos exactos para desplegar el backend (NestJS) y la base de datos (PostgreSQL) en el entorno de producción.

1. Requerimientos de la Máquina Virtual
Sistema Operativo y Recursos: Ubuntu Server 22.04 LTS con 2 vCPU, 4 GB de RAM y 40 GB de almacenamiento.

Puertos de Red (Inbound): 80 (HTTP), 443 (HTTPS) y 5432 (PostgreSQL).

Dependencias Globales: Node.js (v18+), PostgreSQL (v15+), PM2 (gestor de procesos) y Nginx (proxy inverso).

2. Variables de Entorno (.env)
El servidor requiere un archivo .env en la raíz para aislar la seguridad. El equipo de infraestructura debe proveer:

Credenciales de acceso a la base de datos de producción (DB_USER, DB_PASSWORD, DB_NAME).

El puerto interno de despliegue de la API (Por defecto: 3000).

3. Pasos de Ejecución (Para el Ingeniero)

Clonar el repositorio oficial en el servidor (ej. /var/www/agroasoc) y ejecutar npm install.

Compilar el proyecto de TypeScript a JavaScript ejecutando npm run build.

Levantar el servicio en segundo plano asegurando su persistencia con el comando: pm2 start dist/main.js --name agroasoc-api.

Configurar Nginx para redirigir el tráfico web externo hacia el puerto 3000 interno.