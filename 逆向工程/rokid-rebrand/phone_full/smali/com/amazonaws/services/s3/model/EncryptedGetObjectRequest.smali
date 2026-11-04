.class public Lcom/amazonaws/services/s3/model/EncryptedGetObjectRequest;
.super Lcom/amazonaws/services/s3/model/GetObjectRequest;
.source "EncryptedGetObjectRequest.java"

# interfaces
.implements Ljava/io/Serializable;


# instance fields
.field private instructionFileSuffix:Ljava/lang/String;

.field private keyWrapExpected:Z

.field private supplemental:Lcom/amazonaws/services/s3/model/ExtraMaterialsDescription;


# direct methods
.method public constructor <init>(Lcom/amazonaws/services/s3/model/S3ObjectId;)V
    .locals 1
    .param p1, "s3ObjectId"    # Lcom/amazonaws/services/s3/model/S3ObjectId;

    .line 72
    invoke-direct {p0, p1}, Lcom/amazonaws/services/s3/model/GetObjectRequest;-><init>(Lcom/amazonaws/services/s3/model/S3ObjectId;)V

    .line 44
    sget-object v0, Lcom/amazonaws/services/s3/model/ExtraMaterialsDescription;->NONE:Lcom/amazonaws/services/s3/model/ExtraMaterialsDescription;

    iput-object v0, p0, Lcom/amazonaws/services/s3/model/EncryptedGetObjectRequest;->supplemental:Lcom/amazonaws/services/s3/model/ExtraMaterialsDescription;

    .line 73
    return-void
.end method

.method public constructor <init>(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1
    .param p1, "bucketName"    # Ljava/lang/String;
    .param p2, "key"    # Ljava/lang/String;

    .line 61
    const/4 v0, 0x0

    invoke-direct {p0, p1, p2, v0}, Lcom/amazonaws/services/s3/model/EncryptedGetObjectRequest;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 62
    return-void
.end method

.method public constructor <init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 1
    .param p1, "bucketName"    # Ljava/lang/String;
    .param p2, "key"    # Ljava/lang/String;
    .param p3, "versionId"    # Ljava/lang/String;

    .line 66
    invoke-direct {p0, p1, p2, p3}, Lcom/amazonaws/services/s3/model/GetObjectRequest;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 44
    sget-object v0, Lcom/amazonaws/services/s3/model/ExtraMaterialsDescription;->NONE:Lcom/amazonaws/services/s3/model/ExtraMaterialsDescription;

    iput-object v0, p0, Lcom/amazonaws/services/s3/model/EncryptedGetObjectRequest;->supplemental:Lcom/amazonaws/services/s3/model/ExtraMaterialsDescription;

    .line 67
    invoke-virtual {p0, p2}, Lcom/amazonaws/services/s3/model/EncryptedGetObjectRequest;->setKey(Ljava/lang/String;)V

    .line 68
    invoke-virtual {p0, p3}, Lcom/amazonaws/services/s3/model/EncryptedGetObjectRequest;->setVersionId(Ljava/lang/String;)V

    .line 69
    return-void
.end method

.method public constructor <init>(Ljava/lang/String;Ljava/lang/String;Z)V
    .locals 1
    .param p1, "bucketName"    # Ljava/lang/String;
    .param p2, "key"    # Ljava/lang/String;
    .param p3, "isRequesterPays"    # Z

    .line 77
    invoke-direct {p0, p1, p2, p3}, Lcom/amazonaws/services/s3/model/GetObjectRequest;-><init>(Ljava/lang/String;Ljava/lang/String;Z)V

    .line 44
    sget-object v0, Lcom/amazonaws/services/s3/model/ExtraMaterialsDescription;->NONE:Lcom/amazonaws/services/s3/model/ExtraMaterialsDescription;

    iput-object v0, p0, Lcom/amazonaws/services/s3/model/EncryptedGetObjectRequest;->supplemental:Lcom/amazonaws/services/s3/model/ExtraMaterialsDescription;

    .line 78
    return-void
.end method


# virtual methods
.method public getExtraMaterialDescription()Lcom/amazonaws/services/s3/model/ExtraMaterialsDescription;
    .locals 1

    .line 87
    iget-object v0, p0, Lcom/amazonaws/services/s3/model/EncryptedGetObjectRequest;->supplemental:Lcom/amazonaws/services/s3/model/ExtraMaterialsDescription;

    return-object v0
.end method

.method public getInstructionFileSuffix()Ljava/lang/String;
    .locals 1

    .line 137
    iget-object v0, p0, Lcom/amazonaws/services/s3/model/EncryptedGetObjectRequest;->instructionFileSuffix:Ljava/lang/String;

    return-object v0
.end method

.method public isKeyWrapExpected()Z
    .locals 1

    .line 182
    iget-boolean v0, p0, Lcom/amazonaws/services/s3/model/EncryptedGetObjectRequest;->keyWrapExpected:Z

    return v0
.end method

.method public setExtraMaterialDescription(Lcom/amazonaws/services/s3/model/ExtraMaterialsDescription;)V
    .locals 1
    .param p1, "supplemental"    # Lcom/amazonaws/services/s3/model/ExtraMaterialsDescription;

    .line 101
    if-nez p1, :cond_0

    sget-object v0, Lcom/amazonaws/services/s3/model/ExtraMaterialsDescription;->NONE:Lcom/amazonaws/services/s3/model/ExtraMaterialsDescription;

    goto :goto_0

    :cond_0
    move-object v0, p1

    :goto_0
    iput-object v0, p0, Lcom/amazonaws/services/s3/model/EncryptedGetObjectRequest;->supplemental:Lcom/amazonaws/services/s3/model/ExtraMaterialsDescription;

    .line 103
    return-void
.end method

.method public setInstructionFileSuffix(Ljava/lang/String;)V
    .locals 0
    .param p1, "instructionFileSuffix"    # Ljava/lang/String;

    .line 154
    iput-object p1, p0, Lcom/amazonaws/services/s3/model/EncryptedGetObjectRequest;->instructionFileSuffix:Ljava/lang/String;

    .line 155
    return-void
.end method

.method public setKeyWrapExpected(Z)V
    .locals 0
    .param p1, "keyWrapExpected"    # Z

    .line 197
    iput-boolean p1, p0, Lcom/amazonaws/services/s3/model/EncryptedGetObjectRequest;->keyWrapExpected:Z

    .line 198
    return-void
.end method

.method public withExtraMaterialsDescription(Lcom/amazonaws/services/s3/model/ExtraMaterialsDescription;)Lcom/amazonaws/services/s3/model/EncryptedGetObjectRequest;
    .locals 0
    .param p1, "supplemental"    # Lcom/amazonaws/services/s3/model/ExtraMaterialsDescription;

    .line 116
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/s3/model/EncryptedGetObjectRequest;->setExtraMaterialDescription(Lcom/amazonaws/services/s3/model/ExtraMaterialsDescription;)V

    .line 117
    return-object p0
.end method

.method public withExtraMaterialsDescription(Ljava/util/Map;)Lcom/amazonaws/services/s3/model/EncryptedGetObjectRequest;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;)",
            "Lcom/amazonaws/services/s3/model/EncryptedGetObjectRequest;"
        }
    .end annotation

    .line 131
    .local p1, "supplemental":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    if-nez p1, :cond_0

    const/4 v0, 0x0

    goto :goto_0

    :cond_0
    new-instance v0, Lcom/amazonaws/services/s3/model/ExtraMaterialsDescription;

    invoke-direct {v0, p1}, Lcom/amazonaws/services/s3/model/ExtraMaterialsDescription;-><init>(Ljava/util/Map;)V

    :goto_0
    invoke-virtual {p0, v0}, Lcom/amazonaws/services/s3/model/EncryptedGetObjectRequest;->setExtraMaterialDescription(Lcom/amazonaws/services/s3/model/ExtraMaterialsDescription;)V

    .line 133
    return-object p0
.end method

.method public withInstructionFileSuffix(Ljava/lang/String;)Lcom/amazonaws/services/s3/model/EncryptedGetObjectRequest;
    .locals 0
    .param p1, "instructionFileSuffix"    # Ljava/lang/String;

    .line 172
    iput-object p1, p0, Lcom/amazonaws/services/s3/model/EncryptedGetObjectRequest;->instructionFileSuffix:Ljava/lang/String;

    .line 173
    return-object p0
.end method

.method public withKeyWrapExpected(Z)Lcom/amazonaws/services/s3/model/EncryptedGetObjectRequest;
    .locals 0
    .param p1, "keyWrapExpected"    # Z

    .line 204
    iput-boolean p1, p0, Lcom/amazonaws/services/s3/model/EncryptedGetObjectRequest;->keyWrapExpected:Z

    .line 205
    return-object p0
.end method
