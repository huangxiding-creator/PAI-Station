.class public Lorg/codehaus/stax2/io/Stax2FileSource;
.super Lorg/codehaus/stax2/io/Stax2ReferentialSource;
.source "Stax2FileSource.java"


# instance fields
.field final _file:Ljava/io/File;


# direct methods
.method public constructor <init>(Ljava/io/File;)V
    .locals 0
    .param p1, "f"    # Ljava/io/File;

    .line 15
    invoke-direct {p0}, Lorg/codehaus/stax2/io/Stax2ReferentialSource;-><init>()V

    .line 16
    iput-object p1, p0, Lorg/codehaus/stax2/io/Stax2FileSource;->_file:Ljava/io/File;

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

    .line 62
    new-instance v0, Ljava/io/FileInputStream;

    iget-object v1, p0, Lorg/codehaus/stax2/io/Stax2FileSource;->_file:Ljava/io/File;

    invoke-direct {v0, v1}, Ljava/io/FileInputStream;-><init>(Ljava/io/File;)V

    return-object v0
.end method

.method public constructReader()Ljava/io/Reader;
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 51
    invoke-virtual {p0}, Lorg/codehaus/stax2/io/Stax2FileSource;->getEncoding()Ljava/lang/String;

    move-result-object v0

    .line 52
    .local v0, "enc":Ljava/lang/String;
    if-eqz v0, :cond_0

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v1

    if-lez v1, :cond_0

    .line 53
    new-instance v1, Ljava/io/InputStreamReader;

    invoke-virtual {p0}, Lorg/codehaus/stax2/io/Stax2FileSource;->constructInputStream()Ljava/io/InputStream;

    move-result-object v2

    invoke-direct {v1, v2, v0}, Ljava/io/InputStreamReader;-><init>(Ljava/io/InputStream;Ljava/lang/String;)V

    return-object v1

    .line 56
    :cond_0
    new-instance v1, Ljava/io/FileReader;

    iget-object v2, p0, Lorg/codehaus/stax2/io/Stax2FileSource;->_file:Ljava/io/File;

    invoke-direct {v1, v2}, Ljava/io/FileReader;-><init>(Ljava/io/File;)V

    return-object v1
.end method

.method public getFile()Ljava/io/File;
    .locals 1

    .line 72
    iget-object v0, p0, Lorg/codehaus/stax2/io/Stax2FileSource;->_file:Ljava/io/File;

    return-object v0
.end method

.method public getReference()Ljava/net/URL;
    .locals 4

    .line 38
    :try_start_0
    iget-object v0, p0, Lorg/codehaus/stax2/io/Stax2FileSource;->_file:Ljava/io/File;

    invoke-virtual {v0}, Ljava/io/File;->toURL()Ljava/net/URL;

    move-result-object v0
    :try_end_0
    .catch Ljava/net/MalformedURLException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    .line 39
    :catch_0
    move-exception v0

    .line 44
    .local v0, "e":Ljava/net/MalformedURLException;
    new-instance v1, Ljava/lang/IllegalArgumentException;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "(was "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ") Could not convert File \'"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, p0, Lorg/codehaus/stax2/io/Stax2FileSource;->_file:Ljava/io/File;

    invoke-virtual {v3}, Ljava/io/File;->getPath()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "\' to URL: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v1
.end method
