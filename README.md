# monitorsefaz
Monitor SEFAZ

O script basicamente faz o retrieve da página de status da Receita, filtra a tabela com as "bolas" de status, conta as "bolas" verdes por estado (que é o status OK).

Posteriormente ele conta as "bolas" por Estado e chama a função *gera_htm* declarada no começo do script para fazer a comparação total de "bolas" por Estado *versus* o total de "bolas" verdes por Estado. A lógica da função é que o total de "bolas" verdes precisa ser igual ao total de "bolas". 

Caso não seja, é indicativo que algum Estado não esteja com o status *verde*.

Para as comparações são usados arquivos temporários no mesmo diretório do script.

# Execução:
./monitor.sh

# Recomendações para instalação

Posicionar o script em uma pasta que o mesmo tenha direitos de leitura para que o mesmo possa criar e remover os arquivos temporários.
O servidor precisa ter acesso liberado ao site da receita (nfe.fazenda.gov.br).
Instalar uma crontab para que o processo seja feito de forma automática de 1 em 1 minuto (ou de acordo com a necessidade, basta editar a entrada do crontab):


* * * * *  cd /var/www/html/sefaz/;sh monitor.sh
