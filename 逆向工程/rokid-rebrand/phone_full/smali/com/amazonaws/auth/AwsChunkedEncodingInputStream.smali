.class public final Lcom/amazonaws/auth/AwsChunkedEncodingInputStream;
.super Lcom/amazonaws/internal/SdkInputStream;
.source "AwsChunkedEncodingInputStream.java"


# static fields
.field private static final BIT_MASK:I = 0xff

.field private static final CHUNK_SIGNATURE_HEADER:Ljava/lang/String; = ";chunk-signature="

.field private static final CHUNK_STRING_TO_SIGN_PREFIX:Ljava/lang/String; = "AWS4-HMAC-SHA256-PAYLOAD"

.field private static final CLRF:Ljava/lang/String; = "\r\n"

.field private static final DEFAULT_BUFFER_SIZE:I = 0x40000

.field private static final DEFAULT_CHUNK_SIZE:I = 0x20000

.field protected static final DEFAULT_ENCODING:Ljava/lang/String; = "UTF-8"

.field private static final FINAL_CHUNK:[B

.field private static final SIGNATURE_LENGTH:I = 0x40

.field private static final log:Lcom/amazonaws/logging/Log;


# instance fields
.field private final aws4Signer:Lcom/amazonaws/auth/AWS4Signer;

.field private currentChunkIterator:Lcom/amazonaws/auth/ChunkContentIterator;

.field private final dateTime:Ljava/lang/String;

.field private decodedStreamBuffer:Lcom/amazonaws/auth/DecodedStreamBuffer;

.field private final headerSignature:Ljava/lang/String;

.field private is:Ljava/io/InputStream;

.field private isAtStart:Z

.field private isTerminating:Z

.field private final kSigning:[B

.field private final keyPath:Ljava/lang/String;

.field private final maxBufferSize:I

.field private priorChunkSignature:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 45
    const/4 v0, 0x0

    new-array v0, v0, [B

    sput-object v0, Lcom/amazonaws/auth/AwsChunkedEncodingInputStream;->FINAL_CHUNK:[B

    .line 69
    const-class v0, Lcom/amazonaws/auth/AwsChunkedEncodingInputStream;

    invoke-static {v0}, Lcom/amazonaws/logging/LogFactory;->getLog(Ljava/lang/Class;)Lcom/amazonaws/logging/Log;

    move-result-object v0

    sput-object v0, Lcom/amazonaws/auth/AwsChunkedEncodingInputStream;->log:Lcom/amazonaws/logging/Log;

    return-void
.end method

.method public constructor <init>(Ljava/io/InputStream;I[BLjava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/amazonaws/auth/AWS4Signer;)V
    .locals 2
    .param p1, "in"    # Ljava/io/InputStream;
    .param p2, "maxBufferSize"    # I
    .param p3, "kSigning"    # [B
    .param p4, "datetime"    # Ljava/lang/String;
    .param p5, "keyPath"    # Ljava/lang/String;
    .param p6, "headerSignature"    # Ljava/lang/String;
    .param p7, "aws4Signer"    # Lcom/amazonaws/auth/AWS4Signer;

    .line 116
    invoke-direct {p0}, Lcom/amazonaws/internal/SdkInputStream;-><init>()V

    .line 47
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/amazonaws/auth/AwsChunkedEncodingInputStream;->is:Ljava/io/InputStream;

    .line 66
    const/4 v1, 0x1

    iput-boolean v1, p0, Lcom/amazonaws/auth/AwsChunkedEncodingInputStream;->isAtStart:Z

    .line 67
    const/4 v1, 0x0

    iput-boolean v1, p0, Lcom/amazonaws/auth/AwsChunkedEncodingInputStream;->isTerminating:Z

    .line 117
    instance-of v1, p1, Lcom/amazonaws/auth/AwsChunkedEncodingInputStream;

    if-eqz v1, :cond_0

    .line 120
    move-object v0, p1

    check-cast v0, Lcom/amazonaws/auth/AwsChunkedEncodingInputStream;

    .line 121
    .local v0, "originalChunkedStream":Lcom/amazonaws/auth/AwsChunkedEncodingInputStream;
    iget v1, v0, Lcom/amazonaws/auth/AwsChunkedEncodingInputStream;->maxBufferSize:I

    invoke-static {v1, p2}, Ljava/lang/Math;->max(II)I

    move-result p2

    .line 122
    iget-object v1, v0, Lcom/amazonaws/auth/AwsChunkedEncodingInputStream;->is:Ljava/io/InputStream;

    iput-object v1, p0, Lcom/amazonaws/auth/AwsChunkedEncodingInputStream;->is:Ljava/io/InputStream;

    .line 123
    iget-object v1, v0, Lcom/amazonaws/auth/AwsChunkedEncodingInputStream;->decodedStreamBuffer:Lcom/amazonaws/auth/DecodedStreamBuffer;

    iput-object v1, p0, Lcom/amazonaws/auth/AwsChunkedEncodingInputStream;->decodedStreamBuffer:Lcom/amazonaws/auth/DecodedStreamBuffer;

    .line 124
    .end local v0    # "originalChunkedStream":Lcom/amazonaws/auth/AwsChunkedEncodingInputStream;
    goto :goto_0

    .line 125
    :cond_0
    iput-object p1, p0, Lcom/amazonaws/auth/AwsChunkedEncodingInputStream;->is:Ljava/io/InputStream;

    .line 126
    iput-object v0, p0, Lcom/amazonaws/auth/AwsChunkedEncodingInputStream;->decodedStreamBuffer:Lcom/amazonaws/auth/DecodedStreamBuffer;

    .line 129
    :goto_0
    const/high16 v0, 0x20000

    if-lt p2, v0, :cond_1

    .line 133
    iput p2, p0, Lcom/amazonaws/auth/AwsChunkedEncodingInputStream;->maxBufferSize:I

    .line 134
    iput-object p3, p0, Lcom/amazonaws/auth/AwsChunkedEncodingInputStream;->kSigning:[B

    .line 135
    iput-object p4, p0, Lcom/amazonaws/auth/AwsChunkedEncodingInputStream;->dateTime:Ljava/lang/String;

    .line 136
    iput-object p5, p0, Lcom/amazonaws/auth/AwsChunkedEncodingInputStream;->keyPath:Ljava/lang/String;

    .line 137
    iput-object p6, p0, Lcom/amazonaws/auth/AwsChunkedEncodingInputStream;->headerSignature:Ljava/lang/String;

    .line 138
    iput-object p6, p0, Lcom/amazonaws/auth/AwsChunkedEncodingInputStream;->priorChunkSignature:Ljava/lang/String;

    .line 139
    iput-object p7, p0, Lcom/amazonaws/auth/AwsChunkedEncodingInputStream;->aws4Signer:Lcom/amazonaws/auth/AWS4Signer;

    .line 140
    return-void

    .line 130
    :cond_1
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "Max buffer size should not be less than chunk size"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public constructor <init>(Ljava/io/InputStream;[BLjava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/amazonaws/auth/AWS4Signer;)V
    .locals 8
    .param p1, "in"    # Ljava/io/InputStream;
    .param p2, "kSigning"    # [B
    .param p3, "datetime"    # Ljava/lang/String;
    .param p4, "keyPath"    # Ljava/lang/String;
    .param p5, "headerSignature"    # Ljava/lang/String;
    .param p6, "aws4Signer"    # Lcom/amazonaws/auth/AWS4Signer;

    .line 92
    const/high16 v2, 0x40000

    move-object v0, p0

    move-object v1, p1

    move-object v3, p2

    move-object v4, p3

    move-object v5, p4

    move-object v6, p5

    move-object v7, p6

    invoke-direct/range {v0 .. v7}, Lcom/amazonaws/auth/AwsChunkedEncodingInputStream;-><init>(Ljava/io/InputStream;I[BLjava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/amazonaws/auth/AWS4Signer;)V

    .line 93
    return-void
.end method

.method private static calculateSignedChunkLength(J)J
    .locals 4
    .param p0, "chunkDataSize"    # J

    .line 293
    invoke-static {p0, p1}, Ljava/lang/Long;->toHexString(J)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v0

    .line 294
    const-string v1, ";chunk-signature="

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v1

    add-int/2addr v0, v1

    add-int/lit8 v0, v0, 0x40

    .line 296
    const-string v1, "\r\n"

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v2

    add-int/2addr v0, v2

    int-to-long v2, v0

    add-long/2addr v2, p0

    .line 298
    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v0

    int-to-long v0, v0

    add-long/2addr v2, v0

    .line 293
    return-wide v2
.end method

.method public static calculateStreamContentLength(J)J
    .locals 10
    .param p0, "originalLength"    # J

    .line 281
    const-wide/16 v0, 0x0

    cmp-long v2, p0, v0

    if-ltz v2, :cond_1

    .line 285
    const-wide/32 v2, 0x20000

    div-long v4, p0, v2

    .line 286
    .local v4, "maxSizeChunks":J
    rem-long v6, p0, v2

    .line 287
    .local v6, "remainingBytes":J
    invoke-static {v2, v3}, Lcom/amazonaws/auth/AwsChunkedEncodingInputStream;->calculateSignedChunkLength(J)J

    move-result-wide v2

    mul-long/2addr v2, v4

    cmp-long v8, v6, v0

    if-lez v8, :cond_0

    .line 288
    invoke-static {v6, v7}, Lcom/amazonaws/auth/AwsChunkedEncodingInputStream;->calculateSignedChunkLength(J)J

    move-result-wide v8

    goto :goto_0

    :cond_0
    move-wide v8, v0

    :goto_0
    add-long/2addr v2, v8

    .line 289
    invoke-static {v0, v1}, Lcom/amazonaws/auth/AwsChunkedEncodingInputStream;->calculateSignedChunkLength(J)J

    move-result-wide v0

    add-long/2addr v2, v0

    .line 287
    return-wide v2

    .line 282
    .end local v4    # "maxSizeChunks":J
    .end local v6    # "remainingBytes":J
    :cond_1
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "Nonnegative content length expected."

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method private createSignedChunk([B)[B
    .locals 10
    .param p1, "chunkData"    # [B

    .line 347
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 349
    .local v0, "chunkHeader":Ljava/lang/StringBuilder;
    array-length v1, p1

    invoke-static {v1}, Ljava/lang/Integer;->toHexString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 351
    const-string v1, ""

    .line 353
    .local v1, "nonsigExtension":Ljava/lang/String;
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "AWS4-HMAC-SHA256-PAYLOAD\n"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, p0, Lcom/amazonaws/auth/AwsChunkedEncodingInputStream;->dateTime:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "\n"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v4, p0, Lcom/amazonaws/auth/AwsChunkedEncodingInputStream;->keyPath:Ljava/lang/String;

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v4, p0, Lcom/amazonaws/auth/AwsChunkedEncodingInputStream;->priorChunkSignature:Ljava/lang/String;

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v4, p0, Lcom/amazonaws/auth/AwsChunkedEncodingInputStream;->aws4Signer:Lcom/amazonaws/auth/AWS4Signer;

    .line 357
    const-string v5, ""

    invoke-virtual {v4, v5}, Lcom/amazonaws/auth/AWS4Signer;->hash(Ljava/lang/String;)[B

    move-result-object v4

    invoke-static {v4}, Lcom/amazonaws/util/BinaryUtils;->toHex([B)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, p0, Lcom/amazonaws/auth/AwsChunkedEncodingInputStream;->aws4Signer:Lcom/amazonaws/auth/AWS4Signer;

    .line 358
    invoke-virtual {v3, p1}, Lcom/amazonaws/auth/AWS4Signer;->hash([B)[B

    move-result-object v3

    invoke-static {v3}, Lcom/amazonaws/util/BinaryUtils;->toHex([B)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    .line 359
    .local v2, "chunkStringToSign":Ljava/lang/String;
    iget-object v3, p0, Lcom/amazonaws/auth/AwsChunkedEncodingInputStream;->aws4Signer:Lcom/amazonaws/auth/AWS4Signer;

    iget-object v4, p0, Lcom/amazonaws/auth/AwsChunkedEncodingInputStream;->kSigning:[B

    sget-object v5, Lcom/amazonaws/auth/SigningAlgorithm;->HmacSHA256:Lcom/amazonaws/auth/SigningAlgorithm;

    invoke-virtual {v3, v2, v4, v5}, Lcom/amazonaws/auth/AWS4Signer;->sign(Ljava/lang/String;[BLcom/amazonaws/auth/SigningAlgorithm;)[B

    move-result-object v3

    invoke-static {v3}, Lcom/amazonaws/util/BinaryUtils;->toHex([B)Ljava/lang/String;

    move-result-object v3

    .line 361
    .local v3, "chunkSignature":Ljava/lang/String;
    iput-object v3, p0, Lcom/amazonaws/auth/AwsChunkedEncodingInputStream;->priorChunkSignature:Ljava/lang/String;

    .line 362
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, ";chunk-signature="

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 363
    const-string v4, "\r\n"

    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 366
    :try_start_0
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    sget-object v6, Lcom/amazonaws/util/StringUtils;->UTF8:Ljava/nio/charset/Charset;

    invoke-virtual {v5, v6}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B

    move-result-object v5

    .line 367
    .local v5, "header":[B
    sget-object v6, Lcom/amazonaws/util/StringUtils;->UTF8:Ljava/nio/charset/Charset;

    invoke-virtual {v4, v6}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B

    move-result-object v4

    .line 368
    .local v4, "trailer":[B
    array-length v6, v5

    array-length v7, p1

    add-int/2addr v6, v7

    array-length v7, v4

    add-int/2addr v6, v7

    new-array v6, v6, [B

    .line 369
    .local v6, "signedChunk":[B
    array-length v7, v5

    const/4 v8, 0x0

    invoke-static {v5, v8, v6, v8, v7}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 370
    array-length v7, v5

    array-length v9, p1

    invoke-static {p1, v8, v6, v7, v9}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 371
    array-length v7, v5

    array-length v9, p1

    add-int/2addr v7, v9

    array-length v9, v4

    invoke-static {v4, v8, v6, v7, v9}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 374
    return-object v6

    .line 375
    .end local v4    # "trailer":[B
    .end local v5    # "header":[B
    .end local v6    # "signedChunk":[B
    :catch_0
    move-exception v4

    .line 376
    .local v4, "e":Ljava/lang/Exception;
    new-instance v5, Lcom/amazonaws/AmazonClientException;

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "Unable to sign the chunked data. "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v4}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-direct {v5, v6, v4}, Lcom/amazonaws/AmazonClientException;-><init>(Ljava/lang/String;Ljava/lang/Throwable;)V

    throw v5
.end method

.method private setUpNextChunk()Z
    .locals 6
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 308
    const/high16 v0, 0x20000

    new-array v1, v0, [B

    .line 309
    .local v1, "chunkData":[B
    const/4 v2, 0x0

    .line 310
    .local v2, "chunkSizeInBytes":I
    :goto_0
    if-ge v2, v0, :cond_2

    .line 312
    iget-object v3, p0, Lcom/amazonaws/auth/AwsChunkedEncodingInputStream;->decodedStreamBuffer:Lcom/amazonaws/auth/DecodedStreamBuffer;

    if-eqz v3, :cond_0

    iget-object v3, p0, Lcom/amazonaws/auth/AwsChunkedEncodingInputStream;->decodedStreamBuffer:Lcom/amazonaws/auth/DecodedStreamBuffer;

    .line 313
    invoke-virtual {v3}, Lcom/amazonaws/auth/DecodedStreamBuffer;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_0

    .line 314
    add-int/lit8 v3, v2, 0x1

    .end local v2    # "chunkSizeInBytes":I
    .local v3, "chunkSizeInBytes":I
    iget-object v4, p0, Lcom/amazonaws/auth/AwsChunkedEncodingInputStream;->decodedStreamBuffer:Lcom/amazonaws/auth/DecodedStreamBuffer;

    invoke-virtual {v4}, Lcom/amazonaws/auth/DecodedStreamBuffer;->next()B

    move-result v4

    aput-byte v4, v1, v2

    move v2, v3

    goto :goto_0

    .line 318
    .end local v3    # "chunkSizeInBytes":I
    .restart local v2    # "chunkSizeInBytes":I
    :cond_0
    sub-int v3, v0, v2

    .line 319
    .local v3, "bytesToRead":I
    iget-object v4, p0, Lcom/amazonaws/auth/AwsChunkedEncodingInputStream;->is:Ljava/io/InputStream;

    invoke-virtual {v4, v1, v2, v3}, Ljava/io/InputStream;->read([BII)I

    move-result v4

    .line 320
    .local v4, "count":I
    const/4 v5, -0x1

    if-eq v4, v5, :cond_2

    .line 321
    iget-object v5, p0, Lcom/amazonaws/auth/AwsChunkedEncodingInputStream;->decodedStreamBuffer:Lcom/amazonaws/auth/DecodedStreamBuffer;

    if-eqz v5, :cond_1

    .line 322
    iget-object v5, p0, Lcom/amazonaws/auth/AwsChunkedEncodingInputStream;->decodedStreamBuffer:Lcom/amazonaws/auth/DecodedStreamBuffer;

    invoke-virtual {v5, v1, v2, v4}, Lcom/amazonaws/auth/DecodedStreamBuffer;->buffer([BII)V

    .line 324
    :cond_1
    add-int/2addr v2, v4

    .line 328
    .end local v3    # "bytesToRead":I
    .end local v4    # "count":I
    goto :goto_0

    .line 330
    :cond_2
    if-nez v2, :cond_3

    .line 331
    sget-object v0, Lcom/amazonaws/auth/AwsChunkedEncodingInputStream;->FINAL_CHUNK:[B

    invoke-direct {p0, v0}, Lcom/amazonaws/auth/AwsChunkedEncodingInputStream;->createSignedChunk([B)[B

    move-result-object v0

    .line 332
    .local v0, "signedFinalChunk":[B
    new-instance v3, Lcom/amazonaws/auth/ChunkContentIterator;

    invoke-direct {v3, v0}, Lcom/amazonaws/auth/ChunkContentIterator;-><init>([B)V

    iput-object v3, p0, Lcom/amazonaws/auth/AwsChunkedEncodingInputStream;->currentChunkIterator:Lcom/amazonaws/auth/ChunkContentIterator;

    .line 333
    const/4 v3, 0x1

    return v3

    .line 335
    .end local v0    # "signedFinalChunk":[B
    :cond_3
    array-length v0, v1

    const/4 v3, 0x0

    if-ge v2, v0, :cond_4

    .line 336
    new-array v0, v2, [B

    .line 337
    .local v0, "temp":[B
    invoke-static {v1, v3, v0, v3, v2}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 338
    move-object v1, v0

    .line 340
    .end local v0    # "temp":[B
    :cond_4
    invoke-direct {p0, v1}, Lcom/amazonaws/auth/AwsChunkedEncodingInputStream;->createSignedChunk([B)[B

    move-result-object v0

    .line 341
    .local v0, "signedChunkContent":[B
    new-instance v4, Lcom/amazonaws/auth/ChunkContentIterator;

    invoke-direct {v4, v0}, Lcom/amazonaws/auth/ChunkContentIterator;-><init>([B)V

    iput-object v4, p0, Lcom/amazonaws/auth/AwsChunkedEncodingInputStream;->currentChunkIterator:Lcom/amazonaws/auth/ChunkContentIterator;

    .line 342
    return v3
.end method


# virtual methods
.method protected getWrappedInputStream()Ljava/io/InputStream;
    .locals 1

    .line 383
    iget-object v0, p0, Lcom/amazonaws/auth/AwsChunkedEncodingInputStream;->is:Ljava/io/InputStream;

    return-object v0
.end method

.method public declared-synchronized mark(I)V
    .locals 2
    .param p1, "readlimit"    # I

    monitor-enter p0

    .line 220
    :try_start_0
    invoke-virtual {p0}, Lcom/amazonaws/auth/AwsChunkedEncodingInputStream;->abortIfNeeded()V

    .line 221
    iget-boolean v0, p0, Lcom/amazonaws/auth/AwsChunkedEncodingInputStream;->isAtStart:Z

    if-eqz v0, :cond_3

    .line 225
    iget-object v0, p0, Lcom/amazonaws/auth/AwsChunkedEncodingInputStream;->is:Ljava/io/InputStream;

    invoke-virtual {v0}, Ljava/io/InputStream;->markSupported()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 226
    sget-object v0, Lcom/amazonaws/auth/AwsChunkedEncodingInputStream;->log:Lcom/amazonaws/logging/Log;

    invoke-interface {v0}, Lcom/amazonaws/logging/Log;->isDebugEnabled()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 227
    sget-object v0, Lcom/amazonaws/auth/AwsChunkedEncodingInputStream;->log:Lcom/amazonaws/logging/Log;

    const-string v1, "AwsChunkedEncodingInputStream marked at the start of the stream (will directly mark the wrapped stream since it\'s mark-supported)."

    invoke-interface {v0, v1}, Lcom/amazonaws/logging/Log;->debug(Ljava/lang/Object;)V

    .line 230
    .end local p0    # "this":Lcom/amazonaws/auth/AwsChunkedEncodingInputStream;
    :cond_0
    iget-object v0, p0, Lcom/amazonaws/auth/AwsChunkedEncodingInputStream;->is:Ljava/io/InputStream;

    const v1, 0x7fffffff

    invoke-virtual {v0, v1}, Ljava/io/InputStream;->mark(I)V

    goto :goto_0

    .line 232
    :cond_1
    sget-object v0, Lcom/amazonaws/auth/AwsChunkedEncodingInputStream;->log:Lcom/amazonaws/logging/Log;

    invoke-interface {v0}, Lcom/amazonaws/logging/Log;->isDebugEnabled()Z

    move-result v0

    if-eqz v0, :cond_2

    .line 233
    sget-object v0, Lcom/amazonaws/auth/AwsChunkedEncodingInputStream;->log:Lcom/amazonaws/logging/Log;

    const-string v1, "AwsChunkedEncodingInputStream marked at the start of the stream (initializing the buffer since the wrapped stream is not mark-supported)."

    invoke-interface {v0, v1}, Lcom/amazonaws/logging/Log;->debug(Ljava/lang/Object;)V

    .line 236
    :cond_2
    new-instance v0, Lcom/amazonaws/auth/DecodedStreamBuffer;

    iget v1, p0, Lcom/amazonaws/auth/AwsChunkedEncodingInputStream;->maxBufferSize:I

    invoke-direct {v0, v1}, Lcom/amazonaws/auth/DecodedStreamBuffer;-><init>(I)V

    iput-object v0, p0, Lcom/amazonaws/auth/AwsChunkedEncodingInputStream;->decodedStreamBuffer:Lcom/amazonaws/auth/DecodedStreamBuffer;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 238
    :goto_0
    monitor-exit p0

    return-void

    .line 222
    :cond_3
    :try_start_1
    new-instance v0, Ljava/lang/UnsupportedOperationException;

    const-string v1, "Chunk-encoded stream only supports mark() at the start of the stream."

    invoke-direct {v0, v1}, Ljava/lang/UnsupportedOperationException;-><init>(Ljava/lang/String;)V

    throw v0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 219
    .end local p1    # "readlimit":I
    :catchall_0
    move-exception p1

    monitor-exit p0

    throw p1
.end method

.method public markSupported()Z
    .locals 1

    .line 210
    const/4 v0, 0x1

    return v0
.end method

.method public read()I
    .locals 5
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 144
    const/4 v0, 0x1

    new-array v1, v0, [B

    .line 145
    .local v1, "tmp":[B
    const/4 v2, 0x0

    invoke-virtual {p0, v1, v2, v0}, Lcom/amazonaws/auth/AwsChunkedEncodingInputStream;->read([BII)I

    move-result v0

    .line 146
    .local v0, "count":I
    const/4 v3, -0x1

    if-eq v0, v3, :cond_1

    .line 147
    sget-object v3, Lcom/amazonaws/auth/AwsChunkedEncodingInputStream;->log:Lcom/amazonaws/logging/Log;

    invoke-interface {v3}, Lcom/amazonaws/logging/Log;->isDebugEnabled()Z

    move-result v3

    if-eqz v3, :cond_0

    .line 148
    sget-object v3, Lcom/amazonaws/auth/AwsChunkedEncodingInputStream;->log:Lcom/amazonaws/logging/Log;

    const-string v4, "One byte read from the stream."

    invoke-interface {v3, v4}, Lcom/amazonaws/logging/Log;->debug(Ljava/lang/Object;)V

    .line 150
    :cond_0
    aget-byte v2, v1, v2

    and-int/lit16 v2, v2, 0xff

    .line 151
    .local v2, "unsignedByte":I
    return v2

    .line 153
    .end local v2    # "unsignedByte":I
    :cond_1
    return v0
.end method

.method public read([BII)I
    .locals 4
    .param p1, "b"    # [B
    .param p2, "off"    # I
    .param p3, "len"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 159
    invoke-virtual {p0}, Lcom/amazonaws/auth/AwsChunkedEncodingInputStream;->abortIfNeeded()V

    .line 160
    if-eqz p1, :cond_6

    .line 162
    if-ltz p2, :cond_5

    if-ltz p3, :cond_5

    array-length v0, p1

    sub-int/2addr v0, p2

    if-gt p3, v0, :cond_5

    .line 164
    const/4 v0, 0x0

    if-nez p3, :cond_0

    .line 165
    return v0

    .line 168
    :cond_0
    iget-object v1, p0, Lcom/amazonaws/auth/AwsChunkedEncodingInputStream;->currentChunkIterator:Lcom/amazonaws/auth/ChunkContentIterator;

    if-eqz v1, :cond_1

    iget-object v1, p0, Lcom/amazonaws/auth/AwsChunkedEncodingInputStream;->currentChunkIterator:Lcom/amazonaws/auth/ChunkContentIterator;

    .line 169
    invoke-virtual {v1}, Lcom/amazonaws/auth/ChunkContentIterator;->hasNext()Z

    move-result v1

    if-nez v1, :cond_3

    .line 170
    :cond_1
    iget-boolean v1, p0, Lcom/amazonaws/auth/AwsChunkedEncodingInputStream;->isTerminating:Z

    if-eqz v1, :cond_2

    .line 171
    const/4 v0, -0x1

    return v0

    .line 173
    :cond_2
    invoke-direct {p0}, Lcom/amazonaws/auth/AwsChunkedEncodingInputStream;->setUpNextChunk()Z

    move-result v1

    iput-boolean v1, p0, Lcom/amazonaws/auth/AwsChunkedEncodingInputStream;->isTerminating:Z

    .line 177
    :cond_3
    iget-object v1, p0, Lcom/amazonaws/auth/AwsChunkedEncodingInputStream;->currentChunkIterator:Lcom/amazonaws/auth/ChunkContentIterator;

    invoke-virtual {v1, p1, p2, p3}, Lcom/amazonaws/auth/ChunkContentIterator;->read([BII)I

    move-result v1

    .line 178
    .local v1, "count":I
    if-lez v1, :cond_4

    .line 179
    iput-boolean v0, p0, Lcom/amazonaws/auth/AwsChunkedEncodingInputStream;->isAtStart:Z

    .line 180
    sget-object v0, Lcom/amazonaws/auth/AwsChunkedEncodingInputStream;->log:Lcom/amazonaws/logging/Log;

    invoke-interface {v0}, Lcom/amazonaws/logging/Log;->isDebugEnabled()Z

    move-result v0

    if-eqz v0, :cond_4

    .line 181
    sget-object v0, Lcom/amazonaws/auth/AwsChunkedEncodingInputStream;->log:Lcom/amazonaws/logging/Log;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " byte read from the stream."

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-interface {v0, v2}, Lcom/amazonaws/logging/Log;->debug(Ljava/lang/Object;)V

    .line 184
    :cond_4
    return v1

    .line 163
    .end local v1    # "count":I
    :cond_5
    new-instance v0, Ljava/lang/IndexOutOfBoundsException;

    invoke-direct {v0}, Ljava/lang/IndexOutOfBoundsException;-><init>()V

    throw v0

    .line 161
    :cond_6
    new-instance v0, Ljava/lang/NullPointerException;

    invoke-direct {v0}, Ljava/lang/NullPointerException;-><init>()V

    throw v0
.end method

.method public declared-synchronized reset()V
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    monitor-enter p0

    .line 246
    :try_start_0
    invoke-virtual {p0}, Lcom/amazonaws/auth/AwsChunkedEncodingInputStream;->abortIfNeeded()V

    .line 248
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/amazonaws/auth/AwsChunkedEncodingInputStream;->currentChunkIterator:Lcom/amazonaws/auth/ChunkContentIterator;

    .line 249
    iget-object v1, p0, Lcom/amazonaws/auth/AwsChunkedEncodingInputStream;->headerSignature:Ljava/lang/String;

    iput-object v1, p0, Lcom/amazonaws/auth/AwsChunkedEncodingInputStream;->priorChunkSignature:Ljava/lang/String;

    .line 252
    iget-object v1, p0, Lcom/amazonaws/auth/AwsChunkedEncodingInputStream;->is:Ljava/io/InputStream;

    invoke-virtual {v1}, Ljava/io/InputStream;->markSupported()Z

    move-result v1

    if-eqz v1, :cond_1

    .line 253
    sget-object v1, Lcom/amazonaws/auth/AwsChunkedEncodingInputStream;->log:Lcom/amazonaws/logging/Log;

    invoke-interface {v1}, Lcom/amazonaws/logging/Log;->isDebugEnabled()Z

    move-result v1

    if-eqz v1, :cond_0

    .line 254
    sget-object v1, Lcom/amazonaws/auth/AwsChunkedEncodingInputStream;->log:Lcom/amazonaws/logging/Log;

    const-string v2, "AwsChunkedEncodingInputStream reset (will reset the wrapped stream because it is mark-supported)."

    invoke-interface {v1, v2}, Lcom/amazonaws/logging/Log;->debug(Ljava/lang/Object;)V

    .line 257
    .end local p0    # "this":Lcom/amazonaws/auth/AwsChunkedEncodingInputStream;
    :cond_0
    iget-object v1, p0, Lcom/amazonaws/auth/AwsChunkedEncodingInputStream;->is:Ljava/io/InputStream;

    invoke-virtual {v1}, Ljava/io/InputStream;->reset()V

    goto :goto_0

    .line 259
    :cond_1
    sget-object v1, Lcom/amazonaws/auth/AwsChunkedEncodingInputStream;->log:Lcom/amazonaws/logging/Log;

    invoke-interface {v1}, Lcom/amazonaws/logging/Log;->isDebugEnabled()Z

    move-result v1

    if-eqz v1, :cond_2

    .line 260
    sget-object v1, Lcom/amazonaws/auth/AwsChunkedEncodingInputStream;->log:Lcom/amazonaws/logging/Log;

    const-string v2, "AwsChunkedEncodingInputStream reset (will use the buffer of the decoded stream)."

    invoke-interface {v1, v2}, Lcom/amazonaws/logging/Log;->debug(Ljava/lang/Object;)V

    .line 263
    :cond_2
    iget-object v1, p0, Lcom/amazonaws/auth/AwsChunkedEncodingInputStream;->decodedStreamBuffer:Lcom/amazonaws/auth/DecodedStreamBuffer;

    if-eqz v1, :cond_3

    .line 266
    iget-object v1, p0, Lcom/amazonaws/auth/AwsChunkedEncodingInputStream;->decodedStreamBuffer:Lcom/amazonaws/auth/DecodedStreamBuffer;

    invoke-virtual {v1}, Lcom/amazonaws/auth/DecodedStreamBuffer;->startReadBuffer()V

    .line 269
    :goto_0
    iput-object v0, p0, Lcom/amazonaws/auth/AwsChunkedEncodingInputStream;->currentChunkIterator:Lcom/amazonaws/auth/ChunkContentIterator;

    .line 270
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/amazonaws/auth/AwsChunkedEncodingInputStream;->isAtStart:Z

    .line 271
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/amazonaws/auth/AwsChunkedEncodingInputStream;->isTerminating:Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 272
    monitor-exit p0

    return-void

    .line 264
    :cond_3
    :try_start_1
    new-instance v0, Ljava/io/IOException;

    const-string v1, "Cannot reset the stream because the mark is not set."

    invoke-direct {v0, v1}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 245
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public skip(J)J
    .locals 9
    .param p1, "n"    # J
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 189
    const-wide/16 v0, 0x0

    cmp-long v2, p1, v0

    if-gtz v2, :cond_0

    .line 190
    return-wide v0

    .line 192
    :cond_0
    move-wide v2, p1

    .line 193
    .local v2, "remaining":J
    const-wide/32 v4, 0x40000

    invoke-static {v4, v5, p1, p2}, Ljava/lang/Math;->min(JJ)J

    move-result-wide v4

    long-to-int v4, v4

    .line 194
    .local v4, "toskip":I
    new-array v5, v4, [B

    .line 195
    .local v5, "temp":[B
    :goto_0
    cmp-long v6, v2, v0

    if-lez v6, :cond_2

    .line 196
    const/4 v6, 0x0

    invoke-virtual {p0, v5, v6, v4}, Lcom/amazonaws/auth/AwsChunkedEncodingInputStream;->read([BII)I

    move-result v6

    .line 197
    .local v6, "count":I
    if-gez v6, :cond_1

    .line 198
    goto :goto_1

    .line 200
    :cond_1
    int-to-long v7, v6

    sub-long/2addr v2, v7

    .line 201
    .end local v6    # "count":I
    goto :goto_0

    .line 202
    :cond_2
    :goto_1
    sub-long v0, p1, v2

    return-wide v0
.end method
