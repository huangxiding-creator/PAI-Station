.class public Lio/minio/Digest;
.super Ljava/lang/Object;
.source "Digest.java"


# static fields
.field public static final ZERO_MD5_HASH:Ljava/lang/String; = "1B2M2Y8AsgTpgAmY7PhCfg=="

.field public static final ZERO_SHA256_HASH:Ljava/lang/String; = "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"


# direct methods
.method private constructor <init>()V
    .locals 0

    .line 42
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static md5Hash([BI)Ljava/lang/String;
    .locals 3
    .param p0, "data"    # [B
    .param p1, "length"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/security/NoSuchAlgorithmException;
        }
    .end annotation

    .line 46
    const-string v0, "MD5"

    invoke-static {v0}, Ljava/security/MessageDigest;->getInstance(Ljava/lang/String;)Ljava/security/MessageDigest;

    move-result-object v0

    .line 47
    .local v0, "md5Digest":Ljava/security/MessageDigest;
    const/4 v1, 0x0

    invoke-virtual {v0, p0, v1, p1}, Ljava/security/MessageDigest;->update([BII)V

    .line 48
    invoke-static {}, Ljava/util/Base64;->getEncoder()Ljava/util/Base64$Encoder;

    move-result-object v1

    invoke-virtual {v0}, Ljava/security/MessageDigest;->digest()[B

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/util/Base64$Encoder;->encodeToString([B)Ljava/lang/String;

    move-result-object v1

    return-object v1
.end method

.method public static sha256Hash(Ljava/lang/String;)Ljava/lang/String;
    .locals 2
    .param p0, "string"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/security/NoSuchAlgorithmException;
        }
    .end annotation

    .line 60
    sget-object v0, Ljava/nio/charset/StandardCharsets;->UTF_8:Ljava/nio/charset/Charset;

    invoke-virtual {p0, v0}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B

    move-result-object v0

    .line 61
    .local v0, "data":[B
    array-length v1, v0

    invoke-static {v0, v1}, Lio/minio/Digest;->sha256Hash([BI)Ljava/lang/String;

    move-result-object v1

    return-object v1
.end method

.method public static sha256Hash([BI)Ljava/lang/String;
    .locals 3
    .param p0, "data"    # [B
    .param p1, "length"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/security/NoSuchAlgorithmException;
        }
    .end annotation

    .line 53
    const-string v0, "SHA-256"

    invoke-static {v0}, Ljava/security/MessageDigest;->getInstance(Ljava/lang/String;)Ljava/security/MessageDigest;

    move-result-object v0

    .line 54
    .local v0, "sha256Digest":Ljava/security/MessageDigest;
    const/4 v1, 0x0

    invoke-virtual {v0, p0, v1, p1}, Ljava/security/MessageDigest;->update([BII)V

    .line 55
    invoke-static {}, Lcom/google/common/io/BaseEncoding;->base16()Lcom/google/common/io/BaseEncoding;

    move-result-object v1

    invoke-virtual {v0}, Ljava/security/MessageDigest;->digest()[B

    move-result-object v2

    invoke-virtual {v1, v2}, Lcom/google/common/io/BaseEncoding;->encode([B)Ljava/lang/String;

    move-result-object v1

    sget-object v2, Ljava/util/Locale;->US:Ljava/util/Locale;

    invoke-virtual {v1, v2}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v1

    return-object v1
.end method

.method public static sha256Md5Hashes(Ljava/lang/Object;I)[Ljava/lang/String;
    .locals 6
    .param p0, "data"    # Ljava/lang/Object;
    .param p1, "len"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/security/NoSuchAlgorithmException;,
            Ljava/io/IOException;,
            Lio/minio/errors/InsufficientDataException;,
            Lio/minio/errors/InternalException;
        }
    .end annotation

    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 74
    const-string v0, "SHA-256"

    invoke-static {v0}, Ljava/security/MessageDigest;->getInstance(Ljava/lang/String;)Ljava/security/MessageDigest;

    move-result-object v0

    .line 75
    .local v0, "sha256Digest":Ljava/security/MessageDigest;
    const-string v1, "MD5"

    invoke-static {v1}, Ljava/security/MessageDigest;->getInstance(Ljava/lang/String;)Ljava/security/MessageDigest;

    move-result-object v1

    .line 77
    .local v1, "md5Digest":Ljava/security/MessageDigest;
    instance-of v2, p0, Ljava/io/BufferedInputStream;

    const/4 v3, 0x0

    if-nez v2, :cond_2

    instance-of v2, p0, Ljava/io/RandomAccessFile;

    if-eqz v2, :cond_0

    goto :goto_0

    .line 79
    :cond_0
    instance-of v2, p0, [B

    if-eqz v2, :cond_1

    .line 80
    move-object v2, p0

    check-cast v2, [B

    invoke-virtual {v0, v2, v3, p1}, Ljava/security/MessageDigest;->update([BII)V

    .line 81
    move-object v2, p0

    check-cast v2, [B

    invoke-virtual {v1, v2, v3, p1}, Ljava/security/MessageDigest;->update([BII)V

    goto :goto_1

    .line 83
    :cond_1
    new-instance v2, Lio/minio/errors/InternalException;

    const-string v3, "Unknown data source to calculate SHA-256 hash. This should not happen, please report this issue at https://github.com/minio/minio-java/issues"

    const/4 v4, 0x0

    invoke-direct {v2, v3, v4}, Lio/minio/errors/InternalException;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    throw v2

    .line 78
    :cond_2
    :goto_0
    invoke-static {p0, p1, v0, v1}, Lio/minio/Digest;->updateDigests(Ljava/lang/Object;ILjava/security/MessageDigest;Ljava/security/MessageDigest;)I

    .line 89
    :goto_1
    const/4 v2, 0x2

    new-array v2, v2, [Ljava/lang/String;

    .line 90
    invoke-static {}, Lcom/google/common/io/BaseEncoding;->base16()Lcom/google/common/io/BaseEncoding;

    move-result-object v4

    invoke-virtual {v0}, Ljava/security/MessageDigest;->digest()[B

    move-result-object v5

    invoke-virtual {v4, v5}, Lcom/google/common/io/BaseEncoding;->encode([B)Ljava/lang/String;

    move-result-object v4

    sget-object v5, Ljava/util/Locale;->US:Ljava/util/Locale;

    invoke-virtual {v4, v5}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v4

    aput-object v4, v2, v3

    .line 91
    invoke-static {}, Lcom/google/common/io/BaseEncoding;->base64()Lcom/google/common/io/BaseEncoding;

    move-result-object v3

    invoke-virtual {v1}, Ljava/security/MessageDigest;->digest()[B

    move-result-object v4

    invoke-virtual {v3, v4}, Lcom/google/common/io/BaseEncoding;->encode([B)Ljava/lang/String;

    move-result-object v3

    const/4 v4, 0x1

    aput-object v3, v2, v4

    .line 89
    return-object v2
.end method

.method private static updateDigests(Ljava/lang/Object;ILjava/security/MessageDigest;Ljava/security/MessageDigest;)I
    .locals 11
    .param p0, "inputStream"    # Ljava/lang/Object;
    .param p1, "len"    # I
    .param p2, "sha256Digest"    # Ljava/security/MessageDigest;
    .param p3, "md5Digest"    # Ljava/security/MessageDigest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lio/minio/errors/InsufficientDataException;
        }
    .end annotation

    .line 99
    const/4 v0, 0x0

    .line 100
    .local v0, "file":Ljava/io/RandomAccessFile;
    const/4 v1, 0x0

    .line 101
    .local v1, "stream":Ljava/io/BufferedInputStream;
    instance-of v2, p0, Ljava/io/RandomAccessFile;

    if-eqz v2, :cond_0

    .line 102
    move-object v0, p0

    check-cast v0, Ljava/io/RandomAccessFile;

    goto :goto_0

    .line 103
    :cond_0
    instance-of v2, p0, Ljava/io/BufferedInputStream;

    if-eqz v2, :cond_1

    .line 104
    move-object v1, p0

    check-cast v1, Ljava/io/BufferedInputStream;

    .line 108
    :cond_1
    :goto_0
    const-wide/16 v2, 0x0

    .line 109
    .local v2, "pos":J
    if-eqz v0, :cond_2

    .line 110
    invoke-virtual {v0}, Ljava/io/RandomAccessFile;->getFilePointer()J

    move-result-wide v2

    goto :goto_1

    .line 112
    :cond_2
    invoke-virtual {v1, p1}, Ljava/io/BufferedInputStream;->mark(I)V

    .line 116
    :goto_1
    const/16 v4, 0x4000

    new-array v4, v4, [B

    .line 117
    .local v4, "buf":[B
    array-length v5, v4

    .line 118
    .local v5, "bytesToRead":I
    const/4 v6, 0x0

    .line 119
    .local v6, "bytesRead":I
    const/4 v7, 0x0

    .line 120
    .local v7, "totalBytesRead":I
    :cond_3
    :goto_2
    if-ge v7, p1, :cond_9

    .line 121
    sub-int v8, p1, v7

    if-ge v8, v5, :cond_4

    .line 122
    sub-int v5, p1, v7

    .line 125
    :cond_4
    const/4 v8, 0x0

    if-eqz v0, :cond_5

    .line 126
    invoke-virtual {v0, v4, v8, v5}, Ljava/io/RandomAccessFile;->read([BII)I

    move-result v6

    goto :goto_3

    .line 128
    :cond_5
    invoke-virtual {v1, v4, v8, v5}, Ljava/io/BufferedInputStream;->read([BII)I

    move-result v6

    .line 131
    :goto_3
    if-ltz v6, :cond_8

    .line 137
    if-lez v6, :cond_3

    .line 138
    if-eqz p2, :cond_6

    .line 139
    invoke-virtual {p2, v4, v8, v6}, Ljava/security/MessageDigest;->update([BII)V

    .line 142
    :cond_6
    if-eqz p3, :cond_7

    .line 143
    invoke-virtual {p3, v4, v8, v6}, Ljava/security/MessageDigest;->update([BII)V

    .line 146
    :cond_7
    add-int/2addr v7, v6

    goto :goto_2

    .line 133
    :cond_8
    new-instance v8, Lio/minio/errors/InsufficientDataException;

    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    const-string v10, "Insufficient data.  bytes read "

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, v7}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v9

    const-string v10, " expected "

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-direct {v8, v9}, Lio/minio/errors/InsufficientDataException;-><init>(Ljava/lang/String;)V

    throw v8

    .line 151
    :cond_9
    if-eqz v0, :cond_a

    .line 152
    invoke-virtual {v0, v2, v3}, Ljava/io/RandomAccessFile;->seek(J)V

    goto :goto_4

    .line 154
    :cond_a
    invoke-virtual {v1}, Ljava/io/BufferedInputStream;->reset()V

    .line 157
    :goto_4
    return v7
.end method
