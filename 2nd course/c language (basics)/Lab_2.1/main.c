#include<stdio.h>
#include<conio.h>
#include<math.h>
//---------------------------------------------------------------------------
#pragma hdrstop
#pragma argsused
//---------------------------------------------------------------------------
// Lab 2.1;
// Variant 5;
// Task: Compose a program that computes the value of the function 'f(x)', 
// for values-based arguments. 
// Function evaluation is implemented using the operator 'if'.
// All variables must be pointers. Option from the task Lab 1.
//----------------------------------------------------------------------------
// For |x|<2:  f=(pow((x-1),2)+x)/(2+x);
// For |x|>2:  f=(pow((x+1),3)+2*x)/(sqrt(pow(3x-2,2)+1));
// For |x|=2:  f=abs(pow(x,2)+3)+15;
//----------------------------------------------------------------------------
int main(int argc, char* argv[]) {
  int x, f;
  int *px;                // Announcement of the pointer 'px';
  int *pf;                // Announcement of the pointer 'pf';
  px=&x;                  // Assign pointer 'px' address of the variable 'x';
                          // Next, the pointer will reference the 'x';
  pf=&f;                  // Similarly, index for 'pf' and the variable 'f';
  clrscr();
  printf("Enter X: ");
  scanf("%d",px);
  //----------------------------------------------------------------------------
  if (abs(*px)<2) {
    printf("\nSince |%d|<2, compute function by formula 1;\n",*px);
    *pf=(pow((*px-1),2)+*px)/(2+*px);
  }
  //----------------------------------------------------------------------------
  if (abs(*px)==2) {
    printf("\nSince |%d|=2, compute function by formula 3;\n",*px);
    *pf=abs(pow(*px,2)+3)+15;
  }
  //----------------------------------------------------------------------------
  if (abs(*px)>2) {
    printf("\nSince |%d|>2, compute function by formula 2;\n",*px);
    *pf=(pow((*px+1),3)+2*x)/(sqrt(pow((3**px-2),2)+1));
  }
  //----------------------------------------------------------------------------
  printf("\nFunction result: %d\n",*pf);
  printf("Press any key to exit...");
  getch();
  return 0;
}

