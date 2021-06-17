#include 'protheus.ch'
#include 'parmtype.ch'
#include 'totvs.ch'
#include 'restful.ch'

//-------------------------------------------------------------------
/*/{Protheus.doc} WSFORNECEDORES
@description WebService para consulta de fornecedores.
@type wsrestful
@author Julian de Almeida Santos
@since 16/06/2021
/*/
//-------------------------------------------------------------------
WSRESTFUL WSFORNECEDORES DESCRIPTION "WebService para consulta de fornecedores."

    WSDATA codigo AS STRING
    WSDATA loja AS STRING

    WSMETHOD GET; 
    DESCRIPTION "Retorna informacoes do fornecedor."; 
    WSSYNTAX "/WSFORNECEDORES"

END WSRESTFUL

//-------------------------------------------------------------------
/*/{Protheus.doc} GET
@description Metodo para requisicoes GET
@type wsmethod
@author Julian de Almeida Santos
@since 16/06/2021
/*/
//-------------------------------------------------------------------
WSMETHOD GET WSRECEIVE codigo, loja WSSERVICE WSFORNECEDORES

    // Variaveis.
    local   cCodigo   := iif(valtype(self:codigo)=="U", "", self:codigo)
    local   cLoja     := iif(valtype(self:loja)=="U", "", self:loja)
    local   ofornecedor  := JSonObject():New()
    local   cResponse := ""

    // Abre alias SA2
    DBSelectArea('SA2')
    DbSetOrder(1) // FILIAL + CODIGO + LOJA
    DbGoTop()

    // VALIDA CODIGO E LOJA.
    if len(cCodigo) != 6 .OR. len(cLoja) != 2
        SetRestFault(400, EncodeUTF8("Código ou Loja é inváldo."))
        return .F.
    endif

    // POSICIONA NO FORNECEDOR
    if !SA2->( DbSeek( xFilial("SA2") + cCodigo + cLoja ) )
        SetRestFault(404, EncodeUTF8("Fornecedor não localizado."))
        return .F.
    endif

    // Cria Json.
    oFornecedor['codigo']     := AllTrim(SA2->A2_COD)
    oFornecedor['loja']       := AllTrim(SA2->A2_LOJA)
    oFornecedor['uf']         := AllTrim(SA2->A2_EST)
    oFornecedor['municipio']  := AllTrim(SA2->A2_MUN)
    oFornecedor['bairro']     := AllTrim(SA2->A2_BAIRRO)
    oFornecedor['end']        := AllTrim(SA2->A2_END)
    oFornecedor['cnpj']       := AllTrim(SA2->A2_CGC)

    // Json to String
    cResponse := oFornecedor:toJson()

    // Define tipo de retorno.
    self:SetContentType('application/json')

    // Define resposta.
    self:SetResponse( EncodeUTF8( cResponse ) )

return .T.
