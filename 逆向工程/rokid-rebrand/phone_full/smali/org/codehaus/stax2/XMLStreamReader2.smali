.class public interface abstract Lorg/codehaus/stax2/XMLStreamReader2;
.super Ljava/lang/Object;
.source "XMLStreamReader2.java"

# interfaces
.implements Lorg/codehaus/stax2/typed/TypedXMLStreamReader;
.implements Lorg/codehaus/stax2/validation/Validatable;


# static fields
.field public static final FEATURE_DTD_OVERRIDE:Ljava/lang/String; = "org.codehaus.stax2.propDtdOverride"
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation
.end field


# virtual methods
.method public abstract closeCompletely()V
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method

.method public abstract getAttributeInfo()Lorg/codehaus/stax2/AttributeInfo;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method

.method public abstract getDTDInfo()Lorg/codehaus/stax2/DTDInfo;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method

.method public abstract getDepth()I
.end method

.method public abstract getFeature(Ljava/lang/String;)Ljava/lang/Object;
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation
.end method

.method public abstract getLocationInfo()Lorg/codehaus/stax2/LocationInfo;
.end method

.method public abstract getNonTransientNamespaceContext()Ljavax/xml/namespace/NamespaceContext;
.end method

.method public abstract getPrefixedName()Ljava/lang/String;
.end method

.method public abstract getText(Ljava/io/Writer;Z)I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method

.method public abstract isEmptyElement()Z
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method

.method public abstract isPropertySupported(Ljava/lang/String;)Z
.end method

.method public abstract setFeature(Ljava/lang/String;Ljava/lang/Object;)V
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation
.end method

.method public abstract setProperty(Ljava/lang/String;Ljava/lang/Object;)Z
.end method

.method public abstract skipElement()V
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method
