.class public Lorg/codehaus/stax2/ri/evt/Stax2EventReaderAdapter;
.super Ljava/lang/Object;
.source "Stax2EventReaderAdapter.java"

# interfaces
.implements Lorg/codehaus/stax2/XMLEventReader2;


# instance fields
.field protected final mReader:Ljavax/xml/stream/XMLEventReader;


# direct methods
.method protected constructor <init>(Ljavax/xml/stream/XMLEventReader;)V
    .locals 0
    .param p1, "er"    # Ljavax/xml/stream/XMLEventReader;

    .line 40
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 41
    iput-object p1, p0, Lorg/codehaus/stax2/ri/evt/Stax2EventReaderAdapter;->mReader:Ljavax/xml/stream/XMLEventReader;

    .line 42
    return-void
.end method

.method public static wrapIfNecessary(Ljavax/xml/stream/XMLEventReader;)Lorg/codehaus/stax2/XMLEventReader2;
    .locals 1
    .param p0, "er"    # Ljavax/xml/stream/XMLEventReader;

    .line 53
    instance-of v0, p0, Lorg/codehaus/stax2/XMLEventReader2;

    if-eqz v0, :cond_0

    .line 54
    move-object v0, p0

    check-cast v0, Lorg/codehaus/stax2/XMLEventReader2;

    return-object v0

    .line 56
    :cond_0
    new-instance v0, Lorg/codehaus/stax2/ri/evt/Stax2EventReaderAdapter;

    invoke-direct {v0, p0}, Lorg/codehaus/stax2/ri/evt/Stax2EventReaderAdapter;-><init>(Ljavax/xml/stream/XMLEventReader;)V

    return-object v0
.end method


# virtual methods
.method public close()V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 67
    iget-object v0, p0, Lorg/codehaus/stax2/ri/evt/Stax2EventReaderAdapter;->mReader:Ljavax/xml/stream/XMLEventReader;

    invoke-interface {v0}, Ljavax/xml/stream/XMLEventReader;->close()V

    .line 68
    return-void
.end method

.method public getElementText()Ljava/lang/String;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 72
    iget-object v0, p0, Lorg/codehaus/stax2/ri/evt/Stax2EventReaderAdapter;->mReader:Ljavax/xml/stream/XMLEventReader;

    invoke-interface {v0}, Ljavax/xml/stream/XMLEventReader;->getElementText()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getProperty(Ljava/lang/String;)Ljava/lang/Object;
    .locals 1
    .param p1, "name"    # Ljava/lang/String;

    .line 77
    iget-object v0, p0, Lorg/codehaus/stax2/ri/evt/Stax2EventReaderAdapter;->mReader:Ljavax/xml/stream/XMLEventReader;

    invoke-interface {v0, p1}, Ljavax/xml/stream/XMLEventReader;->getProperty(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public hasNext()Z
    .locals 1

    .line 82
    iget-object v0, p0, Lorg/codehaus/stax2/ri/evt/Stax2EventReaderAdapter;->mReader:Ljavax/xml/stream/XMLEventReader;

    invoke-interface {v0}, Ljavax/xml/stream/XMLEventReader;->hasNext()Z

    move-result v0

    return v0
.end method

.method public hasNextEvent()Z
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 122
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/evt/Stax2EventReaderAdapter;->peek()Ljavax/xml/stream/events/XMLEvent;

    move-result-object v0

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method public isPropertySupported(Ljava/lang/String;)Z
    .locals 2
    .param p1, "name"    # Ljava/lang/String;

    .line 133
    :try_start_0
    iget-object v0, p0, Lorg/codehaus/stax2/ri/evt/Stax2EventReaderAdapter;->mReader:Ljavax/xml/stream/XMLEventReader;

    invoke-interface {v0, p1}, Ljavax/xml/stream/XMLEventReader;->getProperty(Ljava/lang/String;)Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/IllegalArgumentException; {:try_start_0 .. :try_end_0} :catch_0

    .line 136
    nop

    .line 137
    const/4 v0, 0x1

    return v0

    .line 134
    :catch_0
    move-exception v0

    .line 135
    .local v0, "iae":Ljava/lang/IllegalArgumentException;
    const/4 v1, 0x0

    return v1
.end method

.method public next()Ljava/lang/Object;
    .locals 1

    .line 92
    iget-object v0, p0, Lorg/codehaus/stax2/ri/evt/Stax2EventReaderAdapter;->mReader:Ljavax/xml/stream/XMLEventReader;

    invoke-interface {v0}, Ljavax/xml/stream/XMLEventReader;->next()Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public nextEvent()Ljavax/xml/stream/events/XMLEvent;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 87
    iget-object v0, p0, Lorg/codehaus/stax2/ri/evt/Stax2EventReaderAdapter;->mReader:Ljavax/xml/stream/XMLEventReader;

    invoke-interface {v0}, Ljavax/xml/stream/XMLEventReader;->nextEvent()Ljavax/xml/stream/events/XMLEvent;

    move-result-object v0

    return-object v0
.end method

.method public nextTag()Ljavax/xml/stream/events/XMLEvent;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 97
    iget-object v0, p0, Lorg/codehaus/stax2/ri/evt/Stax2EventReaderAdapter;->mReader:Ljavax/xml/stream/XMLEventReader;

    invoke-interface {v0}, Ljavax/xml/stream/XMLEventReader;->nextTag()Ljavax/xml/stream/events/XMLEvent;

    move-result-object v0

    return-object v0
.end method

.method public peek()Ljavax/xml/stream/events/XMLEvent;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 102
    iget-object v0, p0, Lorg/codehaus/stax2/ri/evt/Stax2EventReaderAdapter;->mReader:Ljavax/xml/stream/XMLEventReader;

    invoke-interface {v0}, Ljavax/xml/stream/XMLEventReader;->peek()Ljavax/xml/stream/events/XMLEvent;

    move-result-object v0

    return-object v0
.end method

.method public remove()V
    .locals 1

    .line 110
    iget-object v0, p0, Lorg/codehaus/stax2/ri/evt/Stax2EventReaderAdapter;->mReader:Ljavax/xml/stream/XMLEventReader;

    invoke-interface {v0}, Ljavax/xml/stream/XMLEventReader;->remove()V

    .line 111
    return-void
.end method

.method public setProperty(Ljava/lang/String;Ljava/lang/Object;)Z
    .locals 1
    .param p1, "name"    # Ljava/lang/String;
    .param p2, "value"    # Ljava/lang/Object;

    .line 144
    const/4 v0, 0x0

    return v0
.end method
