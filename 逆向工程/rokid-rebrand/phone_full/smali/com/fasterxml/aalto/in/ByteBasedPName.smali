.class public abstract Lcom/fasterxml/aalto/in/ByteBasedPName;
.super Lcom/fasterxml/aalto/in/PName;
.source "ByteBasedPName.java"


# instance fields
.field protected final mHash:I


# direct methods
.method protected constructor <init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;I)V
    .locals 0
    .param p1, "pname"    # Ljava/lang/String;
    .param p2, "prefix"    # Ljava/lang/String;
    .param p3, "ln"    # Ljava/lang/String;
    .param p4, "hash"    # I

    .line 38
    invoke-direct {p0, p1, p2, p3}, Lcom/fasterxml/aalto/in/PName;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 39
    iput p4, p0, Lcom/fasterxml/aalto/in/ByteBasedPName;->mHash:I

    .line 40
    return-void
.end method


# virtual methods
.method public abstract equals(II)Z
.end method

.method public abstract equals([II)Z
.end method

.method public abstract getFirstQuad()I
.end method

.method public abstract getQuad(I)I
.end method

.method public hashCode()I
    .locals 1

    .line 81
    iget v0, p0, Lcom/fasterxml/aalto/in/ByteBasedPName;->mHash:I

    return v0
.end method

.method public abstract hashEquals(III)Z
.end method

.method public abstract hashEquals(I[II)Z
.end method

.method public abstract sizeInQuads()I
.end method
