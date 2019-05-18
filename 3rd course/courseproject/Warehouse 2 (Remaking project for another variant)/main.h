//---------------------------------------------------------------------------
#ifndef mainH
#define mainH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ComCtrls.hpp>
#include <ExtCtrls.hpp>
#include <Menus.hpp>
#include <Grids.hpp>
//---------------------------------------------------------------------------
class TMainForm : public TForm {
__published:	// IDE-managed Components
        TPageControl *PageControl1;
        TPanel *Panel1;
        TPanel *Panel2;
        TMainMenu *MainMenu1;
        TMenuItem *N1;
        TButton *Button1;
        TButton *Button2;
        TButton *Button3;
        TButton *Button4;
        TButton *Button5;
        TButton *Button6;
        TButton *Button7;
        TTabSheet *TabSheet1;
        TTabSheet *TabSheet2;
        TTabSheet *TabSheet3;
        TTabSheet *TabSheet4;
        TStringGrid *StringGrid1;
        TStringGrid *StringGrid2;
        TLabeledEdit *LabeledEdit1;
        TLabeledEdit *LabeledEdit2;
        TLabeledEdit *LabeledEdit3;
        TLabeledEdit *LabeledEdit4;
        TLabeledEdit *LabeledEdit5;
        TLabeledEdit *LabeledEdit6;
        TPanel *Panel3;
        TButton *Button8;
        TButton *Button9;
        TComboBox *ComboBox1;
        TTabSheet *TabSheet5;
        TLabeledEdit *LabeledEdit7;
        TStringGrid *StringGrid3;
        TPanel *Panel4;
        TLabel *Label1;
        TLabel *Label2;
        TMenuItem *N2;
        TMenuItem *N3;
        TMenuItem *N4;
        TMenuItem *N5;
        TMenuItem *N6;
        void __fastcall FormCreate(TObject *Sender);
        void __fastcall Button1Click(TObject *Sender);
        void __fastcall Button2Click(TObject *Sender);
        void __fastcall Button3Click(TObject *Sender);
        void __fastcall Button5Click(TObject *Sender);
        void __fastcall Button4Click(TObject *Sender);
        void __fastcall Button6Click(TObject *Sender);
        void __fastcall Button7Click(TObject *Sender);
        void __fastcall LabeledEdit1KeyPress(TObject *Sender, char &Key);
        void __fastcall Button8Click(TObject *Sender);
        void __fastcall Button9Click(TObject *Sender);
        void __fastcall N5Click(TObject *Sender);
        void __fastcall N6Click(TObject *Sender);
        void __fastcall N4Click(TObject *Sender);
        void __fastcall N3Click(TObject *Sender);
private:	// User declarations
public:		// User declarations
        __fastcall TMainForm(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TMainForm *MainForm;
//---------------------------------------------------------------------------
#endif
