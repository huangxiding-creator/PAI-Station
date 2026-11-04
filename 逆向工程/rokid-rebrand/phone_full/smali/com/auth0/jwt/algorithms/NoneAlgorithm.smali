.class Lcom/auth0/jwt/algorithms/NoneAlgorithm;
.super Lcom/auth0/jwt/algorithms/Algorithm;
.source "NoneAlgorithm.java"


# direct methods
.method constructor <init>()V
    .locals 1

    .line 11
    const-string v0, "none"

    invoke-direct {p0, v0, v0}, Lcom/auth0/jwt/algorithms/Algorithm;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    .line 12
    return-void
.end method


# virtual methods
.method public sign([B)[B
    .locals 1
    .param p1, "contentBytes"    # [B
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/auth0/jwt/exceptions/SignatureGenerationException;
        }
    .end annotation

    .line 34
    const/4 v0, 0x0

    new-array v0, v0, [B

    return-object v0
.end method

.method public sign([B[B)[B
    .locals 1
    .param p1, "headerBytes"    # [B
    .param p2, "payloadBytes"    # [B
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/auth0/jwt/exceptions/SignatureGenerationException;
        }
    .end annotation

    .line 29
    const/4 v0, 0x0

    new-array v0, v0, [B

    return-object v0
.end method

.method public verify(Lcom/auth0/jwt/interfaces/DecodedJWT;)V
    .locals 2
    .param p1, "jwt"    # Lcom/auth0/jwt/interfaces/DecodedJWT;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/auth0/jwt/exceptions/SignatureVerificationException;
        }
    .end annotation

    .line 17
    :try_start_0
    invoke-static {}, Ljava/util/Base64;->getUrlDecoder()Ljava/util/Base64$Decoder;

    move-result-object v0

    invoke-interface {p1}, Lcom/auth0/jwt/interfaces/DecodedJWT;->getSignature()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/util/Base64$Decoder;->decode(Ljava/lang/String;)[B

    move-result-object v0

    .line 19
    .local v0, "signatureBytes":[B
    array-length v1, v0

    if-gtz v1, :cond_0

    .line 24
    .end local v0    # "signatureBytes":[B
    nop

    .line 25
    return-void

    .line 20
    .restart local v0    # "signatureBytes":[B
    :cond_0
    new-instance v1, Lcom/auth0/jwt/exceptions/SignatureVerificationException;

    invoke-direct {v1, p0}, Lcom/auth0/jwt/exceptions/SignatureVerificationException;-><init>(Lcom/auth0/jwt/algorithms/Algorithm;)V

    .end local p1    # "jwt":Lcom/auth0/jwt/interfaces/DecodedJWT;
    throw v1
    :try_end_0
    .catch Ljava/lang/IllegalArgumentException; {:try_start_0 .. :try_end_0} :catch_0

    .line 22
    .end local v0    # "signatureBytes":[B
    .restart local p1    # "jwt":Lcom/auth0/jwt/interfaces/DecodedJWT;
    :catch_0
    move-exception v0

    .line 23
    .local v0, "e":Ljava/lang/IllegalArgumentException;
    new-instance v1, Lcom/auth0/jwt/exceptions/SignatureVerificationException;

    invoke-direct {v1, p0, v0}, Lcom/auth0/jwt/exceptions/SignatureVerificationException;-><init>(Lcom/auth0/jwt/algorithms/Algorithm;Ljava/lang/Throwable;)V

    throw v1
.end method
