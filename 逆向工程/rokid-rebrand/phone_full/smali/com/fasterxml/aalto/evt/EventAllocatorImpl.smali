.class public final Lcom/fasterxml/aalto/evt/EventAllocatorImpl;
.super Lorg/codehaus/stax2/ri/evt/Stax2EventAllocatorImpl;
.source "EventAllocatorImpl.java"


# static fields
.field static final sStdInstance:Lcom/fasterxml/aalto/evt/EventAllocatorImpl;


# instance fields
.field protected final _cfgPreserveLocation:Z

.field protected _lastLocation:Ljavax/xml/stream/Location;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .line 34
    new-instance v0, Lcom/fasterxml/aalto/evt/EventAllocatorImpl;

    const/4 v1, 0x1

    invoke-direct {v0, v1}, Lcom/fasterxml/aalto/evt/EventAllocatorImpl;-><init>(Z)V

    sput-object v0, Lcom/fasterxml/aalto/evt/EventAllocatorImpl;->sStdInstance:Lcom/fasterxml/aalto/evt/EventAllocatorImpl;

    return-void
.end method

.method protected constructor <init>(Z)V
    .locals 1
    .param p1, "preserveLocation"    # Z

    .line 62
    invoke-direct {p0}, Lorg/codehaus/stax2/ri/evt/Stax2EventAllocatorImpl;-><init>()V

    .line 54
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/fasterxml/aalto/evt/EventAllocatorImpl;->_lastLocation:Ljavax/xml/stream/Location;

    .line 63
    iput-boolean p1, p0, Lcom/fasterxml/aalto/evt/EventAllocatorImpl;->_cfgPreserveLocation:Z

    .line 64
    return-void
.end method

.method public static getDefaultInstance()Lcom/fasterxml/aalto/evt/EventAllocatorImpl;
    .locals 1

    .line 70
    sget-object v0, Lcom/fasterxml/aalto/evt/EventAllocatorImpl;->sStdInstance:Lcom/fasterxml/aalto/evt/EventAllocatorImpl;

    return-object v0
.end method

.method public static getFastInstance()Lcom/fasterxml/aalto/evt/EventAllocatorImpl;
    .locals 2

    .line 77
    new-instance v0, Lcom/fasterxml/aalto/evt/EventAllocatorImpl;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Lcom/fasterxml/aalto/evt/EventAllocatorImpl;-><init>(Z)V

    return-object v0
.end method


# virtual methods
.method public allocate(Ljavax/xml/stream/XMLStreamReader;)Ljavax/xml/stream/events/XMLEvent;
    .locals 2
    .param p1, "r"    # Ljavax/xml/stream/XMLStreamReader;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 101
    invoke-interface {p1}, Ljavax/xml/stream/XMLStreamReader;->getEventType()I

    move-result v0

    const/16 v1, 0x101

    if-ne v0, v1, :cond_0

    .line 102
    invoke-static {}, Lcom/fasterxml/aalto/evt/IncompleteEvent;->instance()Lcom/fasterxml/aalto/evt/IncompleteEvent;

    move-result-object v0

    return-object v0

    .line 104
    :cond_0
    invoke-super {p0, p1}, Lorg/codehaus/stax2/ri/evt/Stax2EventAllocatorImpl;->allocate(Ljavax/xml/stream/XMLStreamReader;)Ljavax/xml/stream/events/XMLEvent;

    move-result-object v0

    return-object v0
.end method

.method protected getLocation(Ljavax/xml/stream/XMLStreamReader;)Ljavax/xml/stream/Location;
    .locals 2
    .param p1, "r"    # Ljavax/xml/stream/XMLStreamReader;

    .line 116
    iget-boolean v0, p0, Lcom/fasterxml/aalto/evt/EventAllocatorImpl;->_cfgPreserveLocation:Z

    if-eqz v0, :cond_0

    .line 117
    invoke-interface {p1}, Ljavax/xml/stream/XMLStreamReader;->getLocation()Ljavax/xml/stream/Location;

    move-result-object v0

    return-object v0

    .line 119
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/evt/EventAllocatorImpl;->_lastLocation:Ljavax/xml/stream/Location;

    .line 123
    .local v0, "loc":Ljavax/xml/stream/Location;
    if-nez v0, :cond_1

    .line 124
    invoke-interface {p1}, Ljavax/xml/stream/XMLStreamReader;->getLocation()Ljavax/xml/stream/Location;

    move-result-object v1

    iput-object v1, p0, Lcom/fasterxml/aalto/evt/EventAllocatorImpl;->_lastLocation:Ljavax/xml/stream/Location;

    move-object v0, v1

    .line 126
    :cond_1
    return-object v0
.end method

.method public newInstance()Ljavax/xml/stream/util/XMLEventAllocator;
    .locals 2

    .line 89
    new-instance v0, Lcom/fasterxml/aalto/evt/EventAllocatorImpl;

    iget-boolean v1, p0, Lcom/fasterxml/aalto/evt/EventAllocatorImpl;->_cfgPreserveLocation:Z

    invoke-direct {v0, v1}, Lcom/fasterxml/aalto/evt/EventAllocatorImpl;-><init>(Z)V

    return-object v0
.end method
