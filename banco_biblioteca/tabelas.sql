create database db_biblioteca;
use db_biblioteca;

create table livro (
	id_livro	int		auto_increment,
    titulo		varchar(50),
    autor		varchar(50),
    exemplares_disponiveis		int,
    primary key(id_livro)
);

create table usuario (
	id_usuario	int		auto_increment,
    nome		varchar(100),
    email		varchar(100),
    primary key(id_usuario)
);

create table emprestimo (
	id_emprestimo		int		auto_increment,
    data_emprestimo		date,
    data_devolucao		date,
    usuario_id			int,
    livro_id			int,
    primary key(id_emprestimo),
    foreign key(usuario_id) references usuario (id_usuario),
    foreign key(livro_id) references livro (id_livro)
);

create table historicoEmprestimo(
	id_hist				int		auto_increment,
    data_emprestimo		date,
    data_devolucao		date,
    usuario_id			int,
    livro_id			int,
    primary key(id_hist)
);

INSERT INTO livro (titulo, autor, exemplares_disponiveis) VALUES
('Dom Casmurro', 'Machado de Assis', 5),
('O Primo Basílio', 'José de Alencar', 3),
('Moby Dick', 'Herman Melville', 4),
('1984', 'George Orwell', 7),
('O Pequeno Príncipe', 'Antoine de Saint-Exupéry', 10),
('O Hobbit', 'J.R.R. Tolkien', 2),
('A Moreninha', 'Joaquim Manuel de Macedo', 8),
('O Cortiço', 'Aluísio Azevedo', 6),
('A Divina Comédia', 'Dante Alighieri', 3),
('Cem Anos de Solidão', 'Gabriel García Márquez', 9),
('A Guerra dos Tronos', 'George R.R. Martin', 4),
('O Senhor dos Anéis', 'J.R.R. Tolkien', 5),
('Grande Sertão: Veredas', 'João Guimarães Rosa', 2),
('O Processo', 'Franz Kafka', 6),
('O Código Da Vinci', 'Dan Brown', 7);

INSERT INTO usuario (nome, email) VALUES
('João Silva', 'joao.silva@email.com'),
('Maria Oliveira', 'maria.oliveira@email.com'),
('Pedro Santos', 'pedro.santos@email.com'),
('Ana Costa', 'ana.costa@email.com'),
('Carlos Pereira', 'carlos.pereira@email.com'),
('Fernanda Almeida', 'fernanda.almeida@email.com'),
('Lucas Souza', 'lucas.souza@email.com'),
('Juliana Lima', 'juliana.lima@email.com'),
('Rafael Rocha', 'rafael.rocha@email.com'),
('Isabela Ferreira', 'isabela.ferreira@email.com'),
('Eduardo Martins', 'eduardo.martins@email.com'),
('Patrícia Carvalho', 'patricia.carvalho@email.com'),
('Thiago Mendes', 'thiago.mendes@email.com'),
('Camila Dias', 'camila.dias@email.com'),
('Ricardo Barbosa', 'ricardo.barbosa@email.com');


-- teste trigger exercicio 01
insert into emprestimo (data_emprestimo, data_devolucao, usuario_id, livro_id) values 
	("2025-02-01", "2025-02-04", 5, 2),
    ("2025-02-01", "2025-02-06", 5, 3),
    ("2025-02-01", "2025-02-09", 5, 1),
    ("2025-02-01", "2025-02-09", 5, 8);
    
-- teste trigger exercicio 02
delete from emprestimo where id_emprestimo;

-- teste view exercicio 04
select * from vw_mais_emprestados;

-- teste view exercicio 05
select * from vw_mais_3_emprestimos;

-- teste procedure exercicio 06
call realizar_emprestimo(1, 6);
call realizar_emprestimo(4, 6);
call realizar_emprestimo(13, 6);

-- teste procedure exercicio 08
call realizar_emprestimo(7, "2000");
    
select * from livro;
select * from usuario;
select * from emprestimo;
select * from historicoEmprestimo;




