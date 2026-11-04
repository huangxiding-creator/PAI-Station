.class Lcom/auth0/jwt/algorithms/ECDSAAlgorithm;
.super Lcom/auth0/jwt/algorithms/Algorithm;
.source "ECDSAAlgorithm.java"


# instance fields
.field private final crypto:Lcom/auth0/jwt/algorithms/CryptoHelper;

.field private final ecNumberSize:I

.field private final keyProvider:Lcom/auth0/jwt/interfaces/ECDSAKeyProvider;


# direct methods
.method constructor <init>(Lcom/auth0/jwt/algorithms/CryptoHelper;Ljava/lang/String;Ljava/lang/String;ILcom/auth0/jwt/interfaces/ECDSAKeyProvider;)V
    .locals 2
    .param p1, "crypto"    # Lcom/auth0/jwt/algorithms/CryptoHelper;
    .param p2, "id"    # Ljava/lang/String;
    .param p3, "algorithm"    # Ljava/lang/String;
    .param p4, "ecNumberSize"    # I
    .param p5, "keyProvider"    # Lcom/auth0/jwt/interfaces/ECDSAKeyProvider;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/IllegalArgumentException;
        }
    .end annotation

    .line 30
    invoke-direct {p0, p2, p3}, Lcom/auth0/jwt/algorithms/Algorithm;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    .line 31
    if-eqz p5, :cond_0

    .line 34
    iput-object p5, p0, Lcom/auth0/jwt/algorithms/ECDSAAlgorithm;->keyProvider:Lcom/auth0/jwt/interfaces/ECDSAKeyProvider;

    .line 35
    iput-object p1, p0, Lcom/auth0/jwt/algorithms/ECDSAAlgorithm;->crypto:Lcom/auth0/jwt/algorithms/CryptoHelper;

    .line 36
    iput p4, p0, Lcom/auth0/jwt/algorithms/ECDSAAlgorithm;->ecNumberSize:I

    .line 37
    return-void

    .line 32
    :cond_0
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "The Key Provider cannot be null."

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method constructor <init>(Ljava/lang/String;Ljava/lang/String;ILcom/auth0/jwt/interfaces/ECDSAKeyProvider;)V
    .locals 6
    .param p1, "id"    # Ljava/lang/String;
    .param p2, "algorithm"    # Ljava/lang/String;
    .param p3, "ecNumberSize"    # I
    .param p4, "keyProvider"    # Lcom/auth0/jwt/interfaces/ECDSAKeyProvider;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/IllegalArgumentException;
        }
    .end annotation

    .line 41
    new-instance v1, Lcom/auth0/jwt/algorithms/CryptoHelper;

    invoke-direct {v1}, Lcom/auth0/jwt/algorithms/CryptoHelper;-><init>()V

    move-object v0, p0

    move-object v2, p1

    move-object v3, p2

    move v4, p3

    move-object v5, p4

    invoke-direct/range {v0 .. v5}, Lcom/auth0/jwt/algorithms/ECDSAAlgorithm;-><init>(Lcom/auth0/jwt/algorithms/CryptoHelper;Ljava/lang/String;Ljava/lang/String;ILcom/auth0/jwt/interfaces/ECDSAKeyProvider;)V

    .line 42
    return-void
.end method

.method private countPadding([BII)I
    .locals 3
    .param p1, "bytes"    # [B
    .param p2, "fromIndex"    # I
    .param p3, "toIndex"    # I

    .line 277
    const/4 v0, 0x0

    .line 278
    .local v0, "padding":I
    :goto_0
    add-int v1, p2, v0

    if-ge v1, p3, :cond_0

    add-int v1, p2, v0

    aget-byte v1, p1, v1

    if-nez v1, :cond_0

    .line 279
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 281
    :cond_0
    add-int v1, p2, v0

    aget-byte v1, p1, v1

    and-int/lit16 v1, v1, 0xff

    const/16 v2, 0x7f

    if-le v1, v2, :cond_1

    add-int/lit8 v1, v0, -0x1

    goto :goto_1

    :cond_1
    move v1, v0

    :goto_1
    return v1
.end method

.method private isAllZeros([B)Z
    .locals 4
    .param p1, "bytes"    # [B

    .line 268
    array-length v0, p1

    const/4 v1, 0x0

    move v2, v1

    :goto_0
    if-ge v2, v0, :cond_1

    aget-byte v3, p1, v2

    .line 269
    .local v3, "b":B
    if-eqz v3, :cond_0

    .line 270
    return v1

    .line 268
    .end local v3    # "b":B
    :cond_0
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 273
    :cond_1
    const/4 v0, 0x1

    return v0
.end method

.method static providerForKeys(Ljava/security/interfaces/ECPublicKey;Ljava/security/interfaces/ECPrivateKey;)Lcom/auth0/jwt/interfaces/ECDSAKeyProvider;
    .locals 2
    .param p0, "publicKey"    # Ljava/security/interfaces/ECPublicKey;
    .param p1, "privateKey"    # Ljava/security/interfaces/ECPrivateKey;

    .line 286
    if-nez p0, :cond_1

    if-eqz p1, :cond_0

    goto :goto_0

    .line 287
    :cond_0
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "Both provided Keys cannot be null."

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 289
    :cond_1
    :goto_0
    new-instance v0, Lcom/auth0/jwt/algorithms/ECDSAAlgorithm$1;

    invoke-direct {v0, p0, p1}, Lcom/auth0/jwt/algorithms/ECDSAAlgorithm$1;-><init>(Ljava/security/interfaces/ECPublicKey;Ljava/security/interfaces/ECPrivateKey;)V

    return-object v0
.end method


# virtual methods
.method DERToJOSE([B)[B
    .locals 12
    .param p1, "derSignature"    # [B
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/security/SignatureException;
        }
    .end annotation

    .line 101
    const/4 v0, 0x0

    aget-byte v1, p1, v0

    const/16 v2, 0x30

    const/4 v3, 0x1

    if-ne v1, v2, :cond_0

    array-length v1, p1

    iget v2, p0, Lcom/auth0/jwt/algorithms/ECDSAAlgorithm;->ecNumberSize:I

    mul-int/lit8 v2, v2, 0x2

    if-eq v1, v2, :cond_0

    move v1, v3

    goto :goto_0

    :cond_0
    move v1, v0

    .line 102
    .local v1, "derEncoded":Z
    :goto_0
    const-string v2, "Invalid DER signature format."

    if-eqz v1, :cond_5

    .line 106
    iget v4, p0, Lcom/auth0/jwt/algorithms/ECDSAAlgorithm;->ecNumberSize:I

    mul-int/lit8 v4, v4, 0x2

    new-array v4, v4, [B

    .line 109
    .local v4, "joseSignature":[B
    const/4 v5, 0x1

    .line 110
    .local v5, "offset":I
    aget-byte v6, p1, v3

    const/16 v7, -0x7f

    if-ne v6, v7, :cond_1

    .line 112
    add-int/lit8 v5, v5, 0x1

    .line 116
    :cond_1
    add-int/lit8 v6, v5, 0x1

    .end local v5    # "offset":I
    .local v6, "offset":I
    aget-byte v5, p1, v5

    and-int/lit16 v5, v5, 0xff

    .line 117
    .local v5, "encodedLength":I
    array-length v7, p1

    sub-int/2addr v7, v6

    if-ne v5, v7, :cond_4

    .line 122
    add-int/2addr v6, v3

    .line 125
    add-int/lit8 v7, v6, 0x1

    .end local v6    # "offset":I
    .local v7, "offset":I
    aget-byte v6, p1, v6

    .line 126
    .local v6, "rlength":I
    iget v8, p0, Lcom/auth0/jwt/algorithms/ECDSAAlgorithm;->ecNumberSize:I

    add-int/2addr v8, v3

    if-gt v6, v8, :cond_3

    .line 129
    iget v8, p0, Lcom/auth0/jwt/algorithms/ECDSAAlgorithm;->ecNumberSize:I

    sub-int/2addr v8, v6

    .line 131
    .local v8, "rpadding":I
    neg-int v9, v8

    invoke-static {v9, v0}, Ljava/lang/Math;->max(II)I

    move-result v9

    add-int/2addr v9, v7

    .line 132
    invoke-static {v8, v0}, Ljava/lang/Math;->max(II)I

    move-result v10

    invoke-static {v8, v0}, Ljava/lang/Math;->min(II)I

    move-result v11

    add-int/2addr v11, v6

    .line 131
    invoke-static {p1, v9, v4, v10, v11}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 135
    add-int/lit8 v9, v6, 0x1

    add-int/2addr v7, v9

    .line 138
    add-int/lit8 v9, v7, 0x1

    .end local v7    # "offset":I
    .local v9, "offset":I
    aget-byte v7, p1, v7

    .line 139
    .local v7, "slength":I
    iget v10, p0, Lcom/auth0/jwt/algorithms/ECDSAAlgorithm;->ecNumberSize:I

    add-int/2addr v10, v3

    if-gt v7, v10, :cond_2

    .line 142
    iget v2, p0, Lcom/auth0/jwt/algorithms/ECDSAAlgorithm;->ecNumberSize:I

    sub-int/2addr v2, v7

    .line 144
    .local v2, "spadding":I
    neg-int v3, v2

    invoke-static {v3, v0}, Ljava/lang/Math;->max(II)I

    move-result v3

    add-int/2addr v3, v9

    iget v10, p0, Lcom/auth0/jwt/algorithms/ECDSAAlgorithm;->ecNumberSize:I

    .line 145
    invoke-static {v2, v0}, Ljava/lang/Math;->max(II)I

    move-result v11

    add-int/2addr v10, v11

    invoke-static {v2, v0}, Ljava/lang/Math;->min(II)I

    move-result v0

    add-int/2addr v0, v7

    .line 144
    invoke-static {p1, v3, v4, v10, v0}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 147
    return-object v4

    .line 140
    .end local v2    # "spadding":I
    :cond_2
    new-instance v0, Ljava/security/SignatureException;

    invoke-direct {v0, v2}, Ljava/security/SignatureException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 127
    .end local v8    # "rpadding":I
    .end local v9    # "offset":I
    .local v7, "offset":I
    :cond_3
    new-instance v0, Ljava/security/SignatureException;

    invoke-direct {v0, v2}, Ljava/security/SignatureException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 118
    .end local v7    # "offset":I
    .local v6, "offset":I
    :cond_4
    new-instance v0, Ljava/security/SignatureException;

    invoke-direct {v0, v2}, Ljava/security/SignatureException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 103
    .end local v4    # "joseSignature":[B
    .end local v5    # "encodedLength":I
    .end local v6    # "offset":I
    :cond_5
    new-instance v0, Ljava/security/SignatureException;

    invoke-direct {v0, v2}, Ljava/security/SignatureException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method JOSEToDER([B)[B
    .locals 11
    .param p1, "joseSignature"    # [B
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/security/SignatureException;
        }
    .end annotation

    .line 211
    iget v0, p0, Lcom/auth0/jwt/algorithms/ECDSAAlgorithm;->ecNumberSize:I

    const/4 v1, 0x0

    invoke-direct {p0, p1, v1, v0}, Lcom/auth0/jwt/algorithms/ECDSAAlgorithm;->countPadding([BII)I

    move-result v0

    .line 212
    .local v0, "rPadding":I
    iget v2, p0, Lcom/auth0/jwt/algorithms/ECDSAAlgorithm;->ecNumberSize:I

    array-length v3, p1

    invoke-direct {p0, p1, v2, v3}, Lcom/auth0/jwt/algorithms/ECDSAAlgorithm;->countPadding([BII)I

    move-result v2

    .line 213
    .local v2, "sPadding":I
    iget v3, p0, Lcom/auth0/jwt/algorithms/ECDSAAlgorithm;->ecNumberSize:I

    sub-int/2addr v3, v0

    .line 214
    .local v3, "rLength":I
    iget v4, p0, Lcom/auth0/jwt/algorithms/ECDSAAlgorithm;->ecNumberSize:I

    sub-int/2addr v4, v2

    .line 216
    .local v4, "sLength":I
    add-int/lit8 v5, v3, 0x2

    const/4 v6, 0x2

    add-int/2addr v5, v6

    add-int/2addr v5, v4

    .line 220
    .local v5, "length":I
    const/16 v7, 0x7f

    if-le v5, v7, :cond_0

    .line 221
    add-int/lit8 v7, v5, 0x3

    new-array v7, v7, [B

    .line 222
    .local v7, "derSignature":[B
    const/16 v8, -0x7f

    const/4 v9, 0x1

    aput-byte v8, v7, v9

    .line 223
    const/4 v8, 0x2

    .local v8, "offset":I
    goto :goto_0

    .line 225
    .end local v7    # "derSignature":[B
    .end local v8    # "offset":I
    :cond_0
    add-int/lit8 v7, v5, 0x2

    new-array v7, v7, [B

    .line 226
    .restart local v7    # "derSignature":[B
    const/4 v8, 0x1

    .line 231
    .restart local v8    # "offset":I
    :goto_0
    const/16 v9, 0x30

    aput-byte v9, v7, v1

    .line 232
    add-int/lit8 v9, v8, 0x1

    .end local v8    # "offset":I
    .local v9, "offset":I
    and-int/lit16 v10, v5, 0xff

    int-to-byte v10, v10

    aput-byte v10, v7, v8

    .line 235
    add-int/lit8 v8, v9, 0x1

    .end local v9    # "offset":I
    .restart local v8    # "offset":I
    aput-byte v6, v7, v9

    .line 236
    add-int/lit8 v9, v8, 0x1

    .end local v8    # "offset":I
    .restart local v9    # "offset":I
    int-to-byte v10, v3

    aput-byte v10, v7, v8

    .line 239
    if-gez v0, :cond_1

    .line 241
    add-int/lit8 v8, v9, 0x1

    .end local v9    # "offset":I
    .restart local v8    # "offset":I
    aput-byte v1, v7, v9

    .line 242
    iget v9, p0, Lcom/auth0/jwt/algorithms/ECDSAAlgorithm;->ecNumberSize:I

    invoke-static {p1, v1, v7, v8, v9}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 243
    iget v9, p0, Lcom/auth0/jwt/algorithms/ECDSAAlgorithm;->ecNumberSize:I

    add-int/2addr v8, v9

    goto :goto_1

    .line 245
    .end local v8    # "offset":I
    .restart local v9    # "offset":I
    :cond_1
    iget v8, p0, Lcom/auth0/jwt/algorithms/ECDSAAlgorithm;->ecNumberSize:I

    invoke-static {v8, v3}, Ljava/lang/Math;->min(II)I

    move-result v8

    .line 246
    .local v8, "copyLength":I
    invoke-static {p1, v0, v7, v9, v8}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 247
    add-int/2addr v9, v8

    move v8, v9

    .line 251
    .end local v9    # "offset":I
    .local v8, "offset":I
    :goto_1
    add-int/lit8 v9, v8, 0x1

    .end local v8    # "offset":I
    .restart local v9    # "offset":I
    aput-byte v6, v7, v8

    .line 252
    add-int/lit8 v6, v9, 0x1

    .end local v9    # "offset":I
    .local v6, "offset":I
    int-to-byte v8, v4

    aput-byte v8, v7, v9

    .line 255
    if-gez v2, :cond_2

    .line 257
    add-int/lit8 v8, v6, 0x1

    .end local v6    # "offset":I
    .restart local v8    # "offset":I
    aput-byte v1, v7, v6

    .line 258
    iget v1, p0, Lcom/auth0/jwt/algorithms/ECDSAAlgorithm;->ecNumberSize:I

    iget v6, p0, Lcom/auth0/jwt/algorithms/ECDSAAlgorithm;->ecNumberSize:I

    invoke-static {p1, v1, v7, v8, v6}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    move v6, v8

    goto :goto_2

    .line 260
    .end local v8    # "offset":I
    .restart local v6    # "offset":I
    :cond_2
    iget v1, p0, Lcom/auth0/jwt/algorithms/ECDSAAlgorithm;->ecNumberSize:I

    add-int/2addr v1, v2

    iget v8, p0, Lcom/auth0/jwt/algorithms/ECDSAAlgorithm;->ecNumberSize:I

    .line 261
    invoke-static {v8, v4}, Ljava/lang/Math;->min(II)I

    move-result v8

    .line 260
    invoke-static {p1, v1, v7, v6, v8}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 264
    :goto_2
    return-object v7
.end method

.method public getSigningKeyId()Ljava/lang/String;
    .locals 1

    .line 95
    iget-object v0, p0, Lcom/auth0/jwt/algorithms/ECDSAAlgorithm;->keyProvider:Lcom/auth0/jwt/interfaces/ECDSAKeyProvider;

    invoke-interface {v0}, Lcom/auth0/jwt/interfaces/ECDSAKeyProvider;->getPrivateKeyId()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public sign([B)[B
    .locals 3
    .param p1, "contentBytes"    # [B
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/auth0/jwt/exceptions/SignatureGenerationException;
        }
    .end annotation

    .line 82
    :try_start_0
    iget-object v0, p0, Lcom/auth0/jwt/algorithms/ECDSAAlgorithm;->keyProvider:Lcom/auth0/jwt/interfaces/ECDSAKeyProvider;

    invoke-interface {v0}, Lcom/auth0/jwt/interfaces/ECDSAKeyProvider;->getPrivateKey()Ljava/security/PrivateKey;

    move-result-object v0

    check-cast v0, Ljava/security/interfaces/ECPrivateKey;

    .line 83
    .local v0, "privateKey":Ljava/security/interfaces/ECPrivateKey;
    if-eqz v0, :cond_0

    .line 86
    iget-object v1, p0, Lcom/auth0/jwt/algorithms/ECDSAAlgorithm;->crypto:Lcom/auth0/jwt/algorithms/CryptoHelper;

    invoke-virtual {p0}, Lcom/auth0/jwt/algorithms/ECDSAAlgorithm;->getDescription()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2, v0, p1}, Lcom/auth0/jwt/algorithms/CryptoHelper;->createSignatureFor(Ljava/lang/String;Ljava/security/PrivateKey;[B)[B

    move-result-object v1

    .line 87
    .local v1, "signature":[B
    invoke-virtual {p0, v1}, Lcom/auth0/jwt/algorithms/ECDSAAlgorithm;->DERToJOSE([B)[B

    move-result-object v2

    return-object v2

    .line 84
    .end local v1    # "signature":[B
    :cond_0
    new-instance v1, Ljava/lang/IllegalStateException;

    const-string v2, "The given Private Key is null."

    invoke-direct {v1, v2}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    .end local p1    # "contentBytes":[B
    throw v1
    :try_end_0
    .catch Ljava/security/NoSuchAlgorithmException; {:try_start_0 .. :try_end_0} :catch_3
    .catch Ljava/security/SignatureException; {:try_start_0 .. :try_end_0} :catch_2
    .catch Ljava/security/InvalidKeyException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/IllegalStateException; {:try_start_0 .. :try_end_0} :catch_0

    .line 88
    .end local v0    # "privateKey":Ljava/security/interfaces/ECPrivateKey;
    .restart local p1    # "contentBytes":[B
    :catch_0
    move-exception v0

    goto :goto_0

    :catch_1
    move-exception v0

    goto :goto_0

    :catch_2
    move-exception v0

    goto :goto_0

    :catch_3
    move-exception v0

    .line 89
    .local v0, "e":Ljava/lang/Exception;
    :goto_0
    new-instance v1, Lcom/auth0/jwt/exceptions/SignatureGenerationException;

    invoke-direct {v1, p0, v0}, Lcom/auth0/jwt/exceptions/SignatureGenerationException;-><init>(Lcom/auth0/jwt/algorithms/Algorithm;Ljava/lang/Throwable;)V

    throw v1
.end method

.method public sign([B[B)[B
    .locals 3
    .param p1, "headerBytes"    # [B
    .param p2, "payloadBytes"    # [B
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/auth0/jwt/exceptions/SignatureGenerationException;
        }
    .end annotation

    .line 68
    :try_start_0
    iget-object v0, p0, Lcom/auth0/jwt/algorithms/ECDSAAlgorithm;->keyProvider:Lcom/auth0/jwt/interfaces/ECDSAKeyProvider;

    invoke-interface {v0}, Lcom/auth0/jwt/interfaces/ECDSAKeyProvider;->getPrivateKey()Ljava/security/PrivateKey;

    move-result-object v0

    check-cast v0, Ljava/security/interfaces/ECPrivateKey;

    .line 69
    .local v0, "privateKey":Ljava/security/interfaces/ECPrivateKey;
    if-eqz v0, :cond_0

    .line 72
    iget-object v1, p0, Lcom/auth0/jwt/algorithms/ECDSAAlgorithm;->crypto:Lcom/auth0/jwt/algorithms/CryptoHelper;

    invoke-virtual {p0}, Lcom/auth0/jwt/algorithms/ECDSAAlgorithm;->getDescription()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2, v0, p1, p2}, Lcom/auth0/jwt/algorithms/CryptoHelper;->createSignatureFor(Ljava/lang/String;Ljava/security/PrivateKey;[B[B)[B

    move-result-object v1

    .line 73
    .local v1, "signature":[B
    invoke-virtual {p0, v1}, Lcom/auth0/jwt/algorithms/ECDSAAlgorithm;->DERToJOSE([B)[B

    move-result-object v2

    return-object v2

    .line 70
    .end local v1    # "signature":[B
    :cond_0
    new-instance v1, Ljava/lang/IllegalStateException;

    const-string v2, "The given Private Key is null."

    invoke-direct {v1, v2}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    .end local p1    # "headerBytes":[B
    .end local p2    # "payloadBytes":[B
    throw v1
    :try_end_0
    .catch Ljava/security/NoSuchAlgorithmException; {:try_start_0 .. :try_end_0} :catch_3
    .catch Ljava/security/SignatureException; {:try_start_0 .. :try_end_0} :catch_2
    .catch Ljava/security/InvalidKeyException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/IllegalStateException; {:try_start_0 .. :try_end_0} :catch_0

    .line 74
    .end local v0    # "privateKey":Ljava/security/interfaces/ECPrivateKey;
    .restart local p1    # "headerBytes":[B
    .restart local p2    # "payloadBytes":[B
    :catch_0
    move-exception v0

    goto :goto_0

    :catch_1
    move-exception v0

    goto :goto_0

    :catch_2
    move-exception v0

    goto :goto_0

    :catch_3
    move-exception v0

    .line 75
    .local v0, "e":Ljava/lang/Exception;
    :goto_0
    new-instance v1, Lcom/auth0/jwt/exceptions/SignatureGenerationException;

    invoke-direct {v1, p0, v0}, Lcom/auth0/jwt/exceptions/SignatureGenerationException;-><init>(Lcom/auth0/jwt/algorithms/Algorithm;Ljava/lang/Throwable;)V

    throw v1
.end method

.method validateSignatureStructure([BLjava/security/interfaces/ECPublicKey;)V
    .locals 13
    .param p1, "joseSignature"    # [B
    .param p2, "publicKey"    # Ljava/security/interfaces/ECPublicKey;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/security/SignatureException;
        }
    .end annotation

    .line 161
    array-length v0, p1

    iget v1, p0, Lcom/auth0/jwt/algorithms/ECDSAAlgorithm;->ecNumberSize:I

    mul-int/lit8 v1, v1, 0x2

    const-string v2, "Invalid JOSE signature format."

    if-ne v0, v1, :cond_6

    .line 165
    invoke-direct {p0, p1}, Lcom/auth0/jwt/algorithms/ECDSAAlgorithm;->isAllZeros([B)Z

    move-result v0

    const-string v1, "Invalid signature format."

    if-nez v0, :cond_5

    .line 170
    iget v0, p0, Lcom/auth0/jwt/algorithms/ECDSAAlgorithm;->ecNumberSize:I

    new-array v0, v0, [B

    .line 171
    .local v0, "rBytes":[B
    iget v3, p0, Lcom/auth0/jwt/algorithms/ECDSAAlgorithm;->ecNumberSize:I

    const/4 v4, 0x0

    invoke-static {p1, v4, v0, v4, v3}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 172
    invoke-direct {p0, v0}, Lcom/auth0/jwt/algorithms/ECDSAAlgorithm;->isAllZeros([B)Z

    move-result v3

    if-nez v3, :cond_4

    .line 177
    iget v3, p0, Lcom/auth0/jwt/algorithms/ECDSAAlgorithm;->ecNumberSize:I

    new-array v3, v3, [B

    .line 178
    .local v3, "sBytes":[B
    iget v5, p0, Lcom/auth0/jwt/algorithms/ECDSAAlgorithm;->ecNumberSize:I

    iget v6, p0, Lcom/auth0/jwt/algorithms/ECDSAAlgorithm;->ecNumberSize:I

    invoke-static {p1, v5, v3, v4, v6}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 179
    invoke-direct {p0, v3}, Lcom/auth0/jwt/algorithms/ECDSAAlgorithm;->isAllZeros([B)Z

    move-result v5

    if-nez v5, :cond_3

    .line 184
    iget v5, p0, Lcom/auth0/jwt/algorithms/ECDSAAlgorithm;->ecNumberSize:I

    invoke-direct {p0, p1, v4, v5}, Lcom/auth0/jwt/algorithms/ECDSAAlgorithm;->countPadding([BII)I

    move-result v4

    .line 185
    .local v4, "rPadding":I
    iget v5, p0, Lcom/auth0/jwt/algorithms/ECDSAAlgorithm;->ecNumberSize:I

    array-length v6, p1

    invoke-direct {p0, p1, v5, v6}, Lcom/auth0/jwt/algorithms/ECDSAAlgorithm;->countPadding([BII)I

    move-result v5

    .line 186
    .local v5, "sPadding":I
    iget v6, p0, Lcom/auth0/jwt/algorithms/ECDSAAlgorithm;->ecNumberSize:I

    sub-int/2addr v6, v4

    .line 187
    .local v6, "rLength":I
    iget v7, p0, Lcom/auth0/jwt/algorithms/ECDSAAlgorithm;->ecNumberSize:I

    sub-int/2addr v7, v5

    .line 189
    .local v7, "sLength":I
    add-int/lit8 v8, v6, 0x2

    add-int/lit8 v8, v8, 0x2

    add-int/2addr v8, v7

    .line 190
    .local v8, "length":I
    const/16 v9, 0xff

    if-gt v8, v9, :cond_2

    .line 194
    invoke-interface {p2}, Ljava/security/interfaces/ECPublicKey;->getParams()Ljava/security/spec/ECParameterSpec;

    move-result-object v2

    invoke-virtual {v2}, Ljava/security/spec/ECParameterSpec;->getOrder()Ljava/math/BigInteger;

    move-result-object v2

    .line 195
    .local v2, "order":Ljava/math/BigInteger;
    new-instance v9, Ljava/math/BigInteger;

    const/4 v10, 0x1

    invoke-direct {v9, v10, v0}, Ljava/math/BigInteger;-><init>(I[B)V

    .line 196
    .local v9, "r":Ljava/math/BigInteger;
    new-instance v11, Ljava/math/BigInteger;

    invoke-direct {v11, v10, v3}, Ljava/math/BigInteger;-><init>(I[B)V

    .line 199
    .local v11, "s":Ljava/math/BigInteger;
    invoke-virtual {v2, v9}, Ljava/math/BigInteger;->compareTo(Ljava/math/BigInteger;)I

    move-result v12

    if-lt v12, v10, :cond_1

    .line 203
    invoke-virtual {v2, v11}, Ljava/math/BigInteger;->compareTo(Ljava/math/BigInteger;)I

    move-result v12

    if-lt v12, v10, :cond_0

    .line 206
    return-void

    .line 204
    :cond_0
    new-instance v10, Ljava/security/SignatureException;

    invoke-direct {v10, v1}, Ljava/security/SignatureException;-><init>(Ljava/lang/String;)V

    throw v10

    .line 200
    :cond_1
    new-instance v10, Ljava/security/SignatureException;

    invoke-direct {v10, v1}, Ljava/security/SignatureException;-><init>(Ljava/lang/String;)V

    throw v10

    .line 191
    .end local v2    # "order":Ljava/math/BigInteger;
    .end local v9    # "r":Ljava/math/BigInteger;
    .end local v11    # "s":Ljava/math/BigInteger;
    :cond_2
    new-instance v1, Ljava/security/SignatureException;

    invoke-direct {v1, v2}, Ljava/security/SignatureException;-><init>(Ljava/lang/String;)V

    throw v1

    .line 180
    .end local v4    # "rPadding":I
    .end local v5    # "sPadding":I
    .end local v6    # "rLength":I
    .end local v7    # "sLength":I
    .end local v8    # "length":I
    :cond_3
    new-instance v2, Ljava/security/SignatureException;

    invoke-direct {v2, v1}, Ljava/security/SignatureException;-><init>(Ljava/lang/String;)V

    throw v2

    .line 173
    .end local v3    # "sBytes":[B
    :cond_4
    new-instance v2, Ljava/security/SignatureException;

    invoke-direct {v2, v1}, Ljava/security/SignatureException;-><init>(Ljava/lang/String;)V

    throw v2

    .line 166
    .end local v0    # "rBytes":[B
    :cond_5
    new-instance v0, Ljava/security/SignatureException;

    invoke-direct {v0, v1}, Ljava/security/SignatureException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 162
    :cond_6
    new-instance v0, Ljava/security/SignatureException;

    invoke-direct {v0, v2}, Ljava/security/SignatureException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public verify(Lcom/auth0/jwt/interfaces/DecodedJWT;)V
    .locals 8
    .param p1, "jwt"    # Lcom/auth0/jwt/interfaces/DecodedJWT;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/auth0/jwt/exceptions/SignatureVerificationException;
        }
    .end annotation

    .line 47
    :try_start_0
    invoke-static {}, Ljava/util/Base64;->getUrlDecoder()Ljava/util/Base64$Decoder;

    move-result-object v0

    invoke-interface {p1}, Lcom/auth0/jwt/interfaces/DecodedJWT;->getSignature()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/util/Base64$Decoder;->decode(Ljava/lang/String;)[B

    move-result-object v0

    .line 48
    .local v0, "signatureBytes":[B
    iget-object v1, p0, Lcom/auth0/jwt/algorithms/ECDSAAlgorithm;->keyProvider:Lcom/auth0/jwt/interfaces/ECDSAKeyProvider;

    invoke-interface {p1}, Lcom/auth0/jwt/interfaces/DecodedJWT;->getKeyId()Ljava/lang/String;

    move-result-object v2

    invoke-interface {v1, v2}, Lcom/auth0/jwt/interfaces/ECDSAKeyProvider;->getPublicKeyById(Ljava/lang/String;)Ljava/security/PublicKey;

    move-result-object v1

    check-cast v1, Ljava/security/interfaces/ECPublicKey;

    .line 49
    .local v1, "publicKey":Ljava/security/interfaces/ECPublicKey;
    if-eqz v1, :cond_1

    .line 52
    invoke-virtual {p0, v0, v1}, Lcom/auth0/jwt/algorithms/ECDSAAlgorithm;->validateSignatureStructure([BLjava/security/interfaces/ECPublicKey;)V

    .line 53
    iget-object v2, p0, Lcom/auth0/jwt/algorithms/ECDSAAlgorithm;->crypto:Lcom/auth0/jwt/algorithms/CryptoHelper;

    .line 54
    invoke-virtual {p0}, Lcom/auth0/jwt/algorithms/ECDSAAlgorithm;->getDescription()Ljava/lang/String;

    move-result-object v3

    invoke-interface {p1}, Lcom/auth0/jwt/interfaces/DecodedJWT;->getHeader()Ljava/lang/String;

    move-result-object v5

    invoke-interface {p1}, Lcom/auth0/jwt/interfaces/DecodedJWT;->getPayload()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {p0, v0}, Lcom/auth0/jwt/algorithms/ECDSAAlgorithm;->JOSEToDER([B)[B

    move-result-object v7

    .line 53
    move-object v4, v1

    invoke-virtual/range {v2 .. v7}, Lcom/auth0/jwt/algorithms/CryptoHelper;->verifySignatureFor(Ljava/lang/String;Ljava/security/PublicKey;Ljava/lang/String;Ljava/lang/String;[B)Z

    move-result v2

    .line 56
    .local v2, "valid":Z
    if-eqz v2, :cond_0

    .line 62
    .end local v0    # "signatureBytes":[B
    .end local v1    # "publicKey":Ljava/security/interfaces/ECPublicKey;
    .end local v2    # "valid":Z
    nop

    .line 63
    return-void

    .line 57
    .restart local v0    # "signatureBytes":[B
    .restart local v1    # "publicKey":Ljava/security/interfaces/ECPublicKey;
    .restart local v2    # "valid":Z
    :cond_0
    new-instance v3, Lcom/auth0/jwt/exceptions/SignatureVerificationException;

    invoke-direct {v3, p0}, Lcom/auth0/jwt/exceptions/SignatureVerificationException;-><init>(Lcom/auth0/jwt/algorithms/Algorithm;)V

    .end local p1    # "jwt":Lcom/auth0/jwt/interfaces/DecodedJWT;
    throw v3

    .line 50
    .end local v2    # "valid":Z
    .restart local p1    # "jwt":Lcom/auth0/jwt/interfaces/DecodedJWT;
    :cond_1
    new-instance v2, Ljava/lang/IllegalStateException;

    const-string v3, "The given Public Key is null."

    invoke-direct {v2, v3}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    .end local p1    # "jwt":Lcom/auth0/jwt/interfaces/DecodedJWT;
    throw v2
    :try_end_0
    .catch Ljava/security/NoSuchAlgorithmException; {:try_start_0 .. :try_end_0} :catch_4
    .catch Ljava/security/SignatureException; {:try_start_0 .. :try_end_0} :catch_3
    .catch Ljava/security/InvalidKeyException; {:try_start_0 .. :try_end_0} :catch_2
    .catch Ljava/lang/IllegalStateException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/IllegalArgumentException; {:try_start_0 .. :try_end_0} :catch_0

    .line 59
    .end local v0    # "signatureBytes":[B
    .end local v1    # "publicKey":Ljava/security/interfaces/ECPublicKey;
    .restart local p1    # "jwt":Lcom/auth0/jwt/interfaces/DecodedJWT;
    :catch_0
    move-exception v0

    goto :goto_0

    :catch_1
    move-exception v0

    goto :goto_0

    :catch_2
    move-exception v0

    goto :goto_0

    :catch_3
    move-exception v0

    goto :goto_0

    :catch_4
    move-exception v0

    .line 61
    .local v0, "e":Ljava/lang/Exception;
    :goto_0
    new-instance v1, Lcom/auth0/jwt/exceptions/SignatureVerificationException;

    invoke-direct {v1, p0, v0}, Lcom/auth0/jwt/exceptions/SignatureVerificationException;-><init>(Lcom/auth0/jwt/algorithms/Algorithm;Ljava/lang/Throwable;)V

    throw v1
.end method
