#include 'protheus.ch'
#include 'parmtype.ch'
#include 'totvs.ch'
#include 'topconn.ch'
#include 'tbiconn.ch'

//-------------------------------------------------------------------
/*/{Protheus.doc} _FWDefSize
@description Exemplo para classe FWDefSize
@author Julian de Almeida Santos
@since 30/05/2023
/*/
//-------------------------------------------------------------------
User Function _FWDefSize()

	Local oSize
	Local lEnchoice := .T.

    // Calcula as dimensoes dos objetos                                         
    oSize := FwDefSize():New(lEnchoice) // Com enchoicebar

    // adiciona Enchoice
	oSize:AddObject( "ENCHOICE", 100, 60, .T., .T. ) // Adiciona enchoice

    // adiciona folder                                                           
	oSize:AddObject( "GETDADOS", 100, 100, .T., .T. ) // Adiciona Folder

    // Dispara o calculo                                                     
	oSize:Process()

	// Retorna posicoes ENCHOICE
	nLinIni := oSize:GetDimension("ENCHOICE","LININI")
	nLinEnd := oSize:GetDimension("ENCHOICE","LINEND")
	nColIni := oSize:GetDimension("ENCHOICE","COLINI")
	nColEnd := oSize:GetDimension("ENCHOICE","COLEND")
	Alert("ENCHOICE" + CRLF + "Linha inicial " + str(nLinIni) + CRLF + "Linha final " + str(nLinEnd) + CRLF + "Coluna inicial " + str(nColIni) + CRLF + "Coluna final " + str(nColEnd))

	// Retorna posicoes GETDADOS
	nLinIni := oSize:GetDimension("GETDADOS","LININI")
	nLinEnd := oSize:GetDimension("GETDADOS","LINEND")
	nColIni := oSize:GetDimension("GETDADOS","COLINI")
	nColEnd := oSize:GetDimension("GETDADOS","COLEND")
	Alert("GETDADOS" + CRLF + "Linha inicial " + str(nLinIni) + CRLF + "Linha final " + str(nLinEnd) + CRLF + "Coluna inicial " + str(nColIni) + CRLF + "Coluna final " + str(nColEnd))
    
Return()
