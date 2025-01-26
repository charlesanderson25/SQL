-- CURSO ANALISE DE DADOS COM SQL
-- BANCO DE DADOS 'VENDAS'

SELECT * FROM produtos;

SELECT COUNT(id_produto) FROM produtos;
SELECT COUNT(*) FROM produtos;

SELECT 
	COUNT(*) AS VENDAS_TOTAIS 
    FROM vendas;

SELECT * 
FROM vendas
LIMIT 10;

SELECT  STRFTIME('%Y', data_venda) AS ANO,
		STRFTIME('%m', data_venda) AS MES,
	    COUNT(id_venda)
        
	FROM vendas
    WHERE MES IN ('11', '12', '01')
    GROUP BY ANO, MES
    ORDER BY ANO;
    
SELECT *
FROM fornecedores;
   
SELECT *
FROM vendas;
   	
SELECT T1.produto_id,
	   T2.nome_produto,
       T3.id_fornecedor,
       T3.nome AS NOME_FORNECEDOR
FROM itens_venda T1
INNER JOIN produtos T2
	ON T1.produto_id = T2.id_produto
INNER JOIN fornecedores T3
	ON T2.fornecedor_id = T3.id_fornecedor;
   
SELECT *
FROM produtos;