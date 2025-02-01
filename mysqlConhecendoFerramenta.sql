-- 28/01/2025

CREATE DATABASE alura1;

USE alura1;

CREATE TABLE proprietarios (
proprietario_id VARCHAR(255) PRIMARY KEY,
nome VARCHAR(255),
cpf_cnpj VARCHAR(20),
contato VARCHAR(255)
);

CREATE TABLE clientes (
    cliente_id VARCHAR(255) PRIMARY KEY,
    nome VARCHAR(255),
    cpf VARCHAR(14),
    contato VARCHAR(255)
);

CREATE TABLE enderecos (
    endereco_id VARCHAR(255) PRIMARY KEY,
    rua VARCHAR(255),
    numero INT,
    bairro VARCHAR(255),
    cidade VARCHAR(255),
    estado VARCHAR(2),
    cep VARCHAR(10)
);

CREATE TABLE hospedagens (
    hospedagem_id VARCHAR(255) PRIMARY KEY,
    tipo VARCHAR(50),
    endereco_id VARCHAR(255),
    proprietario_id VARCHAR(255),
        ativo bool,
    FOREIGN KEY (endereco_id) REFERENCES enderecos(endereco_id),
    FOREIGN KEY (proprietario_id) REFERENCES proprietarios(proprietario_id)
);

CREATE TABLE alugueis (
    aluguel_id VARCHAR(255) PRIMARY KEY,
    cliente_id VARCHAR(255),
    hospedagem_id VARCHAR(255),
    data_inicio DATE,
    data_fim DATE,
    preco_total DECIMAL(10, 2),
    FOREIGN KEY (cliente_id) REFERENCES clientes(cliente_id),
    FOREIGN KEY (hospedagem_id) REFERENCES hospedagens(hospedagem_id)
);

CREATE TABLE avaliacoes (
avaliacao_id VARCHAR(255) PRIMARY KEY,
cliente_id VARCHAR(255),
hospedagem_id VARCHAR(255),
nota INT,
comentario TEXT,
FOREIGN KEY (cliente_id) REFERENCES clientes(cliente_id),
FOREIGN KEY (hospedagem_id) REFERENCES hospedagens(hospedagem_id)
);

SELECT * FROM
enderecos;

SELECT * 
FROM clientes
ORDER BY CLIENTE_ID;

SELECT * 
FROM proprietarios
ORDER BY PROPRIETARIO_ID;

SELECT * 
FROM hospedagens
ORDER BY HOSPEDAGEM_ID;

SELECT * 
FROM alugueis;

SELECT * 
FROM avaliacoes;

-- 29/01/2025

SELECT *
FROM hospedagens;

SELECT *
FROM avaliacoes;

SELECT T2.hospedagem_id,
		 T2.tipo,
		 T1.avaliacao_id,
		 T1.nota,
		 T1.comentario
FROM avaliacoes T1
LEFT JOIN hospedagens T2
	ON T1.hospedagem_id = T2.hospedagem_id
WHERE T1.nota >= 4;

SELECT *
FROM alugueis;

#------------------------------------------------------#

# 31/01/2025

ALTER TABLE proprietarios
ADD COLUMN qtd_hospedagens INT;

SELECT *
FROM proprietarios;

ALTER TABLE alugueis
RENAME TO reservas;

SELECT *
FROM reservas;

ALTER TABLE reservas 
CHANGE COLUMN aluguel_id reserva_id INT;

SELECT *
FROM hospedagens;

SHOW CREATE TABLE hospedagens;

UPDATE hospedagens t1
SET ativo = 1
WHERE t1.hospedagem_id IN ('1', '10', '100');

SELECT *
FROM hospedagens t1
WHERE t1.hospedagem_id IN ('1', '10', '100');

SELECT *
FROM proprietarios
WHERE proprietarios.proprietario_id = '1009';

UPDATE proprietarios
SET contato = 'daniela_120@hotmail.com'
WHERE proprietarios.proprietario_id = '1009';

SELECT *
FROM avaliacoes
WHERE avaliacoes.hospedagem_id IN ('10000', '1001');

DELETE FROM avaliacoes
WHERE avaliacoes.hospedagem_id IN ('10000', '1001');

SELECT *
FROM hospedagens
WHERE hospedagens.hospedagem_id IN ('10000', '1001');

DELETE FROM hospedagens
WHERE hospedagens.hospedagem_id IN ('10000', '1001');

SELECT * FROM reservas
WHERE reservas.hospedagem_id IN ('10000', '1001');

DELETE FROM reservas
0WHERE reservas.hospedagem_id IN ('10000', '1001');

#-----------------------------------------------------------------------------------------#

-- 01/02/2025

SHOW CREATE DATABASE alura1;

CREATE DATABASE alura2; /*!40100 DEFAULT CHARACTER SET latin1 */

USE alura2;

SELECT *
FROM alura2.tabelaclienteconta;

SELECT *
FROM alura2.tabelaclientes;

SELECT *
FROM alura2.tabelacolaboradores;

SELECT *
FROM alura2.tabelaconta;

SELECT *
FROM alura2.tabeladepartamento;

SELECT *
FROM alura2.tabelaemprestimo;

SELECT *
FROM alura2.tabelapagamentos;

SELECT *
FROM alura2.tabelascorecredito;

SELECT *
FROM alura2.tabelatelefones;

-- valor total emprestimos

SELECT SUM(Valor) AS Valor_Total_Emprestimos
FROM tabelaemprestimo;

-- media salario colaboradoes

SELECT AVG(salario) AS MediaSalario
FROM tabelacolaboradores;

-- maior valor emoprestimo

SELECT MAX(Valor)
FROM tabelaemprestimo;

-- menor valor emprestimo

SELECT MIN(Valor)
FROM tabelaemprestimo;

# quantidade colaboradores

SELECT COUNT(t1.id_colaborador)
from tabelacolaboradores t1;

-- media valores emprestados

SELECT SUM(Valor) / COUNT(id_emprestimo)
FROM tabelaemprestimo;

SELECT *
FROM alura2.tabelacolaboradores;

SELECT *
FROM alura2.tabeladepartamento;

-- salarios por departamento

SELECT t1.id_departamento,
		 t1.NomeDepartamento,
		 t2.Salario
FROM tabeladepartamento t1 
INNER JOIN tabelacolaboradores t2
	ON t1.id_departamento = t2.id_departamento;

-- valor total emprestimo maior 20.000
	
SELECT *
FROM tabelaemprestimo t1
WHERE t1.Valor > 20000
ORDER BY t1.Valor ASC;

-- Qual é o total de valores concedidos e a quantidade de empréstimos firmados por tipo de empréstimo?

SELECT t1.Tipo,
		 t1.Valor AS TotalValor,
		 COUNT(t1.Tipo) AS Qtd_Emprestimos
from tabelaemprestimo t1
GROUP BY t1.Tipo;

-- Qual é o total, a média, o maior e o menor valor dos empréstimos concedidos?

SELECT SUM(t1.Valor) AS TotalEmprestimos,
		 AVG(t1.Valor) AS MediaEmprestimos,
		 MAX(t1.Valor) AS MaiorEmprestimo,
		 MIN(t1.Valor) AS MenorEmprestimo
FROM tabelaemprestimo t1;