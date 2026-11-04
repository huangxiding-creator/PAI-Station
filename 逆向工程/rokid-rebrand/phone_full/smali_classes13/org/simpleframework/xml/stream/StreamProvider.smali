.class public Lorg/simpleframework/xml/stream/StreamProvider;
.super Ljava/lang/Object;
.source "StreamProvider.java"

# interfaces
.implements Lorg/simpleframework/xml/stream/Provider;


# instance fields
.field private final factory:Ljavax/xml/stream/XMLInputFactory;


# direct methods
.method public constructor <init>()V
    .locals 3

    .line 60
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 61
    invoke-static {}, Ljavax/xml/stream/XMLInputFactory;->newInstance()Ljavax/xml/stream/XMLInputFactory;

    move-result-object v0

    iput-object v0, p0, Lorg/simpleframework/xml/stream/StreamProvider;->factory:Ljavax/xml/stream/XMLInputFactory;

    .line 62
    iget-object v0, p0, Lorg/simpleframework/xml/stream/StreamProvider;->factory:Ljavax/xml/stream/XMLInputFactory;

    const/4 v1, 0x0

    invoke-static {v1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v1

    const-string v2, "javax.xml.stream.supportDTD"

    invoke-virtual {v0, v2, v1}, Ljavax/xml/stream/XMLInputFactory;->setProperty(Ljava/lang/String;Ljava/lang/Object;)V

    .line 63
    iget-object v0, p0, Lorg/simpleframework/xml/stream/StreamProvider;->factory:Ljavax/xml/stream/XMLInputFactory;

    const-string v2, "javax.xml.stream.isSupportingExternalEntities"

    invoke-virtual {v0, v2, v1}, Ljavax/xml/stream/XMLInputFactory;->setProperty(Ljava/lang/String;Ljava/lang/Object;)V

    .line 64
    iget-object v0, p0, Lorg/simpleframework/xml/stream/StreamProvider;->factory:Ljavax/xml/stream/XMLInputFactory;

    new-instance v1, Lorg/simpleframework/xml/stream/StreamProvider$1;

    invoke-direct {v1, p0}, Lorg/simpleframework/xml/stream/StreamProvider$1;-><init>(Lorg/simpleframework/xml/stream/StreamProvider;)V

    invoke-virtual {v0, v1}, Ljavax/xml/stream/XMLInputFactory;->setXMLResolver(Ljavax/xml/stream/XMLResolver;)V

    .line 71
    return-void
.end method

.method public constructor <init>(Ljavax/xml/stream/XMLInputFactory;)V
    .locals 0
    .param p1, "factory"    # Ljavax/xml/stream/XMLInputFactory;

    .line 51
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 52
    iput-object p1, p0, Lorg/simpleframework/xml/stream/StreamProvider;->factory:Ljavax/xml/stream/XMLInputFactory;

    .line 53
    return-void
.end method

.method private provide(Ljavax/xml/stream/XMLEventReader;)Lorg/simpleframework/xml/stream/EventReader;
    .locals 1
    .param p1, "source"    # Ljavax/xml/stream/XMLEventReader;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 110
    new-instance v0, Lorg/simpleframework/xml/stream/StreamReader;

    invoke-direct {v0, p1}, Lorg/simpleframework/xml/stream/StreamReader;-><init>(Ljavax/xml/stream/XMLEventReader;)V

    return-object v0
.end method


# virtual methods
.method public provide(Ljava/io/InputStream;)Lorg/simpleframework/xml/stream/EventReader;
    .locals 1
    .param p1, "source"    # Ljava/io/InputStream;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 84
    iget-object v0, p0, Lorg/simpleframework/xml/stream/StreamProvider;->factory:Ljavax/xml/stream/XMLInputFactory;

    invoke-virtual {v0, p1}, Ljavax/xml/stream/XMLInputFactory;->createXMLEventReader(Ljava/io/InputStream;)Ljavax/xml/stream/XMLEventReader;

    move-result-object v0

    invoke-direct {p0, v0}, Lorg/simpleframework/xml/stream/StreamProvider;->provide(Ljavax/xml/stream/XMLEventReader;)Lorg/simpleframework/xml/stream/EventReader;

    move-result-object v0

    return-object v0
.end method

.method public provide(Ljava/io/Reader;)Lorg/simpleframework/xml/stream/EventReader;
    .locals 1
    .param p1, "source"    # Ljava/io/Reader;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 97
    iget-object v0, p0, Lorg/simpleframework/xml/stream/StreamProvider;->factory:Ljavax/xml/stream/XMLInputFactory;

    invoke-virtual {v0, p1}, Ljavax/xml/stream/XMLInputFactory;->createXMLEventReader(Ljava/io/Reader;)Ljavax/xml/stream/XMLEventReader;

    move-result-object v0

    invoke-direct {p0, v0}, Lorg/simpleframework/xml/stream/StreamProvider;->provide(Ljavax/xml/stream/XMLEventReader;)Lorg/simpleframework/xml/stream/EventReader;

    move-result-object v0

    return-object v0
.end method
