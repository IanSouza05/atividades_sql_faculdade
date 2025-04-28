-- 01 Crie uma trigger que registre na tabela tb_historico sempre que uma nova música for inserida no banco --

-- criação de tb_historico --
CREATE TABLE IF NOT EXISTS tb_historico(
	id_historico		INT		AUTO_INCREMENT,
    hist_data			DATETIME,
    acao				VARCHAR(20),
    id_musica_fk		INT,
    PRIMARY KEY(id_historico)
);

DELIMITER $$
CREATE TRIGGER trg_insert_tb_historico AFTER INSERT ON tb_musica FOR EACH ROW
BEGIN 
	INSERT INTO tb_historico (hist_data, acao, id_musica_fk)
    VALUES (now(), 'INSERT', new.id_musica);
END;
$$
DELIMITER ;


-- 02 Crie uma trigger que insira "Música recente" ou "Música antiga" na tabela tb_historico, 
-- dependendo do ano da música inserida. – Se música > 2020 música recente. --

-- apagando a trigger anterior, inserindo o tipo_musica na tabela tb_historico e refazendo a trigger --
DROP TRIGGER trg_insert_tb_historico;
ALTER TABLE tb_historico ADD tipo_musica ENUM('recente', 'antiga');

DELIMITER $$
CREATE TRIGGER trg_insert_tb_historico AFTER INSERT ON tb_musica FOR EACH ROW
BEGIN
	DECLARE tipo VARCHAR(10);
    IF new.ano_musica > 2020 THEN 
		SET tipo = 'recente';
	ELSE 
		SET	tipo = 'antiga';
	END IF;
INSERT INTO tb_historico (hist_data, acao, id_musica_fk, tipo_musica)
VALUES (now(), 'INSERT', new.id_musica, tipo);
END;
$$
DELIMITER ;


-- 03 Crie uma trigger que registre "Música de Forró adicionada" quando uma música com o estilo Forró
-- (código 5) for inserida. --

-- recriando a trigger para informar o estilo da musica e adicionando uma coluna que mostra o estilo adicionado --
DROP TRIGGER trg_insert_tb_historico;
ALTER TABLE tb_historico ADD descricao VARCHAR(100);

DELIMITER $$
CREATE TRIGGER trg_tb_historico AFTER INSERT ON tb_musica FOR EACH ROW
BEGIN
	DECLARE tipo VARCHAR(10);
    DECLARE estilo varchar(20);
		-- verifica se é recente ou antiga --
		IF new.ano_musica > 2020 THEN 
			SET tipo = 'recente';
		ELSE 
			SET	tipo = 'antiga';
		END IF;
        -- verifica o estilo da musica --
		IF new.id_estilo_fk = 1 THEN
			SET estilo = 'MPB';
		ELSEIF new.id_estilo_fk = 2 THEN
			SET estilo = 'Pop';
		ELSEIF new.id_estilo_fk = 3 THEN
			SET estilo = 'Funk';
		ELSEIF new.id_estilo_fk = 4 THEN
			SET estilo = 'Sertanejo';
		ELSE
			SET estilo = 'Forró';
	END IF;
INSERT INTO tb_historico (hist_data, acao, id_musica_fk, tipo_musica, descricao)
VALUES (now(), 'INSERT', new.id_musica, tipo, concat('Musica de ', estilo, ' adicionada'));
END;
$$
DELIMITER ;

	
 -- 04 Crie uma trigger que, ao deletar uma música, registre no histórico a mensagem: "Música deletada: <titulo>"  --
 
 DELIMITER $$
 CREATE TRIGGER trg_delete_tb_historico AFTER DELETE ON tb_musica FOR EACH ROW
 BEGIN
	DECLARE tipo VARCHAR(10);
		-- verifica se é recente ou antiga --
		IF old.ano_musica > 2020 THEN 
			SET tipo = 'recente';
		ELSE 
			SET	tipo = 'antiga';
		END IF;
INSERT INTO tb_historico (hist_data, acao, id_musica_fk, tipo_musica, descricao)
VALUES (now(), 'DELETE', old.id_musica, tipo, concat('Musica deletada: ', old.nome_musica));
END;
$$
DELIMITER ;


-- 05 Crie uma trigger que, ao atualizar o ano de uma música, registre no histórico: 
-- "Ano da músicam <titulo> alterado de <ano_antigo> para <ano_novo>" --

DELIMITER $$
CREATE TRIGGER trg_update_tb_historico AFTER UPDATE ON tb_musica FOR EACH ROW
BEGIN
	DECLARE tipo VARCHAR(10);
		-- verifica se é recente ou antiga --
		IF new.ano_musica > 2020 THEN 
			SET tipo = 'recente';
		ELSE 
			SET	tipo = 'antiga';
		END IF;
	INSERT INTO tb_historico(hist_data, acao, id_musica_fk, tipo_musica, descricao)
    VALUES (now(), 'UPDATE', old.id_musica, tipo, concat('Ano da musica ', old.nome_musica, ' alterado de ', old.ano_musica, ' para ', new.ano_musica));
END;
$$
DELIMITER ;


select * from tb_compositor;
select * from tb_musica;
select * from tb_estilo;
select * from tb_compositor_musica;
select * from tb_historico;



