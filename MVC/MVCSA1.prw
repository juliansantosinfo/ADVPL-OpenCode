#include 'protheus.ch'
#include 'parmtype.ch'

User Function MVCSA1()

    // Variaveis.
    Local   cAlias      := ""
    Local   cDescription:= ""
    private oBrowser    := Nil
    
    // Define browser.
    oBrowser := FWBrowser()
    oBrowser:SetAlias(cAlias)
    oBrowser:SetDescription(cDescription)

Return()

Static Function menudef()

    // Variaveis.
    Local aRotina

    // Popula array com opções do menu.
    // Posições do Array
    // 1. Nome da opção no menu   
    // 2. Nome da Rotina associada                                
    // 3. Usado pela rotina                                       
    // 4. Tipo de Operação a ser efetuada
    AADD(aRotina, {})
    AADD(aRotina, {})
    AADD(aRotina, {})
    AADD(aRotina, {})
    AADD(aRotina, {})

Return(aRotina)

Static Function modeldef()
Return()

Static Function viewdef()
Return()