#include<stdio.h>
#include<conio.h>
#include<dos.h>
//---------------------------------------------------------------------------
#pragma hdrstop
#pragma argsused
//---------------------------------------------------------------------------
	/* Tasks. */
// Given dimension N by N matrix.
// 1. If the minimum element of each subsequent column is less than 
//    the previous one, the maximum element of the matrix to add to the 
//    elements, standing over the side diagonal, and subtracted from the 
//    elements, standing under the secondary diagonal. 
//    Otherwise the matrix remain unchanged.
// 2. Find the minimum among the sums of elements diagonals parallel 
//    to the main diagonal.
// 3. Find the number in the first column does not contain any 
//    element of 2 times.
//============================================================================
// Function prototypes
int menu(int kp, char*NAZ[]);
int main(int argc, char* argv[]);
void vvod(int*n, int ***A);
void prosm(int n, int **A);
void file(int *n, int m, int ***A);
int zadacha1(int n, int **A);
int zadacha2 (int n, int **A);
int zadacha3 (int n, int **A);
//============================================================================
int menu(int kp, char*NAZ[]) {
	int k, i;
	clrscr();
	for (i=0; i<kp; i++)
		printf("\n %d %s", i+1, NAZ[i]);
	printf("\n\n Select ->");
	scanf("%d",&k);
	return k;
}
//============================================================================
void file(int *n,int m, int ***D) {     // Working with files
	int kol=3,punkt,i,j;
	int size=sizeof(int);
	FILE *ft;
	char*nazv[]={"Open file","Save to File","Exit"};
	while(1) { 
		punkt=menu(kol, nazv);
		switch(punkt) {
			case 1:			// reading
			{
				ft=fopen("data.dat","rb");    
				if (!ft) { 
					clrscr();
					printf("Error opening file");
					getch();
					return;
				}
				fread(n, size, 1, ft);
				int **A=new int* [*n];
				for (i=0; i<*n; i++)
					A[i]=new int [*n];
				for (i=0;i<*n;i++)
					for (j=0;j<*n;j++)
						fread(&A[i][j], size, 1, ft);
				fclose(ft);
				*D=A;
				clrscr();
				printf("Load file");
				for (int i=0; i<5;i++) {
					sleep(1);
					printf(".");
				}
				delete []A;
				break;
			}
			case 2: 		// writing
			{
				ft=fopen("data.dat","wb");       
				fwrite(&m, size, 1, ft);
				int **B=new int*[*n];
				for (i=0; i<*n; i++)
					B[i]=new int [*n];
				B=*D;
				for (i=0;i<*n;i++)
					for (j=0;j<*n;j++)
						fwrite(&B[i][j], size, 1, ft);
				fclose(ft);
				clrscr();
				printf("Saving file");
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
	int **A=NULL;
	int t;
	int kol=7,nom;
	char *nazv[]={"Input", "View",
	"If the minimum element of each subsequent column, is less than previous "
	"one,\n   the maximum element of the matrix to add to the elements, "
	"standing over the\n   side diagonal, and subtracted from the "
	"elements, standing under the\n   secondary diagonal.\n   "
	"Otherwise the matrix remain unchanged.","Find the minimum among the sums "
	"of elements diagonals parallel to the main\n   diagonal.", "Find the number "
	"in the first column does not contain any element of 2 times.",
	"Exit","Working with files"};
	while(1) {
		nom=menu(kol, nazv);
		switch(nom) {
			case 1: 
				vvod(&n, &A );
				break;
			case 2:
				prosm(n, A );
				break;
			case 3: 
				zadacha1(n, A);
				getch();
				clrscr;
				break;
			case 4: 
				t=zadacha2(n, A);
				printf("\nAt least, among the sums dagonaley parallel to the main: %d",t);
				getch();
				clrscr;
				break;
			case 5: 
				zadacha3(n, A);
				getch();
				clrscr;
				break;
			case 6: 
				delete[] A; 
				return 0;
			case 7: 
				file(&n,n,&A); 
				break;
		}
	}
}
//============================================================================
void vvod(int*n, int ***D) {
	int i,j;
	clrscr();
	printf("Enter the dimension -> ");
	scanf("%d", n);
	int **A=new int* [*n];
	for (i=0; i<*n; i++)
		A[i]=new int [*n];
	for (i=0; i<*n; i++)
		for (j=0; j<*n; j++) {
			printf("\n A[%d][%d]= ", i, j);
			scanf("%d", &A[i][j]);
		}
        *D=A;
}
//============================================================================
void prosm(int n, int **A) {
	int i, j;
	clrscr( );
	for (i=0; i<n; i++) {
		for (j=0; j<n; j++)
			printf("%8d", A[i][j]);
		printf("\n");
	}
	getch();
}
//============================================================================

/*
 * Task 1: If the minimum element of each subsequent column is less than the 
 * previous one, the maximum element of the matrix to add to the elements, 
 * standing over the side diagonal, and subtracted from the elements, 
 * standing under the secondary diagonal.
* Otherwise matrix remain unchanged.
 */
int zadacha1(int n, int **matr) {
	int m_i=0,m_j=0,m1_i,m1_j,fl=0,fl1=0,j,i;
	int max=matr[0][0];
	for (j=0;j<n;j++) {
		m_i=0;
		m_j=j;
		for (i=1;i<n;i++) {
			if (matr[i][j]<matr[m_i][m_j]) {
				m_i=i;
				m_j=j;
			}
			if (max<matr[j][i])
				max=matr[j][i];
		}
		if (fl==0) {
			fl=1;
			m1_i=m_i;
			m1_j=m_j;
			continue;
		} else {
			if (matr[m1_i][m1_j]<matr[m_i][m_j]) {
				fl1=1;
				break;
			} else {
				m1_i=m_i;
				m1_j=m_j;
			}
		}
	}
	if (fl1==1)
		printf("Leave the matrix unchanged");
	else {
		printf("The resulting matrix: \n\n");
		for (i=0;i<n;i++) {
			for (j=0;j<n;j++) {
				if (j<n-i-1)
					matr[i][j]+=max;
				if (j>n-i-1)
					matr[i][j]-=max;
				printf(" %d",matr[i][j]);
			}
			printf("\n");
		}
	}
	return 0;
}
//============================================================================

/*
 * Task 2: Find the minimum among the sums of elements diagonals parallel 
 * to the main diagonal.
 */
int zadacha2(int n, int **matr) {
	printf("\n");
	int tmp=0,i,j;
	int tmp1=0;
	int _j;
	for (i=0;i<n;i++) {
		tmp+=matr[i][i];
		printf(" a[%d][%d] ",i,i);
		if (i!=(n-1))
			printf("+");
	}
	printf(" = %d;\n",tmp);
	int fl=0;
	while (fl<=1) {
		_j=1;
		while(_j<=(n-1)) {
			tmp1=0;
			for(i=0,j=_j;j<=(n-1);i++,j++) {
				if (fl==0) {
					tmp1+=matr[i][j];
					printf(" a[%d][%d] ",i,j);
				} else {
					tmp1+=matr[j][i];
					printf(" a[%d][%d] ",j,i);
				}
				if (j!=(n-1))
					printf("+");
			}
			printf("= %d;\n",tmp1);
			_j++;
			if (tmp1<tmp)
				tmp=tmp1;
		}
		fl++;
	}
	return tmp;
}
//============================================================================

/*
 * Task 3: Find the number in the first column does not contain any 
 * element of 2 times.
 */
int zadacha3(int n, int **matr) {
	int fl,j,i;
	for (j=0;j<n;j++) { 
		fl=0;
		for (i=0;i<n;i++) {
			if ((matr[i][j])%2==0) {
				fl=1;
				break;
			}
		}
		if (fl==0)
			break;
	}
	if (fl==0)
		printf("\nResult: %d\n",(j+1));
	else
		printf("There are elements in all columns are multiples of 2;\n\n");
	return 0;
}
