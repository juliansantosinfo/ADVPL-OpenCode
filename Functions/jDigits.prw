#include 'protheus.ch'
#include 'parmtype.ch'

/*/{Protheus.doc} jDigits
@description Verifica se uma string contém caracteres numéricos.
@type function
@author Julian Santos
@since 28/08/2018
@param cString
@return Retorna .T. se a string contém caracteres numéricos.
@example U_jHasDigits("ABC123") -> .T.
@example U_jHasDigits("ABCDEG") -> .F.
/*/
User Function jHasDigits(cString)

	// Variaveis.
	Local	lRet 	:= .F.
	Local	cDigit	:= "0123456789"
	Local	nL		:= 0

	// Percorre string letra a letra.
	For nL := 1 to Len(cString)

		// Valida se char informado esta contido na string de digitos.
		If SubStr(cString, nL, 01) $ cDigit
			lRet := .T.
			Exit
		EndIf

	Next

Return (lRet)

/*/{Protheus.doc} jIsDigit
@description Verifica se um charactere representa um numero 0-9.
@type function
@author Julian Santos
@since 28/08/2018
@param cChar
@return Retorna .T. se a string contém caracteres numéricos.
@example U_jIsDigit("1") -> .T.
@example U_jIsDigit("A") -> .F.
/*/
User Function jIsDigit(cChar)

	// Variaveis.
	Local	lRet 	:= .F.
	Local	cDigit	:= "0123456789"

	// Valida se char informado esta contido na string de digitos.
	If cChar $ cDigit
		lRet := .T.
	EndIf

Return (lRet)

/*/{Protheus.doc} jOnlyDigits
@description Verifica se existem apenas caracteres numéricos na string informada no parametro.
@type function
@author Julian Santos
@since 28/08/2018
@param cString
@param lComma
@param lDot
@return Retorna .T. se a string contém caracteres numéricos.
@example U_jOnlyDigits("123456") -> .T.
@example U_jOnlyDigits("A23456") -> .F.
/*/
User Function jOnlyDigits(cString, lComma, lDot)

	// Variaveis.
	Local	lRet 	:= .T.
	Local	cDigit	:= "0123456789"
	Local	nL		:= 0
	Default	lComma	:= .F.
	Default	lDot	:= .F.

	// Valida se considera ponto e a virgula.
	cDigit += IIf(lComma, ",", "")
	cDigit += IIf(lDot  , ".", "")

	// Percorre string letra a letra.
	For nL := 1 to Len(cString)

		// Valida se char informado não esta contido na string de digitos.
		If !( SubStr(cString, nL, 01) $ cDigit )
			lRet := .F.
			Exit
		EndIf

	Next

Return (lRet)