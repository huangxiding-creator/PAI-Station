.class public Lorg/codehaus/stax2/io/Stax2URLSource;
.super Lorg/codehaus/stax2/io/Stax2ReferentialSource;
.source "Stax2URLSource.java"


# instance fields
.field final mURL:Ljava/net/URL;


# direct methods
.method public constructor <init>(Ljava/net/URL;)V
    .locals 0
    .param p1, "url"    # Ljava/net/URL;

    .line 15
    invoke-direct {p0}, Lorg/codehaus/stax2/io/Stax2ReferentialSource;-><init>()V

    .line 16
    iput-object p1, p0, Lorg/codehaus/stax2/io/Stax2URLSource;->mURL:Ljava/net/URL;

    .line 17
    return-void
.end method


# virtual methods
.method public constructInputStream()Ljava/io/InputStream;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 52
    iget-object v0, p0, Lorg/codehaus/stax2/io/Stax2URLSource;->mURL:Ljava/net/URL;

    invoke-virtual {v0}, Ljava/net/URL;->getProtocol()Ljava/lang/String;

    move-result-object v0

    const-string v1, "file"

    invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 53
    new-instance v0, Ljava/io/FileInputStream;

    iget-object v1, p0, Lorg/codehaus/stax2/io/Stax2URLSource;->mURL:Ljava/net/URL;

    invoke-virtual {v1}, Ljava/net/URL;->getPath()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/io/FileInputStream;-><init>(Ljava/lang/String;)V

    return-object v0

    .line 55
    :cond_0
    iget-object v0, p0, Lorg/codehaus/stax2/io/Stax2URLSource;->mURL:Ljava/net/URL;

    invoke-virtual {v0}, Ljava/net/URL;->openStream()Ljava/io/InputStream;

    move-result-object v0

    return-object v0
.end method

.method public constructReader()Ljava/io/Reader;
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 38
    invoke-virtual {p0}, Lorg/codehaus/stax2/io/Stax2URLSource;->getEncoding()Ljava/lang/String;

    move-result-object v0

    .line 39
    .local v0, "enc":Ljava/lang/String;
    if-eqz v0, :cond_0

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v1

    if-lez v1, :cond_0

    .line 40
    new-instance v1, Ljava/io/InputStreamReader;

    invoke-virtual {p0}, Lorg/codehaus/stax2/io/Stax2URLSource;->constructInputStream()Ljava/io/InputStream;

    move-result-object v2

    invoke-direct {v1, v2, v0}, Ljava/io/InputStreamReader;-><init>(Ljava/io/InputStream;Ljava/lang/String;)V

    return-object v1

    .line 43
    :cond_0
    new-instance v1, Ljava/io/InputStreamReader;

    invoke-virtual {p0}, Lorg/codehaus/stax2/io/Stax2URLSource;->constructInputStream()Ljava/io/InputStream;

    move-result-object v2

    invoke-direct {v1, v2}, Ljava/io/InputStreamReader;-><init>(Ljava/io/InputStream;)V

    return-object v1
.end method

.method public getReference()Ljava/net/URL;
    .locals 1

    .line 32
    iget-object v0, p0, Lorg/codehaus/stax2/io/Stax2URLSource;->mURL:Ljava/net/URL;

    return-object v0
.end method
