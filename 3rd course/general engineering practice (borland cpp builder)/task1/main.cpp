#include <vcl.h>
#include <math.h>
#pragma hdrstop
#include "main.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TForm1 *Form1;
//---------------------------------------------------------------------------
__fastcall TForm1::TForm1(TComponent* Owner) : TForm(Owner) {
}
//---------------------------------------------------------------------------
void __fastcall TForm1::FormCreate(TObject *Sender) {
	HMENU MenuHandle = GetSystemMenu(Handle, false);      // Barring a reversal
	if (MenuHandle)                                       // of the window to
		DeleteMenu(MenuHandle, SC_MAXIMIZE, MF_BYCOMMAND);// full screen

	Constraints->MaxHeight=230;                          //
	Constraints->MinHeight=230;                          // Ban window resizing
	Constraints->MaxWidth=505;                           //
	Constraints->MinWidth=505;                           //

	Form1->LabeledEdit1->Text = FloatToStr(0.4*pow(10,4));     // Default X
	Form1->LabeledEdit2->Text = FloatToStr(-0.875);            // Default Y
	Form1->LabeledEdit3->Text = FloatToStr(-0.475*pow(10,-3)); // Default Z
}
//---------------------------------------------------------------------------

/**
 * Press "Calculate"
 */
void __fastcall TForm1::Button1Click(TObject *Sender) {
	double x = StrToFloat(Form1->LabeledEdit1->Text);
	double y = StrToFloat(Form1->LabeledEdit2->Text);
	double z = StrToFloat(Form1->LabeledEdit3->Text);
	double w = fabs(cos(x)-cos(y));
	w=pow(w,(1+2*pow(sin(y),2)));
	w=w*(1+z+(pow(z,2)/2)+(pow(z,3)/3)+(pow(z,4)/4));
	Form1->LabeledEdit4->Text = FloatToStr(w);
}
