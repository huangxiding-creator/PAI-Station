.class public final Lcom/fasterxml/aalto/in/PName1;
.super Lcom/fasterxml/aalto/in/ByteBasedPName;
.source "PName1.java"


# instance fields
.field final mQuad:I


# direct methods
.method public constructor <init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;II)V
    .locals 0
    .param p1, "pname"    # Ljava/lang/String;
    .param p2, "prefix"    # Ljava/lang/String;
    .param p3, "ln"    # Ljava/lang/String;
    .param p4, "hash"    # I
    .param p5, "quad"    # I

    .line 34
    invoke-direct {p0, p1, p2, p3, p4}, Lcom/fasterxml/aalto/in/ByteBasedPName;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;I)V

    .line 35
    iput p5, p0, Lcom/fasterxml/aalto/in/PName1;->mQuad:I

    .line 36
    return-void
.end method


# virtual methods
.method public createBoundName(Lcom/fasterxml/aalto/in/NsBinding;)Lcom/fasterxml/aalto/in/PName;
    .locals 7
    .param p1, "nsb"    # Lcom/fasterxml/aalto/in/NsBinding;

    .line 41
    new-instance v6, Lcom/fasterxml/aalto/in/PName1;

    iget-object v1, p0, Lcom/fasterxml/aalto/in/PName1;->_prefixedName:Ljava/lang/String;

    iget-object v2, p0, Lcom/fasterxml/aalto/in/PName1;->_prefix:Ljava/lang/String;

    iget-object v3, p0, Lcom/fasterxml/aalto/in/PName1;->_localName:Ljava/lang/String;

    iget v4, p0, Lcom/fasterxml/aalto/in/PName1;->mHash:I

    iget v5, p0, Lcom/fasterxml/aalto/in/PName1;->mQuad:I

    move-object v0, v6

    invoke-direct/range {v0 .. v5}, Lcom/fasterxml/aalto/in/PName1;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;II)V

    .line 43
    .local v0, "newName":Lcom/fasterxml/aalto/in/PName1;
    iput-object p1, v0, Lcom/fasterxml/aalto/in/PName1;->_namespaceBinding:Lcom/fasterxml/aalto/in/NsBinding;

    .line 44
    return-object v0
.end method

.method public equals(II)Z
    .locals 1
    .param p1, "quad1"    # I
    .param p2, "quad2"    # I

    .line 49
    iget v0, p0, Lcom/fasterxml/aalto/in/PName1;->mQuad:I

    if-ne p1, v0, :cond_0

    if-nez p2, :cond_0

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

    .line 54
    const/4 v0, 0x0

    const/4 v1, 0x1

    if-ne p2, v1, :cond_0

    aget v2, p1, v0

    iget v3, p0, Lcom/fasterxml/aalto/in/PName1;->mQuad:I

    if-ne v2, v3, :cond_0

    move v0, v1

    :cond_0
    return v0
.end method

.method public getFirstQuad()I
    .locals 1

    .line 69
    iget v0, p0, Lcom/fasterxml/aalto/in/PName1;->mQuad:I

    return v0
.end method

.method public final getLastQuad()I
    .locals 1

    .line 74
    iget v0, p0, Lcom/fasterxml/aalto/in/PName1;->mQuad:I

    return v0
.end method

.method public getQuad(I)I
    .locals 1
    .param p1, "index"    # I

    .line 79
    if-nez p1, :cond_0

    iget v0, p0, Lcom/fasterxml/aalto/in/PName1;->mQuad:I

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method public hashEquals(III)Z
    .locals 1
    .param p1, "h"    # I
    .param p2, "quad1"    # I
    .param p3, "quad2"    # I

    .line 59
    iget v0, p0, Lcom/fasterxml/aalto/in/PName1;->mHash:I

    if-ne p1, v0, :cond_0

    iget v0, p0, Lcom/fasterxml/aalto/in/PName1;->mQuad:I

    if-ne p2, v0, :cond_0

    if-nez p3, :cond_0

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

    .line 64
    iget v0, p0, Lcom/fasterxml/aalto/in/PName1;->mHash:I

    const/4 v1, 0x0

    if-ne p1, v0, :cond_0

    const/4 v0, 0x1

    if-ne p3, v0, :cond_0

    aget v2, p2, v1

    iget v3, p0, Lcom/fasterxml/aalto/in/PName1;->mQuad:I

    if-ne v2, v3, :cond_0

    move v1, v0

    :cond_0
    return v1
.end method

.method public sizeInQuads()I
    .locals 1

    .line 83
    const/4 v0, 0x1

    return v0
.end method
