#include 'protheus.ch'
#include 'parmtype.ch'
#include 'totvs.ch'

//-------------------------------------------------------------------
/*/{Protheus.doc} xReadTxt
@description Sample for reading text files.
@type user function
@author Julian de Almeida Santos
@since 14/05/2020
/*/
//-------------------------------------------------------------------
User Function xReadCSV()

    // Example of function to read csv file with FT_FUSE.
    Sample01()

Return()

//-------------------------------------------------------------------
/*/{Protheus.doc} Sample01
@type static function
@author Julian de Almeida Santos
@since 14/05/2020
/*/
//-------------------------------------------------------------------
Static Function Sample01()

    // Variaveis.
    local   cFile       := ""
    local   nHandle     := 0
    local   cLinha      := ""
    local   lPrim       := .T.
    local   aCampos     := {}
    local   aDados      := {}

    // Select file.
    cFile := cGetFile( "Files CSV|*.csv", "Select csv File", 0, , .F., GETF_LOCALHARD, .T., .T.)

    // Trava file para uso.
    nHandle := FT_FUSE(cFile)

    // Se houver erro de abertura abandona processamento
    If nHandle = -1
        Return
    Endif

    // Posiciona na primeria linha
    FT_FGoTop()

    // Enquanto não for final do arquivo continua lendo o mesmo.
    While !FT_FEOF()
        
        // Le conteudo da linha posicionada.
        cLinha := FT_FREADLN()

        If lPrim
            aCampos := Separa(cLinha, ";", .T.)
			lPrim   := .F.
		Else
			AADD(aDados, Separa(cLinha, ";", .T.))
		EndIf
        
        // Proxima linha.
        FT_FSKIP()

    EndDo

    // Libera arquivo.
    FT_FUSE()

Return