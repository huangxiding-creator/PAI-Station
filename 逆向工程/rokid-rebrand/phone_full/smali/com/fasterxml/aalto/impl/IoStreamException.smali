.class public Lcom/fasterxml/aalto/impl/IoStreamException;
.super Lcom/fasterxml/aalto/impl/StreamExceptionBase;
.source "IoStreamException.java"


# direct methods
.method public constructor <init>(Ljava/io/IOException;)V
    .locals 0
    .param p1, "ie"    # Ljava/io/IOException;

    .line 14
    invoke-direct {p0, p1}, Lcom/fasterxml/aalto/impl/StreamExceptionBase;-><init>(Ljava/lang/Throwable;)V

    .line 15
    return-void
.end method

.method public constructor <init>(Ljava/lang/String;)V
    .locals 0
    .param p1, "msg"    # Ljava/lang/String;

    .line 18
    invoke-direct {p0, p1}, Lcom/fasterxml/aalto/impl/StreamExceptionBase;-><init>(Ljava/lang/String;)V

    .line 19
    return-void
.end method
