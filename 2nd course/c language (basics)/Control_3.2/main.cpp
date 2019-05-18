#include <conio.h>
#include <stdio.h>
#include <string.h>
//---------------------------------------------------------------------------
#pragma hdrstop
#pragma argsused
//---------------------------------------------------------------------------
// Task: implement string processing using the functions described 
// in <string.h> and (or) using pointers (Memory for string - dynamically).
//       - Determine the number of words, the second letter 'P'.
//---------------------------------------------------------------------------
int main(int argc, char* argv[]) {
  char *st = new char[0],k;
  int i=0,n,ch=0;
  //--------------------------------------------------------------------------
  while (1) {
    clrscr( );
    puts("Select the input method string.");
    puts(" Press '1' for keyboard input;");
    puts(" Press '2' to load from the file 'data.txt';");
    puts(" Press '3' to exit the program;");
    puts("--------------------------------------"
      "--------------------------------------");
    k=getch();
    if (k=='1') {
      puts("Enter the string:");
      gets(st);
                          //Save a string in a file
      FILE *f1;           //Data file
      f1=fopen("data.txt","wt");    //Open a file F1 for write
      fprintf(f1,"%s\n",st);        //Write string
      fclose(f1);                   //Close the file
      break;
    }
    if (k=='2') {
      FILE *f1;                       //Data file
      f1=fopen("data.txt","rt");      //Open a file F1 for read
      if (!f1) {
        puts("Error reading data");
        getch();
        continue;
      } else {
        fgets(st,1000,f1);    //Read a string
        fclose(f1);            //Close the file
        puts("Line read from the file:\n");
        printf("%s \n",st);    //Display string
      }
      getch();
      break;
    }
    if (k=='3')
      return 0;
  }
  //--------------------------------------------------------------------------
  n=strlen(st);
  if ((st[0]!=' ')&&(st[1])=='P')
    ch++;
  while (i<n) {
    if (st[i]==' ')
      if ((st[i+2]=='P')&&(st[i+1]!=' '))
        ch++;
    i++;
  }
  puts("---------------------------------------"
    "-------------------------------------");
  printf("Words in a row, 2-th letter 'P': %d",ch);
  getch();
  return 0;
}
 
