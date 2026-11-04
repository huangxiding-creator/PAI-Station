.class public interface abstract Lcom/auth0/jwt/interfaces/DecodedJWT;
.super Ljava/lang/Object;
.source "DecodedJWT.java"

# interfaces
.implements Lcom/auth0/jwt/interfaces/Payload;
.implements Lcom/auth0/jwt/interfaces/Header;


# virtual methods
.method public abstract getHeader()Ljava/lang/String;
.end method

.method public abstract getPayload()Ljava/lang/String;
.end method

.method public abstract getSignature()Ljava/lang/String;
.end method

.method public abstract getToken()Ljava/lang/String;
.end method
