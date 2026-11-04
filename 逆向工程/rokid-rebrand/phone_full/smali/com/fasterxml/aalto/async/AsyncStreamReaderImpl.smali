.class public Lcom/fasterxml/aalto/async/AsyncStreamReaderImpl;
.super Lcom/fasterxml/aalto/stax/StreamReaderImpl;
.source "AsyncStreamReaderImpl.java"

# interfaces
.implements Lcom/fasterxml/aalto/AsyncXMLStreamReader;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "<F::",
        "Lcom/fasterxml/aalto/AsyncInputFeeder;",
        ">",
        "Lcom/fasterxml/aalto/stax/StreamReaderImpl;",
        "Lcom/fasterxml/aalto/AsyncXMLStreamReader<",
        "TF;>;"
    }
.end annotation


# instance fields
.field protected final _asyncScanner:Lcom/fasterxml/aalto/async/AsyncByteScanner;


# direct methods
.method public constructor <init>(Lcom/fasterxml/aalto/async/AsyncByteScanner;)V
    .locals 1
    .param p1, "scanner"    # Lcom/fasterxml/aalto/async/AsyncByteScanner;

    .line 20
    .local p0, "this":Lcom/fasterxml/aalto/async/AsyncStreamReaderImpl;, "Lcom/fasterxml/aalto/async/AsyncStreamReaderImpl<TF;>;"
    invoke-direct {p0, p1}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;-><init>(Lcom/fasterxml/aalto/in/XmlScanner;)V

    .line 21
    iput-object p1, p0, Lcom/fasterxml/aalto/async/AsyncStreamReaderImpl;->_asyncScanner:Lcom/fasterxml/aalto/async/AsyncByteScanner;

    .line 22
    const/16 v0, 0x101

    iput v0, p0, Lcom/fasterxml/aalto/async/AsyncStreamReaderImpl;->_currToken:I

    .line 23
    return-void
.end method


# virtual methods
.method protected _reportNonTextEvent(I)V
    .locals 1
    .param p1, "type"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 47
    .local p0, "this":Lcom/fasterxml/aalto/async/AsyncStreamReaderImpl;, "Lcom/fasterxml/aalto/async/AsyncStreamReaderImpl<TF;>;"
    const/16 v0, 0x101

    if-ne p1, v0, :cond_0

    .line 48
    const-string v0, "Can not use text-aggregating methods with non-blocking parser, as they (may) require blocking"

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/async/AsyncStreamReaderImpl;->throwWfe(Ljava/lang/String;)V

    .line 50
    :cond_0
    invoke-super {p0, p1}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_reportNonTextEvent(I)V

    .line 51
    return-void
.end method

.method public getInputFeeder()Lcom/fasterxml/aalto/AsyncInputFeeder;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()TF;"
        }
    .end annotation

    .line 34
    .local p0, "this":Lcom/fasterxml/aalto/async/AsyncStreamReaderImpl;, "Lcom/fasterxml/aalto/async/AsyncStreamReaderImpl<TF;>;"
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncStreamReaderImpl;->_asyncScanner:Lcom/fasterxml/aalto/async/AsyncByteScanner;

    return-object v0
.end method
