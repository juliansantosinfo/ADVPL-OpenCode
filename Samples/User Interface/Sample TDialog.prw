#include 'protheus.ch'
#include 'parmtype.ch'
#include 'totvs.ch'

//-------------------------------------------------------------------
/*/{Protheus.doc} xTDialog
@description Sample for class TDialog
@type user function
@author Julian de Almeida Santos
@since 03/03/2020
/*/
//-------------------------------------------------------------------
User Function xTDialog()

    // Example of function to TDialog class without transparency.
    Sample01()

    // Example of function to TDialog class with transparency.
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
    local   oTDialog    := Nil
    local   nTop        := 0
    local   nLeft       := 0
    local   nBottom     := 0
    local   nRight      := 0
    local   cTitle      := "Sample to TDialog class without transparency!"
    local   oWnd        := Nil
    local   lPixel      := .T.
    local   nWidth      := 1280
    local   nHeight     := 720
    local   lTransparent:= .F.

    local   lCentered   := .T.
    local   bValid      := {|| .T.}
    local   bInit       := {|| }

    // Instantiate MsDialog object
    oTDialog  := TDialog():New (nTop, nLeft, nBottom, nRight, cTitle, , , , , CLR_BLACK, CLR_WHITE, , oWnd, , , , , nWidth, nHeight, lTransparent)
    /*
    oTDialog  := TDialog():New (nTop, nLeft, nBottom, nRight, cTitle, , , , , CLR_BLACK, CLR_WHITE, , oWnd, lPixel, nWidth, nHeight, lTransparent)
    */

    // Shows MsDialog with Activate method.
    oTDialog:Activate( , , , lCentered, bValid, , bInit, , )

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
    local   oTDialog    := Nil
    local   nTop        := 0
    local   nLeft       := 0
    local   nBottom     := 720
    local   nRight      := 1280
    local   cTitle      := "Sample to TDialog class with transparency!"
    local   oWnd        := Nil
    local   lPixel      := .T.
    local   nWidth      := 1280
    local   nHeight     := 720
    local   lTransparent:= .T.

    local   lCentered   := .T.
    local   bValid      := {|| .T.}
    local   bInit       := {|| }

    // Instantiate MsDialog object
    oTDialog  := TDialog():New (nTop, nLeft, nBottom, nRight, cTitle, , , , nOr(WS_VISIBLE,WS_POPUP), CLR_BLACK, CLR_WHITE, , oWnd, , , , , nWidth, nHeight, lTransparent)
    /*
    oTDialog  := TDialog():New (nTop, nLeft, nBottom, nRight, cTitle, , , , nOr(WS_VISIBLE,WS_POPUP), CLR_BLACK, CLR_WHITE, , oWnd, lPixel, nWidth, nHeight, lTransparent)
    */

    // Shows MsDialog with Activate method.
    oTDialog:Activate( , , , lCentered, bValid, , bInit, , )

Return()