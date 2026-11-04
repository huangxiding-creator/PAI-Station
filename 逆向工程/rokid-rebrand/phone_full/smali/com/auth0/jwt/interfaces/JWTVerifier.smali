.class public interface abstract Lcom/auth0/jwt/interfaces/JWTVerifier;
.super Ljava/lang/Object;
.source "JWTVerifier.java"


# virtual methods
.method public abstract verify(Lcom/auth0/jwt/interfaces/DecodedJWT;)Lcom/auth0/jwt/interfaces/DecodedJWT;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/auth0/jwt/exceptions/JWTVerificationException;
        }
    .end annotation
.end method

.method public abstract verify(Ljava/lang/String;)Lcom/auth0/jwt/interfaces/DecodedJWT;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/auth0/jwt/exceptions/JWTVerificationException;
        }
    .end annotation
.end method
