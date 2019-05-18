#include <vcl.h>
#include <stdio.h>
#include <DateUtils.hpp>
#pragma hdrstop
#include "main.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TForm1 *Form1;

struct flight *BeginFlights=NULL;     // Pointer to beginning of flight list
struct client *BeginCustomers=NULL;   // Pointer to beginning list of clients

struct flight *BUF_Flights=NULL;
struct client *BUF_Customers=NULL;
//---------------------------------------------------------------------------

/**
 * Description structure "Flight"
 */
struct flight {
  TDateTime date;               // Departure date
  TDateTime hour;               // Departure hours
  unsigned int number_flight;   // Flight number
  AnsiString airport_departure; // Airport of departure
  AnsiString airport_arrival;   // Airport arrival
  int free_places_agency;       // Number of free places for travel agencies
  struct flight *next_flight;   // Pointer to the next item in the list
};
//---------------------------------------------------------------------------

/**
 * Description structure "Client"
 */
struct client {
  AnsiString surname;             // Surname of the client
  AnsiString name;                // Name of the client
  TDateTime departure_date;       // Date of departure
  AnsiString resting_place;       // Resting place
  AnsiString airport_arrival;     // Arrival airport
  int number_participants;        // Number of participants
  struct flight *pointer_flight;  // Pointer to the flight
  struct client *next_client;     // Pointer to the next item in the list
};
//---------------------------------------------------------------------------
  /* Function prototypes */
void ReplacementInterface(bool, bool, bool); // Replacement UI main window
void ShowRecords(flight **begin);            // Display a list in StringGrid1
void ShowRecords(client **begin);            // Display a list in StringGrid2
bool ModifyingList(flight **working);
bool ModifyingList(client **working);
void RevertingChanges(flight **working,flight **begin);
void RevertingChanges(client **working, client **begin);
void RecordSelection(flight **working, flight **begin, int SelTable);
void RecordSelection(client **working, client **begin, int SelTable);
void flight_sort(flight **begin, unsigned int num_field);
void client_sort(client **begin, unsigned int num_field);
flight* q_flight_sorted(struct flight** a,unsigned int r,unsigned int n);
client* q_client_sorted(struct client** a,unsigned int r,unsigned int n);
//---------------------------------------------------------------------------
__fastcall TForm1::TForm1(TComponent* Owner) : TForm(Owner){
}
//---------------------------------------------------------------------------

void __fastcall TForm1::FormCreate(TObject *Sender) {
  Form1->StringGrid1->ColCount = 6;  // Set number cols in a list of flights
  Form1->StringGrid2->ColCount = 7;  // Set number cols in a list of clients

  Form1->StringGrid1->RowCount = 2;  // Set number rows in a list of flights
  Form1->StringGrid2->RowCount = 2;  // Set number rows in a list of clients

  Form1->StringGrid1->Options << goRowSelect; // Selects entire row in table
  Form1->StringGrid2->Options << goRowSelect;

  Form1->StringGrid1->Cells[0][0] = "Departure date";
  Form1->StringGrid1->Cells[1][0] = "Departure time";
  Form1->StringGrid1->Cells[2][0] = "Flight number";
  Form1->StringGrid1->Cells[3][0] = "Departure airport";
  Form1->StringGrid1->Cells[4][0] = "Arrival airport";
  Form1->StringGrid1->Cells[5][0] = "Places for agency";

  Form1->LabeledEdit1->EditLabel->Caption = "Departure date";
  Form1->LabeledEdit2->EditLabel->Caption = "Departure time";
  Form1->LabeledEdit3->EditLabel->Caption = "Flight number";
  Form1->LabeledEdit4->EditLabel->Caption = "Departure airport";
  Form1->LabeledEdit5->EditLabel->Caption = "Arrival airport";
  Form1->LabeledEdit6->EditLabel->Caption = "Places for agency";

  Form1->StringGrid2->Cells[0][0] = "Client surname";
  Form1->StringGrid2->Cells[1][0] = "Client name";
  Form1->StringGrid2->Cells[2][0] = "Departure date";
  Form1->StringGrid2->Cells[3][0] = "Resting place";
  Form1->StringGrid2->Cells[4][0] = "Arrival airport";
  Form1->StringGrid2->Cells[5][0] = "Number of participants";
  Form1->StringGrid2->Cells[6][0] = "Flight number";

  Form1->LabeledEdit7->EditLabel->Caption = "Client surname";
  Form1->LabeledEdit8->EditLabel->Caption = "Client name";
  Form1->LabeledEdit9->EditLabel->Caption = "Departure date";
  Form1->LabeledEdit10->EditLabel->Caption = "Resting place";
  Form1->LabeledEdit11->EditLabel->Caption = "Arrival airport";
  Form1->LabeledEdit12->EditLabel->Caption = "Count participants";
  Form1->LabeledEdit13->EditLabel->Caption = "Flight number";

  Form1->LabeledEdit12->Enabled = false;
  Form1->LabeledEdit13->Enabled = false;

  Form1->Button1->Caption = "Add";
  Form1->Button2->Caption = "Edit";
  Form1->Button3->Caption = "Delete";
  Form1->Button4->Caption = "Auto-assign";
  Form1->Button5->Caption = "Exit";
  Form1->Button6->Caption = "Save";
  Form1->Button7->Caption = "Cancel";

  Form1->TabSheet1->Caption = "List of flights";
  Form1->TabSheet2->Caption = "List of clients";
  Form1->TabSheet3->Caption = "Edit flight";
  Form1->TabSheet4->Caption = "Edit client";

  Form1->Panel2->Visible = false;       // Hide edit pane
  Form1->TabSheet3->TabVisible = false; // Hide editing tab
  Form1->TabSheet4->TabVisible = false; // Hide editing tab

  Form1->StringGrid1->ColWidths[0]=80;
  Form1->StringGrid1->ColWidths[1]=80;
  Form1->StringGrid1->ColWidths[2]=80;
  Form1->StringGrid1->ColWidths[3]=202;
  Form1->StringGrid1->ColWidths[4]=202;
  Form1->StringGrid1->ColWidths[5]=111;

  Form1->StringGrid2->ColWidths[0]=109;
  Form1->StringGrid2->ColWidths[1]=95;
  Form1->StringGrid2->ColWidths[2]=80;
  Form1->StringGrid2->ColWidths[3]=115;
  Form1->StringGrid2->ColWidths[4]=170;
  Form1->StringGrid2->ColWidths[5]=100;
  Form1->StringGrid2->ColWidths[6]=85;

  HMENU MenuHandle = GetSystemMenu(Handle, false);     // Barring a reversal
  if (MenuHandle)                                      // of the window to 
    DeleteMenu(MenuHandle, SC_MAXIMIZE, MF_BYCOMMAND); // full screen

  Constraints->MaxHeight=533;                          //
  Constraints->MinHeight=533;                          // Ban window resizing
  Constraints->MaxWidth=810;                           //
  Constraints->MinWidth=810;                           //
}
//---------------------------------------------------------------------------

/**
 * Press 'Add' record
 */
void __fastcall TForm1::Button1Click(TObject *Sender) {

  Form1->Tag = 0; // Set the flag to add entries
  switch (Form1->PageControl1->ActivePageIndex) {

    case 0:     // Selected fly list
      {
        ReplacementInterface(true, false, false);
        struct flight *tmp=BeginFlights;
        if (tmp==NULL) {                               // If the list is empty
          tmp=new flight;    // Create the first instance of structure
          BeginFlights=tmp;  // Sets start address of first list pointer structure
          BUF_Flights=tmp;   // Sets buffer pointer address of the first structure
        } else {                                   // If the list is not empty
          while ((tmp->next_flight)!=NULL)
            tmp=tmp->next_flight;
          (tmp->next_flight) = new flight;  // Assign buffer pointer 
          BUF_Flights=tmp->next_flight;     // address created memory
        }
      }
      BUF_Flights->next_flight=NULL;
      break;

    case 1:     // Selected client list
      {
        ReplacementInterface(true, true, false);
        struct client *tmp=BeginCustomers;
        if (tmp==NULL) {                               // If the list is empty
          tmp=new client;      // Create the first instance of structure
          BeginCustomers=tmp;  // Sets start address of first list pointer structure
          BUF_Customers=tmp;   // Sets buffer pointer address of the first structure
        } else {                                   // If the list is not empty
          while ((tmp->next_client)!=NULL)
            tmp=tmp->next_client;
          (tmp->next_client)=new client;    // Assign buffer pointer 
          BUF_Customers=tmp->next_client;   // address created memory
        }
      }
      BUF_Customers->next_client=NULL;
      BUF_Customers->pointer_flight=NULL;
      BUF_Customers->number_participants=0;
      break;

    default:
      ShowMessage("Unknown error has occurred the program!!!");
      break;
  }
}
//---------------------------------------------------------------------------

/**
 * Press 'Edit' record
 */
void __fastcall TForm1::Button2Click(TObject *Sender) {

  Form1->Tag = 1; // Set the flag to edit entries
  switch (Form1->PageControl1->ActivePageIndex) {
    
    case 0:     // Selected list of flights
      {
        RecordSelection(&BUF_Flights, &BeginFlights, Form1->StringGrid1->Row);
        if (BUF_Flights==NULL) {
          ShowMessage("You cannot change selected record!!");
          return; 
        }
        ReplacementInterface(true, false, true);
      }
      break;

    case 1:     // Selected list of clients
      {
        RecordSelection(&BUF_Customers, &BeginCustomers, Form1->StringGrid2->Row);
        if (BUF_Customers==NULL) { 
          ShowMessage("You cannot change selected record!!");
          return; 
        }
        ReplacementInterface(true, true, true);
      }
      break;
    default:
      ShowMessage("Unknown error has occurred the program!!!");
      break;
  }
}
//---------------------------------------------------------------------------

/**
 * Press 'Delete' record
 */
void __fastcall TForm1::Button3Click(TObject *Sender) {

  switch (Form1->PageControl1->ActivePageIndex) {

    case 0:     // Selected list of flights
      {
        RecordSelection(&BUF_Flights, &BeginFlights, Form1->StringGrid1->Row);
        if (BUF_Flights==NULL) { 
          ShowMessage("You cannot delete selected record!!");
          return; 
        }
        if (MessageBox(0,"Are you sure you want to delete the selected entry?",
        "Attention!", MB_YESNO) == mrYes) {
          struct client *tmp=BeginCustomers;      // Check list of clients,
          while (tmp!=NULL) {                     // with a pointer 
            if (tmp->pointer_flight==BUF_Flights) // to this entry.
              tmp->pointer_flight=NULL;           // Zeroing of these pointers.
            tmp=tmp->next_client;                 //  
          }

          if (BUF_Flights==BeginFlights) // If you delete the first element
            BeginFlights=BeginFlights->next_flight;
          else {
            struct flight *tmp=BeginFlights;
            while (tmp->next_flight!=BUF_Flights)
              tmp=tmp->next_flight;
            tmp->next_flight=BUF_Flights->next_flight;
          }
          delete BUF_Flights;
          BUF_Flights=NULL;
          ShowRecords(&BeginFlights);
          ShowRecords(&BeginCustomers);
        }
      }
    break;

    case 1:     // Selected list of clients
      {
        RecordSelection(&BUF_Customers, &BeginCustomers, Form1->StringGrid2->Row);
        if (BUF_Customers==NULL) { 
          ShowMessage("You cannot delete selected record!!");
          return; 
        }
        if (MessageBox(0,"Are you sure you want to delete the selected entry?",
        "Attention!", MB_YESNO) == mrYes) {
          if (BUF_Customers==BeginCustomers) // If you delete the first element
            BeginCustomers=BeginCustomers->next_client;
          else {
            struct client *tmp=BeginCustomers;
            while (tmp->next_client!=BUF_Customers)
              tmp=tmp->next_client;
            tmp->next_client=BUF_Customers->next_client;
          }
          delete BUF_Customers;
          BUF_Customers=NULL;
          ShowRecords(&BeginCustomers);
        }
      }
      break;

    default:
      ShowMessage("Unknown error has occurred the program!!!");
      break;
  }
}
//---------------------------------------------------------------------------

/**
 * Press 'Auto-assign' (Automatic assignment of flights)
 */
void __fastcall TForm1::Button4Click(TObject *Sender) {

  if ((BeginFlights==NULL)||(BeginCustomers==NULL)) {
    (MessageDlg("One of the lists is empty!!\n(Do not perform auto-assign)",
      mtError, TMsgDlgButtons() << mbYes,0));
    return;
  }
  Form1->PageControl1->ActivePageIndex=1;

  struct client *cle=BeginCustomers;   //
  while(cle!=NULL) {                   // Clear the list client from the old
    if (cle->pointer_flight!=NULL) {   // pointer values.
      cle->pointer_flight=NULL;        //
      cle->number_participants=0;      // And reset the value of the field
    }                                  // "Number of participants".
    cle=cle->next_client;              //
  }

  struct client *kl_tmp=BeginCustomers;
  while(kl_tmp!=NULL) {                   // Until end of the list of clients
    if (kl_tmp->pointer_flight==NULL) {   // If client is not assigned a flight
      struct flight *fl_tmp=BeginFlights;
      while (fl_tmp!=NULL) {              // Until the end a list of flights
        if ((fl_tmp->date==kl_tmp->departure_date) && 
            (fl_tmp->airport_arrival==kl_tmp->airport_arrival)) {

          unsigned int ch=0;
          
          // all the places to travel on this flight
          unsigned int x = fl_tmp->free_places_agency;
          struct client *kl_tmp2=BeginCustomers;
          while(kl_tmp2!=NULL) {
            if (fl_tmp==kl_tmp2->pointer_flight)
              ch++;
            kl_tmp2=kl_tmp2->next_client;
          }
          if (ch<x) {
            kl_tmp->pointer_flight=fl_tmp;         // Fill in the field

            struct client *kl_tmp3=BeginCustomers; //
            while(kl_tmp3!=NULL) {                 // Change the value of field
              if (fl_tmp==kl_tmp3->pointer_flight) // "number of participants"
                kl_tmp3->number_participants=ch+1; // in the entire client list
              kl_tmp3=kl_tmp3->next_client;        //
            }
            break;
          }
        }
        fl_tmp=fl_tmp->next_flight;
      }
    }
    kl_tmp=kl_tmp->next_client;
  }
  ShowRecords(&BeginCustomers);
}
//---------------------------------------------------------------------------

/**
 * Press 'Exit'
 */
void __fastcall TForm1::Button5Click(TObject *Sender) {
  Form1->Close();
}
//---------------------------------------------------------------------------

/**
 * Press 'Save' (Save the changes)
 */
void __fastcall TForm1::Button6Click(TObject *Sender) {
  switch (Form1->PageControl1->ActivePageIndex) {
    case 2:
      if (!ModifyingList(&BUF_Flights))        // If you cannot change value of
        return;
      ReplacementInterface(false, false, false);  // Change interface
      ShowRecords(&BeginFlights);                 // Display the modified list
      break;
    case 3:
      if (!ModifyingList(&BUF_Customers))      // If you cannot change value of
        return;
      ReplacementInterface(false, true, false);   // Change interface
      ShowRecords(&BeginCustomers);               // Display the modified list
      break;
    default:
      ShowMessage("Unknown error has occurred the program!!!");
      break;
  }
}
//---------------------------------------------------------------------------

/**
 * Press 'Cancel' (Cancel changes)
 */
void __fastcall TForm1::Button7Click(TObject *Sender) {
  
  switch (Form1->PageControl1->ActivePageIndex) {
    
    case 2:
      if (Form1->Tag==0) {                          // If you added the record
        RevertingChanges(&BUF_Flights,&BeginFlights);
        BUF_Flights=NULL;
      }
      ReplacementInterface(false, false, false);    // Change interface
      break;
    
    case 3:
      if (Form1->Tag==0) {                          // If you added the record
        RevertingChanges(&BUF_Customers,&BeginCustomers);
        BUF_Customers=NULL;
      }
      ReplacementInterface(false, true, false);     // Change interface
      break;
    
    default:
      ShowMessage("Unknown error has occurred the program!!!");
      break;
  }
}
//---------------------------------------------------------------------------

/**
 * Replacement interface main window to edit entity or view a list entities
 */
void ReplacementInterface(bool FSwitch, bool LSwitch, bool editing) {
  
  if (FSwitch) {                        // If changing from viewing to editing
    Form1->TabSheet1->TabVisible = false;
    Form1->TabSheet2->TabVisible = false;
    Form1->Panel2->Visible = true;
    Form1->Panel1->Visible = false;
    
    if (!LSwitch) {                            // If edit the list of "flying"
      Form1->TabSheet3->TabVisible = true;
      Form1->TabSheet4->TabVisible = false;
      
      if (editing) {                                         // If edit entity
        Form1->LabeledEdit1->Text = DateToStr(BUF_Flights->date);
        Form1->LabeledEdit2->Text = TimeToStr(BUF_Flights->hour);
        Form1->LabeledEdit3->Text = IntToStr(BUF_Flights->number_flight);
        Form1->LabeledEdit4->Text = BUF_Flights->airport_departure;
        Form1->LabeledEdit5->Text = BUF_Flights->airport_arrival;
        Form1->LabeledEdit6->Text = IntToStr(BUF_Flights->free_places_agency);
      }
      Form1->LabeledEdit1->SetFocus();
    
    } else {                                  // If edit the list of "clients"
      Form1->TabSheet3->TabVisible = false;
      Form1->TabSheet4->TabVisible = true;
      
      if (editing) {                                         // If edit entity
        Form1->LabeledEdit7->Text = BUF_Customers->surname;
        Form1->LabeledEdit8->Text = BUF_Customers->name;
        Form1->LabeledEdit9->Text = DateToStr(BUF_Customers->departure_date);
        Form1->LabeledEdit10->Text = BUF_Customers->resting_place;
        Form1->LabeledEdit11->Text = BUF_Customers->airport_arrival;
        Form1->LabeledEdit12->Text = IntToStr(BUF_Customers->number_participants);
        if (BUF_Customers->pointer_flight!=NULL)
          Form1->LabeledEdit13->Text = 
            IntToStr(BUF_Customers->pointer_flight->number_flight);
        else
          Form1->LabeledEdit13->Text = "<Not assigned>";
      }
      Form1->LabeledEdit7->SetFocus();
    }
  
  } else {                              // If changing from editing on preview
    Form1->TabSheet1->TabVisible = true;
    Form1->TabSheet2->TabVisible = true;
    Form1->Panel2->Visible = false;
    Form1->Panel1->Visible = true;
    
    if (!LSwitch) {                           // If edit the list of "flying"
      Form1->LabeledEdit1->Clear();
      Form1->LabeledEdit2->Clear();
      Form1->LabeledEdit3->Clear();
      Form1->LabeledEdit4->Clear();
      Form1->LabeledEdit5->Clear();
      Form1->LabeledEdit6->Clear();
      Form1->TabSheet3->TabVisible = false;
      Form1->PageControl1->ActivePageIndex = 0;
    
    } else {                                  // If edit the list of "clients"
      Form1->LabeledEdit7->Clear();
      Form1->LabeledEdit8->Clear();
      Form1->LabeledEdit9->Clear();
      Form1->LabeledEdit10->Clear();
      Form1->LabeledEdit11->Clear();
      Form1->LabeledEdit12->Clear();
      Form1->LabeledEdit13->Clear();
      Form1->TabSheet4->TabVisible = false;
      Form1->PageControl1->ActivePageIndex = 1;
    }
  }
}
//---------------------------------------------------------------------------

/*
 * Function list of flights display on the screen (in StringGrid1)
 */
void ShowRecords(flight **begin) {
  for(int x=1; x<Form1->StringGrid1->RowCount; x++)
  Form1->StringGrid1->Rows[x]->Clear();

  Form1->StringGrid1->RowCount=2;
  if (!begin)       // If the entry does not exist, exit the function.
    return;
  struct flight *tmp=NULL;
  tmp=(*begin);

  for (int i=0, j=1; tmp!=NULL; j++, i=0) {
    Form1->StringGrid1->Cells[i++][j]=tmp->date;
    Form1->StringGrid1->Cells[i++][j]=tmp->hour;
    Form1->StringGrid1->Cells[i++][j]=tmp->number_flight;
    Form1->StringGrid1->Cells[i++][j]=tmp->airport_departure;
    Form1->StringGrid1->Cells[i++][j]=tmp->airport_arrival;
    Form1->StringGrid1->Cells[i++][j]=tmp->free_places_agency;
    tmp=tmp->next_flight;
    Form1->StringGrid1->RowCount++;
  }
  return;
}
//---------------------------------------------------------------------------

/*
 * Function list of clients display on the screen (in StringGrid2)
 */
void ShowRecords(client **begin) {
  for(int x=1; x<Form1->StringGrid2->RowCount; x++)
  Form1->StringGrid2->Rows[x]->Clear();

  Form1->StringGrid2->RowCount=2;
  if (!begin)       // If the entry does not exist, exit the function.
    return;
  struct client *tmp=NULL;
  tmp=(*begin);
  
  for (int i=0, j=1; tmp!=NULL; j++, i=0) {
    Form1->StringGrid2->Cells[i++][j]=tmp->surname;
    Form1->StringGrid2->Cells[i++][j]=tmp->name;
    Form1->StringGrid2->Cells[i++][j]=tmp->departure_date;
    Form1->StringGrid2->Cells[i++][j]=tmp->resting_place;
    Form1->StringGrid2->Cells[i++][j]=tmp->airport_arrival;
    Form1->StringGrid2->Cells[i++][j]=tmp->number_participants;
    if (tmp->pointer_flight==NULL)
      Form1->StringGrid2->Cells[i++][j] = "<Not assigned>";
    else
      Form1->StringGrid2->Cells[i++][j] = 
        IntToStr(tmp->pointer_flight->number_flight);
    tmp=tmp->next_client;
    Form1->StringGrid2->RowCount++;
  }
  return;
}
//---------------------------------------------------------------------------

/*
 * Changing the record list of flights
 */
bool ModifyingList(flight **working) {
  
  try {
    StrToDate(Form1->LabeledEdit1->Text);    //
    StrToTime(Form1->LabeledEdit2->Text);    //  Checking the data entered
    StrToInt(Form1->LabeledEdit3->Text);     //
    StrToInt(Form1->LabeledEdit6->Text);     //
  } catch ( ... ) {
    (MessageDlg("Missing or incorrect data in the fields!!",
      mtError, TMsgDlgButtons() << mbYes,0));
    return false;
  }
  (*working)->date = StrToDate(Form1->LabeledEdit1->Text);
  (*working)->hour = StrToTime(Form1->LabeledEdit2->Text);
  (*working)->number_flight = StrToInt(Form1->LabeledEdit3->Text);
  (*working)->airport_departure = Form1->LabeledEdit4->Text;
  (*working)->airport_arrival = Form1->LabeledEdit5->Text;
  (*working)->free_places_agency = StrToInt(Form1->LabeledEdit6->Text);
  return true;
}
//---------------------------------------------------------------------------

/*
 * Changing the record list of clients
 */
bool ModifyingList(client **working) {
  
  try {
    StrToDate(Form1->LabeledEdit9->Text);  // Checking the data entered
  } catch ( ... ) {
    (MessageDlg("Missing or incorrect data in the fields!!",
      mtError, TMsgDlgButtons() << mbYes,0));
    return false;
  }
  (*working)->surname = Form1->LabeledEdit7->Text;
  (*working)->name = Form1->LabeledEdit8->Text;
  (*working)->departure_date = StrToDate(Form1->LabeledEdit9->Text);
  (*working)->resting_place = Form1->LabeledEdit10->Text;
  (*working)->airport_arrival = Form1->LabeledEdit11->Text;
  return true;
}
//---------------------------------------------------------------------------

/*
 * Delete created at the end of the list flight structure (If cancel changes)
 */
void RevertingChanges(flight **working, flight **begin) {
  struct flight *tmp=(*begin);
  if (tmp==(*working)) {        // If only the first record was created
    delete BeginFlights;
    BeginFlights=NULL;
    return;
  }
  while ((tmp->next_flight)!=(*working))
    tmp=tmp->next_flight;
  delete tmp->next_flight;
  tmp->next_flight=NULL;
}
//---------------------------------------------------------------------------

/*
 * Delete created at the end of the list client structure (If cancel changes)
 */
void RevertingChanges(client **working, client **begin) {
  struct client *tmp=(*begin);
  if (tmp==(*working)) {        // If only the first record was created
    delete BeginCustomers;
    BeginCustomers=NULL;
    return; 
  }
  while ((tmp->next_client)!=(*working))
    tmp=tmp->next_client;
  delete tmp->next_client;
  tmp->next_client=NULL;
}
//---------------------------------------------------------------------------

/*
 * Insert in buffer selected at StringGrid1 records (flight)
 */
void RecordSelection(flight **working, flight **begin, int SelTable) {
  (*working)=(*begin);
  if (*begin==NULL)
    return;
  for (int i=1;i<SelTable;i++)
    (*working)=(*working)->next_flight;
}
//---------------------------------------------------------------------------

/*
 * Insert in buffer selected at StringGrid2 records (client)
 */
void RecordSelection(client **working, client **begin, int SelTable) {
  (*working)=(*begin);
  if (*begin==NULL)
    return;
  for (int i=1;i<SelTable;i++)
    (*working)=(*working)->next_client;
}
//---------------------------------------------------------------------------

/*
 * Move input focus to the next component
 * (For all components of the labelEdit (and one ComboBox))
 */
void __fastcall TForm1::LabeledEdit1KeyPress(TObject *Sender, char &Key) {
  if (Key==13)
    Form1->SelectNext(Form1->ActiveControl,true,true);
}
//---------------------------------------------------------------------------

/*
 * Save a backup copy in file (Press 'Menu'->'File'->'Save list copy in file')
 */
void __fastcall TForm1::N2Click(TObject *Sender) {
  
  if ((Form1->PageControl1->ActivePageIndex==2)||
          (Form1->PageControl1->ActivePageIndex==3)) { 
    MessageDlg("Please, you must exit edit mode recording!",
          mtError, TMsgDlgButtons() << mbYes,0);
    return; 
  }
  if (MessageBox(0,"Are you sure you want to save all the entries to a file?",
  "Attention!", MB_YESNO) == mrNo)
    return;


  if (BeginFlights==NULL)                   // If a record dont exist
    (MessageDlg("Not exist entities in the list of flights!!\n"
        "Fly list is not saved.", mtError, TMsgDlgButtons() << mbYes,0));
  else {
    FILE *f=NULL;
    f = fopen("d_struct_fl.dat","wb");
    if (f==NULL) {                          // If you can not create a file
      fclose(f);
      (MessageDlg("Error creating file!!\nFly list is not saved.",
            mtError, TMsgDlgButtons() << mbYes,0));
    } else {
      struct flight *tmp=BeginFlights;
      unsigned short sym,fl=0;
      do {
        sym=DateToStr(tmp->date).Length()+1;       //Ñalculate length of chars "Date"
        fwrite(&sym,sizeof(unsigned short),1,f);               // Write length "Date"
        fwrite((DateToStr(tmp->date)).c_str(),sizeof(char)*sym,1,f);   //Write "Date"
        sym=TimeToStr(tmp->hour).Length()+1;       //Ñalculate length of chars "Hour"
        fwrite(&sym,sizeof(unsigned short),1,f);               // Write length "Hour"
        fwrite((TimeToStr(tmp->hour)).c_str(),sizeof(char)*sym,1,f);   //Write "Hour"
        fwrite(&tmp->number_flight,sizeof(unsigned int),1,f); //Write "Flight number"
        sym=tmp->airport_departure.Length()+1; //Ñalculate length "Departure Airport"
        fwrite(&sym,sizeof(unsigned short),1,f);  // Write length "Departure Airport"
        fwrite((tmp->airport_departure).c_str(),sizeof(char)*sym,1,f); //Write "D.A."
        sym=tmp->airport_arrival.Length()+1;     //Ñalculate length "Arrival Airport"
        fwrite(&sym,sizeof(unsigned short),1,f);     //Write length "Arrival Airport"
        fwrite((tmp->airport_arrival).c_str(),sizeof(char)*sym,1,f);   //Write "A.A."
        fwrite(&tmp->free_places_agency,sizeof(int),1,f);//Write "free places agency"
        tmp=tmp->next_flight;
        if (tmp==NULL) 
          fl=1;
        fwrite(&fl,sizeof(unsigned short),1,f);
      } while (tmp!=NULL);
      fclose(f);
    }
  }


  if (BeginCustomers==NULL)                   // If a record dont exist
    (MessageDlg("Not exist entities in the list of clients!!\n"
        "Client list is not saved.", mtError, TMsgDlgButtons() << mbYes,0));
  else {
    FILE *f=NULL;
    f = fopen("d_struct_kl.dat","wb");
    if (f==NULL) {                          // If you can not create a file
      fclose(f);
      (MessageDlg("Error creating file!!\nClient list is not saved.",
            mtError, TMsgDlgButtons() << mbYes,0));
    } else {
      struct client *tmp=BeginCustomers;
      unsigned short sym,fl=0;
      do {
        sym=tmp->surname.Length()+1;     //Ñalculate length of chars "Surname client"
        fwrite(&sym,sizeof(unsigned short),1,f);     // Write length "Surname client"
        fwrite((tmp->surname).c_str(),sizeof(char)*sym,1,f); //Write "Surname client"
        sym=tmp->name.Length()+1;           //Ñalculate length of chars "Name client"
        fwrite(&sym,sizeof(unsigned short),1,f);        // Write length "Name client"
        fwrite((tmp->name).c_str(),sym,1,f);                   // Write "Name client"
        sym=DateToStr(tmp->departure_date).Length()+1;//Ñalc. length "Departure date"
        fwrite(&sym,sizeof(unsigned short),1,f);     // Write length "Departure date"
                                                            // Write "Departure date"
        fwrite((DateToStr(tmp->departure_date)).c_str(),sizeof(char)*sym,1,f);
        sym=tmp->resting_place.Length()+1;  // Ñalculate length chars "Resting place"
        fwrite(&sym,sizeof(unsigned short),1,f);      // Write length "Resting place"
        fwrite((tmp->resting_place).c_str(),sizeof(char)*sym,1,f); //Write "R. place"
        sym=tmp->airport_arrival.Length()+1;    // Ñalculate length "Arrival airport"
        fwrite(&sym,sizeof(unsigned short),1,f);    // Write length "Arrival airport"
        fwrite((tmp->airport_arrival).c_str(),sizeof(char)*sym,1,f); // Write "A. a."
        tmp=tmp->next_client;
        if (tmp==NULL) 
          fl=1;
        fwrite(&fl,sizeof(unsigned short),1,f);
      } while (tmp!=NULL);
      fclose(f);
    }
  }
}
//---------------------------------------------------------------------------

/*
 * Load a backup copy from file (Press 'Menu'->'File'->'Load list copy from file')
 */
void __fastcall TForm1::N5Click(TObject *Sender) {
  if ((Form1->PageControl1->ActivePageIndex==2)||
        (Form1->PageControl1->ActivePageIndex==3)) { 
    MessageDlg("Please, you must exit edit mode recording!",
          mtError, TMsgDlgButtons() << mbYes,0);
    return; 
  }
  if (MessageBox(0,"Do you really want to restore the flight list from a file?"
        "\n(All current records will be deleted)",
        "Attention!", MB_YESNO) == mrYes) {
    FILE *f=NULL;
    f = fopen("d_struct_fl.dat","rb");
    if (f==NULL) {                         // If you cannot open the file
      fclose(f);
      (MessageDlg("Error opening file!\nList of flights is not restored.",
            mtError, TMsgDlgButtons() << mbYes,0));
    } else {
      struct flight *tmp=BeginFlights, *buf=NULL;
      //-----------------------------------
      if (tmp!=NULL) {                     //
        while ((tmp->next_flight)!=NULL) { //
          buf=tmp->next_flight;            //
          delete tmp;                      //
          tmp=buf;                         //   Delete all entries from RAM
        }                                  //
        delete tmp;                        //
        BeginFlights=NULL;                 //
      }                                    //
      //-----------------------------------
      unsigned short fl=1;
      unsigned short k;
      char s[100];
      unsigned short sym;
      while(!feof(f)) {            // Until the end of the file
        if (fl) {                  // If record - first
          tmp=new flight;
          BeginFlights=tmp;
          fl=0; 
        } else {
          tmp->next_flight=new flight;
          tmp=tmp->next_flight; 
        }
        fread(&sym,sizeof(unsigned short),1,f);
        fread(s,sizeof(char)*sym,1,f);
        tmp->date=StrToDate(AnsiString(s));
        fread(&sym,sizeof(unsigned short),1,f);
        fread(s,sizeof(char)*sym,1,f);
        tmp->hour=StrToTime(AnsiString(s));
        fread(&tmp->number_flight,sizeof(unsigned int),1,f);
        fread(&sym,sizeof(unsigned short),1,f);
        fread(s,sizeof(char)*sym,1,f);
        tmp->airport_departure=AnsiString(s);
        fread(&sym,sizeof(unsigned short),1,f);
        fread(s,sizeof(char)*sym,1,f);
        tmp->airport_arrival=AnsiString(s);
        fread(&tmp->free_places_agency,sizeof(int),1,f);
        tmp->next_flight=NULL;
        fread(&k,sizeof(unsigned short),1,f);
        if (k)                     // End-of-file flag
          break;
      }
      fclose(f);
      ShowRecords(&BeginFlights);
    }
  }



  if (MessageBox(0,"Do you really want to restore the clients list from file?"
        "\n(All current records will be deleted)",
        "Attention!", MB_YESNO) == mrYes) {
    FILE *f=NULL;
    f = fopen("d_struct_kl.dat","rb");
    if (f==NULL) {                         // If you cannot open the file
      fclose(f);
      (MessageDlg("Error opening the file!\nClients list are not restored.",
            mtError, TMsgDlgButtons() << mbYes,0));
    } else {
      struct client *tmp=BeginCustomers, *buf=NULL;
      //-----------------------------------
      if (tmp!=NULL) {                     //
        while ((tmp->next_client)!=NULL) { //
          buf=tmp->next_client;            //
          delete tmp;                      //
          tmp=buf;                         //   Delete all entries from RAM
        }                                  //
        delete tmp;                        //
        BeginCustomers=NULL;               //
      }                                    //
      //-----------------------------------
      unsigned short fl=1,k;
      char s[100];
      unsigned short sym;
      while(!feof(f)) {            // Until the end of the file
        if (fl) {                  // If record - first
          tmp=new client;
          BeginCustomers=tmp;
          fl=0; 
        } else { 
          tmp->next_client=new client;
          tmp=tmp->next_client; 
        }

        fread(&sym,sizeof(unsigned short),1,f);
        fread(s,sizeof(char)*sym,1,f);
        tmp->surname=AnsiString(s);
        fread(&sym,sizeof(unsigned short),1,f);
        fread(s,sizeof(char)*sym,1,f);
        tmp->name=AnsiString(s);
        fread(&sym,sizeof(unsigned short),1,f);
        fread(s,sizeof(char)*sym,1,f);
        tmp->departure_date=StrToDate(AnsiString(s));
        fread(&sym,sizeof(unsigned short),1,f);
        fread(s,sizeof(char)*sym,1,f);
        tmp->resting_place=AnsiString(s);
        fread(&sym,sizeof(unsigned short),1,f);
        fread(s,sizeof(char)*sym,1,f);
        tmp->airport_arrival=AnsiString(s);
        tmp->number_participants=0;
        tmp->next_client=NULL;
        tmp->pointer_flight=NULL;
        fread(&k,sizeof(unsigned short),1,f);
        if (k)                     // End-of-file flag
          break;
      }
      fclose(f);
      ShowRecords(&BeginCustomers);
    }
  }
}
//---------------------------------------------------------------------------

/*
 * Press 'Menu'->'Sorting'->'List of flights'->'Departure date'
 */
void __fastcall TForm1::N8Click(TObject *Sender) {
  if ((Form1->PageControl1->ActivePageIndex==2)||
        (Form1->PageControl1->ActivePageIndex==3)) {
    MessageDlg("Please, you must exit edit mode recording!",
          mtError, TMsgDlgButtons() << mbYes,0);
    return;
  }
  flight_sort(&BeginFlights,1);
  ShowRecords(&BeginFlights);
  Form1->PageControl1->ActivePageIndex=0;
}
//---------------------------------------------------------------------------

/*
 * Press 'Menu'->'Sorting'->'List of flights'->'Flight number'
 */
void __fastcall TForm1::N10Click(TObject *Sender) {
  if ((Form1->PageControl1->ActivePageIndex==2)||
        (Form1->PageControl1->ActivePageIndex==3)) {
    MessageDlg("Please, you must exit edit mode recording!",
          mtError, TMsgDlgButtons() << mbYes,0);
    return;
  }
  flight_sort(&BeginFlights,2);
  ShowRecords(&BeginFlights);
  Form1->PageControl1->ActivePageIndex=0;
}
//---------------------------------------------------------------------------

/*
 * Press 'Menu'->'Sorting'->'List of flights'->'Departure airport'
 */
void __fastcall TForm1::N11Click(TObject *Sender) {
  if ((Form1->PageControl1->ActivePageIndex==2)||
        (Form1->PageControl1->ActivePageIndex==3)) {
    MessageDlg("Please, you must exit edit mode recording!",
          mtError, TMsgDlgButtons() << mbYes,0);
    return; 
  }
  flight_sort(&BeginFlights,3);
  ShowRecords(&BeginFlights);
  Form1->PageControl1->ActivePageIndex=0;
}
//---------------------------------------------------------------------------

/*
 * Press 'Menu'->'Sorting'->'List of flights'->'Arrival airport'
 */
void __fastcall TForm1::N12Click(TObject *Sender) {
  if ((Form1->PageControl1->ActivePageIndex==2)||
        (Form1->PageControl1->ActivePageIndex==3)) {
    MessageDlg("Please, you must exit edit mode recording!",
          mtError, TMsgDlgButtons() << mbYes,0);
    return; 
  }
  flight_sort(&BeginFlights,4);
  ShowRecords(&BeginFlights);
  Form1->PageControl1->ActivePageIndex=0;
}
//---------------------------------------------------------------------------

/*
 * Press 'Menu'->'Sorting'->'List of clients'->'Client surname'
 */
void __fastcall TForm1::N13Click(TObject *Sender) {
  if ((Form1->PageControl1->ActivePageIndex==2)||
        (Form1->PageControl1->ActivePageIndex==3)) { 
    MessageDlg("Please, you must exit edit mode recording!",
          mtError, TMsgDlgButtons() << mbYes,0);
    return;
  }
  client_sort(&BeginCustomers,1);
  ShowRecords(&BeginCustomers);
  Form1->PageControl1->ActivePageIndex=1;
}
//---------------------------------------------------------------------------

/*
 * Press 'Menu'->'Sorting'->'List of clients'->'Departure date'
 */
void __fastcall TForm1::N14Click(TObject *Sender) {
  if ((Form1->PageControl1->ActivePageIndex==2)||
        (Form1->PageControl1->ActivePageIndex==3)) { 
    MessageDlg("Please, you must exit edit mode recording!",
          mtError, TMsgDlgButtons() << mbYes,0);
    return;
  }
  client_sort(&BeginCustomers,2);
  ShowRecords(&BeginCustomers);
  Form1->PageControl1->ActivePageIndex=1;
}
//---------------------------------------------------------------------------

/*
 * Press 'Menu'->'Sorting'->'List of clients'->'Resting place'
 */
void __fastcall TForm1::N15Click(TObject *Sender) {
  if ((Form1->PageControl1->ActivePageIndex==2)||
        (Form1->PageControl1->ActivePageIndex==3)) {
    MessageDlg("Please, you must exit edit mode recording!",
          mtError, TMsgDlgButtons() << mbYes,0);
    return;
  }
  client_sort(&BeginCustomers,3);
  ShowRecords(&BeginCustomers);
  Form1->PageControl1->ActivePageIndex=1;
}
//---------------------------------------------------------------------------

/*
 * Press 'Menu'->'Sorting'->'List of clients'->'Arrival airport'
 */
void __fastcall TForm1::N16Click(TObject *Sender) {
  if ((Form1->PageControl1->ActivePageIndex==2)||
        (Form1->PageControl1->ActivePageIndex==3)) {
    MessageDlg("Please, you must exit edit mode recording!",
          mtError, TMsgDlgButtons() << mbYes,0);
    return;
  }
  client_sort(&BeginCustomers,4);
  ShowRecords(&BeginCustomers);
  Form1->PageControl1->ActivePageIndex=1;
}
//---------------------------------------------------------------------------

/*
 * Press 'Menu'->'About'
 */
void __fastcall TForm1::N3Click(TObject *Sender) {
  MessageDlg("Practical application to the course project on the theme:"
    "\n\"Programming technique using dynamic lists\"."
    "\n\nThe program is a database of travel agency"
    "\nwith two simply connected dynamic lists:\n"
    "list of flights and list of clients.\n\n"
    "Completed: student group POIT-31;\n"
    "Baranov V.", mtInformation, TMsgDlgButtons() << mbYes,0);
}
//---------------------------------------------------------------------------

/*
 * Press 'Menu'->'Exit'
 */
void __fastcall TForm1::N4Click(TObject *Sender) {
  Form1->Close();
}
//---------------------------------------------------------------------------

/*
 * Sorting records fly list
 */
void flight_sort(flight **begin, unsigned int num_field) {
  if ((*begin)==NULL) {
    MessageDlg("Not exist enities in the list flights!!\n"
      "(List sorting is not executed)", mtError, TMsgDlgButtons() << mbYes,0);
    return; 
  }
  if ((*begin)->next_flight==NULL) {
    MessageDlg("In fly list only one entity!\n(List sorting is not executed)",
          mtError, TMsgDlgButtons() << mbYes,0);
    return; 
  }
  struct flight *tmp=(*begin);
  unsigned int n=0,sym;
  while (tmp->next_flight!=NULL) {              // Calculating size array
    tmp=tmp->next_flight;
    n++;
  }
  tmp=(*begin);
  struct flight** ar = new struct flight*[n+1]; // Create array pointers
  for (unsigned int i=0;i<n+1;i++,tmp=tmp->next_flight)
    ar[i]=tmp;
  *ar=q_flight_sorted(ar,num_field,n);          // Sort by selected field
  (*begin)=ar[0];
  tmp=ar[0];
  for (unsigned int i=1;i<n+1;i++) {
    tmp->next_flight=ar[i];
    ar[i]=NULL;                  // <--Do not touch it - this is the magic.
    tmp=tmp->next_flight;        //    Without it does not work
  }
  tmp->next_flight=NULL;
  delete []ar;
}
//---------------------------------------------------------------------------

/*
 * Sorting records client list
 */
void client_sort(client **begin, unsigned int num_field) {
  if ((*begin)==NULL) {
    MessageDlg("Not exist enities in the list clients!!\n"
      "(List sorting is not executed)", mtError, TMsgDlgButtons() << mbYes,0);
    return;
  }
  if ((*begin)->next_client==NULL) {
    MessageDlg("In client list only one entity!\n(List sorting is not executed)",
          mtError, TMsgDlgButtons() << mbYes,0);
    return; 
  }
  struct client *tmp=(*begin);
  unsigned int n=0,sym;
  while (tmp->next_client!=NULL) {               // Calculating size array
    tmp=tmp->next_client;
    n++;
  }
  tmp=(*begin);
  struct client** art = new struct client*[n+1]; // Create array pointers
  for (unsigned int i=0;i<n+1;i++,tmp=tmp->next_client)
    art[i]=tmp;
  *art=q_client_sorted(art,num_field,n);         // Sort by selected field
  (*begin)=art[0];
  tmp=art[0];
  for (unsigned int i=1;i<n+1;i++) {
    tmp->next_client=art[i];
    art[i]=NULL;                  // <--Do not touch it - this is the magic.
    tmp=tmp->next_client;         //    Without it does not work
  }
  tmp->next_client=NULL;
  delete []art;
}
//---------------------------------------------------------------------------

/*
 * Algorithm sorting array [flights] (standard exchange method (bubble))
 */
flight* q_flight_sorted(struct flight** a,unsigned int r,unsigned int n) {
  flight* buf=NULL;
  for (unsigned int i=n;i>0;i--)
    for (unsigned int j=0;j<i;j++) {
      switch(r) {
        case 1: 
          if (CompareDateTime(a[j]->date,a[j+1]->date)>0) {
            buf=a[j];
            a[j]=a[j+1];
            a[j+1]=buf;
          };
          break;
        case 2: 
          if ((a[j]->number_flight)>(a[j+1]->number_flight)) {
            buf=a[j];
            a[j]=a[j+1];
            a[j+1]=buf;
          };
          break;
        case 3: 
          if ((a[j]->airport_departure).AnsiCompareIC((a[j+1]->
                  airport_departure))>0) {
            buf=a[j];
            a[j]=a[j+1];
            a[j+1]=buf;
          };
          break;
        case 4: 
          if ((a[j]->airport_arrival).AnsiCompareIC((a[j+1]->
                  airport_arrival))>0) {
            buf=a[j];
            a[j]=a[j+1];
            a[j+1]=buf;
          };
          break;
      }
    }
  return *a;
}
//---------------------------------------------------------------------------

/*
 * Algorithm sorting array [clients] (standard exchange method (bubble))
 */
client* q_client_sorted(struct client** at,unsigned int r,unsigned int n) {
  client* buf=NULL;
  for (unsigned int i=n;i>0;i--)
    for (unsigned int j=0;j<i;j++) {
      switch(r) {
        case 1:
          if ((at[j]->surname).AnsiCompareIC((at[j+1]->surname))>0) { 
            buf=at[j];
            at[j]=at[j+1];
            at[j+1]=buf;
          };
          break;
        case 2:
          if (CompareDateTime(at[j]->departure_date,at[j+1]->departure_date)>0) {
            buf=at[j];
            at[j]=at[j+1];
            at[j+1]=buf; 
          };
          break;
        case 3:
          if ((at[j]->resting_place).AnsiCompareIC((at[j+1]->resting_place))>0) {
            buf=at[j];
            at[j]=at[j+1];
            at[j+1]=buf;
          };
          break;
        case 4:
          if ((at[j]->airport_arrival).AnsiCompareIC((at[j+1]->
                  airport_arrival))>0) {
            buf=at[j];
            at[j]=at[j+1];
            at[j+1]=buf;
          };
          break;
      }
    }
  return *at;
}
