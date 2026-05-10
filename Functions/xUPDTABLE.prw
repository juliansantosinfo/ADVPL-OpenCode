#include 'protheus.ch'
#include 'parmtype.ch'
#include 'totvs.ch'
#include 'topconn.ch'
#include 'tbiconn.ch'

//-------------------------------------------------------------------
/*/{Protheus.doc} xUPDTABLE
@description Força update na estrutura da tabela, de acordo com alterações efetuadas no SX3.
@type function
@author Julian de Almeida Santos
@since 10/09/2024
/*/
//-------------------------------------------------------------------
User Function xUPDTABLE(cCodEmpresa, cCodFilial, cAlias)

    Default cCodEmpresa := FwInputBox('Informe a Empresa:', '   ')
    Default cCodFilial  := FwInputBox('Informe a Filial:', '   ')
    Default cAlias      := FwInputBox('Informe o Alias da tabela:', '   ')

	If TYPE('cEmpAnt') == "U"

		RESET ENVIRONMENT
		RPCSetType(3)
		PREPARE ENVIRONMENT EMPRESA cCodEmpresa FILIAL cCodFilial MODULO 'FAT'

	EndIf

    If ChkFile(cAlias,.T.)
        (cAlias)->(DBCloseArea())

        __SetX31Mode( .F. )
        X31UPDTABLE(cAlias)
        __SetX31Mode( .T. )

        TCRefresh(cAlias)

        Alert("Tabela '" + cAlias + "' atualizada com sucesso!")
    Else
        Alert("Não foi possivel abrir a tabela '" + cAlias + "' em modo exclusivo!")
    EndIf

Return()
