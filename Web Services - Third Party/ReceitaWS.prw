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
User Function ReceitaWS(cCNPJ)

    local   cURLBase    := 'http://www.receitaws.com.br/v1/cnpj/'
    local   cURL        := cURLBase + cCNPJ
    local   cGetPar     := ""
    local   nTimeOut    := 120
    local   aHeaderStr  := {}
    local   cHeaderRet  := ""

    local   oResponse   := JsonObject():New()

    cContent := HttpCGet( cURL , cGetPar , nTimeOut , aHeaderStr , @cHeaderRet)

    // Parse do conteudo da requisicao.
    cError := oResponse:fromJson(cContent)

    // Valida erros no parse.
    if !Empty(cError)
        MsgStop(cError, 'Erro no parser Text -> JsonObject.')
    endif

Return(oResponse)
