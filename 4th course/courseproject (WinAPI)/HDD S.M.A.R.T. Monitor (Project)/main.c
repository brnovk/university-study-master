#include <windows.h>

#pragma pack(1)
#include "main.h"
#include "resource.h"

/* function prototype declarations */

int InitApplication(HINSTANCE, char *);
HWND InitInstance(HINSTANCE, int);
LRESULT CALLBACK WndProc(HWND, UINT, WPARAM, LPARAM);
int get_os_version(void);
int do_read_version(HWND, HANDLE, GETVERSIONINPARAMS *);
int do_read_identify(HWND, HANDLE, char, BYTE *);
int do_read_attribute(HWND, HANDLE, char, BYTE *);
int get_selected_disc_number(HWND);
BOOL fillingCombobox(HWND);
char* getNormaliseDrive(int);
void clear_values(HWND hWnd);
void swap_byte(char *, int);

/*
 * @brief  Entry point to the program
 */
int WINAPI WinMain(HINSTANCE hInstance, HINSTANCE hPrevInstance,
        PSTR szCmdLine, int iCmdShow) {
    HWND hwnd;
    MSG msg;

    if (!hPrevInstance) {
        /* Register window class  */
        if (!InitApplication(hInstance, "MAIN")) {
            MessageBox(HWND_DESKTOP, "Error registering window class",
                    "Error", MB_OK | MB_ICONEXCLAMATION);
            return FALSE;
        }
    }

    if ((hwnd = InitInstance(hInstance, iCmdShow)) == NULL) {
        MessageBox(HWND_DESKTOP, "Failed to create window",
                "Error", MB_OK | MB_ICONEXCLAMATION);
        return FALSE;
    }

    /* start message loop  */
    while (GetMessage(&msg, NULL, 0, 0)) {
        if (!IsDialogMessage(hwnd, &msg)) {
            TranslateMessage(&msg);
            DispatchMessage(&msg);
        }
    }

    return (int) msg.wParam;
}

/*
 * @brief  Register window class
 */
int InitApplication(HINSTANCE hInstance, char *class_name) {
    WNDCLASSEX wndclass;

    wndclass.cbSize = sizeof (wndclass);
    wndclass.style = CS_HREDRAW | CS_VREDRAW;
    wndclass.lpfnWndProc = WndProc;
    wndclass.cbClsExtra = 0;
    wndclass.cbWndExtra = DLGWINDOWEXTRA;
    wndclass.hInstance = hInstance;
    wndclass.hIcon = LoadIcon(NULL, IDR_MAINFRAME);
    wndclass.hCursor = LoadCursor(NULL, IDC_ARROW);
    wndclass.hbrBackground = (HBRUSH) GetStockObject(DKGRAY_BRUSH);
    wndclass.lpszMenuName = NULL;
    wndclass.lpszClassName = class_name;
    wndclass.hIconSm = LoadIcon(hInstance, IDR_MAINFRAME);

    return RegisterClassEx(&wndclass);
}

HWND InitInstance(HINSTANCE hInstance, int iCmdShow) {
    HWND hWnd;

    /* Create the Window */
    hWnd = CreateDialog(hInstance, "MAIN", 0, NULL);
    if (hWnd == NULL)
        return NULL;

    ShowWindow(hWnd, iCmdShow);
    UpdateWindow(hWnd);

    return hWnd;
}

/*
 * @brief  Main Window Procedure
 */
LRESULT CALLBACK WndProc(HWND hWnd, UINT msg, WPARAM wParam, LPARAM lParam) {
    static GETVERSIONINPARAMS ver_parm;
    static BYTE identify[sizeof (SENDCMDOUTPARAMS) + SMART_SIZE];
    static BYTE attribute[sizeof (SENDCMDOUTPARAMS) + SMART_SIZE];
    HANDLE hDevice;
    int v;
    static int selectedDiscNumber;

    switch (msg) {
        case WM_COMMAND: /* Message when selecting the menu and buttons, etc. */
            switch (LOWORD(wParam)) {
                
                case IDOK: /* Button "Refresh" */
                    selectedDiscNumber = get_selected_disc_number(hWnd);
                    if ((v = get_os_version()) == 2) { /* Win/NT/2K/XP/7 or old */
                        hDevice = CreateFile(
                        getNormaliseDrive(selectedDiscNumber),
                        GENERIC_READ | GENERIC_WRITE,
                        FILE_SHARE_READ | FILE_SHARE_WRITE,
                        NULL,
                        OPEN_EXISTING, 0, NULL
                        );
                    } else {
                        break; /* unknown or non support version */
                    }
                    if (hDevice == INVALID_HANDLE_VALUE) {
                        MessageBox(hWnd, "Can't open",
                                "Error", MB_OK | MB_ICONEXCLAMATION);
                        break;
                    }
                    if (do_read_version(hWnd, hDevice, &ver_parm) != 0) {
                        CloseHandle(hDevice);
                        break;
                    }
                    if ((ver_parm.bIDEDeviceMap <= 0) ||
                        ((ver_parm.fCapabilities & 0x04) == 0)) {
                        SetWindowText(GetDlgItem(hWnd, IDC_STATIC2),
                                "Error");
                        break;
                    }
                    memset(identify, 0, sizeof (identify));
                    if (do_read_identify(hWnd, hDevice, selectedDiscNumber, identify) != 0) {
                        CloseHandle(hDevice);
                        break;
                    }
                    memset(attribute, 0, sizeof (attribute));
                    if (do_read_attribute(hWnd, hDevice, selectedDiscNumber, attribute) != 0) {
                        CloseHandle(hDevice);
                        break;
                    }
                    CloseHandle(hDevice);
                    break;
                    
                case IDCANCEL: /* Exit */
                    PostMessage(hWnd, WM_DESTROY, (WPARAM) 0, (LPARAM) 0);
                    break;
                    
                case IDABOUT: /* About */
                    MessageBox(hWnd, 
                    aboutInfo,
                    "About", MB_OK | MB_ICONINFORMATION);
                    break;
            }
            break;
            
        case WM_CREATE:
            PostMessage(hWnd, (WM_APP + 1), 0, 0);
            break;
            
        /* Filling Combobox all supported devices */
        case (WM_APP + 1):  
            fillingCombobox(hWnd);
            break;
            
        case WM_DESTROY:
            PostQuitMessage(0);
            break;
            
        default:
            return (LRESULT) DefWindowProc(hWnd, msg, wParam, lParam);
    }
    return (LRESULT) 0;
}

/*
 * @brief   Getting OS version
 * @return  1:Win95/98/98SE2/Me 2:WinNT/2K/XP/Vista/7 0:unknown
 */
int get_os_version(void) {
    OSVERSIONINFO ver;

    memset((char *) &ver, 0, sizeof (OSVERSIONINFO));
    ver.dwOSVersionInfoSize = sizeof (OSVERSIONINFO);
    if (GetVersionEx(&ver) == 0) {
        return 0; /* error */
    }
    if (ver.dwPlatformId >= VER_PLATFORM_WIN32_NT) {
        return 2; /* Win/NT or old */
    }
    if (ver.dwPlatformId == VER_PLATFORM_WIN32_WINDOWS) {
        return 1; /* Win95/98/98SE2/Me */
    }
    return 0; /* unknown or Win32s */
}

/*
 * @brief   SMART_GET_VERSION
 * @return  0:no error 1:error
 */
int do_read_version(HWND hwnd, HANDLE hdev, GETVERSIONINPARAMS *vp) {
    DWORD read_byte;
    char buffer[64];
    memset(vp, 0, sizeof (GETVERSIONINPARAMS));
    if (DeviceIoControl(hdev, SMART_GET_VERSION,
            NULL,
            0,
            vp,
            sizeof (GETVERSIONINPARAMS),
            &read_byte,
            NULL) == 0) { /* If an error occurred */
        strcpy(buffer, "Program don't support this device!");
        SetWindowText(GetDlgItem(hwnd, IDC_STATIC1), buffer);
        free(vp);
        return 1;
    }

    sprintf(buffer, "%d", vp->bVersion);
    SetWindowText(GetDlgItem(hwnd, IDC_STATIC2), buffer);


    sprintf(buffer, "%d", vp->bRevision);
    SetWindowText(GetDlgItem(hwnd, IDC_STATIC3), buffer);

                        
    sprintf(buffer, "0x%lx", vp->fCapabilities);
    SetWindowText(GetDlgItem(hwnd, IDC_STATIC4), buffer);

    sprintf(buffer, "0x%x", vp->bIDEDeviceMap);
    SetWindowText(GetDlgItem(hwnd, IDC_STATIC5), buffer);
                        
    sprintf(buffer, "%d", read_byte);
    SetWindowText(GetDlgItem(hwnd, IDC_STATIC6), buffer);
    free(vp);
    return 0;
}

/*
 * @brief   Display identify the disk
 * @return  0:no error 1:error
 */
int do_read_identify(HWND hwnd, HANDLE hdev, char drvno, BYTE *identify) {
    PIDENTSECDATA ids;
    SENDCMDINPARAMS scip;
    DWORD read_byte;
    char buffer[64];

    /* Initialization SENDCMDINPARAMS */
    scip.irDriveRegs.bFeaturesReg = 0;
    scip.irDriveRegs.bSectorCountReg = 1;
    scip.irDriveRegs.bSectorNumberReg = 1;
    scip.irDriveRegs.bCylLowReg = 0;
    scip.irDriveRegs.bCylHighReg = 0;
    scip.irDriveRegs.bDriveHeadReg = 0xa0 | ((drvno & 1) << 4);

    scip.irDriveRegs.bCommandReg = IDE_ATA_ID;
    scip.bDriveNumber = drvno;
    scip.cBufferSize = 1;

    if (DeviceIoControl(hdev, SMART_RECV_DRIVE_DATA,
            (PVOID) & scip,
            sizeof (SENDCMDINPARAMS) - 1,
            (LPVOID) identify,
            sizeof (SENDCMDOUTPARAMS) + SMART_SIZE,
            &read_byte,
            NULL) == 0) {
        strcpy(buffer, "HDD does not support S.M.A.R.T.");
        SetWindowText(GetDlgItem(hwnd, IDC_STATIC1), buffer);
        free(identify);
        return 1;
    }
    ids = (PIDENTSECDATA) ((LPSENDCMDOUTPARAMS) identify)->bBuffer;

    sprintf(buffer, "%s%d%s.", "HDD Drive", drvno, ": S.M.A.R.T. supported");
    SetWindowText(GetDlgItem(hwnd, IDC_STATIC1),buffer);

    swap_byte(ids->sModelNumber, sizeof (ids->sModelNumber));
    memset(buffer, 0, sizeof (buffer));
    strncpy(buffer, ids->sModelNumber, sizeof (ids->sModelNumber));
    SetWindowText(GetDlgItem(hwnd, IDC_STATIC7), buffer);

    swap_byte(ids->sFirmwareRev, sizeof (ids->sFirmwareRev));
    memset(buffer, 0, sizeof (buffer));
    strncpy(buffer, ids->sFirmwareRev, sizeof (ids->sFirmwareRev));
    SetWindowText(GetDlgItem(hwnd, IDC_STATIC8), buffer);

    swap_byte(ids->sSerialNumber, sizeof (ids->sSerialNumber));
    memset(buffer, 0, sizeof (buffer));
    strncpy(buffer, ids->sSerialNumber, sizeof (ids->sSerialNumber));
    SetWindowText(GetDlgItem(hwnd, IDC_STATIC9), buffer);
    free(ids);
    free(identify);
    return 0;
}

/*
 * @brief   Read and display SMART attributes
 * @return  0:no error 1:error
 */
int do_read_attribute(HWND hwnd, HANDLE hdev, char drvno, BYTE *attr) {
    SENDCMDINPARAMS scip;
    LPDRVATTRIBUTE pda;
    HWND hList; /* ListBox*/
    DWORD read_byte;
    int i;
    char buffer[128];

    scip.irDriveRegs.bFeaturesReg = SMART_READ_ATTRIBUTE_VALUES;
    scip.irDriveRegs.bSectorCountReg = 1;
    scip.irDriveRegs.bSectorNumberReg = 1;
    scip.irDriveRegs.bCylLowReg = SMART_CYL_LOW;
    scip.irDriveRegs.bCylHighReg = SMART_CYL_HI;
    scip.irDriveRegs.bDriveHeadReg = 0xa0 | ((drvno & 1) << 4);

    scip.irDriveRegs.bCommandReg = IDE_EXEC_SMART_CMD;
    scip.bDriveNumber = drvno;
    scip.cBufferSize = 1;

    if (DeviceIoControl(hdev, SMART_RECV_DRIVE_DATA,
            (PVOID) & scip,
            sizeof (SENDCMDINPARAMS) - 1,
            (LPVOID) attr,
            sizeof (SENDCMDOUTPARAMS) + SMART_SIZE,
            &read_byte,
            NULL) == 0) {
        strcpy(buffer, "Failed to get attributes");
        SetWindowText(GetDlgItem(hwnd, IDC_STATIC1), buffer);
        return 1;
    }
    pda = (LPDRVATTRIBUTE)&(((LPSENDCMDOUTPARAMS) attr)->bBuffer[2]);

    hList = GetDlgItem(hwnd, IDC_LIST1);
    SendMessage(hList, LB_RESETCONTENT, 0, 0L);
    SendMessage(hList, WM_SETREDRAW, FALSE, 0);
    for (i = 0; i < NUM_ATTRIBUTE_STRUCTS; i++) {
        if (pda->bAttrID == 0) {
            continue;
        } 
        sprintf(buffer, "%2X%10d%7d%7d%7d%31s",
                pda->bAttrID, pda->bRawVal[0],
                pda->bAttrVal, pda->bWorstVal, 
                pda->wStatFlag, textAttrib[pda->bAttrID]);
        SendMessage(hList, LB_ADDSTRING, 0, (LPARAM) buffer);
        pda++;
    }
    SendMessage(hList, WM_SETREDRAW, TRUE, 0);
    return 0;
}

/*
 * @brief   Read all supported devices and filling Combobox
 * @return  TRUE:no error FALSE:error
 */
BOOL fillingCombobox(HWND hwnd) {
    HANDLE currentHandle;
    BOOL resultValue = FALSE;
    HWND handleComboBox = GetDlgItem(hwnd, IDC_COMBO1);
    SendMessage(handleComboBox, CB_RESETCONTENT, 0, 0L);
    GETVERSIONINPARAMS VP;
    DWORD br;
    char buffer[3];
    memset((void*) &VP, 0, sizeof (VP));
    int i;
    for (i = 0; i < 64; i++) {
        if ((get_os_version()) == 2) {
            currentHandle = CreateFile(
                    getNormaliseDrive(i),
                    GENERIC_READ | GENERIC_WRITE,
                    FILE_SHARE_READ | FILE_SHARE_WRITE,
                    NULL,
                    OPEN_EXISTING, 0, NULL
                    );
            if (currentHandle != INVALID_HANDLE_VALUE) {
                if (DeviceIoControl(currentHandle, 
                        SMART_GET_VERSION, 
                        NULL, 0, &VP,
                        sizeof (VP), &br, NULL)) { // Get rid of flash drives //
                    SendMessage(handleComboBox, CB_ADDSTRING, 0, (LPARAM) itoa(i, buffer, 10));
                    resultValue = TRUE;
                }
            }
            CloseHandle(currentHandle);
        } else {
            MessageBox(hwnd, "This version Windows not supported!",
                    "Error", MB_OK | MB_ICONEXCLAMATION);
            break; /* unknown or non support version */
        }
    }
    SendMessage(handleComboBox, CB_SETCURSEL, 0, 1); // Installation 1-st value
    return resultValue;
}

/*
 * @brief   Getting selected in the ComboBox disc
 * @return  Device number in the system
 */
int get_selected_disc_number(HWND hWnd) {
    char stringVal[10];
    HWND handleComboBox = GetDlgItem(hWnd, IDC_COMBO1);
    GetDlgItemText(hWnd,IDC_COMBO1,stringVal,9);
    return atoi(stringVal);
}

/*
 * @brief   Getting string, pointing to the HDD device
 * @return  "\\\\.\\PhysicalDrive" + disk number on system
 */
char* getNormaliseDrive(int nDrive) {
    const char *sBegin = "\\\\.\\PhysicalDrive";
    char *sEnd, *sFull, buffer[3];
    sEnd = itoa(nDrive, buffer, 10);
    sFull = malloc(strlen(sBegin) + strlen(sEnd) + 1);
    strcpy(sFull, sBegin);
    strcat(sFull, sEnd);
    return sFull;
}

void swap_byte(char *dat, int length) {
    int i;
    char tmp;

    for (i = 0; i < length; i += 2) {
        tmp = dat[i];
        dat[i] = dat[i + 1];
        dat[i + 1] = tmp;
    }
}
