.class public abstract Lorg/codehaus/stax2/io/Stax2ReferentialSource;
.super Lorg/codehaus/stax2/io/Stax2Source;
.source "Stax2ReferentialSource.java"


# direct methods
.method protected constructor <init>()V
    .locals 0

    .line 22
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

.method public abstract getReference()Ljava/net/URL;
.end method

.method public getSystemId()Ljava/lang/String;
    .locals 2

    .line 51
    invoke-super {p0}, Lorg/codehaus/stax2/io/Stax2Source;->getSystemId()Ljava/lang/String;

    move-result-object v0

    .line 52
    .local v0, "sysId":Ljava/lang/String;
    if-nez v0, :cond_0

    .line 53
    invoke-virtual {p0}, Lorg/codehaus/stax2/io/Stax2ReferentialSource;->getReference()Ljava/net/URL;

    move-result-object v1

    invoke-virtual {v1}, Ljava/net/URL;->toExternalForm()Ljava/lang/String;

    move-result-object v0

    .line 55
    :cond_0
    return-object v0
.end method
