.class final Lcom/amazonaws/services/s3/internal/crypto/KMSSecuredCEK;
.super Lcom/amazonaws/services/s3/internal/crypto/SecuredCEK;
.source "KMSSecuredCEK.java"


# annotations
.annotation runtime Ljava/lang/Deprecated;
.end annotation


# static fields
.field static final KEY_PROTECTION_MECHANISM:Ljava/lang/String; = "kms"


# direct methods
.method constructor <init>([BLjava/util/Map;)V
    .locals 1
    .param p1, "encryptedKeyBlob"    # [B
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "([B",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    .line 31
    .local p2, "matdesc":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    const-string v0, "kms"

    invoke-direct {p0, p1, v0, p2}, Lcom/amazonaws/services/s3/internal/crypto/SecuredCEK;-><init>([BLjava/lang/String;Ljava/util/Map;)V

    .line 32
    return-void
.end method

.method public static isKMSKeyWrapped(Ljava/lang/String;)Z
    .locals 1
    .param p0, "keyWrapAlgo"    # Ljava/lang/String;

    .line 39
    const-string v0, "kms"

    invoke-virtual {v0, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    return v0
.end method
