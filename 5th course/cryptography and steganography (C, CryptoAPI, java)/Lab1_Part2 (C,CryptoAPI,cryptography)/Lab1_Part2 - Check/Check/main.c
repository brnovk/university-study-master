#include "common.h"

int main(int argc, char *argv[])
{
	HANDLE signf = 0;
	HANDLE signmmf = 0;
	PBYTE signdata = NULL;
	LARGE_INTEGER signsz = { .QuadPart = 0 };
	void *keyblob = NULL;
	unsigned char err = 1;

	HCRYPTPROV prov;
	HCRYPTKEY key;
	HCRYPTHASH hash = 0;

	if (argc != 3) {
		fputs("Usage: Check.exe <input file> <output file>", stderr);
		return -1;
	}

	// Variants 1, 2, 3, 4, 6, 7, 8 = CALG_RSA_SIGN;
	// Variant 5 = CALG_DSS_SIGN
	//
	// MS_ENHANCED_PROV, PROV_RSA_FULL 	= CALG_RSA_SIGN
	// MS_DEF_DSS_PROV, PROV_DSS 		= CALG_DSS_SIGN
	crash_if(!CryptAcquireContext(&prov, "lab12", MS_ENHANCED_PROV, PROV_RSA_FULL, 0),
			"Can't acquire crypt context.");

	hash = GetFileHash(prov, argv[1]);

	signf = CreateFileA(argv[2], GENERIC_READ, 0, NULL, OPEN_EXISTING,
		FILE_ATTRIBUTE_NORMAL, NULL);
	signmmf = CreateFileMappingA(signf, NULL, PAGE_READONLY, 0, 0, NULL);
	crash_if(!signmmf, "Can't open memory mapped file.");
	GetFileSizeEx(signf, &signsz);
	signdata = MapViewOfFile(signmmf, FILE_MAP_READ, 0, 0, 0);
	crash_if(!signdata, "Can't map view of file.");

	crash_if(!CryptGetUserKey(prov, AT_SIGNATURE, &key),
		"Can't acquire signature key.");

	if (CryptVerifySignature(hash, signdata, signsz.LowPart, key, NULL, 0)) {
		printf("Signature matches.\n");
		err = 0;
	}
	else {
		printf("Signature mismatch.\n");
	}

err:
	apply_not_null(signdata, UnmapViewOfFile);
	apply_not_null(signmmf, CloseHandle);
	apply_not_null(signf, CloseHandle);

	apply_not_null(keyblob, free);

	apply_not_null(hash, CryptDestroyHash)

	if (err)
		return -1;
	return 0;
}