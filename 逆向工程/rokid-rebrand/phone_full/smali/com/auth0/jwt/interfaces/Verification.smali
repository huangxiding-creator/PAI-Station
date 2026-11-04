.class public interface abstract Lcom/auth0/jwt/interfaces/Verification;
.super Ljava/lang/Object;
.source "Verification.java"


# virtual methods
.method public abstract acceptExpiresAt(J)Lcom/auth0/jwt/interfaces/Verification;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/IllegalArgumentException;
        }
    .end annotation
.end method

.method public abstract acceptIssuedAt(J)Lcom/auth0/jwt/interfaces/Verification;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/IllegalArgumentException;
        }
    .end annotation
.end method

.method public abstract acceptLeeway(J)Lcom/auth0/jwt/interfaces/Verification;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/IllegalArgumentException;
        }
    .end annotation
.end method

.method public abstract acceptNotBefore(J)Lcom/auth0/jwt/interfaces/Verification;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/IllegalArgumentException;
        }
    .end annotation
.end method

.method public abstract build()Lcom/auth0/jwt/JWTVerifier;
.end method

.method public abstract ignoreIssuedAt()Lcom/auth0/jwt/interfaces/Verification;
.end method

.method public varargs abstract withAnyOfAudience([Ljava/lang/String;)Lcom/auth0/jwt/interfaces/Verification;
.end method

.method public varargs abstract withArrayClaim(Ljava/lang/String;[Ljava/lang/Integer;)Lcom/auth0/jwt/interfaces/Verification;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/IllegalArgumentException;
        }
    .end annotation
.end method

.method public varargs abstract withArrayClaim(Ljava/lang/String;[Ljava/lang/Long;)Lcom/auth0/jwt/interfaces/Verification;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/IllegalArgumentException;
        }
    .end annotation
.end method

.method public varargs abstract withArrayClaim(Ljava/lang/String;[Ljava/lang/String;)Lcom/auth0/jwt/interfaces/Verification;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/IllegalArgumentException;
        }
    .end annotation
.end method

.method public varargs abstract withAudience([Ljava/lang/String;)Lcom/auth0/jwt/interfaces/Verification;
.end method

.method public abstract withClaim(Ljava/lang/String;Ljava/lang/Boolean;)Lcom/auth0/jwt/interfaces/Verification;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/IllegalArgumentException;
        }
    .end annotation
.end method

.method public abstract withClaim(Ljava/lang/String;Ljava/lang/Double;)Lcom/auth0/jwt/interfaces/Verification;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/IllegalArgumentException;
        }
    .end annotation
.end method

.method public abstract withClaim(Ljava/lang/String;Ljava/lang/Integer;)Lcom/auth0/jwt/interfaces/Verification;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/IllegalArgumentException;
        }
    .end annotation
.end method

.method public abstract withClaim(Ljava/lang/String;Ljava/lang/Long;)Lcom/auth0/jwt/interfaces/Verification;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/IllegalArgumentException;
        }
    .end annotation
.end method

.method public abstract withClaim(Ljava/lang/String;Ljava/lang/String;)Lcom/auth0/jwt/interfaces/Verification;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/IllegalArgumentException;
        }
    .end annotation
.end method

.method public withClaim(Ljava/lang/String;Ljava/time/Instant;)Lcom/auth0/jwt/interfaces/Verification;
    .locals 1
    .param p1, "name"    # Ljava/lang/String;
    .param p2, "value"    # Ljava/time/Instant;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/IllegalArgumentException;
        }
    .end annotation

    .line 210
    if-eqz p2, :cond_0

    invoke-static {p2}, Ljava/util/Date;->from(Ljava/time/Instant;)Ljava/util/Date;

    move-result-object v0

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    invoke-interface {p0, p1, v0}, Lcom/auth0/jwt/interfaces/Verification;->withClaim(Ljava/lang/String;Ljava/util/Date;)Lcom/auth0/jwt/interfaces/Verification;

    move-result-object v0

    return-object v0
.end method

.method public abstract withClaim(Ljava/lang/String;Ljava/util/Date;)Lcom/auth0/jwt/interfaces/Verification;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/IllegalArgumentException;
        }
    .end annotation
.end method

.method public abstract withClaim(Ljava/lang/String;Ljava/util/function/BiPredicate;)Lcom/auth0/jwt/interfaces/Verification;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/util/function/BiPredicate<",
            "Lcom/auth0/jwt/interfaces/Claim;",
            "Lcom/auth0/jwt/interfaces/DecodedJWT;",
            ">;)",
            "Lcom/auth0/jwt/interfaces/Verification;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/IllegalArgumentException;
        }
    .end annotation
.end method

.method public abstract withClaimPresence(Ljava/lang/String;)Lcom/auth0/jwt/interfaces/Verification;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/IllegalArgumentException;
        }
    .end annotation
.end method

.method public withIssuer(Ljava/lang/String;)Lcom/auth0/jwt/interfaces/Verification;
    .locals 2
    .param p1, "issuer"    # Ljava/lang/String;

    .line 24
    const/4 v0, 0x1

    new-array v0, v0, [Ljava/lang/String;

    const/4 v1, 0x0

    aput-object p1, v0, v1

    invoke-interface {p0, v0}, Lcom/auth0/jwt/interfaces/Verification;->withIssuer([Ljava/lang/String;)Lcom/auth0/jwt/interfaces/Verification;

    move-result-object v0

    return-object v0
.end method

.method public varargs abstract withIssuer([Ljava/lang/String;)Lcom/auth0/jwt/interfaces/Verification;
.end method

.method public abstract withJWTId(Ljava/lang/String;)Lcom/auth0/jwt/interfaces/Verification;
.end method

.method public abstract withNullClaim(Ljava/lang/String;)Lcom/auth0/jwt/interfaces/Verification;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/IllegalArgumentException;
        }
    .end annotation
.end method

.method public abstract withSubject(Ljava/lang/String;)Lcom/auth0/jwt/interfaces/Verification;
.end method
