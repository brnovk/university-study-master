#include <windows.h>
#include <ctime>
//-----------------------------------------------------------------------------
// 
// Variant 5, POIT-31, Baranov V.
// Task: write program, drawing by clicking mouse rectangle random size and
// fill colors centered on the point the mouse cursor clicking.
// When performing tasks using Windows API functions, and do not use the
// library and language extensions that are not part of standard C ++ library.
//-----------------------------------------------------------------------------

//---------- Prototype WndProc() ------------
LRESULT CALLBACK WndProc (HWND, UINT, WPARAM, LPARAM);

//-----------------------------------------------------------------------------

int WINAPI WinMain (HINSTANCE hInstance, HINSTANCE hPrevInstance,
					LPSTR lpCmdLine, int nCmdShow) {
	HWND hMainWnd;                    // HWND - Window descriptor;
	char szClassName[] = "MyClass";
	WNDCLASSEX ws;                    // Structure of the window class;
	MSG msg;                          // Structure message;

	//Fill the window class structure:
	ws.cbSize        = sizeof(ws);
	ws.style         = CS_HREDRAW | CS_VREDRAW;
	ws.lpfnWndProc   = WndProc;
	ws.cbClsExtra    = 0;
	ws.cbWndExtra    = 0;
	ws.hInstance     = hInstance;
	ws.hIcon         = LoadIcon(NULL, IDI_APPLICATION);
	ws.hCursor       = LoadCursor(NULL, IDC_ARROW);
	ws.hbrBackground = (HBRUSH)GetStockObject(WHITE_BRUSH);
	ws.lpszMenuName  = NULL;
	ws.lpszClassName = szClassName;
	ws.hIconSm       = LoadIcon(NULL, IDI_APPLICATION);
	//-------------------------------------------------------------------------
	// Register the window class
	if (!RegisterClassEx(&ws)) {
		MessageBox(NULL,"Cannot register class", "Error", MB_OK);
		return 0;
	}

	// Create the main application window
	hMainWnd = CreateWindow(szClassName,
							"Practice task (Var 5, POIT-31, Baranov)",
							WS_OVERLAPPEDWINDOW, CW_USEDEFAULT,
							0, CW_USEDEFAULT, 0, (HWND)NULL,
							(HMENU)NULL,(HINSTANCE)hInstance, NULL);
	if (!hMainWnd) {
		MessageBox(NULL, "Cannot create main window", "Error", MB_OK);
		return 0;
	}

	// Show window
	ShowWindow(hMainWnd, nCmdShow);
	while (GetMessage(&msg,NULL,0,0)) {
		TranslateMessage(&msg); 
		DispatchMessage(&msg);
	}

	return msg.wParam;
}

//-----------------------------------------------------------------------------

LRESULT CALLBACK WndProc(HWND hWnd, UINT uMsg, WPARAM wParam, LPARAM lParam) {
	HDC hDC;
	WORD xPos, yPos, nSize;
	RECT rect;
	long rand_x,rand_y,rand_r,rand_g,rand_b;
	//-------------------------------------------------------------------------
	switch (uMsg) {
		case WM_LBUTTONDOWN:
			yPos = LOWORD(lParam);  // Save the coordinates of the mouse cursor
			xPos = HIWORD(lParam);  //
			hDC = GetDC(hWnd);
			srand(time(NULL));
			rand_r=rand()%255+1;
			rand_g=rand()%255+1;
			rand_b=rand()%255+1;
			rand_x=rand()%150+1;
			rand_y=rand()%150+1;
			rect.top=xPos+rand_x;
			rect.left=yPos+rand_y;
			rect.bottom=xPos-rand_x;
			rect.right=yPos-rand_y;
			FillRect(hDC, &rect,(HBRUSH)CreateSolidBrush
					(RGB(rand_r,rand_g,rand_b))); 
			ReleaseDC(hWnd, hDC);
			break;
		case WM_CLOSE:
			DestroyWindow(hWnd); 
			break;
		case WM_DESTROY:
			PostQuitMessage(0);                         // Send message WM_QUIT
			break;
		default:                               // Processing all other messages
			return DefWindowProc(hWnd, uMsg, wParam, lParam);
	}
	return 0;
}
