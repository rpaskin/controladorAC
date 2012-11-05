Sistema de Ar-Condicionado
==========================

A ACME ltda. esta produzindo um novo ar-condicionado totalmente
digital. Eles contrataram voce pra fazer o algoritmo que refrigera o
ambiente.

A funca que voce precisa implementar devera ter o seguinte modelo:

refrigera(temp_atual, temp_desejada, ...)

As ... sao parametros adicionais. Voce pode solicitar parametros
extras como configuracoes, por exemplo.

O hardware do ar-condicionado possui uma funca que voce pode chamar que e':

reduz_um_grau()

Esta funcao reduz exatamente um grau na temperatura do ambiente (doh).
E MUITO IMPORTANTE LEMBRAR QUE CADA CHAMADA DESTA FUNCAO CUSTA O
EQUIVALENTE A R$ 0,10 para o cliente em energia. Alem disso, cada vez
que o ar liga (a primeira vez que esta funcao e'chamada na sua funcao)
o cliente paga R$ 0,50. Este e' o custo de ligar o compressor.

A temperatura do ambiente retorna gradualmente pra cima.

A sua funcao deve ainda retornar uma tupla com a temperatura final e o
custo da reducao de temperatura.

A ACME solicitou que voce implemente a funcao MAIS EFICIENTE POSSIVEL
que mantenha o quarto refrigerado conforme o cliente solicitar. Os
argumentos temp_atual e temp_desejada serao passados pra voce pelo
ar-condicionado.

Para testar a sua funcao escreva um programa que escreva na tela o
custo total do ar-condicionado rodando durante 360 minutos, sendo que
a cada minuto a temperatura do ambiente sobe 0,5 grau C. A temperatura
inicial e' de 30 graus C e a temperatura desejada e' de 20 graus C.

Considere para este problema que os seres humanos nao conseguem diferenciar temperaturas para cima ou para baixo ate 2 graus.


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