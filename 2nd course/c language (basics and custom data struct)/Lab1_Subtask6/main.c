#include<stdio.h>
#include<stdlib.h>
//----------------------------------------------------------------------------
#pragma hdrstop
#pragma argsused
//----------------------------------------------------------------------------
  // Lab 1;
  // Subtask 6;
  // Variant 5;
  // Task: Enter any lowercase character from the keyboard.
  // Print its sequence and the corresponding uppercase character. 
//----------------------------------------------------------------------------
int main(int argc, char* argv[]) {
  char x;
  int ch;
  do {
    system("cls");
    printf("Enter a lowercase symbol:");
    scanf("%c",&x);
    ch=(int)x;
  } while (ch<96||ch>123);
  printf("Key symbol(%c): %d\n",x,ch);
  x=ch-32;
  ch-=32;
  printf("Key symbol(%c): %d\n",x,ch);
  //--------------------------------------------------------------------------
  system("pause");
  return 0;
}
