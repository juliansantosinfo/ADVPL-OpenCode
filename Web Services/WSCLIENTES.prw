#include 'protheus.ch'
#include 'parmtype.ch'
#include 'totvs.ch'
#include 'restful.ch'

//-------------------------------------------------------------------
/*/{Protheus.doc} WSCLIENTES
@description WebService para consulta de clientes.
@type wsrestful
@author Julian de Almeida Santos
@since 16/06/2021
/*/
//-------------------------------------------------------------------
WSRESTFUL WSCLIENTES DESCRIPTION "WebService para consulta de clientes."

    WSMETHOD GET; 
    DESCRIPTION "Retorna informacoes do cliente."; 
    WSSYNTAX "/WSCLIENTES/{codigo}/{loja}"

END WSRESTFUL

//-------------------------------------------------------------------
/*/{Protheus.doc} GET
@description Metodo para requisicoes GET
@type wsmethod
@author Julian de Almeida Santos
@since 16/06/2021
/*/
//-------------------------------------------------------------------
WSMETHOD GET WSSERVICE WSCLIENTES

    // Variaveis.
    local   cCodigo   := self:aURLParms[1]
    local   cLoja     := self:aURLParms[2]
    local   oCliente  := JSonObject():New()
    local   cResponse := ""

    // Abre alias SA1
    DBSelectArea('SA1')
    DbSetOrder(1) // FILIAL + CODIGO + LOJA
    DbGoTop()

    // VALIDA CODIGO E LOJA.
    if len(cCodigo) != 6 .OR. len(cLoja) != 2
        SetRestFault(400, EncodeUTF8("Código ou Loja é inváldo."))
        return .F.
    endif

    // POSICIONA NO CLIENTE
    if !SA1->( DbSeek( xFilial("SA1") + cCodigo + cLoja ) )
        SetRestFault(404, EncodeUTF8("Cliente não localizado."))
        return .F.
    endif

    // Cria Json.
    oCliente['codigo']     := AllTrim(SA1->A1_COD)
    oCliente['loja']       := AllTrim(SA1->A1_LOJA)
    oCliente['uf']         := AllTrim(SA1->A1_EST)
    oCliente['municipio']  := AllTrim(SA1->A1_MUN)
    oCliente['bairro']     := AllTrim(SA1->A1_BAIRRO)
    oCliente['end']        := AllTrim(SA1->A1_END)
    oCliente['cnpj']       := AllTrim(SA1->A1_CGC)

    // Json to String
    cResponse := oCliente:toJson()

    // Define tipo de retorno.
    self:SetContentType('application/json')

    // Define resposta.
    self:SetResponse( EncodeUTF8( cResponse ) )

return .T.
