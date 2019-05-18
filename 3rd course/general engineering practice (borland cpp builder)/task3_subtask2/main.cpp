#pragma hdrstop
#pragma argsused
//-----------------------------------------------------------------------------
// Task 3, Part 1, Var 4 (14), POIT-31, Baranov V.
// Processing lines: using pointers and functions of library <cstring>.
// Task: In each pair of characters 'AB' insert '*' symbol;
//       Count how many times in the line the character 'I' is before last '2';
//-----------------------------------------------------------------------------
#include <windows.h>
#include <cstdlib>
#include <iostream>
#include <cstring>
    
#define MAXLEN 1000  // Max length string

// Function prototypes---------------------------------------------------------
unsigned int StringEmpty(char*);               // Checks string occupancy
char* ConvertingString(char* s, unsigned int); // Conversion string
unsigned int NumberOccurrences(char*); // Count occurrences substring in string
//-----------------------------------------------------------------------------
int main(int argc, char *argv[]) {
	system("chcp 1251");
	char* s = new char [MAXLEN];
	char* buf=NULL;
	char p;
	s[0]='\0';
	int n; 
	while(1) {
		system("cls");
		std::cout << "Press:\n1.Input string"
			"\n2.View source string"
			"\n3.View converted string"
			"\n4.Counting occurrences of characters \"I\" is before last \"2\""
			"\n0.Exit\n->>";
		std::cin.get(p);
		std::cin.sync();
		system("cls");
		switch(p) {
			case '1': 
				std::cout << "Enter the string.\n-->";   // Input string
				std::cin.getline(s,sizeof(char [MAXLEN]));
				break;

			case '2': 
				if (StringEmpty(s))  // If the string is empty
					break;
				std::cout << "Source string: \n" << s << std::endl;
				system("pause");
				break;

			case '3': 
				if (StringEmpty(s)) // If the string is empty
					break; 
				buf=ConvertingString(s,strlen(s));
				std::cout << "Converted string: \n" << buf << std::endl;
				system("pause");
				delete []buf;
				break;

			case '4':
				if (StringEmpty(s)) // If the string is empty
					break; 
				n=NumberOccurrences(s); // Number of times symbols 'I' before 2
				std::cout << "Number of times symbols 'I' before last '2':" 
					<< n << std::endl;
				system("pause");
				break;

			case '0': 
				delete []s;
				return EXIT_SUCCESS; // Exit the program

			default:  
				std::cout << "Entered an invalid character. " << std::endl;
				std::cout << "Program will be completed. " << std::endl;
				delete []s;
				system("pause");
				return EXIT_SUCCESS;  // Exit the program
		}
	}
}
//-----------------------------------------------------------------------------

/**
 * Checks string occupancy.
 */
unsigned int StringEmpty(char* s) {
	if (!strlen(s)) {
		std::cout << "Do not put the source string!!!\n";
		system("pause");
		return 1;
	} else 
		return 0;
}
//-----------------------------------------------------------------------------

/**
 * Count occurrences substring in string.
 */
unsigned int NumberOccurrences(char* s) {
	char* LastOcc=NULL;
	unsigned int ch=0;
	LastOcc=strrchr(s,'2');
	if (LastOcc==NULL) return 0;
	while((s=strstr(s,"I"))!=NULL) {
		if (s>=LastOcc)
			break;
		++ch;
		s++;
	}
	return ch;
}
//-----------------------------------------------------------------------------

/**
 * Conversion string.
 */
char* ConvertingString(char* s,unsigned int n) {
	n=n+(n/2); // calculate the maximum length of the transformed string
	char* sub = new char [n];
	char* buf;
	sub[0]='\0';
	while(1) {
		buf=s;
		s=strstr(buf,"AB");
		if (s!=NULL) {
			s++;
			strncat(sub,buf,(s-buf));
			strcat(sub,"*");
		} else {
			strcat(sub,buf);
			break;
		}
	}
	return sub;
}
