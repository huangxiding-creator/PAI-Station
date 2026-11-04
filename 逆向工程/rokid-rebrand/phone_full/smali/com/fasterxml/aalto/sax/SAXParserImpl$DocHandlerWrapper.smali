.class final Lcom/fasterxml/aalto/sax/SAXParserImpl$DocHandlerWrapper;
.super Ljava/lang/Object;
.source "SAXParserImpl.java"

# interfaces
.implements Lorg/xml/sax/ContentHandler;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/fasterxml/aalto/sax/SAXParserImpl;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x18
    name = "DocHandlerWrapper"
.end annotation


# instance fields
.field final mAttrWrapper:Lcom/fasterxml/aalto/sax/SAXParserImpl$AttributesWrapper;

.field final mDocHandler:Lorg/xml/sax/DocumentHandler;


# direct methods
.method constructor <init>(Lorg/xml/sax/DocumentHandler;)V
    .locals 1
    .param p1, "h"    # Lorg/xml/sax/DocumentHandler;

    .line 803
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 800
    new-instance v0, Lcom/fasterxml/aalto/sax/SAXParserImpl$AttributesWrapper;

    invoke-direct {v0}, Lcom/fasterxml/aalto/sax/SAXParserImpl$AttributesWrapper;-><init>()V

    iput-object v0, p0, Lcom/fasterxml/aalto/sax/SAXParserImpl$DocHandlerWrapper;->mAttrWrapper:Lcom/fasterxml/aalto/sax/SAXParserImpl$AttributesWrapper;

    .line 804
    iput-object p1, p0, Lcom/fasterxml/aalto/sax/SAXParserImpl$DocHandlerWrapper;->mDocHandler:Lorg/xml/sax/DocumentHandler;

    .line 805
    return-void
.end method


# virtual methods
.method public characters([CII)V
    .locals 1
    .param p1, "ch"    # [C
    .param p2, "start"    # I
    .param p3, "length"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/xml/sax/SAXException;
        }
    .end annotation

    .line 809
    iget-object v0, p0, Lcom/fasterxml/aalto/sax/SAXParserImpl$DocHandlerWrapper;->mDocHandler:Lorg/xml/sax/DocumentHandler;

    invoke-interface {v0, p1, p2, p3}, Lorg/xml/sax/DocumentHandler;->characters([CII)V

    .line 810
    return-void
.end method

.method public endDocument()V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/xml/sax/SAXException;
        }
    .end annotation

    .line 814
    iget-object v0, p0, Lcom/fasterxml/aalto/sax/SAXParserImpl$DocHandlerWrapper;->mDocHandler:Lorg/xml/sax/DocumentHandler;

    invoke-interface {v0}, Lorg/xml/sax/DocumentHandler;->endDocument()V

    .line 815
    return-void
.end method

.method public endElement(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 1
    .param p1, "uri"    # Ljava/lang/String;
    .param p2, "localName"    # Ljava/lang/String;
    .param p3, "qName"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/xml/sax/SAXException;
        }
    .end annotation

    .line 820
    if-nez p3, :cond_0

    .line 821
    move-object p3, p2

    .line 823
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/sax/SAXParserImpl$DocHandlerWrapper;->mDocHandler:Lorg/xml/sax/DocumentHandler;

    invoke-interface {v0, p3}, Lorg/xml/sax/DocumentHandler;->endElement(Ljava/lang/String;)V

    .line 824
    return-void
.end method

.method public endPrefixMapping(Ljava/lang/String;)V
    .locals 0
    .param p1, "prefix"    # Ljava/lang/String;

    .line 829
    return-void
.end method

.method public ignorableWhitespace([CII)V
    .locals 1
    .param p1, "ch"    # [C
    .param p2, "start"    # I
    .param p3, "length"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/xml/sax/SAXException;
        }
    .end annotation

    .line 834
    iget-object v0, p0, Lcom/fasterxml/aalto/sax/SAXParserImpl$DocHandlerWrapper;->mDocHandler:Lorg/xml/sax/DocumentHandler;

    invoke-interface {v0, p1, p2, p3}, Lorg/xml/sax/DocumentHandler;->ignorableWhitespace([CII)V

    .line 835
    return-void
.end method

.method public processingInstruction(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1
    .param p1, "target"    # Ljava/lang/String;
    .param p2, "data"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/xml/sax/SAXException;
        }
    .end annotation

    .line 840
    iget-object v0, p0, Lcom/fasterxml/aalto/sax/SAXParserImpl$DocHandlerWrapper;->mDocHandler:Lorg/xml/sax/DocumentHandler;

    invoke-interface {v0, p1, p2}, Lorg/xml/sax/DocumentHandler;->processingInstruction(Ljava/lang/String;Ljava/lang/String;)V

    .line 841
    return-void
.end method

.method public setDocumentLocator(Lorg/xml/sax/Locator;)V
    .locals 1
    .param p1, "locator"    # Lorg/xml/sax/Locator;

    .line 845
    iget-object v0, p0, Lcom/fasterxml/aalto/sax/SAXParserImpl$DocHandlerWrapper;->mDocHandler:Lorg/xml/sax/DocumentHandler;

    invoke-interface {v0, p1}, Lorg/xml/sax/DocumentHandler;->setDocumentLocator(Lorg/xml/sax/Locator;)V

    .line 846
    return-void
.end method

.method public skippedEntity(Ljava/lang/String;)V
    .locals 0
    .param p1, "name"    # Ljava/lang/String;

    .line 851
    return-void
.end method

.method public startDocument()V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/xml/sax/SAXException;
        }
    .end annotation

    .line 856
    iget-object v0, p0, Lcom/fasterxml/aalto/sax/SAXParserImpl$DocHandlerWrapper;->mDocHandler:Lorg/xml/sax/DocumentHandler;

    invoke-interface {v0}, Lorg/xml/sax/DocumentHandler;->startDocument()V

    .line 857
    return-void
.end method

.method public startElement(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lorg/xml/sax/Attributes;)V
    .locals 2
    .param p1, "uri"    # Ljava/lang/String;
    .param p2, "localName"    # Ljava/lang/String;
    .param p3, "qName"    # Ljava/lang/String;
    .param p4, "attrs"    # Lorg/xml/sax/Attributes;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/xml/sax/SAXException;
        }
    .end annotation

    .line 864
    if-nez p3, :cond_0

    .line 865
    move-object p3, p2

    .line 868
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/sax/SAXParserImpl$DocHandlerWrapper;->mAttrWrapper:Lcom/fasterxml/aalto/sax/SAXParserImpl$AttributesWrapper;

    invoke-virtual {v0, p4}, Lcom/fasterxml/aalto/sax/SAXParserImpl$AttributesWrapper;->setAttributes(Lorg/xml/sax/Attributes;)V

    .line 869
    iget-object v0, p0, Lcom/fasterxml/aalto/sax/SAXParserImpl$DocHandlerWrapper;->mDocHandler:Lorg/xml/sax/DocumentHandler;

    iget-object v1, p0, Lcom/fasterxml/aalto/sax/SAXParserImpl$DocHandlerWrapper;->mAttrWrapper:Lcom/fasterxml/aalto/sax/SAXParserImpl$AttributesWrapper;

    invoke-interface {v0, p3, v1}, Lorg/xml/sax/DocumentHandler;->startElement(Ljava/lang/String;Lorg/xml/sax/AttributeList;)V

    .line 870
    return-void
.end method

.method public startPrefixMapping(Ljava/lang/String;Ljava/lang/String;)V
    .locals 0
    .param p1, "prefix"    # Ljava/lang/String;
    .param p2, "uri"    # Ljava/lang/String;

    .line 875
    return-void
.end method
