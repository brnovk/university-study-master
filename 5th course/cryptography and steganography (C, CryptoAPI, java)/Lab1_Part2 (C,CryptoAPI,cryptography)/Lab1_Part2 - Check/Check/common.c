#include "common.h"

// Variants 2, 4, 5, 7 = CALG_SHA
// Variants 1 È 6 = CALG_MD2
// Variants 3 È 8 = CALG_MD5
const ALG_ID HASH_ALG = CALG_SHA;

HCRYPTHASH GetFileHash(HCRYPTPROV prov, char *filename)
{
	HANDLE inf = 0;
	HANDLE inmmf = 0;
	PBYTE indata = NULL;
	LARGE_INTEGER insz = { .QuadPart = 0 };

	HCRYPTHASH hash = 0;

	inf = CreateFileA(filename, GENERIC_READ, 0, NULL, OPEN_EXISTING,
		FILE_ATTRIBUTE_NORMAL, NULL);
	inmmf = CreateFileMappingA(inf, NULL, PAGE_READONLY, 0, 0, NULL);
	crash_if(!inmmf, "Can't open memory mapped file.");
	GetFileSizeEx(inf, &insz);
	indata = MapViewOfFile(inmmf, FILE_MAP_READ, 0, 0, 0);
	crash_if(!indata, "Can't map view of file.");

	crash_if(!CryptCreateHash(prov, HASH_ALG, 0, 0, &hash),
		"Can't create hash object.");
	crash_if(!CryptHashData(hash, indata, insz.QuadPart, 0),
		"Can't calculate hash for the input data.");

err:
	apply_not_null(indata, UnmapViewOfFile);
	apply_not_null(inmmf, CloseHandle);
	apply_not_null(inf, CloseHandle);

	return hash;
}