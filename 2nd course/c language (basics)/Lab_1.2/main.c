#include<stdio.h>
#include<conio.h>
#include<math.h>
//---------------------------------------------------------------------------
#pragma hdrstop
#pragma argsused
//---------------------------------------------------------------------------
  // Lab 1.2;
  // Variant 5;
  // Task: Display up to five decimal points table of 
  // the function f (x) for n + 1, the value of x in the interval [a, b]. 
  // In the program to check the correctness of input data. 
  // Calculation functions programmed using the if statement. 
  // Use a float data and input-output control function of <conio.h> library.
  // You need to use a for loop.
//----------------------------------------------------------------------------
  // For (x*y)<0:  f=((4*a)-y+1)/(pow(y,2)+1);
  // For (x*y)=0:  f=3+pow(a,2)+pow(y,2);
  // For (x*y)>0:  f=(x-y)/(1+pow(y,2)+pow(a,2));
//----------------------------------------------------------------------------
int main(int argc, char* argv[]) {
  float x, y, a, b, f;
  int f1=0,f2=0,f3=0,f4=0,n,i;
  clrscr();
  printf("Enter the first argument of the function: ");
  f1=scanf("%f",&y);
  printf("\nEnter the lower limit of the 2nd argument of the function: ");
  f2=scanf("%f",&a);
  printf("\nEnter the upper limit of the 2nd argument of the function: ");
  f3=scanf("%f",&b);
  printf("\nEnter the number of values of the 2nd argument of the function: ");
  f4=scanf("%d",&n);
  if ((f1!=1)&&(f2!=1)&&(f3!=1)&&(f4!=1)) {
    printf("\nIncorrect source data...\n");
    printf("The program will be completed!");
    getch();
    return 0;
  }
//----------------------------------------------------------------------------
  x=(b-a)/n;
  for (i=0;i<=n;i++) {
    if ((a*y)<0) {
      f=((4*a)-y+1)/(pow(y,2)+1);
      printf("\n--(%1.1f*%1.1f)<0 (Formula 1);\n"
        "  Result: %1.5f",a,y,f);
    }
    if ((a*y)==0) {
      f=3+pow(a,2)+pow(y,2);
      printf("\n--(%1.1f*%1.1f)=0 (Formula 2);\n"
        "  Result: %1.5f",a,y,f);
    }
    if ((x*y)>0) {
      f=(x-y)/(1+pow(y,2)+pow(a,2));
      printf("\n--(%1.1f*%1.1f)>0 (Formula 3);\n"
        "  Result: %1.5f",x,y,f);
    }
    a+=x;
  }
//----------------------------------------------------------------------------
  printf("\n\nPress any key to exit...");
  getch();
  return 0;
}

