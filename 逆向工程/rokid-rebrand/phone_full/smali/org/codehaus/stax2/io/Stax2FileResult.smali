.class public Lorg/codehaus/stax2/io/Stax2FileResult;
.super Lorg/codehaus/stax2/io/Stax2ReferentialResult;
.source "Stax2FileResult.java"


# instance fields
.field final mFile:Ljava/io/File;


# direct methods
.method public constructor <init>(Ljava/io/File;)V
    .locals 0
    .param p1, "f"    # Ljava/io/File;

    .line 14
    invoke-direct {p0}, Lorg/codehaus/stax2/io/Stax2ReferentialResult;-><init>()V

    .line 15
    iput-object p1, p0, Lorg/codehaus/stax2/io/Stax2FileResult;->mFile:Ljava/io/File;

    .line 16
    return-void
.end method


# virtual methods
.method public constructOutputStream()Ljava/io/OutputStream;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 38
    new-instance v0, Ljava/io/FileOutputStream;

    iget-object v1, p0, Lorg/codehaus/stax2/io/Stax2FileResult;->mFile:Ljava/io/File;

    invoke-direct {v0, v1}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V

    return-object v0
.end method

.method public constructWriter()Ljava/io/Writer;
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 27
    invoke-virtual {p0}, Lorg/codehaus/stax2/io/Stax2FileResult;->getEncoding()Ljava/lang/String;

    move-result-object v0

    .line 28
    .local v0, "enc":Ljava/lang/String;
    if-eqz v0, :cond_0

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v1

    if-lez v1, :cond_0

    .line 29
    new-instance v1, Ljava/io/OutputStreamWriter;

    invoke-virtual {p0}, Lorg/codehaus/stax2/io/Stax2FileResult;->constructOutputStream()Ljava/io/OutputStream;

    move-result-object v2

    invoke-direct {v1, v2, v0}, Ljava/io/OutputStreamWriter;-><init>(Ljava/io/OutputStream;Ljava/lang/String;)V

    return-object v1

    .line 32
    :cond_0
    new-instance v1, Ljava/io/FileWriter;

    iget-object v2, p0, Lorg/codehaus/stax2/io/Stax2FileResult;->mFile:Ljava/io/File;

    invoke-direct {v1, v2}, Ljava/io/FileWriter;-><init>(Ljava/io/File;)V

    return-object v1
.end method

.method public getFile()Ljava/io/File;
    .locals 1

    .line 48
    iget-object v0, p0, Lorg/codehaus/stax2/io/Stax2FileResult;->mFile:Ljava/io/File;

    return-object v0
.end method
