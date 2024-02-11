#include <iostream>
#include "matriz.h"

int main(int argc, char **argv)
{
   unsigned char in_mat_a[8][8] = {
      {7,7,7,7,7,7,7,7},
      {7,7,7,7,7,7,7,7},
      {7,7,7,7,7,7,7,7},
      {7,7,7,7,7,7,7,7},
      {7,7,7,7,7,7,7,7},
      {7,7,7,7,7,7,7,7},
      {7,7,7,7,7,7,7,7},
      {7,7,7,7,7,7,7,7}
   };
   unsigned char in_mat_b[2][2] = {
	   {13,13},
	   {13,13}
   };
   unsigned char in_mat_m[2][2] = {
	   {0,0},
	   {0,0}
   };

   unsigned char mat_error[8][8] = {
	   {0,0,0,0,0,0,0,0},
	   {0,0,0,0,0,0,0,0},
	   {0,0,0,0,0,0,0,0},
	   {0,0,0,0,0,0,0,0},
	   {0,0,0,0,0,0,0,0},
	   {0,0,0,0,0,0,0,0},
	   {0,0,0,0,0,0,0,0},
	   {0,0,0,0,0,0,0,0}
  };


   unsigned short hw_result[2][2];
   matrixmul(in_mat_a,in_mat_b,in_mat_m, hw_result);


   cout << "Matrix results:" << endl;
	for (int i = 0; i < MAT_A_ROWS; i++) {
	  cout << "\n" << endl;
	  for (int j = 0; j < MAT_M_COLS; j++) {
		 cout << hw_result[i][j] << " ";
	  }
	}
	cout << "\n" << endl;

}
