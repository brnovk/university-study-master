#include<stdio.h>
#include<stdlib.h>
//----------------------------------------------------------------------------
#pragma hdrstop
#pragma argsused
//----------------------------------------------------------------------------
  // Lab 1;
  // Subtask 4;
  // Variant 5;
  // Task: Enter two integers a, b.
  // Find the number x, corresponding to the whole of division a on b.
  // Determine the character whose serial number is found x.
//----------------------------------------------------------------------------
int main(int argc, char* argv[]) {
  int a,b;
  printf("Inter 1st number:");
  scanf("%d",&a);      
  printf("Inter 2nd number:");
  scanf("%d",&b);
  //--------------------------------------------------------------------------
  printf("(%d / %d):\n",a,b);
  printf("Result(integer part): %d;\n",a/b);
  printf("Result(symbol): %c;\n\n",(char)(a/b));
  system("pause");
  //--------------------------------------------------------------------------
  return 0;
}
