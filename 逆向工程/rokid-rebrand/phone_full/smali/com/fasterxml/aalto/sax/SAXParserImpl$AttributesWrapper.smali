.class final Lcom/fasterxml/aalto/sax/SAXParserImpl$AttributesWrapper;
.super Ljava/lang/Object;
.source "SAXParserImpl.java"

# interfaces
.implements Lorg/xml/sax/AttributeList;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/fasterxml/aalto/sax/SAXParserImpl;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x18
    name = "AttributesWrapper"
.end annotation


# instance fields
.field mAttrs:Lorg/xml/sax/Attributes;


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 883
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public getLength()I
    .locals 1

    .line 891
    iget-object v0, p0, Lcom/fasterxml/aalto/sax/SAXParserImpl$AttributesWrapper;->mAttrs:Lorg/xml/sax/Attributes;

    invoke-interface {v0}, Lorg/xml/sax/Attributes;->getLength()I

    move-result v0

    return v0
.end method

.method public getName(I)Ljava/lang/String;
    .locals 2
    .param p1, "i"    # I

    .line 896
    iget-object v0, p0, Lcom/fasterxml/aalto/sax/SAXParserImpl$AttributesWrapper;->mAttrs:Lorg/xml/sax/Attributes;

    invoke-interface {v0, p1}, Lorg/xml/sax/Attributes;->getQName(I)Ljava/lang/String;

    move-result-object v0

    .line 897
    .local v0, "n":Ljava/lang/String;
    if-nez v0, :cond_0

    iget-object v1, p0, Lcom/fasterxml/aalto/sax/SAXParserImpl$AttributesWrapper;->mAttrs:Lorg/xml/sax/Attributes;

    invoke-interface {v1, p1}, Lorg/xml/sax/Attributes;->getLocalName(I)Ljava/lang/String;

    move-result-object v1

    goto :goto_0

    :cond_0
    move-object v1, v0

    :goto_0
    return-object v1
.end method

.method public getType(I)Ljava/lang/String;
    .locals 1
    .param p1, "i"    # I

    .line 902
    iget-object v0, p0, Lcom/fasterxml/aalto/sax/SAXParserImpl$AttributesWrapper;->mAttrs:Lorg/xml/sax/Attributes;

    invoke-interface {v0, p1}, Lorg/xml/sax/Attributes;->getType(I)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getType(Ljava/lang/String;)Ljava/lang/String;
    .locals 1
    .param p1, "name"    # Ljava/lang/String;

    .line 907
    iget-object v0, p0, Lcom/fasterxml/aalto/sax/SAXParserImpl$AttributesWrapper;->mAttrs:Lorg/xml/sax/Attributes;

    invoke-interface {v0, p1}, Lorg/xml/sax/Attributes;->getType(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getValue(I)Ljava/lang/String;
    .locals 1
    .param p1, "i"    # I

    .line 912
    iget-object v0, p0, Lcom/fasterxml/aalto/sax/SAXParserImpl$AttributesWrapper;->mAttrs:Lorg/xml/sax/Attributes;

    invoke-interface {v0, p1}, Lorg/xml/sax/Attributes;->getValue(I)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getValue(Ljava/lang/String;)Ljava/lang/String;
    .locals 1
    .param p1, "name"    # Ljava/lang/String;

    .line 917
    iget-object v0, p0, Lcom/fasterxml/aalto/sax/SAXParserImpl$AttributesWrapper;->mAttrs:Lorg/xml/sax/Attributes;

    invoke-interface {v0, p1}, Lorg/xml/sax/Attributes;->getValue(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public setAttributes(Lorg/xml/sax/Attributes;)V
    .locals 0
    .param p1, "a"    # Lorg/xml/sax/Attributes;

    .line 886
    iput-object p1, p0, Lcom/fasterxml/aalto/sax/SAXParserImpl$AttributesWrapper;->mAttrs:Lorg/xml/sax/Attributes;

    .line 887
    return-void
.end method
