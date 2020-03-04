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
    oJDialog  := JDialog():New (cTitle, nWidth, nHeight)

    oJDialog:setLeftClick(  {|| oJDialog:setSize(500, 500) , oJDialog:setTitle("Novo Titulo"), oJDialog:Center(.T.)} )

    oJDialog:setRightClick( {|| oJDialog:setSize(1280, 720), oJDialog:setTitle(cTitle)       , oJDialog:Center(.T.)} )

    oJDialog:setDoubleClick( {|| Alert("setDoubleClick")} )

    oJDialog:setAfterStarted( {|| Alert("setAfterStarted")} )

    oJDialog:BFOCUSCHANGE := {|| oJDialog:setSize(1500, 500) }

    TButton():New( 30, 30, "TButton", oJDialog, , 50, 15, , , , .T., , , , , ,  )

    // Shows JDialog with Activate method.
    oJDialog:show()

Return()