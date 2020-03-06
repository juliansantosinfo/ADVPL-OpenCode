#include 'protheus.ch'
#include 'parmtype.ch'
#include 'totvs.ch'

//-------------------------------------------------------------------
/*/{Protheus.doc} xJDialog
@description Sample for class JDialog
@type user function
@author Julian de Almeida Santos
@since 03/03/2020
/*/
//-------------------------------------------------------------------
User Function xJDialog()

    // Example of function to JDialog class.
    Sample01()

    // Example of function to JDialog class with enchoicebar.
    Sample02()

    // Example of function to JDialog class with some methods.
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
    local   oJDialog    := Nil
    local   cTitle      := "Sample to JDialog class without transparency!"
    local   nWidth      := 1280
    local   nHeight     := 720

    // Instantiate JDialog object
    oJDialog  := JDialog():New (cTitle, nWidth, nHeight)    // Initialize object JDialog.
    oJDialog:show()                                         // Show JDialog.

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
    local   oJDialog    := Nil
    local   cTitle      := "Sample to JDialog class without transparency!"
    local   nWidth      := 1280
    local   nHeight     := 720

    // Instantiate JDialog object
    oJDialog  := JDialog():New (cTitle, nWidth, nHeight)    // Initialize object JDialog.
    oJDialog:setEnchoiceBar()                               // Add EnchoiceBar.
    oJDialog:show()                                         // Show JDialog.

Return()

//-------------------------------------------------------------------
/*/{Protheus.doc} Sample03
@type static function
@author Julian de Almeida Santos
@since 03/03/2020
/*/
//-------------------------------------------------------------------
Static Function Sample03()

    // Variables.
    local   oJDialog    := Nil
    local   cTitle      := "Sample to JDialog class without transparency!"
    local   nWidth      := 1280
    local   nHeight     := 720

    
    oJDialog  := JDialog():New (cTitle, nWidth, nHeight)            // Initialize object JDialog.

    oJDialog:setLeftClick(  {|| oJDialog:setSize(300, 300, .T.)} )  // set code block to left click button.
    oJDialog:setRightClick( {|| oJDialog:setSize(500, 500, .T.)} )  // set code block to right click button.
    oJDialog:setDoubleClick( {|| oJDialog:setTitle("New Title")} )  // set code block to doble click button.
    oJDialog:setAfterStarted( {|| Alert("JDialog Started.")} )      //

    oJDialog:show()

Return()