#include 'protheus.ch'
#include 'parmtype.ch'
#include 'totvs.ch'
#include 'tbiconn.ch'

//-------------------------------------------------------------------
/*/{Protheus.doc} xJDlgGetDados
@description Sample for class JDialogGetDados
@type user function
@author Julian de Almeida Santos
@since 18/03/2020
/*/
//-------------------------------------------------------------------
User Function xJDlgGetDados()

    // Sample to JDialogGetDados class without EnchoiceBar.
    Sample01()

Return()

//-------------------------------------------------------------------
/*/{Protheus.doc} Sample01
@type static function
@author Julian de Almeida Santos
@since 18/03/2020
/*/
//-------------------------------------------------------------------
Static Function Sample01()

    // Variables.
    local   oJDialog    := Nil
    local   cTitle      := "Sample to JDialogGetDados class without EnchoiceBar!"
    local   nWidth      := 1280
    local   nHeight     := 720
    local   aHeader     := Nil
    local   aColumnSize := Nil
    local   aCols       := Nil
    local   lEnchoiceBar:= .F.

    // Instantiate JDialogGetDados object #1
    oJDialogGetDados := JDialogGetDados():new(cTitle, nWidth, nHeight)
    oJDialogGetDados:show()

Return()