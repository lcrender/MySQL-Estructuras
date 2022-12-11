DROP DATABASE IF EXISTS `spoty`;
CREATE DATABASE `spoty`;
USE `spoty`;
CREATE TABLE `paises` (
  `id` int NOT NULL AUTO_INCREMENT,
  `pais` varchar(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id.pais_UNIQUE` (`id`)
);
CREATE TABLE `paypal` (
  `id` int NOT NULL AUTO_INCREMENT,
  `usuario` varchar(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id.paypal_UNIQUE` (`id`)
);
CREATE TABLE `tarjetas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `numero` int NOT NULL,
  `vencimiento` datetime NOT NULL,
  `codigo` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id.tarjetas_UNIQUE` (`id`)
);
CREATE TABLE `suscripcion` (
  `id` int NOT NULL AUTO_INCREMENT,
  `fecha_inicio` datetime NOT NULL,
  `fecha_renovacion` datetime NOT NULL,
  `forma_pago` tinyint(1) NOT NULL,
  `id_tarjeta` int DEFAULT NULL,
  `id_paypal` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id.suscripcion_UNIQUE` (`id`),
  KEY `fk_tarjeta_idx` (`id_tarjeta`),
  KEY `fk_paypal_idx` (`id_paypal`),
  CONSTRAINT `fk_paypal` FOREIGN KEY (`id_paypal`) REFERENCES `paypal` (`id`),
  CONSTRAINT `fk_tarjeta` FOREIGN KEY (`id_tarjeta`) REFERENCES `tarjetas` (`id`)
);
CREATE TABLE `usuarios` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(45) NOT NULL,
  `password` varchar(45) NOT NULL,
  `usuario` varchar(45) NOT NULL,
  `fecha_nacimiento` datetime NOT NULL,
  `sexo` tinyint NOT NULL,
  `id_pais` int NOT NULL,
  `cp` int NOT NULL,
  `premium` tinyint NOT NULL,
  `id_suscripcion` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id.usuario_UNIQUE` (`id`),
  KEY `fk_pais_idx` (`id_pais`),
  KEY `fk_suscripcion_idx` (`id_suscripcion`),
  CONSTRAINT `fk_pais` FOREIGN KEY (`id_pais`) REFERENCES `paises` (`id`),
  CONSTRAINT `fk_suscripcion` FOREIGN KEY (`id_suscripcion`) REFERENCES `suscripcion` (`id`)
);
CREATE TABLE `artistas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) NOT NULL,
  `imagen` varchar(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id.artista_UNIQUE` (`id`)
);
CREATE TABLE `artistas_similares` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_artista` int NOT NULL,
  `id_artista_simil` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id.artista.similar_UNIQUE` (`id`),
  KEY `fk_sartista_idx` (`id_artista`),
  KEY `fk_simil_idx` (`id_artista_simil`),
  CONSTRAINT `fk_sartista` FOREIGN KEY (`id_artista`) REFERENCES `artistas` (`id`),
  CONSTRAINT `fk_simil` FOREIGN KEY (`id_artista_simil`) REFERENCES `artistas` (`id`)
);
CREATE TABLE `albums` (
  `id` int NOT NULL AUTO_INCREMENT,
  `titulo` varchar(45) NOT NULL,
  `id_artista` int NOT NULL,
  `creacion` datetime NOT NULL,
  `imagen` varchar(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id.album_UNIQUE` (`id`),
  KEY `fk_artista_idx` (`id_artista`),
  CONSTRAINT `fk_artista` FOREIGN KEY (`id_artista`) REFERENCES `artistas` (`id`)
);
CREATE TABLE `albumes_favoritos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_album` int NOT NULL,
  `id_usuario` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id.album.favorito_UNIQUE` (`id`),
  KEY `fk_falbumes_idx` (`id_album`),
  KEY `fk_fusuario_idx` (`id_usuario`),
  CONSTRAINT `fk_falbumes` FOREIGN KEY (`id_album`) REFERENCES `albums` (`id`),
  CONSTRAINT `fk_fusuario` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`)
);

CREATE TABLE `cancion` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_album` int NOT NULL,
  `titulo` varchar(45) NOT NULL,
  `duracion` datetime NOT NULL,
  `reproducciones` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id.cancion_UNIQUE` (`id`),
  KEY `fk_calbum_idx` (`id_album`),
  CONSTRAINT `fk_calbum` FOREIGN KEY (`id_album`) REFERENCES `albums` (`id`)
);
CREATE TABLE `canciones_favoritas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_usuario` int NOT NULL,
  `id_cancion` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id.cancion.favorita_UNIQUE` (`id`),
  KEY `fk_cfusuario_idx` (`id_usuario`),
  KEY `fk_cfcancion_idx` (`id_cancion`),
  CONSTRAINT `fk_cfcancion` FOREIGN KEY (`id_cancion`) REFERENCES `cancion` (`id`),
  CONSTRAINT `fk_cfusuario` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`)
);



CREATE TABLE `playlists` (
  `id` int NOT NULL AUTO_INCREMENT,
  `titulo` varchar(45) NOT NULL,
  `n_canciones` int NOT NULL,
  `fecha_creacion` datetime NOT NULL,
  `id_usuario` int NOT NULL,
  `eliminada` tinyint(1) NOT NULL,
  `fecha_eliminada` datetime DEFAULT NULL,
  `compartida` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id.playlist_UNIQUE` (`id`),
  KEY `fk_pusuario_idx` (`id_usuario`),
  CONSTRAINT `fk_pusuario` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`)
);
CREATE TABLE `playlists_compartidas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_usuario` int NOT NULL,
  `fecha_update` datetime NOT NULL,
  `id_playlist` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id.playlist.compartida_UNIQUE` (`id`),
  KEY `fk_pcusuario_idx` (`id_usuario`),
  KEY `fk_pcplaylist_idx` (`id_playlist`),
  CONSTRAINT `fk_pcplaylist` FOREIGN KEY (`id_playlist`) REFERENCES `playlists` (`id`),
  CONSTRAINT `fk_pcusuario` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`)
);
CREATE TABLE `seguidos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_usuario` int NOT NULL,
  `id_artista` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id.seguido_UNIQUE` (`id`),
  KEY `sk_susuario_idx` (`id_usuario`),
  KEY `fk_scartista_idx` (`id_artista`),
  CONSTRAINT `fk_scartista` FOREIGN KEY (`id_artista`) REFERENCES `artistas` (`id`),
  CONSTRAINT `fk_susuario` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`)
);


CREATE TABLE `pagos` (
  `numero_orden` int NOT NULL AUTO_INCREMENT,
  `id_suscripcion` int NOT NULL,
  `total` float NOT NULL,
  PRIMARY KEY (`numero_orden`),
  UNIQUE KEY `id.pagos_UNIQUE` (`numero_orden`),
  KEY `fk_psuscripcion_idx` (`id_suscripcion`),
  CONSTRAINT `fk_psuscripcion` FOREIGN KEY (`id_suscripcion`) REFERENCES `suscripcion` (`id`)
);
