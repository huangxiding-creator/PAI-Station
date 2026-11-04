.class public interface abstract Lcom/auth0/jwt/interfaces/JWTPartsParser;
.super Ljava/lang/Object;
.source "JWTPartsParser.java"


# virtual methods
.method public abstract parseHeader(Ljava/lang/String;)Lcom/auth0/jwt/interfaces/Header;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/auth0/jwt/exceptions/JWTDecodeException;
        }
    .end annotation
.end method

.method public abstract parsePayload(Ljava/lang/String;)Lcom/auth0/jwt/interfaces/Payload;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/auth0/jwt/exceptions/JWTDecodeException;
        }
    .end annotation
.end method
