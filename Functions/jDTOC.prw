#include 'protheus.ch'
#include 'parmtype.ch'

/*/{Protheus.doc} jDTOC
@description Converte data para charactere de acordo com numero de digitos.
@type Function
@author Julian Santos
@since  10/01/2018
@param dData
@param nDgtAno
@return Retorna a data formatada em string.
@example U_jDTOC(01/01/2018, 2) -> "01/01/18"
@example U_jDTOC(01/01/2018, 4) -> "01/01/2018"
/*/
User Function jDTOC(dData, nDgtAno)

	// Variaveis.
	Local	cData		:= ""
	Default	dData		:= dDataBase	// Data a ser convertida.
	Default nDgtAno		:= 4			// Numero de digitos par ao ano.

	// Converte data para String.
	cData := DTOS(dData)

	// Retorna vazio caso data esteja em branco.
	If Empty(cData)
		Return (AllTrim(cData))
	EndIf

	// Converte data para characterer de acordo com numero de digitos.
	If nDgtAno == 2
	    cData := SubStr(cData, 07, 02) + "/" + SubStr(cData, 05, 02) + "/" + SubStr(cData, 03, 02)
	Else
		cData := SubStr(cData, 07, 02) + "/" + SubStr(cData, 05, 02) + "/" + SubStr(cData, 01, 04)
	EndIf

Return (cData)