.class public abstract Lorg/codehaus/stax2/XMLInputFactory2;
.super Ljavax/xml/stream/XMLInputFactory;
.source "XMLInputFactory2.java"

# interfaces
.implements Lorg/codehaus/stax2/XMLStreamProperties;


# static fields
.field public static final P_AUTO_CLOSE_INPUT:Ljava/lang/String; = "org.codehaus.stax2.closeInputSource"

.field public static final P_DTD_OVERRIDE:Ljava/lang/String; = "org.codehaus.stax2.propDtdOverride"

.field public static final P_INTERN_NAMES:Ljava/lang/String; = "org.codehaus.stax2.internNames"

.field public static final P_INTERN_NS_URIS:Ljava/lang/String; = "org.codehaus.stax2.internNsUris"

.field public static final P_LAZY_PARSING:Ljava/lang/String; = "com.ctc.wstx.lazyParsing"

.field public static final P_PRESERVE_LOCATION:Ljava/lang/String; = "org.codehaus.stax2.preserveLocation"

.field public static final P_REPORT_CDATA:Ljava/lang/String; = "http://java.sun.com/xml/stream/properties/report-cdata-event"

.field public static final P_REPORT_PROLOG_WHITESPACE:Ljava/lang/String; = "org.codehaus.stax2.reportPrologWhitespace"


# direct methods
.method protected constructor <init>()V
    .locals 0

    .line 178
    invoke-direct {p0}, Ljavax/xml/stream/XMLInputFactory;-><init>()V

    .line 179
    return-void
.end method


# virtual methods
.method public abstract configureForConvenience()V
.end method

.method public abstract configureForLowMemUsage()V
.end method

.method public abstract configureForRoundTripping()V
.end method

.method public abstract configureForSpeed()V
.end method

.method public abstract configureForXmlConformance()V
.end method

.method public abstract createXMLEventReader(Ljava/io/File;)Lorg/codehaus/stax2/XMLEventReader2;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method

.method public abstract createXMLEventReader(Ljava/net/URL;)Lorg/codehaus/stax2/XMLEventReader2;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method

.method public abstract createXMLStreamReader(Ljava/io/File;)Lorg/codehaus/stax2/XMLStreamReader2;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method

.method public abstract createXMLStreamReader(Ljava/net/URL;)Lorg/codehaus/stax2/XMLStreamReader2;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method
