.class public abstract Lcom/fasterxml/aalto/out/StreamWriterBase;
.super Lorg/codehaus/stax2/ri/Stax2WriterImpl;
.source "StreamWriterBase.java"

# interfaces
.implements Ljavax/xml/namespace/NamespaceContext;
.implements Lorg/codehaus/stax2/validation/ValidationContext;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/fasterxml/aalto/out/StreamWriterBase$State;
    }
.end annotation


# static fields
.field static final MAX_POOL_SIZE:I = 0x8


# instance fields
.field protected final _cfgCDataAsText:Z

.field protected _cfgCheckAttrs:Z

.field protected _cfgCheckContent:Z

.field protected _cfgCheckStructure:Z

.field protected final _config:Lcom/fasterxml/aalto/out/WriterConfig;

.field protected _currElem:Lcom/fasterxml/aalto/out/OutputElement;

.field protected _dtdRootElemName:Ljava/lang/String;

.field protected _outputElemPool:Lcom/fasterxml/aalto/out/OutputElement;

.field protected _poolSize:I

.field protected _rootNsContext:Ljavax/xml/namespace/NamespaceContext;

.field protected _state:Lcom/fasterxml/aalto/out/StreamWriterBase$State;

.field protected _stateAnyOutput:Z

.field protected _stateEmptyElement:Z

.field protected _stateStartElementOpen:Z

.field protected _symbols:Lcom/fasterxml/aalto/out/WNameTable;

.field protected _validator:Lorg/codehaus/stax2/validation/XMLValidator;

.field protected _valueEncoderFactory:Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory;

.field protected _vldContent:I

.field protected _vldProblemHandler:Lorg/codehaus/stax2/validation/ValidationProblemHandler;

.field protected final _xmlWriter:Lcom/fasterxml/aalto/out/XmlWriter;


# direct methods
.method protected constructor <init>(Lcom/fasterxml/aalto/out/WriterConfig;Lcom/fasterxml/aalto/out/XmlWriter;Lcom/fasterxml/aalto/out/WNameTable;)V
    .locals 2
    .param p1, "cfg"    # Lcom/fasterxml/aalto/out/WriterConfig;
    .param p2, "writer"    # Lcom/fasterxml/aalto/out/XmlWriter;
    .param p3, "symbols"    # Lcom/fasterxml/aalto/out/WNameTable;

    .line 217
    invoke-direct {p0}, Lorg/codehaus/stax2/ri/Stax2WriterImpl;-><init>()V

    .line 120
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_validator:Lorg/codehaus/stax2/validation/XMLValidator;

    .line 128
    const/4 v1, 0x4

    iput v1, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_vldContent:I

    .line 133
    iput-object v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_vldProblemHandler:Lorg/codehaus/stax2/validation/ValidationProblemHandler;

    .line 141
    sget-object v1, Lcom/fasterxml/aalto/out/StreamWriterBase$State;->PROLOG:Lcom/fasterxml/aalto/out/StreamWriterBase$State;

    iput-object v1, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_state:Lcom/fasterxml/aalto/out/StreamWriterBase$State;

    .line 149
    invoke-static {}, Lcom/fasterxml/aalto/out/OutputElement;->createRoot()Lcom/fasterxml/aalto/out/OutputElement;

    move-result-object v1

    iput-object v1, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_currElem:Lcom/fasterxml/aalto/out/OutputElement;

    .line 156
    const/4 v1, 0x0

    iput-boolean v1, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_stateAnyOutput:Z

    .line 164
    iput-boolean v1, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_stateStartElementOpen:Z

    .line 174
    iput-boolean v1, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_stateEmptyElement:Z

    .line 183
    iput-object v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_dtdRootElemName:Ljava/lang/String;

    .line 197
    iput-object v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_outputElemPool:Lcom/fasterxml/aalto/out/OutputElement;

    .line 207
    iput v1, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_poolSize:I

    .line 218
    iput-object p1, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_config:Lcom/fasterxml/aalto/out/WriterConfig;

    .line 219
    iput-object p2, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_xmlWriter:Lcom/fasterxml/aalto/out/XmlWriter;

    .line 220
    iput-object p3, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_symbols:Lcom/fasterxml/aalto/out/WNameTable;

    .line 225
    invoke-virtual {p1}, Lcom/fasterxml/aalto/out/WriterConfig;->willCheckStructure()Z

    move-result v0

    iput-boolean v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_cfgCheckStructure:Z

    .line 226
    invoke-virtual {p1}, Lcom/fasterxml/aalto/out/WriterConfig;->willCheckContent()Z

    move-result v0

    iput-boolean v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_cfgCheckContent:Z

    .line 227
    invoke-virtual {p1}, Lcom/fasterxml/aalto/out/WriterConfig;->willCheckAttributes()Z

    move-result v0

    iput-boolean v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_cfgCheckAttrs:Z

    .line 228
    iput-boolean v1, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_cfgCDataAsText:Z

    .line 229
    return-void
.end method

.method private final _finishDocument(Z)V
    .locals 2
    .param p1, "forceRealClose"    # Z
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1810
    iget-object v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_state:Lcom/fasterxml/aalto/out/StreamWriterBase$State;

    sget-object v1, Lcom/fasterxml/aalto/out/StreamWriterBase$State;->EPILOG:Lcom/fasterxml/aalto/out/StreamWriterBase$State;

    if-eq v0, v1, :cond_2

    .line 1811
    iget-boolean v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_cfgCheckStructure:Z

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_state:Lcom/fasterxml/aalto/out/StreamWriterBase$State;

    sget-object v1, Lcom/fasterxml/aalto/out/StreamWriterBase$State;->PROLOG:Lcom/fasterxml/aalto/out/StreamWriterBase$State;

    if-ne v0, v1, :cond_0

    .line 1812
    sget-object v0, Lcom/fasterxml/aalto/impl/ErrorConsts;->WERR_PROLOG_NO_ROOT:Ljava/lang/String;

    invoke-static {v0}, Lcom/fasterxml/aalto/out/StreamWriterBase;->_reportNwfStructure(Ljava/lang/String;)V

    .line 1816
    :cond_0
    iget-boolean v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_stateStartElementOpen:Z

    if-eqz v0, :cond_1

    .line 1817
    iget-boolean v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_stateEmptyElement:Z

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/out/StreamWriterBase;->_closeStartElement(Z)V

    .line 1820
    :cond_1
    :goto_0
    iget-object v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_state:Lcom/fasterxml/aalto/out/StreamWriterBase$State;

    sget-object v1, Lcom/fasterxml/aalto/out/StreamWriterBase$State;->EPILOG:Lcom/fasterxml/aalto/out/StreamWriterBase$State;

    if-eq v0, v1, :cond_2

    .line 1821
    invoke-virtual {p0}, Lcom/fasterxml/aalto/out/StreamWriterBase;->writeEndElement()V

    goto :goto_0

    .line 1826
    :cond_2
    iget-object v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_symbols:Lcom/fasterxml/aalto/out/WNameTable;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/out/WNameTable;->maybeDirty()Z

    move-result v0

    if-eqz v0, :cond_3

    .line 1827
    iget-object v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_symbols:Lcom/fasterxml/aalto/out/WNameTable;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/out/WNameTable;->mergeToParent()Z

    .line 1834
    :cond_3
    :try_start_0
    iget-object v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_xmlWriter:Lcom/fasterxml/aalto/out/XmlWriter;

    invoke-virtual {v0, p1}, Lcom/fasterxml/aalto/out/XmlWriter;->close(Z)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 1837
    nop

    .line 1838
    return-void

    .line 1835
    :catch_0
    move-exception v0

    .line 1836
    .local v0, "ie":Ljava/io/IOException;
    new-instance v1, Lcom/fasterxml/aalto/impl/IoStreamException;

    invoke-direct {v1, v0}, Lcom/fasterxml/aalto/impl/IoStreamException;-><init>(Ljava/io/IOException;)V

    throw v1
.end method

.method protected static _reportNwfAttr(Ljava/lang/String;)V
    .locals 0
    .param p0, "msg"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1727
    invoke-static {p0}, Lcom/fasterxml/aalto/out/StreamWriterBase;->throwOutputError(Ljava/lang/String;)V

    .line 1728
    return-void
.end method

.method protected static _reportNwfAttr(Ljava/lang/String;Ljava/lang/Object;)V
    .locals 0
    .param p0, "msg"    # Ljava/lang/String;
    .param p1, "arg"    # Ljava/lang/Object;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1733
    invoke-static {p0, p1}, Lcom/fasterxml/aalto/out/StreamWriterBase;->throwOutputError(Ljava/lang/String;Ljava/lang/Object;)V

    .line 1734
    return-void
.end method

.method protected static _reportNwfContent(Ljava/lang/String;)V
    .locals 0
    .param p0, "msg"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1709
    invoke-static {p0}, Lcom/fasterxml/aalto/out/StreamWriterBase;->throwOutputError(Ljava/lang/String;)V

    .line 1710
    return-void
.end method

.method protected static _reportNwfContent(Ljava/lang/String;Ljava/lang/Object;)V
    .locals 0
    .param p0, "msg"    # Ljava/lang/String;
    .param p1, "arg"    # Ljava/lang/Object;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1715
    invoke-static {p0, p1}, Lcom/fasterxml/aalto/out/StreamWriterBase;->throwOutputError(Ljava/lang/String;Ljava/lang/Object;)V

    .line 1716
    return-void
.end method

.method protected static _reportNwfName(Ljava/lang/String;)V
    .locals 0
    .param p0, "msg"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1739
    invoke-static {p0}, Lcom/fasterxml/aalto/out/StreamWriterBase;->throwOutputError(Ljava/lang/String;)V

    .line 1740
    return-void
.end method

.method protected static _reportNwfStructure(Ljava/lang/String;)V
    .locals 0
    .param p0, "msg"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1691
    invoke-static {p0}, Lcom/fasterxml/aalto/out/StreamWriterBase;->throwOutputError(Ljava/lang/String;)V

    .line 1692
    return-void
.end method

.method protected static _reportNwfStructure(Ljava/lang/String;Ljava/lang/Object;)V
    .locals 0
    .param p0, "msg"    # Ljava/lang/String;
    .param p1, "arg"    # Ljava/lang/Object;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1697
    invoke-static {p0, p1}, Lcom/fasterxml/aalto/out/StreamWriterBase;->throwOutputError(Ljava/lang/String;Ljava/lang/Object;)V

    .line 1698
    return-void
.end method

.method protected static reportIllegalArg(Ljava/lang/String;)V
    .locals 1
    .param p0, "msg"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/IllegalArgumentException;
        }
    .end annotation

    .line 1751
    new-instance v0, Ljava/lang/IllegalArgumentException;

    invoke-direct {v0, p0}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method protected static reportIllegalMethod(Ljava/lang/String;)V
    .locals 0
    .param p0, "msg"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1679
    invoke-static {p0}, Lcom/fasterxml/aalto/out/StreamWriterBase;->throwOutputError(Ljava/lang/String;)V

    .line 1680
    return-void
.end method

.method private resetValidationFlags()V
    .locals 1

    .line 1125
    iget-object v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_config:Lcom/fasterxml/aalto/out/WriterConfig;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/out/WriterConfig;->willCheckStructure()Z

    move-result v0

    iput-boolean v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_cfgCheckStructure:Z

    .line 1126
    iget-object v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_config:Lcom/fasterxml/aalto/out/WriterConfig;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/out/WriterConfig;->willCheckAttributes()Z

    move-result v0

    iput-boolean v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_cfgCheckAttrs:Z

    .line 1127
    return-void
.end method

.method protected static throwFromIOE(Ljava/io/IOException;)V
    .locals 1
    .param p0, "ioe"    # Ljava/io/IOException;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1745
    new-instance v0, Lcom/fasterxml/aalto/impl/IoStreamException;

    invoke-direct {v0, p0}, Lcom/fasterxml/aalto/impl/IoStreamException;-><init>(Ljava/io/IOException;)V

    throw v0
.end method

.method protected static throwOutputError(Ljava/lang/String;)V
    .locals 1
    .param p0, "msg"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1662
    new-instance v0, Lcom/fasterxml/aalto/impl/StreamExceptionBase;

    invoke-direct {v0, p0}, Lcom/fasterxml/aalto/impl/StreamExceptionBase;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method protected static throwOutputError(Ljava/lang/String;Ljava/lang/Object;)V
    .locals 1
    .param p0, "format"    # Ljava/lang/String;
    .param p1, "arg"    # Ljava/lang/Object;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1668
    filled-new-array {p1}, [Ljava/lang/Object;

    move-result-object v0

    invoke-static {p0, v0}, Ljava/text/MessageFormat;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    .line 1669
    .local v0, "msg":Ljava/lang/String;
    invoke-static {v0}, Lcom/fasterxml/aalto/out/StreamWriterBase;->throwOutputError(Ljava/lang/String;)V

    .line 1670
    return-void
.end method

.method private final writeTypedElement(Lorg/codehaus/stax2/ri/typed/AsciiValueEncoder;)V
    .locals 2
    .param p1, "enc"    # Lorg/codehaus/stax2/ri/typed/AsciiValueEncoder;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 853
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_stateAnyOutput:Z

    .line 854
    iget-boolean v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_stateStartElementOpen:Z

    if-eqz v0, :cond_0

    .line 855
    iget-boolean v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_stateEmptyElement:Z

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/out/StreamWriterBase;->_closeStartElement(Z)V

    .line 858
    :cond_0
    :try_start_0
    iget-object v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_xmlWriter:Lcom/fasterxml/aalto/out/XmlWriter;

    invoke-virtual {v0, p1}, Lcom/fasterxml/aalto/out/XmlWriter;->writeTypedValue(Lorg/codehaus/stax2/ri/typed/AsciiValueEncoder;)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 861
    nop

    .line 862
    return-void

    .line 859
    :catch_0
    move-exception v0

    .line 860
    .local v0, "ioe":Ljava/io/IOException;
    new-instance v1, Lcom/fasterxml/aalto/impl/IoStreamException;

    invoke-direct {v1, v0}, Lcom/fasterxml/aalto/impl/IoStreamException;-><init>(Ljava/io/IOException;)V

    throw v1
.end method


# virtual methods
.method protected _closeStartElement(Z)V
    .locals 3
    .param p1, "emptyElem"    # Z
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1386
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_stateStartElementOpen:Z

    .line 1388
    if-eqz p1, :cond_0

    .line 1389
    :try_start_0
    iget-object v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_xmlWriter:Lcom/fasterxml/aalto/out/XmlWriter;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/out/XmlWriter;->writeStartTagEmptyEnd()V

    goto :goto_0

    .line 1391
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_xmlWriter:Lcom/fasterxml/aalto/out/XmlWriter;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/out/XmlWriter;->writeStartTagEnd()V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 1395
    :goto_0
    nop

    .line 1398
    if-eqz p1, :cond_2

    .line 1399
    iget-object v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_currElem:Lcom/fasterxml/aalto/out/OutputElement;

    .line 1400
    .local v0, "thisElem":Lcom/fasterxml/aalto/out/OutputElement;
    invoke-virtual {v0}, Lcom/fasterxml/aalto/out/OutputElement;->getParent()Lcom/fasterxml/aalto/out/OutputElement;

    move-result-object v1

    iput-object v1, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_currElem:Lcom/fasterxml/aalto/out/OutputElement;

    .line 1401
    iget-object v1, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_currElem:Lcom/fasterxml/aalto/out/OutputElement;

    invoke-virtual {v1}, Lcom/fasterxml/aalto/out/OutputElement;->isRoot()Z

    move-result v1

    if-eqz v1, :cond_1

    .line 1402
    sget-object v1, Lcom/fasterxml/aalto/out/StreamWriterBase$State;->EPILOG:Lcom/fasterxml/aalto/out/StreamWriterBase$State;

    iput-object v1, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_state:Lcom/fasterxml/aalto/out/StreamWriterBase$State;

    .line 1404
    :cond_1
    iget v1, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_poolSize:I

    const/16 v2, 0x8

    if-ge v1, v2, :cond_2

    .line 1405
    iget-object v1, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_outputElemPool:Lcom/fasterxml/aalto/out/OutputElement;

    invoke-virtual {v0, v1}, Lcom/fasterxml/aalto/out/OutputElement;->addToPool(Lcom/fasterxml/aalto/out/OutputElement;)V

    .line 1406
    iput-object v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_outputElemPool:Lcom/fasterxml/aalto/out/OutputElement;

    .line 1407
    iget v1, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_poolSize:I

    add-int/lit8 v1, v1, 0x1

    iput v1, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_poolSize:I

    .line 1410
    .end local v0    # "thisElem":Lcom/fasterxml/aalto/out/OutputElement;
    :cond_2
    return-void

    .line 1393
    :catch_0
    move-exception v0

    .line 1394
    .local v0, "ioe":Ljava/io/IOException;
    new-instance v1, Lcom/fasterxml/aalto/impl/IoStreamException;

    invoke-direct {v1, v0}, Lcom/fasterxml/aalto/impl/IoStreamException;-><init>(Ljava/io/IOException;)V

    throw v1
.end method

.method protected _reportInvalidContent(I)V
    .locals 3
    .param p1, "evtType"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1771
    iget v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_vldContent:I

    packed-switch v0, :pswitch_data_0

    .line 1789
    :pswitch_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Internal error: trying to report invalid content for "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/out/StreamWriterBase;->_reportValidationProblem(Ljava/lang/String;)V

    goto :goto_0

    .line 1785
    :pswitch_1
    sget-object v0, Lcom/fasterxml/aalto/impl/ErrorConsts;->VERR_ANY:Ljava/lang/String;

    iget-object v1, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_currElem:Lcom/fasterxml/aalto/out/OutputElement;

    .line 1786
    invoke-virtual {v1}, Lcom/fasterxml/aalto/out/OutputElement;->getNameDesc()Ljava/lang/String;

    move-result-object v1

    invoke-static {p1}, Lcom/fasterxml/aalto/impl/ErrorConsts;->tokenTypeDesc(I)Ljava/lang/String;

    move-result-object v2

    filled-new-array {v1, v2}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Ljava/text/MessageFormat;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    .line 1785
    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/out/StreamWriterBase;->_reportValidationProblem(Ljava/lang/String;)V

    .line 1787
    goto :goto_0

    .line 1777
    :pswitch_2
    sget-object v0, Lcom/fasterxml/aalto/impl/ErrorConsts;->VERR_NON_MIXED:Ljava/lang/String;

    iget-object v1, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_currElem:Lcom/fasterxml/aalto/out/OutputElement;

    .line 1778
    invoke-virtual {v1}, Lcom/fasterxml/aalto/out/OutputElement;->getNameDesc()Ljava/lang/String;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Ljava/text/MessageFormat;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    .line 1777
    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/out/StreamWriterBase;->_reportValidationProblem(Ljava/lang/String;)V

    .line 1779
    goto :goto_0

    .line 1773
    :pswitch_3
    sget-object v0, Lcom/fasterxml/aalto/impl/ErrorConsts;->VERR_EMPTY:Ljava/lang/String;

    iget-object v1, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_currElem:Lcom/fasterxml/aalto/out/OutputElement;

    .line 1774
    invoke-virtual {v1}, Lcom/fasterxml/aalto/out/OutputElement;->getNameDesc()Ljava/lang/String;

    move-result-object v1

    invoke-static {p1}, Lcom/fasterxml/aalto/impl/ErrorConsts;->tokenTypeDesc(I)Ljava/lang/String;

    move-result-object v2

    filled-new-array {v1, v2}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Ljava/text/MessageFormat;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    .line 1773
    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/out/StreamWriterBase;->_reportValidationProblem(Ljava/lang/String;)V

    .line 1775
    nop

    .line 1791
    :goto_0
    return-void

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_3
        :pswitch_2
        :pswitch_0
        :pswitch_1
        :pswitch_1
    .end packed-switch
.end method

.method public _reportValidationProblem(Ljava/lang/String;)V
    .locals 3
    .param p1, "msg"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1795
    new-instance v0, Lorg/codehaus/stax2/validation/XMLValidationProblem;

    invoke-virtual {p0}, Lcom/fasterxml/aalto/out/StreamWriterBase;->getValidationLocation()Ljavax/xml/stream/Location;

    move-result-object v1

    const/4 v2, 0x2

    invoke-direct {v0, v1, p1, v2}, Lorg/codehaus/stax2/validation/XMLValidationProblem;-><init>(Ljavax/xml/stream/Location;Ljava/lang/String;I)V

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/out/StreamWriterBase;->reportProblem(Lorg/codehaus/stax2/validation/XMLValidationProblem;)V

    .line 1798
    return-void
.end method

.method protected abstract _serializeQName(Ljavax/xml/namespace/QName;)Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method

.method protected abstract _setPrefix(Ljava/lang/String;Ljava/lang/String;)V
.end method

.method protected _verifyRootElement(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1
    .param p1, "prefix"    # Ljava/lang/String;
    .param p2, "localName"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/codehaus/stax2/validation/XMLValidationException;
        }
    .end annotation

    .line 1650
    sget-object v0, Lcom/fasterxml/aalto/out/StreamWriterBase$State;->TREE:Lcom/fasterxml/aalto/out/StreamWriterBase$State;

    iput-object v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_state:Lcom/fasterxml/aalto/out/StreamWriterBase$State;

    .line 1651
    return-void
.end method

.method protected _verifyStartElement(Ljava/lang/String;Ljava/lang/String;)V
    .locals 2
    .param p1, "prefix"    # Ljava/lang/String;
    .param p2, "localName"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1599
    iget-boolean v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_stateStartElementOpen:Z

    if-eqz v0, :cond_0

    .line 1600
    iget-boolean v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_stateEmptyElement:Z

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/out/StreamWriterBase;->_closeStartElement(Z)V

    goto :goto_1

    .line 1601
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_state:Lcom/fasterxml/aalto/out/StreamWriterBase$State;

    sget-object v1, Lcom/fasterxml/aalto/out/StreamWriterBase$State;->PROLOG:Lcom/fasterxml/aalto/out/StreamWriterBase$State;

    if-ne v0, v1, :cond_1

    .line 1602
    invoke-virtual {p0, p1, p2}, Lcom/fasterxml/aalto/out/StreamWriterBase;->_verifyRootElement(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_1

    .line 1603
    :cond_1
    iget-object v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_state:Lcom/fasterxml/aalto/out/StreamWriterBase$State;

    sget-object v1, Lcom/fasterxml/aalto/out/StreamWriterBase$State;->EPILOG:Lcom/fasterxml/aalto/out/StreamWriterBase$State;

    if-ne v0, v1, :cond_4

    .line 1604
    iget-boolean v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_cfgCheckStructure:Z

    if-eqz v0, :cond_3

    .line 1605
    if-nez p1, :cond_2

    move-object v0, p2

    goto :goto_0

    :cond_2
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ":"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 1606
    .local v0, "name":Ljava/lang/String;
    :goto_0
    sget-object v1, Lcom/fasterxml/aalto/impl/ErrorConsts;->WERR_PROLOG_SECOND_ROOT:Ljava/lang/String;

    invoke-static {v1, v0}, Lcom/fasterxml/aalto/out/StreamWriterBase;->_reportNwfStructure(Ljava/lang/String;Ljava/lang/Object;)V

    .line 1611
    .end local v0    # "name":Ljava/lang/String;
    :cond_3
    sget-object v0, Lcom/fasterxml/aalto/out/StreamWriterBase$State;->TREE:Lcom/fasterxml/aalto/out/StreamWriterBase$State;

    iput-object v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_state:Lcom/fasterxml/aalto/out/StreamWriterBase$State;

    .line 1613
    :cond_4
    :goto_1
    return-void
.end method

.method protected final _verifyWriteAttr(Lcom/fasterxml/aalto/out/WName;)V
    .locals 0
    .param p1, "name"    # Lcom/fasterxml/aalto/out/WName;

    .line 1584
    return-void
.end method

.method protected final _verifyWriteCData()V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1618
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_stateAnyOutput:Z

    .line 1619
    iget-boolean v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_stateStartElementOpen:Z

    if-eqz v0, :cond_0

    .line 1620
    iget-boolean v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_stateEmptyElement:Z

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/out/StreamWriterBase;->_closeStartElement(Z)V

    .line 1624
    :cond_0
    iget-boolean v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_cfgCheckStructure:Z

    if-eqz v0, :cond_1

    .line 1625
    invoke-virtual {p0}, Lcom/fasterxml/aalto/out/StreamWriterBase;->inPrologOrEpilog()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 1626
    sget-object v0, Lcom/fasterxml/aalto/impl/ErrorConsts;->WERR_PROLOG_CDATA:Ljava/lang/String;

    invoke-static {v0}, Lcom/fasterxml/aalto/out/StreamWriterBase;->_reportNwfStructure(Ljava/lang/String;)V

    .line 1629
    :cond_1
    return-void
.end method

.method protected final _verifyWriteDTD()V
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1634
    iget-boolean v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_cfgCheckStructure:Z

    if-eqz v0, :cond_2

    .line 1635
    iget-object v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_state:Lcom/fasterxml/aalto/out/StreamWriterBase$State;

    sget-object v1, Lcom/fasterxml/aalto/out/StreamWriterBase$State;->PROLOG:Lcom/fasterxml/aalto/out/StreamWriterBase$State;

    if-ne v0, v1, :cond_1

    .line 1639
    iget-object v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_dtdRootElemName:Ljava/lang/String;

    if-nez v0, :cond_0

    goto :goto_0

    .line 1640
    :cond_0
    new-instance v0, Ljavax/xml/stream/XMLStreamException;

    const-string v1, "Trying to write multiple DOCTYPE declarations"

    invoke-direct {v0, v1}, Ljavax/xml/stream/XMLStreamException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 1636
    :cond_1
    new-instance v0, Ljavax/xml/stream/XMLStreamException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Can not write DOCTYPE declaration (DTD) when not in prolog any more (state "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_state:Lcom/fasterxml/aalto/out/StreamWriterBase$State;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "; start element(s) written)"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljavax/xml/stream/XMLStreamException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 1643
    :cond_2
    :goto_0
    return-void
.end method

.method protected final _writeAttribute(Lcom/fasterxml/aalto/out/WName;Ljava/lang/String;)V
    .locals 2
    .param p1, "name"    # Lcom/fasterxml/aalto/out/WName;
    .param p2, "value"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1433
    iget-boolean v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_cfgCheckAttrs:Z

    if-eqz v0, :cond_0

    .line 1434
    invoke-virtual {p0, p1}, Lcom/fasterxml/aalto/out/StreamWriterBase;->_verifyWriteAttr(Lcom/fasterxml/aalto/out/WName;)V

    .line 1437
    :cond_0
    :try_start_0
    iget-object v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_xmlWriter:Lcom/fasterxml/aalto/out/XmlWriter;

    invoke-virtual {v0, p1, p2}, Lcom/fasterxml/aalto/out/XmlWriter;->writeAttribute(Lcom/fasterxml/aalto/out/WName;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 1440
    nop

    .line 1441
    return-void

    .line 1438
    :catch_0
    move-exception v0

    .line 1439
    .local v0, "ioe":Ljava/io/IOException;
    new-instance v1, Lcom/fasterxml/aalto/impl/IoStreamException;

    invoke-direct {v1, v0}, Lcom/fasterxml/aalto/impl/IoStreamException;-><init>(Ljava/io/IOException;)V

    throw v1
.end method

.method protected final _writeAttribute(Lcom/fasterxml/aalto/out/WName;Lorg/codehaus/stax2/ri/typed/AsciiValueEncoder;)V
    .locals 2
    .param p1, "name"    # Lcom/fasterxml/aalto/out/WName;
    .param p2, "enc"    # Lorg/codehaus/stax2/ri/typed/AsciiValueEncoder;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1446
    iget-boolean v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_cfgCheckAttrs:Z

    if-eqz v0, :cond_0

    .line 1447
    invoke-virtual {p0, p1}, Lcom/fasterxml/aalto/out/StreamWriterBase;->_verifyWriteAttr(Lcom/fasterxml/aalto/out/WName;)V

    .line 1450
    :cond_0
    :try_start_0
    iget-object v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_xmlWriter:Lcom/fasterxml/aalto/out/XmlWriter;

    invoke-virtual {v0, p1, p2}, Lcom/fasterxml/aalto/out/XmlWriter;->writeAttribute(Lcom/fasterxml/aalto/out/WName;Lorg/codehaus/stax2/ri/typed/AsciiValueEncoder;)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 1453
    nop

    .line 1454
    return-void

    .line 1451
    :catch_0
    move-exception v0

    .line 1452
    .local v0, "ioe":Ljava/io/IOException;
    new-instance v1, Lcom/fasterxml/aalto/impl/IoStreamException;

    invoke-direct {v1, v0}, Lcom/fasterxml/aalto/impl/IoStreamException;-><init>(Ljava/io/IOException;)V

    throw v1
.end method

.method protected final _writeDefaultNamespace(Ljava/lang/String;)V
    .locals 3
    .param p1, "uri"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1459
    iget-object v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_symbols:Lcom/fasterxml/aalto/out/WNameTable;

    const-string/jumbo v1, "xmlns"

    invoke-virtual {v0, v1}, Lcom/fasterxml/aalto/out/WNameTable;->findSymbol(Ljava/lang/String;)Lcom/fasterxml/aalto/out/WName;

    move-result-object v0

    .line 1461
    .local v0, "name":Lcom/fasterxml/aalto/out/WName;
    :try_start_0
    iget-object v1, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_xmlWriter:Lcom/fasterxml/aalto/out/XmlWriter;

    invoke-virtual {v1, v0, p1}, Lcom/fasterxml/aalto/out/XmlWriter;->writeAttribute(Lcom/fasterxml/aalto/out/WName;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 1464
    nop

    .line 1465
    return-void

    .line 1462
    :catch_0
    move-exception v1

    .line 1463
    .local v1, "ioe":Ljava/io/IOException;
    new-instance v2, Lcom/fasterxml/aalto/impl/IoStreamException;

    invoke-direct {v2, v1}, Lcom/fasterxml/aalto/impl/IoStreamException;-><init>(Ljava/io/IOException;)V

    throw v2
.end method

.method protected final _writeNamespace(Ljava/lang/String;Ljava/lang/String;)V
    .locals 3
    .param p1, "prefix"    # Ljava/lang/String;
    .param p2, "uri"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1470
    iget-object v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_symbols:Lcom/fasterxml/aalto/out/WNameTable;

    const-string/jumbo v1, "xmlns"

    invoke-virtual {v0, v1, p1}, Lcom/fasterxml/aalto/out/WNameTable;->findSymbol(Ljava/lang/String;Ljava/lang/String;)Lcom/fasterxml/aalto/out/WName;

    move-result-object v0

    .line 1472
    .local v0, "name":Lcom/fasterxml/aalto/out/WName;
    :try_start_0
    iget-object v1, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_xmlWriter:Lcom/fasterxml/aalto/out/XmlWriter;

    invoke-virtual {v1, v0, p2}, Lcom/fasterxml/aalto/out/XmlWriter;->writeAttribute(Lcom/fasterxml/aalto/out/WName;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 1475
    nop

    .line 1476
    return-void

    .line 1473
    :catch_0
    move-exception v1

    .line 1474
    .local v1, "ioe":Ljava/io/IOException;
    new-instance v2, Lcom/fasterxml/aalto/impl/IoStreamException;

    invoke-direct {v2, v1}, Lcom/fasterxml/aalto/impl/IoStreamException;-><init>(Ljava/io/IOException;)V

    throw v2
.end method

.method protected _writeStartDocument(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 4
    .param p1, "version"    # Ljava/lang/String;
    .param p2, "encoding"    # Ljava/lang/String;
    .param p3, "standAlone"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1485
    iget-boolean v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_cfgCheckStructure:Z

    if-eqz v0, :cond_0

    .line 1486
    iget-boolean v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_stateAnyOutput:Z

    if-eqz v0, :cond_0

    .line 1487
    sget-object v0, Lcom/fasterxml/aalto/impl/ErrorConsts;->WERR_DUP_XML_DECL:Ljava/lang/String;

    invoke-static {v0}, Lcom/fasterxml/aalto/out/StreamWriterBase;->_reportNwfStructure(Ljava/lang/String;)V

    .line 1491
    :cond_0
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_stateAnyOutput:Z

    .line 1493
    iget-boolean v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_cfgCheckContent:Z

    const-string v1, "1.1"

    if-eqz v0, :cond_1

    .line 1496
    if-eqz p1, :cond_1

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    if-lez v0, :cond_1

    .line 1497
    const-string v0, "1.0"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_1

    .line 1498
    invoke-virtual {p1, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_1

    .line 1499
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Illegal version argument (\'"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "\'); should only use \'"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v2, "\' or \'"

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v2, "\'"

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/fasterxml/aalto/out/StreamWriterBase;->_reportNwfContent(Ljava/lang/String;)V

    .line 1506
    :cond_1
    if-eqz p1, :cond_2

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    if-nez v0, :cond_3

    .line 1507
    :cond_2
    const-string p1, "1.0"

    .line 1509
    :cond_3
    invoke-virtual {v1, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_4

    .line 1510
    iget-object v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_config:Lcom/fasterxml/aalto/out/WriterConfig;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/out/WriterConfig;->enableXml11()V

    .line 1511
    iget-object v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_xmlWriter:Lcom/fasterxml/aalto/out/XmlWriter;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/out/XmlWriter;->enableXml11()V

    .line 1514
    :cond_4
    if-eqz p2, :cond_5

    invoke-virtual {p2}, Ljava/lang/String;->length()I

    move-result v0

    if-lez v0, :cond_5

    .line 1518
    iget-object v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_config:Lcom/fasterxml/aalto/out/WriterConfig;

    invoke-virtual {v0, p2}, Lcom/fasterxml/aalto/out/WriterConfig;->setActualEncodingIfNotSet(Ljava/lang/String;)V

    .line 1521
    :cond_5
    :try_start_0
    iget-object v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_xmlWriter:Lcom/fasterxml/aalto/out/XmlWriter;

    invoke-virtual {v0, p1, p2, p3}, Lcom/fasterxml/aalto/out/XmlWriter;->writeXmlDeclaration(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 1524
    nop

    .line 1525
    return-void

    .line 1522
    :catch_0
    move-exception v0

    .line 1523
    .local v0, "ioe":Ljava/io/IOException;
    new-instance v1, Lcom/fasterxml/aalto/impl/IoStreamException;

    invoke-direct {v1, v0}, Lcom/fasterxml/aalto/impl/IoStreamException;-><init>(Ljava/io/IOException;)V

    throw v1
.end method

.method protected _writeStartTag(Lcom/fasterxml/aalto/out/WName;Z)V
    .locals 3
    .param p1, "name"    # Lcom/fasterxml/aalto/out/WName;
    .param p2, "isEmpty"    # Z
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1530
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_stateAnyOutput:Z

    .line 1531
    iput-boolean v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_stateStartElementOpen:Z

    .line 1533
    iget-object v1, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_outputElemPool:Lcom/fasterxml/aalto/out/OutputElement;

    if-eqz v1, :cond_0

    .line 1534
    iget-object v1, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_outputElemPool:Lcom/fasterxml/aalto/out/OutputElement;

    .line 1535
    .local v1, "newCurr":Lcom/fasterxml/aalto/out/OutputElement;
    iget-object v2, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_currElem:Lcom/fasterxml/aalto/out/OutputElement;

    invoke-virtual {v1, v2, p1}, Lcom/fasterxml/aalto/out/OutputElement;->reuseAsChild(Lcom/fasterxml/aalto/out/OutputElement;Lcom/fasterxml/aalto/out/WName;)Lcom/fasterxml/aalto/out/OutputElement;

    move-result-object v2

    iput-object v2, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_outputElemPool:Lcom/fasterxml/aalto/out/OutputElement;

    .line 1536
    iget v2, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_poolSize:I

    sub-int/2addr v2, v0

    iput v2, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_poolSize:I

    .line 1537
    iput-object v1, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_currElem:Lcom/fasterxml/aalto/out/OutputElement;

    .line 1538
    .end local v1    # "newCurr":Lcom/fasterxml/aalto/out/OutputElement;
    goto :goto_0

    .line 1539
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_currElem:Lcom/fasterxml/aalto/out/OutputElement;

    invoke-virtual {v0, p1}, Lcom/fasterxml/aalto/out/OutputElement;->createChild(Lcom/fasterxml/aalto/out/WName;)Lcom/fasterxml/aalto/out/OutputElement;

    move-result-object v0

    iput-object v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_currElem:Lcom/fasterxml/aalto/out/OutputElement;

    .line 1542
    :goto_0
    :try_start_0
    iget-object v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_xmlWriter:Lcom/fasterxml/aalto/out/XmlWriter;

    invoke-virtual {v0, p1}, Lcom/fasterxml/aalto/out/XmlWriter;->writeStartTagStart(Lcom/fasterxml/aalto/out/WName;)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 1545
    nop

    .line 1546
    iput-boolean p2, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_stateEmptyElement:Z

    .line 1547
    return-void

    .line 1543
    :catch_0
    move-exception v0

    .line 1544
    .local v0, "ioe":Ljava/io/IOException;
    new-instance v1, Lcom/fasterxml/aalto/impl/IoStreamException;

    invoke-direct {v1, v0}, Lcom/fasterxml/aalto/impl/IoStreamException;-><init>(Ljava/io/IOException;)V

    throw v1
.end method

.method protected _writeStartTag(Lcom/fasterxml/aalto/out/WName;ZLjava/lang/String;)V
    .locals 3
    .param p1, "name"    # Lcom/fasterxml/aalto/out/WName;
    .param p2, "isEmpty"    # Z
    .param p3, "uri"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1552
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_stateAnyOutput:Z

    .line 1553
    iput-boolean v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_stateStartElementOpen:Z

    .line 1555
    if-nez p3, :cond_0

    .line 1556
    const-string p3, ""

    .line 1559
    :cond_0
    iget-object v1, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_outputElemPool:Lcom/fasterxml/aalto/out/OutputElement;

    if-eqz v1, :cond_1

    .line 1560
    iget-object v1, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_outputElemPool:Lcom/fasterxml/aalto/out/OutputElement;

    .line 1561
    .local v1, "newCurr":Lcom/fasterxml/aalto/out/OutputElement;
    iget-object v2, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_currElem:Lcom/fasterxml/aalto/out/OutputElement;

    invoke-virtual {v1, v2, p1, p3}, Lcom/fasterxml/aalto/out/OutputElement;->reuseAsChild(Lcom/fasterxml/aalto/out/OutputElement;Lcom/fasterxml/aalto/out/WName;Ljava/lang/String;)Lcom/fasterxml/aalto/out/OutputElement;

    move-result-object v2

    iput-object v2, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_outputElemPool:Lcom/fasterxml/aalto/out/OutputElement;

    .line 1562
    iget v2, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_poolSize:I

    sub-int/2addr v2, v0

    iput v2, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_poolSize:I

    .line 1563
    iput-object v1, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_currElem:Lcom/fasterxml/aalto/out/OutputElement;

    .line 1564
    .end local v1    # "newCurr":Lcom/fasterxml/aalto/out/OutputElement;
    goto :goto_0

    .line 1565
    :cond_1
    iget-object v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_currElem:Lcom/fasterxml/aalto/out/OutputElement;

    invoke-virtual {v0, p1, p3}, Lcom/fasterxml/aalto/out/OutputElement;->createChild(Lcom/fasterxml/aalto/out/WName;Ljava/lang/String;)Lcom/fasterxml/aalto/out/OutputElement;

    move-result-object v0

    iput-object v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_currElem:Lcom/fasterxml/aalto/out/OutputElement;

    .line 1568
    :goto_0
    :try_start_0
    iget-object v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_xmlWriter:Lcom/fasterxml/aalto/out/XmlWriter;

    invoke-virtual {v0, p1}, Lcom/fasterxml/aalto/out/XmlWriter;->writeStartTagStart(Lcom/fasterxml/aalto/out/WName;)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 1571
    nop

    .line 1572
    iput-boolean p2, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_stateEmptyElement:Z

    .line 1573
    return-void

    .line 1569
    :catch_0
    move-exception v0

    .line 1570
    .local v0, "ioe":Ljava/io/IOException;
    new-instance v1, Lcom/fasterxml/aalto/impl/IoStreamException;

    invoke-direct {v1, v0}, Lcom/fasterxml/aalto/impl/IoStreamException;-><init>(Ljava/io/IOException;)V

    throw v1
.end method

.method public addDefaultAttribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I
    .locals 1
    .param p1, "localName"    # Ljava/lang/String;
    .param p2, "uri"    # Ljava/lang/String;
    .param p3, "prefix"    # Ljava/lang/String;
    .param p4, "value"    # Ljava/lang/String;

    .line 1320
    const/4 v0, -0x1

    return v0
.end method

.method public close()V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 240
    const/4 v0, 0x0

    invoke-direct {p0, v0}, Lcom/fasterxml/aalto/out/StreamWriterBase;->_finishDocument(Z)V

    .line 241
    return-void
.end method

.method public closeCompletely()V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1031
    const/4 v0, 0x1

    invoke-direct {p0, v0}, Lcom/fasterxml/aalto/out/StreamWriterBase;->_finishDocument(Z)V

    .line 1032
    return-void
.end method

.method public findAttributeIndex(Ljava/lang/String;Ljava/lang/String;)I
    .locals 1
    .param p1, "nsURI"    # Ljava/lang/String;
    .param p2, "localName"    # Ljava/lang/String;

    .line 1364
    const/4 v0, -0x1

    return v0
.end method

.method public flush()V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 247
    :try_start_0
    iget-object v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_xmlWriter:Lcom/fasterxml/aalto/out/XmlWriter;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/out/XmlWriter;->flush()V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 250
    nop

    .line 251
    return-void

    .line 248
    :catch_0
    move-exception v0

    .line 249
    .local v0, "ie":Ljava/io/IOException;
    new-instance v1, Lcom/fasterxml/aalto/impl/IoStreamException;

    invoke-direct {v1, v0}, Lcom/fasterxml/aalto/impl/IoStreamException;-><init>(Ljava/io/IOException;)V

    throw v1
.end method

.method public getAttributeCount()I
    .locals 1

    .line 1338
    const/4 v0, 0x0

    return v0
.end method

.method public getAttributeLocalName(I)Ljava/lang/String;
    .locals 1
    .param p1, "index"    # I

    .line 1341
    const/4 v0, 0x0

    return-object v0
.end method

.method public getAttributeNamespace(I)Ljava/lang/String;
    .locals 1
    .param p1, "index"    # I

    .line 1344
    const/4 v0, 0x0

    return-object v0
.end method

.method public getAttributePrefix(I)Ljava/lang/String;
    .locals 1
    .param p1, "index"    # I

    .line 1347
    const/4 v0, 0x0

    return-object v0
.end method

.method public getAttributeType(I)Ljava/lang/String;
    .locals 1
    .param p1, "index"    # I

    .line 1359
    const-string v0, ""

    return-object v0
.end method

.method public getAttributeValue(I)Ljava/lang/String;
    .locals 1
    .param p1, "index"    # I

    .line 1350
    const/4 v0, 0x0

    return-object v0
.end method

.method public getAttributeValue(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .locals 1
    .param p1, "nsURI"    # Ljava/lang/String;
    .param p2, "localName"    # Ljava/lang/String;

    .line 1354
    const/4 v0, 0x0

    return-object v0
.end method

.method public getBaseUri()Ljava/lang/String;
    .locals 1

    .line 1288
    const/4 v0, 0x0

    return-object v0
.end method

.method public getCurrentElementName()Ljavax/xml/namespace/QName;
    .locals 1

    .line 1276
    iget-object v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_currElem:Lcom/fasterxml/aalto/out/OutputElement;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/out/OutputElement;->getQName()Ljavax/xml/namespace/QName;

    move-result-object v0

    return-object v0
.end method

.method public getEncoding()Ljava/lang/String;
    .locals 1

    .line 1144
    iget-object v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_config:Lcom/fasterxml/aalto/out/WriterConfig;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/out/WriterConfig;->getActualEncoding()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getLocation()Lorg/codehaus/stax2/XMLStreamLocation2;
    .locals 7

    .line 1138
    new-instance v6, Lcom/fasterxml/aalto/impl/LocationImpl;

    iget-object v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_xmlWriter:Lcom/fasterxml/aalto/out/XmlWriter;

    .line 1139
    invoke-virtual {v0}, Lcom/fasterxml/aalto/out/XmlWriter;->getAbsOffset()I

    move-result v3

    iget-object v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_xmlWriter:Lcom/fasterxml/aalto/out/XmlWriter;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/out/XmlWriter;->getRow()I

    move-result v4

    iget-object v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_xmlWriter:Lcom/fasterxml/aalto/out/XmlWriter;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/out/XmlWriter;->getColumn()I

    move-result v5

    const/4 v1, 0x0

    const/4 v2, 0x0

    move-object v0, v6

    invoke-direct/range {v0 .. v5}, Lcom/fasterxml/aalto/impl/LocationImpl;-><init>(Ljava/lang/String;Ljava/lang/String;III)V

    .line 1138
    return-object v6
.end method

.method public final getNamespaceContext()Ljavax/xml/namespace/NamespaceContext;
    .locals 0

    .line 255
    return-object p0
.end method

.method public getNamespaceURI(Ljava/lang/String;)Ljava/lang/String;
    .locals 2
    .param p1, "prefix"    # Ljava/lang/String;

    .line 713
    iget-object v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_currElem:Lcom/fasterxml/aalto/out/OutputElement;

    invoke-virtual {v0, p1}, Lcom/fasterxml/aalto/out/OutputElement;->getNamespaceURI(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 714
    .local v0, "uri":Ljava/lang/String;
    if-nez v0, :cond_0

    .line 715
    iget-object v1, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_rootNsContext:Ljavax/xml/namespace/NamespaceContext;

    if-eqz v1, :cond_0

    .line 716
    iget-object v1, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_rootNsContext:Ljavax/xml/namespace/NamespaceContext;

    invoke-interface {v1, p1}, Ljavax/xml/namespace/NamespaceContext;->getNamespaceURI(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 719
    :cond_0
    return-object v0
.end method

.method public getPrefix(Ljava/lang/String;)Ljava/lang/String;
    .locals 2
    .param p1, "uri"    # Ljava/lang/String;

    .line 725
    iget-object v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_currElem:Lcom/fasterxml/aalto/out/OutputElement;

    invoke-virtual {v0, p1}, Lcom/fasterxml/aalto/out/OutputElement;->getPrefix(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 726
    .local v0, "prefix":Ljava/lang/String;
    if-nez v0, :cond_0

    .line 727
    iget-object v1, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_rootNsContext:Ljavax/xml/namespace/NamespaceContext;

    if-eqz v1, :cond_0

    .line 728
    iget-object v1, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_rootNsContext:Ljavax/xml/namespace/NamespaceContext;

    invoke-interface {v1, p1}, Ljavax/xml/namespace/NamespaceContext;->getPrefix(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 731
    :cond_0
    return-object v0
.end method

.method public getPrefixes(Ljava/lang/String;)Ljava/util/Iterator;
    .locals 2
    .param p1, "uri"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            ")",
            "Ljava/util/Iterator<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .line 737
    iget-object v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_currElem:Lcom/fasterxml/aalto/out/OutputElement;

    iget-object v1, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_rootNsContext:Ljavax/xml/namespace/NamespaceContext;

    invoke-virtual {v0, p1, v1}, Lcom/fasterxml/aalto/out/OutputElement;->getPrefixes(Ljava/lang/String;Ljavax/xml/namespace/NamespaceContext;)Ljava/util/Iterator;

    move-result-object v0

    return-object v0
.end method

.method public getProperty(Ljava/lang/String;)Ljava/lang/Object;
    .locals 2
    .param p1, "name"    # Ljava/lang/String;

    .line 264
    iget-object v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_config:Lcom/fasterxml/aalto/out/WriterConfig;

    const/4 v1, 0x1

    invoke-virtual {v0, p1, v1}, Lcom/fasterxml/aalto/out/WriterConfig;->getProperty(Ljava/lang/String;Z)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public getValidationLocation()Ljavax/xml/stream/Location;
    .locals 1

    .line 1293
    invoke-virtual {p0}, Lcom/fasterxml/aalto/out/StreamWriterBase;->getLocation()Lorg/codehaus/stax2/XMLStreamLocation2;

    move-result-object v0

    return-object v0
.end method

.method public getXmlVersion()Ljava/lang/String;
    .locals 1

    .line 1271
    iget-object v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_config:Lcom/fasterxml/aalto/out/WriterConfig;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/out/WriterConfig;->isXml11()Z

    move-result v0

    if-eqz v0, :cond_0

    const-string v0, "1.1"

    goto :goto_0

    :cond_0
    const-string v0, "1.0"

    :goto_0
    return-object v0
.end method

.method protected final inPrologOrEpilog()Z
    .locals 2

    .line 1413
    iget-object v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_state:Lcom/fasterxml/aalto/out/StreamWriterBase$State;

    sget-object v1, Lcom/fasterxml/aalto/out/StreamWriterBase$State;->TREE:Lcom/fasterxml/aalto/out/StreamWriterBase$State;

    if-eq v0, v1, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method public isNotationDeclared(Ljava/lang/String;)Z
    .locals 1
    .param p1, "name"    # Ljava/lang/String;

    .line 1326
    const/4 v0, 0x0

    return v0
.end method

.method public isPropertySupported(Ljava/lang/String;)Z
    .locals 1
    .param p1, "name"    # Ljava/lang/String;

    .line 1045
    iget-object v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_config:Lcom/fasterxml/aalto/out/WriterConfig;

    invoke-virtual {v0, p1}, Lcom/fasterxml/aalto/out/WriterConfig;->isPropertySupported(Ljava/lang/String;)Z

    move-result v0

    return v0
.end method

.method public isUnparsedEntityDeclared(Ljava/lang/String;)Z
    .locals 1
    .param p1, "name"    # Ljava/lang/String;

    .line 1329
    const/4 v0, 0x0

    return v0
.end method

.method public reportProblem(Lorg/codehaus/stax2/validation/XMLValidationProblem;)V
    .locals 2
    .param p1, "prob"    # Lorg/codehaus/stax2/validation/XMLValidationProblem;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1300
    iget-object v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_vldProblemHandler:Lorg/codehaus/stax2/validation/ValidationProblemHandler;

    if-eqz v0, :cond_0

    .line 1301
    iget-object v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_vldProblemHandler:Lorg/codehaus/stax2/validation/ValidationProblemHandler;

    invoke-interface {v0, p1}, Lorg/codehaus/stax2/validation/ValidationProblemHandler;->reportProblem(Lorg/codehaus/stax2/validation/XMLValidationProblem;)V

    .line 1302
    return-void

    .line 1306
    :cond_0
    invoke-virtual {p1}, Lorg/codehaus/stax2/validation/XMLValidationProblem;->getSeverity()I

    move-result v0

    const/4 v1, 0x2

    if-ge v0, v1, :cond_1

    .line 1309
    return-void

    .line 1307
    :cond_1
    invoke-static {p1}, Lcom/fasterxml/aalto/ValidationException;->create(Lorg/codehaus/stax2/validation/XMLValidationProblem;)Lcom/fasterxml/aalto/ValidationException;

    move-result-object v0

    throw v0
.end method

.method public abstract setDefaultNamespace(Ljava/lang/String;)V
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method

.method public setNamespaceContext(Ljavax/xml/namespace/NamespaceContext;)V
    .locals 2
    .param p1, "ctxt"    # Ljavax/xml/namespace/NamespaceContext;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 276
    iget-object v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_state:Lcom/fasterxml/aalto/out/StreamWriterBase$State;

    sget-object v1, Lcom/fasterxml/aalto/out/StreamWriterBase$State;->PROLOG:Lcom/fasterxml/aalto/out/StreamWriterBase$State;

    if-eq v0, v1, :cond_0

    .line 277
    const-string v0, "Called setNamespaceContext() after having already output root element."

    invoke-static {v0}, Lcom/fasterxml/aalto/out/StreamWriterBase;->throwOutputError(Ljava/lang/String;)V

    .line 279
    :cond_0
    iput-object p1, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_rootNsContext:Ljavax/xml/namespace/NamespaceContext;

    .line 280
    return-void
.end method

.method public final setPrefix(Ljava/lang/String;Ljava/lang/String;)V
    .locals 3
    .param p1, "prefix"    # Ljava/lang/String;
    .param p2, "uri"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 286
    if-eqz p1, :cond_7

    .line 290
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    if-nez v0, :cond_0

    .line 291
    invoke-virtual {p0, p2}, Lcom/fasterxml/aalto/out/StreamWriterBase;->setDefaultNamespace(Ljava/lang/String;)V

    .line 292
    return-void

    .line 294
    :cond_0
    if-eqz p2, :cond_6

    .line 300
    const-string/jumbo v0, "xml"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    const-string v1, "http://www.w3.org/XML/1998/namespace"

    if-eqz v0, :cond_1

    .line 301
    invoke-virtual {p2, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_4

    .line 302
    sget-object v0, Lcom/fasterxml/aalto/impl/ErrorConsts;->ERR_NS_REDECL_XML:Ljava/lang/String;

    invoke-static {v0, p2}, Lcom/fasterxml/aalto/out/StreamWriterBase;->throwOutputError(Ljava/lang/String;Ljava/lang/Object;)V

    goto :goto_0

    .line 304
    :cond_1
    const-string/jumbo v0, "xmlns"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    const-string v2, "http://www.w3.org/2000/xmlns/"

    if-eqz v0, :cond_2

    .line 305
    invoke-virtual {p2, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_4

    .line 306
    sget-object v0, Lcom/fasterxml/aalto/impl/ErrorConsts;->ERR_NS_REDECL_XMLNS:Ljava/lang/String;

    invoke-static {v0, p2}, Lcom/fasterxml/aalto/out/StreamWriterBase;->throwOutputError(Ljava/lang/String;Ljava/lang/Object;)V

    goto :goto_0

    .line 310
    :cond_2
    invoke-virtual {p2, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_3

    .line 311
    sget-object v0, Lcom/fasterxml/aalto/impl/ErrorConsts;->ERR_NS_REDECL_XML_URI:Ljava/lang/String;

    invoke-static {v0, p1}, Lcom/fasterxml/aalto/out/StreamWriterBase;->throwOutputError(Ljava/lang/String;Ljava/lang/Object;)V

    goto :goto_0

    .line 312
    :cond_3
    invoke-virtual {p2, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_4

    .line 313
    sget-object v0, Lcom/fasterxml/aalto/impl/ErrorConsts;->ERR_NS_REDECL_XMLNS_URI:Ljava/lang/String;

    invoke-static {v0, p1}, Lcom/fasterxml/aalto/out/StreamWriterBase;->throwOutputError(Ljava/lang/String;Ljava/lang/Object;)V

    .line 317
    :cond_4
    :goto_0
    invoke-virtual {p2}, Ljava/lang/String;->length()I

    move-result v0

    if-nez v0, :cond_5

    .line 318
    iget-object v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_config:Lcom/fasterxml/aalto/out/WriterConfig;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/out/WriterConfig;->isXml11()Z

    move-result v0

    if-nez v0, :cond_5

    .line 319
    sget-object v0, Lcom/fasterxml/aalto/impl/ErrorConsts;->ERR_NS_EMPTY:Ljava/lang/String;

    invoke-static {v0}, Lcom/fasterxml/aalto/out/StreamWriterBase;->throwOutputError(Ljava/lang/String;)V

    .line 323
    :cond_5
    invoke-virtual {p0, p1, p2}, Lcom/fasterxml/aalto/out/StreamWriterBase;->_setPrefix(Ljava/lang/String;Ljava/lang/String;)V

    .line 324
    return-void

    .line 295
    :cond_6
    new-instance v0, Ljava/lang/NullPointerException;

    invoke-direct {v0}, Ljava/lang/NullPointerException;-><init>()V

    throw v0

    .line 287
    :cond_7
    new-instance v0, Ljava/lang/NullPointerException;

    invoke-direct {v0}, Ljava/lang/NullPointerException;-><init>()V

    throw v0
.end method

.method public setProperty(Ljava/lang/String;Ljava/lang/Object;)Z
    .locals 1
    .param p1, "name"    # Ljava/lang/String;
    .param p2, "value"    # Ljava/lang/Object;

    .line 1061
    iget-object v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_config:Lcom/fasterxml/aalto/out/WriterConfig;

    invoke-virtual {v0, p1, p2}, Lcom/fasterxml/aalto/out/WriterConfig;->setProperty(Ljava/lang/String;Ljava/lang/Object;)Z

    move-result v0

    return v0
.end method

.method public setValidationProblemHandler(Lorg/codehaus/stax2/validation/ValidationProblemHandler;)Lorg/codehaus/stax2/validation/ValidationProblemHandler;
    .locals 1
    .param p1, "h"    # Lorg/codehaus/stax2/validation/ValidationProblemHandler;

    .line 1118
    iget-object v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_vldProblemHandler:Lorg/codehaus/stax2/validation/ValidationProblemHandler;

    .line 1119
    .local v0, "oldH":Lorg/codehaus/stax2/validation/ValidationProblemHandler;
    iput-object p1, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_vldProblemHandler:Lorg/codehaus/stax2/validation/ValidationProblemHandler;

    .line 1120
    return-object v0
.end method

.method public stopValidatingAgainst(Lorg/codehaus/stax2/validation/XMLValidationSchema;)Lorg/codehaus/stax2/validation/XMLValidator;
    .locals 4
    .param p1, "schema"    # Lorg/codehaus/stax2/validation/XMLValidationSchema;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1086
    const/4 v0, 0x2

    new-array v0, v0, [Lorg/codehaus/stax2/validation/XMLValidator;

    .line 1087
    .local v0, "results":[Lorg/codehaus/stax2/validation/XMLValidator;
    const/4 v1, 0x0

    .line 1088
    .local v1, "found":Lorg/codehaus/stax2/validation/XMLValidator;
    iget-object v2, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_validator:Lorg/codehaus/stax2/validation/XMLValidator;

    invoke-static {v2, p1, v0}, Lorg/codehaus/stax2/validation/ValidatorPair;->removeValidator(Lorg/codehaus/stax2/validation/XMLValidator;Lorg/codehaus/stax2/validation/XMLValidationSchema;[Lorg/codehaus/stax2/validation/XMLValidator;)Z

    move-result v2

    if-eqz v2, :cond_0

    .line 1089
    const/4 v2, 0x0

    aget-object v1, v0, v2

    .line 1090
    const/4 v3, 0x1

    aget-object v3, v0, v3

    iput-object v3, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_validator:Lorg/codehaus/stax2/validation/XMLValidator;

    .line 1091
    invoke-virtual {v1, v2}, Lorg/codehaus/stax2/validation/XMLValidator;->validationCompleted(Z)V

    .line 1092
    iget-object v2, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_validator:Lorg/codehaus/stax2/validation/XMLValidator;

    if-nez v2, :cond_0

    .line 1093
    invoke-direct {p0}, Lcom/fasterxml/aalto/out/StreamWriterBase;->resetValidationFlags()V

    .line 1096
    :cond_0
    return-object v1
.end method

.method public stopValidatingAgainst(Lorg/codehaus/stax2/validation/XMLValidator;)Lorg/codehaus/stax2/validation/XMLValidator;
    .locals 4
    .param p1, "validator"    # Lorg/codehaus/stax2/validation/XMLValidator;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1102
    const/4 v0, 0x2

    new-array v0, v0, [Lorg/codehaus/stax2/validation/XMLValidator;

    .line 1103
    .local v0, "results":[Lorg/codehaus/stax2/validation/XMLValidator;
    const/4 v1, 0x0

    .line 1104
    .local v1, "found":Lorg/codehaus/stax2/validation/XMLValidator;
    iget-object v2, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_validator:Lorg/codehaus/stax2/validation/XMLValidator;

    invoke-static {v2, p1, v0}, Lorg/codehaus/stax2/validation/ValidatorPair;->removeValidator(Lorg/codehaus/stax2/validation/XMLValidator;Lorg/codehaus/stax2/validation/XMLValidator;[Lorg/codehaus/stax2/validation/XMLValidator;)Z

    move-result v2

    if-eqz v2, :cond_0

    .line 1105
    const/4 v2, 0x0

    aget-object v1, v0, v2

    .line 1106
    const/4 v3, 0x1

    aget-object v3, v0, v3

    iput-object v3, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_validator:Lorg/codehaus/stax2/validation/XMLValidator;

    .line 1107
    invoke-virtual {v1, v2}, Lorg/codehaus/stax2/validation/XMLValidator;->validationCompleted(Z)V

    .line 1108
    iget-object v2, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_validator:Lorg/codehaus/stax2/validation/XMLValidator;

    if-nez v2, :cond_0

    .line 1109
    invoke-direct {p0}, Lcom/fasterxml/aalto/out/StreamWriterBase;->resetValidationFlags()V

    .line 1112
    :cond_0
    return-object v1
.end method

.method public toString()Ljava/lang/String;
    .locals 2

    .line 1843
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "[StreamWriter: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", underlying outputter: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_xmlWriter:Lcom/fasterxml/aalto/out/XmlWriter;

    if-nez v1, :cond_0

    const-string v1, "NULL"

    goto :goto_0

    :cond_0
    iget-object v1, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_xmlWriter:Lcom/fasterxml/aalto/out/XmlWriter;

    .line 1844
    invoke-virtual {v1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v1

    :goto_0
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 1843
    return-object v0
.end method

.method public validateAgainst(Lorg/codehaus/stax2/validation/XMLValidationSchema;)Lorg/codehaus/stax2/validation/XMLValidator;
    .locals 3
    .param p1, "schema"    # Lorg/codehaus/stax2/validation/XMLValidationSchema;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1067
    invoke-interface {p1, p0}, Lorg/codehaus/stax2/validation/XMLValidationSchema;->createValidator(Lorg/codehaus/stax2/validation/ValidationContext;)Lorg/codehaus/stax2/validation/XMLValidator;

    move-result-object v0

    .line 1069
    .local v0, "vld":Lorg/codehaus/stax2/validation/XMLValidator;
    iget-object v1, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_validator:Lorg/codehaus/stax2/validation/XMLValidator;

    if-nez v1, :cond_0

    .line 1074
    const/4 v1, 0x1

    iput-boolean v1, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_cfgCheckStructure:Z

    .line 1075
    iput-boolean v1, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_cfgCheckAttrs:Z

    .line 1076
    iput-object v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_validator:Lorg/codehaus/stax2/validation/XMLValidator;

    goto :goto_0

    .line 1078
    :cond_0
    new-instance v1, Lorg/codehaus/stax2/validation/ValidatorPair;

    iget-object v2, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_validator:Lorg/codehaus/stax2/validation/XMLValidator;

    invoke-direct {v1, v2, v0}, Lorg/codehaus/stax2/validation/ValidatorPair;-><init>(Lorg/codehaus/stax2/validation/XMLValidator;Lorg/codehaus/stax2/validation/XMLValidator;)V

    iput-object v1, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_validator:Lorg/codehaus/stax2/validation/XMLValidator;

    .line 1080
    :goto_0
    return-object v0
.end method

.method protected final valueEncoderFactory()Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory;
    .locals 1

    .line 1418
    iget-object v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_valueEncoderFactory:Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory;

    if-nez v0, :cond_0

    .line 1419
    new-instance v0, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory;

    invoke-direct {v0}, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory;-><init>()V

    iput-object v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_valueEncoderFactory:Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory;

    .line 1421
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_valueEncoderFactory:Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory;

    return-object v0
.end method

.method public final writeAttribute(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1
    .param p1, "localName"    # Ljava/lang/String;
    .param p2, "value"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 332
    iget-boolean v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_stateStartElementOpen:Z

    if-nez v0, :cond_0

    .line 333
    sget-object v0, Lcom/fasterxml/aalto/impl/ErrorConsts;->WERR_ATTR_NO_ELEM:Ljava/lang/String;

    invoke-static {v0}, Lcom/fasterxml/aalto/out/StreamWriterBase;->throwOutputError(Ljava/lang/String;)V

    .line 336
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_symbols:Lcom/fasterxml/aalto/out/WNameTable;

    invoke-virtual {v0, p1}, Lcom/fasterxml/aalto/out/WNameTable;->findSymbol(Ljava/lang/String;)Lcom/fasterxml/aalto/out/WName;

    move-result-object v0

    invoke-virtual {p0, v0, p2}, Lcom/fasterxml/aalto/out/StreamWriterBase;->_writeAttribute(Lcom/fasterxml/aalto/out/WName;Ljava/lang/String;)V

    .line 337
    return-void
.end method

.method public abstract writeAttribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method

.method public abstract writeAttribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method

.method public writeBinary(Lorg/codehaus/stax2/typed/Base64Variant;[BII)V
    .locals 1
    .param p1, "v"    # Lorg/codehaus/stax2/typed/Base64Variant;
    .param p2, "value"    # [B
    .param p3, "from"    # I
    .param p4, "length"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 847
    invoke-virtual {p0}, Lcom/fasterxml/aalto/out/StreamWriterBase;->valueEncoderFactory()Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory;

    move-result-object v0

    invoke-virtual {v0, p1, p2, p3, p4}, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory;->getEncoder(Lorg/codehaus/stax2/typed/Base64Variant;[BII)Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$Base64Encoder;

    move-result-object v0

    invoke-direct {p0, v0}, Lcom/fasterxml/aalto/out/StreamWriterBase;->writeTypedElement(Lorg/codehaus/stax2/ri/typed/AsciiValueEncoder;)V

    .line 848
    return-void
.end method

.method public writeBinary([BII)V
    .locals 2
    .param p1, "value"    # [B
    .param p2, "from"    # I
    .param p3, "length"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 839
    invoke-static {}, Lorg/codehaus/stax2/typed/Base64Variants;->getDefaultVariant()Lorg/codehaus/stax2/typed/Base64Variant;

    move-result-object v0

    .line 840
    .local v0, "v":Lorg/codehaus/stax2/typed/Base64Variant;
    invoke-virtual {p0}, Lcom/fasterxml/aalto/out/StreamWriterBase;->valueEncoderFactory()Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory;

    move-result-object v1

    invoke-virtual {v1, v0, p1, p2, p3}, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory;->getEncoder(Lorg/codehaus/stax2/typed/Base64Variant;[BII)Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$Base64Encoder;

    move-result-object v1

    invoke-direct {p0, v1}, Lcom/fasterxml/aalto/out/StreamWriterBase;->writeTypedElement(Lorg/codehaus/stax2/ri/typed/AsciiValueEncoder;)V

    .line 841
    return-void
.end method

.method public writeBinaryAttribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[B)V
    .locals 4
    .param p1, "prefix"    # Ljava/lang/String;
    .param p2, "nsURI"    # Ljava/lang/String;
    .param p3, "localName"    # Ljava/lang/String;
    .param p4, "value"    # [B
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 968
    invoke-static {}, Lorg/codehaus/stax2/typed/Base64Variants;->getDefaultVariant()Lorg/codehaus/stax2/typed/Base64Variant;

    move-result-object v0

    .line 969
    .local v0, "v":Lorg/codehaus/stax2/typed/Base64Variant;
    nop

    .line 970
    invoke-virtual {p0}, Lcom/fasterxml/aalto/out/StreamWriterBase;->valueEncoderFactory()Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory;

    move-result-object v1

    const/4 v2, 0x0

    array-length v3, p4

    invoke-virtual {v1, v0, p4, v2, v3}, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory;->getEncoder(Lorg/codehaus/stax2/typed/Base64Variant;[BII)Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$Base64Encoder;

    move-result-object v1

    .line 969
    invoke-virtual {p0, p1, p2, p3, v1}, Lcom/fasterxml/aalto/out/StreamWriterBase;->writeTypedAttribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lorg/codehaus/stax2/ri/typed/AsciiValueEncoder;)V

    .line 971
    return-void
.end method

.method public writeBinaryAttribute(Lorg/codehaus/stax2/typed/Base64Variant;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[B)V
    .locals 3
    .param p1, "v"    # Lorg/codehaus/stax2/typed/Base64Variant;
    .param p2, "prefix"    # Ljava/lang/String;
    .param p3, "nsURI"    # Ljava/lang/String;
    .param p4, "localName"    # Ljava/lang/String;
    .param p5, "value"    # [B
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 977
    nop

    .line 978
    invoke-virtual {p0}, Lcom/fasterxml/aalto/out/StreamWriterBase;->valueEncoderFactory()Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory;

    move-result-object v0

    const/4 v1, 0x0

    array-length v2, p5

    invoke-virtual {v0, p1, p5, v1, v2}, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory;->getEncoder(Lorg/codehaus/stax2/typed/Base64Variant;[BII)Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$Base64Encoder;

    move-result-object v0

    .line 977
    invoke-virtual {p0, p2, p3, p4, v0}, Lcom/fasterxml/aalto/out/StreamWriterBase;->writeTypedAttribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lorg/codehaus/stax2/ri/typed/AsciiValueEncoder;)V

    .line 979
    return-void
.end method

.method public writeBoolean(Z)V
    .locals 2
    .param p1, "b"    # Z
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 753
    invoke-virtual {p0}, Lcom/fasterxml/aalto/out/StreamWriterBase;->valueEncoderFactory()Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory;

    move-result-object v0

    if-eqz p1, :cond_0

    const-string/jumbo v1, "true"

    goto :goto_0

    :cond_0
    const-string v1, "false"

    :goto_0
    invoke-virtual {v0, v1}, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory;->getScalarEncoder(Ljava/lang/String;)Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$ScalarEncoder;

    move-result-object v0

    invoke-direct {p0, v0}, Lcom/fasterxml/aalto/out/StreamWriterBase;->writeTypedElement(Lorg/codehaus/stax2/ri/typed/AsciiValueEncoder;)V

    .line 754
    return-void
.end method

.method public final writeBooleanAttribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Z)V
    .locals 1
    .param p1, "prefix"    # Ljava/lang/String;
    .param p2, "nsURI"    # Ljava/lang/String;
    .param p3, "localName"    # Ljava/lang/String;
    .param p4, "value"    # Z
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 870
    nop

    .line 871
    invoke-virtual {p0}, Lcom/fasterxml/aalto/out/StreamWriterBase;->valueEncoderFactory()Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory;

    move-result-object v0

    invoke-virtual {v0, p4}, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory;->getEncoder(Z)Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$ScalarEncoder;

    move-result-object v0

    .line 870
    invoke-virtual {p0, p1, p2, p3, v0}, Lcom/fasterxml/aalto/out/StreamWriterBase;->writeTypedAttribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lorg/codehaus/stax2/ri/typed/AsciiValueEncoder;)V

    .line 872
    return-void
.end method

.method public writeCData(Ljava/lang/String;)V
    .locals 3
    .param p1, "data"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 350
    iget-boolean v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_cfgCDataAsText:Z

    if-eqz v0, :cond_0

    .line 351
    invoke-virtual {p0, p1}, Lcom/fasterxml/aalto/out/StreamWriterBase;->writeCharacters(Ljava/lang/String;)V

    .line 352
    return-void

    .line 355
    :cond_0
    invoke-virtual {p0}, Lcom/fasterxml/aalto/out/StreamWriterBase;->_verifyWriteCData()V

    .line 357
    iget v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_vldContent:I

    const/4 v1, 0x3

    if-ne v0, v1, :cond_1

    iget-object v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_validator:Lorg/codehaus/stax2/validation/XMLValidator;

    if-eqz v0, :cond_1

    .line 361
    iget-object v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_validator:Lorg/codehaus/stax2/validation/XMLValidator;

    const/4 v1, 0x0

    invoke-virtual {v0, p1, v1}, Lorg/codehaus/stax2/validation/XMLValidator;->validateText(Ljava/lang/String;Z)V

    .line 365
    :cond_1
    :try_start_0
    iget-object v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_xmlWriter:Lcom/fasterxml/aalto/out/XmlWriter;

    invoke-virtual {v0, p1}, Lcom/fasterxml/aalto/out/XmlWriter;->writeCData(Ljava/lang/String;)I

    move-result v0

    .line 366
    .local v0, "ix":I
    if-ltz v0, :cond_2

    .line 367
    sget-object v1, Lcom/fasterxml/aalto/impl/ErrorConsts;->WERR_CDATA_CONTENT:Ljava/lang/String;

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/fasterxml/aalto/out/StreamWriterBase;->_reportNwfContent(Ljava/lang/String;Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 371
    .end local v0    # "ix":I
    :cond_2
    nop

    .line 372
    return-void

    .line 369
    :catch_0
    move-exception v0

    .line 370
    .local v0, "ioe":Ljava/io/IOException;
    new-instance v1, Lcom/fasterxml/aalto/impl/IoStreamException;

    invoke-direct {v1, v0}, Lcom/fasterxml/aalto/impl/IoStreamException;-><init>(Ljava/io/IOException;)V

    throw v1
.end method

.method public writeCData([CII)V
    .locals 3
    .param p1, "cbuf"    # [C
    .param p2, "start"    # I
    .param p3, "len"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1157
    iget-boolean v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_cfgCDataAsText:Z

    if-eqz v0, :cond_0

    .line 1158
    invoke-virtual {p0, p1, p2, p3}, Lcom/fasterxml/aalto/out/StreamWriterBase;->writeCharacters([CII)V

    .line 1159
    return-void

    .line 1162
    :cond_0
    invoke-virtual {p0}, Lcom/fasterxml/aalto/out/StreamWriterBase;->_verifyWriteCData()V

    .line 1165
    :try_start_0
    iget-object v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_xmlWriter:Lcom/fasterxml/aalto/out/XmlWriter;

    invoke-virtual {v0, p1, p2, p3}, Lcom/fasterxml/aalto/out/XmlWriter;->writeCData([CII)I

    move-result v0
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 1168
    .local v0, "ix":I
    nop

    .line 1169
    if-ltz v0, :cond_1

    .line 1170
    sget-object v1, Lcom/fasterxml/aalto/impl/ErrorConsts;->WERR_CDATA_CONTENT:Ljava/lang/String;

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/fasterxml/aalto/out/StreamWriterBase;->_reportNwfContent(Ljava/lang/String;Ljava/lang/Object;)V

    .line 1172
    :cond_1
    return-void

    .line 1166
    .end local v0    # "ix":I
    :catch_0
    move-exception v0

    .line 1167
    .local v0, "ioe":Ljava/io/IOException;
    new-instance v1, Lcom/fasterxml/aalto/impl/IoStreamException;

    invoke-direct {v1, v0}, Lcom/fasterxml/aalto/impl/IoStreamException;-><init>(Ljava/io/IOException;)V

    throw v1
.end method

.method public writeCharacters(Ljava/lang/String;)V
    .locals 2
    .param p1, "text"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 418
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_stateAnyOutput:Z

    .line 419
    iget-boolean v1, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_stateStartElementOpen:Z

    if-eqz v1, :cond_0

    .line 420
    iget-boolean v1, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_stateEmptyElement:Z

    invoke-virtual {p0, v1}, Lcom/fasterxml/aalto/out/StreamWriterBase;->_closeStartElement(Z)V

    .line 423
    :cond_0
    invoke-virtual {p0}, Lcom/fasterxml/aalto/out/StreamWriterBase;->inPrologOrEpilog()Z

    move-result v1

    if-eqz v1, :cond_1

    .line 424
    invoke-virtual {p0, p1}, Lcom/fasterxml/aalto/out/StreamWriterBase;->writeSpace(Ljava/lang/String;)V

    .line 425
    return-void

    .line 433
    :cond_1
    iget v1, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_vldContent:I

    if-gt v1, v0, :cond_3

    .line 434
    iget v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_vldContent:I

    const/4 v1, 0x4

    if-nez v0, :cond_2

    .line 435
    invoke-virtual {p0, v1}, Lcom/fasterxml/aalto/out/StreamWriterBase;->_reportInvalidContent(I)V

    goto :goto_0

    .line 437
    :cond_2
    iget-object v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_config:Lcom/fasterxml/aalto/out/WriterConfig;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/out/WriterConfig;->isXml11()Z

    move-result v0

    invoke-static {p1, v0}, Lcom/fasterxml/aalto/util/TextUtil;->isAllWhitespace(Ljava/lang/String;Z)Z

    move-result v0

    if-nez v0, :cond_4

    .line 438
    invoke-virtual {p0, v1}, Lcom/fasterxml/aalto/out/StreamWriterBase;->_reportInvalidContent(I)V

    goto :goto_0

    .line 441
    :cond_3
    iget v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_vldContent:I

    const/4 v1, 0x3

    if-ne v0, v1, :cond_4

    .line 442
    iget-object v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_validator:Lorg/codehaus/stax2/validation/XMLValidator;

    if-eqz v0, :cond_4

    .line 446
    iget-object v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_validator:Lorg/codehaus/stax2/validation/XMLValidator;

    const/4 v1, 0x0

    invoke-virtual {v0, p1, v1}, Lorg/codehaus/stax2/validation/XMLValidator;->validateText(Ljava/lang/String;Z)V

    .line 451
    :cond_4
    :goto_0
    :try_start_0
    iget-object v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_xmlWriter:Lcom/fasterxml/aalto/out/XmlWriter;

    invoke-virtual {v0, p1}, Lcom/fasterxml/aalto/out/XmlWriter;->writeCharacters(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 454
    nop

    .line 455
    return-void

    .line 452
    :catch_0
    move-exception v0

    .line 453
    .local v0, "ioe":Ljava/io/IOException;
    new-instance v1, Lcom/fasterxml/aalto/impl/IoStreamException;

    invoke-direct {v1, v0}, Lcom/fasterxml/aalto/impl/IoStreamException;-><init>(Ljava/io/IOException;)V

    throw v1
.end method

.method public writeCharacters([CII)V
    .locals 2
    .param p1, "text"    # [C
    .param p2, "start"    # I
    .param p3, "len"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 378
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_stateAnyOutput:Z

    .line 379
    iget-boolean v1, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_stateStartElementOpen:Z

    if-eqz v1, :cond_0

    .line 380
    iget-boolean v1, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_stateEmptyElement:Z

    invoke-virtual {p0, v1}, Lcom/fasterxml/aalto/out/StreamWriterBase;->_closeStartElement(Z)V

    .line 385
    :cond_0
    invoke-virtual {p0}, Lcom/fasterxml/aalto/out/StreamWriterBase;->inPrologOrEpilog()Z

    move-result v1

    if-eqz v1, :cond_1

    .line 386
    invoke-virtual {p0, p1, p2, p3}, Lcom/fasterxml/aalto/out/StreamWriterBase;->writeSpace([CII)V

    .line 387
    return-void

    .line 391
    :cond_1
    iget v1, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_vldContent:I

    if-gt v1, v0, :cond_3

    .line 392
    iget v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_vldContent:I

    const/4 v1, 0x4

    if-nez v0, :cond_2

    .line 393
    invoke-virtual {p0, v1}, Lcom/fasterxml/aalto/out/StreamWriterBase;->_reportInvalidContent(I)V

    goto :goto_0

    .line 395
    :cond_2
    iget-object v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_config:Lcom/fasterxml/aalto/out/WriterConfig;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/out/WriterConfig;->isXml11()Z

    move-result v0

    invoke-static {p1, p2, p3, v0}, Lcom/fasterxml/aalto/util/TextUtil;->isAllWhitespace([CIIZ)Z

    move-result v0

    if-nez v0, :cond_4

    .line 396
    invoke-virtual {p0, v1}, Lcom/fasterxml/aalto/out/StreamWriterBase;->_reportInvalidContent(I)V

    goto :goto_0

    .line 399
    :cond_3
    iget v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_vldContent:I

    const/4 v1, 0x3

    if-ne v0, v1, :cond_4

    .line 400
    iget-object v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_validator:Lorg/codehaus/stax2/validation/XMLValidator;

    if-eqz v0, :cond_4

    .line 403
    iget-object v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_validator:Lorg/codehaus/stax2/validation/XMLValidator;

    const/4 v1, 0x0

    invoke-virtual {v0, p1, p2, p3, v1}, Lorg/codehaus/stax2/validation/XMLValidator;->validateText([CIIZ)V

    .line 406
    :cond_4
    :goto_0
    if-lez p3, :cond_5

    .line 408
    :try_start_0
    iget-object v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_xmlWriter:Lcom/fasterxml/aalto/out/XmlWriter;

    invoke-virtual {v0, p1, p2, p3}, Lcom/fasterxml/aalto/out/XmlWriter;->writeCharacters([CII)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 411
    goto :goto_1

    .line 409
    :catch_0
    move-exception v0

    .line 410
    .local v0, "ioe":Ljava/io/IOException;
    new-instance v1, Lcom/fasterxml/aalto/impl/IoStreamException;

    invoke-direct {v1, v0}, Lcom/fasterxml/aalto/impl/IoStreamException;-><init>(Ljava/io/IOException;)V

    throw v1

    .line 413
    .end local v0    # "ioe":Ljava/io/IOException;
    :cond_5
    :goto_1
    return-void
.end method

.method public writeComment(Ljava/lang/String;)V
    .locals 3
    .param p1, "data"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 460
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_stateAnyOutput:Z

    .line 461
    iget-boolean v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_stateStartElementOpen:Z

    if-eqz v0, :cond_0

    .line 462
    iget-boolean v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_stateEmptyElement:Z

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/out/StreamWriterBase;->_closeStartElement(Z)V

    .line 464
    :cond_0
    iget v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_vldContent:I

    if-nez v0, :cond_1

    .line 465
    const/4 v0, 0x5

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/out/StreamWriterBase;->_reportInvalidContent(I)V

    .line 473
    :cond_1
    :try_start_0
    iget-object v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_xmlWriter:Lcom/fasterxml/aalto/out/XmlWriter;

    invoke-virtual {v0, p1}, Lcom/fasterxml/aalto/out/XmlWriter;->writeComment(Ljava/lang/String;)I

    move-result v0

    .line 474
    .local v0, "ix":I
    if-ltz v0, :cond_2

    .line 475
    sget-object v1, Lcom/fasterxml/aalto/impl/ErrorConsts;->WERR_COMMENT_CONTENT:Ljava/lang/String;

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/fasterxml/aalto/out/StreamWriterBase;->_reportNwfContent(Ljava/lang/String;Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 479
    .end local v0    # "ix":I
    :cond_2
    nop

    .line 480
    return-void

    .line 477
    :catch_0
    move-exception v0

    .line 478
    .local v0, "ioe":Ljava/io/IOException;
    new-instance v1, Lcom/fasterxml/aalto/impl/IoStreamException;

    invoke-direct {v1, v0}, Lcom/fasterxml/aalto/impl/IoStreamException;-><init>(Ljava/io/IOException;)V

    throw v1
.end method

.method public final writeDTD(Ljava/lang/String;)V
    .locals 2
    .param p1, "dtd"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 488
    invoke-virtual {p0}, Lcom/fasterxml/aalto/out/StreamWriterBase;->_verifyWriteDTD()V

    .line 489
    const-string v0, ""

    iput-object v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_dtdRootElemName:Ljava/lang/String;

    .line 491
    :try_start_0
    iget-object v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_xmlWriter:Lcom/fasterxml/aalto/out/XmlWriter;

    invoke-virtual {v0, p1}, Lcom/fasterxml/aalto/out/XmlWriter;->writeDTD(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 494
    nop

    .line 495
    return-void

    .line 492
    :catch_0
    move-exception v0

    .line 493
    .local v0, "ioe":Ljava/io/IOException;
    new-instance v1, Lcom/fasterxml/aalto/impl/IoStreamException;

    invoke-direct {v1, v0}, Lcom/fasterxml/aalto/impl/IoStreamException;-><init>(Ljava/io/IOException;)V

    throw v1
.end method

.method public writeDTD(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 2
    .param p1, "rootName"    # Ljava/lang/String;
    .param p2, "systemId"    # Ljava/lang/String;
    .param p3, "publicId"    # Ljava/lang/String;
    .param p4, "internalSubset"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1187
    invoke-virtual {p0}, Lcom/fasterxml/aalto/out/StreamWriterBase;->_verifyWriteDTD()V

    .line 1188
    iput-object p1, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_dtdRootElemName:Ljava/lang/String;

    .line 1190
    :try_start_0
    iget-object v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_xmlWriter:Lcom/fasterxml/aalto/out/XmlWriter;

    iget-object v1, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_symbols:Lcom/fasterxml/aalto/out/WNameTable;

    invoke-virtual {v1, p1}, Lcom/fasterxml/aalto/out/WNameTable;->findSymbol(Ljava/lang/String;)Lcom/fasterxml/aalto/out/WName;

    move-result-object v1

    invoke-virtual {v0, v1, p2, p3, p4}, Lcom/fasterxml/aalto/out/XmlWriter;->writeDTD(Lcom/fasterxml/aalto/out/WName;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 1193
    nop

    .line 1194
    return-void

    .line 1191
    :catch_0
    move-exception v0

    .line 1192
    .local v0, "ioe":Ljava/io/IOException;
    new-instance v1, Lcom/fasterxml/aalto/impl/IoStreamException;

    invoke-direct {v1, v0}, Lcom/fasterxml/aalto/impl/IoStreamException;-><init>(Ljava/io/IOException;)V

    throw v1
.end method

.method public writeDTD(Lorg/codehaus/stax2/DTDInfo;)V
    .locals 4
    .param p1, "info"    # Lorg/codehaus/stax2/DTDInfo;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1177
    invoke-interface {p1}, Lorg/codehaus/stax2/DTDInfo;->getDTDRootName()Ljava/lang/String;

    move-result-object v0

    .line 1178
    invoke-interface {p1}, Lorg/codehaus/stax2/DTDInfo;->getDTDSystemId()Ljava/lang/String;

    move-result-object v1

    .line 1179
    invoke-interface {p1}, Lorg/codehaus/stax2/DTDInfo;->getDTDPublicId()Ljava/lang/String;

    move-result-object v2

    invoke-interface {p1}, Lorg/codehaus/stax2/DTDInfo;->getDTDInternalSubset()Ljava/lang/String;

    move-result-object v3

    .line 1177
    invoke-virtual {p0, v0, v1, v2, v3}, Lcom/fasterxml/aalto/out/StreamWriterBase;->writeDTD(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 1180
    return-void
.end method

.method public writeDecimal(Ljava/math/BigDecimal;)V
    .locals 2
    .param p1, "value"    # Ljava/math/BigDecimal;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 797
    invoke-virtual {p0}, Lcom/fasterxml/aalto/out/StreamWriterBase;->valueEncoderFactory()Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory;

    move-result-object v0

    invoke-virtual {p1}, Ljava/math/BigDecimal;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory;->getScalarEncoder(Ljava/lang/String;)Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$ScalarEncoder;

    move-result-object v0

    invoke-direct {p0, v0}, Lcom/fasterxml/aalto/out/StreamWriterBase;->writeTypedElement(Lorg/codehaus/stax2/ri/typed/AsciiValueEncoder;)V

    .line 798
    return-void
.end method

.method public final writeDecimalAttribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/math/BigDecimal;)V
    .locals 2
    .param p1, "prefix"    # Ljava/lang/String;
    .param p2, "nsURI"    # Ljava/lang/String;
    .param p3, "localName"    # Ljava/lang/String;
    .param p4, "value"    # Ljava/math/BigDecimal;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 918
    nop

    .line 919
    invoke-virtual {p0}, Lcom/fasterxml/aalto/out/StreamWriterBase;->valueEncoderFactory()Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory;

    move-result-object v0

    invoke-virtual {p4}, Ljava/math/BigDecimal;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory;->getScalarEncoder(Ljava/lang/String;)Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$ScalarEncoder;

    move-result-object v0

    .line 918
    invoke-virtual {p0, p1, p2, p3, v0}, Lcom/fasterxml/aalto/out/StreamWriterBase;->writeTypedAttribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lorg/codehaus/stax2/ri/typed/AsciiValueEncoder;)V

    .line 920
    return-void
.end method

.method public abstract writeDefaultNamespace(Ljava/lang/String;)V
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method

.method public writeDouble(D)V
    .locals 1
    .param p1, "value"    # D
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 781
    invoke-virtual {p0}, Lcom/fasterxml/aalto/out/StreamWriterBase;->valueEncoderFactory()Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory;

    move-result-object v0

    invoke-virtual {v0, p1, p2}, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory;->getEncoder(D)Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$DoubleEncoder;

    move-result-object v0

    invoke-direct {p0, v0}, Lcom/fasterxml/aalto/out/StreamWriterBase;->writeTypedElement(Lorg/codehaus/stax2/ri/typed/AsciiValueEncoder;)V

    .line 782
    return-void
.end method

.method public writeDoubleArray([DII)V
    .locals 1
    .param p1, "value"    # [D
    .param p2, "from"    # I
    .param p3, "length"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 832
    invoke-virtual {p0}, Lcom/fasterxml/aalto/out/StreamWriterBase;->valueEncoderFactory()Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory;

    move-result-object v0

    invoke-virtual {v0, p1, p2, p3}, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory;->getEncoder([DII)Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$DoubleArrayEncoder;

    move-result-object v0

    invoke-direct {p0, v0}, Lcom/fasterxml/aalto/out/StreamWriterBase;->writeTypedElement(Lorg/codehaus/stax2/ri/typed/AsciiValueEncoder;)V

    .line 833
    return-void
.end method

.method public writeDoubleArrayAttribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[D)V
    .locals 3
    .param p1, "prefix"    # Ljava/lang/String;
    .param p2, "nsURI"    # Ljava/lang/String;
    .param p3, "localName"    # Ljava/lang/String;
    .param p4, "value"    # [D
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 960
    nop

    .line 961
    invoke-virtual {p0}, Lcom/fasterxml/aalto/out/StreamWriterBase;->valueEncoderFactory()Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory;

    move-result-object v0

    const/4 v1, 0x0

    array-length v2, p4

    invoke-virtual {v0, p4, v1, v2}, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory;->getEncoder([DII)Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$DoubleArrayEncoder;

    move-result-object v0

    .line 960
    invoke-virtual {p0, p1, p2, p3, v0}, Lcom/fasterxml/aalto/out/StreamWriterBase;->writeTypedAttribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lorg/codehaus/stax2/ri/typed/AsciiValueEncoder;)V

    .line 962
    return-void
.end method

.method public final writeDoubleAttribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;D)V
    .locals 1
    .param p1, "prefix"    # Ljava/lang/String;
    .param p2, "nsURI"    # Ljava/lang/String;
    .param p3, "localName"    # Ljava/lang/String;
    .param p4, "value"    # D
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 902
    nop

    .line 903
    invoke-virtual {p0}, Lcom/fasterxml/aalto/out/StreamWriterBase;->valueEncoderFactory()Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory;

    move-result-object v0

    invoke-virtual {v0, p4, p5}, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory;->getEncoder(D)Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$DoubleEncoder;

    move-result-object v0

    .line 902
    invoke-virtual {p0, p1, p2, p3, v0}, Lcom/fasterxml/aalto/out/StreamWriterBase;->writeTypedAttribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lorg/codehaus/stax2/ri/typed/AsciiValueEncoder;)V

    .line 904
    return-void
.end method

.method public writeEmptyElement(Ljava/lang/String;)V
    .locals 3
    .param p1, "localName"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 506
    const/4 v0, 0x0

    invoke-virtual {p0, v0, p1}, Lcom/fasterxml/aalto/out/StreamWriterBase;->_verifyStartElement(Ljava/lang/String;Ljava/lang/String;)V

    .line 507
    iget-object v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_symbols:Lcom/fasterxml/aalto/out/WNameTable;

    invoke-virtual {v0, p1}, Lcom/fasterxml/aalto/out/WNameTable;->findSymbol(Ljava/lang/String;)Lcom/fasterxml/aalto/out/WName;

    move-result-object v0

    .line 508
    .local v0, "name":Lcom/fasterxml/aalto/out/WName;
    iget-object v1, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_validator:Lorg/codehaus/stax2/validation/XMLValidator;

    if-eqz v1, :cond_0

    .line 509
    iget-object v1, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_validator:Lorg/codehaus/stax2/validation/XMLValidator;

    const-string v2, ""

    invoke-virtual {v1, p1, v2, v2}, Lorg/codehaus/stax2/validation/XMLValidator;->validateElementStart(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 511
    :cond_0
    const/4 v1, 0x1

    invoke-virtual {p0, v0, v1}, Lcom/fasterxml/aalto/out/StreamWriterBase;->_writeStartTag(Lcom/fasterxml/aalto/out/WName;Z)V

    .line 512
    return-void
.end method

.method public abstract writeEmptyElement(Ljava/lang/String;Ljava/lang/String;)V
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method

.method public abstract writeEmptyElement(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method

.method public writeEndDocument()V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 524
    const/4 v0, 0x0

    invoke-direct {p0, v0}, Lcom/fasterxml/aalto/out/StreamWriterBase;->_finishDocument(Z)V

    .line 525
    return-void
.end method

.method public writeEndElement()V
    .locals 5
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 534
    iget-boolean v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_stateStartElementOpen:Z

    const/4 v1, 0x1

    const/4 v2, 0x0

    if-eqz v0, :cond_0

    iget-boolean v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_stateEmptyElement:Z

    if-eqz v0, :cond_0

    .line 535
    iput-boolean v2, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_stateEmptyElement:Z

    .line 536
    invoke-virtual {p0, v1}, Lcom/fasterxml/aalto/out/StreamWriterBase;->_closeStartElement(Z)V

    .line 540
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_state:Lcom/fasterxml/aalto/out/StreamWriterBase$State;

    sget-object v3, Lcom/fasterxml/aalto/out/StreamWriterBase$State;->TREE:Lcom/fasterxml/aalto/out/StreamWriterBase$State;

    if-eq v0, v3, :cond_1

    .line 541
    const-string v0, "No open start element, when trying to write end element"

    invoke-static {v0}, Lcom/fasterxml/aalto/out/StreamWriterBase;->_reportNwfStructure(Ljava/lang/String;)V

    .line 544
    :cond_1
    iget-object v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_currElem:Lcom/fasterxml/aalto/out/OutputElement;

    .line 547
    .local v0, "thisElem":Lcom/fasterxml/aalto/out/OutputElement;
    invoke-virtual {v0}, Lcom/fasterxml/aalto/out/OutputElement;->getParent()Lcom/fasterxml/aalto/out/OutputElement;

    move-result-object v3

    iput-object v3, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_currElem:Lcom/fasterxml/aalto/out/OutputElement;

    .line 548
    iget v3, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_poolSize:I

    const/16 v4, 0x8

    if-ge v3, v4, :cond_2

    .line 549
    iget-object v3, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_outputElemPool:Lcom/fasterxml/aalto/out/OutputElement;

    invoke-virtual {v0, v3}, Lcom/fasterxml/aalto/out/OutputElement;->addToPool(Lcom/fasterxml/aalto/out/OutputElement;)V

    .line 550
    iput-object v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_outputElemPool:Lcom/fasterxml/aalto/out/OutputElement;

    .line 551
    iget v3, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_poolSize:I

    add-int/2addr v3, v1

    iput v3, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_poolSize:I

    .line 554
    :cond_2
    nop

    .line 567
    :try_start_0
    iget-boolean v1, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_stateStartElementOpen:Z

    if-eqz v1, :cond_3

    .line 571
    iput-boolean v2, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_stateStartElementOpen:Z

    .line 572
    iget-object v1, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_xmlWriter:Lcom/fasterxml/aalto/out/XmlWriter;

    invoke-virtual {v1}, Lcom/fasterxml/aalto/out/XmlWriter;->writeStartTagEmptyEnd()V

    goto :goto_0

    .line 574
    :cond_3
    iget-object v1, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_xmlWriter:Lcom/fasterxml/aalto/out/XmlWriter;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/out/OutputElement;->getName()Lcom/fasterxml/aalto/out/WName;

    move-result-object v2

    invoke-virtual {v1, v2}, Lcom/fasterxml/aalto/out/XmlWriter;->writeEndTag(Lcom/fasterxml/aalto/out/WName;)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 578
    :goto_0
    nop

    .line 579
    iget-object v1, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_currElem:Lcom/fasterxml/aalto/out/OutputElement;

    invoke-virtual {v1}, Lcom/fasterxml/aalto/out/OutputElement;->isRoot()Z

    move-result v1

    if-eqz v1, :cond_4

    .line 580
    sget-object v1, Lcom/fasterxml/aalto/out/StreamWriterBase$State;->EPILOG:Lcom/fasterxml/aalto/out/StreamWriterBase$State;

    iput-object v1, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_state:Lcom/fasterxml/aalto/out/StreamWriterBase$State;

    .line 584
    :cond_4
    iget-object v1, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_validator:Lorg/codehaus/stax2/validation/XMLValidator;

    if-eqz v1, :cond_5

    .line 585
    iget-object v1, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_validator:Lorg/codehaus/stax2/validation/XMLValidator;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/out/OutputElement;->getLocalName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0}, Lcom/fasterxml/aalto/out/OutputElement;->getNonNullPrefix()Ljava/lang/String;

    move-result-object v3

    .line 586
    invoke-virtual {v0}, Lcom/fasterxml/aalto/out/OutputElement;->getNonNullNamespaceURI()Ljava/lang/String;

    move-result-object v4

    .line 585
    invoke-virtual {v1, v2, v3, v4}, Lorg/codehaus/stax2/validation/XMLValidator;->validateElementEnd(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    iput v1, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_vldContent:I

    .line 588
    :cond_5
    return-void

    .line 576
    :catch_0
    move-exception v1

    .line 577
    .local v1, "ioe":Ljava/io/IOException;
    new-instance v2, Lcom/fasterxml/aalto/impl/IoStreamException;

    invoke-direct {v2, v1}, Lcom/fasterxml/aalto/impl/IoStreamException;-><init>(Ljava/io/IOException;)V

    throw v2
.end method

.method public writeEntityRef(Ljava/lang/String;)V
    .locals 2
    .param p1, "name"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 594
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_stateAnyOutput:Z

    .line 595
    iget-boolean v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_stateStartElementOpen:Z

    if-eqz v0, :cond_0

    .line 596
    iget-boolean v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_stateEmptyElement:Z

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/out/StreamWriterBase;->_closeStartElement(Z)V

    .line 600
    :cond_0
    iget-boolean v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_cfgCheckStructure:Z

    if-eqz v0, :cond_1

    .line 601
    invoke-virtual {p0}, Lcom/fasterxml/aalto/out/StreamWriterBase;->inPrologOrEpilog()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 602
    sget-object v0, Lcom/fasterxml/aalto/impl/ErrorConsts;->WERR_PROLOG_ENTITY:Ljava/lang/String;

    invoke-static {v0}, Lcom/fasterxml/aalto/out/StreamWriterBase;->_reportNwfStructure(Ljava/lang/String;)V

    .line 606
    :cond_1
    iget v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_vldContent:I

    if-nez v0, :cond_2

    .line 608
    const/16 v0, 0x9

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/out/StreamWriterBase;->_reportInvalidContent(I)V

    .line 611
    :cond_2
    :try_start_0
    iget-object v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_xmlWriter:Lcom/fasterxml/aalto/out/XmlWriter;

    iget-object v1, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_symbols:Lcom/fasterxml/aalto/out/WNameTable;

    invoke-virtual {v1, p1}, Lcom/fasterxml/aalto/out/WNameTable;->findSymbol(Ljava/lang/String;)Lcom/fasterxml/aalto/out/WName;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/fasterxml/aalto/out/XmlWriter;->writeEntityReference(Lcom/fasterxml/aalto/out/WName;)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 614
    nop

    .line 615
    return-void

    .line 612
    :catch_0
    move-exception v0

    .line 613
    .local v0, "ioe":Ljava/io/IOException;
    new-instance v1, Lcom/fasterxml/aalto/impl/IoStreamException;

    invoke-direct {v1, v0}, Lcom/fasterxml/aalto/impl/IoStreamException;-><init>(Ljava/io/IOException;)V

    throw v1
.end method

.method public writeFloat(F)V
    .locals 1
    .param p1, "value"    # F
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 774
    invoke-virtual {p0}, Lcom/fasterxml/aalto/out/StreamWriterBase;->valueEncoderFactory()Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory;

    move-result-object v0

    invoke-virtual {v0, p1}, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory;->getEncoder(F)Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$FloatEncoder;

    move-result-object v0

    invoke-direct {p0, v0}, Lcom/fasterxml/aalto/out/StreamWriterBase;->writeTypedElement(Lorg/codehaus/stax2/ri/typed/AsciiValueEncoder;)V

    .line 775
    return-void
.end method

.method public writeFloatArray([FII)V
    .locals 1
    .param p1, "value"    # [F
    .param p2, "from"    # I
    .param p3, "length"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 825
    invoke-virtual {p0}, Lcom/fasterxml/aalto/out/StreamWriterBase;->valueEncoderFactory()Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory;

    move-result-object v0

    invoke-virtual {v0, p1, p2, p3}, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory;->getEncoder([FII)Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$FloatArrayEncoder;

    move-result-object v0

    invoke-direct {p0, v0}, Lcom/fasterxml/aalto/out/StreamWriterBase;->writeTypedElement(Lorg/codehaus/stax2/ri/typed/AsciiValueEncoder;)V

    .line 826
    return-void
.end method

.method public writeFloatArrayAttribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[F)V
    .locals 3
    .param p1, "prefix"    # Ljava/lang/String;
    .param p2, "nsURI"    # Ljava/lang/String;
    .param p3, "localName"    # Ljava/lang/String;
    .param p4, "value"    # [F
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 952
    nop

    .line 953
    invoke-virtual {p0}, Lcom/fasterxml/aalto/out/StreamWriterBase;->valueEncoderFactory()Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory;

    move-result-object v0

    const/4 v1, 0x0

    array-length v2, p4

    invoke-virtual {v0, p4, v1, v2}, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory;->getEncoder([FII)Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$FloatArrayEncoder;

    move-result-object v0

    .line 952
    invoke-virtual {p0, p1, p2, p3, v0}, Lcom/fasterxml/aalto/out/StreamWriterBase;->writeTypedAttribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lorg/codehaus/stax2/ri/typed/AsciiValueEncoder;)V

    .line 954
    return-void
.end method

.method public final writeFloatAttribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;F)V
    .locals 1
    .param p1, "prefix"    # Ljava/lang/String;
    .param p2, "nsURI"    # Ljava/lang/String;
    .param p3, "localName"    # Ljava/lang/String;
    .param p4, "value"    # F
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 894
    nop

    .line 895
    invoke-virtual {p0}, Lcom/fasterxml/aalto/out/StreamWriterBase;->valueEncoderFactory()Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory;

    move-result-object v0

    invoke-virtual {v0, p4}, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory;->getEncoder(F)Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$FloatEncoder;

    move-result-object v0

    .line 894
    invoke-virtual {p0, p1, p2, p3, v0}, Lcom/fasterxml/aalto/out/StreamWriterBase;->writeTypedAttribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lorg/codehaus/stax2/ri/typed/AsciiValueEncoder;)V

    .line 896
    return-void
.end method

.method public writeFullEndElement()V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1203
    iget-boolean v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_stateStartElementOpen:Z

    if-eqz v0, :cond_0

    iget-boolean v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_stateEmptyElement:Z

    if-eqz v0, :cond_0

    .line 1204
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_stateEmptyElement:Z

    .line 1208
    const/4 v0, 0x1

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/out/StreamWriterBase;->_closeStartElement(Z)V

    .line 1210
    :cond_0
    invoke-virtual {p0}, Lcom/fasterxml/aalto/out/StreamWriterBase;->writeEndElement()V

    .line 1211
    return-void
.end method

.method public writeInt(I)V
    .locals 1
    .param p1, "value"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 760
    invoke-virtual {p0}, Lcom/fasterxml/aalto/out/StreamWriterBase;->valueEncoderFactory()Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory;

    move-result-object v0

    invoke-virtual {v0, p1}, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory;->getEncoder(I)Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$IntEncoder;

    move-result-object v0

    invoke-direct {p0, v0}, Lcom/fasterxml/aalto/out/StreamWriterBase;->writeTypedElement(Lorg/codehaus/stax2/ri/typed/AsciiValueEncoder;)V

    .line 761
    return-void
.end method

.method public final writeIntArray([III)V
    .locals 1
    .param p1, "value"    # [I
    .param p2, "from"    # I
    .param p3, "length"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 811
    invoke-virtual {p0}, Lcom/fasterxml/aalto/out/StreamWriterBase;->valueEncoderFactory()Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory;

    move-result-object v0

    invoke-virtual {v0, p1, p2, p3}, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory;->getEncoder([III)Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$IntArrayEncoder;

    move-result-object v0

    invoke-direct {p0, v0}, Lcom/fasterxml/aalto/out/StreamWriterBase;->writeTypedElement(Lorg/codehaus/stax2/ri/typed/AsciiValueEncoder;)V

    .line 812
    return-void
.end method

.method public writeIntArrayAttribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[I)V
    .locals 3
    .param p1, "prefix"    # Ljava/lang/String;
    .param p2, "nsURI"    # Ljava/lang/String;
    .param p3, "localName"    # Ljava/lang/String;
    .param p4, "value"    # [I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 936
    nop

    .line 937
    invoke-virtual {p0}, Lcom/fasterxml/aalto/out/StreamWriterBase;->valueEncoderFactory()Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory;

    move-result-object v0

    const/4 v1, 0x0

    array-length v2, p4

    invoke-virtual {v0, p4, v1, v2}, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory;->getEncoder([III)Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$IntArrayEncoder;

    move-result-object v0

    .line 936
    invoke-virtual {p0, p1, p2, p3, v0}, Lcom/fasterxml/aalto/out/StreamWriterBase;->writeTypedAttribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lorg/codehaus/stax2/ri/typed/AsciiValueEncoder;)V

    .line 938
    return-void
.end method

.method public final writeIntAttribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;I)V
    .locals 1
    .param p1, "prefix"    # Ljava/lang/String;
    .param p2, "nsURI"    # Ljava/lang/String;
    .param p3, "localName"    # Ljava/lang/String;
    .param p4, "value"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 878
    nop

    .line 879
    invoke-virtual {p0}, Lcom/fasterxml/aalto/out/StreamWriterBase;->valueEncoderFactory()Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory;

    move-result-object v0

    invoke-virtual {v0, p4}, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory;->getEncoder(I)Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$IntEncoder;

    move-result-object v0

    .line 878
    invoke-virtual {p0, p1, p2, p3, v0}, Lcom/fasterxml/aalto/out/StreamWriterBase;->writeTypedAttribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lorg/codehaus/stax2/ri/typed/AsciiValueEncoder;)V

    .line 880
    return-void
.end method

.method public writeInteger(Ljava/math/BigInteger;)V
    .locals 2
    .param p1, "value"    # Ljava/math/BigInteger;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 789
    invoke-virtual {p0}, Lcom/fasterxml/aalto/out/StreamWriterBase;->valueEncoderFactory()Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory;

    move-result-object v0

    invoke-virtual {p1}, Ljava/math/BigInteger;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory;->getScalarEncoder(Ljava/lang/String;)Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$ScalarEncoder;

    move-result-object v0

    invoke-direct {p0, v0}, Lcom/fasterxml/aalto/out/StreamWriterBase;->writeTypedElement(Lorg/codehaus/stax2/ri/typed/AsciiValueEncoder;)V

    .line 790
    return-void
.end method

.method public final writeIntegerAttribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/math/BigInteger;)V
    .locals 2
    .param p1, "prefix"    # Ljava/lang/String;
    .param p2, "nsURI"    # Ljava/lang/String;
    .param p3, "localName"    # Ljava/lang/String;
    .param p4, "value"    # Ljava/math/BigInteger;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 910
    nop

    .line 911
    invoke-virtual {p0}, Lcom/fasterxml/aalto/out/StreamWriterBase;->valueEncoderFactory()Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory;

    move-result-object v0

    invoke-virtual {p4}, Ljava/math/BigInteger;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory;->getScalarEncoder(Ljava/lang/String;)Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$ScalarEncoder;

    move-result-object v0

    .line 910
    invoke-virtual {p0, p1, p2, p3, v0}, Lcom/fasterxml/aalto/out/StreamWriterBase;->writeTypedAttribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lorg/codehaus/stax2/ri/typed/AsciiValueEncoder;)V

    .line 912
    return-void
.end method

.method public writeLong(J)V
    .locals 1
    .param p1, "value"    # J
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 767
    invoke-virtual {p0}, Lcom/fasterxml/aalto/out/StreamWriterBase;->valueEncoderFactory()Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory;

    move-result-object v0

    invoke-virtual {v0, p1, p2}, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory;->getEncoder(J)Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$LongEncoder;

    move-result-object v0

    invoke-direct {p0, v0}, Lcom/fasterxml/aalto/out/StreamWriterBase;->writeTypedElement(Lorg/codehaus/stax2/ri/typed/AsciiValueEncoder;)V

    .line 768
    return-void
.end method

.method public writeLongArray([JII)V
    .locals 1
    .param p1, "value"    # [J
    .param p2, "from"    # I
    .param p3, "length"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 818
    invoke-virtual {p0}, Lcom/fasterxml/aalto/out/StreamWriterBase;->valueEncoderFactory()Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory;

    move-result-object v0

    invoke-virtual {v0, p1, p2, p3}, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory;->getEncoder([JII)Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$LongArrayEncoder;

    move-result-object v0

    invoke-direct {p0, v0}, Lcom/fasterxml/aalto/out/StreamWriterBase;->writeTypedElement(Lorg/codehaus/stax2/ri/typed/AsciiValueEncoder;)V

    .line 819
    return-void
.end method

.method public writeLongArrayAttribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[J)V
    .locals 3
    .param p1, "prefix"    # Ljava/lang/String;
    .param p2, "nsURI"    # Ljava/lang/String;
    .param p3, "localName"    # Ljava/lang/String;
    .param p4, "value"    # [J
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 944
    nop

    .line 945
    invoke-virtual {p0}, Lcom/fasterxml/aalto/out/StreamWriterBase;->valueEncoderFactory()Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory;

    move-result-object v0

    const/4 v1, 0x0

    array-length v2, p4

    invoke-virtual {v0, p4, v1, v2}, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory;->getEncoder([JII)Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$LongArrayEncoder;

    move-result-object v0

    .line 944
    invoke-virtual {p0, p1, p2, p3, v0}, Lcom/fasterxml/aalto/out/StreamWriterBase;->writeTypedAttribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lorg/codehaus/stax2/ri/typed/AsciiValueEncoder;)V

    .line 946
    return-void
.end method

.method public final writeLongAttribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;J)V
    .locals 1
    .param p1, "prefix"    # Ljava/lang/String;
    .param p2, "nsURI"    # Ljava/lang/String;
    .param p3, "localName"    # Ljava/lang/String;
    .param p4, "value"    # J
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 886
    nop

    .line 887
    invoke-virtual {p0}, Lcom/fasterxml/aalto/out/StreamWriterBase;->valueEncoderFactory()Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory;

    move-result-object v0

    invoke-virtual {v0, p4, p5}, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory;->getEncoder(J)Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$LongEncoder;

    move-result-object v0

    .line 886
    invoke-virtual {p0, p1, p2, p3, v0}, Lcom/fasterxml/aalto/out/StreamWriterBase;->writeTypedAttribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lorg/codehaus/stax2/ri/typed/AsciiValueEncoder;)V

    .line 888
    return-void
.end method

.method public abstract writeNamespace(Ljava/lang/String;Ljava/lang/String;)V
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method

.method public writeProcessingInstruction(Ljava/lang/String;)V
    .locals 1
    .param p1, "target"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 623
    const/4 v0, 0x0

    invoke-virtual {p0, p1, v0}, Lcom/fasterxml/aalto/out/StreamWriterBase;->writeProcessingInstruction(Ljava/lang/String;Ljava/lang/String;)V

    .line 624
    return-void
.end method

.method public writeProcessingInstruction(Ljava/lang/String;Ljava/lang/String;)V
    .locals 3
    .param p1, "target"    # Ljava/lang/String;
    .param p2, "data"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 630
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_stateAnyOutput:Z

    .line 631
    iget-boolean v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_stateStartElementOpen:Z

    if-eqz v0, :cond_0

    .line 632
    iget-boolean v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_stateEmptyElement:Z

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/out/StreamWriterBase;->_closeStartElement(Z)V

    .line 638
    :cond_0
    iget v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_vldContent:I

    if-nez v0, :cond_1

    .line 639
    const/4 v0, 0x3

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/out/StreamWriterBase;->_reportInvalidContent(I)V

    .line 643
    :cond_1
    :try_start_0
    iget-object v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_xmlWriter:Lcom/fasterxml/aalto/out/XmlWriter;

    iget-object v1, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_symbols:Lcom/fasterxml/aalto/out/WNameTable;

    invoke-virtual {v1, p1}, Lcom/fasterxml/aalto/out/WNameTable;->findSymbol(Ljava/lang/String;)Lcom/fasterxml/aalto/out/WName;

    move-result-object v1

    invoke-virtual {v0, v1, p2}, Lcom/fasterxml/aalto/out/XmlWriter;->writePI(Lcom/fasterxml/aalto/out/WName;Ljava/lang/String;)I

    move-result v0

    .line 644
    .local v0, "ix":I
    if-ltz v0, :cond_2

    .line 645
    sget-object v1, Lcom/fasterxml/aalto/impl/ErrorConsts;->WERR_PI_CONTENT:Ljava/lang/String;

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/fasterxml/aalto/out/StreamWriterBase;->_reportNwfContent(Ljava/lang/String;Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 649
    .end local v0    # "ix":I
    :cond_2
    nop

    .line 650
    return-void

    .line 647
    :catch_0
    move-exception v0

    .line 648
    .local v0, "ioe":Ljava/io/IOException;
    new-instance v1, Lcom/fasterxml/aalto/impl/IoStreamException;

    invoke-direct {v1, v0}, Lcom/fasterxml/aalto/impl/IoStreamException;-><init>(Ljava/io/IOException;)V

    throw v1
.end method

.method public writeQName(Ljavax/xml/namespace/QName;)V
    .locals 2
    .param p1, "value"    # Ljavax/xml/namespace/QName;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 804
    invoke-virtual {p0}, Lcom/fasterxml/aalto/out/StreamWriterBase;->valueEncoderFactory()Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory;

    move-result-object v0

    invoke-virtual {p0, p1}, Lcom/fasterxml/aalto/out/StreamWriterBase;->_serializeQName(Ljavax/xml/namespace/QName;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory;->getScalarEncoder(Ljava/lang/String;)Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$ScalarEncoder;

    move-result-object v0

    invoke-direct {p0, v0}, Lcom/fasterxml/aalto/out/StreamWriterBase;->writeTypedElement(Lorg/codehaus/stax2/ri/typed/AsciiValueEncoder;)V

    .line 805
    return-void
.end method

.method public final writeQNameAttribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljavax/xml/namespace/QName;)V
    .locals 1
    .param p1, "prefix"    # Ljava/lang/String;
    .param p2, "nsURI"    # Ljava/lang/String;
    .param p3, "localName"    # Ljava/lang/String;
    .param p4, "value"    # Ljavax/xml/namespace/QName;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 929
    invoke-virtual {p0, p4}, Lcom/fasterxml/aalto/out/StreamWriterBase;->_serializeQName(Ljavax/xml/namespace/QName;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, p1, p2, p3, v0}, Lcom/fasterxml/aalto/out/StreamWriterBase;->writeAttribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 930
    return-void
.end method

.method public writeRaw(Ljava/lang/String;)V
    .locals 3
    .param p1, "text"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1224
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_stateAnyOutput:Z

    .line 1225
    iget-boolean v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_stateStartElementOpen:Z

    if-eqz v0, :cond_0

    .line 1226
    iget-boolean v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_stateEmptyElement:Z

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/out/StreamWriterBase;->_closeStartElement(Z)V

    .line 1229
    :cond_0
    :try_start_0
    iget-object v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_xmlWriter:Lcom/fasterxml/aalto/out/XmlWriter;

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v1

    const/4 v2, 0x0

    invoke-virtual {v0, p1, v2, v1}, Lcom/fasterxml/aalto/out/XmlWriter;->writeRaw(Ljava/lang/String;II)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 1232
    nop

    .line 1233
    return-void

    .line 1230
    :catch_0
    move-exception v0

    .line 1231
    .local v0, "ioe":Ljava/io/IOException;
    new-instance v1, Lcom/fasterxml/aalto/impl/IoStreamException;

    invoke-direct {v1, v0}, Lcom/fasterxml/aalto/impl/IoStreamException;-><init>(Ljava/io/IOException;)V

    throw v1
.end method

.method public writeRaw(Ljava/lang/String;II)V
    .locals 2
    .param p1, "text"    # Ljava/lang/String;
    .param p2, "start"    # I
    .param p3, "offset"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1238
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_stateAnyOutput:Z

    .line 1239
    iget-boolean v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_stateStartElementOpen:Z

    if-eqz v0, :cond_0

    .line 1240
    iget-boolean v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_stateEmptyElement:Z

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/out/StreamWriterBase;->_closeStartElement(Z)V

    .line 1243
    :cond_0
    :try_start_0
    iget-object v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_xmlWriter:Lcom/fasterxml/aalto/out/XmlWriter;

    invoke-virtual {v0, p1, p2, p3}, Lcom/fasterxml/aalto/out/XmlWriter;->writeRaw(Ljava/lang/String;II)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 1246
    nop

    .line 1247
    return-void

    .line 1244
    :catch_0
    move-exception v0

    .line 1245
    .local v0, "ioe":Ljava/io/IOException;
    new-instance v1, Lcom/fasterxml/aalto/impl/IoStreamException;

    invoke-direct {v1, v0}, Lcom/fasterxml/aalto/impl/IoStreamException;-><init>(Ljava/io/IOException;)V

    throw v1
.end method

.method public writeRaw([CII)V
    .locals 2
    .param p1, "text"    # [C
    .param p2, "offset"    # I
    .param p3, "length"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1252
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_stateAnyOutput:Z

    .line 1253
    iget-boolean v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_stateStartElementOpen:Z

    if-eqz v0, :cond_0

    .line 1254
    iget-boolean v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_stateEmptyElement:Z

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/out/StreamWriterBase;->_closeStartElement(Z)V

    .line 1257
    :cond_0
    :try_start_0
    iget-object v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_xmlWriter:Lcom/fasterxml/aalto/out/XmlWriter;

    invoke-virtual {v0, p1, p2, p3}, Lcom/fasterxml/aalto/out/XmlWriter;->writeRaw([CII)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 1260
    nop

    .line 1261
    return-void

    .line 1258
    :catch_0
    move-exception v0

    .line 1259
    .local v0, "ioe":Ljava/io/IOException;
    new-instance v1, Lcom/fasterxml/aalto/impl/IoStreamException;

    invoke-direct {v1, v0}, Lcom/fasterxml/aalto/impl/IoStreamException;-><init>(Ljava/io/IOException;)V

    throw v1
.end method

.method public writeSpace(Ljava/lang/String;)V
    .locals 2
    .param p1, "text"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1003
    :try_start_0
    iget-object v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_xmlWriter:Lcom/fasterxml/aalto/out/XmlWriter;

    invoke-virtual {v0, p1}, Lcom/fasterxml/aalto/out/XmlWriter;->writeSpace(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 1006
    nop

    .line 1007
    return-void

    .line 1004
    :catch_0
    move-exception v0

    .line 1005
    .local v0, "ioe":Ljava/io/IOException;
    new-instance v1, Lcom/fasterxml/aalto/impl/IoStreamException;

    invoke-direct {v1, v0}, Lcom/fasterxml/aalto/impl/IoStreamException;-><init>(Ljava/io/IOException;)V

    throw v1
.end method

.method public writeSpace([CII)V
    .locals 2
    .param p1, "cbuf"    # [C
    .param p2, "offset"    # I
    .param p3, "len"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1013
    :try_start_0
    iget-object v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_xmlWriter:Lcom/fasterxml/aalto/out/XmlWriter;

    invoke-virtual {v0, p1, p2, p3}, Lcom/fasterxml/aalto/out/XmlWriter;->writeSpace([CII)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 1016
    nop

    .line 1017
    return-void

    .line 1014
    :catch_0
    move-exception v0

    .line 1015
    .local v0, "ioe":Ljava/io/IOException;
    new-instance v1, Lcom/fasterxml/aalto/impl/IoStreamException;

    invoke-direct {v1, v0}, Lcom/fasterxml/aalto/impl/IoStreamException;-><init>(Ljava/io/IOException;)V

    throw v1
.end method

.method public writeStartDocument()V
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 655
    iget-object v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_config:Lcom/fasterxml/aalto/out/WriterConfig;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/out/WriterConfig;->getActualEncoding()Ljava/lang/String;

    move-result-object v0

    .line 656
    .local v0, "enc":Ljava/lang/String;
    if-nez v0, :cond_0

    .line 657
    const-string v0, "UTF-8"

    .line 658
    iget-object v1, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_config:Lcom/fasterxml/aalto/out/WriterConfig;

    invoke-virtual {v1, v0}, Lcom/fasterxml/aalto/out/WriterConfig;->setActualEncodingIfNotSet(Ljava/lang/String;)V

    .line 660
    :cond_0
    const-string v1, "1.0"

    const/4 v2, 0x0

    invoke-virtual {p0, v1, v0, v2}, Lcom/fasterxml/aalto/out/StreamWriterBase;->_writeStartDocument(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 661
    return-void
.end method

.method public writeStartDocument(Ljava/lang/String;)V
    .locals 2
    .param p1, "version"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 667
    iget-object v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_config:Lcom/fasterxml/aalto/out/WriterConfig;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/out/WriterConfig;->getActualEncoding()Ljava/lang/String;

    move-result-object v0

    const/4 v1, 0x0

    invoke-virtual {p0, p1, v0, v1}, Lcom/fasterxml/aalto/out/StreamWriterBase;->_writeStartDocument(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 668
    return-void
.end method

.method public writeStartDocument(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1
    .param p1, "encoding"    # Ljava/lang/String;
    .param p2, "version"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 674
    const/4 v0, 0x0

    invoke-virtual {p0, p2, p1, v0}, Lcom/fasterxml/aalto/out/StreamWriterBase;->_writeStartDocument(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 675
    return-void
.end method

.method public writeStartDocument(Ljava/lang/String;Ljava/lang/String;Z)V
    .locals 1
    .param p1, "version"    # Ljava/lang/String;
    .param p2, "encoding"    # Ljava/lang/String;
    .param p3, "standAlone"    # Z
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1218
    if-eqz p3, :cond_0

    const-string/jumbo v0, "yes"

    goto :goto_0

    :cond_0
    const-string v0, "no"

    :goto_0
    invoke-virtual {p0, p1, p2, v0}, Lcom/fasterxml/aalto/out/StreamWriterBase;->_writeStartDocument(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 1219
    return-void
.end method

.method public writeStartElement(Ljava/lang/String;)V
    .locals 3
    .param p1, "localName"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 687
    const/4 v0, 0x0

    invoke-virtual {p0, v0, p1}, Lcom/fasterxml/aalto/out/StreamWriterBase;->_verifyStartElement(Ljava/lang/String;Ljava/lang/String;)V

    .line 688
    iget-object v0, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_symbols:Lcom/fasterxml/aalto/out/WNameTable;

    invoke-virtual {v0, p1}, Lcom/fasterxml/aalto/out/WNameTable;->findSymbol(Ljava/lang/String;)Lcom/fasterxml/aalto/out/WName;

    move-result-object v0

    .line 689
    .local v0, "name":Lcom/fasterxml/aalto/out/WName;
    iget-object v1, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_validator:Lorg/codehaus/stax2/validation/XMLValidator;

    if-eqz v1, :cond_0

    .line 690
    iget-object v1, p0, Lcom/fasterxml/aalto/out/StreamWriterBase;->_validator:Lorg/codehaus/stax2/validation/XMLValidator;

    const-string v2, ""

    invoke-virtual {v1, p1, v2, v2}, Lorg/codehaus/stax2/validation/XMLValidator;->validateElementStart(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 692
    :cond_0
    const/4 v1, 0x0

    invoke-virtual {p0, v0, v1}, Lcom/fasterxml/aalto/out/StreamWriterBase;->_writeStartTag(Lcom/fasterxml/aalto/out/WName;Z)V

    .line 693
    return-void
.end method

.method public abstract writeStartElement(Ljava/lang/String;Ljava/lang/String;)V
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method

.method public abstract writeStartElement(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method

.method public abstract writeTypedAttribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lorg/codehaus/stax2/ri/typed/AsciiValueEncoder;)V
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method
