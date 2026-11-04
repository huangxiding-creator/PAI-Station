.class public Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/TableSwitchForm;
.super Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/SwitchForm;
.source "TableSwitchForm.java"


# direct methods
.method public constructor <init>(ILjava/lang/String;)V
    .locals 0
    .param p1, "opcode"    # I
    .param p2, "name"    # Ljava/lang/String;

    .line 25
    invoke-direct {p0, p1, p2}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/SwitchForm;-><init>(ILjava/lang/String;)V

    .line 26
    return-void
.end method


# virtual methods
.method public setByteCodeOperands(Lorg/apache/commons/compress/harmony/unpack200/bytecode/ByteCode;Lorg/apache/commons/compress/harmony/unpack200/bytecode/OperandManager;I)V
    .locals 18
    .param p1, "byteCode"    # Lorg/apache/commons/compress/harmony/unpack200/bytecode/ByteCode;
    .param p2, "operandManager"    # Lorg/apache/commons/compress/harmony/unpack200/bytecode/OperandManager;
    .param p3, "codeLength"    # I

    .line 39
    move-object/from16 v0, p0

    move-object/from16 v1, p1

    invoke-virtual/range {p2 .. p2}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/OperandManager;->nextCaseCount()I

    move-result v2

    .line 40
    .local v2, "case_count":I
    invoke-virtual/range {p2 .. p2}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/OperandManager;->nextLabel()I

    move-result v3

    .line 41
    .local v3, "default_pc":I
    const/4 v4, -0x1

    .line 42
    .local v4, "case_value":I
    invoke-virtual/range {p2 .. p2}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/OperandManager;->nextCaseValues()I

    move-result v4

    .line 44
    new-array v5, v2, [I

    .line 45
    .local v5, "case_pcs":[I
    const/4 v6, 0x0

    .local v6, "index":I
    :goto_0
    if-ge v6, v2, :cond_0

    .line 46
    invoke-virtual/range {p2 .. p2}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/OperandManager;->nextLabel()I

    move-result v7

    aput v7, v5, v6

    .line 45
    add-int/lit8 v6, v6, 0x1

    goto :goto_0

    .line 49
    .end local v6    # "index":I
    :cond_0
    add-int/lit8 v6, v2, 0x1

    new-array v6, v6, [I

    .line 50
    .local v6, "labelsArray":[I
    const/4 v7, 0x0

    aput v3, v6, v7

    .line 51
    const/4 v8, 0x1

    .local v8, "index":I
    :goto_1
    add-int/lit8 v9, v2, 0x1

    if-ge v8, v9, :cond_1

    .line 52
    add-int/lit8 v9, v8, -0x1

    aget v9, v5, v9

    aput v9, v6, v8

    .line 51
    add-int/lit8 v8, v8, 0x1

    goto :goto_1

    .line 54
    .end local v8    # "index":I
    :cond_1
    invoke-virtual {v1, v6}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/ByteCode;->setByteCodeTargets([I)V

    .line 56
    move v8, v4

    .line 57
    .local v8, "lowValue":I
    add-int v9, v8, v2

    add-int/lit8 v9, v9, -0x1

    .line 70
    .local v9, "highValue":I
    rem-int/lit8 v10, p3, 0x4

    rsub-int/lit8 v10, v10, 0x3

    .line 71
    .local v10, "padLength":I
    add-int/lit8 v11, v10, 0x1

    add-int/lit8 v11, v11, 0x4

    add-int/lit8 v11, v11, 0x4

    add-int/lit8 v11, v11, 0x4

    array-length v12, v5

    mul-int/lit8 v12, v12, 0x4

    add-int/2addr v11, v12

    .line 76
    .local v11, "rewriteSize":I
    new-array v12, v11, [I

    .line 77
    .local v12, "newRewrite":[I
    const/4 v13, 0x0

    .line 81
    .local v13, "rewriteIndex":I
    add-int/lit8 v14, v13, 0x1

    .end local v13    # "rewriteIndex":I
    .local v14, "rewriteIndex":I
    invoke-virtual/range {p1 .. p1}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/ByteCode;->getOpcode()I

    move-result v15

    aput v15, v12, v13

    .line 84
    const/4 v13, 0x0

    .local v13, "index":I
    :goto_2
    if-ge v13, v10, :cond_2

    .line 85
    add-int/lit8 v15, v14, 0x1

    .end local v14    # "rewriteIndex":I
    .local v15, "rewriteIndex":I
    aput v7, v12, v14

    .line 84
    add-int/lit8 v13, v13, 0x1

    move v14, v15

    goto :goto_2

    .line 90
    .end local v13    # "index":I
    .end local v15    # "rewriteIndex":I
    .restart local v14    # "rewriteIndex":I
    :cond_2
    add-int/lit8 v7, v14, 0x1

    .end local v14    # "rewriteIndex":I
    .local v7, "rewriteIndex":I
    const/4 v13, -0x1

    aput v13, v12, v14

    .line 91
    add-int/lit8 v14, v7, 0x1

    .end local v7    # "rewriteIndex":I
    .restart local v14    # "rewriteIndex":I
    aput v13, v12, v7

    .line 92
    add-int/lit8 v7, v14, 0x1

    .end local v14    # "rewriteIndex":I
    .restart local v7    # "rewriteIndex":I
    aput v13, v12, v14

    .line 93
    add-int/lit8 v14, v7, 0x1

    .end local v7    # "rewriteIndex":I
    .restart local v14    # "rewriteIndex":I
    aput v13, v12, v7

    .line 96
    move v7, v14

    .line 97
    .local v7, "lowbyteIndex":I
    invoke-virtual {v0, v8, v7, v12}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/TableSwitchForm;->setRewrite4Bytes(II[I)V

    .line 98
    add-int/lit8 v14, v14, 0x4

    .line 101
    move v15, v14

    .line 102
    .local v15, "highbyteIndex":I
    invoke-virtual {v0, v9, v15, v12}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/TableSwitchForm;->setRewrite4Bytes(II[I)V

    .line 103
    add-int/lit8 v14, v14, 0x4

    .line 107
    const/16 v16, 0x0

    move/from16 v13, v16

    .restart local v13    # "index":I
    :goto_3
    if-ge v13, v2, :cond_3

    .line 109
    add-int/lit8 v17, v14, 0x1

    const/16 v16, -0x1

    .end local v14    # "rewriteIndex":I
    .local v17, "rewriteIndex":I
    aput v16, v12, v14

    .line 110
    add-int/lit8 v14, v17, 0x1

    .end local v17    # "rewriteIndex":I
    .restart local v14    # "rewriteIndex":I
    aput v16, v12, v17

    .line 111
    add-int/lit8 v17, v14, 0x1

    .end local v14    # "rewriteIndex":I
    .restart local v17    # "rewriteIndex":I
    aput v16, v12, v14

    .line 112
    add-int/lit8 v14, v17, 0x1

    .end local v17    # "rewriteIndex":I
    .restart local v14    # "rewriteIndex":I
    aput v16, v12, v17

    .line 107
    add-int/lit8 v13, v13, 0x1

    goto :goto_3

    .line 114
    .end local v13    # "index":I
    :cond_3
    invoke-virtual {v1, v12}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/ByteCode;->setRewrite([I)V

    .line 115
    return-void
.end method
