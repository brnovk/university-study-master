#include<stdio.h>
#include<stdlib.h>
#include<math.h>
//----------------------------------------------------------------------------
#pragma hdrstop
#pragma argsused
//----------------------------------------------------------------------------
  // Lab 1;
  // Subtask 3;
  // Variant 5;
  // Task: Enter three real numbers a, b, c.
  // Find the integral and fractional parts of a division (a + b) on c
//----------------------------------------------------------------------------
int main(int argc, char* argv[]) {
	double x,y,z,c,dr,ii;
	printf("Inter 1st number:");
	scanf("%lf",&x);
	printf("Inter 2nd number:");
	scanf("%lf",&y);
	printf("Inter 3rd number:");
	scanf("%lf",&z);
	//--------------------------------------------------------------------
	ii = ((x+y)/z);
	dr = modf(ii, &c);
	//--------------------------------------------------------------------
	printf("(%2.2lf+%2.2lf)/%2.2lf = %2.2lf;\n",x,y,z,ii);
	printf("Result(integer part): %1.0lf;\n",c);
	printf("Result(floating part): %0.1lf;\n\n",dr);  
	system("pause");
	return 0;
}

