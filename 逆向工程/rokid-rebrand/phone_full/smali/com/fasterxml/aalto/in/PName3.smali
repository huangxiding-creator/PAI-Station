.class public final Lcom/fasterxml/aalto/in/PName3;
.super Lcom/fasterxml/aalto/in/ByteBasedPName;
.source "PName3.java"


# instance fields
.field final mQuad1:I

.field final mQuad2:I

.field final mQuad3:I


# direct methods
.method public constructor <init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;IIII)V
    .locals 0
    .param p1, "pname"    # Ljava/lang/String;
    .param p2, "prefix"    # Ljava/lang/String;
    .param p3, "ln"    # Ljava/lang/String;
    .param p4, "hash"    # I
    .param p5, "q1"    # I
    .param p6, "q2"    # I
    .param p7, "q3"    # I

    .line 29
    invoke-direct {p0, p1, p2, p3, p4}, Lcom/fasterxml/aalto/in/ByteBasedPName;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;I)V

    .line 30
    iput p5, p0, Lcom/fasterxml/aalto/in/PName3;->mQuad1:I

    .line 31
    iput p6, p0, Lcom/fasterxml/aalto/in/PName3;->mQuad2:I

    .line 32
    iput p7, p0, Lcom/fasterxml/aalto/in/PName3;->mQuad3:I

    .line 33
    return-void
.end method

.method constructor <init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;I[I)V
    .locals 1
    .param p1, "pname"    # Ljava/lang/String;
    .param p2, "prefix"    # Ljava/lang/String;
    .param p3, "ln"    # Ljava/lang/String;
    .param p4, "hash"    # I
    .param p5, "quads"    # [I

    .line 21
    invoke-direct {p0, p1, p2, p3, p4}, Lcom/fasterxml/aalto/in/ByteBasedPName;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;I)V

    .line 22
    const/4 v0, 0x0

    aget v0, p5, v0

    iput v0, p0, Lcom/fasterxml/aalto/in/PName3;->mQuad1:I

    .line 23
    const/4 v0, 0x1

    aget v0, p5, v0

    iput v0, p0, Lcom/fasterxml/aalto/in/PName3;->mQuad2:I

    .line 24
    const/4 v0, 0x2

    aget v0, p5, v0

    iput v0, p0, Lcom/fasterxml/aalto/in/PName3;->mQuad3:I

    .line 25
    return-void
.end method


# virtual methods
.method public createBoundName(Lcom/fasterxml/aalto/in/NsBinding;)Lcom/fasterxml/aalto/in/PName;
    .locals 9
    .param p1, "nsb"    # Lcom/fasterxml/aalto/in/NsBinding;

    .line 38
    new-instance v8, Lcom/fasterxml/aalto/in/PName3;

    iget-object v1, p0, Lcom/fasterxml/aalto/in/PName3;->_prefixedName:Ljava/lang/String;

    iget-object v2, p0, Lcom/fasterxml/aalto/in/PName3;->_prefix:Ljava/lang/String;

    iget-object v3, p0, Lcom/fasterxml/aalto/in/PName3;->_localName:Ljava/lang/String;

    iget v4, p0, Lcom/fasterxml/aalto/in/PName3;->mHash:I

    iget v5, p0, Lcom/fasterxml/aalto/in/PName3;->mQuad1:I

    iget v6, p0, Lcom/fasterxml/aalto/in/PName3;->mQuad2:I

    iget v7, p0, Lcom/fasterxml/aalto/in/PName3;->mQuad3:I

    move-object v0, v8

    invoke-direct/range {v0 .. v7}, Lcom/fasterxml/aalto/in/PName3;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;IIII)V

    .line 40
    .local v0, "newName":Lcom/fasterxml/aalto/in/PName3;
    iput-object p1, v0, Lcom/fasterxml/aalto/in/PName3;->_namespaceBinding:Lcom/fasterxml/aalto/in/NsBinding;

    .line 41
    return-object v0
.end method

.method public equals(II)Z
    .locals 1
    .param p1, "quad1"    # I
    .param p2, "quad2"    # I

    .line 47
    const/4 v0, 0x0

    return v0
.end method

.method public equals([II)Z
    .locals 4
    .param p1, "quads"    # [I
    .param p2, "qlen"    # I

    .line 53
    const/4 v0, 0x3

    const/4 v1, 0x0

    if-ne p2, v0, :cond_0

    aget v0, p1, v1

    iget v2, p0, Lcom/fasterxml/aalto/in/PName3;->mQuad1:I

    if-ne v0, v2, :cond_0

    const/4 v0, 0x1

    aget v2, p1, v0

    iget v3, p0, Lcom/fasterxml/aalto/in/PName3;->mQuad2:I

    if-ne v2, v3, :cond_0

    const/4 v2, 0x2

    aget v2, p1, v2

    iget v3, p0, Lcom/fasterxml/aalto/in/PName3;->mQuad3:I

    if-ne v2, v3, :cond_0

    move v1, v0

    :cond_0
    return v1
.end method

.method public getFirstQuad()I
    .locals 1

    .line 75
    iget v0, p0, Lcom/fasterxml/aalto/in/PName3;->mQuad1:I

    return v0
.end method

.method public getLastQuad()I
    .locals 1

    .line 80
    iget v0, p0, Lcom/fasterxml/aalto/in/PName3;->mQuad3:I

    return v0
.end method

.method public getQuad(I)I
    .locals 1
    .param p1, "index"    # I

    .line 86
    const/4 v0, 0x2

    if-ge p1, v0, :cond_1

    .line 87
    if-nez p1, :cond_0

    iget v0, p0, Lcom/fasterxml/aalto/in/PName3;->mQuad1:I

    goto :goto_0

    :cond_0
    iget v0, p0, Lcom/fasterxml/aalto/in/PName3;->mQuad2:I

    :goto_0
    return v0

    .line 90
    :cond_1
    iget v0, p0, Lcom/fasterxml/aalto/in/PName3;->mQuad3:I

    return v0
.end method

.method public hashEquals(III)Z
    .locals 1
    .param p1, "h"    # I
    .param p2, "quad1"    # I
    .param p3, "quad2"    # I

    .line 62
    const/4 v0, 0x0

    return v0
.end method

.method public hashEquals(I[II)Z
    .locals 4
    .param p1, "h"    # I
    .param p2, "quads"    # [I
    .param p3, "qlen"    # I

    .line 67
    iget v0, p0, Lcom/fasterxml/aalto/in/PName3;->mHash:I

    const/4 v1, 0x0

    if-ne p1, v0, :cond_0

    const/4 v0, 0x3

    if-ne p3, v0, :cond_0

    aget v0, p2, v1

    iget v2, p0, Lcom/fasterxml/aalto/in/PName3;->mQuad1:I

    if-ne v0, v2, :cond_0

    const/4 v0, 0x1

    aget v2, p2, v0

    iget v3, p0, Lcom/fasterxml/aalto/in/PName3;->mQuad2:I

    if-ne v2, v3, :cond_0

    const/4 v2, 0x2

    aget v2, p2, v2

    iget v3, p0, Lcom/fasterxml/aalto/in/PName3;->mQuad3:I

    if-ne v2, v3, :cond_0

    move v1, v0

    :cond_0
    return v1
.end method

.method public sizeInQuads()I
    .locals 1

    .line 94
    const/4 v0, 0x3

    return v0
.end method
