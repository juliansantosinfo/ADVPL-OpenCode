#include 'protheus.ch'
#include 'parmtype.ch'
#include 'totvs.ch'
#include 'tbiconn.ch'

//-------------------------------------------------------------------
/*/{Protheus.doc} xJDlgGrid
@description Sample for class JDialogGrid
@type user function
@author Julian de Almeida Santos
@since 05/03/2020
/*/
//-------------------------------------------------------------------
User Function xJDlgGrid()

    RESET ENVIRONMENT
    RPCSetType(3)
    PREPARE ENVIRONMENT EMPRESA '01' FILIAL '01' MODULO 'FAT'

    // Sample to JDialogGrid class without EnchoiceBar.
    Sample01()

    // Sample to JDialogGrid class with EnchoiceBar.
    Sample02()

    // Sample to JDialogGrid class with context menu.
    Sample03()

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
    AADD(aHeader, {"COLUMN 1", 250, 0})
    AADD(aHeader, {"COLUMN 2", 250, 0})
    AADD(aHeader, {"COLUMN 3", 250, 0})
    AADD(aHeader, {"COLUMN 4", 250, 0})
    AADD(aHeader, {"COLUMN 5", 250, 0})

    // Define aCols.
    AADD(aCols, {"Text 1", "Text 2", "Text 3", Date(), 9.36})
    AADD(aCols, {"Text 1", "Text 2", "Text 3", Date(), 9.36})
    AADD(aCols, {"Text 1", "Text 2", "Text 3", Date(), 8.36})
    AADD(aCols, {"Text 1", "Text 2", "Text 3", Date(), 7.36})
    AADD(aCols, {"Text 1", "Text 2", "Text 3", Date(), 6.36})
    AADD(aCols, {"Text 1", "Text 2", "Text 3", Date(), 5.36})
    AADD(aCols, {"Text 1", "Text 2", "Text 3", Date(), 4.36})
    AADD(aCols, {"Text 1", "Text 2", "Text 3", Date(), 3.36})
    AADD(aCols, {"Text 1", "Text 2", "Text 3", Date(), 2.36})
    AADD(aCols, {"Text 1", "Text 2", "Text 3", Date(), 1.36})

    // Instantiate JDialogGrid object #1
    //oJDialogGrid  := JDialogGrid():new(cTitle, nWidth, nHeight)
    //oJDialogGrid:show()

    // Instantiate JDialogGrid object #2
    //oJDialogGrid  := JDialogGrid():new(cTitle, nWidth, nHeight, aHeader, aCols, lEnchoiceBar)
    //oJDialogGrid:show()

    // Instantiate JDialogGrid object #3
    //oJDialogGrid  := JDialogGrid():new(cTitle, nWidth, nHeight)
    //oJDialogGrid:setGridColumns(aHeader)
    //oJDialogGrid:setGridData(aCols)
    //oJDialogGrid:setSortHeader(.T.)
    //oJDialogGrid:show()

    // Instantiate JDialogGrid object #4
    cSQL := "SELECT * FROM ZB7011 "
    oJDialogGrid  := JDialogGrid():new(cTitle, nWidth, nHeight)
    oJDialogGrid:setFromSQL(cSQL)
    oJDialogGrid:setSortHeader(.T.)
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
    AADD(aHeader, {"COLUMN 1", 250, 0})
    AADD(aHeader, {"COLUMN 2", 250, 0})
    AADD(aHeader, {"COLUMN 3", 250, 0})
    AADD(aHeader, {"COLUMN 4", 250, 0})
    AADD(aHeader, {"COLUMN 5", 250, 0})

    // Define aCols.
    AADD(aCols, {"Text 1", "Text 2", "Text 3", Date(), 9.36})
    AADD(aCols, {"Text 1", "Text 2", "Text 3", Date(), 9.36})
    AADD(aCols, {"Text 1", "Text 2", "Text 3", Date(), 8.36})
    AADD(aCols, {"Text 1", "Text 2", "Text 3", Date(), 7.36})
    AADD(aCols, {"Text 1", "Text 2", "Text 3", Date(), 6.36})
    AADD(aCols, {"Text 1", "Text 2", "Text 3", Date(), 5.36})
    AADD(aCols, {"Text 1", "Text 2", "Text 3", Date(), 4.36})
    AADD(aCols, {"Text 1", "Text 2", "Text 3", Date(), 3.36})
    AADD(aCols, {"Text 1", "Text 2", "Text 3", Date(), 2.36})
    AADD(aCols, {"Text 1", "Text 2", "Text 3", Date(), 1.36})

    // Instantiate JDialog object
    oJDialogGrid  := JDialogGrid():new(cTitle, nWidth, nHeight, aHeader, aCols, lEnchoiceBar)
    oJDialogGrid:oDialog:setEnchoiceBar()
    oJDialogGrid:show()

Return()

//-------------------------------------------------------------------
/*/{Protheus.doc} Sample03
@type static function
@author Julian de Almeida Santos
@since 05/03/2020
/*/
//-------------------------------------------------------------------
Static Function Sample03()

    // Variables.
    local   oJDialog    := Nil
    local   cTitle      := "Sample to JDialogGrid class with context menu"
    local   nWidth      := 1280
    local   nHeight     := 720
    local   aHeader     := {}
    local   aCols       := {}
    local   lEnchoiceBar:= .T.
    local   aMenuItens  := {}

    // Define aHeader.
    AADD(aHeader, {"COLUMN 1", 250, 0})
    AADD(aHeader, {"COLUMN 2", 250, 0})
    AADD(aHeader, {"COLUMN 3", 250, 0})
    AADD(aHeader, {"COLUMN 4", 250, 0})
    AADD(aHeader, {"COLUMN 5", 250, 0})

    // Define aCols.
    AADD(aCols, {"Text 1", "Text 2", "Text 3", Date(), 9.36})
    AADD(aCols, {"Text 1", "Text 2", "Text 3", Date(), 9.36})
    AADD(aCols, {"Text 1", "Text 2", "Text 3", Date(), 8.36})
    AADD(aCols, {"Text 1", "Text 2", "Text 3", Date(), 7.36})
    AADD(aCols, {"Text 1", "Text 2", "Text 3", Date(), 6.36})
    AADD(aCols, {"Text 1", "Text 2", "Text 3", Date(), 5.36})
    AADD(aCols, {"Text 1", "Text 2", "Text 3", Date(), 4.36})
    AADD(aCols, {"Text 1", "Text 2", "Text 3", Date(), 3.36})
    AADD(aCols, {"Text 1", "Text 2", "Text 3", Date(), 2.36})
    AADD(aCols, {"Text 1", "Text 2", "Text 3", Date(), 1.36})

    // Define menu itens.
    AADD(aMenuItens, {"Item 1", {|| Alert("Selecionado o Item 1!")}, })
    AADD(aMenuItens, {"Item 2", {|| Alert("Selecionado o Item 2!")}, })
    AADD(aMenuItens, {"Item 3", {|| Alert("Selecionado o Item 3!")}, })

    // Instantiate JDialog object
    oJDialogGrid  := JDialogGrid():new(cTitle, nWidth, nHeight, aHeader, aCols, lEnchoiceBar)
    oJDialogGrid:oDialog:setEnchoiceBar()
    oJDialogGrid:addContextMenu(aMenuItens)
    oJDialogGrid:show()

Return()