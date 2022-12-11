DROP DATABASE IF EXISTS `yutub`;
CREATE DATABASE `yutub`;
USE `yutub`;
CREATE TABLE `paises` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
);
CREATE TABLE `canales` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(128) NOT NULL,
  `descripcion` varchar(400) DEFAULT NULL,
  `fecha_creacion` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
);
CREATE TABLE `etiquetas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id.etiqueta_UNIQUE` (`id`)
);
CREATE TABLE `grupo_etiquetas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_etiqueta` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `fk_etiquetas_idx` (`id_etiqueta`),
  CONSTRAINT `fk_etiquetas` FOREIGN KEY (`id_etiqueta`) REFERENCES `etiquetas` (`id`)
);
CREATE TABLE `likes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `like_dislike` tinyint NOT NULL,
  `fecha` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
);
CREATE TABLE `usuario_playlists` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_usuario` int NOT NULL,
  `nombre` varchar(128) NOT NULL,
  `fecha` datetime NOT NULL,
  `estado` tinyint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id.usuario.playlist_UNIQUE` (`id`),
  KEY `fk_usplusuario_idx` (`id_usuario`)
);
CREATE TABLE `playlists` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_video` int NOT NULL,
  `id_usuario_playlist` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id.playlist_UNIQUE` (`id`),
  KEY `fk_plvideo_idx` (`id_video`),
  KEY `fk_pusuarioplaylist_idx` (`id_usuario_playlist`),
  CONSTRAINT `fk_pusuarioplaylist` FOREIGN KEY (`id_usuario_playlist`) REFERENCES `usuario_playlists` (`id`)
);
CREATE TABLE `suscripciones` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_usuario` int NOT NULL,
  `id_canal` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id.suscripcion_UNIQUE` (`id`),
  KEY `fk_susuario_idx` (`id_usuario`),
  KEY `fk_scanal_idx` (`id_canal`),
  CONSTRAINT `fk_scanal` FOREIGN KEY (`id_canal`) REFERENCES `canales` (`id`)
);
CREATE TABLE `usuarios` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(128) NOT NULL,
  `password` varchar(128) NOT NULL,
  `nombre_de_usuario` varchar(128) NOT NULL,
  `fecha_nacimiento` datetime NOT NULL,
  `sexo` int NOT NULL,
  `id_pais` int NOT NULL,
  `cp` int NOT NULL,
  `id_likes` int DEFAULT NULL,
  `id_suscripciones` int DEFAULT NULL,
  `id_playlists` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id.usuario_UNIQUE` (`id`),
  KEY `fk_pais_idx` (`id_pais`),
  KEY `fk_ulikes_idx` (`id_likes`),
  KEY `fk_ususcripciones_idx` (`id_suscripciones`),
  KEY `fk_usplaylist_idx` (`id_playlists`),
  CONSTRAINT `fk_pais` FOREIGN KEY (`id_pais`) REFERENCES `paises` (`id`),
  CONSTRAINT `fk_ulikes` FOREIGN KEY (`id_likes`) REFERENCES `likes` (`id`),
  CONSTRAINT `fk_usplaylist` FOREIGN KEY (`id_playlists`) REFERENCES `playlists` (`id`),
  CONSTRAINT `fk_ususcripciones` FOREIGN KEY (`id_suscripciones`) REFERENCES `suscripciones` (`id`)
);
CREATE TABLE `videos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_usuario` int NOT NULL,
  `titulo` varchar(60) NOT NULL,
  `descripcion` varchar(400) DEFAULT NULL,
  `tamaño` int NOT NULL,
  `nombre_archivo` varchar(128) NOT NULL,
  `duracion` int NOT NULL,
  `thumbail` varchar(45) NOT NULL,
  `reproducciones` int NOT NULL,
  `likes` int NOT NULL,
  `dislikes` int NOT NULL,
  `estado` tinyint NOT NULL,
  `id_grupo_etiquetas` int DEFAULT NULL,
  `fecha_publicacion` datetime NOT NULL,
  `id_canal` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id.videos_UNIQUE` (`id`),
  KEY `fk_vusuario_idx` (`id_usuario`),
  KEY `fk_vgetiquetas_idx` (`id_grupo_etiquetas`),
  KEY `fk_vcanal_idx` (`id_canal`),
  CONSTRAINT `fk_vcanal` FOREIGN KEY (`id_canal`) REFERENCES `canales` (`id`),
  CONSTRAINT `fk_vgetiquetas` FOREIGN KEY (`id_grupo_etiquetas`) REFERENCES `grupo_etiquetas` (`id`),
  CONSTRAINT `fk_vusuario` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`)
);
CREATE TABLE `comentarios` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_video` int NOT NULL,
  `id_usuario` int NOT NULL,
  `comentario` varchar(300) NOT NULL,
  `fecha` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id.comentario_UNIQUE` (`id`),
  KEY `fk_comvideos_idx` (`id_video`),
  KEY `fk_comusuario_idx` (`id_usuario`),
  CONSTRAINT `fk_comusuario` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`),
  CONSTRAINT `fk_comvideos` FOREIGN KEY (`id_video`) REFERENCES `videos` (`id`)
);
CREATE TABLE `likes_comentarios` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_comentario` int NOT NULL,
  `id_usuario` int NOT NULL,
  `like_dislike` tinyint NOT NULL,
  `fecha` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id.like.comentario_UNIQUE` (`id`),
  KEY `fk_lcusuario_idx` (`id_usuario`),
  KEY `fklccomentario_idx` (`id_comentario`),
  CONSTRAINT `fk_lcusuario` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`),
  CONSTRAINT `fklccomentario` FOREIGN KEY (`id_comentario`) REFERENCES `comentarios` (`id`)
);