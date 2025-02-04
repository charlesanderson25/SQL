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

-- ---------------------------------------------------------------------------------

DROP PROCEDURE if EXISTS pc_novo_aluguel_1;

delimiter $$

USE alura1 $$

CREATE PROCEDURE pc_novo_aluguel_1(
	vAluguel    INT(11),
	vCliente    VARCHAR(10),
	vHospedagem VARCHAR(10),
	vDataInicio DATE,
	vDataFinal  DATE,
	vPrecoTotal DECIMAL(10,2)
)

BEGIN 

	INSERT INTO alugueis VALUES(vAluguel,
							 vCliente,
							 vHospedagem,
		   				 vDataInicio,
							 vDataFinal,
							 vPrecoTotal);

END $$

delimiter ;

-- ------------------------------------------------------

CALL alura1.pc_novo_aluguel_1(10002, '1003', '8635', '2025-03-06', '2025-03-10', 600);

SELECT * 
FROM alugueis
WHERE aluguel_id IN (10002, 10003);

CALL alura1.pc_novo_aluguel_1(10003, '1004', '8635', '2025-03-10', '2025-03-12', 250);

-- ------------------------------------------------------------------------------------------------

DROP PROCEDURE if EXISTS pc_novo_aluguel_2;

delimiter $$

USE alura1 $$

CREATE PROCEDURE pc_novo_aluguel_2(
	vAluguel    INT(11),
	vCliente    VARCHAR(10),
	vHospedagem VARCHAR(10),
	vDataInicio DATE,
	vDataFinal  DATE,
	vPrecoUnitario DECIMAL(10,2)
)

BEGIN 
	
	DECLARE vDias INT(11) DEFAULT 0;
	DECLARE vPrecoTotal DECIMAL(10,2);
	SET vDias = (SELECT DATEDIFF(vDataFinal, vDataInicio));
	SET vPrecoTotal = vDias * vPrecoUnitario;
	
	INSERT INTO alugueis VALUES(vAluguel,
							 vCliente,
							 vHospedagem,
		   				 vDataInicio,
							 vDataFinal,
							 vPrecoTotal);

END $$

delimiter ;

-- ------------------------------------------------------

CALL alura1.pc_novo_aluguel_1(10002, '1003', '8635', '2025-03-06', '2025-03-10', 600);

SELECT * 
FROM alugueis
WHERE aluguel_id IN (10002, 10003);

CALL alura1.pc_novo_aluguel_1(10003, '1004', '8635', '2025-03-10', '2025-03-12', 250);

-- ------------------------------------------------------

SELECT DATEDIFF('2025-01-25', '2025-01-20') AS diferenca_dias;

SELECT * 
FROM alugueis;

CALL pc_novo_aluguel_2(10004, '1004', '8635', '2025-03-13', '2025-03-16', 40);

SELECT * 
FROM alugueis t1
WHERE t1.aluguel_id = 10004 ;

#---------------------------------------------#
-- TRATAMENTO DE ERROS NA PROCEDURE          --
#---------------------------------------------#

DROP PROCEDURE if EXISTS pc_novo_aluguel_3;

delimiter $$

USE alura1 $$

CREATE PROCEDURE pc_novo_aluguel_3(
	vAluguel    INT(11),
	vCliente    VARCHAR(10),
	vHospedagem VARCHAR(10),
	vDataInicio DATE,
	vDataFinal  DATE,
	vPrecoUnitario DECIMAL(10,2)
)

BEGIN 
	
	DECLARE vDias INT(11) DEFAULT 0;
	DECLARE vPrecoTotal DECIMAL(10,2);
	DECLARE vMensagem VARCHAR(100);
	
		-- Se der o erro 1452 no INSERT INTO o código abaixo será executado com a mensagem de erro

		DECLARE exit handler FOR 1452 -- 1452 é um tipo de erro do MySQL
		
		BEGIN
			SET vMensagem = 'Problema de chave estrangeira associado a alguma entidade da base';
			SELECT vMensagem;
	   END; 		
	   
	   -- fim do código de erro 
	
	SET vDias = (SELECT DATEDIFF(vDataFinal, vDataInicio));
	SET vPrecoTotal = vDias * vPrecoUnitario;
	
	INSERT INTO alugueis VALUES(vAluguel,
							 vCliente,
							 vHospedagem,
		   				 vDataInicio,
							 vDataFinal,
							 vPrecoTotal);
	
	-- Se o INSERT INTO for executado com sucesso, a mensagem abaixo será exibida
							 
	SET vMensagem = 'Aluguel incluído com sucesso!';
	SELECT vMensagem;

END $$

delimiter ;

-- ------------------------------------------------------

CALL pc_novo_aluguel_3(10005, '10001', '8635', '2025-03-17', '2025-03-15', 40);
CALL pc_novo_aluguel_3(10005, '1004', '8635', '2025-03-17', '2025-03-25', 40);

DELETE 
FROM alugueis
WHERE alugueis.aluguel_id = 10005;

SELECT *
FROM alugueis
WHERE aluguel_id = 10005;

#---------------------------------------------#
-- Nova PROCEDURE                            --
#---------------------------------------------#

DROP PROCEDURE if EXISTS pc_novo_aluguel_4;

delimiter $$

USE alura1 $$

CREATE PROCEDURE pc_novo_aluguel_4(
	vAluguel       INT(11),
	vClienteNome   VARCHAR(150),
	vHospedagem    VARCHAR(10),
	vDataInicio    DATE,
	vDataFinal     DATE,
	vPrecoUnitario DECIMAL(10,2)
)

BEGIN 
	
	DECLARE vCliente VARCHAR(10);
	DECLARE vDias INT(11) DEFAULT 0;
	DECLARE vPrecoTotal DECIMAL(10,2);
	DECLARE vMensagem VARCHAR(100);
	
		-- Se der o erro 1452 no INSERT INTO o código abaixo será executado com a mensagem de erro

		DECLARE exit handler FOR 1452 -- 1452 é um tipo de erro do MySQL
		
		BEGIN
			SET vMensagem = 'Problema de chave estrangeira associado a alguma entidade da base';
			SELECT vMensagem;
	   END; 		
	   
	   -- fim do código de erro 
	
	SET vDias = (SELECT DATEDIFF(vDataFinal, vDataInicio));
	SET vPrecoTotal = vDias * vPrecoUnitario;

	-- recebe o nome do cliente via parametro e atualiza o cliente_id atraves da consulta abaixo
	SELECT cliente_id 
		INTO vCliente 
		FROM clientes 
		WHERE nome = vClienteNome;
	
	INSERT INTO alugueis VALUES(vAluguel,
							 vCliente,
							 vHospedagem,
		   				 vDataInicio,
							 vDataFinal,
							 vPrecoTotal);
	
	-- Se o INSERT INTO for executado com sucesso, a mensagem abaixo será exibida
							 
	SET vMensagem = 'Aluguel incluído com sucesso!';
	SELECT vMensagem;

END $$

delimiter ;

-- ------------------------------------------------------

USE alura1;

SELECT alura1.

CALL pc_novo_aluguel_4(10006, 'Luana Moura', '8635', '2025-03-26', '2025-03-30', 40);

SELECT *
FROM alugueis 
WHERE aluguel_id = 10006;


#---------------------------------------------#
-- Nova PROCEDURE                            --
#---------------------------------------------#

DROP PROCEDURE if EXISTS pc_novo_aluguel_5;

delimiter $$

USE alura1 $$

CREATE PROCEDURE pc_novo_aluguel_5(
	vAluguel       INT(11),
	vClienteNome   VARCHAR(150),
	vHospedagem    VARCHAR(10),
	vDataInicio    DATE,
	vDataFinal     DATE,
	vPrecoUnitario DECIMAL(10,2)
)

BEGIN 

	DECLARE vNumCliente INTEGER;	
	DECLARE vCliente VARCHAR(10);
	DECLARE vDias INT(11) DEFAULT 0;
	DECLARE vPrecoTotal DECIMAL(10,2);
	DECLARE vMensagem VARCHAR(100);
	
		-- Se der o erro 1452 no INSERT INTO o código abaixo será executado com a mensagem de erro

		DECLARE exit handler FOR 1452 -- 1452 é um tipo de erro do MySQL
		
		BEGIN
			SET vMensagem = 'Problema de chave estrangeira associado a alguma entidade da base';
			SELECT vMensagem;
	   END; 		
	   
	   -- fim do código de erro 
	
	SET vNumCliente = (SELECT COUNT(*) FROM clientes WHERE nome = vClienteNome);
		IF vNumCliente > 1 THEN
			SET vMensagem = 'Esse cliente não pode ser usado para incluir o aluguel pelo nome.';
			SELECT vMensagem; 
		ELSE
		
			SET vDias = (SELECT DATEDIFF(vDataFinal, vDataInicio));
			SET vPrecoTotal = vDias * vPrecoUnitario;
		
			-- recebe o nome do cliente via parametro e atualiza o cliente_id atraves da consulta abaixo
			SELECT cliente_id 
				INTO vCliente 
				FROM clientes 
				WHERE nome = vClienteNome;
			
			INSERT INTO alugueis VALUES(vAluguel,
									 vCliente,
									 vHospedagem,
				   				 vDataInicio,
									 vDataFinal,
									 vPrecoTotal);
			
			-- Se o INSERT INTO for executado com sucesso, a mensagem abaixo será exibida
									 
			SET vMensagem = 'Aluguel incluído com sucesso!';
			SELECT vMensagem;
		
		END if;

END $$

delimiter ;

-- ------------------------------------------------------

CALL pc_novo_aluguel_5(10007, 'Júlia Pires', '8635', '2025-03-30', '2025-04-04', 40);

SELECT *
FROM clientes
WHERE nome = 'Júlia Pires';

#---------------------------------------------#
-- Nova PROCEDURE                            --
#---------------------------------------------#

DROP PROCEDURE if EXISTS pc_novo_aluguel_6;

delimiter $$

USE alura1 $$

CREATE PROCEDURE pc_novo_aluguel_6(
	vAluguel       INT(11),
	vClienteNome   VARCHAR(150),
	vHospedagem    VARCHAR(10),
	vDataInicio    DATE,
	vDataFinal     DATE,
	vPrecoUnitario DECIMAL(10,2)
)

BEGIN 

	DECLARE vNumCliente INTEGER;	
	DECLARE vCliente VARCHAR(10);
	DECLARE vDias INT(11) DEFAULT 0;
	DECLARE vPrecoTotal DECIMAL(10,2);
	DECLARE vMensagem VARCHAR(100);
	
		-- Se der o erro 1452 no INSERT INTO o código abaixo será executado com a mensagem de erro

		DECLARE exit handler FOR 1452 -- 1452 é um tipo de erro do MySQL
		
		BEGIN
			SET vMensagem = 'Problema de chave estrangeira associado a alguma entidade da base';
			SELECT vMensagem;
	   END; 		
	   
	   -- fim do código de erro 
	
	SET vNumCliente = (SELECT COUNT(*) FROM clientes WHERE nome = vClienteNome);
		IF vNumCliente > 1 THEN
			SET vMensagem = 'Esse cliente não pode ser usado para incluir o aluguel pelo nome.';
			SELECT vMensagem; 
			
			ELSEIF vNumCliente = 0 THEN
				SET vMensagem = 'Cliente inexistente, não pode ser utilizado na inclusão de um novo aluguel.';
				SELECT vMensagem; 
		ELSE
		
			SET vDias = (SELECT DATEDIFF(vDataFinal, vDataInicio));
			SET vPrecoTotal = vDias * vPrecoUnitario;
		
			-- recebe o nome do cliente via parametro e atualiza o cliente_id atraves da consulta abaixo
			SELECT cliente_id 
				INTO vCliente 
				FROM clientes 
				WHERE nome = vClienteNome;
			
			INSERT INTO alugueis VALUES(vAluguel,
									 vCliente,
									 vHospedagem,
				   				 vDataInicio,
									 vDataFinal,
									 vPrecoTotal);
			
			-- Se o INSERT INTO for executado com sucesso, a mensagem abaixo será exibida
									 
			SET vMensagem = 'Aluguel incluído com sucesso!';
			SELECT vMensagem;
		
		END if;

END $$

delimiter ;

-- ------------------------------------------------------

USE alura1;

CALL pc_novo_aluguel_6(10007, 'Charles Anderson Oliveira', '8635', '2025-03-30', '2025-04-04', 40);

SELECT '2025-01-31' + INTERVAL 5 DAY;


#---------------------------------------------#
-- Nova PROCEDURE                            --
#---------------------------------------------#

DROP PROCEDURE if EXISTS pc_novo_aluguel_7;

delimiter $$

USE alura1 $$

CREATE PROCEDURE pc_novo_aluguel_7(
	-- vAluguel       INT(11),
	vClienteNome   VARCHAR(150),
	vHospedagem    VARCHAR(10),
	vDataInicio    DATE,
	vDataFinal     DATE,
	vPrecoUnitario DECIMAL(10,2)
)

BEGIN 
	DECLARE vAluguel INT(11);
	DECLARE vNumCliente INTEGER;	
	DECLARE vCliente VARCHAR(10);
	DECLARE vDias INT(11) DEFAULT 0;
	DECLARE vPrecoTotal DECIMAL(10,2);
	DECLARE vMensagem VARCHAR(100);
	
		-- Se der o erro 1452 no INSERT INTO o código abaixo será executado com a mensagem de erro

		DECLARE exit handler FOR 1452 -- 1452 é um tipo de erro do MySQL
		
		BEGIN
			SET vMensagem = 'Problema de chave estrangeira associado a alguma entidade da base';
			SELECT vMensagem;
	   END; 		
	   
	   -- fim do código de erro 
	
	SET vNumCliente = (SELECT COUNT(*) FROM clientes WHERE nome = vClienteNome);
		IF vNumCliente > 1 THEN
			SET vMensagem = 'Esse cliente não pode ser usado para incluir o aluguel pelo nome.';
			SELECT vMensagem; 
			
			ELSEIF vNumCliente = 0 THEN
				SET vMensagem = 'Cliente inexistente, não pode ser utilizado na inclusão de um novo aluguel.';
				SELECT vMensagem; 
		ELSE
		
			SET vDias = (SELECT DATEDIFF(vDataFinal, vDataInicio));
			SET vPrecoTotal = vDias * vPrecoUnitario;
		
			-- recebe o nome do cliente via parametro e atualiza o cliente_id atraves da consulta abaixo
			SELECT cliente_id 
				INTO vCliente 
				FROM clientes 
				WHERE nome = vClienteNome;
			
			-- Incrementa aluguel_id de forma automática
			SELECT MAX(t1.aluguel_id) + 1 INTO vAluguel FROM alugueis t1;
			
			INSERT INTO alugueis VALUES(vAluguel,
									 vCliente,
									 vHospedagem,
				   				 vDataInicio,
									 vDataFinal,
									 vPrecoTotal);
			
			-- Se o INSERT INTO for executado com sucesso, a mensagem abaixo será exibida
									 
			SET vMensagem = 'Aluguel incluído com sucesso!';
			SELECT vMensagem;
		
		END if;

END $$

delimiter ;

-- ------------------------------------------------------

USE alura1;

CALL pc_novo_aluguel_7('Marina Nunes', '8635', '2025-04-30', '2025-05-04', 40);

SHOW CREATE TABLE alugueis;

SELECT MAX(t1.aluguel_id) 
FROM alugueis t1

SELECT *
FROM clientes

#---------------------------------------------#
-- Nova PROCEDURE                            --
#---------------------------------------------#

DROP PROCEDURE if EXISTS pc_novo_aluguel_8;

delimiter $$

USE alura1 $$

CREATE PROCEDURE pc_novo_aluguel_8(
	-- vAluguel       INT(11),
	vClienteNome   VARCHAR(150),
	vHospedagem    VARCHAR(10),
	vDataInicio    DATE,
	vDataFinal     DATE,
	vPrecoUnitario DECIMAL(10,2)
)

BEGIN 
	DECLARE vAluguel INT(11);
	DECLARE vNumCliente INTEGER;	
	DECLARE vCliente VARCHAR(10);
	DECLARE vDias INT(11) DEFAULT 0;
	DECLARE vPrecoTotal DECIMAL(10,2);
	DECLARE vMensagem VARCHAR(100);
	
		-- Se der o erro 1452 no INSERT INTO o código abaixo será executado com a mensagem de erro

		DECLARE exit handler FOR 1452 -- 1452 é um tipo de erro do MySQL
		
		BEGIN
			SET vMensagem = 'Problema de chave estrangeira associado a alguma entidade da base';
			SELECT vMensagem;
	   END; 		
	   
	   -- fim do código de erro 
	
	SET vNumCliente = (SELECT COUNT(*) FROM clientes WHERE nome = vClienteNome);
		IF vNumCliente > 1 THEN
			SET vMensagem = 'Esse cliente não pode ser usado para incluir o aluguel pelo nome.';
			SELECT vMensagem; 
			
			ELSEIF vNumCliente = 0 THEN
				SET vMensagem = 'Cliente inexistente, não pode ser utilizado na inclusão de um novo aluguel.';
				SELECT vMensagem; 
		ELSE
		
			SET vDias = (SELECT DATEDIFF(vDataFinal, vDataInicio));
			SET vPrecoTotal = vDias * vPrecoUnitario;
		
			-- recebe o nome do cliente via parametro e atualiza o cliente_id atraves da consulta abaixo
			SELECT cliente_id 
				INTO vCliente 
				FROM clientes 
				WHERE nome = vClienteNome;
			
			-- Incrementa aluguel_id de forma automática
			SELECT MAX(t1.aluguel_id) + 1 INTO vAluguel FROM alugueis t1;
			
			INSERT INTO alugueis VALUES(vAluguel,
									 vCliente,
									 vHospedagem,
				   				 vDataInicio,
									 vDataFinal,
									 vPrecoTotal);
			
			-- Se o INSERT INTO for executado com sucesso, a mensagem abaixo será exibida
									 
			SET vMensagem = CONCAT('Aluguel incluído com sucesso! ID', vAluguel);
			SELECT vMensagem;
		
		END if;

END $$

delimiter ;

-- ------------------------------------------------------

USE alura1;

CALL pc_novo_aluguel_8('Luana Moura', '8635', '2025-04-29', '2025-05-03', 50);

SHOW CREATE TABLE alugueis;

SELECT MAX(t1.aluguel_id) 
FROM alugueis t1

SELECT * 
FROM alugueis t1

SELECT *
FROM clientes

-- 04/02/2025

