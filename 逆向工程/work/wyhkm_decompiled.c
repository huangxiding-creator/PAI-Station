
/* ===== HKMSearchDevice ===== */

void HKMSearchDevice(uint param_1,uint param_2,uint param_3)

{
                    /* 0x8670  56  HKMSearchDevice */
  FUN_18000d530(param_1,param_2,(undefined4 *)0x0,param_3);
  return;
}



/* ===== HKMSearchDevice2 ===== */

void HKMSearchDevice2(uint param_1,uint param_2,undefined4 param_3,uint param_4)

{
  undefined4 auStackX_18 [4];
  
                    /* 0x8680  57  HKMSearchDevice2 */
  auStackX_18[0] = param_3;
  FUN_18000d530(param_1,param_2,auStackX_18,param_4);
  return;
}



/* ===== HKMSearchDeviceAll ===== */

longlong HKMSearchDeviceAll(uint param_1,uint param_2,uint param_3)

{
  uint uVar1;
  undefined4 *puVar2;
  longlong lVar3;
  
                    /* 0x8690  58  HKMSearchDeviceAll */
  puVar2 = FUN_18001a510(3,4,0x100);
  if (puVar2 != (undefined4 *)0x0) {
    uVar1 = FUN_18000d5f0(param_1,param_2,param_3,puVar2 + 4,0x100);
    if ((uVar1 != 0xffffffff) && (uVar1 < 0x101)) {
      puVar2[3] = uVar1;
      lVar3 = FUN_18001a590((longlong)puVar2);
      return lVar3;
    }
    FUN_18001a600((longlong)puVar2);
  }
  return 0;
}



/* ===== HKMOpen ===== */

int * HKMOpen(uint param_1,uint param_2)

{
  DWORD dwErrCode;
  int *_Memory;
  undefined8 uVar1;
  
                    /* 0x86a0  47  HKMOpen */
  SetLastError(0);
  _Memory = malloc(0xbb0);
  if (_Memory == (int *)0x0) {
    dwErrCode = GetLastError();
    if (0xbfff < dwErrCode) {
      dwErrCode = 0xe00c;
    }
    if (dwErrCode == 0) {
      dwErrCode = 0xe001;
    }
  }
  else {
    uVar1 = FUN_1800164e0(param_1,_Memory,param_2 & 0xcfffffff);
    dwErrCode = _Memory[0x2a7];
    if ((int)uVar1 == 0) {
      free(_Memory);
      _Memory = (int *)0x0;
    }
    if (_Memory != (int *)0x0) {
      return _Memory;
    }
  }
  if ((param_2 & 0x30000000) == 0x10000000) {
    SetLastError(dwErrCode);
  }
  else if ((param_2 & 0x30000000) == 0x20000000) {
    FUN_1800162f0();
    return (int *)0x0;
  }
  return (int *)0x0;
}



/* ===== HKMOpen2 ===== */

int * HKMOpen2(uint param_1,uint param_2,uint param_3)

{
  int *piVar1;
  DWORD aDStackX_18 [4];
  
                    /* 0x86b0  48  HKMOpen2 */
  aDStackX_18[0] = 0;
  piVar1 = FUN_180019600(param_1,param_2,param_3 & 0xcfffffff,aDStackX_18);
  if (piVar1 == (int *)0x0) {
    if ((param_3 & 0x30000000) == 0x10000000) {
      SetLastError(aDStackX_18[0]);
    }
    else if ((param_3 & 0x30000000) == 0x20000000) {
      FUN_1800162f0();
      return (int *)0x0;
    }
  }
  return piVar1;
}



/* ===== HKMIsOpen ===== */

undefined8 HKMIsOpen(int *param_1,byte param_2)

{
  BOOL BVar1;
  undefined8 uVar2;
  
                    /* 0x86c0  29  HKMIsOpen */
  if (param_1 != (int *)0x0) {
    BVar1 = IsBadReadPtr(param_1,0xbb0);
    if (BVar1 == 0) {
      uVar2 = FUN_180016840(param_1,param_2);
      return uVar2;
    }
  }
  return 0;
}



/* ===== HKMClose ===== */

undefined8 HKMClose(int *param_1)

{
  BOOL BVar1;
  undefined8 uVar2;
  
                    /* 0x8710  7  HKMClose */
  if (param_1 != (int *)0x0) {
    BVar1 = IsBadReadPtr(param_1,0xbb0);
    if (BVar1 == 0) {
      uVar2 = FUN_180016920(param_1);
      return uVar2;
    }
  }
  return 0;
}



/* ===== HKMGetDevInfo ===== */

uint HKMGetDevInfo(int *param_1,undefined4 param_2,int param_3)

{
  BOOL BVar1;
  uint uVar2;
  
                    /* 0x8750  15  HKMGetDevInfo */
  if (param_1 != (int *)0x0) {
    BVar1 = IsBadReadPtr(param_1,0xbb0);
    if (BVar1 == 0) {
      uVar2 = FUN_180016950(param_1,param_2,param_3);
      return uVar2;
    }
  }
  return 0;
}



/* ===== HKMGetSerialNumber ===== */

int HKMGetSerialNumber(int *param_1,int param_2)

{
  BOOL BVar1;
  int iVar2;
  
                    /* 0x8830  22  HKMGetSerialNumber */
  if (param_1 != (int *)0x0) {
    BVar1 = IsBadReadPtr(param_1,0xbb0);
    if (BVar1 == 0) {
      iVar2 = FUN_1800169f0(param_1,param_2);
      return iVar2;
    }
  }
  return 0;
}



/* ===== HKMSetKeyInterval ===== */

undefined8 HKMSetKeyInterval(int *param_1,uint param_2,uint param_3)

{
  BOOL BVar1;
  undefined8 uVar2;
  
                    /* 0x8bf0  61  HKMSetKeyInterval */
  if ((param_1 != (int *)0x0) && (param_2 <= param_3)) {
    BVar1 = IsBadReadPtr(param_1,0xbb0);
    if (BVar1 == 0) {
      uVar2 = FUN_180016f00(param_1,param_2,param_3 - param_2);
      return uVar2;
    }
  }
  return 0;
}



/* ===== HKMSetMouseInterval ===== */

undefined8 HKMSetMouseInterval(int *param_1,uint param_2,uint param_3)

{
  BOOL BVar1;
  undefined8 uVar2;
  
                    /* 0x8c50  64  HKMSetMouseInterval */
  if ((param_1 != (int *)0x0) && (param_2 <= param_3)) {
    BVar1 = IsBadReadPtr(param_1,0xbb0);
    if (BVar1 == 0) {
      uVar2 = FUN_180016f60(param_1,param_2,param_3 - param_2);
      return uVar2;
    }
  }
  return 0;
}



/* ===== HKMSetMouseSpeed ===== */

undefined8 HKMSetMouseSpeed(int *param_1,int param_2)

{
  BOOL BVar1;
  undefined8 uVar2;
  
                    /* 0x8d60  68  HKMSetMouseSpeed */
  if (param_1 != (int *)0x0) {
    BVar1 = IsBadReadPtr(param_1,0xbb0);
    if (BVar1 == 0) {
      uVar2 = FUN_180017070(param_1,param_2);
      return uVar2;
    }
  }
  return 0;
}



/* ===== HKMKeyPress ===== */

ulonglong HKMKeyPress(int *param_1,LPCWSTR param_2)

{
  BOOL BVar1;
  int iVar2;
  ulonglong uVar3;
  
                    /* 0x8e50  31  HKMKeyPress */
  if ((param_1 == (int *)0x0) || (BVar1 = IsBadReadPtr(param_1,0xbb0), BVar1 != 0)) {
    return 0;
  }
  if (0xffff < (uint)param_2) {
    if (param_1[0x2a6] == 1) {
      iVar2 = IsBadStringPtrA((LPCSTR)param_2,0x80);
    }
    else {
      iVar2 = IsBadStringPtrW(param_2,0x40);
    }
    if (iVar2 != 0) {
      return 0;
    }
  }
  uVar3 = FUN_180019910(param_1,0,(ushort *)param_2);
  return uVar3;
}



/* ===== HKMKeyDown ===== */

ulonglong HKMKeyDown(int *param_1,LPCWSTR param_2)

{
  BOOL BVar1;
  int iVar2;
  ulonglong uVar3;
  
                    /* 0x8ed0  30  HKMKeyDown */
  if ((param_1 == (int *)0x0) || (BVar1 = IsBadReadPtr(param_1,0xbb0), BVar1 != 0)) {
    return 0;
  }
  if (0xffff < (uint)param_2) {
    if (param_1[0x2a6] == 1) {
      iVar2 = IsBadStringPtrA((LPCSTR)param_2,0x80);
    }
    else {
      iVar2 = IsBadStringPtrW(param_2,0x40);
    }
    if (iVar2 != 0) {
      return 0;
    }
  }
  uVar3 = FUN_180019910(param_1,1,(ushort *)param_2);
  return uVar3;
}



/* ===== HKMKeyUp ===== */

ulonglong HKMKeyUp(int *param_1,LPCWSTR param_2)

{
  BOOL BVar1;
  int iVar2;
  ulonglong uVar3;
  
                    /* 0x8f50  32  HKMKeyUp */
  if ((param_1 == (int *)0x0) || (BVar1 = IsBadReadPtr(param_1,0xbb0), BVar1 != 0)) {
    return 0;
  }
  if (0xffff < (uint)param_2) {
    if (param_1[0x2a6] == 1) {
      iVar2 = IsBadStringPtrA((LPCSTR)param_2,0x80);
    }
    else {
      iVar2 = IsBadStringPtrW(param_2,0x40);
    }
    if (iVar2 != 0) {
      return 0;
    }
  }
  uVar3 = FUN_180019910(param_1,2,(ushort *)param_2);
  return uVar3;
}



/* ===== HKMMoveTo ===== */

ulonglong HKMMoveTo(int *param_1,int param_2,int param_3)

{
  BOOL BVar1;
  ulonglong uVar2;
  
                    /* 0x8fd0  46  HKMMoveTo */
  if (param_1 != (int *)0x0) {
    BVar1 = IsBadReadPtr(param_1,0xbb0);
    if (BVar1 == 0) {
      uVar2 = FUN_180017210(param_1,param_2,param_3);
      return uVar2;
    }
  }
  return 0;
}



/* ===== HKMMoveR ===== */

undefined8 HKMMoveR(int *param_1,uint param_2,uint param_3)

{
  BOOL BVar1;
  undefined8 uVar2;
  
                    /* 0x9030  43  HKMMoveR */
  if (param_1 != (int *)0x0) {
    BVar1 = IsBadReadPtr(param_1,0xbb0);
    if (BVar1 == 0) {
      uVar2 = FUN_180017360(param_1,param_2,param_3);
      return uVar2;
    }
  }
  return 0;
}



/* ===== HKMMoveR2 ===== */

ulonglong HKMMoveR2(int *param_1,uint param_2,uint param_3)

{
  BOOL BVar1;
  ulonglong uVar2;
  
                    /* 0x9090  44  HKMMoveR2 */
  if (param_1 != (int *)0x0) {
    BVar1 = IsBadReadPtr(param_1,0xbb0);
    if (BVar1 == 0) {
      uVar2 = FUN_1800173d0(param_1,param_2,param_3);
      return uVar2;
    }
  }
  return 0;
}



/* ===== HKMLeftClick ===== */

undefined8 HKMLeftClick(int *param_1)

{
  BOOL BVar1;
  undefined8 uVar2;
  
                    /* 0x9150  33  HKMLeftClick */
  if (param_1 != (int *)0x0) {
    BVar1 = IsBadReadPtr(param_1,0xbb0);
    if (BVar1 == 0) {
      uVar2 = FUN_180017630(param_1,0);
      return uVar2;
    }
  }
  return 0;
}



/* ===== HKMRightClick ===== */

undefined8 HKMRightClick(int *param_1)

{
  BOOL BVar1;
  undefined8 uVar2;
  
                    /* 0x9190  52  HKMRightClick */
  if (param_1 != (int *)0x0) {
    BVar1 = IsBadReadPtr(param_1,0xbb0);
    if (BVar1 == 0) {
      uVar2 = FUN_180017630(param_1,1);
      return uVar2;
    }
  }
  return 0;
}



/* ===== HKMMouseWheel ===== */

undefined8 HKMMouseWheel(int *param_1,uint param_2)

{
  BOOL BVar1;
  undefined8 uVar2;
  
                    /* 0x9650  41  HKMMouseWheel */
  if (param_1 != (int *)0x0) {
    BVar1 = IsBadReadPtr(param_1,0xbb0);
    if (BVar1 == 0) {
      uVar2 = FUN_1800176a0(param_1,param_2);
      return uVar2;
    }
  }
  return 0;
}



/* ===== HKMReleaseKeyboard ===== */

undefined8 HKMReleaseKeyboard(int *param_1)

{
  BOOL BVar1;
  undefined8 uVar2;
  
                    /* 0x96f0  50  HKMReleaseKeyboard */
  if (param_1 != (int *)0x0) {
    BVar1 = IsBadReadPtr(param_1,0xbb0);
    if (BVar1 == 0) {
      uVar2 = FUN_1800177a0(param_1);
      return uVar2;
    }
  }
  return 0;
}



/* ===== HKMReleaseMouse ===== */

undefined8 HKMReleaseMouse(int *param_1)

{
  BOOL BVar1;
  undefined8 uVar2;
  
                    /* 0x9730  51  HKMReleaseMouse */
  if (param_1 != (int *)0x0) {
    BVar1 = IsBadReadPtr(param_1,0xbb0);
    if (BVar1 == 0) {
      uVar2 = FUN_1800177f0(param_1);
      return uVar2;
    }
  }
  return 0;
}



/* ===== HKMOutputString ===== */

ulonglong HKMOutputString(int *param_1,LPWSTR param_2)

{
  BOOL BVar1;
  int iVar2;
  ulonglong uVar3;
  
                    /* 0x9770  49  HKMOutputString */
  if (param_1 != (int *)0x0) {
    BVar1 = IsBadReadPtr(param_1,0xbb0);
    if ((BVar1 == 0) && (param_2 != (LPWSTR)0x0)) {
      if (param_1[0x2a6] == 1) {
        iVar2 = IsBadStringPtrA((LPCSTR)param_2,0x80);
      }
      else {
        iVar2 = IsBadStringPtrW(param_2,0x40);
      }
      if (iVar2 == 0) {
        uVar3 = FUN_1800187c0(param_1,param_2);
        return uVar3;
      }
    }
  }
  return 0;
}



/* ===== HKMDelayRnd ===== */

undefined8 HKMDelayRnd(int *param_1,uint param_2,uint param_3)

{
  BOOL BVar1;
  undefined8 uVar2;
  
                    /* 0x97f0  8  HKMDelayRnd */
  if (param_1 != (int *)0x0) {
    BVar1 = IsBadReadPtr(param_1,0xbb0);
    if ((BVar1 == 0) && (param_2 <= param_3)) {
      uVar2 = FUN_180017150(param_1,param_2,param_3 - param_2);
      return uVar2;
    }
  }
  return 0;
}



/* ===== HKMVerifyUserData ===== */

undefined4 HKMVerifyUserData(int *param_1,LPWSTR param_2,int param_3)

{
  BOOL BVar1;
  int iVar2;
  undefined4 uVar3;
  
                    /* 0x98d0  72  HKMVerifyUserData */
  if (param_1 != (int *)0x0) {
    BVar1 = IsBadReadPtr(param_1,0xbb0);
    if ((BVar1 == 0) && (param_2 != (LPWSTR)0x0)) {
      if (param_1[0x2a6] == 1) {
        iVar2 = IsBadStringPtrA((LPCSTR)param_2,0x80);
      }
      else {
        iVar2 = IsBadStringPtrW(param_2,0x40);
      }
      if (iVar2 == 0) {
        uVar3 = FUN_180018b70(param_1,param_2,param_3);
        return uVar3;
      }
    }
  }
  return 0;
}



/* ===== HKMVerifyUserData2 ===== */

undefined4 HKMVerifyUserData2(int *param_1,wchar_t *param_2,int param_3)

{
  BOOL BVar1;
  int iVar2;
  undefined4 uVar3;
  
                    /* 0x9960  73  HKMVerifyUserData2 */
  if (param_1 != (int *)0x0) {
    BVar1 = IsBadReadPtr(param_1,0xbb0);
    if ((BVar1 == 0) && (param_2 != (wchar_t *)0x0)) {
      if (param_1[0x2a6] == 1) {
        iVar2 = IsBadStringPtrA((LPCSTR)param_2,0x80);
      }
      else {
        iVar2 = IsBadStringPtrW(param_2,0x40);
      }
      if (iVar2 == 0) {
        uVar3 = FUN_180018ca0(param_1,param_2,param_3);
        return uVar3;
      }
    }
  }
  return 0;
}



/* ===== HKMSetLightMode ===== */

undefined8 HKMSetLightMode(int *param_1,uint param_2,int param_3)

{
  BOOL BVar1;
  undefined8 uVar2;
  
                    /* 0x9ab0  62  HKMSetLightMode */
  if (param_1 != (int *)0x0) {
    BVar1 = IsBadReadPtr(param_1,0xbb0);
    if (BVar1 == 0) {
      uVar2 = FUN_180018e90(param_1,param_2,param_3);
      return uVar2;
    }
  }
  return 0;
}



/* ===== HKMGetError ===== */

int HKMGetError(int *param_1)

{
  BOOL BVar1;
  int iVar2;
  
                    /* 0x9c30  17  HKMGetError */
  if (param_1 != (int *)0x0) {
    BVar1 = IsBadReadPtr(param_1,0xbb0);
    if (BVar1 == 0) {
      iVar2 = FUN_1800190d0(param_1,0);
      return iVar2;
    }
  }
  return 0xe004;
}


