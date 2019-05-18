#include<stdio.h>
#include<conio.h>
#include<math.h>
//---------------------------------------------------------------------------
#pragma hdrstop
#pragma argsused
//---------------------------------------------------------------------------
  // Lab 0.1;
  // Variant 5;
  // Task: Calculate the value of the function 'f', using float. Program to
  // calculate values of at least three pairs of arguments that implement
  // each of the branches of the computing process. On the print 'x', 'y',
  // 'xy', the value of the function.
//----------------------------------------------------------------------------
  // For (x*y)<1:      f=(atan(1/(x-y)));
  // For 1<=(x*y)<8:   f=(exp(x))+log(5)*fabs(x-y);
  // For (x*y)>=8:     f=1/(1+x-(x*y));
//----------------------------------------------------------------------------
int main(int argc, char* argv[]) {
	float x, y, f;
	clrscr();
	printf("Enter the first argument of the function: ");
	scanf("%f",&x);
	printf("\nEnter the second argument of the function: ");
	scanf("%f",&y);
//----------------------------------------------------------------------------
	if ((x*y)<1) {
		printf("\nSince (%1.1f*%1.1f) < 1, compute function by formula 1;\n",x,y);
		f=(atan(1/(x-y)));
	}
//----------------------------------------------------------------------------
	if (((x*y)>=1) && ((x*y)<8)) {
		printf("\nSince 1 <= (%1.1f*%1.1f) < 8, compute function by formula 2;\n",x,y);
		f=(exp(x))+log(5)*fabs(x-y);
	}
//----------------------------------------------------------------------------
	if ((x*y)>=8) {
		printf("\nSince (%1.1f*%1.1f) >= 8, compute function by formula 3;\n",x,y);
		f=1/(1+x-(x*y));
	}
//----------------------------------------------------------------------------
	printf("\nFunction result: %f\n",f);
	printf("Press any key to exit...");
	getch();
	return 0;
}
