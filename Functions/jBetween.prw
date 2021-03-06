#include 'protheus.ch'
#include 'parmtype.ch'

/*/{Protheus.doc} jBetween
@description Verifica se um valor est� contido entre uma faixa m�nima e m�xima.
@type function
@author Julian Santos
@since 28/08/2018
@param xMinimum
@param xMaximum
@param xValue
@return Retorna .T. se o valor estiver entre o maximo e o minimo.
@example U_jBetween(10, 20, 15) -> .T.
@example U_jBetween(10, 20, 21) -> .F.
/*/
User Function jBetween(xMinimum, xMaximum, xValue, lForceNum)

	// Variaveis.
	Default	xMinimum	:= Nil
	Default xMaximum	:= Nil
	Default xValue		:= Nil
	Default lForceNum	:= .F.

	// Transforma valores em numerico.
	If lForceNum

		If Type("xMinimum") == "C"
			xMinimum := Val(xMinimum)
		EndIf

		If Type("xMaximum") == "C"
			xMaximum := Val(xMaximum)
		EndIf

		If Type("xValue") == "C"
			xValue := Val(xValue)
		EndIf

	EndIf

	// V�lida m�nimo.
	If xValue < xMinimum
		Return( .F. )
	EndIf

	// V�lida m�ximo.
	If xValue > xMaximum
		Return( .F. )
	EndIf

Return( .T. )