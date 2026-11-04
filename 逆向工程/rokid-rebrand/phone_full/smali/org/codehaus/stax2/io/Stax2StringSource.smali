.class public Lorg/codehaus/stax2/io/Stax2StringSource;
.super Lorg/codehaus/stax2/io/Stax2BlockSource;
.source "Stax2StringSource.java"


# instance fields
.field final mText:Ljava/lang/String;


# direct methods
.method public constructor <init>(Ljava/lang/String;)V
    .locals 0
    .param p1, "text"    # Ljava/lang/String;

    .line 14
    invoke-direct {p0}, Lorg/codehaus/stax2/io/Stax2BlockSource;-><init>()V

    .line 15
    iput-object p1, p0, Lorg/codehaus/stax2/io/Stax2StringSource;->mText:Ljava/lang/String;

    .line 16
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

    .line 36
    const/4 v0, 0x0

    return-object v0
.end method

.method public constructReader()Ljava/io/Reader;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 27
    new-instance v0, Ljava/io/StringReader;

    iget-object v1, p0, Lorg/codehaus/stax2/io/Stax2StringSource;->mText:Ljava/lang/String;

    invoke-direct {v0, v1}, Ljava/io/StringReader;-><init>(Ljava/lang/String;)V

    return-object v0
.end method

.method public getText()Ljava/lang/String;
    .locals 1

    .line 46
    iget-object v0, p0, Lorg/codehaus/stax2/io/Stax2StringSource;->mText:Ljava/lang/String;

    return-object v0
.end method
