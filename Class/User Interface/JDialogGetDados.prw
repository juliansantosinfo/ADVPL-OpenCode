#include 'protheus.ch'
#include 'parmtype.ch'
#include 'totvs.ch'
#include 'topconn.ch'

static  oBmpOk := LoadBitmap( GetResources(), "LBOK")
static  oBmpNo := LoadBitmap( GetResources(), "LBNO")

//-------------------------------------------------------------------
/*/{Protheus.doc} JDialogGetDados
@description
@type class
@author Julian de Almeida Santos
@since 18/03/2020
/*/
//-------------------------------------------------------------------
Class JDialogGetDados

    method new() constructor

    method show()
    method close()

    method createGrid()
    method getGridSize()

    method setHeader()
    method getHeader()
    method setData()
    method getData()

    method setFromSQL()

    method setInsertLine()
    method setDeleteLine()
    method setEditLine()

    data nWidth         as Numeric
    data nHeight        as Numeric
    data lEnchoiceBar   as Logical

    data aHeader        as Array
    data aData          as Array

    data oDialog        as Object
    data oGrid          as Object
    data oMenu          as Object

EndClass

//-------------------------------------------------------------------
/*/{Protheus.doc} new
@description Constructor method for class JDialog.
@type method
@author Julian de ALmeida Santos
@since 12/03/2020
/*/
//-------------------------------------------------------------------
method new(cTitle, nWidth, nHeight, aHeader, aData, lEnchoiceBar) class JDialogGetDados

    // Variables.
    default cTitle          := ""
    default nWidth          := 640
    default nHeight         := 480
    default aHeader         := {}
    default aData           := {}
    default lEnchoiceBar    := .F.

    self:nWidth         := nWidth
    self:nHeight        := nHeight
    self:aHeader        := aHeader
    self:aData          := aData
    self:lEnchoiceBar   := lEnchoiceBar

    self:oDialog := JDialog():New(cTitle, self:nWidth, self:nHeight)

    self:createGrid()

return()

//-------------------------------------------------------------------
/*/{Protheus.doc} createGrid
@description
@type method
@author Julian de ALmeida Santos
@since 18/03/2020
/*/
//-------------------------------------------------------------------
method createGrid() class JDialogGetDados

    // Variables.
    local   aGridPosition   := {}
    local   nGridRow        := 0
    local   nGridCol        := 0
    local   nGridWidth      := 0
    local   nGridHeight     := 0

    local   nStyle          := GD_INSERT + GD_UPDATE + GD_DELETE
    local   cLinhaOk        := "AllwaysTrue"
    local   cTudoOk         := "AllwaysTrue"
    local   cIniCpos        := Nil
    local   aAlter          := {}
    local   nFreeze         := Nil
    local   nMax            := 9999
    local   cFieldOk        := "AllwaysTrue"
    local   cSuperDel       := "AllwaysTrue"
    local   cDelOk          := "AllwaysTrue"
    local   uChange         := Nil
    local   cTela           := Nil
    local   aColSize        := Nil

    If Empty(self:aHeader)
        return()
    EndIf
    
    aAlter := {"COL1","COL2","COL3","COL4"}

    aGridPosition := self:getGridSize(self:nWidth, self:nHeight, self:lEnchoiceBar)
    nGridRow      := aGridPosition[1,1]
    nGridCol      := aGridPosition[1,2]
    nGridWidth    := aGridPosition[1,3]
    nGridHeight   := aGridPosition[1,4]

    self:oGrid := MsNewGetDados():New(nGridRow, nGridCol, nGridHeight, nGridWidth, nStyle, cLinhaOk, cTudoOk, cIniCpos, aAlter, nFreeze, nMax, cFieldOk, cSuperDel, cDelOk, self:oDialog, self:aHeader, {}, , , aColSize)

    If !Empty(self:aData)
        self:setData()
    EndIf

return()

//-------------------------------------------------------------------
/*/{Protheus.doc} show
@description Show JDialogGetDados.
@type method
@author Julian de ALmeida Santos
@since 18/03/2020
/*/
//-------------------------------------------------------------------
method show() class JDialogGetDados
    self:oDialog:show()
return()

//-------------------------------------------------------------------
/*/{Protheus.doc} close
@description Close JDialogGetDados.
@type method
@author Julian de ALmeida Santos
@since 18/03/2020
/*/
//-------------------------------------------------------------------
method close() class JDialogGetDados
    self:oDialog:close()
return()

//-------------------------------------------------------------------
/*/{Protheus.doc} getGridSize
@description Return dimensions to MsGetDados object.
@type method
@author Julian de ALmeida Santos
@since 18/03/2020
/*/
//-------------------------------------------------------------------
method getGridSize(nWidth, nHeight, lEnchoiceBar) class JDialogGetDados

    // Variables.
    local   aSize           := Array(8)
    local   aObjects        := {}
    local   aInfo           := {}
    local   aGridPosition   := {}
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
    aGridPosition := MsObjSize( aInfo, aObjects, .F., lHorizontal)

return(aGridPosition)

//-------------------------------------------------------------------
/*/{Protheus.doc} setHeader
@description 
@type method
@author Julian de ALmeida Santos
@since 18/03/2020
/*/
//-------------------------------------------------------------------
method setHeader(aHeader) class JDialogGetDados

    // Variables.
    default aHeader := self:aHeader

    self:aHeader := aHeader

    self:createGrid()

return()

//-------------------------------------------------------------------
/*/{Protheus.doc} setData
@description 
@type method
@author Julian de ALmeida Santos
@since 18/03/2020
/*/
//-------------------------------------------------------------------
method setData(aData) class JDialogGetDados

    // Variables.
    default aData   := self:aData

    self:aData := aData
    self:oGrid:setArray(self:aData, .T.)
    self:oGrid:Refresh()

return()

method setFromSQL(cSQL) class JDialogGetDados

    // Variables.
    local   cAliasSQL   := CriaTrab(,.F.)
    local   aStruct     := {}
    
    local   cColName    := ""
    local   cColTipo    := ""
    local   nColSize    := 0
    local   nColDec     := 0
    
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
        cColTipo := aStruct[nH,2]
        nColSize := aStruct[nH,3]
        nColDec  := aStruct[nH,4]

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
    self:dataInitial := self:getData()

return()

//-------------------------------------------------------------------
/*/{Protheus.doc} setInsertLine
@description 
@type method
@author Julian de ALmeida Santos
@since 18/03/2020
/*/
//-------------------------------------------------------------------
method setInsertLine(lAllow) class JDialogGetDados
    // Variables.
    default lAllow  := .F.
    self:oGrid:LINSERT := lAllow
return()

//-------------------------------------------------------------------
/*/{Protheus.doc} setDeleteLine
@description 
@type method
@author Julian de ALmeida Santos
@since 18/03/2020
/*/
//-------------------------------------------------------------------
method setDeleteLine(lAllow) class JDialogGetDados
    // Variables.
    default lAllow  := .F.
    self:oGrid:LDELETE := lAllow
return()

//-------------------------------------------------------------------
/*/{Protheus.doc} setDeleteLine
@description 
@type method
@author Julian de ALmeida Santos
@since 18/03/2020
/*/
//-------------------------------------------------------------------
method setEditLine(lAllow) class JDialogGetDados
    // Variables.
    default lAllow  := .F.
    self:oGrid:LUPDATE := lAllow
return()

//-------------------------------------------------------------------
/*/{Protheus.doc} setData
@description 
@type method
@author Julian de ALmeida Santos
@since 18/03/2020
/*/
//-------------------------------------------------------------------
method getHeader() class JDialogGetDados
return(@self:oGrid:aHeader)

//-------------------------------------------------------------------
/*/{Protheus.doc} setData
@description 
@type method
@author Julian de ALmeida Santos
@since 18/03/2020
/*/
//-------------------------------------------------------------------
method getData() class JDialogGetDados
return(@self:oGrid:aCols)