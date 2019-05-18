#include <vcl.h>
#pragma hdrstop
#include "math.h" 
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

	Constraints->MaxHeight=530;                          //
	Constraints->MinHeight=530;                          // Ban window resizing
	Constraints->MaxWidth=600;                           //
	Constraints->MinWidth=525;                           //

	Edit1->Text="-3";         // initial value X1
	Edit2->Text="3";          // initial value X2
	Edit3->Text="10";         // initial value N
	Edit4->Text="0,0001";     // initial value E
	Memo1->Clear();
}
//---------------------------------------------------------------------------

/**
 * Press Calculate
 */
void __fastcall TForm1::Button1Click(TObject *Sender) {

	double x1,x2,x,h,s,f,un,e=0.0001;
	long int N,k;
	x=x1=StrToFloat(Edit1->Text);
	Memo1->Clear();
	Memo1->Lines->Add("Results: ");
	Memo1->Lines->Add("x1="+Edit1->Text);
	x2=StrToFloat(Edit2->Text);
	Memo1->Lines->Add("x2="+Edit2->Text);
	N=StrToInt(Edit3->Text);
	Memo1->Lines->Add("N="+Edit3->Text);
	h=(x2-x1)/N;
	Memo1->Lines->Add("e="+Edit4->Text);

	for(;x<x2+h/2;x+=h) {
		s=1;
		k=1;
		un=log(9)*x;
		while(fabs(un)>e) {
			s+=un;
			k++;
			un*=x*log(9)/k;
		}
		f=pow(9,x);
		Memo1->Lines->Add("For 'X' "+FloatToStrF(x,ffFixed,10,2)+
			" sum="+FloatToStrF(s,ffFixed,16,5)+
			" function="+FloatToStrF(f,ffFixed,16,5));
	}
}
