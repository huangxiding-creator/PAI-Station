.class public Lorg/codehaus/stax2/io/Stax2CharArraySource;
.super Lorg/codehaus/stax2/io/Stax2BlockSource;
.source "Stax2CharArraySource.java"


# instance fields
.field final mBuffer:[C

.field final mLength:I

.field final mStart:I


# direct methods
.method public constructor <init>([CII)V
    .locals 0
    .param p1, "buf"    # [C
    .param p2, "start"    # I
    .param p3, "len"    # I

    .line 24
    invoke-direct {p0}, Lorg/codehaus/stax2/io/Stax2BlockSource;-><init>()V

    .line 25
    iput-object p1, p0, Lorg/codehaus/stax2/io/Stax2CharArraySource;->mBuffer:[C

    .line 26
    iput p2, p0, Lorg/codehaus/stax2/io/Stax2CharArraySource;->mStart:I

    .line 27
    iput p3, p0, Lorg/codehaus/stax2/io/Stax2CharArraySource;->mLength:I

    .line 28
    return-void
.end method


# virtual methods
.method public constructInputStream()Ljava/io/InputStream;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 48
    const/4 v0, 0x0

    return-object v0
.end method

.method public constructReader()Ljava/io/Reader;
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 39
    new-instance v0, Ljava/io/CharArrayReader;

    iget-object v1, p0, Lorg/codehaus/stax2/io/Stax2CharArraySource;->mBuffer:[C

    iget v2, p0, Lorg/codehaus/stax2/io/Stax2CharArraySource;->mStart:I

    iget v3, p0, Lorg/codehaus/stax2/io/Stax2CharArraySource;->mLength:I

    invoke-direct {v0, v1, v2, v3}, Ljava/io/CharArrayReader;-><init>([CII)V

    return-object v0
.end method

.method public getBuffer()[C
    .locals 1

    .line 58
    iget-object v0, p0, Lorg/codehaus/stax2/io/Stax2CharArraySource;->mBuffer:[C

    return-object v0
.end method

.method public getBufferLength()I
    .locals 1

    .line 66
    iget v0, p0, Lorg/codehaus/stax2/io/Stax2CharArraySource;->mLength:I

    return v0
.end method

.method public getBufferStart()I
    .locals 1

    .line 62
    iget v0, p0, Lorg/codehaus/stax2/io/Stax2CharArraySource;->mStart:I

    return v0
.end method
