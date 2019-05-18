//---------------------------------------------------------------------------
// Task 4, Var 4, POIT-31, Baranov V.
// Task: Given a string, consisting of groups of 1 and 0. Find and display
//       group with an even number of characters. Initial data entered using
//       TEdit component in TListBox component. Scalar results are displayed
//       via TLabel component. Input line finish by pressing Enter.
//---------------------------------------------------------------------------
#include <vcl.h>
#include <cstring>
#pragma hdrstop
#include "main.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TForm1 *Form1;
//---------------------------------------------------------------------------

__fastcall TForm1::TForm1(TComponent* Owner) : TForm(Owner) {
}

// Custom function prototypes------------------------------------------------
void Execution(AnsiString);           // Calculate and output the result
unsigned int ValueChecks(AnsiString); // Check the availability of the data
//---------------------------------------------------------------------------

/**
 * Press Exit
 */
void __fastcall TForm1::Button2Click(TObject *Sender) {
  Form1->Close();
}
//---------------------------------------------------------------------------

/**
 * Press Clear
 */
void __fastcall TForm1::Button3Click(TObject *Sender) {
  Form1->ListBox1->Clear();
  Form1->LabeledEdit1->Clear();
  Form1->LabeledEdit1->SetFocus();
}
//---------------------------------------------------------------------------

void __fastcall TForm1::FormShow(TObject *Sender) {
  Form1->Caption="Task 4 (POIT-31, Variant 4, Baranov V.)";
  Form1->LabeledEdit1->SetFocus();
}
//---------------------------------------------------------------------------

void __fastcall TForm1::FormCreate(TObject *Sender) {
  HMENU MenuHandle = GetSystemMenu(Handle, false);      // Barring a reversal
  if (MenuHandle)                                       // of the window to
    DeleteMenu(MenuHandle, SC_MAXIMIZE, MF_BYCOMMAND);  // full screen

  Constraints->MaxHeight=405;                          //
  Constraints->MinHeight=405;                          // Ban window resizing
  Constraints->MaxWidth=490;                           //
  Constraints->MinWidth=490;                           //
}
//---------------------------------------------------------------------------

/**
 * Press About
 */
void __fastcall TForm1::Button4Click(TObject *Sender) {
  (MessageDlg("Task ¹4\nVariant 4\nGroup POIT-31\nPerformed"
    ": Baranov V.\n______________________\n Task:\nGiven a string"
    ", consisting of groups of zeros and ones.\nFind and display"
    " groups with an even number of characters.", mtInformation,
    TMsgDlgButtons() << mbYes,0));
  Form1->LabeledEdit1->SetFocus();
}
//---------------------------------------------------------------------------

/**
 * Control input valid values in LabeledEdit1
 */
void __fastcall TForm1::LabeledEdit1KeyPress(TObject *Sender, char &Key) {
  if (!((Key=='0')||(Key=='1')||(Key==13)||(Key==8)||(Key==32)))
    Key=0;
  else if (Key==13)
    Form1->Button1->Click();
}
//---------------------------------------------------------------------------

/**
 * Press Calculate
 */
void __fastcall TForm1::Button1Click(TObject *Sender) {
  if (!ValueChecks(Form1->LabeledEdit1->Text)) {
    ShowMessage("Invalid value in source string!!!\nCan only be '0' or '1'");
    return;
  }
  Form1->ListBox1->Items->Add("Source line: ");
  Form1->ListBox1->Items->Add(Form1->LabeledEdit1->Text);
  Form1->ListBox1->Items->Add("Groups with an even number of characters: ");
  Execution(Form1->LabeledEdit1->Text);
  Form1->LabeledEdit1->Clear();
  Form1->LabeledEdit1->SetFocus();
}
//---------------------------------------------------------------------------

/**
 * Calculate and output the result.
 */
void Execution(AnsiString s) {
  TStringList* MyList = new TStringList(); //declare
  MyList->Delimiter = L' ';      // designated delimiter
  MyList->DelimitedText = s;     // splitting a string
  int u,n;
  n = MyList->Count;             // define the number of lines of MyList
  for (int i=0;i<n;i++) {
    u=MyList->Strings[i].Length(); // Find out the length of the string
    if (!(u%2))                    // If the length is even
      Form1->ListBox1->Items->Add(MyList->Strings[i]); // Print
  }
  delete MyList;
  Form1->ListBox1->Items->Add("____________________________________________");
}
//---------------------------------------------------------------------------

/**
 * Check data availability
 */
unsigned int ValueChecks(AnsiString s) {
  if (s.IsEmpty()) // If the string is empty, return 0
    return 0;
  if (s.Pos('1')||s.Pos('0')) // If the line is a one or a zero - return 1;
    return 1;
  return 0;
}
