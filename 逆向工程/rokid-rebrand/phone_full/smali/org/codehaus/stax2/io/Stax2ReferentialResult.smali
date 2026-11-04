.class public abstract Lorg/codehaus/stax2/io/Stax2ReferentialResult;
.super Lorg/codehaus/stax2/io/Stax2Result;
.source "Stax2ReferentialResult.java"


# direct methods
.method protected constructor <init>()V
    .locals 0

    .line 15
    invoke-direct {p0}, Lorg/codehaus/stax2/io/Stax2Result;-><init>()V

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
