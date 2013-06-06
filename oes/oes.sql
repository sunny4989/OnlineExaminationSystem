SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

SHOW WARNINGS;
DROP SCHEMA IF EXISTS `oes` ;
CREATE SCHEMA IF NOT EXISTS `oes` DEFAULT CHARACTER SET latin1 ;
SHOW WARNINGS;
USE `oes` ;

-- -----------------------------------------------------
-- Table `oes`.`exam_student`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `oes`.`exam_student` ;

SHOW WARNINGS;
CREATE  TABLE IF NOT EXISTS `oes`.`exam_student` (
  `examId` INT(11) NOT NULL ,
  `iduser` CHAR(17) NOT NULL ,
  `status` VARCHAR(45) NULL DEFAULT NULL ,
  PRIMARY KEY (`examId`, `iduser`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `oes`.`question`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `oes`.`question` ;

SHOW WARNINGS;
CREATE  TABLE IF NOT EXISTS `oes`.`question` (
  `questionId` INT(11) NOT NULL AUTO_INCREMENT ,
  `question` VARCHAR(245) NOT NULL ,
  `a` VARCHAR(145) NOT NULL ,
  `b` VARCHAR(145) NOT NULL ,
  `c` VARCHAR(145) NOT NULL ,
  `d` VARCHAR(145) NOT NULL ,
  `ans` VARCHAR(6) NOT NULL ,
  `level` VARCHAR(10) NOT NULL ,
  `subject` VARCHAR(25) NOT NULL ,
  PRIMARY KEY (`questionId`) )
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = latin1;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `oes`.`schedule`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `oes`.`schedule` ;

SHOW WARNINGS;
CREATE  TABLE IF NOT EXISTS `oes`.`schedule` (
  `examId` INT(11) NOT NULL AUTO_INCREMENT ,
  `date` DATE NOT NULL ,
  `time` TIME NOT NULL ,
  `tLimit` TIME NOT NULL ,
  `level` VARCHAR(10) NOT NULL ,
  `subject` VARCHAR(25) NOT NULL ,
  `NOQ` INT(11) NOT NULL ,
  PRIMARY KEY (`examId`) )
ENGINE = InnoDB
AUTO_INCREMENT = 12
DEFAULT CHARACTER SET = latin1;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `oes`.`user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `oes`.`user` ;

SHOW WARNINGS;
CREATE  TABLE IF NOT EXISTS `oes`.`user` (
  `name` VARCHAR(45) NOT NULL ,
  `iduser` CHAR(17) NOT NULL ,
  `password` VARCHAR(45) NOT NULL ,
  `gender` VARCHAR(6) NOT NULL ,
  `address` VARCHAR(145) NOT NULL ,
  `mobileNo` VARCHAR(13) NULL DEFAULT NULL ,
  `emailId` VARCHAR(27) NULL DEFAULT NULL ,
  `type` VARCHAR(10) NOT NULL ,
  `security` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`iduser`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Placeholder table for view `oes`.`paper`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oes`.`paper` (`questionId` INT, `question` INT, `a` INT, `b` INT, `c` INT, `d` INT, `ans` INT, `level` INT, `subject` INT);
SHOW WARNINGS;

-- -----------------------------------------------------
-- View `oes`.`paper`
-- -----------------------------------------------------
DROP VIEW IF EXISTS `oes`.`paper` ;
SHOW WARNINGS;
DROP TABLE IF EXISTS `oes`.`paper`;
SHOW WARNINGS;
USE `oes`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `oes`.`paper` AS select `oes`.`question`.`questionId` AS `questionId`,`oes`.`question`.`question` AS `question`,`oes`.`question`.`a` AS `a`,`oes`.`question`.`b` AS `b`,`oes`.`question`.`c` AS `c`,`oes`.`question`.`d` AS `d`,`oes`.`question`.`ans` AS `ans`,`oes`.`question`.`level` AS `level`,`oes`.`question`.`subject` AS `subject` from `oes`.`question` where ((`oes`.`question`.`level` = 'medium') and (`oes`.`question`.`subject` = 'computer')) order by rand();
SHOW WARNINGS;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
