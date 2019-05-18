#pragma hdrstop
#pragma argsused
//---------------------------------------------------------------------------
// Task 3, Part 1, Var 4 (14), POIT-31, Baranov V.
// Processing lines: character-wise.
// Task: After the last letter of each word to insert a point.
//       The extra characters (from 81st) to delete;
//---------------------------------------------------------------------------
#include <windows.h>
#include <cstdlib>
#include <iostream>

#define MAXLEN 1000  // max length string

// Function prototypes-------------------------------------------------------
unsigned int CheckLetter(char);            // Checking letter
int LengthString(char* s);                 // Calculate length string
char* ConvertingString(char* s,int n);     // Conversion string
//---------------------------------------------------------------------------

int main(int argc, char* argv[]) {
	system("chcp 1251");   // for Russian encoding.
	char* s = new char [MAXLEN];
	char* buf=NULL;       
	char p;
	s[0]='\0';
	int n;  // length source string
	while(1) {
		system("cls");
		std::cout << "Press:\n1.Input"
			"\n2.View"
			"\n3.Show result"
			"\n0.Exit\n->>";
		std::cin.get(p);
		std::cin.sync();
		system("cls");
		switch(p) {
			
			case '1':
				std::cout << "Enter the string.\n-->";   // String input
				std::cin.getline(s,sizeof(char [MAXLEN]));
				break;

			case '2':
				n=LengthString(s);       // Calculated the length of the string
				if (!n) {                // If string length = 0
					std::cout << "Do not put the source string!!!\n";
					system("pause");
					break; 
				}
				std::cout << "Source string: \n" << s << std::endl;
				system("pause");         // View string
				break;

			case '3':
				n=LengthString(s);       // Calculated the length of the string
				if (!n) {                // If string length = 0
					std::cout << "Do not put the source string!!!\n";
					system("pause");
					break; 
				}
				buf=ConvertingString(s,n);
				std::cout << "Converted string: \n" << buf << std::endl;
				system("pause");
				delete []buf;
				break;

			case '0':
				delete []s;           // Exit the program
				return EXIT_SUCCESS;

			default:
				std::cout << "Invalid character entered. " << std::endl;
				std::cout << "Work program will be completed. " << std::endl;
				delete []s;     
				system("pause");
				return EXIT_SUCCESS;  //Exit the program
		}
	}
}
//---------------------------------------------------------------------------

/**
 * Calculate length string.
 */
int LengthString(char* s) {
	int tmp=0,i=0;
	while(s[i]!='\0') {
		tmp++;
		i++;
	}
	return tmp;
}
//---------------------------------------------------------------------------

/**
 * Conversion string.
 */
char* ConvertingString(char* s,int n) {                           
	char* conv = new char [80];
	conv[0]=s[0];
	int j,i;
	for (i=1, j=1; i<n+1; i++,j++) {
		if (j>=79) 
			break;
		// If previous character  - letter, and current - no
		if (CheckLetter(s[i-1])&&(!CheckLetter(s[i]))) {
			conv[j]='.';   // Insert dot after the word
			j++;
		} 
		conv[j]=s[i];
	}
	conv[j++]='\0';
	return conv;
}
//---------------------------------------------------------------------------

/**
 * Checking letter.
 * (For Russian characters - only 1251 encoding)
 */
unsigned int CheckLetter(char ch) {
	if ((ch>64)&&(ch<91))    // If a character in the range 'A'...'Z'
		return 1;
	if ((ch>96)&&(ch<123))   // If a character in the range 'a'...'z'
		return 1;
	if ((ch>-65)&&(ch<0))    // If a character in the range 'à'...'ß'
		return 1;
	return 0;                // If the character is not a letter
}
