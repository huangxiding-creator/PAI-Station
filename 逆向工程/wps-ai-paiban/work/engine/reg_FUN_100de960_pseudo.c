
/* WARNING: Removing unreachable block (ram,0x100def6c) */

undefined1 FUN_100de960(QString *param_1)

{
  bool bVar1;
  bool bVar2;
  bool bVar3;
  bool bVar4;
  bool bVar5;
  bool bVar6;
  bool bVar7;
  bool bVar8;
  bool bVar9;
  bool bVar10;
  bool bVar11;
  bool bVar12;
  bool bVar13;
  bool bVar14;
  bool bVar15;
  bool bVar16;
  bool bVar17;
  bool bVar18;
  bool bVar19;
  bool bVar20;
  bool bVar21;
  uint uVar22;
  QString *this;
  QString *pQVar23;
  undefined4 *puVar24;
  QString local_74 [4];
  QString local_70 [4];
  QString local_6c [4];
  QString local_68 [4];
  QString local_64 [4];
  QString local_60 [4];
  QString local_5c [4];
  QString local_58 [4];
  QString local_54 [4];
  QString local_50 [4];
  QString local_4c [4];
  QString local_48 [4];
  QString local_44 [4];
  QString local_40 [4];
  QString local_3c [4];
  QString local_38 [4];
  QString local_34 [4];
  QString local_30 [4];
  QString local_2c [4];
  QString local_28 [4];
  QString local_24 [4];
  QString local_20 [4];
  undefined4 local_1c;
  QString local_18 [7];
  undefined1 local_11;
  void *local_10;
  undefined1 *puStack_c;
  undefined4 local_8;
  
  local_8 = 0xffffffff;
  puStack_c = &LAB_102cd2df;
  local_10 = ExceptionList;
  uVar22 = DAT_10401e54 ^ (uint)&stack0xfffffffc;
  ExceptionList = &local_10;
  puVar24 = &local_1c;
  local_1c = 0;
  this = (QString *)kso_qt::QString::trimmed(param_1);
  pQVar23 = local_18;
  local_8 = 0;
  kso_qt::QString::toLower(this);
  local_8._0_1_ = 2;
  kso_qt::QString::~QString((QString *)&local_1c);
  kso_qt::QString::QString(local_74,0x13,"begin_typeset_write",pQVar23,puVar24,uVar22);
  local_8 = CONCAT31(local_8._1_3_,3);
  bVar20 = false;
  bVar19 = false;
  bVar18 = false;
  bVar17 = false;
  bVar16 = false;
  bVar15 = false;
  bVar14 = false;
  bVar13 = false;
  bVar12 = false;
  bVar11 = false;
  bVar10 = false;
  bVar9 = false;
  bVar8 = false;
  bVar7 = false;
  bVar6 = false;
  bVar5 = false;
  bVar4 = false;
  bVar3 = false;
  bVar2 = false;
  bVar1 = false;
  local_1c = 0x400001;
  bVar21 = kso_qt::operator==(local_18,local_74);
  if (!bVar21) {
    kso_qt::QString::QString(local_70,0xe,"doc_preprocess");
    local_8 = 4;
    bVar20 = false;
    bVar19 = false;
    bVar18 = false;
    bVar17 = false;
    bVar16 = false;
    bVar15 = false;
    bVar14 = false;
    bVar13 = false;
    bVar12 = false;
    bVar11 = false;
    bVar10 = false;
    bVar9 = false;
    bVar8 = false;
    bVar7 = false;
    bVar6 = true;
    bVar5 = false;
    bVar4 = false;
    bVar3 = false;
    bVar2 = false;
    bVar1 = false;
    local_1c = 0xc00003;
    bVar21 = kso_qt::operator==(local_18,local_70);
    if (!bVar21) {
      kso_qt::QString::QString(local_6c,0x14,"open_typeset_session");
      local_8 = 5;
      bVar20 = false;
      bVar19 = false;
      bVar18 = false;
      bVar17 = false;
      bVar16 = false;
      bVar15 = false;
      bVar14 = false;
      bVar13 = false;
      bVar12 = false;
      bVar11 = false;
      bVar10 = false;
      bVar9 = false;
      bVar8 = false;
      bVar7 = false;
      bVar6 = true;
      bVar5 = true;
      bVar4 = false;
      bVar3 = false;
      bVar2 = false;
      bVar1 = false;
      local_1c = 0x1c00007;
      bVar21 = kso_qt::operator==(local_18,local_6c);
      if (!bVar21) {
        kso_qt::QString::QString(local_68,0x15,"close_typeset_session");
        local_8 = 6;
        bVar20 = false;
        bVar19 = false;
        bVar18 = false;
        bVar17 = false;
        bVar16 = false;
        bVar15 = false;
        bVar14 = false;
        bVar13 = false;
        bVar12 = false;
        bVar11 = false;
        bVar10 = false;
        bVar9 = false;
        bVar8 = false;
        bVar7 = false;
        bVar6 = true;
        bVar5 = true;
        bVar4 = true;
        bVar3 = false;
        bVar2 = false;
        bVar1 = false;
        local_1c = 0x3c0000f;
        bVar21 = kso_qt::operator==(local_18,local_68);
        if (!bVar21) {
          kso_qt::QString::QString(local_64,0x18,"finalize_typeset_session");
          local_8 = 7;
          bVar20 = false;
          bVar19 = false;
          bVar18 = false;
          bVar17 = false;
          bVar16 = false;
          bVar15 = false;
          bVar14 = false;
          bVar13 = false;
          bVar12 = false;
          bVar11 = false;
          bVar10 = false;
          bVar9 = false;
          bVar8 = false;
          bVar7 = false;
          bVar6 = true;
          bVar5 = true;
          bVar4 = true;
          bVar3 = true;
          bVar2 = false;
          bVar1 = false;
          local_1c = 0x7c0001f;
          bVar21 = kso_qt::operator==(local_18,local_64);
          if (!bVar21) {
            kso_qt::QString::QString(local_60,0xb,"oplist_exec");
            local_8 = 8;
            bVar20 = false;
            bVar19 = false;
            bVar18 = false;
            bVar17 = false;
            bVar16 = false;
            bVar15 = false;
            bVar14 = false;
            bVar13 = false;
            bVar12 = false;
            bVar11 = false;
            bVar10 = false;
            bVar9 = false;
            bVar8 = false;
            bVar7 = false;
            bVar6 = true;
            bVar5 = true;
            bVar4 = true;
            bVar3 = true;
            bVar2 = true;
            bVar1 = false;
            local_1c = 0xfc0003f;
            bVar21 = kso_qt::operator==(local_18,local_60);
            if (!bVar21) {
              kso_qt::QString::QString(local_5c,0x14,"batch_set_span_style");
              local_8 = 9;
              bVar20 = false;
              bVar19 = false;
              bVar18 = false;
              bVar17 = false;
              bVar16 = false;
              bVar15 = false;
              bVar14 = false;
              bVar13 = false;
              bVar12 = false;
              bVar11 = false;
              bVar10 = false;
              bVar9 = false;
              bVar8 = false;
              bVar7 = false;
              bVar6 = true;
              bVar5 = true;
              bVar4 = true;
              bVar3 = true;
              bVar2 = true;
              bVar1 = true;
              local_1c = 0x1fc0007f;
              bVar21 = kso_qt::operator==(local_18,local_5c);
              if (!bVar21) {
                kso_qt::QString::QString(local_58,0x1a,"batch_set_paragraph_indent");
                local_8 = 10;
                bVar20 = false;
                bVar19 = false;
                bVar18 = false;
                bVar17 = false;
                bVar16 = false;
                bVar15 = false;
                bVar14 = false;
                bVar13 = false;
                bVar12 = false;
                bVar11 = false;
                bVar10 = false;
                bVar9 = false;
                bVar8 = false;
                bVar7 = false;
                bVar6 = true;
                bVar5 = true;
                bVar4 = true;
                bVar3 = true;
                bVar2 = true;
                bVar1 = true;
                local_1c = 0x3fc000ff;
                bVar21 = kso_qt::operator==(local_18,local_58);
                if (!bVar21) {
                  kso_qt::QString::QString(local_54,0x1b,"batch_apply_paragraph_style");
                  local_8 = 0xb;
                  bVar20 = false;
                  bVar19 = false;
                  bVar18 = false;
                  bVar17 = false;
                  bVar16 = false;
                  bVar15 = false;
                  bVar14 = false;
                  bVar13 = true;
                  bVar12 = false;
                  bVar11 = false;
                  bVar10 = false;
                  bVar9 = false;
                  bVar8 = false;
                  bVar7 = false;
                  bVar6 = true;
                  bVar5 = true;
                  bVar4 = true;
                  bVar3 = true;
                  bVar2 = true;
                  bVar1 = true;
                  local_1c = 0x7fc001ff;
                  bVar21 = kso_qt::operator==(local_18,local_54);
                  if (!bVar21) {
                    kso_qt::QString::QString(local_50,0x19,"batch_set_paragraph_props");
                    local_8 = 0xc;
                    bVar20 = false;
                    bVar19 = false;
                    bVar18 = false;
                    bVar17 = false;
                    bVar16 = false;
                    bVar15 = false;
                    bVar14 = false;
                    bVar13 = true;
                    bVar12 = true;
                    bVar11 = false;
                    bVar10 = false;
                    bVar9 = false;
                    bVar8 = false;
                    bVar7 = false;
                    bVar6 = true;
                    bVar5 = true;
                    bVar4 = true;
                    bVar3 = true;
                    bVar2 = true;
                    bVar1 = true;
                    local_1c = 0xffc003ff;
                    bVar21 = kso_qt::operator==(local_18,local_50);
                    if (!bVar21) {
                      kso_qt::QString::QString(local_4c,0x15,"import_element_styles");
                      local_8 = 0xd;
                      bVar20 = false;
                      bVar19 = false;
                      bVar18 = false;
                      bVar17 = false;
                      bVar16 = false;
                      bVar15 = false;
                      bVar14 = false;
                      bVar13 = true;
                      bVar12 = true;
                      bVar11 = true;
                      bVar10 = false;
                      bVar9 = false;
                      bVar8 = false;
                      bVar7 = false;
                      bVar6 = true;
                      bVar5 = true;
                      bVar4 = true;
                      bVar3 = true;
                      bVar2 = true;
                      bVar1 = true;
                      local_1c = 0xffc007ff;
                      bVar21 = kso_qt::operator==(local_18,local_4c);
                      if (!bVar21) {
                        kso_qt::QString::QString(local_48,0x18,"cleanup_empty_paragraphs");
                        local_8 = 0xe;
                        bVar20 = false;
                        bVar19 = false;
                        bVar18 = false;
                        bVar17 = false;
                        bVar16 = false;
                        bVar15 = false;
                        bVar14 = false;
                        bVar13 = true;
                        bVar12 = true;
                        bVar11 = true;
                        bVar10 = true;
                        bVar9 = false;
                        bVar8 = false;
                        bVar7 = false;
                        bVar6 = true;
                        bVar5 = true;
                        bVar4 = true;
                        bVar3 = true;
                        bVar2 = true;
                        bVar1 = true;
                        local_1c = 0xffc00fff;
                        bVar21 = kso_qt::operator==(local_18,local_48);
                        if (!bVar21) {
                          kso_qt::QString::QString(local_44,0x1c,"trim_paragraph_leading_chars");
                          local_8 = 0xf;
                          bVar20 = false;
                          bVar19 = false;
                          bVar18 = false;
                          bVar17 = false;
                          bVar16 = false;
                          bVar15 = false;
                          bVar14 = false;
                          bVar13 = true;
                          bVar12 = true;
                          bVar11 = true;
                          bVar10 = true;
                          bVar9 = true;
                          bVar8 = false;
                          bVar7 = false;
                          bVar6 = true;
                          bVar5 = true;
                          bVar4 = true;
                          bVar3 = true;
                          bVar2 = true;
                          bVar1 = true;
                          local_1c = 0xffc01fff;
                          bVar21 = kso_qt::operator==(local_18,local_44);
                          if (!bVar21) {
                            kso_qt::QString::QString(local_40,0x11,"batch_set_spacing");
                            local_8 = 0x10;
                            bVar20 = false;
                            bVar19 = false;
                            bVar18 = false;
                            bVar17 = false;
                            bVar16 = false;
                            bVar15 = false;
                            bVar14 = false;
                            bVar13 = true;
                            bVar12 = true;
                            bVar11 = true;
                            bVar10 = true;
                            bVar9 = true;
                            bVar8 = true;
                            bVar7 = false;
                            bVar6 = true;
                            bVar5 = true;
                            bVar4 = true;
                            bVar3 = true;
                            bVar2 = true;
                            bVar1 = true;
                            local_1c = 0xffc03fff;
                            bVar21 = kso_qt::operator==(local_18,local_40);
                            if (!bVar21) {
                              kso_qt::QString::QString(local_3c,0x17,"batch_page_break_before");
                              local_8 = 0x11;
                              bVar20 = false;
                              bVar19 = false;
                              bVar18 = false;
                              bVar17 = false;
                              bVar16 = false;
                              bVar15 = false;
                              bVar14 = false;
                              bVar13 = true;
                              bVar12 = true;
                              bVar11 = true;
                              bVar10 = true;
                              bVar9 = true;
                              bVar8 = true;
                              bVar7 = true;
                              bVar6 = true;
                              bVar5 = true;
                              bVar4 = true;
                              bVar3 = true;
                              bVar2 = true;
                              bVar1 = true;
                              local_1c = 0xffc07fff;
                              bVar21 = kso_qt::operator==(local_18,local_3c);
                              if (!bVar21) {
                                kso_qt::QString::QString(local_38,0x10,"setup_page_setup");
                                local_8 = 0x12;
                                bVar20 = true;
                                bVar19 = false;
                                bVar18 = false;
                                bVar17 = false;
                                bVar16 = false;
                                bVar15 = false;
                                bVar14 = false;
                                bVar13 = true;
                                bVar12 = true;
                                bVar11 = true;
                                bVar10 = true;
                                bVar9 = true;
                                bVar8 = true;
                                bVar7 = true;
                                bVar6 = true;
                                bVar5 = true;
                                bVar4 = true;
                                bVar3 = true;
                                bVar2 = true;
                                bVar1 = true;
                                local_1c = 0xffc0ffff;
                                bVar21 = kso_qt::operator==(local_18,local_38);
                                if (!bVar21) {
                                  kso_qt::QString::QString(local_34,0x13,"setup_header_footer");
                                  local_8 = 0x13;
                                  bVar20 = true;
                                  bVar19 = true;
                                  bVar18 = false;
                                  bVar17 = false;
                                  bVar16 = false;
                                  bVar15 = false;
                                  bVar14 = false;
                                  bVar13 = true;
                                  bVar12 = true;
                                  bVar11 = true;
                                  bVar10 = true;
                                  bVar9 = true;
                                  bVar8 = true;
                                  bVar7 = true;
                                  bVar6 = true;
                                  bVar5 = true;
                                  bVar4 = true;
                                  bVar3 = true;
                                  bVar2 = true;
                                  bVar1 = true;
                                  local_1c = 0xffc1ffff;
                                  bVar21 = kso_qt::operator==(local_18,local_34);
                                  if (!bVar21) {
                                    kso_qt::QString::QString
                                              (local_30,0x18,"insert_table_of_contents");
                                    local_8 = 0x14;
                                    bVar20 = true;
                                    bVar19 = true;
                                    bVar18 = true;
                                    bVar17 = false;
                                    bVar16 = false;
                                    bVar15 = false;
                                    bVar14 = false;
                                    bVar13 = true;
                                    bVar12 = true;
                                    bVar11 = true;
                                    bVar10 = true;
                                    bVar9 = true;
                                    bVar8 = true;
                                    bVar7 = true;
                                    bVar6 = true;
                                    bVar5 = true;
                                    bVar4 = true;
                                    bVar3 = true;
                                    bVar2 = true;
                                    bVar1 = true;
                                    local_1c = 0xffc3ffff;
                                    bVar21 = kso_qt::operator==(local_18,local_30);
                                    if (!bVar21) {
                                      kso_qt::QString::QString
                                                (local_2c,0x18,"update_table_of_contents");
                                      local_8 = 0x15;
                                      bVar20 = true;
                                      bVar19 = true;
                                      bVar18 = true;
                                      bVar17 = true;
                                      bVar16 = false;
                                      bVar15 = false;
                                      bVar14 = false;
                                      bVar13 = true;
                                      bVar12 = true;
                                      bVar11 = true;
                                      bVar10 = true;
                                      bVar9 = true;
                                      bVar8 = true;
                                      bVar7 = true;
                                      bVar6 = true;
                                      bVar5 = true;
                                      bVar4 = true;
                                      bVar3 = true;
                                      bVar2 = true;
                                      bVar1 = true;
                                      local_1c = 0xffc7ffff;
                                      bVar21 = kso_qt::operator==(local_18,local_2c);
                                      if (!bVar21) {
                                        kso_qt::QString::QString(local_28,0x10,"setup_toc_styles");
                                        local_8 = 0x16;
                                        bVar20 = true;
                                        bVar19 = true;
                                        bVar18 = true;
                                        bVar17 = true;
                                        bVar16 = true;
                                        bVar15 = false;
                                        bVar14 = false;
                                        bVar13 = true;
                                        bVar12 = true;
                                        bVar11 = true;
                                        bVar10 = true;
                                        bVar9 = true;
                                        bVar8 = true;
                                        bVar7 = true;
                                        bVar6 = true;
                                        bVar5 = true;
                                        bVar4 = true;
                                        bVar3 = true;
                                        bVar2 = true;
                                        bVar1 = true;
                                        local_1c = 0xffcfffff;
                                        bVar21 = kso_qt::operator==(local_18,local_28);
                                        if (!bVar21) {
                                          kso_qt::QString::QString
                                                    (local_24,0x18,"delete_table_of_contents");
                                          local_8 = 0x17;
                                          bVar20 = true;
                                          bVar19 = true;
                                          bVar18 = true;
                                          bVar17 = true;
                                          bVar16 = true;
                                          bVar15 = true;
                                          bVar14 = false;
                                          bVar13 = true;
                                          bVar12 = true;
                                          bVar11 = true;
                                          bVar10 = true;
                                          bVar9 = true;
                                          bVar8 = true;
                                          bVar7 = true;
                                          bVar6 = true;
                                          bVar5 = true;
                                          bVar4 = true;
                                          bVar3 = true;
                                          bVar2 = true;
                                          bVar1 = true;
                                          local_1c = 0xffdfffff;
                                          bVar21 = kso_qt::operator==(local_18,local_24);
                                          if (!bVar21) {
                                            kso_qt::QString::QString
                                                      (local_20,0x11,"setup_table_style");
                                            bVar20 = true;
                                            bVar19 = true;
                                            bVar18 = true;
                                            bVar17 = true;
                                            bVar16 = true;
                                            bVar15 = true;
                                            bVar14 = true;
                                            bVar13 = true;
                                            bVar12 = true;
                                            bVar11 = true;
                                            bVar10 = true;
                                            bVar9 = true;
                                            bVar8 = true;
                                            bVar7 = true;
                                            bVar6 = true;
                                            bVar5 = true;
                                            bVar4 = true;
                                            bVar3 = true;
                                            bVar2 = true;
                                            bVar1 = true;
                                            bVar21 = kso_qt::operator==(local_18,local_20);
                                            local_11 = 0;
                                            if (!bVar21) goto LAB_100dee26;
                                          }
                                        }
                                      }
                                    }
                                  }
                                }
                              }
                            }
                          }
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
  }
  local_11 = 1;
LAB_100dee26:
  if (bVar14) {
    kso_qt::QString::~QString(local_20);
  }
  if (bVar15) {
    kso_qt::QString::~QString(local_24);
  }
  if (bVar16) {
    kso_qt::QString::~QString(local_28);
  }
  if (bVar17) {
    kso_qt::QString::~QString(local_2c);
  }
  if (bVar18) {
    kso_qt::QString::~QString(local_30);
  }
  if (bVar19) {
    kso_qt::QString::~QString(local_34);
  }
  if (bVar20) {
    kso_qt::QString::~QString(local_38);
  }
  if (bVar7) {
    kso_qt::QString::~QString(local_3c);
  }
  if (bVar8) {
    kso_qt::QString::~QString(local_40);
  }
  if (bVar9) {
    kso_qt::QString::~QString(local_44);
  }
  if (bVar10) {
    kso_qt::QString::~QString(local_48);
  }
  if (bVar11) {
    kso_qt::QString::~QString(local_4c);
  }
  if (bVar12) {
    kso_qt::QString::~QString(local_50);
  }
  if (bVar13) {
    kso_qt::QString::~QString(local_54);
  }
  if (bVar1) {
    kso_qt::QString::~QString(local_5c);
  }
  if (bVar2) {
    kso_qt::QString::~QString(local_60);
  }
  if (bVar3) {
    kso_qt::QString::~QString(local_64);
  }
  if (bVar4) {
    kso_qt::QString::~QString(local_68);
  }
  if (bVar5) {
    kso_qt::QString::~QString(local_6c);
  }
  if (bVar6) {
    kso_qt::QString::~QString(local_70);
  }
  kso_qt::QString::~QString(local_74);
  kso_qt::QString::~QString(local_18);
  ExceptionList = local_10;
  return local_11;
}

