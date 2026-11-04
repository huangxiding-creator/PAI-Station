.class Lcom/amazonaws/services/s3/internal/crypto/AesCtr;
.super Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoScheme;
.source "AesCtr.java"


# annotations
.annotation runtime Ljava/lang/Deprecated;
.end annotation


# static fields
.field private static final DEFAULT_IV_LENGTH_IN_BYTES:I = 0x10

.field private static final SUPPORTED_IV_LENGTH:I = 0xc


# direct methods
.method constructor <init>()V
    .locals 0

    .line 23
    invoke-direct {p0}, Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoScheme;-><init>()V

    return-void
.end method

.method private computeJ0([B)[B
    .locals 4
    .param p1, "nonce"    # [B

    .line 86
    invoke-virtual {p0}, Lcom/amazonaws/services/s3/internal/crypto/AesCtr;->getBlockSizeInBytes()I

    move-result v0

    .line 87
    .local v0, "blockSize":I
    new-array v1, v0, [B

    .line 88
    .local v1, "j0":[B
    const/4 v2, 0x0

    array-length v3, p1

    invoke-static {p1, v2, v1, v2, v3}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 89
    add-int/lit8 v2, v0, -0x1

    const/4 v3, 0x1

    aput-byte v3, v1, v2

    .line 90
    const-wide/16 v2, 0x1

    invoke-static {v1, v2, v3}, Lcom/amazonaws/services/s3/internal/crypto/AesCtr;->incrementBlocks([BJ)[B

    move-result-object v2

    return-object v2
.end method


# virtual methods
.method adjustIV([BJ)[B
    .locals 6
    .param p1, "iv"    # [B
    .param p2, "byteOffset"    # J

    .line 61
    array-length v0, p1

    const/16 v1, 0xc

    if-ne v0, v1, :cond_1

    .line 63
    invoke-virtual {p0}, Lcom/amazonaws/services/s3/internal/crypto/AesCtr;->getBlockSizeInBytes()I

    move-result v0

    .line 64
    .local v0, "blockSize":I
    int-to-long v1, v0

    div-long v1, p2, v1

    .line 65
    .local v1, "blockOffset":J
    int-to-long v3, v0

    mul-long/2addr v3, v1

    cmp-long v3, v3, p2

    if-nez v3, :cond_0

    .line 71
    invoke-direct {p0, p1}, Lcom/amazonaws/services/s3/internal/crypto/AesCtr;->computeJ0([B)[B

    move-result-object v3

    .line 72
    .local v3, "j0":[B
    invoke-static {v3, v1, v2}, Lcom/amazonaws/services/s3/internal/crypto/AesCtr;->incrementBlocks([BJ)[B

    move-result-object v4

    return-object v4

    .line 66
    .end local v3    # "j0":[B
    :cond_0
    new-instance v3, Ljava/lang/IllegalArgumentException;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "Expecting byteOffset to be multiple of 16, but got blockOffset="

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v1, v2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, ", blockSize="

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, ", byteOffset="

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, p2, p3}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-direct {v3, v4}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v3

    .line 62
    .end local v0    # "blockSize":I
    .end local v1    # "blockOffset":J
    :cond_1
    new-instance v0, Ljava/lang/UnsupportedOperationException;

    invoke-direct {v0}, Ljava/lang/UnsupportedOperationException;-><init>()V

    throw v0
.end method

.method getBlockSizeInBytes()I
    .locals 1

    .line 44
    sget-object v0, Lcom/amazonaws/services/s3/internal/crypto/AesCtr;->AES_GCM:Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoScheme;

    invoke-virtual {v0}, Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoScheme;->getBlockSizeInBytes()I

    move-result v0

    return v0
.end method

.method getCipherAlgorithm()Ljava/lang/String;
    .locals 1

    .line 34
    const-string v0, "AES/CTR/NoPadding"

    return-object v0
.end method

.method getIVLengthInBytes()I
    .locals 1

    .line 49
    const/16 v0, 0x10

    return v0
.end method

.method getKeyGeneratorAlgorithm()Ljava/lang/String;
    .locals 1

    .line 29
    sget-object v0, Lcom/amazonaws/services/s3/internal/crypto/AesCtr;->AES_GCM:Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoScheme;

    invoke-virtual {v0}, Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoScheme;->getKeyGeneratorAlgorithm()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method getKeyLengthInBits()I
    .locals 1

    .line 39
    sget-object v0, Lcom/amazonaws/services/s3/internal/crypto/AesCtr;->AES_GCM:Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoScheme;

    invoke-virtual {v0}, Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoScheme;->getKeyLengthInBits()I

    move-result v0

    return v0
.end method

.method getMaxPlaintextSize()J
    .locals 2

    .line 54
    const-wide/16 v0, -0x1

    return-wide v0
.end method
