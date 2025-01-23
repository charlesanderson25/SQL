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