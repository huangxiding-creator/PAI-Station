.class public interface abstract Lorg/codehaus/stax2/validation/ValidationContext;
.super Ljava/lang/Object;
.source "ValidationContext.java"


# virtual methods
.method public abstract addDefaultAttribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method

.method public abstract findAttributeIndex(Ljava/lang/String;Ljava/lang/String;)I
.end method

.method public abstract getAttributeCount()I
.end method

.method public abstract getAttributeLocalName(I)Ljava/lang/String;
.end method

.method public abstract getAttributeNamespace(I)Ljava/lang/String;
.end method

.method public abstract getAttributePrefix(I)Ljava/lang/String;
.end method

.method public abstract getAttributeType(I)Ljava/lang/String;
.end method

.method public abstract getAttributeValue(I)Ljava/lang/String;
.end method

.method public abstract getAttributeValue(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
.end method

.method public abstract getBaseUri()Ljava/lang/String;
.end method

.method public abstract getCurrentElementName()Ljavax/xml/namespace/QName;
.end method

.method public abstract getNamespaceURI(Ljava/lang/String;)Ljava/lang/String;
.end method

.method public abstract getValidationLocation()Ljavax/xml/stream/Location;
.end method

.method public abstract getXmlVersion()Ljava/lang/String;
.end method

.method public abstract isNotationDeclared(Ljava/lang/String;)Z
.end method

.method public abstract isUnparsedEntityDeclared(Ljava/lang/String;)Z
.end method

.method public abstract reportProblem(Lorg/codehaus/stax2/validation/XMLValidationProblem;)V
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method
