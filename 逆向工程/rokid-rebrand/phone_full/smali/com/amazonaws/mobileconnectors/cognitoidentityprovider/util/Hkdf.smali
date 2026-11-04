.class public final Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/util/Hkdf;
.super Ljava/lang/Object;
.source "Hkdf.java"


# static fields
.field private static final EMPTY_ARRAY:[B

.field private static final MAX_KEY_SIZE:I = 0xff


# instance fields
.field private final algorithm:Ljava/lang/String;

.field private prk:Ljavax/crypto/SecretKey;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 36
    const/4 v0, 0x0

    new-array v0, v0, [B

    sput-object v0, Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/util/Hkdf;->EMPTY_ARRAY:[B

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;)V
    .locals 3
    .param p1, "algorithm"    # Ljava/lang/String;

    .line 105
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 38
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/util/Hkdf;->prk:Ljavax/crypto/SecretKey;

    .line 106
    const-string v0, "Hmac"

    invoke-virtual {p1, v0}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 110
    iput-object p1, p0, Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/util/Hkdf;->algorithm:Ljava/lang/String;

    .line 112
    return-void

    .line 107
    :cond_0
    new-instance v0, Ljava/lang/IllegalArgumentException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Invalid algorithm "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ". Hkdf may only be used with Hmac algorithms."

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method private assertInitialized()V
    .locals 2

    .line 202
    iget-object v0, p0, Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/util/Hkdf;->prk:Ljavax/crypto/SecretKey;

    if-eqz v0, :cond_0

    .line 205
    return-void

    .line 203
    :cond_0
    new-instance v0, Ljava/lang/IllegalStateException;

    const-string v1, "Hkdf has not been initialized"

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method private createMac()Ljavax/crypto/Mac;
    .locals 2

    .line 188
    :try_start_0
    iget-object v0, p0, Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/util/Hkdf;->algorithm:Ljava/lang/String;

    invoke-static {v0}, Ljavax/crypto/Mac;->getInstance(Ljava/lang/String;)Ljavax/crypto/Mac;

    move-result-object v0

    .line 189
    .local v0, "ex":Ljavax/crypto/Mac;
    iget-object v1, p0, Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/util/Hkdf;->prk:Ljavax/crypto/SecretKey;

    invoke-virtual {v0, v1}, Ljavax/crypto/Mac;->init(Ljava/security/Key;)V
    :try_end_0
    .catch Ljava/security/NoSuchAlgorithmException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/security/InvalidKeyException; {:try_start_0 .. :try_end_0} :catch_0

    .line 190
    return-object v0

    .line 193
    .end local v0    # "ex":Ljavax/crypto/Mac;
    :catch_0
    move-exception v0

    .line 194
    .local v0, "var3":Ljava/security/InvalidKeyException;
    new-instance v1, Ljava/lang/RuntimeException;

    invoke-direct {v1, v0}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/Throwable;)V

    throw v1

    .line 191
    .end local v0    # "var3":Ljava/security/InvalidKeyException;
    :catch_1
    move-exception v0

    .line 192
    .local v0, "var2":Ljava/security/NoSuchAlgorithmException;
    new-instance v1, Ljava/lang/RuntimeException;

    invoke-direct {v1, v0}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/Throwable;)V

    throw v1
.end method

.method public static getInstance(Ljava/lang/String;)Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/util/Hkdf;
    .locals 2
    .param p0, "algorithm"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/security/NoSuchAlgorithmException;
        }
    .end annotation

    .line 49
    invoke-static {p0}, Ljavax/crypto/Mac;->getInstance(Ljava/lang/String;)Ljavax/crypto/Mac;

    move-result-object v0

    .line 50
    .local v0, "mac":Ljavax/crypto/Mac;
    new-instance v1, Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/util/Hkdf;

    invoke-direct {v1, p0}, Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/util/Hkdf;-><init>(Ljava/lang/String;)V

    return-object v1
.end method


# virtual methods
.method public deriveKey([BI[BI)V
    .locals 7
    .param p1, "info"    # [B
    .param p2, "length"    # I
    .param p3, "output"    # [B
    .param p4, "offset"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/crypto/ShortBufferException;
        }
    .end annotation

    .line 148
    invoke-direct {p0}, Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/util/Hkdf;->assertInitialized()V

    .line 149
    if-ltz p2, :cond_4

    .line 151
    array-length v0, p3

    add-int v1, p4, p2

    if-lt v0, v1, :cond_3

    .line 154
    invoke-direct {p0}, Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/util/Hkdf;->createMac()Ljavax/crypto/Mac;

    move-result-object v0

    .line 155
    .local v0, "mac":Ljavax/crypto/Mac;
    invoke-virtual {v0}, Ljavax/crypto/Mac;->getMacLength()I

    move-result v1

    mul-int/lit16 v1, v1, 0xff

    if-gt p2, v1, :cond_2

    .line 159
    sget-object v1, Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/util/Hkdf;->EMPTY_ARRAY:[B

    .line 162
    .local v1, "t":[B
    const/4 v2, 0x0

    .line 164
    .local v2, "loc":I
    const/4 v3, 0x1

    .local v3, "i":B
    :goto_0
    const/4 v4, 0x0

    if-ge v2, p2, :cond_1

    .line 165
    :try_start_0
    invoke-virtual {v0, v1}, Ljavax/crypto/Mac;->update([B)V

    .line 166
    invoke-virtual {v0, p1}, Ljavax/crypto/Mac;->update([B)V

    .line 167
    invoke-virtual {v0, v3}, Ljavax/crypto/Mac;->update(B)V

    .line 168
    invoke-virtual {v0}, Ljavax/crypto/Mac;->doFinal()[B

    move-result-object v5

    move-object v1, v5

    .line 170
    const/4 v5, 0x0

    .local v5, "x":I
    :goto_1
    array-length v6, v1

    if-ge v5, v6, :cond_0

    if-ge v2, p2, :cond_0

    .line 171
    aget-byte v6, v1, v5

    aput-byte v6, p3, v2
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 172
    add-int/lit8 v5, v5, 0x1

    .line 170
    add-int/lit8 v2, v2, 0x1

    goto :goto_1

    .line 164
    .end local v5    # "x":I
    :cond_0
    add-int/lit8 v4, v3, 0x1

    int-to-byte v3, v4

    goto :goto_0

    .line 176
    .end local v2    # "loc":I
    .end local v3    # "i":B
    :catchall_0
    move-exception v2

    invoke-static {v1, v4}, Ljava/util/Arrays;->fill([BB)V

    .line 177
    throw v2

    .line 176
    :cond_1
    invoke-static {v1, v4}, Ljava/util/Arrays;->fill([BB)V

    .line 177
    nop

    .line 181
    .end local v0    # "mac":Ljavax/crypto/Mac;
    .end local v1    # "t":[B
    return-void

    .line 156
    .restart local v0    # "mac":Ljavax/crypto/Mac;
    :cond_2
    new-instance v1, Ljava/lang/IllegalArgumentException;

    const-string v2, "Requested keys may not be longer than 255 times the underlying HMAC length."

    invoke-direct {v1, v2}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v1

    .line 152
    .end local v0    # "mac":Ljavax/crypto/Mac;
    :cond_3
    new-instance v0, Ljavax/crypto/ShortBufferException;

    invoke-direct {v0}, Ljavax/crypto/ShortBufferException;-><init>()V

    throw v0

    .line 150
    :cond_4
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "Length must be a non-negative value."

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public deriveKey(Ljava/lang/String;I)[B
    .locals 1
    .param p1, "info"    # Ljava/lang/String;
    .param p2, "length"    # I

    .line 120
    if-eqz p1, :cond_0

    sget-object v0, Lcom/amazonaws/util/StringUtils;->UTF8:Ljava/nio/charset/Charset;

    invoke-virtual {p1, v0}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B

    move-result-object v0

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    invoke-virtual {p0, v0, p2}, Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/util/Hkdf;->deriveKey([BI)[B

    move-result-object v0

    return-object v0
.end method

.method public deriveKey([BI)[B
    .locals 3
    .param p1, "info"    # [B
    .param p2, "length"    # I

    .line 129
    new-array v0, p2, [B

    .line 132
    .local v0, "result":[B
    const/4 v1, 0x0

    :try_start_0
    invoke-virtual {p0, p1, p2, v0, v1}, Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/util/Hkdf;->deriveKey([BI[BI)V
    :try_end_0
    .catch Ljavax/crypto/ShortBufferException; {:try_start_0 .. :try_end_0} :catch_0

    .line 133
    return-object v0

    .line 134
    :catch_0
    move-exception v1

    .line 135
    .local v1, "var5":Ljavax/crypto/ShortBufferException;
    new-instance v2, Ljava/lang/RuntimeException;

    invoke-direct {v2, v1}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/Throwable;)V

    throw v2
.end method

.method public init([B)V
    .locals 2
    .param p1, "ikm"    # [B

    .line 57
    const/4 v0, 0x0

    move-object v1, v0

    check-cast v1, [B

    invoke-virtual {p0, p1, v0}, Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/util/Hkdf;->init([B[B)V

    .line 58
    return-void
.end method

.method public init([B[B)V
    .locals 6
    .param p1, "ikm"    # [B
    .param p2, "salt"    # [B

    .line 65
    if-nez p2, :cond_0

    sget-object v0, Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/util/Hkdf;->EMPTY_ARRAY:[B

    goto :goto_0

    :cond_0
    invoke-virtual {p2}, [B->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [B

    check-cast v0, [B

    .line 66
    .local v0, "realSalt":[B
    :goto_0
    sget-object v1, Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/util/Hkdf;->EMPTY_ARRAY:[B

    .line 69
    .local v1, "rawKeyMaterial":[B
    const/4 v2, 0x0

    :try_start_0
    iget-object v3, p0, Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/util/Hkdf;->algorithm:Ljava/lang/String;

    invoke-static {v3}, Ljavax/crypto/Mac;->getInstance(Ljava/lang/String;)Ljavax/crypto/Mac;

    move-result-object v3

    .line 70
    .local v3, "e":Ljavax/crypto/Mac;
    array-length v4, v0

    if-nez v4, :cond_1

    .line 71
    invoke-virtual {v3}, Ljavax/crypto/Mac;->getMacLength()I

    move-result v4

    new-array v4, v4, [B

    move-object v0, v4

    .line 72
    invoke-static {v0, v2}, Ljava/util/Arrays;->fill([BB)V

    .line 75
    :cond_1
    new-instance v4, Ljavax/crypto/spec/SecretKeySpec;

    iget-object v5, p0, Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/util/Hkdf;->algorithm:Ljava/lang/String;

    invoke-direct {v4, v0, v5}, Ljavax/crypto/spec/SecretKeySpec;-><init>([BLjava/lang/String;)V

    invoke-virtual {v3, v4}, Ljavax/crypto/Mac;->init(Ljava/security/Key;)V

    .line 76
    invoke-virtual {v3, p1}, Ljavax/crypto/Mac;->doFinal([B)[B

    move-result-object v4

    move-object v1, v4

    .line 77
    new-instance v4, Ljavax/crypto/spec/SecretKeySpec;

    iget-object v5, p0, Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/util/Hkdf;->algorithm:Ljava/lang/String;

    invoke-direct {v4, v1, v5}, Ljavax/crypto/spec/SecretKeySpec;-><init>([BLjava/lang/String;)V

    .line 78
    .local v4, "key":Ljavax/crypto/spec/SecretKeySpec;
    invoke-static {v1, v2}, Ljava/util/Arrays;->fill([BB)V

    .line 79
    invoke-virtual {p0, v4}, Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/util/Hkdf;->unsafeInitWithoutKeyExtraction(Ljavax/crypto/SecretKey;)V
    :try_end_0
    .catch Ljava/security/GeneralSecurityException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 83
    .end local v3    # "e":Ljavax/crypto/Mac;
    .end local v4    # "key":Ljavax/crypto/spec/SecretKeySpec;
    invoke-static {v1, v2}, Ljava/util/Arrays;->fill([BB)V

    .line 84
    nop

    .line 86
    return-void

    .line 83
    :catchall_0
    move-exception v3

    goto :goto_1

    .line 80
    :catch_0
    move-exception v3

    .line 81
    .local v3, "var10":Ljava/security/GeneralSecurityException;
    :try_start_1
    new-instance v4, Ljava/lang/RuntimeException;

    const-string v5, "Unexpected exception"

    invoke-direct {v4, v5, v3}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;Ljava/lang/Throwable;)V

    .end local v0    # "realSalt":[B
    .end local v1    # "rawKeyMaterial":[B
    .end local p1    # "ikm":[B
    .end local p2    # "salt":[B
    throw v4
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 83
    .end local v3    # "var10":Ljava/security/GeneralSecurityException;
    .restart local v0    # "realSalt":[B
    .restart local v1    # "rawKeyMaterial":[B
    .restart local p1    # "ikm":[B
    .restart local p2    # "salt":[B
    :goto_1
    invoke-static {v1, v2}, Ljava/util/Arrays;->fill([BB)V

    .line 84
    throw v3
.end method

.method public unsafeInitWithoutKeyExtraction(Ljavax/crypto/SecretKey;)V
    .locals 3
    .param p1, "rawKey"    # Ljavax/crypto/SecretKey;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/security/InvalidKeyException;
        }
    .end annotation

    .line 93
    invoke-interface {p1}, Ljavax/crypto/SecretKey;->getAlgorithm()Ljava/lang/String;

    move-result-object v0

    iget-object v1, p0, Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/util/Hkdf;->algorithm:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 98
    iput-object p1, p0, Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/util/Hkdf;->prk:Ljavax/crypto/SecretKey;

    .line 100
    return-void

    .line 94
    :cond_0
    new-instance v0, Ljava/security/InvalidKeyException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Algorithm for the provided key must match the algorithm for this Hkdf. Expected "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/amazonaws/mobileconnectors/cognitoidentityprovider/util/Hkdf;->algorithm:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " but found "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    .line 96
    invoke-interface {p1}, Ljavax/crypto/SecretKey;->getAlgorithm()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/security/InvalidKeyException;-><init>(Ljava/lang/String;)V

    throw v0
.end method
