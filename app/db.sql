CREATE DATABASE IF NOT EXISTS `poceanico` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4 _general_ci;

USE `poceanico`;

CREATE TABLE `users`
(
  `id_user` INT AUTO_INCREMENT PRIMARY KEY,
  `user` VARCHAR(255) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_users`)
  ) ENGINE=InnoDB

CREATE TABLE `categorias`
(
  `id_categoria` INT AUTO_INCREMENT PRIMARY KEY,
  `categoria` VARCHAR(255) NOT NULL,
  `tipo` TEXT,
  `id_user` int(11), /*Relacion con la tabla users*/
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_categoria`),
  CONSTRAINT FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`)
  ) ENGINE=InnoDB

CREATE TABLE `cuentas`
(
  `id_cuenta` int(11) NOT NULL AUTO_INCREMENT,
  `cuenta` varchar(50) NOT NULL,
  `tipo` varchar(50) NOT NULL,
  `saldo` varchar(100) NOT NULL,
  `id_user` int(11),
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_cuenta`),
  CONSTRAINT FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`)
  ) ENGINE=InnoDB

CREATE TABLE `comisiones` 
(
  `id_comisiones` int(11) NOT NULL AUTO_INCREMENT,
  `id_user` int(11),
  `status` VarChar(20) NOT NULL,
  `monto` VarChar(20) NOT NULL,
  `createdAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Id_comisiones`),
  CONSTRAINT FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`)
) ENGINE=InnoDB

CREATE TABLE `historico` 
(
  `Id_historico` int(11) NOT NULL AUTO_INCREMENT,
  `Modulo` VarChar(50) NOT NULL, 
  `Accion` VarChar(20) NOT NULL,
  `id_user` int(11),
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (`Id_historico`),
    CONSTRAINT FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`)
) ENGINE=InnoDB

CREATE TABLE `ingresos`
(
    `id_ingreso` int(11) NOT NULL AUTO_INCREMENT,
    `id_cliente` int(11),
    'status' VarChar(20) NOT NULL, /* Enum: 'pendiente', 'aceptado', 'rechazado', 'cobrado', '', */
    `facturatipo` VarChar(20) NOT NULL, /* Enum: 'A', 'B', 'C', 'M', 'E' */
    `categoria` int(11),
    `productos` VarChar(20) NOT NULL,
    `subtotal` float NOT NULL,  /*Suma de los productos */
    `descuento` float NOT NULL, /* Descuento del cliente */
    `subtotalcondesc` float NOT NULL, /* Subtotal con descuento */
    `iva` float NOT NULL, /* IVA del subtotal */
    `total` float NOT NULL, /* Total con impuestos */
    `formapago` varchar(30), /* Enum: 'efectivo', 'tarjeta', 'cheque', 'transferencia', 'otros' */
    `metodoenvio` varchar(30), /* Enum: 'envio', 'recogida', 'otros' */
    `id_cuenta` int(11),
    `notacliente` varchar(30),  
    `notainterna` varchar(30),  
    `id_user` int(11),
    `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`Id_ingreso`),
    CONSTRAINT FOREIGN KEY (`id_cliente`, `id_user`, `id_cuenta`) REFERENCES `clientes`, `users`, `cuentas` (`id_cliente`, `id_user`, `id_cuenta` ) 
    ) ENGINE=InnoDB

CREATE TABLE `egresos`
(
    `id_egreso` int(11) NOT NULL AUTO_INCREMENT,
    `tipo` VarChar(20) NOT NULL, /* Enum: 'compras', 'gastos', 'otros egresos' */
    `id_proveedor` int(11),
    `id_categoria` int(11),
    `numero` VarChar(20) NOT NULL,
    'status' VarChar(20) NOT NULL, /* Enum: 'pendiente', 'pagado'*/
    `facturatipo` VarChar(20) NOT NULL, /* Enum: 'A', 'B', 'C', 'M', 'E' */
    `productos` VarChar(20) NOT NULL,
    `subtotal` float NOT NULL,  /*Suma de los productos */
    `descuento` float NOT NULL, /* Descuento del cliente */
    `subtotalcondesc` float NOT NULL, /* Subtotal con descuento */
    `iva` float NOT NULL, /* IVA del subtotal */
    `total` float NOT NULL, /* Total con impuestos */
    `formapago` varchar(30), /* Enum: 'efectivo', 'tarjeta', 'cheque', 'transferencia', 'otros' */
    `id_cuenta` int(11),
    `notacliente` varchar(30),  
    `notainterna` varchar(30),  
    `id_user` int(11),
    `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`Id_egreso`),
    CONSTRAINT FOREIGN KEY (`id_proveedor`, `id_categoria`, `id_cuenta`, `id_user`) REFERENCES `proveedores`, `categorias`, `cuentas`, `users` (`id_proveedor`, `id_categoria`, `id_cuenta`, `id_user` )
    ) ENGINE=InnoDB

CREATE TABLE `inventario`
(
    `id_inventario` int(11) NOT NULL AUTO_INCREMENT,
    `producto` int(11) NOT NULL, /* Relacion con la tabla productos */
    `id_categoria` int(11),
    `id_proveedor` int(11),
    `cantidad` int(11) NOT NULL, /* Cantidad de productos */
    `precio` float NOT NULL, /* Precio de venta */
    `id_user` int(11),
    `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`Id_inventario`),
    CONSTRAINT FOREIGN KEY (`id_categoria`, `id_proveedor`, `id_user`) REFERENCES `categorias`, `proveedores`, `users` (`id_categoria`, `id_proveedor`, `id_user`)
    ) ENGINE=InnoDB

CREATE TABLE `clientes`
(
    `id_cliente` int(11) NOT NULL AUTO_INCREMENT,
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
    PRIMARY KEY (`Id_cliente`),
    CONSTRAINT FOREIGN KEY (`id_categoria`, `id_user`) REFERENCES `categorias`, `users` (`id_categoria`, `id_user` )
) ENGINE=InnoDB

CREATE TABLE `proveedores`
(
    `id_proveedor` int(11) NOT NULL AUTO_INCREMENT,
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
    PRIMARY KEY (`Id_proveedor`),
    CONSTRAINT FOREIGN KEY (`id_categoria`, `id_user`) REFERENCES `categorias`, `users` (`id_categoria` , `id_user`)
) ENGINE =InnoDB

CREATE TABLE `productos`
(
    `id_producto` int(11) NOT NULL AUTO_INCREMENT,
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
    PRIMARY KEY (`Id_producto`),
    CONSTRAINT FOREIGN KEY (`id_proveedor`, `id_categoria`, `id_user`) REFERENCES `proveedores`, ` categorias`, `users` (`id_proveedor`, `id_categoria`, `id_user`)
) ENGINE =InnoDB

/*Para crear la base de datos y crear las tablas en mysql debes importar este documento*/