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

    // Calcula as dimensoes dos objetos                                         
    oSize := FwDefSize():New(.T.) // Com enchoicebar
	oSize:lLateral     := .F.       // Calculo vertical

    // adiciona Enchoice                                                          
	oSize:AddObject( "ENCHOICE", 100, 60, .T., .T. ) // Adiciona enchoice

    // adiciona folder                                                           
	oSize:AddObject( "FOLDER", 100, 100, .T., .T. ) // Adiciona Folder

    // Dispara o calculo                                                     
	oSize:Process()
    
    // Desenha a dialog
	DEFINE MSDIALOG oDlgEsp TITLE "TITULO" FROM oSize:aWindSize[1],oSize:aWindSize[2] TO oSize:aWindSize[3],oSize:aWindSize[4] PIXEL
    
    // Monta a Enchoice                                                         
	oEnChoice := MsMGet():New( cAlias, nReg, nOpc,,,,,;
	{oSize:GetDimension("ENCHOICE","LININI"),;
	oSize:GetDimension("ENCHOICE","COLINI"),;
	oSize:GetDimension("ENCHOICE","LINEND"),;
	oSize:GetDimension("ENCHOICE","COLEND")};
	, , 3, , , , , ,.T. )

    // Monta o Objeto Folder                                                    
	oFolder:=TFolder():New( oSize:GetDimension("FOLDER","LININI"),;
	oSize:GetDimension("FOLDER","COLINI"),aTitles,aPages,oDlgEsp,,,,.T.,;
	.T.,oSize:GetDimension("FOLDER","XSIZE"),;
	oSize:GetDimension("FOLDER","YSIZE"))

    // Cria a dimensão das getdados, diminuindo um pouco da área do folder //devido ao titulo da pasta e bordas do objeto
	aPosGetD := { 3, 3, oSize:GetDimension("FOLDER","YSIZE") - 16, oSize:GetDimension("FOLDER","XSIZE") - 4 }

    //desenha a getdados
	o2Get:=MSGetDados():New( aPosGetD[1] ,aPosGetD[2],aPosGetD[3],;
	aPosGetD[4],nOpc,"At250LinOk( 2 )",'AllWaysTrue',"+AAO_ITEM",.T.,,,,;
	MAXGETDAD,,,,,oFolder:aDialogs[2])

Return()
