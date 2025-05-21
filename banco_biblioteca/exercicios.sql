-- TRIGGERS --
-- 01 Quando um livro for emprestado (insert em Emprestimo), diminua exemplares_disponiveis da tabela Livro

delimiter $$
create trigger trg_emprestimos after insert on emprestimo for each row
begin 
	update livro set exemplares_disponiveis = exemplares_disponiveis - 1 where id_livro = new.livro_id;
end;
$$
delimiter ;

-- 02 Quando um empréstimo for excluído da tabela Emprestimo, aumente os exemplares_disponiveis do livro correspondente.

delimiter $$
create trigger trg_devolucao after delete on emprestimo for each row
begin
	update livro set exemplares_disponiveis = exemplares_disponiveis + 1 where id_livro = old.livro_id;
end;
$$
delimiter ;

-- 03 Ao fazer a devolução (remoção de um empréstimo), registre os dados na tabela HistoricoEmprestimo.

delimiter $$
create trigger trg_hist_devolucao after delete on emprestimo for each row
begin
	insert into historicoEmprestimo (data_emprestimo, data_devolucao, usuario_id, livro_id)
    values (old.data_emprestimo, old.data_devolucao, old.usuario_id, old.livro_id);
end;
$$
delimiter ;

-- VIEWS --
-- 04 Crie uma view que mostre os 5 livros mais emprestados da história.
create view vw_mais_emprestados as
select l.titulo from livro l inner join historicoEmprestimo he on l.id_livro = he.livro_id
group by l.titulo order by count(he.livro_id) desc limit 3;

-- 05 Mostre usuários com mais de 3 empréstimos em andamento.
create view vw_mais_3_emprestimos as
select u.nome, count(*) as total_emprestimos from usuario u inner join emprestimo em on u.id_usuario = em.usuario_id
group by u.id_usuario, u.nome HAVING COUNT(*) > 3;

-- PROCEDURE

-- 06 Crie uma procedure realizar_emprestimo que:
-- Verifique se há exemplares disponíveis
-- Registre o empréstimo
-- Se não houver, emita erro (SIGNAL)

delimiter $$
create procedure realizar_emprestimo (in usuarioId int, in livroId int)
begin
	declare disponibilidade int;
    select exemplares_disponiveis into disponibilidade from livro where id_livro = livroId; 
    
    if disponibilidade > 0 then
		insert into emprestimo (data_emprestimo, data_devolucao, usuario_id, livro_id) values 
		("2025-02-01", "2025-02-05", usuarioId, livroId);
    else
		signal sqlstate '45000'
		set message_text = 'Este livro não tem no estoque';
	end if;
end;
$$
delimiter ;

-- 07 Procedure de devolução com histórico
-- Remova o empréstimo da tabela Emprestimo
-- Registre os dados na tabela HistoricoEmprestimo
-- Atualize Livro.exemplares_disponiveis

delimiter $$
create procedure devolucao (in emprestimoId int)
begin
	delete from emprestimo where id_emprestimo = emprestimoId;
end;
$$
delimiter ;


-- TRANSACTION
-- 08 Transação completa de empréstimo
-- 	Faça uma transação que:
-- 	Verifica se há livros disponíveis
-- 	Atualiza a tabela Livro
-- 	Insere o empréstimo
-- 	Só executa se tudo for bem — caso contrário, ROLLBACK


delimiter $$
create procedure realizar_emprestimo (in usuarioId int, in nome_livro varchar(80))
begin 
	declare disponibilidade int;
    declare livroId int;
    select exemplares_disponiveis into disponibilidade from livro where titulo = nome_livro;
    select id_livro into livroId from livro where titulo = nome_livro;
    
    start transaction;
    if disponibilidade > 0 then
		insert into emprestimo (data_emprestimo, data_devolucao, usuario_id, livro_id)
        values (curdate(), date_add(curdate(), interval 7 day), usuarioId, livroId);
        commit;
	else 
		rollback;
        signal sqlstate '45000'
        set message_text = 'Sem exemplares diponiveis';
	end if;
end;
$$
delimiter ;

drop procedure realizar_emprestimo;
select exemplares_disponiveis from livro where titulo = "1984";
select id_livro from livro where titulo = "O pequeno principe";











