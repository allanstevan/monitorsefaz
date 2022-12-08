# Descrição
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

# Recomendações para monitoramento

A pasta do script deve ser uma pasta acessivel pelo servidor web para que seja acessada externamente, por exemplo, /var/www/html no caso do apache. O script pode ser mudado à gosto para que fique em outra pasta e mande os outputs (estado.htm, por exemplo SC.htm, SP.htm, etc) para a pasta "publicável" pelo webserver.

No sistema de monitoramento deve ser configurado para verificar a string OK ou ERRO no arquivo htm relacionado. Ex: http://servidordomonitor.com.br/monitorsefaz/RS.htm
