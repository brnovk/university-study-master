#include<stdio.h>
#include<stdlib.h>
#include<conio.h>
//----------------------------------------------------------------------------
#pragma hdrstop
#pragma argsused
//----------------------------------------------------------------------------
  // Lab 1;
  // Subtask 7;
  // Variant 5;
  // Task: Modify any program so that the program is executed as long as 
  // the end is not indicated in any way by the user.
//----------------------------------------------------------------------------
int main(int argc, char* argv[]) {
	system("cls");
	printf("Worked unlimited loop!\nPress key ESC!!!");
	while (1) {	// infinite loop
		if (getch()==27) break;  // If pressed ECS - exit the cycle
	}
	printf("\n\nUnlimited loop complited!!\n");
	system("pause");
	return 0;
}
