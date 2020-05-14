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
User Function xReadTxt()

    // Example of function to read txt file with memoread.
    Sample01()

    // Example of function to read txt file with FT_FUSE.
    Sample02()

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
    local   cFileText   := ""

    // Select file.
    cFile := cGetFile( "Files TXT|*.txt", "Select File", 0, , .F., GETF_LOCALHARD, .T., .T.)

    // Get file text.
    cFileText := memoread(cFile, .F.)

    Alert(cFileText)

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} Sample02
@type static function
@author Julian de Almeida Santos
@since 14/05/2020
/*/
//-------------------------------------------------------------------
Static Function Sample02()

    // Variaveis.
    local   cFile       := ""
    local   cFileText   := ""

    local   nHandle    := 0
    local   MaxLine     := 0
    local   cLinha      := ""


    // Select file.
    cFile := cGetFile( "Files TXT|*.txt", "Select File", 0, , .F., GETF_LOCALHARD, .T., .T.)

    // Get file text.
    cFileText := memoread(cFile, .F.)

    // Trava file para uso.
    nHandle := FT_FUSE(cPath)

    // Se houver erro de abertura abandona processamento
    If nHandle = -1
        Return
    Endif

    // Lê e retorna o número total de linhas do arquivo texto aberto pela função FT_FUse().
    MaxLine := FT_FLASTREC()

    // Posiciona na primeria linha
    FT_FGoTop()

    // Enquanto não for final do arquivo continua lendo o mesmo.
    While !FT_FEOF()

        // Retorna a linha corrente
        nRecno := FT_FRecno()
        
        // Le conteudo da linha posicionada.
        cLinha := FT_FREADLN()

        // Apresenta conteudo do arquivo.
        Alert(cLinha)
        
        // Proxima linha.
        FT_FSKIP()

    EndDo

    // Libera arquivo.
    FT_FUSE()

Return