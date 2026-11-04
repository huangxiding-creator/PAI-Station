.class public Lcom/fasterxml/aalto/dom/DOMReaderImpl;
.super Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;
.source "DOMReaderImpl.java"


# instance fields
.field protected final _config:Lcom/fasterxml/aalto/in/ReaderConfig;


# direct methods
.method protected constructor <init>(Ljavax/xml/transform/dom/DOMSource;Lcom/fasterxml/aalto/in/ReaderConfig;)V
    .locals 2
    .param p1, "src"    # Ljavax/xml/transform/dom/DOMSource;
    .param p2, "cfg"    # Lcom/fasterxml/aalto/in/ReaderConfig;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 32
    invoke-virtual {p2}, Lcom/fasterxml/aalto/in/ReaderConfig;->willSupportNamespaces()Z

    move-result v0

    invoke-virtual {p2}, Lcom/fasterxml/aalto/in/ReaderConfig;->willCoalesceText()Z

    move-result v1

    invoke-direct {p0, p1, v0, v1}, Lorg/codehaus/stax2/ri/dom/DOMWrappingReader;-><init>(Ljavax/xml/transform/dom/DOMSource;ZZ)V

    .line 33
    iput-object p2, p0, Lcom/fasterxml/aalto/dom/DOMReaderImpl;->_config:Lcom/fasterxml/aalto/in/ReaderConfig;

    .line 34
    invoke-virtual {p2}, Lcom/fasterxml/aalto/in/ReaderConfig;->hasInternNamesBeenEnabled()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 35
    invoke-virtual {p2}, Lcom/fasterxml/aalto/in/ReaderConfig;->willInternNames()Z

    move-result v0

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/dom/DOMReaderImpl;->setInternNames(Z)V

    .line 37
    :cond_0
    invoke-virtual {p2}, Lcom/fasterxml/aalto/in/ReaderConfig;->hasInternNsURIsBeenEnabled()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 38
    invoke-virtual {p2}, Lcom/fasterxml/aalto/in/ReaderConfig;->willInternNsURIs()Z

    move-result v0

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/dom/DOMReaderImpl;->setInternNsURIs(Z)V

    .line 40
    :cond_1
    return-void
.end method

.method public static createFrom(Ljavax/xml/transform/dom/DOMSource;Lcom/fasterxml/aalto/in/ReaderConfig;)Lcom/fasterxml/aalto/dom/DOMReaderImpl;
    .locals 1
    .param p0, "src"    # Ljavax/xml/transform/dom/DOMSource;
    .param p1, "cfg"    # Lcom/fasterxml/aalto/in/ReaderConfig;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 45
    new-instance v0, Lcom/fasterxml/aalto/dom/DOMReaderImpl;

    invoke-direct {v0, p0, p1}, Lcom/fasterxml/aalto/dom/DOMReaderImpl;-><init>(Ljavax/xml/transform/dom/DOMSource;Lcom/fasterxml/aalto/in/ReaderConfig;)V

    return-object v0
.end method


# virtual methods
.method public getProperty(Ljava/lang/String;)Ljava/lang/Object;
    .locals 2
    .param p1, "name"    # Ljava/lang/String;

    .line 62
    const-string v0, "javax.xml.stream.entities"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 64
    sget-object v0, Ljava/util/Collections;->EMPTY_LIST:Ljava/util/List;

    return-object v0

    .line 66
    :cond_0
    const-string v0, "javax.xml.stream.notations"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 68
    sget-object v0, Ljava/util/Collections;->EMPTY_LIST:Ljava/util/List;

    return-object v0

    .line 71
    :cond_1
    iget-object v0, p0, Lcom/fasterxml/aalto/dom/DOMReaderImpl;->_config:Lcom/fasterxml/aalto/in/ReaderConfig;

    const/4 v1, 0x1

    invoke-virtual {v0, p1, v1}, Lcom/fasterxml/aalto/in/ReaderConfig;->getProperty(Ljava/lang/String;Z)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public isPropertySupported(Ljava/lang/String;)Z
    .locals 1
    .param p1, "name"    # Ljava/lang/String;

    .line 56
    iget-object v0, p0, Lcom/fasterxml/aalto/dom/DOMReaderImpl;->_config:Lcom/fasterxml/aalto/in/ReaderConfig;

    invoke-virtual {v0, p1}, Lcom/fasterxml/aalto/in/ReaderConfig;->isPropertySupported(Ljava/lang/String;)Z

    move-result v0

    return v0
.end method

.method public setProperty(Ljava/lang/String;Ljava/lang/Object;)Z
    .locals 1
    .param p1, "name"    # Ljava/lang/String;
    .param p2, "value"    # Ljava/lang/Object;

    .line 80
    iget-object v0, p0, Lcom/fasterxml/aalto/dom/DOMReaderImpl;->_config:Lcom/fasterxml/aalto/in/ReaderConfig;

    invoke-virtual {v0, p1, p2}, Lcom/fasterxml/aalto/in/ReaderConfig;->setProperty(Ljava/lang/String;Ljava/lang/Object;)Z

    move-result v0

    return v0
.end method

.method protected throwStreamException(Ljava/lang/String;Ljavax/xml/stream/Location;)V
    .locals 1
    .param p1, "msg"    # Ljava/lang/String;
    .param p2, "loc"    # Ljavax/xml/stream/Location;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 93
    new-instance v0, Lcom/fasterxml/aalto/WFCException;

    invoke-direct {v0, p1, p2}, Lcom/fasterxml/aalto/WFCException;-><init>(Ljava/lang/String;Ljavax/xml/stream/Location;)V

    throw v0
.end method
