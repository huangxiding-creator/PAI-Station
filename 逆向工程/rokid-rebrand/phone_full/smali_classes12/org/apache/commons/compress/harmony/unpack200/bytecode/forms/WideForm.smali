.class public Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/WideForm;
.super Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/VariableInstructionForm;
.source "WideForm.java"


# direct methods
.method public constructor <init>(ILjava/lang/String;)V
    .locals 0
    .param p1, "opcode"    # I
    .param p2, "name"    # Ljava/lang/String;

    .line 29
    invoke-direct {p0, p1, p2}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/VariableInstructionForm;-><init>(ILjava/lang/String;)V

    .line 30
    return-void
.end method


# virtual methods
.method public setByteCodeOperands(Lorg/apache/commons/compress/harmony/unpack200/bytecode/ByteCode;Lorg/apache/commons/compress/harmony/unpack200/bytecode/OperandManager;I)V
    .locals 2
    .param p1, "byteCode"    # Lorg/apache/commons/compress/harmony/unpack200/bytecode/ByteCode;
    .param p2, "operandManager"    # Lorg/apache/commons/compress/harmony/unpack200/bytecode/OperandManager;
    .param p3, "codeLength"    # I

    .line 44
    invoke-virtual {p2}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/OperandManager;->nextWideByteCode()I

    move-result v0

    .line 45
    .local v0, "instruction":I
    const/16 v1, 0x84

    if-ne v0, v1, :cond_0

    .line 46
    invoke-virtual {p0, v0, p1, p2, p3}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/WideForm;->setByteCodeOperandsFormat2(ILorg/apache/commons/compress/harmony/unpack200/bytecode/ByteCode;Lorg/apache/commons/compress/harmony/unpack200/bytecode/OperandManager;I)V

    goto :goto_0

    .line 48
    :cond_0
    invoke-virtual {p0, v0, p1, p2, p3}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/WideForm;->setByteCodeOperandsFormat1(ILorg/apache/commons/compress/harmony/unpack200/bytecode/ByteCode;Lorg/apache/commons/compress/harmony/unpack200/bytecode/OperandManager;I)V

    .line 50
    :goto_0
    return-void
.end method

.method protected setByteCodeOperandsFormat1(ILorg/apache/commons/compress/harmony/unpack200/bytecode/ByteCode;Lorg/apache/commons/compress/harmony/unpack200/bytecode/OperandManager;I)V
    .locals 5
    .param p1, "instruction"    # I
    .param p2, "byteCode"    # Lorg/apache/commons/compress/harmony/unpack200/bytecode/ByteCode;
    .param p3, "operandManager"    # Lorg/apache/commons/compress/harmony/unpack200/bytecode/OperandManager;
    .param p4, "codeLength"    # I

    .line 71
    invoke-virtual {p3}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/OperandManager;->nextLocal()I

    move-result v0

    .line 79
    .local v0, "local":I
    const/4 v1, 0x4

    new-array v1, v1, [I

    .line 80
    .local v1, "newRewrite":[I
    const/4 v2, 0x0

    .line 84
    .local v2, "rewriteIndex":I
    add-int/lit8 v3, v2, 0x1

    .end local v2    # "rewriteIndex":I
    .local v3, "rewriteIndex":I
    invoke-virtual {p2}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/ByteCode;->getOpcode()I

    move-result v4

    aput v4, v1, v2

    .line 87
    add-int/lit8 v2, v3, 0x1

    .end local v3    # "rewriteIndex":I
    .restart local v2    # "rewriteIndex":I
    aput p1, v1, v3

    .line 90
    invoke-virtual {p0, v0, v2, v1}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/WideForm;->setRewrite2Bytes(II[I)V

    .line 91
    add-int/lit8 v2, v2, 0x2

    .line 93
    invoke-virtual {p2, v1}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/ByteCode;->setRewrite([I)V

    .line 94
    return-void
.end method

.method protected setByteCodeOperandsFormat2(ILorg/apache/commons/compress/harmony/unpack200/bytecode/ByteCode;Lorg/apache/commons/compress/harmony/unpack200/bytecode/OperandManager;I)V
    .locals 6
    .param p1, "instruction"    # I
    .param p2, "byteCode"    # Lorg/apache/commons/compress/harmony/unpack200/bytecode/ByteCode;
    .param p3, "operandManager"    # Lorg/apache/commons/compress/harmony/unpack200/bytecode/OperandManager;
    .param p4, "codeLength"    # I

    .line 108
    invoke-virtual {p3}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/OperandManager;->nextLocal()I

    move-result v0

    .line 109
    .local v0, "local":I
    invoke-virtual {p3}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/OperandManager;->nextShort()I

    move-result v1

    .line 117
    .local v1, "constWord":I
    const/4 v2, 0x6

    new-array v2, v2, [I

    .line 118
    .local v2, "newRewrite":[I
    const/4 v3, 0x0

    .line 122
    .local v3, "rewriteIndex":I
    add-int/lit8 v4, v3, 0x1

    .end local v3    # "rewriteIndex":I
    .local v4, "rewriteIndex":I
    invoke-virtual {p2}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/ByteCode;->getOpcode()I

    move-result v5

    aput v5, v2, v3

    .line 125
    add-int/lit8 v3, v4, 0x1

    .end local v4    # "rewriteIndex":I
    .restart local v3    # "rewriteIndex":I
    aput p1, v2, v4

    .line 128
    invoke-virtual {p0, v0, v3, v2}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/WideForm;->setRewrite2Bytes(II[I)V

    .line 129
    add-int/lit8 v3, v3, 0x2

    .line 132
    invoke-virtual {p0, v1, v3, v2}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/WideForm;->setRewrite2Bytes(II[I)V

    .line 133
    add-int/lit8 v3, v3, 0x2

    .line 136
    invoke-virtual {p2, v2}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/ByteCode;->setRewrite([I)V

    .line 137
    return-void
.end method
