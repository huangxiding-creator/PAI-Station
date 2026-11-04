.class public final Lcom/auth0/jwt/JWTVerifier;
.super Ljava/lang/Object;
.source "JWTVerifier.java"

# interfaces
.implements Lcom/auth0/jwt/interfaces/JWTVerifier;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/auth0/jwt/JWTVerifier$BaseVerification;
    }
.end annotation


# instance fields
.field private final algorithm:Lcom/auth0/jwt/algorithms/Algorithm;

.field final expectedChecks:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lcom/auth0/jwt/impl/ExpectedCheckHolder;",
            ">;"
        }
    .end annotation
.end field

.field private final parser:Lcom/auth0/jwt/impl/JWTParser;


# direct methods
.method constructor <init>(Lcom/auth0/jwt/algorithms/Algorithm;Ljava/util/List;)V
    .locals 1
    .param p1, "algorithm"    # Lcom/auth0/jwt/algorithms/Algorithm;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/auth0/jwt/algorithms/Algorithm;",
            "Ljava/util/List<",
            "Lcom/auth0/jwt/impl/ExpectedCheckHolder;",
            ">;)V"
        }
    .end annotation

    .line 31
    .local p2, "expectedChecks":Ljava/util/List;, "Ljava/util/List<Lcom/auth0/jwt/impl/ExpectedCheckHolder;>;"
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 32
    iput-object p1, p0, Lcom/auth0/jwt/JWTVerifier;->algorithm:Lcom/auth0/jwt/algorithms/Algorithm;

    .line 33
    invoke-static {p2}, Ljava/util/Collections;->unmodifiableList(Ljava/util/List;)Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lcom/auth0/jwt/JWTVerifier;->expectedChecks:Ljava/util/List;

    .line 34
    new-instance v0, Lcom/auth0/jwt/impl/JWTParser;

    invoke-direct {v0}, Lcom/auth0/jwt/impl/JWTParser;-><init>()V

    iput-object v0, p0, Lcom/auth0/jwt/JWTVerifier;->parser:Lcom/auth0/jwt/impl/JWTParser;

    .line 35
    return-void
.end method

.method static init(Lcom/auth0/jwt/algorithms/Algorithm;)Lcom/auth0/jwt/interfaces/Verification;
    .locals 1
    .param p0, "algorithm"    # Lcom/auth0/jwt/algorithms/Algorithm;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/IllegalArgumentException;
        }
    .end annotation

    .line 45
    new-instance v0, Lcom/auth0/jwt/JWTVerifier$BaseVerification;

    invoke-direct {v0, p0}, Lcom/auth0/jwt/JWTVerifier$BaseVerification;-><init>(Lcom/auth0/jwt/algorithms/Algorithm;)V

    return-object v0
.end method

.method private verifyAlgorithm(Lcom/auth0/jwt/interfaces/DecodedJWT;Lcom/auth0/jwt/algorithms/Algorithm;)V
    .locals 2
    .param p1, "jwt"    # Lcom/auth0/jwt/interfaces/DecodedJWT;
    .param p2, "expectedAlgorithm"    # Lcom/auth0/jwt/algorithms/Algorithm;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/auth0/jwt/exceptions/AlgorithmMismatchException;
        }
    .end annotation

    .line 469
    invoke-virtual {p2}, Lcom/auth0/jwt/algorithms/Algorithm;->getName()Ljava/lang/String;

    move-result-object v0

    invoke-interface {p1}, Lcom/auth0/jwt/interfaces/DecodedJWT;->getAlgorithm()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 473
    return-void

    .line 470
    :cond_0
    new-instance v0, Lcom/auth0/jwt/exceptions/AlgorithmMismatchException;

    const-string v1, "The provided Algorithm doesn\'t match the one defined in the JWT\'s Header."

    invoke-direct {v0, v1}, Lcom/auth0/jwt/exceptions/AlgorithmMismatchException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method private verifyClaims(Lcom/auth0/jwt/interfaces/DecodedJWT;Ljava/util/List;)V
    .locals 7
    .param p1, "jwt"    # Lcom/auth0/jwt/interfaces/DecodedJWT;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/auth0/jwt/interfaces/DecodedJWT;",
            "Ljava/util/List<",
            "Lcom/auth0/jwt/impl/ExpectedCheckHolder;",
            ">;)V"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/auth0/jwt/exceptions/TokenExpiredException;,
            Lcom/auth0/jwt/exceptions/InvalidClaimException;
        }
    .end annotation

    .line 477
    .local p2, "expectedChecks":Ljava/util/List;, "Ljava/util/List<Lcom/auth0/jwt/impl/ExpectedCheckHolder;>;"
    invoke-interface {p2}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/auth0/jwt/impl/ExpectedCheckHolder;

    .line 479
    .local v1, "expectedCheck":Lcom/auth0/jwt/impl/ExpectedCheckHolder;
    invoke-interface {v1}, Lcom/auth0/jwt/impl/ExpectedCheckHolder;->getClaimName()Ljava/lang/String;

    move-result-object v2

    .line 480
    .local v2, "claimName":Ljava/lang/String;
    invoke-interface {p1, v2}, Lcom/auth0/jwt/interfaces/DecodedJWT;->getClaim(Ljava/lang/String;)Lcom/auth0/jwt/interfaces/Claim;

    move-result-object v3

    .line 482
    .local v3, "claim":Lcom/auth0/jwt/interfaces/Claim;
    invoke-interface {v1, v3, p1}, Lcom/auth0/jwt/impl/ExpectedCheckHolder;->verify(Lcom/auth0/jwt/interfaces/Claim;Lcom/auth0/jwt/interfaces/DecodedJWT;)Z

    move-result v4

    .line 484
    .local v4, "isValid":Z
    if-eqz v4, :cond_0

    .line 491
    .end local v1    # "expectedCheck":Lcom/auth0/jwt/impl/ExpectedCheckHolder;
    .end local v2    # "claimName":Ljava/lang/String;
    .end local v3    # "claim":Lcom/auth0/jwt/interfaces/Claim;
    .end local v4    # "isValid":Z
    goto :goto_0

    .line 485
    .restart local v1    # "expectedCheck":Lcom/auth0/jwt/impl/ExpectedCheckHolder;
    .restart local v2    # "claimName":Ljava/lang/String;
    .restart local v3    # "claim":Lcom/auth0/jwt/interfaces/Claim;
    .restart local v4    # "isValid":Z
    :cond_0
    new-instance v0, Lcom/auth0/jwt/exceptions/IncorrectClaimException;

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v5

    .line 486
    const-string v6, "The Claim \'%s\' value doesn\'t match the required one."

    invoke-static {v6, v5}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v5

    invoke-direct {v0, v5, v2, v3}, Lcom/auth0/jwt/exceptions/IncorrectClaimException;-><init>(Ljava/lang/String;Ljava/lang/String;Lcom/auth0/jwt/interfaces/Claim;)V

    throw v0

    .line 492
    .end local v1    # "expectedCheck":Lcom/auth0/jwt/impl/ExpectedCheckHolder;
    .end local v2    # "claimName":Ljava/lang/String;
    .end local v3    # "claim":Lcom/auth0/jwt/interfaces/Claim;
    .end local v4    # "isValid":Z
    :cond_1
    return-void
.end method


# virtual methods
.method public verify(Lcom/auth0/jwt/interfaces/DecodedJWT;)Lcom/auth0/jwt/interfaces/DecodedJWT;
    .locals 1
    .param p1, "jwt"    # Lcom/auth0/jwt/interfaces/DecodedJWT;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/auth0/jwt/exceptions/JWTVerificationException;
        }
    .end annotation

    .line 462
    iget-object v0, p0, Lcom/auth0/jwt/JWTVerifier;->algorithm:Lcom/auth0/jwt/algorithms/Algorithm;

    invoke-direct {p0, p1, v0}, Lcom/auth0/jwt/JWTVerifier;->verifyAlgorithm(Lcom/auth0/jwt/interfaces/DecodedJWT;Lcom/auth0/jwt/algorithms/Algorithm;)V

    .line 463
    iget-object v0, p0, Lcom/auth0/jwt/JWTVerifier;->algorithm:Lcom/auth0/jwt/algorithms/Algorithm;

    invoke-virtual {v0, p1}, Lcom/auth0/jwt/algorithms/Algorithm;->verify(Lcom/auth0/jwt/interfaces/DecodedJWT;)V

    .line 464
    iget-object v0, p0, Lcom/auth0/jwt/JWTVerifier;->expectedChecks:Ljava/util/List;

    invoke-direct {p0, p1, v0}, Lcom/auth0/jwt/JWTVerifier;->verifyClaims(Lcom/auth0/jwt/interfaces/DecodedJWT;Ljava/util/List;)V

    .line 465
    return-object p1
.end method

.method public verify(Ljava/lang/String;)Lcom/auth0/jwt/interfaces/DecodedJWT;
    .locals 2
    .param p1, "token"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/auth0/jwt/exceptions/JWTVerificationException;
        }
    .end annotation

    .line 444
    new-instance v0, Lcom/auth0/jwt/JWTDecoder;

    iget-object v1, p0, Lcom/auth0/jwt/JWTVerifier;->parser:Lcom/auth0/jwt/impl/JWTParser;

    invoke-direct {v0, v1, p1}, Lcom/auth0/jwt/JWTDecoder;-><init>(Lcom/auth0/jwt/impl/JWTParser;Ljava/lang/String;)V

    .line 445
    .local v0, "jwt":Lcom/auth0/jwt/interfaces/DecodedJWT;
    invoke-virtual {p0, v0}, Lcom/auth0/jwt/JWTVerifier;->verify(Lcom/auth0/jwt/interfaces/DecodedJWT;)Lcom/auth0/jwt/interfaces/DecodedJWT;

    move-result-object v1

    return-object v1
.end method
