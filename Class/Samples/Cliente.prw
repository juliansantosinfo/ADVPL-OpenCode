#include 'totvs.ch'
#include 'protheus.ch'

//-------------------------------------------------------------------
/*/{Protheus.doc} cliente
Exemplo de class para representar um cliente.
@type    class
@author  Julian de Almeida Santos
@since   08/04/2019
/*/
//-------------------------------------------------------------------
class clienteSample

    // methods
    method new() constructor
    method getCodigo()
    method setCodigo()
    method getLoja()
    method setLoja()
    method getNome()
    method setNome()
    
    // properties
    data codigo     as String init ""
    data loja       as String init ""
    data nome       as String init ""


endClass

//-------------------------------------------------------------------
/*/{Protheus.doc} new
Method new para class cliente.
@type    method
@author  Julian de Almeida Santos
@since   08/04/2019
/*/
//-------------------------------------------------------------------
method new() class clienteSample
    
    // inicializa propriedades da class
    self:codigo := ""
    self:loja   := ""
    self:nome   := ""

return

//-------------------------------------------------------------------
/*/{Protheus.doc} getCodigo
@type    method
@author  Julian de Almeida Santos
@since   08/04/2019
/*/
//-------------------------------------------------------------------
method getCodigo() class clienteSample
return(self:codigo)

//-------------------------------------------------------------------
/*/{Protheus.doc} setCodigo
@type    method
@author  Julian de Almeida Santos
@since   08/04/2019
/*/
//-------------------------------------------------------------------
method setCodigo(codigo) class clienteSample
    self:codigo := codigo
return

//-------------------------------------------------------------------
/*/{Protheus.doc} getLoja
@type    method
@author  Julian de Almeida Santos
@since   08/04/2019
/*/
//-------------------------------------------------------------------
method getLoja() class clienteSample
return(self:loja)

//-------------------------------------------------------------------
/*/{Protheus.doc} setLoja
@type    method
@author  Julian de Almeida Santos
@since   08/04/2019
/*/
//-------------------------------------------------------------------
method setLoja(loja) class clienteSample
    self:loja := loja
return

//-------------------------------------------------------------------
/*/{Protheus.doc} getNome
@type    method
@author  Julian de Almeida Santos
@since   08/04/2019
/*/
//-------------------------------------------------------------------
method getNome() class clienteSample
return(self:nome)

//-------------------------------------------------------------------
/*/{Protheus.doc} setNome
@type    method
@author  Julian de Almeida Santos
@since   08/04/2019
/*/
//-------------------------------------------------------------------
method setNome(nome) class clienteSample
    self:nome := nome
return