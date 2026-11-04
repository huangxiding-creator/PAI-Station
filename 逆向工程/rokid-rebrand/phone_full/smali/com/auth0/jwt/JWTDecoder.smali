.class final Lcom/auth0/jwt/JWTDecoder;
.super Ljava/lang/Object;
.source "JWTDecoder.java"

# interfaces
.implements Lcom/auth0/jwt/interfaces/DecodedJWT;
.implements Ljava/io/Serializable;


# static fields
.field private static final serialVersionUID:J = 0x19ff85363df075ffL


# instance fields
.field private final header:Lcom/auth0/jwt/interfaces/Header;

.field private final parts:[Ljava/lang/String;

.field private final payload:Lcom/auth0/jwt/interfaces/Payload;


# direct methods
.method constructor <init>(Lcom/auth0/jwt/impl/JWTParser;Ljava/lang/String;)V
    .locals 5
    .param p1, "converter"    # Lcom/auth0/jwt/impl/JWTParser;
    .param p2, "jwt"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/auth0/jwt/exceptions/JWTDecodeException;
        }
    .end annotation

    .line 36
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 37
    invoke-static {p2}, Lcom/auth0/jwt/TokenUtils;->splitToken(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/auth0/jwt/JWTDecoder;->parts:[Ljava/lang/String;

    .line 41
    :try_start_0
    new-instance v0, Ljava/lang/String;

    invoke-static {}, Ljava/util/Base64;->getUrlDecoder()Ljava/util/Base64$Decoder;

    move-result-object v1

    iget-object v2, p0, Lcom/auth0/jwt/JWTDecoder;->parts:[Ljava/lang/String;

    const/4 v3, 0x0

    aget-object v2, v2, v3

    invoke-virtual {v1, v2}, Ljava/util/Base64$Decoder;->decode(Ljava/lang/String;)[B

    move-result-object v1

    sget-object v2, Ljava/nio/charset/StandardCharsets;->UTF_8:Ljava/nio/charset/Charset;

    invoke-direct {v0, v1, v2}, Ljava/lang/String;-><init>([BLjava/nio/charset/Charset;)V

    .line 42
    .local v0, "headerJson":Ljava/lang/String;
    new-instance v1, Ljava/lang/String;

    invoke-static {}, Ljava/util/Base64;->getUrlDecoder()Ljava/util/Base64$Decoder;

    move-result-object v2

    iget-object v3, p0, Lcom/auth0/jwt/JWTDecoder;->parts:[Ljava/lang/String;

    const/4 v4, 0x1

    aget-object v3, v3, v4

    invoke-virtual {v2, v3}, Ljava/util/Base64$Decoder;->decode(Ljava/lang/String;)[B

    move-result-object v2

    sget-object v3, Ljava/nio/charset/StandardCharsets;->UTF_8:Ljava/nio/charset/Charset;

    invoke-direct {v1, v2, v3}, Ljava/lang/String;-><init>([BLjava/nio/charset/Charset;)V
    :try_end_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/IllegalArgumentException; {:try_start_0 .. :try_end_0} :catch_0

    .line 47
    .local v1, "payloadJson":Ljava/lang/String;
    nop

    .line 48
    invoke-virtual {p1, v0}, Lcom/auth0/jwt/impl/JWTParser;->parseHeader(Ljava/lang/String;)Lcom/auth0/jwt/interfaces/Header;

    move-result-object v2

    iput-object v2, p0, Lcom/auth0/jwt/JWTDecoder;->header:Lcom/auth0/jwt/interfaces/Header;

    .line 49
    invoke-virtual {p1, v1}, Lcom/auth0/jwt/impl/JWTParser;->parsePayload(Ljava/lang/String;)Lcom/auth0/jwt/interfaces/Payload;

    move-result-object v2

    iput-object v2, p0, Lcom/auth0/jwt/JWTDecoder;->payload:Lcom/auth0/jwt/interfaces/Payload;

    .line 50
    return-void

    .line 45
    .end local v0    # "headerJson":Ljava/lang/String;
    .end local v1    # "payloadJson":Ljava/lang/String;
    :catch_0
    move-exception v0

    .line 46
    .local v0, "e":Ljava/lang/IllegalArgumentException;
    new-instance v1, Lcom/auth0/jwt/exceptions/JWTDecodeException;

    const-string v2, "The input is not a valid base 64 encoded string."

    invoke-direct {v1, v2, v0}, Lcom/auth0/jwt/exceptions/JWTDecodeException;-><init>(Ljava/lang/String;Ljava/lang/Throwable;)V

    throw v1

    .line 43
    .end local v0    # "e":Ljava/lang/IllegalArgumentException;
    :catch_1
    move-exception v0

    .line 44
    .local v0, "e":Ljava/lang/NullPointerException;
    new-instance v1, Lcom/auth0/jwt/exceptions/JWTDecodeException;

    const-string v2, "The UTF-8 Charset isn\'t initialized."

    invoke-direct {v1, v2, v0}, Lcom/auth0/jwt/exceptions/JWTDecodeException;-><init>(Ljava/lang/String;Ljava/lang/Throwable;)V

    throw v1
.end method

.method constructor <init>(Ljava/lang/String;)V
    .locals 1
    .param p1, "jwt"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/auth0/jwt/exceptions/JWTDecodeException;
        }
    .end annotation

    .line 33
    new-instance v0, Lcom/auth0/jwt/impl/JWTParser;

    invoke-direct {v0}, Lcom/auth0/jwt/impl/JWTParser;-><init>()V

    invoke-direct {p0, v0, p1}, Lcom/auth0/jwt/JWTDecoder;-><init>(Lcom/auth0/jwt/impl/JWTParser;Ljava/lang/String;)V

    .line 34
    return-void
.end method


# virtual methods
.method public getAlgorithm()Ljava/lang/String;
    .locals 1

    .line 54
    iget-object v0, p0, Lcom/auth0/jwt/JWTDecoder;->header:Lcom/auth0/jwt/interfaces/Header;

    invoke-interface {v0}, Lcom/auth0/jwt/interfaces/Header;->getAlgorithm()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getAudience()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .line 89
    iget-object v0, p0, Lcom/auth0/jwt/JWTDecoder;->payload:Lcom/auth0/jwt/interfaces/Payload;

    invoke-interface {v0}, Lcom/auth0/jwt/interfaces/Payload;->getAudience()Ljava/util/List;

    move-result-object v0

    return-object v0
.end method

.method public getClaim(Ljava/lang/String;)Lcom/auth0/jwt/interfaces/Claim;
    .locals 1
    .param p1, "name"    # Ljava/lang/String;

    .line 129
    iget-object v0, p0, Lcom/auth0/jwt/JWTDecoder;->payload:Lcom/auth0/jwt/interfaces/Payload;

    invoke-interface {v0, p1}, Lcom/auth0/jwt/interfaces/Payload;->getClaim(Ljava/lang/String;)Lcom/auth0/jwt/interfaces/Claim;

    move-result-object v0

    return-object v0
.end method

.method public getClaims()Ljava/util/Map;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Lcom/auth0/jwt/interfaces/Claim;",
            ">;"
        }
    .end annotation

    .line 134
    iget-object v0, p0, Lcom/auth0/jwt/JWTDecoder;->payload:Lcom/auth0/jwt/interfaces/Payload;

    invoke-interface {v0}, Lcom/auth0/jwt/interfaces/Payload;->getClaims()Ljava/util/Map;

    move-result-object v0

    return-object v0
.end method

.method public getContentType()Ljava/lang/String;
    .locals 1

    .line 64
    iget-object v0, p0, Lcom/auth0/jwt/JWTDecoder;->header:Lcom/auth0/jwt/interfaces/Header;

    invoke-interface {v0}, Lcom/auth0/jwt/interfaces/Header;->getContentType()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getExpiresAt()Ljava/util/Date;
    .locals 1

    .line 94
    iget-object v0, p0, Lcom/auth0/jwt/JWTDecoder;->payload:Lcom/auth0/jwt/interfaces/Payload;

    invoke-interface {v0}, Lcom/auth0/jwt/interfaces/Payload;->getExpiresAt()Ljava/util/Date;

    move-result-object v0

    return-object v0
.end method

.method public getExpiresAtAsInstant()Ljava/time/Instant;
    .locals 1

    .line 99
    iget-object v0, p0, Lcom/auth0/jwt/JWTDecoder;->payload:Lcom/auth0/jwt/interfaces/Payload;

    invoke-interface {v0}, Lcom/auth0/jwt/interfaces/Payload;->getExpiresAtAsInstant()Ljava/time/Instant;

    move-result-object v0

    return-object v0
.end method

.method public getHeader()Ljava/lang/String;
    .locals 2

    .line 139
    iget-object v0, p0, Lcom/auth0/jwt/JWTDecoder;->parts:[Ljava/lang/String;

    const/4 v1, 0x0

    aget-object v0, v0, v1

    return-object v0
.end method

.method public getHeaderClaim(Ljava/lang/String;)Lcom/auth0/jwt/interfaces/Claim;
    .locals 1
    .param p1, "name"    # Ljava/lang/String;

    .line 74
    iget-object v0, p0, Lcom/auth0/jwt/JWTDecoder;->header:Lcom/auth0/jwt/interfaces/Header;

    invoke-interface {v0, p1}, Lcom/auth0/jwt/interfaces/Header;->getHeaderClaim(Ljava/lang/String;)Lcom/auth0/jwt/interfaces/Claim;

    move-result-object v0

    return-object v0
.end method

.method public getId()Ljava/lang/String;
    .locals 1

    .line 124
    iget-object v0, p0, Lcom/auth0/jwt/JWTDecoder;->payload:Lcom/auth0/jwt/interfaces/Payload;

    invoke-interface {v0}, Lcom/auth0/jwt/interfaces/Payload;->getId()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getIssuedAt()Ljava/util/Date;
    .locals 1

    .line 114
    iget-object v0, p0, Lcom/auth0/jwt/JWTDecoder;->payload:Lcom/auth0/jwt/interfaces/Payload;

    invoke-interface {v0}, Lcom/auth0/jwt/interfaces/Payload;->getIssuedAt()Ljava/util/Date;

    move-result-object v0

    return-object v0
.end method

.method public getIssuedAtAsInstant()Ljava/time/Instant;
    .locals 1

    .line 119
    iget-object v0, p0, Lcom/auth0/jwt/JWTDecoder;->payload:Lcom/auth0/jwt/interfaces/Payload;

    invoke-interface {v0}, Lcom/auth0/jwt/interfaces/Payload;->getIssuedAtAsInstant()Ljava/time/Instant;

    move-result-object v0

    return-object v0
.end method

.method public getIssuer()Ljava/lang/String;
    .locals 1

    .line 79
    iget-object v0, p0, Lcom/auth0/jwt/JWTDecoder;->payload:Lcom/auth0/jwt/interfaces/Payload;

    invoke-interface {v0}, Lcom/auth0/jwt/interfaces/Payload;->getIssuer()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getKeyId()Ljava/lang/String;
    .locals 1

    .line 69
    iget-object v0, p0, Lcom/auth0/jwt/JWTDecoder;->header:Lcom/auth0/jwt/interfaces/Header;

    invoke-interface {v0}, Lcom/auth0/jwt/interfaces/Header;->getKeyId()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getNotBefore()Ljava/util/Date;
    .locals 1

    .line 104
    iget-object v0, p0, Lcom/auth0/jwt/JWTDecoder;->payload:Lcom/auth0/jwt/interfaces/Payload;

    invoke-interface {v0}, Lcom/auth0/jwt/interfaces/Payload;->getNotBefore()Ljava/util/Date;

    move-result-object v0

    return-object v0
.end method

.method public getNotBeforeAsInstant()Ljava/time/Instant;
    .locals 1

    .line 109
    iget-object v0, p0, Lcom/auth0/jwt/JWTDecoder;->payload:Lcom/auth0/jwt/interfaces/Payload;

    invoke-interface {v0}, Lcom/auth0/jwt/interfaces/Payload;->getNotBeforeAsInstant()Ljava/time/Instant;

    move-result-object v0

    return-object v0
.end method

.method public getPayload()Ljava/lang/String;
    .locals 2

    .line 144
    iget-object v0, p0, Lcom/auth0/jwt/JWTDecoder;->parts:[Ljava/lang/String;

    const/4 v1, 0x1

    aget-object v0, v0, v1

    return-object v0
.end method

.method public getSignature()Ljava/lang/String;
    .locals 2

    .line 149
    iget-object v0, p0, Lcom/auth0/jwt/JWTDecoder;->parts:[Ljava/lang/String;

    const/4 v1, 0x2

    aget-object v0, v0, v1

    return-object v0
.end method

.method public getSubject()Ljava/lang/String;
    .locals 1

    .line 84
    iget-object v0, p0, Lcom/auth0/jwt/JWTDecoder;->payload:Lcom/auth0/jwt/interfaces/Payload;

    invoke-interface {v0}, Lcom/auth0/jwt/interfaces/Payload;->getSubject()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getToken()Ljava/lang/String;
    .locals 4

    .line 154
    iget-object v0, p0, Lcom/auth0/jwt/JWTDecoder;->parts:[Ljava/lang/String;

    const/4 v1, 0x0

    aget-object v0, v0, v1

    iget-object v1, p0, Lcom/auth0/jwt/JWTDecoder;->parts:[Ljava/lang/String;

    const/4 v2, 0x1

    aget-object v1, v1, v2

    iget-object v2, p0, Lcom/auth0/jwt/JWTDecoder;->parts:[Ljava/lang/String;

    const/4 v3, 0x2

    aget-object v2, v2, v3

    filled-new-array {v0, v1, v2}, [Ljava/lang/Object;

    move-result-object v0

    const-string v1, "%s.%s.%s"

    invoke-static {v1, v0}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getType()Ljava/lang/String;
    .locals 1

    .line 59
    iget-object v0, p0, Lcom/auth0/jwt/JWTDecoder;->header:Lcom/auth0/jwt/interfaces/Header;

    invoke-interface {v0}, Lcom/auth0/jwt/interfaces/Header;->getType()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
