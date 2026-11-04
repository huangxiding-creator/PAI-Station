.class public final Lcom/fasterxml/aalto/in/PNameN;
.super Lcom/fasterxml/aalto/in/ByteBasedPName;
.source "PNameN.java"


# instance fields
.field final mQuadLen:I

.field final mQuads:[I


# direct methods
.method constructor <init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;I[II)V
    .locals 0
    .param p1, "pname"    # Ljava/lang/String;
    .param p2, "prefix"    # Ljava/lang/String;
    .param p3, "ln"    # Ljava/lang/String;
    .param p4, "hash"    # I
    .param p5, "quads"    # [I
    .param p6, "quadLen"    # I

    .line 35
    invoke-direct {p0, p1, p2, p3, p4}, Lcom/fasterxml/aalto/in/ByteBasedPName;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;I)V

    .line 36
    iput-object p5, p0, Lcom/fasterxml/aalto/in/PNameN;->mQuads:[I

    .line 37
    iput p6, p0, Lcom/fasterxml/aalto/in/PNameN;->mQuadLen:I

    .line 38
    return-void
.end method


# virtual methods
.method public createBoundName(Lcom/fasterxml/aalto/in/NsBinding;)Lcom/fasterxml/aalto/in/PName;
    .locals 8
    .param p1, "nsb"    # Lcom/fasterxml/aalto/in/NsBinding;

    .line 43
    new-instance v7, Lcom/fasterxml/aalto/in/PNameN;

    iget-object v1, p0, Lcom/fasterxml/aalto/in/PNameN;->_prefixedName:Ljava/lang/String;

    iget-object v2, p0, Lcom/fasterxml/aalto/in/PNameN;->_prefix:Ljava/lang/String;

    iget-object v3, p0, Lcom/fasterxml/aalto/in/PNameN;->_localName:Ljava/lang/String;

    iget v4, p0, Lcom/fasterxml/aalto/in/PNameN;->mHash:I

    iget-object v5, p0, Lcom/fasterxml/aalto/in/PNameN;->mQuads:[I

    iget v6, p0, Lcom/fasterxml/aalto/in/PNameN;->mQuadLen:I

    move-object v0, v7

    invoke-direct/range {v0 .. v6}, Lcom/fasterxml/aalto/in/PNameN;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;I[II)V

    .line 45
    .local v0, "newName":Lcom/fasterxml/aalto/in/PNameN;
    iput-object p1, v0, Lcom/fasterxml/aalto/in/PNameN;->_namespaceBinding:Lcom/fasterxml/aalto/in/NsBinding;

    .line 46
    return-object v0
.end method

.method public equals(II)Z
    .locals 3
    .param p1, "quad1"    # I
    .param p2, "quad2"    # I

    .line 53
    iget v0, p0, Lcom/fasterxml/aalto/in/PNameN;->mQuadLen:I

    const/4 v1, 0x3

    const/4 v2, 0x0

    if-ge v0, v1, :cond_3

    .line 54
    iget v0, p0, Lcom/fasterxml/aalto/in/PNameN;->mQuadLen:I

    const/4 v1, 0x1

    if-ne v0, v1, :cond_1

    .line 55
    iget-object v0, p0, Lcom/fasterxml/aalto/in/PNameN;->mQuads:[I

    aget v0, v0, v2

    if-ne v0, p1, :cond_0

    if-nez p2, :cond_0

    move v2, v1

    :cond_0
    return v2

    .line 57
    :cond_1
    iget-object v0, p0, Lcom/fasterxml/aalto/in/PNameN;->mQuads:[I

    aget v0, v0, v2

    if-ne v0, p1, :cond_2

    iget-object v0, p0, Lcom/fasterxml/aalto/in/PNameN;->mQuads:[I

    aget v0, v0, v1

    if-ne v0, p2, :cond_2

    move v2, v1

    :cond_2
    return v2

    .line 59
    :cond_3
    return v2
.end method

.method public equals([II)Z
    .locals 4
    .param p1, "quads"    # [I
    .param p2, "qlen"    # I

    .line 65
    iget v0, p0, Lcom/fasterxml/aalto/in/PNameN;->mQuadLen:I

    const/4 v1, 0x0

    if-ne p2, v0, :cond_2

    .line 66
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_0
    if-ge v0, p2, :cond_1

    .line 67
    aget v2, p1, v0

    iget-object v3, p0, Lcom/fasterxml/aalto/in/PNameN;->mQuads:[I

    aget v3, v3, v0

    if-eq v2, v3, :cond_0

    .line 68
    return v1

    .line 66
    :cond_0
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 71
    .end local v0    # "i":I
    :cond_1
    const/4 v0, 0x1

    return v0

    .line 73
    :cond_2
    return v1
.end method

.method public getFirstQuad()I
    .locals 2

    .line 102
    iget-object v0, p0, Lcom/fasterxml/aalto/in/PNameN;->mQuads:[I

    const/4 v1, 0x0

    aget v0, v0, v1

    return v0
.end method

.method public getLastQuad()I
    .locals 2

    .line 107
    iget-object v0, p0, Lcom/fasterxml/aalto/in/PNameN;->mQuads:[I

    iget v1, p0, Lcom/fasterxml/aalto/in/PNameN;->mQuadLen:I

    add-int/lit8 v1, v1, -0x1

    aget v0, v0, v1

    return v0
.end method

.method public getQuad(I)I
    .locals 1
    .param p1, "index"    # I

    .line 112
    iget v0, p0, Lcom/fasterxml/aalto/in/PNameN;->mQuadLen:I

    if-ge p1, v0, :cond_0

    iget-object v0, p0, Lcom/fasterxml/aalto/in/PNameN;->mQuads:[I

    aget v0, v0, p1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method public hashEquals(III)Z
    .locals 3
    .param p1, "h"    # I
    .param p2, "quad1"    # I
    .param p3, "quad2"    # I

    .line 78
    iget v0, p0, Lcom/fasterxml/aalto/in/PNameN;->mHash:I

    const/4 v1, 0x0

    if-ne p1, v0, :cond_3

    iget v0, p0, Lcom/fasterxml/aalto/in/PNameN;->mQuadLen:I

    const/4 v2, 0x3

    if-ge v0, v2, :cond_3

    .line 79
    iget v0, p0, Lcom/fasterxml/aalto/in/PNameN;->mQuadLen:I

    const/4 v2, 0x1

    if-ne v0, v2, :cond_1

    .line 80
    iget-object v0, p0, Lcom/fasterxml/aalto/in/PNameN;->mQuads:[I

    aget v0, v0, v1

    if-ne v0, p2, :cond_0

    if-nez p3, :cond_0

    move v1, v2

    :cond_0
    return v1

    .line 82
    :cond_1
    iget-object v0, p0, Lcom/fasterxml/aalto/in/PNameN;->mQuads:[I

    aget v0, v0, v1

    if-ne v0, p2, :cond_2

    iget-object v0, p0, Lcom/fasterxml/aalto/in/PNameN;->mQuads:[I

    aget v0, v0, v2

    if-ne v0, p3, :cond_2

    move v1, v2

    :cond_2
    return v1

    .line 84
    :cond_3
    return v1
.end method

.method public hashEquals(I[II)Z
    .locals 4
    .param p1, "h"    # I
    .param p2, "quads"    # [I
    .param p3, "qlen"    # I

    .line 89
    iget v0, p0, Lcom/fasterxml/aalto/in/PNameN;->mHash:I

    const/4 v1, 0x0

    if-ne p1, v0, :cond_2

    iget v0, p0, Lcom/fasterxml/aalto/in/PNameN;->mQuadLen:I

    if-ne p3, v0, :cond_2

    .line 90
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_0
    if-ge v0, p3, :cond_1

    .line 91
    aget v2, p2, v0

    iget-object v3, p0, Lcom/fasterxml/aalto/in/PNameN;->mQuads:[I

    aget v3, v3, v0

    if-eq v2, v3, :cond_0

    .line 92
    return v1

    .line 90
    :cond_0
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 95
    .end local v0    # "i":I
    :cond_1
    const/4 v0, 0x1

    return v0

    .line 97
    :cond_2
    return v1
.end method

.method public sizeInQuads()I
    .locals 1

    .line 116
    iget v0, p0, Lcom/fasterxml/aalto/in/PNameN;->mQuadLen:I

    return v0
.end method
