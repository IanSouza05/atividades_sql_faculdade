CREATE DATABASE bd_musica;
USE bd_musica;

-- tabela compositores --
CREATE TABLE IF NOT EXISTS tb_compositor(
	id_compositor		INT		NOT NULL	AUTO_INCREMENT,
    nome_compositor		VARCHAR(100)		NOT NULL,
    PRIMARY KEY(id_compositor)
);

-- tabela estilos musicais --
CREATE TABLE IF NOT EXISTS tb_estilo(
	id_estilo			INT		NOT NULL	AUTO_INCREMENT,
    descricao_estilo	VARCHAR(100)		NOT NULL,
    PRIMARY KEY(id_estilo)
);

-- tabela das musicass --
CREATE TABLE IF NOT EXISTS tb_musica(
	id_musica			INT 	NOT NULL	AUTO_INCREMENT,
    nome_musica			VARCHAR(100)		NOT NULL,
    ano_musica			INT					DEFAULT NULL,
    id_estilo_fk		INT					DEFAULT NULL,
    PRIMARY KEY(id_musica),
    FOREIGN KEY	(id_estilo_fk) REFERENCES tb_estilo(id_estilo)
);

-- tabela que relaciona os compositores com as mucisas --
CREATE TABLE IF NOT EXISTS tb_compositor_musica(
	id_compositor		INT		NOT NULL,
    id_musica			INT     NOT NULL,
	PRIMARY KEY(id_compositor, id_musica),
    FOREIGN KEY(id_compositor) REFERENCES tb_compositor(id_compositor),
    FOREIGN KEY(id_musica) REFERENCES tb_musica(id_musica)
);






