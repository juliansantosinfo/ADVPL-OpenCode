#include 'protheus.ch'
#include 'parmtype.ch'
#include 'totvs.ch'

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

    method setSelectionByRow()
    method setSelectionByColumn()

    method getDialog()
    method getGrid()

    data oDialog    as Object
    data oGrid      as Object

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

    self:setGridColumns(aHeader)

    self:setGridData(aCols)

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

    For nH := 1 To Len(aHeader)

        // Define ID to column.
        nColumnID++

        // Set variables to column.
        cColumnTitle := aHeader[nH,nPosTitle]
        nColumnWidth := aHeader[nH,nPosWidth]
        nColumnAlign := aHeader[nH,nPosAlign]

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

    For nRow := 1 To Len(aCols)

        If Len(aCols[nRow]) > nHeaderSize
            ASize(aCols[nRow], nHeaderSize)
        EndIf

        For nColumn := 1 To Len(aCols[nRow])

            If ValType(aCols[nRow,nColumn]) == "D"
                aCols[nRow,nColumn] := DTOC(aCols[nRow,nColumn])
            ElseIf ValType(aCols[nRow,nColumn]) == "N"
                aCols[nRow,nColumn] := AllTrim(Str(aCols[nRow,nColumn]))
            EndIf

        Next

        self:oGrid:setRowData( nRow, {|oGrid| aCols[nRow] } )

    Next

    self:oGrid:setSelectedRow(1)

return()

//-------------------------------------------------------------------
/*/{Protheus.doc} selectionByRow
@description Defines the type of grid navigation per line
@type 06/03/2020
@author Julian de Almeida Santos
@since 06/03/2020
/*/
//-------------------------------------------------------------------
method setSelectionByRow()
    self:oGrid:SetSelectionMode(0)
return()

//-------------------------------------------------------------------
/*/{Protheus.doc} selectionByColumn
@description Defines the type of grid navigation per column
@type 06/03/2020
@author Julian de Almeida Santos
@since 06/03/2020
/*/
//-------------------------------------------------------------------
method setSelectionByColumn()
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