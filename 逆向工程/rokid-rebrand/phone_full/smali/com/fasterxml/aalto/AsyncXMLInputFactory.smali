.class public abstract Lcom/fasterxml/aalto/AsyncXMLInputFactory;
.super Lorg/codehaus/stax2/XMLInputFactory2;
.source "AsyncXMLInputFactory.java"


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 15
    invoke-direct {p0}, Lorg/codehaus/stax2/XMLInputFactory2;-><init>()V

    return-void
.end method


# virtual methods
.method public abstract createAsyncFor(Ljava/nio/ByteBuffer;)Lcom/fasterxml/aalto/AsyncXMLStreamReader;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/nio/ByteBuffer;",
            ")",
            "Lcom/fasterxml/aalto/AsyncXMLStreamReader<",
            "Lcom/fasterxml/aalto/AsyncByteBufferFeeder;",
            ">;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method

.method public abstract createAsyncFor([B)Lcom/fasterxml/aalto/AsyncXMLStreamReader;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "([B)",
            "Lcom/fasterxml/aalto/AsyncXMLStreamReader<",
            "Lcom/fasterxml/aalto/AsyncByteArrayFeeder;",
            ">;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method

.method public abstract createAsyncFor([BII)Lcom/fasterxml/aalto/AsyncXMLStreamReader;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "([BII)",
            "Lcom/fasterxml/aalto/AsyncXMLStreamReader<",
            "Lcom/fasterxml/aalto/AsyncByteArrayFeeder;",
            ">;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method

.method public abstract createAsyncForByteArray()Lcom/fasterxml/aalto/AsyncXMLStreamReader;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Lcom/fasterxml/aalto/AsyncXMLStreamReader<",
            "Lcom/fasterxml/aalto/AsyncByteArrayFeeder;",
            ">;"
        }
    .end annotation
.end method

.method public abstract createAsyncForByteBuffer()Lcom/fasterxml/aalto/AsyncXMLStreamReader;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Lcom/fasterxml/aalto/AsyncXMLStreamReader<",
            "Lcom/fasterxml/aalto/AsyncByteBufferFeeder;",
            ">;"
        }
    .end annotation
.end method
