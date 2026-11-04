.class public abstract Lorg/codehaus/stax2/XMLOutputFactory2;
.super Ljavax/xml/stream/XMLOutputFactory;
.source "XMLOutputFactory2.java"

# interfaces
.implements Lorg/codehaus/stax2/XMLStreamProperties;


# static fields
.field public static final P_ATTR_VALUE_ESCAPER:Ljava/lang/String; = "org.codehaus.stax2.attrValueEscaper"

.field public static final P_AUTOMATIC_EMPTY_ELEMENTS:Ljava/lang/String; = "org.codehaus.stax2.automaticEmptyElements"

.field public static final P_AUTOMATIC_NS_PREFIX:Ljava/lang/String; = "org.codehaus.stax2.automaticNsPrefix"

.field public static final P_AUTO_CLOSE_OUTPUT:Ljava/lang/String; = "org.codehaus.stax2.autoCloseOutput"

.field public static final P_TEXT_ESCAPER:Ljava/lang/String; = "org.codehaus.stax2.textEscaper"


# direct methods
.method protected constructor <init>()V
    .locals 0

    .line 147
    invoke-direct {p0}, Ljavax/xml/stream/XMLOutputFactory;-><init>()V

    .line 148
    return-void
.end method


# virtual methods
.method public abstract configureForRobustness()V
.end method

.method public abstract configureForSpeed()V
.end method

.method public abstract configureForXmlConformance()V
.end method

.method public abstract createXMLEventWriter(Ljava/io/Writer;Ljava/lang/String;)Ljavax/xml/stream/XMLEventWriter;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method

.method public abstract createXMLEventWriter(Ljavax/xml/stream/XMLStreamWriter;)Ljavax/xml/stream/XMLEventWriter;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method

.method public abstract createXMLStreamWriter(Ljava/io/Writer;Ljava/lang/String;)Lorg/codehaus/stax2/XMLStreamWriter2;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method
