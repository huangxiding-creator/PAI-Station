.class Lcom/auth0/jwt/algorithms/HMACAlgorithm;
.super Lcom/auth0/jwt/algorithms/Algorithm;
.source "HMACAlgorithm.java"


# instance fields
.field private final crypto:Lcom/auth0/jwt/algorithms/CryptoHelper;

.field private final secret:[B


# direct methods
.method constructor <init>(Lcom/auth0/jwt/algorithms/CryptoHelper;Ljava/lang/String;Ljava/lang/String;[B)V
    .locals 2
    .param p1, "crypto"    # Lcom/auth0/jwt/algorithms/CryptoHelper;
    .param p2, "id"    # Ljava/lang/String;
    .param p3, "algorithm"    # Ljava/lang/String;
    .param p4, "secretBytes"    # [B
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/IllegalArgumentException;
        }
    .end annotation

    .line 26
    invoke-direct {p0, p2, p3}, Lcom/auth0/jwt/algorithms/Algorithm;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    .line 27
    if-eqz p4, :cond_0

    .line 30
    array-length v0, p4

    invoke-static {p4, v0}, Ljava/util/Arrays;->copyOf([BI)[B

    move-result-object v0

    iput-object v0, p0, Lcom/auth0/jwt/algorithms/HMACAlgorithm;->secret:[B

    .line 31
    iput-object p1, p0, Lcom/auth0/jwt/algorithms/HMACAlgorithm;->crypto:Lcom/auth0/jwt/algorithms/CryptoHelper;

    .line 32
    return-void

    .line 28
    :cond_0
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "The Secret cannot be null"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method constructor <init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 2
    .param p1, "id"    # Ljava/lang/String;
    .param p2, "algorithm"    # Ljava/lang/String;
    .param p3, "secret"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/IllegalArgumentException;
        }
    .end annotation

    .line 39
    new-instance v0, Lcom/auth0/jwt/algorithms/CryptoHelper;

    invoke-direct {v0}, Lcom/auth0/jwt/algorithms/CryptoHelper;-><init>()V

    invoke-static {p3}, Lcom/auth0/jwt/algorithms/HMACAlgorithm;->getSecretBytes(Ljava/lang/String;)[B

    move-result-object v1

    invoke-direct {p0, v0, p1, p2, v1}, Lcom/auth0/jwt/algorithms/HMACAlgorithm;-><init>(Lcom/auth0/jwt/algorithms/CryptoHelper;Ljava/lang/String;Ljava/lang/String;[B)V

    .line 40
    return-void
.end method

.method constructor <init>(Ljava/lang/String;Ljava/lang/String;[B)V
    .locals 1
    .param p1, "id"    # Ljava/lang/String;
    .param p2, "algorithm"    # Ljava/lang/String;
    .param p3, "secretBytes"    # [B
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/IllegalArgumentException;
        }
    .end annotation

    .line 35
    new-instance v0, Lcom/auth0/jwt/algorithms/CryptoHelper;

    invoke-direct {v0}, Lcom/auth0/jwt/algorithms/CryptoHelper;-><init>()V

    invoke-direct {p0, v0, p1, p2, p3}, Lcom/auth0/jwt/algorithms/HMACAlgorithm;-><init>(Lcom/auth0/jwt/algorithms/CryptoHelper;Ljava/lang/String;Ljava/lang/String;[B)V

    .line 36
    return-void
.end method

.method static getSecretBytes(Ljava/lang/String;)[B
    .locals 2
    .param p0, "secret"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/IllegalArgumentException;
        }
    .end annotation

    .line 44
    if-eqz p0, :cond_0

    .line 47
    sget-object v0, Ljava/nio/charset/StandardCharsets;->UTF_8:Ljava/nio/charset/Charset;

    invoke-virtual {p0, v0}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B

    move-result-object v0

    return-object v0

    .line 45
    :cond_0
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "The Secret cannot be null"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method


# virtual methods
.method public sign([B)[B
    .locals 3
    .param p1, "contentBytes"    # [B
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/auth0/jwt/exceptions/SignatureGenerationException;
        }
    .end annotation

    .line 76
    :try_start_0
    iget-object v0, p0, Lcom/auth0/jwt/algorithms/HMACAlgorithm;->crypto:Lcom/auth0/jwt/algorithms/CryptoHelper;

    invoke-virtual {p0}, Lcom/auth0/jwt/algorithms/HMACAlgorithm;->getDescription()Ljava/lang/String;

    move-result-object v1

    iget-object v2, p0, Lcom/auth0/jwt/algorithms/HMACAlgorithm;->secret:[B

    invoke-virtual {v0, v1, v2, p1}, Lcom/auth0/jwt/algorithms/CryptoHelper;->createSignatureFor(Ljava/lang/String;[B[B)[B

    move-result-object v0
    :try_end_0
    .catch Ljava/security/NoSuchAlgorithmException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/security/InvalidKeyException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    .line 77
    :catch_0
    move-exception v0

    goto :goto_0

    :catch_1
    move-exception v0

    .line 78
    .local v0, "e":Ljava/security/GeneralSecurityException;
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

    .line 67
    :try_start_0
    iget-object v0, p0, Lcom/auth0/jwt/algorithms/HMACAlgorithm;->crypto:Lcom/auth0/jwt/algorithms/CryptoHelper;

    invoke-virtual {p0}, Lcom/auth0/jwt/algorithms/HMACAlgorithm;->getDescription()Ljava/lang/String;

    move-result-object v1

    iget-object v2, p0, Lcom/auth0/jwt/algorithms/HMACAlgorithm;->secret:[B

    invoke-virtual {v0, v1, v2, p1, p2}, Lcom/auth0/jwt/algorithms/CryptoHelper;->createSignatureFor(Ljava/lang/String;[B[B[B)[B

    move-result-object v0
    :try_end_0
    .catch Ljava/security/NoSuchAlgorithmException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/security/InvalidKeyException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    .line 68
    :catch_0
    move-exception v0

    goto :goto_0

    :catch_1
    move-exception v0

    .line 69
    .local v0, "e":Ljava/security/GeneralSecurityException;
    :goto_0
    new-instance v1, Lcom/auth0/jwt/exceptions/SignatureGenerationException;

    invoke-direct {v1, p0, v0}, Lcom/auth0/jwt/exceptions/SignatureGenerationException;-><init>(Lcom/auth0/jwt/algorithms/Algorithm;Ljava/lang/Throwable;)V

    throw v1
.end method

.method public verify(Lcom/auth0/jwt/interfaces/DecodedJWT;)V
    .locals 8
    .param p1, "jwt"    # Lcom/auth0/jwt/interfaces/DecodedJWT;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/auth0/jwt/exceptions/SignatureVerificationException;
        }
    .end annotation

    .line 53
    :try_start_0
    invoke-static {}, Ljava/util/Base64;->getUrlDecoder()Ljava/util/Base64$Decoder;

    move-result-object v0

    invoke-interface {p1}, Lcom/auth0/jwt/interfaces/DecodedJWT;->getSignature()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/util/Base64$Decoder;->decode(Ljava/lang/String;)[B

    move-result-object v7

    .line 54
    .local v7, "signatureBytes":[B
    iget-object v2, p0, Lcom/auth0/jwt/algorithms/HMACAlgorithm;->crypto:Lcom/auth0/jwt/algorithms/CryptoHelper;

    .line 55
    invoke-virtual {p0}, Lcom/auth0/jwt/algorithms/HMACAlgorithm;->getDescription()Ljava/lang/String;

    move-result-object v3

    iget-object v4, p0, Lcom/auth0/jwt/algorithms/HMACAlgorithm;->secret:[B

    invoke-interface {p1}, Lcom/auth0/jwt/interfaces/DecodedJWT;->getHeader()Ljava/lang/String;

    move-result-object v5

    invoke-interface {p1}, Lcom/auth0/jwt/interfaces/DecodedJWT;->getPayload()Ljava/lang/String;

    move-result-object v6

    .line 54
    invoke-virtual/range {v2 .. v7}, Lcom/auth0/jwt/algorithms/CryptoHelper;->verifySignatureFor(Ljava/lang/String;[BLjava/lang/String;Ljava/lang/String;[B)Z

    move-result v0

    .line 56
    .local v0, "valid":Z
    if-eqz v0, :cond_0

    .line 61
    .end local v0    # "valid":Z
    .end local v7    # "signatureBytes":[B
    nop

    .line 62
    return-void

    .line 57
    .restart local v0    # "valid":Z
    .restart local v7    # "signatureBytes":[B
    :cond_0
    new-instance v1, Lcom/auth0/jwt/exceptions/SignatureVerificationException;

    invoke-direct {v1, p0}, Lcom/auth0/jwt/exceptions/SignatureVerificationException;-><init>(Lcom/auth0/jwt/algorithms/Algorithm;)V

    .end local p1    # "jwt":Lcom/auth0/jwt/interfaces/DecodedJWT;
    throw v1
    :try_end_0
    .catch Ljava/lang/IllegalStateException; {:try_start_0 .. :try_end_0} :catch_3
    .catch Ljava/security/InvalidKeyException; {:try_start_0 .. :try_end_0} :catch_2
    .catch Ljava/security/NoSuchAlgorithmException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/IllegalArgumentException; {:try_start_0 .. :try_end_0} :catch_0

    .line 59
    .end local v0    # "valid":Z
    .end local v7    # "signatureBytes":[B
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

    .line 60
    .local v0, "e":Ljava/lang/Exception;
    :goto_0
    new-instance v1, Lcom/auth0/jwt/exceptions/SignatureVerificationException;

    invoke-direct {v1, p0, v0}, Lcom/auth0/jwt/exceptions/SignatureVerificationException;-><init>(Lcom/auth0/jwt/algorithms/Algorithm;Ljava/lang/Throwable;)V

    throw v1
.end method
