#include 'protheus.ch'
#include 'parmtype.ch'
#include 'totvs.ch'
#include 'restful.ch'

//-------------------------------------------------------------------
/*/{Protheus.doc} WSCLIENTES
@description WebService para consulta de clientes.
@type wsrestful
@author Julian de Almeida Santos
@since 17/06/2021
/*/
//-------------------------------------------------------------------
WSRESTFUL WSCLIENTES DESCRIPTION "WebService para consulta de clientes."

    WSMETHOD GET; 
    DESCRIPTION "Retorna informacoes do cliente."; 
    WSSYNTAX "/WSCLIENTES/{rota}"

    WSMETHOD POST; 
    DESCRIPTION "Inseri cliente."; 
    WSSYNTAX "/WSCLIENTES"

END WSRESTFUL

//-------------------------------------------------------------------
/*/{Protheus.doc} GET
@description Metodo para requisicoes GET
@type wsmethod
@author Julian de Almeida Santos
@since 17/06/2021
/*/
//-------------------------------------------------------------------
WSMETHOD GET WSSERVICE WSCLIENTES

    // Variaveis.
    local   cRota     := self:aURLParms[1]
    local   cId       := self:aURLParms[2]
    local   oCliente  := JSonObject():New()
    local   cResponse := ""

    // Abre alias SA1
    DBSelectArea('SA1')

    if cRota == "codigo"
        // Define index.
        SA1->(DbSetOrder(1)) // FILIAL + CODIGO + LOJA
        // Valida codigo e loja
        if len(cId) != 8
            SetRestFault(400, EncodeUTF8("Código e Loja é inváldo."))
            return .F.
        endif
    elseif cRota == "cnpj"
        // Abre alias SA1
        SA1->(DbSetOrder(3)) // FILIAL + CNPJ
        // Valida CNPJ
        if len(cId) != 14
            SetRestFault(400, EncodeUTF8("CNPJ é inváldo."))
            return .F.
        endif
    else
        SetRestFault(404, EncodeUTF8("Rota informada não existe."))
        return .F.
    endif

    // Posiciona no topo.
    SA1->(DbGoTop())

    // Posiciona no cliente.
    if !SA1->( DbSeek( xFilial("SA1") + cId ) )
        SetRestFault(404, EncodeUTF8("Cliente não localizado."))
        return .F.
    endif

    oCliente['codigo']      := AllTrim(SA1->A1_COD)
    oCliente['loja']        := AllTrim(SA1->A1_LOJA)
    oCliente['razao']       := AllTrim(SA1->A1_NOME)
    oCliente['nome']        := AllTrim(SA1->A1_NREDUZ)
    oCliente['tipo']        := AllTrim(SA1->A1_TIPO)
    oCliente['cnpj']        := AllTrim(SA1->A1_CGC)
    oCliente['ie']          := AllTrim(SA1->A1_INSCR)
    oCliente['pessoa']      := AllTrim(SA1->A1_PESSOA)
    oCliente['email']       := AllTrim(SA1->A1_EMAIL)
    oCliente['cep']         := AllTrim(SA1->A1_CEP)
    oCliente['endereco']    := AllTrim(SA1->A1_END)
    oCliente['bairro']      := AllTrim(SA1->A1_BAIRRO)
    oCliente['uf']          := AllTrim(SA1->A1_EST)
    oCliente['municipio']   := AllTrim(SA1->A1_MUN)
    oCliente['ddd']         := AllTrim(SA1->A1_DDD)
    oCliente['telefone']    := AllTrim(SA1->A1_TEL)

    // Json to String
    cResponse := oCliente:toJson()

    // Define tipo de retorno.
    self:SetContentType('application/json')

    // Define resposta.
    self:SetResponse( EncodeUTF8( cResponse ) )

return .T.

//-------------------------------------------------------------------
/*/{Protheus.doc} POST
@description Metodo para POST.
@type wsmethod
@author Julian de Almeida Santos
@since 17/06/2021
/*/
//-------------------------------------------------------------------
WSMETHOD POST WSSERVICE WSCLIENTES

    // Variáveis.
    local   cConteudo   := self:getContent()
    local   oCliente    := JsonObject():New()
    local   cCodMun     := ""

    // Parse do conteudo da requisicao.
    cError := oCliente:fromJson(cConteudo)

    // Valida erros no parse.
    if !Empty(cError)
        SetRestFault(400, cError)
        return .F.
    endif

    // Abre alias SA1.
    DBSelectArea('SA1')
    SA1->(DbSetOrder(3)) // FILIAL + CNPJ
    SA1->(DbGoTop())

    // Valida CNPJ.
    if len(oCliente['cnpj']) != 14
        SetRestFault(400, EncodeUTF8('O CNPJ informado tem o comprimento inválido.'))
        return .F.
    endif

    // Verifica se CNPJ existe no cadastro.
    if SA1->( DbSeek( xFilial('SA1') + oCliente['cnpj'] ) )
        SetRestFault(400, EncodeUTF8('O CNPJ informado já está registrado.'))
        return .F.
    endif

    // Busca municipio.
    DBSelectArea('CC2')
    DbSetOrder(2)
    DbGoTop()

    if CC2->( DbSeek( xFilial("CC2") + Upper(oCliente['municipio']) ) )
        cCodMun := CC2->CC2_CODMUN
    endif
    
    // Grava cliente.
    RecLock("SA1", .T.)
    SA1->A1_COD     := GetSx8Num("SA1","A1_COD")
    SA1->A1_LOJA    := "01"
    SA1->A1_NOME    := Upper(oCliente['razao'])
    SA1->A1_NREDUZ  := Upper(oCliente['nome'])
    SA1->A1_TIPO    := Upper(oCliente['tipo'])
    SA1->A1_CGC     := Upper(oCliente['cnpj'])
    SA1->A1_INSCR   := Upper(oCliente['ie'])
    SA1->A1_PESSOA  := Upper(oCliente['pessoa'])
    SA1->A1_EMAIL   := Upper(oCliente['email'])
    SA1->A1_CEP     := Upper(oCliente['cep'])
    SA1->A1_END     := Upper(oCliente['endereco'])
    SA1->A1_BAIRRO  := Upper(oCliente['bairro'])
    SA1->A1_EST     := Upper(oCliente['uf'])
    SA1->A1_MUN     := Upper(oCliente['municipio'])
    SA1->A1_COD_MUN := cCodMun
    SA1->A1_DDD     := Upper(oCliente['ddd'])
    SA1->A1_TEL     := Upper(oCliente['telefone'])
    SA1->A1_MSBLQL  := "2"
    SA1->A1_DTCAD   := Date()
    SA1->A1_HRCAD   := Time()
    MsUnlock()

    // Define o tipo de retorno do método.
	self:SetContentType( 'application/json' )

    // Define a resposta.
    self:SetResponse(EncodeUTF8(oCliente:toJson()))

Return .T.
