#include 'protheus.ch'
#include 'parmtype.ch'
#include 'totvs.ch'

//-------------------------------------------------------------------
/*/{Protheus.doc} xTWindow
@description Sample for class TWindow
@type user function
@author Julian de Almeida Santos
@since 03/03/2020
/*/
//-------------------------------------------------------------------
User Function xTWindow()

    // Example of function to oTWindow class.
    Sample01()

    // Example of function to oTWindow, changing properties.
    Sample02()

    // Example of function to oTWindow class with TMenuBar.
    Sample03()

Return()

//-------------------------------------------------------------------
/*/{Protheus.doc} Sample01
@type static function
@author Julian de Almeida Santos
@since 03/03/2020
/*/
//-------------------------------------------------------------------
Static Function Sample01()

    // Variables.
    local   oTWindow    := Nil
    local   nTop        := 0
    local   nLeft       := 0
    local   nBottom     := 0
    local   nRight      := 0
    local   cTitle      := "Sample to oTWindow class"
    local   oParent     := Nil
    local   nColorFont  := CLR_BLACK
    local   nColorBack  := CLR_WHITE
    local   lPixel      := .T.
    local   lCentered   := .T.
    local   cShow       := "MAXIMIZED" // MAXIMIZED, ICONIZED, FULLSCREEN, HIDDEN (>= Server NG 13.2.3.43 ou Lobo Guara 17.3.0.13).

    // Instantiate oTWindow object
    oTWindow := TWindow():New(nTop, nLeft, nBottom, nRight, cTitle, , , , , oParent, , , nColorFont, nColorBack, , , , , , , lPixel)

    // Center window.
    oTWindow:Center(lCentered)

    // Shows oTWindow with Activate method.
    oTWindow:Activate(cShow)

Return()

//-------------------------------------------------------------------
/*/{Protheus.doc} Sample02
@type static function
@author Julian de Almeida Santos
@since 03/03/2020
/*/
//-------------------------------------------------------------------
Static Function Sample02()

    // Variables.
    local   oTWindow    := Nil
    local   nTop        := 0
    local   nLeft       := 0
    local   nBottom     := 0
    local   nRight      := 0
    local   cTitle      := "Sample to oTWindow class"
    local   oParent     := Nil
    local   nColorFont  := CLR_BLACK
    local   nColorBack  := CLR_WHITE
    local   lPixel      := .T.
    local   lCentered   := .T.
    local   cShow       := "MAXIMIZED" // MAXIMIZED, ICONIZED, FULLSCREEN, HIDDEN (>= Server NG 13.2.3.43 ou Lobo Guara 17.3.0.13).

    // Instantiate oTWindow object
    oTWindow := TWindow():New(nTop, nLeft, nBottom, nRight, cTitle, , , , , oParent, , , nColorFont, nColorBack, , , , , , , lPixel)

    // TWindow properties.
    oTWindow:BFOCUSCHANGE   := {|| }
    oTWindow:BINIT          := {|| Alert("BINIT") }
    oTWindow:BSTART         := {|| Alert("BSTART") }
    oTWindow:BWINDOWSTATE   := {|| Alert("BWINDOWSTATE") }
    oTWindow:BKEYDOWN       := {|| Alert("BKEYDOWN") }
    oTWindow:BLBUTTONUP     := {|| Alert("BLBUTTONUP") }
    oTWindow:BGOTFOCUS      := {|| Alert("BGOTFOCUS") }
    oTWindow:BHELP          := {|| Alert("BHELP") }
    oTWindow:BLCLICKED      := {|| Alert("BLCLICKED") }
    oTWindow:BLDBLCLICK     := {|| Alert("BLDBLCLICK") }
    oTWindow:BLOSTFOCUS     := {|| Alert("BLOSTFOCUS") }
    oTWindow:BMOVED         := {|| Alert("BMOVED") }
    oTWindow:BPAINTED       := {|| Alert("BPAINTED") }
    oTWindow:BRABSCLICKED   := {|| Alert("BRABSCLICKED") }
    oTWindow:BRCLICKED      := {|| Alert("BRCLICKED") }
    oTWindow:BRESIZED       := {|| Alert("BRESIZED") }

    // Center window.
    oTWindow:Center(lCentered)

    // Shows oTWindow with Activate method.
    oTWindow:Activate(cShow)

Return()

//-------------------------------------------------------------------
/*/{Protheus.doc} Sample02
@type static function
@author Julian de Almeida Santos
@since 03/03/2020
/*/
//-------------------------------------------------------------------
Static Function Sample03()

    // Variables.
    local   oTWindow    := Nil
    local   nTop        := 0
    local   nLeft       := 0
    local   nBottom     := 0
    local   nRight      := 0
    local   cTitle      := "Sample to oTWindow class"
    local   oParent     := Nil
    local   nColorFont  := CLR_BLACK
    local   nColorBack  := CLR_WHITE
    local   lPixel      := .T.
    local   lCentered   := .T.
    local   cShow       := "MAXIMIZED" // MAXIMIZED, ICONIZED, FULLSCREEN, HIDDEN (>= Server NG 13.2.3.43 ou Lobo Guara 17.3.0.13).

    // Instantiate oTWindow object
    oTWindow := TWindow():New(nTop, nLeft, nBottom, nRight, cTitle, , , , , oParent, , , nColorFont, nColorBack, , , , , , , lPixel)

    // Define TMenuBar
    oTMenuBar := TMenuBar():New(oTWindow)  
    
    oTMenu1   := TMenu():New(0,0,0,0,.T.,,oTWindow)
    oTMenu2   := TMenu():New(0,0,0,0,.T.,,oTWindow)
    
    oTMenuBar:AddItem('Menu 1', oTMenu1, .T.)
    oTMenuBar:AddItem('Menu 2', oTMenu2, .T.)
    
    oTMI01 := TMenuItem():New(oTWindow,'Menu Item 01',,,, {||Alert('TMenuItem 01')},,'AVGLBPAR1',,,,,,,.T.)
    oTMI02 := TMenuItem():New(oTWindow,'Menu Item 02',,,, {||Alert('TMenuItem 02')},,'AVGLBPAR1',,,,,,,.T.)
    oTMenu1:Add(oTMI01)
    oTMenu1:Add(oTMI02)
    
    oTMI03 := TMenuItem():New(oTWindow,'Menu Item 01',,,,{||Alert('TMenuItem 01')},,'AVGLBPAR1',,,,,,,.T.)
    oTMI04 := TMenuItem():New(oTWindow,'Menu Item 02',,,,{||Alert('TMenuItem 02')},,'AVGLBPAR1',,,,,,,.T.)
    oTMenu2:Add(oTMI03)
    oTMenu2:Add(oTMI04)

    // Add TMenuBar.
    oTWindow:SetMenu(oTMenuBar)

    // Center window.
    oTWindow:Center(lCentered)

    // Shows oTWindow with Activate method.
    oTWindow:Activate(cShow)

Return()