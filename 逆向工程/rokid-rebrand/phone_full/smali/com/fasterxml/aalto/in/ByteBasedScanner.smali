.class public abstract Lcom/fasterxml/aalto/in/ByteBasedScanner;
.super Lcom/fasterxml/aalto/in/XmlScanner;
.source "ByteBasedScanner.java"


# static fields
.field protected static final BYTE_A:B = 0x41t

.field protected static final BYTE_AMP:B = 0x26t

.field protected static final BYTE_APOS:B = 0x27t

.field protected static final BYTE_C:B = 0x43t

.field protected static final BYTE_CR:B = 0xdt

.field protected static final BYTE_D:B = 0x44t

.field protected static final BYTE_EQ:B = 0x3dt

.field protected static final BYTE_EXCL:B = 0x21t

.field protected static final BYTE_GT:B = 0x3et

.field protected static final BYTE_HASH:B = 0x23t

.field protected static final BYTE_HYPHEN:B = 0x2dt

.field protected static final BYTE_LBRACKET:B = 0x5bt

.field protected static final BYTE_LF:B = 0xat

.field protected static final BYTE_LT:B = 0x3ct

.field protected static final BYTE_NULL:B = 0x0t

.field protected static final BYTE_P:B = 0x50t

.field protected static final BYTE_QMARK:B = 0x3ft

.field protected static final BYTE_QUOT:B = 0x22t

.field protected static final BYTE_RBRACKET:B = 0x5dt

.field protected static final BYTE_S:B = 0x53t

.field protected static final BYTE_SEMICOLON:B = 0x3bt

.field protected static final BYTE_SLASH:B = 0x2ft

.field protected static final BYTE_SPACE:B = 0x20t

.field protected static final BYTE_T:B = 0x54t

.field protected static final BYTE_TAB:B = 0x9t

.field protected static final BYTE_a:B = 0x61t

.field protected static final BYTE_g:B = 0x67t

.field protected static final BYTE_l:B = 0x6ct

.field protected static final BYTE_m:B = 0x6dt

.field protected static final BYTE_o:B = 0x6ft

.field protected static final BYTE_p:B = 0x70t

.field protected static final BYTE_q:B = 0x71t

.field protected static final BYTE_s:B = 0x73t

.field protected static final BYTE_t:B = 0x74t

.field protected static final BYTE_u:B = 0x75t

.field protected static final BYTE_x:B = 0x78t


# instance fields
.field protected _inputEnd:I

.field protected _inputPtr:I

.field protected _tmpChar:I


# direct methods
.method protected constructor <init>(Lcom/fasterxml/aalto/in/ReaderConfig;)V
    .locals 3
    .param p1, "cfg"    # Lcom/fasterxml/aalto/in/ReaderConfig;

    .line 125
    invoke-direct {p0, p1}, Lcom/fasterxml/aalto/in/XmlScanner;-><init>(Lcom/fasterxml/aalto/in/ReaderConfig;)V

    .line 115
    const/4 v0, 0x0

    iput v0, p0, Lcom/fasterxml/aalto/in/ByteBasedScanner;->_tmpChar:I

    .line 126
    const-wide/16 v1, 0x0

    iput-wide v1, p0, Lcom/fasterxml/aalto/in/ByteBasedScanner;->_pastBytesOrChars:J

    .line 127
    iput v0, p0, Lcom/fasterxml/aalto/in/ByteBasedScanner;->_rowStartOffset:I

    .line 128
    return-void
.end method


# virtual methods
.method protected abstract _closeSource()V
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation
.end method

.method protected final addUTFPName(Lcom/fasterxml/aalto/in/ByteBasedPNameTable;Lcom/fasterxml/aalto/util/XmlCharTypes;I[III)Lcom/fasterxml/aalto/in/PName;
    .locals 24
    .param p1, "symbols"    # Lcom/fasterxml/aalto/in/ByteBasedPNameTable;
    .param p2, "charTypes"    # Lcom/fasterxml/aalto/util/XmlCharTypes;
    .param p3, "hash"    # I
    .param p4, "quads"    # [I
    .param p5, "qlen"    # I
    .param p6, "lastQuadBytes"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 226
    move-object/from16 v0, p0

    move/from16 v7, p6

    shl-int/lit8 v1, p5, 0x2

    const/4 v2, 0x4

    sub-int/2addr v1, v2

    add-int v8, v1, v7

    .line 234
    .local v8, "byteLen":I
    if-ge v7, v2, :cond_0

    .line 235
    add-int/lit8 v1, p5, -0x1

    aget v1, p4, v1

    .line 237
    .local v1, "lastQuad":I
    add-int/lit8 v3, p5, -0x1

    rsub-int/lit8 v4, v7, 0x4

    shl-int/lit8 v4, v4, 0x3

    shl-int v4, v1, v4

    aput v4, p4, v3

    move v9, v1

    goto :goto_0

    .line 239
    .end local v1    # "lastQuad":I
    :cond_0
    const/4 v1, 0x0

    move v9, v1

    .line 243
    .local v9, "lastQuad":I
    :goto_0
    const/4 v1, 0x0

    aget v3, p4, v1

    ushr-int/lit8 v3, v3, 0x18

    .line 245
    .local v3, "ch":I
    const/4 v4, 0x1

    .line 246
    .local v4, "ix":I
    iget-object v5, v0, Lcom/fasterxml/aalto/in/ByteBasedScanner;->_nameBuffer:[C

    .line 247
    .local v5, "cbuf":[C
    const/4 v6, 0x0

    .line 248
    .local v6, "cix":I
    move-object/from16 v10, p2

    iget-object v11, v10, Lcom/fasterxml/aalto/util/XmlCharTypes;->NAME_CHARS:[I

    .line 250
    .local v11, "TYPES":[I
    aget v12, v11, v3

    const/16 v2, 0xf0

    const/16 v13, 0xe0

    const/16 v15, 0xc0

    const/4 v14, 0x1

    packed-switch v12, :pswitch_data_0

    .line 264
    and-int/lit16 v12, v3, 0xe0

    if-ne v12, v15, :cond_1

    .line 265
    and-int/lit8 v3, v3, 0x1f

    .line 266
    const/4 v12, 0x1

    .local v12, "needed":I
    goto :goto_1

    .line 258
    .end local v12    # "needed":I
    :pswitch_0
    const/4 v12, 0x1

    .line 259
    .local v12, "ok":Z
    goto/16 :goto_4

    .line 255
    .end local v12    # "ok":Z
    :pswitch_1
    const/4 v12, 0x0

    .line 256
    .restart local v12    # "ok":Z
    goto/16 :goto_4

    .line 267
    .end local v12    # "ok":Z
    :cond_1
    and-int/lit16 v12, v3, 0xf0

    if-ne v12, v13, :cond_2

    .line 268
    and-int/lit8 v3, v3, 0xf

    .line 269
    const/4 v12, 0x2

    .local v12, "needed":I
    goto :goto_1

    .line 270
    .end local v12    # "needed":I
    :cond_2
    and-int/lit16 v12, v3, 0xf8

    if-ne v12, v2, :cond_3

    .line 271
    and-int/lit8 v3, v3, 0x7

    .line 272
    const/4 v12, 0x3

    .restart local v12    # "needed":I
    goto :goto_1

    .line 274
    .end local v12    # "needed":I
    :cond_3
    invoke-virtual {v0, v3}, Lcom/fasterxml/aalto/in/ByteBasedScanner;->reportInvalidInitial(I)V

    .line 275
    move v3, v14

    move v12, v14

    .line 277
    .restart local v12    # "needed":I
    :goto_1
    add-int v2, v4, v12

    if-le v2, v8, :cond_4

    .line 278
    const/4 v2, 0x0

    invoke-virtual {v0, v5, v2}, Lcom/fasterxml/aalto/in/ByteBasedScanner;->reportEofInName([CI)V

    goto :goto_2

    .line 277
    :cond_4
    const/4 v2, 0x0

    .line 280
    :goto_2
    add-int/2addr v4, v12

    .line 282
    aget v13, p4, v2

    .line 284
    .local v13, "q":I
    shr-int/lit8 v2, v13, 0x10

    and-int/lit16 v2, v2, 0xff

    .line 285
    .local v2, "ch2":I
    and-int/lit16 v15, v2, 0xc0

    const/16 v1, 0x80

    if-eq v15, v1, :cond_5

    .line 286
    invoke-virtual {v0, v2}, Lcom/fasterxml/aalto/in/ByteBasedScanner;->reportInvalidOther(I)V

    .line 288
    :cond_5
    shl-int/lit8 v1, v3, 0x6

    and-int/lit8 v15, v2, 0x3f

    or-int/2addr v1, v15

    .line 294
    .end local v3    # "ch":I
    .local v1, "ch":I
    if-le v12, v14, :cond_9

    .line 295
    shr-int/lit8 v3, v13, 0x8

    and-int/lit16 v2, v3, 0xff

    .line 296
    and-int/lit16 v3, v2, 0xc0

    const/16 v15, 0x80

    if-eq v3, v15, :cond_6

    .line 297
    invoke-virtual {v0, v2}, Lcom/fasterxml/aalto/in/ByteBasedScanner;->reportInvalidOther(I)V

    .line 299
    :cond_6
    shl-int/lit8 v3, v1, 0x6

    and-int/lit8 v15, v2, 0x3f

    or-int v1, v3, v15

    .line 300
    const/4 v3, 0x2

    if-le v12, v3, :cond_8

    .line 301
    and-int/lit16 v2, v13, 0xff

    .line 302
    and-int/lit16 v3, v2, 0xc0

    const/16 v15, 0x80

    if-eq v3, v15, :cond_7

    .line 303
    and-int/lit16 v3, v2, 0xff

    invoke-virtual {v0, v3}, Lcom/fasterxml/aalto/in/ByteBasedScanner;->reportInvalidOther(I)V

    .line 305
    :cond_7
    shl-int/lit8 v3, v1, 0x6

    and-int/lit8 v15, v2, 0x3f

    or-int v1, v3, v15

    move v3, v1

    goto :goto_3

    .line 300
    :cond_8
    move v3, v1

    goto :goto_3

    .line 294
    :cond_9
    move v3, v1

    .line 308
    .end local v1    # "ch":I
    .restart local v3    # "ch":I
    :goto_3
    invoke-static {v3}, Lcom/fasterxml/aalto/util/XmlChars;->is10NameStartChar(I)Z

    move-result v1

    .line 309
    .local v1, "ok":Z
    const/4 v15, 0x2

    if-le v12, v15, :cond_a

    .line 313
    const/high16 v15, 0x10000

    sub-int/2addr v3, v15

    .line 314
    add-int/lit8 v15, v6, 0x1

    .end local v6    # "cix":I
    .local v15, "cix":I
    shr-int/lit8 v22, v3, 0xa

    const v18, 0xd800

    add-int v14, v22, v18

    int-to-char v14, v14

    aput-char v14, v5, v6

    .line 315
    and-int/lit16 v6, v3, 0x3ff

    const v14, 0xdc00

    or-int v3, v6, v14

    move v12, v1

    move v6, v15

    goto :goto_4

    .line 309
    .end local v15    # "cix":I
    .restart local v6    # "cix":I
    :cond_a
    move v12, v1

    .line 320
    .end local v1    # "ok":Z
    .end local v2    # "ch2":I
    .end local v13    # "q":I
    .local v12, "ok":Z
    :goto_4
    if-nez v12, :cond_b

    .line 321
    const/4 v1, 0x0

    invoke-virtual {v0, v3, v1}, Lcom/fasterxml/aalto/in/ByteBasedScanner;->reportInvalidNameChar(II)V

    .line 324
    :cond_b
    add-int/lit8 v1, v6, 0x1

    .end local v6    # "cix":I
    .local v1, "cix":I
    int-to-char v2, v3

    aput-char v2, v5, v6

    .line 329
    const/4 v2, -0x1

    move v13, v2

    move v14, v3

    move v15, v4

    move-object v6, v5

    move/from16 v22, v12

    move v12, v1

    .line 331
    .end local v1    # "cix":I
    .end local v3    # "ch":I
    .end local v4    # "ix":I
    .end local v5    # "cbuf":[C
    .local v6, "cbuf":[C
    .local v12, "cix":I
    .local v13, "last_colon":I
    .local v14, "ch":I
    .local v15, "ix":I
    .local v22, "ok":Z
    :goto_5
    if-ge v15, v8, :cond_1a

    .line 332
    shr-int/lit8 v1, v15, 0x2

    aget v1, p4, v1

    .line 333
    .end local v14    # "ch":I
    .local v1, "ch":I
    and-int/lit8 v2, v15, 0x3

    .line 334
    .local v2, "byteIx":I
    rsub-int/lit8 v3, v2, 0x3

    shl-int/lit8 v3, v3, 0x3

    shr-int v3, v1, v3

    and-int/lit16 v1, v3, 0xff

    .line 335
    add-int/lit8 v15, v15, 0x1

    .line 338
    aget v3, v11, v1

    packed-switch v3, :pswitch_data_1

    .line 357
    and-int/lit16 v3, v1, 0xe0

    const/16 v4, 0xc0

    if-ne v3, v4, :cond_d

    .line 358
    and-int/lit8 v1, v1, 0x1f

    .line 359
    const/4 v3, 0x1

    const/16 v5, 0xe0

    const/16 v14, 0xf0

    .local v3, "needed":I
    goto :goto_6

    .line 352
    .end local v3    # "needed":I
    :pswitch_2
    const/4 v3, 0x1

    .line 353
    .end local v22    # "ok":Z
    .local v3, "ok":Z
    move v14, v1

    move/from16 v22, v3

    const v17, 0xdc00

    const v18, 0xd800

    const/high16 v19, 0x10000

    goto/16 :goto_8

    .line 344
    .end local v3    # "ok":Z
    .restart local v22    # "ok":Z
    :pswitch_3
    if-ltz v13, :cond_c

    .line 345
    invoke-virtual/range {p0 .. p0}, Lcom/fasterxml/aalto/in/ByteBasedScanner;->reportMultipleColonsInName()V

    .line 347
    :cond_c
    move v3, v12

    .line 348
    .end local v13    # "last_colon":I
    .local v3, "last_colon":I
    const/4 v4, 0x1

    .line 349
    .end local v22    # "ok":Z
    .local v4, "ok":Z
    move v14, v1

    move v13, v3

    move/from16 v22, v4

    const v17, 0xdc00

    const v18, 0xd800

    const/high16 v19, 0x10000

    goto/16 :goto_8

    .line 341
    .end local v3    # "last_colon":I
    .end local v4    # "ok":Z
    .restart local v13    # "last_colon":I
    .restart local v22    # "ok":Z
    :pswitch_4
    const/4 v3, 0x0

    .line 342
    .end local v22    # "ok":Z
    .local v3, "ok":Z
    move v14, v1

    move/from16 v22, v3

    const v17, 0xdc00

    const v18, 0xd800

    const/high16 v19, 0x10000

    goto/16 :goto_8

    .line 360
    .end local v3    # "ok":Z
    .restart local v22    # "ok":Z
    :cond_d
    and-int/lit16 v3, v1, 0xf0

    const/16 v5, 0xe0

    if-ne v3, v5, :cond_e

    .line 361
    and-int/lit8 v1, v1, 0xf

    .line 362
    const/4 v3, 0x2

    const/16 v14, 0xf0

    .local v3, "needed":I
    goto :goto_6

    .line 363
    .end local v3    # "needed":I
    :cond_e
    and-int/lit16 v3, v1, 0xf8

    const/16 v14, 0xf0

    if-ne v3, v14, :cond_f

    .line 364
    and-int/lit8 v1, v1, 0x7

    .line 365
    const/4 v3, 0x3

    .restart local v3    # "needed":I
    goto :goto_6

    .line 367
    .end local v3    # "needed":I
    :cond_f
    invoke-virtual {v0, v1}, Lcom/fasterxml/aalto/in/ByteBasedScanner;->reportInvalidInitial(I)V

    .line 368
    const/4 v3, 0x1

    move v1, v3

    move/from16 v21, v3

    .line 370
    .restart local v3    # "needed":I
    :goto_6
    add-int v4, v15, v3

    if-le v4, v8, :cond_10

    .line 371
    invoke-virtual {v0, v6, v12}, Lcom/fasterxml/aalto/in/ByteBasedScanner;->reportEofInName([CI)V

    .line 375
    :cond_10
    shr-int/lit8 v4, v15, 0x2

    aget v4, p4, v4

    .line 376
    .local v4, "ch2":I
    and-int/lit8 v2, v15, 0x3

    .line 377
    rsub-int/lit8 v21, v2, 0x3

    shl-int/lit8 v21, v21, 0x3

    shr-int v4, v4, v21

    .line 378
    add-int/lit8 v15, v15, 0x1

    .line 380
    and-int/lit16 v5, v4, 0xc0

    const/16 v14, 0x80

    if-eq v5, v14, :cond_11

    .line 381
    invoke-virtual {v0, v4}, Lcom/fasterxml/aalto/in/ByteBasedScanner;->reportInvalidOther(I)V

    .line 383
    :cond_11
    shl-int/lit8 v5, v1, 0x6

    and-int/lit8 v14, v4, 0x3f

    or-int v1, v5, v14

    .line 386
    const/4 v5, 0x1

    if-le v3, v5, :cond_15

    .line 387
    shr-int/lit8 v14, v15, 0x2

    aget v4, p4, v14

    .line 388
    and-int/lit8 v2, v15, 0x3

    .line 389
    rsub-int/lit8 v14, v2, 0x3

    shl-int/lit8 v14, v14, 0x3

    shr-int/2addr v4, v14

    .line 390
    add-int/lit8 v15, v15, 0x1

    .line 392
    and-int/lit16 v14, v4, 0xc0

    const/16 v5, 0x80

    if-eq v14, v5, :cond_12

    .line 393
    invoke-virtual {v0, v4}, Lcom/fasterxml/aalto/in/ByteBasedScanner;->reportInvalidOther(I)V

    .line 395
    :cond_12
    shl-int/lit8 v5, v1, 0x6

    and-int/lit8 v14, v4, 0x3f

    or-int v1, v5, v14

    .line 396
    const/4 v5, 0x2

    if-le v3, v5, :cond_14

    .line 397
    shr-int/lit8 v5, v15, 0x2

    aget v4, p4, v5

    .line 398
    and-int/lit8 v2, v15, 0x3

    .line 399
    rsub-int/lit8 v5, v2, 0x3

    shl-int/lit8 v5, v5, 0x3

    shr-int/2addr v4, v5

    .line 400
    add-int/lit8 v15, v15, 0x1

    .line 401
    and-int/lit16 v5, v4, 0xc0

    const/16 v14, 0x80

    if-eq v5, v14, :cond_13

    .line 402
    and-int/lit16 v5, v4, 0xff

    invoke-virtual {v0, v5}, Lcom/fasterxml/aalto/in/ByteBasedScanner;->reportInvalidOther(I)V

    .line 404
    :cond_13
    shl-int/lit8 v5, v1, 0x6

    and-int/lit8 v20, v4, 0x3f

    or-int v1, v5, v20

    goto :goto_7

    .line 396
    :cond_14
    const/16 v14, 0x80

    goto :goto_7

    .line 386
    :cond_15
    const/16 v14, 0x80

    .line 407
    :goto_7
    invoke-static {v1}, Lcom/fasterxml/aalto/util/XmlChars;->is10NameChar(I)Z

    move-result v5

    .line 408
    .end local v22    # "ok":Z
    .local v5, "ok":Z
    const/4 v14, 0x2

    if-le v3, v14, :cond_17

    .line 409
    const/high16 v19, 0x10000

    sub-int v1, v1, v19

    .line 410
    array-length v14, v6

    if-lt v12, v14, :cond_16

    .line 411
    array-length v14, v6

    invoke-static {v6, v14}, Lcom/fasterxml/aalto/util/DataUtil;->growArrayBy([CI)[C

    move-result-object v14

    move-object v6, v14

    iput-object v14, v0, Lcom/fasterxml/aalto/in/ByteBasedScanner;->_nameBuffer:[C

    .line 413
    :cond_16
    add-int/lit8 v14, v12, 0x1

    .end local v12    # "cix":I
    .local v14, "cix":I
    shr-int/lit8 v22, v1, 0xa

    move/from16 v23, v2

    const v18, 0xd800

    .end local v2    # "byteIx":I
    .local v23, "byteIx":I
    add-int v2, v22, v18

    int-to-char v2, v2

    aput-char v2, v6, v12

    .line 414
    and-int/lit16 v2, v1, 0x3ff

    const v17, 0xdc00

    or-int v1, v2, v17

    move/from16 v22, v5

    move v12, v14

    move/from16 v2, v23

    move v14, v1

    goto :goto_8

    .line 408
    .end local v14    # "cix":I
    .end local v23    # "byteIx":I
    .restart local v2    # "byteIx":I
    .restart local v12    # "cix":I
    :cond_17
    move/from16 v23, v2

    const v17, 0xdc00

    const v18, 0xd800

    const/high16 v19, 0x10000

    .end local v2    # "byteIx":I
    .restart local v23    # "byteIx":I
    move v14, v1

    move/from16 v22, v5

    .line 418
    .end local v1    # "ch":I
    .end local v3    # "needed":I
    .end local v4    # "ch2":I
    .end local v5    # "ok":Z
    .end local v23    # "byteIx":I
    .restart local v2    # "byteIx":I
    .local v14, "ch":I
    .restart local v22    # "ok":Z
    :goto_8
    if-nez v22, :cond_18

    .line 419
    invoke-virtual {v0, v14, v12}, Lcom/fasterxml/aalto/in/ByteBasedScanner;->reportInvalidNameChar(II)V

    .line 421
    :cond_18
    array-length v1, v6

    if-lt v12, v1, :cond_19

    .line 422
    array-length v1, v6

    invoke-static {v6, v1}, Lcom/fasterxml/aalto/util/DataUtil;->growArrayBy([CI)[C

    move-result-object v1

    move-object v3, v1

    .end local v6    # "cbuf":[C
    .local v3, "cbuf":[C
    iput-object v1, v0, Lcom/fasterxml/aalto/in/ByteBasedScanner;->_nameBuffer:[C

    move-object v6, v3

    .line 424
    .end local v3    # "cbuf":[C
    .restart local v6    # "cbuf":[C
    :cond_19
    add-int/lit8 v1, v12, 0x1

    .end local v12    # "cix":I
    .local v1, "cix":I
    int-to-char v3, v14

    aput-char v3, v6, v12

    .line 425
    .end local v2    # "byteIx":I
    move v12, v1

    goto/16 :goto_5

    .line 431
    .end local v1    # "cix":I
    .restart local v12    # "cix":I
    :cond_1a
    new-instance v3, Ljava/lang/String;

    const/4 v1, 0x0

    invoke-direct {v3, v6, v1, v12}, Ljava/lang/String;-><init>([CII)V

    .line 433
    .local v3, "baseName":Ljava/lang/String;
    const/4 v1, 0x4

    if-ge v7, v1, :cond_1b

    .line 434
    add-int/lit8 v1, p5, -0x1

    aput v9, p4, v1

    .line 436
    :cond_1b
    move-object/from16 v1, p1

    move/from16 v2, p3

    move v4, v13

    move-object/from16 v5, p4

    move-object/from16 v16, v6

    .end local v6    # "cbuf":[C
    .local v16, "cbuf":[C
    move/from16 v6, p5

    invoke-virtual/range {v1 .. v6}, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->addSymbol(ILjava/lang/String;I[II)Lcom/fasterxml/aalto/in/ByteBasedPName;

    move-result-object v1

    return-object v1

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_1
        :pswitch_1
        :pswitch_1
        :pswitch_0
        :pswitch_1
    .end packed-switch

    :pswitch_data_1
    .packed-switch 0x0
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_2
        :pswitch_4
    .end packed-switch
.end method

.method protected abstract decodeCharForError(B)I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method

.method public getCurrentColumnNr()I
    .locals 2

    .line 150
    iget v0, p0, Lcom/fasterxml/aalto/in/ByteBasedScanner;->_inputPtr:I

    iget v1, p0, Lcom/fasterxml/aalto/in/ByteBasedScanner;->_rowStartOffset:I

    sub-int/2addr v0, v1

    return v0
.end method

.method public getCurrentLocation()Lorg/codehaus/stax2/XMLStreamLocation2;
    .locals 7

    .line 144
    iget-object v0, p0, Lcom/fasterxml/aalto/in/ByteBasedScanner;->_config:Lcom/fasterxml/aalto/in/ReaderConfig;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/ReaderConfig;->getPublicId()Ljava/lang/String;

    move-result-object v1

    iget-object v0, p0, Lcom/fasterxml/aalto/in/ByteBasedScanner;->_config:Lcom/fasterxml/aalto/in/ReaderConfig;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/ReaderConfig;->getSystemId()Ljava/lang/String;

    move-result-object v2

    iget-wide v3, p0, Lcom/fasterxml/aalto/in/ByteBasedScanner;->_pastBytesOrChars:J

    iget v0, p0, Lcom/fasterxml/aalto/in/ByteBasedScanner;->_inputPtr:I

    int-to-long v5, v0

    add-long/2addr v3, v5

    iget v5, p0, Lcom/fasterxml/aalto/in/ByteBasedScanner;->_currRow:I

    iget v0, p0, Lcom/fasterxml/aalto/in/ByteBasedScanner;->_inputPtr:I

    iget v6, p0, Lcom/fasterxml/aalto/in/ByteBasedScanner;->_rowStartOffset:I

    sub-int v6, v0, v6

    invoke-static/range {v1 .. v6}, Lcom/fasterxml/aalto/impl/LocationImpl;->fromZeroBased(Ljava/lang/String;Ljava/lang/String;JII)Lcom/fasterxml/aalto/impl/LocationImpl;

    move-result-object v0

    return-object v0
.end method

.method public getEndingByteOffset()J
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 167
    iget-boolean v0, p0, Lcom/fasterxml/aalto/in/ByteBasedScanner;->_tokenIncomplete:Z

    if-eqz v0, :cond_0

    .line 168
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ByteBasedScanner;->finishToken()V

    .line 170
    :cond_0
    iget-wide v0, p0, Lcom/fasterxml/aalto/in/ByteBasedScanner;->_pastBytesOrChars:J

    iget v2, p0, Lcom/fasterxml/aalto/in/ByteBasedScanner;->_inputPtr:I

    int-to-long v2, v2

    add-long/2addr v0, v2

    return-wide v0
.end method

.method public getEndingCharOffset()J
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 176
    const-wide/16 v0, -0x1

    return-wide v0
.end method

.method public getStartingByteOffset()J
    .locals 2

    .line 155
    iget-wide v0, p0, Lcom/fasterxml/aalto/in/ByteBasedScanner;->_startRawOffset:J

    return-wide v0
.end method

.method public getStartingCharOffset()J
    .locals 2

    .line 161
    const-wide/16 v0, -0x1

    return-wide v0
.end method

.method protected final markLF()V
    .locals 1

    .line 185
    iget v0, p0, Lcom/fasterxml/aalto/in/ByteBasedScanner;->_inputPtr:I

    iput v0, p0, Lcom/fasterxml/aalto/in/ByteBasedScanner;->_rowStartOffset:I

    .line 186
    iget v0, p0, Lcom/fasterxml/aalto/in/ByteBasedScanner;->_currRow:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/fasterxml/aalto/in/ByteBasedScanner;->_currRow:I

    .line 187
    return-void
.end method

.method protected final markLF(I)V
    .locals 1
    .param p1, "offset"    # I

    .line 180
    iput p1, p0, Lcom/fasterxml/aalto/in/ByteBasedScanner;->_rowStartOffset:I

    .line 181
    iget v0, p0, Lcom/fasterxml/aalto/in/ByteBasedScanner;->_currRow:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/fasterxml/aalto/in/ByteBasedScanner;->_currRow:I

    .line 182
    return-void
.end method

.method protected reportInvalidInitial(I)V
    .locals 2
    .param p1, "mask"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 446
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Invalid UTF-8 start byte 0x"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-static {p1}, Ljava/lang/Integer;->toHexString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/in/ByteBasedScanner;->reportInputProblem(Ljava/lang/String;)V

    .line 447
    return-void
.end method

.method protected reportInvalidOther(I)V
    .locals 2
    .param p1, "mask"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 450
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Invalid UTF-8 middle byte 0x"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-static {p1}, Ljava/lang/Integer;->toHexString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/in/ByteBasedScanner;->reportInputProblem(Ljava/lang/String;)V

    .line 451
    return-void
.end method

.method protected final setStartLocation()V
    .locals 4

    .line 190
    iget-wide v0, p0, Lcom/fasterxml/aalto/in/ByteBasedScanner;->_pastBytesOrChars:J

    iget v2, p0, Lcom/fasterxml/aalto/in/ByteBasedScanner;->_inputPtr:I

    int-to-long v2, v2

    add-long/2addr v0, v2

    iput-wide v0, p0, Lcom/fasterxml/aalto/in/ByteBasedScanner;->_startRawOffset:J

    .line 191
    iget v0, p0, Lcom/fasterxml/aalto/in/ByteBasedScanner;->_currRow:I

    int-to-long v0, v0

    iput-wide v0, p0, Lcom/fasterxml/aalto/in/ByteBasedScanner;->_startRow:J

    .line 192
    iget v0, p0, Lcom/fasterxml/aalto/in/ByteBasedScanner;->_inputPtr:I

    iget v1, p0, Lcom/fasterxml/aalto/in/ByteBasedScanner;->_rowStartOffset:I

    sub-int/2addr v0, v1

    int-to-long v0, v0

    iput-wide v0, p0, Lcom/fasterxml/aalto/in/ByteBasedScanner;->_startColumn:J

    .line 193
    return-void
.end method
