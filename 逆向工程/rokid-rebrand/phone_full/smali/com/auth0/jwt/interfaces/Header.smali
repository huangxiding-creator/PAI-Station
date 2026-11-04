.class public interface abstract Lcom/auth0/jwt/interfaces/Header;
.super Ljava/lang/Object;
.source "Header.java"


# virtual methods
.method public abstract getAlgorithm()Ljava/lang/String;
.end method

.method public abstract getContentType()Ljava/lang/String;
.end method

.method public abstract getHeaderClaim(Ljava/lang/String;)Lcom/auth0/jwt/interfaces/Claim;
.end method

.method public abstract getKeyId()Ljava/lang/String;
.end method

.method public abstract getType()Ljava/lang/String;
.end method
