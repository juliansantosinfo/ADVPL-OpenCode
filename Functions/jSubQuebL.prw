#include 'protheus.ch'
#include 'parmtype.ch'

/*/{Protheus.doc} SubQuebL
@description Retirar quebra de linha de uma string e substituir por uma expressão informada via parametro.
@type function
@author Julian Santos
@since 17/01/2018
@param cTexto, character, String a ter o conteudo substituido.
@param cCharSub, character, Caracterer que sera inserido em substituição a quebra de linha.
@return character, Retorna string com conteudo substituido.
@example SubQuebL("EXEMPLO DE TETXO\r\n") -> "EXEMPLO DE TETXO"
/*/
User Function jSubQuebL(cTexto, cCharSub)

	// Variaveis.
	Default cTexto		:= ""
	Default	cCharSub	:= ""

	// Substitui conteudo.
	cTexto := StrTran(cTexto, CHR(13) + CHR(10), cCharSub)
	cTexto := StrTran(cTexto, CHR(10)          , cCharSub)
	cTexto := StrTran(cTexto, CHR(13)          , cCharSub)
	cTexto := AllTrim(StrEmpty(cTexto))

Return (cTexto)