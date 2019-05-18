/**
*	Lab 1 Part 1 (decryption)
* Implement secure file sharing software.
* In the program features include encryption and decryption of files
* on disk using symmetric encryption algorithm ALG1.
* The input to a program that serves the type of cryptographic operation
* (encryption/decryption), name of the input and output files
* and password. When performing encryption, the output is
* the encrypted file, when performing decryption � file
* identical to the original (if the password is correct).
*/
#include "stdafx.h"

DWORD ENCRYPT_ALGORITHM;
DWORD ENCRYPT_BLOCK_SIZE;
DWORD KEYLENGTH;
const wchar_t* PROVIDER;
DWORD PROVIDER_TYPE;

bool MyDecryptFile(
	LPTSTR szSource,
	LPTSTR szDestination,
	LPTSTR szPassword);

void MyHandleError(
	LPTSTR psz,
	int nErrorNumber);

int _tmain(int argc, _TCHAR* argv[]) {
	if (argc < 3) {
		_tprintf(TEXT("Usage: <decrypt.exe> <source file> ")
			TEXT("<destination file> <algorythm> <password>\n")
			TEXT("*** <password> is optional ***\n"));
		_tprintf(TEXT("Press any key to exit."));
		_gettch();
		return 1;
	}

	LPTSTR pszSource = argv[1];
	LPTSTR pszDestination = argv[2];
	LPTSTR pszPassword = NULL;

	// If there is a parameter with password
	if (argv[4] != NULL) {
		pszPassword = argv[4];
	}

	if (_tcscmp(argv[3], TEXT("CALG_RC2")) == 0) {
		ENCRYPT_ALGORITHM = CALG_RC2;
		ENCRYPT_BLOCK_SIZE = 64;
		KEYLENGTH = 0x00280000;
		PROVIDER = MS_ENHANCED_PROV;
		PROVIDER_TYPE = PROV_RSA_FULL;
	} else if (_tcscmp(argv[3], TEXT("CALG_RC4")) == 0) {
		ENCRYPT_ALGORITHM = CALG_RC4;
		ENCRYPT_BLOCK_SIZE = 64;
		KEYLENGTH = 0x00280000;
		PROVIDER = MS_ENHANCED_PROV;
		PROVIDER_TYPE = PROV_RSA_FULL;
	} else if (_tcscmp(argv[3], TEXT("CALG_DES")) == 0) {
		ENCRYPT_ALGORITHM = CALG_DES;
		ENCRYPT_BLOCK_SIZE = 64;
		KEYLENGTH = 0x00380000;
		PROVIDER = MS_ENHANCED_PROV;
		PROVIDER_TYPE = PROV_RSA_FULL;
	} else if (_tcscmp(argv[3], TEXT("CALG_3DES_112")) == 0) {
		ENCRYPT_ALGORITHM = CALG_3DES_112;
		ENCRYPT_BLOCK_SIZE = 64;
		KEYLENGTH = 0x00700000;
		PROVIDER = MS_ENHANCED_PROV;
		PROVIDER_TYPE = PROV_RSA_FULL;
	} else if (_tcscmp(argv[3], TEXT("CALG_3DES")) == 0) {
		ENCRYPT_ALGORITHM = CALG_3DES;
		ENCRYPT_BLOCK_SIZE = 64;
		KEYLENGTH = 0x00A80000;
		PROVIDER = MS_ENHANCED_PROV;
		PROVIDER_TYPE = PROV_RSA_FULL;
	} else if (_tcscmp(argv[3], TEXT("CALG_AES_128")) == 0) {
		ENCRYPT_ALGORITHM = CALG_AES_128;
		ENCRYPT_BLOCK_SIZE = 128;
		KEYLENGTH = 0x00800000;
		PROVIDER = MS_ENH_RSA_AES_PROV;
		PROVIDER_TYPE = PROV_RSA_AES;
	} else if (_tcscmp(argv[3], TEXT("CALG_AES_192")) == 0) {
		ENCRYPT_ALGORITHM = CALG_AES_192;
		ENCRYPT_BLOCK_SIZE = 128;
		KEYLENGTH = 0x00C00000;
		PROVIDER = MS_ENH_RSA_AES_PROV;
		PROVIDER_TYPE = PROV_RSA_AES;
	} else {
		ENCRYPT_ALGORITHM = CALG_AES_256;
		ENCRYPT_BLOCK_SIZE = 128;
		KEYLENGTH = 0x01000000;
		PROVIDER = MS_ENH_RSA_AES_PROV;
		PROVIDER_TYPE = PROV_RSA_AES;
	}

	//---------------------------------------------------------------
	// Call EncryptFile to do the actual encryption.
	if (MyDecryptFile(pszSource, pszDestination, pszPassword)) {
		_tprintf(
			TEXT("Encryption of the file %s was successful. \n"),
			pszSource);
		_tprintf(
			TEXT("The encrypted data is in file %s.\n"),
			pszDestination);
	} else {
		MyHandleError(
			TEXT("Error encrypting file!\n"),
			GetLastError());
	}

	return 0;
}

//-------------------------------------------------------------------
// Code for the function MyDecryptFile called by main.
//-------------------------------------------------------------------
// Parameters passed are:
//  pszSource, the name of the input file, an encrypted file.
//  pszDestination, the name of the output, a plaintext file to be 
//   created.
//  pszPassword, either NULL if a password is not to be used or the 
//   string that is the password.
bool MyDecryptFile(
	LPTSTR pszSourceFile,
	LPTSTR pszDestinationFile,
	LPTSTR pszPassword) {
	//---------------------------------------------------------------
	// Declare and initialize local variables.
	bool fReturn = false;
	HANDLE hSourceFile = INVALID_HANDLE_VALUE;
	HANDLE hDestinationFile = INVALID_HANDLE_VALUE;
	HCRYPTKEY hKey = NULL;
	HCRYPTHASH hHash = NULL;

	HCRYPTPROV hCryptProv = NULL;

	DWORD dwCount;
	PBYTE pbBuffer = NULL;
	DWORD dwBlockLen;
	DWORD dwBufferLen;

	//---------------------------------------------------------------
	// Open the source file. 
	hSourceFile = CreateFile(
		pszSourceFile,
		FILE_READ_DATA,
		FILE_SHARE_READ,
		NULL,
		OPEN_EXISTING,
		FILE_ATTRIBUTE_NORMAL,
		NULL);
	if (INVALID_HANDLE_VALUE != hSourceFile) {
		_tprintf(
			TEXT("The source encrypted file, %s, is open. \n"),
			pszSourceFile);
	} else {
		MyHandleError(
			TEXT("Error opening source plaintext file!\n"),
			GetLastError());
		goto Exit_MyDecryptFile;
	}

	//---------------------------------------------------------------
	// Open the destination file. 
	hDestinationFile = CreateFile(
		pszDestinationFile,
		FILE_WRITE_DATA,
		FILE_SHARE_READ,
		NULL,
		OPEN_ALWAYS,
		FILE_ATTRIBUTE_NORMAL,
		NULL);
	if (INVALID_HANDLE_VALUE != hDestinationFile) {
		_tprintf(
			TEXT("The destination file, %s, is open. \n"),
			pszDestinationFile);
	} else {
		MyHandleError(
			TEXT("Error opening destination file!\n"),
			GetLastError());
		goto Exit_MyDecryptFile;
	}

	//---------------------------------------------------------------
	// Get the handle to the default provider. 
	if (CryptAcquireContext(
		&hCryptProv,
		NULL,
		PROVIDER,
		PROVIDER_TYPE,
		0)) {
		_tprintf(
			TEXT("A cryptographic provider has been acquired. \n"));
	} else {
		MyHandleError(
			TEXT("Error during CryptAcquireContext!\n"),
			GetLastError());
		goto Exit_MyDecryptFile;
	}

	//---------------------------------------------------------------
	// Create the session key.
	if (!pszPassword || !pszPassword[0]) {
		//-----------------------------------------------------------
		// Decrypt the file with the saved session key. 

		DWORD dwKeyBlobLen;
		PBYTE pbKeyBlob = NULL;

		// Read the key BLOB length from the source file. 
		if (!ReadFile(
			hSourceFile,
			&dwKeyBlobLen,
			sizeof(DWORD),
			&dwCount,
			NULL)) {
			MyHandleError(
				TEXT("Error reading key BLOB length!\n"),
				GetLastError());
			goto Exit_MyDecryptFile;
		}

		// Allocate a buffer for the key BLOB.
		if (!(pbKeyBlob = (PBYTE)malloc(dwKeyBlobLen))) {
			MyHandleError(
				TEXT("Memory allocation error.\n"),
				E_OUTOFMEMORY);
		}

		//-----------------------------------------------------------
		// Read the key BLOB from the source file. 
		if (!ReadFile(
			hSourceFile,
			pbKeyBlob,
			dwKeyBlobLen,
			&dwCount,
			NULL)) {
			MyHandleError(
				TEXT("Error reading key BLOB length!\n"),
				GetLastError());
			goto Exit_MyDecryptFile;
		}

		//-----------------------------------------------------------
		// Import the key BLOB into the CSP. 
		if (!CryptImportKey(
			hCryptProv,
			pbKeyBlob,
			dwKeyBlobLen,
			0,
			0,
			&hKey)) {
			MyHandleError(
				TEXT("Error during CryptImportKey!/n"),
				GetLastError());
			goto Exit_MyDecryptFile;
		}

		if (pbKeyBlob) {
			free(pbKeyBlob);
		}
	} else {
		//-----------------------------------------------------------
		// Decrypt the file with a session key derived from a 
		// password. 

		//-----------------------------------------------------------
		// Create a hash object. 
		if (!CryptCreateHash(
			hCryptProv,
			CALG_MD5,
			0,
			0,
			&hHash)) {
			MyHandleError(
				TEXT("Error during CryptCreateHash!\n"),
				GetLastError());
			goto Exit_MyDecryptFile;
		}

		//-----------------------------------------------------------
		// Hash in the password data. 
		if (!CryptHashData(
			hHash,
			(BYTE *)pszPassword,
			lstrlen(pszPassword),
			0)) {
			MyHandleError(
				TEXT("Error during CryptHashData!\n"),
				GetLastError());
			goto Exit_MyDecryptFile;
		}

		//-----------------------------------------------------------
		// Derive a session key from the hash object. 
		if (!CryptDeriveKey(
			hCryptProv,
			ENCRYPT_ALGORITHM,
			hHash,
			KEYLENGTH,
			&hKey)) {
			MyHandleError(
				TEXT("Error during CryptDeriveKey!\n"),
				GetLastError());
			goto Exit_MyDecryptFile;
		}
	}

	//---------------------------------------------------------------
	// The decryption key is now available, either having been 
	// imported from a BLOB read in from the source file or having 
	// been created by using the password. This point in the program 
	// is not reached if the decryption key is not available.

	//---------------------------------------------------------------
	// Determine the number of bytes to decrypt at a time. 
	// This must be a multiple of ENCRYPT_BLOCK_SIZE. 

	dwBlockLen = 1000 - (1000 % ENCRYPT_BLOCK_SIZE);
	dwBufferLen = dwBlockLen;

	//---------------------------------------------------------------
	// Allocate memory for the file read buffer. 
	if (!(pbBuffer = (PBYTE)malloc(dwBufferLen))) {
		MyHandleError(TEXT("Out of memory!\n"), E_OUTOFMEMORY);
		goto Exit_MyDecryptFile;
	}

	//---------------------------------------------------------------
	// Decrypt the source file, and write to the destination file. 
	bool fEOF = false;
	do {
		//-----------------------------------------------------------
		// Read up to dwBlockLen bytes from the source file. 
		if (!ReadFile(
			hSourceFile,
			pbBuffer,
			dwBlockLen,
			&dwCount,
			NULL)) {
			MyHandleError(
				TEXT("Error reading from source file!\n"),
				GetLastError());
			goto Exit_MyDecryptFile;
		}

		if (dwCount < dwBlockLen) {
			fEOF = TRUE;
		}

		//-----------------------------------------------------------
		// Decrypt the block of data. 
		if (!CryptDecrypt(
			hKey,
			0,
			fEOF,
			0,
			pbBuffer,
			&dwCount)) {
			MyHandleError(
				TEXT("Error during CryptDecrypt!\n"),
				GetLastError());
			goto Exit_MyDecryptFile;
		}

		//-----------------------------------------------------------
		// Write the decrypted data to the destination file. 
		if (!WriteFile(
			hDestinationFile,
			pbBuffer,
			dwCount,
			&dwCount,
			NULL)) {
			MyHandleError(
				TEXT("Error writing ciphertext.\n"),
				GetLastError());
			goto Exit_MyDecryptFile;
		}

		//-----------------------------------------------------------
		// End the do loop when the last block of the source file 
		// has been read, encrypted, and written to the destination 
		// file.
	} while (!fEOF);

	fReturn = true;

Exit_MyDecryptFile:

	//---------------------------------------------------------------
	// Free the file read buffer.
	if (pbBuffer) {
		free(pbBuffer);
	}

	//---------------------------------------------------------------
	// Close files.
	if (hSourceFile) {
		CloseHandle(hSourceFile);
	}

	if (hDestinationFile) {
		CloseHandle(hDestinationFile);
	}

	//-----------------------------------------------------------
	// Release the hash object. 
	if (hHash) {
		if (!(CryptDestroyHash(hHash))) {
			MyHandleError(
				TEXT("Error during CryptDestroyHash.\n"),
				GetLastError());
		}

		hHash = NULL;
	}

	//---------------------------------------------------------------
	// Release the session key. 
	if (hKey) {
		if (!(CryptDestroyKey(hKey))) {
			MyHandleError(
				TEXT("Error during CryptDestroyKey!\n"),
				GetLastError());
		}
	}

	//---------------------------------------------------------------
	// Release the provider handle. 
	if (hCryptProv) {
		if (!(CryptReleaseContext(hCryptProv, 0))) {
			MyHandleError(
				TEXT("Error during CryptReleaseContext!\n"),
				GetLastError());
		}
	}

	return fReturn;
}


//-------------------------------------------------------------------
//  This example uses the function MyHandleError, a simple error
//  handling function, to print an error message to the  
//  standard error (stderr) file and exit the program. 
//  For most applications, replace this function with one 
//  that does more extensive error reporting.

void MyHandleError(LPTSTR psz, int nErrorNumber) {
	_ftprintf(stderr, TEXT("An error occurred in the program. \n"));
	_ftprintf(stderr, TEXT("%s\n"), psz);
	_ftprintf(stderr, TEXT("Error number %x.\n"), nErrorNumber);
}
