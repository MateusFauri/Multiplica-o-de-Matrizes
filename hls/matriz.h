#ifndef __MATRIZ_H__
#define __MATRIZ_H__

#include <cmath>
using namespace std;

#define MAT_A_ROWS 8
#define MAT_A_COLS 8
#define MAT_M_ROWS 2
#define MAT_M_COLS 2
#define QUANTIDADE 16
#define SEPARADOR 4
#define FINAL 8

void matrixmul(
    unsigned char a[MAT_A_ROWS][MAT_A_COLS],          // 8 bits
    unsigned char b[MAT_M_ROWS][MAT_M_ROWS],          // 8 bits
    unsigned short res[MAT_M_ROWS][MAT_M_COLS]        // 16 bits
);    

#endif
