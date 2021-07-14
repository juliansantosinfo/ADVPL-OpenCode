#include 'protheus.ch'
#include 'parmtype.ch'
#include 'totvs.ch'

//-------------------------------------------------------------------
/*/{Protheus.doc} CNPJValid
@description Valida CNPJ.
@type user function
@since 14/07/2021
@author Julian de Almeida Santos
/*/
//-------------------------------------------------------------------
User Function CNPJValid(cCNPJ, cError)

    // Valida se CNPJ esta vazio ou tem um tamanho invalido.
    if empty(cCNPJ) .OR. len(cCNPJ) != 14
        return .F.
    endif

    if substr(cCNPJ, 13, 2) != DigCNPJ(cCNPJ)
        return .F.
    endif

Return(.T.)

//-------------------------------------------------------------------
/*/{Protheus.doc} DigCNPJ
@description Digito verificador para CNPJ.
@type user function
@since 14/07/2021
@author Julian de Almeida Santos

Fonte original retirado do blog Tudo em AdvPL.
Link do post: https://siga0984.wordpress.com/2019/05/18/algoritmos-validacao-de-cnpj
/*/
//-------------------------------------------------------------------
Static Function DigCNPJ(cCNPJ)

    // Variaveis.
    local   nI , nVL  
    local   nM1 := 5, nM2 := 6
    local   nDV1 := 0, nDV2 := 0
    local   cRet

    // Calculo do valor base para os digitos verificadores, de acordo com o peso da formula. 
    For nI := 1 to 12
        nVL := val( substr(cCNPJ,nI,1) )
        nDV1 += (  nVL * nM1 )
        nDV2 += (  nVL * nM2 )
        nM1--           
        IF nM1 < 2 
            nM1 := 9
        Endif
        nM2--           
        IF nM2 < 2 
            nM2 := 9
        Endif
    Next

    // Cálculo do primeiro dígito
    nDV1 := nDV1 % 11
    IF nDV1 < 2 
        nDV1 := 0 
    Else
        nDV1 := 11 - nDV1
    Endif

    // Cálculo do segundo digito 
    nDV2 += ( nDV1 * 2 )  
    nDV2 := nDV2 % 11
    IF nDV2 < 2 
        nDV2 := 0 
    Else
        nDV2 := 11 - nDV2
    Endif

    cRet := chr(48+nDV1)+chr(48+nDV2)

Return(cRet)
