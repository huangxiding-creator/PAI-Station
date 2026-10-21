
/* WARNING: Function: __security_check_cookie replaced with injection: security_check_cookie */

undefined1 FUN_1001c260(void)

{
  bool bVar1;
  char cVar2;
  undefined1 uVar3;
  QVariant *pQVar4;
  int iVar5;
  QString *pQVar6;
  QVariant *pQVar7;
  undefined4 uVar8;
  QFileInfo *this;
  QByteArray *pQVar9;
  undefined2 *puVar10;
  QCoreApplication *this_00;
  KxMainWindow *pKVar11;
  ExternalRefCountData *pEVar12;
  undefined4 *puVar13;
  QUuid *this_01;
  undefined4 uVar14;
  undefined4 uVar15;
  QObject *pQVar16;
  QHashData *pQVar17;
  char *pcVar18;
  QObject *pQVar19;
  QVariant *pQVar20;
  QVariant *pQVar21;
  QVariant **ppQVar22;
  int *piVar23;
  char *pcStack_1c0;
  QVariant local_170 [16];
  QVariant local_160 [16];
  undefined1 local_150 [4];
  undefined1 local_14c [4];
  undefined1 local_148 [4];
  undefined1 local_144 [4];
  QString local_140 [4];
  QString *local_13c;
  QObject *local_138;
  void **local_134;
  QString local_130 [4];
  QString local_12c [4];
  QString local_128 [4];
  QString local_124 [4];
  QString local_120 [4];
  QString local_11c [4];
  QString local_118 [4];
  QString local_114 [4];
  undefined1 local_110;
  int *local_10c;
  undefined4 local_108;
  undefined4 local_104;
  QString local_100 [4];
  QString local_fc [4];
  QString local_f8 [4];
  QVariant local_f4 [8];
  undefined4 local_ec;
  undefined4 local_e8;
  QFile local_e4 [8];
  QString local_dc [4];
  QString local_d8 [4];
  QString local_d4 [4];
  QString local_d0 [4];
  QString local_cc [4];
  QString local_c8 [4];
  QString local_c4 [4];
  code *local_c0;
  QString local_bc [4];
  QString local_b8 [4];
  QString local_b4 [4];
  QVariant local_b0 [8];
  QString *local_a8;
  QObject *local_a4;
  QString local_a0 [4];
  int local_9c;
  int local_98;
  QVariant local_94 [16];
  QString local_84 [4];
  int local_80;
  QString local_7c [4];
  void **local_78;
  QVariant local_74 [8];
  undefined4 local_6c;
  undefined4 *local_68;
  QMapDataBase *local_64;
  QString local_60 [4];
  int local_5c;
  QHashData *local_58;
  QString local_54 [2];
  undefined1 local_52;
  char local_51;
  QMapDataBase *local_50;
  QString local_4c [4];
  QVariant *local_48;
  QObject *local_44;
  QVariant *local_40;
  QVariant *local_3c;
  int local_38;
  QVariant *local_34;
  QVariant *local_30;
  QString local_2c [4];
  QString local_28 [4];
  QString local_24 [4];
  QString local_20 [4];
  QString local_1c [4];
  QString local_18 [4];
  uint local_14;
  void *local_10;
  undefined1 *puStack_c;
  undefined4 local_8;
  
  local_8 = 0xffffffff;
  puStack_c = &LAB_102b1180;
  local_10 = ExceptionList;
  local_14 = DAT_10401e54 ^ (uint)&stack0xfffffffc;
  ExceptionList = &local_10;
  local_3c = (QVariant *)0x0;
  kso_qt::QString::QString((QString *)&local_38);
  local_8 = 0;
  pQVar4 = (QVariant *)kso_qt::QVariant::QVariant(local_94);
  local_8._0_1_ = 1;
  iVar5 = FUN_1000e470();
  if (iVar5 != 0) {
    pQVar4 = (QVariant *)(iVar5 + 0x10);
  }
  kso_qt::QVariant::QVariant(local_b0,pQVar4);
  kso_qt::QVariant::~QVariant(local_94);
  local_8._0_1_ = 2;
  kso_qt::QVariant::toMap(local_b0);
  kso_qt::QVariant::~QVariant(local_b0);
  local_8._0_1_ = 5;
  kso_qt::QString::~QString((QString *)&local_38);
  kso_qt::QString::QString((QString *)&local_40);
  pQVar4 = (QVariant *)kso_qt::QVariant::QVariant(local_94);
  local_8._0_1_ = 7;
  iVar5 = FUN_1000e470();
  if (iVar5 != 0) {
    pQVar4 = (QVariant *)(iVar5 + 0x10);
  }
  kso_qt::QVariant::QVariant(local_74,pQVar4);
  kso_qt::QVariant::~QVariant(local_94);
  local_8._0_1_ = 8;
  kso_qt::QVariant::toMap(local_74);
  kso_qt::QVariant::~QVariant(local_74);
  local_8._0_1_ = 0xb;
  kso_qt::QString::~QString((QString *)&local_40);
  kso_qt::QString::QString((QString *)&local_38);
  pQVar4 = (QVariant *)kso_qt::QVariant::QVariant(local_94);
  local_8._0_1_ = 0xd;
  iVar5 = FUN_1000e470();
  if (iVar5 != 0) {
    pQVar4 = (QVariant *)(iVar5 + 0x10);
  }
  kso_qt::QVariant::QVariant(local_b0,pQVar4);
  kso_qt::QVariant::~QVariant(local_94);
  local_8._0_1_ = 0xe;
  kso_qt::QVariant::toString(local_b0);
  kso_qt::QVariant::~QVariant(local_b0);
  local_8._0_1_ = 0x11;
  kso_qt::QString::~QString((QString *)&local_38);
  kso_qt::QString::QString((QString *)&local_40);
  local_30 = (QVariant *)kso_qt::QVariant::QVariant(local_94);
  local_8._0_1_ = 0x13;
  iVar5 = FUN_1000e470();
  pQVar4 = local_30;
  if (iVar5 != 0) {
    pQVar4 = (QVariant *)(iVar5 + 0x10);
  }
  kso_qt::QVariant::QVariant(local_74,pQVar4);
  kso_qt::QVariant::~QVariant(local_94);
  local_8._0_1_ = 0x14;
  kso_qt::QVariant::toString(local_74);
  kso_qt::QVariant::~QVariant(local_74);
  local_8 = CONCAT31(local_8._1_3_,0x17);
  kso_qt::QString::~QString((QString *)&local_40);
  if ((*(int *)(local_9c + 4) == 0) && (*(int *)(local_80 + 4) != 0)) {
    kso_qt::QChar::QChar((QChar *)&pcStack_1c0,0x5f);
    pQVar6 = (QString *)kso_qt::QString::section((QString *)&local_80,&local_30);
    kso_qt::QString::operator=((QString *)&local_9c,pQVar6);
    kso_qt::QString::~QString((QString *)&local_30);
  }
  kso_qt::QString::QString(local_60,(QString *)&local_9c);
  local_8._0_1_ = 0x18;
  kso_qt::QString::QString((QString *)&local_38);
  local_30 = (QVariant *)kso_qt::QVariant::QVariant(local_94);
  local_8._0_1_ = 0x1a;
  pcStack_1c0 = (char *)0x1001c4f1;
  iVar5 = FUN_1000e470();
  pQVar4 = local_30;
  if (iVar5 != 0) {
    pQVar4 = (QVariant *)(iVar5 + 0x10);
  }
  pcStack_1c0 = (char *)0x1001c506;
  kso_qt::QVariant::QVariant(local_b0,pQVar4);
  kso_qt::QVariant::~QVariant(local_94);
  local_8._0_1_ = 0x1b;
  pcStack_1c0 = (char *)0x1001c521;
  kso_qt::QVariant::toString(local_b0);
  pcStack_1c0 = (char *)0x1001c529;
  kso_qt::QVariant::~QVariant(local_b0);
  local_8._0_1_ = 0x1e;
  pcStack_1c0 = (char *)0x1001c536;
  kso_qt::QString::~QString((QString *)&local_38);
  pcStack_1c0 = "file_path";
  kso_qt::QString::QString((QString *)&local_40,9);
  local_30 = (QVariant *)kso_qt::QVariant::QVariant(local_94);
  local_8._0_1_ = 0x20;
  iVar5 = FUN_1000e470(&local_40);
  pQVar4 = local_30;
  if (iVar5 != 0) {
    pQVar4 = (QVariant *)(iVar5 + 0x10);
  }
  kso_qt::QVariant::QVariant(local_74,pQVar4);
  kso_qt::QVariant::~QVariant(local_94);
  pQVar6 = local_b8;
  local_8._0_1_ = 0x21;
  kso_qt::QVariant::toString(local_74);
  kso_qt::QVariant::~QVariant(local_74);
  local_8._0_1_ = 0x24;
  kso_qt::QString::~QString((QString *)&local_40);
  kso_qt::QString::QString((QString *)&local_38,9,"file_data",pQVar6);
  local_30 = (QVariant *)kso_qt::QVariant::QVariant(local_94);
  local_8._0_1_ = 0x26;
  iVar5 = FUN_1000e470(&local_38);
  pQVar4 = local_30;
  if (iVar5 != 0) {
    pQVar4 = (QVariant *)(iVar5 + 0x10);
  }
  kso_qt::QVariant::QVariant(local_b0,pQVar4);
  kso_qt::QVariant::~QVariant(local_94);
  piVar23 = &local_98;
  local_8._0_1_ = 0x27;
  kso_qt::QVariant::toString(local_b0);
  kso_qt::QVariant::~QVariant(local_b0);
  local_8._0_1_ = 0x2a;
  kso_qt::QString::~QString((QString *)&local_38);
  kso_qt::QString::QString((QString *)&local_34,9,"encrypted",piVar23);
  pQVar4 = (QVariant *)0xfffc01;
  local_8 = CONCAT31(local_8._1_3_,0x2b);
  local_3c = (QVariant *)0xfffc01;
  iVar5 = FUN_1000e470(&local_34);
  if (iVar5 == 0) {
    kso_qt::QString::QString((QString *)&local_40,0x14,"external_encrypt_doc");
    pQVar4 = (QVariant *)0xfffc03;
    local_3c = (QVariant *)0xfffc03;
    iVar5 = FUN_1000e470(&local_40);
    local_51 = '\x01';
    if (iVar5 == 0) goto LAB_1001c66d;
  }
  else {
LAB_1001c66d:
    local_51 = '\0';
  }
  if (((uint)pQVar4 & 2) != 0) {
    pQVar4 = (QVariant *)((uint)pQVar4 & 0xfffffffd);
    local_3c = pQVar4;
    kso_qt::QString::~QString((QString *)&local_40);
  }
  local_8 = 0x2a;
  if (((uint)pQVar4 & 1) != 0) {
    pQVar4 = (QVariant *)((uint)pQVar4 & 0xfffffffe);
    local_3c = pQVar4;
    kso_qt::QString::~QString((QString *)&local_34);
  }
  if (local_51 == '\0') {
    kso_qt::QString::QString((QString *)&local_40,0x14,"external_encrypt_doc");
    local_3c = (QVariant *)((uint)pQVar4 | 0x10);
    local_30 = (QVariant *)kso_qt::QVariant::QVariant(local_94);
    local_8 = 0x30;
    iVar5 = FUN_1000e470(&local_40);
    pQVar7 = local_30;
    if (iVar5 != 0) {
      pQVar7 = (QVariant *)(iVar5 + 0x10);
    }
    kso_qt::QVariant::QVariant(local_74,pQVar7);
    kso_qt::QVariant::~QVariant(local_94);
    local_8 = 0x31;
    pQVar7 = local_74;
    pQVar4 = (QVariant *)((uint)pQVar4 | 0xc000030);
  }
  else {
    kso_qt::QString::QString((QString *)&local_48,9,"encrypted");
    local_3c = (QVariant *)((uint)pQVar4 | 4);
    local_30 = (QVariant *)kso_qt::QVariant::QVariant(local_94);
    local_8 = 0x2d;
    iVar5 = FUN_1000e470(&local_48);
    pQVar7 = local_30;
    if (iVar5 != 0) {
      pQVar7 = (QVariant *)(iVar5 + 0x10);
    }
    kso_qt::QVariant::QVariant(local_f4,pQVar7);
    kso_qt::QVariant::~QVariant(local_94);
    local_8 = 0x2e;
    pQVar7 = local_f4;
    pQVar4 = (QVariant *)((uint)pQVar4 | 0x300000c);
  }
  local_3c = pQVar4;
  local_34 = pQVar4;
  local_51 = kso_qt::QVariant::toBool(pQVar7);
  if (((uint)pQVar4 & 0x20) != 0) {
    pQVar4 = (QVariant *)((uint)pQVar4 & 0xffffffdf);
    local_34 = pQVar4;
    kso_qt::QVariant::~QVariant(local_74);
  }
  if (((uint)pQVar4 & 0x10) != 0) {
    pQVar4 = (QVariant *)((uint)pQVar4 & 0xffffffef);
    local_34 = pQVar4;
    kso_qt::QString::~QString((QString *)&local_40);
  }
  if (((uint)pQVar4 & 8) != 0) {
    pQVar4 = (QVariant *)((uint)pQVar4 & 0xfffffff7);
    local_34 = pQVar4;
    kso_qt::QVariant::~QVariant(local_f4);
  }
  local_8 = 0x2a;
  if (((uint)pQVar4 & 4) != 0) {
    local_34 = (QVariant *)((uint)pQVar4 & 0xfffffffb);
    kso_qt::QString::~QString((QString *)&local_48);
  }
  kso_qt::QString::QString(local_2c,0x18,"wps_styleset_preset_item");
  local_8._0_1_ = 0x32;
  kso_qt::QString::QString(local_28,10,"stylesheet");
  local_8._0_1_ = 0x33;
  kso_qt::QString::QString(local_24,0x17,"wps_styleset_docer_item");
  local_8._0_1_ = 0x34;
  kso_qt::QString::QString(local_20,10,"stylesheet");
  local_8._0_1_ = 0x35;
  kso_qt::QString::QString(local_1c,10,"stylesheet");
  local_8._0_1_ = 0x36;
  kso_qt::QString::QString(local_18,10,"stylesheet");
  pQVar6 = local_2c;
  local_8 = CONCAT31(local_8._1_3_,0x37);
  local_40 = (QVariant *)shared_null_exref;
  do {
    FUN_10021fd0();
    local_30 = local_40;
    local_3c = (QVariant *)0x0;
    local_38 = CONCAT31(local_38._1_3_,1);
    pQVar7 = local_40 + 8;
    pQVar4 = local_40;
    if (*(QVariant **)(local_40 + 0xc) == (QVariant *)0x0) {
LAB_1001c8e2:
      FUN_10021d40(pQVar6,pQVar6 + 4,pQVar7,local_38);
    }
    else {
      pQVar20 = (QVariant *)0x0;
      pQVar7 = *(QVariant **)(local_40 + 0xc);
      do {
        local_48 = pQVar7;
        bVar1 = kso_qt::operator<((QString *)(pQVar7 + 0xc),pQVar6);
        pQVar4 = local_30;
        if (bVar1) {
          pQVar21 = *(QVariant **)(pQVar7 + 8);
          local_38 = (uint)local_38._1_3_ << 8;
        }
        else {
          local_38 = CONCAT31(local_38._1_3_,1);
          pQVar21 = *(QVariant **)(pQVar7 + 4);
          pQVar20 = pQVar7;
        }
        pQVar7 = pQVar21;
      } while (pQVar21 != (QVariant *)0x0);
      pQVar7 = local_48;
      local_3c = pQVar20;
      if ((pQVar20 == (QVariant *)0x0) ||
         (bVar1 = kso_qt::operator<(pQVar6,(QString *)(pQVar20 + 0xc)), pQVar7 = local_48, bVar1))
      goto LAB_1001c8e2;
      kso_qt::QString::operator=((QString *)(pQVar20 + 0x10),pQVar6 + 4);
    }
    pQVar6 = pQVar6 + 8;
  } while (pQVar6 != (QString *)&local_14);
  local_8._0_1_ = 0x39;
  _eh_vector_destructor_iterator_(local_2c,8,3,FUN_10013930);
  kso_qt::QString::QString((QString *)&local_48,0xc,"openPosition");
  pQVar7 = (QVariant *)kso_qt::QVariant::QVariant(local_94);
  local_8._0_1_ = 0x3b;
  iVar5 = FUN_1000e470(&local_48);
  if (iVar5 != 0) {
    pQVar7 = (QVariant *)(iVar5 + 0x10);
  }
  kso_qt::QVariant::QVariant(local_b0,pQVar7);
  local_3c = (QVariant *)((uint)local_34 | 0x30000000);
  local_34 = local_3c;
  kso_qt::QVariant::~QVariant(local_94);
  local_8._0_1_ = 0x3c;
  uVar8 = kso_qt::QVariant::toString(local_b0);
  local_30 = (QVariant *)kso_qt::QString::QString((QString *)&local_44);
  iVar5 = FUN_1000e470(uVar8);
  pQVar6 = (QString *)local_30;
  if (iVar5 != 0) {
    pQVar6 = (QString *)(iVar5 + 0x10);
  }
  kso_qt::QString::QString(local_c4,pQVar6);
  kso_qt::QString::~QString((QString *)&local_44);
  kso_qt::QString::~QString(local_4c);
  kso_qt::QVariant::~QVariant(local_b0);
  kso_qt::QString::~QString((QString *)&local_48);
  kso_qt::QByteArray::QByteArray((QByteArray *)&local_5c);
  local_8._0_1_ = 0x40;
  this = (QFileInfo *)kso_qt::QFileInfo::QFileInfo((QFileInfo *)&local_30,local_b8);
  local_8._0_1_ = 0x41;
  bVar1 = kso_qt::QFileInfo::exists(this);
  local_8._0_1_ = 0x40;
  kso_qt::QFileInfo::~QFileInfo((QFileInfo *)&local_30);
  if (bVar1) {
    kso_qt::QFile::QFile((QFile *)&local_6c,local_b8);
    local_8._0_1_ = 0x42;
    bVar1 = kso_qt::QFile::open((QFile *)&local_6c,1);
    pQVar7 = local_34;
    if (bVar1) {
      if (local_51 == '\0') {
        if (*(int *)(local_80 + 4) == 0) {
          local_ec = 0;
          local_e8 = 0;
          uVar8 = FUN_10013020();
          pQVar7 = local_34;
          pQVar6 = local_4c;
          local_3c = (QVariant *)((uint)local_34 | 0x40);
          local_8 = CONCAT31(local_8._1_3_,0x43);
          uVar14 = kso_qt::QIODevice::readAll((QIODevice *)&local_6c);
          local_8._0_1_ = 0x44;
          local_8._1_3_ = 0;
          local_3c = (QVariant *)((uint)pQVar7 | 0xc0);
          pQVar9 = (QByteArray *)FUN_1010aa10(&local_44,uVar14,uVar8,pQVar6);
          pQVar7 = (QVariant *)((uint)pQVar7 | 0x1c0);
        }
        else {
          pQVar9 = (QByteArray *)kso_qt::QIODevice::readAll((QIODevice *)&local_6c);
          pQVar7 = (QVariant *)((uint)local_34 | 0x200);
        }
        kso_qt::QByteArray::operator=((QByteArray *)&local_5c,pQVar9);
        if (((uint)pQVar7 & 0x200) != 0) {
          pQVar7 = (QVariant *)((uint)pQVar7 & 0xfffffdff);
          kso_qt::QByteArray::~QByteArray((QByteArray *)&local_30);
        }
        if (((uint)pQVar7 & 0x100) != 0) {
          pQVar7 = (QVariant *)((uint)pQVar7 & 0xfffffeff);
          kso_qt::QByteArray::~QByteArray((QByteArray *)&local_44);
        }
        if ((char)pQVar7 < '\0') {
          pQVar7 = (QVariant *)((uint)pQVar7 & 0xffffff7f);
          kso_qt::QByteArray::~QByteArray((QByteArray *)local_4c);
        }
        local_8 = 0x42;
        if (((uint)pQVar7 & 0x40) != 0) {
          pQVar7 = (QVariant *)((uint)pQVar7 & 0xffffffbf);
          kso_qt::QByteArray::~QByteArray((QByteArray *)&local_e8);
          kso_qt::QByteArray::~QByteArray((QByteArray *)&local_ec);
        }
        kso_qt::QFileDevice::close((QFileDevice *)&local_6c);
        local_8._0_1_ = 0x40;
        kso_qt::QFile::~QFile((QFile *)&local_6c);
      }
      else {
        pQVar9 = (QByteArray *)kso_qt::QIODevice::readAll((QIODevice *)&local_6c);
        kso_qt::QByteArray::operator=((QByteArray *)&local_5c,pQVar9);
        kso_qt::QByteArray::~QByteArray((QByteArray *)&local_30);
        pQVar7 = local_34;
        kso_qt::QFileDevice::close((QFileDevice *)&local_6c);
        local_8._0_1_ = 0x40;
        kso_qt::QFile::~QFile((QFile *)&local_6c);
      }
    }
    else {
      local_8._0_1_ = 0x40;
      kso_qt::QFile::~QFile((QFile *)&local_6c);
    }
  }
  else {
    pQVar7 = local_34;
    if (*(int *)(local_98 + 4) != 0) {
      if (local_51 == '\0') {
        local_6c = 0;
        local_68 = (undefined4 *)0x0;
        uVar8 = FUN_10013020();
        pQVar6 = local_4c;
        local_8._0_1_ = 0x47;
        uVar14 = kso_qt::QString::toUtf8((QString *)&local_98);
        pQVar9 = (QByteArray *)&local_44;
        local_8._0_1_ = 0x48;
        uVar15 = kso_qt::QByteArray::fromBase64(pQVar9);
        local_8._0_1_ = 0x49;
        pQVar9 = (QByteArray *)FUN_1010aa10(&local_30,uVar15,uVar8,pQVar9,uVar14,pQVar6);
        kso_qt::QByteArray::operator=((QByteArray *)&local_5c,pQVar9);
        kso_qt::QByteArray::~QByteArray((QByteArray *)&local_30);
        kso_qt::QByteArray::~QByteArray((QByteArray *)&local_44);
        kso_qt::QByteArray::~QByteArray((QByteArray *)local_4c);
        local_8._0_1_ = 0x40;
        kso_qt::QByteArray::~QByteArray((QByteArray *)&local_68);
        pQVar9 = (QByteArray *)&local_6c;
      }
      else {
        kso_qt::QString::toUtf8((QString *)&local_98);
        local_8._0_1_ = 0x46;
        pQVar9 = (QByteArray *)kso_qt::QByteArray::fromBase64((QByteArray *)&local_30);
        kso_qt::QByteArray::operator=((QByteArray *)&local_5c,pQVar9);
        kso_qt::QByteArray::~QByteArray((QByteArray *)&local_30);
        local_8._0_1_ = 0x40;
        pQVar9 = (QByteArray *)&local_44;
      }
      kso_qt::QByteArray::~QByteArray(pQVar9);
      pQVar7 = local_34;
    }
  }
  if (*(int *)(local_5c + 4) == 0) {
    uVar3 = 0;
  }
  else {
    pQVar9 = (QByteArray *)
             kso_qt::QCryptographicHash::hash((QByteArray *)&local_44,(Algorithm)&local_5c);
    ppQVar22 = &local_30;
    local_8._0_1_ = 0x4a;
    pQVar9 = (QByteArray *)kso_qt::QByteArray::toHex(pQVar9);
    local_8._0_1_ = 0x4b;
    kso_qt::QString::QString(local_dc,pQVar9);
    kso_qt::QByteArray::~QByteArray((QByteArray *)&local_30);
    local_8._0_1_ = 0x4e;
    kso_qt::QByteArray::~QByteArray((QByteArray *)&local_44);
    kso_qt::QString::QString((QString *)&local_48,6,"custom",ppQVar22);
    local_8._0_1_ = 0x4f;
    pQVar6 = (QString *)FUN_100f2be0(local_4c,&local_48);
    local_8._0_1_ = 0x51;
    kso_qt::QString::QString((QString *)&local_34,pQVar6);
    local_3c = (QVariant *)((uint)pQVar7 | 0x40000000);
    puVar10 = (undefined2 *)kso_qt::QChar::fromLatin1((char)&local_52);
    kso_qt::QString::operator+=((QString *)&local_34,*puVar10);
    local_8._0_1_ = 0x52;
    kso_qt::QString::QString((QString *)&local_38,(QString *)&local_34);
    local_3c = (QVariant *)((uint)pQVar7 | 0xc0000000);
    kso_qt::QString::append((QString *)&local_38,local_dc);
    kso_qt::QDir::toNativeSeparators(local_7c);
    kso_qt::QString::~QString((QString *)&local_38);
    kso_qt::QString::~QString((QString *)&local_34);
    kso_qt::QString::~QString(local_4c);
    local_8._0_1_ = 0x57;
    kso_qt::QString::~QString((QString *)&local_48);
    kso_qt::QFile::QFile(local_e4,local_7c);
    local_8._0_1_ = 0x58;
    bVar1 = kso_qt::QFile::open(local_e4,2);
    if (bVar1) {
      kso_qt::QIODevice::write((QIODevice *)local_e4,(QByteArray *)&local_5c);
      kso_qt::QFileDevice::close((QFileDevice *)local_e4);
      this_00 = kso_qt::QCoreApplication::instance();
      pKVar11 = KxApplication::currentMainWindow((KxApplication *)this_00);
      uVar8 = FUN_1010aab0(pKVar11);
      FUN_1009d980();
      local_a4 = (QObject *)FUN_1009d740(uVar8);
      local_44 = local_a4;
      if (local_a4 == (QObject *)0x0) {
        pEVar12 = (ExternalRefCountData *)0x0;
      }
      else {
        pEVar12 = kso_qt::QtSharedPointer::ExternalRefCountData::getAndRef(local_a4);
      }
      local_8._0_1_ = 0x59;
      local_a8 = (QString *)pEVar12;
      local_30 = (QVariant *)pEVar12;
      if (((pEVar12 == (ExternalRefCountData *)0x0) ||
          (pQVar4 = local_40, *(int *)(pEVar12 + 4) == 0)) || (local_a4 == (QObject *)0x0)) {
        uVar3 = 0;
      }
      else {
        FUN_100ad9a0();
        FUN_100f2e50(local_b4,local_60);
        local_8 = CONCAT31(local_8._1_3_,0x5a);
        iVar5 = FUN_1006a7c0();
        if (iVar5 == 2) {
          kso_qt::QString::operator=(local_b4,0x18,"WPS_layout_typeDoc_again");
        }
        local_58 = (QHashData *)shared_null_exref;
        local_8._0_1_ = 0x5b;
        uVar8 = FUN_100f4090(local_11c);
        local_8._0_1_ = 0x5c;
        kso_qt::QString::QString((QString *)&local_48,0xd,"open_position");
        local_8._0_1_ = 0x5d;
        FUN_10023330(local_144,&local_48,uVar8);
        kso_qt::QString::~QString((QString *)&local_48);
        local_8._0_1_ = 0x5b;
        kso_qt::QString::~QString(local_11c);
        kso_qt::QString::QString((QString *)&local_3c,7,"request");
        local_8._0_1_ = 0x5e;
        kso_qt::QString::QString((QString *)&local_38,0xe,"request_source");
        local_8._0_1_ = 0x5f;
        FUN_10023330(local_150,&local_38,&local_3c);
        kso_qt::QString::~QString((QString *)&local_38);
        local_8._0_1_ = 0x5b;
        kso_qt::QString::~QString((QString *)&local_3c);
        kso_qt::QString::QString(local_54,0xd,"function_code");
        local_8._0_1_ = 0x60;
        FUN_10023330(local_148,local_54,local_b4);
        kso_qt::QString::~QString(local_54);
        uVar8 = kso_qt::QString::QString(local_114);
        local_8._0_1_ = 0x61;
        kso_qt::QString::QString(local_d0,0xf,"ai_request_info");
        local_8._0_1_ = 0x62;
        FUN_10023330(local_14c,local_d0,uVar8);
        kso_qt::QString::~QString(local_d0);
        local_8._0_1_ = 0x5b;
        kso_qt::QString::~QString(local_114);
        kso_qt::QString::QString(local_d8,0x11,"external_category");
        local_8._0_1_ = 99;
        pQVar4 = (QVariant *)FUN_1000cfb0(local_170,local_d8);
        pQVar6 = local_118;
        local_8._0_1_ = 100;
        uVar8 = kso_qt::QVariant::toString(pQVar4);
        local_8._0_1_ = 0x65;
        kso_qt::QString::QString(local_d4,0x11,"external_category",pQVar6);
        local_8._0_1_ = 0x66;
        FUN_10023330(&local_e8,local_d4,uVar8);
        kso_qt::QString::~QString(local_d4);
        kso_qt::QString::~QString(local_118);
        kso_qt::QVariant::~QVariant(local_170);
        local_8._0_1_ = 0x5b;
        kso_qt::QString::~QString(local_d8);
        kso_qt::QString::QString(local_c8,0xb,"category_id");
        local_8._0_1_ = 0x67;
        FUN_10023330(&local_68,local_c8,local_60);
        local_8._0_1_ = 0x5b;
        kso_qt::QString::~QString(local_c8);
        kso_qt::QString::QString(local_cc,0xe,"ai_typesetting");
        local_8._0_1_ = 0x68;
        cVar2 = FUN_100acf50(local_cc,&local_58);
        local_8._0_1_ = 0x5b;
        kso_qt::QString::~QString(local_cc);
        pQVar16 = local_44;
        if (cVar2 == '\0') {
LAB_1001d28d:
          uVar3 = 0;
        }
        else {
          cVar2 = FUN_100bdee0(local_60,local_7c);
          if ((cVar2 != '\0') && (iVar5 = FUN_1006a7c0(), iVar5 == 2)) {
            local_44 = (QObject *)shared_null_exref;
            uVar8 = kso_qt::QString::QString((QString *)&local_c0);
            local_8._0_1_ = 0x6a;
            kso_qt::QString::QString(local_4c,0x15,"template_apply_repeat");
            local_8._0_1_ = 0x6b;
            kso_qt::QString::QString(local_a0,4,&DAT_10312504);
            local_8._0_1_ = 0x6c;
            kso_qt::QString::QString((QString *)&local_34,0xe,"ai_typesetting");
            local_8._0_1_ = 0x6d;
            FUN_100c56c0(&local_34,local_a0,local_4c,uVar8,&local_44,0,0);
            kso_qt::QString::~QString((QString *)&local_34);
            kso_qt::QString::~QString(local_a0);
            kso_qt::QString::~QString(local_4c);
            kso_qt::QString::~QString((QString *)&local_c0);
            local_8._0_1_ = 0x5b;
            FUN_100134a0();
            kso_qt::QString::QString((QString *)&local_30,0x15,"template_apply_repeat");
            local_8._0_1_ = 0x6e;
            FUN_100c4200(&local_30,1);
            local_8._0_1_ = 0x5b;
            kso_qt::QString::~QString((QString *)&local_30);
            FUN_100ca500();
            local_30 = (QVariant *)shared_null_exref;
            local_8._0_1_ = 0x6f;
            FUN_100109b0(&local_30);
            FUN_1000cc00();
            goto LAB_1001d28d;
          }
          if (*(int *)(local_80 + 4) == 0) {
            FUN_1009d980();
            uVar3 = FUN_1009e2e0(local_60);
            local_38 = CONCAT31(local_38._1_3_,uVar3);
            local_68 = operator_new(0x38);
            local_134 = local_78;
            local_8._0_1_ = 0x70;
            if (local_68 == (undefined4 *)0x0) {
              local_3c = (QVariant *)0x0;
            }
            else {
              local_3c = (QVariant *)FUN_10073840(local_78);
            }
            local_140[0] = local_38._0_1_;
            local_13c = local_a8;
            local_138 = pQVar16;
            LOCK();
            *(int *)local_a8 = *(int *)local_a8 + 1;
            UNLOCK();
            kso_qt::QString::QString(local_130,local_60);
            kso_qt::QString::QString(local_12c,local_7c);
            kso_qt::QString::QString(local_128,local_bc);
            local_c0 = FUN_10009f70;
            local_8 = CONCAT31(local_8._1_3_,0x71);
            puVar13 = operator_new(0x24);
            local_68 = puVar13;
            if (puVar13 == (undefined4 *)0x0) {
              puVar13 = (undefined4 *)0x0;
            }
            else {
              FUN_10011dc0(local_140);
              *puVar13 = 1;
              puVar13[1] = FUN_10022bd0;
              *(undefined1 *)(puVar13 + 2) = local_110;
              puVar13[3] = local_10c;
              puVar13[4] = local_108;
              local_10c = (int *)0x0;
              local_108 = 0;
              puVar13[5] = local_104;
              kso_qt::QString::QString((QString *)(puVar13 + 6),local_100);
              kso_qt::QString::QString((QString *)(puVar13 + 7),local_fc);
              kso_qt::QString::QString((QString *)(puVar13 + 8),local_f8);
              kso_qt::QString::~QString(local_f8);
              kso_qt::QString::~QString(local_fc);
              kso_qt::QString::~QString(local_100);
              if (local_10c != (int *)0x0) {
                LOCK();
                iVar5 = *local_10c;
                *local_10c = *local_10c + -1;
                UNLOCK();
                if ((iVar5 == 1) && (local_10c != (int *)0x0)) {
                  free(local_10c);
                }
              }
            }
            kso_qt::QObject::connectImpl
                      ((QObject *)local_a0,(void **)local_3c,(QObject *)&local_c0,local_78,
                       (QSlotObjectBase *)0x0,(ConnectionType)puVar13,(int *)0x0,(QMetaObject *)0x0)
            ;
            local_8 = CONCAT31(local_8._1_3_,0x5b);
            kso_qt::QString::~QString(local_128);
            kso_qt::QString::~QString(local_12c);
            kso_qt::QString::~QString(local_130);
            if (local_13c != (QString *)0x0) {
              LOCK();
              iVar5 = *(int *)local_13c;
              *(int *)local_13c = *(int *)local_13c + -1;
              UNLOCK();
              if ((iVar5 == 1) && (local_13c != (QString *)0x0)) {
                free(local_13c);
              }
            }
            kso_qt::QMetaObject::Connection::~Connection((Connection *)local_a0);
            this_01 = (QUuid *)kso_qt::QUuid::createUuid();
            uVar8 = 3;
            kso_qt::QUuid::toString(this_01,(StringFormat)&local_34);
            local_8._0_1_ = 0x72;
            if (local_38._0_1_ == (QString)0x0) {
              uVar14 = 5;
              pcVar18 = "apply";
            }
            else {
              uVar14 = 7;
              pcVar18 = "preview";
            }
            kso_qt::QString::QString(local_4c,uVar14,pcVar18,uVar8);
            local_8._0_1_ = 0x73;
            uVar8 = FUN_100ba680(local_84);
            local_8._0_1_ = 0x74;
            uVar14 = FUN_100b9dd0(local_124,local_60);
            local_8._0_1_ = 0x75;
            uVar15 = FUN_100f4090(local_120);
            local_8._0_1_ = 0x76;
            kso_qt::QString::QString((QString *)&local_30,6,"wps_ai");
            iVar5 = local_38;
            local_8._0_1_ = 0x77;
            uVar8 = FUN_10073920(&local_78,&local_30,uVar15,local_4c,&local_34,local_38,uVar14,uVar8
                                );
            FUN_1000cf10(uVar8);
            FUN_1000cc00();
            kso_qt::QString::~QString((QString *)&local_30);
            kso_qt::QString::~QString(local_120);
            kso_qt::QString::~QString(local_124);
            local_8._0_1_ = 0x73;
            kso_qt::QString::~QString(local_84);
            FUN_1006a860();
            pQVar16 = (QObject *)FUN_1009d980();
            kso_qt::QVariant::QVariant(local_160,(QString *)&local_34);
            local_8._0_1_ = 0x78;
            kso_qt::QObject::setProperty(pQVar16,"trickId",local_160);
            local_8._0_1_ = 0x73;
            kso_qt::QVariant::~QVariant(local_160);
            pQVar16 = (QObject *)FUN_1009d980();
            kso_qt::QVariant::QVariant(local_94,SUB41(iVar5,0));
            local_8._0_1_ = 0x79;
            kso_qt::QObject::setProperty(pQVar16,"isPostAuthClient",local_94);
            kso_qt::QVariant::~QVariant(local_94);
            kso_qt::QString::~QString(local_4c);
            kso_qt::QString::~QString((QString *)&local_34);
            uVar3 = 1;
          }
          else {
            if (*(int *)(pEVar12 + 4) != 0) {
              pQVar19 = (QObject *)0x0;
              if (*(int *)(pEVar12 + 4) != 0) {
                pQVar19 = pQVar16;
              }
              FUN_10021a50(pQVar19);
              FUN_100ce170(local_60,local_7c,local_bc,local_c4,&local_64);
            }
            uVar3 = 1;
          }
        }
        pQVar17 = local_58 + 8;
        local_8._0_1_ = 0x7a;
        if (*(int *)pQVar17 == 0) {
LAB_1001d2b3:
          kso_qt::QHashData::free_helper(local_58,FUN_10021dd0);
        }
        else if (*(int *)pQVar17 != -1) {
          LOCK();
          iVar5 = *(int *)pQVar17;
          *(int *)pQVar17 = *(int *)pQVar17 + -1;
          UNLOCK();
          if (iVar5 == 1) goto LAB_1001d2b3;
        }
        kso_qt::QString::~QString(local_b4);
        pQVar4 = local_40;
      }
      if (local_a8 != (QString *)0x0) {
        LOCK();
        iVar5 = *(int *)local_a8;
        *(int *)local_a8 = *(int *)local_a8 + -1;
        UNLOCK();
        if (iVar5 == 1) {
          free(local_a8);
        }
      }
    }
    else {
      uVar3 = 0;
    }
    kso_qt::QFile::~QFile(local_e4);
    kso_qt::QString::~QString(local_7c);
    kso_qt::QString::~QString(local_dc);
  }
  kso_qt::QByteArray::~QByteArray((QByteArray *)&local_5c);
  kso_qt::QString::~QString(local_c4);
  pQVar7 = local_40;
  local_8._0_1_ = 0x7b;
  if (*(int *)pQVar4 == 0) {
LAB_1001d776:
    if (*(int *)(local_40 + 0xc) != 0) {
      FUN_10021e50();
      kso_qt::QMapDataBase::freeTree((QMapDataBase *)pQVar7,*(QMapNodeBase **)(pQVar7 + 0xc),4);
    }
    kso_qt::QMapDataBase::freeData((QMapDataBase *)pQVar7);
  }
  else if (*(int *)pQVar4 != -1) {
    LOCK();
    iVar5 = *(int *)local_40;
    *(int *)local_40 = *(int *)local_40 + -1;
    UNLOCK();
    if (iVar5 == 1) goto LAB_1001d776;
  }
  kso_qt::QString::~QString((QString *)&local_98);
  kso_qt::QString::~QString(local_b8);
  kso_qt::QString::~QString(local_bc);
  kso_qt::QString::~QString(local_60);
  kso_qt::QString::~QString((QString *)&local_80);
  kso_qt::QString::~QString((QString *)&local_9c);
  local_8 = CONCAT31(local_8._1_3_,0x7c);
  if (*(int *)local_64 != 0) {
    if (*(int *)local_64 == -1) goto LAB_1001d824;
    LOCK();
    iVar5 = *(int *)local_64;
    *(int *)local_64 = *(int *)local_64 + -1;
    UNLOCK();
    if (iVar5 != 1) goto LAB_1001d824;
  }
  if (*(int *)(local_64 + 0xc) != 0) {
    FUN_1000e220();
    kso_qt::QMapDataBase::freeTree(local_64,*(QMapNodeBase **)(local_64 + 0xc),8);
  }
  kso_qt::QMapDataBase::freeData(local_64);
LAB_1001d824:
  local_8 = 0x7d;
  if (*(int *)local_50 != 0) {
    if (*(int *)local_50 == -1) {
      ExceptionList = local_10;
      return uVar3;
    }
    LOCK();
    iVar5 = *(int *)local_50;
    *(int *)local_50 = *(int *)local_50 + -1;
    UNLOCK();
    if (iVar5 != 1) {
      ExceptionList = local_10;
      return uVar3;
    }
  }
  if (*(int *)(local_50 + 0xc) != 0) {
    FUN_1000e220();
    kso_qt::QMapDataBase::freeTree(local_50,*(QMapNodeBase **)(local_50 + 0xc),8);
  }
  kso_qt::QMapDataBase::freeData(local_50);
  ExceptionList = local_10;
  return uVar3;
}

