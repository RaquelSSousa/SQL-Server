USE [Lyceum]
GO
/** Object:  StoredProcedure [dbo].[csvRelValidacaoRDStationCandidatos]    **/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[csvRelValidacaoRDStationCandidatos]
@PeriodoLetivo varchar(10),
@p_estagio_candidato varchar(20),
@p_SIT_ACADEMICA varchar(20),
@p_ANO_ENCERRAMENTO varchar(10),
@p_STATUS_FINANCEIRO varchar(20),
@p_DATA_VENCIMENTO_MENSALIDADE T_DATA --origem desse tipo de parâmetro: SP_csvRetornoCobrancasInstituicao Ele já filtra trazendo o formato de data para o padrão brasileiro.
as



--** PARAMETRROS DE TESTE
--@PeriodoLetivo varchar(10),
--@p_estagio_candidato varchar(20),
--@p_SIT_ACADEMICA varchar(20),
--@p_ANO_ENCERRAMENTO varchar(10),
--@p_STATUS_FINANCEIRO varchar(20),
--@p_DATA_VENCIMENTO_MENSALIDADE varchar(30)
 
--SET @PeriodoLetivo = '2024.2'
--SET @p_estagio_candidato = '*'
--SET @p_SIT_ACADEMICA = '*'
--SET @p_ANO_ENCERRAMENTO = '*'
--SET @p_STATUS_FINANCEIRO = '*'
--SET @p_DATA_VENCIMENTO_MENSALIDADE = '*'
 
SELECT	*
FROM	[dbo].[VW_INT_LYCEUM_RDSTATION]
WHERE	((PERIODO_LETIVO		= @PeriodoLetivo AND @PeriodoLetivo <> '*' ) OR (@PeriodoLetivo = '*'))
AND		((estagio_candidato		= @p_estagio_candidato AND @p_estagio_candidato <> '*' ) OR (@p_estagio_candidato = '*'))
AND		((SIT_ACADEMICA			= @p_SIT_ACADEMICA AND @p_SIT_ACADEMICA <> '*' ) OR (@p_SIT_ACADEMICA = '*'))
AND		((CONVERT(VARCHAR, ANO_ENCERRAMENTO) = @p_ANO_ENCERRAMENTO AND @p_ANO_ENCERRAMENTO <> '*' ) OR (@p_ANO_ENCERRAMENTO = '*'))-- Origem com tratamento pra Todos e conversão para VARCHAR: SP_csvAlunosMatriculados
AND		((STATUS_FINANCEIRO	 = @p_STATUS_FINANCEIRO AND @p_STATUS_FINANCEIRO <> '*' ) OR (@p_STATUS_FINANCEIRO = '*'))
AND		((@p_DATA_VENCIMENTO_MENSALIDADE IS NOT NULL AND CONVERT(VARCHAR, DATA_VENCIMENTO_MENSALIDADE) = @p_DATA_VENCIMENTO_MENSALIDADE) OR @p_DATA_VENCIMENTO_MENSALIDADE IS NULL) -- Origem com tratamento pra Null q também funciona como todos: SP_csvRetornoCobrancasInstituicao