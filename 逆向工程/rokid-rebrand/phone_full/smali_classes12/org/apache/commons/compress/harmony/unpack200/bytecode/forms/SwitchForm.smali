.class public abstract Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/SwitchForm;
.super Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/VariableInstructionForm;
.source "SwitchForm.java"


# direct methods
.method public constructor <init>(ILjava/lang/String;)V
    .locals 0
    .param p1, "opcode"    # I
    .param p2, "name"    # Ljava/lang/String;

    .line 25
    invoke-direct {p0, p1, p2}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/VariableInstructionForm;-><init>(ILjava/lang/String;)V

    .line 26
    return-void
.end method


# virtual methods
.method public fixUpByteCodeTargets(Lorg/apache/commons/compress/harmony/unpack200/bytecode/ByteCode;Lorg/apache/commons/compress/harmony/unpack200/bytecode/CodeAttribute;)V
    .locals 9
    .param p1, "byteCode"    # Lorg/apache/commons/compress/harmony/unpack200/bytecode/ByteCode;
    .param p2, "codeAttribute"    # Lorg/apache/commons/compress/harmony/unpack200/bytecode/CodeAttribute;

    .line 39
    invoke-virtual {p1}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/ByteCode;->getByteCodeTargets()[I

    move-result-object v0

    .line 40
    .local v0, "originalTargets":[I
    array-length v1, v0

    .line 41
    .local v1, "numberOfLabels":I
    new-array v2, v1, [I

    .line 43
    .local v2, "replacementTargets":[I
    invoke-virtual {p1}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/ByteCode;->getByteCodeIndex()I

    move-result v3

    .line 44
    .local v3, "sourceIndex":I
    iget-object v4, p2, Lorg/apache/commons/compress/harmony/unpack200/bytecode/CodeAttribute;->byteCodeOffsets:Ljava/util/List;

    invoke-interface {v4, v3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/lang/Integer;

    invoke-virtual {v4}, Ljava/lang/Integer;->intValue()I

    move-result v4

    .line 45
    .local v4, "sourceValue":I
    const/4 v5, 0x0

    .local v5, "index":I
    :goto_0
    if-ge v5, v1, :cond_0

    .line 46
    aget v6, v0, v5

    add-int/2addr v6, v3

    .line 47
    .local v6, "absoluteInstructionTargetIndex":I
    iget-object v7, p2, Lorg/apache/commons/compress/harmony/unpack200/bytecode/CodeAttribute;->byteCodeOffsets:Ljava/util/List;

    invoke-interface {v7, v6}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Ljava/lang/Integer;

    .line 48
    invoke-virtual {v7}, Ljava/lang/Integer;->intValue()I

    move-result v7

    .line 49
    .local v7, "targetValue":I
    sub-int v8, v7, v4

    aput v8, v2, v5

    .line 45
    .end local v6    # "absoluteInstructionTargetIndex":I
    .end local v7    # "targetValue":I
    add-int/lit8 v5, v5, 0x1

    goto :goto_0

    .line 51
    .end local v5    # "index":I
    :cond_0
    invoke-virtual {p1}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/ByteCode;->getRewrite()[I

    move-result-object v5

    .line 52
    .local v5, "rewriteArray":[I
    const/4 v6, 0x0

    .local v6, "index":I
    :goto_1
    if-ge v6, v1, :cond_1

    .line 53
    aget v7, v2, v6

    invoke-virtual {p0, v7, v5}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/forms/SwitchForm;->setRewrite4Bytes(I[I)V

    .line 52
    add-int/lit8 v6, v6, 0x1

    goto :goto_1

    .line 55
    .end local v6    # "index":I
    :cond_1
    return-void
.end method
