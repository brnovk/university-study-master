#include<stdio.h>
#include<conio.h>
//---------------------------------------------------------------------------
#pragma hdrstop
#pragma argsused
//---------------------------------------------------------------------------
// Task: handle the string as an array of characters (not dynamically).
//       - After each character '!' insert symbol 'I'
//       - Count the total number of digits in the string.
//---------------------------------------------------------------------------
int main(int argc, char* argv[]) {
  int n,i=0,j,ch=0;
  char st[1000],k;
  //--------------------------------------------------------------------------
  while (1) {
    clrscr( );
    puts("Select the input method string.");
    puts(" Press '1' for keyboard input;");
    puts(" Press '2' to load from the file 'data.txt';");
    puts(" Press '3' to exit the program;");
    puts("----------------------------------------"
      "------------------------------------");
    k=getch();
    if (k=='1') {
      puts("Enter the string:");
      gets(st);
      FILE *f1;                     //Data file
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
        fgets(st,1000,f1);     //Read a string
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
  n=0;
  while (1) {
    if (st[n]=='\0')
      break;
    else 
      n++;
  }
  if (n>500) {
    printf("\nProgram may not work correctly with a string "
      "of more than 500 characters...");
    getch();
  }
  //--------------------------------------------------------------------------
  while (i<n) {
    if (st[i]=='!') {
      n++;
      j=n;
      while (j!=i) {
        st[j]=st[j-1];
        st[j+1];
        j--;
      }
      i++;
      st[i]='I';
    }
    if ((st[i]>='0')&&(st[i]<='9'))
      ch++;
    i++;
  }
  //--------------------------------------------------------------------------
  puts("---------------------------------"
    "-------------------------------------------");
  delete []st;
  printf("The number of digits in a string: %d\n",ch);
  printf("The resulting string:\n");
  puts(st);
  getch();
  return 0;
}

