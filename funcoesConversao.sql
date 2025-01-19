/*
Funções de conversão
*/

/*
Sem conversão
*/

SELECT (' O faturamento bruto médio foi de R$ ' || faturamento_bruto )
FROM faturamento;

/*
Utilizando a função CAST para conversão do faturamento em string
*/

SELECT (' O faturamento bruto médio foi de R$ ' || CAST(ROUND(AVG(faturamento_bruto),2) AS FATURAMENTO_TEXT))
FROM faturamento;