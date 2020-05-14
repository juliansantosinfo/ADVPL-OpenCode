#include 'protheus.ch'
#include 'parmtype.ch'
#include 'totvs.ch'
#include 'tbiconn.ch'

static  oBmpOk := LoadBitmap( GetResources(), "LBOK")
static  oBmpNo := LoadBitmap( GetResources(), "LBNO")

//-------------------------------------------------------------------
/*/{Protheus.doc} xJDlgGetDados
@description Sample for class JDialogGetDados
@type user function
@author Julian de Almeida Santos
@since 18/03/2020
/*/
//-------------------------------------------------------------------
User Function xJDlgGetDados()

    RpcSetEnv('01', '01')

    // Sample to JDialogGetDados class without EnchoiceBar.
    Sample01()

Return()

//-------------------------------------------------------------------
/*/{Protheus.doc} Sample01
@type static function
@author Julian de Almeida Santos
@since 18/03/2020
/*/
//-------------------------------------------------------------------
Static Function Sample01()

    // Variables.
    local   oJDialog    := Nil
    local   cTitle      := "Sample to JDialogGetDados class without EnchoiceBar!"
    local   nWidth      := 1280
    local   nHeight     := 720
    local   aHeader     := Nil
    local   aColumnSize := Nil
    local   aCols       := Nil
    local   lEnchoiceBar:= .F.

    // Define aHeader.
    aHeader := {}
    AADD(aHeader, {"COLUMN 1", "COL1", "@BMP"         , 02, 00, ".T.", "", "C"})
    AADD(aHeader, {"COLUMN 2", "COL2", "@!"           , 20, 00, ".T.", "", "C"})
    AADD(aHeader, {"COLUMN 3", "COL3", "9999999.99"   , 10, 02, ".T.", "", "N"})
    AADD(aHeader, {"COLUMN 4", "COL4", ""             , 08, 00, ".T.", "", "D"})

    // Define aCols.
    aCols := {}
    AADD(aCols, {oBmpOk, "COLUMN CARACTER", 4, Date(), .F.})
    AADD(aCols, {oBmpNo, "COLUMN CARACTER", 3, Date(), .F.})
    AADD(aCols, {oBmpOk, "COLUMN CARACTER", 2, Date(), .F.})
    AADD(aCols, {oBmpNo, "COLUMN CARACTER", 1, Date(), .F.})

    // Instantiate JDialogGetDados object #1
    oJDialogGetDados := JDialogGetDados():new(cTitle, nWidth, nHeight, aHeader, aCols, lEnchoiceBar)
    oJDialogGetDados:show()             // Show dialog.

    // Instantiate JDialogGetDados object #2
    oJDialogGetDados := JDialogGetDados():new(cTitle, nWidth, nHeight)
    oJDialogGetDados:setHeader(aHeader) // set header to msgetdados.
    oJDialogGetDados:setData(aCols)     // Set data to msgetdados.
    oJDialogGetDados:show()             // Show dialog.

    // Instantiate JDialogGetDados object #3
    oJDialogGetDados := JDialogGetDados():new(cTitle, nWidth, nHeight)
    oJDialogGetDados:setHeader(aHeader) // set header to msgetdados.
    oJDialogGetDados:setData(aCols)     // Set data to msgetdados.
    oJDialogGetDados:setInsertLine(.F.) // Disables line insertion.
    oJDialogGetDados:setDeleteLine(.F.) // Disable line deletion.
    oJDialogGetDados:setEditLine(.F.)   // Disable line editing.
    oJDialogGetDados:show()             // Show dialog.

    // Instantiate JDialogGetDados object #4
    cSQL := "SELECT * FROM SA1010 WHERE ROWNUM <= 100 "
    oJDialogGetDados := JDialogGetDados():new(cTitle, nWidth, nHeight, aHeader, aCols, lEnchoiceBar)
    oJDialogGetDados:setFromSQL(cSQL)   // Create grid with data from SQL.
    oJDialogGetDados:show()             // Show dialog.

Return()
