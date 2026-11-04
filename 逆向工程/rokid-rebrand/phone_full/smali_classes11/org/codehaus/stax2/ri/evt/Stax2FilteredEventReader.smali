.class public Lorg/codehaus/stax2/ri/evt/Stax2FilteredEventReader;
.super Ljava/lang/Object;
.source "Stax2FilteredEventReader.java"

# interfaces
.implements Lorg/codehaus/stax2/XMLEventReader2;
.implements Ljavax/xml/stream/XMLStreamConstants;


# instance fields
.field final mFilter:Ljavax/xml/stream/EventFilter;

.field final mReader:Lorg/codehaus/stax2/XMLEventReader2;


# direct methods
.method public constructor <init>(Lorg/codehaus/stax2/XMLEventReader2;Ljavax/xml/stream/EventFilter;)V
    .locals 0
    .param p1, "r"    # Lorg/codehaus/stax2/XMLEventReader2;
    .param p2, "f"    # Ljavax/xml/stream/EventFilter;

    .line 25
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 26
    iput-object p1, p0, Lorg/codehaus/stax2/ri/evt/Stax2FilteredEventReader;->mReader:Lorg/codehaus/stax2/XMLEventReader2;

    .line 27
    iput-object p2, p0, Lorg/codehaus/stax2/ri/evt/Stax2FilteredEventReader;->mFilter:Ljavax/xml/stream/EventFilter;

    .line 28
    return-void
.end method


# virtual methods
.method public close()V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 39
    iget-object v0, p0, Lorg/codehaus/stax2/ri/evt/Stax2FilteredEventReader;->mReader:Lorg/codehaus/stax2/XMLEventReader2;

    invoke-interface {v0}, Lorg/codehaus/stax2/XMLEventReader2;->close()V

    .line 40
    return-void
.end method

.method public getElementText()Ljava/lang/String;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 46
    iget-object v0, p0, Lorg/codehaus/stax2/ri/evt/Stax2FilteredEventReader;->mReader:Lorg/codehaus/stax2/XMLEventReader2;

    invoke-interface {v0}, Lorg/codehaus/stax2/XMLEventReader2;->getElementText()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getProperty(Ljava/lang/String;)Ljava/lang/Object;
    .locals 1
    .param p1, "name"    # Ljava/lang/String;

    .line 51
    iget-object v0, p0, Lorg/codehaus/stax2/ri/evt/Stax2FilteredEventReader;->mReader:Lorg/codehaus/stax2/XMLEventReader2;

    invoke-interface {v0, p1}, Lorg/codehaus/stax2/XMLEventReader2;->getProperty(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public hasNext()Z
    .locals 2

    .line 58
    :try_start_0
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/evt/Stax2FilteredEventReader;->peek()Ljavax/xml/stream/events/XMLEvent;

    move-result-object v0
    :try_end_0
    .catch Ljavax/xml/stream/XMLStreamException; {:try_start_0 .. :try_end_0} :catch_0

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0

    .line 59
    :catch_0
    move-exception v0

    .line 60
    .local v0, "sex":Ljavax/xml/stream/XMLStreamException;
    new-instance v1, Ljava/lang/RuntimeException;

    invoke-direct {v1, v0}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/Throwable;)V

    throw v1
.end method

.method public hasNextEvent()Z
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 133
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/evt/Stax2FilteredEventReader;->peek()Ljavax/xml/stream/events/XMLEvent;

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
    .locals 1
    .param p1, "name"    # Ljava/lang/String;

    .line 139
    iget-object v0, p0, Lorg/codehaus/stax2/ri/evt/Stax2FilteredEventReader;->mReader:Lorg/codehaus/stax2/XMLEventReader2;

    invoke-interface {v0, p1}, Lorg/codehaus/stax2/XMLEventReader2;->isPropertySupported(Ljava/lang/String;)Z

    move-result v0

    return v0
.end method

.method public next()Ljava/lang/Object;
    .locals 2

    .line 80
    :try_start_0
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/evt/Stax2FilteredEventReader;->nextEvent()Ljavax/xml/stream/events/XMLEvent;

    move-result-object v0
    :try_end_0
    .catch Ljavax/xml/stream/XMLStreamException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    .line 81
    :catch_0
    move-exception v0

    .line 82
    .local v0, "sex":Ljavax/xml/stream/XMLStreamException;
    new-instance v1, Ljava/lang/RuntimeException;

    invoke-direct {v1, v0}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/Throwable;)V

    throw v1
.end method

.method public nextEvent()Ljavax/xml/stream/events/XMLEvent;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 68
    nop

    :goto_0
    iget-object v0, p0, Lorg/codehaus/stax2/ri/evt/Stax2FilteredEventReader;->mReader:Lorg/codehaus/stax2/XMLEventReader2;

    invoke-interface {v0}, Lorg/codehaus/stax2/XMLEventReader2;->nextEvent()Ljavax/xml/stream/events/XMLEvent;

    move-result-object v0

    .line 69
    .local v0, "evt":Ljavax/xml/stream/events/XMLEvent;
    if-eqz v0, :cond_1

    iget-object v1, p0, Lorg/codehaus/stax2/ri/evt/Stax2FilteredEventReader;->mFilter:Ljavax/xml/stream/EventFilter;

    invoke-interface {v1, v0}, Ljavax/xml/stream/EventFilter;->accept(Ljavax/xml/stream/events/XMLEvent;)Z

    move-result v1

    if-eqz v1, :cond_0

    goto :goto_1

    .line 73
    .end local v0    # "evt":Ljavax/xml/stream/events/XMLEvent;
    :cond_0
    goto :goto_0

    .line 71
    .restart local v0    # "evt":Ljavax/xml/stream/events/XMLEvent;
    :cond_1
    :goto_1
    return-object v0
.end method

.method public nextTag()Ljavax/xml/stream/events/XMLEvent;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 92
    nop

    :goto_0
    iget-object v0, p0, Lorg/codehaus/stax2/ri/evt/Stax2FilteredEventReader;->mReader:Lorg/codehaus/stax2/XMLEventReader2;

    invoke-interface {v0}, Lorg/codehaus/stax2/XMLEventReader2;->nextTag()Ljavax/xml/stream/events/XMLEvent;

    move-result-object v0

    .line 93
    .local v0, "evt":Ljavax/xml/stream/events/XMLEvent;
    if-eqz v0, :cond_1

    iget-object v1, p0, Lorg/codehaus/stax2/ri/evt/Stax2FilteredEventReader;->mFilter:Ljavax/xml/stream/EventFilter;

    invoke-interface {v1, v0}, Ljavax/xml/stream/EventFilter;->accept(Ljavax/xml/stream/events/XMLEvent;)Z

    move-result v1

    if-eqz v1, :cond_0

    goto :goto_1

    .line 96
    .end local v0    # "evt":Ljavax/xml/stream/events/XMLEvent;
    :cond_0
    goto :goto_0

    .line 94
    .restart local v0    # "evt":Ljavax/xml/stream/events/XMLEvent;
    :cond_1
    :goto_1
    return-object v0
.end method

.method public peek()Ljavax/xml/stream/events/XMLEvent;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 107
    nop

    :goto_0
    iget-object v0, p0, Lorg/codehaus/stax2/ri/evt/Stax2FilteredEventReader;->mReader:Lorg/codehaus/stax2/XMLEventReader2;

    invoke-interface {v0}, Lorg/codehaus/stax2/XMLEventReader2;->peek()Ljavax/xml/stream/events/XMLEvent;

    move-result-object v0

    .line 108
    .local v0, "evt":Ljavax/xml/stream/events/XMLEvent;
    if-eqz v0, :cond_1

    iget-object v1, p0, Lorg/codehaus/stax2/ri/evt/Stax2FilteredEventReader;->mFilter:Ljavax/xml/stream/EventFilter;

    invoke-interface {v1, v0}, Ljavax/xml/stream/EventFilter;->accept(Ljavax/xml/stream/events/XMLEvent;)Z

    move-result v1

    if-eqz v1, :cond_0

    goto :goto_1

    .line 112
    :cond_0
    iget-object v1, p0, Lorg/codehaus/stax2/ri/evt/Stax2FilteredEventReader;->mReader:Lorg/codehaus/stax2/XMLEventReader2;

    invoke-interface {v1}, Lorg/codehaus/stax2/XMLEventReader2;->nextEvent()Ljavax/xml/stream/events/XMLEvent;

    .line 113
    .end local v0    # "evt":Ljavax/xml/stream/events/XMLEvent;
    goto :goto_0

    .line 109
    .restart local v0    # "evt":Ljavax/xml/stream/events/XMLEvent;
    :cond_1
    :goto_1
    return-object v0
.end method

.method public remove()V
    .locals 1

    .line 121
    iget-object v0, p0, Lorg/codehaus/stax2/ri/evt/Stax2FilteredEventReader;->mReader:Lorg/codehaus/stax2/XMLEventReader2;

    invoke-interface {v0}, Lorg/codehaus/stax2/XMLEventReader2;->remove()V

    .line 122
    return-void
.end method

.method public setProperty(Ljava/lang/String;Ljava/lang/Object;)Z
    .locals 1
    .param p1, "name"    # Ljava/lang/String;
    .param p2, "value"    # Ljava/lang/Object;

    .line 145
    iget-object v0, p0, Lorg/codehaus/stax2/ri/evt/Stax2FilteredEventReader;->mReader:Lorg/codehaus/stax2/XMLEventReader2;

    invoke-interface {v0, p1, p2}, Lorg/codehaus/stax2/XMLEventReader2;->setProperty(Ljava/lang/String;Ljava/lang/Object;)Z

    move-result v0

    return v0
.end method
