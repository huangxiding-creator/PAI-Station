.class public Lcom/amazonaws/services/s3/model/EncryptedInitiateMultipartUploadRequest;
.super Lcom/amazonaws/services/s3/model/InitiateMultipartUploadRequest;
.source "EncryptedInitiateMultipartUploadRequest.java"

# interfaces
.implements Lcom/amazonaws/services/s3/model/MaterialsDescriptionProvider;
.implements Ljava/io/Serializable;


# instance fields
.field private createEncryptionMaterial:Z

.field private materialsDescription:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method public constructor <init>(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1
    .param p1, "bucketName"    # Ljava/lang/String;
    .param p2, "key"    # Ljava/lang/String;

    .line 57
    invoke-direct {p0, p1, p2}, Lcom/amazonaws/services/s3/model/InitiateMultipartUploadRequest;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    .line 54
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/amazonaws/services/s3/model/EncryptedInitiateMultipartUploadRequest;->createEncryptionMaterial:Z

    .line 58
    return-void
.end method

.method public constructor <init>(Ljava/lang/String;Ljava/lang/String;Lcom/amazonaws/services/s3/model/ObjectMetadata;)V
    .locals 1
    .param p1, "bucketName"    # Ljava/lang/String;
    .param p2, "key"    # Ljava/lang/String;
    .param p3, "objectMetadata"    # Lcom/amazonaws/services/s3/model/ObjectMetadata;

    .line 62
    invoke-direct {p0, p1, p2, p3}, Lcom/amazonaws/services/s3/model/InitiateMultipartUploadRequest;-><init>(Ljava/lang/String;Ljava/lang/String;Lcom/amazonaws/services/s3/model/ObjectMetadata;)V

    .line 54
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/amazonaws/services/s3/model/EncryptedInitiateMultipartUploadRequest;->createEncryptionMaterial:Z

    .line 63
    return-void
.end method


# virtual methods
.method public getMaterialsDescription()Ljava/util/Map;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .line 67
    iget-object v0, p0, Lcom/amazonaws/services/s3/model/EncryptedInitiateMultipartUploadRequest;->materialsDescription:Ljava/util/Map;

    return-object v0
.end method

.method public isCreateEncryptionMaterial()Z
    .locals 1

    .line 99
    iget-boolean v0, p0, Lcom/amazonaws/services/s3/model/EncryptedInitiateMultipartUploadRequest;->createEncryptionMaterial:Z

    return v0
.end method

.method public setCreateEncryptionMaterial(Z)V
    .locals 0
    .param p1, "createEncryptionMaterial"    # Z

    .line 108
    iput-boolean p1, p0, Lcom/amazonaws/services/s3/model/EncryptedInitiateMultipartUploadRequest;->createEncryptionMaterial:Z

    .line 109
    return-void
.end method

.method public setMaterialsDescription(Ljava/util/Map;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    .line 77
    .local p1, "materialsDescription":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    if-nez p1, :cond_0

    const/4 v0, 0x0

    goto :goto_0

    :cond_0
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0, p1}, Ljava/util/HashMap;-><init>(Ljava/util/Map;)V

    .line 79
    invoke-static {v0}, Ljava/util/Collections;->unmodifiableMap(Ljava/util/Map;)Ljava/util/Map;

    move-result-object v0

    :goto_0
    iput-object v0, p0, Lcom/amazonaws/services/s3/model/EncryptedInitiateMultipartUploadRequest;->materialsDescription:Ljava/util/Map;

    .line 80
    return-void
.end method

.method public withCreateEncryptionMaterial(Z)Lcom/amazonaws/services/s3/model/EncryptedInitiateMultipartUploadRequest;
    .locals 0
    .param p1, "createEncryptionMaterial"    # Z

    .line 118
    iput-boolean p1, p0, Lcom/amazonaws/services/s3/model/EncryptedInitiateMultipartUploadRequest;->createEncryptionMaterial:Z

    .line 119
    return-object p0
.end method

.method public withMaterialsDescription(Ljava/util/Map;)Lcom/amazonaws/services/s3/model/EncryptedInitiateMultipartUploadRequest;
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;)",
            "Lcom/amazonaws/services/s3/model/EncryptedInitiateMultipartUploadRequest;"
        }
    .end annotation

    .line 90
    .local p1, "materialsDescription":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/s3/model/EncryptedInitiateMultipartUploadRequest;->setMaterialsDescription(Ljava/util/Map;)V

    .line 91
    return-object p0
.end method
