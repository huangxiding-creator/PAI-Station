.class public final Lcom/fasterxml/aalto/evt/EventReaderImpl;
.super Lorg/codehaus/stax2/ri/Stax2EventReaderImpl;
.source "EventReaderImpl.java"


# direct methods
.method public constructor <init>(Ljavax/xml/stream/util/XMLEventAllocator;Lorg/codehaus/stax2/XMLStreamReader2;)V
    .locals 0
    .param p1, "a"    # Ljavax/xml/stream/util/XMLEventAllocator;
    .param p2, "r"    # Lorg/codehaus/stax2/XMLStreamReader2;

    .line 34
    invoke-direct {p0, p1, p2}, Lorg/codehaus/stax2/ri/Stax2EventReaderImpl;-><init>(Ljavax/xml/stream/util/XMLEventAllocator;Lorg/codehaus/stax2/XMLStreamReader2;)V

    .line 35
    return-void
.end method


# virtual methods
.method protected getErrorDesc(II)Ljava/lang/String;
    .locals 1
    .param p1, "errorType"    # I
    .param p2, "currEvent"    # I

    .line 46
    const/4 v0, 0x0

    return-object v0
.end method

.method public isPropertySupported(Ljava/lang/String;)Z
    .locals 1
    .param p1, "name"    # Ljava/lang/String;

    .line 51
    invoke-virtual {p0}, Lcom/fasterxml/aalto/evt/EventReaderImpl;->getStreamReader()Ljavax/xml/stream/XMLStreamReader;

    move-result-object v0

    check-cast v0, Lorg/codehaus/stax2/XMLStreamReader2;

    invoke-interface {v0, p1}, Lorg/codehaus/stax2/XMLStreamReader2;->isPropertySupported(Ljava/lang/String;)Z

    move-result v0

    return v0
.end method

.method protected reportProblem(Ljava/lang/String;Ljavax/xml/stream/Location;)V
    .locals 1
    .param p1, "msg"    # Ljava/lang/String;
    .param p2, "loc"    # Ljavax/xml/stream/Location;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 72
    new-instance v0, Lcom/fasterxml/aalto/impl/StreamExceptionBase;

    invoke-direct {v0, p1, p2}, Lcom/fasterxml/aalto/impl/StreamExceptionBase;-><init>(Ljava/lang/String;Ljavax/xml/stream/Location;)V

    throw v0
.end method

.method public setProperty(Ljava/lang/String;Ljava/lang/Object;)Z
    .locals 1
    .param p1, "name"    # Ljava/lang/String;
    .param p2, "value"    # Ljava/lang/Object;

    .line 56
    invoke-virtual {p0}, Lcom/fasterxml/aalto/evt/EventReaderImpl;->getStreamReader()Ljavax/xml/stream/XMLStreamReader;

    move-result-object v0

    check-cast v0, Lorg/codehaus/stax2/XMLStreamReader2;

    invoke-interface {v0, p1, p2}, Lorg/codehaus/stax2/XMLStreamReader2;->setProperty(Ljava/lang/String;Ljava/lang/Object;)Z

    move-result v0

    return v0
.end method
