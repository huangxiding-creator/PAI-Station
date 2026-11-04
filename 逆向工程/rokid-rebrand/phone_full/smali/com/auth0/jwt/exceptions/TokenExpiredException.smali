.class public Lcom/auth0/jwt/exceptions/TokenExpiredException;
.super Lcom/auth0/jwt/exceptions/JWTVerificationException;
.source "TokenExpiredException.java"


# static fields
.field private static final serialVersionUID:J = -0x62364d688213aaecL


# instance fields
.field private final expiredOn:Ljava/time/Instant;


# direct methods
.method public constructor <init>(Ljava/lang/String;Ljava/time/Instant;)V
    .locals 0
    .param p1, "message"    # Ljava/lang/String;
    .param p2, "expiredOn"    # Ljava/time/Instant;

    .line 15
    invoke-direct {p0, p1}, Lcom/auth0/jwt/exceptions/JWTVerificationException;-><init>(Ljava/lang/String;)V

    .line 16
    iput-object p2, p0, Lcom/auth0/jwt/exceptions/TokenExpiredException;->expiredOn:Ljava/time/Instant;

    .line 17
    return-void
.end method


# virtual methods
.method public getExpiredOn()Ljava/time/Instant;
    .locals 1

    .line 20
    iget-object v0, p0, Lcom/auth0/jwt/exceptions/TokenExpiredException;->expiredOn:Ljava/time/Instant;

    return-object v0
.end method
