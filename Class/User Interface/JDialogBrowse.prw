#include 'protheus.ch'
#include 'parmtype.ch'
#include 'totvs.ch'
#include 'topconn.ch'

static  oBmpOk := LoadBitmap( GetResources(), "LBOK")
static  oBmpNo := LoadBitmap( GetResources(), "LBNO")

//-------------------------------------------------------------------
/*/{Protheus.doc} JDialogBrowse
@description
@type class
@author Julian de Almeida Santos
@since 12/03/2020
/*/
//-------------------------------------------------------------------
Class JDialogBrowse

    method new() constructor

    method show()
    method close()

    method getBrowseSize()
    method setFromSQL()

    method getDialog()
    method getDlgTile()
    method getDlgWidth()
    method getDlgHeight()
    method getBrowse()

    method setAlias()
    method setHeader()
    method getHeader()
    method setData()
    method getData()

    method setSortHeader()
    method sortColumn()

    method getColumnSize()
    method setColumnSize()

    method addContextMenu()
    method removeContextMenu()

    method GoLine()
    method GoColumn()

    method setDlgTile()
    method setDlgWidth()
    method setDlgHeight()

    data oDialog    as Object
    data oBrowse    as Object

EndClass

//-------------------------------------------------------------------
/*/{Protheus.doc} new
@description Constructor method for class JDialog.
@type method
@author Julian de ALmeida Santos
@since 12/03/2020
/*/
//-------------------------------------------------------------------
method new(cTitle, nWidth, nHeight, aHeader, aData, cAlias, lEnchoiceBar) class JDialogBrowse

    // Variables.
    local   aBrowsePosition := {}
    local   nBrwRow         := 0
    local   nBrwCol         := 0
    local   nBrwWidth       := 0
    local   nBrwHeight      := 0
    default cTitle          := ""
    default nWidth          := 640
    default nHeight         := 480
    default aHeader         := {}
    default aData           := {}
    default cAlias          := ""
    default lEnchoiceBar    := .F.

    self:oDialog := JDialog():New(cTitle, nWidth, nHeight)

    aBrowsePosition := self:getBrowseSize(nWidth, nHeight, lEnchoiceBar)
    nBrwRow   := aBrowsePosition[1,1]
    nBrwCol   := aBrowsePosition[1,2]
    nBrwWidth := aBrowsePosition[1,3]
    nBrwHeight:= aBrowsePosition[1,4]

    self:oBrowse := TCBrowse():New(nBrwRow, nBrwCol, nBrwWidth, nBrwHeight, , , , self:oDialog, , , , , , , , , , , , , cAlias, .T., , , , .T., .T. )

    If Empty(cAlias) .AND. !Empty(aHeader) .AND. !Empty(aData)
        self:setHeader(aHeader)
        self:setData(aData)
    EndIf

return()

//-------------------------------------------------------------------
/*/{Protheus.doc} show
@description Show JDialogBrowse.
@type method
@author Julian de ALmeida Santos
@since 12/03/2020
/*/
//-------------------------------------------------------------------
method show() class JDialogBrowse
    self:oDialog:show()
return()

//-------------------------------------------------------------------
/*/{Protheus.doc} close
@description Close JDialogBrowse.
@type method
@author Julian de ALmeida Santos
@since 12/03/2020
/*/
//-------------------------------------------------------------------
method close() class JDialogBrowse
    self:oDialog:close()
return()

//-------------------------------------------------------------------
/*/{Protheus.doc} getBrowseSize
@description Return dimensions to TCBrowse object.
@type method
@author Julian de ALmeida Santos
@since 12/03/2020
/*/
//-------------------------------------------------------------------
method getBrowseSize(nWidth, nHeight, lEnchoiceBar) class JDialogBrowse

    // Variables.
    local   aSize           := Array(8)
    local   aObjects        := {}
    local   aInfo           := {}
    local   aBrowsePosition := {}
    local   lHorizontal     := .F.
    default nWidth          := 0
    default nHeight         := 0
    default lEnchoiceBar    := .F.

    // Initialize aSize.
    aSize[1] := 0
    aSize[2] := IIf(lEnchoiceBar, 30, 0)
    aSize[3] := nWidth / 2
    aSize[4] := nHeight / 2
    aSize[5] := nWidth
    aSize[6] := nHeight
    aSize[7] := 0
    aSize[8] := 0

    // Initialize aObjects.
    AADD(aObjects, { 000, 000, .T., .T., .T.})

    // Initialize aInfo.
    aInfo   := {aSize[1], aSize[2], aSize[3], aSize[4], 5, 5}

    // Calculates dimensions for the Browse.
    aBrowsePosition := MsObjSize( aInfo, aObjects, .F., lHorizontal)

return(aBrowsePosition)

//-------------------------------------------------------------------
/*/{Protheus.doc} setAlias
@description Set Table to Browse.
@type method
@author Julian de ALmeida Santos
@since 12/03/2020
/*/
//-------------------------------------------------------------------
method setAlias(cAlias) class JDialogBrowse
    self:oBrowse:cAlias := cAlias
return()

//-------------------------------------------------------------------
/*/{Protheus.doc} setHeader
@description Set Header to Browse.
@type method
@author Julian de ALmeida Santos
@since 12/03/2020
/*/
//-------------------------------------------------------------------
method setHeader(aHeader) class JDialogBrowse

    // Add column to Browse.
    self:oBrowse:aHeaders := aHeader

return()

//-------------------------------------------------------------------
/*/{Protheus.doc} setBrowseData
@description Set data to Browse.
@type method
@author Julian de ALmeida Santos
@since 12/03/2020
/*/
//-------------------------------------------------------------------
method setData(aData, bLine) class JDialogBrowse

    // Variable.
    local   nRow    := 1
    local   nColumn := 1
    local   cColumn := ""
    private cType   := ""
    private xValue  := Nil
    default bLine   := Nil

    // Define array to Browse.
    self:oBrowse:SetArray(aData)

    // Verifica se foi informado a propriedade BLine.
    // If not informed, set up a standard code block.
    If bLine == Nil

        cBLine      := "{ || {"
        cBLineFields:= ""

        For nColumn := 1 To Len(aData[nRow])

            xValue := aData[nRow,nColumn]
            cType  := ValType(xValue)
            cColumn:= AllTrim(Str(nColumn))

            If !Empty(cBLineFields)
                cBLineFields += ','
            EndIf

            If cType == 'L'
                cBLineFields += "IIf(self:oBrowse:aArray[self:oBrowse:nAt, " + cColumn + "], oBmpOk, oBmpNo)"
            Else
                cBLineFields += "self:oBrowse:aArray[self:oBrowse:nAt, " + cColumn + "]"
            EndIf

        Next

        cBLine += cBLineFields
        cBLine += "}}"

        self:oBrowse:bLine := &cBLine

    Else
        self:oBrowse:bLine := bLine
    EndIf

return()

//-------------------------------------------------------------------
/*/{Protheus.doc} setSortHeader
@description Defines Browse data from SQL.
@type 06/03/2020
@author Julian de Almeida Santos
@since 12/03/2020
/*/
//-------------------------------------------------------------------
method setFromSQL(cSQL) class JDialogBrowse

    // Variables.
    local   cAliasSQL   := CriaTrab(,.F.)
    local   aStruct     := {}
    local   cColName    := ""
    local   aHeader     := {}
    local   aData       := {}
    local   aRow        := {}
    default cSQL        := ""

    TCQUERY cSQL ALIAS &cAliasSQL NEW

    DBSelectArea(cAliasSQL)
    DbGoTop()

    aStruct := (cAliasSQL)->(DBStruct())

    For nH := 1 To Len(aStruct)

        cColName := aStruct[nH,1]
        
        AADD(aHeader, cColName)

    Next

    While !(cAliasSQL)->(EOF())

        // Inicializa array com informacoes da linha atual.
        aRow := {}

        For nX := 1 To Len(aStruct)
            // Add coluna ao array do item atual.
            AADD(aRow, (cAliasSQL)->&(aStruct[nX,01]))
        Next

        // Add item atual ao array de itens geral.
        AADD(aData, aRow)

        (cAliasSQL)->(DbSkip())

    End

    self:setHeader(aHeader)
    self:setData(aData)

return()

//-------------------------------------------------------------------
/*/{Protheus.doc} setSortHeader
@description Defines whether the click on the column header orders it.
@type 06/03/2020
@author Julian de Almeida Santos
@since 12/03/2020
/*/
//-------------------------------------------------------------------
method setSortHeader(lSort) class JDialogBrowse

    // Variables.
    local   bHeaderClick := {|x, y,z| self:sortColumn(x,y,z) }
    default lSort        := .T.

    If lSort
        self:oBrowse:bHeaderClick := bHeaderClick
    Else
        self:oBrowse:bHeaderClick := {||}
    EndIf

return()

//-------------------------------------------------------------------
/*/{Protheus.doc} sortColumn
@description Sorts informed column.
@type 06/03/2020
@author Julian de Almeida Santos
@since 12/03/2020
/*/
//-------------------------------------------------------------------
method sortColumn(oBrowse, nColumn) class JDialogBrowse

    // Variables
    default oBrowse := self:oBrowse
    default nColumn := 1

    self:oBrowse:aArray := ASort(self:oBrowse:aArray, , , {|x,y| x[nColumn] < y[nColumn]})

    self:setData(self:oBrowse:aArray)

    self:oBrowse:Refresh()

return()

//-------------------------------------------------------------------
/*/{Protheus.doc} getColumnSize
@description Get columns size.
@type 06/03/2020
@author Julian de Almeida Santos
@since 12/03/2020
/*/
//-------------------------------------------------------------------
method getColumnSize() class JDialogBrowse
return(self:oBrowse:GetColSizes())

//-------------------------------------------------------------------
/*/{Protheus.doc} setColumnSize
@description Set columns size.
@type 06/03/2020
@author Julian de Almeida Santos
@since 12/03/2020
/*/
//-------------------------------------------------------------------
method setColumnSize(aColumnSize) class JDialogBrowse

    // Variables.
    default aColumnSize := self:oBrowse:aColSizes

    self:oBrowse:aColSizes := aColumnSize

return()

//-------------------------------------------------------------------
/*/{Protheus.doc} addContextMenu
@description Adds context menu to the grid.
@type 06/03/2020
@author Julian de Almeida Santos
@since 12/03/2020
/*/
//-------------------------------------------------------------------
method addContextMenu(aMenuItens) class JDialogBrowse

    // Variables
    local   oMenuItem       := Nil
    local   cItemTitle      := ""
    local   cItemBlock      := {||}
    private cItemResource   := ""
    default aMenuItens      := {}

    // Define TMenu.
    self:oMenu := TMenu():New(0,0,0,0,.T.)

    // Cycles through the array of items from the add menu to the context menu.
    For nM := 1 To Len(aMenuItens)

        // Define values for menu item.
        cItemTitle      := aMenuItens[nM,1]
        cItemBlock      := aMenuItens[nM,2]
        cItemResource   := aMenuItens[nM,3]
        cItemResource   := IIf(Type('cItemResource') != "C", "", cItemResource)

        // Define TMenuItem.
        oMenuItem := TMenuItem():New(self:oDialog, cItemTitle,,,, cItemBlock,, cItemResource,,,,,,,.T.)

        // Adds item to the context menu.
        self:oMenu:Add(oMenuItem)

    Next

    // Adds context menu to the grid.
    self:oGrid:setPopup(self:oMenu)

return()

//-------------------------------------------------------------------
/*/{Protheus.doc} removeContextMenu
@description Removes context menu from the grid.
@type 06/03/2020
@author Julian de Almeida Santos
@since 12/03/2020
/*/
//-------------------------------------------------------------------
method removeContextMenu() class JDialogBrowse
    self:oGrid:setPoupUp()
return()

//-------------------------------------------------------------------
/*/{Protheus.doc} GoLine
@description 
@type 06/03/2020
@author Julian de Almeida Santos
@since 12/03/2020
/*/
//-------------------------------------------------------------------
method GoLine(nLine) class JDialogBrowse
    
    // Variables 
    default nLine := 1

    self:oBrowse:GoPosition( nLine )

return()

//-------------------------------------------------------------------
/*/{Protheus.doc} GoColumn
@description 
@type 06/03/2020
@author Julian de Almeida Santos
@since 12/03/2020
/*/
//-------------------------------------------------------------------
method GoColumn(nColumn) class JDialogBrowse

    // Variables 
    default nColumn := 1

    self:oGrid:SetSelectionMode(nColumn)

return()

//-------------------------------------------------------------------
/*/{Protheus.doc} getDialog
@description Return JDialog object.
@type method
@author Julian de ALmeida Santos
@since 12/03/2020
/*/
//-------------------------------------------------------------------
method getDialog() class JDialogBrowse
return(self:oDialog)

//-------------------------------------------------------------------
/*/{Protheus.doc} getDlgTile
@description Return JDialog Title.
@type method
@author Julian de ALmeida Santos
@since 12/03/2020
/*/
//-------------------------------------------------------------------
method getDlgTile() class JDialogBrowse
return(self:oDialog:cTitle)

//-------------------------------------------------------------------
/*/{Protheus.doc} setDlgTile
@description set JDialog Title.
@type method
@author Julian de ALmeida Santos
@since 12/03/2020
/*/
//-------------------------------------------------------------------
method setDlgTile(cTitle) class JDialogBrowse
    // Variables.
    default cTitle := self:oDialog:cTitle
    self:oDialog:cTitle := cTitle
return()

//-------------------------------------------------------------------
/*/{Protheus.doc} getDlgWidth
@description Return JDialog Widht.
@type method
@author Julian de ALmeida Santos
@since 12/03/2020
/*/
//-------------------------------------------------------------------
method getDlgWidth() class JDialogBrowse
return(self:oDialog:nWidth)

//-------------------------------------------------------------------
/*/{Protheus.doc} setDlgWidth
@description Set JDialog widht.
@type method
@author Julian de ALmeida Santos
@since 12/03/2020
/*/
//-------------------------------------------------------------------
method setDlgWidth(nWidth) class JDialogBrowse
    // Variables.
    default nWidth := self:oDialog:nWidth
    self:oDialog:nWidth := nWidth
return()

//-------------------------------------------------------------------
/*/{Protheus.doc} getDlgHeight
@description Return JDialog Height.
@type method
@author Julian de ALmeida Santos
@since 12/03/2020
/*/
//-------------------------------------------------------------------
method getDlgHeight() class JDialogBrowse
return(self:oDialog:nHeight)

//-------------------------------------------------------------------
/*/{Protheus.doc} setDlgHeight
@description Set JDialog height.
@type method
@author Julian de ALmeida Santos
@since 12/03/2020
/*/
//-------------------------------------------------------------------
method setDlgHeight(nHeight) class JDialogBrowse
    // Variables.
    default nHeight := self:oDialog:nHeight
    self:oDialog:nHeight := nHeight
return()

//-------------------------------------------------------------------
/*/{Protheus.doc} getBrowse
@description Return TBrowse object.
@type method
@author Julian de ALmeida Santos
@since 12/03/2020
/*/
//-------------------------------------------------------------------
method getBrowse() class JDialogBrowse
return(self:oBrowse)

//-------------------------------------------------------------------
/*/{Protheus.doc} getHeader()
@description Returns array with header from the Browse.
@type method
@author Julian de ALmeida Santos
@since 12/03/2020
/*/
//-------------------------------------------------------------------
method getHeader() class JDialogBrowse
return(self:oBrowse:aHeader)

//-------------------------------------------------------------------
/*/{Protheus.doc} setHeader()
@description set array with header from the Browse.
@type method
@author Julian de ALmeida Santos
@since 12/03/2020
/*/
//-------------------------------------------------------------------
method setHeader(aHeader) class JDialogBrowse
    default aHeader := self:oBrowse:aHeader
    self:oBrowse:aHeader := aHeader
return()

//-------------------------------------------------------------------
/*/{Protheus.doc} getData()
@description Returns array with data from the Browse.
@type method
@author Julian de ALmeida Santos
@since 12/03/2020
/*/
//-------------------------------------------------------------------
method getData() class JDialogBrowse
return(self:oBrowse:aArray)