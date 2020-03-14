#include 'protheus.ch'
#include 'parmtype.ch'
#include 'totvs.ch'
#include 'tbiconn.ch'

//-------------------------------------------------------------------
/*/{Protheus.doc} xJDlgBrowse
@description Sample for class JDialogBrowse
@type user function
@author Julian de Almeida Santos
@since 05/03/2020
/*/
//-------------------------------------------------------------------
User Function xJDlgBrowse()

    RESET ENVIRONMENT
    RPCSetType(3)
    PREPARE ENVIRONMENT EMPRESA '01' FILIAL '01' MODULO 'FAT'

    // Sample to JDialogBrowse class without EnchoiceBar.
    Sample01()

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
    local   cTitle      := "Sample to JDialogBrowse class without EnchoiceBar!"
    local   nWidth      := 1280
    local   nHeight     := 720
    local   aHeader     := Nil
    local   aColumnSize := Nil
    local   aCols       := Nil
    local   lEnchoiceBar:= .F.

    // Define aHeader.
    aHeader := {}
    AADD(aHeader, "COLUMN 1")
    AADD(aHeader, "COLUMN 2")
    AADD(aHeader, "COLUMN 3")
    AADD(aHeader, "COLUMN 4")
    AADD(aHeader, "COLUMN 5")
    AADD(aHeader, "COLUMN 6")
    AADD(aHeader, "COLUMN 7")

    // Define aCols.
    aCols := {}
    AADD(aCols, {.T., "Text 1", "Text 2", "Text 3", Date(), 9.36, .F.})
    AADD(aCols, {.T., "Text 1", "Text 2", "Text 3", Date(), 9.36, .F.})
    AADD(aCols, {.T., "Text 1", "Text 2", "Text 3", Date(), 8.36, .F.})
    AADD(aCols, {.T., "Text 1", "Text 2", "Text 3", Date(), 7.36, .F.})
    AADD(aCols, {.T., "Text 1", "Text 2", "Text 3", Date(), 6.36, .F.})
    AADD(aCols, {.T., "Text 1", "Text 2", "Text 3", Date(), 5.36, .F.})
    AADD(aCols, {.T., "Text 1", "Text 2", "Text 3", Date(), 4.36, .F.})
    AADD(aCols, {.T., "Text 1", "Text 2", "Text 3", Date(), 3.36, .F.})
    AADD(aCols, {.T., "Text 1", "Text 2", "Text 3", Date(), 2.36, .F.})
    AADD(aCols, {.T., "Text 1", "Text 2", "Text 3", Date(), 1.36, .F.})

    // Instantiate JDialogBrowse object #1
    oJDialogBrowse := JDialogBrowse():new(cTitle, nWidth, nHeight)
    oJDialogBrowse:show()

    // Instantiate JDialogBrowse object #2
    oJDialogBrowse := JDialogBrowse():new(cTitle, nWidth, nHeight, aHeader, aCols, lEnchoiceBar)
    oJDialogBrowse:show()

    // Instantiate JDialogBrowse object #3
    oJDialogBrowse := JDialogBrowse():new(cTitle, nWidth, nHeight)
    oJDialogBrowse:setHeader(aHeader)
    oJDialogBrowse:setData(aCols)
    oJDialogBrowse:setSortHeader(.T.)
    oJDialogBrowse:setDbClick({|| changeCheckBox()})
    oJDialogBrowse:show()

    // Instantiate JDialogBrowse object #4
    cSQL := "SELECT * FROM SA1010 WHERE ROWNUM <= 100 "
    oJDialogBrowse := JDialogBrowse():new(cTitle, nWidth, nHeight)
    oJDialogBrowse:setFromSQL(cSQL)
    oJDialogBrowse:setSortHeader(.T.)
    oJDialogBrowse:addMenuDefault()
    oJDialogBrowse:show()

    // Instantiate JDialogBrowse object #5
    cSQL := "SELECT * FROM SA1010 WHERE ROWNUM <= 100 "
    oJDialogBrowse := JDialogBrowse():new(cTitle, nWidth, nHeight)
    oJDialogBrowse:setFromSQL(cSQL)
    oJDialogBrowse:setSortHeader(.T.)
    oJDialogBrowse:addMenuDefault()
    oJDialogBrowse:addColCheck()
    oJDialogBrowse:setDbClick({|| changeCheckBox()})
    oJDialogBrowse:show()

Return()

//-------------------------------------------------------------------
/*/{Protheus.doc} changeCheckBox
@description Changes checkbox state.
@type static function
@author Julian de Almeida Santos
@since 13/03/2020
/*/
//-------------------------------------------------------------------
Static Function changeCheckBox()

    // Variables.
    local   nRow    := oJDialogBrowse:getRow()
    local   nColumn := oJDialogBrowse:getColumn()
    private xValue  := oJDialogBrowse:getValue(nRow, nColumn)

    If ValType(xValue) == "L"
       oJDialogBrowse:setValue(nRow, nColumn, !xValue)
    EndIf

Return()