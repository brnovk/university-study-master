#include "common.h"

int main(int argc, char *argv[])
{
	HANDLE signf = 0;
	HANDLE signmmf = 0;
	PBYTE signdata = NULL;
	void *keyblob = NULL;
	unsigned char err = 1;

	HCRYPTPROV prov;
	HCRYPTKEY key;
	HCRYPTHASH hash = 0;

	if (argc != 3) {
		fputs("Usage: Signature.exe <input file> <output file>", stderr);
		return -1;
	}

	// Variants 1, 2, 3, 4, 6, 7, 8 = CALG_RSA_SIGN;
	// Variant 5 = CALG_DSS_SIGN
	//
	// MS_ENHANCED_PROV, PROV_RSA_FULL 	= CALG_RSA_SIGN
	// MS_DEF_DSS_PROV, PROV_DSS 		= CALG_DSS_SIGN
	if (!CryptAcquireContext(&prov, "lab12", MS_ENHANCED_PROV, PROV_RSA_FULL, 0)) {
		crash_if(CryptAcquireContext(&prov, "lab12", MS_ENHANCED_PROV, PROV_RSA_FULL, CRYPT_NEWKEYSET),
			"Can't acquire crypt context.");
	}

	signf = CreateFileA(argv[2], GENERIC_READ | GENERIC_WRITE, 0, NULL,
		CREATE_ALWAYS, FILE_ATTRIBUTE_NORMAL, NULL);


	if (!CryptGetUserKey(prov, AT_SIGNATURE, &key)) {
		if (GetLastError() == NTE_NO_KEY) {
			puts("Cannot find user's exchange key, generating one.");
			crash_if(!CryptGenKey(prov, AT_SIGNATURE, 0, &key),
				"Cannot generate user's key.");
		}
		else {
			crash_if(1, "Can't acquire signature key.");

		}
	}

	/*
	crash_if(!CryptExportKey(key, 0, PUBLICKEYBLOB, 0, NULL, &blob_len),
	"Can't determine size of a blob for public key.");
	crash_if(!(keyblob = malloc(blob_len)),
	"Can't reserve memory for a public key blob.");
	crash_if(!CryptExportKey(key, 0, PUBLICKEYBLOB, 0, keyblob, &blob_len),
	"Can't export public key.");
	*/
	hash = GetFileHash(prov, argv[1]);

	DWORD sign_len = 0;
	crash_if(!CryptSignHash(hash, AT_SIGNATURE, NULL, 0, NULL, &sign_len),
		"Can't find the signed hash size.");

	signmmf = CreateFileMappingA(signf, NULL, PAGE_READWRITE, 0, sign_len, NULL);
	crash_if(!signmmf, "Can't open memory mapped file.");
	signdata = MapViewOfFile(signmmf, FILE_MAP_WRITE, 0, 0, 0);
	crash_if(!signdata, "Can't map view of file");

	crash_if(!CryptSignHash(hash, AT_SIGNATURE, NULL, 0, signdata, &sign_len),
		"Error while saving signature.");


	err = 0;

err: // freeing resources ...
	apply_not_null(signdata, UnmapViewOfFile);
	apply_not_null(signmmf, CloseHandle);
	apply_not_null(signf, CloseHandle);

	apply_not_null(keyblob, free);

	apply_not_null(hash, CryptDestroyHash)

	if (err)
		return -1;
	return 0;
}