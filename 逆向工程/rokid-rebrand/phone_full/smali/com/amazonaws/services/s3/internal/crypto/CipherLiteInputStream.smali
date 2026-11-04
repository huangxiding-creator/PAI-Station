.class public Lcom/amazonaws/services/s3/internal/crypto/CipherLiteInputStream;
.super Lcom/amazonaws/internal/SdkFilterInputStream;
.source "CipherLiteInputStream.java"


# annotations
.annotation runtime Ljava/lang/Deprecated;
.end annotation


# static fields
.field private static final BYTE_MASK:I = 0xff

.field private static final DEFAULT_IN_BUFFER_SIZE:I = 0x200

.field private static final MAX_RETRY:I = 0x3e8


# instance fields
.field private final bufin:[B

.field private bufout:[B

.field private cipherLite:Lcom/amazonaws/services/s3/internal/crypto/CipherLite;

.field private currPos:I

.field private eof:Z

.field private final lastMultiPart:Z

.field private maxPos:I

.field private final multipart:Z


# direct methods
.method protected constructor <init>(Ljava/io/InputStream;)V
    .locals 6
    .param p1, "is"    # Ljava/io/InputStream;

    .line 110
    sget-object v2, Lcom/amazonaws/services/s3/internal/crypto/CipherLite;->NULL:Lcom/amazonaws/services/s3/internal/crypto/CipherLite;

    const/4 v4, 0x0

    const/4 v5, 0x0

    const/16 v3, 0x200

    move-object v0, p0

    move-object v1, p1

    invoke-direct/range {v0 .. v5}, Lcom/amazonaws/services/s3/internal/crypto/CipherLiteInputStream;-><init>(Ljava/io/InputStream;Lcom/amazonaws/services/s3/internal/crypto/CipherLite;IZZ)V

    .line 111
    return-void
.end method

.method public constructor <init>(Ljava/io/InputStream;Lcom/amazonaws/services/s3/internal/crypto/CipherLite;)V
    .locals 6
    .param p1, "is"    # Ljava/io/InputStream;
    .param p2, "cipherLite"    # Lcom/amazonaws/services/s3/internal/crypto/CipherLite;

    .line 66
    const/4 v4, 0x0

    const/4 v5, 0x0

    const/16 v3, 0x200

    move-object v0, p0

    move-object v1, p1

    move-object v2, p2

    invoke-direct/range {v0 .. v5}, Lcom/amazonaws/services/s3/internal/crypto/CipherLiteInputStream;-><init>(Ljava/io/InputStream;Lcom/amazonaws/services/s3/internal/crypto/CipherLite;IZZ)V

    .line 67
    return-void
.end method

.method public constructor <init>(Ljava/io/InputStream;Lcom/amazonaws/services/s3/internal/crypto/CipherLite;I)V
    .locals 6
    .param p1, "is"    # Ljava/io/InputStream;
    .param p2, "cipherLite"    # Lcom/amazonaws/services/s3/internal/crypto/CipherLite;
    .param p3, "buffsize"    # I

    .line 76
    const/4 v4, 0x0

    const/4 v5, 0x0

    move-object v0, p0

    move-object v1, p1

    move-object v2, p2

    move v3, p3

    invoke-direct/range {v0 .. v5}, Lcom/amazonaws/services/s3/internal/crypto/CipherLiteInputStream;-><init>(Ljava/io/InputStream;Lcom/amazonaws/services/s3/internal/crypto/CipherLite;IZZ)V

    .line 77
    return-void
.end method

.method public constructor <init>(Ljava/io/InputStream;Lcom/amazonaws/services/s3/internal/crypto/CipherLite;IZZ)V
    .locals 3
    .param p1, "is"    # Ljava/io/InputStream;
    .param p2, "cipherLite"    # Lcom/amazonaws/services/s3/internal/crypto/CipherLite;
    .param p3, "buffsize"    # I
    .param p4, "multipart"    # Z
    .param p5, "lastMultiPart"    # Z

    .line 89
    invoke-direct {p0, p1}, Lcom/amazonaws/internal/SdkFilterInputStream;-><init>(Ljava/io/InputStream;)V

    .line 54
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/amazonaws/services/s3/internal/crypto/CipherLiteInputStream;->eof:Z

    .line 57
    iput v0, p0, Lcom/amazonaws/services/s3/internal/crypto/CipherLiteInputStream;->currPos:I

    .line 58
    iput v0, p0, Lcom/amazonaws/services/s3/internal/crypto/CipherLiteInputStream;->maxPos:I

    .line 90
    if-eqz p5, :cond_1

    if-eqz p4, :cond_0

    goto :goto_0

    .line 91
    :cond_0
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "lastMultiPart can only be true if multipart is true"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 94
    :cond_1
    :goto_0
    iput-boolean p4, p0, Lcom/amazonaws/services/s3/internal/crypto/CipherLiteInputStream;->multipart:Z

    .line 95
    iput-boolean p5, p0, Lcom/amazonaws/services/s3/internal/crypto/CipherLiteInputStream;->lastMultiPart:Z

    .line 96
    iput-object p2, p0, Lcom/amazonaws/services/s3/internal/crypto/CipherLiteInputStream;->cipherLite:Lcom/amazonaws/services/s3/internal/crypto/CipherLite;

    .line 97
    if-lez p3, :cond_2

    rem-int/lit16 v0, p3, 0x200

    if-nez v0, :cond_2

    .line 102
    new-array v0, p3, [B

    iput-object v0, p0, Lcom/amazonaws/services/s3/internal/crypto/CipherLiteInputStream;->bufin:[B

    .line 103
    return-void

    .line 98
    :cond_2
    new-instance v0, Ljava/lang/IllegalArgumentException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "buffsize ("

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ") must be a positive multiple of "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const/16 v2, 0x200

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method private nextChunk()I
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 259
    invoke-virtual {p0}, Lcom/amazonaws/services/s3/internal/crypto/CipherLiteInputStream;->abortIfNeeded()V

    .line 260
    iget-boolean v0, p0, Lcom/amazonaws/services/s3/internal/crypto/CipherLiteInputStream;->eof:Z

    const/4 v1, -0x1

    if-eqz v0, :cond_0

    .line 261
    return v1

    .line 263
    :cond_0
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/amazonaws/services/s3/internal/crypto/CipherLiteInputStream;->bufout:[B

    .line 264
    iget-object v0, p0, Lcom/amazonaws/services/s3/internal/crypto/CipherLiteInputStream;->in:Ljava/io/InputStream;

    iget-object v2, p0, Lcom/amazonaws/services/s3/internal/crypto/CipherLiteInputStream;->bufin:[B

    invoke-virtual {v0, v2}, Ljava/io/InputStream;->read([B)I

    move-result v0

    .line 265
    .local v0, "len":I
    const/4 v2, 0x0

    if-ne v0, v1, :cond_5

    .line 266
    const/4 v3, 0x1

    iput-boolean v3, p0, Lcom/amazonaws/services/s3/internal/crypto/CipherLiteInputStream;->eof:Z

    .line 268
    iget-boolean v3, p0, Lcom/amazonaws/services/s3/internal/crypto/CipherLiteInputStream;->multipart:Z

    if-eqz v3, :cond_1

    iget-boolean v3, p0, Lcom/amazonaws/services/s3/internal/crypto/CipherLiteInputStream;->lastMultiPart:Z

    if-eqz v3, :cond_4

    .line 270
    :cond_1
    :try_start_0
    iget-object v3, p0, Lcom/amazonaws/services/s3/internal/crypto/CipherLiteInputStream;->cipherLite:Lcom/amazonaws/services/s3/internal/crypto/CipherLite;

    invoke-virtual {v3}, Lcom/amazonaws/services/s3/internal/crypto/CipherLite;->doFinal()[B

    move-result-object v3

    iput-object v3, p0, Lcom/amazonaws/services/s3/internal/crypto/CipherLiteInputStream;->bufout:[B

    .line 271
    iget-object v3, p0, Lcom/amazonaws/services/s3/internal/crypto/CipherLiteInputStream;->bufout:[B

    if-nez v3, :cond_2

    .line 274
    return v1

    .line 276
    :cond_2
    iput v2, p0, Lcom/amazonaws/services/s3/internal/crypto/CipherLiteInputStream;->currPos:I

    .line 277
    iget-object v2, p0, Lcom/amazonaws/services/s3/internal/crypto/CipherLiteInputStream;->bufout:[B

    array-length v2, v2

    iput v2, p0, Lcom/amazonaws/services/s3/internal/crypto/CipherLiteInputStream;->maxPos:I

    .line 278
    iget v1, p0, Lcom/amazonaws/services/s3/internal/crypto/CipherLiteInputStream;->maxPos:I
    :try_end_0
    .catch Ljavax/crypto/IllegalBlockSizeException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljavax/crypto/BadPaddingException; {:try_start_0 .. :try_end_0} :catch_0

    return v1

    .line 281
    :catch_0
    move-exception v2

    .line 282
    .local v2, "e":Ljavax/crypto/BadPaddingException;
    iget-object v3, p0, Lcom/amazonaws/services/s3/internal/crypto/CipherLiteInputStream;->cipherLite:Lcom/amazonaws/services/s3/internal/crypto/CipherLite;

    invoke-virtual {v3}, Lcom/amazonaws/services/s3/internal/crypto/CipherLite;->getCipherAlgorithm()Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoScheme;->isAesGcm(Ljava/lang/String;)Z

    move-result v3

    if-nez v3, :cond_3

    goto :goto_0

    .line 283
    :cond_3
    new-instance v1, Ljava/lang/SecurityException;

    invoke-direct {v1, v2}, Ljava/lang/SecurityException;-><init>(Ljava/lang/Throwable;)V

    throw v1

    .line 279
    .end local v2    # "e":Ljavax/crypto/BadPaddingException;
    :catch_1
    move-exception v2

    .line 285
    nop

    .line 287
    :cond_4
    :goto_0
    return v1

    .line 289
    :cond_5
    iget-object v1, p0, Lcom/amazonaws/services/s3/internal/crypto/CipherLiteInputStream;->cipherLite:Lcom/amazonaws/services/s3/internal/crypto/CipherLite;

    iget-object v3, p0, Lcom/amazonaws/services/s3/internal/crypto/CipherLiteInputStream;->bufin:[B

    invoke-virtual {v1, v3, v2, v0}, Lcom/amazonaws/services/s3/internal/crypto/CipherLite;->update([BII)[B

    move-result-object v1

    iput-object v1, p0, Lcom/amazonaws/services/s3/internal/crypto/CipherLiteInputStream;->bufout:[B

    .line 290
    iput v2, p0, Lcom/amazonaws/services/s3/internal/crypto/CipherLiteInputStream;->currPos:I

    .line 291
    iget-object v1, p0, Lcom/amazonaws/services/s3/internal/crypto/CipherLiteInputStream;->bufout:[B

    if-nez v1, :cond_6

    goto :goto_1

    :cond_6
    iget-object v1, p0, Lcom/amazonaws/services/s3/internal/crypto/CipherLiteInputStream;->bufout:[B

    array-length v2, v1

    :goto_1
    iput v2, p0, Lcom/amazonaws/services/s3/internal/crypto/CipherLiteInputStream;->maxPos:I

    .line 292
    iget v1, p0, Lcom/amazonaws/services/s3/internal/crypto/CipherLiteInputStream;->maxPos:I

    return v1
.end method


# virtual methods
.method public available()I
    .locals 2

    .line 193
    invoke-virtual {p0}, Lcom/amazonaws/services/s3/internal/crypto/CipherLiteInputStream;->abortIfNeeded()V

    .line 194
    iget v0, p0, Lcom/amazonaws/services/s3/internal/crypto/CipherLiteInputStream;->maxPos:I

    iget v1, p0, Lcom/amazonaws/services/s3/internal/crypto/CipherLiteInputStream;->currPos:I

    sub-int/2addr v0, v1

    return v0
.end method

.method public close()V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 200
    iget-object v0, p0, Lcom/amazonaws/services/s3/internal/crypto/CipherLiteInputStream;->in:Ljava/io/InputStream;

    invoke-virtual {v0}, Ljava/io/InputStream;->close()V

    .line 204
    iget-boolean v0, p0, Lcom/amazonaws/services/s3/internal/crypto/CipherLiteInputStream;->multipart:Z

    if-nez v0, :cond_0

    .line 205
    iget-object v0, p0, Lcom/amazonaws/services/s3/internal/crypto/CipherLiteInputStream;->cipherLite:Lcom/amazonaws/services/s3/internal/crypto/CipherLite;

    invoke-virtual {v0}, Lcom/amazonaws/services/s3/internal/crypto/CipherLite;->getCipherAlgorithm()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoScheme;->isAesGcm(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 208
    :try_start_0
    iget-object v0, p0, Lcom/amazonaws/services/s3/internal/crypto/CipherLiteInputStream;->cipherLite:Lcom/amazonaws/services/s3/internal/crypto/CipherLite;

    invoke-virtual {v0}, Lcom/amazonaws/services/s3/internal/crypto/CipherLite;->doFinal()[B
    :try_end_0
    .catch Ljavax/crypto/BadPaddingException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljavax/crypto/IllegalBlockSizeException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 210
    :catch_0
    move-exception v0

    goto :goto_1

    .line 209
    :catch_1
    move-exception v0

    .line 211
    :goto_0
    nop

    .line 214
    :cond_0
    :goto_1
    const/4 v0, 0x0

    iput v0, p0, Lcom/amazonaws/services/s3/internal/crypto/CipherLiteInputStream;->currPos:I

    .line 215
    iput v0, p0, Lcom/amazonaws/services/s3/internal/crypto/CipherLiteInputStream;->maxPos:I

    .line 216
    invoke-virtual {p0}, Lcom/amazonaws/services/s3/internal/crypto/CipherLiteInputStream;->abortIfNeeded()V

    .line 217
    return-void
.end method

.method public mark(I)V
    .locals 1
    .param p1, "readlimit"    # I

    .line 227
    invoke-virtual {p0}, Lcom/amazonaws/services/s3/internal/crypto/CipherLiteInputStream;->abortIfNeeded()V

    .line 228
    iget-object v0, p0, Lcom/amazonaws/services/s3/internal/crypto/CipherLiteInputStream;->in:Ljava/io/InputStream;

    invoke-virtual {v0, p1}, Ljava/io/InputStream;->mark(I)V

    .line 229
    iget-object v0, p0, Lcom/amazonaws/services/s3/internal/crypto/CipherLiteInputStream;->cipherLite:Lcom/amazonaws/services/s3/internal/crypto/CipherLite;

    invoke-virtual {v0}, Lcom/amazonaws/services/s3/internal/crypto/CipherLite;->mark()J

    .line 230
    return-void
.end method

.method public markSupported()Z
    .locals 1

    .line 221
    invoke-virtual {p0}, Lcom/amazonaws/services/s3/internal/crypto/CipherLiteInputStream;->abortIfNeeded()V

    .line 222
    iget-object v0, p0, Lcom/amazonaws/services/s3/internal/crypto/CipherLiteInputStream;->in:Ljava/io/InputStream;

    invoke-virtual {v0}, Ljava/io/InputStream;->markSupported()Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/amazonaws/services/s3/internal/crypto/CipherLiteInputStream;->cipherLite:Lcom/amazonaws/services/s3/internal/crypto/CipherLite;

    invoke-virtual {v0}, Lcom/amazonaws/services/s3/internal/crypto/CipherLite;->markSupported()Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method public read()I
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 115
    iget v0, p0, Lcom/amazonaws/services/s3/internal/crypto/CipherLiteInputStream;->currPos:I

    iget v1, p0, Lcom/amazonaws/services/s3/internal/crypto/CipherLiteInputStream;->maxPos:I

    if-lt v0, v1, :cond_3

    .line 116
    iget-boolean v0, p0, Lcom/amazonaws/services/s3/internal/crypto/CipherLiteInputStream;->eof:Z

    const/4 v1, -0x1

    if-eqz v0, :cond_0

    .line 117
    return v1

    .line 119
    :cond_0
    const/4 v0, 0x0

    .line 122
    .local v0, "count":I
    :cond_1
    const/16 v2, 0x3e8

    if-gt v0, v2, :cond_2

    .line 126
    invoke-direct {p0}, Lcom/amazonaws/services/s3/internal/crypto/CipherLiteInputStream;->nextChunk()I

    move-result v2

    .line 127
    .local v2, "len":I
    add-int/lit8 v0, v0, 0x1

    .line 128
    if-eqz v2, :cond_1

    .line 130
    if-ne v2, v1, :cond_3

    .line 131
    return v1

    .line 123
    .end local v2    # "len":I
    :cond_2
    new-instance v1, Ljava/io/IOException;

    const-string v2, "exceeded maximum number of attempts to read next chunk of data"

    invoke-direct {v1, v2}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v1

    .line 134
    .end local v0    # "count":I
    :cond_3
    iget-object v0, p0, Lcom/amazonaws/services/s3/internal/crypto/CipherLiteInputStream;->bufout:[B

    iget v1, p0, Lcom/amazonaws/services/s3/internal/crypto/CipherLiteInputStream;->currPos:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Lcom/amazonaws/services/s3/internal/crypto/CipherLiteInputStream;->currPos:I

    aget-byte v0, v0, v1

    and-int/lit16 v0, v0, 0xff

    return v0
.end method

.method public read([B)I
    .locals 2
    .param p1, "b"    # [B
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 139
    const/4 v0, 0x0

    array-length v1, p1

    invoke-virtual {p0, p1, v0, v1}, Lcom/amazonaws/services/s3/internal/crypto/CipherLiteInputStream;->read([BII)I

    move-result v0

    return v0
.end method

.method public read([BII)I
    .locals 3
    .param p1, "buf"    # [B
    .param p2, "off"    # I
    .param p3, "targetLen"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 144
    iget v0, p0, Lcom/amazonaws/services/s3/internal/crypto/CipherLiteInputStream;->currPos:I

    iget v1, p0, Lcom/amazonaws/services/s3/internal/crypto/CipherLiteInputStream;->maxPos:I

    if-lt v0, v1, :cond_3

    .line 146
    iget-boolean v0, p0, Lcom/amazonaws/services/s3/internal/crypto/CipherLiteInputStream;->eof:Z

    const/4 v1, -0x1

    if-eqz v0, :cond_0

    .line 147
    return v1

    .line 149
    :cond_0
    const/4 v0, 0x0

    .line 152
    .local v0, "count":I
    :cond_1
    const/16 v2, 0x3e8

    if-gt v0, v2, :cond_2

    .line 156
    invoke-direct {p0}, Lcom/amazonaws/services/s3/internal/crypto/CipherLiteInputStream;->nextChunk()I

    move-result v2

    .line 157
    .local v2, "len":I
    add-int/lit8 v0, v0, 0x1

    .line 158
    if-eqz v2, :cond_1

    .line 160
    if-ne v2, v1, :cond_3

    .line 161
    return v1

    .line 153
    .end local v2    # "len":I
    :cond_2
    new-instance v1, Ljava/io/IOException;

    const-string v2, "exceeded maximum number of attempts to read next chunk of data"

    invoke-direct {v1, v2}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v1

    .line 164
    .end local v0    # "count":I
    :cond_3
    if-gtz p3, :cond_4

    .line 165
    const/4 v0, 0x0

    return v0

    .line 167
    :cond_4
    iget v0, p0, Lcom/amazonaws/services/s3/internal/crypto/CipherLiteInputStream;->maxPos:I

    iget v1, p0, Lcom/amazonaws/services/s3/internal/crypto/CipherLiteInputStream;->currPos:I

    sub-int/2addr v0, v1

    .line 168
    .local v0, "len":I
    if-ge p3, v0, :cond_5

    .line 169
    move v0, p3

    .line 172
    :cond_5
    iget-object v1, p0, Lcom/amazonaws/services/s3/internal/crypto/CipherLiteInputStream;->bufout:[B

    iget v2, p0, Lcom/amazonaws/services/s3/internal/crypto/CipherLiteInputStream;->currPos:I

    invoke-static {v1, v2, p1, p2, v0}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 173
    iget v1, p0, Lcom/amazonaws/services/s3/internal/crypto/CipherLiteInputStream;->currPos:I

    add-int/2addr v1, v0

    iput v1, p0, Lcom/amazonaws/services/s3/internal/crypto/CipherLiteInputStream;->currPos:I

    .line 174
    return v0
.end method

.method renewCipherLite()V
    .locals 1

    .line 296
    iget-object v0, p0, Lcom/amazonaws/services/s3/internal/crypto/CipherLiteInputStream;->cipherLite:Lcom/amazonaws/services/s3/internal/crypto/CipherLite;

    invoke-virtual {v0}, Lcom/amazonaws/services/s3/internal/crypto/CipherLite;->recreate()Lcom/amazonaws/services/s3/internal/crypto/CipherLite;

    move-result-object v0

    iput-object v0, p0, Lcom/amazonaws/services/s3/internal/crypto/CipherLiteInputStream;->cipherLite:Lcom/amazonaws/services/s3/internal/crypto/CipherLite;

    .line 297
    return-void
.end method

.method public reset()V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 234
    invoke-virtual {p0}, Lcom/amazonaws/services/s3/internal/crypto/CipherLiteInputStream;->abortIfNeeded()V

    .line 235
    iget-object v0, p0, Lcom/amazonaws/services/s3/internal/crypto/CipherLiteInputStream;->in:Ljava/io/InputStream;

    invoke-virtual {v0}, Ljava/io/InputStream;->reset()V

    .line 236
    iget-object v0, p0, Lcom/amazonaws/services/s3/internal/crypto/CipherLiteInputStream;->cipherLite:Lcom/amazonaws/services/s3/internal/crypto/CipherLite;

    invoke-virtual {v0}, Lcom/amazonaws/services/s3/internal/crypto/CipherLite;->reset()V

    .line 237
    invoke-virtual {p0}, Lcom/amazonaws/services/s3/internal/crypto/CipherLiteInputStream;->resetInternal()V

    .line 238
    return-void
.end method

.method final resetInternal()V
    .locals 1

    .line 241
    invoke-virtual {p0}, Lcom/amazonaws/services/s3/internal/crypto/CipherLiteInputStream;->markSupported()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 242
    const/4 v0, 0x0

    iput v0, p0, Lcom/amazonaws/services/s3/internal/crypto/CipherLiteInputStream;->currPos:I

    .line 243
    iput v0, p0, Lcom/amazonaws/services/s3/internal/crypto/CipherLiteInputStream;->maxPos:I

    .line 244
    iput-boolean v0, p0, Lcom/amazonaws/services/s3/internal/crypto/CipherLiteInputStream;->eof:Z

    .line 246
    :cond_0
    return-void
.end method

.method public skip(J)J
    .locals 4
    .param p1, "n"    # J
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 179
    invoke-virtual {p0}, Lcom/amazonaws/services/s3/internal/crypto/CipherLiteInputStream;->abortIfNeeded()V

    .line 180
    iget v0, p0, Lcom/amazonaws/services/s3/internal/crypto/CipherLiteInputStream;->maxPos:I

    iget v1, p0, Lcom/amazonaws/services/s3/internal/crypto/CipherLiteInputStream;->currPos:I

    sub-int/2addr v0, v1

    .line 181
    .local v0, "available":I
    int-to-long v1, v0

    cmp-long v1, p1, v1

    if-lez v1, :cond_0

    .line 182
    int-to-long p1, v0

    .line 184
    :cond_0
    const-wide/16 v1, 0x0

    cmp-long v3, p1, v1

    if-gez v3, :cond_1

    .line 185
    return-wide v1

    .line 187
    :cond_1
    iget v1, p0, Lcom/amazonaws/services/s3/internal/crypto/CipherLiteInputStream;->currPos:I

    int-to-long v1, v1

    add-long/2addr v1, p1

    long-to-int v1, v1

    iput v1, p0, Lcom/amazonaws/services/s3/internal/crypto/CipherLiteInputStream;->currPos:I

    .line 188
    return-wide p1
.end method
