#include<stdio.h>
#include<conio.h>
#include<math.h>
#include<limits.h>
//---------------------------------------------------------------------------
#pragma hdrstop
#pragma argsused
//---------------------------------------------------------------------------
  // Lab 0.2;
  // Variant 5;
  // Task: Calculate the value of 'g' function using integer data, 
  // intermediate and final results of the operation of integer arithmetic, 
  // MAXINT constants operatopa selection ranges Switch. 
  // Program to calculate values at least three pairs of arguments that 
  // implement each of the branches of the computing process. 
  // On the print 'x', 'y', 'xy', the value of the function.
//----------------------------------------------------------------------------
  // For (x*y)<3:       g=(pow(x,2)-pow(y,2)+3*x)/sqrt(2*pow((x*y),4));
  // For 3<=(x*y)<=10:  g=(x+1+sqrt(abs(y+1)))/(pow(x,2)+x*y);
  // For (x*y)>10:      g=(-5*pow(x,2)+abs(x-y));
//----------------------------------------------------------------------------
int main(int argc, char* argv[]) {
	int x, y, z, fl, g;
	clrscr();
	printf("Enter the first argument of the function: ");
	scanf("%d",&x);
	printf("\nEnter the second argument of the function: ");
	scanf("%d",&y);
	z=x*y;
	if ((z<3)&&(z>(INT_MAX))) fl=0;
	if ((z>=3)&&(z<=10)) fl=1;
	switch (fl) {
		case 0:
		printf("\nSince (%d*%d) < 3, compute function by formula 1;\n",x,y);
		g=(pow(x,2)-pow(y,2)+3*x)/sqrt(2*pow((x*y),4));
		break;
//----------------------------------------------------------------------------
		case 1:
		printf("\nSince 3 <= (%d*%d) <= 10, compute function by formula 2;\n",x,y);
		g=(x+1+sqrt(abs(y+1)))/(pow(x,2)+x*y);
		break;
//----------------------------------------------------------------------------
		default:
		printf("\nSince (%d*%d) > 10, compute function by formula 3;\n",x,y);
		g=(-5*pow(x,2)+abs(x-y));
		break;
	}
	printf("\nFunction result: %d\n",g);
	printf("Press any key to exit...");
	getch();
	return 0;
}

