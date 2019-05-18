//---------------------------------------------------------------------------
#ifndef mainH
#define mainH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <Menus.hpp>
#include <ComCtrls.hpp>
#include <Grids.hpp>
#include <ExtCtrls.hpp>
//---------------------------------------------------------------------------
class TForm1 : public TForm {
__published:	// IDE-managed Components
        TMainMenu *MainMenu1;
        TMenuItem *N1;
        TMenuItem *SaveLists;
        TPanel *Panel1;
        TButton *Button1;
        TButton *Button2;
        TButton *Button3;
        TButton *Button4;
        TButton *Button5;
        TPanel *Panel2;
        TButton *Button6;
        TButton *Button7;
        TPageControl *PageControl1;
        TTabSheet *TabSheet1;
        TStringGrid *StringGrid1;
        TTabSheet *TabSheet2;
        TStringGrid *StringGrid2;
        TTabSheet *TabSheet3;
        TLabeledEdit *LabeledEdit1;
        TLabeledEdit *LabeledEdit2;
        TLabeledEdit *LabeledEdit3;
        TLabeledEdit *LabeledEdit4;
        TLabeledEdit *LabeledEdit5;
        TTabSheet *TabSheet4;
        TLabeledEdit *LabeledEdit7;
        TLabeledEdit *LabeledEdit8;
        TLabeledEdit *LabeledEdit9;
        TLabeledEdit *LabeledEdit10;
        TLabeledEdit *LabeledEdit11;
        TLabeledEdit *LabeledEdit6;
        TMenuItem *LoadLists;
        TMenuItem *N3;
        TMenuItem *N4;
        TLabeledEdit *LabeledEdit12;
        TLabeledEdit *LabeledEdit13;
        TMenuItem *N2;
        TMenuItem *N5;
        TMenuItem *N6;
        TMenuItem *N7;
        TMenuItem *N8;
        TMenuItem *N10;
        TMenuItem *N11;
        TMenuItem *N12;
        TMenuItem *N13;
        TMenuItem *N14;
        TMenuItem *N15;
        TMenuItem *N16;
        void __fastcall FormCreate(TObject *Sender);
        void __fastcall Button1Click(TObject *Sender);
        void __fastcall Button2Click(TObject *Sender);
        void __fastcall Button3Click(TObject *Sender);
        void __fastcall Button4Click(TObject *Sender);
        void __fastcall Button5Click(TObject *Sender);
        void __fastcall Button6Click(TObject *Sender);
        void __fastcall Button7Click(TObject *Sender);
        void __fastcall LabeledEdit1KeyPress(TObject *Sender, char &Key);
        void __fastcall N2Click(TObject *Sender);
        void __fastcall N5Click(TObject *Sender);
        void __fastcall N8Click(TObject *Sender);
        void __fastcall N10Click(TObject *Sender);
        void __fastcall N11Click(TObject *Sender);
        void __fastcall N12Click(TObject *Sender);
        void __fastcall N13Click(TObject *Sender);
        void __fastcall N14Click(TObject *Sender);
        void __fastcall N15Click(TObject *Sender);
        void __fastcall N16Click(TObject *Sender);
        void __fastcall N3Click(TObject *Sender);
        void __fastcall N4Click(TObject *Sender);
private:	// User declarations
public:		// User declarations
        __fastcall TForm1(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TForm1 *Form1;
//---------------------------------------------------------------------------
#endif
