.class public interface abstract Lcom/auth0/jwt/interfaces/Claim;
.super Ljava/lang/Object;
.source "Claim.java"


# virtual methods
.method public abstract as(Ljava/lang/Class;)Ljava/lang/Object;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Ljava/lang/Object;",
            ">(",
            "Ljava/lang/Class<",
            "TT;>;)TT;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/auth0/jwt/exceptions/JWTDecodeException;
        }
    .end annotation
.end method

.method public abstract asArray(Ljava/lang/Class;)[Ljava/lang/Object;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Ljava/lang/Object;",
            ">(",
            "Ljava/lang/Class<",
            "TT;>;)[TT;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/auth0/jwt/exceptions/JWTDecodeException;
        }
    .end annotation
.end method

.method public abstract asBoolean()Ljava/lang/Boolean;
.end method

.method public abstract asDate()Ljava/util/Date;
.end method

.method public abstract asDouble()Ljava/lang/Double;
.end method

.method public asInstant()Ljava/time/Instant;
    .locals 2

    .line 87
    invoke-interface {p0}, Lcom/auth0/jwt/interfaces/Claim;->asDate()Ljava/util/Date;

    move-result-object v0

    .line 88
    .local v0, "date":Ljava/util/Date;
    if-eqz v0, :cond_0

    invoke-virtual {v0}, Ljava/util/Date;->toInstant()Ljava/time/Instant;

    move-result-object v1

    goto :goto_0

    :cond_0
    const/4 v1, 0x0

    :goto_0
    return-object v1
.end method

.method public abstract asInt()Ljava/lang/Integer;
.end method

.method public abstract asList(Ljava/lang/Class;)Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Ljava/lang/Object;",
            ">(",
            "Ljava/lang/Class<",
            "TT;>;)",
            "Ljava/util/List<",
            "TT;>;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/auth0/jwt/exceptions/JWTDecodeException;
        }
    .end annotation
.end method

.method public abstract asLong()Ljava/lang/Long;
.end method

.method public abstract asMap()Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/Object;",
            ">;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/auth0/jwt/exceptions/JWTDecodeException;
        }
    .end annotation
.end method

.method public abstract asString()Ljava/lang/String;
.end method

.method public abstract isMissing()Z
.end method

.method public abstract isNull()Z
.end method
