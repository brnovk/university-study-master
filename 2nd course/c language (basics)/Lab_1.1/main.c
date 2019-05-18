#include<stdio.h>
#include<conio.h>
#include<math.h>
//---------------------------------------------------------------------------
#pragma hdrstop
#pragma argsused
//---------------------------------------------------------------------------
  // Lab 1.1;
  // Variant 5;
  // Task: Calculate the value of the function f (x) for the entered value 
  // of the argument; 
  // The calculation functions are implemented using the if statement;
  // Use the functions of the library stdio.h, conio.h, math.h.
//----------------------------------------------------------------------------
  // For |x|<2:  f=(pow((x-1),2)+x)/(2+x);
  // For |x|>2:  f=(pow((x+1),3)+2*x)/(sqrt(pow(3x-2,2)+1));
  // For |x|=2:  f=abs(pow(x,2)+3)+15;
//----------------------------------------------------------------------------
int main(int argc, char* argv[]) {
	int x, f;
	clrscr();
	printf("Enter X: ");
	scanf("%d",&x);
//----------------------------------------------------------------------------
	if (abs(x)<2) {
		printf("\nSince |%d|<2, compute function by formula 1;\n",x);
		f=(pow((x-1),2)+x)/(2+x);
	}
//----------------------------------------------------------------------------
	if (abs(x)==2) {
		printf("\nSince |%d|=2, compute function by formula 3;\n",x);
		f=abs(pow(x,2)+3)+15;
	}
//----------------------------------------------------------------------------
	if (abs(x)>2) {
		printf("\nSince |%d|>2, compute function by formula 2;\n",x);
		f=(pow((x+1),3)+2*x)/(sqrt(pow((3*x-2),2)+1));
	}
//----------------------------------------------------------------------------
	printf("\nFunction result: %d\n",f);
	printf("Press any key to exit...");
	getch();
	return 0;
}

