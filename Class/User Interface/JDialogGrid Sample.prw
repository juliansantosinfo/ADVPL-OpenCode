#include 'protheus.ch'
#include 'parmtype.ch'
#include 'totvs.ch'

//-------------------------------------------------------------------
/*/{Protheus.doc} xJDlgGrid
@description Sample for class JDialogGrid
@type user function
@author Julian de Almeida Santos
@since 05/03/2020
/*/
//-------------------------------------------------------------------
User Function xJDlgGrid()

    // Sample to JDialogGrid class without EnchoiceBar.
    Sample01()

    // Sample to JDialogGrid class with EnchoiceBar.
    Sample02()

Return()

//-------------------------------------------------------------------
/*/{Protheus.doc} Sample01
@type static function
@author Julian de Almeida Santos
@since 05/03/2020
/*/
//-------------------------------------------------------------------
Static Function Sample01()

    // Variables.
    local   oJDialog    := Nil
    local   cTitle      := "Sample to JDialogGrid class without EnchoiceBar!"
    local   nWidth      := 1280
    local   nHeight     := 720
    local   aHeader     := {}
    local   aCols       := {}
    local   lEnchoiceBar:= .F.

    // Define aHeader.
    AADD(aHeader, {"COLUMN 1", 256, 0})
    AADD(aHeader, {"COLUMN 2", 256, 0})
    AADD(aHeader, {"COLUMN 3", 256, 0})
    AADD(aHeader, {"COLUMN 4", 256, 0})
    AADD(aHeader, {"COLUMN 5", 256, 0})

    // Define aCols.
    AADD(aCols, {"Text 1", "Text 2", "Text 3", Date(), 1259.36})
    AADD(aCols, {"Text 1", "Text 2", "Text 3", Date(), 1259.36})
    AADD(aCols, {"Text 1", "Text 2", "Text 3", Date(), 1259.36})
    AADD(aCols, {"Text 1", "Text 2", "Text 3", Date(), 1259.36})
    AADD(aCols, {"Text 1", "Text 2", "Text 3", Date(), 1259.36})
    AADD(aCols, {"Text 1", "Text 2", "Text 3", Date(), 1259.36})
    AADD(aCols, {"Text 1", "Text 2", "Text 3", Date(), 1259.36})

    // Instantiate JDialog object
    oJDialogGrid  := JDialogGrid():new(cTitle, nWidth, nHeight, aHeader, aCols, lEnchoiceBar) 
    oJDialogGrid:show()

Return()

//-------------------------------------------------------------------
/*/{Protheus.doc} Sample02
@type static function
@author Julian de Almeida Santos
@since 05/03/2020
/*/
//-------------------------------------------------------------------
Static Function Sample02()

    // Variables.
    local   oJDialog    := Nil
    local   cTitle      := "Sample to JDialogGrid class with EnchoiceBar"
    local   nWidth      := 1280
    local   nHeight     := 720
    local   aHeader     := {}
    local   aCols       := {}
    local   lEnchoiceBar:= .T.

    // Define aHeader.
    AADD(aHeader, {"COLUMN 1", 256, 0})
    AADD(aHeader, {"COLUMN 2", 256, 0})
    AADD(aHeader, {"COLUMN 3", 256, 0})
    AADD(aHeader, {"COLUMN 4", 256, 0})
    AADD(aHeader, {"COLUMN 5", 256, 0})

    // Define aCols.
    AADD(aCols, {"Text 1", "Text 2", "Text 3", Date(), 1259.36})
    AADD(aCols, {"Text 1", "Text 2", "Text 3", Date(), 1259.36})
    AADD(aCols, {"Text 1", "Text 2", "Text 3", Date(), 1259.36})
    AADD(aCols, {"Text 1", "Text 2", "Text 3", Date(), 1259.36})
    AADD(aCols, {"Text 1", "Text 2", "Text 3", Date(), 1259.36})
    AADD(aCols, {"Text 1", "Text 2", "Text 3", Date(), 1259.36})
    AADD(aCols, {"Text 1", "Text 2", "Text 3", Date(), 1259.36})

    // Instantiate JDialog object
    oJDialogGrid  := JDialogGrid():new(cTitle, nWidth, nHeight, aHeader, aCols, lEnchoiceBar) 
    oJDialogGrid:oDialog:setEnchoiceBar()
    oJDialogGrid:show()

Return()