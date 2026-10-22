# Aula 10 — Desafio Ripes
# Dupla: Juan Riquelme  /  Victor Carraly
#
# Objetivo: traduzir o laço abaixo para Assembly RISC-V e observar,
# ciclo a ciclo, o pipeline enchendo, parando (bolha) e sendo descartado.
#
# Equivalente em C:
#   soma = 0;
#   for (i = 0; i < 8; i++)
#       if (v[i] >= 128) soma += v[i];
#
# Ao final, x13 deve conter a soma. Calcule à mão quanto deveria dar: 733

.data
v:  .word 200, 13, 150, 7, 255, 90, 128, 3

.text
main:
    la   x10, v            # x10 = &v[0]   (endereço do primeiro elemento)
    li   x11, 8            # x11 = N
    li   x12, 0            # x12 = i
    li   x13, 0            # x13 = soma
    li   x14, 128          # x14 = LIMIAR

laco:
    lw   x5, 0(x10)        # TODO 1: carregue v[i] em x5
    blt  x5, x14, pula     # TODO 2: se x5 < x14, pule para 'pula'
    add  x13, x13, x5      # TODO 3: soma += v[i]
pula:
    addi x10, x10, 4       # TODO 4: avance x10 para o próximo elemento (4 bytes)
    addi x12, x12, 1       # TODO 5: i++
    blt  x12, x11, laco    # TODO 6: volte para 'laco' enquanto i < N

fim:
    li   a7, 10            # ecall 10 = encerra o programa no Ripes
    ecall
