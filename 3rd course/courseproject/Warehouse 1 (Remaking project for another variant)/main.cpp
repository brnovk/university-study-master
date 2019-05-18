#include <vcl.h>
#include <stdio.h>
#include <DateUtils.hpp>
#pragma hdrstop
#include "main.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TMainForm *MainForm;

struct listBasic *beginListBasic=NULL;  // Pointer to begin main list
struct listExtra *beginListExtra=NULL;  // Pointer to begin additional list

struct listBasic *bufListBasic=NULL;
struct listExtra *bufListExtra=NULL;
//---------------------------------------------------------------------------

/*
 * Description structure item main list
 */
struct listBasic  {
  unsigned long productCode;       // Product code
  AnsiString productName;          // Product name
  AnsiString departmentName;       // Department name
  long productPrice;               // Product price
  struct listBasic *prevListBasic; // Pointer to the previous element
  struct listBasic *nextListBasic; // Pointer to the next element
};
//---------------------------------------------------------------------------

/*
 * Description structure item additional list
 */
struct listExtra  {
  unsigned long productCode;       // Product code
  unsigned int residualQuantity;   // Balance in warehouse (count)
  AnsiString warehouseName;        // Warehouse name
  struct listExtra *prevListExtra; // Pointer to the previous element
  struct listExtra *nextListExtra; // Pointer to the next element
};
//---------------------------------------------------------------------------
  /* Function prototypes */
void ReplacementInterface(unsigned short, bool, bool);
listBasic* choosingRelatedRecord(unsigned int keySecondList,
                                                listBasic **sourceList);
void RecordSelection(listBasic **working, listBasic **begin, int SelTable);
void RecordSelection(listExtra **working, listExtra **begin, int SelTable);
void ShowRecords(listBasic **begin);
void ShowRecords(listExtra **begin);
bool ModifyingList(listBasic **working);
bool ModifyingList(listExtra **working);
void RevertingChanges(listBasic **working, listBasic **begin);
void RevertingChanges(listExtra **working, listExtra **begin);

//---------------------------------------------------------------------------
__fastcall TMainForm::TMainForm(TComponent* Owner) : TForm(Owner) {
}
//---------------------------------------------------------------------------

void __fastcall TMainForm::FormCreate(TObject *Sender)  {
  MainForm->StringGrid1->ColCount = 4;  // Set number cols in main list
  MainForm->StringGrid2->ColCount = 4;  // Set number cols in additional list
  MainForm->StringGrid3->ColCount = 3;  // Set number cols in query list

  MainForm->StringGrid1->RowCount = 2;  // Set number rows in main list
  MainForm->StringGrid2->RowCount = 2;  // Set number rows in additional list
  MainForm->StringGrid3->RowCount = 2;  // Set number rows in query list

  MainForm->StringGrid1->Options << goRowSelect; // Selects entire row in table
  MainForm->StringGrid2->Options << goRowSelect;

  MainForm->StringGrid1->Cells[0][0]="Product code";
  MainForm->StringGrid1->Cells[1][0]="Product name";
  MainForm->StringGrid1->Cells[2][0]="Department name";
  MainForm->StringGrid1->Cells[3][0]="Product price";

  MainForm->LabeledEdit1->EditLabel->Caption = "Product code";
  MainForm->LabeledEdit2->EditLabel->Caption = "Product name";
  MainForm->LabeledEdit3->EditLabel->Caption = "Department name";
  MainForm->LabeledEdit4->EditLabel->Caption = "Product price";

  MainForm->StringGrid2->Cells[0][0]="Product code";
  MainForm->StringGrid2->Cells[1][0]="Product name";
  MainForm->StringGrid2->Cells[2][0]="Warehouse name";
  MainForm->StringGrid2->Cells[3][0]="Balance on warehouse";

  MainForm->LabeledEdit5->EditLabel->Caption = "Product name";
  MainForm->LabeledEdit6->EditLabel->Caption = "Product code";
  MainForm->LabeledEdit7->EditLabel->Caption = "Count on warehouse";
  MainForm->LabeledEdit8->EditLabel->Caption = "Warehouse name";

  MainForm->StringGrid3->Cells[0][0]="Product code";
  MainForm->StringGrid3->Cells[1][0]="Product name";
  MainForm->StringGrid3->Cells[2][0]="Balance on all warehouses";

  MainForm->LabeledEdit5->Enabled = false;

  MainForm->Button1->Caption = "Add";
  MainForm->Button2->Caption = "Edit";
  MainForm->Button3->Caption = "Delete";
  MainForm->Button4->Caption = "Query";
  MainForm->Button5->Caption = "Exit";
  MainForm->Button6->Caption = "Save";
  MainForm->Button7->Caption = "Cancel";
  MainForm->Button8->Caption = "Execute query";
  MainForm->Button9->Caption = "Back";

  MainForm->TabSheet1->Caption = "Main info about product";
  MainForm->TabSheet2->Caption = "Additional info about product";
  MainForm->TabSheet3->Caption = "Change of info main list";
  MainForm->TabSheet4->Caption = "Change of info additional list";
  MainForm->TabSheet5->Caption = "Query";

  MainForm->Panel2->Visible = false;       // Hide edit pane
  MainForm->Panel3->Visible = false;       // Hide bar query records
  MainForm->Panel4->Visible = false;       // Hide results pane query
  MainForm->TabSheet3->TabVisible = false; // Hide editing tab
  MainForm->TabSheet4->TabVisible = false; // Hide editing tab
  MainForm->TabSheet5->TabVisible = false; // Hide query tab

  MainForm->StringGrid1->ColWidths[0]=153;
  MainForm->StringGrid1->ColWidths[1]=201;
  MainForm->StringGrid1->ColWidths[2]=199;
  MainForm->StringGrid1->ColWidths[3]=200;

  MainForm->StringGrid2->ColWidths[0]=153;
  MainForm->StringGrid2->ColWidths[1]=201;
  MainForm->StringGrid2->ColWidths[2]=199;
  MainForm->StringGrid2->ColWidths[3]=200;

  MainForm->StringGrid3->ColWidths[0]=153;
  MainForm->StringGrid3->ColWidths[1]=201;
  MainForm->StringGrid3->ColWidths[2]=400;

  MainForm->ComboBox1->Style = csDropDownList;

  HMENU MenuHandle = GetSystemMenu(Handle, false);    // Barring a reversal
   if(MenuHandle)                                     // of the window to 
  DeleteMenu(MenuHandle, SC_MAXIMIZE, MF_BYCOMMAND);  // full screen

  Constraints->MaxHeight=533;                          //
  Constraints->MinHeight=533;                          // Ban window resizing
  Constraints->MaxWidth=810;                           //
  Constraints->MinWidth=810;                           //

  MainForm->Label2->Caption = "Query products whose total number in all "
        "warehouses (<100) and";
  MainForm->Label3->Caption = "balance on each of the warehouses (<10).";
}
//---------------------------------------------------------------------------

/*
 * Press 'Add' record
 */
void __fastcall TMainForm::Button1Click(TObject *Sender)  {
  
  MainForm->Tag = 0; // Set the flag to add entries
  switch (MainForm->PageControl1->ActivePageIndex) {

    case 0:  {                                   // Selected main list
      ReplacementInterface(0, false, false);
      struct listBasic *tmp=beginListBasic;
      if (tmp==NULL) {                           // If the list is empty
        tmp=new listBasic;
        beginListBasic=tmp;
        bufListBasic=tmp;
        bufListBasic->prevListBasic=NULL;
      } else {                                   // If the list is not empty
        while ((tmp->nextListBasic)!=NULL)  {
          tmp=tmp->nextListBasic;
        }
        (tmp->nextListBasic)=new listBasic;
        bufListBasic = tmp->nextListBasic;
        bufListBasic->prevListBasic = tmp;
      }
      bufListBasic->nextListBasic=NULL;
      break;
    }

    case 1:  {                                   // Selected additional list
      ReplacementInterface(0, true, false);
      struct listExtra *tmp=beginListExtra;
      if (tmp==NULL) {                           // If the list is empty
        tmp=new listExtra;
        beginListExtra=tmp;
        bufListExtra=tmp;
        bufListExtra->prevListExtra=NULL;
      } else {                                   // If the list is not empty
        while ((tmp->nextListExtra)!=NULL)  {
          tmp=tmp->nextListExtra;
        }
        (tmp->nextListExtra)=new listExtra;
        bufListExtra=tmp->nextListExtra;
        bufListExtra->prevListExtra=tmp;
      }
      bufListExtra->nextListExtra=NULL;
      break;
    }

    default:
      ShowMessage("Unknown error has occurred the program!!!");
      break;
  }
}
//---------------------------------------------------------------------------

/*
 * Press 'Edit' record
 */
void __fastcall TMainForm::Button2Click(TObject *Sender)  {

  MainForm->Tag = 1; // Set the flag to edit entries
  switch (MainForm->PageControl1->ActivePageIndex)  {
    
    case 0:  {                                     // Selected main list
      RecordSelection(&bufListBasic, &beginListBasic,
            MainForm->StringGrid1->Row);
      if (bufListBasic==NULL) {
        ShowMessage("You cannot change selected record!!");
        return;
      }
      ReplacementInterface(0, false, true);
      break;
    }
    
    case 1:  {                                     // Selected additional list
      RecordSelection(&bufListExtra, &beginListExtra,
            MainForm->StringGrid2->Row);
      if (bufListExtra==NULL)  {
        ShowMessage("You cannot change selected record!!");
        return;
      }
      ReplacementInterface(0, true, true);
      break;
    }
    
    default:
      ShowMessage("Unknown error has occurred the program!!!");
      break;
  }
}
//---------------------------------------------------------------------------

/*
 * Press 'Delete' record
 */
void __fastcall TMainForm::Button3Click(TObject *Sender)  {

  switch (MainForm->PageControl1->ActivePageIndex)  {

    case 0:   {                                     // Selected main list
      RecordSelection(&bufListBasic, &beginListBasic, MainForm->StringGrid1->Row);
      if (bufListBasic==NULL)  {
        ShowMessage("You cannot delete selected record!!");
        return;
      }
      if (MessageBox(0,"Are you sure you want to delete the selected entry?",
            "Attention!", MB_YESNO) == mrYes)  {
        if (bufListBasic==beginListBasic) { // If you delete the first element
          beginListBasic=beginListBasic->nextListBasic;
          if (beginListBasic!=NULL) {
            beginListBasic->prevListBasic=NULL;
          }
        } else  {
          struct listBasic *tmp=beginListBasic;
          while (tmp->nextListBasic!=bufListBasic)  {
            tmp=tmp->nextListBasic;
          }
          tmp->nextListBasic=bufListBasic->nextListBasic;
          tmp->prevListBasic=bufListBasic->prevListBasic;
        }
        delete bufListBasic;
        bufListBasic=NULL;
        ShowRecords(&beginListBasic);
        ShowRecords(&beginListExtra);
      }
      break;
    }

    case 1:  {                                     // Selected additional list
      RecordSelection(&bufListExtra, &beginListExtra, MainForm->StringGrid2->Row);
      if (bufListExtra==NULL)  {
        ShowMessage("You cannot delete selected record!!");
        return;
      }
      if (MessageBox(0,"Are you sure you want to delete the selected entry?",
            "Attention!", MB_YESNO) == mrYes)  {
        if (bufListExtra==beginListExtra) { // If you delete the first element
          beginListExtra=beginListExtra->nextListExtra;
          if (beginListExtra!=NULL) {
            beginListExtra->prevListExtra=NULL;
          }
        }
        else  {
          struct listExtra *tmp=beginListExtra;
          while (tmp->nextListExtra!=bufListExtra)  {
            tmp=tmp->nextListExtra;
          }
          tmp->nextListExtra=bufListExtra->nextListExtra;
          tmp->prevListExtra=bufListExtra->prevListExtra;
        }
        delete bufListExtra;
        bufListExtra=NULL;
        ShowRecords(&beginListExtra);
      }
      break;
    }

    default:
      ShowMessage("Unknown error has occurred the program!!!");
      break;
  }
}
//---------------------------------------------------------------------------

/*
 * Press 'Query' record
 */
void __fastcall TMainForm::Button4Click(TObject *Sender)  {
  if (beginListBasic==NULL)  {
    ShowMessage("Main list is empty!!");
    return;
  }
  ReplacementInterface(2, false, false);
}
//---------------------------------------------------------------------------

/*
 * Press 'Exit'
 */
void __fastcall TMainForm::Button5Click(TObject *Sender)  {
  MainForm->Close();
}
//---------------------------------------------------------------------------

/*
 * Press 'Save' (Save the changes)
 */
void __fastcall TMainForm::Button6Click(TObject *Sender)  {
  switch (MainForm->PageControl1->ActivePageIndex)  {
    case 2:
      if (!ModifyingList(&bufListBasic))  {  // If you cannot change value of
        return;
      }
      ReplacementInterface(1, false, false); // Change interface
      ShowRecords(&beginListBasic);          // Display the modified list
      break;

    case 3:
      if (!ModifyingList(&bufListExtra)) {   // If you cannot change value of
        return;
      }
      ReplacementInterface(1, true, false);  // Change interface
      ShowRecords(&beginListExtra);          // Display the modified list
      break;

    default:
      ShowMessage("Unknown error has occurred the program!!!");
      break;
  }
}
//---------------------------------------------------------------------------

/*
 * Press 'Cancel' (Cancel changes)
 */
void __fastcall TMainForm::Button7Click(TObject *Sender)  {
  
  switch (MainForm->PageControl1->ActivePageIndex)  {
    
    case 2:
      if (MainForm->Tag==0) {                       // If you added the record
        RevertingChanges(&bufListBasic,&beginListBasic);
        bufListBasic=NULL;
      }
      ReplacementInterface(1, false, false);        // Change interface
      break;

    case 3:
      if (MainForm->Tag==0) {                       // If you added the record
        RevertingChanges(&bufListExtra,&beginListExtra);
        bufListExtra=NULL;
      }
      ReplacementInterface(1, true, false);         // Change interface
      break;

    default:
      ShowMessage("Unknown error has occurred the program!!!");
      break;
  }
}
//---------------------------------------------------------------------------

/*
 * Press 'Execute query'
 */
void __fastcall TMainForm::Button8Click(TObject *Sender)  {
  MainForm->Label1->Caption = "";
  for(int x=1; x<MainForm->StringGrid3->RowCount; x++)  {
    MainForm->StringGrid3->Rows[x]->Clear();
  }
  MainForm->StringGrid3->RowCount=2;
  if (MainForm->ComboBox1->ItemIndex == 0) {
    ShowMessage("Please, select a department!!");
    return;
  }
  listBasic* tmpBasic = beginListBasic;
  listExtra* tmpExtra;

  TStringList *storageArray = new TStringList;                //
  tmpExtra = beginListExtra;                                  //
  while (tmpExtra!=NULL)  {                                   //
    if (storageArray->IndexOf(tmpExtra->warehouseName)==-1) { //get list of
      storageArray->Add(tmpExtra->warehouseName);             //all warehouses
    }                                                         //
    tmpExtra = tmpExtra->nextListExtra;                       //
  }                                                           //
  int totalResidue, iR=1, iC;;
  TStringList *arrayUniqueItems = new TStringList;
  beginLoop: while (tmpBasic!=NULL)  {
    if (tmpBasic->departmentName==MainForm->ComboBox1->Text) {
      totalResidue = 0;
      tmpExtra = beginListExtra;
      while (tmpExtra!=NULL)  {
        if (tmpBasic->productCode == tmpExtra->productCode) {
          totalResidue+=tmpExtra->residualQuantity;
        }
        tmpExtra = tmpExtra->nextListExtra;
      }
      if (totalResidue<=100) {
        tmpBasic = tmpBasic->nextListBasic;
        continue;
      } else {
        tmpExtra = beginListExtra;
        int tmpRQ;
        for(int i=0;i<storageArray->Count;i++) {
          tmpExtra = beginListExtra;
          tmpRQ=0;
          while (tmpExtra!=NULL) {
            if (tmpBasic->productCode == tmpExtra->productCode) {
              if (tmpExtra->warehouseName==storageArray->Strings[i]) {
                tmpRQ+=tmpExtra->residualQuantity;
              }
            }
            tmpExtra = tmpExtra->nextListExtra;
          }
          if (tmpRQ<11) {
            tmpBasic = tmpBasic->nextListBasic;
            goto beginLoop;
          } else {
            if (arrayUniqueItems->IndexOf(IntToStr(tmpBasic->productCode))==-1) {
              arrayUniqueItems->Add(IntToStr(tmpBasic->productCode));
            } else {
              tmpBasic = tmpBasic->nextListBasic;
              goto beginLoop;
            }
            iC=0;
            MainForm->StringGrid3->RowCount++;
            MainForm->StringGrid3->Cells[iC++][iR]=tmpBasic->productCode;
            MainForm->StringGrid3->Cells[iC++][iR]=tmpBasic->productName;
            MainForm->StringGrid3->Cells[iC++][iR]=totalResidue;
            iR++;
          }
        }
      }
    }
    tmpBasic = tmpBasic->nextListBasic;
  }
  MainForm->Label1->Caption = "Specified department: "+MainForm->ComboBox1->Text;
}
//---------------------------------------------------------------------------

/*
 * Press 'Back'
 */
void __fastcall TMainForm::Button9Click(TObject *Sender)  {
    ReplacementInterface(3, false, false);
}
//---------------------------------------------------------------------------

/*
 * Load a backup copy from file (Press 'Menu'->'File'->'Load list copy from file')
 */
void __fastcall TMainForm::N5Click(TObject *Sender)  {
  if ((MainForm->PageControl1->ActivePageIndex==2)||
        (MainForm->PageControl1->ActivePageIndex==3)) {
    MessageDlg("Please, you must exit edit mode recording!",
          mtError, TMsgDlgButtons() << mbYes,0);
    return;
  }
  if (MessageBox(0,"Do you really want to restore products list from a file?"
        "\n(All current records will be deleted)",
        "Attention!", MB_YESNO) == mrYes) {
    FILE *f=NULL;
    f = fopen("d_struct_Basic.dat","rb");
    if (f==NULL) {                         // If you cannot open the file
      fclose(f);
      (MessageDlg("Error opening file!\nList of products is not restored.",
            mtError, TMsgDlgButtons() << mbYes,0));
    } else {
      struct listBasic *tmp=beginListBasic, *buf=NULL;
      if (tmp!=NULL) {                          //
        while ((tmp->nextListBasic)!=NULL)  {   //
          buf=tmp->nextListBasic;               //
          delete tmp;                           // Delete all entries from RAM
          tmp=buf;                              //
        }                                       //
        delete tmp;                             //
        beginListBasic=NULL;                    //
      }
      unsigned short fl=1;
      unsigned short k;
      char s[100];
      unsigned short sym;
      while(!feof(f)) {            // Until the end of the file
        if (fl) {                  // If record - first
          tmp=new listBasic;
          beginListBasic=tmp;
          tmp->prevListBasic=NULL;
          fl=0;
        } else {
          tmp->nextListBasic=new listBasic;
          (tmp->nextListBasic)->prevListBasic=tmp;
          tmp=tmp->nextListBasic;
        }
        fread(&tmp->productCode,sizeof(unsigned long),1,f);
        fread(&sym,sizeof(unsigned short),1,f);
        fread(s,sizeof(char)*sym,1,f);
        tmp->productName =AnsiString(s);
        fread(&sym,sizeof(unsigned short),1,f);
        fread(s,sizeof(char)*sym,1,f);
        tmp->departmentName =AnsiString(s);
        fread(&tmp->productPrice,sizeof(long),1,f);
        tmp->nextListBasic=NULL;
        fread(&k,sizeof(unsigned short),1,f);
        if (k) {                     // End-of-file flag
          break;
        }
      }
      fclose(f);
      ShowRecords(&beginListBasic);
    }
  }
  if (MessageBox(0,"Do you really want to restore balances list from a file?"
        "\n(All current records will be deleted)",
        "Attention!", MB_YESNO) == mrYes)  {
    FILE *f=NULL;
    f = fopen("d_struct_Extra.dat","rb");
    if (f==NULL) {                         // If you cannot open the file
      fclose(f);
      (MessageDlg("Error opening the file!\nBalances list are not restored.",
      mtError, TMsgDlgButtons() << mbYes,0));
    } else {
      struct listExtra *tmp=beginListExtra, *buf=NULL;
      if (tmp!=NULL)  {                        //
        while ((tmp->nextListExtra)!=NULL)  {  //
          buf=tmp->nextListExtra;              //
          delete tmp;                          //  Delete all entries from RAM
          tmp=buf;                             //
        }                                      //
        delete tmp;                            //
        beginListExtra=NULL;                   //
      }
      unsigned short fl=1,k;
      char s[100];
      unsigned short sym;
      while(!feof(f)) {            // Until the end of the file
        if (fl) {                  // If record - first
          tmp=new listExtra;
          beginListExtra=tmp;
          tmp->prevListExtra=NULL;
          fl=0;
        } else {
          tmp->nextListExtra=new listExtra;
          (tmp->nextListExtra)->prevListExtra=tmp;
          tmp=tmp->nextListExtra;
        }
        fread(&tmp->productCode,sizeof(unsigned long),1,f);
        fread(&sym,sizeof(unsigned short),1,f);
        fread(s,sizeof(char)*sym,1,f);
        tmp->warehouseName =AnsiString(s);
        fread(&tmp->residualQuantity,sizeof(unsigned int),1,f);
        tmp->nextListExtra=NULL;
        fread(&k,sizeof(unsigned short),1,f);
        if (k) {                     // End-of-file flag
          break;
        }
      }
      fclose(f);
      ShowRecords(&beginListExtra);
    }
  }
}
//---------------------------------------------------------------------------

/*
 * Save a backup copy in file (Press 'Menu'->'File'->'Save list copy in file')
 */
void __fastcall TMainForm::N6Click(TObject *Sender)  {

  if ((MainForm->PageControl1->ActivePageIndex==2)||
        (MainForm->PageControl1->ActivePageIndex==3)) {
    MessageDlg("Please, you must exit edit mode recording!",
          mtError, TMsgDlgButtons() << mbYes,0);
    return;
  }
  if (MessageBox(0,"Are you sure you want to save all the entries to a file?",
        "Attention!", MB_YESNO) == mrNo) {
    return;
  }
  if (beginListBasic==NULL) {                   // If a record dont exist
    (MessageDlg("Not exist entities in the main list!!\n"
          "Fly list is not saved.", mtError, TMsgDlgButtons() << mbYes,0));
  } else  {
    FILE *f=NULL;
    f = fopen("d_struct_Basic.dat","wb");
    if (f==NULL)  {                          // If you can not create a file
      fclose(f);
      (MessageDlg("Error creating file!!\nList of products is not saved.",
            mtError, TMsgDlgButtons() << mbYes,0));
    } else {
      struct listBasic *tmp=beginListBasic;
      unsigned short sym,fl=0;
      do {
        fwrite(&tmp->productCode,sizeof(unsigned long),1,f);//Write "Prod. cod"
        sym=tmp->productName.Length()+1;     // Сlculate length "Product name"
        fwrite(&sym,sizeof(unsigned short),1,f); // Write length "Product name"
        fwrite((tmp->productName).c_str(),sizeof(char)*sym,1,f); //Write "P.n."
        sym=tmp->departmentName.Length()+1;//Сlculate length "Department name"
        fwrite(&sym,sizeof(unsigned short),1,f);// Write length "Departm. name"
        fwrite((tmp->departmentName).c_str(),sizeof(char)*sym,1,f);//Write D.n.
        fwrite(&tmp->productPrice,sizeof(long),1,f);     //Write product price
        tmp=tmp->nextListBasic;
        if (tmp==NULL) {
          fl=1;
        }
        fwrite(&fl,sizeof(unsigned short),1,f);
      } while (tmp!=NULL);
      fclose(f);
    }
  }
  if (beginListExtra==NULL) {                   // If a record dont exist
    (MessageDlg("Not exist entities in the balances list!!\n"
          "Fly list is not saved.",
          mtError, TMsgDlgButtons() << mbYes,0));
  } else {
    FILE *f=NULL;
    f = fopen("d_struct_Extra.dat","wb");
    if (f==NULL) {                          // If you can not create a file
      fclose(f);
      (MessageDlg("Error creating file!!\nBalances list is not saved.",
            mtError, TMsgDlgButtons() << mbYes,0));
    } else {
      struct listExtra *tmp=beginListExtra;
      unsigned short sym,fl=0;
      do {
        fwrite(&tmp->productCode,sizeof(unsigned long),1,f);//Write "Prod. cod"
        sym=tmp->warehouseName.Length()+1; // Сlculate length "Warehouse name"
        fwrite(&sym,sizeof(unsigned short),1,f);//Write length "Warehouse name"
        fwrite((tmp->warehouseName).c_str(),sizeof(char)*sym,1,f);// Write W.n.
        fwrite(&tmp->residualQuantity,sizeof(unsigned int),1,f);//Write balance
        tmp=tmp->nextListExtra;
        if (tmp==NULL) {
          fl=1;
        }
        fwrite(&fl,sizeof(unsigned short),1,f);
      } while (tmp!=NULL);
      fclose(f);
    }
  }
}
//---------------------------------------------------------------------------

/*
 * Press 'About'
 */
void __fastcall TMainForm::N3Click(TObject *Sender) {
  MessageDlg("Practical application to the course project on the theme:"
        "\n\"Programming technique using dynamic lists\"."
        "\n\nThis program is a database of warehouse products"
        "\nwith two double linked dynamic lists.",
        mtInformation, TMsgDlgButtons() << mbYes,0);
}
//---------------------------------------------------------------------------

/*
 * Press 'Exit'
 */
void __fastcall TMainForm::N4Click(TObject *Sender)  {
    MainForm->Close();
}
//---------------------------------------------------------------------------

/*
 * Handling keyboard clicks when the input focus is in input fields values.
 * (For all LabeledEdit in the program).
 * (When the Enter key is pressed, focus moves to the next component).
 */
void __fastcall TMainForm::LabeledEdit1KeyPress(TObject *Sender, char &Key)  {
  if (Key==13) {
    MainForm->SelectNext(MainForm->ActiveControl,true,true);
  }
}
//---------------------------------------------------------------------------

/*
 * Function replacement application interface (viewing, editing or query)
 * @param fSwitch 0 - Replacement 'view' on 'edit';
 *                1 - Replacement 'edit' on 'view';
 *                2 - Replacement 'view' on 'query';
 *                3 - Replacement 'query' on 'view';
 * @param lSwitch true - for additional list        (For fSwitch 1 or 0);
 *                false - for main list             (For fSwitch 1 or 0);
 * @param editing true - edit record                (For fSwitch 1 or 0);
 *                false - add record                (For fSwitch 1 or 0);
 */
void ReplacementInterface(unsigned short fSwitch, bool lSwitch, bool editing) {
  
  switch(fSwitch) {

    case 0: {                             // If change from 'view' on 'editing'
      MainForm->TabSheet1->TabVisible = false;
      MainForm->TabSheet2->TabVisible = false;
      MainForm->TabSheet5->TabVisible = false;
      MainForm->Panel2->Visible = true;
      MainForm->Panel1->Visible = false;
      if (!lSwitch) {                                  // If change 'main' list
        MainForm->TabSheet3->TabVisible = true;
        MainForm->TabSheet4->TabVisible = false;
        if (editing) {                                      // If 'edit' record
          MainForm->LabeledEdit1->Text = IntToStr(bufListBasic->productCode);
          MainForm->LabeledEdit2->Text = bufListBasic->productName;
          MainForm->LabeledEdit3->Text = bufListBasic->departmentName;
          MainForm->LabeledEdit4->Text = bufListBasic->productPrice;
        }
        MainForm->LabeledEdit1->SetFocus();
      } else {                                   // If change 'additional' list
        MainForm->TabSheet3->TabVisible = false;
        MainForm->TabSheet4->TabVisible = true;
        if (editing) {                                      // If 'edit' record
          if (choosingRelatedRecord(bufListExtra->productCode,
                &beginListBasic)==NULL) {
            MainForm->LabeledEdit5->Text = "<Not assigned>";
          } else {
            MainForm->LabeledEdit5->Text =
                  (choosingRelatedRecord(bufListExtra->productCode,
                  &beginListBasic))->productName;
          }
          MainForm->LabeledEdit6->Text = bufListExtra->productCode;
          MainForm->LabeledEdit7->Text =
          IntToStr(bufListExtra->residualQuantity);
          MainForm->LabeledEdit8->Text = bufListExtra->warehouseName;

        }
        MainForm->LabeledEdit6->SetFocus();
      }
      break;
    }

    case 1: {                             // If change from 'editing' on 'view'
      MainForm->TabSheet1->TabVisible = true;
      MainForm->TabSheet2->TabVisible = true;
      MainForm->Panel2->Visible = false;
      MainForm->Panel1->Visible = true;
      if (!lSwitch) {                                  // If change 'main' list
        MainForm->LabeledEdit1->Clear();
        MainForm->LabeledEdit2->Clear();
        MainForm->LabeledEdit3->Clear();
        MainForm->LabeledEdit4->Clear();
        MainForm->TabSheet3->TabVisible = false;
        MainForm->PageControl1->ActivePageIndex = 0;
      } else {                                   // If change 'additional' list
        MainForm->LabeledEdit5->Clear();
        MainForm->LabeledEdit6->Clear();
        MainForm->LabeledEdit7->Clear();
        MainForm->LabeledEdit8->Clear();
        MainForm->TabSheet4->TabVisible = false;
        MainForm->PageControl1->ActivePageIndex = 1;
      }
      break;
    }

    case 2: {                               // If change from 'view' on 'query'
      MainForm->TabSheet1->TabVisible = false;
      MainForm->TabSheet2->TabVisible = false;
      MainForm->TabSheet5->TabVisible = true;
      MainForm->Panel1->Visible = false;
      MainForm->Panel3->Visible = true;
      MainForm->Panel4->Visible = true;
      MainForm->Label1->Caption = "";
      for(int x=1; x<MainForm->StringGrid3->RowCount; x++)  {
        MainForm->StringGrid3->Rows[x]->Clear();
      }
      MainForm->StringGrid3->RowCount=2;
      MainForm->ComboBox1->Clear();
      MainForm->ComboBox1->Items->Add("Select department");
      MainForm->ComboBox1->ItemIndex = 0;
      int iTmp;
      listBasic* tmp = beginListBasic;
      if (tmp != NULL) {
        while (tmp!=NULL) {
          if (MainForm->ComboBox1->Items->IndexOf(tmp->departmentName)==-1) {
            MainForm->ComboBox1->Items->Add(tmp->departmentName);
          }
          tmp = tmp->nextListBasic;
        }
      }
      break;
    }

    case 3: {                               // If change from 'query' on 'view'
      MainForm->TabSheet1->TabVisible = true;
      MainForm->TabSheet2->TabVisible = true;
      MainForm->TabSheet5->TabVisible = false;
      MainForm->Panel1->Visible = true;
      MainForm->Panel3->Visible = false;
      MainForm->Panel4->Visible = false;
      MainForm->PageControl1->ActivePageIndex = 1;
      break;
    }

    default: {
      ShowMessage("Unknown error has occurred the program!!!");
      return;
    }
  }
}
//---------------------------------------------------------------------------

/*
 * Function query link record.
 * Search entry in the main list with the specified field value "product code".
 * 
 * @param keySecondList - field value "product code" that will search main list;
 * @param **sourceList - pointer begin main list;
 * @return listBasic* - if found record by condition;
 *         NULL - if not found or source list is empty;
 */
listBasic* choosingRelatedRecord(unsigned int keySecondList, 
      listBasic **sourceList) {
  listBasic* resultPointer=NULL;
  resultPointer = (*sourceList);
  if (resultPointer != NULL) {
    while (resultPointer!=NULL) {
      if (resultPointer->productCode==keySecondList) {
        return resultPointer;
      }
      resultPointer = resultPointer->nextListBasic;
    }
  }
  return NULL;
}
//---------------------------------------------------------------------------

/*
 * Function setting the buffer pointer to main list,
 * based on selected in StringGrid1 record.
 * (For the subsequent removal or editing)
 * 
 * @param **working - buffer pointer to the main list;
 * @param **begin - pointer to the beginning of the main list;
 * @param SelTable - selected in a StringGrid string.
 */
void RecordSelection(listBasic **working, listBasic **begin, int SelTable)  {
  (*working)=(*begin);
  if (*begin==NULL) {
    return;
  }
  for (int i=1;i<SelTable;i++) {
    (*working)=(*working)->nextListBasic;
  }
}
//---------------------------------------------------------------------------

/*
 * Function setting the buffer pointer to additional list,
 * based on selected in StringGrid2 record.
 * (For the subsequent removal or editing)
 * 
 * @param **working - buffer pointer to the additional list;
 * @param **begin - pointer to the beginning of the additional list;
 * @param SelTable - selected in a StringGrid string.
 */
void RecordSelection(listExtra **working, listExtra **begin, int SelTable) {
  (*working)=(*begin);
  if (*begin==NULL) {
    return;
  }
  for (int i=1;i<SelTable;i++)  {
    (*working)=(*working)->nextListExtra;
  }
}
//---------------------------------------------------------------------------

/**
 * Function display main list on the screen.
 * (Copy from program memory in StringGrid1)
 * 
 * @param **begin - pointer to the start of the main list;
 */
void ShowRecords(listBasic **begin) {
  for(int x=1; x<MainForm->StringGrid1->RowCount; x++) {
    MainForm->StringGrid1->Rows[x]->Clear();
  }
  MainForm->StringGrid1->RowCount=2;
  if (!begin) {       // If the entry does not exist, exit the function.
    return;
  }
  struct listBasic *tmp=NULL;
  tmp=(*begin);
  for (int i=0, j=1; tmp!=NULL; j++, i=0) {
    MainForm->StringGrid1->Cells[i++][j]=tmp->productCode;
    MainForm->StringGrid1->Cells[i++][j]=tmp->productName;
    MainForm->StringGrid1->Cells[i++][j]=tmp->departmentName;
    MainForm->StringGrid1->Cells[i++][j]=tmp->productPrice;
    tmp=tmp->nextListBasic;
    MainForm->StringGrid1->RowCount++;
  }
  return;
}
//---------------------------------------------------------------------------

/**
 * Function display additional list on the screen.
 * (Copy from program memory in StringGrid1)
 * 
 * @param **begin - pointer to the start of the additional list;
 */
void ShowRecords(listExtra **begin)  {
  for(int x=1; x<MainForm->StringGrid2->RowCount; x++) {
    MainForm->StringGrid2->Rows[x]->Clear();
  }
  MainForm->StringGrid2->RowCount=2;
  if (!begin) {       // If the entry does not exist, exit the function.
    return;
  }
  struct listExtra *tmp=NULL;
  tmp=(*begin);
  for (int i=0, j=1; tmp!=NULL; j++, i=0) {
    MainForm->StringGrid2->Cells[i++][j]=tmp->productCode;

    if (choosingRelatedRecord(tmp->productCode, &beginListBasic)==NULL) {
      MainForm->StringGrid2->Cells[i++][j]="<Not assigned>";
    } else {
      MainForm->StringGrid2->Cells[i++][j] =
        (choosingRelatedRecord(tmp->productCode,&beginListBasic))->productName;
    }
    MainForm->StringGrid2->Cells[i++][j]=tmp->warehouseName;
    MainForm->StringGrid2->Cells[i++][j]=tmp->residualQuantity;
    tmp=tmp->nextListExtra;
    MainForm->StringGrid2->RowCount++;
  }
  return;
}
//---------------------------------------------------------------------------

/**
 * Changing the record main list
 * @param **working - buffer pointer to main list;
 * @return true - if change values;
 *         false - if not change values;
 */
bool ModifyingList(listBasic **working) {
  try {
    StrToInt(MainForm->LabeledEdit1->Text);    //
    StrToInt(MainForm->LabeledEdit4->Text);    //  Checking the data entered
  } catch ( ... ) {
    (MessageDlg("Missing or incorrect data in the fields!!",
          mtError, TMsgDlgButtons() << mbYes,0));
    return false;
  }
  (*working)->productCode    = StrToInt(MainForm->LabeledEdit1->Text);
  (*working)->productName    = MainForm->LabeledEdit2->Text;
  (*working)->departmentName = MainForm->LabeledEdit3->Text;
  (*working)->productPrice   = StrToInt(MainForm->LabeledEdit4->Text);
  return true;
}
//---------------------------------------------------------------------------

/**
 * Changing the record additional list
 * @param **working - buffer pointer to additional list;
 * @return true - if change values;
 *         false - if not change values;
 */
bool ModifyingList(listExtra **working) {
  try {
    StrToInt(MainForm->LabeledEdit6->Text);  //  Checking the data entered
    StrToInt(MainForm->LabeledEdit7->Text);
  } catch ( ... ) {
    (MessageDlg("Missing or incorrect data in the fields!!",
          mtError, TMsgDlgButtons() << mbYes,0));
    return false;
  }
  (*working)->productCode = StrToInt(MainForm->LabeledEdit6->Text);
  (*working)->residualQuantity = StrToInt(MainForm->LabeledEdit7->Text);
  (*working)->warehouseName = MainForm->LabeledEdit8->Text;
  return true;
}
//---------------------------------------------------------------------------

/**
 * Function deletes the last generated value of the main list.
 * (Required if you click "Cancel" If you add a record)
 * 
 * @param **working - buffer pointer to main list;
 * @param **begin - pointer to the start of the main list;
 */
void RevertingChanges(listBasic **working, listBasic **begin) {
  struct listBasic *tmp=(*begin);
  if (tmp==(*working)) {        // If only the first record was created
    delete beginListBasic;
    beginListBasic=NULL;
    return;
  }
  while ((tmp->nextListBasic)!=(*working)) {
    tmp=tmp->nextListBasic;
  }
  delete tmp->nextListBasic;
  tmp->nextListBasic=NULL;
}
//---------------------------------------------------------------------------

/**
 * Function deletes the last generated value of the additional list.
 * (Required if you click "Cancel" If you add a record)
 * 
 * @param **working - buffer pointer to additional list;
 * @param **begin - pointer to the start of the additional list;
 */
void RevertingChanges(listExtra **working, listExtra **begin) {
  struct listExtra *tmp=(*begin);
  if (tmp==(*working)) {        // If only the first record was created
    delete beginListExtra;
    beginListExtra=NULL;
    return;
  }
  while ((tmp->nextListExtra)!=(*working)) {
    tmp=tmp->nextListExtra;
  }
  delete tmp->nextListExtra;
  tmp->nextListExtra=NULL;
}
