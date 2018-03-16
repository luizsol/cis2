# PSI-3451 Projeto de CI Lógicos Integrados
# Experimento 2

Esta segunda prática de VHDL pretende colocar o aluno em contato com mais algumas estruturas sintáticas da linguagem. As mesmas recomendações dadas na apostila da aula 2 permanecem e solicitamos que todos revisitem a parte inicial daquele texto. Tenha certeza que sabe responder as perguntas listadas abaixo após a observação dos arquivos ou dos resultados de simulações.

## PARTE PRÁTICA

São fornecidos 6 arquivos VHDL. A partir destes serão gerados outros modelos através de pequenas modificações nos respectivos códigos VHDL. No total serão realizadas 12 simulações com o objetivo de exercitar alguns conceitos da linguagem VHDL.

A seguir vamos descrever cada um dos modelos fornecidos e os conceitos de VHDL que podem ser observados em cada uma das simulações.

Em cada experimento, o respectivo arquivo VHDL será submetido à seguinte sequência de tarefas: **captura-compilação-simulação**.

O procedimento para **capturar**, **compilar** e **simular** cada arquivo VHDL é o mesmo utilizado na Aula 2.

Utilize [o roteiro disponibilizado no site](https://edisciplinas.usp.br/pluginfile.php/4251725/mod_resource/content/1/roteiro%20geral%20para%20uso%20modelsim.pdf) para facilitar a sua tarefa.

### Preparação das Pastas e Arquivos para Simulação

* Ligar o computador e entrar no ambiente *Windows*.
* Utilizando o *Windows Explorer* acesse a sua área de trabalho na unidade de rede `X`.
* Na sua área de trabalho crie uma pasta `X:\psi3451\aula_3` para armazenar os resultados desta prática. Ainda com o Windows Explorer, selecione *Rede* => *NEWSERVERLAB* => *psi3451* => *aula_3* e copie todos os seis arquivos deste diretório.

Como serão realizadas11 simulações, recomendamos que sejam criadas pastas separadas para cada uma das simulações com o objetivo de salvar adequadamente os resultados. Siga as instruções nas respectivas seções.

* Transfira cada um dos 6 arquivos VHDL, copiados do serverlab para as 6 pastas correspondentes:
```
X:\psi3451\aula_3\fa_3 (full_adder_3.vhd)
X:\psi3451\aula_3\fa_4 (full_adder_4.vhd)
X:\psi3451\aula_3\sc_1 (setp_counter_1.vhd)
X:\psi3451\aula_3\rb_1 (reg_bank_simplificado_1.vhd)
X:\psi3451\aula_3\ rb_2 (reg_bank_simplificado_2.vhd)
X:\psi3451\aula_3\ rb_3 (reg_bank_simplificado_3.vhd)
```

### 1) Captura e simulação do somador completo full_adder_3 no modelo comportamental, com processo
* Abra o arquivo full_adder_3.vhd para a pasta X:\psi3451\aula_3\fa_3. Ele está codificado no modelo VHDL comportamental (behavioral). Estude o código. Conceitos VHDL deste modelo:
    * comando process (sintaxe)
    * lista de sensibilidade indicada pelos sinais que aparecem entre parênteses ao lado do comando process
* Repita o procedimento de captura, compilação e simulação conforme descrito no item 1 acima

***Recomendação***: realize a simulação com várias combinações de valores de entrada (do comando `force`). Guarde os resultados do Wave para comparação na seção seguinte

**Pergunta**: como é o novo comportamento do circuito comparado aos `fa_1` e `fa_2` da Aula 2 (anterior)? Há equivalência entre os modelos?

> Resposta: o comportamento é idêntico ao do circuito `fa_2` tanto em resultado como em atrasos:
> fa_3:
> ![Resultado da simulação de fa_3](img/fa_3_wave.bmp)
> fa_2:
> ![Resultado da simulação de fa_3](../exp01/docs/img/img3.png)
