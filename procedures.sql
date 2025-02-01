-- STORED Procedures

SELECT *
FROM avaliacoes;

SELECT *
FROM clientes;

SELECT *
FROM reservas;

USE alura1;

ALTER TABLE reservas 
RENAME TO alugueis;

SELECT *
FROM alugueis;

ALTER TABLE alugueis
CHANGE COLUMN reserva_id aluguel_it INT;

ALTER TABLE alugueis
CHANGE COLUMN aluguel_it aluguel_ii INT;

ALTER TABLE alugueis
CHANGE COLUMN aluguel_ii aluguel_id INT;

-- ---------------------------------------------------------------------------------

USE alura1;
DROP PROCEDURE if EXISTS nao_faz_nada;

DELIMITER $$

CREATE PROCEDURE nao_faz_nada()

BEGIN

END $$

DELIMITER ;

-- ---------------------------------------------------------------------------------
USE alura1;
DROP PROCEDURE if EXISTS ola_mundo;

delimiter $$
USE alura1 $$

CREATE PROCEDURE ola_mundo()

BEGIN 

SELECT 'olá mundo!!!';

END $$

delimiter ;

-- ---------------------------------------------------------------------------------

CALL pc_ola_mundo;

-- ---------------------------------------------------------------------------------

DROP PROCEDURE if EXISTS pc_clientes;

delimiter $$

USE alura1 $$

CREATE PROCEDURE pc_clientes()

	BEGIN 
	
		SELECT * FROM clientes;
	
	END $$

delimiter ;

-- ---------------------------------------------------------------------------------

CALL alura1.pc_clientes;

SELECT *
FROM hospedagens;

-- ---------------------------------------------------------------------------------

DROP PROCEDURE if EXISTS pc_list_Hospedagens_Casa;

delimiter $$

USE alura1 $$

CREATE PROCEDURE pc_list_Hospedagens_Casa()

BEGIN

	SELECT *
	FROM hospedagens t1
	WHERE t1.tipo = 'casa';

END $$

delimiter ;

-- ---------------------------------------------------------------------------------

SHOW WARNINGS LIMIT 5;

-- ---------------------------------------------------------------------------------

CALL alura1.pc_list_Hospedagens_Casa;

DROP PROCEDURE alura1.pc_nao_faz_nada;
-- ---------------------------------------------------------------------------------

DROP PROCEDURE if EXISTS pc_hello_world;

delimiter $$

USE alura1 $$

CREATE PROCEDURE pc_hello_world()

BEGIN

DECLARE texto VARCHAR(255) DEFAULT 'hello world!';
SELECT texto;

END $$

delimiter ;

-- ---------------------------------------------------------------------------------

CALL alura1.pc_hello_world;

SELECT * 
FROM alugueis;

-- ---------------------------------------------------------------------------------

DROP PROCEDURE if EXISTS pc_novo_aluguel;

delimiter $$

USE alura1 $$

CREATE PROCEDURE pc_novo_aluguel()

BEGIN 

	DECLARE vAluguel INT(11)     	     DEFAULT 10001;
	DECLARE vCliente VARCHAR(10)       DEFAULT 1002;
	DECLARE vHospedagem VARCHAR(10)    DEFAULT 8635;
	DECLARE vDataInicio DATE           DEFAULT '2025-03-01';
	DECLARE vDataFinal  DATE           DEFAULT '2025-03-05';
	DECLARE vPrecoTotal DECIMAL(10,2)  DEFAULT 550.23;
	INSERT INTO alugueis VALUES(vAluguel,
							 vCliente,
							 vHospedagem,
		   				 vDataInicio,
							 vDataFinal,
							 vPrecoTotal);

END $$

delimiter ;

-- ---------------------------------------------------------------------------------

SELECT *
FROM alugueis;

CALL alura1.pc_novo_aluguel;

SHOW CREATE TABLE alugueis;

CALL alura1.pc_novo_aluguel;