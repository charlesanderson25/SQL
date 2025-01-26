/* Fokus.db */

/*
Usando o LIKE
*/

SELECT  SUM(faturamento_bruto) AS TOTAL_FATURAMENTO,
        SUM(despesas) AS TOTAL_DESPESAS,
        SUM(lucro_liquido) AS TOTAL_LUCRO_LIQUIDO,
        SUM(numero_clientes) AS TOTAL_CLIENTES,
        SUM(numero_novos_clientes) AS QTD_NOVOS_CLIENTES
FROM faturamento
WHERE mes LIKE '%2019';

SELECT * FROM faturamento;

SELECT * FROM HistoricoEmprego;

/*
Usando o COUNT
*/

SELECT COUNT(*) 
FROM HistoricoEmprego
WHERE datatermino IS NULL
GROUP BY cargo;

SELECT COUNT(*) 
FROM HistoricoEmprego
WHERE datatermino NOT NULL;

SELECT parentesco, COUNT(*) FROM Dependentes
GROUP BY parentesco;

/*
Usando o Having
*/

SELECT *, AVG(salario)
FROM HistoricoEmprego
GROUP BY CARGO
HAVING salario >= 18000 AND datatermino IS NULL;

SELECT *
FROM HistoricoEmprego;
WHERE cargo = 'Advogado';


SELECT instituicao, 
	   COUNT(curso) AS TOTAL_CURSOS
FROM Treinamento
GROUP BY instituicao
HAVING TOTAL_CURSOS > 1;

SELECT * from Colaboradores;

/*
Concatenar strings
*/

SELECT 
('O colaborador(a) ' || nome || ' possui CPF: ' || cpf || ' e e-mail: ' || email)
from Colaboradores;

/*
Função length, conta quantidade de caracteres 
*/

SELECT *, LENGTH(CPF)
FROM Colaboradores;

/*
Case When
*/

SELECT * from HistoricoEmprego;

SELECT *, 
       CASE 
       WHEN salario < 3000 THEN 'BAIXO'
       WHEN salario BETWEEN 3000 AND 6000 THEN 'MEDIO'
       ELSE 'ALTO'
       END AS NIVEL_SALARIO
FROM HistoricoEmprego;

/*
Uso do DEFAULT na criação de uma coluna em uma nova tabela
Trata-se de um valor padrão a ser inserido caso o campo não seja preenchido
*/

CREATE TABLE clientes (
       id TEXT NOT NULL,
       nome VARCHAR(255),
       telefone VARCHAR(50),
       email VARCHAR(100) DEFAULT 'Sem email',
       endereco VARCHAR(255),
       PRIMARY KEY (id)
)

-- UNION

SELECT RUA, 
		 BAIRRO, 
		 CIDADE, 
		 ESTADO, 
		 CEP 
FROM alura.tb_colaboradoes

UNION ALL

SELECT RUA,

		 BAIRRO,
		 CIDADE,
		 ESTADO,
		 CEP 
FROM ALURA.tb_fornecedores;

SELECT * FROM
ALURA.tb_colaboradoes;

SELECT * FROM 
ALURA.tb_pedidos;

SELECT * FROM
ALURA.tb_itenspedidos;

SELECT * FROM 
ALURA.tb_CLIENTES;

SELECT * FROM
ALURA.tb_fornecedores;

-- Insere dados a partir de um arquivp .csv

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 5.7/Uploads/pedidos.csv'
INTO TABLE ALURA.tb_pedidos
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(ID, IDCLIENTE, DATAHORAPEDIDO, STATUS);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 5.7/Uploads/itens_de_pedido.csv'
INTO TABLE ALURA.tb_itenspedidos
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(IDPEDIDO, IDPRODUTO, QUANTIDADE, PRECOUNITARIO);

CREATE TEMPORARY TABLE alura.tb_pedidos_temp (
    ID INT,
    IDCLIENTE INT,
    DATAHORAPEDIDO DATETIME,
    STATUS VARCHAR(50)
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 5.7/Uploads/pedidos.csv'
INTO TABLE alura.tb_pedidos_temp
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(ID, IDCLIENTE, DATAHORAPEDIDO, STATUS);

-- Subconsultas

SELECT DISTINCT idcliente
FROM ALURA.tb_pedidos_TEMP
WHERE IDCLIENTE NOT IN (SELECT ID FROM ALURA.tb_clientes);

SELECT * FROM
alura.tb_pedidos_temp;

SELECT * FROM 
ALURA.tb_pedidos
WHERE ( SELECT ID FROM ALURA.tb_clientes WHERE ID = 10 );

SELECT * 
FROM ALURA.tb_clientes;

SELECT * 
FROM ALURA.tb_PEDIDOS;

SELECT * 
FROM ALURA.tb_clientes
	WHERE ID = ( 
		SELECT IDCLIENTE 
			FROM ALURA.tb_pedidos 
			WHERE ID = 1 );
			
SELECT * 
FROM ALURA.tb_clientes
WHERE ID IN (SELECT IDCLIENTE FROM ALURA.tb_pedidos WHERE DATE_FORMAT(tb_pedidos.DATAHORAPEDIDO, '%d') = '02');

-- Subconsultas com Having

SELECT AVG(PRECO)
FROM ALURA.tb_produtos;

-- Produtos com preço maior que a média

SELECT NOME, PRECO
FROM ALURA.tb_produtos
HAVING PRECO > ( 
	SELECT AVG(PRECO)
	FROM ALURA.tb_produtos );
	
SELECT * 
FROM ALURA.tb_clientes;

SELECT * 
FROM ALURA.tb_PEDIDOS;

SELECT * 
FROM ALURA.tb_clientes T1
INNER JOIN ALURA.tb_pedidos T2
ON T1.ID = T2.IDCLIENTE
ORDER BY T1.ID
;

SELECT *
FROM ALURA.tb_produtos;

SELECT *
FROM ALURA.tb_itenspedidos T1
RIGHT JOIN ALURA.tb_produtos T2
ON T1.IDPRODUTO = T2.ID
;

INSERT INTO alura.tb_produtos (ID, NOME, DESCRICAO, PRECO, CATEGORIA) VALUES
(31, 'Lasanha à bolonhesa', 'Deliciosa lasanha caseira com molho bolonhesa', 12.50, 'Almoço');

SELECT * 
FROM ALURA.tb_pedidos

-- 25 JANEIRO DE 2025

SELECT * 
FROM ALURA.tb_pedidos t1
WHERE t1.IDCLIENTE = 26;

SELECT *
FROM ALURA.tb_clientes;

INSERT INTO alura.tb_clientes (ID, NOME, TELEFONE, EMAIL, ENDERECO) VALUES
(28, 'João Santos', 11982331313, 'joao.santos123@gmail.com', 'CNB12, LT 23, Taguatinga Norte');

-- LEFT JOIN

SELECT *
FROM ALURA.tb_clientes t1
LEFT JOIN ALURA.tb_pedidos t2
	ON t1.ID = t2.IDCLIENTE;
	
SELECT * 
FROM ALURA.tb_pedidos t1
ORDER BY ID;

SELECT *
FROM ALURA.tb_itenspedidos;

SELECT *
FROM ALURA.tb_produtos;

SELECT SUM(PRECOUNITARIO) AS VALOR_TOTAL_PEDIDOS
FROM ALURA.tb_itenspedidos;

SELECT t1.IDPEDIDO,
		 t1.IDPRODUTO,
		 t1.QUANTIDADE,
		 t1.PRECOUNITARIO, 
		 t2.NOME,
		 t2.PRECO AS t2_PRECO,
       SUM(t1.PRECOUNITARIO) AS VALOR_TOTAL_PEDIDO
FROM ALURA.tb_itenspedidos t1
INNER JOIN ALURA.tb_produtos t2
	ON t1.IDPRODUTO = t2.ID
GROUP BY t1.IDPEDIDO
;

-- Criando views

CREATE VIEW nome_end_clientes AS
SELECT *
FROM ALURA.tb_clientes;

CREATE VIEW nm_end_clientes AS
SELECT nome, endereco
FROM ALURA.tb_clientes;

SELECT *
FROM ALURA.nome_end_clientes;

DROP VIEW ALURA.nome_end_clientes;

SELECT *
FROM ALURA.nm_end_clientes;

-- Faturamento total do dia
CREATE VIEW VW_PEDIDOS AS
SELECT T1.ID,
		 T1.IDCLIENTE,
		 DATE(T1.DATAHORAPEDIDO) AS DIA,
		 T1.`STATUS`
FROM ALURA.tb_pedidos T1;

SELECT *
FROM ALURA.vw_pedidos;


CREATE VIEW VW_ITENSPEDIDOS AS
SELECT T1.IDPEDIDO,
		 T1.QUANTIDADE,
		 T1.PRECOUNITARIO AS PRECO_PRODUTOS
FROM ALURA.tb_itenspedidos T1;

SELECT *
FROM ALURA.vw_itenspedidos;

DROP VIEW ALURA.vw_faturamento_diario;

CREATE VIEW VW_FATURAMENTO_DIARIO_TEMP AS
SELECT *
FROM ALURA.vw_pedidos T1
INNER JOIN ALURA.vw_itenspedidos T2
	ON T1.ID = T2.IDPEDIDO;
	
SELECT *
FROM ALURA.vw_faturamento_diario_temp;

CREATE VIEW ALURA.vw_faturamento_diario AS
SELECT ID AS IDPEDIDO, 
		 IDCLIENTE,
		 DIA,
		 STATUS AS SITUACAO_PEDIDO,
		 QUANTIDADE,
		 SUM(PRECO_PRODUTOS) AS FATURAMENTO_DIARIO
FROM ALURA.vw_faturamento_diario_temp
GROUP BY DIA
ORDER BY DIA;

SELECT * 
FROM ALURA.vw_faturamento_diario;

SELECT *
FROM ALURA.tb_itenspedidos;

SELECT *
FROM ALURA.tb_pedidos;

SELECT *
FROM ALURA.tb_clientes;

SELECT *
FROM ALURA.tb_colaboradoes;

SELECT *
FROM ALURA.tb_fornecedores;

SELECT *
FROM ALURA.tb_pedidos;

INSERT INTO ALURA.tb_pedidos (ID, IDCLIENTE, DATAHORAPEDIDO, STATUS)
VALUES (451, 8, '2025-01-25 10:49:00', 'Entregue');

DELETE FROM ALURA.tb_pedidos 
WHERE ID = 451 
			AND IDCLIENTE = 8 
			AND DATAHORAPEDIDO = '2025-01-25 10:49:00' 
			AND `STATUS` = 'Entregue';

SELECT *
FROM ALURA.tb_pedidos;

CREATE TABLE ALURA.tb_pedidos_backup
SELECT *
FROM ALURA.tb_pedidos;

SELECT *
FROM ALURA.tb_pedidos_backup;

DELETE FROM ALURA.tb_pedidos_backup
WHERE ID = 451 
			AND IDCLIENTE = 8 
			AND DATAHORAPEDIDO = '2025-01-25 10:49:00' 
			AND `STATUS` = 'Entregue';
			

-- TRIGGER
DELIMITER //

CREATE TRIGGER AtualizaPedidosBackup
AFTER INSERT ON ALURA.tb_pedidos
FOR EACH ROW

BEGIN

	INSERT INTO ALURA.tb_pedidos_backup (ID, IDCLIENTE, DATAHORAPEDIDO, STATUS)
	VALUES (NEW.ID, NEW.IDCLIENTE, NEW.DATAHORAPEDIDO, NEW.STATUS);

END;

//

DELIMITER;

-- Localiza Trigger

SELECT 
    TRIGGER_NAME,
    EVENT_MANIPULATION AS EVENTO,
    EVENT_OBJECT_TABLE AS TABELA,
    ACTION_STATEMENT AS CODIGO,
    ACTION_TIMING AS MOMENTO
FROM INFORMATION_SCHEMA.TRIGGERS
WHERE TRIGGER_SCHEMA = 'alura';

SELECT 
    TRIGGER_NAME,
    EVENT_MANIPULATION AS EVENTO,
    EVENT_OBJECT_TABLE AS TABELA,
    ACTION_STATEMENT AS CODIGO,
    ACTION_TIMING AS MOMENTO
FROM INFORMATION_SCHEMA.TRIGGERS
WHERE TRIGGER_SCHEMA = 'alura' AND EVENT_OBJECT_TABLE = 'tb_pedidos';

-- altera privilegios usuario

GRANT ALL PRIVILEGES ON alura.* TO 'root'@'localhost';
FLUSH PRIVILEGES;

-- LISTA AS TRIGGERS NO BANCP

SHOW TRIGGERS FROM alura;

-- 26/01/2025

-- UTILIZANDO BLOCO DE TRANSACTION

-- Desativar autocommit

SET AUTOCOMMIT = 0;

START TRANSACTION;

SELECT *
FROM ALURA.tb_clientes;

INSERT INTO ALURA.tb_clientes (tb_clientes.ID, tb_clientes.NOME, tb_clientes.TELEFONE, tb_clientes.EMAIL, tb_clientes.ENDERECO)
VALUES (29, 'Jade Santana', '984546465', 'jade@gmail.com', 'CNB 12, LT22')

-- Desfazer a transação

ROLLBACK;

-- Confirmar transação

COMMIT;

-- Retornar ao modo autocommit

SET AUTOCOMMIT = 1;