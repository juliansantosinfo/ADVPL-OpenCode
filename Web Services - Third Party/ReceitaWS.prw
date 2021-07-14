#include 'protheus.ch'
#include 'parmtype.ch'
#include 'totvs.ch'

//-------------------------------------------------------------------
/*/{Protheus.doc} ReceitaWS
@description Consome webservice ReceitaWS, buscando empresa por CNPJ.
@type user function
@since 14/07/2021
@author Julian de Almeida Santos
/*/
//-------------------------------------------------------------------
User Function ReceitaWS(cCNPJ, cError)

    local   cURLBase    := 'http://www.receitaws.com.br/v1/cnpj/'
    local   cURL        := cURLBase + cCNPJ
    local   cGetPar     := ""
    local   nTimeOut    := 120
    local   aHeaderStr  := {}
    local   cHeaderRet  := ""
    local   oResponse   := JsonObject():New()
    default cError      := ""

    cContent := HttpCGet( cURL , cGetPar , nTimeOut , aHeaderStr , @cHeaderRet)

    // Parse do conteudo da requisicao.
    cError := oResponse:fromJson(cContent)

Return(oResponse)

//-------------------------------------------------------------------
/*/{Protheus.doc} TestReceitaWS
@description Teste da funcao ReceitaWS.
@type user function
@since 14/07/2021
@author Julian de Almeida Santos
/*/
//-------------------------------------------------------------------
User Function TestReceitaWS()

    // Variaveis.
    local   cCNPJ   := "00394460000141"
    local   cError  := ""

    oCNPJ      := U_ReceitaWS(cCNPJ, @cError)
    aCNPJProps := oCNPJ:GetNames()

    for nI := 1 to len(aCNPJProps)
        cProp := aCNPJProps[nI]
        alert(cProp + ': ' + oCNPJ[cProp])
    next

Return()
