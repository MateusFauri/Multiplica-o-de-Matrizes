#include "matriz.h"

void matrixmul(
      unsigned char  a[MAT_A_ROWS][MAT_A_COLS],
      unsigned char  b[MAT_M_ROWS][MAT_M_ROWS],
      unsigned short res[MAT_M_ROWS][MAT_M_COLS])
{
	unsigned char m[MAT_M_ROWS][MAT_M_COLS] = {{0,0}, {0,0}};

    // linha 0 até 3 e coluna 0 até 3 - Primeiro Quadrante
    fisrtMatRow: for (int row=0; row < SEPARADOR; row++){
    	fisrtMatCol: for(int col=0; col < SEPARADOR; col++){
            m[0][0] += a[row][col];
        }
    }
    m[0][0] /= QUANTIDADE;

    // linha 0 até 3 e coluna 4 até 7 - Segundo Quadrante
    secondMatRow: for (int row=0; row < SEPARADOR; row++){
    	secondMatCol: for(int col=SEPARADOR; col < FINAL; col++){
                m[0][1] += a[row][col];
        }
    }
    m[0][1] /= QUANTIDADE;

    // linha 4 até 7 e coluna 0 até 3 - Terceiro Quadrante
    thirdtMatRow: for (int row=SEPARADOR; row < FINAL; row++){
    	thirdtMatCol: for(int col=0; col < SEPARADOR; col++){
                m[1][0] += a[row][col];
        }
    }
    m[1][0] /= QUANTIDADE;

    // linha 4 até 7 e coluna 4 até 7 - Quarto Quadrante
    fourthMatRow: for (int row=SEPARADOR; row < FINAL; row++){
    	fourthMatCol: for(int col=SEPARADOR; col < FINAL; col++){
                m[1][1] += a[row][col];
        }
    }
    m[1][1] /= QUANTIDADE;


    Row: for(int row = 0; row < MAT_M_ROWS; row++) {
      Col: for(int col = 0; col < MAT_M_ROWS; col++) {
         res[row][col] = 0;
         Product: for(int k = 0; k < MAT_M_ROWS; k++) {
            res[row][col] += m[row][k] * b[k][col];
         }
      }
    }

}
