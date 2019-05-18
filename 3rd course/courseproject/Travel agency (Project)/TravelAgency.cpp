//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
//---------------------------------------------------------------------------
USEFORM("main.cpp", Form1);
//---------------------------------------------------------------------------
WINAPI WinMain(HINSTANCE, HINSTANCE, LPSTR, int) {

    // Installation of Russian locales to work correctly with date/time
    DateSeparator = '.';
    TimeSeparator = ':';
    LongDateFormat = "d MMMM yyyy 'ã.'";
    ShortDateFormat = "dd.MM.yyyy";
    ShortTimeFormat = "h:mm";
    LongTimeFormat = "h:mm:ss";

    
    try {
        Application->Initialize();
        Application->CreateForm(__classid(TForm1), &Form1);
         Application->Run();
    } catch (Exception &exception) {
        Application->ShowException(&exception);
    } catch (...) {
        try {
            throw Exception("");
        } catch (Exception &exception) {
            Application->ShowException(&exception);
        }
    }
    return 0;
}
//---------------------------------------------------------------------------
