//---------------------------------------------------------------------------
// Task 5, Var 4, POIT-31, Baranov V.
// Task: Write a program using the data type "struct". In the program to
// provide for the preservation of the input data to a file and be able to
// read from a previously saved file. In the bus station to store the
// schedule of buses. For each bus trip is listed with its number, the type
// of bus, destination, time of departure and arrival. Display information
// about routes that can are for arrival at destination before a specified
// time.
//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
#include "main.h"
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
MyStruct s[100], st;
int nzap=-1;
//---------------------------------------------------------------------------

__fastcall TForm1::TForm1(TComponent* Owner) : TForm(Owner) {
}
//---------------------------------------------------------------------------

void __fastcall TForm1::FormCreate(TObject *Sender) {
	HMENU MenuHandle = GetSystemMenu(Handle, false);      // Barring a reversal
	if (MenuHandle)                                       // of the window to
		DeleteMenu(MenuHandle, SC_MAXIMIZE, MF_BYCOMMAND);// full screen

	Constraints->MaxHeight=521;                          //
	Constraints->MinHeight=521;                          // Ban window resizing
	Constraints->MaxWidth=673;                           //
	Constraints->MinWidth=673;                           //

	LabeledEdit1->Clear();
	LabeledEdit2->Clear();
	LabeledEdit3->Clear();
	LabeledEdit4->Clear();
	LabeledEdit5->Clear();
	LabeledEdit6->Clear();
	LabeledEdit1->EditLabel->Caption="Bus trip number";
	LabeledEdit2->EditLabel->Caption="Bus type";
	LabeledEdit3->EditLabel->Caption="Destination point";
	LabeledEdit4->EditLabel->Caption="Departure time";
	LabeledEdit5->EditLabel->Caption="Arrival time";
	LabeledEdit6->EditLabel->Caption="Field for indicating time of arrival";
	Memo1->Clear();
	Form1->Caption="Task 5 (POIT-31, Variant 4, Baranov V.)";
}
//---------------------------------------------------------------------------

/**
 * Press Add one struct
 */
void __fastcall TForm1::BitBtn1Click(TObject *Sender) {
	int x;
	if (!TryStrToInt(LabeledEdit1->Text,x)) {
		MessageDlg("Invalid value in field \"Bus trip number\"!",
			mtError,TMsgDlgButtons() << mbYes,0);
		return;
	}
	if (LabeledEdit2->Text.IsEmpty()) {
		MessageDlg("Empty field \"Bus type\"!",
			mtError,TMsgDlgButtons() << mbYes,0);
		return;
	}
	if (LabeledEdit3->Text.IsEmpty()) {
		MessageDlg("Empty field \"Destination point\"!",
			mtError,TMsgDlgButtons() << mbYes,0);
		return;
	}
	if (LabeledEdit4->Text.IsEmpty()) {
		MessageDlg("Empty field \"Departure time\"!",
			mtError,TMsgDlgButtons() << mbYes,0);
		return;
	}
	if (LabeledEdit5->Text.IsEmpty()) {
		MessageDlg("Empty field \"Arrival time\"!",
			mtError,TMsgDlgButtons() << mbYes,0);
		return;
	}
	nzap++;
	s[nzap].flight_number = x;
	s[nzap].type_bus=LabeledEdit2->Text;
	s[nzap].point_destination=LabeledEdit3->Text;
	s[nzap].departure_time=LabeledEdit4->Text;
	s[nzap].arrival_time=LabeledEdit5->Text;
	Memo1->Lines->Add(IntToStr(s[nzap].flight_number)+" "
		+s[nzap].type_bus+" "
		+s[nzap].point_destination+" "
		+s[nzap].departure_time+" "
		+s[nzap].arrival_time);
	LabeledEdit1->Clear();
	LabeledEdit2->Clear();
	LabeledEdit3->Clear();
	LabeledEdit4->Clear();
	LabeledEdit5->Clear();
}
//---------------------------------------------------------------------------

/**
 * Press Query
 */
void __fastcall TForm1::BitBtn2Click(TObject *Sender) {
	if (LabeledEdit6->Text.IsEmpty()) {
		MessageDlg("Empty field \"Field for indicating time of arrival\"!",
			mtError,TMsgDlgButtons() << mbYes,0);
		return;
	}
	Memo1->Lines->Add("\n\nResult:");
	for (int i=0; i<=nzap; i++)
		if (CompareStr(s[i].arrival_time,LabeledEdit6->Text)<0)
			Memo1->Lines->Add(IntToStr(s[i].flight_number)+" "
				+s[i].type_bus+" "
				+s[i].point_destination+" "
				+s[i].departure_time+" "
				+s[i].arrival_time);
	Memo1->Lines->Add("__________________________________________________");
}
//---------------------------------------------------------------------------

/**
 * Press Exit
 */
void __fastcall TForm1::BitBtn4Click(TObject *Sender) {
	Form1->Close();
}
//---------------------------------------------------------------------------

/**
 * Press About
 */
void __fastcall TForm1::BitBtn3Click(TObject *Sender) {
	(MessageDlg("Task ¹5\nVariant 4\nGroup POIT-31\nPerformed"
			": Baranov V.\n\n Task:\nIn the bus station to store the schedule"
			"of buses.\nFor each bus trip is listed with its number, the type"
			"\nof bus, destination, time of departure and arrival.\n"
			"Display information about routes that can are\n"
			"for arrival at destination before a specified time.", 
			mtInformation, TMsgDlgButtons() << mbYes,0));
	Form1->LabeledEdit1->SetFocus();
}
//---------------------------------------------------------------------------

void __fastcall TForm1::LabeledEdit1KeyPress(TObject *Sender, char &Key) {
	if (!(((Key>'0')&&(Key<'9'))||(Key==13)||(Key==8)||(Key==32)))
		Key=0;
	else if (Key==13)
		Form1->LabeledEdit2->SetFocus();
}
//---------------------------------------------------------------------------

void __fastcall TForm1::FormShow(TObject *Sender) {
	Form1->LabeledEdit1->SetFocus();
}
//---------------------------------------------------------------------------

void __fastcall TForm1::LabeledEdit2KeyPress(TObject *Sender, char &Key) {
	if (Key==13)
		Form1->LabeledEdit3->SetFocus();
}
//---------------------------------------------------------------------------

void __fastcall TForm1::LabeledEdit3KeyPress(TObject *Sender, char &Key) {
	if (Key==13)
		Form1->LabeledEdit4->SetFocus();
}
//---------------------------------------------------------------------------

void __fastcall TForm1::LabeledEdit4KeyPress(TObject *Sender, char &Key) {
	if (Key==13)
		Form1->LabeledEdit5->SetFocus();
}
//---------------------------------------------------------------------------

void __fastcall TForm1::LabeledEdit5KeyPress(TObject *Sender, char &Key) {
	if (Key==13) Form1->BitBtn1->SetFocus();
}
//---------------------------------------------------------------------------

/**
 * Press "Memo -> file"
 */
void __fastcall TForm1::Button1Click(TObject *Sender) {
	Memo1->Lines->SaveToFile("data.txt");
}
//---------------------------------------------------------------------------

/**
 * Press "File -> Memo"
 */
void __fastcall TForm1::Button2Click(TObject *Sender) {
	Memo1->Lines->LoadFromFile("data.txt");
}
//---------------------------------------------------------------------------

/**
 * Press "Memo -> List"
 */
void __fastcall TForm1::Button3Click(TObject *Sender) {
	int n,i,j;
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
