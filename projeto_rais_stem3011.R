#libraries necessaries
library(DBI)
library(bigrquery)
library(ggplot2)
library(descr)
library(car)
library(readxl)
library(basedosdados)
library(gt)
library(dplyr)
library(webshot)
library(tidyr)

#autenticacao conta google bigquery

bq_auth(path = "C:/Users/nay_o/OneDrive/Documentos/R/"chave_json_do_google_biquery.json")

# criar conexão com o BigQuery basedosdados
con <- dbConnect(
  bigrquery::bigquery(),
  billing = "microdados-rais-stem-fields",
  project = "microdados-rais-stem-fields"
)

#buscar os dados em 'basedosdados'
sqlQuery <- "SELECT * FROM `microdados-rais-stem-fields.STEM_FIELDS_2009_2019.2009_2019_ajust`"
df.sim = dbGetQuery(con, sqlQuery)


# replace NA with "nao_stem"
df.analise <- df.sim %>%
  mutate(STEM= replace(STEM, is.na(STEM), "NAO_STEM"))


df.analise$sexo[df.analise$sexo == "1"] <-"Masculino"
df.analise$sexo[df.analise$sexo == "2"] <-"Feminino"

#arruma variavel faixa tempo emprego
df.analise$faixa_tempo_emprego[df.analise$faixa_tempo_emprego == 1] <-"Ate 2,9 meses"
df.analise$faixa_tempo_emprego[df.analise$faixa_tempo_emprego == 2] <-"3,0 a 5,9 meses"
df.analise$faixa_tempo_emprego[df.analise$faixa_tempo_emprego == 3] <-"6,0 a 11,9 meses"
df.analise$faixa_tempo_emprego[df.analise$faixa_tempo_emprego == 4] <-"12,0 a 23,9 meses"
df.analise$faixa_tempo_emprego[df.analise$faixa_tempo_emprego == 5] <-"24,0 a 35,9 meses"
df.analise$faixa_tempo_emprego[df.analise$faixa_tempo_emprego == 6] <-"36,0 a 59,9 meses"
df.analise$faixa_tempo_emprego[df.analise$faixa_tempo_emprego == 7] <-"60,0 a 119,9 meses"
df.analise$faixa_tempo_emprego[df.analise$faixa_tempo_emprego == 8] <-"120,0 meses ou mais"
df.analise$faixa_tempo_emprego[df.analise$faixa_tempo_emprego == "{ñ class}"] <-"{ñ class}"

#arruma variavel faixa horas contratadas
df.analise$faixa_horas_contratadas[df.analise$faixa_horas_contratadas == 01] <-"Até 12 horas"
df.analise$faixa_horas_contratadas[df.analise$faixa_horas_contratadas == 02] <-"13 a 15 horas"
df.analise$faixa_horas_contratadas[df.analise$faixa_horas_contratadas == 03] <-"16 a 20 horas"
df.analise$faixa_horas_contratadas[df.analise$faixa_horas_contratadas == 04] <-"21 a 30 horas"
df.analise$faixa_horas_contratadas[df.analise$faixa_horas_contratadas == 05] <-"31 a 40 horas"
df.analise$faixa_horas_contratadas[df.analise$faixa_horas_contratadas == 06] <-"41 a 44 horas"

#arruma variavel grau instrução
df.analise$grau_instrucao_apos_2005[df.analise$grau_instrucao_apos_2005 == 1] <-"ANALFABETO"
df.analise$grau_instrucao_apos_2005[df.analise$grau_instrucao_apos_2005 == 2] <-"ATE 5.A INC"
df.analise$grau_instrucao_apos_2005[df.analise$grau_instrucao_apos_2005 == 3] <-"5.A CO FUND"
df.analise$grau_instrucao_apos_2005[df.analise$grau_instrucao_apos_2005 == 4] <-"6. A 9. FUND"
df.analise$grau_instrucao_apos_2005[df.analise$grau_instrucao_apos_2005 == 5] <-"FUND COMPL"
df.analise$grau_instrucao_apos_2005[df.analise$grau_instrucao_apos_2005 == 6] <-"MEDIO INCOMP"
df.analise$grau_instrucao_apos_2005[df.analise$grau_instrucao_apos_2005 == 7] <-"MEDIO COMPL"
df.analise$grau_instrucao_apos_2005[df.analise$grau_instrucao_apos_2005 == 8] <-"SUP. INCOMP"
df.analise$grau_instrucao_apos_2005[df.analise$grau_instrucao_apos_2005 == 9] <-"SUP. COMP"
df.analise$grau_instrucao_apos_2005[df.analise$grau_instrucao_apos_2005 == 10] <-"MESTRADO"
df.analise$grau_instrucao_apos_2005[df.analise$grau_instrucao_apos_2005 == 11] <-"DOUTORADO"
df.analise$grau_instrucao_apos_2005[df.analise$grau_instrucao_apos_2005 == -1] <-"IGNORADO"

#arruma variavel raça   
df.analise$raca_cor[df.analise$raca_cor == 1] <-"INDIGENA"
df.analise$raca_cor[df.analise$raca_cor == 2] <-"BRANCA"
df.analise$raca_cor[df.analise$raca_cor == 4] <-"PRETA"
df.analise$raca_cor[df.analise$raca_cor == 6] <-"AMARELA"
df.analise$raca_cor[df.analise$raca_cor == 8] <-"PARDA"
df.analise$raca_cor[df.analise$raca_cor == 9] <-"NAO IDENT"
df.analise$raca_cor[df.analise$raca_cor == -1] <-"IGNORADO"

#arruma variavel TAM ESTAB (NUM EMP)
df.analise$tamanho_estabelecimento[df.analise$tamanho_estabelecimento == 1] <-"ZERO"
df.analise$tamanho_estabelecimento[df.analise$tamanho_estabelecimento == 2] <-"ATE 4"
df.analise$tamanho_estabelecimento[df.analise$tamanho_estabelecimento == 3] <-"DE 5 A 9"
df.analise$tamanho_estabelecimento[df.analise$tamanho_estabelecimento == 4] <-"DE 10 A 19"
df.analise$tamanho_estabelecimento[df.analise$tamanho_estabelecimento == 5] <-"DE 20 A 49"
df.analise$tamanho_estabelecimento[df.analise$tamanho_estabelecimento == 6] <-"DE 50 A 99"
df.analise$tamanho_estabelecimento[df.analise$tamanho_estabelecimento == 7] <-"DE 100 A 249"
df.analise$tamanho_estabelecimento[df.analise$tamanho_estabelecimento == 8] <-"DE 250 A 499"
df.analise$tamanho_estabelecimento[df.analise$tamanho_estabelecimento == 9] <-"DE 500 A 999"
df.analise$tamanho_estabelecimento[df.analise$tamanho_estabelecimento == 10] <-"1000 OU MAIS"
df.analise$tamanho_estabelecimento[df.analise$tamanho_estabelecimento == -1] <-"IGNORADO"

#arruma variavel TIPO VINCULO (NUM EMP)
df.analise$tipo_vinculo[df.analise$tipo_vinculo == 10] <-"CLT U/PJ IND"
df.analise$tipo_vinculo[df.analise$tipo_vinculo == 15] <-"CLT U/PF IND"
df.analise$tipo_vinculo[df.analise$tipo_vinculo == 20] <-"CLT R/PJ IND"
df.analise$tipo_vinculo[df.analise$tipo_vinculo == 25] <-"CLT R/PF IND"
df.analise$tipo_vinculo[df.analise$tipo_vinculo == 30] <-"ESTATUTARIO"
df.analise$tipo_vinculo[df.analise$tipo_vinculo == 31] <-"ESTAT RGPS"
df.analise$tipo_vinculo[df.analise$tipo_vinculo == 35] <-"ESTAT N/EFET"
df.analise$tipo_vinculo[df.analise$tipo_vinculo == 40] <-"AVULSO"
df.analise$tipo_vinculo[df.analise$tipo_vinculo == 50] <-"TEMPORARIO"
df.analise$tipo_vinculo[df.analise$tipo_vinculo == 55] <-"APREND CONTR"
df.analise$tipo_vinculo[df.analise$tipo_vinculo == 60] <-"CLT U/PJ DET"
df.analise$tipo_vinculo[df.analise$tipo_vinculo == 65] <-"CLT U/PF DET"
df.analise$tipo_vinculo[df.analise$tipo_vinculo == 70] <-"CLT R/PJ DET"
df.analise$tipo_vinculo[df.analise$tipo_vinculo == 75] <-"CLT R/PF DET"
df.analise$tipo_vinculo[df.analise$tipo_vinculo == 80] <-"DIRETOR"
df.analise$tipo_vinculo[df.analise$tipo_vinculo == 90] <-"CONT PRZ DET"
df.analise$tipo_vinculo[df.analise$tipo_vinculo == 95] <-"CONT TMP DET"
df.analise$tipo_vinculo[df.analise$tipo_vinculo == 96] <-"CONT LEI EST"
df.analise$tipo_vinculo[df.analise$tipo_vinculo == 97] <-"CONT LEI MUN"
df.analise$tipo_vinculo[df.analise$tipo_vinculo == -1] <-"IGNORADO"

##Quantidade de stem workers pr - proporção?

empregos_stem <- df.analise %>%
  group_by(ano, sigla_uf, STEM, sexo) %>%
  summarize("Remuneração" = mean(valor_remuneracao_media_sm)) %>%
  arrange(Remuneração, desc("Remuneração"))

wTITULO_gen <- df.analise %>%
  filter(STEM == "STEM") %>%
  count(ano, sigla_uf, cbo_2002, sexo) %>%
  rename("Número" = n) %>%
  arrange("Número", desc("Número"))

write.csv(wTITULO_gen, file = "wTITULO_gen.csv")

cabecalho <- df.analise %>%
  filter(cbo_ajust == "a")
write.csv(cabecalho, file = "cabecalho.csv")

cabecalho <- df.analise %>%
  filter(cbo_ajust == "a")
write.csv(cabecalho, file = "cabecalho.csv")

usethis::use_git()
usethis::use_github()
usethis::use_git_remote("origin", url = NULL, overwrite = TRUE)

