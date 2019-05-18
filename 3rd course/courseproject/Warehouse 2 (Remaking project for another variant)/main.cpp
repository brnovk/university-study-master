#include <vcl.h>
#include <stdio.h>
#include <DateUtils.hpp>
#pragma hdrstop
#include "main.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TMainForm *MainForm;

struct listBasic    *endListBasic   =NULL; // Pointer to end main list
struct listResidues *endListResidues=NULL; // Pointer to end list of balances

struct listBasic    *bufListBasic    = NULL;
struct listResidues *bufListResidues = NULL;
//---------------------------------------------------------------------------

/*
 * Description structure item main list (Product information)
 */
struct listBasic  {
	unsigned long productCode;       // Product code
	AnsiString productName;          // Product name
	AnsiString departmentName;       // Department name
	long productPrice;               // Product price
	struct listBasic *nextListBasic; // Pointer to the next element
};
//---------------------------------------------------------------------------

/*
 * Description structure item additional list (Information about balance)
 */
struct listResidues  {
	unsigned long productCode;             // Product code
	unsigned int residualQuantity;         // Balance in warehouse (count)
	struct listResidues *nextListResidues; // Pointer to the next element
};
//---------------------------------------------------------------------------
  /* Function prototypes */
void ReplacementInterface(unsigned short, bool, bool);// Replacement interface
listBasic* choosingRelatedRecord(unsigned int keySecondList,
                                                listBasic **sourceList);
void ShowRecords(listBasic **end);      // Display the list in the StringGrid1
void ShowRecords(listResidues **end);   // Display the list in the StringGrid2
bool ModifyingList(listBasic **working);
bool ModifyingList(listResidues **working);
void RevertingChanges(listBasic **working,listBasic **end);
void RevertingChanges(listResidues **working, listResidues **end);
void RecordSelection(listBasic **working, listBasic **end, int SelTable);
void RecordSelection(listResidues **working, listResidues **end, int SelTable);

//---------------------------------------------------------------------------
__fastcall TMainForm::TMainForm(TComponent* Owner) : TForm(Owner) {
}
//---------------------------------------------------------------------------

void __fastcall TMainForm::FormCreate(TObject *Sender)  {
	MainForm->StringGrid1->ColCount = 4;  // Set number cols in main list
	MainForm->StringGrid2->ColCount = 3;  // Set number cols in additional list
	MainForm->StringGrid3->ColCount = 4;  // Set number cols in query list

	MainForm->StringGrid1->RowCount = 2;  // Set number rows in main list
	MainForm->StringGrid2->RowCount = 2;  // Set number rows in additional list
	MainForm->StringGrid3->RowCount = 2;  // Set number rows in query list

	MainForm->StringGrid1->Options << goRowSelect;//Selects entire row in table
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
	MainForm->StringGrid2->Cells[2][0]="Balance on warehouse";

	MainForm->LabeledEdit5->EditLabel->Caption = "Product name";
	MainForm->LabeledEdit6->EditLabel->Caption = "Product code";
	MainForm->LabeledEdit7->EditLabel->Caption = "Count on warehouse";

	MainForm->StringGrid3->Cells[0][0]="Product code";
	MainForm->StringGrid3->Cells[1][0]="Product name";
	MainForm->StringGrid3->Cells[2][0]="Product price";
	MainForm->StringGrid3->Cells[3][0]="Balance on warehouse";

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
	MainForm->TabSheet3->Caption = "Change information about product";
	MainForm->TabSheet4->Caption = "Change information about balances";
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
	MainForm->StringGrid2->ColWidths[2]=400;

	MainForm->StringGrid3->ColWidths[0]=153;
	MainForm->StringGrid3->ColWidths[1]=201;
	MainForm->StringGrid3->ColWidths[2]=199;
	MainForm->StringGrid3->ColWidths[3]=200;

	MainForm->ComboBox1->Style = csDropDownList;

	HMENU MenuHandle = GetSystemMenu(Handle, false);      // Barring a reversal
	if (MenuHandle)                                       // of the window to 
		DeleteMenu(MenuHandle, SC_MAXIMIZE, MF_BYCOMMAND);// full screen

	Constraints->MaxHeight=533;                          //
	Constraints->MinHeight=533;                          // Ban window resizing
	Constraints->MaxWidth=810;                           //
	Constraints->MinWidth=810;                           //
}
//---------------------------------------------------------------------------

/*
 * Press 'Add' record
 */
void __fastcall TMainForm::Button1Click(TObject *Sender) {
	
	MainForm->Tag = 0; // Set the flag to add entries
	switch (MainForm->PageControl1->ActivePageIndex) {

		case 0: {                                   // Selected main list
			ReplacementInterface(0, false, false);
			struct listBasic *tmp=endListBasic;

			if (tmp==NULL) {                        // If list is empty
				tmp=new listBasic;
				endListBasic=tmp;
				bufListBasic=tmp;
				bufListBasic->nextListBasic=NULL;
			} else {                                // If list is not empty
				tmp=new listBasic;
				(tmp->nextListBasic) = endListBasic;
				endListBasic = tmp;
				bufListBasic = tmp;
			}
			break;
		}

		case 1: {                                   // Selected additional list
			ReplacementInterface(0, true, false);
			struct listResidues *tmp=endListResidues;
			if (tmp==NULL) {                        // If the list is empty
				tmp=new listResidues;
				endListResidues=tmp;
				bufListResidues=tmp;
				bufListResidues->nextListResidues=NULL;
			} else {                                // If the list is not empty
				tmp=new listResidues;
				(tmp->nextListResidues) = endListResidues;
				endListResidues=tmp;
				bufListResidues=tmp;
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
 * Press 'Edit' record
 */
void __fastcall TMainForm::Button2Click(TObject *Sender) {
	
	MainForm->Tag = 1; // Set the flag to edit entries
	switch (MainForm->PageControl1->ActivePageIndex) {
		case 0: {                                   // Selected main list
			RecordSelection(&bufListBasic, &endListBasic,
			MainForm->StringGrid1->Row);
			if (bufListBasic==NULL) {
				ShowMessage("You cannot change selected record!!");
				return;
			}
			ReplacementInterface(0, false, true);
			break;
		}
		case 1: {                                   // Selected additional list
			RecordSelection(&bufListResidues, &endListResidues,
			MainForm->StringGrid2->Row);
			if (bufListResidues==NULL) {
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
void __fastcall TMainForm::Button3Click(TObject *Sender) {

	switch (MainForm->PageControl1->ActivePageIndex) {

		case 0: {                                   // Selected main list
			RecordSelection(&bufListBasic, &endListBasic,
						MainForm->StringGrid1->Row);
			if (bufListBasic==NULL) {
				ShowMessage("You cannot delete selected record!!");
				return;
			}
			if (MessageBox(0,"Are you sure you want to delete selected entry?",
						"Âíèìàíèå!!!", MB_YESNO) == mrYes) {
				if (bufListBasic==endListBasic) { //If delete first element
					endListBasic=endListBasic->nextListBasic;
				} else {
					struct listBasic *tmp=endListBasic;
					while (tmp->nextListBasic!=bufListBasic) {
						tmp=tmp->nextListBasic;
					}
					tmp->nextListBasic=bufListBasic->nextListBasic;
				}
				delete bufListBasic;
				bufListBasic=NULL;
				ShowRecords(&endListBasic);
				ShowRecords(&endListResidues);
			}
			break;
		}

		case 1: {                                   // Selected additional list
			RecordSelection(&bufListResidues, &endListResidues, 
						MainForm->StringGrid2->Row);
			if (bufListResidues==NULL) {
				ShowMessage("You cannot delete selected record!!");
				return;
			}
			if (MessageBox(0,"Are you sure you want to delete selected entry?",
						"Âíèìàíèå!!!", MB_YESNO) == mrYes) {
				if (bufListResidues==endListResidues) {//If delete first element
					endListResidues=endListResidues->nextListResidues;
				} else {
					struct listResidues *tmp=endListResidues;
					while (tmp->nextListResidues!=bufListResidues) {
						tmp=tmp->nextListResidues;
					}
					tmp->nextListResidues=bufListResidues->nextListResidues;
				}
				delete bufListResidues;
				bufListResidues=NULL;
				ShowRecords(&endListResidues);
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
 * Press 'Exit'
 */
void __fastcall TMainForm::Button5Click(TObject *Sender) {
	MainForm->Close();
}
//---------------------------------------------------------------------------

/*
 * Press 'Query' record
 */
void __fastcall TMainForm::Button4Click(TObject *Sender) {
	if (endListBasic==NULL) {
		ShowMessage("List of products is empty!!");
		return;
	}
	ReplacementInterface(2, false, false);
}
//---------------------------------------------------------------------------

/*
 * Press 'Save' (Save the changes)
 */
void __fastcall TMainForm::Button6Click(TObject *Sender) {
	switch (MainForm->PageControl1->ActivePageIndex) {
		case 2:
			if (!ModifyingList(&bufListBasic)) {//If you cannot change value of
				return;
			}
			ReplacementInterface(1, false, false); // Change interface
			ShowRecords(&endListBasic);            // Display the modified list
			break;

		case 3:
			if (!ModifyingList(&bufListResidues)) {//If you cannot change value
				return;
			}
			ReplacementInterface(1, true, false);  // Change interface
			ShowRecords(&endListResidues);         // Display the modified list
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
void __fastcall TMainForm::Button7Click(TObject *Sender) {
	switch (MainForm->PageControl1->ActivePageIndex) {
		case 2:
			if (MainForm->Tag==0) {                  // If you added the record
				RevertingChanges(&bufListBasic,&endListBasic);
				bufListBasic=NULL;
			}
			ReplacementInterface(1, false, false);   // Change interface
			break;

		case 3:
			if (MainForm->Tag==0) {                  // If you added the record
				RevertingChanges(&bufListResidues,&endListResidues);
				bufListResidues=NULL;
			}
			ReplacementInterface(1, true, false);    // Change interface
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
void __fastcall TMainForm::Button8Click(TObject *Sender) {
	MainForm->Label1->Caption = "";
	MainForm->Label2->Caption = "";
	for(int x=1; x<MainForm->StringGrid3->RowCount; x++) {
		MainForm->StringGrid3->Rows[x]->Clear();
	}
	MainForm->StringGrid3->RowCount=2;
	if (MainForm->ComboBox1->ItemIndex == 0) {
		ShowMessage("Select department!!");
		return;
	}
	listBasic* tmpBasic = endListBasic;
	listResidues* tmpResidues;
	int sumResidues;
	int amountDepartment = 0;
	int iR=1,iC;
	while (tmpBasic!=NULL) {
		iC=0;
		if (MainForm->ComboBox1->Text==tmpBasic->departmentName) {
			tmpResidues = endListResidues;
			MainForm->StringGrid3->RowCount++;
			MainForm->StringGrid3->Cells[iC++][iR]=tmpBasic->productCode;
			MainForm->StringGrid3->Cells[iC++][iR]=tmpBasic->productName;
			MainForm->StringGrid3->Cells[iC++][iR]=tmpBasic->productPrice;
			sumResidues = 0;
			while (tmpResidues!=NULL) {
				if (tmpBasic->productCode == tmpResidues->productCode) {
					sumResidues+=tmpResidues->residualQuantity;
				}
				tmpResidues = tmpResidues->nextListResidues;
			}
			MainForm->StringGrid3->Cells[iC++][iR]=sumResidues;
			if (sumResidues!=0) {
				amountDepartment += (tmpBasic->productPrice*sumResidues);
			}
			iR++;
		}
		tmpBasic = tmpBasic->nextListBasic;
		MainForm->Label1->Caption = "Selected department: " 
					+ MainForm->ComboBox1->Text;
		MainForm->Label2->Caption = "Total cost: "+IntToStr(amountDepartment);
	}
}
//---------------------------------------------------------------------------

/*
 * Press 'Back'
 */
void __fastcall TMainForm::Button9Click(TObject *Sender) {
	ReplacementInterface(3, false, false);
}
//---------------------------------------------------------------------------

/*
 * Load a backup copy from file (Press 'Menu'->'File'->'Load list copy from file')
 */
void __fastcall TMainForm::N5Click(TObject *Sender) {
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
		if (f==NULL) {                           // If you cannot open the file
			fclose(f);
			(MessageDlg("Error opening file!\nList products is not restored.",
						mtError, TMsgDlgButtons() << mbYes,0));
		} else {
			struct listBasic *tmp=endListBasic, *buf=NULL;
			if (tmp!=NULL) {                         //
				while ((tmp->nextListBasic)!=NULL) { //
					buf=tmp->nextListBasic;          //
					delete tmp;                      // Delete all entries
					tmp=buf;                         // from RAM
				}                                    //
				delete tmp;                          //
				endListBasic=NULL;                   //
			}
			unsigned short fl=1;
			unsigned short k;
			char s[100];
			unsigned short sym;
			while(!feof(f)) {              // Until the end of the file
				if (fl) {                  // If record - first
					tmp=new listBasic;
					endListBasic=tmp;
					fl=0;
				} else {
					tmp->nextListBasic=new listBasic;
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
			ShowRecords(&endListBasic);
		}
	}

	if (MessageBox(0,"Do you really want restore list of balances from file?"
				"\n(All current records will be deleted)",
				"Attention!", MB_YESNO) == mrYes) {
		FILE *f=NULL;
		f = fopen("d_struct_Residues.dat","rb");
		if (f==NULL) {                           // If you cannot open the file
			fclose(f);
			(MessageDlg("Error opening file!\nBalances list are not restored.",
						mtError, TMsgDlgButtons() << mbYes,0));
		} else {
			struct listResidues *tmp=endListResidues, *buf=NULL;
			if (tmp!=NULL) {                             //
				while ((tmp->nextListResidues)!=NULL) {  //
					buf=tmp->nextListResidues;           //
					delete tmp;                          // Delete all entries
					tmp=buf;                             // from RAM
				}                                        //
				delete tmp;                              //
				endListResidues=NULL;                    //
			}                                            //
			unsigned short fl=1,k;
			char s[100];
			unsigned short sym;
			while(!feof(f)) {              // Until the end of the file
				if (fl) {                  // If record - first
					tmp=new listResidues;
					endListResidues=tmp;
					fl=0;
				} else {
					tmp->nextListResidues=new listResidues;
					tmp=tmp->nextListResidues;
				}
				fread(&tmp->productCode,sizeof(unsigned long),1,f);
				fread(&tmp->residualQuantity,sizeof(unsigned int),1,f);
				tmp->nextListResidues=NULL;
				fread(&k,sizeof(unsigned short),1,f);
				if (k) {                     // End-of-file flag
					break;
				}
			}
			fclose(f);
			ShowRecords(&endListResidues);
		}
	}
}
//---------------------------------------------------------------------------

/*
 * Save a backup copy in file (Press 'Menu'->'File'->'Save list copy in file')
 */
void __fastcall TMainForm::N6Click(TObject *Sender) {
	if ((MainForm->PageControl1->ActivePageIndex==2) ||
				(MainForm->PageControl1->ActivePageIndex==3)) {
		MessageDlg("Please, you must exit edit mode recording!",
					mtError, TMsgDlgButtons() << mbYes,0);
		return;
	}
	if (MessageBox(0,"Are you sure you want to save all the entries to file?",
				"Attention!", MB_YESNO) == mrNo) {
		return;
	}
	if (endListBasic==NULL) {                   // If a record dont exist
		(MessageDlg("Not exist entities in the main list!!\n\n"
					"The list of products is not saved",
					mtError, TMsgDlgButtons() << mbYes,0));
	} else {
		FILE *f=NULL;
		f = fopen("d_struct_Basic.dat","wb");
		if (f==NULL) {                          // If you can not create a file
			fclose(f);
			(MessageDlg("Error creating file!!\nList of products is not saved",
						mtError, TMsgDlgButtons() << mbYes,0));
		} else {
			struct listBasic *tmp=endListBasic;
			unsigned short sym,fl=0;
			do {
				// Write "Product code"
				fwrite(&tmp->productCode,sizeof(unsigned long),1,f);
				// Ñalculate length "Product name"
				sym=tmp->productName.Length()+1;
				// Write length "Product name"
				fwrite(&sym,sizeof(unsigned short),1,f);
				// Write "Product name"
				fwrite((tmp->productName).c_str(),sizeof(char)*sym,1,f);
				// Ñalculate length "Department name"
				sym=tmp->departmentName.Length()+1;
				// Write length "Department name"
				fwrite(&sym,sizeof(unsigned short),1,f);
				// Write "Department name"
				fwrite((tmp->departmentName).c_str(),sizeof(char)*sym,1,f);
				// Write "Product price"
				fwrite(&tmp->productPrice,sizeof(long),1,f);
				tmp=tmp->nextListBasic;
				if (tmp==NULL) {
					fl=1;
				}
				fwrite(&fl,sizeof(unsigned short),1,f);
			} while (tmp!=NULL);
			fclose(f);
		}
	}
	if (endListResidues==NULL) {                   // If a record dont exist
		(MessageDlg("Not exist entities in the balances list!!\n"
					"List of balances not saved",
					mtError, TMsgDlgButtons() << mbYes,0));
	} else {
		FILE *f=NULL;
		f = fopen("d_struct_Residues.dat","wb");
		if (f==NULL) {                          // If you can not create a file
			fclose(f);
			(MessageDlg("Error creating file!!\nBalances list is not saved.",
						mtError, TMsgDlgButtons() << mbYes,0));
		} else {
			struct listResidues *tmp=endListResidues;
			unsigned short fl=0;
			do {
				// Write "Product code"
				fwrite(&tmp->productCode,sizeof(unsigned long),1,f);
				// Write "Balance"
				fwrite(&tmp->residualQuantity,sizeof(unsigned int),1,f);
				tmp=tmp->nextListResidues;
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
 * Press 'Exit'
 */
void __fastcall TMainForm::N4Click(TObject *Sender) {
	MainForm->Close();
}
//---------------------------------------------------------------------------

/*
 * Press 'About'
 */
void __fastcall TMainForm::N3Click(TObject *Sender) {
	MessageDlg("Practical application to the course project on the theme:"
		" \n\"Programming technique using dynamic lists\"."
		"\n\nThis program is a database of warehouse products"
		"\nwith two linked dynamic lists:\n"
		"a list of products and a list balance of products.",
		mtInformation, TMsgDlgButtons() << mbYes,0);
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

		case 0: {                         // If change from 'view' on 'editing'
			MainForm->TabSheet1->TabVisible = false;
			MainForm->TabSheet2->TabVisible = false;
			MainForm->TabSheet5->TabVisible = false;
			MainForm->Panel2->Visible = true;
			MainForm->Panel1->Visible = false;
			if (!lSwitch) {                            // If change 'main' list
				MainForm->TabSheet3->TabVisible = true;
				MainForm->TabSheet4->TabVisible = false;
				if (editing) {                              // If 'edit' record
					MainForm->LabeledEdit1->Text = 
								IntToStr(bufListBasic->productCode);
					MainForm->LabeledEdit2->Text = bufListBasic->productName;
					MainForm->LabeledEdit3->Text = bufListBasic->departmentName;
					MainForm->LabeledEdit4->Text = bufListBasic->productPrice;
				}
				MainForm->LabeledEdit1->SetFocus();
			} else {                             // If change 'additional' list
				MainForm->TabSheet3->TabVisible = false;
				MainForm->TabSheet4->TabVisible = true;
				if (editing) {                              // If 'edit' record
					if (choosingRelatedRecord(bufListResidues->productCode,
								&endListBasic)==NULL) {
						MainForm->LabeledEdit5->Text = "<Not assigned>";
					} else {
						MainForm->LabeledEdit5->Text = 
							(choosingRelatedRecord(
							bufListResidues->productCode, 
							&endListBasic))->productName;
					}
					MainForm->LabeledEdit6->Text = bufListResidues->productCode;
					MainForm->LabeledEdit7->Text =
						IntToStr(bufListResidues->residualQuantity);
				}
				MainForm->LabeledEdit6->SetFocus();
			}
			break;
		}

		case 1: {                         // If change from 'editing' on 'view'
			MainForm->TabSheet1->TabVisible = true;
			MainForm->TabSheet2->TabVisible = true;
			MainForm->Panel2->Visible = false;
			MainForm->Panel1->Visible = true;
			if (!lSwitch) {                            // If change 'main' list
				MainForm->LabeledEdit1->Clear();
				MainForm->LabeledEdit2->Clear();
				MainForm->LabeledEdit3->Clear();
				MainForm->LabeledEdit4->Clear();
				MainForm->TabSheet3->TabVisible = false;
				MainForm->PageControl1->ActivePageIndex = 0;
			} else {                             // If change 'additional' list
				MainForm->LabeledEdit5->Clear();
				MainForm->LabeledEdit6->Clear();
				MainForm->LabeledEdit7->Clear();
				MainForm->TabSheet4->TabVisible = false;
				MainForm->PageControl1->ActivePageIndex = 1;
			}
			break;
		}

		case 2: {                           // If change from 'view' on 'query'
			MainForm->TabSheet1->TabVisible = false;
			MainForm->TabSheet2->TabVisible = false;
			MainForm->TabSheet5->TabVisible = true;
			MainForm->Panel1->Visible = false;
			MainForm->Panel3->Visible = true;
			MainForm->Panel4->Visible = true;
			MainForm->Label1->Caption = "";
			MainForm->Label2->Caption = "";
			for(int x=1; x<MainForm->StringGrid3->RowCount; x++) {
				MainForm->StringGrid3->Rows[x]->Clear();
			}
			MainForm->StringGrid3->RowCount=2;
			MainForm->ComboBox1->Clear();
			MainForm->ComboBox1->Items->Add("Select Department");
			MainForm->ComboBox1->ItemIndex = 0;
			int iTmp;
			listBasic* tmp = endListBasic;
			if (tmp != NULL) {
				while (tmp!=NULL) {
					if (MainForm->ComboBox1->Items->IndexOf(
									tmp->departmentName)==-1) {
						MainForm->ComboBox1->Items->Add(tmp->departmentName);
					}
					tmp = tmp->nextListBasic;
				}
			}
			break;
		}

		case 3: {                           // If change from 'query' on 'view'
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
 * @param **sourceList - pointer end main list;
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
 * @param **end - pointer to the ending of the main list;
 * @param SelTable - selected in a StringGrid string.
 */
void RecordSelection(listBasic **working, listBasic **end, int SelTable) {
	(*working)=(*end);
	if (*end==NULL) {
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
 * @param **end - pointer to the ending of the additional list;
 * @param SelTable - selected in a StringGrid string.
 */
void RecordSelection(listResidues **working, listResidues **end, int SelTable) {
	(*working)=(*end);
	if (*end==NULL) {
		return;
	}
	for (int i=1;i<SelTable;i++) {
		(*working)=(*working)->nextListResidues;
	}
}
//---------------------------------------------------------------------------

/**
 * Function display main list on the screen.
 * (Copy from program memory in StringGrid1)
 * 
 * @param **end - pointer to the end of the main list;
 */
void ShowRecords(listBasic **end) {
	for(int x=1; x<MainForm->StringGrid1->RowCount; x++) {
		MainForm->StringGrid1->Rows[x]->Clear();
	}
	MainForm->StringGrid1->RowCount=2;
	if (!end) {              // If the entry does not exist, exit the function
		return;
	}
	struct listBasic *tmp=NULL;
	tmp=(*end);
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
 * @param **end - pointer to the end of the additional list;
 */
void ShowRecords(listResidues **end) {
	for(int x=1; x<MainForm->StringGrid2->RowCount; x++) {
		MainForm->StringGrid2->Rows[x]->Clear();
	}
	MainForm->StringGrid2->RowCount=2;
	if (!end) {              // If the entry does not exist, exit the function
		return;
	}
	struct listResidues *tmp=NULL;
	tmp=(*end);
	for (int i=0, j=1; tmp!=NULL; j++, i=0) {
		MainForm->StringGrid2->Cells[i++][j]=tmp->productCode;

		if (choosingRelatedRecord(tmp->productCode, &endListBasic)==NULL) {
			MainForm->StringGrid2->Cells[i++][j]="<Not assigned>";
		} else {
			MainForm->StringGrid2->Cells[i++][j] =
				(choosingRelatedRecord(tmp->productCode,&endListBasic))->
				productName;
		}
		MainForm->StringGrid2->Cells[i++][j]=tmp->residualQuantity;
		tmp=tmp->nextListResidues;
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
		StrToInt(MainForm->LabeledEdit4->Text);    // Checking the data entered
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
bool ModifyingList(listResidues **working) {
	try {
		StrToInt(MainForm->LabeledEdit6->Text);    // Checking the data entered
		StrToInt(MainForm->LabeledEdit7->Text);
	} catch ( ... ) {
		(MessageDlg("Missing or incorrect data in the fields!!",
					mtError, TMsgDlgButtons() << mbYes,0));
		return false;
	}
	(*working)->productCode = StrToInt(MainForm->LabeledEdit6->Text);
	(*working)->residualQuantity = StrToInt(MainForm->LabeledEdit7->Text);
	return true;
}
//---------------------------------------------------------------------------

/**
 * Function deletes the last generated value of the main list.
 * (Required if you click "Cancel" If you add a record)
 * 
 * @param **working - buffer pointer to main list;
 * @param **begin - pointer to the end of the main list;
 */
void RevertingChanges(listBasic **working, listBasic **end) {
	struct listBasic *tmp=(*end);
	if (tmp->nextListBasic==NULL) {    // If only the first record was created
		delete endListBasic;
		endListBasic=NULL;
		return;
	}
	(*end)=(*end)->nextListBasic;
	delete tmp;
}
//---------------------------------------------------------------------------

/**
 * Function deletes the last generated value of the additional list.
 * (Required if you click "Cancel" If you add a record)
 * 
 * @param **working - buffer pointer to additional list;
 * @param **begin - pointer to the end of the additional list;
 */
void RevertingChanges(listResidues **working, listResidues **end) {
	struct listResidues *tmp=(*end);
	if (tmp->nextListResidues==NULL) {  // If only the first record was created
		delete endListResidues;
		endListResidues=NULL;
		return;
	}
	(*end)=(*end)->nextListResidues;
	delete tmp;
}
//---------------------------------------------------------------------------

/*
 * Handling keyboard clicks when the input focus is in input fields values.
 * (For all LabeledEdit in the program).
 * (When the Enter key is pressed, focus moves to the next component).
 */
void __fastcall TMainForm::LabeledEdit1KeyPress(TObject *Sender, char &Key) {
	if (Key==13) {
		MainForm->SelectNext(MainForm->ActiveControl,true,true);
	}
}
