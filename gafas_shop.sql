DROP DATABASE IF EXISTS `gafas_shop`;
CREATE DATABASE `gafas_shop`;
USE `gafas_shop`;
CREATE TABLE `direcciones` (
  `id` int NOT NULL AUTO_INCREMENT,
  `calle` varchar(128)  NOT NULL,
  `numero` int NOT NULL,
  `piso` varchar(20)  DEFAULT NULL,
  `puerta` varchar(20)  DEFAULT NULL,
  `ciudad` varchar(45)  NOT NULL,
  `cp` varchar(10)  NOT NULL,
  `pais` varchar(45)  NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
);
CREATE TABLE `proveedores` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(128)  NOT NULL,
  `id_direccion` int NOT NULL,
  `telefono` int DEFAULT NULL,
  `fax` int DEFAULT NULL,
  `nif` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `fk_direccion_idx` (`id_direccion`)
);
CREATE TABLE `clientes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(128)  NOT NULL,
  `id_direccion` int DEFAULT NULL,
  `telefono` varchar(13)  DEFAULT NULL,
  `email` varchar(60)  DEFAULT NULL,
  `fecha_registro` datetime DEFAULT NULL,
  `recomendado` int DEFAULT NULL,
  `id_cliente_recomendado` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id.clientes_UNIQUE` (`id`),
  KEY `fk_direccion_idx` (`id_direccion`),
  KEY `fk_usdireccion_idx` (`id_direccion`),
  KEY `fk_cliente_rec_idx` (`id_cliente_recomendado`),
  CONSTRAINT `fk_cliente_rec` FOREIGN KEY (`id_cliente_recomendado`) REFERENCES `clientes` (`id`),
  CONSTRAINT `fk_usdireccion` FOREIGN KEY (`id_direccion`) REFERENCES `direcciones` (`id`)
);
CREATE TABLE `empleados` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(128)  NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
);
CREATE TABLE `gafas_color_montura` (
  `id` int NOT NULL AUTO_INCREMENT,
  `montura` varchar(128)  NOT NULL,
  PRIMARY KEY (`id`)
);
CREATE TABLE `gafas_color_vidrio` (
  `id` int NOT NULL AUTO_INCREMENT,
  `color` varchar(128)  NOT NULL,
  PRIMARY KEY (`id`)
);
CREATE TABLE `gafas_cristal` (
  `id` int NOT NULL AUTO_INCREMENT,
  `graduacion` varchar(128)  NOT NULL,
  PRIMARY KEY (`id`)
);
CREATE TABLE `gafas_marca` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(128)  NOT NULL,
  `id_proveedor` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_proveedor_idx` (`id_proveedor`),
  CONSTRAINT `fk_proveedor` FOREIGN KEY (`id_proveedor`) REFERENCES `proveedores` (`id`)
);
CREATE TABLE `gafas_montura` (
  `id` int NOT NULL AUTO_INCREMENT,
  `montura` varchar(128)  NOT NULL,
  PRIMARY KEY (`id`)
);
CREATE TABLE `gafas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_marca` int NOT NULL,
  `id_cristal` int DEFAULT NULL,
  `id_montura` int DEFAULT NULL,
  `id_color_montura` int DEFAULT NULL,
  `id_color_vidrio` int DEFAULT NULL,
  `precio` float DEFAULT NULL,
  `id_proveedor` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idgafas_UNIQUE` (`id`),
  KEY `fk_marca_idx` (`id_marca`),
  KEY `fk_cristal_idx` (`id_cristal`),
  KEY `fk_montura_idx` (`id_montura`),
  KEY `fk_color_montura_idx` (`id_color_montura`),
  KEY `fk_color_vidrio_idx` (`id_color_vidrio`),
  KEY `fk_proveedor_idx` (`id_proveedor`),
  CONSTRAINT `fk_color_montura` FOREIGN KEY (`id_color_montura`) REFERENCES `gafas_color_montura` (`id`),
  CONSTRAINT `fk_color_vidrio` FOREIGN KEY (`id_color_vidrio`) REFERENCES `gafas_color_vidrio` (`id`),
  CONSTRAINT `fk_cristal` FOREIGN KEY (`id_cristal`) REFERENCES `gafas_cristal` (`id`),
  CONSTRAINT `fk_gproveedor` FOREIGN KEY (`id_proveedor`) REFERENCES `proveedores` (`id`),
  CONSTRAINT `fk_marca` FOREIGN KEY (`id_marca`) REFERENCES `gafas_marca` (`id`),
  CONSTRAINT `fk_montura` FOREIGN KEY (`id_montura`) REFERENCES `gafas_montura` (`id`)
);
CREATE TABLE `ventas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_gafa` int NOT NULL,
  `id_cliente` int NOT NULL,
  `id_empleado` int NOT NULL,
  `fecha` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id.venta_UNIQUE` (`id`),
  KEY `id_gafa_idx` (`id_gafa`),
  KEY `id_cliente_idx` (`id_cliente`),
  KEY `fk_empleado_idx` (`id_empleado`),
  CONSTRAINT `fk_cliente` FOREIGN KEY (`id_cliente`) REFERENCES `clientes` (`id`),
  CONSTRAINT `fk_empleado` FOREIGN KEY (`id_empleado`) REFERENCES `empleados` (`id`),
  CONSTRAINT `fk_gafa` FOREIGN KEY (`id_gafa`) REFERENCES `gafas` (`id`)
);

INSERT INTO `direcciones` VALUES (1,'Mitre',23,'1','2','Madrid','1231','España'),(2,'Gomez Bolaño',436,NULL,NULL,'Madrid','3232','España');
INSERT INTO `proveedores` VALUES (1,'Proveedor del Sur',1,600343203,2322232,45343),(2,'Proveedor del Norte',2,434343,2342423,43223);
INSERT INTO `empleados` VALUES (1,'Marcos Lopez'),(2,'Juanita Papusota'),(3,'Jasinto Gomez');
INSERT INTO `gafas_marca` VALUES (1,'Vulk',1),(2,'Reef',1),(3,'Volcom',2);
INSERT INTO `gafas` VALUES (1,1,NULL,NULL,NULL,NULL,100,1),(2,2,NULL,NULL,NULL,NULL,80,2),(3,3,NULL,NULL,NULL,NULL,120,1);
INSERT INTO `clientes` VALUES (1,'Alan',NULL,NULL,NULL,NULL,NULL,NULL),(2,'Diego',NULL,NULL,NULL,NULL,NULL,NULL),(3,'Jose',NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `ventas` VALUES (2,1,1,1,'2022-10-25 00:00:00'),(3,1,1,2,'2022-04-05 00:00:00'),(4,1,1,1,'2021-04-05 00:00:00'),(5,1,2,1,'2022-04-15 00:00:00'),(6,1,2,1,'2021-04-15 00:00:00');
