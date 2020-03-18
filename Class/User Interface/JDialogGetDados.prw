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

    method getGridSize()

    method setHeader()
    method getHeader()
    method setData()
    method getData()

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
    local   aGridPosition   := {}
    local   nGridRow        := 0
    local   nGridCol        := 0
    local   nGridWidth      := 0
    local   nGridHeight     := 0
    local   nStyle          := GD_INSERT + GD_UPDATE + GD_DELETE
    default cTitle          := ""
    default nWidth          := 640
    default nHeight         := 480
    default aHeader         := {}
    default aData           := {}
    default lEnchoiceBar    := .F.

    self:oDialog := JDialog():New(cTitle, nWidth, nHeight)

    aGridPosition := self:getGridSize(nWidth, nHeight, lEnchoiceBar)
    nGridRow   := aGridPosition[1,1]
    nGridCol   := aGridPosition[1,2]
    nGridWidth := aGridPosition[1,3]
    nGridHeight:= aGridPosition[1,4]

    self:oGrid := MsNewGetDados():New(nGridRow, nGridCol, nGridHeight, nGridWidth, nStyle, , , , , , , , , , self:oDialog, aHeader, aData, , , )

    If !Empty(aHeader) .AND. !Empty(aData)
        self:setHeader(aHeader)
        self:setData(aData)
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
    local   aGridPosition := {}
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
method setHeader() class JDialogGetDados
return()

//-------------------------------------------------------------------
/*/{Protheus.doc} setData
@description 
@type method
@author Julian de ALmeida Santos
@since 18/03/2020
/*/
//-------------------------------------------------------------------
method setData() class JDialogGetDados
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
return()

//-------------------------------------------------------------------
/*/{Protheus.doc} setData
@description 
@type method
@author Julian de ALmeida Santos
@since 18/03/2020
/*/
//-------------------------------------------------------------------
method getData() class JDialogGetDados
return()