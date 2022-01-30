# Microdados_rais_STEM

Esse código foi escrito com o objetivo de organizar microdados da Rais e verificar a existência de desigualdade de gênero em profissões STEM. Esse foi o tema da minha monografia de graduação em Ciências Econômicas pela UFPR.
Abaixo, divido a explicação em duas fases: primeiro a parte teórica da origem e escolha dos dados e depois a parte mais prática.

1.	CAPTURA E ANÁLISE DOS MICRODADOS DA RAIS 

Os dados utilizados para a análise serão da Relação Anual de Informações Sociais, através dos midrodados disponibilizados pelo Ministério do Trabalho. A RAIS é um relatório enviado anualmente por todas as pessoas jurídicas do Brasil para o Ministério da Economia. Nele, deve constar o número de empregados da pessoa jurídica no dia 31/12, além da informação sobre admissões e demissões. Isso permite que o ministério elabore um “censo” do emprego formal no país. (BRASIL, 2021).
Apenas atores do mercado de trabalho formal, com contrato de trabalho, estão inclusos nesse relatório. Ele não inclui outras questões que são relevantes para o mercado de trabalho no geral, como a informalidade, o estágio e o trabalho doméstico (BRASIL, 2021).
Existem dois tipos de questionários dentro da RAIS. O primeiro é o de vínculos, em que cada observação é um contrato de trabalho. A análise desse questionário é mais interessante para a análise de salários, distribuição do emprego no país e distribuição de renda. O segundo tipo é o de estabelecimentos, em que cada observação é um CNPJ ou CEI (Cadastro Específico do INSS) ideal caso o foco sejam as empresas (BRASIL, 2021). Para esse trabalho utilizaremos dados do primeiro tipo de questionário.
A maior parte dos microdados do governo brasileiro é disponibilizada em arquivos do tipo txt colunado e a importação desses dados é complexa e demorada. A RAIS, em específico, é subdividida em muitos arquivos, por unidade federativa, região, ano e outros dados a depender da necessidade do analista. Além disso os nomes de arquivos e de variáveis da RAIS variam ao longo do tempo. 
Para esse trabalho, os microdados da RAIS foram capturados a partir do datalake disponibilizado pelo projeto Base dos Dados. A Base dos Dados é uma organização não-governamental, sem fins lucrativos, open source e colaborativa, que trabalha com o objetivo de catalogar e organizar bases de dados públicas, facilitando o acesso dos pesquisadores e da população em geral. Essa ferramenta já é conhecida e utilizada inclusive em parceria com órgãos públicos como o Tesouro Nacional, Governo do Estado de São Paulo, IPEA, entre outros (BASE DOS DADOS, 2021).
Os dados foram capturados através da ferramenta do Google chamada BigQuery, ferramenta importante para compartilhamento de grandes quantidades de dados, no datalake chamado BD+. Esse datalake padroniza os dados e sistematiza de forma que a obtenção dos dados é mais fácil e o maior trabalho a ser feito é a análise dos dados (BASE DOS DADOS, 2021).
A partir da captura dos dados necessários nesse repositório, a análise foi feita através do Software RStudio (R Core Team, 2016). No RStudio foram feitos os tratamentos específicos dos dados para esse trabalho, verificando a nomenclatura de algumas variáveis, ajustando médias e verificando padrões. Muito importante para esse tratamento são as informações constantes no Dicionário Rais, disponibilizado pelo Ministério da Economia, juntamente com os microdados (BRASIL, 2019).

2. O que eu fiz na prática?
Foram analisadas as seguintes informações (colunas) disponíveis nos microdados da RAIS:

cbo_2002:	Número identificador das Ocupações CBO - Tabela Ocupações;
ano:	2009, 2019;
sigla_uf:	PR, SC, RS;
tipo_vinculo:	Tipo de vínculo empregatício (CLT, estatutário, por contrato, etc.);
faixa_horas_contratadas:	Faixa de horas trabalhadas de acordo com o contrato do trabalhador; 
valor_remuneracao_media_sm:	Faixa de remuneração média do ano do trabalhador em salários-mínimos;
grau_instrucao_apos_2005:	Grau de instrução (Analfabetos, Ensino Fundamental e Médio etc);
sexo:	Masculino ou feminino
Tamanho_estabelecimento:	número empregados ativos em 31/12
STEM	Coluna criada para identificar, através do código cbo_2002, as ocupações STEM e não STEM
Fonte: Elaboração própria com dados da RAIS (BRASIL, 2021)


A coluna “cbo_2002” é uma coluna original da base de microdados da RAIS, cada linha dessa coluna é composta por um número de 5 dígitos, que representam as ocupações da CBO. A coluna “ano”, também é original da base e é composta por números de 4 dígitos. A coluna “sigla_uf” possui dois dígitos, são as letras das siglas da dos estados brasileiros. 
As variáveis “tipo_vinculo”, “faixa_horas_contratadas”, “valor_remuneracao_media_sm”, grau_instrucao_apos_2005 e “Tamanho_estabelecimento”, são colunas que na base de dados original, são compostas por números que representam faixas de dados. Para esse estudo, foram modificadas de acordo com o dicionário da RAIS para melhor compreensão dos resultados, essa modificação foi feita no RStudio. 
A coluna sexo é original da base e se trata de variável dummy, sendo 1 para sexo masculino e 2 para feminino. Também foi modificada no Rtudio.
A coluna “STEM” foi adicionada à base de dados no BigQuery, considerando a seleção de ocupações STEM feita esse estudo. É composta por uma variável dummy, para linhas onde a ocupação CBO está na lista dos 155 códigos CBO selecionados o valor da varável é “STEM”, caso contrário “Não STEM”
 
