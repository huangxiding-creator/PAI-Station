.class Lcom/auth0/jwt/algorithms/ECDSAAlgorithm$1;
.super Ljava/lang/Object;
.source "ECDSAAlgorithm.java"

# interfaces
.implements Lcom/auth0/jwt/interfaces/ECDSAKeyProvider;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/auth0/jwt/algorithms/ECDSAAlgorithm;->providerForKeys(Ljava/security/interfaces/ECPublicKey;Ljava/security/interfaces/ECPrivateKey;)Lcom/auth0/jwt/interfaces/ECDSAKeyProvider;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic val$privateKey:Ljava/security/interfaces/ECPrivateKey;

.field final synthetic val$publicKey:Ljava/security/interfaces/ECPublicKey;


# direct methods
.method constructor <init>(Ljava/security/interfaces/ECPublicKey;Ljava/security/interfaces/ECPrivateKey;)V
    .locals 0

    .line 289
    iput-object p1, p0, Lcom/auth0/jwt/algorithms/ECDSAAlgorithm$1;->val$publicKey:Ljava/security/interfaces/ECPublicKey;

    iput-object p2, p0, Lcom/auth0/jwt/algorithms/ECDSAAlgorithm$1;->val$privateKey:Ljava/security/interfaces/ECPrivateKey;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public bridge synthetic getPrivateKey()Ljava/security/PrivateKey;
    .locals 1

    .line 289
    invoke-virtual {p0}, Lcom/auth0/jwt/algorithms/ECDSAAlgorithm$1;->getPrivateKey()Ljava/security/interfaces/ECPrivateKey;

    move-result-object v0

    return-object v0
.end method

.method public getPrivateKey()Ljava/security/interfaces/ECPrivateKey;
    .locals 1

    .line 297
    iget-object v0, p0, Lcom/auth0/jwt/algorithms/ECDSAAlgorithm$1;->val$privateKey:Ljava/security/interfaces/ECPrivateKey;

    return-object v0
.end method

.method public getPrivateKeyId()Ljava/lang/String;
    .locals 1

    .line 302
    const/4 v0, 0x0

    return-object v0
.end method

.method public bridge synthetic getPublicKeyById(Ljava/lang/String;)Ljava/security/PublicKey;
    .locals 0

    .line 289
    invoke-virtual {p0, p1}, Lcom/auth0/jwt/algorithms/ECDSAAlgorithm$1;->getPublicKeyById(Ljava/lang/String;)Ljava/security/interfaces/ECPublicKey;

    move-result-object p1

    return-object p1
.end method

.method public getPublicKeyById(Ljava/lang/String;)Ljava/security/interfaces/ECPublicKey;
    .locals 1
    .param p1, "keyId"    # Ljava/lang/String;

    .line 292
    iget-object v0, p0, Lcom/auth0/jwt/algorithms/ECDSAAlgorithm$1;->val$publicKey:Ljava/security/interfaces/ECPublicKey;

    return-object v0
.end method
