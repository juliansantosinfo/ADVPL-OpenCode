#include 'protheus.ch'
#include 'parmtype.ch'
#include 'totvs.ch'

//-------------------------------------------------------------------
/*/{Protheus.doc} xTMenuBar
@description Sample for class xTMenuBar
@type user function
@author Julian de Almeida Santos
@since 03/03/2020
/*/
//-------------------------------------------------------------------
User Function xTMenuBar()

    // Example of function to TMenuBar class with TWindow.
    Sample01()

    // Example of function to TMenuBar class with TDialog.
    Sample02()

    // Example of function to TMenuBar class with MsDialog.
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

    // Variables
    local   oTWindow
    local   oTMenuBar
    local   oTMenu1
    local   oTMenu2
    local   oTMenu3
    local   oTMenu4
    local   oMItem01
    local   oMItem02
    local   oMItem03
    local   oMItem04

    // Instantiate oTWindow object
    oTWindow := TWindow():New(0, 0, 720, 1280, "Sample to TMenuBar class with Twindow", , , , , Nil, , , , , , , , , , , .T.)

    // Define TMenuBar
    oTMenuBar := TMenuBar():New(oTWindow)

    // Define TMenu to menu bar.
    oTMenu1   := TMenu():New(0, 0, 0, 0, .T., 'AVGLBPAR1', oTWindow)
    oTMenu2   := TMenu():New(0, 0, 0, 0, .T., 'AVGLBPAR1', oTWindow)
    oTMenu3   := TMenu():New(0, 0, 0, 0, .T., 'AVGLBPAR1', oTWindow)
    oTMenu4   := TMenu():New(0, 0, 0, 0, .T., 'AVGLBPAR1', oTWindow)

    // Define TMenuItem to TMenu.
    oMItem01 := TMenuItem():New(oTWindow, 'Menu Item 01', , , , {|| Alert('TMenuItem 01')}, ,'AVGLBPAR1', , , , , , , .T.)
    oMItem02 := TMenuItem():New(oTWindow, 'Menu Item 02', , , , {|| Alert('TMenuItem 02')}, ,'AVGLBPAR1', , , , , , , .T.)
    oMItem03 := TMenuItem():New(oTWindow, 'Menu Item 03', , , , {|| Alert('TMenuItem 03')}, ,'AVGLBPAR1', , , , , , , .T.)
    oMItem04 := TMenuItem():New(oTWindow, 'Menu Item 04', , , , {|| Alert('TMenuItem 04')}, ,'AVGLBPAR1', , , , , , , .T.)

    // Add TMenu to menu bar.
    oTMenuBar:AddItem('Menu 1', oTMenu1, .T.)
    oTMenuBar:AddItem('Menu 2', oTMenu2, .T.)
    oTMenuBar:AddItem('Menu 3', oTMenu3, .T.)
    oTMenuBar:AddItem('Menu 4', oTMenu4, .T.)

    // Add TMenuItem to TMenu.
    oTMenu1:Add(oMItem01)
    oTMenu2:Add(oMItem02)
    oTMenu3:Add(oMItem03)
    oTMenu4:Add(oMItem04)

    // Add TMenuBar.
    oTWindow:SetMenu(oTMenuBar)

    // Centralize Twindow.
    oTWindow:Center(.T.)

    // Shows oTWindow with Activate method.
    oTWindow:Activate("MAXIMIZED")

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} Sample02
@type static function
@author Julian de Almeida Santos
@since 03/03/2020
/*/
//-------------------------------------------------------------------
Static Function Sample02()

    // Variables
    local   oTDialog
    local   oTMenuBar
    local   oTMenu1
    local   oTMenu2
    local   oTMenu3
    local   oTMenu4
    local   oMItem01
    local   oMItem02
    local   oMItem03
    local   oMItem04

     // Instantiate TDialog object
    oTDialog  := TDialog():New(0, 0, 0, 0, "Sample to TMenuBar class with TDialog", , , , , CLR_BLACK, CLR_WHITE, , , , , , , 1280, 720, .F.)

    // Define TMenuBar
    oTMenuBar := TMenuBar():New(oTDialog)

    // Define TMenu to menu bar.
    oTMenu1   := TMenu():New(0, 0, 0, 0, .T., 'AVGLBPAR1', oTDialog)
    oTMenu2   := TMenu():New(0, 0, 0, 0, .T., 'AVGLBPAR1', oTDialog)
    oTMenu3   := TMenu():New(0, 0, 0, 0, .T., 'AVGLBPAR1', oTDialog)
    oTMenu4   := TMenu():New(0, 0, 0, 0, .T., 'AVGLBPAR1', oTDialog)

    // Define TMenuItem to TMenu.
    oMItem01 := TMenuItem():New(oTDialog, 'Menu Item 01', , , , {|| Alert('TMenuItem 01')}, ,'AVGLBPAR1', , , , , , , .T.)
    oMItem02 := TMenuItem():New(oTDialog, 'Menu Item 02', , , , {|| Alert('TMenuItem 02')}, ,'AVGLBPAR1', , , , , , , .T.)
    oMItem03 := TMenuItem():New(oTDialog, 'Menu Item 03', , , , {|| Alert('TMenuItem 03')}, ,'AVGLBPAR1', , , , , , , .T.)
    oMItem04 := TMenuItem():New(oTDialog, 'Menu Item 04', , , , {|| Alert('TMenuItem 04')}, ,'AVGLBPAR1', , , , , , , .T.)

    // Add TMenu to menu bar.
    oTMenuBar:AddItem('Menu 1', oTMenu1, .T.)
    oTMenuBar:AddItem('Menu 2', oTMenu2, .T.)
    oTMenuBar:AddItem('Menu 3', oTMenu3, .T.)
    oTMenuBar:AddItem('Menu 4', oTMenu4, .T.)

    // Add TMenuItem to TMenu.
    oTMenu1:Add(oMItem01)
    oTMenu2:Add(oMItem02)
    oTMenu3:Add(oMItem03)
    oTMenu4:Add(oMItem04)

    // Add TMenuBar.
    oTDialog:SetMenu(oTMenuBar)

    // Shows TDialog with Activate method.
    oTDialog:Activate( , , , .T., , , , , )

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} Sample03
@type static function
@author Julian de Almeida Santos
@since 03/03/2020
/*/
//-------------------------------------------------------------------
Static Function Sample03()

    // Variables
    local   oMsDialog
    local   oTMenuBar
    local   oTMenu1
    local   oTMenu2
    local   oTMenu3
    local   oTMenu4
    local   oMItem01
    local   oMItem02
    local   oMItem03
    local   oMItem04

     // Instantiate MsDialog object
    oMsDialog := MSDialog():New(0, 0, 720, 1280, "Sample to TMenuBar class with MsDialog", , , , , , , , , .T., , , , )

    // Define TMenuBar
    oTMenuBar := TMenuBar():New(oMsDialog)

    // Define TMenu to menu bar.
    oTMenu1   := TMenu():New(0, 0, 0, 0, .T., 'AVGLBPAR1', oMsDialog)
    oTMenu2   := TMenu():New(0, 0, 0, 0, .T., 'AVGLBPAR1', oMsDialog)
    oTMenu3   := TMenu():New(0, 0, 0, 0, .T., 'AVGLBPAR1', oMsDialog)
    oTMenu4   := TMenu():New(0, 0, 0, 0, .T., 'AVGLBPAR1', oMsDialog)

    // Define TMenuItem to TMenu.
    oMItem01 := TMenuItem():New(oMsDialog, 'Menu Item 01', , , , {|| Alert('TMenuItem 01')}, ,'AVGLBPAR1', , , , , , , .T.)
    oMItem02 := TMenuItem():New(oMsDialog, 'Menu Item 02', , , , {|| Alert('TMenuItem 02')}, ,'AVGLBPAR1', , , , , , , .T.)
    oMItem03 := TMenuItem():New(oMsDialog, 'Menu Item 03', , , , {|| Alert('TMenuItem 03')}, ,'AVGLBPAR1', , , , , , , .T.)
    oMItem04 := TMenuItem():New(oMsDialog, 'Menu Item 04', , , , {|| Alert('TMenuItem 04')}, ,'AVGLBPAR1', , , , , , , .T.)

    // Add TMenu to menu bar.
    oTMenuBar:AddItem('Menu 1', oTMenu1, .T.)
    oTMenuBar:AddItem('Menu 2', oTMenu2, .T.)
    oTMenuBar:AddItem('Menu 3', oTMenu3, .T.)
    oTMenuBar:AddItem('Menu 4', oTMenu4, .T.)

    // Add TMenuItem to TMenu.
    oTMenu1:Add(oMItem01)
    oTMenu2:Add(oMItem02)
    oTMenu3:Add(oMItem03)
    oTMenu4:Add(oMItem04)

    // Add TMenuBar.
    oMsDialog:SetMenu(oTMenuBar)

    // Shows MsDialog with Activate method.
    oMsDialog:Activate( , , , .T., , , , , )

Return