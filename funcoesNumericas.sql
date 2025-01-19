/* Fokus.db */

/*
Funções Numéricas
*/

SELECT * FROM faturamento;

/*
Media faturamento arredondando com 2 casas decimais
*/

SELECT *, 
	   ROUND(AVG(faturamento_bruto),2) AS MEDIA_FATURAMENTO
FROM faturamento
WHERE MES LIKE '%2018';

/*
Função CEIL arredonda para o inteiro maior
*/

SELECT *, 
	   CEIL(faturamento_bruto) as faturamento_round
from faturamento;

/*
Função FLOOR arredonda para o inteiro menor
*/

SELECT *, 
	   FLOOR(faturamento_bruto) as faturamento_round
from faturamento;