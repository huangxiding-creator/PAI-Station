.class public Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPInterfaceMethodRef;
.super Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPRef;
.source "CPInterfaceMethodRef.java"


# instance fields
.field private cachedHashCode:I

.field private hashcodeComputed:Z


# direct methods
.method public constructor <init>(Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPClass;Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPNameAndType;I)V
    .locals 1
    .param p1, "className"    # Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPClass;
    .param p2, "descriptor"    # Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPNameAndType;
    .param p3, "globalIndex"    # I

    .line 22
    const/16 v0, 0xb

    invoke-direct {p0, v0, p1, p2, p3}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPRef;-><init>(BLorg/apache/commons/compress/harmony/unpack200/bytecode/CPClass;Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPNameAndType;I)V

    .line 23
    return-void
.end method

.method private generateHashCode()V
    .locals 4

    .line 39
    const/4 v0, 0x1

    iput-boolean v0, p0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPInterfaceMethodRef;->hashcodeComputed:Z

    .line 40
    const/16 v0, 0x1f

    .line 41
    .local v0, "PRIME":I
    const/4 v1, 0x1

    .line 42
    .local v1, "result":I
    mul-int/lit8 v2, v1, 0x1f

    iget-object v3, p0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPInterfaceMethodRef;->className:Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPClass;

    invoke-virtual {v3}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPClass;->hashCode()I

    move-result v3

    add-int/2addr v2, v3

    .line 43
    .end local v1    # "result":I
    .local v2, "result":I
    mul-int/lit8 v1, v2, 0x1f

    iget-object v3, p0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPInterfaceMethodRef;->nameAndType:Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPNameAndType;

    invoke-virtual {v3}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPNameAndType;->hashCode()I

    move-result v3

    add-int/2addr v1, v3

    .line 44
    .end local v2    # "result":I
    .restart local v1    # "result":I
    iput v1, p0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPInterfaceMethodRef;->cachedHashCode:I

    .line 45
    return-void
.end method


# virtual methods
.method public hashCode()I
    .locals 1

    .line 49
    iget-boolean v0, p0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPInterfaceMethodRef;->hashcodeComputed:Z

    if-nez v0, :cond_0

    .line 50
    invoke-direct {p0}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPInterfaceMethodRef;->generateHashCode()V

    .line 52
    :cond_0
    iget v0, p0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPInterfaceMethodRef;->cachedHashCode:I

    return v0
.end method

.method public invokeInterfaceCount()I
    .locals 1

    .line 32
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPInterfaceMethodRef;->nameAndType:Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPNameAndType;

    invoke-virtual {v0}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPNameAndType;->invokeInterfaceCount()I

    move-result v0

    return v0
.end method
