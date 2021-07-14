#include 'protheus.ch'
#include 'parmtype.ch'
#include 'totvs.ch'

//-------------------------------------------------------------------
/*/{Protheus.doc} ViaCEP
@description Consome webservice ViaCEP, buscando endereço por CEP.
@type user function
@since 14/07/2021
@author Julian de Almeida Santos
/*/
//-------------------------------------------------------------------
User Function ViaCEP(cCEP, cError)

    local   cURLBase    := 'viacep.com.br/ws/'
    local   cURL        := ""
    local   cGetPar     := ""
    local   nTimeOut    := 120
    local   aHeaderStr  := {}
    local   cHeaderRet  := ""
    local   oResponse   := JsonObject():New()
    default cError      := ""

    // Valida CEP
    if empty(cCEP) .OR. len(cCEP) != 8
        cError := "CEP informado esta vazio ou não contem 8 digitos."
        return(oResponse)
    endif

    // Define URL.
    cURL := cURLBase + cCEP + "/json"

    // Processa requisicao.
    cContent := HttpCGet( cURL , cGetPar , nTimeOut , aHeaderStr , @cHeaderRet)

    // Parse do conteudo da requisicao.
    cError := oResponse:fromJson(cContent)

Return(oResponse)

//-------------------------------------------------------------------
/*/{Protheus.doc} TestViaCEP
@description Teste da funcao ViaCEP.
@type user function
@since 14/07/2021
@author Julian de Almeida Santos
/*/
//-------------------------------------------------------------------
User Function TestViaCEP()

    // Variaveis.
    local   cCEP    := "13487200"
    local   cError  := ""

    oCEP      := U_ViaCEP(cCEP, @cError)
    aCEPProps := oCEP:GetNames()

    for nI := 1 to len(aCEPProps)
        cProp := aCEPProps[nI]
        alert(cProp + ': ' + oCEP[cProp])
    next

Return()
