:: CALG_RC2
:: CALG_RC4
:: CALG_DES
:: CALG_3DES_112
:: CALG_3DES
:: CALG_AES_128
:: CALG_AES_192
:: CALG_AES_256

start cmd.exe /k "..\Release\decrypt.exe _newEncryptedFile.txt _resultingDecryptedFile.txt CALG_AES_256 pass"
