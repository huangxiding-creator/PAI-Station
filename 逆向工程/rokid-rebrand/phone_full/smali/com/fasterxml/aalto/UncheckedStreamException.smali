.class public Lcom/fasterxml/aalto/UncheckedStreamException;
.super Ljava/lang/RuntimeException;
.source "UncheckedStreamException.java"


# direct methods
.method private constructor <init>(Ljavax/xml/stream/XMLStreamException;)V
    .locals 0
    .param p1, "orig"    # Ljavax/xml/stream/XMLStreamException;

    .line 38
    invoke-direct {p0, p1}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/Throwable;)V

    .line 39
    return-void
.end method

.method public static createFrom(Ljavax/xml/stream/XMLStreamException;)Lcom/fasterxml/aalto/UncheckedStreamException;
    .locals 1
    .param p0, "sex"    # Ljavax/xml/stream/XMLStreamException;

    .line 43
    new-instance v0, Lcom/fasterxml/aalto/UncheckedStreamException;

    invoke-direct {v0, p0}, Lcom/fasterxml/aalto/UncheckedStreamException;-><init>(Ljavax/xml/stream/XMLStreamException;)V

    return-object v0
.end method


# virtual methods
.method public getLocalizedMessage()Ljava/lang/String;
    .locals 1

    .line 58
    invoke-virtual {p0}, Lcom/fasterxml/aalto/UncheckedStreamException;->getCause()Ljava/lang/Throwable;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Throwable;->getLocalizedMessage()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getMessage()Ljava/lang/String;
    .locals 1

    .line 53
    invoke-virtual {p0}, Lcom/fasterxml/aalto/UncheckedStreamException;->getCause()Ljava/lang/Throwable;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Throwable;->getMessage()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getStackTrace()[Ljava/lang/StackTraceElement;
    .locals 1

    .line 48
    invoke-virtual {p0}, Lcom/fasterxml/aalto/UncheckedStreamException;->getCause()Ljava/lang/Throwable;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Throwable;->getStackTrace()[Ljava/lang/StackTraceElement;

    move-result-object v0

    return-object v0
.end method

.method public printStackTrace()V
    .locals 1

    .line 63
    invoke-virtual {p0}, Lcom/fasterxml/aalto/UncheckedStreamException;->getCause()Ljava/lang/Throwable;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    .line 64
    return-void
.end method

.method public printStackTrace(Ljava/io/PrintStream;)V
    .locals 1
    .param p1, "p"    # Ljava/io/PrintStream;

    .line 68
    invoke-virtual {p0}, Lcom/fasterxml/aalto/UncheckedStreamException;->getCause()Ljava/lang/Throwable;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/Throwable;->printStackTrace(Ljava/io/PrintStream;)V

    .line 69
    return-void
.end method

.method public printStackTrace(Ljava/io/PrintWriter;)V
    .locals 1
    .param p1, "p"    # Ljava/io/PrintWriter;

    .line 73
    invoke-virtual {p0}, Lcom/fasterxml/aalto/UncheckedStreamException;->getCause()Ljava/lang/Throwable;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/Throwable;->printStackTrace(Ljava/io/PrintWriter;)V

    .line 74
    return-void
.end method

.method public toString()Ljava/lang/String;
    .locals 1

    .line 78
    invoke-virtual {p0}, Lcom/fasterxml/aalto/UncheckedStreamException;->getCause()Ljava/lang/Throwable;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Throwable;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
