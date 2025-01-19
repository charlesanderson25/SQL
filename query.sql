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