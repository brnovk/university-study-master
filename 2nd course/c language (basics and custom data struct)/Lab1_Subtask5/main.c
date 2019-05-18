#include<stdio.h>
#include<stdlib.h>
//----------------------------------------------------------------------------
#pragma hdrstop
#pragma argsused
//----------------------------------------------------------------------------
  // Lab 1;
  // Subtask 5;
  // Variant 5;
  // Task: Determine the number obtained by writing out in the reverse order 
  // of numbers given three-digit number.
//----------------------------------------------------------------------------
int main(int argc, char* argv[]) {
  int a,b=0;
  printf("Inter number:");
  scanf("%d",&a);      
  //--------------------------------------------------------------------------
  while (a) {
    b=b*10+a%10;
    a/=10;
  }
  //--------------------------------------------------------------------------
  printf("Result: %d;\n\n",b);
  system("pause");
  return 0;
}
