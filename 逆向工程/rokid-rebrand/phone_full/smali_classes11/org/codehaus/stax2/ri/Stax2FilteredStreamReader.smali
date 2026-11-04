.class public Lorg/codehaus/stax2/ri/Stax2FilteredStreamReader;
.super Lorg/codehaus/stax2/util/StreamReader2Delegate;
.source "Stax2FilteredStreamReader.java"

# interfaces
.implements Ljavax/xml/stream/XMLStreamConstants;


# instance fields
.field final mFilter:Ljavax/xml/stream/StreamFilter;


# direct methods
.method public constructor <init>(Ljavax/xml/stream/XMLStreamReader;Ljavax/xml/stream/StreamFilter;)V
    .locals 1
    .param p1, "r"    # Ljavax/xml/stream/XMLStreamReader;
    .param p2, "f"    # Ljavax/xml/stream/StreamFilter;

    .line 21
    invoke-static {p1}, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->wrapIfNecessary(Ljavax/xml/stream/XMLStreamReader;)Lorg/codehaus/stax2/XMLStreamReader2;

    move-result-object v0

    invoke-direct {p0, v0}, Lorg/codehaus/stax2/util/StreamReader2Delegate;-><init>(Lorg/codehaus/stax2/XMLStreamReader2;)V

    .line 22
    iput-object p2, p0, Lorg/codehaus/stax2/ri/Stax2FilteredStreamReader;->mFilter:Ljavax/xml/stream/StreamFilter;

    .line 23
    return-void
.end method


# virtual methods
.method public next()I
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 36
    nop

    :cond_0
    iget-object v0, p0, Lorg/codehaus/stax2/ri/Stax2FilteredStreamReader;->_delegate2:Lorg/codehaus/stax2/XMLStreamReader2;

    invoke-interface {v0}, Lorg/codehaus/stax2/XMLStreamReader2;->next()I

    move-result v0

    .line 37
    .local v0, "type":I
    iget-object v1, p0, Lorg/codehaus/stax2/ri/Stax2FilteredStreamReader;->mFilter:Ljavax/xml/stream/StreamFilter;

    invoke-interface {v1, p0}, Ljavax/xml/stream/StreamFilter;->accept(Ljavax/xml/stream/XMLStreamReader;)Z

    move-result v1

    if-eqz v1, :cond_1

    .line 38
    goto :goto_0

    .line 40
    :cond_1
    const/16 v1, 0x8

    if-ne v0, v1, :cond_0

    .line 42
    :goto_0
    return v0
.end method

.method public nextTag()I
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 51
    nop

    :cond_0
    iget-object v0, p0, Lorg/codehaus/stax2/ri/Stax2FilteredStreamReader;->_delegate2:Lorg/codehaus/stax2/XMLStreamReader2;

    invoke-interface {v0}, Lorg/codehaus/stax2/XMLStreamReader2;->nextTag()I

    move-result v0

    .line 52
    .local v0, "type":I
    iget-object v1, p0, Lorg/codehaus/stax2/ri/Stax2FilteredStreamReader;->mFilter:Ljavax/xml/stream/StreamFilter;

    invoke-interface {v1, p0}, Ljavax/xml/stream/StreamFilter;->accept(Ljavax/xml/stream/XMLStreamReader;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 53
    nop

    .line 56
    return v0
.end method
