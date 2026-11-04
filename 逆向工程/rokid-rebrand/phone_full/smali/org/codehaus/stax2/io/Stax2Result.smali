.class public abstract Lorg/codehaus/stax2/io/Stax2Result;
.super Ljava/lang/Object;
.source "Stax2Result.java"

# interfaces
.implements Ljavax/xml/transform/Result;


# instance fields
.field protected mEncoding:Ljava/lang/String;

.field protected mPublicId:Ljava/lang/String;

.field protected mSystemId:Ljava/lang/String;


# direct methods
.method protected constructor <init>()V
    .locals 0

    .line 45
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public abstract constructOutputStream()Ljava/io/OutputStream;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation
.end method

.method public abstract constructWriter()Ljava/io/Writer;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation
.end method

.method public getEncoding()Ljava/lang/String;
    .locals 1

    .line 72
    iget-object v0, p0, Lorg/codehaus/stax2/io/Stax2Result;->mEncoding:Ljava/lang/String;

    return-object v0
.end method

.method public getPublicId()Ljava/lang/String;
    .locals 1

    .line 64
    iget-object v0, p0, Lorg/codehaus/stax2/io/Stax2Result;->mPublicId:Ljava/lang/String;

    return-object v0
.end method

.method public getSystemId()Ljava/lang/String;
    .locals 1

    .line 55
    iget-object v0, p0, Lorg/codehaus/stax2/io/Stax2Result;->mSystemId:Ljava/lang/String;

    return-object v0
.end method

.method public setEncoding(Ljava/lang/String;)V
    .locals 0
    .param p1, "enc"    # Ljava/lang/String;

    .line 76
    iput-object p1, p0, Lorg/codehaus/stax2/io/Stax2Result;->mEncoding:Ljava/lang/String;

    .line 77
    return-void
.end method

.method public setPublicId(Ljava/lang/String;)V
    .locals 0
    .param p1, "id"    # Ljava/lang/String;

    .line 68
    iput-object p1, p0, Lorg/codehaus/stax2/io/Stax2Result;->mPublicId:Ljava/lang/String;

    .line 69
    return-void
.end method

.method public setSystemId(Ljava/lang/String;)V
    .locals 0
    .param p1, "id"    # Ljava/lang/String;

    .line 60
    iput-object p1, p0, Lorg/codehaus/stax2/io/Stax2Result;->mSystemId:Ljava/lang/String;

    .line 61
    return-void
.end method
