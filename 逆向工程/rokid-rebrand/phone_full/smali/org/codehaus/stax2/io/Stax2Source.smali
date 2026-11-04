.class public abstract Lorg/codehaus/stax2/io/Stax2Source;
.super Ljava/lang/Object;
.source "Stax2Source.java"

# interfaces
.implements Ljavax/xml/transform/Source;


# instance fields
.field protected mEncoding:Ljava/lang/String;

.field protected mPublicId:Ljava/lang/String;

.field protected mSystemId:Ljava/lang/String;


# direct methods
.method protected constructor <init>()V
    .locals 0

    .line 46
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

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

.method public getEncoding()Ljava/lang/String;
    .locals 1

    .line 73
    iget-object v0, p0, Lorg/codehaus/stax2/io/Stax2Source;->mEncoding:Ljava/lang/String;

    return-object v0
.end method

.method public getPublicId()Ljava/lang/String;
    .locals 1

    .line 65
    iget-object v0, p0, Lorg/codehaus/stax2/io/Stax2Source;->mPublicId:Ljava/lang/String;

    return-object v0
.end method

.method public abstract getReference()Ljava/net/URL;
.end method

.method public getSystemId()Ljava/lang/String;
    .locals 1

    .line 56
    iget-object v0, p0, Lorg/codehaus/stax2/io/Stax2Source;->mSystemId:Ljava/lang/String;

    return-object v0
.end method

.method public setEncoding(Ljava/lang/String;)V
    .locals 0
    .param p1, "enc"    # Ljava/lang/String;

    .line 77
    iput-object p1, p0, Lorg/codehaus/stax2/io/Stax2Source;->mEncoding:Ljava/lang/String;

    .line 78
    return-void
.end method

.method public setPublicId(Ljava/lang/String;)V
    .locals 0
    .param p1, "id"    # Ljava/lang/String;

    .line 69
    iput-object p1, p0, Lorg/codehaus/stax2/io/Stax2Source;->mPublicId:Ljava/lang/String;

    .line 70
    return-void
.end method

.method public setSystemId(Ljava/lang/String;)V
    .locals 0
    .param p1, "id"    # Ljava/lang/String;

    .line 61
    iput-object p1, p0, Lorg/codehaus/stax2/io/Stax2Source;->mSystemId:Ljava/lang/String;

    .line 62
    return-void
.end method
