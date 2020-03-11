#include 'protheus.ch'
#include 'parmtype.ch'
#include 'totvs.ch'
#include 'topconn.ch'

#define GRID_MOVEUP       0
#define GRID_MOVEDOWN     1
#define GRID_MOVEHOME     2
#define GRID_MOVEEND      3
#define GRID_MOVEPAGEUP   4
#define GRID_MOVEPAGEDOWN 5

//-------------------------------------------------------------------
/*/{Protheus.doc} JDialogGrid
@description
@type class
@author Julian de Almeida Santos
@since 05/03/2020
/*/
//-------------------------------------------------------------------
Class JDialogGrid

    method new() constructor

    method show()
    method close()

    method getGridSize()
    method setGridColumns()
    method setGridData()
    method setFromSQL()
    method setCursorMove()

    method setRowSelection()
    method setColumnSelection()

    method setSortHeader()
    method sortColumn()
    method clearRows()

    method addContextMenu()
    method removeContextMenu()

    method getDialog()
    method getGrid()
    method getMenu()

    method getHeader()
    method getData()

    data oDialog    as Object
    data oGrid      as Object
    data oMenu      as Object

    data aHeader    as Array
    data aCols      as Array

    data nAt        as Array

EndClass

//-------------------------------------------------------------------
/*/{Protheus.doc} new
@description Constructor method for class JDialog.
@type method
@author Julian de ALmeida Santos
@since 05/03/2020
/*/
//-------------------------------------------------------------------
method new(cTitle, nWidth, nHeight, aHeader, aCols, lEnchoiceBar) class JDialogGrid

    // Variables.
    local   aGridPosition   := {}
    local   nGridRow        := 0
    local   nGridCol        := 0
    local   nGridWidth      := 0
    local   nGridHeight     := 0
    default cTitle          := ""
    default nWidth          := 640
    default nHeight         := 480
    default aHeader         := {}
    default aCols           := {}
    default lEnchoiceBar    := .F.

    self:oDialog := JDialog():New(cTitle, nWidth, nHeight)

    aGridPosition := self:getGridSize(nWidth, nHeight, lEnchoiceBar)
    nGridRow   := aGridPosition[1,1]
    nGridCol   := aGridPosition[1,2]
    nGridWidth := aGridPosition[1,3]
    nGridHeight:= aGridPosition[1,4]

    self:oGrid := TGrid():New(self:oDialog, nGridRow, nGridCol, nGridWidth, nGridHeight)

    self:oGrid:bCursorMove := { |oGrid,nMvType,nCurPos,nOffSet,nVisRows| self:setCursorMove(oGrid, nMvType, nCurPos, nOffSet, nVisRows)}

    If !Empty(aHeader) .AND. !Empty(aCols)
        self:aHeader := aHeader
        self:aCols := aCols
        self:setGridColumns(self:aHeader)
        self:setGridData(self:aCols)
    EndIf

return()

//-------------------------------------------------------------------
/*/{Protheus.doc} show
@description Constructor method for class JDialog.
@type method
@author Julian de ALmeida Santos
@since 05/03/2020
/*/
//-------------------------------------------------------------------
method show() class JDialogGrid
    self:oDialog:show()
return()

//-------------------------------------------------------------------
/*/{Protheus.doc} close
@description Constructor method for class JDialog.
@type method
@author Julian de ALmeida Santos
@since 05/03/2020
/*/
//-------------------------------------------------------------------
method close() class JDialogGrid
    self:oDialog:close()
return()

//-------------------------------------------------------------------
/*/{Protheus.doc} getGridSize
@description Return dimensions to TGrid object.
@type method
@author Julian de ALmeida Santos
@since 05/03/2020
/*/
//-------------------------------------------------------------------
method getGridSize(nWidth, nHeight, lEnchoiceBar) class JDialogGrid

    // Variables.
    local   aSize         := Array(8)
    local   aObjects      := {}
    local   aInfo         := {}
    local   aGridPosition := {}
    local   lHorizontal   := .F.
    default nWidth        := 0
    default nHeight       := 0
    default lEnchoiceBar  := .F.

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

    // Calculates dimensions for the grid.
    aGridPosition := MsObjSize( aInfo, aObjects, .F., lHorizontal)

return(aGridPosition)

//-------------------------------------------------------------------
/*/{Protheus.doc} getDialog
@description Return JDialog object.
@type method
@author Julian de ALmeida Santos
@since 05/03/2020
/*/
//-------------------------------------------------------------------
method setGridColumns(aHeader) class JDialogGrid

    // Variables.
    local   nColumnID := 0
    local   nPosTitle := 1
    local   nPosWidth := 2
    local   nPosAlign := 3

    self:aHeader := aHeader

    For nH := 1 To Len(self:aHeader)

        // Define ID to column.
        nColumnID++

        // Set variables to column.
        cColumnTitle := self:aHeader[nH,nPosTitle]
        nColumnWidth := self:aHeader[nH,nPosWidth]
        nColumnAlign := self:aHeader[nH,nPosAlign]

        // Add column to grid.
        self:oGrid:AddColumn( nColumnID, cColumnTitle, nColumnWidth, nColumnAlign)

    Next

return()

//-------------------------------------------------------------------
/*/{Protheus.doc} setGridData
@description 
@type method
@author Julian de ALmeida Santos
@since 05/03/2020
/*/
//-------------------------------------------------------------------
method setGridData(aCols) class JDialogGrid

    // Variables.
    local   nHeaderSize := Len(self:oGrid:GetColumnsSize())

    self:aCols := aCols

    self:clearRows()

    For nRow := 1 To Len(self:aCols)

        If Len(self:aCols[nRow]) > nHeaderSize
            ASize(self:aCols[nRow], nHeaderSize)
        EndIf

        For nColumn := 1 To Len(self:aCols[nRow])

            If ValType(self:aCols[nRow,nColumn]) == "D"
                self:aCols[nRow,nColumn] := DTOC(self:aCols[nRow,nColumn])
            ElseIf ValType(self:aCols[nRow,nColumn]) == "N"
                self:aCols[nRow,nColumn] := AllTrim(Str(self:aCols[nRow,nColumn]))
            EndIf

        Next

        self:oGrid:setRowData( nRow, {|oGrid| self:aCols[nRow] } )

    Next

    self:nAt := 1

    self:oGrid:setSelectedRow(self:nAt)

return()

//-------------------------------------------------------------------
/*/{Protheus.doc} setSortHeader
@description Defines grid data from SQL.
@type 06/03/2020
@author Julian de Almeida Santos
@since 06/03/2020
/*/
//-------------------------------------------------------------------
method setFromSQL(cSQL) class JDialogGrid

    // Variables.
    local   cAliasSQL   := CriaTrab(,.F.)
    local   aStruct     := {}
    local   aRow        := {}
    default cSQL        := ""

    self:aHeader := {}
    self:aCols := {}

    TCQUERY cSQL ALIAS &cAliasSQL NEW

    DBSelectArea(cAliasSQL)
    DbGoTop()

    aStruct := (cAliasSQL)->(DBStruct())

    For nH := 1 To Len(aStruct)

        cColName := aStruct[nH,1]
        cColType := aStruct[nH,2]
        cColSize := aStruct[nH,3]
        cColSize := (IIf(Len(cColName) > cColSize, Len(cColName), cColSize) * 7.5)
        cColSize := IIf(cColSize > 400, 400, cColSize)
        cColAling:= IIf(cColType == "C", 1, IIf(cColType == "N", 2, 0))

        AADD(self:aHeader, {cColName, cColSize, cColAling})

    Next

    While !(cAliasSQL)->(EOF())

        // Inicializa array com informacoes da linha atual.
        aRow := {}

        For nX := 1 To Len(aStruct)
            // Add coluna ao array do item atual.
            AADD(aRow, (cAliasSQL)->&(aStruct[nX,01]))
        Next

        // Add item atual ao array de itens geral.
        AADD(self:aCols, aRow)

        (cAliasSQL)->(DbSkip())

    End

    self:setGridColumns(self:aHeader)
    self:setGridData(self:aCols)

return()

//-------------------------------------------------------------------
/*/{Protheus.doc} setCursorMove
@description 
@type static function
@author Julian de Almeida Santos
@since 09/03/2020
/*/
//-------------------------------------------------------------------
method setCursorMove(oGrid, nMvType, nCurPos, nOffSet, nVisRows) class JDialogGrid

    If nMvType == 0

        If self:nAt == GRID_MOVEUP
            return()
        EndIf

        self:nAt -= nOffSet

        If nCurPos == 0
            self:oGrid:scrollLine(-1)
            self:oGrid:setRowData( nCurPos, {|oGrid| self:aCols[self:nAt] } )
        Else
            nCurPos -= nOffSet
        EndIf

        self:oGrid:setSelectedRow(nCurPos)

    ElseIf nMvType == GRID_MOVEDOWN

        If nCurPos == -1
            nCurPos := 0
        EndIf

        If self:nAt == Len(self:aCols)
            return()
        EndIf

        self:nAt += nOffSet
        nGoLine := nCurPos+nOffSet
        If nCurPos == (nVisRows - 1)
            self:oGrid:scrollLine(nOffSet)
            self:oGrid:setSelectedRow(nGoLine)
        Else
            self:oGrid:setSelectedRow(nGoLine)
        EndIf

    ElseIf nMvType == GRID_MOVEHOME

        If self:nAt == 1
            return()
        EndIf

        While self:nAt != 1

            self:nAt -= 1

            If nCurPos == 0
                self:oGrid:scrollLine(-1)
                self:oGrid:setRowData( nCurPos, {|oGrid| self:aCols[self:nAt] } )
            Else
                nCurPos -= 1
            EndIf

            self:oGrid:setSelectedRow(nCurPos)

        EndDO

    ElseIf nMvType  == GRID_MOVEEND

        nMaxRow  := Len(self:aCols)
        nJumpRows:= (nMaxRow - self:nAt) - (nVisRows - 1)

        If self:nAt == nMaxRow
            return()
        EndIf

        nCurPos := (nVisRows - 1)
        self:oGrid:setSelectedRow(nCurPos)

        self:oGrid:scrollLine(nJumpRows)
        self:nAt += nJumpRows

    ElseIf nMvType == 4
    ElseIf nMvType == 5
    EndIf

return

//-------------------------------------------------------------------
/*/{Protheus.doc} setSortHeader
@description Defines whether the click on the column header orders it.
@type 06/03/2020
@author Julian de Almeida Santos
@since 06/03/2020
/*/
//-------------------------------------------------------------------
method setSortHeader(lSort) class JDialogGrid

    // Variables.
    local   bHeaderClick := {|oGrid, nColumn| self:sortColumn(nColumn) }
    default lSort        := .T.

    If lSort
        self:oGrid:SetHeaderClick(bHeaderClick)
    Else
        self:oGrid:SetHeaderClick({||})
    EndIf

return()

//-------------------------------------------------------------------
/*/{Protheus.doc} sortColumn
@description Sorts informed column.
@type 06/03/2020
@author Julian de Almeida Santos
@since 06/03/2020
/*/
//-------------------------------------------------------------------
method sortColumn(nColumn) class JDialogGrid

    // Variables
    default   nColumn := 1

    self:aCols := ASort(self:aCols, , , {|x,y| x[nColumn] < y[nColumn]})

    self:setGridData(self:aCols)

return()

//-------------------------------------------------------------------
/*/{Protheus.doc} clearRows
@description Erase grid lines.
@type 06/03/2020
@author Julian de Almeida Santos
@since 06/03/2020
/*/
//-------------------------------------------------------------------
method clearRows() class JDialogGrid
    self:oGrid:ClearRows()
return()

//-------------------------------------------------------------------
/*/{Protheus.doc} addContextMenu
@description Adds context menu to the grid.
@type 06/03/2020
@author Julian de Almeida Santos
@since 06/03/2020
/*/
//-------------------------------------------------------------------
method addContextMenu(aMenuItens) class JDialogGrid

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
@since 06/03/2020
/*/
//-------------------------------------------------------------------
method removeContextMenu() class JDialogGrid
    self:oGrid:setPoupUp()
return()

//-------------------------------------------------------------------
/*/{Protheus.doc} setRowSelection
@description Defines the type of grid navigation per line
@type 06/03/2020
@author Julian de Almeida Santos
@since 06/03/2020
/*/
//-------------------------------------------------------------------
method setRowSelection() class JDialogGrid
    self:oGrid:SetSelectionMode(0)
return()

//-------------------------------------------------------------------
/*/{Protheus.doc} setColumnSelection
@description Defines the type of grid navigation per column
@type 06/03/2020
@author Julian de Almeida Santos
@since 06/03/2020
/*/
//-------------------------------------------------------------------
method setColumnSelection() class JDialogGrid
    self:oGrid:SetSelectionMode(1)
return()

//-------------------------------------------------------------------
/*/{Protheus.doc} getDialog
@description Return JDialog object.
@type method
@author Julian de ALmeida Santos
@since 05/03/2020
/*/
//-------------------------------------------------------------------
method getDialog() class JDialogGrid
return(@self:oDialog)

//-------------------------------------------------------------------
/*/{Protheus.doc} getGrid
@description Return TGrid object.
@type method
@author Julian de ALmeida Santos
@since 05/03/2020
/*/
//-------------------------------------------------------------------
method getGrid() class JDialogGrid
return(@self:oGrid)

//-------------------------------------------------------------------
/*/{Protheus.doc} getMenu
@description Return TGrid object.
@type method
@author Julian de ALmeida Santos
@since 05/03/2020
/*/
//-------------------------------------------------------------------
method getMenu() class JDialogGrid
return(@self:oMenu)

//-------------------------------------------------------------------
/*/{Protheus.doc} getHeader()
@description Returns array with header from the grid.
@type method
@author Julian de ALmeida Santos
@since 05/03/2020
/*/
//-------------------------------------------------------------------
method getHeader() class JDialogGrid
return(@self:aHeader)

//-------------------------------------------------------------------
/*/{Protheus.doc} getData()
@description Returns array with data from the grid.
@type method
@author Julian de ALmeida Santos
@since 05/03/2020
/*/
//-------------------------------------------------------------------
method getData() class JDialogGrid
return(@self:aCols)