.class Lcom/amazonaws/services/s3/internal/crypto/S3KeyWrapScheme;
.super Ljava/lang/Object;
.source "S3KeyWrapScheme.java"


# annotations
.annotation runtime Ljava/lang/Deprecated;
.end annotation


# static fields
.field public static final AES_WRAP:Ljava/lang/String; = "AESWrap"

.field static final NONE:Lcom/amazonaws/services/s3/internal/crypto/S3KeyWrapScheme;

.field public static final RSA_ECB_OAEP_WITH_SHA256_AND_MGF1_PADDING:Ljava/lang/String; = "RSA/ECB/OAEPWithSHA-256AndMGF1Padding"


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 31
    new-instance v0, Lcom/amazonaws/services/s3/internal/crypto/S3KeyWrapScheme$1;

    invoke-direct {v0}, Lcom/amazonaws/services/s3/internal/crypto/S3KeyWrapScheme$1;-><init>()V

    sput-object v0, Lcom/amazonaws/services/s3/internal/crypto/S3KeyWrapScheme;->NONE:Lcom/amazonaws/services/s3/internal/crypto/S3KeyWrapScheme;

    return-void
.end method

.method constructor <init>()V
    .locals 0

    .line 26
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method getKeyWrapAlgorithm(Ljava/security/Key;Ljava/security/Provider;)Ljava/lang/String;
    .locals 2
    .param p1, "key"    # Ljava/security/Key;
    .param p2, "provider"    # Ljava/security/Provider;

    .line 51
    invoke-interface {p1}, Ljava/security/Key;->getAlgorithm()Ljava/lang/String;

    move-result-object v0

    .line 52
    .local v0, "algorithm":Ljava/lang/String;
    const-string v1, "AES"

    invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 53
    const-string v1, "AESWrap"

    return-object v1

    .line 55
    :cond_0
    const-string v1, "RSA"

    invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_1

    .line 56
    invoke-static {p2}, Lcom/amazonaws/services/s3/internal/crypto/CryptoRuntime;->isRsaKeyWrapAvailable(Ljava/security/Provider;)Z

    move-result v1

    if-eqz v1, :cond_1

    .line 57
    const-string v1, "RSA/ECB/OAEPWithSHA-256AndMGF1Padding"

    return-object v1

    .line 59
    :cond_1
    const/4 v1, 0x0

    return-object v1
.end method

.method public toString()Ljava/lang/String;
    .locals 1

    .line 63
    const-string v0, "S3KeyWrapScheme"

    return-object v0
.end method
