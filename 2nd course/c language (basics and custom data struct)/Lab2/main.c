#include <cstdlib>
#include <cstdio>
#include <windows.h>
//----------------------------------------------------------------------------
#pragma hdrstop
#pragma argsused
//----------------------------------------------------------------------------
  // Lab 2;
  // Variant 5;
  // Task: Develop a method for economical accommodation in the memory of 
  // a given sparse static array.
  // All zero (identical) elements are arranged in lower part of the matrix.
//----------------------------------------------------------------------------
// Function prototypes
void ChangeEntireArray(int *ad);       // Filling the entire array
int EnterDimensions(char* mes, int x, int  y, int u); //Enter the dimensions
void PopulateItems(int *ap);           // Filling all the unique elements
void ConcludedOfArray(int *ap);        // Displays the entire array on screen
void ViewChangeUnique(int *a,int fl);  // View/change a unique item
//----------------------------------------------------------------------------

/*
 * Function input array dimensions and repeating elements.
 */
int EnterDimensions(char* mes,int x, int y, int u) {
	int f;
	printf("%s",mes);
	if (u) printf("(from %d to %d):",x,y);   
	scanf(" %d",&f);
	return f;
}
//============================================================================

/*
 * Function of filling all nonzero (unique) values of the array elements.
 */
void PopulateItems(int *ap) {
	int i,c,j,k=0,f=4;
	c=(ap[0]-ap[2]);              // All lines minus the zero line
	printf("Enter a non-zero value (unique) array:\n");
	for (i=0; i<c; i++,k++)       // input vector elements
		for (j=0;j<ap[1];j++,f++) {
			printf(" A[%d][%d]= ", k+1,j+1);
			scanf("%d", &ap[f]);
		}
}
//=============================================================================

/*
 * Function display the entire array on the screen.
 */
void ConcludedOfArray(int *ap) {
	int i, j, c,f=4;
	printf("The entered array:\n");
	c=(ap[0]-ap[2]); 	// All lines minus the zero line
	for (i=0; i<c; i++) {
		for (j=0; j<ap[1]; j++,f++)
			printf("%8d", ap[f]);
		printf("\n");
	}
	for (; i<ap[0]; i++) {
		for (j=0; j<ap[1]; j++)
			printf("%8d",ap[3]);
		printf("\n");
	}
}
//=============================================================================

/*
 * Filling the entire array.
 */
void ChangeEntireArray(int *ad) {
	system("cls");
	do {
		ad[0]=EnterDimensions("Enter the number of rows matrix ",2,10,1);
	} while ((ad[0]<2)||(ad[0]>10));
	do {
		ad[1]=EnterDimensions("Enter the number of cols matrix",1,10,1);
	} while ((ad[1]<1)||(ad[1]>10));
	do {
		ad[2]=EnterDimensions("Enter the number of rows zero elements "
			"of bottom of matrix ",1,ad[0]/2,1);
	} while ((ad[2]<1)||(ad[2]>ad[0]/2));
	ad[3]=EnterDimensions("Enter a value of zero (repeating) element: ",0,0,0);
	PopulateItems(ad);  // Filling all the unique values
}
//=============================================================================

/**
 * View and edit a unique member.
 */
void ViewChangeUnique(int *af,int fl) {
	char h;
	int p,n,r;
	do {
		system("cls");
		printf(" Enter line number of unique "
			"element (from %d to %d):",1,(af[0]-af[2]));
		scanf("%c",&h);
		p=(int)h;
	} while (p<49||p>((af[0]-af[2])+48));
	p-=48;
	do {
		system("cls");
		printf(" Enter column number unique "
			"item (from %d to %d):",1,af[1]);
		scanf("%c",&h);
		n=(int)h;
	} while (n<49||n>(af[1]+48));
	n-=48;
	system("cls");
	r=((p-1)*af[1])+n+3; //Conversion formula
	printf("The value of this element: A[%d][%d] = %d;\n",p,n,af[r]);
	//---------------------------------------------------------------------
	if (fl) { //Edit the value
		printf("Enter the new value for this element: ");
		scanf(" %d",&af[r]);
		printf("The new value is stored!\n");
	}
}
//=============================================================================

int main(int argc, char *argv[]) {
	int b[53],l,t=1;
	int* a=b;
	char v;
	system ("chcp 1251"); // Changing the encoding from 866 to 1251
	system("cls");
	ChangeEntireArray(a); // Filling the entire array
	while(t) {
		do {
			system("cls");
			printf("Press:\n 0 - To view the entire array;\n");
			printf(" 1 - To view a non-zero (unique) element of the array;\n");
			printf(" 2 - To view the zero (repeating) element of the array;\n");
			printf(" 3 - To change the entire array;\n");
			printf(" 4 - To change a non-zero (unique) element of the array;\n");
			printf(" 5 - To change the zero (repeating) element of the array;\n");
			printf(" 6 - To exit.\n");
			scanf("%c",&v);
			l=(int)v;
		} while (l<48||l>54);
		switch(l) {
			case 48: 
				ConcludedOfArray(a);    // View the entire array
				system("pause");
				break;
			case 49: 
				ViewChangeUnique(a,0);  // View unique element
				system("pause");
				break;
			case 50: 
				system("cls");          // View repeating element
				printf("Zero (repeating) element of the array: %d;\n",a[3]);
				printf("It occupies the lower %d-line array;\n",a[2]);
				system("pause");
				break;
			case 51: 
				ChangeEntireArray(a);   // Filling the entire array
				break;
			case 52: 
				ViewChangeUnique(a,1);  // Changing a unique element
				system("pause");
				break;
			case 53: 
				system("cls");          // Changing repeating element
				printf("Old value of zero (repeating) element: %d;\n",a[3]);
				printf("Enter the new value of the element: ");
				scanf(" %d",&a[3]);
				printf("The new value is saved!\n");
				system("pause");
				break;
			case 54: 
				system ("chcp 866");
				return EXIT_SUCCESS;	// Exit the program
		}
	}
	return EXIT_FAILURE;
}
