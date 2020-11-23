//Bibliotecas
#Include "Protheus.ch"
 
/*/{Protheus.doc} zPrettyXML
Fun��o que serve para quebrar um XML e deix�-lo indentado para o usu�rio
@author Atilio
@since 13/05/2018
@version 1.0
@param cTextoOrig, characters, descricao
@type function
@example Exemplo Abaixo
    //..............
    cTextoOrig := MemoRead("C:\TOTVS\notas\original.xml")
    cTextoNovo := ""
     
    cTextoNovo := u_zPrettyXML(cTextoOrig)
     
    Aviso('Aten��o', cTextoNovo, {'OK'}, 03)
    //..............
/*/
 
User Function zPrettyXML(cTextoOrig)
    
    Local aArea      := GetArea()
    Local cTextoNovo := ""
    Local aLinhas    := {}
    Local cEspaco    := ""
    Local nAbriu     := 0
    Local nAtual     := 0
    Local aLinNov    := {}
     
    //Se tiver conte�do texto, e tiver o trecho de XML
    If ! Empty(cTextoOrig) .And. '<?xml version=' $ cTextoOrig
         
        //Substitui a fecha chaves para um enter
        cTextoNovo := StrTran(cTextoOrig, "</",                "zPrettyXML_QUEBR")
        cTextoNovo := StrTran(cTextoNovo, "<",                 CRLF + "<")
        cTextoNovo := StrTran(cTextoNovo, ">",                 ">" + CRLF)
        cTextoNovo := StrTran(cTextoNovo, "zPrettyXML_QUEBR",  CRLF + "</")
         
        //Pega todas as linhas
        aLinhas := StrTokArr(cTextoNovo, CRLF)
         
        //Percorre as linhas adicionando espa�os em branco
        For nAtual := 1 To Len(aLinhas)
            //Somente se tiver conte�do
            If ! Empty(aLinhas[nAtual])
             
                //Se for abertura de tag, e n�o for fechamento na mesma linha, aumenta a tabula��o 
                If "<" $ aLinhas[nAtual] .And. ! "<?" $ aLinhas[nAtual] .And. ! "</" $ aLinhas[nAtual] .And. ! "/>" $ aLinhas[nAtual]
                    nAbriu += 1
                EndIf
                 
                //Definindo a quantidade de espa�os em branco, conforme n�mero de tags abertas
                cEspaco := ""
                If nAbriu > 0
                    cEspaco := Replicate(' ', 2 * (nAbriu + Iif(! "<" $ aLinhas[nAtual], 1, 0)) )
                EndIf
                 
                //Monta agora o texto com a tabula��o
                aAdd(aLinNov, cEspaco + aLinhas[nAtual])
                 
                //Se for fechamento de tag, diminui a tabula��o
                If "</" $ aLinhas[nAtual] .And. At('<', SubStr(aLinhas[nAtual], 2, Len(aLinhas[nAtual]))) == 0
                    nAbriu -= 1
                EndIf
            EndIf
        Next
         
        //Monta agora o texto novo
        cTextoNovo := ""
        For nAtual := 1 TO Len(aLinNov)
            cTextoNovo += aLinNov[nAtual] + CRLF
        Next
    EndIf
     
    RestArea(aArea)
    
Return cTextoNovo
