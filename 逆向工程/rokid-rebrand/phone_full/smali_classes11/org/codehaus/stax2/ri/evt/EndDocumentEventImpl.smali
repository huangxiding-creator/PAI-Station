.class public Lorg/codehaus/stax2/ri/evt/EndDocumentEventImpl;
.super Lorg/codehaus/stax2/ri/evt/BaseEventImpl;
.source "EndDocumentEventImpl.java"

# interfaces
.implements Ljavax/xml/stream/events/EndDocument;


# direct methods
.method public constructor <init>(Ljavax/xml/stream/Location;)V
    .locals 0
    .param p1, "loc"    # Ljavax/xml/stream/Location;

    .line 16
    invoke-direct {p0, p1}, Lorg/codehaus/stax2/ri/evt/BaseEventImpl;-><init>(Ljavax/xml/stream/Location;)V

    .line 17
    return-void
.end method


# virtual methods
.method public equals(Ljava/lang/Object;)Z
    .locals 1
    .param p1, "o"    # Ljava/lang/Object;

    .line 57
    if-ne p1, p0, :cond_0

    const/4 v0, 0x1

    return v0

    .line 58
    :cond_0
    if-nez p1, :cond_1

    const/4 v0, 0x0

    return v0

    .line 59
    :cond_1
    instance-of v0, p1, Ljavax/xml/stream/events/EndDocument;

    return v0
.end method

.method public getEventType()I
    .locals 1

    .line 27
    const/16 v0, 0x8

    return v0
.end method

.method public hashCode()I
    .locals 1

    .line 64
    const/16 v0, 0x8

    return v0
.end method

.method public isEndDocument()Z
    .locals 1

    .line 32
    const/4 v0, 0x1

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

    .line 40
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

    .line 45
    invoke-interface {p1}, Lorg/codehaus/stax2/XMLStreamWriter2;->writeEndDocument()V

    .line 46
    return-void
.end method
