#include<iostream>
#include<cstdlib>
#include<windows.h>
//----------------------------------------------------------------------------
#pragma hdrstop
#pragma argsused
//----------------------------------------------------------------------------
  // Lab 3;
  // Variant 5;
  // Task: Selection from the string substring indicating the start and 
  // length of the substring.
  // Provide a reaction to an incorrect setting of the parameters. 
  // Do not use the existing rows in the language processing tools.
//----------------------------------------------------------------------------

#define MAXLEN 1000  // Max string length

//----------------------------------------------------------------------------
// Function prototypes
int EnterParameter(char* mes, int x);      // Func. input additional values
int LengthString(char* s);                 // Function of the string length
char* SelectSubstring(char* s,int bp, int np); // Function select a substring
//----------------------------------------------------------------------------
int main(int argc, char* argv[]) {
  system("chcp 1251");
  char* s = new char [MAXLEN];
  s[0]='\0';
  char* buf=NULL;       
  char p;
  int n,begin_sub,n_sub; //n         - length source string
                         //begin_sub - begin substring
                         //n_sub     - length substring
  while(1) {
    system("cls");
    std::cout << "Press:\n1.Input string"
                  "\n2.View string"
                  "\n3.Finding a substring"
                  "\n0.Exit\n->>";
    std::cin.get(p);
    std::cin.sync();
    system("cls");
    switch(p) {
      case '1':               //Input string
        std::cout << "Enter the string.\n-->";
        std::cin.getline(s,sizeof(char [MAXLEN]));
        break;

      case '2':               //View string
        std::cout << "Source string: \n" << s << std::endl;
        system("pause");
        break;

      case '3':
        n=LengthString(s);    //Calculate the length of the string
        if (!n) {             //If the string length = 0
          std::cout << "Do not put the source string!!!\n";
          system("pause");
          break;
        }
        begin_sub=EnterParameter((char*)"Enter beginning substring: ",n);
        n_sub=EnterParameter((char*)"Enter length substring: ",n-begin_sub+1);
        buf=SelectSubstring(s,begin_sub-1,n_sub); //Select substring
                                                  //Show substring
        std::cout << "Selected line: \n" << buf << std::endl;         
        system("pause");
        delete []buf;
        break;

      case '0':               //Exit the program
        delete []s;
        return EXIT_SUCCESS;

      default:                //Exit the program
        std::cout << "Invalid character entered. " << std::endl;
        std::cout << "The program will be completed. " << std::endl;
        delete []s;
        system("pause");
        return EXIT_FAILURE;
     }
  }
}
//----------------------------------------------------------------------------

/**
 * Function input additional values
 */
int EnterParameter(char* mes,int x) {
  int tmp;
  do {
    std::cout << mes << std::endl << "(from 1 to " << x << ");\n" << "-->";
    std::cin >> tmp;
    if (!std::cin.good()) {
      std::cout << "Character entered is not a number!" << std::endl;
      system("pause"); 
      std::cin.clear();
      std::cin.sync();
      continue;
    }
  } while (tmp<1||tmp>x);  // While the number is not of the desired range...
  std::cin.sync();
  return tmp;
}
//----------------------------------------------------------------------------

/**
 * Function calculating string length.
 */
int LengthString(char* s) {
  int tmp=0,i=0;
  while(s[i]!='\0') {
    tmp++;
    i++;
  }
  return tmp;
}
//----------------------------------------------------------------------------

/*
 * Select a substring function.
 */
char* SelectSubstring(char* s,int begin_sub,int n_sub) {
  char* sub = new char [n_sub];
  int i;
  for (i=0;i!=n_sub;i++,begin_sub++)
    sub[i]=s[begin_sub];
  sub[i]='\0';
  return sub;
}

