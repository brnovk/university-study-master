#include <stdio.h>
#include <stdint.h>
#include <string.h>

#include <windows.h>
#include <wincrypt.h>

#define crash_if(cond, msg) { if (cond) { fprintf(stderr, "Error code: %lx\n", GetLastError()); fputs(msg "\n", stderr); getchar(); goto err; } }
#define apply_not_null(value, fun) { if (value) { fun (value); } }

extern const ALG_ID HASH_ALG;
extern const ALG_ID CRYPT_ALG;


HCRYPTHASH GetFileHash(HCRYPTPROV prov, char *filename);