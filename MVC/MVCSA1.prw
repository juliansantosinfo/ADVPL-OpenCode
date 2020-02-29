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

    // Define descrição.
    oBrowse:SetDescription(cDescription)

    // Define legendas.
    oBrowse:AddLegend("A1_MSBLQL==1", "RED"  , "Bloqueado")
    oBrowse:AddLegend("A1_MSBLQL==2", "GREEN", "Liberado" )

    // Ativa browse.
    oBrowse:Activate()

Return()

//-------------------------------------------------------------------
/*/{Protheus.doc} MenuDef
@description Uma função MenuDef define as operações quer serão realizadas pela aplicação, tais como inclusão, alteração, exclusão, etc.
@type static function
@author Julian de Almeida Santos
@since 15/08/2019
/*/
//-------------------------------------------------------------------
Static Function MenuDef()

    // Variaveis.
    Local aRotina   := {}

    // Popula array com opções do menu.
    // Posições do Array
    // 1. Nome da opção no menu
    // 2. Nome da Rotina associada
    // 3. Usado pela rotina
    // 4. Tipo de Operação a ser efetuada
    AADD(aRotina, {})
    AADD(aRotina, {})
    AADD(aRotina, {})
    AADD(aRotina, {})
    AADD(aRotina, {})

Return(aRotina)

//-------------------------------------------------------------------
/*/{Protheus.doc} ModelDef
@description Função ModelDef, define o modelo de dados a ser utilizado pela ViewDef.
@type static function
@author Julian de Almeida Santos
@since 15/08/2019
/*/
//-------------------------------------------------------------------
Static Function ModelDef()

    /*A primeira coisa que precisamos fazer é criar a estrutura utilizada no modelo de dados (Model).
    As estruturas são objetos que contêm as definições dos dados necessárias para uso da
    ModelDef ou para a ViewDef. Esses objetos contêm:
    *Estrutura dos Campos;
    *Índices;
    *Gatilhos;
    *Regras de preenchimento (veremos à frente);
    *Etc.
    Como dito anteriormente o MVC não trabalha vinculado aos metadados (dicionários) do
    Microsiga Protheus, ele trabalha vinculado a estruturas. Essas estruturas, por sua vez, é que
    podem ser construídas a partir dos metadados.
    Com a função FWFormStruct a estrutura será criada a partir do metadado.*/

    LOCAL   oStruSA1    := FWFormStruct( 1, 'SA1')
    LOCAL	oStruZAV	:= FWFormStruct( 1, 'ZAV')
    LOCAL	oStruZAX	:= FWFormStruct( 1, 'ZAX')
    LOCAL	oStruZAZ	:= FWFormStruct( 1, 'ZAZ')

    /*Ao criarmos uma estrutura baseada no metadados (dicionários), utilizando a função
    FWFormStruct, são respeitadas as propriedades que o campo tem como validação,
    inicializador padrão e modo de edição, etc. Se houver a necessidade de mudar alguma propriedade do campo na estrutura, usaremos o
    método SetProperty para isso. Onde o 1º parâmetro é o nome do campo que se deseja mudar ou atribuir a propriedade o 2º é
    a propriedade que esta sendo tratada e o 3º é o valor para a propriedade.*/

    oStruZAV:SetProperty( 'ZAV_CODIGO' , MODEL_FIELD_VALID	,{ || U_ZAVVLDCP('CODIGO') })
    oStruZAV:SetProperty( 'ZAV_NOME'   , MODEL_FIELD_VALID	,{ || U_ZAVVLDCP('NOME'  ) })
    oStruZAV:SetProperty( 'ZAV_TIPO'   , MODEL_FIELD_VALID	,{ || U_ZAVVLDTP(        ) })

    /*MPFormModel é a classe utilizada para a construção de um objeto de modelo de dados
    (Model). Devemos dar um identificador (ID) para o modelo como um todo e também um para cada
    componente. Essa é uma característica do MVC, todo componente do modelo ou da interface devem ter um
    ID, como formulários, GRIDs, boxes, etc. M_UCTLPROM é o identificador (ID) dado ao Model:*/
    PRIVATE	oModel		:= MPFormModel():New( 'M_UCTLPROM' )

    /*O método AddFields adiciona um componente de formulário ao modelo.
    A estrutura do modelo de dados (Model) deve iniciar, obrigatoriamente, com um componente
    de formulário.*/
    oModel:AddFields( 'M_FORMZAV', /*cOwner*/, oStruZAV )

    /*O método AddGrid adiciona ao modelo um componente de grid.
    Devemos dar um identificador (ID) para cada componente do Model.
    M_GRIDZAX é o identificador (ID) dado ao componente no Model, oStruZAX é a estrutura que
    será usada no componente e que foi construída anteriormente utilizando FWFormStruct, note
    que o segundo parâmetro (Owner) desta vez foi informado, isso porque esta entidade depende
    da 1ª (Master), portanto M_FORMZAV é o componente superior ou owner de M_GRIDZAX.*/
    oModel:AddGrid( 'M_GRIDZAX', 'M_FORMZAV', oStruZAX )

    /*O método AddGrid adiciona ao modelo um componente de grid.
    Devemos dar um identificador (ID) para cada componente do Model.
    M_GRIDZAZ é o identificador (ID) dado ao componente no Model, oStruZAZ é a estrutura que
    será usada no componente e que foi construída anteriormente utilizando FWFormStruct, note
    que o segundo parâmetro (Owner) desta vez foi informado, isso porque esta entidade depende
    da 1ª (Master), portanto M_FORMZAZ é o componente superior ou owner de M_GRIDZAZ.*/
    oModel:AddGrid( 'M_GRIDZAZ', 'M_FORMZAV', oStruZAZ )

    /*Dentro do modelo devemos relacionar todas as entidades que participam dele. No nosso
    exemplo temos que relacionar a entidade Detail com a entidade Master.
    Uma regrinha bem simples para entender isso é: Toda entidade do modelo que possui um
    superior (owner) dever ter seu relacionamento para ele definido. Em outras palavras, é preciso
    dizer quais as chaves de relacionamento do filho para o pai.
    O método utilizado para esta definição é o SetRelation.
    O ZA2DETAIL é o identificador (ID) da entidade Detail, o segundo parâmetro é um vetor bi-
    dimensional onde são definidos os relacionamentos entre cada campo da entidade filho para a
    entidade Pai. O terceiro parâmetro é a ordenação destes dados no componente.
    Estamos dizendo no exemplo acima que o relacionamento da entidade Detail será por
    ZA2_FILIAL e ZA2_MUSICA, o valor de ZA2_FILIAL será dado por xFilial() e o de
    ZA2_MUSICA virá de ZA1_MUSICA.
    Observação: O relacionamento sempre é definido do Detail (Filho) para o Master (Pai),
    tanto no identificador (ID) quanto na ordem do vetor bi-dimensional.*/
    oModel:SetRelation( 'M_GRIDZAX', { { 'ZAX_FILIAL', 'xFilial( "ZAX" )' }, { 'ZAX_CODIGO', 'ZAV_CODIGO' } }, ZAX->( IndexKey( 1 ) ) )

    /*Dentro do modelo devemos relacionar todas as entidades que participam dele. No nosso
    exemplo temos que relacionar a entidade Detail com a entidade Master.
    Uma regrinha bem simples para entender isso é: Toda entidade do modelo que possui um
    superior (owner) dever ter seu relacionamento para ele definido. Em outras palavras, é preciso
    dizer quais as chaves de relacionamento do filho para o pai.
    O método utilizado para esta definição é o SetRelation.
    O ZA2DETAIL é o identificador (ID) da entidade Detail, o segundo parâmetro é um vetor bi-
    dimensional onde são definidos os reNlacionamentos entre cada campo da entidade filho para a
    entidade Pai. O terceiro parâmetro é a ordenação destes dados no componente.
    Estamos dizendo no exemplo acima que o relacionamento da entidade Detail será por
    ZA2_FILIAL e ZA2_MUSICA, o valor de ZA2_FILIAL será dado por xFilial() e o de
    ZA2_MUSICA virá de ZA1_MUSICA.
    Observação: O relacionamento sempre é definido do Detail (Filho) para o Master (Pai),
    tanto no identificador (ID) quanto na ordem do vetor bi-dimensional.*/
    oModel:SetRelation( 'M_GRIDZAZ', { { 'ZAZ_FILIAL', 'xFilial( "ZAZ" )' }, { 'ZAZ_CODIGO', 'ZAV_CODIGO' } }, ZAZ->( IndexKey( 1 ) ) )

    /*O modelo de dados precisa que sempre se informe qual a chave primária para a entidade
    principal do modelo de dados (Model).
    Se a estrutura da entidade foi construída utilizando-se o FWFormStruct, a chave primária
    será aquela que foi definida no metadados (dicionários)X2_UNICO.
    Se a estrutura foi construída manualmente ou se a entidade não possui definição de chave
    única no metadados, temos que definir qual será essa chave com o método S SetPrimaryKey.*/
    oModel:SetPrimaryKey( {'ZAV_FILIAL','ZAV_CODIGO'} )

    /*Sempre definindo uma descrição para os componentes do modelo.
    Com o método SetDescription adicionamos a descrição ao modelo de dados (Model), essa
    descrição será usada em vários lugares como em Web Services por exemplo.
    Adicionamos a descrição do modelo de dados: */
    oModel:SetDescription( 'Modelo de dados de Cadastro de Promoções' )

    /*Adicionamos a descrição dos componentes do modelo de dados:*/
    oModel:GetModel( 'M_FORMZAV' ):SetDescription( 'Dados Cadastro de Promoções' )
    oModel:GetModel( 'M_GRIDZAX' ):SetDescription( 'Dados Cadastro de Promoções/Coef. e Quantidades' )
    oModel:GetModel( 'M_GRIDZAZ' ):SetDescription( 'Dados Cadastro de Promoções/Produtos e Prç. Liquido' )

    /*Permite que o grid tenha ou não linhas.*/
    oModel:GetModel( 'M_GRIDZAX' ):SetOptional( .T. )
    oModel:GetModel( 'M_GRIDZAZ' ):SetOptional( .T. )

    /*Ao final da função ModelDef, deve ser retornado o objeto de modelo de dados (Model) gerado
    na função.*/

Return(oModel)