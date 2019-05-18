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
int v2(int n, int *A, int *fl);
int main(int argc, char* argv[]);
//---------------------------------------------------------------------------
int v2(int n,int *A,int *fl) {
  /*Calculation of the amount of negative items*/
  int i,t=0,k=0;
  for(i=0;i<n;i++)
    if (A[i]<0) { 
      k+=A[i]; 
      t=1;
    }
  if (t==0) {
    *fl=0;
    return 0;
  } else {
    *fl=1;
    return k;
  }
}
//---------------------------------------------------------------------------
int main(int argc, char* argv[]) {
  int n, A[50];
  clrscr();
  cout <<"Enter the dimension (<=50) -> ";
  cin >> n;
  for(int i=0;i<n;i++) { 
    cout << "\n A[" << i << "]=";
    cin >> A[i];  
  }
  int s,fl;
  s=v2(n, A,&fl);
  if (fl==0) 
    cout << "\n Negative items missing";
  else {
    cout << "\nSum of negative elements: ";
    cout << s;
  }
  getch();
  return 0;
}

