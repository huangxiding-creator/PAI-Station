
void FUN_100d7220(code *param_1)

{
  uint uVar1;
  bool bVar2;
  char cVar3;
  undefined1 uVar4;
  QVariant *pQVar5;
  int iVar6;
  QObject *this;
  QJsonParseError *pQVar7;
  QJsonValue *pQVar8;
  QString *pQVar9;
  QJsonObject *pQVar10;
  KxMainWindow *pKVar11;
  QJsonObject *pQVar12;
  QJsonDocument *pQVar13;
  QVariant *pQVar14;
  QCoreApplication *this_00;
  int in_ECX;
  char *pcVar15;
  undefined4 *puVar16;
  KxMainWindow **ppKVar17;
  undefined4 uVar18;
  void ***pppvVar19;
  int *piVar20;
  QVariant **ppQVar21;
  QJsonValue local_d4 [16];
  QJsonValue local_c4 [16];
  QJsonValue local_b4 [16];
  QJsonValue local_a4 [16];
  QString local_94 [4];
  QVariant local_90 [8];
  undefined4 local_88;
  int local_84;
  QVariant local_80 [8];
  QString local_78 [8];
  QVariant local_70 [16];
  code *local_60;
  int local_5c;
  undefined *local_58;
  QString local_54 [4];
  QTypedArrayData<unsigned_short> *local_50;
  uint local_4c;
  int local_48;
  void **local_44;
  int local_40;
  QObject *local_3c;
  QJsonObject local_38 [4];
  KxMainWindow *local_34;
  void **local_30;
  QTypedArrayData<unsigned_short> *local_2c;
  int local_28;
  int local_24;
  uint local_20;
  int local_1c;
  QString local_18 [4];
  QVariant *local_14;
  void *local_10;
  undefined1 *puStack_c;
  undefined4 local_8;
  
  local_8 = 0xffffffff;
  puStack_c = &LAB_102cc136;
  local_10 = ExceptionList;
  ExceptionList = &local_10;
  local_4c = 0;
  pQVar5 = (QVariant *)kso_qt::QVariant::QVariant(local_70);
  local_8 = 0;
  kso_qt::QString::QString((QString *)&local_2c);
  local_8._0_1_ = 1;
  iVar6 = FUN_1000e470();
  if (iVar6 != 0) {
    pQVar5 = (QVariant *)(iVar6 + 0x10);
  }
  kso_qt::QVariant::QVariant(local_80,pQVar5);
  local_8._0_1_ = 2;
  kso_qt::QVariant::toString(local_80);
  kso_qt::QVariant::~QVariant(local_80);
  kso_qt::QString::~QString((QString *)&local_2c);
  kso_qt::QVariant::~QVariant(local_70);
  local_14 = (QVariant *)kso_qt::QVariant::QVariant(local_70);
  local_8._0_1_ = 7;
  kso_qt::QString::QString((QString *)&local_2c);
  local_8._0_1_ = 8;
  iVar6 = FUN_1000e470();
  pQVar5 = local_14;
  if (iVar6 != 0) {
    pQVar5 = (QVariant *)(iVar6 + 0x10);
  }
  kso_qt::QVariant::QVariant(local_80,pQVar5);
  local_8._0_1_ = 9;
  kso_qt::QVariant::toString(local_80);
  kso_qt::QVariant::~QVariant(local_80);
  kso_qt::QString::~QString((QString *)&local_2c);
  kso_qt::QVariant::~QVariant(local_70);
  local_14 = (QVariant *)kso_qt::QVariant::QVariant(local_70);
  local_8._0_1_ = 0xe;
  kso_qt::QString::QString((QString *)&local_2c);
  local_8._0_1_ = 0xf;
  iVar6 = FUN_1000e470();
  pQVar5 = local_14;
  if (iVar6 != 0) {
    pQVar5 = (QVariant *)(iVar6 + 0x10);
  }
  kso_qt::QVariant::QVariant(local_80,pQVar5);
  local_8._0_1_ = 0x10;
  kso_qt::QVariant::toString(local_80);
  kso_qt::QVariant::~QVariant(local_80);
  kso_qt::QString::~QString((QString *)&local_2c);
  local_8._0_1_ = 0x14;
  kso_qt::QVariant::~QVariant(local_70);
  local_4c = FUN_100dbf50();
  if (local_4c == 0) {
    kso_qt::QString::QString((QString *)&param_1);
    local_8._0_1_ = 0x15;
    FUN_100db9f0();
    pQVar9 = (QString *)&param_1;
    goto LAB_100d9096;
  }
  this = (QObject *)FUN_1009d980();
  kso_qt::QVariant::QVariant(local_90,true);
  local_8._0_1_ = 0x16;
  kso_qt::QObject::setProperty(this,"isCurrentPostAuth",local_90);
  local_8._0_1_ = 0x14;
  kso_qt::QVariant::~QVariant(local_90);
  FUN_1009d980();
  uVar1 = local_4c;
  local_5c = FUN_1009d740();
  if (local_5c != 0) {
    kso_qt::QString::trimmed(local_54);
    local_8._0_1_ = 0x17;
    if (*(int *)(param_1 + 4) != 0) {
      local_44 = (void **)0x0;
      local_40 = 0;
      pQVar7 = (QJsonParseError *)kso_qt::QString::toUtf8((QString *)&param_1);
      local_8._0_1_ = 0x18;
      kso_qt::QJsonDocument::fromJson((QByteArray *)&local_20,pQVar7);
      local_8._0_1_ = 0x1a;
      kso_qt::QByteArray::~QByteArray((QByteArray *)&local_14);
      if ((local_40 == 0) &&
         (bVar2 = kso_qt::QJsonDocument::isObject((QJsonDocument *)&local_20), bVar2)) {
        kso_qt::QJsonDocument::object((QJsonDocument *)&local_20);
        local_8._0_1_ = 0x1b;
        pQVar8 = (QJsonValue *)kso_qt::QJsonObject::value(local_38,local_a4);
        local_8._0_1_ = 0x1c;
        kso_qt::QJsonValue::toString(pQVar8);
        local_8._0_1_ = 0x1e;
        kso_qt::QJsonValue::~QJsonValue(local_a4);
        if (*(int *)(local_1c + 4) == 0) {
          pQVar8 = (QJsonValue *)kso_qt::QJsonObject::value(local_38);
          local_8._0_1_ = 0x1f;
          pQVar9 = (QString *)kso_qt::QJsonValue::toString(pQVar8);
          kso_qt::QString::operator=((QString *)&local_1c,pQVar9);
          kso_qt::QString::~QString((QString *)&local_14);
          local_8._0_1_ = 0x1e;
          kso_qt::QJsonValue::~QJsonValue((QJsonValue *)local_90);
        }
        FUN_100aba60();
        kso_qt::QString::~QString((QString *)&local_1c);
        kso_qt::QJsonObject::~QJsonObject(local_38);
      }
      kso_qt::QJsonDocument::~QJsonDocument((QJsonDocument *)&local_20);
    }
    local_8._0_1_ = 0x14;
    kso_qt::QString::~QString((QString *)&param_1);
  }
  pQVar9 = (QString *)kso_qt::QString::trimmed(local_94);
  local_8._0_1_ = 0x20;
  kso_qt::QString::toLower(pQVar9);
  local_8._0_1_ = 0x22;
  kso_qt::QString::~QString((QString *)&local_5c);
  bVar2 = kso_qt::QString::operator==((QString *)&local_48,0xc);
  if (bVar2) {
    FUN_100d5510();
    local_8._0_1_ = 0x23;
LAB_100d75d7:
    FUN_100db9f0();
    pQVar9 = (QString *)&param_1;
LAB_100d908d:
    kso_qt::QString::~QString(pQVar9);
  }
  else {
    bVar2 = kso_qt::QString::operator==((QString *)&local_48);
    if (bVar2) {
      FUN_100d5510();
      local_8._0_1_ = 0x24;
      goto LAB_100d75d7;
    }
    bVar2 = kso_qt::QString::operator==((QString *)&local_48);
    if (bVar2) {
      FUN_100d4410();
      local_8._0_1_ = 0x25;
      goto LAB_100d75d7;
    }
    bVar2 = kso_qt::QString::operator==((QString *)&local_48);
    if (bVar2) {
      FUN_100d5200();
      local_8._0_1_ = 0x26;
      goto LAB_100d75d7;
    }
    bVar2 = kso_qt::QString::operator==((QString *)&local_48);
    if (bVar2) {
      FUN_100d4b80();
      local_8._0_1_ = 0x27;
      if (*(int *)(local_24 + 4) == 0) {
        kso_qt::QString::QString((QString *)&param_1);
        local_8._0_1_ = 0x28;
        kso_qt::QString::trimmed(local_54);
        local_8._0_1_ = 0x29;
        uVar4 = (undefined1)local_8;
        local_8._0_1_ = 0x29;
        if (*(int *)(local_4c + 4) != 0) {
          pQVar7 = (QJsonParseError *)kso_qt::QString::toUtf8((QString *)&local_4c);
          local_8._0_1_ = 0x2a;
          kso_qt::QJsonDocument::fromJson((QByteArray *)&local_1c,pQVar7);
          local_8._0_1_ = 0x2c;
          kso_qt::QByteArray::~QByteArray((QByteArray *)&local_14);
          bVar2 = kso_qt::QJsonDocument::isObject((QJsonDocument *)&local_1c);
          if (bVar2) {
            pQVar10 = (QJsonObject *)kso_qt::QJsonDocument::object((QJsonDocument *)&local_1c);
            local_8._0_1_ = 0x2d;
            pQVar8 = (QJsonValue *)kso_qt::QJsonObject::value(pQVar10,local_70,8,"doc_type");
            local_8._0_1_ = 0x2e;
            pQVar9 = (QString *)kso_qt::QJsonValue::toString(pQVar8);
            kso_qt::QString::operator=((QString *)&param_1,pQVar9);
            kso_qt::QString::~QString((QString *)&local_5c);
            kso_qt::QJsonValue::~QJsonValue((QJsonValue *)local_70);
            kso_qt::QJsonObject::~QJsonObject((QJsonObject *)&local_88);
          }
          local_8._0_1_ = 0x29;
          kso_qt::QJsonDocument::~QJsonDocument((QJsonDocument *)&local_1c);
          uVar4 = (undefined1)local_8;
        }
        local_8._0_1_ = uVar4;
        if (*(int *)(param_1 + 4) == 0) {
          pQVar9 = (QString *)FUN_100d5510();
          kso_qt::QString::operator=((QString *)&param_1,pQVar9);
          kso_qt::QString::~QString((QString *)&local_14);
        }
        FUN_1009d980();
        iVar6 = FUN_1009d740();
        if (iVar6 == 0) {
          kso_qt::QString::QString((QString *)&local_20);
        }
        else {
          FUN_100b7040();
        }
        local_8._0_1_ = 0x2f;
        if (*(int *)(local_20 + 4) == 0) {
          kso_qt::QString::QString((QString *)&local_2c);
          local_8._0_1_ = 0x30;
          FUN_100db9f0();
          kso_qt::QString::~QString((QString *)&local_2c);
        }
        else {
          FUN_100db9f0();
        }
        kso_qt::QString::~QString((QString *)&local_20);
        kso_qt::QString::~QString((QString *)&local_4c);
        kso_qt::QString::~QString((QString *)&param_1);
        pQVar9 = (QString *)&local_24;
      }
      else {
        FUN_100db9f0();
        pQVar9 = (QString *)&local_24;
      }
      goto LAB_100d908d;
    }
    bVar2 = kso_qt::QString::operator==((QString *)&local_48);
    if (bVar2) {
      kso_qt::QString::QString((QString *)&param_1);
      local_8._0_1_ = 0x31;
      kso_qt::QString::trimmed(local_54);
      local_8._0_1_ = 0x32;
      uVar4 = (undefined1)local_8;
      local_8._0_1_ = 0x32;
      if (*(int *)(local_28 + 4) != 0) {
        pQVar7 = (QJsonParseError *)kso_qt::QString::toUtf8((QString *)&local_28);
        local_8._0_1_ = 0x33;
        kso_qt::QJsonDocument::fromJson((QByteArray *)&local_24,pQVar7);
        local_8._0_1_ = 0x35;
        kso_qt::QByteArray::~QByteArray((QByteArray *)&local_14);
        bVar2 = kso_qt::QJsonDocument::isObject((QJsonDocument *)&local_24);
        if (bVar2) {
          pQVar10 = (QJsonObject *)kso_qt::QJsonDocument::object((QJsonDocument *)&local_24);
          local_8._0_1_ = 0x36;
          pQVar8 = (QJsonValue *)kso_qt::QJsonObject::value(pQVar10,local_70);
          local_8._0_1_ = 0x37;
          pQVar9 = (QString *)kso_qt::QJsonValue::toString(pQVar8);
          kso_qt::QString::operator=((QString *)&param_1,pQVar9);
          kso_qt::QString::~QString((QString *)&local_5c);
          kso_qt::QJsonValue::~QJsonValue((QJsonValue *)local_70);
          kso_qt::QJsonObject::~QJsonObject((QJsonObject *)&local_88);
        }
        local_8._0_1_ = 0x32;
        kso_qt::QJsonDocument::~QJsonDocument((QJsonDocument *)&local_24);
        uVar4 = (undefined1)local_8;
      }
      local_8._0_1_ = uVar4;
      if (*(int *)(param_1 + 4) == 0) {
        pQVar9 = (QString *)FUN_100d5510();
        kso_qt::QString::operator=((QString *)&param_1,pQVar9);
        kso_qt::QString::~QString((QString *)&local_14);
        if (*(int *)(param_1 + 4) != 0) goto LAB_100d798f;
LAB_100d79a3:
        kso_qt::QString::operator=((QString *)&param_1,"SmartLayoutThesis");
      }
      else {
LAB_100d798f:
        bVar2 = kso_qt::QString::operator==((QString *)&param_1);
        if (bVar2) goto LAB_100d79a3;
      }
      FUN_100d49a0();
      local_8._0_1_ = 0x38;
      uVar4 = (undefined1)local_8;
      local_8._0_1_ = 0x38;
      if (*(int *)(local_1c + 4) == 0) {
        kso_qt::QString::QString((QString *)&local_5c);
        local_8._0_1_ = 0x39;
        local_4c = 0x71;
      }
      else {
        local_8._0_1_ = uVar4;
        kso_qt::QString::QString((QString *)&local_14,(QString *)&local_1c);
        local_8._0_1_ = 0x3a;
        local_8._1_3_ = 0;
        local_4c = 0x72;
      }
      local_20 = local_4c;
      FUN_100db9f0();
      if ((local_20 & 2) != 0) {
        local_20 = local_20 & 0xfffffffd;
        kso_qt::QString::~QString((QString *)&local_14);
      }
      if ((local_20 & 1) != 0) {
        kso_qt::QString::~QString((QString *)&local_5c);
      }
      kso_qt::QString::~QString((QString *)&local_1c);
      kso_qt::QString::~QString((QString *)&local_28);
      pQVar9 = (QString *)&param_1;
      goto LAB_100d908d;
    }
    bVar2 = kso_qt::QString::operator==((QString *)&local_48);
    if (bVar2) {
      FUN_100d4690();
      local_8._0_1_ = 0x3b;
      FUN_100db9f0();
      pQVar9 = (QString *)&local_40;
      goto LAB_100d908d;
    }
    bVar2 = kso_qt::QString::operator==((QString *)&local_48);
    if (bVar2) {
      FUN_100d56f0();
      local_8._0_1_ = 0x3c;
      goto LAB_100d75d7;
    }
    bVar2 = kso_qt::QString::operator==((QString *)&local_48);
    if (!bVar2) {
      bVar2 = kso_qt::QString::operator==((QString *)&local_48);
      if (bVar2) {
        FUN_1009d980();
        iVar6 = FUN_1009d740();
        if ((iVar6 == 0) || (iVar6 = FUN_1006a7c0(), iVar6 != 2)) {
          kso_qt::QString::QString((QString *)&param_1,0x15);
          local_8._0_1_ = 0x4a;
          FUN_100db9f0();
          pQVar9 = (QString *)&param_1;
        }
        else {
          kso_qt::QString::trimmed(local_54);
          local_8._0_1_ = 0x40;
          uVar4 = (undefined1)local_8;
          local_8._0_1_ = 0x40;
          if (*(int *)(local_24 + 4) == 0) {
            kso_qt::QString::QString((QString *)&param_1,0x14,"paramString is empty");
            local_8._0_1_ = 0x41;
            FUN_100db9f0();
            kso_qt::QString::~QString((QString *)&param_1);
            pQVar9 = (QString *)&local_24;
          }
          else {
            ppQVar21 = &local_14;
            local_44 = (void **)0x0;
            local_40 = 0;
            local_8._0_1_ = uVar4;
            pQVar7 = (QJsonParseError *)kso_qt::QString::toUtf8((QString *)&local_24);
            local_8._0_1_ = 0x42;
            kso_qt::QJsonDocument::fromJson((QByteArray *)&local_28,pQVar7);
            local_8._0_1_ = 0x44;
            kso_qt::QByteArray::~QByteArray((QByteArray *)&local_14);
            if ((local_40 == 0) &&
               (bVar2 = kso_qt::QJsonDocument::isObject((QJsonDocument *)&local_28), bVar2)) {
              pQVar10 = local_38;
              param_1 = (code *)((uint)param_1 & 0xffffff);
              kso_qt::QJsonDocument::object((QJsonDocument *)&local_28);
              local_8._0_1_ = 0x46;
              bVar2 = kso_qt::QJsonObject::contains(local_38,5,"apply",pQVar10);
              if (bVar2) {
                pQVar8 = (QJsonValue *)kso_qt::QJsonObject::value(local_38,local_70,5,"apply");
                local_8._0_1_ = 0x47;
                bVar2 = kso_qt::QJsonValue::toBool(pQVar8,false);
                param_1 = (code *)CONCAT13(bVar2,param_1._0_3_);
                local_8._0_1_ = 0x46;
                kso_qt::QJsonValue::~QJsonValue((QJsonValue *)local_70);
              }
              if (param_1._3_1_ == '\0') {
                FUN_100bf140();
                kso_qt::QString::QString((QString *)&param_1,0xb,"abandon ok.");
                local_8._0_1_ = 0x49;
              }
              else {
                FUN_100bf810();
                kso_qt::QString::QString((QString *)&param_1,9,"apply ok.");
                local_8._0_1_ = 0x48;
              }
              FUN_100db9f0();
              kso_qt::QString::~QString((QString *)&param_1);
              kso_qt::QJsonObject::~QJsonObject(local_38);
              kso_qt::QJsonDocument::~QJsonDocument((QJsonDocument *)&local_28);
              pQVar9 = (QString *)&local_24;
            }
            else {
              kso_qt::QString::QString
                        ((QString *)&param_1,0x1b,"Failed to parse paramString",ppQVar21);
              local_8._0_1_ = 0x45;
              FUN_100db9f0();
              kso_qt::QString::~QString((QString *)&param_1);
              kso_qt::QJsonDocument::~QJsonDocument((QJsonDocument *)&local_28);
              pQVar9 = (QString *)&local_24;
            }
          }
        }
        goto LAB_100d908d;
      }
      bVar2 = kso_qt::QString::operator==((QString *)&local_48,0xc);
      if (bVar2) {
        kso_qt::QString::QString((QString *)&param_1);
        local_8._0_1_ = 0x4b;
        kso_qt::QString::trimmed(local_54);
        local_8._0_1_ = 0x4c;
        uVar4 = (undefined1)local_8;
        local_8._0_1_ = 0x4c;
        if (*(int *)(local_3c + 4) != 0) {
          pQVar7 = (QJsonParseError *)kso_qt::QString::toUtf8((QString *)&local_3c);
          local_8._0_1_ = 0x4d;
          kso_qt::QJsonDocument::fromJson((QByteArray *)&local_28,pQVar7);
          local_8._0_1_ = 0x4f;
          kso_qt::QByteArray::~QByteArray((QByteArray *)&local_14);
          bVar2 = kso_qt::QJsonDocument::isObject((QJsonDocument *)&local_28);
          if (bVar2) {
            pQVar10 = local_38;
            pQVar12 = (QJsonObject *)kso_qt::QJsonDocument::object((QJsonDocument *)&local_28);
            local_8._0_1_ = 0x50;
            pQVar8 = (QJsonValue *)kso_qt::QJsonObject::value(pQVar12,local_70,8,"doc_type",pQVar10)
            ;
            local_8._0_1_ = 0x51;
            pQVar9 = (QString *)kso_qt::QJsonValue::toString(pQVar8);
            kso_qt::QString::operator=((QString *)&param_1,pQVar9);
            kso_qt::QString::~QString((QString *)&local_5c);
            kso_qt::QJsonValue::~QJsonValue((QJsonValue *)local_70);
            kso_qt::QJsonObject::~QJsonObject(local_38);
          }
          local_8._0_1_ = 0x4c;
          kso_qt::QJsonDocument::~QJsonDocument((QJsonDocument *)&local_28);
          uVar4 = (undefined1)local_8;
        }
        local_8._0_1_ = uVar4;
        if (*(int *)(param_1 + 4) == 0) {
          pQVar9 = (QString *)FUN_100d5510(&local_14,uVar1,0);
          kso_qt::QString::operator=((QString *)&param_1,pQVar9);
          kso_qt::QString::~QString((QString *)&local_14);
          if (*(int *)(param_1 + 4) != 0) goto LAB_100d7f68;
LAB_100d7f7c:
          kso_qt::QString::operator=((QString *)&param_1,"SmartLayoutThesis");
        }
        else {
LAB_100d7f68:
          bVar2 = kso_qt::QString::operator==((QString *)&param_1,0xe,"SmartLayoutGen");
          if (bVar2) goto LAB_100d7f7c;
        }
        local_14 = (QVariant *)(in_ECX + -8);
        FUN_100d49a0(&local_20,uVar1,&param_1);
        local_8._0_1_ = 0x52;
        uVar4 = (undefined1)local_8;
        local_8._0_1_ = 0x52;
        if (*(int *)(local_20 + 4) == 0) {
          kso_qt::QString::QString((QString *)&local_2c,0x18,"doc_element_recog_failed");
          local_8._0_1_ = 0x53;
          FUN_100db9f0();
          kso_qt::QString::~QString((QString *)&local_2c);
        }
        else {
          ppQVar21 = &local_14;
          local_88 = 0;
          local_84 = 0;
          local_8._0_1_ = uVar4;
          pQVar7 = (QJsonParseError *)kso_qt::QString::toUtf8((QString *)&local_20);
          local_8._0_1_ = 0x54;
          kso_qt::QJsonDocument::fromJson((QByteArray *)&local_24,pQVar7);
          local_8._0_1_ = 0x56;
          kso_qt::QByteArray::~QByteArray((QByteArray *)&local_14);
          if ((local_84 == 0) &&
             (bVar2 = kso_qt::QJsonDocument::isObject((QJsonDocument *)&local_24), bVar2)) {
            kso_qt::QJsonObject::QJsonObject((QJsonObject *)&local_44);
            pQVar10 = local_38;
            local_8._0_1_ = 0x58;
            pQVar12 = (QJsonObject *)kso_qt::QJsonDocument::object((QJsonDocument *)&local_24);
            local_8._0_1_ = 0x59;
            kso_qt::QJsonValue::QJsonValue(local_a4,pQVar12);
            local_8._0_1_ = 0x5a;
            kso_qt::QString::QString((QString *)&local_2c,0xc,"recog_result",pQVar10);
            local_8._0_1_ = 0x5b;
            kso_qt::QJsonObject::insert((QJsonObject *)&local_44,local_78,(QJsonValue *)&local_2c);
            kso_qt::QString::~QString((QString *)&local_2c);
            kso_qt::QJsonValue::~QJsonValue(local_a4);
            local_8._0_1_ = 0x58;
            kso_qt::QJsonObject::~QJsonObject(local_38);
            kso_qt::QJsonValue::QJsonValue((QJsonValue *)local_70,true);
            local_8._0_1_ = 0x5c;
            kso_qt::QString::QString((QString *)&local_2c,7,"skip_ui");
            local_8._0_1_ = 0x5d;
            kso_qt::QJsonObject::insert((QJsonObject *)&local_44,local_78,(QJsonValue *)&local_2c);
            kso_qt::QString::~QString((QString *)&local_2c);
            local_8._0_1_ = 0x58;
            kso_qt::QJsonValue::~QJsonValue((QJsonValue *)local_70);
            pQVar13 = (QJsonDocument *)
                      kso_qt::QJsonDocument::QJsonDocument
                                ((QJsonDocument *)&local_5c,(QJsonObject *)&local_44);
            uVar18 = 1;
            local_8._0_1_ = 0x5e;
            kso_qt::QJsonDocument::toJson(pQVar13,(JsonFormat)&local_14);
            local_8._0_1_ = 0x5f;
            kso_qt::QString::fromUtf8((QByteArray *)&local_58);
            kso_qt::QByteArray::~QByteArray((QByteArray *)&local_14);
            local_8._0_1_ = 0x62;
            kso_qt::QJsonDocument::~QJsonDocument((QJsonDocument *)&local_5c);
            kso_qt::QString::QString((QString *)&local_50,0x14,"open_typeset_session",uVar18);
            local_8._0_1_ = 99;
            FUN_100dded0(&local_1c,local_4c,&local_50,&local_58);
            local_8._0_1_ = 0x65;
            kso_qt::QString::~QString((QString *)&local_50);
            bVar2 = kso_qt::QString::startsWith
                              ((QString *)&local_1c,0x18,"wps_toolcall_fmt success",1);
            local_34 = (KxMainWindow *)CONCAT31(local_34._1_3_,bVar2);
            if (bVar2) {
              local_14 = (QVariant *)CONCAT31(local_14._1_3_,0x3a);
              kso_qt::QChar::QChar((QChar *)&stack0xfffffee8,local_14);
              iVar6 = kso_qt::QString::indexOf((QString *)&local_1c);
              if (-1 < iVar6) {
                pQVar9 = (QString *)
                         kso_qt::QString::mid((QString *)&local_1c,(int)&local_2c,iVar6 + 1);
                local_8._0_1_ = 0x66;
                pQVar9 = (QString *)kso_qt::QString::trimmed(pQVar9);
                local_8._0_1_ = 0x67;
                pQVar7 = (QJsonParseError *)kso_qt::QString::toUtf8(pQVar9);
                local_8._0_1_ = 0x68;
                kso_qt::QJsonDocument::fromJson((QByteArray *)&local_28,pQVar7);
                kso_qt::QByteArray::~QByteArray((QByteArray *)&local_14);
                kso_qt::QString::~QString((QString *)&local_5c);
                local_8._0_1_ = 0x6c;
                kso_qt::QString::~QString((QString *)&local_2c);
                bVar2 = kso_qt::QJsonDocument::isObject((QJsonDocument *)&local_28);
                if (bVar2) {
                  pQVar9 = local_78;
                  pQVar10 = (QJsonObject *)kso_qt::QJsonDocument::object((QJsonDocument *)&local_28)
                  ;
                  local_8._0_1_ = 0x6d;
                  pQVar8 = (QJsonValue *)
                           kso_qt::QJsonObject::value(pQVar10,local_70,9,"sessionId",pQVar9);
                  local_8._0_1_ = 0x6e;
                  pQVar9 = (QString *)kso_qt::QJsonValue::toString(pQVar8);
                  kso_qt::QString::operator=((QString *)(in_ECX + 0x1c),pQVar9);
                  kso_qt::QString::~QString((QString *)&local_4c);
                  kso_qt::QJsonValue::~QJsonValue((QJsonValue *)local_70);
                  kso_qt::QJsonObject::~QJsonObject((QJsonObject *)local_78);
                }
                local_8._0_1_ = 0x65;
                kso_qt::QJsonDocument::~QJsonDocument((QJsonDocument *)&local_28);
              }
            }
            FUN_100db9f0();
            kso_qt::QString::~QString((QString *)&local_1c);
            kso_qt::QString::~QString((QString *)&local_58);
            kso_qt::QJsonObject::~QJsonObject((QJsonObject *)&local_44);
          }
          else {
            kso_qt::QString::QString
                      ((QString *)&local_2c,0x1c,"failed_to_parse_recog_result",ppQVar21);
            local_8._0_1_ = 0x57;
            FUN_100db9f0();
            kso_qt::QString::~QString((QString *)&local_2c);
          }
          kso_qt::QJsonDocument::~QJsonDocument((QJsonDocument *)&local_24);
        }
        kso_qt::QString::~QString((QString *)&local_20);
        kso_qt::QString::~QString((QString *)&local_3c);
        pQVar9 = (QString *)&param_1;
      }
      else {
        cVar3 = FUN_100df010(&local_48);
        if (cVar3 != '\0') {
          kso_qt::QString::QString((QString *)&param_1,local_54);
          local_8._0_1_ = 0x6f;
          uVar4 = (undefined1)local_8;
          local_8._0_1_ = 0x6f;
          if (*(int *)(*(int *)(in_ECX + 0x1c) + 4) != 0) {
            kso_qt::QJsonObject::QJsonObject((QJsonObject *)&local_44);
            local_8._0_1_ = 0x70;
            kso_qt::QString::trimmed(local_54);
            local_8._0_1_ = 0x71;
            uVar4 = (undefined1)local_8;
            local_8._0_1_ = 0x71;
            if (*(int *)(local_28 + 4) != 0) {
              pQVar7 = (QJsonParseError *)kso_qt::QString::toUtf8((QString *)&local_28);
              local_8._0_1_ = 0x72;
              kso_qt::QJsonDocument::fromJson((QByteArray *)&local_3c,pQVar7);
              local_8 = CONCAT31(local_8._1_3_,0x74);
              kso_qt::QByteArray::~QByteArray((QByteArray *)&local_34);
              bVar2 = kso_qt::QJsonDocument::isObject((QJsonDocument *)&local_3c);
              if (bVar2) {
                pQVar10 = (QJsonObject *)kso_qt::QJsonDocument::object((QJsonDocument *)&local_3c);
                kso_qt::QJsonObject::operator=((QJsonObject *)&local_44,pQVar10);
                kso_qt::QJsonObject::~QJsonObject((QJsonObject *)local_78);
              }
              local_8._0_1_ = 0x71;
              kso_qt::QJsonDocument::~QJsonDocument((QJsonDocument *)&local_3c);
              uVar4 = (undefined1)local_8;
            }
            local_8._0_1_ = uVar4;
            bVar2 = kso_qt::QJsonObject::contains((QJsonObject *)&local_44,9,"sessionid");
            if ((!bVar2) &&
               (bVar2 = kso_qt::QJsonObject::contains((QJsonObject *)&local_44,9,"sessionId"),
               !bVar2)) {
              kso_qt::QJsonValue::QJsonValue((QJsonValue *)local_70,(QString *)(in_ECX + 0x1c));
              local_8._0_1_ = 0x75;
              kso_qt::QString::QString((QString *)&local_2c,9,"sessionid");
              local_8._0_1_ = 0x76;
              kso_qt::QJsonObject::insert((QJsonObject *)&local_44,local_78,(QJsonValue *)&local_2c)
              ;
              kso_qt::QString::~QString((QString *)&local_2c);
              local_8._0_1_ = 0x71;
              kso_qt::QJsonValue::~QJsonValue((QJsonValue *)local_70);
              pQVar13 = (QJsonDocument *)
                        kso_qt::QJsonDocument::QJsonDocument
                                  ((QJsonDocument *)&local_5c,(QJsonObject *)&local_44);
              local_8._0_1_ = 0x77;
              kso_qt::QJsonDocument::toJson(pQVar13,(JsonFormat)&local_14);
              local_8._0_1_ = 0x78;
              pQVar9 = (QString *)kso_qt::QString::fromUtf8((QByteArray *)&local_34);
              kso_qt::QString::operator=((QString *)&param_1,pQVar9);
              kso_qt::QString::~QString((QString *)&local_34);
              kso_qt::QByteArray::~QByteArray((QByteArray *)&local_14);
              kso_qt::QJsonDocument::~QJsonDocument((QJsonDocument *)&local_5c);
            }
            kso_qt::QString::~QString((QString *)&local_28);
            local_8._0_1_ = 0x6f;
            kso_qt::QJsonObject::~QJsonObject((QJsonObject *)&local_44);
            uVar4 = (undefined1)local_8;
          }
          local_8._0_1_ = uVar4;
          FUN_100dded0(&local_24,uVar1,local_94,&param_1);
          local_8._0_1_ = 0x79;
          bVar2 = kso_qt::QString::startsWith
                            ((QString *)&local_24,0x18,"wps_toolcall_fmt success",1);
          local_34 = (KxMainWindow *)CONCAT31(local_34._1_3_,bVar2);
          bVar2 = kso_qt::QString::operator==((QString *)&local_48,0xb,"oplist_exec");
          if (bVar2) {
            FUN_1009d980();
            FUN_1009d740();
            FUN_100d6150();
          }
          FUN_100db9f0();
          kso_qt::QString::~QString((QString *)&local_24);
          pQVar9 = (QString *)&param_1;
          goto LAB_100d908d;
        }
        bVar2 = kso_qt::QString::operator==((QString *)&local_48,0x15,"is_exam_service_ready");
        if (bVar2) {
          FUN_1009d980();
          iVar6 = FUN_1009d740(uVar1);
          if (iVar6 == 0) {
            param_1 = (code *)0x0;
          }
          else {
            param_1 = (code *)FUN_100bac50();
          }
          FUN_10011310();
          kso_qt::QString::QString((QString *)&local_2c,0x1c,"event.examPaper.startTypeset");
          local_8._0_1_ = 0x7a;
          uVar4 = FUN_100114a0(&local_2c,param_1);
          param_1 = (code *)CONCAT31(param_1._1_3_,uVar4);
          local_8._0_1_ = 0x22;
          kso_qt::QString::~QString((QString *)&local_2c);
          if (param_1._0_1_ == (QString)0x0) {
            uVar18 = 9;
            pcVar15 = "not_ready";
          }
          else {
            uVar18 = 5;
            pcVar15 = "ready";
          }
          kso_qt::QString::QString((QString *)&local_2c,uVar18,pcVar15);
          local_8._0_1_ = 0x7b;
          FUN_100db9f0();
LAB_100d908a:
          pQVar9 = (QString *)&local_2c;
        }
        else {
          bVar2 = kso_qt::QString::operator==((QString *)&local_48,0x16,"ensure_aitypeset_panel");
          if (bVar2) {
            local_2c = kso_qt::QString::fromAscii_helper("kcopilotentrylite",0x11);
            local_8._0_1_ = 0x7c;
            local_3c = KPluginManager::getPluginInstanceObject((QString *)&local_2c);
            local_8._0_1_ = 0x22;
            kso_qt::QString::~QString((QString *)&local_2c);
            if (local_3c != (QObject *)0x0) {
              param_1 = shared_null_exref;
              local_8._0_1_ = 0x7d;
              kso_qt::QVariant::QVariant(local_70,0x13,"kwebwpsdoccomposing");
              local_8._0_1_ = 0x7e;
              local_50 = kso_qt::QString::fromAscii_helper("plugin_name",0xb);
              pQVar5 = local_70;
              local_8._0_1_ = 0x7f;
              pQVar14 = (QVariant *)FUN_10014590(&local_50);
              kso_qt::QVariant::operator=(pQVar14,pQVar5);
              kso_qt::QString::~QString((QString *)&local_50);
              kso_qt::QVariant::~QVariant(local_70);
              local_58 = &DAT_103fe550;
              local_8._0_1_ = 0x80;
              kso_qt::QVariant::QVariant((QVariant *)local_a4,(QString *)&local_58);
              local_8._0_1_ = 0x81;
              local_50 = kso_qt::QString::fromAscii_helper("entry",5);
              pQVar8 = local_a4;
              local_8._0_1_ = 0x82;
              pQVar5 = (QVariant *)FUN_10014590(&local_50);
              kso_qt::QVariant::operator=(pQVar5,(QVariant *)pQVar8);
              kso_qt::QString::~QString((QString *)&local_50);
              kso_qt::QVariant::~QVariant((QVariant *)local_a4);
              local_8._0_1_ = 0x7d;
              kso_qt::QString::~QString((QString *)&local_58);
              kso_qt::QVariant::QVariant(local_80,true);
              local_8._0_1_ = 0x83;
              local_50 = kso_qt::QString::fromAscii_helper("silent",6);
              pQVar5 = local_80;
              local_8._0_1_ = 0x84;
              pQVar14 = (QVariant *)FUN_10014590(&local_50);
              kso_qt::QVariant::operator=(pQVar14,pQVar5);
              kso_qt::QString::~QString((QString *)&local_50);
              kso_qt::QVariant::~QVariant(local_80);
              local_50 = (QTypedArrayData<unsigned_short> *)&DAT_103fe570;
              local_8._0_1_ = 0x85;
              this_00 = kso_qt::QCoreApplication::instance();
              local_34 = KxApplication::currentMainWindow((KxApplication *)this_00);
              kso_qt::QMetaObject::invokeMethod
                        (local_3c,"triggerCopilot",2,0,0,&local_34,"QWidget*",(QString *)&local_50,
                         "QString",&param_1,"const QVariantMap&",0,0,0,0,0,0,0,0,0,0,0,0,0,0);
              local_8._0_1_ = 0x7d;
              kso_qt::QString::~QString((QString *)&local_50);
              kso_qt::QString::QString((QString *)&local_3c,0x17,"panel_loading_triggered");
              local_8._0_1_ = 0x86;
              FUN_100db9f0();
              kso_qt::QString::~QString((QString *)&local_3c);
              FUN_1000cc00();
              goto LAB_100d9093;
            }
            kso_qt::QString::QString((QString *)&param_1,0x1b,"kcopilotentrylite not found");
            local_8._0_1_ = 0x87;
            FUN_100db9f0();
            pQVar9 = (QString *)&param_1;
          }
          else {
            bVar2 = kso_qt::QString::operator==((QString *)&local_48,10,"ai_typeset");
            if ((bVar2) || (*(int *)(local_48 + 4) == 0)) {
              kso_qt::QString::QString((QString *)&local_2c,6,"detect");
              kso_qt::QString::QString((QString *)&local_50);
              kso_qt::QString::QString((QString *)&local_1c);
              kso_qt::QString::QString((QString *)&local_20);
              kso_qt::QString::QString((QString *)&local_24);
              piVar20 = &local_28;
              local_8._0_1_ = 0x8c;
              local_58 = (undefined *)0x0;
              kso_qt::QString::trimmed(local_54);
              local_8._0_1_ = 0x8d;
              uVar4 = (undefined1)local_8;
              local_8._0_1_ = 0x8d;
              if (*(int *)(local_28 + 4) == 0) {
                kso_qt::QString::QString((QString *)&param_1,0x14,"paramString is empty",piVar20);
                local_8._0_1_ = 0x8e;
                FUN_100db9f0();
                kso_qt::QString::~QString((QString *)&param_1);
              }
              else {
                ppKVar17 = &local_34;
                local_88 = 0;
                local_84 = 0;
                local_8._0_1_ = uVar4;
                pQVar7 = (QJsonParseError *)kso_qt::QString::toUtf8((QString *)&local_28);
                local_8._0_1_ = 0x8f;
                kso_qt::QJsonDocument::fromJson((QByteArray *)&local_3c,pQVar7);
                local_8._0_1_ = 0x91;
                kso_qt::QByteArray::~QByteArray((QByteArray *)&local_34);
                if ((local_84 == 0) &&
                   (bVar2 = kso_qt::QJsonDocument::isObject((QJsonDocument *)&local_3c), bVar2)) {
                  pppvVar19 = &local_44;
                  kso_qt::QJsonDocument::object((QJsonDocument *)&local_3c);
                  local_8._0_1_ = 0x93;
                  pQVar8 = (QJsonValue *)
                           kso_qt::QJsonObject::value
                                     ((QJsonObject *)&local_44,local_70,4,&DAT_10311e54,pppvVar19);
                  local_8._0_1_ = 0x94;
                  kso_qt::QString::QString((QString *)&local_5c,6,"detect");
                  local_8._0_1_ = 0x95;
                  pQVar9 = (QString *)kso_qt::QJsonValue::toString(pQVar8,(QString *)&local_34);
                  kso_qt::QString::operator=((QString *)&local_2c,pQVar9);
                  kso_qt::QString::~QString((QString *)&local_34);
                  kso_qt::QString::~QString((QString *)&local_5c);
                  local_8._0_1_ = 0x93;
                  kso_qt::QJsonValue::~QJsonValue((QJsonValue *)local_70);
                  pQVar8 = (QJsonValue *)
                           kso_qt::QJsonObject::value
                                     ((QJsonObject *)&local_44,local_a4,8,"doc_type");
                  ppKVar17 = &local_34;
                  local_8._0_1_ = 0x96;
                  pQVar9 = (QString *)kso_qt::QJsonValue::toString(pQVar8);
                  kso_qt::QString::operator=((QString *)&local_50,pQVar9);
                  kso_qt::QString::~QString((QString *)&local_34);
                  local_8._0_1_ = 0x93;
                  kso_qt::QJsonValue::~QJsonValue(local_a4);
                  pQVar8 = (QJsonValue *)
                           kso_qt::QJsonObject::value
                                     ((QJsonObject *)&local_44,local_80,0xd,"template_name",ppKVar17
                                     );
                  ppKVar17 = &local_34;
                  local_8._0_1_ = 0x97;
                  pQVar9 = (QString *)kso_qt::QJsonValue::toString(pQVar8);
                  kso_qt::QString::operator=((QString *)&local_1c,pQVar9);
                  kso_qt::QString::~QString((QString *)&local_34);
                  local_8._0_1_ = 0x93;
                  kso_qt::QJsonValue::~QJsonValue((QJsonValue *)local_80);
                  pQVar8 = (QJsonValue *)
                           kso_qt::QJsonObject::value
                                     ((QJsonObject *)&local_44,local_c4,9,"rule_file",ppKVar17);
                  ppKVar17 = &local_34;
                  local_8._0_1_ = 0x98;
                  pQVar9 = (QString *)kso_qt::QJsonValue::toString(pQVar8);
                  kso_qt::QString::operator=((QString *)&local_20,pQVar9);
                  kso_qt::QString::~QString((QString *)&local_34);
                  local_8._0_1_ = 0x93;
                  kso_qt::QJsonValue::~QJsonValue(local_c4);
                  pQVar8 = (QJsonValue *)
                           kso_qt::QJsonObject::value
                                     ((QJsonObject *)&local_44,local_d4,0xb,"rule_string",ppKVar17);
                  ppKVar17 = &local_34;
                  local_8._0_1_ = 0x99;
                  pQVar9 = (QString *)kso_qt::QJsonValue::toString(pQVar8);
                  kso_qt::QString::operator=((QString *)&local_24,pQVar9);
                  kso_qt::QString::~QString((QString *)&local_34);
                  local_8._0_1_ = 0x93;
                  kso_qt::QJsonValue::~QJsonValue(local_d4);
                  pQVar8 = (QJsonValue *)
                           kso_qt::QJsonObject::value
                                     ((QJsonObject *)&local_44,local_b4,9,"rule_mode",ppKVar17);
                  ppKVar17 = &local_34;
                  local_8._0_1_ = 0x9a;
                  pQVar9 = (QString *)kso_qt::QJsonValue::toString(pQVar8);
                  puVar16 = &param_1;
                  local_8 = CONCAT31(local_8._1_3_,0x9b);
                  kso_qt::QString::trimmed(pQVar9);
                  if ((*(int *)(param_1 + 4) == 0) ||
                     (iVar6 = kso_qt::QString::compare
                                        ((QString *)&param_1,4,&DAT_10323238,0,puVar16,ppKVar17),
                     iVar6 == 0)) {
                    local_58 = (undefined *)0x0;
LAB_100d8ec5:
                    kso_qt::QString::~QString((QString *)&param_1);
                    param_1 = (code *)((uint)param_1 & 0xffffff);
                  }
                  else {
                    iVar6 = kso_qt::QString::compare
                                      ((QString *)&param_1,10,"modelEssay",0,puVar16,ppKVar17);
                    if ((iVar6 == 0) ||
                       (iVar6 = kso_qt::QString::compare
                                          ((QString *)&param_1,0xb,"model_essay",0,puVar16,ppKVar17)
                       , iVar6 == 0)) {
                      local_58 = (undefined *)0x1;
                      goto LAB_100d8ec5;
                    }
                    kso_qt::QString::~QString((QString *)&param_1);
                    param_1 = (code *)CONCAT13(1,param_1._0_3_);
                  }
                  kso_qt::QString::~QString((QString *)&local_34);
                  local_8._0_1_ = 0x93;
                  kso_qt::QJsonValue::~QJsonValue(local_b4);
                  if (param_1._3_1_ == '\0') {
                    pQVar8 = (QJsonValue *)
                             kso_qt::QJsonObject::value
                                       ((QJsonObject *)&local_44,local_b4,0xb,"format_spec");
                    local_8._0_1_ = 0x9d;
                    kso_qt::QJsonValue::toString(pQVar8);
                    local_8._0_1_ = 0x9f;
                    kso_qt::QJsonValue::~QJsonValue(local_b4);
                    kso_qt::QString::operator=((QString *)(in_ECX + 0x18),local_18);
                    local_60 = FUN_10009fe0;
                    local_5c = 0;
                    local_34 = operator_new(0xc);
                    if (local_34 == (KxMainWindow *)0x0) {
                      pKVar11 = (KxMainWindow *)0x0;
                    }
                    else {
                      *(undefined4 *)local_34 = 1;
                      *(code **)(local_34 + 4) = FUN_100d94c0;
                      *(int *)(local_34 + 8) = in_ECX + -8;
                      pKVar11 = local_34;
                    }
                    kso_qt::QObject::connectImpl
                              ((QObject *)&param_1,(void **)(in_ECX + -8),(QObject *)&local_60,
                               (void **)(in_ECX + -8),(QSlotObjectBase *)0x0,(ConnectionType)pKVar11
                               ,(int *)0x80,(QMetaObject *)0x0);
                    kso_qt::QMetaObject::Connection::~Connection((Connection *)&param_1);
                    FUN_1009d980();
                    uVar1 = local_4c;
                    iVar6 = FUN_1009d740();
                    if (iVar6 != 0) {
                      kso_qt::QString::operator=((QString *)(iVar6 + 0x160),(QString *)&local_14);
                    }
                    FUN_100d40b0(uVar1,&local_2c,&local_50,&local_1c);
                    kso_qt::QString::~QString((QString *)&local_14);
                    kso_qt::QJsonObject::~QJsonObject((QJsonObject *)&local_44);
                  }
                  else {
                    kso_qt::QString::QString((QString *)&param_1,0xe,"invalid_params");
                    local_8._0_1_ = 0x9c;
                    FUN_100db9f0();
                    kso_qt::QString::~QString((QString *)&param_1);
                    kso_qt::QJsonObject::~QJsonObject((QJsonObject *)&local_44);
                  }
                }
                else {
                  kso_qt::QString::QString
                            ((QString *)&param_1,0x1b,"Failed to parse paramString",ppKVar17);
                  local_8._0_1_ = 0x92;
                  FUN_100db9f0();
                  kso_qt::QString::~QString((QString *)&param_1);
                }
                kso_qt::QJsonDocument::~QJsonDocument((QJsonDocument *)&local_3c);
              }
              kso_qt::QString::~QString((QString *)&local_28);
              kso_qt::QString::~QString((QString *)&local_24);
              kso_qt::QString::~QString((QString *)&local_20);
              kso_qt::QString::~QString((QString *)&local_1c);
              kso_qt::QString::~QString((QString *)&local_50);
              goto LAB_100d908a;
            }
            bVar2 = kso_qt::QString::operator==
                              ((QString *)&local_48,0x1e,"report_cowork_typeset_decision");
            if (bVar2) {
              kso_qt::QString::QString((QString *)&local_58);
              kso_qt::QString::QString((QString *)&local_24);
              kso_qt::QString::QString((QString *)&param_1);
              local_8._0_1_ = 0xa2;
              kso_qt::QString::trimmed(local_54);
              local_8._0_1_ = 0xa3;
              uVar4 = (undefined1)local_8;
              local_8._0_1_ = 0xa3;
              if (*(int *)(local_28 + 4) != 0) {
                local_88 = 0;
                local_84 = 0;
                pQVar7 = (QJsonParseError *)kso_qt::QString::toUtf8((QString *)&local_28);
                local_8._0_1_ = 0xa4;
                kso_qt::QJsonDocument::fromJson((QByteArray *)&local_3c,pQVar7);
                local_8._0_1_ = 0xa6;
                kso_qt::QByteArray::~QByteArray((QByteArray *)&local_34);
                if ((local_84 == 0) &&
                   (bVar2 = kso_qt::QJsonDocument::isObject((QJsonDocument *)&local_3c), bVar2)) {
                  kso_qt::QJsonDocument::object((QJsonDocument *)&local_3c);
                  local_8._0_1_ = 0xa7;
                  pQVar8 = (QJsonValue *)
                           kso_qt::QJsonObject::value((QJsonObject *)&local_44,local_70);
                  ppKVar17 = &local_34;
                  local_8._0_1_ = 0xa8;
                  pQVar9 = (QString *)kso_qt::QJsonValue::toString(pQVar8);
                  kso_qt::QString::operator=((QString *)&local_58,pQVar9);
                  kso_qt::QString::~QString((QString *)&local_34);
                  local_8._0_1_ = 0xa7;
                  kso_qt::QJsonValue::~QJsonValue((QJsonValue *)local_70);
                  pQVar8 = (QJsonValue *)
                           kso_qt::QJsonObject::value
                                     ((QJsonObject *)&local_44,local_a4,10,"request_id",ppKVar17);
                  ppKVar17 = &local_34;
                  local_8._0_1_ = 0xa9;
                  pQVar9 = (QString *)kso_qt::QJsonValue::toString(pQVar8);
                  kso_qt::QString::operator=((QString *)&local_24,pQVar9);
                  kso_qt::QString::~QString((QString *)&local_34);
                  local_8._0_1_ = 0xa7;
                  kso_qt::QJsonValue::~QJsonValue(local_a4);
                  pQVar8 = (QJsonValue *)
                           kso_qt::QJsonObject::value
                                     ((QJsonObject *)&local_44,local_80,9,"sessionId",ppKVar17);
                  local_8._0_1_ = 0xaa;
                  pQVar9 = (QString *)kso_qt::QJsonValue::toString(pQVar8);
                  kso_qt::QString::operator=((QString *)&param_1,pQVar9);
                  kso_qt::QString::~QString((QString *)&local_34);
                  local_8._0_1_ = 0xa7;
                  kso_qt::QJsonValue::~QJsonValue((QJsonValue *)local_80);
                  if (*(int *)(param_1 + 4) == 0) {
                    pQVar8 = (QJsonValue *)kso_qt::QJsonObject::value((QJsonObject *)&local_44);
                    local_8._0_1_ = 0xab;
                    pQVar9 = (QString *)kso_qt::QJsonValue::toString(pQVar8);
                    kso_qt::QString::operator=((QString *)&param_1,pQVar9);
                    kso_qt::QString::~QString((QString *)&local_34);
                    kso_qt::QJsonValue::~QJsonValue((QJsonValue *)local_70);
                  }
                  kso_qt::QJsonObject::~QJsonObject((QJsonObject *)&local_44);
                }
                local_8._0_1_ = 0xa3;
                kso_qt::QJsonDocument::~QJsonDocument((QJsonDocument *)&local_3c);
                uVar4 = (undefined1)local_8;
              }
              local_8._0_1_ = uVar4;
              FUN_1009d980();
              iVar6 = FUN_1009d740();
              if (iVar6 == 0) {
                kso_qt::QString::QString((QString *)&local_2c);
                local_8._0_1_ = 0xac;
                FUN_100db9f0();
                pQVar9 = (QString *)&local_2c;
              }
              else {
                FUN_100c81e0(&local_1c);
                local_8._0_1_ = 0xad;
                uVar4 = (undefined1)local_8;
                local_8._0_1_ = 0xad;
                if (*(int *)(local_1c + 4) == 0) {
                  kso_qt::QString::QString((QString *)&local_14);
                  local_8._0_1_ = 0xae;
                  local_4c = 0x74;
                }
                else {
                  local_8._0_1_ = uVar4;
                  kso_qt::QString::QString((QString *)&local_34,(QString *)&local_1c);
                  local_8._0_1_ = 0xaf;
                  local_8._1_3_ = 0;
                  local_4c = 0x78;
                }
                local_20 = local_4c;
                FUN_100db9f0();
                if ((local_20 & 8) != 0) {
                  local_20 = local_20 & 0xfffffff7;
                  kso_qt::QString::~QString((QString *)&local_34);
                }
                if ((local_20 & 4) != 0) {
                  kso_qt::QString::~QString((QString *)&local_14);
                }
                pQVar9 = (QString *)&local_1c;
              }
              kso_qt::QString::~QString(pQVar9);
              kso_qt::QString::~QString((QString *)&local_28);
              kso_qt::QString::~QString((QString *)&param_1);
              kso_qt::QString::~QString((QString *)&local_24);
              pQVar9 = (QString *)&local_58;
            }
            else {
              kso_qt::QString::QString((QString *)&param_1);
              local_8._0_1_ = 0xb0;
              FUN_100db9f0();
              pQVar9 = (QString *)&param_1;
            }
          }
        }
      }
      goto LAB_100d908d;
    }
    FUN_1009d980();
    pQVar5 = (QVariant *)FUN_1009d740();
    local_14 = pQVar5;
    if (pQVar5 == (QVariant *)0x0) {
LAB_100d7bd1:
      kso_qt::QString::QString((QString *)&param_1);
      local_8._0_1_ = 0x3e;
      FUN_100db9f0();
      pQVar9 = (QString *)&param_1;
      goto LAB_100d908d;
    }
    iVar6 = FUN_1006a7c0();
    if ((iVar6 != 2) && (iVar6 = FUN_1006a7c0(), iVar6 != 1)) {
      if (pQVar5 != (QVariant *)0x0) {
        kso_qt::QString::QString((QString *)&param_1);
        local_8._0_1_ = 0x3f;
        FUN_100db9f0();
        pQVar9 = (QString *)&param_1;
        goto LAB_100d908d;
      }
      goto LAB_100d7bd1;
    }
    local_30 = (void **)(in_ECX + -8);
    kso_qt::QString::QString((QString *)&local_2c,local_18);
    param_1 = FUN_1000a360;
    local_8._0_1_ = 0x3d;
    pKVar11 = operator_new(0x10);
    local_34 = pKVar11;
    if (pKVar11 == (KxMainWindow *)0x0) {
      pKVar11 = (KxMainWindow *)0x0;
    }
    else {
      local_44 = local_30;
      kso_qt::QString::QString((QString *)&local_40,(QString *)&local_2c);
      *(undefined4 *)pKVar11 = 1;
      *(code **)(pKVar11 + 4) = FUN_100d9930;
      *(void ***)(pKVar11 + 8) = local_44;
      kso_qt::QString::QString((QString *)(pKVar11 + 0xc),(QString *)&local_40);
      kso_qt::QString::~QString((QString *)&local_40);
    }
    kso_qt::QObject::connectImpl
              ((QObject *)&local_5c,(void **)local_14,(QObject *)&param_1,(void **)(in_ECX + -8),
               (QSlotObjectBase *)0x0,(ConnectionType)pKVar11,(int *)0x80,(QMetaObject *)0x0);
    kso_qt::QString::~QString((QString *)&local_2c);
    kso_qt::QMetaObject::Connection::~Connection((Connection *)&local_5c);
  }
LAB_100d9093:
  pQVar9 = (QString *)&local_48;
LAB_100d9096:
  kso_qt::QString::~QString(pQVar9);
  kso_qt::QString::~QString(local_54);
  kso_qt::QString::~QString(local_94);
  kso_qt::QString::~QString(local_18);
  ExceptionList = local_10;
  return;
}

