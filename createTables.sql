CREATE TABLE alura.tb_produtos (
	ID INT PRIMARY KEY,
	NOME VARCHAR(255),
	DESCRICAO VARCHAR(255),
	PRECO DECIMAL(10, 2),
	CATEGORIA VARCHAR(50)
);

CREATE TABLE alura.tb_colaboradoes (
	ID INT PRIMARY KEY,
	NOME VARCHAR(100),
	CARGO VARCHAR(100),
	DATACONTRATACAO DATE,
	TELEFONE VARCHAR(20),
	EMAIL VARCHAR(100),
	RUA VARCHAR(100) NOT NULL, 
	BAIRRO VARCHAR(100) NOT NULL,
	CIDADE VARCHAR(100) NOT NULL,
	ESTADO VARCHAR(2) NOT NULL,
	CEP VARCHAR(8) NOT NULL
);

CREATE TABLE alura.tb_fornecedores (
	ID INT PRIMARY KEY,
	NOME VARCHAR(100) NOT NULL,
	CONTATO VARCHAR(100) NOT NULL,
	TELEFONE VARCHAR(20),
	EMAIL VARCHAR(100),
	RUA VARCHAR(100) NOT NULL, 
	BAIRRO VARCHAR(100) NOT NULL,
	CIDADE VARCHAR(100) NOT NULL,
	ESTADO VARCHAR(2) NOT NULL,
	CEP VARCHAR(8) NOT NULL	
);

CREATE TABLE alura.tb_clientes (
	ID INT PRIMARY KEY NOT NULL,
	NOME VARCHAR(255),
	TELEFONE VARCHAR(20),
	EMAIL VARCHAR(100) DEFAULT 'SEM E-MAIL',
	ENDERECO VARCHAR(255)
);

CREATE TABLE alura.tb_pedidos (
	ID INT PRIMARY KEY NOT NULL,
	IDCLIENTE INT, 
	DATAHORAPEDIDO DATETIME,
	STATUS VARCHAR(50),
	FOREIGN KEY (IDCLIENTE) REFERENCES alura.tb_clientes(ID) ON DELETE CASCADE
);

CREATE TABLE alura.tb_itenspedidos (
	IDPEDIDO INT,
	IDPRODUTO INT,
	QUANTIDADE INT,
	PRECOUNITARIO DECIMAL(10, 2),
	PRIMARY KEY(IDPEDIDO, IDPRODUTO),
	FOREIGN KEY (IDPEDIDO) REFERENCES alura.tb_pedidos(ID) ON DELETE CASCADE,
	FOREIGN KEY (IDPRODUTO) REFERENCES alura.tb_pedidos(ID) ON DELETE CASCADE
);
