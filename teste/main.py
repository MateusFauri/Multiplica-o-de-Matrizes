TAMANHO_MEDIO 4
TAMANHO_PEQUENO 2
MEDIA 16

matriz_A = [[1,2,3,4], 
            [-1,-2,-3,-4], 
            [1,2,3,4],
            [-1,-2,-3,-4]]

matriz_B = [[5,5,5,5],
            [-5,-6,-7,-8],
            [5,5,5,5],
            [-5,-6,-7,-8]]

matriz_C = [[1,2,3,4],
            [-2,-2,-2,-2],
            [1,2,3,4],
            [-2,-2,-2,-2]]

matriz_D = [[5,6,7,8],
            [-2,-2,-2,-2],
            [5,6,7,8],
            [-2,-2,-2,-2]]

matriz_b = [[1,-1], [1,-1]]
matriz_m = [[0,0], [0,0]]
resultado = [[0,0], [0,0]]


def media_matriz(matriz[TAMANHO_MEDIO][TAMANHO_MEDIO]):
    media = 0

    for row in range(0, TAMANHO_MEDIO):
        for col in range(0, TAMANHO_MEDIO):
            media += matriz[row][col]

    return media / MEDIA

def multiplicacao_matriz(matrizA, matrizB):
    for row in range(0, TAMANHO_PEQUENO):
        for col in range(0, TAMANHO_PEQUENO):
            for num in range(0, TAMANHO_PEQUENO):
                resultado[row][col] += matrizA[row][num] * matrizB[num][col]

    return resultado


matriz_m[0][0] = media_matriz(matriz_A)
matriz_m[0][1] = media_matriz(matriz_B)
matriz_m[1][0] = media_matriz(matriz_C)
matriz_m[1][1] = media_matriz(matriz_D)

resultado = multiplicacao_matriz(matriz)
print()

