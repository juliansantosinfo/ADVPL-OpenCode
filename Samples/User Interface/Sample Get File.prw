#include 'protheus.ch'
#include 'parmtype.ch'
#include 'totvs.ch'
#include 'fileio.ch'

//-------------------------------------------------------------------
/*/{Protheus.doc} xGetFile
@description Sample for selection of files or directories.
@type user function
@author Julian de Almeida Santos
@since 14/05/2020
/*/
//-------------------------------------------------------------------
User Function xGetFile()

    // Example of function to get file path.
    Sample01()

    // Example of function to get path.
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

    local   cMask       := "Arquivos TXT|*.txt|Arquivos CSV|*.csv|Arquivos PRW|*.prw"
    local   cTitle      := "Selecione um Arquivo TXT"
    local   cMaskDefault:= 0
    local   cDirinicial := "/"
    local   lSave       := .F.
    local   nOptions     := GETF_LOCALFLOPPY + GETF_LOCALHARD + GETF_NETWORKDRIVE
    local   lShowServer := .T.
    local   lKeepCase   := .T.
    local   cSelected   := ""

    // GETF_MULTISELECT  = Permite selecionar mais de 1 arquivo no padrão "arquivo1 | arquivo2 | arquivo3" 
    // GETF_NOCHANGEDIR  = Não permite mudar o diretório inicial..
    // GETF_LOCALFLOPPY  = Apresenta a unidade do disquete da máquina local.
    // GETF_LOCALHARD    = Apresenta a unidade do disco local.
    // GETF_NETWORKDRIVE = Apresenta as unidades da rede (mapeamento). 
    // GETF_SHAREWARE    = Não implementado.
    // GETF_RETDIRECTORY = Retorna/apresenta um diretório.
    // GETF_HIDDENDIR    = Mostra arquivos e pastas ocultas
    // GETF_SYSDIR       = Mostra arquivos e pastas do sistema

    // --------------
    // Open File
    // --------------
    cSelected:= cGetFile( cMask , cTitle, cMaskDefault, cDirinicial, lSave, nOptions, lShowServer, lKeepCase)
  
    Alert(cSelected)

    // --------------
    // Open File MultSelect
    // --------------

    nOptions += GETF_MULTISELECT

    cSelected:= cGetFile( cMask , cTitle, cMaskDefault, cDirinicial, lSave, nOptions, lShowServer, lKeepCase)

    Alert(cSelected)

    aSelecteds := StrTokArr(cSelected, "|")
  
    for nI := 1 to Len(aSelecteds)
        Alert(aSelecteds[nI])
    next

    // --------------
    // Save File
    // --------------
    lSave := .F.

    cSelected:= cGetFile( cMask , cTitle, cMaskDefault, cDirinicial, lSave, nOptions, lShowServer, lKeepCase)

    Alert(cSelected)

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} Sample01
@type static function
@author Julian de Almeida Santos
@since 14/05/2020
/*/
//-------------------------------------------------------------------
Static Function Sample02()

    local   cMask       := "Arquivos TXT|*.txt|Arquivos CSV|*.csv|Arquivos PRW|*.prw"
    local   cTitle      := "Selecione um Arquivo TXT"
    local   cMaskDefault:= 0
    local   cDirinicial := "/"
    local   lSave       := .F.
    local   nOptions     := GETF_LOCALFLOPPY + GETF_LOCALHARD + GETF_NETWORKDRIVE + GETF_RETDIRECTORY
    local   lShowServer := .T.
    local   lKeepCase   := .T.
    local   cSelected   := ""

    // GETF_MULTISELECT  = Permite selecionar mais de 1 arquivo no padrão "arquivo1 | arquivo2 | arquivo3" 
    // GETF_NOCHANGEDIR  = Não permite mudar o diretório inicial..
    // GETF_LOCALFLOPPY  = Apresenta a unidade do disquete da máquina local.
    // GETF_LOCALHARD    = Apresenta a unidade do disco local.
    // GETF_NETWORKDRIVE = Apresenta as unidades da rede (mapeamento). 
    // GETF_SHAREWARE    = Não implementado.
    // GETF_RETDIRECTORY = Retorna/apresenta um diretório.
    // GETF_HIDDENDIR    = Mostra arquivos e pastas ocultas
    // GETF_SYSDIR       = Mostra arquivos e pastas do sistema

    // --------------
    // Open File
    // --------------
    cSelected:= cGetFile( cMask , cTitle, cMaskDefault, cDirinicial, lSave, nOptions, lShowServer, lKeepCase)
  
    Alert(cSelected)

    // --------------
    // Save File
    // --------------
    lSave := .F.

    cSelected:= cGetFile( cMask , cTitle, cMaskDefault, cDirinicial, lSave, nOptions, lShowServer, lKeepCase)

    Alert(cSelected)

Return