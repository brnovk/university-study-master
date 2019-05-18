//---------------------------------------------------------------------------
#ifndef mainH
#define mainH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ExtCtrls.hpp>
//---------------------------------------------------------------------------
class TForm1 : public TForm {
__published:	// IDE-managed Components
        TButton *Button1;
        TButton *Button2;
        TLabeledEdit *LabeledEdit1;
        TButton *Button3;
        TListBox *ListBox1;
        TButton *Button4;
        void __fastcall Button2Click(TObject *Sender);
        void __fastcall Button3Click(TObject *Sender);
        void __fastcall FormShow(TObject *Sender);
        void __fastcall Button4Click(TObject *Sender);
        void __fastcall LabeledEdit1KeyPress(TObject *Sender, char &Key);
        void __fastcall Button1Click(TObject *Sender);
    void __fastcall FormCreate(TObject *Sender);
private:	// User declarations
public:		// User declarations
        __fastcall TForm1(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TForm1 *Form1;
//---------------------------------------------------------------------------
#endif
