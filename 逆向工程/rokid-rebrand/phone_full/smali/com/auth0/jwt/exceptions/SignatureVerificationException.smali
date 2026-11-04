.class public Lcom/auth0/jwt/exceptions/SignatureVerificationException;
.super Lcom/auth0/jwt/exceptions/JWTVerificationException;
.source "SignatureVerificationException.java"


# direct methods
.method public constructor <init>(Lcom/auth0/jwt/algorithms/Algorithm;)V
    .locals 1
    .param p1, "algorithm"    # Lcom/auth0/jwt/algorithms/Algorithm;

    .line 10
    const/4 v0, 0x0

    invoke-direct {p0, p1, v0}, Lcom/auth0/jwt/exceptions/SignatureVerificationException;-><init>(Lcom/auth0/jwt/algorithms/Algorithm;Ljava/lang/Throwable;)V

    .line 11
    return-void
.end method

.method public constructor <init>(Lcom/auth0/jwt/algorithms/Algorithm;Ljava/lang/Throwable;)V
    .locals 2
    .param p1, "algorithm"    # Lcom/auth0/jwt/algorithms/Algorithm;
    .param p2, "cause"    # Ljava/lang/Throwable;

    .line 14
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "The Token\'s Signature resulted invalid when verified using the Algorithm: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0, p2}, Lcom/auth0/jwt/exceptions/JWTVerificationException;-><init>(Ljava/lang/String;Ljava/lang/Throwable;)V

    .line 15
    return-void
.end method
