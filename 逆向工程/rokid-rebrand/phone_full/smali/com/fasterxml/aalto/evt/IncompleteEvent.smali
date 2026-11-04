.class public Lcom/fasterxml/aalto/evt/IncompleteEvent;
.super Lorg/codehaus/stax2/ri/evt/BaseEventImpl;
.source "IncompleteEvent.java"


# static fields
.field private static final INSTANCE:Lcom/fasterxml/aalto/evt/IncompleteEvent;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 19
    new-instance v0, Lcom/fasterxml/aalto/evt/IncompleteEvent;

    invoke-direct {v0}, Lcom/fasterxml/aalto/evt/IncompleteEvent;-><init>()V

    sput-object v0, Lcom/fasterxml/aalto/evt/IncompleteEvent;->INSTANCE:Lcom/fasterxml/aalto/evt/IncompleteEvent;

    return-void
.end method

.method protected constructor <init>()V
    .locals 1

    .line 22
    invoke-static {}, Lcom/fasterxml/aalto/impl/LocationImpl;->getEmptyLocation()Lcom/fasterxml/aalto/impl/LocationImpl;

    move-result-object v0

    invoke-direct {p0, v0}, Lorg/codehaus/stax2/ri/evt/BaseEventImpl;-><init>(Ljavax/xml/stream/Location;)V

    .line 23
    return-void
.end method

.method public static instance()Lcom/fasterxml/aalto/evt/IncompleteEvent;
    .locals 1

    .line 25
    sget-object v0, Lcom/fasterxml/aalto/evt/IncompleteEvent;->INSTANCE:Lcom/fasterxml/aalto/evt/IncompleteEvent;

    return-object v0
.end method


# virtual methods
.method public equals(Ljava/lang/Object;)Z
    .locals 1
    .param p1, "o"    # Ljava/lang/Object;

    .line 44
    if-ne p1, p0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method public getEventType()I
    .locals 1

    .line 29
    const/16 v0, 0x101

    return v0
.end method

.method public hashCode()I
    .locals 1

    .line 49
    const/16 v0, 0x2a

    return v0
.end method

.method public writeAsEncodedUnicode(Ljava/io/Writer;)V
    .locals 0
    .param p1, "w"    # Ljava/io/Writer;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 35
    return-void
.end method

.method public writeUsing(Lorg/codehaus/stax2/XMLStreamWriter2;)V
    .locals 0
    .param p1, "w"    # Lorg/codehaus/stax2/XMLStreamWriter2;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 40
    return-void
.end method
