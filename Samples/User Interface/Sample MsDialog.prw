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

    // Example of function to MsDialog class without transparency.
    Sample01()

    // Example of function to MsDialog class with transparency.
    Sample02()

Return()

//-------------------------------------------------------------------
/*/{Protheus.doc} Sample01
@type static function
@author Julian de Almeida Santos
@since 03/03/2020
/*/
//-------------------------------------------------------------------
Static Function Sample01()

    // Variables.
    local   oMsDialog   := Nil
    local   nTop        := 0
    local   nLeft       := 0
    local   nBottom     := 720
    local   nRight      := 1280
    local   cTitle      := "Sample to MsDialog class without transparency!"
    local   lTransparent:= .T.

    local   lCentered   := .T.
    local   bValid      := {|| .T.}
    local   bInit       := {|| }

    // Instantiate MsDialog object
    oMsDialog := MSDialog():New(nTop, nLeft,nBottom, nRight, cTitle, , , , , CLR_BLACK, CLR_WHITE, , , .T., , , , lTransparent)

    // Shows MsDialog with Activate method.
    oMsDialog:Activate( , , , lCentered, bValid, , bInit, , )

Return()

//-------------------------------------------------------------------
/*/{Protheus.doc} Sample02
@type static function
@author Julian de Almeida Santos
@since 03/03/2020
/*/
//-------------------------------------------------------------------
Static Function Sample02()

    // Variables.
    local   oMsDialog   := Nil
    local   nTop        := 0
    local   nLeft       := 0
    local   nBottom     := 720
    local   nRight      := 1280
    local   cTitle      := "Sample to MsDialog class with transparency!"
    local   lTransparent:= .T.

    local   lCentered   := .T.
    local   bValid      := {|| .T.}
    local   bInit       := {|| }

    // Instantiate MsDialog object
    oMsDialog := MSDialog():New(nTop, nLeft,nBottom, nRight, cTitle, , , , nOR(WS_VISIBLE, WS_POPUP), CLR_BLACK, CLR_WHITE, , , .T., , , , lTransparent)

    // Shows MsDialog with Activate method.
    oMsDialog:Activate( , , , lCentered, bValid, , bInit, , )
    
Return()