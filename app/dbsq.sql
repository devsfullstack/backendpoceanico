CREATE DATABASE IF NOT EXISTS poceanico DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;

USE poceanico;

CREATE TABLE IF NOT EXISTS `usuarios` 
(

  `id_user` int(11) AUTO_INCREMENT,
  `nombre` VARCHAR(255) NOT NULL,
  `apellido` VARCHAR(255) NOT NULL,
  `usuario` VARCHAR(255) NOT NULL,
  `contraseña` VARCHAR(255) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `cargo` VARCHAR(255) NOT NULL,
  `rol` VARCHAR(255) NOT NULL,
  `created_at` TIMESTAMP DEFAULT LOCALTIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT LOCALTIMESTAMP ON UPDATE LOCALTIMESTAMP,
  PRIMARY KEY (`id_user`)
);

CREATE TABLE IF NOT EXISTS `categorias`
(
  `id_categoria` int(11) AUTO_INCREMENT,
  `categoria` VARCHAR(255) NOT NULL,
  `tipo` varchar(255) NOT NULL,
  `id_user` int(11) NOT NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_categoria`),
  CONSTRAINT FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`)
);

CREATE TABLE IF NOT EXISTS `cuentas`
(
  `id_cuenta` int(11) AUTO_INCREMENT,
  `cuenta` varchar(50) NOT NULL,
  `tipo` varchar(50) NOT NULL,
  `saldo` varchar(100) NOT NULL,
  `id_user` int(11) NOT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_cuenta`),
  CONSTRAINT FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`)
); 

CREATE TABLE IF NOT EXISTS `comisiones` 
(
  `id_comisiones` int(11) AUTO_INCREMENT,
  `id_user` int(11) NOT NULL,
  `status` VarChar(20) NOT NULL,
  `monto` VarChar(20) NOT NULL,
  `createdAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_comisiones`),
  CONSTRAINT FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`)
);

CREATE TABLE IF NOT EXISTS `historico` 
(
  `id_historico` int(11) AUTO_INCREMENT,
  `modulo` VarChar(50) NOT NULL, 
  `accion` VarChar(20) NOT NULL,
  `id_user` int(11) not null,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (`id_historico`),
    CONSTRAINT FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`)
);

CREATE TABLE IF NOT EXISTS `ingresos`
(
    `id_ingreso` int(11) AUTO_INCREMENT,
    `id_cliente` int(11) NOT NULL,
    `status` VarChar(20) NOT NULL, /* Enum: 'pendiente', 'aceptado', 'rechazado', 'cobrado', '', */
    `facturatipo` VarChar(20) NOT NULL, /* Enum: 'A', 'B', 'C', 'M', 'E' */
    `id_categoria`  int(11) NOT NULL,
    `productos` VarChar(20) NOT NULL,
    `subtotal` float NOT NULL,  /*Suma de los productos */
    `descuento` float NOT NULL, /* Descuento del cliente */
    `subtotalcondesc` float NOT NULL, /* Subtotal con descuento */
    `iva` float NOT NULL, /* IVA del subtotal */
    `total` float NOT NULL, /* Total con impuestos */
    `formapago` varchar(30) NOT NULL, /* Enum: 'efectivo', 'tarjeta', 'cheque', 'transferencia', 'otros' */
    `metodoenvio` varchar(30) NOT NULL, /* Enum: 'envio', 'recogida', 'otros' */
    `id_cuenta` int(11) NOT NULL,
    `notacliente` varchar(30),  
    `notainterna` varchar(30),  
    `id_user` int(11) NOT NULL,
    `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id_ingreso`),
    CONSTRAINT FOREIGN KEY (`id_user`) REFERENCES  `users` ( `id_user`)
);

CREATE TABLE IF NOT EXISTS `egresos`
(
    `id_egreso` int(11) AUTO_INCREMENT,
    `tipo` VarChar(20) NOT NULL, /* Enum: 'compras', 'gastos', 'otros egresos' */
    `id_proveedor` int(11) NOT NULL,
    `id_categoria` int(11) NOT NULL,
    `numero` VarChar(20) NOT NULL,
    `status` VarChar(20) NOT NULL, /* Enum: 'pendiente', 'pagado'*/
    `facturatipo` VarChar(20) NOT NULL, /* Enum: 'A', 'B', 'C', 'M', 'E' */
    `productos` VarChar(20) NOT NULL,
    `subtotal` float NOT NULL,  /*Suma de los productos */
    `descuento` float NOT NULL, /* Descuento del cliente */
    `subtotalcondesc` float NOT NULL, /* Subtotal con descuento */
    `iva` float NOT NULL, /* IVA del subtotal */
    `total` float NOT NULL, /* Total con impuestos */
    `formapago` varchar(30), /* Enum: 'efectivo', 'tarjeta', 'cheque', 'transferencia', 'otros' */
    `id_cuenta` int(11) NOT NULL,
    `notacliente` varchar(30),  
    `notainterna` varchar(30),  
    `id_user` int(11) NOT NULL,
    `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id_egreso`),
    CONSTRAINT FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`)
);

CREATE TABLE IF NOT EXISTS `inventario`
(
    `id_inventario` int(11) AUTO_INCREMENT,
    `producto` int(11) NOT NULL, /* Relacion con la tabla productos */
    `id_categoria` int(11) NOT NULL,
    `id_proveedor` int(11) NOT NULL,
    `cantidad` int(11) NOT NULL, /* Cantidad de productos */
    `precio` float NOT NULL, /* Precio de venta */
    `id_user` int(11) NOT NULL,
    `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id_inventario`),
    CONSTRAINT FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`)
);

CREATE TABLE IF NOT EXISTS `clientes`
(
    `id_cliente` int(11) AUTO_INCREMENT,
    `tipodoc` VarChar(20) NOT NULL, /* Enum: 'DNI', 'Cuit', 'Cuil' */
    `documento` VarChar(20) NOT NULL, /* DNI, CUIT, CUil */
    `nombre` VarChar(20) NOT NULL,
    `apellido` VarChar(20) NOT NULL,
    `direccion` VarChar(20) NOT NULL,
    `localidad` VarChar(20) NOT NULL,
    `provincia` VarChar(20) NOT NULL,
    `codpostal` VarChar(20) NOT NULL,
    `telefono` VarChar(20) NOT NULL,
    `email` VarChar(20) NOT NULL,
    `id_categoria` int(11),
    `usermeli` VarChar(20) NOT NULL,
    `pagweb` VarChar(20) NOT NULL,
    `descuento` float NOT NULL, /* Descuento del cliente */
    `saldo` float NOT NULL, /* Saldo del cliente */
    `id_user` int(11) NOT NULL, /* Relacion con la tabla users */
    `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id_cliente`),
    CONSTRAINT FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`)
);

CREATE TABLE IF NOT EXISTS  `proveedores`
(
    `id_proveedor` int(11) AUTO_INCREMENT,
    `tipodoc` VarChar(20) NOT NULL, /* Enum: 'DNI ', 'Cuit', 'Cuil' */
    `documento` VarChar(20) NOT NULL, /* DNI, CUIT, CUil */
    `nombre` VarChar(20) NOT NULL,
    `razonsocial` VarChar(20) NOT NULL,
    `direccion` VarChar(20) NOT NULL,
    `condicion` VarChar(20) NOT NULL, /* Enum: 'Monotributista', 'Consumidor Final', 'Responsable Inscripto', 'Exento' */
    `tipofactura` VarChar(20) NOT NULL, /* Enum: 'Factura', 'Nota de Crédito', 'Nota de Débito' */
    `localidad` VarChar(20) NOT NULL,
    `provincia` VarChar(20) NOT NULL,
    `codpostal` VarChar(20) NOT NULL,
    `telefono` VarChar(20) NOT NULL,
    `email` VarChar(20) NOT NULL,
    `id_categoria` int(11),
    `saldoinicial` float NOT NULL, /* Saldo inicial del proveedor */
    `id_user` int(11),
    `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id_proveedor`),
    CONSTRAINT FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`)
);

CREATE TABLE IF NOT EXISTS `productos`
(
    `id_producto` int(11) AUTO_INCREMENT,
    `codigo` VarChar(20) NOT NULL,
    `nombre` VarChar(20) NOT NULL,
    `descripcion` VarChar(20) NOT NULL,
    `tipo` VarChar(20) NOT NULL, /* Enum: 'Servicio', 'Producto' */
    `precio` float NOT NULL,
    `id_proveedor` int(11) NOT NULL, /* Id del proveedor */
    `id_categoria` int(11) NOT NULL, /* Id de la categoría */
    `stock` int(11) NOT NULL, /* Stock del producto */ 
    `id_user` int(11) NOT NULL, /* Relacion con la tabla users */
    `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id_producto`),
    CONSTRAINT FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`)
); 

/*Para crear la base de datos y crear las tablas en mysql debes importar este documento*/

