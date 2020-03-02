#include 'protheus.ch'
#include 'parmtype.ch'
#include 'totvs.ch'

//-------------------------------------------------------------------
/*/{Protheus.doc} xMsDialog
@description Sample for class MsDialog
@type user function
@author Julian de Almeida Santos
@since 29/02/2020
/*/
//-------------------------------------------------------------------
User Function xMsDialog()

    // Variables.
    local   oMsDialog   := Nil
    local   nTop        := 0
    local   nLeft       := 0
    local   nBottom     := 720
    local   nRight      := 1280
    local   cTitle      := "Sample to MsDialog class!"
    local   lTransparent:= .T.

    local   lCentered   := .T.
    local   bValid      := {|| .T.}
    local   bInit       := {|| }

    // Instantiate MsDialog object
    oMsDialog := MSDialog():New(nTop, nLeft,nBottom, nRight, cTitle, , , , , CLR_BLACK, CLR_WHITE, , , .T.,,,, lTransparent)

    // Shows MsDialog with Activate method.
    oMsDialog:Activate( , , , lCentered, bValid, , bInit, , )

Return()