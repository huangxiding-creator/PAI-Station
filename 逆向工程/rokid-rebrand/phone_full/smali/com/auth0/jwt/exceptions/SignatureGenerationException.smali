.class public Lcom/auth0/jwt/exceptions/SignatureGenerationException;
.super Lcom/auth0/jwt/exceptions/JWTCreationException;
.source "SignatureGenerationException.java"


# direct methods
.method public constructor <init>(Lcom/auth0/jwt/algorithms/Algorithm;Ljava/lang/Throwable;)V
    .locals 2
    .param p1, "algorithm"    # Lcom/auth0/jwt/algorithms/Algorithm;
    .param p2, "cause"    # Ljava/lang/Throwable;

    .line 10
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "The Token\'s Signature couldn\'t be generated when signing using the Algorithm: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0, p2}, Lcom/auth0/jwt/exceptions/JWTCreationException;-><init>(Ljava/lang/String;Ljava/lang/Throwable;)V

    .line 11
    return-void
.end method
