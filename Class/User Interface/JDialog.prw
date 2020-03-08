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
    method close()
    
    method setSize()
    method setTitle()
    method setEnchoiceBar()

    method setLeftClick()
    method setRightClick()
    method setDoubleClick()
    method setBeforeShowing()
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
method show(lCentered, bBeforeClosing, bBeforeShowing) class JDialog
    
    // Variables.
    default lCentered       := .T.      // Indicates whether the window will be (.T.) Or not (.F.) Centered.
    default bBeforeClosing  := {|| .T.} // Indicates whether the content of the dialog is valid. If the return is false (.F.), The dialog will not be closed when finalization is requested.
    default bBeforeShowing  := {|| }    // Indicates the block of code that will be executed when the dialog starts displaying.
    
    // Show JDialog.
    self:Activate( , , , lCentered, bBeforeClosing, , bBeforeShowing, , )

return()

//-------------------------------------------------------------------
/*/{Protheus.doc} close
@description close JDialog.
@type method
@author Julian de Almeida Santos
@since 03/03/2020
/*/
//-------------------------------------------------------------------
method close() class JDialog
    
    self:End()

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
@description Change title to JDialog.
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
/*/{Protheus.doc} setEnchoiceBar
@description Define enchoicebarbar to JDialog.
@type method
@author Julian de Almeida Santos
@since 03/03/2020
/*/
//-------------------------------------------------------------------
method setEnchoiceBar(bFinish, bCancel, aButtons, lStandard, lHasOk, lPrintReg, lWalkThru, lMashups, lMsgDel, nRecno, cAliasRec, cProfileID) class JDialog

    // Variables.
    default bFinish     := {|| self:End()}  // Code block to be executed in the Ok button.
    default bCancel     := {|| self:End()}  // Block of code to be executed on the Cancel button.
    default lMsgDel     := Nil              // Displays dialog to confirm the deletion.
    default aButtons    := Nil              // Array containing additional buttons.
    default nRecno      := Nil              // Record to be positioned after executing the Ok button.
    default cAliasRec   := Nil              // Record alias to be positioned after executing the Ok button. If the parameter nRecno is informed, cAliasRec becomes mandatory.
    default lMashups    := Nil              // Indicates whether the "Mashups" button should be displayed.
    default lPrintReg   := Nil              // Indicates the "Print Registration" button should be displayed.
    default lStandard   := Nil              // Indicates whether standard buttons should be displayed.
    default lHasOk      := Nil              // Indicates whether the "OK" button should be displayed.
    default lWalkThru   := Nil              // Indicates whether the "WalkThru" button should be displayed.
    default cProfileID  := Nil              // ID to be taken into account when configuring the profile.

    // Initializes variable CACESSO if it does not exist.
    If Type('CACESSO') != 'C'
        CACESSO := ""
    EndIf

    // Add EnchoiceBar.
    EnchoiceBar(self, bFinish, bCancel, lMsgDel, aButtons, nRecno, cAliasRec, lMashups, lPrintReg, lStandard, lHasOk, lWalkThru, cProfileID)

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
    default bCodeBlock := self:BLCLICKED // Code block to be executed after the left click.

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
    default bCodeBlock := self:BRCLICKED // Code block to be executed after the right click.

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
    default bCodeBlock := self:BLDBLCLICK // Code block to be executed after the double  click.

    // Set propertie BRCLICKED.
    self:BLDBLCLICK := bCodeBlock

return()

//-------------------------------------------------------------------
/*/{Protheus.doc} setBeforeShowing
@description Define codeBlock to be executed before showing dialog.
@type method
@author Julian de Almeida Santos
@since 03/03/2020
/*/
//-------------------------------------------------------------------
method setBeforeShowing(bCodeBlock) class JDialog

    // Variables.
    default bCodeBlock := self:BSTART // Code block to be executed before showing dialog.

    // Set propertie BRCLICKED.
    self:BSTART := bCodeBlock

return ()

//-------------------------------------------------------------------
/*/{Protheus.doc} setFocusChange
@description Define codeBlock to be executed when the dialog changes focus. 
@type method
@author Julian de Almeida Santos
@since 03/03/2020
/*/
//-------------------------------------------------------------------
method setFocusChange(bCodeBlock) class JDialog

    // Variables.
    default bCodeBlock := self:BFOCUSCHANGE // Code block to be executed when the dialog changes focus.

    // Set propertie BRCLICKED.
    self:BFOCUSCHANGE := bCodeBlock

return()