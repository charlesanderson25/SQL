/* Fokus.db */

/*
Trabalhando com datas

Extrair apenas o ano e o mes de uma data no formato americano

Note que o 'm' referente ao mês no primeiro parametro da função STRFTIME() é minusculo

*/

SELECT * from Licencas;

SELECT  *, 
		STRFTIME('%Y/%m', datainicio) as Mes_Ano_inicio
from Licencas;

/*
Função JULIANDAY, calcula a diferença entre datas
*/

SELECT *, 
	   JULIANDAY(datafim) - JULIANDAY(datainicio) AS QTD_DIAS_LICENCA
FROM Licencas;

/*
Função DATE
Funcionalidade: A função DATE é usada para extrair a data de um valor de data e hora ou para obter a data atual. Ela retorna a data no formato 'YYYY-MM-DD'.
Sintaxe Básica: DATE('now', '[modificador]')
Exemplo de Uso: Para obter a data atual:
*/

SELECT DATE('now');

/*
Para obter a data 10 dias atrás:
*/

SELECT DATE('NOW', '-10 DAYS');

/*
Função TIME
Funcionalidade: A função TIME é usada para extrair a hora de um valor de data e hora ou para obter a hora atual. Ela retorna a hora no formato 'HH:MM:SS'.
Sintaxe Básica: TIME('now', '[modificador]')
Exemplo de Uso: Para obter a hora atual:
*/

SELECT TIME('NOW');

/*
Função DATETIME
Funcionalidade: DATETIME é uma função mais abrangente que retorna tanto a data quanto a hora no formato 'YYYY-MM-DD HH:MM:SS'. Pode ser usada para obter o momento atual ou converter/modificar valores de data e hora existentes.
Sintaxe Básica: DATETIME('now', '[modificador]')
Exemplo de Uso: Para obter a data e hora atuais:
*/

SELECT DATETIME('NOW');

/*
Para obter a data e hora exatas 1 ano no futuro:
*/

SELECT DATETIME('NOW', '+1 YEAR');

/*
Função CURRENT_TIMESTAMP
Funcionalidade: CURRENT_TIMESTAMP é uma função de conveniência que retorna a data e hora atuais no formato 'YYYY-MM-DD HH:MM:SS'. É equivalente a usar DATETIME('now').
Sintaxe Básica: CURRENT_TIMESTAMP
Exemplo de Uso: Para obter o timestamp atual:
*/

SELECT CURRENT_TIMESTAMP;