TAMANHO_MEDIO = 4
TAMANHO_PEQUENO = 2
MEDIA = 16

matriz_A = [[11,5,7,2],
            [-1,5,7,-4],
            [3,4,4,4],
            [4,7,-6,2]]

matriz_B = [[5,4,8,9],
            [-2,-10,4,9],
            [5,0,5,0],
            [1,1,-1,1]]

matriz_C = [[4,4,5,5],
            [-3,4,1,0],
            [1,-3,9,2],
            [-5,-5,-5,5]]

matriz_D = [[-3,3,3,12],
            [-2,-7,-3,-2],
            [14,-12,13,3],
            [-5,5,5,5]]

matriz_b = [[1,-1],[1,-1]]
matriz_m = [[0,0], [0,0]]
resultado = [[0,0], [0,0]]


def media_matriz(matriz):
    media = 0

    for row in range(0, TAMANHO_MEDIO):
        for col in range(0, TAMANHO_MEDIO):
            media += matriz[row][col]

    return media / MEDIA

def multiplicacao_matriz(matrizA, matrizB):
    resultado[0][0] = (matrizA[0][0] * matrizB[0][0]) + (matrizA[0][1] * matrizB[1][0]) 
    resultado[0][1] = (matrizA[0][0] * matrizB[0][1]) + (matrizA[0][1] * matrizB[1][1]) 
    resultado[1][0] = (matrizA[1][0] * matrizB[0][0]) + (matrizA[1][1] * matrizB[1][0]) 
    resultado[1][1] = (matrizA[1][0] * matrizB[0][1]) + (matrizA[1][1] * matrizB[1][1]) 

    return resultado


matriz_m[0][0] = media_matriz(matriz_A)
matriz_m[0][1] = media_matriz(matriz_B)
matriz_m[1][0] = media_matriz(matriz_C)
matriz_m[1][1] = media_matriz(matriz_D)
print("Matriz M: ")
print(matriz_m)
print("\nMatriz Final:")
resultado = multiplicacao_matriz(matriz_m, matriz_b)
print(resultado)


