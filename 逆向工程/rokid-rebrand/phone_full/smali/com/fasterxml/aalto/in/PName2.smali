.class public final Lcom/fasterxml/aalto/in/PName2;
.super Lcom/fasterxml/aalto/in/ByteBasedPName;
.source "PName2.java"


# instance fields
.field final mQuad1:I

.field final mQuad2:I


# direct methods
.method public constructor <init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;III)V
    .locals 0
    .param p1, "pname"    # Ljava/lang/String;
    .param p2, "prefix"    # Ljava/lang/String;
    .param p3, "ln"    # Ljava/lang/String;
    .param p4, "hash"    # I
    .param p5, "quad1"    # I
    .param p6, "quad2"    # I

    .line 36
    invoke-direct {p0, p1, p2, p3, p4}, Lcom/fasterxml/aalto/in/ByteBasedPName;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;I)V

    .line 37
    iput p5, p0, Lcom/fasterxml/aalto/in/PName2;->mQuad1:I

    .line 38
    iput p6, p0, Lcom/fasterxml/aalto/in/PName2;->mQuad2:I

    .line 39
    return-void
.end method


# virtual methods
.method public createBoundName(Lcom/fasterxml/aalto/in/NsBinding;)Lcom/fasterxml/aalto/in/PName;
    .locals 8
    .param p1, "nsb"    # Lcom/fasterxml/aalto/in/NsBinding;

    .line 44
    new-instance v7, Lcom/fasterxml/aalto/in/PName2;

    iget-object v1, p0, Lcom/fasterxml/aalto/in/PName2;->_prefixedName:Ljava/lang/String;

    iget-object v2, p0, Lcom/fasterxml/aalto/in/PName2;->_prefix:Ljava/lang/String;

    iget-object v3, p0, Lcom/fasterxml/aalto/in/PName2;->_localName:Ljava/lang/String;

    iget v4, p0, Lcom/fasterxml/aalto/in/PName2;->mHash:I

    iget v5, p0, Lcom/fasterxml/aalto/in/PName2;->mQuad1:I

    iget v6, p0, Lcom/fasterxml/aalto/in/PName2;->mQuad2:I

    move-object v0, v7

    invoke-direct/range {v0 .. v6}, Lcom/fasterxml/aalto/in/PName2;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;III)V

    .line 46
    .local v0, "newName":Lcom/fasterxml/aalto/in/PName2;
    iput-object p1, v0, Lcom/fasterxml/aalto/in/PName2;->_namespaceBinding:Lcom/fasterxml/aalto/in/NsBinding;

    .line 47
    return-object v0
.end method

.method public equals(II)Z
    .locals 1
    .param p1, "quad1"    # I
    .param p2, "quad2"    # I

    .line 52
    iget v0, p0, Lcom/fasterxml/aalto/in/PName2;->mQuad1:I

    if-ne p1, v0, :cond_0

    iget v0, p0, Lcom/fasterxml/aalto/in/PName2;->mQuad2:I

    if-ne p2, v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method public equals([II)Z
    .locals 4
    .param p1, "quads"    # [I
    .param p2, "qlen"    # I

    .line 57
    const/4 v0, 0x2

    const/4 v1, 0x0

    if-ne p2, v0, :cond_0

    aget v0, p1, v1

    iget v2, p0, Lcom/fasterxml/aalto/in/PName2;->mQuad1:I

    if-ne v0, v2, :cond_0

    const/4 v0, 0x1

    aget v2, p1, v0

    iget v3, p0, Lcom/fasterxml/aalto/in/PName2;->mQuad2:I

    if-ne v2, v3, :cond_0

    move v1, v0

    :cond_0
    return v1
.end method

.method public getFirstQuad()I
    .locals 1

    .line 74
    iget v0, p0, Lcom/fasterxml/aalto/in/PName2;->mQuad1:I

    return v0
.end method

.method public getLastQuad()I
    .locals 1

    .line 79
    iget v0, p0, Lcom/fasterxml/aalto/in/PName2;->mQuad2:I

    return v0
.end method

.method public getQuad(I)I
    .locals 1
    .param p1, "index"    # I

    .line 84
    if-nez p1, :cond_0

    iget v0, p0, Lcom/fasterxml/aalto/in/PName2;->mQuad1:I

    goto :goto_0

    :cond_0
    iget v0, p0, Lcom/fasterxml/aalto/in/PName2;->mQuad2:I

    :goto_0
    return v0
.end method

.method public hashEquals(III)Z
    .locals 1
    .param p1, "h"    # I
    .param p2, "quad1"    # I
    .param p3, "quad2"    # I

    .line 63
    iget v0, p0, Lcom/fasterxml/aalto/in/PName2;->mHash:I

    if-ne p1, v0, :cond_0

    iget v0, p0, Lcom/fasterxml/aalto/in/PName2;->mQuad1:I

    if-ne p2, v0, :cond_0

    iget v0, p0, Lcom/fasterxml/aalto/in/PName2;->mQuad2:I

    if-ne p3, v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method public hashEquals(I[II)Z
    .locals 4
    .param p1, "h"    # I
    .param p2, "quads"    # [I
    .param p3, "qlen"    # I

    .line 68
    iget v0, p0, Lcom/fasterxml/aalto/in/PName2;->mHash:I

    const/4 v1, 0x0

    if-ne p1, v0, :cond_0

    const/4 v0, 0x2

    if-ne p3, v0, :cond_0

    aget v0, p2, v1

    iget v2, p0, Lcom/fasterxml/aalto/in/PName2;->mQuad1:I

    if-ne v0, v2, :cond_0

    const/4 v0, 0x1

    aget v2, p2, v0

    iget v3, p0, Lcom/fasterxml/aalto/in/PName2;->mQuad2:I

    if-ne v2, v3, :cond_0

    move v1, v0

    :cond_0
    return v1
.end method

.method public sizeInQuads()I
    .locals 1

    .line 88
    const/4 v0, 0x2

    return v0
.end method
