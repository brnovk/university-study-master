#ifndef __MAIN_H__
#define __MAIN_H__

/* Dialog box for macros */
#define IDC_STATIC  -1

#define SMART_SIZE            (512 - 1)
#define NUM_ATTRIBUTE_STRUCTS 30

#define SMART_GET_VERSION     0x00074080
#define SMART_SEND_DRIVE_CMD  0x0007c084
#define SMART_RECV_DRIVE_DATA 0x0007c088

#define IDE_ATA_ID           0xec 
#define IDE_ATAPI_ID         0xa1 
#define IDE_EXEC_SMART_CMD   0xb0

#define SMART_CYL_LOW   0x4f
#define SMART_CYL_HI    0xc2

#define SMART_READ_ATTRIBUTE_VALUES     0xd0
#define SMART_READ_ATTRIBUTE_THRESHOLDS 0xd1

typedef struct _GETVERSIONINPARAMS {
    UCHAR bVersion;
    UCHAR bRevision;
    UCHAR bReserved;
    UCHAR bIDEDeviceMap;
    ULONG fCapabilities;
    ULONG dwReserved[4];
} GETVERSIONINPARAMS, *LPGETVERSIONINPARAMS;

typedef struct _IDEREGS {
    UCHAR bFeaturesReg;
    UCHAR bSectorCountReg;
    UCHAR bSectorNumberReg;
    UCHAR bCylLowReg;
    UCHAR bCylHighReg;
    UCHAR bDriveHeadReg;
    UCHAR bCommandReg;
    UCHAR bReserved;
} IDEREGS, *LPIDERE;

typedef struct _DRIVERSTATUS {
    UCHAR bDriverError;
    UCHAR bIDEError;
    UCHAR bReserved[2];
    ULONG dwReserved[2];
} DRIVERSTATUS, *LPDRIVERSTATUS;

typedef struct _SENDCMDINPARAMS {
    ULONG cBufferSize;
    IDEREGS irDriveRegs;
    UCHAR bDriveNumber;
    UCHAR bReserved[3];
    ULONG dwReserved[4];
    UCHAR bBuffer[1];
} SENDCMDINPARAMS, *LPSENDCMDINPARAMS;

typedef struct _SENDCMDOUTPARAMS {
    ULONG cBufferSize;
    DRIVERSTATUS DriverStatus;
    UCHAR bBuffer[1];
} SENDCMDOUTPARAMS, *LPSENDCMDOUTPARAMS;

typedef struct _IDENTSECDATA {
    USHORT wGenConfig;
    USHORT wNumCyls;
    USHORT wReserved;
    USHORT wNumHeads;
    USHORT wBytesPerTrack;
    USHORT wBytesPerSector;
    USHORT wSectorsPerTrack;
    USHORT wVendorUnique[3];
    CHAR sSerialNumber[20];
    USHORT wBufferType;
    USHORT wBufferSize;
    USHORT wECCSize;
    CHAR sFirmwareRev[8];
    CHAR sModelNumber[40];
    BYTE bReserved[162];
} IDENTSECDATA, *PIDENTSECDATA;

typedef struct _DRVATTIBUTE {
    BYTE bAttrID; 
    WORD wStatFlag;
    BYTE bAttrVal;
    BYTE bWorstVal;
    WORD bRawVal[3];
    BYTE bReserve;
} DRVATTRIBUTE, *LPDRVATTRIBUTE;

const char *aboutInfo = "Practical application to course project on the topic:"
        "\n\"Monitoring the SMART status of the hard disk registers\"."
        "\n\nAttention: program don't support reading"
        "\ninformation from disks connected via SCSI interface,"
        "\nas well as RAID arrays."
        "\n\nPerformed: student group POIT-41;"
        "\nBaranov V.";

const char *textAttrib[] = {
    "<unknown attribute>",
    "Raw Read Error Rate",
    "Throughput Performance",
    "Spin-Up Time",
    "Start/Stop Count",
    "Reallocated Sectors Count",
    "Read Channel Margin",
    "Seek Error Rate",
    "Seek Time Performance",
    "Power-On Hours (POH)",
    "Spin-Up Retry Count",
    "Recalibration Retries",
    "Device Power Cycle Count",
    "Soft Read Error Rate",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "End-to-End error",
    "<unknown attribute>",
    "<unknown attribute>",
    "Reported UNC Errors",
    "Command Timeout",
    "<unknown attribute>",
    "Airflow Temperature (WDC)",
    "G-sense error rate",
    "Power-off retract count",
    "Load/Unload Cycle",
    "HDA temperature",
    "Hardware ECC Recovered",
    "Reallocation Event Count",
    "Current Pending Sector Count",
    "Uncorrectable Sector Count",
    "UltraDMA CRC Error Count",
    "Write / Multi-Zone Error Rate",
    "Soft read error rate",
    "Data Address Mark errors",
    "Run out cancel",
    "Soft ECC correction",
    "Thermal asperity rate (TAR)",
    "Flying height",
    "Spin high current",
    "Spin buzz",
    "Offline seek performance",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "Disk Shift",
    "G-Sense Error Rate",
    "Loaded Hours",
    "Load/Unload Retry Count",
    "Load Friction",
    "Load Cycle Count",
    "Load 'In'-time",
    "Torque Amplification Count",
    "Power-Off Retract Cycle",
    "<unknown attribute>",
    "GMR Head Amplitude",
    "Temperature",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "Head flying hours",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "<unknown attribute>",
    "Read error retry rate"
};

#endif // __MAIN_H__
