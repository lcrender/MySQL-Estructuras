DROP DATABASE IF EXISTS `comidas`;
CREATE DATABASE `comidas`;
USE `comidas`;
CREATE TABLE `direcciones` (
  `id` int NOT NULL AUTO_INCREMENT,
  `direccion` varchar(128) NOT NULL,
  `cp` int NOT NULL,
  `localidad` varchar(60) NOT NULL,
  `provincia` varchar(60) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
);
CREATE TABLE `tiendas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(128) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
);
CREATE TABLE `cat_productos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `categoria` varchar(128) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
);
CREATE TABLE `empleados` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(60) NOT NULL,
  `apellido` varchar(60) NOT NULL,
  `nif` int NOT NULL,
  `telefono` int NOT NULL,
  `id_puesto` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  UNIQUE KEY `nif_UNIQUE` (`nif`)
);
CREATE TABLE `productos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(128) NOT NULL,
  `descripcion` varchar(300) NOT NULL,
  `imagen` varchar(128) DEFAULT NULL,
  `id_cat_productos` int NOT NULL,
  `precio` float NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `fk_cat_prod_idx` (`id_cat_productos`),
  CONSTRAINT `fk_cat_prod` FOREIGN KEY (`id_cat_productos`) REFERENCES `cat_productos` (`id`)
);
CREATE TABLE `clientes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(40) NOT NULL,
  `apellido` varchar(40) NOT NULL,
  `id_direccion` int NOT NULL,
  `telefono` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `fk_direccion_idx` (`id_direccion`),
  CONSTRAINT `fk_direccion` FOREIGN KEY (`id_direccion`) REFERENCES `direcciones` (`id`)
);
CREATE TABLE `pedidos` (
  `id_pedido` int NOT NULL AUTO_INCREMENT,
  `id_cliente` int NOT NULL,
  `fecha_hora` datetime NOT NULL,
  `envio` tinyint(1) NOT NULL,
  `id_direccion` int DEFAULT NULL,
  `id_tienda` int NOT NULL,
  `id_empleado` int NOT NULL,
  `hora_entrega` datetime NOT NULL,
  PRIMARY KEY (`id_pedido`),
  UNIQUE KEY `id_UNIQUE` (`id_pedido`),
  KEY `fk_pcliente_idx` (`id_cliente`),
  KEY `fk_pdireccion_idx` (`id_direccion`),
  KEY `fk_pempleado_idx` (`id_empleado`),
  KEY `fk_ptienda_idx` (`id_tienda`),
  CONSTRAINT `fk_pcliente` FOREIGN KEY (`id_cliente`) REFERENCES `clientes` (`id`),
  CONSTRAINT `fk_pdireccion` FOREIGN KEY (`id_direccion`) REFERENCES `direcciones` (`id`),
  CONSTRAINT `fk_pempleado` FOREIGN KEY (`id_empleado`) REFERENCES `empleados` (`id`),
  CONSTRAINT `fk_ptienda` FOREIGN KEY (`id_tienda`) REFERENCES `tiendas` (`id`)
);
CREATE TABLE `pedidos_detalles` (
  `id_pedido` int NOT NULL,
  `id_producto` int NOT NULL,
  `cantidad` int NOT NULL,
  `precio` float NOT NULL,
  `total` float NOT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `fk_dpedido_idx` (`id_pedido`),
  KEY `fk_dproducto_idx` (`id_producto`),
  CONSTRAINT `fk_dpedido` FOREIGN KEY (`id_pedido`) REFERENCES `pedidos` (`id_pedido`),
  CONSTRAINT `fk_dproducto` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id`)
);


CREATE TABLE `carrito` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_cliente` int NOT NULL,
  `id_producto` int NOT NULL,
  `cantidad` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `fk_producto_idx` (`id_producto`),
  KEY `fk_cliente_idx` (`id_cliente`),
  CONSTRAINT `fk_cliente` FOREIGN KEY (`id_cliente`) REFERENCES `clientes` (`id`),
  CONSTRAINT `fk_producto` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id`)
);



INSERT INTO `direcciones` VALUES (1,'Alem 232',1234,'Moron','Buenos Aires'),(2,'Rambla Juliana 322',88,'Barcelona','Barcelona'),(3,'Via Maria 2323',88,'Barcelona','Barcelona'),(4,'Maradona 99',121,'Las Toninas','Madrid');
INSERT INTO `tiendas` VALUES (1,'Tienda Norte'),(2,'Tienda Sur');
INSERT INTO `cat_productos` VALUES (1,'Bebidas'),(2,'Pizzas Napolitanas'),(3,'Pizzas Especiales'),(4,'Pizzas Integrales'),(5,'Hamburguesas');
INSERT INTO `productos` VALUES (1,'Tinto de verano','vino tinto de verano',NULL,1,10),(2,'Blue Burguer','Hamburguesa con queso azul',NULL,5,12),(3,'Pizza Margarita','Salsa de tomate, muzzarella, oregano',NULL,2,8),(4,'Pizza Napolitana','Salsa de tomate, muzzarella, tomate, oregano',NULL,2,9),(5,'Pizza Mc Queen Jr','Salsa de tomate, muzzarella, tomate, papas fritas, cebolla, morron, oregano',NULL,3,12),(6,'Pizza The Fat','Salsa de tomate, muzzarella, anana, papas fritas, dulce de leche, salsa golf, oregano',NULL,3,22),(7,'agua','agua de 1 litro marca Patito',NULL,1,1),(8,'Vino','Vino patero Catalan',NULL,1,2);
INSERT INTO `empleados` VALUES (1,'Jorge','Mangone',3432,600232340,0),(2,'Dario','Matarolo',1212,34322323,0),(3,'Matias','Figaro',12413,453435345,1),(5,'Juliana','Velazques',4343,43543534,0);
INSERT INTO `clientes` VALUES (1,'Jhony','Tolengo',1,32324433),(2,'Bruce','Lee',2,93939393),(3,'Enzo','Franchescoli',3,32432243),(4,'Lorenzo','Sanchez',4,34324324);
INSERT INTO `pedidos` VALUES (1,1,'2022-10-10 20:22:22',1,2,1,2,'2022-10-10 20:23:23'),(2,1,'2022-10-11 20:22:22',0,NULL,1,1,'2022-11-10 20:23:23'),(3,2,'2021-10-10 20:22:22',0,NULL,1,1,'2022-10-11 20:23:23');
INSERT INTO `pedidos_detalles` VALUES (1,2,5,6,30,1),(2,5,1,3,3,2),(3,3,4,4,16,3),(1,7,2,3,6,4);
INSERT INTO `carrito` VALUES (1,1,1,4);
