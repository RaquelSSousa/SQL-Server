--BEGIN TRAN

SELECT * 
FROM LY_CONSULTA_DINAMICA
WHERE TITULO = 'Total De Alunos Por Coordenador'

--sp:sp_csvTotalAlunosCoordenador(@p_ano,  @p_periodo, @p_sit_aluno,  @p_curso, @p_unidade_resp,  @p_turno

/******* Atualizando Consulta Dinâmica com novas variáveis *******/
UPDATE LY_CONSULTA_DINAMICA 
SET STORED_PROCEDURE = 'sp:sp_csvTotalAlunosCoordenador(@p_ano,  @p_periodo, @p_sit_aluno,  @p_curso, @p_unidade_resp,  @p_turno, @p_coordenador)'
WHERE ID = '135'

SELECT * 
FROM LY_CONSULTA_DINAMICA_PARAMETROS
WHERE ID_CONSULTA_DINAMICA = '135'

/******* Atualizando os parâmetros em ordem decrescente *******/
UPDATE LY_CONSULTA_DINAMICA_PARAMETROS
SET 
SQL_TEXTO = 'SELECT DISTINCT CONVERT(VARCHAR(4),ANO) AS VALOR, CONVERT(VARCHAR(4),ANO) AS DESCR FROM LY_HISTMATRICULA ORDER BY VALOR DESC'
WHERE ID = '1705'

/******* Inserindo os novo parâmetro solicitados no chamado *******/
INSERT INTO LY_CONSULTA_DINAMICA_PARAMETROS(
ID_CONSULTA_DINAMICA
,ORDEM
,PARAMETRO
,TIPO
,DESCRICAO
,OBRIGATORIO
,SQL_TEXTO
,COL_VALOR
,COL_DESCR
,MULTIPLOS_VALORES
)
VALUES (
(SELECT ID
FROM LY_CONSULTA_DINAMICA
WHERE ID = '135')
,'7'
,'p_coordenador'
,'5'
,'Coordenador'
,'N'
,'SELECT DISTINCT (CO.NUM_FUNC) AS VALOR, DO.NOME_COMPL AS DESCR FROM LY_COORDENACAO CO JOIN LY_DOCENTE DO ON CO.NUM_FUNC = DO.NUM_FUNC ORDER BY DO.NOME_COMPL ASC '
,'VALOR'
,'DESCR'
,'N'
)

