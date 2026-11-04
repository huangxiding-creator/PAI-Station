.class public Lorg/codehaus/stax2/ri/evt/ProcInstrEventImpl;
.super Lorg/codehaus/stax2/ri/evt/BaseEventImpl;
.source "ProcInstrEventImpl.java"

# interfaces
.implements Ljavax/xml/stream/events/ProcessingInstruction;


# instance fields
.field final mData:Ljava/lang/String;

.field final mTarget:Ljava/lang/String;


# direct methods
.method public constructor <init>(Ljavax/xml/stream/Location;Ljava/lang/String;Ljava/lang/String;)V
    .locals 0
    .param p1, "loc"    # Ljavax/xml/stream/Location;
    .param p2, "target"    # Ljava/lang/String;
    .param p3, "data"    # Ljava/lang/String;

    .line 20
    invoke-direct {p0, p1}, Lorg/codehaus/stax2/ri/evt/BaseEventImpl;-><init>(Ljavax/xml/stream/Location;)V

    .line 21
    iput-object p2, p0, Lorg/codehaus/stax2/ri/evt/ProcInstrEventImpl;->mTarget:Ljava/lang/String;

    .line 22
    iput-object p3, p0, Lorg/codehaus/stax2/ri/evt/ProcInstrEventImpl;->mData:Ljava/lang/String;

    .line 23
    return-void
.end method


# virtual methods
.method public equals(Ljava/lang/Object;)Z
    .locals 5
    .param p1, "o"    # Ljava/lang/Object;

    .line 86
    const/4 v0, 0x1

    if-ne p1, p0, :cond_0

    return v0

    .line 87
    :cond_0
    const/4 v1, 0x0

    if-nez p1, :cond_1

    return v1

    .line 89
    :cond_1
    instance-of v2, p1, Ljavax/xml/stream/events/ProcessingInstruction;

    if-nez v2, :cond_2

    return v1

    .line 91
    :cond_2
    move-object v2, p1

    check-cast v2, Ljavax/xml/stream/events/ProcessingInstruction;

    .line 92
    .local v2, "other":Ljavax/xml/stream/events/ProcessingInstruction;
    iget-object v3, p0, Lorg/codehaus/stax2/ri/evt/ProcInstrEventImpl;->mTarget:Ljava/lang/String;

    invoke-interface {v2}, Ljavax/xml/stream/events/ProcessingInstruction;->getTarget()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_3

    iget-object v3, p0, Lorg/codehaus/stax2/ri/evt/ProcInstrEventImpl;->mData:Ljava/lang/String;

    .line 93
    invoke-interface {v2}, Ljavax/xml/stream/events/ProcessingInstruction;->getData()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Lorg/codehaus/stax2/ri/evt/ProcInstrEventImpl;->stringsWithNullsEqual(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_3

    goto :goto_0

    :cond_3
    move v0, v1

    .line 92
    :goto_0
    return v0
.end method

.method public getData()Ljava/lang/String;
    .locals 1

    .line 27
    iget-object v0, p0, Lorg/codehaus/stax2/ri/evt/ProcInstrEventImpl;->mData:Ljava/lang/String;

    return-object v0
.end method

.method public getEventType()I
    .locals 1

    .line 43
    const/4 v0, 0x3

    return v0
.end method

.method public getTarget()Ljava/lang/String;
    .locals 1

    .line 32
    iget-object v0, p0, Lorg/codehaus/stax2/ri/evt/ProcInstrEventImpl;->mTarget:Ljava/lang/String;

    return-object v0
.end method

.method public hashCode()I
    .locals 2

    .line 99
    iget-object v0, p0, Lorg/codehaus/stax2/ri/evt/ProcInstrEventImpl;->mTarget:Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/String;->hashCode()I

    move-result v0

    .line 100
    .local v0, "hash":I
    iget-object v1, p0, Lorg/codehaus/stax2/ri/evt/ProcInstrEventImpl;->mData:Ljava/lang/String;

    if-eqz v1, :cond_0

    .line 101
    iget-object v1, p0, Lorg/codehaus/stax2/ri/evt/ProcInstrEventImpl;->mData:Ljava/lang/String;

    invoke-virtual {v1}, Ljava/lang/String;->hashCode()I

    move-result v1

    xor-int/2addr v0, v1

    .line 103
    :cond_0
    return v0
.end method

.method public isProcessingInstruction()Z
    .locals 1

    .line 48
    const/4 v0, 0x1

    return v0
.end method

.method public writeAsEncodedUnicode(Ljava/io/Writer;)V
    .locals 1
    .param p1, "w"    # Ljava/io/Writer;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 56
    :try_start_0
    const-string v0, "<?"

    invoke-virtual {p1, v0}, Ljava/io/Writer;->write(Ljava/lang/String;)V

    .line 57
    iget-object v0, p0, Lorg/codehaus/stax2/ri/evt/ProcInstrEventImpl;->mTarget:Ljava/lang/String;

    invoke-virtual {p1, v0}, Ljava/io/Writer;->write(Ljava/lang/String;)V

    .line 58
    iget-object v0, p0, Lorg/codehaus/stax2/ri/evt/ProcInstrEventImpl;->mData:Ljava/lang/String;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lorg/codehaus/stax2/ri/evt/ProcInstrEventImpl;->mData:Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v0

    if-lez v0, :cond_0

    .line 59
    iget-object v0, p0, Lorg/codehaus/stax2/ri/evt/ProcInstrEventImpl;->mData:Ljava/lang/String;

    invoke-virtual {p1, v0}, Ljava/io/Writer;->write(Ljava/lang/String;)V

    .line 61
    :cond_0
    const-string v0, "?>"

    invoke-virtual {p1, v0}, Ljava/io/Writer;->write(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 64
    goto :goto_0

    .line 62
    :catch_0
    move-exception v0

    .line 63
    .local v0, "ie":Ljava/io/IOException;
    invoke-virtual {p0, v0}, Lorg/codehaus/stax2/ri/evt/ProcInstrEventImpl;->throwFromIOE(Ljava/io/IOException;)V

    .line 65
    .end local v0    # "ie":Ljava/io/IOException;
    :goto_0
    return-void
.end method

.method public writeUsing(Lorg/codehaus/stax2/XMLStreamWriter2;)V
    .locals 2
    .param p1, "w"    # Lorg/codehaus/stax2/XMLStreamWriter2;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 70
    iget-object v0, p0, Lorg/codehaus/stax2/ri/evt/ProcInstrEventImpl;->mData:Ljava/lang/String;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lorg/codehaus/stax2/ri/evt/ProcInstrEventImpl;->mData:Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v0

    if-lez v0, :cond_0

    .line 71
    iget-object v0, p0, Lorg/codehaus/stax2/ri/evt/ProcInstrEventImpl;->mTarget:Ljava/lang/String;

    iget-object v1, p0, Lorg/codehaus/stax2/ri/evt/ProcInstrEventImpl;->mData:Ljava/lang/String;

    invoke-interface {p1, v0, v1}, Lorg/codehaus/stax2/XMLStreamWriter2;->writeProcessingInstruction(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_0

    .line 73
    :cond_0
    iget-object v0, p0, Lorg/codehaus/stax2/ri/evt/ProcInstrEventImpl;->mTarget:Ljava/lang/String;

    invoke-interface {p1, v0}, Lorg/codehaus/stax2/XMLStreamWriter2;->writeProcessingInstruction(Ljava/lang/String;)V

    .line 75
    :goto_0
    return-void
.end method
