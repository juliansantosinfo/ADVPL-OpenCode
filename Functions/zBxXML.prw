#Include "Protheus.ch"
#Include "ApWebSrv.ch"
#Include "TopConn.ch"
  
/*/{Protheus.doc} zBxXML
Faz download do arquivo XML do site da sefaz usando a Chave da nota
@author S�livan Sim�es Silva - Email: sulivansimoes@gmail.com
@since  08/03/2019
@version 1.1
@param cChaveNFe, caracter, chave da NFe � ser baixada da Sefaz 
@example zBxXML
@type function
@see Abaixo os links usados como refer�ncia para montagem da fun��o
        Link 01 - http://tdn.totvs.com/display/tec/Classe+TWsdlManager
        Link 02 - http://tdn.totvs.com/display/tec/SOAP+1.1+e+SOAP+1.2
        Link 03 - http://tdn.totvs.com/display/tec/XmlParser                
        Link 04 - http://www.nfe.fazenda.gov.br/portal/exibirArquivo.aspx?conteudo=iGDFY8YBs28=
    D�vidas quanto a Parse:
        Link 01 - https://centraldeatendimento.totvs.com/hc/pt-br/articles/360022658731-MP-ADVPL-Peer-certificate-cannot-be-authenticated-with-given-CA-certificates
        Link 02 - http://tdn.totvs.com/display/tec/Acesso+a+Web+Services+que+exigem+certificados+de+CA
        Link 03 - http://tdn.totvs.com/pages/viewpage.action?pageId=223932805
        Link 04 - http://tdn.totvs.com/display/tec/TWsdlManager%3AlSSLInsecure
@obs Documenta��o feita e adapta��es por Daniel Atilio
    Os par�metros que devem ser criados na base s�o:
        MV_X_BXUF  - C�digo do Estado conforme IBGE ( https://www.oobj.com.br/bc/article/quais-os-c%C3%B3digos-de-cada-uf-no-brasil-465.html )
        MV_X_BXAMB - Indica o tipo de Ambiente, 1 = Produ��o, 2 = Homologa��o
        MV_X_BXCA  - Diret�rio do certificado "ca", por exemplo: \certs\000001_ca.pem
        MV_X_BXCER - Diret�rio do certificado "cert", por exemplo: \certs\000001_cert.pem
        MV_X_BXKEY - Diret�rio do certificado "key", por exemplo: \certs\000001_key.pem
        MV_X_BXPSW - Senha do Certificado
        MV_X_BXPRO - Tipo do Protocolo, 0=Descobre sozinho; 1=TLSv1; 2=SSLv2; 3=SSLv3
        MV_X_BXDIR - Diret�rio que ser� gerado os arquivos XML
        MV_X_SSLIN - Define se far� a conex�o SSL com o servidor de forma an�nima, ou seja, sem verifica��o de certificados ou chaves. Default � .T.
@example Basta chamar a fun��o passando a chave da nfe
    u_zBxXML("CHAVE_AAAAAAAAAAAAAAAAAAAAAAA")
    u_zBxXML("CHAVE_BBBBBBBBBBBBBBBBBBBBBBB")
    u_zBxXML("CHAVE_CCCCCCCCCCCCCCCCCCCCCCC")
/*/
  
User Function zBxXML(cChaveNFe)
    Local aArea        := GetArea()
    Local lRet      := .T.
    Local cURL        := "https://www1.nfe.fazenda.gov.br/NFeDistribuicaoDFe/NFeDistribuicaoDFe.asmx?WSDL"
    Local cMsg      := ""
    Local oWsdl     := Nil
    Local cMsgRet   := ""
    Local cError    := ""
    Local cWarning  := ""
    Local cXmlGZip  := ""
    Local cArqXML   := ""
    Local cUfAutor  := SuperGetMV("MV_X_BXUF",  .F., "35")
    Local cTpAmb    := SuperGetMV("MV_X_BXAMB", .F., "1")
    Local cCNPJEmp  := Alltrim(Alltrim(FWArrFilAtu(FWCodEmp(),FWCodFil())[18]))
    Local lContinua := .T.
    Private oXmlDocZip
  
    //Inst�ncia a classe, setando as par�metriza��es necess�rias
    oWsdl := TWsdlManager():New()
    oWsdl:cSSLCACertFile := SuperGetMV("MV_X_BXCA",  .F., "\certs\000001_ca.pem")
    oWsdl:cSSLCertFile   := SuperGetMV("MV_X_BXCER", .F., "\certs\000001_cert.pem")
    oWsdl:cSSLKeyFile    := SuperGetMV("MV_X_BXKEY", .F., "\certs\000001_key.pem")
    oWsdl:cSSLKeyPwd     := SuperGetMV("MV_X_BXPSW", .F., "senha")
    oWsdl:nSSLVersion    := SuperGetMV("MV_X_BXPRO", .F., "0")
    oWsdl:lSSLInsecure   := SuperGetMV("MV_X_SSLIN", .F., .T.)
    oWsdl:nTimeout       := 120
  
    //Tenta fazer o Parse da URL
    lRet := oWsdl:ParseURL(cURL)
    If ! lRet 
        ConOut("[u_zBxXML] - Erro ParseURL: " + oWsdl:cError)
        lContinua := .F.
    EndIf
      
    //Se for continuar o processamento
    If lContinua
      
        //Tenta definir a opera��o
        lRet := oWsdl:SetOperation("nfeDistDFeInteresse")
        If ! lRet 
            ConOut("[u_zBxXML] - Erro SetOperation: " + oWsdl:cError)
            lContinua := .F.
        EndIf
        
    EndIf
      
    //Se for continuar
    If lContinua
        //Monta a mensagem que ser� enviada
        cMsg := '<soapenv:Envelope xmlns:soapenv="http://www.w3.org/2003/05/soap-envelope">'                        + CRLF
        cMsg += '    <soapenv:Header/>'                                                                              + CRLF
        cMsg += '    <soapenv:Body>'                                                                                + CRLF
        cMsg += '        <nfeDistDFeInteresse xmlns="http://www.portalfiscal.inf.br/nfe/wsdl/NFeDistribuicaoDFe">'  + CRLF
        cMsg += '                <nfeDadosMsg>'                                                                      + CRLF
        cMsg += '                    <distDFeInt xmlns="http://www.portalfiscal.inf.br/nfe" versao="1.01">'          + CRLF
        cMsg += '                        <tpAmb>'+cTpAmb+'</tpAmb>'                                                  + CRLF
        cMsg += '                     <cUFAutor>'+cUfAutor+'</cUFAutor>'                                              + CRLF
        cMsg += '                        <CNPJ>'+cCNPJEmp+'</CNPJ>'                                                  + CRLF
        cMsg += '                      <consChNFe>'                                                                    + CRLF
        cMsg += '                           <chNFe>'+alltrim(cChaveNFe)+'</chNFe>'                                  + CRLF
        cMsg += '                      </consChNFe>'                                                                   + CRLF
        cMsg += '                    </distDFeInt>'                                                                  + CRLF
        cMsg += '                </nfeDadosMsg>'                                                                     + CRLF
        cMsg += '            </nfeDistDFeInteresse>'                                                                 + CRLF
        cMsg += '        </soapenv:Body>'                                                                            + CRLF
        cMsg += '    </soapenv:Envelope>'                                                                            + CRLF
          
        //Envia uma mensagem SOAP personalizada ao servidor
        lRet := oWsdl:SendSoapMsg(cMsg)
        If ! lRet 
            ConOut("[u_zBxXML] - Erro SendSoapMsg: " + oWsdl:cError)
            ConOut("[u_zBxXML] - Erro SendSoapMsg FaultCode: " + oWsdl:cFaultCode)
            lContinua := .F.
        EndIf
    EndIf
  
    //Se for continuar
    If lContinua
        //Pega a resposta do SOAP
        cMsgRet := oWsdl:GetSoapResponse()
                             
        //Transforma a resposta em um objeto
        oXmlDocZip := XmlParser(cMsgRet, "_", @cError, @cWarning)
          
        //Se existir Warning, mostra no console.log
        If ! Empty(cWarning)
            ConOut("[u_zBxXML] - Alerta cWarning: " + cWarning)
        EndIf
          
        //Se houve erro, n�o permitir� prosseguir
        If ! Empty(cError)
            ConOut("[u_zBxXML] - Erro cError: " + cError)
            lContinua := .F.
        EndIf
    EndIf
  
    //Se for continuar
    If lContinua
        //Se a tag DocZip existir (for diferente de Undefinied)
        If (Type("oXmlDocZip:_SOAP_ENVELOPE:_SOAP_BODY:_NFEDISTDFEINTERESSERESPONSE:_NFEDISTDFEINTERESSERESULT:_RETDISTDFEINT:_LOTEDISTDFEINT:_DOCZIP") != "U")
  
            //Pega tag que cont�m XML em zip
            cXmlGZip := oXmlDocZip:_SOAP_ENVELOPE:_SOAP_BODY:_NFEDISTDFEINTERESSERESPONSE:_NFEDISTDFEINTERESSERESULT:_RETDISTDFEINT:_LOTEDISTDFEINT:_DOCZIP:TEXT
              
            //Gera arquivo XML
            cArqXML := fGeraXML(cXmlGZip, cChaveNFe)
        else
            conout("[u_zBxXML] - Ocorreu algum problema no momento de baixar o arquivo da sefaz!")
        endif
    EndIf
  
    RestArea(aArea)
Return cArqXML
  
/*-------------------------------------------------------------------------------*
 | Func:  fGeraXML                                                               |
 | Desc:  Fun��o para gerar o arquivo XML em uma pasta                           |
 *-------------------------------------------------------------------------------*/
  
Static Function fGeraXML(cConteudo, cChave)
    Local aArea        := getArea()
    Local lRet         := .T. 
    Local cArquivo     := cChave + ".xml"
    Local cDiretorio := Alltrim(SuperGetMV("MV_X_BXDIR", .F., "C:\TOTVS\XML\"))
    Local nTamanho     := 0
    Local cUnXML       := ""
    Local cDecode64  := ""
    Local cArqFull   := ""
    Local lHouveErro := .F.
      
    //Se o �ltimo caracter do diret�rio n�o for \, ser� barra \
    If SubStr(cDiretorio, Len(cDiretorio), 1) != "\"
        cDiretorio += "\"
    EndIf
      
    //Define o caminho final do arquivo
    cArqFull := cDiretorio + cArquivo
      
    //Pega o tamanho e descriptografa o conte�do
    nTamanho  := Len(cConteudo)
    cDecode64 := Decode64(cConteudo)
    lRet      := GzStrDecomp(cDecode64, nTamanho, @cUnXML)
       
    //Se deu certo
    If lRet
          
        //Se o diret�rio n�o existir, cria
        If ! ExistDir(cDiretorio)
            MakeDir(cDiretorio)
        EndIf
          
        //Cria o arquivo com o conte�do
        lRet := MemoWrite(cDiretorio+cArquivo, cUnXML)
          
        //Se houve falha, mostra mensagem no console.log
        If ! lRet
            ConOut("[u_zBxXML][fGeraXML] - N�o foi possivel criar o arquivo: " + cArqFull)
            lHouveErro := .T.
        EndIf
      
    //Se n�o deu certo, mostra mensagem no console.log
    Else
        ConOut("[u_zBxXML][fGeraXML] - Houve algum erro na descompacta��o do arquivo!")
        lHouveErro := .T.
    EndIf
  
    //Se houve erro, zera o nome do arquivo para retornar em branco
    If lHouveErro
        cArqFull := ""
    EndIf
  
    RestArea(aArea)
Return cArqFull
