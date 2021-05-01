-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema cestaCcheia
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema cestaCcheia
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `cestaCcheia` DEFAULT CHARACTER SET utf8 ;
USE `cestaCcheia` ;

-- -----------------------------------------------------
-- Table `cestaCcheia`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cestaCcheia`.`usuario` (
  `id` INT NOT NULL,
  `nome` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  `senha` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cestaCcheia`.`Produto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cestaCcheia`.`Produto` (
  `cod_produto` INT NOT NULL,
  `nome_produto` VARCHAR(45) NULL,
  `valor` VARCHAR(45) NULL,
  `favorito` TINYINT NULL,
  PRIMARY KEY (`cod_produto`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cestaCcheia`.`Cesta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cestaCcheia`.`Cesta` (
  `id` INT NOT NULL,
  `produtos` INT NOT NULL,
  `data` DATETIME NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Cesta_Produto1_idx` (`produtos` ASC) VISIBLE,
  CONSTRAINT `fk_Cesta_Produto1`
    FOREIGN KEY (`produtos`)
    REFERENCES `cestaCcheia`.`Produto` (`cod_produto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cestaCcheia`.`Lista`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cestaCcheia`.`Lista` (
  `id` INT NOT NULL,
  `data` DATETIME NULL,
  `cesta` INT NOT NULL,
  `usuario` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Lista_Cesta1_idx` (`cesta` ASC) VISIBLE,
  INDEX `fk_Lista_usuario1_idx` (`usuario` ASC) VISIBLE,
  CONSTRAINT `fk_Lista_Cesta1`
    FOREIGN KEY (`cesta`)
    REFERENCES `cestaCcheia`.`Cesta` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Lista_usuario1`
    FOREIGN KEY (`usuario`)
    REFERENCES `cestaCcheia`.`usuario` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cestaCcheia`.`mercado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cestaCcheia`.`mercado` (
  `id` INT NOT NULL,
  `nome` VARCHAR(45) NULL,
  `endereco` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  `produtos` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_mercado_Produto_idx` (`produtos` ASC) VISIBLE,
  CONSTRAINT `fk_mercado_Produto`
    FOREIGN KEY (`produtos`)
    REFERENCES `cestaCcheia`.`Produto` (`cod_produto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cestaCcheia`.`compra`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cestaCcheia`.`compra` (
  `id` INT NOT NULL,
  `data` DATETIME NULL,
  `usuario` INT NOT NULL,
  `cesta` INT NOT NULL,
  `forma_pagamento` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_compra_usuario1_idx` (`usuario` ASC) VISIBLE,
  INDEX `fk_compra_Cesta1_idx` (`cesta` ASC) VISIBLE,
  CONSTRAINT `fk_compra_usuario1`
    FOREIGN KEY (`usuario`)
    REFERENCES `cestaCcheia`.`usuario` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_compra_Cesta1`
    FOREIGN KEY (`cesta`)
    REFERENCES `cestaCcheia`.`Cesta` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cestaCcheia`.`historico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cestaCcheia`.`historico` (
  `id` INT NOT NULL,
  `data` DATETIME NULL,
  `usuario` INT NOT NULL,
  `compra` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_historico_usuario1_idx` (`usuario` ASC) VISIBLE,
  INDEX `fk_historico_compra1_idx` (`compra` ASC) VISIBLE,
  CONSTRAINT `fk_historico_usuario1`
    FOREIGN KEY (`usuario`)
    REFERENCES `cestaCcheia`.`usuario` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_historico_compra1`
    FOREIGN KEY (`compra`)
    REFERENCES `cestaCcheia`.`compra` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
