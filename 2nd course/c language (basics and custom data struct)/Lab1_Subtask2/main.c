#include<stdio.h>
#include<stdlib.h>
//----------------------------------------------------------------------------
#pragma hdrstop
#pragma argsused
//----------------------------------------------------------------------------
  // Lab 1;
  // Subtask 2;
  // Variant 5;
  // Task: Input three integer number three.
  // Determine the number of preceding each of the input numbers and 
  // the amount received by the numbers.
//----------------------------------------------------------------------------
int main(int argc, char* argv[]) {
  int x,y,z;
  printf("Inter 1st number:");
  scanf("%d",&x);
  printf("Inter 2nd number:");
  scanf("%d",&y);
  printf("Inter 3rd number:");
  scanf("%d",&z);
  //--------------------------------------------------------------------------
  printf("\n %d - 1 = %d",x,x-1);    
  printf("\n %d - 1 = %d",y,y-1);
  printf("\n %d - 1 = %d",z,z-1);

  printf("\n %d + %d + %d = %d\n",x-1,y-1,z-1,((x-1)+(y-1)+(z-1)));    
  system("pause");
  return 0;
}

