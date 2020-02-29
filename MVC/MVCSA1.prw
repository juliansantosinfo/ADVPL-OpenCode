#include 'protheus.ch'
#include 'parmtype.ch'

//-------------------------------------------------------------------
/*/{Protheus.doc} MVCSA1
@description CRUD MVC para tabela SA1 (Cadastro de Clientes)
@type user function
@author Julian de Almeida Santos
@since 15/08/2019
/*/
//-------------------------------------------------------------------   
User Function MVCSA1()

    // Variaveis.
    Local   cAlias      := "SA1"
    Local   cDescription:= "Cadastro de Produtos"
    private oBrowse     := Nil

    // Define browser.
    oBrowse := FWBrowse():New()

    // Define tabela.
    oBrowse:SetAlias(cAlias)

    // Define descri��o.
    oBrowse:SetDescription(cDescription)

    // Define legendas.
    oBrowse:AddLegend("A1_MSBLQL==1", "RED"  , "Bloqueado")
    oBrowse:AddLegend("A1_MSBLQL==2", "GREEN", "Liberado" )

    // Ativa browse.
    oBrowse:Activate()

Return()

//-------------------------------------------------------------------
/*/{Protheus.doc} MenuDef
@description Uma fun��o MenuDef define as opera��es quer ser�o realizadas pela aplica��o, tais como inclus�o, altera��o, exclus�o, etc.
@type static function
@author Julian de Almeida Santos
@since 15/08/2019
/*/
//-------------------------------------------------------------------
Static Function MenuDef()

    // Variaveis.
    Local aRotina   := {}

    // Popula array com op��es do menu.
    // Posi��es do Array
    // 1. Nome da op��o no menu
    // 2. Nome da Rotina associada
    // 3. Usado pela rotina
    // 4. Tipo de Opera��o a ser efetuada
    AADD(aRotina, {})
    AADD(aRotina, {})
    AADD(aRotina, {})
    AADD(aRotina, {})
    AADD(aRotina, {})

Return(aRotina)

//-------------------------------------------------------------------
/*/{Protheus.doc} ModelDef
@description Fun��o ModelDef, define o modelo de dados a ser utilizado pela ViewDef.
@type static function
@author Julian de Almeida Santos
@since 15/08/2019
/*/
//-------------------------------------------------------------------
Static Function ModelDef()

    /*A primeira coisa que precisamos fazer � criar a estrutura utilizada no modelo de dados (Model).
    As estruturas s�o objetos que cont�m as defini��es dos dados necess�rias para uso da
    ModelDef ou para a ViewDef. Esses objetos cont�m:
    *Estrutura dos Campos;
    *�ndices;
    *Gatilhos;
    *Regras de preenchimento (veremos � frente);
    *Etc.
    Como dito anteriormente o MVC n�o trabalha vinculado aos metadados (dicion�rios) do
    Microsiga Protheus, ele trabalha vinculado a estruturas. Essas estruturas, por sua vez, � que
    podem ser constru�das a partir dos metadados.
    Com a fun��o FWFormStruct a estrutura ser� criada a partir do metadado.*/

    LOCAL   oStruSA1    := FWFormStruct( 1, 'SA1')
    LOCAL	oStruZAV	:= FWFormStruct( 1, 'ZAV')
    LOCAL	oStruZAX	:= FWFormStruct( 1, 'ZAX')
    LOCAL	oStruZAZ	:= FWFormStruct( 1, 'ZAZ')

    /*Ao criarmos uma estrutura baseada no metadados (dicion�rios), utilizando a fun��o
    FWFormStruct, s�o respeitadas as propriedades que o campo tem como valida��o,
    inicializador padr�o e modo de edi��o, etc. Se houver a necessidade de mudar alguma propriedade do campo na estrutura, usaremos o
    m�todo SetProperty para isso. Onde o 1� par�metro � o nome do campo que se deseja mudar ou atribuir a propriedade o 2� �
    a propriedade que esta sendo tratada e o 3� � o valor para a propriedade.*/

    oStruZAV:SetProperty( 'ZAV_CODIGO' , MODEL_FIELD_VALID	,{ || U_ZAVVLDCP('CODIGO') })
    oStruZAV:SetProperty( 'ZAV_NOME'   , MODEL_FIELD_VALID	,{ || U_ZAVVLDCP('NOME'  ) })
    oStruZAV:SetProperty( 'ZAV_TIPO'   , MODEL_FIELD_VALID	,{ || U_ZAVVLDTP(        ) })

    /*MPFormModel � a classe utilizada para a constru��o de um objeto de modelo de dados
    (Model). Devemos dar um identificador (ID) para o modelo como um todo e tamb�m um para cada
    componente. Essa � uma caracter�stica do MVC, todo componente do modelo ou da interface devem ter um
    ID, como formul�rios, GRIDs, boxes, etc. M_UCTLPROM � o identificador (ID) dado ao Model:*/
    PRIVATE	oModel		:= MPFormModel():New( 'M_UCTLPROM' )

    /*O m�todo AddFields adiciona um componente de formul�rio ao modelo.
    A estrutura do modelo de dados (Model) deve iniciar, obrigatoriamente, com um componente
    de formul�rio.*/
    oModel:AddFields( 'M_FORMZAV', /*cOwner*/, oStruZAV )

    /*O m�todo AddGrid adiciona ao modelo um componente de grid.
    Devemos dar um identificador (ID) para cada componente do Model.
    M_GRIDZAX � o identificador (ID) dado ao componente no Model, oStruZAX � a estrutura que
    ser� usada no componente e que foi constru�da anteriormente utilizando FWFormStruct, note
    que o segundo par�metro (Owner) desta vez foi informado, isso porque esta entidade depende
    da 1� (Master), portanto M_FORMZAV � o componente superior ou owner de M_GRIDZAX.*/
    oModel:AddGrid( 'M_GRIDZAX', 'M_FORMZAV', oStruZAX )

    /*O m�todo AddGrid adiciona ao modelo um componente de grid.
    Devemos dar um identificador (ID) para cada componente do Model.
    M_GRIDZAZ � o identificador (ID) dado ao componente no Model, oStruZAZ � a estrutura que
    ser� usada no componente e que foi constru�da anteriormente utilizando FWFormStruct, note
    que o segundo par�metro (Owner) desta vez foi informado, isso porque esta entidade depende
    da 1� (Master), portanto M_FORMZAZ � o componente superior ou owner de M_GRIDZAZ.*/
    oModel:AddGrid( 'M_GRIDZAZ', 'M_FORMZAV', oStruZAZ )

    /*Dentro do modelo devemos relacionar todas as entidades que participam dele. No nosso
    exemplo temos que relacionar a entidade Detail com a entidade Master.
    Uma regrinha bem simples para entender isso �: Toda entidade do modelo que possui um
    superior (owner) dever ter seu relacionamento para ele definido. Em outras palavras, � preciso
    dizer quais as chaves de relacionamento do filho para o pai.
    O m�todo utilizado para esta defini��o � o SetRelation.
    O ZA2DETAIL � o identificador (ID) da entidade Detail, o segundo par�metro � um vetor bi-
    dimensional onde s�o definidos os relacionamentos entre cada campo da entidade filho para a
    entidade Pai. O terceiro par�metro � a ordena��o destes dados no componente.
    Estamos dizendo no exemplo acima que o relacionamento da entidade Detail ser� por
    ZA2_FILIAL e ZA2_MUSICA, o valor de ZA2_FILIAL ser� dado por xFilial() e o de
    ZA2_MUSICA vir� de ZA1_MUSICA.
    Observa��o: O relacionamento sempre � definido do Detail (Filho) para o Master (Pai),
    tanto no identificador (ID) quanto na ordem do vetor bi-dimensional.*/
    oModel:SetRelation( 'M_GRIDZAX', { { 'ZAX_FILIAL', 'xFilial( "ZAX" )' }, { 'ZAX_CODIGO', 'ZAV_CODIGO' } }, ZAX->( IndexKey( 1 ) ) )

    /*Dentro do modelo devemos relacionar todas as entidades que participam dele. No nosso
    exemplo temos que relacionar a entidade Detail com a entidade Master.
    Uma regrinha bem simples para entender isso �: Toda entidade do modelo que possui um
    superior (owner) dever ter seu relacionamento para ele definido. Em outras palavras, � preciso
    dizer quais as chaves de relacionamento do filho para o pai.
    O m�todo utilizado para esta defini��o � o SetRelation.
    O ZA2DETAIL � o identificador (ID) da entidade Detail, o segundo par�metro � um vetor bi-
    dimensional onde s�o definidos os reNlacionamentos entre cada campo da entidade filho para a
    entidade Pai. O terceiro par�metro � a ordena��o destes dados no componente.
    Estamos dizendo no exemplo acima que o relacionamento da entidade Detail ser� por
    ZA2_FILIAL e ZA2_MUSICA, o valor de ZA2_FILIAL ser� dado por xFilial() e o de
    ZA2_MUSICA vir� de ZA1_MUSICA.
    Observa��o: O relacionamento sempre � definido do Detail (Filho) para o Master (Pai),
    tanto no identificador (ID) quanto na ordem do vetor bi-dimensional.*/
    oModel:SetRelation( 'M_GRIDZAZ', { { 'ZAZ_FILIAL', 'xFilial( "ZAZ" )' }, { 'ZAZ_CODIGO', 'ZAV_CODIGO' } }, ZAZ->( IndexKey( 1 ) ) )

    /*O modelo de dados precisa que sempre se informe qual a chave prim�ria para a entidade
    principal do modelo de dados (Model).
    Se a estrutura da entidade foi constru�da utilizando-se o FWFormStruct, a chave prim�ria
    ser� aquela que foi definida no metadados (dicion�rios)X2_UNICO.
    Se a estrutura foi constru�da manualmente ou se a entidade n�o possui defini��o de chave
    �nica no metadados, temos que definir qual ser� essa chave com o m�todo S SetPrimaryKey.*/
    oModel:SetPrimaryKey( {'ZAV_FILIAL','ZAV_CODIGO'} )

    /*Sempre definindo uma descri��o para os componentes do modelo.
    Com o m�todo SetDescription adicionamos a descri��o ao modelo de dados (Model), essa
    descri��o ser� usada em v�rios lugares como em Web Services por exemplo.
    Adicionamos a descri��o do modelo de dados: */
    oModel:SetDescription( 'Modelo de dados de Cadastro de Promo��es' )

    /*Adicionamos a descri��o dos componentes do modelo de dados:*/
    oModel:GetModel( 'M_FORMZAV' ):SetDescription( 'Dados Cadastro de Promo��es' )
    oModel:GetModel( 'M_GRIDZAX' ):SetDescription( 'Dados Cadastro de Promo��es/Coef. e Quantidades' )
    oModel:GetModel( 'M_GRIDZAZ' ):SetDescription( 'Dados Cadastro de Promo��es/Produtos e Pr�. Liquido' )

    /*Permite que o grid tenha ou n�o linhas.*/
    oModel:GetModel( 'M_GRIDZAX' ):SetOptional( .T. )
    oModel:GetModel( 'M_GRIDZAZ' ):SetOptional( .T. )

    /*Ao final da fun��o ModelDef, deve ser retornado o objeto de modelo de dados (Model) gerado
    na fun��o.*/

Return(oModel)