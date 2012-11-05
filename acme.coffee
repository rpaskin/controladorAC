#!/usr/bin/env coffee

#Sistema de Ar-Condicionado
#
#A ACME ltda. est� produzindo um novo ar-condicionado totalmente digital. Eles
#contrataram voc� pra fazer o algoritmo que refrigera o ambiente.
#
#A fun��o que voc� precisa implementar dever� ter o seguinte modelo:
#
#refrigera(temp_atual, temp_desejada, ...)
#
#As ... s�o parametros adicionais. Voc� pode solicitar par�metros extras como
#configura��es, por exemplo.
#
#O hardware do ar-condicionado possui uma fun��o que voc� pode chamar que �:
#
#reduz_um_grau()
#
#Esta fun��o reduz exatamente um grau na temperatura do ambiente (doh). � MUITO
#IMPORTANTE LEMBRAR QUE CADA CHAMADA DESTA FUN��O CUSTA O EQUIVALENTE A R$ 0,10
#para o cliente em energia. Al�m disso, cada vez que o ar liga (a primeira vez
#que esta fun��o � chamada na sua fun��o) o cliente paga R$ 0,50. Este � o custo
#de ligar o compressor.
#
#A temperatura do ambiente retorna gradualmente pra cima.
#
#A sua fun��o deve ainda retornar uma tupla com a temperatura final e o custo da
#redu��o de temperatura.
#
#A ACME solicitou que voc� implemente a fun��o MAIS EFICIENTE POSS�VEL que
#mantenha o quarto refrigerado conforme o cliente solicitar. Os argumentos
#temp_atual e temp_desejada ser�o passados pra voc� pelo ar-condicionado.
#
#Para testar a sua fun��o escreva um programa que escreva na tela o custo total
#do ar-condicionado rodando durante 360 minutos, sendo que a cada minuto a
#temperatura do ambiente sobe 0,5 grau C. A temperatura inicial � de 30 graus C e
#a temperatura desejada � de 20 graus C.
#
#Considere para este problema que os seres humanos n�o conseguem diferenciar
#temperaturas para cima ou para baixo at� 2 graus.

# custos em centavos
custos = {
  ligarCompressor: 50,
  reduzirGrau: 10,
}

# parametros para teste
teste = {
  tempo: 360, # minutos
  mudanca: 0.5, # +0.5 graus por min
  tempInicial: 30,
  tempDesejada: 20,
}

# objeto com o estado atual
estado = {
  temp: teste.tempInicial,
  custo: 0,
  compressorLigado: false,
  reducaoEmProgresso: false # apenas seria utilizado em modo assincrono, ver abaixo
}

#estado = [teste.tempInicial, 0, false] # estado inicial: temperatura, custo, compressor ligado

verbose = false;

process.argv.forEach (val, index, array) ->
  if val is "verbose" then verbose = true

printMsg = (msg) -> if verbose then console.log msg


# Mudanca natural da temperatura e' teste.mudanca graus por minuto
mudarTemp = ->
  estado.temp += teste.mudanca

compressorLigado = -> estado.compressorLigado

ligarCompressor = ->
  if not compressorLigado()
    estado.compressorLigado = true
    estado.custo += custos.ligarCompressor
    printMsg "(compressor ligado @ #{seg} seg/ #{estado.temp} Celsius)"

desligarCompressor = ->
  #if compressorLigado() # desnecessario pq o custo de desligar e' 0
  estado.compressorLigado = false
  printMsg "(compressor desligado @ #{seg} seg/ #{estado.temp} Celsius)"

# Aqui consideramos que a reducao de um grau ocorre em exatamente um minuto. Na
# verdade, isso provavelmente poderia ocorrer mais rapido ou mais lento (ver o
# teste assincrono abaixo).
reduzUmGrau = ->
  estado.custo += custos.reduzirGrau
  # reduz_um_grau() # STUB para conectar ao ar condicionado
  estado.temp--

# NAO UTILIZADA:
# Aqui seria uma funcao lidando com uma reducao de grau assincrona.
# A funcao reduz_um_grau_assinc chamaria esse callback apenas quando o grau
# fosse realmente reduzido
reduzUmGrauAssinc = ->
  estado.reducaoEmProgresso = true
  reduz_um_grau_assinc ->
    estado.reducaoEmProgresso = false
    estado.custo += custos.reduzirGrau
    estado.temp--


# FUNCAO PRINCIPAL =============================================================
refrigera = (tempAtual, tempDesejada) ->
  # Reduzir a temperatura se:
  # Note que ja que assumimos que seres humanos n�o conseguem diferenciar
  # temperaturas para cima ou para baixo at� 2 graus; usamos isso para otimizar o
  # algoritmo; Se o compressor ja esta ligado, o mantemos um pouco ligado e
  # esfriamos um pouco mais; Se o compressor esta desligado, esperamos um pouco
  # alem da temperatura desejada antes de liga-lo.

  erroPermitido = 2

  if (!compressorLigado() and tempAtual > tempDesejada+erroPermitido) or  # estamos com o compressor desligado e a temperatura alta ja pode ser sentida (maxima mais 2 graus)
     (compressorLigado() and tempAtual > tempDesejada-erroPermitido)      # ou estamos com o compressor ja ligado e a temperatura ainda nao esta 2 graus abaixo da desejada

    ligarCompressor()
    tempAtual = reduzUmGrau()

  desligarCompressor() if (tempAtual <= tempDesejada-erroPermitido)
  return estado


# TESTE ========================================================================
# Executar um loop de teste.tempo 'segundos', refrigerando o ambiente segundo os
# parametros acima
seg = 0
for seg in [1..teste.tempo]
  refrigera estado.temp, teste.tempDesejada
  mudarTemp teste.mudanca

desligarCompressor()  # nao necessario, mas aqui para completude do teste

console.log "Resultado: #{seg}seg  #{estado.temp} graus Celsius, custo R$#{(estado.custo/100).toFixed(2)}\n"
