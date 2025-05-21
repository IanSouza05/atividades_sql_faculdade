-- filme por codigo
DELIMITER $$
CREATE PROCEDURE nome_filme(varidfilme int)
	BEGIN
		SELECT concat('O nome do filme é: ', titulo) AS titulo
			FROM cinema.filme WHERE idfilme = varidfilme;
	END;
$$
DELIMITER ;

call nome_filme(102);
call nome_filme(101);


-- Crie uma procedure para retornar os filmes de um determinado gênero. 
DELIMITER $$
CREATE PROCEDURE genero_filme(id_do_filme int)
	BEGIN
		SELECT concat('Os filmes do genero são: ', f.titulo) FROM cinema.filme f INNER JOIN cinema.genero g ON f.genero_idgenero=g.idgenero where g.idgenero = id_do_filme ;
	END;
$$
DELIMITER ;

call genero_filme(1);
call genero_filme(4);


-- Crie uma procedure chamada qtdeAssentosSala que recebe o idSalacomo entrada e retorna a quantidade de assentos dessa sala.
DELIMITER $$
CREATE PROCEDURE qt_de_sssentos_sala (id_da_sala int)
	BEGIN
		SELECT concat('A quantidade de assentos da sala é: ', qtdeAssento) FROM sala WHERE idsala = id_da_sala;
    END;
$$
DELIMITER ;

call qt_de_sssentos_sala(100);
call qt_de_sssentos_sala(200);


-- Crie uma procedurechamada calcularReceitaPorFilme que recebe o idFilmee o preço do ingresso como entrada e retorna a receita total.
DELIMITER $$
CREATE PROCEDURE calcular_receita_por_filme (IN id_do_filme int, IN preco_ingresso decimal(10,2))
	BEGIN
		SELECT concat('A receita desse filme foi: ', sum(preco_ingresso * s.qtdeVendidos)) as receita FROM sessao s INNER JOIN filme f on s.filme_idfilme=f.idfilme WHERE f.idfilme = id_do_filme;
    END;
$$
DELIMITER ;

drop procedure calcular_receita_por_filme;
call calcular_receita_por_filme(103, 20.0);









