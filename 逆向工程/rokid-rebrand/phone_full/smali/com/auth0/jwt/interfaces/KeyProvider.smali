.class interface abstract Lcom/auth0/jwt/interfaces/KeyProvider;
.super Ljava/lang/Object;
.source "KeyProvider.java"


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "<U::",
        "Ljava/security/PublicKey;",
        "R::",
        "Ljava/security/PrivateKey;",
        ">",
        "Ljava/lang/Object;"
    }
.end annotation


# virtual methods
.method public abstract getPrivateKey()Ljava/security/PrivateKey;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()TR;"
        }
    .end annotation
.end method

.method public abstract getPrivateKeyId()Ljava/lang/String;
.end method

.method public abstract getPublicKeyById(Ljava/lang/String;)Ljava/security/PublicKey;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            ")TU;"
        }
    .end annotation
.end method
