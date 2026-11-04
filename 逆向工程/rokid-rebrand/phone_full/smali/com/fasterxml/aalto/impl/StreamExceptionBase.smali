.class public Lcom/fasterxml/aalto/impl/StreamExceptionBase;
.super Ljavax/xml/stream/XMLStreamException;
.source "StreamExceptionBase.java"


# instance fields
.field final mMsg:Ljava/lang/String;


# direct methods
.method public constructor <init>(Ljava/lang/String;)V
    .locals 0
    .param p1, "msg"    # Ljava/lang/String;

    .line 35
    invoke-direct {p0, p1}, Ljavax/xml/stream/XMLStreamException;-><init>(Ljava/lang/String;)V

    .line 36
    iput-object p1, p0, Lcom/fasterxml/aalto/impl/StreamExceptionBase;->mMsg:Ljava/lang/String;

    .line 37
    return-void
.end method

.method public constructor <init>(Ljava/lang/String;Ljavax/xml/stream/Location;)V
    .locals 0
    .param p1, "msg"    # Ljava/lang/String;
    .param p2, "loc"    # Ljavax/xml/stream/Location;

    .line 49
    invoke-direct {p0, p1, p2}, Ljavax/xml/stream/XMLStreamException;-><init>(Ljava/lang/String;Ljavax/xml/stream/Location;)V

    .line 50
    iput-object p1, p0, Lcom/fasterxml/aalto/impl/StreamExceptionBase;->mMsg:Ljava/lang/String;

    .line 51
    return-void
.end method

.method public constructor <init>(Ljava/lang/String;Ljavax/xml/stream/Location;Ljava/lang/Throwable;)V
    .locals 1
    .param p1, "msg"    # Ljava/lang/String;
    .param p2, "loc"    # Ljavax/xml/stream/Location;
    .param p3, "th"    # Ljava/lang/Throwable;

    .line 54
    invoke-direct {p0, p1, p2, p3}, Ljavax/xml/stream/XMLStreamException;-><init>(Ljava/lang/String;Ljavax/xml/stream/Location;Ljava/lang/Throwable;)V

    .line 55
    iput-object p1, p0, Lcom/fasterxml/aalto/impl/StreamExceptionBase;->mMsg:Ljava/lang/String;

    .line 57
    if-eqz p3, :cond_0

    invoke-virtual {p0}, Lcom/fasterxml/aalto/impl/StreamExceptionBase;->getCause()Ljava/lang/Throwable;

    move-result-object v0

    if-nez v0, :cond_0

    .line 58
    invoke-virtual {p0, p3}, Lcom/fasterxml/aalto/impl/StreamExceptionBase;->initCause(Ljava/lang/Throwable;)Ljava/lang/Throwable;

    .line 60
    :cond_0
    return-void
.end method

.method public constructor <init>(Ljava/lang/Throwable;)V
    .locals 1
    .param p1, "th"    # Ljava/lang/Throwable;

    .line 40
    invoke-virtual {p1}, Ljava/lang/Throwable;->getMessage()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0, p1}, Ljavax/xml/stream/XMLStreamException;-><init>(Ljava/lang/String;Ljava/lang/Throwable;)V

    .line 41
    invoke-virtual {p1}, Ljava/lang/Throwable;->getMessage()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/fasterxml/aalto/impl/StreamExceptionBase;->mMsg:Ljava/lang/String;

    .line 43
    invoke-virtual {p0}, Lcom/fasterxml/aalto/impl/StreamExceptionBase;->getCause()Ljava/lang/Throwable;

    move-result-object v0

    if-nez v0, :cond_0

    .line 44
    invoke-virtual {p0, p1}, Lcom/fasterxml/aalto/impl/StreamExceptionBase;->initCause(Ljava/lang/Throwable;)Ljava/lang/Throwable;

    .line 46
    :cond_0
    return-void
.end method


# virtual methods
.method protected getLocationDesc()Ljava/lang/String;
    .locals 2

    .line 100
    invoke-virtual {p0}, Lcom/fasterxml/aalto/impl/StreamExceptionBase;->getLocation()Ljavax/xml/stream/Location;

    move-result-object v0

    .line 101
    .local v0, "loc":Ljavax/xml/stream/Location;
    if-nez v0, :cond_0

    const/4 v1, 0x0

    goto :goto_0

    :cond_0
    invoke-virtual {v0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v1

    :goto_0
    return-object v1
.end method

.method public getMessage()Ljava/lang/String;
    .locals 4

    .line 71
    invoke-virtual {p0}, Lcom/fasterxml/aalto/impl/StreamExceptionBase;->getLocationDesc()Ljava/lang/String;

    move-result-object v0

    .line 76
    .local v0, "locMsg":Ljava/lang/String;
    if-nez v0, :cond_0

    .line 77
    invoke-super {p0}, Ljavax/xml/stream/XMLStreamException;->getMessage()Ljava/lang/String;

    move-result-object v1

    return-object v1

    .line 79
    :cond_0
    new-instance v1, Ljava/lang/StringBuilder;

    iget-object v2, p0, Lcom/fasterxml/aalto/impl/StreamExceptionBase;->mMsg:Ljava/lang/String;

    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result v2

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v3

    add-int/2addr v2, v3

    add-int/lit8 v2, v2, 0x14

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(I)V

    .line 80
    .local v1, "sb":Ljava/lang/StringBuilder;
    iget-object v2, p0, Lcom/fasterxml/aalto/impl/StreamExceptionBase;->mMsg:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 81
    const/16 v2, 0xa

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 82
    const-string v2, " at "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 83
    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 84
    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    return-object v2
.end method

.method public toString()Ljava/lang/String;
    .locals 2

    .line 89
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ": "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {p0}, Lcom/fasterxml/aalto/impl/StreamExceptionBase;->getMessage()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
