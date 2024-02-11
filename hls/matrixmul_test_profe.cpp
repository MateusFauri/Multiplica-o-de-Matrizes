#include <iostream>
#include "matriz.h"

int main(int argc, char **argv)
{
   unsigned char in_mat_a[8][8] = {
      {1,2,3,4,5,5,5,5},
      {-1,-2,-3,-4,-5,-6,-7,-8},
      {1,2,3,4,5,5,5,5},
      {-1,-2,-3,-4,-5,-6,-7,-8},
      {1,2,3,4,5,6,7,8},
      {-2,-2,-2,-2,-2,-2,-2,-2},
      {1,2,3,4,5,6,7,8}
   };
   unsigned char in_mat_b[2][2] = {
	   {1,-1},
	   {-1,1}
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
	  for (int j = 0; j < MAT_B_COLS; j++) {
		 cout << hw_result[i][j] << " ";
	  }
	}
	cout << "\n" << endl;

}
