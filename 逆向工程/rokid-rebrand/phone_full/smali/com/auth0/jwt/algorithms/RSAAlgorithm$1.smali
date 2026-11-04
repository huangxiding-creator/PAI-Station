.class Lcom/auth0/jwt/algorithms/RSAAlgorithm$1;
.super Ljava/lang/Object;
.source "RSAAlgorithm.java"

# interfaces
.implements Lcom/auth0/jwt/interfaces/RSAKeyProvider;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/auth0/jwt/algorithms/RSAAlgorithm;->providerForKeys(Ljava/security/interfaces/RSAPublicKey;Ljava/security/interfaces/RSAPrivateKey;)Lcom/auth0/jwt/interfaces/RSAKeyProvider;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic val$privateKey:Ljava/security/interfaces/RSAPrivateKey;

.field final synthetic val$publicKey:Ljava/security/interfaces/RSAPublicKey;


# direct methods
.method constructor <init>(Ljava/security/interfaces/RSAPublicKey;Ljava/security/interfaces/RSAPrivateKey;)V
    .locals 0

    .line 95
    iput-object p1, p0, Lcom/auth0/jwt/algorithms/RSAAlgorithm$1;->val$publicKey:Ljava/security/interfaces/RSAPublicKey;

    iput-object p2, p0, Lcom/auth0/jwt/algorithms/RSAAlgorithm$1;->val$privateKey:Ljava/security/interfaces/RSAPrivateKey;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public bridge synthetic getPrivateKey()Ljava/security/PrivateKey;
    .locals 1

    .line 95
    invoke-virtual {p0}, Lcom/auth0/jwt/algorithms/RSAAlgorithm$1;->getPrivateKey()Ljava/security/interfaces/RSAPrivateKey;

    move-result-object v0

    return-object v0
.end method

.method public getPrivateKey()Ljava/security/interfaces/RSAPrivateKey;
    .locals 1

    .line 103
    iget-object v0, p0, Lcom/auth0/jwt/algorithms/RSAAlgorithm$1;->val$privateKey:Ljava/security/interfaces/RSAPrivateKey;

    return-object v0
.end method

.method public getPrivateKeyId()Ljava/lang/String;
    .locals 1

    .line 108
    const/4 v0, 0x0

    return-object v0
.end method

.method public bridge synthetic getPublicKeyById(Ljava/lang/String;)Ljava/security/PublicKey;
    .locals 0

    .line 95
    invoke-virtual {p0, p1}, Lcom/auth0/jwt/algorithms/RSAAlgorithm$1;->getPublicKeyById(Ljava/lang/String;)Ljava/security/interfaces/RSAPublicKey;

    move-result-object p1

    return-object p1
.end method

.method public getPublicKeyById(Ljava/lang/String;)Ljava/security/interfaces/RSAPublicKey;
    .locals 1
    .param p1, "keyId"    # Ljava/lang/String;

    .line 98
    iget-object v0, p0, Lcom/auth0/jwt/algorithms/RSAAlgorithm$1;->val$publicKey:Ljava/security/interfaces/RSAPublicKey;

    return-object v0
.end method
