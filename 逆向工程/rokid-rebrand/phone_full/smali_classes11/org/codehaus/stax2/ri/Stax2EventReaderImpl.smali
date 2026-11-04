.class public abstract Lorg/codehaus/stax2/ri/Stax2EventReaderImpl;
.super Ljava/lang/Object;
.source "Stax2EventReaderImpl.java"

# interfaces
.implements Lorg/codehaus/stax2/XMLEventReader2;
.implements Ljavax/xml/stream/XMLStreamConstants;


# static fields
.field protected static final ERR_GETELEMTEXT_NON_TEXT_EVENT:I = 0x2

.field protected static final ERR_GETELEMTEXT_NOT_START_ELEM:I = 0x1

.field protected static final ERR_NEXTTAG_NON_WS_TEXT:I = 0x3

.field protected static final ERR_NEXTTAG_WRONG_TYPE:I = 0x4

.field protected static final STATE_CONTENT:I = 0x3

.field protected static final STATE_END_OF_INPUT:I = 0x2

.field protected static final STATE_INITIAL:I = 0x1


# instance fields
.field protected final mAllocator:Ljavax/xml/stream/util/XMLEventAllocator;

.field protected mPeekedEvent:Ljavax/xml/stream/events/XMLEvent;

.field protected mPrePeekEvent:I

.field protected final mReader:Lorg/codehaus/stax2/XMLStreamReader2;

.field protected mState:I


# direct methods
.method protected constructor <init>(Ljavax/xml/stream/util/XMLEventAllocator;Lorg/codehaus/stax2/XMLStreamReader2;)V
    .locals 1
    .param p1, "a"    # Ljavax/xml/stream/util/XMLEventAllocator;
    .param p2, "r"    # Lorg/codehaus/stax2/XMLStreamReader2;

    .line 134
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 107
    const/4 v0, 0x0

    iput-object v0, p0, Lorg/codehaus/stax2/ri/Stax2EventReaderImpl;->mPeekedEvent:Ljavax/xml/stream/events/XMLEvent;

    .line 117
    const/4 v0, 0x1

    iput v0, p0, Lorg/codehaus/stax2/ri/Stax2EventReaderImpl;->mState:I

    .line 125
    const/4 v0, 0x7

    iput v0, p0, Lorg/codehaus/stax2/ri/Stax2EventReaderImpl;->mPrePeekEvent:I

    .line 135
    iput-object p1, p0, Lorg/codehaus/stax2/ri/Stax2EventReaderImpl;->mAllocator:Ljavax/xml/stream/util/XMLEventAllocator;

    .line 136
    iput-object p2, p0, Lorg/codehaus/stax2/ri/Stax2EventReaderImpl;->mReader:Lorg/codehaus/stax2/XMLStreamReader2;

    .line 137
    return-void
.end method


# virtual methods
.method protected _checkUnwrap(Ljava/lang/RuntimeException;)Ljavax/xml/stream/XMLStreamException;
    .locals 2
    .param p1, "rex"    # Ljava/lang/RuntimeException;

    .line 443
    invoke-virtual {p1}, Ljava/lang/RuntimeException;->getCause()Ljava/lang/Throwable;

    move-result-object v0

    .line 444
    .local v0, "t":Ljava/lang/Throwable;
    :goto_0
    if-eqz v0, :cond_1

    .line 445
    instance-of v1, v0, Ljavax/xml/stream/XMLStreamException;

    if-eqz v1, :cond_0

    .line 446
    move-object v1, v0

    check-cast v1, Ljavax/xml/stream/XMLStreamException;

    return-object v1

    .line 448
    :cond_0
    invoke-virtual {v0}, Ljava/lang/Throwable;->getCause()Ljava/lang/Throwable;

    move-result-object v0

    goto :goto_0

    .line 451
    :cond_1
    throw p1
.end method

.method public close()V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 173
    iget-object v0, p0, Lorg/codehaus/stax2/ri/Stax2EventReaderImpl;->mReader:Lorg/codehaus/stax2/XMLStreamReader2;

    invoke-interface {v0}, Lorg/codehaus/stax2/XMLStreamReader2;->close()V

    .line 174
    return-void
.end method

.method protected createNextEvent(ZI)Ljavax/xml/stream/events/XMLEvent;
    .locals 2
    .param p1, "checkEOD"    # Z
    .param p2, "type"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 425
    :try_start_0
    iget-object v0, p0, Lorg/codehaus/stax2/ri/Stax2EventReaderImpl;->mAllocator:Ljavax/xml/stream/util/XMLEventAllocator;

    iget-object v1, p0, Lorg/codehaus/stax2/ri/Stax2EventReaderImpl;->mReader:Lorg/codehaus/stax2/XMLStreamReader2;

    invoke-interface {v0, v1}, Ljavax/xml/stream/util/XMLEventAllocator;->allocate(Ljavax/xml/stream/XMLStreamReader;)Ljavax/xml/stream/events/XMLEvent;

    move-result-object v0

    .line 426
    .local v0, "evt":Ljavax/xml/stream/events/XMLEvent;
    if-eqz p1, :cond_0

    const/16 v1, 0x8

    if-ne p2, v1, :cond_0

    .line 427
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/Stax2EventReaderImpl;->updateStateEndDocument()V
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    .line 429
    :cond_0
    return-object v0

    .line 430
    .end local v0    # "evt":Ljavax/xml/stream/events/XMLEvent;
    :catch_0
    move-exception v0

    .line 431
    .local v0, "rex":Ljava/lang/RuntimeException;
    invoke-virtual {p0, v0}, Lorg/codehaus/stax2/ri/Stax2EventReaderImpl;->_checkUnwrap(Ljava/lang/RuntimeException;)Ljavax/xml/stream/XMLStreamException;

    move-result-object v1

    throw v1
.end method

.method protected createStartDocumentEvent()Ljavax/xml/stream/events/XMLEvent;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 460
    iget-object v0, p0, Lorg/codehaus/stax2/ri/Stax2EventReaderImpl;->mAllocator:Ljavax/xml/stream/util/XMLEventAllocator;

    iget-object v1, p0, Lorg/codehaus/stax2/ri/Stax2EventReaderImpl;->mReader:Lorg/codehaus/stax2/XMLStreamReader2;

    invoke-interface {v0, v1}, Ljavax/xml/stream/util/XMLEventAllocator;->allocate(Ljavax/xml/stream/XMLStreamReader;)Ljavax/xml/stream/events/XMLEvent;

    move-result-object v0

    .line 461
    .local v0, "start":Ljavax/xml/stream/events/XMLEvent;
    return-object v0
.end method

.method protected final findErrorDesc(II)Ljava/lang/String;
    .locals 3
    .param p1, "errorType"    # I
    .param p2, "currEvent"    # I

    .line 532
    invoke-virtual {p0, p1, p2}, Lorg/codehaus/stax2/ri/Stax2EventReaderImpl;->getErrorDesc(II)Ljava/lang/String;

    move-result-object v0

    .line 533
    .local v0, "msg":Ljava/lang/String;
    if-eqz v0, :cond_0

    .line 534
    return-object v0

    .line 536
    :cond_0
    packed-switch p1, :pswitch_data_0

    .line 548
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Internal error (unrecognized error type: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ")"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    return-object v1

    .line 544
    :pswitch_0
    const-string v1, "Should only encounter START_ELEMENT/END_ELEMENT, SPACE, or all-white-space CHARACTERS"

    return-object v1

    .line 542
    :pswitch_1
    const-string v1, "Only all-whitespace CHARACTERS/CDATA (or SPACE) allowed for nextTag()"

    return-object v1

    .line 540
    :pswitch_2
    const-string v1, "Expected a text token"

    return-object v1

    .line 538
    :pswitch_3
    const-string v1, "Current state not START_ELEMENT when calling getElementText()"

    return-object v1

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method public getElementText()Ljava/lang/String;
    .locals 8
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 182
    iget-object v0, p0, Lorg/codehaus/stax2/ri/Stax2EventReaderImpl;->mPeekedEvent:Ljavax/xml/stream/events/XMLEvent;

    if-nez v0, :cond_0

    .line 183
    iget-object v0, p0, Lorg/codehaus/stax2/ri/Stax2EventReaderImpl;->mReader:Lorg/codehaus/stax2/XMLStreamReader2;

    invoke-interface {v0}, Lorg/codehaus/stax2/XMLStreamReader2;->getElementText()Ljava/lang/String;

    move-result-object v0

    return-object v0

    .line 186
    :cond_0
    iget-object v0, p0, Lorg/codehaus/stax2/ri/Stax2EventReaderImpl;->mPeekedEvent:Ljavax/xml/stream/events/XMLEvent;

    .line 187
    .local v0, "evt":Ljavax/xml/stream/events/XMLEvent;
    const/4 v1, 0x0

    iput-object v1, p0, Lorg/codehaus/stax2/ri/Stax2EventReaderImpl;->mPeekedEvent:Ljavax/xml/stream/events/XMLEvent;

    .line 192
    iget v1, p0, Lorg/codehaus/stax2/ri/Stax2EventReaderImpl;->mPrePeekEvent:I

    const/4 v2, 0x1

    if-eq v1, v2, :cond_1

    .line 193
    iget v1, p0, Lorg/codehaus/stax2/ri/Stax2EventReaderImpl;->mPrePeekEvent:I

    invoke-virtual {p0, v2, v1}, Lorg/codehaus/stax2/ri/Stax2EventReaderImpl;->findErrorDesc(II)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v1}, Lorg/codehaus/stax2/ri/Stax2EventReaderImpl;->reportProblem(Ljava/lang/String;)V

    .line 197
    :cond_1
    const/4 v1, 0x0

    .line 198
    .local v1, "str":Ljava/lang/String;
    const/4 v2, 0x0

    .line 204
    .local v2, "sb":Ljava/lang/StringBuffer;
    :goto_0
    invoke-interface {v0}, Ljavax/xml/stream/events/XMLEvent;->isEndElement()Z

    move-result v3

    if-eqz v3, :cond_4

    .line 205
    nop

    .line 227
    if-eqz v2, :cond_2

    .line 228
    invoke-virtual {v2}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v3

    return-object v3

    .line 230
    :cond_2
    if-nez v1, :cond_3

    const-string v3, ""

    goto :goto_1

    :cond_3
    move-object v3, v1

    :goto_1
    return-object v3

    .line 207
    :cond_4
    invoke-interface {v0}, Ljavax/xml/stream/events/XMLEvent;->getEventType()I

    move-result v3

    .line 208
    .local v3, "type":I
    const/4 v4, 0x5

    if-eq v3, v4, :cond_9

    const/4 v4, 0x3

    if-ne v3, v4, :cond_5

    .line 210
    goto :goto_2

    .line 212
    :cond_5
    invoke-interface {v0}, Ljavax/xml/stream/events/XMLEvent;->isCharacters()Z

    move-result v4

    if-nez v4, :cond_6

    .line 213
    const/4 v4, 0x2

    invoke-virtual {p0, v4, v3}, Lorg/codehaus/stax2/ri/Stax2EventReaderImpl;->findErrorDesc(II)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {p0, v4}, Lorg/codehaus/stax2/ri/Stax2EventReaderImpl;->reportProblem(Ljava/lang/String;)V

    .line 215
    :cond_6
    invoke-interface {v0}, Ljavax/xml/stream/events/XMLEvent;->asCharacters()Ljavax/xml/stream/events/Characters;

    move-result-object v4

    invoke-interface {v4}, Ljavax/xml/stream/events/Characters;->getData()Ljava/lang/String;

    move-result-object v4

    .line 216
    .local v4, "curr":Ljava/lang/String;
    if-nez v1, :cond_7

    .line 217
    move-object v1, v4

    goto :goto_2

    .line 219
    :cond_7
    if-nez v2, :cond_8

    .line 220
    new-instance v5, Ljava/lang/StringBuffer;

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v6

    invoke-virtual {v4}, Ljava/lang/String;->length()I

    move-result v7

    add-int/2addr v6, v7

    invoke-direct {v5, v6}, Ljava/lang/StringBuffer;-><init>(I)V

    move-object v2, v5

    .line 221
    invoke-virtual {v2, v1}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 223
    :cond_8
    invoke-virtual {v2, v4}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 203
    .end local v3    # "type":I
    .end local v4    # "curr":Ljava/lang/String;
    :cond_9
    :goto_2
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/Stax2EventReaderImpl;->nextEvent()Ljavax/xml/stream/events/XMLEvent;

    move-result-object v0

    goto :goto_0
.end method

.method protected abstract getErrorDesc(II)Ljava/lang/String;
.end method

.method public getProperty(Ljava/lang/String;)Ljava/lang/Object;
    .locals 1
    .param p1, "name"    # Ljava/lang/String;

    .line 235
    iget-object v0, p0, Lorg/codehaus/stax2/ri/Stax2EventReaderImpl;->mReader:Lorg/codehaus/stax2/XMLStreamReader2;

    invoke-interface {v0, p1}, Lorg/codehaus/stax2/XMLStreamReader2;->getProperty(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method protected getStreamReader()Ljavax/xml/stream/XMLStreamReader;
    .locals 1

    .line 515
    iget-object v0, p0, Lorg/codehaus/stax2/ri/Stax2EventReaderImpl;->mReader:Lorg/codehaus/stax2/XMLStreamReader2;

    return-object v0
.end method

.method public hasNext()Z
    .locals 2

    .line 240
    iget v0, p0, Lorg/codehaus/stax2/ri/Stax2EventReaderImpl;->mState:I

    const/4 v1, 0x2

    if-eq v0, v1, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method public hasNextEvent()Z
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 412
    iget v0, p0, Lorg/codehaus/stax2/ri/Stax2EventReaderImpl;->mState:I

    const/4 v1, 0x2

    if-eq v0, v1, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method public abstract isPropertySupported(Ljava/lang/String;)Z
.end method

.method public next()Ljava/lang/Object;
    .locals 2

    .line 266
    :try_start_0
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/Stax2EventReaderImpl;->nextEvent()Ljavax/xml/stream/events/XMLEvent;

    move-result-object v0
    :try_end_0
    .catch Ljavax/xml/stream/XMLStreamException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    .line 267
    :catch_0
    move-exception v0

    .line 268
    .local v0, "sex":Ljavax/xml/stream/XMLStreamException;
    invoke-virtual {p0, v0}, Lorg/codehaus/stax2/ri/Stax2EventReaderImpl;->throwUnchecked(Ljavax/xml/stream/XMLStreamException;)V

    .line 269
    const/4 v1, 0x0

    return-object v1
.end method

.method public nextEvent()Ljavax/xml/stream/events/XMLEvent;
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 246
    iget v0, p0, Lorg/codehaus/stax2/ri/Stax2EventReaderImpl;->mState:I

    const/4 v1, 0x2

    const/4 v2, 0x1

    if-ne v0, v1, :cond_0

    .line 247
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/Stax2EventReaderImpl;->throwEndOfInput()V

    goto :goto_0

    .line 248
    :cond_0
    iget v0, p0, Lorg/codehaus/stax2/ri/Stax2EventReaderImpl;->mState:I

    if-ne v0, v2, :cond_1

    .line 249
    const/4 v0, 0x3

    iput v0, p0, Lorg/codehaus/stax2/ri/Stax2EventReaderImpl;->mState:I

    .line 250
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/Stax2EventReaderImpl;->createStartDocumentEvent()Ljavax/xml/stream/events/XMLEvent;

    move-result-object v0

    return-object v0

    .line 252
    :cond_1
    :goto_0
    iget-object v0, p0, Lorg/codehaus/stax2/ri/Stax2EventReaderImpl;->mPeekedEvent:Ljavax/xml/stream/events/XMLEvent;

    if-eqz v0, :cond_3

    .line 253
    iget-object v0, p0, Lorg/codehaus/stax2/ri/Stax2EventReaderImpl;->mPeekedEvent:Ljavax/xml/stream/events/XMLEvent;

    .line 254
    .local v0, "evt":Ljavax/xml/stream/events/XMLEvent;
    const/4 v1, 0x0

    iput-object v1, p0, Lorg/codehaus/stax2/ri/Stax2EventReaderImpl;->mPeekedEvent:Ljavax/xml/stream/events/XMLEvent;

    .line 255
    invoke-interface {v0}, Ljavax/xml/stream/events/XMLEvent;->isEndDocument()Z

    move-result v1

    if-eqz v1, :cond_2

    .line 256
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/Stax2EventReaderImpl;->updateStateEndDocument()V

    .line 258
    :cond_2
    return-object v0

    .line 260
    .end local v0    # "evt":Ljavax/xml/stream/events/XMLEvent;
    :cond_3
    iget-object v0, p0, Lorg/codehaus/stax2/ri/Stax2EventReaderImpl;->mReader:Lorg/codehaus/stax2/XMLStreamReader2;

    invoke-interface {v0}, Lorg/codehaus/stax2/XMLStreamReader2;->next()I

    move-result v0

    invoke-virtual {p0, v2, v0}, Lorg/codehaus/stax2/ri/Stax2EventReaderImpl;->createNextEvent(ZI)Ljavax/xml/stream/events/XMLEvent;

    move-result-object v0

    return-object v0
.end method

.method public nextTag()Ljavax/xml/stream/events/XMLEvent;
    .locals 6
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 277
    iget-object v0, p0, Lorg/codehaus/stax2/ri/Stax2EventReaderImpl;->mPeekedEvent:Ljavax/xml/stream/events/XMLEvent;

    const/4 v1, 0x4

    const/4 v2, 0x3

    const/4 v3, 0x0

    if-eqz v0, :cond_1

    .line 278
    iget-object v0, p0, Lorg/codehaus/stax2/ri/Stax2EventReaderImpl;->mPeekedEvent:Ljavax/xml/stream/events/XMLEvent;

    .line 279
    .local v0, "evt":Ljavax/xml/stream/events/XMLEvent;
    iput-object v3, p0, Lorg/codehaus/stax2/ri/Stax2EventReaderImpl;->mPeekedEvent:Ljavax/xml/stream/events/XMLEvent;

    .line 280
    invoke-interface {v0}, Ljavax/xml/stream/events/XMLEvent;->getEventType()I

    move-result v4

    .line 281
    .local v4, "type":I
    packed-switch v4, :pswitch_data_0

    .line 310
    :pswitch_0
    invoke-virtual {p0, v1, v4}, Lorg/codehaus/stax2/ri/Stax2EventReaderImpl;->findErrorDesc(II)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {p0, v5}, Lorg/codehaus/stax2/ri/Stax2EventReaderImpl;->reportProblem(Ljava/lang/String;)V

    goto :goto_0

    .line 283
    :pswitch_1
    return-object v3

    .line 286
    :pswitch_2
    goto :goto_0

    .line 289
    :pswitch_3
    goto :goto_0

    .line 300
    :pswitch_4
    move-object v5, v0

    check-cast v5, Ljavax/xml/stream/events/Characters;

    invoke-interface {v5}, Ljavax/xml/stream/events/Characters;->isWhiteSpace()Z

    move-result v5

    if-eqz v5, :cond_0

    .line 301
    goto :goto_0

    .line 303
    :cond_0
    invoke-virtual {p0, v2, v4}, Lorg/codehaus/stax2/ri/Stax2EventReaderImpl;->findErrorDesc(II)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {p0, v5}, Lorg/codehaus/stax2/ri/Stax2EventReaderImpl;->reportProblem(Ljava/lang/String;)V

    .line 304
    goto :goto_0

    .line 297
    :pswitch_5
    goto :goto_0

    .line 307
    :pswitch_6
    return-object v0

    .line 312
    .end local v0    # "evt":Ljavax/xml/stream/events/XMLEvent;
    .end local v4    # "type":I
    :goto_0
    goto :goto_1

    .line 320
    :cond_1
    iget v0, p0, Lorg/codehaus/stax2/ri/Stax2EventReaderImpl;->mState:I

    const/4 v4, 0x1

    if-ne v0, v4, :cond_2

    .line 321
    iput v2, p0, Lorg/codehaus/stax2/ri/Stax2EventReaderImpl;->mState:I

    .line 326
    :cond_2
    :goto_1
    iget-object v0, p0, Lorg/codehaus/stax2/ri/Stax2EventReaderImpl;->mReader:Lorg/codehaus/stax2/XMLStreamReader2;

    invoke-interface {v0}, Lorg/codehaus/stax2/XMLStreamReader2;->next()I

    move-result v0

    .line 328
    .local v0, "next":I
    packed-switch v0, :pswitch_data_1

    .line 348
    :pswitch_7
    invoke-virtual {p0, v1, v0}, Lorg/codehaus/stax2/ri/Stax2EventReaderImpl;->findErrorDesc(II)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {p0, v4}, Lorg/codehaus/stax2/ri/Stax2EventReaderImpl;->reportProblem(Ljava/lang/String;)V

    goto :goto_2

    .line 330
    :pswitch_8
    return-object v3

    .line 337
    :pswitch_9
    iget-object v4, p0, Lorg/codehaus/stax2/ri/Stax2EventReaderImpl;->mReader:Lorg/codehaus/stax2/XMLStreamReader2;

    invoke-interface {v4}, Lorg/codehaus/stax2/XMLStreamReader2;->isWhiteSpace()Z

    move-result v4

    if-eqz v4, :cond_3

    .line 338
    goto :goto_1

    .line 340
    :cond_3
    invoke-virtual {p0, v2, v0}, Lorg/codehaus/stax2/ri/Stax2EventReaderImpl;->findErrorDesc(II)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {p0, v4}, Lorg/codehaus/stax2/ri/Stax2EventReaderImpl;->reportProblem(Ljava/lang/String;)V

    .line 341
    goto :goto_2

    .line 334
    :pswitch_a
    goto :goto_1

    .line 345
    :pswitch_b
    const/4 v1, 0x0

    invoke-virtual {p0, v1, v0}, Lorg/codehaus/stax2/ri/Stax2EventReaderImpl;->createNextEvent(ZI)Ljavax/xml/stream/events/XMLEvent;

    move-result-object v1

    return-object v1

    .line 350
    .end local v0    # "next":I
    :goto_2
    goto :goto_1

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_6
        :pswitch_6
        :pswitch_5
        :pswitch_4
        :pswitch_5
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_4
    .end packed-switch

    :pswitch_data_1
    .packed-switch 0x1
        :pswitch_b
        :pswitch_b
        :pswitch_a
        :pswitch_9
        :pswitch_a
        :pswitch_a
        :pswitch_7
        :pswitch_8
        :pswitch_7
        :pswitch_7
        :pswitch_7
        :pswitch_9
    .end packed-switch
.end method

.method public peek()Ljavax/xml/stream/events/XMLEvent;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 356
    iget-object v0, p0, Lorg/codehaus/stax2/ri/Stax2EventReaderImpl;->mPeekedEvent:Ljavax/xml/stream/events/XMLEvent;

    if-nez v0, :cond_2

    .line 357
    iget v0, p0, Lorg/codehaus/stax2/ri/Stax2EventReaderImpl;->mState:I

    const/4 v1, 0x2

    if-ne v0, v1, :cond_0

    .line 360
    const/4 v0, 0x0

    return-object v0

    .line 362
    :cond_0
    iget v0, p0, Lorg/codehaus/stax2/ri/Stax2EventReaderImpl;->mState:I

    const/4 v1, 0x1

    if-ne v0, v1, :cond_1

    .line 364
    const/4 v0, 0x7

    iput v0, p0, Lorg/codehaus/stax2/ri/Stax2EventReaderImpl;->mPrePeekEvent:I

    .line 365
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/Stax2EventReaderImpl;->createStartDocumentEvent()Ljavax/xml/stream/events/XMLEvent;

    move-result-object v0

    iput-object v0, p0, Lorg/codehaus/stax2/ri/Stax2EventReaderImpl;->mPeekedEvent:Ljavax/xml/stream/events/XMLEvent;

    .line 366
    const/4 v0, 0x3

    iput v0, p0, Lorg/codehaus/stax2/ri/Stax2EventReaderImpl;->mState:I

    goto :goto_0

    .line 368
    :cond_1
    iget-object v0, p0, Lorg/codehaus/stax2/ri/Stax2EventReaderImpl;->mReader:Lorg/codehaus/stax2/XMLStreamReader2;

    invoke-interface {v0}, Lorg/codehaus/stax2/XMLStreamReader2;->getEventType()I

    move-result v0

    iput v0, p0, Lorg/codehaus/stax2/ri/Stax2EventReaderImpl;->mPrePeekEvent:I

    .line 369
    iget-object v0, p0, Lorg/codehaus/stax2/ri/Stax2EventReaderImpl;->mReader:Lorg/codehaus/stax2/XMLStreamReader2;

    invoke-interface {v0}, Lorg/codehaus/stax2/XMLStreamReader2;->next()I

    move-result v0

    const/4 v1, 0x0

    invoke-virtual {p0, v1, v0}, Lorg/codehaus/stax2/ri/Stax2EventReaderImpl;->createNextEvent(ZI)Ljavax/xml/stream/events/XMLEvent;

    move-result-object v0

    iput-object v0, p0, Lorg/codehaus/stax2/ri/Stax2EventReaderImpl;->mPeekedEvent:Ljavax/xml/stream/events/XMLEvent;

    .line 372
    :cond_2
    :goto_0
    iget-object v0, p0, Lorg/codehaus/stax2/ri/Stax2EventReaderImpl;->mPeekedEvent:Ljavax/xml/stream/events/XMLEvent;

    return-object v0
.end method

.method public remove()V
    .locals 2

    .line 381
    new-instance v0, Ljava/lang/UnsupportedOperationException;

    const-string v1, "Can not remove events from XMLEventReader."

    invoke-direct {v0, v1}, Ljava/lang/UnsupportedOperationException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method protected reportProblem(Ljava/lang/String;)V
    .locals 1
    .param p1, "msg"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 495
    iget-object v0, p0, Lorg/codehaus/stax2/ri/Stax2EventReaderImpl;->mReader:Lorg/codehaus/stax2/XMLStreamReader2;

    invoke-interface {v0}, Lorg/codehaus/stax2/XMLStreamReader2;->getLocation()Ljavax/xml/stream/Location;

    move-result-object v0

    invoke-virtual {p0, p1, v0}, Lorg/codehaus/stax2/ri/Stax2EventReaderImpl;->reportProblem(Ljava/lang/String;Ljavax/xml/stream/Location;)V

    .line 496
    return-void
.end method

.method protected reportProblem(Ljava/lang/String;Ljavax/xml/stream/Location;)V
    .locals 1
    .param p1, "msg"    # Ljava/lang/String;
    .param p2, "loc"    # Ljavax/xml/stream/Location;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 501
    if-nez p2, :cond_0

    .line 502
    new-instance v0, Ljavax/xml/stream/XMLStreamException;

    invoke-direct {v0, p1}, Ljavax/xml/stream/XMLStreamException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 504
    :cond_0
    new-instance v0, Ljavax/xml/stream/XMLStreamException;

    invoke-direct {v0, p1, p2}, Ljavax/xml/stream/XMLStreamException;-><init>(Ljava/lang/String;Ljavax/xml/stream/Location;)V

    throw v0
.end method

.method public abstract setProperty(Ljava/lang/String;Ljava/lang/Object;)Z
.end method

.method protected throwEndOfInput()V
    .locals 1

    .line 473
    new-instance v0, Ljava/util/NoSuchElementException;

    invoke-direct {v0}, Ljava/util/NoSuchElementException;-><init>()V

    throw v0
.end method

.method protected throwUnchecked(Ljavax/xml/stream/XMLStreamException;)V
    .locals 4
    .param p1, "sex"    # Ljavax/xml/stream/XMLStreamException;

    .line 480
    invoke-virtual {p1}, Ljavax/xml/stream/XMLStreamException;->getNestedException()Ljava/lang/Throwable;

    move-result-object v0

    if-nez v0, :cond_0

    move-object v0, p1

    goto :goto_0

    :cond_0
    invoke-virtual {p1}, Ljavax/xml/stream/XMLStreamException;->getNestedException()Ljava/lang/Throwable;

    move-result-object v0

    .line 482
    .local v0, "t":Ljava/lang/Throwable;
    :goto_0
    instance-of v1, v0, Ljava/lang/RuntimeException;

    if-nez v1, :cond_2

    .line 485
    instance-of v1, v0, Ljava/lang/Error;

    if-eqz v1, :cond_1

    .line 486
    move-object v1, v0

    check-cast v1, Ljava/lang/Error;

    throw v1

    .line 489
    :cond_1
    new-instance v1, Ljava/lang/RuntimeException;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "[was "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "] "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v0}, Ljava/lang/Throwable;->getMessage()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2, v0}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;Ljava/lang/Throwable;)V

    throw v1

    .line 483
    :cond_2
    move-object v1, v0

    check-cast v1, Ljava/lang/RuntimeException;

    throw v1
.end method

.method protected updateStateEndDocument()V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 392
    const/4 v0, 0x2

    iput v0, p0, Lorg/codehaus/stax2/ri/Stax2EventReaderImpl;->mState:I

    .line 393
    return-void
.end method
