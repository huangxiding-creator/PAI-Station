.class public Lcom/auth0/jwt/JWT;
.super Ljava/lang/Object;
.source "JWT.java"


# instance fields
.field private final parser:Lcom/auth0/jwt/impl/JWTParser;


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 21
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 22
    new-instance v0, Lcom/auth0/jwt/impl/JWTParser;

    invoke-direct {v0}, Lcom/auth0/jwt/impl/JWTParser;-><init>()V

    iput-object v0, p0, Lcom/auth0/jwt/JWT;->parser:Lcom/auth0/jwt/impl/JWTParser;

    .line 23
    return-void
.end method

.method public static create()Lcom/auth0/jwt/JWTCreator$Builder;
    .locals 1

    .line 72
    invoke-static {}, Lcom/auth0/jwt/JWTCreator;->init()Lcom/auth0/jwt/JWTCreator$Builder;

    move-result-object v0

    return-object v0
.end method

.method public static decode(Ljava/lang/String;)Lcom/auth0/jwt/interfaces/DecodedJWT;
    .locals 1
    .param p0, "token"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/auth0/jwt/exceptions/JWTDecodeException;
        }
    .end annotation

    .line 52
    new-instance v0, Lcom/auth0/jwt/JWTDecoder;

    invoke-direct {v0, p0}, Lcom/auth0/jwt/JWTDecoder;-><init>(Ljava/lang/String;)V

    return-object v0
.end method

.method public static require(Lcom/auth0/jwt/algorithms/Algorithm;)Lcom/auth0/jwt/interfaces/Verification;
    .locals 1
    .param p0, "algorithm"    # Lcom/auth0/jwt/algorithms/Algorithm;

    .line 63
    invoke-static {p0}, Lcom/auth0/jwt/JWTVerifier;->init(Lcom/auth0/jwt/algorithms/Algorithm;)Lcom/auth0/jwt/interfaces/Verification;

    move-result-object v0

    return-object v0
.end method


# virtual methods
.method public decodeJwt(Ljava/lang/String;)Lcom/auth0/jwt/interfaces/DecodedJWT;
    .locals 2
    .param p1, "token"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/auth0/jwt/exceptions/JWTDecodeException;
        }
    .end annotation

    .line 37
    new-instance v0, Lcom/auth0/jwt/JWTDecoder;

    iget-object v1, p0, Lcom/auth0/jwt/JWT;->parser:Lcom/auth0/jwt/impl/JWTParser;

    invoke-direct {v0, v1, p1}, Lcom/auth0/jwt/JWTDecoder;-><init>(Lcom/auth0/jwt/impl/JWTParser;Ljava/lang/String;)V

    return-object v0
.end method
