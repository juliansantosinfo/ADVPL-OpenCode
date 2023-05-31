#include 'protheus.ch'
#include 'parmtype.ch'
#include 'totvs.ch'
#include 'topconn.ch'
#include 'tbiconn.ch'

//-------------------------------------------------------------------
/*/{Protheus.doc} JLayerMod1
@description 
@author Julian de Almeida Santos
@since 30/05/2023
/*/
//-------------------------------------------------------------------
class JLayerMod1

    method new() constructor

    data oDialog    as object

    
EndClass

//-------------------------------------------------------------------
/*/{Protheus.doc} new
@description class constructor
@author Julian de Almeida Santos
@since 30/05/2023
/*/
//-------------------------------------------------------------------
method new(cTitle, nWidth, nHeight) class JLayerMod1

    Local aWndSize := MsAdvSize()
    Default cTitle := ""
    Default nWidth := 0
    Default nHeight:= 0
    
    self:oDialog := JDialog():New(cTitle, nWidth, nHeight)

return
