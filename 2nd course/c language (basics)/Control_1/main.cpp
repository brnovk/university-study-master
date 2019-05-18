#include<stdio.h>             
#include<conio.h>
#include<math.h>
#include<dos.h>
//---------------------------------------------------------------------------
#pragma hdrstop
#pragma argsused
//---------------------------------------------------------------------------
	/* Tasks. */
// Given a vector of dimension N.
// 1. Find the sum of the elements located between the first and the last 
//    element of zero.
// 2. Compress array by removing it from all the elements, the module which 
//    is in the range [a, b].
//    Vacated at the end of the array elements fill with zeros.
// 3. If the sum of the elements located to the left of the minimum is less 
//    than the maximum, then find the arithmetic mean of the elements 
//    located to the minimum.
//============================================================================
// Function prototypes
int menu(int kp, char*NAZ[]);
int main(int argc, char* argv[]);
void vvod(int*n, int **A);
void prosm(int n, int *A);
void file(int*n, int **A);
int zadacha1(int n, int *A);
int zadacha2(int n, int *A);
int zadacha3 (int n, int *A);
//============================================================================
int menu(int kp, char*NAZ[]) {
	int k, i;
	clrscr();
	for (i=0; i<kp; i++)
		printf("\n %d %s", i+1, NAZ[i]);
	printf("\n\n Select ->");
	scanf("%d",&k);
	if ((0<k)&&(k<8))
		return k;
	else
		return 0;
}
//============================================================================
void file(int *n, int **D) { 
	int kol=3,nom,i;
	FILE *ft;
	char*nazv[]={"Read data","Write data","Exit"};
	while(1) { 
		nom=menu(kol, nazv);
		switch(nom) { 
			case 1: //Opening and reading
			{
				ft=fopen("in.txt","rt");   
				if (!ft) {
					puts("Error opening the file! ");
					getch();
					return;
				}
				fscanf(ft,"%d",n);
				int *A=new int [*n];
				for (i=0;i<*n;i++)
					fscanf(ft,"%d",&A[i]);
				fclose(ft);
				*D=A;
				clrscr();
				printf("Load file");
				for (i=0; i<5;i++) {
					sleep(1);
					printf(".");
				}
				delete []A;
				break;
			}
			case 2: // Recording
			{
				ft=fopen("out.txt","wt"); 
				fprintf(ft,"%d\n",*n);
				int *B=new int [*n];
				B=*D;
				for (i=0;i<*n;i++)
					fprintf(ft,"%d\n",B[i]);
				fclose(ft);
				clrscr();
				printf("Save to file");
				for (i=0; i<5;i++) {
					sleep(1);
					printf(".");
				}
				delete []B;
				break;
			}
			case 3:
			{
				return;
			}
		}
	}
}
//============================================================================
int main(int argc, char* argv[]) {
	int n;
	int *a=NULL;
	int t;
	int kol=7, nom, pr, sum;
	char *nazv[]={" Input;", " View;",
	" Amount of elements between the first and last zero elements;",
	" Compress array, deleting all the elements of the module which is"
	" in \n    within a given range;",
	" Display arithmetic mean elements arranged to"
	" minimum,\n    provided that the sum of the elements"
	" to the left of minimum \n    is smaller than the maximum;",
        " Exit;"," File"};
	while(1) {
		nom=menu(kol, nazv);
		switch(nom) { 
			case 1: 
				vvod(&n, &a );
				break;
			case 2: 
				prosm(n, a );
				break;
			case 3: 
				t = zadacha1(n, a);
				clrscr();
				if (t==0)
					printf("\nIn the array is less than 2-zero elements");
				else
					printf("\nThe sum of the elements between zero elements: %d", t);
				getch();
				break;
			case 4: 
				zadacha2(n, a);
				clrscr();
				break;
			case 5: 
				zadacha3(n, a);
				clrscr();
				getch();
				break;
			case 6: 
				return 0;
			case 7: 
				file(&n, &a); 
				break;
		}
	}
}
//============================================================================
void vvod(int*n, int **D) {
	int i;
	clrscr();
	printf("Enter the dimension -> ");
	scanf("%d", n);
	int *a;
	if (*D!=NULL)		//check whether the allocated memory
		delete [] *D;	//if yes, then destroy it
	a=new int [*n];			// memory allocation vector
	for (i=0; i<*n; i++) {	// enter the elements of the vector
		printf(" A[%d]= ", i);
		scanf("%d", &a[i]);
	}
	*D=a;
}
//============================================================================
void prosm(int n, int *a) {
	int i;
	clrscr( );
	for (i=0; i<n; i++)
		printf("\n A[%d]=%d", i, a[i]);
	getch();
}
//============================================================================

/*
 * Task 1: find the sum of elements that are located between the first 
 * and the last zero element.
 */
int zadacha1(int n, int *a) {
	int u0=0,u1=0,ch=0,i,j;
	for (i=0,j=n-1;i<=j; ) {
		if (u0==0) {
			i++;
			if (a[i-1]==0) 
				u0=1;
		}
		if (u1==0) {
			j--;
			if (a[j+1]==0) 
				u1=1;
		}
		if ((u0==1)&&(u1==1)) {
			while (i!=j) {
				ch+=a[i];
				i++;
			}
			break;
		}
	}
	return ch;
}
//============================================================================

/*
 * Task 2: To compress the array, deleting all the elements of the module 
 * that is in the interval [a, b]. 
 * The released at the end of the array elements fill with zeros.
 */
int zadacha2(int n, int *a) {
	int i, j=0, a3, b;
	int *m2;
	m2=new int[n];
	printf("\nEnter A:");
	scanf("%d",&a3);
	printf("\nEnter B:");
	scanf("%d",&b);
	for(i=0; i<n; i++)
		if ((abs(a[i])<a3) || (abs(a[i])>b)) {
			m2[j]=a[i];
			j++;
		}
	for(i=j; i<n; i++) {
		m2[i]=0;
		i++;
	}
	printf("\nThe resulting array:\n");
	for (j=0; j<n; j++)
		printf(" %d",m2[j]);
	delete [] m2;
	getch();
	return 0;
}
//============================================================================

/*
 * Task 3: If the sum of the elements located to the left of the minimum is 
 * less than the maximum, then find the arithmetic mean of the elements 
 * located to the minimum.
 */
int zadacha3(int n, int *A) {
	int i,min=0,max=0,s1=0,ch=0;
	for (i=1; i<n; i++) {
		if (A[i]<A[min]) min=i;
		if (A[i]>A[max]) max=i;
	}
	if (min==0) {
		printf("To the left of the minimum elements missing;");
		getch();
		return 0;
	}
	for (i=0; i<min; i++) {
		s1+=A[i];
		ch++;
	}
	if (s1<A[max])
		return (s1/ch);
	else
		printf("The sum of the elements, to the left is greater than or "
			"equal to the minimum value, the maximum");
	return 0;
}

