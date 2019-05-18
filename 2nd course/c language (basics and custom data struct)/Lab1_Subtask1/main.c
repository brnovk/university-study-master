#include<stdio.h>
#include<stdlib.h>
#include<math.h>
//----------------------------------------------------------------------------
#pragma hdrstop
#pragma argsused
//----------------------------------------------------------------------------
  // Lab 1;
  // Subtask 1;
  // Variant 5;
  // Task: Calculate the value function f(x)=3,5x+cosx/sin2x+ex, where x=0,1.
  // Round the value f(x) to the nearest integer. 
//----------------------------------------------------------------------------
int main(int argc, char* argv[]) {
	const float x=0.1;
	float f;
	printf("Value X = 0.1");      
	f=(3.5*x)+(cos(x)/sin(2*x))+(2.7*x);
	printf("\nF(x)= %2.2f\n",floor(f));
	system("pause");
	return 0;
}

