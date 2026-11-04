.class public Lcom/amazonaws/services/s3/model/KMSEncryptionMaterials;
.super Lcom/amazonaws/services/s3/model/EncryptionMaterials;
.source "KMSEncryptionMaterials.java"

# interfaces
.implements Ljava/io/Serializable;


# annotations
.annotation runtime Ljava/lang/Deprecated;
.end annotation


# static fields
.field public static final CUSTOMER_MASTER_KEY_ID:Ljava/lang/String; = "kms_cmk_id"


# direct methods
.method public constructor <init>(Ljava/lang/String;)V
    .locals 2
    .param p1, "defaultCustomerMasterKeyId"    # Ljava/lang/String;

    .line 43
    const/4 v0, 0x0

    invoke-direct {p0, v0, v0}, Lcom/amazonaws/services/s3/model/EncryptionMaterials;-><init>(Ljava/security/KeyPair;Ljavax/crypto/SecretKey;)V

    .line 44
    if-eqz p1, :cond_0

    .line 45
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    if-eqz v0, :cond_0

    .line 48
    const-string v0, "kms_cmk_id"

    invoke-virtual {p0, v0, p1}, Lcom/amazonaws/services/s3/model/KMSEncryptionMaterials;->addDescription(Ljava/lang/String;Ljava/lang/String;)Lcom/amazonaws/services/s3/model/EncryptionMaterials;

    .line 49
    return-void

    .line 46
    :cond_0
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "The default customer master key id must be specified"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method


# virtual methods
.method public getCustomerMasterKeyId()Ljava/lang/String;
    .locals 1

    .line 85
    const-string v0, "kms_cmk_id"

    invoke-virtual {p0, v0}, Lcom/amazonaws/services/s3/model/KMSEncryptionMaterials;->getDescription(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public final getKeyPair()Ljava/security/KeyPair;
    .locals 1

    .line 56
    new-instance v0, Ljava/lang/UnsupportedOperationException;

    invoke-direct {v0}, Ljava/lang/UnsupportedOperationException;-><init>()V

    throw v0
.end method

.method public final getSymmetricKey()Ljavax/crypto/SecretKey;
    .locals 1

    .line 64
    new-instance v0, Ljava/lang/UnsupportedOperationException;

    invoke-direct {v0}, Ljava/lang/UnsupportedOperationException;-><init>()V

    throw v0
.end method

.method public final isKMSEnabled()Z
    .locals 1

    .line 76
    const/4 v0, 0x1

    return v0
.end method

.method public toString()Ljava/lang/String;
    .locals 1

    .line 90
    invoke-virtual {p0}, Lcom/amazonaws/services/s3/model/KMSEncryptionMaterials;->getMaterialsDescription()Ljava/util/Map;

    move-result-object v0

    invoke-static {v0}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
