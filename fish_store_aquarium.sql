-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema fish_store_aquarium
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema fish_store_aquarium
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `fish_store_aquarium` DEFAULT CHARACTER SET utf8 ;
USE `fish_store_aquarium` ;

-- -----------------------------------------------------
-- Table `fish_store_aquarium`.`ticket`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fish_store_aquarium`.`ticket` (
  `ticket_num` INT NOT NULL AUTO_INCREMENT,
  `price` DECIMAL(10) NOT NULL DEFAULT 10.00,
  PRIMARY KEY (`ticket_num`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fish_store_aquarium`.`visitor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fish_store_aquarium`.`visitor` (
  `visitor_id` INT NOT NULL AUTO_INCREMENT,
  `age_group` VARCHAR(45) NOT NULL DEFAULT 'Adult',
  `last_name` VARCHAR(45) NOT NULL,
  `first_name` VARCHAR(45) NOT NULL,
  `ticket_num` INT NOT NULL,
  PRIMARY KEY (`visitor_id`, `ticket_num`),
  INDEX `fk_visitor_ticket_idx` (`ticket_num` ASC) VISIBLE,
  CONSTRAINT `fk_visitor_ticket`
    FOREIGN KEY (`ticket_num`)
    REFERENCES `fish_store_aquarium`.`ticket` (`ticket_num`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fish_store_aquarium`.`employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fish_store_aquarium`.`employee` (
  `employee_id` INT NOT NULL AUTO_INCREMENT,
  `last_name` VARCHAR(45) NOT NULL,
  `first_name` VARCHAR(45) NOT NULL,
  `department_id` VARCHAR(45) NOT NULL,
  `position` VARCHAR(45) NOT NULL,
  `hire_date` DATE NOT NULL,
  PRIMARY KEY (`employee_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fish_store_aquarium`.`customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fish_store_aquarium`.`customer` (
  `customer_id` INT NOT NULL AUTO_INCREMENT,
  `last_name` VARCHAR(45) NOT NULL,
  `first_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`customer_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fish_store_aquarium`.`order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fish_store_aquarium`.`order` (
  `order_num` INT NOT NULL AUTO_INCREMENT,
  `total` DECIMAL(10) NOT NULL,
  `num_items` INT NOT NULL,
  `employee_id` INT NOT NULL,
  `customer_id` INT NOT NULL,
  PRIMARY KEY (`order_num`, `employee_id`, `customer_id`),
  INDEX `fk_order_employee1_idx` (`employee_id` ASC) VISIBLE,
  INDEX `fk_order_customer1_idx` (`customer_id` ASC) VISIBLE,
  CONSTRAINT `fk_order_employee1`
    FOREIGN KEY (`employee_id`)
    REFERENCES `fish_store_aquarium`.`employee` (`employee_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_customer1`
    FOREIGN KEY (`customer_id`)
    REFERENCES `fish_store_aquarium`.`customer` (`customer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fish_store_aquarium`.`tank`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fish_store_aquarium`.`tank` (
  `tank_num` INT NOT NULL,
  `water_type` VARCHAR(45) NOT NULL,
  `volume_gal` DECIMAL(10) NOT NULL,
  PRIMARY KEY (`tank_num`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fish_store_aquarium`.`species`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fish_store_aquarium`.`species` (
  `species_id` INT NOT NULL AUTO_INCREMENT,
  `weight_g` DECIMAL(10) NOT NULL,
  `length_mm` DECIMAL(10) NOT NULL,
  `width_mm` DECIMAL(10) NOT NULL,
  `tank_num` INT NOT NULL,
  PRIMARY KEY (`species_id`, `tank_num`),
  INDEX `fk_species_tank1_idx` (`tank_num` ASC) VISIBLE,
  CONSTRAINT `fk_species_tank1`
    FOREIGN KEY (`tank_num`)
    REFERENCES `fish_store_aquarium`.`tank` (`tank_num`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fish_store_aquarium`.`inventory`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fish_store_aquarium`.`inventory` (
  `product_id` INT NOT NULL AUTO_INCREMENT,
  `count` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`product_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fish_store_aquarium`.`product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fish_store_aquarium`.`product` (
  `price` DECIMAL(10) NOT NULL,
  `product_type` VARCHAR(45) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `product_id` INT NOT NULL,
  PRIMARY KEY (`product_id`),
  INDEX `fk_product_inventory1_idx` (`product_id` ASC) VISIBLE,
  CONSTRAINT `fk_product_inventory1`
    FOREIGN KEY (`product_id`)
    REFERENCES `fish_store_aquarium`.`inventory` (`product_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
