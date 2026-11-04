.class public abstract Lorg/codehaus/stax2/io/Stax2BlockSource;
.super Lorg/codehaus/stax2/io/Stax2Source;
.source "Stax2BlockSource.java"


# direct methods
.method protected constructor <init>()V
    .locals 0

    .line 19
    invoke-direct {p0}, Lorg/codehaus/stax2/io/Stax2Source;-><init>()V

    return-void
.end method


# virtual methods
.method public abstract constructInputStream()Ljava/io/InputStream;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation
.end method

.method public abstract constructReader()Ljava/io/Reader;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation
.end method

.method public getReference()Ljava/net/URL;
    .locals 1

    .line 34
    const/4 v0, 0x0

    return-object v0
.end method
