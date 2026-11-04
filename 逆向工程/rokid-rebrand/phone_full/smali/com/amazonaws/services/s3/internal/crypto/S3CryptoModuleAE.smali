.class Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleAE;
.super Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;
.source "S3CryptoModuleAE.java"


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase<",
        "Lcom/amazonaws/services/s3/internal/crypto/MultipartUploadCryptoContext;",
        ">;"
    }
.end annotation

.annotation runtime Ljava/lang/Deprecated;
.end annotation


# static fields
.field private static final BIT_SIZE:I = 0x8

.field private static final DEFAULT_BYTE_SIZE:I = 0x2800


# direct methods
.method static constructor <clinit>()V
    .locals 0

    .line 66
    invoke-static {}, Lcom/amazonaws/services/s3/internal/crypto/CryptoRuntime;->enableBouncyCastle()V

    .line 67
    return-void
.end method

.method constructor <init>(Lcom/amazonaws/services/kms/AWSKMSClient;Lcom/amazonaws/services/s3/internal/S3Direct;Lcom/amazonaws/auth/AWSCredentialsProvider;Lcom/amazonaws/services/s3/model/EncryptionMaterialsProvider;Lcom/amazonaws/services/s3/model/CryptoConfiguration;)V
    .locals 2
    .param p1, "kms"    # Lcom/amazonaws/services/kms/AWSKMSClient;
    .param p2, "s3"    # Lcom/amazonaws/services/s3/internal/S3Direct;
    .param p3, "credentialsProvider"    # Lcom/amazonaws/auth/AWSCredentialsProvider;
    .param p4, "encryptionMaterialsProvider"    # Lcom/amazonaws/services/s3/model/EncryptionMaterialsProvider;
    .param p5, "cryptoConfig"    # Lcom/amazonaws/services/s3/model/CryptoConfiguration;

    .line 75
    invoke-direct/range {p0 .. p5}, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;-><init>(Lcom/amazonaws/services/kms/AWSKMSClient;Lcom/amazonaws/services/s3/internal/S3Direct;Lcom/amazonaws/auth/AWSCredentialsProvider;Lcom/amazonaws/services/s3/model/EncryptionMaterialsProvider;Lcom/amazonaws/services/s3/model/CryptoConfiguration;)V

    .line 77
    invoke-virtual {p5}, Lcom/amazonaws/services/s3/model/CryptoConfiguration;->getCryptoMode()Lcom/amazonaws/services/s3/model/CryptoMode;

    move-result-object v0

    .line 78
    .local v0, "mode":Lcom/amazonaws/services/s3/model/CryptoMode;
    sget-object v1, Lcom/amazonaws/services/s3/model/CryptoMode;->StrictAuthenticatedEncryption:Lcom/amazonaws/services/s3/model/CryptoMode;

    if-eq v0, v1, :cond_1

    sget-object v1, Lcom/amazonaws/services/s3/model/CryptoMode;->AuthenticatedEncryption:Lcom/amazonaws/services/s3/model/CryptoMode;

    if-ne v0, v1, :cond_0

    goto :goto_0

    .line 80
    :cond_0
    new-instance v1, Ljava/lang/IllegalArgumentException;

    invoke-direct {v1}, Ljava/lang/IllegalArgumentException;-><init>()V

    throw v1

    .line 82
    :cond_1
    :goto_0
    return-void
.end method

.method constructor <init>(Lcom/amazonaws/services/kms/AWSKMSClient;Lcom/amazonaws/services/s3/internal/S3Direct;Lcom/amazonaws/services/s3/model/EncryptionMaterialsProvider;Lcom/amazonaws/services/s3/model/CryptoConfiguration;)V
    .locals 6
    .param p1, "kms"    # Lcom/amazonaws/services/kms/AWSKMSClient;
    .param p2, "s3"    # Lcom/amazonaws/services/s3/internal/S3Direct;
    .param p3, "encryptionMaterialsProvider"    # Lcom/amazonaws/services/s3/model/EncryptionMaterialsProvider;
    .param p4, "cryptoConfig"    # Lcom/amazonaws/services/s3/model/CryptoConfiguration;

    .line 99
    new-instance v3, Lcom/amazonaws/auth/DefaultAWSCredentialsProviderChain;

    invoke-direct {v3}, Lcom/amazonaws/auth/DefaultAWSCredentialsProviderChain;-><init>()V

    move-object v0, p0

    move-object v1, p1

    move-object v2, p2

    move-object v4, p3

    move-object v5, p4

    invoke-direct/range {v0 .. v5}, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleAE;-><init>(Lcom/amazonaws/services/kms/AWSKMSClient;Lcom/amazonaws/services/s3/internal/S3Direct;Lcom/amazonaws/auth/AWSCredentialsProvider;Lcom/amazonaws/services/s3/model/EncryptionMaterialsProvider;Lcom/amazonaws/services/s3/model/CryptoConfiguration;)V

    .line 101
    return-void
.end method

.method constructor <init>(Lcom/amazonaws/services/s3/internal/S3Direct;Lcom/amazonaws/services/s3/model/EncryptionMaterialsProvider;Lcom/amazonaws/services/s3/model/CryptoConfiguration;)V
    .locals 6
    .param p1, "s3"    # Lcom/amazonaws/services/s3/internal/S3Direct;
    .param p2, "encryptionMaterialsProvider"    # Lcom/amazonaws/services/s3/model/EncryptionMaterialsProvider;
    .param p3, "cryptoConfig"    # Lcom/amazonaws/services/s3/model/CryptoConfiguration;

    .line 90
    new-instance v3, Lcom/amazonaws/auth/DefaultAWSCredentialsProviderChain;

    invoke-direct {v3}, Lcom/amazonaws/auth/DefaultAWSCredentialsProviderChain;-><init>()V

    const/4 v1, 0x0

    move-object v0, p0

    move-object v2, p1

    move-object v4, p2

    move-object v5, p3

    invoke-direct/range {v0 .. v5}, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleAE;-><init>(Lcom/amazonaws/services/kms/AWSKMSClient;Lcom/amazonaws/services/s3/internal/S3Direct;Lcom/amazonaws/auth/AWSCredentialsProvider;Lcom/amazonaws/services/s3/model/EncryptionMaterialsProvider;Lcom/amazonaws/services/s3/model/CryptoConfiguration;)V

    .line 92
    return-void
.end method

.method private assertParameterNotNull(Ljava/lang/Object;Ljava/lang/String;)V
    .locals 1
    .param p1, "parameterValue"    # Ljava/lang/Object;
    .param p2, "errorMessage"    # Ljava/lang/String;

    .line 438
    if-eqz p1, :cond_0

    .line 441
    return-void

    .line 439
    :cond_0
    new-instance v0, Ljava/lang/IllegalArgumentException;

    invoke-direct {v0, p2}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method private decipher(Lcom/amazonaws/services/s3/model/GetObjectRequest;[J[JLcom/amazonaws/services/s3/model/S3Object;)Lcom/amazonaws/services/s3/model/S3Object;
    .locals 8
    .param p1, "req"    # Lcom/amazonaws/services/s3/model/GetObjectRequest;
    .param p2, "desiredRange"    # [J
    .param p3, "cryptoRange"    # [J
    .param p4, "retrieved"    # Lcom/amazonaws/services/s3/model/S3Object;

    .line 155
    new-instance v0, Lcom/amazonaws/services/s3/internal/crypto/S3ObjectWrapper;

    invoke-virtual {p1}, Lcom/amazonaws/services/s3/model/GetObjectRequest;->getS3ObjectId()Lcom/amazonaws/services/s3/model/S3ObjectId;

    move-result-object v1

    invoke-direct {v0, p4, v1}, Lcom/amazonaws/services/s3/internal/crypto/S3ObjectWrapper;-><init>(Lcom/amazonaws/services/s3/model/S3Object;Lcom/amazonaws/services/s3/model/S3ObjectId;)V

    .line 157
    .local v0, "wrapped":Lcom/amazonaws/services/s3/internal/crypto/S3ObjectWrapper;
    invoke-virtual {v0}, Lcom/amazonaws/services/s3/internal/crypto/S3ObjectWrapper;->hasEncryptionInfo()Z

    move-result v1

    if-eqz v1, :cond_0

    .line 158
    invoke-direct {p0, p1, p2, p3, v0}, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleAE;->decipherWithMetadata(Lcom/amazonaws/services/s3/model/GetObjectRequest;[J[JLcom/amazonaws/services/s3/internal/crypto/S3ObjectWrapper;)Lcom/amazonaws/services/s3/model/S3Object;

    move-result-object v1

    return-object v1

    .line 161
    :cond_0
    invoke-virtual {p1}, Lcom/amazonaws/services/s3/model/GetObjectRequest;->getS3ObjectId()Lcom/amazonaws/services/s3/model/S3ObjectId;

    move-result-object v1

    const/4 v2, 0x0

    invoke-virtual {p0, v1, v2}, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleAE;->fetchInstructionFile(Lcom/amazonaws/services/s3/model/S3ObjectId;Ljava/lang/String;)Lcom/amazonaws/services/s3/internal/crypto/S3ObjectWrapper;

    move-result-object v1

    .line 162
    .local v1, "ifile":Lcom/amazonaws/services/s3/internal/crypto/S3ObjectWrapper;
    if-eqz v1, :cond_2

    .line 164
    :try_start_0
    invoke-virtual {v1}, Lcom/amazonaws/services/s3/internal/crypto/S3ObjectWrapper;->isInstructionFile()Z

    move-result v3

    if-eqz v3, :cond_1

    .line 165
    move-object v2, p0

    move-object v3, p1

    move-object v4, p2

    move-object v5, p3

    move-object v6, v0

    move-object v7, v1

    invoke-direct/range {v2 .. v7}, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleAE;->decipherWithInstructionFile(Lcom/amazonaws/services/s3/model/GetObjectRequest;[J[JLcom/amazonaws/services/s3/internal/crypto/S3ObjectWrapper;Lcom/amazonaws/services/s3/internal/crypto/S3ObjectWrapper;)Lcom/amazonaws/services/s3/model/S3Object;

    move-result-object v2
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 169
    iget-object v3, p0, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleAE;->log:Lcom/amazonaws/logging/Log;

    invoke-static {v1, v3}, Lcom/amazonaws/util/IOUtils;->closeQuietly(Ljava/io/Closeable;Lcom/amazonaws/logging/Log;)V

    .line 165
    return-object v2

    .line 169
    :cond_1
    iget-object v3, p0, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleAE;->log:Lcom/amazonaws/logging/Log;

    invoke-static {v1, v3}, Lcom/amazonaws/util/IOUtils;->closeQuietly(Ljava/io/Closeable;Lcom/amazonaws/logging/Log;)V

    .line 170
    goto :goto_0

    .line 169
    :catchall_0
    move-exception v2

    iget-object v3, p0, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleAE;->log:Lcom/amazonaws/logging/Log;

    invoke-static {v1, v3}, Lcom/amazonaws/util/IOUtils;->closeQuietly(Ljava/io/Closeable;Lcom/amazonaws/logging/Log;)V

    .line 170
    throw v2

    .line 173
    :cond_2
    :goto_0
    invoke-virtual {p0}, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleAE;->isStrict()Z

    move-result v3

    if-nez v3, :cond_3

    iget-object v3, p0, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleAE;->cryptoConfig:Lcom/amazonaws/services/s3/model/CryptoConfiguration;

    invoke-virtual {v3}, Lcom/amazonaws/services/s3/model/CryptoConfiguration;->isIgnoreMissingInstructionFile()Z

    move-result v3

    if-eqz v3, :cond_3

    .line 181
    iget-object v3, p0, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleAE;->log:Lcom/amazonaws/logging/Log;

    .line 184
    invoke-virtual {p4}, Lcom/amazonaws/services/s3/model/S3Object;->getKey()Ljava/lang/String;

    move-result-object v4

    .line 185
    invoke-virtual {p4}, Lcom/amazonaws/services/s3/model/S3Object;->getBucketName()Ljava/lang/String;

    move-result-object v5

    filled-new-array {v4, v5}, [Ljava/lang/Object;

    move-result-object v4

    .line 181
    const-string v5, "Unable to detect encryption information for object \'%s\' in bucket \'%s\'. Returning object without decryption."

    invoke-static {v5, v4}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v4

    invoke-interface {v3, v4}, Lcom/amazonaws/logging/Log;->warn(Ljava/lang/Object;)V

    .line 187
    invoke-virtual {p0, v0, p2, v2}, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleAE;->adjustToDesiredRange(Lcom/amazonaws/services/s3/internal/crypto/S3ObjectWrapper;[JLjava/util/Map;)Lcom/amazonaws/services/s3/internal/crypto/S3ObjectWrapper;

    move-result-object v2

    .line 188
    .local v2, "adjusted":Lcom/amazonaws/services/s3/internal/crypto/S3ObjectWrapper;
    invoke-virtual {v2}, Lcom/amazonaws/services/s3/internal/crypto/S3ObjectWrapper;->getS3Object()Lcom/amazonaws/services/s3/model/S3Object;

    move-result-object v3

    return-object v3

    .line 174
    .end local v2    # "adjusted":Lcom/amazonaws/services/s3/internal/crypto/S3ObjectWrapper;
    :cond_3
    iget-object v2, p0, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleAE;->log:Lcom/amazonaws/logging/Log;

    invoke-static {v0, v2}, Lcom/amazonaws/util/IOUtils;->closeQuietly(Ljava/io/Closeable;Lcom/amazonaws/logging/Log;)V

    .line 175
    new-instance v2, Ljava/lang/SecurityException;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "Instruction file not found for S3 object with bucket name: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    .line 176
    invoke-virtual {p4}, Lcom/amazonaws/services/s3/model/S3Object;->getBucketName()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, ", key: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    .line 177
    invoke-virtual {p4}, Lcom/amazonaws/services/s3/model/S3Object;->getKey()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-direct {v2, v3}, Ljava/lang/SecurityException;-><init>(Ljava/lang/String;)V

    throw v2
.end method

.method private decipherWithInstFileSuffix(Lcom/amazonaws/services/s3/model/GetObjectRequest;[J[JLcom/amazonaws/services/s3/model/S3Object;Ljava/lang/String;)Lcom/amazonaws/services/s3/model/S3Object;
    .locals 8
    .param p1, "req"    # Lcom/amazonaws/services/s3/model/GetObjectRequest;
    .param p2, "desiredRange"    # [J
    .param p3, "cryptoRange"    # [J
    .param p4, "retrieved"    # Lcom/amazonaws/services/s3/model/S3Object;
    .param p5, "instFileSuffix"    # Ljava/lang/String;

    .line 200
    invoke-virtual {p1}, Lcom/amazonaws/services/s3/model/GetObjectRequest;->getS3ObjectId()Lcom/amazonaws/services/s3/model/S3ObjectId;

    move-result-object v0

    .line 202
    .local v0, "id":Lcom/amazonaws/services/s3/model/S3ObjectId;
    invoke-virtual {p0, v0, p5}, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleAE;->fetchInstructionFile(Lcom/amazonaws/services/s3/model/S3ObjectId;Ljava/lang/String;)Lcom/amazonaws/services/s3/internal/crypto/S3ObjectWrapper;

    move-result-object v7

    .line 203
    .local v7, "ifile":Lcom/amazonaws/services/s3/internal/crypto/S3ObjectWrapper;
    if-eqz v7, :cond_1

    .line 208
    :try_start_0
    invoke-virtual {v7}, Lcom/amazonaws/services/s3/internal/crypto/S3ObjectWrapper;->isInstructionFile()Z

    move-result v1

    if-eqz v1, :cond_0

    .line 209
    new-instance v5, Lcom/amazonaws/services/s3/internal/crypto/S3ObjectWrapper;

    invoke-direct {v5, p4, v0}, Lcom/amazonaws/services/s3/internal/crypto/S3ObjectWrapper;-><init>(Lcom/amazonaws/services/s3/model/S3Object;Lcom/amazonaws/services/s3/model/S3ObjectId;)V

    move-object v1, p0

    move-object v2, p1

    move-object v3, p2

    move-object v4, p3

    move-object v6, v7

    invoke-direct/range {v1 .. v6}, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleAE;->decipherWithInstructionFile(Lcom/amazonaws/services/s3/model/GetObjectRequest;[J[JLcom/amazonaws/services/s3/internal/crypto/S3ObjectWrapper;Lcom/amazonaws/services/s3/internal/crypto/S3ObjectWrapper;)Lcom/amazonaws/services/s3/model/S3Object;

    move-result-object v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 217
    iget-object v2, p0, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleAE;->log:Lcom/amazonaws/logging/Log;

    invoke-static {v7, v2}, Lcom/amazonaws/util/IOUtils;->closeQuietly(Ljava/io/Closeable;Lcom/amazonaws/logging/Log;)V

    .line 209
    return-object v1

    .line 212
    :cond_0
    :try_start_1
    new-instance v1, Lcom/amazonaws/AmazonClientException;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Invalid Instruction file with suffix "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " detected for "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p4}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2}, Lcom/amazonaws/AmazonClientException;-><init>(Ljava/lang/String;)V

    .end local v0    # "id":Lcom/amazonaws/services/s3/model/S3ObjectId;
    .end local v7    # "ifile":Lcom/amazonaws/services/s3/internal/crypto/S3ObjectWrapper;
    .end local p1    # "req":Lcom/amazonaws/services/s3/model/GetObjectRequest;
    .end local p2    # "desiredRange":[J
    .end local p3    # "cryptoRange":[J
    .end local p4    # "retrieved":Lcom/amazonaws/services/s3/model/S3Object;
    .end local p5    # "instFileSuffix":Ljava/lang/String;
    throw v1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 217
    .restart local v0    # "id":Lcom/amazonaws/services/s3/model/S3ObjectId;
    .restart local v7    # "ifile":Lcom/amazonaws/services/s3/internal/crypto/S3ObjectWrapper;
    .restart local p1    # "req":Lcom/amazonaws/services/s3/model/GetObjectRequest;
    .restart local p2    # "desiredRange":[J
    .restart local p3    # "cryptoRange":[J
    .restart local p4    # "retrieved":Lcom/amazonaws/services/s3/model/S3Object;
    .restart local p5    # "instFileSuffix":Ljava/lang/String;
    :catchall_0
    move-exception v1

    iget-object v2, p0, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleAE;->log:Lcom/amazonaws/logging/Log;

    invoke-static {v7, v2}, Lcom/amazonaws/util/IOUtils;->closeQuietly(Ljava/io/Closeable;Lcom/amazonaws/logging/Log;)V

    .line 218
    throw v1

    .line 204
    :cond_1
    new-instance v1, Lcom/amazonaws/AmazonClientException;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Instruction file with suffix "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " is not found for "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p4}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2}, Lcom/amazonaws/AmazonClientException;-><init>(Ljava/lang/String;)V

    throw v1
.end method

.method private decipherWithInstructionFile(Lcom/amazonaws/services/s3/model/GetObjectRequest;[J[JLcom/amazonaws/services/s3/internal/crypto/S3ObjectWrapper;Lcom/amazonaws/services/s3/internal/crypto/S3ObjectWrapper;)Lcom/amazonaws/services/s3/model/S3Object;
    .locals 14
    .param p1, "req"    # Lcom/amazonaws/services/s3/model/GetObjectRequest;
    .param p2, "desiredRange"    # [J
    .param p3, "cryptoRange"    # [J
    .param p4, "retrieved"    # Lcom/amazonaws/services/s3/internal/crypto/S3ObjectWrapper;
    .param p5, "instructionFile"    # Lcom/amazonaws/services/s3/internal/crypto/S3ObjectWrapper;

    .line 224
    move-object v0, p0

    move-object v1, p1

    move-object/from16 v2, p4

    sget-object v3, Lcom/amazonaws/services/s3/model/ExtraMaterialsDescription;->NONE:Lcom/amazonaws/services/s3/model/ExtraMaterialsDescription;

    .line 225
    .local v3, "extraMatDesc":Lcom/amazonaws/services/s3/model/ExtraMaterialsDescription;
    invoke-virtual {p0}, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleAE;->isStrict()Z

    move-result v4

    .line 226
    .local v4, "keyWrapExpected":Z
    instance-of v5, v1, Lcom/amazonaws/services/s3/model/EncryptedGetObjectRequest;

    if-eqz v5, :cond_0

    .line 227
    move-object v5, v1

    check-cast v5, Lcom/amazonaws/services/s3/model/EncryptedGetObjectRequest;

    .line 228
    .local v5, "ereq":Lcom/amazonaws/services/s3/model/EncryptedGetObjectRequest;
    invoke-virtual {v5}, Lcom/amazonaws/services/s3/model/EncryptedGetObjectRequest;->getExtraMaterialDescription()Lcom/amazonaws/services/s3/model/ExtraMaterialsDescription;

    move-result-object v3

    .line 229
    if-nez v4, :cond_0

    .line 230
    invoke-virtual {v5}, Lcom/amazonaws/services/s3/model/EncryptedGetObjectRequest;->isKeyWrapExpected()Z

    move-result v4

    .line 233
    .end local v5    # "ereq":Lcom/amazonaws/services/s3/model/EncryptedGetObjectRequest;
    :cond_0
    invoke-virtual/range {p5 .. p5}, Lcom/amazonaws/services/s3/internal/crypto/S3ObjectWrapper;->toJsonString()Ljava/lang/String;

    move-result-object v5

    .line 235
    .local v5, "json":Ljava/lang/String;
    nop

    .line 236
    invoke-static {v5}, Lcom/amazonaws/util/json/JsonUtils;->jsonToMap(Ljava/lang/String;)Ljava/util/Map;

    move-result-object v6

    invoke-static {v6}, Ljava/util/Collections;->unmodifiableMap(Ljava/util/Map;)Ljava/util/Map;

    move-result-object v13

    .line 237
    .local v13, "matdesc":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    iget-object v7, v0, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleAE;->kekMaterialsProvider:Lcom/amazonaws/services/s3/model/EncryptionMaterialsProvider;

    iget-object v6, v0, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleAE;->cryptoConfig:Lcom/amazonaws/services/s3/model/CryptoConfiguration;

    .line 241
    invoke-virtual {v6}, Lcom/amazonaws/services/s3/model/CryptoConfiguration;->getCryptoProvider()Ljava/security/Provider;

    move-result-object v8

    iget-object v12, v0, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleAE;->kms:Lcom/amazonaws/services/kms/AWSKMSClient;

    .line 238
    move-object v6, v13

    move-object/from16 v9, p3

    move-object v10, v3

    move v11, v4

    invoke-static/range {v6 .. v12}, Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;->fromInstructionFile(Ljava/util/Map;Lcom/amazonaws/services/s3/model/EncryptionMaterialsAccessor;Ljava/security/Provider;[JLcom/amazonaws/services/s3/model/ExtraMaterialsDescription;ZLcom/amazonaws/services/kms/AWSKMSClient;)Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;

    move-result-object v6

    .line 247
    .local v6, "cekMaterial":Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;
    invoke-virtual {p0, v6, v2}, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleAE;->securityCheck(Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;Lcom/amazonaws/services/s3/internal/crypto/S3ObjectWrapper;)V

    .line 248
    move-object/from16 v7, p3

    invoke-direct {p0, v2, v6, v7}, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleAE;->decrypt(Lcom/amazonaws/services/s3/internal/crypto/S3ObjectWrapper;Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;[J)Lcom/amazonaws/services/s3/internal/crypto/S3ObjectWrapper;

    move-result-object v8

    .line 250
    .local v8, "decrypted":Lcom/amazonaws/services/s3/internal/crypto/S3ObjectWrapper;
    move-object/from16 v9, p2

    invoke-virtual {p0, v8, v9, v13}, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleAE;->adjustToDesiredRange(Lcom/amazonaws/services/s3/internal/crypto/S3ObjectWrapper;[JLjava/util/Map;)Lcom/amazonaws/services/s3/internal/crypto/S3ObjectWrapper;

    move-result-object v10

    .line 252
    .local v10, "adjusted":Lcom/amazonaws/services/s3/internal/crypto/S3ObjectWrapper;
    invoke-virtual {v10}, Lcom/amazonaws/services/s3/internal/crypto/S3ObjectWrapper;->getS3Object()Lcom/amazonaws/services/s3/model/S3Object;

    move-result-object v11

    return-object v11
.end method

.method private decipherWithMetadata(Lcom/amazonaws/services/s3/model/GetObjectRequest;[J[JLcom/amazonaws/services/s3/internal/crypto/S3ObjectWrapper;)Lcom/amazonaws/services/s3/model/S3Object;
    .locals 10
    .param p1, "req"    # Lcom/amazonaws/services/s3/model/GetObjectRequest;
    .param p2, "desiredRange"    # [J
    .param p3, "cryptoRange"    # [J
    .param p4, "retrieved"    # Lcom/amazonaws/services/s3/internal/crypto/S3ObjectWrapper;

    .line 258
    sget-object v0, Lcom/amazonaws/services/s3/model/ExtraMaterialsDescription;->NONE:Lcom/amazonaws/services/s3/model/ExtraMaterialsDescription;

    .line 259
    .local v0, "extraMatDesc":Lcom/amazonaws/services/s3/model/ExtraMaterialsDescription;
    invoke-virtual {p0}, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleAE;->isStrict()Z

    move-result v1

    .line 260
    .local v1, "keyWrapExpected":Z
    instance-of v2, p1, Lcom/amazonaws/services/s3/model/EncryptedGetObjectRequest;

    if-eqz v2, :cond_0

    .line 261
    move-object v2, p1

    check-cast v2, Lcom/amazonaws/services/s3/model/EncryptedGetObjectRequest;

    .line 262
    .local v2, "ereq":Lcom/amazonaws/services/s3/model/EncryptedGetObjectRequest;
    invoke-virtual {v2}, Lcom/amazonaws/services/s3/model/EncryptedGetObjectRequest;->getExtraMaterialDescription()Lcom/amazonaws/services/s3/model/ExtraMaterialsDescription;

    move-result-object v0

    .line 263
    if-nez v1, :cond_0

    .line 264
    invoke-virtual {v2}, Lcom/amazonaws/services/s3/model/EncryptedGetObjectRequest;->isKeyWrapExpected()Z

    move-result v1

    .line 267
    .end local v2    # "ereq":Lcom/amazonaws/services/s3/model/EncryptedGetObjectRequest;
    :cond_0
    nop

    .line 268
    invoke-virtual {p4}, Lcom/amazonaws/services/s3/internal/crypto/S3ObjectWrapper;->getObjectMetadata()Lcom/amazonaws/services/s3/model/ObjectMetadata;

    move-result-object v3

    iget-object v4, p0, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleAE;->kekMaterialsProvider:Lcom/amazonaws/services/s3/model/EncryptionMaterialsProvider;

    iget-object v2, p0, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleAE;->cryptoConfig:Lcom/amazonaws/services/s3/model/CryptoConfiguration;

    .line 270
    invoke-virtual {v2}, Lcom/amazonaws/services/s3/model/CryptoConfiguration;->getCryptoProvider()Ljava/security/Provider;

    move-result-object v5

    iget-object v9, p0, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleAE;->kms:Lcom/amazonaws/services/kms/AWSKMSClient;

    .line 268
    move-object v6, p3

    move-object v7, v0

    move v8, v1

    invoke-static/range {v3 .. v9}, Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;->fromObjectMetadata(Lcom/amazonaws/services/s3/model/ObjectMetadata;Lcom/amazonaws/services/s3/model/EncryptionMaterialsAccessor;Ljava/security/Provider;[JLcom/amazonaws/services/s3/model/ExtraMaterialsDescription;ZLcom/amazonaws/services/kms/AWSKMSClient;)Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;

    move-result-object v2

    .line 277
    .local v2, "cekMaterial":Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;
    invoke-virtual {p0, v2, p4}, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleAE;->securityCheck(Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;Lcom/amazonaws/services/s3/internal/crypto/S3ObjectWrapper;)V

    .line 278
    invoke-direct {p0, p4, v2, p3}, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleAE;->decrypt(Lcom/amazonaws/services/s3/internal/crypto/S3ObjectWrapper;Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;[J)Lcom/amazonaws/services/s3/internal/crypto/S3ObjectWrapper;

    move-result-object v3

    .line 280
    .local v3, "decrypted":Lcom/amazonaws/services/s3/internal/crypto/S3ObjectWrapper;
    const/4 v4, 0x0

    invoke-virtual {p0, v3, p2, v4}, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleAE;->adjustToDesiredRange(Lcom/amazonaws/services/s3/internal/crypto/S3ObjectWrapper;[JLjava/util/Map;)Lcom/amazonaws/services/s3/internal/crypto/S3ObjectWrapper;

    move-result-object v4

    .line 282
    .local v4, "adjusted":Lcom/amazonaws/services/s3/internal/crypto/S3ObjectWrapper;
    invoke-virtual {v4}, Lcom/amazonaws/services/s3/internal/crypto/S3ObjectWrapper;->getS3Object()Lcom/amazonaws/services/s3/model/S3Object;

    move-result-object v5

    return-object v5
.end method

.method private decrypt(Lcom/amazonaws/services/s3/internal/crypto/S3ObjectWrapper;Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;[J)Lcom/amazonaws/services/s3/internal/crypto/S3ObjectWrapper;
    .locals 5
    .param p1, "wrapper"    # Lcom/amazonaws/services/s3/internal/crypto/S3ObjectWrapper;
    .param p2, "cekMaterial"    # Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;
    .param p3, "range"    # [J

    .line 420
    invoke-virtual {p1}, Lcom/amazonaws/services/s3/internal/crypto/S3ObjectWrapper;->getObjectContent()Lcom/amazonaws/services/s3/model/S3ObjectInputStream;

    move-result-object v0

    .line 421
    .local v0, "objectContent":Lcom/amazonaws/services/s3/model/S3ObjectInputStream;
    new-instance v1, Lcom/amazonaws/services/s3/model/S3ObjectInputStream;

    new-instance v2, Lcom/amazonaws/services/s3/internal/crypto/CipherLiteInputStream;

    .line 422
    invoke-virtual {p2}, Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;->getCipherLite()Lcom/amazonaws/services/s3/internal/crypto/CipherLite;

    move-result-object v3

    const/16 v4, 0x800

    invoke-direct {v2, v0, v3, v4}, Lcom/amazonaws/services/s3/internal/crypto/CipherLiteInputStream;-><init>(Ljava/io/InputStream;Lcom/amazonaws/services/s3/internal/crypto/CipherLite;I)V

    invoke-direct {v1, v2}, Lcom/amazonaws/services/s3/model/S3ObjectInputStream;-><init>(Ljava/io/InputStream;)V

    .line 421
    invoke-virtual {p1, v1}, Lcom/amazonaws/services/s3/internal/crypto/S3ObjectWrapper;->setObjectContent(Lcom/amazonaws/services/s3/model/S3ObjectInputStream;)V

    .line 424
    return-object p1
.end method


# virtual methods
.method protected final adjustToDesiredRange(Lcom/amazonaws/services/s3/internal/crypto/S3ObjectWrapper;[JLjava/util/Map;)Lcom/amazonaws/services/s3/internal/crypto/S3ObjectWrapper;
    .locals 17
    .param p1, "s3object"    # Lcom/amazonaws/services/s3/internal/crypto/S3ObjectWrapper;
    .param p2, "range"    # [J
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/amazonaws/services/s3/internal/crypto/S3ObjectWrapper;",
            "[J",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;)",
            "Lcom/amazonaws/services/s3/internal/crypto/S3ObjectWrapper;"
        }
    .end annotation

    .line 305
    .local p3, "instruction":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    move-object/from16 v1, p1

    if-nez p2, :cond_0

    .line 306
    return-object v1

    .line 310
    :cond_0
    move-object/from16 v2, p3

    invoke-virtual {v1, v2}, Lcom/amazonaws/services/s3/internal/crypto/S3ObjectWrapper;->encryptionSchemeOf(Ljava/util/Map;)Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoScheme;

    move-result-object v3

    .line 312
    .local v3, "encryptionScheme":Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoScheme;
    invoke-virtual/range {p1 .. p1}, Lcom/amazonaws/services/s3/internal/crypto/S3ObjectWrapper;->getObjectMetadata()Lcom/amazonaws/services/s3/model/ObjectMetadata;

    move-result-object v0

    invoke-virtual {v0}, Lcom/amazonaws/services/s3/model/ObjectMetadata;->getInstanceLength()J

    move-result-wide v4

    .line 313
    .local v4, "instanceLen":J
    invoke-virtual {v3}, Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoScheme;->getTagLengthInBits()I

    move-result v0

    div-int/lit8 v0, v0, 0x8

    int-to-long v6, v0

    sub-long v6, v4, v6

    const-wide/16 v8, 0x1

    sub-long/2addr v6, v8

    .line 314
    .local v6, "maxOffset":J
    const/4 v0, 0x1

    aget-wide v8, p2, v0

    cmp-long v8, v8, v6

    const/4 v9, 0x0

    if-lez v8, :cond_2

    .line 315
    aput-wide v6, p2, v0

    .line 316
    aget-wide v10, p2, v9

    aget-wide v12, p2, v0

    cmp-long v8, v10, v12

    if-lez v8, :cond_1

    .line 320
    invoke-virtual/range {p1 .. p1}, Lcom/amazonaws/services/s3/internal/crypto/S3ObjectWrapper;->getObjectContent()Lcom/amazonaws/services/s3/model/S3ObjectInputStream;

    move-result-object v0

    move-object/from16 v8, p0

    iget-object v10, v8, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleAE;->log:Lcom/amazonaws/logging/Log;

    invoke-static {v0, v10}, Lcom/amazonaws/util/IOUtils;->closeQuietly(Ljava/io/Closeable;Lcom/amazonaws/logging/Log;)V

    .line 321
    new-instance v0, Ljava/io/ByteArrayInputStream;

    new-array v9, v9, [B

    invoke-direct {v0, v9}, Ljava/io/ByteArrayInputStream;-><init>([B)V

    invoke-virtual {v1, v0}, Lcom/amazonaws/services/s3/internal/crypto/S3ObjectWrapper;->setObjectContent(Ljava/io/InputStream;)V

    .line 322
    return-object v1

    .line 316
    :cond_1
    move-object/from16 v8, p0

    goto :goto_0

    .line 314
    :cond_2
    move-object/from16 v8, p0

    .line 325
    :goto_0
    aget-wide v10, p2, v9

    aget-wide v12, p2, v0

    cmp-long v10, v10, v12

    if-lez v10, :cond_3

    .line 327
    return-object v1

    .line 330
    :cond_3
    :try_start_0
    invoke-virtual/range {p1 .. p1}, Lcom/amazonaws/services/s3/internal/crypto/S3ObjectWrapper;->getObjectContent()Lcom/amazonaws/services/s3/model/S3ObjectInputStream;

    move-result-object v12

    .line 331
    .local v12, "objectContent":Lcom/amazonaws/services/s3/model/S3ObjectInputStream;
    new-instance v10, Lcom/amazonaws/services/s3/internal/crypto/AdjustedRangeInputStream;

    aget-wide v13, p2, v9

    aget-wide v15, p2, v0

    move-object v11, v10

    invoke-direct/range {v11 .. v16}, Lcom/amazonaws/services/s3/internal/crypto/AdjustedRangeInputStream;-><init>(Ljava/io/InputStream;JJ)V

    move-object v0, v10

    .line 332
    .local v0, "adjustedRangeContents":Ljava/io/InputStream;
    new-instance v9, Lcom/amazonaws/services/s3/model/S3ObjectInputStream;

    invoke-direct {v9, v0}, Lcom/amazonaws/services/s3/model/S3ObjectInputStream;-><init>(Ljava/io/InputStream;)V

    invoke-virtual {v1, v9}, Lcom/amazonaws/services/s3/internal/crypto/S3ObjectWrapper;->setObjectContent(Lcom/amazonaws/services/s3/model/S3ObjectInputStream;)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 333
    return-object v1

    .line 334
    .end local v0    # "adjustedRangeContents":Ljava/io/InputStream;
    .end local v12    # "objectContent":Lcom/amazonaws/services/s3/model/S3ObjectInputStream;
    :catch_0
    move-exception v0

    .line 335
    .local v0, "e":Ljava/io/IOException;
    new-instance v9, Lcom/amazonaws/AmazonClientException;

    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    const-string v11, "Error adjusting output to desired byte range: "

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v0}, Ljava/io/IOException;->getMessage()Ljava/lang/String;

    move-result-object v11

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-direct {v9, v10}, Lcom/amazonaws/AmazonClientException;-><init>(Ljava/lang/String;)V

    throw v9
.end method

.method final cipherLiteForNextPart(Lcom/amazonaws/services/s3/internal/crypto/MultipartUploadCryptoContext;)Lcom/amazonaws/services/s3/internal/crypto/CipherLite;
    .locals 1
    .param p1, "uploadContext"    # Lcom/amazonaws/services/s3/internal/crypto/MultipartUploadCryptoContext;

    .line 387
    invoke-virtual {p1}, Lcom/amazonaws/services/s3/internal/crypto/MultipartUploadCryptoContext;->getCipherLite()Lcom/amazonaws/services/s3/internal/crypto/CipherLite;

    move-result-object v0

    return-object v0
.end method

.method protected final ciphertextLength(J)J
    .locals 2
    .param p1, "originalContentLength"    # J

    .line 446
    iget-object v0, p0, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleAE;->contentCryptoScheme:Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoScheme;

    invoke-virtual {v0}, Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoScheme;->getTagLengthInBits()I

    move-result v0

    div-int/lit8 v0, v0, 0x8

    int-to-long v0, v0

    add-long/2addr v0, p1

    return-wide v0
.end method

.method final computeLastPartSize(Lcom/amazonaws/services/s3/model/UploadPartRequest;)J
    .locals 4
    .param p1, "req"    # Lcom/amazonaws/services/s3/model/UploadPartRequest;

    .line 396
    invoke-virtual {p1}, Lcom/amazonaws/services/s3/model/UploadPartRequest;->getPartSize()J

    move-result-wide v0

    iget-object v2, p0, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleAE;->contentCryptoScheme:Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoScheme;

    .line 397
    invoke-virtual {v2}, Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoScheme;->getTagLengthInBits()I

    move-result v2

    div-int/lit8 v2, v2, 0x8

    int-to-long v2, v2

    add-long/2addr v0, v2

    .line 396
    return-wide v0
.end method

.method public getObjectSecurely(Lcom/amazonaws/services/s3/model/GetObjectRequest;Ljava/io/File;)Lcom/amazonaws/services/s3/model/ObjectMetadata;
    .locals 6
    .param p1, "getObjectRequest"    # Lcom/amazonaws/services/s3/model/GetObjectRequest;
    .param p2, "destinationFile"    # Ljava/io/File;

    .line 342
    const-string v0, "The destination file parameter must be specified when downloading an object directly to a file"

    invoke-direct {p0, p2, v0}, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleAE;->assertParameterNotNull(Ljava/lang/Object;Ljava/lang/String;)V

    .line 345
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleAE;->getObjectSecurely(Lcom/amazonaws/services/s3/model/GetObjectRequest;)Lcom/amazonaws/services/s3/model/S3Object;

    move-result-object v0

    .line 347
    .local v0, "s3Object":Lcom/amazonaws/services/s3/model/S3Object;
    if-nez v0, :cond_0

    .line 348
    const/4 v1, 0x0

    return-object v1

    .line 351
    :cond_0
    const/4 v1, 0x0

    .line 353
    .local v1, "outputStream":Ljava/io/OutputStream;
    :try_start_0
    new-instance v2, Ljava/io/BufferedOutputStream;

    new-instance v3, Ljava/io/FileOutputStream;

    invoke-direct {v3, p2}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V

    invoke-direct {v2, v3}, Ljava/io/BufferedOutputStream;-><init>(Ljava/io/OutputStream;)V

    move-object v1, v2

    .line 354
    const/16 v2, 0x2800

    new-array v2, v2, [B

    .line 356
    .local v2, "buffer":[B
    :goto_0
    invoke-virtual {v0}, Lcom/amazonaws/services/s3/model/S3Object;->getObjectContent()Lcom/amazonaws/services/s3/model/S3ObjectInputStream;

    move-result-object v3

    invoke-virtual {v3, v2}, Lcom/amazonaws/services/s3/model/S3ObjectInputStream;->read([B)I

    move-result v3

    move v4, v3

    .local v4, "bytesRead":I
    const/4 v5, -0x1

    if-le v3, v5, :cond_1

    .line 357
    const/4 v3, 0x0

    invoke-virtual {v1, v2, v3, v4}, Ljava/io/OutputStream;->write([BII)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    .line 363
    .end local v2    # "buffer":[B
    .end local v4    # "bytesRead":I
    :cond_1
    iget-object v2, p0, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleAE;->log:Lcom/amazonaws/logging/Log;

    invoke-static {v1, v2}, Lcom/amazonaws/util/IOUtils;->closeQuietly(Ljava/io/Closeable;Lcom/amazonaws/logging/Log;)V

    .line 364
    invoke-virtual {v0}, Lcom/amazonaws/services/s3/model/S3Object;->getObjectContent()Lcom/amazonaws/services/s3/model/S3ObjectInputStream;

    move-result-object v2

    iget-object v3, p0, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleAE;->log:Lcom/amazonaws/logging/Log;

    invoke-static {v2, v3}, Lcom/amazonaws/util/IOUtils;->closeQuietly(Ljava/io/Closeable;Lcom/amazonaws/logging/Log;)V

    .line 365
    nop

    .line 373
    invoke-virtual {v0}, Lcom/amazonaws/services/s3/model/S3Object;->getObjectMetadata()Lcom/amazonaws/services/s3/model/ObjectMetadata;

    move-result-object v2

    return-object v2

    .line 363
    :catchall_0
    move-exception v2

    goto :goto_1

    .line 359
    :catch_0
    move-exception v2

    .line 360
    .local v2, "e":Ljava/io/IOException;
    :try_start_1
    new-instance v3, Lcom/amazonaws/AmazonClientException;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "Unable to store object contents to disk: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    .line 361
    invoke-virtual {v2}, Ljava/io/IOException;->getMessage()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-direct {v3, v4, v2}, Lcom/amazonaws/AmazonClientException;-><init>(Ljava/lang/String;Ljava/lang/Throwable;)V

    .end local v0    # "s3Object":Lcom/amazonaws/services/s3/model/S3Object;
    .end local v1    # "outputStream":Ljava/io/OutputStream;
    .end local p1    # "getObjectRequest":Lcom/amazonaws/services/s3/model/GetObjectRequest;
    .end local p2    # "destinationFile":Ljava/io/File;
    throw v3
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 363
    .end local v2    # "e":Ljava/io/IOException;
    .restart local v0    # "s3Object":Lcom/amazonaws/services/s3/model/S3Object;
    .restart local v1    # "outputStream":Ljava/io/OutputStream;
    .restart local p1    # "getObjectRequest":Lcom/amazonaws/services/s3/model/GetObjectRequest;
    .restart local p2    # "destinationFile":Ljava/io/File;
    :goto_1
    iget-object v3, p0, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleAE;->log:Lcom/amazonaws/logging/Log;

    invoke-static {v1, v3}, Lcom/amazonaws/util/IOUtils;->closeQuietly(Ljava/io/Closeable;Lcom/amazonaws/logging/Log;)V

    .line 364
    invoke-virtual {v0}, Lcom/amazonaws/services/s3/model/S3Object;->getObjectContent()Lcom/amazonaws/services/s3/model/S3ObjectInputStream;

    move-result-object v3

    iget-object v4, p0, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleAE;->log:Lcom/amazonaws/logging/Log;

    invoke-static {v3, v4}, Lcom/amazonaws/util/IOUtils;->closeQuietly(Ljava/io/Closeable;Lcom/amazonaws/logging/Log;)V

    .line 365
    throw v2
.end method

.method public getObjectSecurely(Lcom/amazonaws/services/s3/model/GetObjectRequest;)Lcom/amazonaws/services/s3/model/S3Object;
    .locals 10
    .param p1, "req"    # Lcom/amazonaws/services/s3/model/GetObjectRequest;

    .line 113
    sget-object v0, Lcom/amazonaws/services/s3/AmazonS3EncryptionClient;->USER_AGENT:Ljava/lang/String;

    invoke-virtual {p0, p1, v0}, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleAE;->appendUserAgent(Lcom/amazonaws/AmazonWebServiceRequest;Ljava/lang/String;)Lcom/amazonaws/AmazonWebServiceRequest;

    .line 116
    invoke-virtual {p1}, Lcom/amazonaws/services/s3/model/GetObjectRequest;->getRange()[J

    move-result-object v0

    .line 117
    .local v0, "desiredRange":[J
    invoke-virtual {p0}, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleAE;->isStrict()Z

    move-result v1

    if-eqz v1, :cond_1

    if-nez v0, :cond_0

    invoke-virtual {p1}, Lcom/amazonaws/services/s3/model/GetObjectRequest;->getPartNumber()Ljava/lang/Integer;

    move-result-object v1

    if-nez v1, :cond_0

    goto :goto_0

    .line 118
    :cond_0
    new-instance v1, Ljava/lang/SecurityException;

    const-string v2, "Range get and getting a part are not allowed in strict crypto mode"

    invoke-direct {v1, v2}, Ljava/lang/SecurityException;-><init>(Ljava/lang/String;)V

    throw v1

    .line 120
    :cond_1
    :goto_0
    invoke-static {v0}, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleAE;->getAdjustedCryptoRange([J)[J

    move-result-object v7

    .line 121
    .local v7, "adjustedCryptoRange":[J
    if-eqz v7, :cond_2

    .line 122
    const/4 v1, 0x0

    aget-wide v1, v7, v1

    const/4 v3, 0x1

    aget-wide v3, v7, v3

    invoke-virtual {p1, v1, v2, v3, v4}, Lcom/amazonaws/services/s3/model/GetObjectRequest;->setRange(JJ)V

    .line 125
    :cond_2
    iget-object v1, p0, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleAE;->s3:Lcom/amazonaws/services/s3/internal/S3Direct;

    invoke-virtual {v1, p1}, Lcom/amazonaws/services/s3/internal/S3Direct;->getObject(Lcom/amazonaws/services/s3/model/GetObjectRequest;)Lcom/amazonaws/services/s3/model/S3Object;

    move-result-object v8

    .line 128
    .local v8, "retrieved":Lcom/amazonaws/services/s3/model/S3Object;
    if-nez v8, :cond_3

    .line 129
    const/4 v1, 0x0

    return-object v1

    .line 131
    :cond_3
    const/4 v1, 0x0

    .line 132
    .local v1, "suffix":Ljava/lang/String;
    instance-of v2, p1, Lcom/amazonaws/services/s3/model/EncryptedGetObjectRequest;

    if-eqz v2, :cond_4

    .line 133
    move-object v2, p1

    check-cast v2, Lcom/amazonaws/services/s3/model/EncryptedGetObjectRequest;

    .line 134
    .local v2, "ereq":Lcom/amazonaws/services/s3/model/EncryptedGetObjectRequest;
    invoke-virtual {v2}, Lcom/amazonaws/services/s3/model/EncryptedGetObjectRequest;->getInstructionFileSuffix()Ljava/lang/String;

    move-result-object v1

    move-object v9, v1

    goto :goto_1

    .line 132
    .end local v2    # "ereq":Lcom/amazonaws/services/s3/model/EncryptedGetObjectRequest;
    :cond_4
    move-object v9, v1

    .line 137
    .end local v1    # "suffix":Ljava/lang/String;
    .local v9, "suffix":Ljava/lang/String;
    :goto_1
    if-eqz v9, :cond_6

    :try_start_0
    invoke-virtual {v9}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/String;->isEmpty()Z

    move-result v1

    if-eqz v1, :cond_5

    goto :goto_2

    .line 139
    :cond_5
    move-object v1, p0

    move-object v2, p1

    move-object v3, v0

    move-object v4, v7

    move-object v5, v8

    move-object v6, v9

    invoke-direct/range {v1 .. v6}, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleAE;->decipherWithInstFileSuffix(Lcom/amazonaws/services/s3/model/GetObjectRequest;[J[JLcom/amazonaws/services/s3/model/S3Object;Ljava/lang/String;)Lcom/amazonaws/services/s3/model/S3Object;

    move-result-object v1

    goto :goto_3

    .line 138
    :cond_6
    :goto_2
    invoke-direct {p0, p1, v0, v7, v8}, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleAE;->decipher(Lcom/amazonaws/services/s3/model/GetObjectRequest;[J[JLcom/amazonaws/services/s3/model/S3Object;)Lcom/amazonaws/services/s3/model/S3Object;

    move-result-object v1
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/Error; {:try_start_0 .. :try_end_0} :catch_0

    .line 137
    :goto_3
    return-object v1

    .line 146
    :catch_0
    move-exception v1

    .line 147
    .local v1, "error":Ljava/lang/Error;
    iget-object v2, p0, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleAE;->log:Lcom/amazonaws/logging/Log;

    invoke-static {v8, v2}, Lcom/amazonaws/util/IOUtils;->closeQuietly(Ljava/io/Closeable;Lcom/amazonaws/logging/Log;)V

    .line 148
    throw v1

    .line 141
    .end local v1    # "error":Ljava/lang/Error;
    :catch_1
    move-exception v1

    .line 144
    .local v1, "ex":Ljava/lang/RuntimeException;
    iget-object v2, p0, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleAE;->log:Lcom/amazonaws/logging/Log;

    invoke-static {v8, v2}, Lcom/amazonaws/util/IOUtils;->closeQuietly(Ljava/io/Closeable;Lcom/amazonaws/logging/Log;)V

    .line 145
    throw v1
.end method

.method protected isStrict()Z
    .locals 1

    .line 108
    const/4 v0, 0x0

    return v0
.end method

.method final newUploadContext(Lcom/amazonaws/services/s3/model/InitiateMultipartUploadRequest;Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;)Lcom/amazonaws/services/s3/internal/crypto/MultipartUploadCryptoContext;
    .locals 3
    .param p1, "req"    # Lcom/amazonaws/services/s3/model/InitiateMultipartUploadRequest;
    .param p2, "cekMaterial"    # Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;

    .line 379
    new-instance v0, Lcom/amazonaws/services/s3/internal/crypto/MultipartUploadCryptoContext;

    .line 380
    invoke-virtual {p1}, Lcom/amazonaws/services/s3/model/InitiateMultipartUploadRequest;->getBucketName()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p1}, Lcom/amazonaws/services/s3/model/InitiateMultipartUploadRequest;->getKey()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v0, v1, v2, p2}, Lcom/amazonaws/services/s3/internal/crypto/MultipartUploadCryptoContext;-><init>(Ljava/lang/String;Ljava/lang/String;Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;)V

    .line 379
    return-object v0
.end method

.method final updateUploadContext(Lcom/amazonaws/services/s3/internal/crypto/MultipartUploadCryptoContext;Lcom/amazonaws/internal/SdkFilterInputStream;)V
    .locals 0
    .param p1, "uploadContext"    # Lcom/amazonaws/services/s3/internal/crypto/MultipartUploadCryptoContext;
    .param p2, "is"    # Lcom/amazonaws/internal/SdkFilterInputStream;

    .line 402
    return-void
.end method

.method final wrapForMultipart(Lcom/amazonaws/services/s3/internal/crypto/CipherLiteInputStream;J)Lcom/amazonaws/internal/SdkFilterInputStream;
    .locals 0
    .param p1, "is"    # Lcom/amazonaws/services/s3/internal/crypto/CipherLiteInputStream;
    .param p2, "partSize"    # J

    .line 392
    return-object p1
.end method
