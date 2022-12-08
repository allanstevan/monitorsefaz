#!/bin/bash
#
# Script para obter status das SEFAZ de cada UF para monitorar no 24x7.
# O script faz um parse da pagina da receita e gera um output individualizado por estado.
# Por Allan Oliveira - 01262022 - allan.stevan@jcatlm.com.br
#
## Funcao para gerar o HTM comparando o numero de bolas com bolas verdes
##
gera_htm () {
if cmp -s $1.tmp $1.tmn; then
    echo "OK" > $1.htm
else
    echo "ERRO" > $1.htm
fi
}
## Funcao abaixo deve ser descomentada apenas se for desejado escrever os resultados dos testes do monitor em um banco de dados (Postgre no caso abaixo)
#escreve_banco() {
#echo `date +"%Y-%m-%d %H:%M:%S"` > data.tmp
#cat $1.htm > pooling_result.tmp
#echo $1`date +"%Y%m%d%H%M%S%s"` > test_id.tmp
#echo $1 > state.tmp
#export PGPASSWORD=`cat /home/centos/cred`; psql -h 'localhost' -U 'postgres' -d 'sefaz' -c "INSERT INTO monitor (test_id, pooling_result, estado, pooled_on) VALUES ('`cat test_id.tmp`','`cat pooling_result.tmp`','`cat state.tmp`','`cat data.tmp`')";
#}
##
##
# Faz o retrieve da pagina da receita e grava em um arquivo
### URL MUDOU EM 14/04/2021 wget https://www.nfe.fazenda.gov.br/portal/disponibilidade.aspx\?versao\=0.00\&tipoConteudo\=P2c98tUpxrI\=\&AspxAutoDetectCookieSupport\=0 -O sefaz_br_output.tmp
wget "https://www.nfe.fazenda.gov.br/portal/disponibilidade.aspx?versao=0.00&tipoConteudo=P2c98tUpxrI=" -O sefaz_br_output.tmp
# Filtra apenas a tabela com as bolas
grep -A 33 tabelaListagemDados sefaz_br_output.tmp > tablog_
# Conta as bolas VERDES por estado e armazena em arquivo temporario
cat array | while read estado; do echo $estado > $estado.tmp; grep $estado tablog_ | grep -o verde | wc -l >> $estado.tmp;done
# Conta as BOLAS por estado e armazena em arquivo temporario (qualquer cor, para comparar depois com as bolas verdes ;-) )
cat array | while read nstado; do echo $nstado > $nstado.tmn; grep $nstado tablog_ | grep -o bola | wc -l >> $nstado.tmn;done
# Chama a funcao do comeco do script para fazer a comparacao Total bolas estado X Total bolas verdes estado e gravar OK ou ERRO no arquivo
cat array | while read zstado; do gera_htm $zstado;done
## Linha abaixo deve ser descomentada apenas se for desejado escrever os resultados dos testes do monitor em um banco de dados (Postgre no caso abaixo)
#cat array | while read abestado; do escreve_banco $abestado;done
# Apaga arquivos temporarios
rm *.tmp
rm *.tmn
rm tablog_
# Exit gracefully :-)
exit 0