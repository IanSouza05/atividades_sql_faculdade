-- inserção dos compositores --
INSERT INTO tb_compositor(nome_compositor) VALUES
	('Tom Jobim'),
    ('Vinícius de Moraes'),
	('Chico Buarque'),
	('Caetano Veloso'),
	('Gilberto Gil'),
	('MC João'),
	('Anitta'),
	('Chitãozinho & Xororó'),
	('Luiz Gonzaga');

-- inserção dos estilos --
INSERT INTO tb_estilo(descricao_estilo) VALUES
	('MPB'),
	('Pop'),
	('Funk'),
	('Sertanejo'),
	('Forró');

-- inserção das musicas --
INSERT INTO tb_musica(nome_musica, ano_musica, id_estilo_fk) VALUES
	('Garota de Ipanema',1962,1),
	('Aquarela do Brasil',1939,1),
	('Apesar de Você',1970,1),
	('Sampa',2000,1),
	('Expresso 2222',1972,1),
	('Baile de Favela',2015,3),
	('Sento Novinha',2022,3),
	('Evidências',1990,4),
	('Te Amo Cada Vez Mais',2002,4),
	('Asa Branca',1947,5),
	('Riacho do Navio',1950,5),
	('Show das Poderosas',2013,2);
    
-- relacionamento compositores/musicas --
INSERT INTO tb_compositor_musica(id_compositor, id_musica) VALUES
	(1,1),
	(2,1),
	(1,2),
	(3,3),
	(4,4),
	(5,5),
	(6,6),
	(8,8),
	(8,9),
	(9,10),
	(9,11),
	(7,12);

-- testes insert exercicio 01 --
INSERT INTO tb_musica(nome_musica, ano_musica, id_estilo_fk) VALUES 
	('Ficha limpa',2021,4);
INSERT INTO tb_musica(nome_musica, ano_musica) VALUES 
	('Mercy',2012);


-- testes insert exercicio 02 --
INSERT INTO tb_musica(nome_musica, ano_musica, id_estilo_fk) VALUES 
	('Xote da alegria', 2001, 5);
INSERT INTO tb_musica(nome_musica, ano_musica, id_estilo_fk) VALUES
	('Bloqueado', 2021, 4);


-- testes insert exercicio 03 --
INSERT INTO tb_musica(nome_musica, ano_musica, id_estilo_fk) VALUES
	('Rindo à toa', 2000, 5);


-- testes delete exercicio 04 --
DELETE FROM tb_compositor_musica WHERE id_musica = 10;
DELETE FROM tb_musica WHERE id_musica = 10;


-- testes update exercicio 05 --
UPDATE tb_musica SET ano_musica = '1950' where nome_musica = 'Garota de Ipanema';





