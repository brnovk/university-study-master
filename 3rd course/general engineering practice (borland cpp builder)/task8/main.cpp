//---------------------------------------------------------------------------
// Task 8, Var 4, POIT-31, Baranov V.
// Task: Create application that uses handling of exceptional situations.
//       Convert number from octal number system to hexadecimal.
//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
#include "main.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TForm1 *Form1;
long value;
//---------------------------------------------------------------------------

__fastcall TForm1::TForm1(TComponent* Owner) : TForm(Owner) {
}
//---------------------------------------------------------------------------

void __fastcall TForm1::FormCreate(TObject *Sender) {

  HMENU MenuHandle = GetSystemMenu(Handle, false);      // Barring a reversal
  if (MenuHandle)                                       // of the window to
    DeleteMenu(MenuHandle, SC_MAXIMIZE, MF_BYCOMMAND);  // full screen

  Constraints->MaxHeight=163;                          //
  Constraints->MinHeight=163;                          // Ban window resizing
  Constraints->MaxWidth=355;                           //
  Constraints->MinWidth=355;                           //

  Form1->Edit1->Clear();
  Form1->Edit2->Clear();
  Form1->Edit2->ReadOnly=true;
}
//---------------------------------------------------------------------------

void __fastcall TForm1::Edit1Change(TObject *Sender) {
  char *endptr;
  AnsiString C="01234567";
  if (Edit1->Text!="") {
    try {
      if((Edit1->Text[1]=='-')&&(Edit1->Text.Length()==1))
        return;
      if (C.AnsiPos(Edit1->Text[Edit1->Text.Length()])==0)
        throw EConvertError("");
      value=strtol(Edit1->Text.c_str(),&endptr,8);
      if ((Edit1->Text.Length()>11)&&(value==MaxInt))
        throw EIntOverflow("");
    } catch (EConvertError &) {
    if (Edit1->Text!='-')
      ShowMessage("Only possible digits from '0' to '7'!");
      Edit1->Text=Edit1->Text.SetLength(Edit1->Text.Length()-1);
      Edit1->SelStart=Edit1->Text.Length();
    } catch (EIntOverflow &) {
      ShowMessage("Too big number!");
      Edit1->Text=Edit1->Text.SetLength(Edit1->Text.Length()-1);
      Edit1->SelStart=Edit1->Text.Length();
    } catch (...) {
      ShowMessage("An unknown exception!");
    }
  }
}
//---------------------------------------------------------------------------

/**
 * Press Convert
 */
void __fastcall TForm1::Button1Click(TObject *Sender) {
  if (Form1->Edit1->Text.IsEmpty())
    return;
  int x=0;
  char ss[50],zz[50];
  char *s = ss;
  char *z = zz;
  s=Edit1->Text.c_str();
  while(*s)
    x=x*8+*s++-((*s>='0'&&*s<='9')?'0':'A'-10);
  itoa(x,z,16);
  Edit2->Text=AnsiString(z);
}
//---------------------------------------------------------------------------

/**
 * Press About
 */
void __fastcall TForm1::Button2Click(TObject *Sender) {
  (MessageDlg("Task 8\nVariant 4\nGroup POIT-31\nPerformed"
      ": Baranov V.\n\n Task:\nCreate application that uses handling "
      "of exceptional situations.\nConvert number from octal number "
      "system to hexadecimal.", mtInformation,TMsgDlgButtons() << mbYes,0));
}
//---------------------------------------------------------------------------

/**
 * Press Exit
 */
void __fastcall TForm1::Button3Click(TObject *Sender) {
  Form1->Close();        
}
//---------------------------------------------------------------------------

void __fastcall TForm1::FormShow(TObject *Sender) {
  Form1->Caption="Task 8 (POIT-31, Variant 4, Baranov V.)";
}
