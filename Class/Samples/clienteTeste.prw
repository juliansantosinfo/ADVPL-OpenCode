#include 'totvs.ch'
#include 'protheus.ch'
#include 'parmtype.ch'

//-------------------------------------------------------------------
/*/{Protheus.doc} clienteTeste
Teste para class cliente.
@type user function
@author  Julian de Almeida Santos
@since   08/04/2019
/*/
//-------------------------------------------------------------------
user function clienteTeste

    cliente := clienteSample():new()

    cliente:setCodigo("000001")
    cliente:setLoja("01")
    cliente:setNome("CLIENTE PADRAO")

    Alert(cliente:getCodigo())
    Alert(cliente:getLoja())
    Alert(cliente:getNome())

return