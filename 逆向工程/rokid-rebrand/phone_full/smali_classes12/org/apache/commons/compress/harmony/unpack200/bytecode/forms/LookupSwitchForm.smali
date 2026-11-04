.class public Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/LookupSwitchForm;
.super Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/SwitchForm;
.source "LookupSwitchForm.java"


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
    .locals 15
    .param p1, "byteCode"    # Lorg/apache/commons/compress/harmony/unpack200/bytecode/ByteCode;
    .param p2, "operandManager"    # Lorg/apache/commons/compress/harmony/unpack200/bytecode/OperandManager;
    .param p3, "codeLength"    # I

    .line 39
    move-object v0, p0

    move-object/from16 v1, p1

    invoke-virtual/range {p2 .. p2}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/OperandManager;->nextCaseCount()I

    move-result v2

    .line 40
    .local v2, "case_count":I
    invoke-virtual/range {p2 .. p2}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/OperandManager;->nextLabel()I

    move-result v3

    .line 41
    .local v3, "default_pc":I
    new-array v4, v2, [I

    .line 42
    .local v4, "case_values":[I
    const/4 v5, 0x0

    .local v5, "index":I
    :goto_0
    if-ge v5, v2, :cond_0

    .line 43
    invoke-virtual/range {p2 .. p2}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/OperandManager;->nextCaseValues()I

    move-result v6

    aput v6, v4, v5

    .line 42
    add-int/lit8 v5, v5, 0x1

    goto :goto_0

    .line 45
    .end local v5    # "index":I
    :cond_0
    new-array v5, v2, [I

    .line 46
    .local v5, "case_pcs":[I
    const/4 v6, 0x0

    .local v6, "index":I
    :goto_1
    if-ge v6, v2, :cond_1

    .line 47
    invoke-virtual/range {p2 .. p2}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/OperandManager;->nextLabel()I

    move-result v7

    aput v7, v5, v6

    .line 46
    add-int/lit8 v6, v6, 0x1

    goto :goto_1

    .line 50
    .end local v6    # "index":I
    :cond_1
    add-int/lit8 v6, v2, 0x1

    new-array v6, v6, [I

    .line 51
    .local v6, "labelsArray":[I
    const/4 v7, 0x0

    aput v3, v6, v7

    .line 52
    const/4 v8, 0x1

    .local v8, "index":I
    :goto_2
    add-int/lit8 v9, v2, 0x1

    if-ge v8, v9, :cond_2

    .line 53
    add-int/lit8 v9, v8, -0x1

    aget v9, v5, v9

    aput v9, v6, v8

    .line 52
    add-int/lit8 v8, v8, 0x1

    goto :goto_2

    .line 55
    .end local v8    # "index":I
    :cond_2
    invoke-virtual {v1, v6}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/ByteCode;->setByteCodeTargets([I)V

    .line 69
    rem-int/lit8 v8, p3, 0x4

    rsub-int/lit8 v8, v8, 0x3

    .line 70
    .local v8, "padLength":I
    add-int/lit8 v9, v8, 0x1

    add-int/lit8 v9, v9, 0x4

    add-int/lit8 v9, v9, 0x4

    array-length v10, v4

    mul-int/lit8 v10, v10, 0x4

    add-int/2addr v9, v10

    array-length v10, v5

    mul-int/lit8 v10, v10, 0x4

    add-int/2addr v9, v10

    .line 74
    .local v9, "rewriteSize":I
    new-array v10, v9, [I

    .line 75
    .local v10, "newRewrite":[I
    const/4 v11, 0x0

    .line 79
    .local v11, "rewriteIndex":I
    add-int/lit8 v12, v11, 0x1

    .end local v11    # "rewriteIndex":I
    .local v12, "rewriteIndex":I
    invoke-virtual/range {p1 .. p1}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/ByteCode;->getOpcode()I

    move-result v13

    aput v13, v10, v11

    .line 82
    const/4 v11, 0x0

    .local v11, "index":I
    :goto_3
    if-ge v11, v8, :cond_3

    .line 83
    add-int/lit8 v13, v12, 0x1

    .end local v12    # "rewriteIndex":I
    .local v13, "rewriteIndex":I
    aput v7, v10, v12

    .line 82
    add-int/lit8 v11, v11, 0x1

    move v12, v13

    goto :goto_3

    .line 88
    .end local v11    # "index":I
    .end local v13    # "rewriteIndex":I
    .restart local v12    # "rewriteIndex":I
    :cond_3
    add-int/lit8 v7, v12, 0x1

    .end local v12    # "rewriteIndex":I
    .local v7, "rewriteIndex":I
    const/4 v11, -0x1

    aput v11, v10, v12

    .line 89
    add-int/lit8 v12, v7, 0x1

    .end local v7    # "rewriteIndex":I
    .restart local v12    # "rewriteIndex":I
    aput v11, v10, v7

    .line 90
    add-int/lit8 v7, v12, 0x1

    .end local v12    # "rewriteIndex":I
    .restart local v7    # "rewriteIndex":I
    aput v11, v10, v12

    .line 91
    add-int/lit8 v12, v7, 0x1

    .end local v7    # "rewriteIndex":I
    .restart local v12    # "rewriteIndex":I
    aput v11, v10, v7

    .line 94
    move v7, v12

    .line 95
    .local v7, "npairsIndex":I
    array-length v13, v4

    invoke-virtual {p0, v13, v7, v10}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/LookupSwitchForm;->setRewrite4Bytes(II[I)V

    .line 96
    add-int/lit8 v12, v12, 0x4

    .line 101
    const/4 v13, 0x0

    .local v13, "index":I
    :goto_4
    array-length v14, v4

    if-ge v13, v14, :cond_4

    .line 103
    aget v14, v4, v13

    invoke-virtual {p0, v14, v12, v10}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/LookupSwitchForm;->setRewrite4Bytes(II[I)V

    .line 104
    add-int/lit8 v12, v12, 0x4

    .line 106
    add-int/lit8 v14, v12, 0x1

    .end local v12    # "rewriteIndex":I
    .local v14, "rewriteIndex":I
    aput v11, v10, v12

    .line 107
    add-int/lit8 v12, v14, 0x1

    .end local v14    # "rewriteIndex":I
    .restart local v12    # "rewriteIndex":I
    aput v11, v10, v14

    .line 108
    add-int/lit8 v14, v12, 0x1

    .end local v12    # "rewriteIndex":I
    .restart local v14    # "rewriteIndex":I
    aput v11, v10, v12

    .line 109
    add-int/lit8 v12, v14, 0x1

    .end local v14    # "rewriteIndex":I
    .restart local v12    # "rewriteIndex":I
    aput v11, v10, v14

    .line 101
    add-int/lit8 v13, v13, 0x1

    goto :goto_4

    .line 111
    .end local v13    # "index":I
    :cond_4
    invoke-virtual {v1, v10}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/ByteCode;->setRewrite([I)V

    .line 112
    return-void
.end method
