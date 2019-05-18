//---------------------------------------------------------------------------
// Task 6, Var 4, POIT-31, Baranov V.
// Task: Select a task from the task 5. Provide recording raw data to a file,
// and the ability to read from it.The result on the screen and to a file.
//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
#include "main.h"
#include <stdio.h>
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TForm1 *Form1;

typedef struct {
  unsigned int flight_number;    // Bus trip number
  AnsiString type_bus;           // Bus type
  AnsiString point_destination;  // Destination point
  AnsiString departure_time;     // Departure time
  AnsiString arrival_time;       // Arrival time
} MyStruct;
MyStruct s[100];
int nzap=0;
FILE *Fs;
//---------------------------------------------------------------------------

__fastcall TForm1::TForm1(TComponent* Owner) : TForm(Owner) {
}
//---------------------------------------------------------------------------

void __fastcall TForm1::FormCreate(TObject *Sender) {

  HMENU MenuHandle = GetSystemMenu(Handle, false);      // Barring a reversal
  if (MenuHandle)                                       // of the window to
    DeleteMenu(MenuHandle, SC_MAXIMIZE, MF_BYCOMMAND);  // full screen

  Constraints->MaxHeight=538;                          //
  Constraints->MinHeight=538;                          // Ban window resizing
  Constraints->MaxWidth=675;                           //
  Constraints->MinWidth=675;                           //

  Edit1->Clear();
  Edit2->Clear();
  Edit3->Clear();
  Edit4->Clear();
  Edit5->Clear();
  Label2->Caption="Bus trip number:";
  Label3->Caption="Bus type:";
  Label4->Caption="Destination point:";
  Label5->Caption="Departure time:";
  Label6->Caption="Arrival time:";
  LabeledEdit1->EditLabel->Caption="Field for indicating time of arrival:";
  Memo1->Clear();
  Button1->Hide();
  Form1->Caption="Task 6 (POIT-31, Variant 4, Baranov V.)";
}
//---------------------------------------------------------------------------

/**
 * Press Create file
 */
void __fastcall TForm1::Button2Click(TObject *Sender) {
  OpenDialog1->Title="New File";
  if (OpenDialog1->Execute()) {
    char *FileNameS= OpenDialog1->FileName.c_str();
    if ((Fs=fopen(FileNameS,"wb"))==NULL) {
      ShowMessage("File no created");
      return;
    }
    Button1->Show();
  }
}
//---------------------------------------------------------------------------

/**
 * Press Add info
 */
void __fastcall TForm1::Button1Click(TObject *Sender) {
  int x;
  if (!TryStrToInt(Edit1->Text,x)) {
    MessageDlg("Invalid value in field \"Bus trip number\"!",
          mtError,TMsgDlgButtons() << mbYes,0);
    return;
  }
  if (Edit2->Text.IsEmpty()) {
    MessageDlg("Empty field \"Bus type\"!",
          mtError,TMsgDlgButtons() << mbYes,0);
    return;
  }
  if (Edit3->Text.IsEmpty()) {
    MessageDlg("Empty field \"Destination point\"!",
          mtError,TMsgDlgButtons() << mbYes,0);
    return;
  }
  if (Edit4->Text.IsEmpty()) {
    MessageDlg("Empty field \"Departure time\"!",
          mtError,TMsgDlgButtons() << mbYes,0);
    return;
  }
  if (Edit5->Text.IsEmpty()) {
    MessageDlg("Empty field \"Arrival time\"!",
          mtError,TMsgDlgButtons() << mbYes,0);
    return;
  }

  s[nzap].flight_number=x;
  s[nzap].type_bus=Edit2->Text.c_str();
  s[nzap].point_destination=Edit3->Text;
  s[nzap].departure_time=Edit4->Text;
  s[nzap].arrival_time=Edit5->Text;
  Memo1->Lines->Add(IntToStr(s[nzap].flight_number)+" "
        +AnsiString(s[nzap].type_bus)+" "
        +AnsiString(s[nzap].point_destination)+" "
        +AnsiString(s[nzap].departure_time)+" "
        +AnsiString(s[nzap].arrival_time)+" ");
  fwrite(&s[nzap],sizeof(MyStruct),1,Fs);
  nzap++;
  Edit1->Clear();
  Edit2->Clear();
  Edit3->Clear();
  Edit4->Clear();
  Edit5->Clear();
}
//---------------------------------------------------------------------------

/**
 * Press Open file
 */
void __fastcall TForm1::Button3Click(TObject *Sender) {
  OpenDialog1->Title="Open File";
  if (OpenDialog1->Execute()) {
    char *FileNameS= OpenDialog1->FileName.c_str();
    if ((Fs=fopen(FileNameS,"rb"))==NULL) {
      ShowMessage("File is not opened");
      return;
    }
    Button1->Show();
    Memo1->Clear();
    nzap=0;
    do {
      fread(&s[nzap],sizeof(MyStruct),1,Fs);
      if (feof(Fs))
        break;
      Memo1->Lines->Add(IntToStr(s[nzap].flight_number)+" "
            +AnsiString(s[nzap].type_bus)+" "
            +AnsiString(s[nzap].point_destination)+" "
            +AnsiString(s[nzap].departure_time)+" "
            +AnsiString(s[nzap].arrival_time)+" ");
      nzap++;
    } while(True);
    Button1->Show();
  }
}
//---------------------------------------------------------------------------

/**
 * Press Sorting
 */
void __fastcall TForm1::Button4Click(TObject *Sender) {
  MyStruct tmp;
  for(int i=0;i<nzap-1;i++)
    for(int j=i;j<nzap;j++)
      if (CompareStr(s[i].arrival_time,s[j].arrival_time)>0) {
        tmp=s[i];
        s[i]=s[j];
        s[j]=tmp;
      }
  Memo1->Clear();
  Memo1->Lines->Add(" Result is sort by field \"Arrival time\":");
  for(int i=0;i<nzap;i++)
    Memo1->Lines->Add(IntToStr(s[i].flight_number)+" "
          +AnsiString(s[i].type_bus)+" "
          +AnsiString(s[i].point_destination)+" "
          +AnsiString(s[i].departure_time)+" "
          +AnsiString(s[i].arrival_time)+" ");
}
//---------------------------------------------------------------------------

/**
 * Press Save result
 */
void __fastcall TForm1::Button5Click(TObject *Sender) {
  SaveDialog1->Title="Save File";
  if (SaveDialog1->Execute()) {
    AnsiString FileNameR = SaveDialog1->FileName;
    Memo1->Lines->SaveToFile(FileNameR);
  }
}
//---------------------------------------------------------------------------

/**
 * Press Exit
 */
void __fastcall TForm1::BitBtn1Click(TObject *Sender) {
  Form1->Close();
}
//---------------------------------------------------------------------------

void __fastcall TForm1::FormClose(TObject *Sender, TCloseAction &Action) {
  fclose(Fs);
}
//---------------------------------------------------------------------------

/**
 * Press Query
 */
void __fastcall TForm1::Button6Click(TObject *Sender) {
  if (LabeledEdit1->Text.IsEmpty()) {
    MessageDlg("Empty field \"Field for indicating time of arrival\"!",
          mtError,TMsgDlgButtons() << mbYes,0);
    return;
  }
  Memo1->Lines->Add("\n\nResult:");
  for (int i=0; i<nzap; i++)
    if (CompareStr(s[i].arrival_time,LabeledEdit1->Text)<0)
      Memo1->Lines->Add(IntToStr(s[i].flight_number)+" "
            +s[i].type_bus+" "
            +s[i].point_destination+" "
            +s[i].departure_time+" "
            +s[i].arrival_time);
  Memo1->Lines->Add("__________________________________________________");
}
//---------------------------------------------------------------------------

/**
 * Press About
 */
void __fastcall TForm1::BitBtn2Click(TObject *Sender) {
  (MessageDlg("Task 6\nVariant 4\nGroup POIT-31\nPerformed"
      ": Baranov V.\n\n Task:\nSelect a task from the task 5.\n"
      "Provide recording raw data to a file,\nand the ability to read from it"
      ".\nThe result on the screen and to a file.", mtInformation,
      TMsgDlgButtons() << mbYes,0));
  Form1->LabeledEdit1->SetFocus();
}
//---------------------------------------------------------------------------

void __fastcall TForm1::FormShow(TObject *Sender) {
  Form1->Edit1->SetFocus();
}
//---------------------------------------------------------------------------

void __fastcall TForm1::Edit1KeyPress(TObject *Sender, char &Key) {
  if (!(((Key>'0')&&(Key<'9'))||(Key==13)||(Key==8)||(Key==32)))
    Key=0;
  else if (Key==13)
    Form1->Edit2->SetFocus();
}
//---------------------------------------------------------------------------

void __fastcall TForm1::Edit2KeyPress(TObject *Sender, char &Key) {
  if (Key==13)
    Form1->Edit3->SetFocus();
}
//---------------------------------------------------------------------------

void __fastcall TForm1::Edit3KeyPress(TObject *Sender, char &Key) {
  if (Key==13)
    Form1->Edit4->SetFocus();
}
//---------------------------------------------------------------------------

void __fastcall TForm1::Edit4KeyPress(TObject *Sender, char &Key) {
  if (Key==13)
    Form1->Edit5->SetFocus();
}
//---------------------------------------------------------------------------

void __fastcall TForm1::Edit5KeyPress(TObject *Sender, char &Key) {
  if (Key==13)
    if (Button1->Visible)
      Form1->Button1->SetFocus();
    else
      Form1->Button2->SetFocus();
}
//---------------------------------------------------------------------------

/**
 * Press "Memo -> file"
 */
void __fastcall TForm1::Button7Click(TObject *Sender) {
  Memo1->Lines->SaveToFile(ExtractFilePath(Application->ExeName)+"data.txt");
}
//---------------------------------------------------------------------------

/**
 * Press "File -> Memo"
 */
void __fastcall TForm1::Button8Click(TObject *Sender) {
  Memo1->Lines->LoadFromFile(ExtractFilePath(Application->ExeName)+"data.txt");
}
//---------------------------------------------------------------------------

/**
 * Press "Memo -> List"
 */
void __fastcall TForm1::Button9Click(TObject *Sender) {
  int n,i,j;//,k=0;
  String v_st1;
  n=Memo1->Lines->Count;
  nzap=n;
  char *pch;
  for (i=0;i<n;i++) {
    v_st1=Memo1->Lines->Strings[i];
    pch=strtok(v_st1.c_str()," ");
    for (j=0;j<5;j++)
      switch (j) {
        case 0:
          s[i].flight_number=StrToInt(pch);pch=strtok(NULL," ");
          break;
        case 1:
          s[i].type_bus=pch;pch=strtok(NULL," ");
          break;
        case 2:
          s[i].point_destination=pch;pch=strtok(NULL," ");
          break;
        case 3:
          s[i].departure_time=pch;pch=strtok(NULL," ");
          break;
        case 4:
          s[i].arrival_time=pch;pch=strtok(NULL," ");
          break;
      }
  }
}
