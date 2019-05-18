//---------------------------------------------------------------------------
// Task 7, Var 4, POIT-31, Baranov V.
// Task: Given a matrix MxN. Determine the amount of specific matrix elements.
//       Specific item - if it is greater than the sum of the remaining 
//       elements of its column.
//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
#include "main.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TForm1 *Form1;
int **pA; 
int N,M; 
//---------------------------------------------------------------------------
__fastcall TForm1::TForm1(TComponent* Owner) : TForm(Owner) {
}
//---------------------------------------------------------------------------

void __fastcall TForm1::FormCreate(TObject *Sender) {

  HMENU MenuHandle = GetSystemMenu(Handle, false);      // Barring a reversal
  if (MenuHandle)                                       // of the window to
    DeleteMenu(MenuHandle, SC_MAXIMIZE, MF_BYCOMMAND);  // full screen

  Constraints->MaxHeight=310;                          //
  Constraints->MinHeight=310;                          // Ban window resizing
  Constraints->MaxWidth=528;                           //
  Constraints->MinWidth=528;                           //

  N=3; M=3;
  Edit1->Text="3";
  Edit2->Text="3";
  StringGrid1->RowCount=N+1;
  StringGrid1->ColCount=M+1;
  for (int i=1; i<=N; i++) {
    StringGrid1->Cells[i][0]="j="+IntToStr(i);
    StringGrid1->Cells[0][i]="i="+IntToStr(i);
  }
  Label4->Caption="";
  Form1->StringGrid1->Options << goEditing;
  Form1->Caption="Task 7 (POIT-31, Variant 4, Baranov V.)";
}
//---------------------------------------------------------------------------

/**
 * Press Change size
 */
void __fastcall TForm1::Button1Click(TObject *Sender) {
  N=StrToInt(Edit1->Text);
  M=StrToInt(Edit2->Text);
  StringGrid1->RowCount=N+1;
  StringGrid1->ColCount=M+1;
  for (int i=1;i<=N;i++)
    StringGrid1->Cells[0][i]="i="+IntToStr(i);
  for (int i=1;i<=M;i++)
    StringGrid1->Cells[i][0]="j="+IntToStr(i);
}
//---------------------------------------------------------------------------

/**
 * Press Calculate
 */
void __fastcall TForm1::Button2Click(TObject *Sender) {
  int i,j,ss;
  pA = new int*[N];
  for (i=0; i<N; i++)
    pA[i] = new int[M];
  for (i=0;i<N;i++)
    for (j=0;j<M;j++)
      pA[i][j]=StrToInt(StringGrid1->Cells[j+1][i+1]);
  //--------------------------------------------------
  unsigned int met=0;
  for (i=0;i<N;i++) {
    ss=0;
    for (j=0;j<M;j++)
      ss+=pA[j][i]; // Find the sum of an entire column
    for (j=0;j<M;j++)
      if ((ss-(pA[j][i]))<pA[j][i])
        met++;
  }
  Label4->Caption=IntToStr(met);
  //--------------------------------------------------
  for (i=0;i<N;i++)
  delete[] pA[i];
  delete [] pA;
}
//---------------------------------------------------------------------------

/**
 * Press About
 */
void __fastcall TForm1::Button3Click(TObject *Sender) {
  (MessageDlg("Task 7\nVariant 4\nGroup POIT-31\nPerformed"
      ": Baranov V.\n\n Task:\nGiven a matrix MxN.\n"
      "Determine the amount of specific matrix elements.\n\n"
      "Specific item - if it is greater than the sum of\nthe remaining"
      " elements of its column.", mtInformation, TMsgDlgButtons() << mbYes,0));
}
//---------------------------------------------------------------------------

/**
 * Press Exit
 */
void __fastcall TForm1::Button4Click(TObject *Sender) {
  Form1->Close();
}
