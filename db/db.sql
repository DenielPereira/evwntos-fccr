-- MySQL Script generated by MySQL Workbench
-- Mon Sep 24 08:55:51 2018
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema eventos_fccr
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema eventos_fccr
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `eventos_fccr` DEFAULT CHARACTER SET utf8 ;
USE `eventos_fccr` ;

-- -----------------------------------------------------
-- Table `eventos_fccr`.`Usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eventos_fccr`.`Usuario` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(255) NOT NULL,
  `sobrenome` VARCHAR(255) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `senha` VARCHAR(255) NOT NULL,
  `nascimento` DATE NOT NULL,
  `sexo` CHAR(1) NOT NULL,
  `admin` TINYINT NULL DEFAULT 0,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `eventos_fccr`.`Eventos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eventos_fccr`.`Eventos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `titulo` VARCHAR(255) NOT NULL,
  `local` VARCHAR(255) NOT NULL,
  `endereco` VARCHAR(255) NOT NULL,
  `inicio` TIMESTAMP NOT NULL,
  `fim` TIMESTAMP NOT NULL,
  `criador` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Eventos_Usuario_idx` (`criador` ASC),
  CONSTRAINT `fk_Eventos_Usuario`
    FOREIGN KEY (`criador`)
    REFERENCES `eventos_fccr`.`Usuario` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `eventos_fccr`.`participantes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eventos_fccr`.`participantes` (
  `Eventos_id` INT NOT NULL,
  `Usuario_id` INT NOT NULL,
  PRIMARY KEY (`Eventos_id`, `Usuario_id`),
  INDEX `fk_Eventos_has_Usuario_Usuario1_idx` (`Usuario_id` ASC),
  INDEX `fk_Eventos_has_Usuario_Eventos1_idx` (`Eventos_id` ASC),
  CONSTRAINT `fk_Eventos_has_Usuario_Eventos1`
    FOREIGN KEY (`Eventos_id`)
    REFERENCES `eventos_fccr`.`Eventos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Eventos_has_Usuario_Usuario1`
    FOREIGN KEY (`Usuario_id`)
    REFERENCES `eventos_fccr`.`Usuario` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `eventos_fccr`.`fotos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eventos_fccr`.`fotos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(255) NOT NULL,
  `conteudo` LONGBLOB NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `eventos_fccr`.`fotos_evento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eventos_fccr`.`fotos_evento` (
  `fotos_id` INT NOT NULL,
  `Eventos_id` INT NOT NULL,
  `Usuario_id` INT NOT NULL,
  PRIMARY KEY (`fotos_id`, `Eventos_id`),
  INDEX `fk_fotos_has_Eventos_Eventos1_idx` (`Eventos_id` ASC),
  INDEX `fk_fotos_has_Eventos_fotos1_idx` (`fotos_id` ASC),
  INDEX `fk_fotos_evento_Usuario1_idx` (`Usuario_id` ASC),
  CONSTRAINT `fk_fotos_has_Eventos_fotos1`
    FOREIGN KEY (`fotos_id`)
    REFERENCES `eventos_fccr`.`fotos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_fotos_has_Eventos_Eventos1`
    FOREIGN KEY (`Eventos_id`)
    REFERENCES `eventos_fccr`.`Eventos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_fotos_evento_Usuario1`
    FOREIGN KEY (`Usuario_id`)
    REFERENCES `eventos_fccr`.`Usuario` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `eventos_fccr`.`comentario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eventos_fccr`.`comentario` (
  `Eventos_id` INT NOT NULL,
  `Usuario_id` INT NOT NULL,
  `comentario` LONGTEXT NULL,
  PRIMARY KEY (`Eventos_id`, `Usuario_id`),
  INDEX `fk_Eventos_has_Usuario_Usuario2_idx` (`Usuario_id` ASC),
  INDEX `fk_Eventos_has_Usuario_Eventos2_idx` (`Eventos_id` ASC),
  CONSTRAINT `fk_Eventos_has_Usuario_Eventos2`
    FOREIGN KEY (`Eventos_id`)
    REFERENCES `eventos_fccr`.`Eventos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Eventos_has_Usuario_Usuario2`
    FOREIGN KEY (`Usuario_id`)
    REFERENCES `eventos_fccr`.`Usuario` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;