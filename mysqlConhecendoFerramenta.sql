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