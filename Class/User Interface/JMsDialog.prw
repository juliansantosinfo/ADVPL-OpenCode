#include 'protheus.ch'
#include 'parmtype.ch'
#include 'totvs.ch'

//-------------------------------------------------------------------
/*/{Protheus.doc} JDialog
@description 
@type class
@author Julian de Almeida Santos
@since 03/03/2020
/*/
//-------------------------------------------------------------------
Class JDialog From TDialog
    
    method new() constructor
    method show()
    
    method setSize()
    method setTitle()

    method setLeftClick()
    method setRightClick()
    method setDoubleClick()
    method setAfterStarted()
    method setFocusChange()

EndClass

//-------------------------------------------------------------------
/*/{Protheus.doc} new
@description Constructor method for class JDialog.
@type method
@author Julian de Almeida Santos
@since 03/03/2020
/*/
//-------------------------------------------------------------------
method new(cTitle, nWidth, nHeight) class JDialog

    // Call to the parent class constructor.
    :New(0, 0, 0, 0, cTitle, , , , , , , , , , , , , nWidth, nHeight, )

return()

//-------------------------------------------------------------------
/*/{Protheus.doc} show
@description Show JDialog.
@type method
@author Julian de Almeida Santos
@since 03/03/2020
/*/
//-------------------------------------------------------------------
method show(lCentered, bValid, bInit) class JDialog
    
    // Variables.
    default lCentered:= .T.
    default bValid   := {|| .T.}
    default bInit    := {|| }
    
    // Show JDialog.
    self:Activate( , , , lCentered, bValid, , bInit, , )

return()

//-------------------------------------------------------------------
/*/{Protheus.doc} setSize
@description change size to JDialog.
@type method
@author Julian de Almeida Santos
@since 03/03/2020
/*/
//-------------------------------------------------------------------
method setSize(nWidth, nHeight, lCentralize) class JDialog
    
    // Variables.
    default nWidth      := self:nWidth
    default nHeight     := self:nHeight
    default lCentralize := .T.

    // set size.
    self:nWidth := nWidth
    self:nHeight:= nHeight

    // Centralize object.
    self:Center(lCentralize)

    // Refresh object.
    self:Refresh()

return()

//-------------------------------------------------------------------
/*/{Protheus.doc} setTitle
@description change title to JDialog.
@type method
@author Julian de Almeida Santos
@since 03/03/2020
/*/
//-------------------------------------------------------------------
method setTitle(cTitle) class JDialog
    
    // Variables.
    default cTitle := ""

    // set size.
    self:cTitle := cTitle

    // Refresh object.
    self:Refresh()

return()

//-------------------------------------------------------------------
/*/{Protheus.doc} setLeftClick
@description Defines a block of code to be executed when it is clicked with the left mouse button.
@type method
@author Julian de Almeida Santos
@since 03/03/2020
/*/
//-------------------------------------------------------------------
method setLeftClick(bCodeBlock) class JDialog

    // Variables.
    default bCodeBlock := self:BLCLICKED

    // Set propertie BLCLICKED.
    self:BLCLICKED := bCodeBlock

return()

//-------------------------------------------------------------------
/*/{Protheus.doc} setRightClick
@description Defines a block of code to be executed when it is clicked with the right mouse button.
@type method
@author Julian de Almeida Santos
@since 03/03/2020
/*/
//-------------------------------------------------------------------
method setRightClick(bCodeBlock) class JDialog

    // Variables.
    default bCodeBlock := self:BRCLICKED

    // Set propertie BRCLICKED.
    self:BRCLICKED := bCodeBlock

return()

//-------------------------------------------------------------------
/*/{Protheus.doc} setDoubleClick
@description Defines a block of code to be executed when it is clicked with the right mouse button.
@type method
@author Julian de Almeida Santos
@since 03/03/2020
/*/
//-------------------------------------------------------------------
method setDoubleClick(bCodeBlock) class JDialog

    // Variables.
    default bCodeBlock := self:BLDBLCLICK

    // Set propertie BRCLICKED.
    self:BLDBLCLICK := bCodeBlock

return()

//-------------------------------------------------------------------
/*/{Protheus.doc} setAfterStarted
@description Define codeBlock to be executed after the window is started.
@type method
@author Julian de Almeida Santos
@since 03/03/2020
/*/
//-------------------------------------------------------------------
method setAfterStarted(bCodeBlock) class JDialog

    // Variables.
    default bCodeBlock := self:BSTART

    // Set propertie BRCLICKED.
    self:BSTART := bCodeBlock

return ()

//-------------------------------------------------------------------
/*/{Protheus.doc} setAfterStarted
@description 
@type method
@author Julian de Almeida Santos
@since 03/03/2020
/*/
//-------------------------------------------------------------------
method setFocusChange(bCodeBlock) class JDialog

    // Variables.
    default bCodeBlock := self:BFOCUSCHANGE

    // Set propertie BRCLICKED.
    self:BFOCUSCHANGE := bCodeBlock

return()