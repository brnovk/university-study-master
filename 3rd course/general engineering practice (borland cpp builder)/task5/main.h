//---------------------------------------------------------------------------
#ifndef mainH
#define mainH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <Buttons.hpp>
#include <ExtCtrls.hpp>
//---------------------------------------------------------------------------
class TForm1 : public TForm {
__published:	// IDE-managed Components
        TPanel *Panel1;
        TBitBtn *BitBtn1;
        TPanel *Panel2;
        TBitBtn *BitBtn2;
        TBitBtn *BitBtn3;
        TMemo *Memo1;
        TLabeledEdit *LabeledEdit1;
        TBitBtn *BitBtn4;
        TLabeledEdit *LabeledEdit2;
        TLabeledEdit *LabeledEdit3;
        TLabeledEdit *LabeledEdit4;
        TLabeledEdit *LabeledEdit5;
        TLabeledEdit *LabeledEdit6;
        TButton *Button1;
        TButton *Button2;
        TButton *Button3;
        void __fastcall FormCreate(TObject *Sender);
        void __fastcall BitBtn1Click(TObject *Sender);
        void __fastcall BitBtn2Click(TObject *Sender);
        void __fastcall BitBtn4Click(TObject *Sender);
        void __fastcall BitBtn3Click(TObject *Sender);
        void __fastcall LabeledEdit1KeyPress(TObject *Sender, char &Key);
        void __fastcall FormShow(TObject *Sender);
        void __fastcall LabeledEdit2KeyPress(TObject *Sender, char &Key);
        void __fastcall LabeledEdit3KeyPress(TObject *Sender, char &Key);
        void __fastcall LabeledEdit4KeyPress(TObject *Sender, char &Key);
        void __fastcall LabeledEdit5KeyPress(TObject *Sender, char &Key);
        void __fastcall Button1Click(TObject *Sender);
        void __fastcall Button2Click(TObject *Sender);
        void __fastcall Button3Click(TObject *Sender);
private:	// User declarations
public:		// User declarations
        __fastcall TForm1(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TForm1 *Form1;
//---------------------------------------------------------------------------
#endif
