.class public interface abstract Lcom/auth0/jwt/interfaces/Payload;
.super Ljava/lang/Object;
.source "Payload.java"


# virtual methods
.method public abstract getAudience()Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end method

.method public abstract getClaim(Ljava/lang/String;)Lcom/auth0/jwt/interfaces/Claim;
.end method

.method public abstract getClaims()Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Lcom/auth0/jwt/interfaces/Claim;",
            ">;"
        }
    .end annotation
.end method

.method public abstract getExpiresAt()Ljava/util/Date;
.end method

.method public getExpiresAtAsInstant()Ljava/time/Instant;
    .locals 1

    .line 47
    invoke-interface {p0}, Lcom/auth0/jwt/interfaces/Payload;->getExpiresAt()Ljava/util/Date;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-interface {p0}, Lcom/auth0/jwt/interfaces/Payload;->getExpiresAt()Ljava/util/Date;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/Date;->toInstant()Ljava/time/Instant;

    move-result-object v0

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return-object v0
.end method

.method public abstract getId()Ljava/lang/String;
.end method

.method public abstract getIssuedAt()Ljava/util/Date;
.end method

.method public getIssuedAtAsInstant()Ljava/time/Instant;
    .locals 1

    .line 79
    invoke-interface {p0}, Lcom/auth0/jwt/interfaces/Payload;->getIssuedAt()Ljava/util/Date;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-interface {p0}, Lcom/auth0/jwt/interfaces/Payload;->getIssuedAt()Ljava/util/Date;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/Date;->toInstant()Ljava/time/Instant;

    move-result-object v0

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return-object v0
.end method

.method public abstract getIssuer()Ljava/lang/String;
.end method

.method public abstract getNotBefore()Ljava/util/Date;
.end method

.method public getNotBeforeAsInstant()Ljava/time/Instant;
    .locals 1

    .line 63
    invoke-interface {p0}, Lcom/auth0/jwt/interfaces/Payload;->getNotBefore()Ljava/util/Date;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-interface {p0}, Lcom/auth0/jwt/interfaces/Payload;->getNotBefore()Ljava/util/Date;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/Date;->toInstant()Ljava/time/Instant;

    move-result-object v0

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return-object v0
.end method

.method public abstract getSubject()Ljava/lang/String;
.end method
