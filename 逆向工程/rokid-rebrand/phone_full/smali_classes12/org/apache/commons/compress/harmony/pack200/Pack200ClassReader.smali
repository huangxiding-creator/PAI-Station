.class public Lorg/apache/commons/compress/harmony/pack200/Pack200ClassReader;
.super Lorg/objectweb/asm/ClassReader;
.source "Pack200ClassReader.java"


# instance fields
.field private anySyntheticAttributes:Z

.field private fileName:Ljava/lang/String;

.field private lastConstantHadWideIndex:Z

.field private lastUnsignedShort:I


# direct methods
.method public constructor <init>([B)V
    .locals 0
    .param p1, "b"    # [B

    .line 35
    invoke-direct {p0, p1}, Lorg/objectweb/asm/ClassReader;-><init>([B)V

    .line 36
    return-void
.end method


# virtual methods
.method public getFileName()Ljava/lang/String;
    .locals 1

    .line 79
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/pack200/Pack200ClassReader;->fileName:Ljava/lang/String;

    return-object v0
.end method

.method public hasSyntheticAttributes()Z
    .locals 1

    .line 71
    iget-boolean v0, p0, Lorg/apache/commons/compress/harmony/pack200/Pack200ClassReader;->anySyntheticAttributes:Z

    return v0
.end method

.method public lastConstantHadWideIndex()Z
    .locals 1

    .line 67
    iget-boolean v0, p0, Lorg/apache/commons/compress/harmony/pack200/Pack200ClassReader;->lastConstantHadWideIndex:Z

    return v0
.end method

.method public readConst(I[C)Ljava/lang/Object;
    .locals 1
    .param p1, "item"    # I
    .param p2, "buf"    # [C

    .line 53
    iget v0, p0, Lorg/apache/commons/compress/harmony/pack200/Pack200ClassReader;->lastUnsignedShort:I

    if-ne p1, v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    iput-boolean v0, p0, Lorg/apache/commons/compress/harmony/pack200/Pack200ClassReader;->lastConstantHadWideIndex:Z

    .line 54
    invoke-super {p0, p1, p2}, Lorg/objectweb/asm/ClassReader;->readConst(I[C)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public readUTF8(I[C)Ljava/lang/String;
    .locals 2
    .param p1, "arg0"    # I
    .param p2, "arg1"    # [C

    .line 59
    invoke-super {p0, p1, p2}, Lorg/objectweb/asm/ClassReader;->readUTF8(I[C)Ljava/lang/String;

    move-result-object v0

    .line 60
    .local v0, "utf8":Ljava/lang/String;
    iget-boolean v1, p0, Lorg/apache/commons/compress/harmony/pack200/Pack200ClassReader;->anySyntheticAttributes:Z

    if-nez v1, :cond_0

    const-string v1, "Synthetic"

    invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 61
    const/4 v1, 0x1

    iput-boolean v1, p0, Lorg/apache/commons/compress/harmony/pack200/Pack200ClassReader;->anySyntheticAttributes:Z

    .line 63
    :cond_0
    return-object v0
.end method

.method public readUnsignedShort(I)I
    .locals 3
    .param p1, "index"    # I

    .line 42
    invoke-super {p0, p1}, Lorg/objectweb/asm/ClassReader;->readUnsignedShort(I)I

    move-result v0

    .line 43
    .local v0, "unsignedShort":I
    iget-object v1, p0, Lorg/apache/commons/compress/harmony/pack200/Pack200ClassReader;->b:[B

    add-int/lit8 v2, p1, -0x1

    aget-byte v1, v1, v2

    const/16 v2, 0x13

    if-ne v1, v2, :cond_0

    .line 44
    iput v0, p0, Lorg/apache/commons/compress/harmony/pack200/Pack200ClassReader;->lastUnsignedShort:I

    goto :goto_0

    .line 46
    :cond_0
    const/16 v1, -0x8000

    iput v1, p0, Lorg/apache/commons/compress/harmony/pack200/Pack200ClassReader;->lastUnsignedShort:I

    .line 48
    :goto_0
    return v0
.end method

.method public setFileName(Ljava/lang/String;)V
    .locals 0
    .param p1, "name"    # Ljava/lang/String;

    .line 75
    iput-object p1, p0, Lorg/apache/commons/compress/harmony/pack200/Pack200ClassReader;->fileName:Ljava/lang/String;

    .line 76
    return-void
.end method
