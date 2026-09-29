-- 1. Usuarios y Roles (Productores y Administradores)
CREATE TABLE usuarios (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    email VARCHAR(150) UNIQUE,
    rol VARCHAR(50) CHECK (rol IN ('productor', 'administrador')) NOT NULL,
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2. Perfil Productivo (Fincas de los asociados)
CREATE TABLE fincas (
    id SERIAL PRIMARY KEY,
    usuario_id INTEGER REFERENCES usuarios(id) ON DELETE CASCADE,
    nombre_finca VARCHAR(150) NOT NULL,
    vereda VARCHAR(150),
    hectareas NUMERIC(8,2),
    cultivo_principal VARCHAR(100) -- Ej. Plátano Verde
);

-- 3. Transacciones y Costos (Basado en el Excel contable)
CREATE TABLE transacciones (
    id SERIAL PRIMARY KEY,
    usuario_id INTEGER REFERENCES usuarios(id),
    tipo VARCHAR(20) CHECK (tipo IN ('ingreso', 'egreso')) NOT NULL,
    categoria VARCHAR(100) NOT NULL, -- Ej. Semillas, Venta Mayorista
    cantidad NUMERIC(10,2) DEFAULT 1,
    precio_unitario NUMERIC(14,2) NOT NULL,
    precio_envio NUMERIC(14,2) DEFAULT 0,
    importe_total NUMERIC(14,2) NOT NULL, -- Calculado en backend
    fecha_transaccion DATE NOT NULL,
    comprobante_url VARCHAR(255)
);

-- 4. Bóveda Digital (Documentos Legales y Tributarios)
CREATE TABLE documentos_legales (
    id SERIAL PRIMARY KEY,
    titulo VARCHAR(200) NOT NULL,
    tipo_documento VARCHAR(50), -- RUT, Camara_Comercio, Resolucion
    fecha_vencimiento DATE,
    archivo_url VARCHAR(255) NOT NULL,
    cargado_por INTEGER REFERENCES usuarios(id),
    fecha_carga TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);