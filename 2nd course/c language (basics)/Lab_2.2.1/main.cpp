#include <conio.h>
#include <iostream.h>
//---------------------------------------------------------------------------
#pragma hdrstop
#pragma argsused
//---------------------------------------------------------------------------
	/*Tasks.*/
// Develop program 3 implement processing vector.
// Checkout solution each task as a separate function.

// For all programs to implement data transfer between a function that 
// implements the solution vector processing tasks, and the main() function:
// 1. Global data description;
// 2. Formal and factual arguments and passing the results to the caller. 
// 3. Formal and factual arguments and passing the results to the caller 
//    and implement dynamic memory allocation for one-dimensional arrays.
//---------------------------------------------------------------------------
// Function prototypes
void r1();
int main(int argc, char* argv[]);
//---------------------------------------------------------------------------
// Global data description
int n;
int a[50];
//---------------------------------------------------------------------------
void r1() {
	int i,s=0;
	for(i=0;i<n;i++) {
		s+=a[i];
	}
	cout << "\nThe sum of all the elements of the vector: ";
	cout << s;
	getch();
}
//---------------------------------------------------------------------------
int main(int argc, char* argv[]) {
	clrscr();
	cout <<"Enter the dimension vector [no more than 50 items]: ";
	cin >> n;
	for(int i=0;i<n;i++) {
		cout << "a[" << i << "]:";
		cin >> a[i];  
	}
	r1();
	return 0;
}
 
