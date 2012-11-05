Sistema de Ar-Condicionado
==========================

A ACME ltda. est� produzindo um novo ar-condicionado totalmente
digital. Eles contrataram voc� pra fazer o algoritmo que refrigera o
ambiente.

A fun��o que voc� precisa implementar dever� ter o seguinte modelo:

refrigera(temp_atual, temp_desejada, ...)

As ... s�o parametros adicionais. Voc� pode solicitar par�metros
extras como configura��es, por exemplo.

O hardware do ar-condicionado possui uma fun��o que voc� pode chamar que �:

reduz_um_grau()

Esta fun��o reduz exatamente um grau na temperatura do ambiente (doh).
� MUITO IMPORTANTE LEMBRAR QUE CADA CHAMADA DESTA FUN��O CUSTA O
EQUIVALENTE A R$ 0,10 para o cliente em energia. Al�m disso, cada vez
que o ar liga (a primeira vez que esta fun��o � chamada na sua fun��o)
o cliente paga R$ 0,50. Este � o custo de ligar o compressor.

A temperatura do ambiente retorna gradualmente pra cima.

A sua fun��o deve ainda retornar uma tupla com a temperatura final e o
custo da redu��o de temperatura.

A ACME solicitou que voc� implemente a fun��o MAIS EFICIENTE POSS�VEL
que mantenha o quarto refrigerado conforme o cliente solicitar. Os
argumentos temp_atual e temp_desejada ser�o passados pra voc� pelo
ar-condicionado.

Para testar a sua fun��o escreva um programa que escreva na tela o
custo total do ar-condicionado rodando durante 360 minutos, sendo que
a cada minuto a temperatura do ambiente sobe 0,5 grau C. A temperatura
inicial � de 30 graus C e a temperatura desejada � de 20 graus C.

Considere para este problema que os seres humanos n�o conseguem diferenciar temperaturas para cima ou para baixo at� 2 graus.


Para executar o Programa
========================

Requer node.js instalado e no seu path.

```
node acme.js
Resultado: 361seg  21 graus Celsius, custo R$28.90
```

Para maiores detalhes, usar o argumento "verbose"

```
node acme.js verbose
(compressor ligado @ 1 seg/ 30 Celsius)
(compressor desligado @ 25 seg/ 18 Celsius)
...
Resultado: 361seg  21 graus Celsius, custo R$28.90
```

Para mudar as configuracoes de teste, abra o arquivo acme.coffee e ajuste:

```
# parametros para teste
teste = {
  tempo: 360, # minutos
  mudanca: 0.5, # +0.5 graus por min
  tempInicial: 30,
  tempDesejada: 20,
}
```

Entao compile o arquivo novamente com:

```
coffee -o ./ ./acme.coffee
```

E execute novamente.

Alternativamente, o arquivo acme.js tambem pode ser modificado diretamente.