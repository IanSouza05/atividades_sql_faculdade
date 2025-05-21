-- Criação do banco de dados
CREATE DATABASE IF NOT EXISTS `cinema` DEFAULT CHARACTER SET utf8;
USE `cinema`;

-- =======================
-- TABELA: genero
-- =======================
DROP TABLE IF EXISTS `genero`;
CREATE TABLE `genero` (
  `idgenero` INT(11) NOT NULL,
  `descricao` VARCHAR(60) NOT NULL,
  PRIMARY KEY (`idgenero`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `genero` VALUES 
(1,'Ação'),
(2,'Suspense'),
(3,'Drama'),
(4,'Policial');

-- =======================
-- TABELA: ator
-- =======================
DROP TABLE IF EXISTS `ator`;
CREATE TABLE `ator` (
  `idator` INT(11) NOT NULL,
  `nome` VARCHAR(300) NOT NULL,
  PRIMARY KEY (`idator`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `ator` VALUES 
(1,'Brad Pit'),
(2,'Angelina Jolie'),
(3,'Jennifer Aniston'),
(4,'Gwyneth Paltrow'),
(5,'Robert John Downey');

-- =======================
-- TABELA: filme
-- =======================
DROP TABLE IF EXISTS `filme`;
CREATE TABLE `filme` (
  `idfilme` INT(11) NOT NULL,
  `titulo` VARCHAR(200) NOT NULL,
  `duracao` TIME NOT NULL,
  `genero_idgenero` INT(11) NOT NULL,
  PRIMARY KEY (`idfilme`, `genero_idgenero`),
  KEY `fk_filme_genero1_idx` (`genero_idgenero`),
  CONSTRAINT `fk_filme_genero1` FOREIGN KEY (`genero_idgenero`) REFERENCES `genero` (`idgenero`)
    ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `filme` VALUES 
(101,'Velozes e Furiosos','01:50:00',1),
(102,'Homens de Ferro','02:00:00',1),
(103,'Batman','02:12:00',1),
(104,'O Poderoso Chefão','01:45:00',4);

-- =======================
-- TABELA: sala
-- =======================
DROP TABLE IF EXISTS `sala`;
CREATE TABLE `sala` (
  `idsala` INT(11) NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  `qtdeAssento` INT(11) NOT NULL,
  PRIMARY KEY (`idsala`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `sala` VALUES 
(100,'Sala A',80),
(200,'Sala B',100),
(300,'Sala C',90),
(400,'Sala D',80);

-- =======================
-- TABELA: elenco
-- =======================
DROP TABLE IF EXISTS `elenco`;
CREATE TABLE `elenco` (
  `filme_idfilme` INT(11) NOT NULL,
  `filme_genero_idgenero` INT(11) NOT NULL,
  `ator_idator` INT(11) NOT NULL,
  `nomeNoFilme` VARCHAR(95) NOT NULL,
  PRIMARY KEY (`filme_idfilme`, `filme_genero_idgenero`, `ator_idator`),
  KEY `fk_filme_has_ator_ator1_idx` (`ator_idator`),
  KEY `fk_filme_has_ator_filme1_idx` (`filme_idfilme`, `filme_genero_idgenero`),
  CONSTRAINT `fk_filme_has_ator_ator1` FOREIGN KEY (`ator_idator`) REFERENCES `ator` (`idator`)
    ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_filme_has_ator_filme1` FOREIGN KEY (`filme_idfilme`, `filme_genero_idgenero`) REFERENCES `filme` (`idfilme`, `genero_idgenero`)
    ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- (Nenhum dado fornecido para elenco, então não há INSERTs)

-- =======================
-- TABELA: sessao (corrigida)
-- =======================
DROP TABLE IF EXISTS `sessao`;
CREATE TABLE `sessao` (
  `id_sessao`	INT    NOT NULL,
  `sala_idsala` INT(11) NOT NULL,
  `filme_idfilme` INT(11) NOT NULL,
  `filme_genero_idgenero` INT(11) NOT NULL,
  `dataHora` DATETIME NOT NULL,
  `qtdeVendidos` INT(11) NOT NULL,
  PRIMARY KEY (`sala_idsala`, `filme_idfilme`, `dataHora`),
  KEY `fk_sala_has_filme_filme1_idx` (`filme_idfilme`, `filme_genero_idgenero`),
  KEY `fk_sala_has_filme_sala_idx` (`sala_idsala`),
  CONSTRAINT `fk_sala_has_filme_filme1` FOREIGN KEY (`filme_idfilme`, `filme_genero_idgenero`)
    REFERENCES `filme` (`idfilme`, `genero_idgenero`)
    ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_sala_has_filme_sala` FOREIGN KEY (`sala_idsala`)
    REFERENCES `sala` (`idsala`)
    ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `sessao` 
(`id_sessao`, `sala_idsala`, `filme_idfilme`, `filme_genero_idgenero`, `dataHora`, `qtdeVendidos`)
VALUES 
(1, 100, 103, 1, '2018-08-06 14:00:00', 50),
(2, 100, 104, 4, '2018-08-06 18:00:00', 70),
(3, 200, 103, 1, '2018-08-06 20:00:00', 60),
(4, 200, 104, 4, '2018-08-06 23:00:00', 80);
