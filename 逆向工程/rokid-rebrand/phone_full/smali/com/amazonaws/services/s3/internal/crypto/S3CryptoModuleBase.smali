.class public abstract Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;
.super Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModule;
.source "S3CryptoModuleBase.java"


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "<T:",
        "Lcom/amazonaws/services/s3/internal/crypto/MultipartUploadCryptoContext;",
        ">",
        "Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModule<",
        "TT;>;"
    }
.end annotation

.annotation runtime Ljava/lang/Deprecated;
.end annotation


# static fields
.field protected static final DEFAULT_BUFFER_SIZE:I = 0x800

.field private static final IS_MULTI_PART:Z = true

.field private static final MAX_RETRY_COUNT:I = 0x9


# instance fields
.field protected final contentCryptoScheme:Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoScheme;

.field protected final cryptoConfig:Lcom/amazonaws/services/s3/model/CryptoConfiguration;

.field protected final cryptoScheme:Lcom/amazonaws/services/s3/internal/crypto/S3CryptoScheme;

.field protected final kekMaterialsProvider:Lcom/amazonaws/services/s3/model/EncryptionMaterialsProvider;

.field protected final kms:Lcom/amazonaws/services/kms/AWSKMSClient;

.field protected final log:Lcom/amazonaws/logging/Log;

.field protected final multipartUploadContexts:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "TT;>;"
        }
    .end annotation
.end field

.field protected final s3:Lcom/amazonaws/services/s3/internal/S3Direct;


# direct methods
.method protected constructor <init>(Lcom/amazonaws/services/kms/AWSKMSClient;Lcom/amazonaws/services/s3/internal/S3Direct;Lcom/amazonaws/auth/AWSCredentialsProvider;Lcom/amazonaws/services/s3/model/EncryptionMaterialsProvider;Lcom/amazonaws/services/s3/model/CryptoConfiguration;)V
    .locals 2
    .param p1, "kms"    # Lcom/amazonaws/services/kms/AWSKMSClient;
    .param p2, "s3"    # Lcom/amazonaws/services/s3/internal/S3Direct;
    .param p3, "credentialsProvider"    # Lcom/amazonaws/auth/AWSCredentialsProvider;
    .param p4, "kekMaterialsProvider"    # Lcom/amazonaws/services/s3/model/EncryptionMaterialsProvider;
    .param p5, "cryptoConfig"    # Lcom/amazonaws/services/s3/model/CryptoConfiguration;

    .line 123
    .local p0, "this":Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;, "Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase<TT;>;"
    invoke-direct {p0}, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModule;-><init>()V

    .line 105
    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v0

    invoke-static {v0}, Lcom/amazonaws/logging/LogFactory;->getLog(Ljava/lang/Class;)Lcom/amazonaws/logging/Log;

    move-result-object v0

    iput-object v0, p0, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;->log:Lcom/amazonaws/logging/Log;

    .line 112
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    .line 113
    invoke-static {v0}, Ljava/util/Collections;->synchronizedMap(Ljava/util/Map;)Ljava/util/Map;

    move-result-object v0

    iput-object v0, p0, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;->multipartUploadContexts:Ljava/util/Map;

    .line 124
    invoke-virtual {p5}, Lcom/amazonaws/services/s3/model/CryptoConfiguration;->isReadOnly()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 127
    iput-object p4, p0, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;->kekMaterialsProvider:Lcom/amazonaws/services/s3/model/EncryptionMaterialsProvider;

    .line 128
    iput-object p2, p0, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;->s3:Lcom/amazonaws/services/s3/internal/S3Direct;

    .line 129
    iput-object p5, p0, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;->cryptoConfig:Lcom/amazonaws/services/s3/model/CryptoConfiguration;

    .line 130
    invoke-virtual {p5}, Lcom/amazonaws/services/s3/model/CryptoConfiguration;->getCryptoMode()Lcom/amazonaws/services/s3/model/CryptoMode;

    move-result-object v0

    invoke-static {v0}, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoScheme;->from(Lcom/amazonaws/services/s3/model/CryptoMode;)Lcom/amazonaws/services/s3/internal/crypto/S3CryptoScheme;

    move-result-object v0

    iput-object v0, p0, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;->cryptoScheme:Lcom/amazonaws/services/s3/internal/crypto/S3CryptoScheme;

    .line 131
    iget-object v0, p0, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;->cryptoScheme:Lcom/amazonaws/services/s3/internal/crypto/S3CryptoScheme;

    invoke-virtual {v0}, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoScheme;->getContentCryptoScheme()Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoScheme;

    move-result-object v0

    iput-object v0, p0, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;->contentCryptoScheme:Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoScheme;

    .line 132
    iput-object p1, p0, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;->kms:Lcom/amazonaws/services/kms/AWSKMSClient;

    .line 133
    return-void

    .line 125
    :cond_0
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "The crypto configuration parameter is required to be read-only"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method protected constructor <init>(Lcom/amazonaws/services/s3/internal/S3Direct;Lcom/amazonaws/auth/AWSCredentialsProvider;Lcom/amazonaws/services/s3/model/EncryptionMaterialsProvider;Lcom/amazonaws/services/s3/model/CryptoConfiguration;)V
    .locals 1
    .param p1, "s3"    # Lcom/amazonaws/services/s3/internal/S3Direct;
    .param p2, "credentialsProvider"    # Lcom/amazonaws/auth/AWSCredentialsProvider;
    .param p3, "kekMaterialsProvider"    # Lcom/amazonaws/services/s3/model/EncryptionMaterialsProvider;
    .param p4, "cryptoConfig"    # Lcom/amazonaws/services/s3/model/CryptoConfiguration;

    .line 141
    .local p0, "this":Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;, "Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase<TT;>;"
    invoke-direct {p0}, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModule;-><init>()V

    .line 105
    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v0

    invoke-static {v0}, Lcom/amazonaws/logging/LogFactory;->getLog(Ljava/lang/Class;)Lcom/amazonaws/logging/Log;

    move-result-object v0

    iput-object v0, p0, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;->log:Lcom/amazonaws/logging/Log;

    .line 112
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    .line 113
    invoke-static {v0}, Ljava/util/Collections;->synchronizedMap(Ljava/util/Map;)Ljava/util/Map;

    move-result-object v0

    iput-object v0, p0, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;->multipartUploadContexts:Ljava/util/Map;

    .line 142
    iput-object p3, p0, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;->kekMaterialsProvider:Lcom/amazonaws/services/s3/model/EncryptionMaterialsProvider;

    .line 143
    iput-object p1, p0, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;->s3:Lcom/amazonaws/services/s3/internal/S3Direct;

    .line 144
    iput-object p4, p0, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;->cryptoConfig:Lcom/amazonaws/services/s3/model/CryptoConfiguration;

    .line 145
    invoke-virtual {p4}, Lcom/amazonaws/services/s3/model/CryptoConfiguration;->getCryptoMode()Lcom/amazonaws/services/s3/model/CryptoMode;

    move-result-object v0

    invoke-static {v0}, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoScheme;->from(Lcom/amazonaws/services/s3/model/CryptoMode;)Lcom/amazonaws/services/s3/internal/crypto/S3CryptoScheme;

    move-result-object v0

    iput-object v0, p0, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;->cryptoScheme:Lcom/amazonaws/services/s3/internal/crypto/S3CryptoScheme;

    .line 146
    iget-object v0, p0, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;->cryptoScheme:Lcom/amazonaws/services/s3/internal/crypto/S3CryptoScheme;

    invoke-virtual {v0}, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoScheme;->getContentCryptoScheme()Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoScheme;

    move-result-object v0

    iput-object v0, p0, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;->contentCryptoScheme:Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoScheme;

    .line 147
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;->kms:Lcom/amazonaws/services/kms/AWSKMSClient;

    .line 148
    return-void
.end method

.method private buildContentCryptoMaterial(Lcom/amazonaws/services/s3/model/EncryptionMaterials;Ljava/security/Provider;Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;
    .locals 8
    .param p1, "materials"    # Lcom/amazonaws/services/s3/model/EncryptionMaterials;
    .param p2, "provider"    # Ljava/security/Provider;
    .param p3, "req"    # Lcom/amazonaws/AmazonWebServiceRequest;

    .line 538
    .local p0, "this":Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;, "Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase<TT;>;"
    iget-object v0, p0, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;->contentCryptoScheme:Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoScheme;

    invoke-virtual {v0}, Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoScheme;->getIVLengthInBytes()I

    move-result v0

    new-array v0, v0, [B

    .line 539
    .local v0, "iv":[B
    iget-object v1, p0, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;->cryptoScheme:Lcom/amazonaws/services/s3/internal/crypto/S3CryptoScheme;

    invoke-virtual {v1}, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoScheme;->getSecureRandom()Ljava/security/SecureRandom;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/security/SecureRandom;->nextBytes([B)V

    .line 541
    invoke-virtual {p1}, Lcom/amazonaws/services/s3/model/EncryptionMaterials;->isKMSEnabled()Z

    move-result v1

    if-eqz v1, :cond_0

    .line 542
    nop

    .line 543
    invoke-static {p1, p3}, Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;->mergeMaterialDescriptions(Lcom/amazonaws/services/s3/model/EncryptionMaterials;Lcom/amazonaws/AmazonWebServiceRequest;)Ljava/util/Map;

    move-result-object v1

    .line 544
    .local v1, "encryptionContext":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    new-instance v2, Lcom/amazonaws/services/kms/model/GenerateDataKeyRequest;

    invoke-direct {v2}, Lcom/amazonaws/services/kms/model/GenerateDataKeyRequest;-><init>()V

    .line 545
    invoke-virtual {v2, v1}, Lcom/amazonaws/services/kms/model/GenerateDataKeyRequest;->withEncryptionContext(Ljava/util/Map;)Lcom/amazonaws/services/kms/model/GenerateDataKeyRequest;

    move-result-object v2

    .line 546
    invoke-virtual {p1}, Lcom/amazonaws/services/s3/model/EncryptionMaterials;->getCustomerMasterKeyId()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Lcom/amazonaws/services/kms/model/GenerateDataKeyRequest;->withKeyId(Ljava/lang/String;)Lcom/amazonaws/services/kms/model/GenerateDataKeyRequest;

    move-result-object v2

    iget-object v3, p0, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;->contentCryptoScheme:Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoScheme;

    .line 547
    invoke-virtual {v3}, Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoScheme;->getKeySpec()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Lcom/amazonaws/services/kms/model/GenerateDataKeyRequest;->withKeySpec(Ljava/lang/String;)Lcom/amazonaws/services/kms/model/GenerateDataKeyRequest;

    move-result-object v2

    .line 548
    .local v2, "keyGenReq":Lcom/amazonaws/services/kms/model/GenerateDataKeyRequest;
    nop

    .line 549
    invoke-virtual {p3}, Lcom/amazonaws/AmazonWebServiceRequest;->getGeneralProgressListener()Lcom/amazonaws/event/ProgressListener;

    move-result-object v3

    invoke-virtual {v2, v3}, Lcom/amazonaws/services/kms/model/GenerateDataKeyRequest;->withGeneralProgressListener(Lcom/amazonaws/event/ProgressListener;)Lcom/amazonaws/AmazonWebServiceRequest;

    move-result-object v3

    .line 550
    invoke-virtual {p3}, Lcom/amazonaws/AmazonWebServiceRequest;->getRequestMetricCollector()Lcom/amazonaws/metrics/RequestMetricCollector;

    move-result-object v4

    invoke-virtual {v3, v4}, Lcom/amazonaws/AmazonWebServiceRequest;->withRequestMetricCollector(Lcom/amazonaws/metrics/RequestMetricCollector;)Lcom/amazonaws/AmazonWebServiceRequest;

    .line 551
    iget-object v3, p0, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;->kms:Lcom/amazonaws/services/kms/AWSKMSClient;

    invoke-virtual {v3, v2}, Lcom/amazonaws/services/kms/AWSKMSClient;->generateDataKey(Lcom/amazonaws/services/kms/model/GenerateDataKeyRequest;)Lcom/amazonaws/services/kms/model/GenerateDataKeyResult;

    move-result-object v3

    .line 552
    .local v3, "keyGenRes":Lcom/amazonaws/services/kms/model/GenerateDataKeyResult;
    new-instance v4, Ljavax/crypto/spec/SecretKeySpec;

    .line 553
    invoke-virtual {v3}, Lcom/amazonaws/services/kms/model/GenerateDataKeyResult;->getPlaintext()Ljava/nio/ByteBuffer;

    move-result-object v5

    invoke-static {v5}, Lcom/amazonaws/util/BinaryUtils;->copyAllBytesFrom(Ljava/nio/ByteBuffer;)[B

    move-result-object v5

    iget-object v6, p0, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;->contentCryptoScheme:Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoScheme;

    .line 554
    invoke-virtual {v6}, Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoScheme;->getKeyGeneratorAlgorithm()Ljava/lang/String;

    move-result-object v6

    invoke-direct {v4, v5, v6}, Ljavax/crypto/spec/SecretKeySpec;-><init>([BLjava/lang/String;)V

    .line 555
    .local v4, "cek":Ljavax/crypto/SecretKey;
    invoke-virtual {v3}, Lcom/amazonaws/services/kms/model/GenerateDataKeyResult;->getCiphertextBlob()Ljava/nio/ByteBuffer;

    move-result-object v5

    invoke-static {v5}, Lcom/amazonaws/util/BinaryUtils;->copyAllBytesFrom(Ljava/nio/ByteBuffer;)[B

    move-result-object v5

    .line 556
    .local v5, "keyBlob":[B
    iget-object v6, p0, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;->contentCryptoScheme:Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoScheme;

    new-instance v7, Lcom/amazonaws/services/s3/internal/crypto/KMSSecuredCEK;

    invoke-direct {v7, v5, v1}, Lcom/amazonaws/services/s3/internal/crypto/KMSSecuredCEK;-><init>([BLjava/util/Map;)V

    invoke-static {v4, v0, v6, p2, v7}, Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;->wrap(Ljavax/crypto/SecretKey;[BLcom/amazonaws/services/s3/internal/crypto/ContentCryptoScheme;Ljava/security/Provider;Lcom/amazonaws/services/s3/internal/crypto/SecuredCEK;)Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;

    move-result-object v6

    return-object v6

    .line 561
    .end local v1    # "encryptionContext":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .end local v2    # "keyGenReq":Lcom/amazonaws/services/kms/model/GenerateDataKeyRequest;
    .end local v3    # "keyGenRes":Lcom/amazonaws/services/kms/model/GenerateDataKeyResult;
    .end local v4    # "cek":Ljavax/crypto/SecretKey;
    .end local v5    # "keyBlob":[B
    :cond_0
    nop

    .line 562
    invoke-virtual {p0, p1, p2}, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;->generateCEK(Lcom/amazonaws/services/s3/model/EncryptionMaterials;Ljava/security/Provider;)Ljavax/crypto/SecretKey;

    move-result-object v1

    iget-object v4, p0, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;->cryptoScheme:Lcom/amazonaws/services/s3/internal/crypto/S3CryptoScheme;

    iget-object v6, p0, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;->kms:Lcom/amazonaws/services/kms/AWSKMSClient;

    .line 561
    move-object v2, v0

    move-object v3, p1

    move-object v5, p2

    move-object v7, p3

    invoke-static/range {v1 .. v7}, Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;->create(Ljavax/crypto/SecretKey;[BLcom/amazonaws/services/s3/model/EncryptionMaterials;Lcom/amazonaws/services/s3/internal/crypto/S3CryptoScheme;Ljava/security/Provider;Lcom/amazonaws/services/kms/AWSKMSClient;Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;

    move-result-object v1

    return-object v1
.end method

.method private ccmFromJson(Ljava/lang/String;)Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;
    .locals 5
    .param p1, "json"    # Ljava/lang/String;

    .line 898
    .local p0, "this":Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;, "Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase<TT;>;"
    nop

    .line 899
    invoke-static {p1}, Lcom/amazonaws/util/json/JsonUtils;->jsonToMap(Ljava/lang/String;)Ljava/util/Map;

    move-result-object v0

    .line 898
    invoke-static {v0}, Ljava/util/Collections;->unmodifiableMap(Ljava/util/Map;)Ljava/util/Map;

    move-result-object v0

    .line 900
    .local v0, "instruction":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    iget-object v1, p0, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;->kekMaterialsProvider:Lcom/amazonaws/services/s3/model/EncryptionMaterialsProvider;

    iget-object v2, p0, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;->cryptoConfig:Lcom/amazonaws/services/s3/model/CryptoConfiguration;

    .line 903
    invoke-virtual {v2}, Lcom/amazonaws/services/s3/model/CryptoConfiguration;->getCryptoProvider()Ljava/security/Provider;

    move-result-object v2

    iget-object v3, p0, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;->kms:Lcom/amazonaws/services/kms/AWSKMSClient;

    .line 900
    const/4 v4, 0x0

    invoke-static {v0, v1, v2, v4, v3}, Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;->fromInstructionFile(Ljava/util/Map;Lcom/amazonaws/services/s3/model/EncryptionMaterialsAccessor;Ljava/security/Provider;ZLcom/amazonaws/services/kms/AWSKMSClient;)Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;

    move-result-object v1

    return-object v1
.end method

.method private contentCryptoMaterialOf(Lcom/amazonaws/services/s3/internal/crypto/S3ObjectWrapper;)Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;
    .locals 5
    .param p1, "s3w"    # Lcom/amazonaws/services/s3/internal/crypto/S3ObjectWrapper;

    .line 873
    .local p0, "this":Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;, "Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase<TT;>;"
    invoke-virtual {p1}, Lcom/amazonaws/services/s3/internal/crypto/S3ObjectWrapper;->hasEncryptionInfo()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 874
    nop

    .line 875
    invoke-virtual {p1}, Lcom/amazonaws/services/s3/internal/crypto/S3ObjectWrapper;->getObjectMetadata()Lcom/amazonaws/services/s3/model/ObjectMetadata;

    move-result-object v0

    iget-object v1, p0, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;->kekMaterialsProvider:Lcom/amazonaws/services/s3/model/EncryptionMaterialsProvider;

    iget-object v2, p0, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;->cryptoConfig:Lcom/amazonaws/services/s3/model/CryptoConfiguration;

    .line 877
    invoke-virtual {v2}, Lcom/amazonaws/services/s3/model/CryptoConfiguration;->getCryptoProvider()Ljava/security/Provider;

    move-result-object v2

    iget-object v3, p0, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;->kms:Lcom/amazonaws/services/kms/AWSKMSClient;

    .line 875
    const/4 v4, 0x0

    invoke-static {v0, v1, v2, v4, v3}, Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;->fromObjectMetadata(Lcom/amazonaws/services/s3/model/ObjectMetadata;Lcom/amazonaws/services/s3/model/EncryptionMaterialsAccessor;Ljava/security/Provider;ZLcom/amazonaws/services/kms/AWSKMSClient;)Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;

    move-result-object v0

    .line 874
    return-object v0

    .line 882
    :cond_0
    nop

    .line 883
    invoke-virtual {p1}, Lcom/amazonaws/services/s3/internal/crypto/S3ObjectWrapper;->getS3ObjectId()Lcom/amazonaws/services/s3/model/S3ObjectId;

    move-result-object v0

    const/4 v1, 0x0

    invoke-virtual {p0, v0, v1}, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;->fetchInstructionFile(Lcom/amazonaws/services/s3/model/S3ObjectId;Ljava/lang/String;)Lcom/amazonaws/services/s3/internal/crypto/S3ObjectWrapper;

    move-result-object v0

    .line 884
    .local v0, "origIfile":Lcom/amazonaws/services/s3/internal/crypto/S3ObjectWrapper;
    if-eqz v0, :cond_2

    .line 888
    invoke-virtual {v0}, Lcom/amazonaws/services/s3/internal/crypto/S3ObjectWrapper;->isInstructionFile()Z

    move-result v1

    if-eqz v1, :cond_1

    .line 892
    invoke-virtual {v0}, Lcom/amazonaws/services/s3/internal/crypto/S3ObjectWrapper;->toJsonString()Ljava/lang/String;

    move-result-object v1

    .line 893
    .local v1, "json":Ljava/lang/String;
    invoke-direct {p0, v1}, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;->ccmFromJson(Ljava/lang/String;)Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;

    move-result-object v2

    return-object v2

    .line 889
    .end local v1    # "json":Ljava/lang/String;
    :cond_1
    new-instance v1, Lcom/amazonaws/AmazonClientException;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Invalid instruction file for S3 object: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2}, Lcom/amazonaws/AmazonClientException;-><init>(Ljava/lang/String;)V

    throw v1

    .line 885
    :cond_2
    new-instance v1, Ljava/lang/IllegalArgumentException;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "S3 object is not encrypted: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v1
.end method

.method static getAdjustedCryptoRange([J)[J
    .locals 6
    .param p0, "range"    # [J

    .line 939
    if-eqz p0, :cond_1

    const/4 v0, 0x0

    aget-wide v1, p0, v0

    const/4 v3, 0x1

    aget-wide v4, p0, v3

    cmp-long v1, v1, v4

    if-lez v1, :cond_0

    goto :goto_0

    .line 942
    :cond_0
    const/4 v1, 0x2

    new-array v1, v1, [J

    .line 943
    .local v1, "adjustedCryptoRange":[J
    aget-wide v4, p0, v0

    invoke-static {v4, v5}, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;->getCipherBlockLowerBound(J)J

    move-result-wide v4

    aput-wide v4, v1, v0

    .line 944
    aget-wide v4, p0, v3

    invoke-static {v4, v5}, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;->getCipherBlockUpperBound(J)J

    move-result-wide v4

    aput-wide v4, v1, v3

    .line 945
    return-object v1

    .line 940
    .end local v1    # "adjustedCryptoRange":[J
    :cond_1
    :goto_0
    const/4 v0, 0x0

    return-object v0
.end method

.method private static getCipherBlockLowerBound(J)J
    .locals 9
    .param p0, "leftmostBytePosition"    # J

    .line 949
    const-wide/16 v0, 0x10

    .line 950
    .local v0, "cipherBlockSize":J
    const-wide/16 v2, 0x10

    rem-long v4, p0, v2

    .line 951
    .local v4, "offset":J
    sub-long v6, p0, v4

    sub-long/2addr v6, v2

    .line 952
    .local v6, "lowerBound":J
    const-wide/16 v2, 0x0

    cmp-long v8, v6, v2

    if-gez v8, :cond_0

    goto :goto_0

    :cond_0
    move-wide v2, v6

    :goto_0
    return-wide v2
.end method

.method private static getCipherBlockUpperBound(J)J
    .locals 8
    .param p0, "rightmostBytePosition"    # J

    .line 962
    const-wide/16 v0, 0x10

    .line 963
    .local v0, "cipherBlockSize":J
    const-wide/16 v2, 0x10

    rem-long v4, p0, v2

    sub-long v4, v2, v4

    .line 964
    .local v4, "offset":J
    add-long v6, p0, v4

    add-long/2addr v6, v2

    .line 965
    .local v6, "upperBound":J
    const-wide/16 v2, 0x0

    cmp-long v2, v6, v2

    if-gez v2, :cond_0

    const-wide v2, 0x7fffffffffffffffL

    goto :goto_0

    :cond_0
    move-wide v2, v6

    :goto_0
    return-wide v2
.end method

.method private newContentCryptoMaterial(Lcom/amazonaws/services/s3/model/EncryptionMaterialsProvider;Ljava/security/Provider;Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;
    .locals 3
    .param p1, "kekMaterialProvider"    # Lcom/amazonaws/services/s3/model/EncryptionMaterialsProvider;
    .param p2, "provider"    # Ljava/security/Provider;
    .param p3, "req"    # Lcom/amazonaws/AmazonWebServiceRequest;

    .line 499
    .local p0, "this":Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;, "Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase<TT;>;"
    invoke-interface {p1}, Lcom/amazonaws/services/s3/model/EncryptionMaterialsProvider;->getEncryptionMaterials()Lcom/amazonaws/services/s3/model/EncryptionMaterials;

    move-result-object v0

    .line 500
    .local v0, "kekMaterials":Lcom/amazonaws/services/s3/model/EncryptionMaterials;
    if-eqz v0, :cond_0

    .line 503
    invoke-direct {p0, v0, p2, p3}, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;->buildContentCryptoMaterial(Lcom/amazonaws/services/s3/model/EncryptionMaterials;Ljava/security/Provider;Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;

    move-result-object v1

    return-object v1

    .line 501
    :cond_0
    new-instance v1, Lcom/amazonaws/AmazonClientException;

    const-string v2, "No material available from the encryption material provider"

    invoke-direct {v1, v2}, Lcom/amazonaws/AmazonClientException;-><init>(Ljava/lang/String;)V

    throw v1
.end method

.method private newContentCryptoMaterial(Lcom/amazonaws/services/s3/model/EncryptionMaterialsProvider;Ljava/util/Map;Ljava/security/Provider;Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;
    .locals 2
    .param p1, "kekMaterialProvider"    # Lcom/amazonaws/services/s3/model/EncryptionMaterialsProvider;
    .param p3, "provider"    # Ljava/security/Provider;
    .param p4, "req"    # Lcom/amazonaws/AmazonWebServiceRequest;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/amazonaws/services/s3/model/EncryptionMaterialsProvider;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;",
            "Ljava/security/Provider;",
            "Lcom/amazonaws/AmazonWebServiceRequest;",
            ")",
            "Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;"
        }
    .end annotation

    .line 481
    .local p0, "this":Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;, "Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase<TT;>;"
    .local p2, "materialsDescription":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    nop

    .line 482
    invoke-interface {p1, p2}, Lcom/amazonaws/services/s3/model/EncryptionMaterialsProvider;->getEncryptionMaterials(Ljava/util/Map;)Lcom/amazonaws/services/s3/model/EncryptionMaterials;

    move-result-object v0

    .line 483
    .local v0, "kekMaterials":Lcom/amazonaws/services/s3/model/EncryptionMaterials;
    if-nez v0, :cond_0

    .line 484
    const/4 v1, 0x0

    return-object v1

    .line 486
    :cond_0
    invoke-direct {p0, v0, p3, p4}, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;->buildContentCryptoMaterial(Lcom/amazonaws/services/s3/model/EncryptionMaterials;Ljava/security/Provider;Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;

    move-result-object v1

    return-object v1
.end method

.method private newS3CipherLiteInputStream(Lcom/amazonaws/services/s3/model/AbstractPutObjectRequest;Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;J)Lcom/amazonaws/services/s3/internal/crypto/CipherLiteInputStream;
    .locals 6
    .param p1, "req"    # Lcom/amazonaws/services/s3/model/AbstractPutObjectRequest;
    .param p2, "cekMaterial"    # Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;
    .param p3, "plaintextLength"    # J

    .line 658
    .local p0, "this":Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;, "Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase<TT;>;"
    invoke-virtual {p1}, Lcom/amazonaws/services/s3/model/AbstractPutObjectRequest;->getFile()Ljava/io/File;

    move-result-object v0

    .line 659
    .local v0, "fileOrig":Ljava/io/File;
    invoke-virtual {p1}, Lcom/amazonaws/services/s3/model/AbstractPutObjectRequest;->getInputStream()Ljava/io/InputStream;

    move-result-object v1

    .line 660
    .local v1, "isOrig":Ljava/io/InputStream;
    const/4 v2, 0x0

    .line 662
    .local v2, "isCurr":Ljava/io/InputStream;
    if-nez v0, :cond_1

    .line 665
    if-nez v1, :cond_0

    const/4 v3, 0x0

    goto :goto_0

    :cond_0
    :try_start_0
    invoke-static {v1}, Lcom/amazonaws/internal/ReleasableInputStream;->wrap(Ljava/io/InputStream;)Lcom/amazonaws/internal/ReleasableInputStream;

    move-result-object v3

    :goto_0
    move-object v2, v3

    goto :goto_1

    .line 667
    :cond_1
    new-instance v3, Lcom/amazonaws/internal/ResettableInputStream;

    invoke-direct {v3, v0}, Lcom/amazonaws/internal/ResettableInputStream;-><init>(Ljava/io/File;)V

    move-object v2, v3

    .line 669
    :goto_1
    const-wide/16 v3, -0x1

    cmp-long v3, p3, v3

    if-lez v3, :cond_2

    .line 676
    new-instance v3, Lcom/amazonaws/util/LengthCheckInputStream;

    const/4 v4, 0x0

    invoke-direct {v3, v2, p3, p4, v4}, Lcom/amazonaws/util/LengthCheckInputStream;-><init>(Ljava/io/InputStream;JZ)V

    move-object v2, v3

    .line 679
    :cond_2
    invoke-virtual {p2}, Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;->getCipherLite()Lcom/amazonaws/services/s3/internal/crypto/CipherLite;

    move-result-object v3

    .line 681
    .local v3, "cipherLite":Lcom/amazonaws/services/s3/internal/crypto/CipherLite;
    invoke-virtual {v3}, Lcom/amazonaws/services/s3/internal/crypto/CipherLite;->markSupported()Z

    move-result v4

    const/16 v5, 0x800

    if-eqz v4, :cond_3

    .line 682
    new-instance v4, Lcom/amazonaws/services/s3/internal/crypto/CipherLiteInputStream;

    invoke-direct {v4, v2, v3, v5}, Lcom/amazonaws/services/s3/internal/crypto/CipherLiteInputStream;-><init>(Ljava/io/InputStream;Lcom/amazonaws/services/s3/internal/crypto/CipherLite;I)V

    return-object v4

    .line 685
    :cond_3
    new-instance v4, Lcom/amazonaws/services/s3/internal/crypto/RenewableCipherLiteInputStream;

    invoke-direct {v4, v2, v3, v5}, Lcom/amazonaws/services/s3/internal/crypto/RenewableCipherLiteInputStream;-><init>(Ljava/io/InputStream;Lcom/amazonaws/services/s3/internal/crypto/CipherLite;I)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-object v4

    .line 688
    .end local v3    # "cipherLite":Lcom/amazonaws/services/s3/internal/crypto/CipherLite;
    :catch_0
    move-exception v3

    .line 689
    .local v3, "e":Ljava/lang/Exception;
    iget-object v4, p0, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;->log:Lcom/amazonaws/logging/Log;

    invoke-static {p1, v0, v1, v2, v4}, Lcom/amazonaws/services/s3/model/S3DataSource$Utils;->cleanupDataSource(Lcom/amazonaws/services/s3/model/S3DataSource;Ljava/io/File;Ljava/io/InputStream;Ljava/io/InputStream;Lcom/amazonaws/logging/Log;)V

    .line 690
    new-instance v4, Lcom/amazonaws/AmazonClientException;

    const-string v5, "Unable to create cipher input stream"

    invoke-direct {v4, v5, v3}, Lcom/amazonaws/AmazonClientException;-><init>(Ljava/lang/String;Ljava/lang/Throwable;)V

    throw v4
.end method

.method private putObjectUsingInstructionFile(Lcom/amazonaws/services/s3/model/PutObjectRequest;)Lcom/amazonaws/services/s3/model/PutObjectResult;
    .locals 8
    .param p1, "putObjectRequest"    # Lcom/amazonaws/services/s3/model/PutObjectRequest;

    .line 200
    .local p0, "this":Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;, "Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase<TT;>;"
    invoke-virtual {p1}, Lcom/amazonaws/services/s3/model/PutObjectRequest;->getFile()Ljava/io/File;

    move-result-object v0

    .line 201
    .local v0, "fileOrig":Ljava/io/File;
    invoke-virtual {p1}, Lcom/amazonaws/services/s3/model/PutObjectRequest;->getInputStream()Ljava/io/InputStream;

    move-result-object v1

    .line 202
    .local v1, "isOrig":Ljava/io/InputStream;
    invoke-virtual {p1}, Lcom/amazonaws/services/s3/model/PutObjectRequest;->clone()Lcom/amazonaws/services/s3/model/PutObjectRequest;

    move-result-object v2

    .line 203
    const/4 v3, 0x0

    invoke-virtual {v2, v3}, Lcom/amazonaws/services/s3/model/PutObjectRequest;->withFile(Ljava/io/File;)Lcom/amazonaws/services/s3/model/PutObjectRequest;

    move-result-object v2

    .line 204
    invoke-virtual {v2, v3}, Lcom/amazonaws/services/s3/model/PutObjectRequest;->withInputStream(Ljava/io/InputStream;)Lcom/amazonaws/services/s3/model/PutObjectRequest;

    move-result-object v2

    .line 205
    .local v2, "putInstFileRequest":Lcom/amazonaws/services/s3/model/PutObjectRequest;
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2}, Lcom/amazonaws/services/s3/model/PutObjectRequest;->getKey()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "."

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "instruction"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Lcom/amazonaws/services/s3/model/PutObjectRequest;->setKey(Ljava/lang/String;)V

    .line 208
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;->createContentCryptoMaterial(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;

    move-result-object v3

    .line 211
    .local v3, "cekMaterial":Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;
    invoke-virtual {p0, p1, v3}, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;->wrapWithCipher(Lcom/amazonaws/services/s3/model/AbstractPutObjectRequest;Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;)Lcom/amazonaws/services/s3/model/AbstractPutObjectRequest;

    move-result-object v4

    check-cast v4, Lcom/amazonaws/services/s3/model/PutObjectRequest;

    .line 215
    .local v4, "req":Lcom/amazonaws/services/s3/model/PutObjectRequest;
    :try_start_0
    iget-object v5, p0, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;->s3:Lcom/amazonaws/services/s3/internal/S3Direct;

    invoke-virtual {v5, v4}, Lcom/amazonaws/services/s3/internal/S3Direct;->putObject(Lcom/amazonaws/services/s3/model/PutObjectRequest;)Lcom/amazonaws/services/s3/model/PutObjectResult;

    move-result-object v5
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 217
    .local v5, "result":Lcom/amazonaws/services/s3/model/PutObjectResult;
    nop

    .line 218
    invoke-virtual {v4}, Lcom/amazonaws/services/s3/model/PutObjectRequest;->getInputStream()Ljava/io/InputStream;

    move-result-object v6

    iget-object v7, p0, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;->log:Lcom/amazonaws/logging/Log;

    .line 217
    invoke-static {p1, v0, v1, v6, v7}, Lcom/amazonaws/services/s3/model/S3DataSource$Utils;->cleanupDataSource(Lcom/amazonaws/services/s3/model/S3DataSource;Ljava/io/File;Ljava/io/InputStream;Ljava/io/InputStream;Lcom/amazonaws/logging/Log;)V

    .line 219
    nop

    .line 221
    iget-object v6, p0, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;->s3:Lcom/amazonaws/services/s3/internal/S3Direct;

    invoke-virtual {p0, v2, v3}, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;->updateInstructionPutRequest(Lcom/amazonaws/services/s3/model/PutObjectRequest;Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;)Lcom/amazonaws/services/s3/model/PutObjectRequest;

    move-result-object v7

    invoke-virtual {v6, v7}, Lcom/amazonaws/services/s3/internal/S3Direct;->putObject(Lcom/amazonaws/services/s3/model/PutObjectRequest;)Lcom/amazonaws/services/s3/model/PutObjectResult;

    .line 224
    return-object v5

    .line 217
    .end local v5    # "result":Lcom/amazonaws/services/s3/model/PutObjectResult;
    :catchall_0
    move-exception v5

    .line 218
    invoke-virtual {v4}, Lcom/amazonaws/services/s3/model/PutObjectRequest;->getInputStream()Ljava/io/InputStream;

    move-result-object v6

    iget-object v7, p0, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;->log:Lcom/amazonaws/logging/Log;

    .line 217
    invoke-static {p1, v0, v1, v6, v7}, Lcom/amazonaws/services/s3/model/S3DataSource$Utils;->cleanupDataSource(Lcom/amazonaws/services/s3/model/S3DataSource;Ljava/io/File;Ljava/io/InputStream;Ljava/io/InputStream;Lcom/amazonaws/logging/Log;)V

    .line 219
    throw v5
.end method

.method private putObjectUsingMetadata(Lcom/amazonaws/services/s3/model/PutObjectRequest;)Lcom/amazonaws/services/s3/model/PutObjectResult;
    .locals 7
    .param p1, "req"    # Lcom/amazonaws/services/s3/model/PutObjectRequest;

    .line 172
    .local p0, "this":Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;, "Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase<TT;>;"
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;->createContentCryptoMaterial(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;

    move-result-object v0

    .line 174
    .local v0, "cekMaterial":Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;
    invoke-virtual {p1}, Lcom/amazonaws/services/s3/model/PutObjectRequest;->getFile()Ljava/io/File;

    move-result-object v1

    .line 175
    .local v1, "fileOrig":Ljava/io/File;
    invoke-virtual {p1}, Lcom/amazonaws/services/s3/model/PutObjectRequest;->getInputStream()Ljava/io/InputStream;

    move-result-object v2

    .line 176
    .local v2, "isOrig":Ljava/io/InputStream;
    invoke-virtual {p0, p1, v0}, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;->wrapWithCipher(Lcom/amazonaws/services/s3/model/AbstractPutObjectRequest;Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;)Lcom/amazonaws/services/s3/model/AbstractPutObjectRequest;

    move-result-object v3

    check-cast v3, Lcom/amazonaws/services/s3/model/PutObjectRequest;

    .line 178
    .local v3, "wrappedReq":Lcom/amazonaws/services/s3/model/PutObjectRequest;
    nop

    .line 179
    invoke-virtual {p1}, Lcom/amazonaws/services/s3/model/PutObjectRequest;->getMetadata()Lcom/amazonaws/services/s3/model/ObjectMetadata;

    move-result-object v4

    invoke-virtual {p1}, Lcom/amazonaws/services/s3/model/PutObjectRequest;->getFile()Ljava/io/File;

    move-result-object v5

    .line 178
    invoke-virtual {p0, v4, v5, v0}, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;->updateMetadataWithContentCryptoMaterial(Lcom/amazonaws/services/s3/model/ObjectMetadata;Ljava/io/File;Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;)Lcom/amazonaws/services/s3/model/ObjectMetadata;

    move-result-object v4

    invoke-virtual {p1, v4}, Lcom/amazonaws/services/s3/model/PutObjectRequest;->setMetadata(Lcom/amazonaws/services/s3/model/ObjectMetadata;)V

    .line 182
    :try_start_0
    iget-object v4, p0, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;->s3:Lcom/amazonaws/services/s3/internal/S3Direct;

    invoke-virtual {v4, v3}, Lcom/amazonaws/services/s3/internal/S3Direct;->putObject(Lcom/amazonaws/services/s3/model/PutObjectRequest;)Lcom/amazonaws/services/s3/model/PutObjectResult;

    move-result-object v4
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 184
    invoke-virtual {v3}, Lcom/amazonaws/services/s3/model/PutObjectRequest;->getInputStream()Ljava/io/InputStream;

    move-result-object v5

    iget-object v6, p0, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;->log:Lcom/amazonaws/logging/Log;

    invoke-static {p1, v1, v2, v5, v6}, Lcom/amazonaws/services/s3/model/S3DataSource$Utils;->cleanupDataSource(Lcom/amazonaws/services/s3/model/S3DataSource;Ljava/io/File;Ljava/io/InputStream;Ljava/io/InputStream;Lcom/amazonaws/logging/Log;)V

    .line 182
    return-object v4

    .line 184
    :catchall_0
    move-exception v4

    invoke-virtual {v3}, Lcom/amazonaws/services/s3/model/PutObjectRequest;->getInputStream()Ljava/io/InputStream;

    move-result-object v5

    iget-object v6, p0, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;->log:Lcom/amazonaws/logging/Log;

    invoke-static {p1, v1, v2, v5, v6}, Lcom/amazonaws/services/s3/model/S3DataSource$Utils;->cleanupDataSource(Lcom/amazonaws/services/s3/model/S3DataSource;Ljava/io/File;Ljava/io/InputStream;Ljava/io/InputStream;Lcom/amazonaws/logging/Log;)V

    .line 185
    throw v4
.end method


# virtual methods
.method public final abortMultipartUploadSecurely(Lcom/amazonaws/services/s3/model/AbortMultipartUploadRequest;)V
    .locals 2
    .param p1, "req"    # Lcom/amazonaws/services/s3/model/AbortMultipartUploadRequest;

    .line 229
    .local p0, "this":Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;, "Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase<TT;>;"
    iget-object v0, p0, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;->s3:Lcom/amazonaws/services/s3/internal/S3Direct;

    invoke-virtual {v0, p1}, Lcom/amazonaws/services/s3/internal/S3Direct;->abortMultipartUpload(Lcom/amazonaws/services/s3/model/AbortMultipartUploadRequest;)V

    .line 230
    iget-object v0, p0, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;->multipartUploadContexts:Ljava/util/Map;

    invoke-virtual {p1}, Lcom/amazonaws/services/s3/model/AbortMultipartUploadRequest;->getUploadId()Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/Map;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    .line 231
    return-void
.end method

.method final appendUserAgent(Lcom/amazonaws/AmazonWebServiceRequest;Ljava/lang/String;)Lcom/amazonaws/AmazonWebServiceRequest;
    .locals 1
    .param p2, "userAgent"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<X:",
            "Lcom/amazonaws/AmazonWebServiceRequest;",
            ">(TX;",
            "Ljava/lang/String;",
            ")TX;"
        }
    .end annotation

    .line 764
    .local p0, "this":Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;, "Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase<TT;>;"
    .local p1, "request":Lcom/amazonaws/AmazonWebServiceRequest;, "TX;"
    invoke-virtual {p1}, Lcom/amazonaws/AmazonWebServiceRequest;->getRequestClientOptions()Lcom/amazonaws/RequestClientOptions;

    move-result-object v0

    invoke-virtual {v0, p2}, Lcom/amazonaws/RequestClientOptions;->appendUserAgent(Ljava/lang/String;)V

    .line 765
    return-object p1
.end method

.method abstract cipherLiteForNextPart(Lcom/amazonaws/services/s3/internal/crypto/MultipartUploadCryptoContext;)Lcom/amazonaws/services/s3/internal/crypto/CipherLite;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TT;)",
            "Lcom/amazonaws/services/s3/internal/crypto/CipherLite;"
        }
    .end annotation
.end method

.method protected abstract ciphertextLength(J)J
.end method

.method public completeMultipartUploadSecurely(Lcom/amazonaws/services/s3/model/CompleteMultipartUploadRequest;)Lcom/amazonaws/services/s3/model/CompleteMultipartUploadResult;
    .locals 7
    .param p1, "req"    # Lcom/amazonaws/services/s3/model/CompleteMultipartUploadRequest;

    .line 389
    .local p0, "this":Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;, "Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase<TT;>;"
    sget-object v0, Lcom/amazonaws/services/s3/AmazonS3EncryptionClient;->USER_AGENT:Ljava/lang/String;

    invoke-virtual {p0, p1, v0}, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;->appendUserAgent(Lcom/amazonaws/AmazonWebServiceRequest;Ljava/lang/String;)Lcom/amazonaws/AmazonWebServiceRequest;

    .line 390
    invoke-virtual {p1}, Lcom/amazonaws/services/s3/model/CompleteMultipartUploadRequest;->getUploadId()Ljava/lang/String;

    move-result-object v0

    .line 391
    .local v0, "uploadId":Ljava/lang/String;
    iget-object v1, p0, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;->multipartUploadContexts:Ljava/util/Map;

    invoke-interface {v1, v0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/amazonaws/services/s3/internal/crypto/MultipartUploadCryptoContext;

    .line 393
    .local v1, "uploadContext":Lcom/amazonaws/services/s3/internal/crypto/MultipartUploadCryptoContext;, "TT;"
    if-eqz v1, :cond_1

    invoke-virtual {v1}, Lcom/amazonaws/services/s3/internal/crypto/MultipartUploadCryptoContext;->hasFinalPartBeenSeen()Z

    move-result v2

    if-eqz v2, :cond_0

    goto :goto_0

    .line 394
    :cond_0
    new-instance v2, Lcom/amazonaws/AmazonClientException;

    const-string v3, "Unable to complete an encrypted multipart upload without being told which part was the last.  Without knowing which part was the last, the encrypted data in Amazon S3 is incomplete and corrupt."

    invoke-direct {v2, v3}, Lcom/amazonaws/AmazonClientException;-><init>(Ljava/lang/String;)V

    throw v2

    .line 398
    :cond_1
    :goto_0
    iget-object v2, p0, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;->s3:Lcom/amazonaws/services/s3/internal/S3Direct;

    invoke-virtual {v2, p1}, Lcom/amazonaws/services/s3/internal/S3Direct;->completeMultipartUpload(Lcom/amazonaws/services/s3/model/CompleteMultipartUploadRequest;)Lcom/amazonaws/services/s3/model/CompleteMultipartUploadResult;

    move-result-object v2

    .line 402
    .local v2, "result":Lcom/amazonaws/services/s3/model/CompleteMultipartUploadResult;
    if-eqz v1, :cond_2

    iget-object v3, p0, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;->cryptoConfig:Lcom/amazonaws/services/s3/model/CryptoConfiguration;

    .line 403
    invoke-virtual {v3}, Lcom/amazonaws/services/s3/model/CryptoConfiguration;->getStorageMode()Lcom/amazonaws/services/s3/model/CryptoStorageMode;

    move-result-object v3

    sget-object v4, Lcom/amazonaws/services/s3/model/CryptoStorageMode;->InstructionFile:Lcom/amazonaws/services/s3/model/CryptoStorageMode;

    if-ne v3, v4, :cond_2

    .line 405
    iget-object v3, p0, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;->s3:Lcom/amazonaws/services/s3/internal/S3Direct;

    .line 406
    invoke-virtual {v1}, Lcom/amazonaws/services/s3/internal/crypto/MultipartUploadCryptoContext;->getBucketName()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v1}, Lcom/amazonaws/services/s3/internal/crypto/MultipartUploadCryptoContext;->getKey()Ljava/lang/String;

    move-result-object v5

    .line 407
    invoke-virtual {v1}, Lcom/amazonaws/services/s3/internal/crypto/MultipartUploadCryptoContext;->getContentCryptoMaterial()Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;

    move-result-object v6

    .line 405
    invoke-virtual {p0, v4, v5, v6}, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;->createInstructionPutRequest(Ljava/lang/String;Ljava/lang/String;Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;)Lcom/amazonaws/services/s3/model/PutObjectRequest;

    move-result-object v4

    invoke-virtual {v3, v4}, Lcom/amazonaws/services/s3/internal/S3Direct;->putObject(Lcom/amazonaws/services/s3/model/PutObjectRequest;)Lcom/amazonaws/services/s3/model/PutObjectResult;

    .line 409
    :cond_2
    iget-object v3, p0, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;->multipartUploadContexts:Ljava/util/Map;

    invoke-interface {v3, v0}, Ljava/util/Map;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    .line 410
    return-object v2
.end method

.method abstract computeLastPartSize(Lcom/amazonaws/services/s3/model/UploadPartRequest;)J
.end method

.method public final copyPartSecurely(Lcom/amazonaws/services/s3/model/CopyPartRequest;)Lcom/amazonaws/services/s3/model/CopyPartResult;
    .locals 4
    .param p1, "copyPartRequest"    # Lcom/amazonaws/services/s3/model/CopyPartRequest;

    .line 235
    .local p0, "this":Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;, "Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase<TT;>;"
    invoke-virtual {p1}, Lcom/amazonaws/services/s3/model/CopyPartRequest;->getUploadId()Ljava/lang/String;

    move-result-object v0

    .line 236
    .local v0, "uploadId":Ljava/lang/String;
    iget-object v1, p0, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;->multipartUploadContexts:Ljava/util/Map;

    invoke-interface {v1, v0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/amazonaws/services/s3/internal/crypto/MultipartUploadCryptoContext;

    .line 237
    .local v1, "uploadContext":Lcom/amazonaws/services/s3/internal/crypto/MultipartUploadCryptoContext;, "TT;"
    iget-object v2, p0, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;->s3:Lcom/amazonaws/services/s3/internal/S3Direct;

    invoke-virtual {v2, p1}, Lcom/amazonaws/services/s3/internal/S3Direct;->copyPart(Lcom/amazonaws/services/s3/model/CopyPartRequest;)Lcom/amazonaws/services/s3/model/CopyPartResult;

    move-result-object v2

    .line 239
    .local v2, "result":Lcom/amazonaws/services/s3/model/CopyPartResult;
    if-eqz v1, :cond_0

    invoke-virtual {v1}, Lcom/amazonaws/services/s3/internal/crypto/MultipartUploadCryptoContext;->hasFinalPartBeenSeen()Z

    move-result v3

    if-nez v3, :cond_0

    .line 240
    const/4 v3, 0x1

    invoke-virtual {v1, v3}, Lcom/amazonaws/services/s3/internal/crypto/MultipartUploadCryptoContext;->setHasFinalPartBeenSeen(Z)V

    .line 242
    :cond_0
    return-object v2
.end method

.method protected final createContentCryptoMaterial(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;
    .locals 7
    .param p1, "req"    # Lcom/amazonaws/AmazonWebServiceRequest;

    .line 433
    .local p0, "this":Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;, "Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase<TT;>;"
    instance-of v0, p1, Lcom/amazonaws/services/s3/model/EncryptionMaterialsFactory;

    if-eqz v0, :cond_0

    .line 435
    move-object v0, p1

    check-cast v0, Lcom/amazonaws/services/s3/model/EncryptionMaterialsFactory;

    .line 436
    .local v0, "f":Lcom/amazonaws/services/s3/model/EncryptionMaterialsFactory;
    invoke-interface {v0}, Lcom/amazonaws/services/s3/model/EncryptionMaterialsFactory;->getEncryptionMaterials()Lcom/amazonaws/services/s3/model/EncryptionMaterials;

    move-result-object v1

    .line 437
    .local v1, "materials":Lcom/amazonaws/services/s3/model/EncryptionMaterials;
    if-eqz v1, :cond_0

    .line 438
    iget-object v2, p0, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;->cryptoConfig:Lcom/amazonaws/services/s3/model/CryptoConfiguration;

    .line 439
    invoke-virtual {v2}, Lcom/amazonaws/services/s3/model/CryptoConfiguration;->getCryptoProvider()Ljava/security/Provider;

    move-result-object v2

    .line 438
    invoke-direct {p0, v1, v2, p1}, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;->buildContentCryptoMaterial(Lcom/amazonaws/services/s3/model/EncryptionMaterials;Ljava/security/Provider;Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;

    move-result-object v2

    return-object v2

    .line 442
    .end local v0    # "f":Lcom/amazonaws/services/s3/model/EncryptionMaterialsFactory;
    .end local v1    # "materials":Lcom/amazonaws/services/s3/model/EncryptionMaterials;
    :cond_0
    instance-of v0, p1, Lcom/amazonaws/services/s3/model/MaterialsDescriptionProvider;

    if-eqz v0, :cond_3

    .line 444
    move-object v0, p1

    check-cast v0, Lcom/amazonaws/services/s3/model/MaterialsDescriptionProvider;

    .line 445
    .local v0, "mdp":Lcom/amazonaws/services/s3/model/MaterialsDescriptionProvider;
    invoke-interface {v0}, Lcom/amazonaws/services/s3/model/MaterialsDescriptionProvider;->getMaterialsDescription()Ljava/util/Map;

    move-result-object v1

    .line 446
    .local v1, "matdescReq":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    iget-object v2, p0, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;->kekMaterialsProvider:Lcom/amazonaws/services/s3/model/EncryptionMaterialsProvider;

    iget-object v3, p0, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;->cryptoConfig:Lcom/amazonaws/services/s3/model/CryptoConfiguration;

    .line 449
    invoke-virtual {v3}, Lcom/amazonaws/services/s3/model/CryptoConfiguration;->getCryptoProvider()Ljava/security/Provider;

    move-result-object v3

    .line 446
    invoke-direct {p0, v2, v1, v3, p1}, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;->newContentCryptoMaterial(Lcom/amazonaws/services/s3/model/EncryptionMaterialsProvider;Ljava/util/Map;Ljava/security/Provider;Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;

    move-result-object v2

    .line 450
    .local v2, "ccm":Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;
    if-eqz v2, :cond_1

    .line 451
    return-object v2

    .line 453
    :cond_1
    if-eqz v1, :cond_3

    .line 456
    iget-object v3, p0, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;->kekMaterialsProvider:Lcom/amazonaws/services/s3/model/EncryptionMaterialsProvider;

    .line 457
    invoke-interface {v3}, Lcom/amazonaws/services/s3/model/EncryptionMaterialsProvider;->getEncryptionMaterials()Lcom/amazonaws/services/s3/model/EncryptionMaterials;

    move-result-object v3

    .line 458
    .local v3, "material":Lcom/amazonaws/services/s3/model/EncryptionMaterials;
    invoke-virtual {v3}, Lcom/amazonaws/services/s3/model/EncryptionMaterials;->isKMSEnabled()Z

    move-result v4

    if-eqz v4, :cond_2

    goto :goto_0

    .line 459
    :cond_2
    new-instance v4, Lcom/amazonaws/AmazonClientException;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "No material available from the encryption material provider for description "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-direct {v4, v5}, Lcom/amazonaws/AmazonClientException;-><init>(Ljava/lang/String;)V

    throw v4

    .line 468
    .end local v0    # "mdp":Lcom/amazonaws/services/s3/model/MaterialsDescriptionProvider;
    .end local v1    # "matdescReq":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .end local v2    # "ccm":Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;
    .end local v3    # "material":Lcom/amazonaws/services/s3/model/EncryptionMaterials;
    :cond_3
    :goto_0
    iget-object v0, p0, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;->kekMaterialsProvider:Lcom/amazonaws/services/s3/model/EncryptionMaterialsProvider;

    iget-object v1, p0, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;->cryptoConfig:Lcom/amazonaws/services/s3/model/CryptoConfiguration;

    .line 469
    invoke-virtual {v1}, Lcom/amazonaws/services/s3/model/CryptoConfiguration;->getCryptoProvider()Ljava/security/Provider;

    move-result-object v1

    .line 468
    invoke-direct {p0, v0, v1, p1}, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;->newContentCryptoMaterial(Lcom/amazonaws/services/s3/model/EncryptionMaterialsProvider;Ljava/security/Provider;Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;

    move-result-object v0

    return-object v0
.end method

.method final createInstructionGetRequest(Lcom/amazonaws/services/s3/model/S3ObjectId;)Lcom/amazonaws/services/s3/model/GetObjectRequest;
    .locals 1
    .param p1, "id"    # Lcom/amazonaws/services/s3/model/S3ObjectId;

    .line 919
    .local p0, "this":Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;, "Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase<TT;>;"
    const/4 v0, 0x0

    invoke-virtual {p0, p1, v0}, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;->createInstructionGetRequest(Lcom/amazonaws/services/s3/model/S3ObjectId;Ljava/lang/String;)Lcom/amazonaws/services/s3/model/GetObjectRequest;

    move-result-object v0

    return-object v0
.end method

.method final createInstructionGetRequest(Lcom/amazonaws/services/s3/model/S3ObjectId;Ljava/lang/String;)Lcom/amazonaws/services/s3/model/GetObjectRequest;
    .locals 2
    .param p1, "s3objectId"    # Lcom/amazonaws/services/s3/model/S3ObjectId;
    .param p2, "instFileSuffix"    # Ljava/lang/String;

    .line 933
    .local p0, "this":Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;, "Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase<TT;>;"
    new-instance v0, Lcom/amazonaws/services/s3/model/GetObjectRequest;

    .line 934
    invoke-virtual {p1, p2}, Lcom/amazonaws/services/s3/model/S3ObjectId;->instructionFileId(Ljava/lang/String;)Lcom/amazonaws/services/s3/model/InstructionFileId;

    move-result-object v1

    invoke-direct {v0, v1}, Lcom/amazonaws/services/s3/model/GetObjectRequest;-><init>(Lcom/amazonaws/services/s3/model/S3ObjectId;)V

    .line 933
    return-object v0
.end method

.method protected final createInstructionPutRequest(Ljava/lang/String;Ljava/lang/String;Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;)Lcom/amazonaws/services/s3/model/PutObjectRequest;
    .locals 7
    .param p1, "bucketName"    # Ljava/lang/String;
    .param p2, "key"    # Ljava/lang/String;
    .param p3, "cekMaterial"    # Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;

    .line 746
    .local p0, "this":Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;, "Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase<TT;>;"
    iget-object v0, p0, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;->cryptoConfig:Lcom/amazonaws/services/s3/model/CryptoConfiguration;

    invoke-virtual {v0}, Lcom/amazonaws/services/s3/model/CryptoConfiguration;->getCryptoMode()Lcom/amazonaws/services/s3/model/CryptoMode;

    move-result-object v0

    invoke-virtual {p3, v0}, Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;->toJsonString(Lcom/amazonaws/services/s3/model/CryptoMode;)Ljava/lang/String;

    move-result-object v0

    sget-object v1, Lcom/amazonaws/util/StringUtils;->UTF8:Ljava/nio/charset/Charset;

    .line 747
    invoke-virtual {v0, v1}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B

    move-result-object v0

    .line 748
    .local v0, "bytes":[B
    new-instance v1, Ljava/io/ByteArrayInputStream;

    invoke-direct {v1, v0}, Ljava/io/ByteArrayInputStream;-><init>([B)V

    .line 749
    .local v1, "is":Ljava/io/InputStream;
    new-instance v2, Lcom/amazonaws/services/s3/model/ObjectMetadata;

    invoke-direct {v2}, Lcom/amazonaws/services/s3/model/ObjectMetadata;-><init>()V

    .line 750
    .local v2, "metadata":Lcom/amazonaws/services/s3/model/ObjectMetadata;
    array-length v3, v0

    int-to-long v3, v3

    invoke-virtual {v2, v3, v4}, Lcom/amazonaws/services/s3/model/ObjectMetadata;->setContentLength(J)V

    .line 751
    const-string/jumbo v3, "x-amz-crypto-instr-file"

    const-string v4, ""

    invoke-virtual {v2, v3, v4}, Lcom/amazonaws/services/s3/model/ObjectMetadata;->addUserMetadata(Ljava/lang/String;Ljava/lang/String;)V

    .line 752
    new-instance v3, Lcom/amazonaws/services/s3/model/S3ObjectId;

    invoke-direct {v3, p1, p2}, Lcom/amazonaws/services/s3/model/S3ObjectId;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    .line 753
    invoke-virtual {v3}, Lcom/amazonaws/services/s3/model/S3ObjectId;->instructionFileId()Lcom/amazonaws/services/s3/model/InstructionFileId;

    move-result-object v3

    .line 754
    .local v3, "ifileId":Lcom/amazonaws/services/s3/model/InstructionFileId;
    new-instance v4, Lcom/amazonaws/services/s3/model/PutObjectRequest;

    invoke-virtual {v3}, Lcom/amazonaws/services/s3/model/InstructionFileId;->getBucket()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v3}, Lcom/amazonaws/services/s3/model/InstructionFileId;->getKey()Ljava/lang/String;

    move-result-object v6

    invoke-direct {v4, v5, v6, v1, v2}, Lcom/amazonaws/services/s3/model/PutObjectRequest;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/io/InputStream;Lcom/amazonaws/services/s3/model/ObjectMetadata;)V

    return-object v4
.end method

.method final fetchInstructionFile(Lcom/amazonaws/services/s3/model/S3ObjectId;Ljava/lang/String;)Lcom/amazonaws/services/s3/internal/crypto/S3ObjectWrapper;
    .locals 5
    .param p1, "s3ObjectId"    # Lcom/amazonaws/services/s3/model/S3ObjectId;
    .param p2, "instFileSuffix"    # Ljava/lang/String;

    .line 795
    .local p0, "this":Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;, "Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase<TT;>;"
    const/4 v0, 0x0

    :try_start_0
    iget-object v1, p0, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;->s3:Lcom/amazonaws/services/s3/internal/S3Direct;

    .line 796
    invoke-virtual {p0, p1, p2}, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;->createInstructionGetRequest(Lcom/amazonaws/services/s3/model/S3ObjectId;Ljava/lang/String;)Lcom/amazonaws/services/s3/model/GetObjectRequest;

    move-result-object v2

    .line 795
    invoke-virtual {v1, v2}, Lcom/amazonaws/services/s3/internal/S3Direct;->getObject(Lcom/amazonaws/services/s3/model/GetObjectRequest;)Lcom/amazonaws/services/s3/model/S3Object;

    move-result-object v1

    .line 797
    .local v1, "o":Lcom/amazonaws/services/s3/model/S3Object;
    if-nez v1, :cond_0

    goto :goto_0

    :cond_0
    new-instance v2, Lcom/amazonaws/services/s3/internal/crypto/S3ObjectWrapper;

    invoke-direct {v2, v1, p1}, Lcom/amazonaws/services/s3/internal/crypto/S3ObjectWrapper;-><init>(Lcom/amazonaws/services/s3/model/S3Object;Lcom/amazonaws/services/s3/model/S3ObjectId;)V
    :try_end_0
    .catch Lcom/amazonaws/AmazonServiceException; {:try_start_0 .. :try_end_0} :catch_0

    move-object v0, v2

    :goto_0
    return-object v0

    .line 798
    .end local v1    # "o":Lcom/amazonaws/services/s3/model/S3Object;
    :catch_0
    move-exception v1

    .line 801
    .local v1, "e":Lcom/amazonaws/AmazonServiceException;
    iget-object v2, p0, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;->log:Lcom/amazonaws/logging/Log;

    invoke-interface {v2}, Lcom/amazonaws/logging/Log;->isDebugEnabled()Z

    move-result v2

    if-eqz v2, :cond_1

    .line 802
    iget-object v2, p0, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;->log:Lcom/amazonaws/logging/Log;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "Unable to retrieve instruction file : "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    .line 803
    invoke-virtual {v1}, Lcom/amazonaws/AmazonServiceException;->getMessage()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    .line 802
    invoke-interface {v2, v3}, Lcom/amazonaws/logging/Log;->debug(Ljava/lang/Object;)V

    .line 805
    :cond_1
    return-object v0
.end method

.method protected final generateCEK(Lcom/amazonaws/services/s3/model/EncryptionMaterials;Ljava/security/Provider;)Ljavax/crypto/SecretKey;
    .locals 8
    .param p1, "kekMaterials"    # Lcom/amazonaws/services/s3/model/EncryptionMaterials;
    .param p2, "providerIn"    # Ljava/security/Provider;

    .line 573
    .local p0, "this":Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;, "Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase<TT;>;"
    iget-object v0, p0, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;->contentCryptoScheme:Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoScheme;

    invoke-virtual {v0}, Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoScheme;->getKeyGeneratorAlgorithm()Ljava/lang/String;

    move-result-object v0

    .line 576
    .local v0, "keygenAlgo":Ljava/lang/String;
    if-nez p2, :cond_0

    .line 577
    :try_start_0
    invoke-static {v0}, Ljavax/crypto/KeyGenerator;->getInstance(Ljava/lang/String;)Ljavax/crypto/KeyGenerator;

    move-result-object v1

    goto :goto_0

    .line 578
    :cond_0
    invoke-static {v0, p2}, Ljavax/crypto/KeyGenerator;->getInstance(Ljava/lang/String;Ljava/security/Provider;)Ljavax/crypto/KeyGenerator;

    move-result-object v1

    :goto_0
    nop

    .line 579
    .local v1, "generator":Ljavax/crypto/KeyGenerator;
    iget-object v2, p0, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;->contentCryptoScheme:Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoScheme;

    invoke-virtual {v2}, Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoScheme;->getKeyLengthInBits()I

    move-result v2

    iget-object v3, p0, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;->cryptoScheme:Lcom/amazonaws/services/s3/internal/crypto/S3CryptoScheme;

    .line 580
    invoke-virtual {v3}, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoScheme;->getSecureRandom()Ljava/security/SecureRandom;

    move-result-object v3

    .line 579
    invoke-virtual {v1, v2, v3}, Ljavax/crypto/KeyGenerator;->init(ILjava/security/SecureRandom;)V

    .line 582
    const/4 v2, 0x0

    .line 583
    .local v2, "involvesBCPublicKey":Z
    invoke-virtual {p1}, Lcom/amazonaws/services/s3/model/EncryptionMaterials;->getKeyPair()Ljava/security/KeyPair;

    move-result-object v3

    .line 584
    .local v3, "keypair":Ljava/security/KeyPair;
    if-eqz v3, :cond_2

    .line 585
    iget-object v4, p0, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;->cryptoScheme:Lcom/amazonaws/services/s3/internal/crypto/S3CryptoScheme;

    .line 586
    invoke-virtual {v4}, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoScheme;->getKeyWrapScheme()Lcom/amazonaws/services/s3/internal/crypto/S3KeyWrapScheme;

    move-result-object v4

    .line 587
    invoke-virtual {v3}, Ljava/security/KeyPair;->getPublic()Ljava/security/PublicKey;

    move-result-object v5

    invoke-virtual {v4, v5, p2}, Lcom/amazonaws/services/s3/internal/crypto/S3KeyWrapScheme;->getKeyWrapAlgorithm(Ljava/security/Key;Ljava/security/Provider;)Ljava/lang/String;

    move-result-object v4

    .line 588
    .local v4, "keyWrapAlgo":Ljava/lang/String;
    if-nez v4, :cond_2

    .line 589
    invoke-virtual {v1}, Ljavax/crypto/KeyGenerator;->getProvider()Ljava/security/Provider;

    move-result-object v5

    .line 590
    .local v5, "provider":Ljava/security/Provider;
    if-nez v5, :cond_1

    const/4 v6, 0x0

    goto :goto_1

    :cond_1
    invoke-virtual {v5}, Ljava/security/Provider;->getName()Ljava/lang/String;

    move-result-object v6

    .line 591
    .local v6, "providerName":Ljava/lang/String;
    :goto_1
    const-string v7, "BC"

    invoke-virtual {v7, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v7

    move v2, v7

    .line 594
    .end local v4    # "keyWrapAlgo":Ljava/lang/String;
    .end local v5    # "provider":Ljava/security/Provider;
    .end local v6    # "providerName":Ljava/lang/String;
    :cond_2
    invoke-virtual {v1}, Ljavax/crypto/KeyGenerator;->generateKey()Ljavax/crypto/SecretKey;

    move-result-object v4

    .line 595
    .local v4, "secretKey":Ljavax/crypto/SecretKey;
    if-eqz v2, :cond_6

    invoke-interface {v4}, Ljavax/crypto/SecretKey;->getEncoded()[B

    move-result-object v5

    const/4 v6, 0x0

    aget-byte v5, v5, v6

    if-eqz v5, :cond_3

    goto :goto_3

    .line 598
    :cond_3
    const/4 v5, 0x0

    .local v5, "retry":I
    :goto_2
    const/16 v7, 0x9

    if-ge v5, v7, :cond_5

    .line 601
    invoke-virtual {v1}, Ljavax/crypto/KeyGenerator;->generateKey()Ljavax/crypto/SecretKey;

    move-result-object v7

    move-object v4, v7

    .line 602
    invoke-interface {v4}, Ljavax/crypto/SecretKey;->getEncoded()[B

    move-result-object v7

    aget-byte v7, v7, v6

    if-eqz v7, :cond_4

    .line 603
    return-object v4

    .line 598
    :cond_4
    add-int/lit8 v5, v5, 0x1

    goto :goto_2

    .line 607
    .end local v5    # "retry":I
    :cond_5
    new-instance v5, Lcom/amazonaws/AmazonClientException;

    const-string v6, "Failed to generate secret key"

    invoke-direct {v5, v6}, Lcom/amazonaws/AmazonClientException;-><init>(Ljava/lang/String;)V

    .end local v0    # "keygenAlgo":Ljava/lang/String;
    .end local p1    # "kekMaterials":Lcom/amazonaws/services/s3/model/EncryptionMaterials;
    .end local p2    # "providerIn":Ljava/security/Provider;
    throw v5
    :try_end_0
    .catch Ljava/security/NoSuchAlgorithmException; {:try_start_0 .. :try_end_0} :catch_0

    .line 596
    .restart local v0    # "keygenAlgo":Ljava/lang/String;
    .restart local p1    # "kekMaterials":Lcom/amazonaws/services/s3/model/EncryptionMaterials;
    .restart local p2    # "providerIn":Ljava/security/Provider;
    :cond_6
    :goto_3
    return-object v4

    .line 608
    .end local v1    # "generator":Ljavax/crypto/KeyGenerator;
    .end local v2    # "involvesBCPublicKey":Z
    .end local v3    # "keypair":Ljava/security/KeyPair;
    .end local v4    # "secretKey":Ljavax/crypto/SecretKey;
    :catch_0
    move-exception v1

    .line 609
    .local v1, "e":Ljava/security/NoSuchAlgorithmException;
    new-instance v2, Lcom/amazonaws/AmazonClientException;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "Unable to generate envelope symmetric key:"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    .line 611
    invoke-virtual {v1}, Ljava/security/NoSuchAlgorithmException;->getMessage()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-direct {v2, v3, v1}, Lcom/amazonaws/AmazonClientException;-><init>(Ljava/lang/String;Ljava/lang/Throwable;)V

    throw v2
.end method

.method public final getS3CryptoScheme()Lcom/amazonaws/services/s3/internal/crypto/S3CryptoScheme;
    .locals 1

    .line 710
    .local p0, "this":Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;, "Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase<TT;>;"
    iget-object v0, p0, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;->cryptoScheme:Lcom/amazonaws/services/s3/internal/crypto/S3CryptoScheme;

    return-object v0
.end method

.method public initiateMultipartUploadSecurely(Lcom/amazonaws/services/s3/model/InitiateMultipartUploadRequest;)Lcom/amazonaws/services/s3/model/InitiateMultipartUploadResult;
    .locals 5
    .param p1, "req"    # Lcom/amazonaws/services/s3/model/InitiateMultipartUploadRequest;

    .line 251
    .local p0, "this":Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;, "Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase<TT;>;"
    sget-object v0, Lcom/amazonaws/services/s3/AmazonS3EncryptionClient;->USER_AGENT:Ljava/lang/String;

    invoke-virtual {p0, p1, v0}, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;->appendUserAgent(Lcom/amazonaws/AmazonWebServiceRequest;Ljava/lang/String;)Lcom/amazonaws/AmazonWebServiceRequest;

    .line 254
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;->createContentCryptoMaterial(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;

    move-result-object v0

    .line 255
    .local v0, "cekMaterial":Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;
    iget-object v1, p0, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;->cryptoConfig:Lcom/amazonaws/services/s3/model/CryptoConfiguration;

    invoke-virtual {v1}, Lcom/amazonaws/services/s3/model/CryptoConfiguration;->getStorageMode()Lcom/amazonaws/services/s3/model/CryptoStorageMode;

    move-result-object v1

    sget-object v2, Lcom/amazonaws/services/s3/model/CryptoStorageMode;->ObjectMetadata:Lcom/amazonaws/services/s3/model/CryptoStorageMode;

    if-ne v1, v2, :cond_1

    .line 256
    invoke-virtual {p1}, Lcom/amazonaws/services/s3/model/InitiateMultipartUploadRequest;->getObjectMetadata()Lcom/amazonaws/services/s3/model/ObjectMetadata;

    move-result-object v1

    .line 257
    .local v1, "metadata":Lcom/amazonaws/services/s3/model/ObjectMetadata;
    if-nez v1, :cond_0

    .line 258
    new-instance v2, Lcom/amazonaws/services/s3/model/ObjectMetadata;

    invoke-direct {v2}, Lcom/amazonaws/services/s3/model/ObjectMetadata;-><init>()V

    move-object v1, v2

    .line 261
    :cond_0
    const/4 v2, 0x0

    invoke-virtual {p0, v1, v2, v0}, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;->updateMetadataWithContentCryptoMaterial(Lcom/amazonaws/services/s3/model/ObjectMetadata;Ljava/io/File;Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;)Lcom/amazonaws/services/s3/model/ObjectMetadata;

    move-result-object v2

    invoke-virtual {p1, v2}, Lcom/amazonaws/services/s3/model/InitiateMultipartUploadRequest;->setObjectMetadata(Lcom/amazonaws/services/s3/model/ObjectMetadata;)V

    .line 264
    .end local v1    # "metadata":Lcom/amazonaws/services/s3/model/ObjectMetadata;
    :cond_1
    iget-object v1, p0, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;->s3:Lcom/amazonaws/services/s3/internal/S3Direct;

    invoke-virtual {v1, p1}, Lcom/amazonaws/services/s3/internal/S3Direct;->initiateMultipartUpload(Lcom/amazonaws/services/s3/model/InitiateMultipartUploadRequest;)Lcom/amazonaws/services/s3/model/InitiateMultipartUploadResult;

    move-result-object v1

    .line 265
    .local v1, "result":Lcom/amazonaws/services/s3/model/InitiateMultipartUploadResult;
    invoke-virtual {p0, p1, v0}, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;->newUploadContext(Lcom/amazonaws/services/s3/model/InitiateMultipartUploadRequest;Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;)Lcom/amazonaws/services/s3/internal/crypto/MultipartUploadCryptoContext;

    move-result-object v2

    .line 266
    .local v2, "uploadContext":Lcom/amazonaws/services/s3/internal/crypto/MultipartUploadCryptoContext;, "TT;"
    instance-of v3, p1, Lcom/amazonaws/services/s3/model/MaterialsDescriptionProvider;

    if-eqz v3, :cond_2

    .line 267
    move-object v3, p1

    check-cast v3, Lcom/amazonaws/services/s3/model/MaterialsDescriptionProvider;

    .line 268
    .local v3, "p":Lcom/amazonaws/services/s3/model/MaterialsDescriptionProvider;
    invoke-interface {v3}, Lcom/amazonaws/services/s3/model/MaterialsDescriptionProvider;->getMaterialsDescription()Ljava/util/Map;

    move-result-object v4

    invoke-virtual {v2, v4}, Lcom/amazonaws/services/s3/internal/crypto/MultipartUploadCryptoContext;->setMaterialsDescription(Ljava/util/Map;)V

    .line 270
    .end local v3    # "p":Lcom/amazonaws/services/s3/model/MaterialsDescriptionProvider;
    :cond_2
    iget-object v3, p0, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;->multipartUploadContexts:Ljava/util/Map;

    invoke-virtual {v1}, Lcom/amazonaws/services/s3/model/InitiateMultipartUploadResult;->getUploadId()Ljava/lang/String;

    move-result-object v4

    invoke-interface {v3, v4, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 271
    return-object v1
.end method

.method protected final newMultipartS3CipherInputStream(Lcom/amazonaws/services/s3/model/UploadPartRequest;Lcom/amazonaws/services/s3/internal/crypto/CipherLite;)Lcom/amazonaws/services/s3/internal/crypto/CipherLiteInputStream;
    .locals 11
    .param p1, "req"    # Lcom/amazonaws/services/s3/model/UploadPartRequest;
    .param p2, "cipherLite"    # Lcom/amazonaws/services/s3/internal/crypto/CipherLite;

    .line 356
    .local p0, "this":Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;, "Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase<TT;>;"
    invoke-virtual {p1}, Lcom/amazonaws/services/s3/model/UploadPartRequest;->getFile()Ljava/io/File;

    move-result-object v0

    .line 357
    .local v0, "fileOrig":Ljava/io/File;
    invoke-virtual {p1}, Lcom/amazonaws/services/s3/model/UploadPartRequest;->getInputStream()Ljava/io/InputStream;

    move-result-object v1

    .line 358
    .local v1, "isOrig":Ljava/io/InputStream;
    const/4 v2, 0x0

    .line 360
    .local v2, "isCurr":Ljava/io/InputStream;
    if-nez v0, :cond_1

    .line 361
    if-eqz v1, :cond_0

    .line 365
    move-object v2, v1

    goto :goto_0

    .line 362
    :cond_0
    :try_start_0
    new-instance v3, Ljava/lang/IllegalArgumentException;

    const-string v4, "A File or InputStream must be specified when uploading part"

    invoke-direct {v3, v4}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    .end local v0    # "fileOrig":Ljava/io/File;
    .end local v1    # "isOrig":Ljava/io/InputStream;
    .end local v2    # "isCurr":Ljava/io/InputStream;
    .end local p1    # "req":Lcom/amazonaws/services/s3/model/UploadPartRequest;
    .end local p2    # "cipherLite":Lcom/amazonaws/services/s3/internal/crypto/CipherLite;
    throw v3

    .line 367
    .restart local v0    # "fileOrig":Ljava/io/File;
    .restart local v1    # "isOrig":Ljava/io/InputStream;
    .restart local v2    # "isCurr":Ljava/io/InputStream;
    .restart local p1    # "req":Lcom/amazonaws/services/s3/model/UploadPartRequest;
    .restart local p2    # "cipherLite":Lcom/amazonaws/services/s3/internal/crypto/CipherLite;
    :cond_1
    new-instance v3, Lcom/amazonaws/internal/ResettableInputStream;

    invoke-direct {v3, v0}, Lcom/amazonaws/internal/ResettableInputStream;-><init>(Ljava/io/File;)V

    move-object v2, v3

    .line 369
    :goto_0
    new-instance v10, Lcom/amazonaws/services/s3/internal/InputSubstream;

    .line 370
    invoke-virtual {p1}, Lcom/amazonaws/services/s3/model/UploadPartRequest;->getFileOffset()J

    move-result-wide v5

    .line 371
    invoke-virtual {p1}, Lcom/amazonaws/services/s3/model/UploadPartRequest;->getPartSize()J

    move-result-wide v7

    .line 372
    invoke-virtual {p1}, Lcom/amazonaws/services/s3/model/UploadPartRequest;->isLastPart()Z

    move-result v9

    move-object v3, v10

    move-object v4, v2

    invoke-direct/range {v3 .. v9}, Lcom/amazonaws/services/s3/internal/InputSubstream;-><init>(Ljava/io/InputStream;JJZ)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_1

    move-object v4, v10

    .line 373
    .end local v2    # "isCurr":Ljava/io/InputStream;
    .local v4, "isCurr":Ljava/io/InputStream;
    :try_start_1
    invoke-virtual {p2}, Lcom/amazonaws/services/s3/internal/crypto/CipherLite;->markSupported()Z

    move-result v2

    if-eqz v2, :cond_2

    new-instance v2, Lcom/amazonaws/services/s3/internal/crypto/CipherLiteInputStream;

    .line 376
    invoke-virtual {p1}, Lcom/amazonaws/services/s3/model/UploadPartRequest;->isLastPart()Z

    move-result v8

    const/16 v6, 0x800

    const/4 v7, 0x1

    move-object v3, v2

    move-object v5, p2

    invoke-direct/range {v3 .. v8}, Lcom/amazonaws/services/s3/internal/crypto/CipherLiteInputStream;-><init>(Ljava/io/InputStream;Lcom/amazonaws/services/s3/internal/crypto/CipherLite;IZZ)V

    goto :goto_1

    :cond_2
    new-instance v2, Lcom/amazonaws/services/s3/internal/crypto/RenewableCipherLiteInputStream;

    .line 379
    invoke-virtual {p1}, Lcom/amazonaws/services/s3/model/UploadPartRequest;->isLastPart()Z

    move-result v10

    const/16 v8, 0x800

    const/4 v9, 0x1

    move-object v5, v2

    move-object v6, v4

    move-object v7, p2

    invoke-direct/range {v5 .. v10}, Lcom/amazonaws/services/s3/internal/crypto/RenewableCipherLiteInputStream;-><init>(Ljava/io/InputStream;Lcom/amazonaws/services/s3/internal/crypto/CipherLite;IZZ)V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    .line 373
    :goto_1
    return-object v2

    .line 380
    :catch_0
    move-exception v3

    move-object v2, v4

    goto :goto_2

    .end local v4    # "isCurr":Ljava/io/InputStream;
    .restart local v2    # "isCurr":Ljava/io/InputStream;
    :catch_1
    move-exception v3

    .line 381
    .local v3, "e":Ljava/lang/Exception;
    :goto_2
    iget-object v4, p0, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;->log:Lcom/amazonaws/logging/Log;

    invoke-static {p1, v0, v1, v2, v4}, Lcom/amazonaws/services/s3/model/S3DataSource$Utils;->cleanupDataSource(Lcom/amazonaws/services/s3/model/S3DataSource;Ljava/io/File;Ljava/io/InputStream;Ljava/io/InputStream;Lcom/amazonaws/logging/Log;)V

    .line 382
    new-instance v4, Lcom/amazonaws/AmazonClientException;

    const-string v5, "Unable to create cipher input stream"

    invoke-direct {v4, v5, v3}, Lcom/amazonaws/AmazonClientException;-><init>(Ljava/lang/String;Ljava/lang/Throwable;)V

    throw v4
.end method

.method abstract newUploadContext(Lcom/amazonaws/services/s3/model/InitiateMultipartUploadRequest;Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;)Lcom/amazonaws/services/s3/internal/crypto/MultipartUploadCryptoContext;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/amazonaws/services/s3/model/InitiateMultipartUploadRequest;",
            "Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;",
            ")TT;"
        }
    .end annotation
.end method

.method protected final plaintextLength(Lcom/amazonaws/services/s3/model/AbstractPutObjectRequest;Lcom/amazonaws/services/s3/model/ObjectMetadata;)J
    .locals 2
    .param p1, "request"    # Lcom/amazonaws/services/s3/model/AbstractPutObjectRequest;
    .param p2, "metadata"    # Lcom/amazonaws/services/s3/model/ObjectMetadata;

    .line 700
    .local p0, "this":Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;, "Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase<TT;>;"
    invoke-virtual {p1}, Lcom/amazonaws/services/s3/model/AbstractPutObjectRequest;->getFile()Ljava/io/File;

    move-result-object v0

    if-eqz v0, :cond_0

    .line 701
    invoke-virtual {p1}, Lcom/amazonaws/services/s3/model/AbstractPutObjectRequest;->getFile()Ljava/io/File;

    move-result-object v0

    invoke-virtual {v0}, Ljava/io/File;->length()J

    move-result-wide v0

    return-wide v0

    .line 702
    :cond_0
    invoke-virtual {p1}, Lcom/amazonaws/services/s3/model/AbstractPutObjectRequest;->getInputStream()Ljava/io/InputStream;

    move-result-object v0

    if-eqz v0, :cond_1

    .line 703
    const-string v0, "Content-Length"

    invoke-virtual {p2, v0}, Lcom/amazonaws/services/s3/model/ObjectMetadata;->getRawMetadataValue(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    if-eqz v0, :cond_1

    .line 704
    invoke-virtual {p2}, Lcom/amazonaws/services/s3/model/ObjectMetadata;->getContentLength()J

    move-result-wide v0

    return-wide v0

    .line 706
    :cond_1
    const-wide/16 v0, -0x1

    return-wide v0
.end method

.method public final putInstructionFileSecurely(Lcom/amazonaws/services/s3/model/PutInstructionFileRequest;)Lcom/amazonaws/services/s3/model/PutObjectResult;
    .locals 13
    .param p1, "req"    # Lcom/amazonaws/services/s3/model/PutInstructionFileRequest;

    .line 812
    .local p0, "this":Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;, "Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase<TT;>;"
    invoke-virtual {p1}, Lcom/amazonaws/services/s3/model/PutInstructionFileRequest;->getS3ObjectId()Lcom/amazonaws/services/s3/model/S3ObjectId;

    move-result-object v0

    .line 813
    .local v0, "id":Lcom/amazonaws/services/s3/model/S3ObjectId;
    new-instance v1, Lcom/amazonaws/services/s3/model/GetObjectRequest;

    invoke-direct {v1, v0}, Lcom/amazonaws/services/s3/model/GetObjectRequest;-><init>(Lcom/amazonaws/services/s3/model/S3ObjectId;)V

    .line 814
    .local v1, "getreq":Lcom/amazonaws/services/s3/model/GetObjectRequest;
    sget-object v2, Lcom/amazonaws/services/s3/AmazonS3EncryptionClient;->USER_AGENT:Ljava/lang/String;

    invoke-virtual {p0, v1, v2}, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;->appendUserAgent(Lcom/amazonaws/AmazonWebServiceRequest;Ljava/lang/String;)Lcom/amazonaws/AmazonWebServiceRequest;

    .line 816
    iget-object v2, p0, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;->s3:Lcom/amazonaws/services/s3/internal/S3Direct;

    invoke-virtual {v2, v1}, Lcom/amazonaws/services/s3/internal/S3Direct;->getObject(Lcom/amazonaws/services/s3/model/GetObjectRequest;)Lcom/amazonaws/services/s3/model/S3Object;

    move-result-object v2

    .line 819
    .local v2, "retrieved":Lcom/amazonaws/services/s3/model/S3Object;
    iget-object v3, p0, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;->log:Lcom/amazonaws/logging/Log;

    invoke-static {v2, v3}, Lcom/amazonaws/util/IOUtils;->closeQuietly(Ljava/io/Closeable;Lcom/amazonaws/logging/Log;)V

    .line 820
    if-eqz v2, :cond_3

    .line 824
    new-instance v3, Lcom/amazonaws/services/s3/internal/crypto/S3ObjectWrapper;

    invoke-direct {v3, v2, v0}, Lcom/amazonaws/services/s3/internal/crypto/S3ObjectWrapper;-><init>(Lcom/amazonaws/services/s3/model/S3Object;Lcom/amazonaws/services/s3/model/S3ObjectId;)V

    .line 826
    .local v3, "wrapped":Lcom/amazonaws/services/s3/internal/crypto/S3ObjectWrapper;
    :try_start_0
    invoke-direct {p0, v3}, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;->contentCryptoMaterialOf(Lcom/amazonaws/services/s3/internal/crypto/S3ObjectWrapper;)Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;

    move-result-object v4

    .line 827
    .local v4, "origCCM":Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;
    sget-object v5, Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoScheme;->AES_GCM:Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoScheme;

    invoke-virtual {v4}, Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;->getContentCryptoScheme()Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoScheme;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_1

    iget-object v5, p0, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;->cryptoConfig:Lcom/amazonaws/services/s3/model/CryptoConfiguration;

    .line 828
    invoke-virtual {v5}, Lcom/amazonaws/services/s3/model/CryptoConfiguration;->getCryptoMode()Lcom/amazonaws/services/s3/model/CryptoMode;

    move-result-object v5

    sget-object v6, Lcom/amazonaws/services/s3/model/CryptoMode;->EncryptionOnly:Lcom/amazonaws/services/s3/model/CryptoMode;

    if-eq v5, v6, :cond_0

    goto :goto_0

    .line 829
    :cond_0
    new-instance v5, Ljava/lang/SecurityException;

    const-string v6, "Lowering the protection of encryption material is not allowed"

    invoke-direct {v5, v6}, Ljava/lang/SecurityException;-><init>(Ljava/lang/String;)V

    .end local v0    # "id":Lcom/amazonaws/services/s3/model/S3ObjectId;
    .end local v1    # "getreq":Lcom/amazonaws/services/s3/model/GetObjectRequest;
    .end local v2    # "retrieved":Lcom/amazonaws/services/s3/model/S3Object;
    .end local v3    # "wrapped":Lcom/amazonaws/services/s3/internal/crypto/S3ObjectWrapper;
    .end local p1    # "req":Lcom/amazonaws/services/s3/model/PutInstructionFileRequest;
    throw v5

    .line 832
    .restart local v0    # "id":Lcom/amazonaws/services/s3/model/S3ObjectId;
    .restart local v1    # "getreq":Lcom/amazonaws/services/s3/model/GetObjectRequest;
    .restart local v2    # "retrieved":Lcom/amazonaws/services/s3/model/S3Object;
    .restart local v3    # "wrapped":Lcom/amazonaws/services/s3/internal/crypto/S3ObjectWrapper;
    .restart local p1    # "req":Lcom/amazonaws/services/s3/model/PutInstructionFileRequest;
    :cond_1
    :goto_0
    invoke-virtual {p0, v4, v3}, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;->securityCheck(Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;Lcom/amazonaws/services/s3/internal/crypto/S3ObjectWrapper;)V

    .line 834
    invoke-virtual {p1}, Lcom/amazonaws/services/s3/model/PutInstructionFileRequest;->getEncryptionMaterials()Lcom/amazonaws/services/s3/model/EncryptionMaterials;

    move-result-object v5

    move-object v12, v5

    .line 836
    .local v12, "newKEK":Lcom/amazonaws/services/s3/model/EncryptionMaterials;
    if-nez v12, :cond_2

    .line 837
    invoke-virtual {p1}, Lcom/amazonaws/services/s3/model/PutInstructionFileRequest;->getMaterialsDescription()Ljava/util/Map;

    move-result-object v6

    iget-object v7, p0, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;->kekMaterialsProvider:Lcom/amazonaws/services/s3/model/EncryptionMaterialsProvider;

    iget-object v8, p0, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;->cryptoScheme:Lcom/amazonaws/services/s3/internal/crypto/S3CryptoScheme;

    iget-object v5, p0, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;->cryptoConfig:Lcom/amazonaws/services/s3/model/CryptoConfiguration;

    .line 840
    invoke-virtual {v5}, Lcom/amazonaws/services/s3/model/CryptoConfiguration;->getCryptoProvider()Ljava/security/Provider;

    move-result-object v9

    iget-object v10, p0, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;->kms:Lcom/amazonaws/services/kms/AWSKMSClient;

    .line 837
    move-object v5, v4

    move-object v11, p1

    invoke-virtual/range {v5 .. v11}, Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;->recreate(Ljava/util/Map;Lcom/amazonaws/services/s3/model/EncryptionMaterialsAccessor;Lcom/amazonaws/services/s3/internal/crypto/S3CryptoScheme;Ljava/security/Provider;Lcom/amazonaws/services/kms/AWSKMSClient;Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;

    move-result-object v5

    .local v5, "newCCM":Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;
    goto :goto_1

    .line 842
    .end local v5    # "newCCM":Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;
    :cond_2
    iget-object v7, p0, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;->kekMaterialsProvider:Lcom/amazonaws/services/s3/model/EncryptionMaterialsProvider;

    iget-object v8, p0, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;->cryptoScheme:Lcom/amazonaws/services/s3/internal/crypto/S3CryptoScheme;

    iget-object v5, p0, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;->cryptoConfig:Lcom/amazonaws/services/s3/model/CryptoConfiguration;

    .line 845
    invoke-virtual {v5}, Lcom/amazonaws/services/s3/model/CryptoConfiguration;->getCryptoProvider()Ljava/security/Provider;

    move-result-object v9

    iget-object v10, p0, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;->kms:Lcom/amazonaws/services/kms/AWSKMSClient;

    .line 842
    move-object v5, v4

    move-object v6, v12

    move-object v11, p1

    invoke-virtual/range {v5 .. v11}, Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;->recreate(Lcom/amazonaws/services/s3/model/EncryptionMaterials;Lcom/amazonaws/services/s3/model/EncryptionMaterialsAccessor;Lcom/amazonaws/services/s3/internal/crypto/S3CryptoScheme;Ljava/security/Provider;Lcom/amazonaws/services/kms/AWSKMSClient;Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;

    move-result-object v5

    .line 847
    .restart local v5    # "newCCM":Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;
    :goto_1
    invoke-virtual {p1, v2}, Lcom/amazonaws/services/s3/model/PutInstructionFileRequest;->createPutObjectRequest(Lcom/amazonaws/services/s3/model/S3Object;)Lcom/amazonaws/services/s3/model/PutObjectRequest;

    move-result-object v6

    .line 849
    .local v6, "putInstFileRequest":Lcom/amazonaws/services/s3/model/PutObjectRequest;
    iget-object v7, p0, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;->s3:Lcom/amazonaws/services/s3/internal/S3Direct;

    invoke-virtual {p0, v6, v5}, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;->updateInstructionPutRequest(Lcom/amazonaws/services/s3/model/PutObjectRequest;Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;)Lcom/amazonaws/services/s3/model/PutObjectRequest;

    move-result-object v8

    invoke-virtual {v7, v8}, Lcom/amazonaws/services/s3/internal/S3Direct;->putObject(Lcom/amazonaws/services/s3/model/PutObjectRequest;)Lcom/amazonaws/services/s3/model/PutObjectResult;

    move-result-object v7
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/Error; {:try_start_0 .. :try_end_0} :catch_0

    return-object v7

    .line 855
    .end local v4    # "origCCM":Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;
    .end local v5    # "newCCM":Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;
    .end local v6    # "putInstFileRequest":Lcom/amazonaws/services/s3/model/PutObjectRequest;
    .end local v12    # "newKEK":Lcom/amazonaws/services/s3/model/EncryptionMaterials;
    :catch_0
    move-exception v4

    .line 856
    .local v4, "error":Ljava/lang/Error;
    iget-object v5, p0, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;->log:Lcom/amazonaws/logging/Log;

    invoke-static {v2, v5}, Lcom/amazonaws/util/IOUtils;->closeQuietly(Ljava/io/Closeable;Lcom/amazonaws/logging/Log;)V

    .line 857
    throw v4

    .line 850
    .end local v4    # "error":Ljava/lang/Error;
    :catch_1
    move-exception v4

    .line 853
    .local v4, "ex":Ljava/lang/RuntimeException;
    iget-object v5, p0, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;->log:Lcom/amazonaws/logging/Log;

    invoke-static {v2, v5}, Lcom/amazonaws/util/IOUtils;->closeQuietly(Ljava/io/Closeable;Lcom/amazonaws/logging/Log;)V

    .line 854
    throw v4

    .line 821
    .end local v3    # "wrapped":Lcom/amazonaws/services/s3/internal/crypto/S3ObjectWrapper;
    .end local v4    # "ex":Ljava/lang/RuntimeException;
    :cond_3
    new-instance v3, Ljava/lang/IllegalArgumentException;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "The specified S3 object ("

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, ") doesn\'t exist."

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-direct {v3, v4}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v3
.end method

.method public final putLocalObjectSecurely(Lcom/amazonaws/services/s3/model/UploadObjectRequest;Ljava/lang/String;Ljava/io/OutputStream;)V
    .locals 8
    .param p1, "reqIn"    # Lcom/amazonaws/services/s3/model/UploadObjectRequest;
    .param p2, "uploadId"    # Ljava/lang/String;
    .param p3, "os"    # Ljava/io/OutputStream;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 509
    .local p0, "this":Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;, "Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase<TT;>;"
    invoke-virtual {p1}, Lcom/amazonaws/services/s3/model/UploadObjectRequest;->clone()Lcom/amazonaws/services/s3/model/UploadObjectRequest;

    move-result-object v0

    .line 511
    .local v0, "req":Lcom/amazonaws/services/s3/model/UploadObjectRequest;
    invoke-virtual {v0}, Lcom/amazonaws/services/s3/model/UploadObjectRequest;->getFile()Ljava/io/File;

    move-result-object v1

    .line 512
    .local v1, "fileOrig":Ljava/io/File;
    invoke-virtual {v0}, Lcom/amazonaws/services/s3/model/UploadObjectRequest;->getInputStream()Ljava/io/InputStream;

    move-result-object v2

    .line 514
    .local v2, "isOrig":Ljava/io/InputStream;
    iget-object v3, p0, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;->multipartUploadContexts:Ljava/util/Map;

    invoke-interface {v3, p2}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lcom/amazonaws/services/s3/internal/crypto/MultipartUploadCryptoContext;

    .line 515
    .local v3, "uploadContext":Lcom/amazonaws/services/s3/internal/crypto/MultipartUploadCryptoContext;, "TT;"
    invoke-virtual {v3}, Lcom/amazonaws/services/s3/internal/crypto/MultipartUploadCryptoContext;->getContentCryptoMaterial()Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;

    move-result-object v4

    .line 516
    .local v4, "cekMaterial":Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;
    invoke-virtual {p0, v0, v4}, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;->wrapWithCipher(Lcom/amazonaws/services/s3/model/AbstractPutObjectRequest;Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;)Lcom/amazonaws/services/s3/model/AbstractPutObjectRequest;

    move-result-object v5

    move-object v0, v5

    check-cast v0, Lcom/amazonaws/services/s3/model/UploadObjectRequest;

    .line 519
    :try_start_0
    invoke-virtual {v0}, Lcom/amazonaws/services/s3/model/UploadObjectRequest;->getInputStream()Ljava/io/InputStream;

    move-result-object v5

    invoke-static {v5, p3}, Lcom/amazonaws/util/IOUtils;->copy(Ljava/io/InputStream;Ljava/io/OutputStream;)J

    .line 522
    const/4 v5, 0x1

    invoke-virtual {v3, v5}, Lcom/amazonaws/services/s3/internal/crypto/MultipartUploadCryptoContext;->setHasFinalPartBeenSeen(Z)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 524
    nop

    .line 525
    invoke-virtual {v0}, Lcom/amazonaws/services/s3/model/UploadObjectRequest;->getInputStream()Ljava/io/InputStream;

    move-result-object v5

    iget-object v6, p0, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;->log:Lcom/amazonaws/logging/Log;

    .line 524
    invoke-static {v0, v1, v2, v5, v6}, Lcom/amazonaws/services/s3/model/S3DataSource$Utils;->cleanupDataSource(Lcom/amazonaws/services/s3/model/S3DataSource;Ljava/io/File;Ljava/io/InputStream;Ljava/io/InputStream;Lcom/amazonaws/logging/Log;)V

    .line 526
    iget-object v5, p0, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;->log:Lcom/amazonaws/logging/Log;

    invoke-static {p3, v5}, Lcom/amazonaws/util/IOUtils;->closeQuietly(Ljava/io/Closeable;Lcom/amazonaws/logging/Log;)V

    .line 527
    nop

    .line 528
    return-void

    .line 524
    :catchall_0
    move-exception v5

    .line 525
    invoke-virtual {v0}, Lcom/amazonaws/services/s3/model/UploadObjectRequest;->getInputStream()Ljava/io/InputStream;

    move-result-object v6

    iget-object v7, p0, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;->log:Lcom/amazonaws/logging/Log;

    .line 524
    invoke-static {v0, v1, v2, v6, v7}, Lcom/amazonaws/services/s3/model/S3DataSource$Utils;->cleanupDataSource(Lcom/amazonaws/services/s3/model/S3DataSource;Ljava/io/File;Ljava/io/InputStream;Ljava/io/InputStream;Lcom/amazonaws/logging/Log;)V

    .line 526
    iget-object v6, p0, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;->log:Lcom/amazonaws/logging/Log;

    invoke-static {p3, v6}, Lcom/amazonaws/util/IOUtils;->closeQuietly(Ljava/io/Closeable;Lcom/amazonaws/logging/Log;)V

    .line 527
    throw v5
.end method

.method public putObjectSecurely(Lcom/amazonaws/services/s3/model/PutObjectRequest;)Lcom/amazonaws/services/s3/model/PutObjectResult;
    .locals 2
    .param p1, "req"    # Lcom/amazonaws/services/s3/model/PutObjectRequest;

    .line 165
    .local p0, "this":Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;, "Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase<TT;>;"
    sget-object v0, Lcom/amazonaws/services/s3/AmazonS3EncryptionClient;->USER_AGENT:Ljava/lang/String;

    invoke-virtual {p0, p1, v0}, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;->appendUserAgent(Lcom/amazonaws/AmazonWebServiceRequest;Ljava/lang/String;)Lcom/amazonaws/AmazonWebServiceRequest;

    .line 166
    iget-object v0, p0, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;->cryptoConfig:Lcom/amazonaws/services/s3/model/CryptoConfiguration;

    invoke-virtual {v0}, Lcom/amazonaws/services/s3/model/CryptoConfiguration;->getStorageMode()Lcom/amazonaws/services/s3/model/CryptoStorageMode;

    move-result-object v0

    sget-object v1, Lcom/amazonaws/services/s3/model/CryptoStorageMode;->InstructionFile:Lcom/amazonaws/services/s3/model/CryptoStorageMode;

    if-ne v0, v1, :cond_0

    .line 167
    invoke-direct {p0, p1}, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;->putObjectUsingInstructionFile(Lcom/amazonaws/services/s3/model/PutObjectRequest;)Lcom/amazonaws/services/s3/model/PutObjectResult;

    move-result-object v0

    goto :goto_0

    .line 168
    :cond_0
    invoke-direct {p0, p1}, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;->putObjectUsingMetadata(Lcom/amazonaws/services/s3/model/PutObjectRequest;)Lcom/amazonaws/services/s3/model/PutObjectResult;

    move-result-object v0

    .line 166
    :goto_0
    return-object v0
.end method

.method protected securityCheck(Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;Lcom/amazonaws/services/s3/internal/crypto/S3ObjectWrapper;)V
    .locals 0
    .param p1, "cekMaterial"    # Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;
    .param p2, "retrieved"    # Lcom/amazonaws/services/s3/internal/crypto/S3ObjectWrapper;

    .line 779
    .local p0, "this":Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;, "Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase<TT;>;"
    return-void
.end method

.method protected final updateInstructionPutRequest(Lcom/amazonaws/services/s3/model/PutObjectRequest;Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;)Lcom/amazonaws/services/s3/model/PutObjectRequest;
    .locals 4
    .param p1, "req"    # Lcom/amazonaws/services/s3/model/PutObjectRequest;
    .param p2, "cekMaterial"    # Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;

    .line 725
    .local p0, "this":Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;, "Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase<TT;>;"
    iget-object v0, p0, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;->cryptoConfig:Lcom/amazonaws/services/s3/model/CryptoConfiguration;

    invoke-virtual {v0}, Lcom/amazonaws/services/s3/model/CryptoConfiguration;->getCryptoMode()Lcom/amazonaws/services/s3/model/CryptoMode;

    move-result-object v0

    invoke-virtual {p2, v0}, Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;->toJsonString(Lcom/amazonaws/services/s3/model/CryptoMode;)Ljava/lang/String;

    move-result-object v0

    sget-object v1, Lcom/amazonaws/util/StringUtils;->UTF8:Ljava/nio/charset/Charset;

    .line 726
    invoke-virtual {v0, v1}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B

    move-result-object v0

    .line 727
    .local v0, "bytes":[B
    invoke-virtual {p1}, Lcom/amazonaws/services/s3/model/PutObjectRequest;->getMetadata()Lcom/amazonaws/services/s3/model/ObjectMetadata;

    move-result-object v1

    .line 728
    .local v1, "metadata":Lcom/amazonaws/services/s3/model/ObjectMetadata;
    if-nez v1, :cond_0

    .line 729
    new-instance v2, Lcom/amazonaws/services/s3/model/ObjectMetadata;

    invoke-direct {v2}, Lcom/amazonaws/services/s3/model/ObjectMetadata;-><init>()V

    move-object v1, v2

    .line 730
    invoke-virtual {p1, v1}, Lcom/amazonaws/services/s3/model/PutObjectRequest;->setMetadata(Lcom/amazonaws/services/s3/model/ObjectMetadata;)V

    .line 733
    :cond_0
    array-length v2, v0

    int-to-long v2, v2

    invoke-virtual {v1, v2, v3}, Lcom/amazonaws/services/s3/model/ObjectMetadata;->setContentLength(J)V

    .line 735
    const-string/jumbo v2, "x-amz-crypto-instr-file"

    const-string v3, ""

    invoke-virtual {v1, v2, v3}, Lcom/amazonaws/services/s3/model/ObjectMetadata;->addUserMetadata(Ljava/lang/String;Ljava/lang/String;)V

    .line 737
    invoke-virtual {p1, v1}, Lcom/amazonaws/services/s3/model/PutObjectRequest;->setMetadata(Lcom/amazonaws/services/s3/model/ObjectMetadata;)V

    .line 738
    new-instance v2, Ljava/io/ByteArrayInputStream;

    invoke-direct {v2, v0}, Ljava/io/ByteArrayInputStream;-><init>([B)V

    invoke-virtual {p1, v2}, Lcom/amazonaws/services/s3/model/PutObjectRequest;->setInputStream(Ljava/io/InputStream;)V

    .line 741
    return-object p1
.end method

.method protected final updateMetadataWithContentCryptoMaterial(Lcom/amazonaws/services/s3/model/ObjectMetadata;Ljava/io/File;Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;)Lcom/amazonaws/services/s3/model/ObjectMetadata;
    .locals 2
    .param p1, "metadata"    # Lcom/amazonaws/services/s3/model/ObjectMetadata;
    .param p2, "file"    # Ljava/io/File;
    .param p3, "instruction"    # Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;

    .line 415
    .local p0, "this":Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;, "Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase<TT;>;"
    if-nez p1, :cond_0

    .line 416
    new-instance v0, Lcom/amazonaws/services/s3/model/ObjectMetadata;

    invoke-direct {v0}, Lcom/amazonaws/services/s3/model/ObjectMetadata;-><init>()V

    move-object p1, v0

    .line 418
    :cond_0
    if-eqz p2, :cond_1

    .line 419
    invoke-static {}, Lcom/amazonaws/services/s3/util/Mimetypes;->getInstance()Lcom/amazonaws/services/s3/util/Mimetypes;

    move-result-object v0

    .line 420
    .local v0, "mimetypes":Lcom/amazonaws/services/s3/util/Mimetypes;
    invoke-virtual {v0, p2}, Lcom/amazonaws/services/s3/util/Mimetypes;->getMimetype(Ljava/io/File;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p1, v1}, Lcom/amazonaws/services/s3/model/ObjectMetadata;->setContentType(Ljava/lang/String;)V

    .line 422
    .end local v0    # "mimetypes":Lcom/amazonaws/services/s3/util/Mimetypes;
    :cond_1
    iget-object v0, p0, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;->cryptoConfig:Lcom/amazonaws/services/s3/model/CryptoConfiguration;

    invoke-virtual {v0}, Lcom/amazonaws/services/s3/model/CryptoConfiguration;->getCryptoMode()Lcom/amazonaws/services/s3/model/CryptoMode;

    move-result-object v0

    invoke-virtual {p3, p1, v0}, Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;->toObjectMetadata(Lcom/amazonaws/services/s3/model/ObjectMetadata;Lcom/amazonaws/services/s3/model/CryptoMode;)Lcom/amazonaws/services/s3/model/ObjectMetadata;

    move-result-object v0

    return-object v0
.end method

.method abstract updateUploadContext(Lcom/amazonaws/services/s3/internal/crypto/MultipartUploadCryptoContext;Lcom/amazonaws/internal/SdkFilterInputStream;)V
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TT;",
            "Lcom/amazonaws/internal/SdkFilterInputStream;",
            ")V"
        }
    .end annotation
.end method

.method public uploadPartSecurely(Lcom/amazonaws/services/s3/model/UploadPartRequest;)Lcom/amazonaws/services/s3/model/UploadPartResult;
    .locals 20
    .param p1, "req"    # Lcom/amazonaws/services/s3/model/UploadPartRequest;

    .line 292
    .local p0, "this":Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;, "Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase<TT;>;"
    move-object/from16 v1, p0

    move-object/from16 v2, p1

    sget-object v0, Lcom/amazonaws/services/s3/AmazonS3EncryptionClient;->USER_AGENT:Ljava/lang/String;

    invoke-virtual {v1, v2, v0}, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;->appendUserAgent(Lcom/amazonaws/AmazonWebServiceRequest;Ljava/lang/String;)Lcom/amazonaws/AmazonWebServiceRequest;

    .line 293
    iget-object v0, v1, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;->contentCryptoScheme:Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoScheme;

    invoke-virtual {v0}, Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoScheme;->getBlockSizeInBytes()I

    move-result v3

    .line 294
    .local v3, "blockSize":I
    invoke-virtual/range {p1 .. p1}, Lcom/amazonaws/services/s3/model/UploadPartRequest;->isLastPart()Z

    move-result v4

    .line 295
    .local v4, "isLastPart":Z
    invoke-virtual/range {p1 .. p1}, Lcom/amazonaws/services/s3/model/UploadPartRequest;->getUploadId()Ljava/lang/String;

    move-result-object v5

    .line 296
    .local v5, "uploadId":Ljava/lang/String;
    invoke-virtual/range {p1 .. p1}, Lcom/amazonaws/services/s3/model/UploadPartRequest;->getPartSize()J

    move-result-wide v6

    .line 297
    .local v6, "partSize":J
    int-to-long v8, v3

    rem-long v8, v6, v8

    const-wide/16 v10, 0x0

    cmp-long v0, v10, v8

    if-nez v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    move v9, v0

    .line 298
    .local v9, "partSizeMultipleOfCipherBlockSize":Z
    if-nez v4, :cond_2

    if-eqz v9, :cond_1

    goto :goto_1

    .line 299
    :cond_1
    new-instance v0, Lcom/amazonaws/AmazonClientException;

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v10, "Invalid part size: part sizes for encrypted multipart uploads must be multiples of the cipher block size ("

    invoke-virtual {v8, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v8

    const-string v10, ") with the exception of the last part."

    invoke-virtual {v8, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-direct {v0, v8}, Lcom/amazonaws/AmazonClientException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 305
    :cond_2
    :goto_1
    iget-object v0, v1, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;->multipartUploadContexts:Ljava/util/Map;

    invoke-interface {v0, v5}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    move-object v12, v0

    check-cast v12, Lcom/amazonaws/services/s3/internal/crypto/MultipartUploadCryptoContext;

    .line 306
    .local v12, "uploadContext":Lcom/amazonaws/services/s3/internal/crypto/MultipartUploadCryptoContext;, "TT;"
    if-eqz v12, :cond_7

    .line 312
    invoke-virtual/range {p1 .. p1}, Lcom/amazonaws/services/s3/model/UploadPartRequest;->getPartNumber()I

    move-result v0

    invoke-virtual {v12, v0}, Lcom/amazonaws/services/s3/internal/crypto/MultipartUploadCryptoContext;->beginPartUpload(I)V

    .line 313
    invoke-virtual {v1, v12}, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;->cipherLiteForNextPart(Lcom/amazonaws/services/s3/internal/crypto/MultipartUploadCryptoContext;)Lcom/amazonaws/services/s3/internal/crypto/CipherLite;

    move-result-object v13

    .line 314
    .local v13, "cipherLite":Lcom/amazonaws/services/s3/internal/crypto/CipherLite;
    invoke-virtual/range {p1 .. p1}, Lcom/amazonaws/services/s3/model/UploadPartRequest;->getFile()Ljava/io/File;

    move-result-object v14

    .line 315
    .local v14, "fileOrig":Ljava/io/File;
    invoke-virtual/range {p1 .. p1}, Lcom/amazonaws/services/s3/model/UploadPartRequest;->getInputStream()Ljava/io/InputStream;

    move-result-object v15

    .line 316
    .local v15, "isOrig":Ljava/io/InputStream;
    const/16 v16, 0x0

    .line 318
    .local v16, "isCurr":Lcom/amazonaws/internal/SdkFilterInputStream;
    :try_start_0
    invoke-virtual {v1, v2, v13}, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;->newMultipartS3CipherInputStream(Lcom/amazonaws/services/s3/model/UploadPartRequest;Lcom/amazonaws/services/s3/internal/crypto/CipherLite;)Lcom/amazonaws/services/s3/internal/crypto/CipherLiteInputStream;

    move-result-object v0

    .line 319
    .local v0, "clis":Lcom/amazonaws/services/s3/internal/crypto/CipherLiteInputStream;
    move-object/from16 v16, v0

    .line 321
    invoke-virtual {v1, v0, v6, v7}, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;->wrapForMultipart(Lcom/amazonaws/services/s3/internal/crypto/CipherLiteInputStream;J)Lcom/amazonaws/internal/SdkFilterInputStream;

    move-result-object v17
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_3

    move-object/from16 v16, v17

    .line 322
    move-object/from16 v8, v16

    .end local v16    # "isCurr":Lcom/amazonaws/internal/SdkFilterInputStream;
    .local v8, "isCurr":Lcom/amazonaws/internal/SdkFilterInputStream;
    :try_start_1
    invoke-virtual {v2, v8}, Lcom/amazonaws/services/s3/model/UploadPartRequest;->setInputStream(Ljava/io/InputStream;)V

    .line 325
    const/4 v10, 0x0

    invoke-virtual {v2, v10}, Lcom/amazonaws/services/s3/model/UploadPartRequest;->setFile(Ljava/io/File;)V

    .line 326
    const-wide/16 v10, 0x0

    invoke-virtual {v2, v10, v11}, Lcom/amazonaws/services/s3/model/UploadPartRequest;->setFileOffset(J)V

    .line 329
    if-eqz v4, :cond_5

    .line 331
    invoke-virtual/range {p0 .. p1}, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;->computeLastPartSize(Lcom/amazonaws/services/s3/model/UploadPartRequest;)J

    move-result-wide v10
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_2

    .line 332
    .local v10, "lastPartSize":J
    const-wide/16 v18, -0x1

    cmp-long v16, v10, v18

    if-lez v16, :cond_3

    .line 333
    :try_start_2
    invoke-virtual {v2, v10, v11}, Lcom/amazonaws/services/s3/model/UploadPartRequest;->setPartSize(J)V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    goto :goto_2

    .line 344
    .end local v0    # "clis":Lcom/amazonaws/services/s3/internal/crypto/CipherLiteInputStream;
    .end local v10    # "lastPartSize":J
    :catchall_0
    move-exception v0

    move/from16 v19, v3

    goto :goto_4

    .line 335
    .restart local v0    # "clis":Lcom/amazonaws/services/s3/internal/crypto/CipherLiteInputStream;
    .restart local v10    # "lastPartSize":J
    :cond_3
    :goto_2
    :try_start_3
    invoke-virtual {v12}, Lcom/amazonaws/services/s3/internal/crypto/MultipartUploadCryptoContext;->hasFinalPartBeenSeen()Z

    move-result v16

    if-nez v16, :cond_4

    move-object/from16 v18, v0

    move/from16 v19, v3

    goto :goto_3

    .line 336
    :cond_4
    move-object/from16 v18, v0

    .end local v0    # "clis":Lcom/amazonaws/services/s3/internal/crypto/CipherLiteInputStream;
    .local v18, "clis":Lcom/amazonaws/services/s3/internal/crypto/CipherLiteInputStream;
    new-instance v0, Lcom/amazonaws/AmazonClientException;
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_2

    move/from16 v19, v3

    .end local v3    # "blockSize":I
    .local v19, "blockSize":I
    :try_start_4
    const-string v3, "This part was specified as the last part in a multipart upload, but a previous part was already marked as the last part.  Only the last part of the upload should be marked as the last part."

    invoke-direct {v0, v3}, Lcom/amazonaws/AmazonClientException;-><init>(Ljava/lang/String;)V

    .end local v4    # "isLastPart":Z
    .end local v5    # "uploadId":Ljava/lang/String;
    .end local v6    # "partSize":J
    .end local v8    # "isCurr":Lcom/amazonaws/internal/SdkFilterInputStream;
    .end local v9    # "partSizeMultipleOfCipherBlockSize":Z
    .end local v12    # "uploadContext":Lcom/amazonaws/services/s3/internal/crypto/MultipartUploadCryptoContext;, "TT;"
    .end local v13    # "cipherLite":Lcom/amazonaws/services/s3/internal/crypto/CipherLite;
    .end local v14    # "fileOrig":Ljava/io/File;
    .end local v15    # "isOrig":Ljava/io/InputStream;
    .end local v19    # "blockSize":I
    .end local p1    # "req":Lcom/amazonaws/services/s3/model/UploadPartRequest;
    throw v0

    .line 329
    .end local v10    # "lastPartSize":J
    .end local v18    # "clis":Lcom/amazonaws/services/s3/internal/crypto/CipherLiteInputStream;
    .restart local v0    # "clis":Lcom/amazonaws/services/s3/internal/crypto/CipherLiteInputStream;
    .restart local v3    # "blockSize":I
    .restart local v4    # "isLastPart":Z
    .restart local v5    # "uploadId":Ljava/lang/String;
    .restart local v6    # "partSize":J
    .restart local v8    # "isCurr":Lcom/amazonaws/internal/SdkFilterInputStream;
    .restart local v9    # "partSizeMultipleOfCipherBlockSize":Z
    .restart local v12    # "uploadContext":Lcom/amazonaws/services/s3/internal/crypto/MultipartUploadCryptoContext;, "TT;"
    .restart local v13    # "cipherLite":Lcom/amazonaws/services/s3/internal/crypto/CipherLite;
    .restart local v14    # "fileOrig":Ljava/io/File;
    .restart local v15    # "isOrig":Ljava/io/InputStream;
    .restart local p1    # "req":Lcom/amazonaws/services/s3/model/UploadPartRequest;
    :cond_5
    move-object/from16 v18, v0

    move/from16 v19, v3

    .line 342
    .end local v0    # "clis":Lcom/amazonaws/services/s3/internal/crypto/CipherLiteInputStream;
    .end local v3    # "blockSize":I
    .restart local v18    # "clis":Lcom/amazonaws/services/s3/internal/crypto/CipherLiteInputStream;
    .restart local v19    # "blockSize":I
    :goto_3
    iget-object v0, v1, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;->s3:Lcom/amazonaws/services/s3/internal/S3Direct;

    invoke-virtual {v0, v2}, Lcom/amazonaws/services/s3/internal/S3Direct;->uploadPart(Lcom/amazonaws/services/s3/model/UploadPartRequest;)Lcom/amazonaws/services/s3/model/UploadPartResult;

    move-result-object v0
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_1

    .line 344
    .end local v18    # "clis":Lcom/amazonaws/services/s3/internal/crypto/CipherLiteInputStream;
    .local v0, "result":Lcom/amazonaws/services/s3/model/UploadPartResult;
    iget-object v3, v1, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;->log:Lcom/amazonaws/logging/Log;

    invoke-static {v2, v14, v15, v8, v3}, Lcom/amazonaws/services/s3/model/S3DataSource$Utils;->cleanupDataSource(Lcom/amazonaws/services/s3/model/S3DataSource;Ljava/io/File;Ljava/io/InputStream;Ljava/io/InputStream;Lcom/amazonaws/logging/Log;)V

    .line 345
    invoke-virtual {v12}, Lcom/amazonaws/services/s3/internal/crypto/MultipartUploadCryptoContext;->endPartUpload()V

    .line 346
    nop

    .line 347
    if-eqz v4, :cond_6

    .line 348
    const/4 v3, 0x1

    invoke-virtual {v12, v3}, Lcom/amazonaws/services/s3/internal/crypto/MultipartUploadCryptoContext;->setHasFinalPartBeenSeen(Z)V

    .line 350
    :cond_6
    invoke-virtual {v1, v12, v8}, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;->updateUploadContext(Lcom/amazonaws/services/s3/internal/crypto/MultipartUploadCryptoContext;Lcom/amazonaws/internal/SdkFilterInputStream;)V

    .line 351
    return-object v0

    .line 344
    .end local v0    # "result":Lcom/amazonaws/services/s3/model/UploadPartResult;
    :catchall_1
    move-exception v0

    goto :goto_4

    .end local v19    # "blockSize":I
    .restart local v3    # "blockSize":I
    :catchall_2
    move-exception v0

    move/from16 v19, v3

    .end local v3    # "blockSize":I
    .restart local v19    # "blockSize":I
    goto :goto_4

    .end local v8    # "isCurr":Lcom/amazonaws/internal/SdkFilterInputStream;
    .end local v19    # "blockSize":I
    .restart local v3    # "blockSize":I
    .restart local v16    # "isCurr":Lcom/amazonaws/internal/SdkFilterInputStream;
    :catchall_3
    move-exception v0

    move/from16 v19, v3

    move-object/from16 v8, v16

    .end local v3    # "blockSize":I
    .end local v16    # "isCurr":Lcom/amazonaws/internal/SdkFilterInputStream;
    .restart local v8    # "isCurr":Lcom/amazonaws/internal/SdkFilterInputStream;
    .restart local v19    # "blockSize":I
    :goto_4
    iget-object v3, v1, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;->log:Lcom/amazonaws/logging/Log;

    invoke-static {v2, v14, v15, v8, v3}, Lcom/amazonaws/services/s3/model/S3DataSource$Utils;->cleanupDataSource(Lcom/amazonaws/services/s3/model/S3DataSource;Ljava/io/File;Ljava/io/InputStream;Ljava/io/InputStream;Lcom/amazonaws/logging/Log;)V

    .line 345
    invoke-virtual {v12}, Lcom/amazonaws/services/s3/internal/crypto/MultipartUploadCryptoContext;->endPartUpload()V

    .line 346
    throw v0

    .line 307
    .end local v8    # "isCurr":Lcom/amazonaws/internal/SdkFilterInputStream;
    .end local v13    # "cipherLite":Lcom/amazonaws/services/s3/internal/crypto/CipherLite;
    .end local v14    # "fileOrig":Ljava/io/File;
    .end local v15    # "isOrig":Ljava/io/InputStream;
    .end local v19    # "blockSize":I
    .restart local v3    # "blockSize":I
    :cond_7
    move/from16 v19, v3

    .end local v3    # "blockSize":I
    .restart local v19    # "blockSize":I
    new-instance v0, Lcom/amazonaws/AmazonClientException;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "No client-side information available on upload ID "

    invoke-virtual {v3, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-direct {v0, v3}, Lcom/amazonaws/AmazonClientException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method abstract wrapForMultipart(Lcom/amazonaws/services/s3/internal/crypto/CipherLiteInputStream;J)Lcom/amazonaws/internal/SdkFilterInputStream;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<I:",
            "Lcom/amazonaws/services/s3/internal/crypto/CipherLiteInputStream;",
            ">(TI;J)",
            "Lcom/amazonaws/internal/SdkFilterInputStream;"
        }
    .end annotation
.end method

.method protected final wrapWithCipher(Lcom/amazonaws/services/s3/model/AbstractPutObjectRequest;Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;)Lcom/amazonaws/services/s3/model/AbstractPutObjectRequest;
    .locals 6
    .param p2, "cekMaterial"    # Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<R:",
            "Lcom/amazonaws/services/s3/model/AbstractPutObjectRequest;",
            ">(TR;",
            "Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;",
            ")TR;"
        }
    .end annotation

    .line 623
    .local p0, "this":Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;, "Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase<TT;>;"
    .local p1, "request":Lcom/amazonaws/services/s3/model/AbstractPutObjectRequest;, "TR;"
    invoke-virtual {p1}, Lcom/amazonaws/services/s3/model/AbstractPutObjectRequest;->getMetadata()Lcom/amazonaws/services/s3/model/ObjectMetadata;

    move-result-object v0

    .line 624
    .local v0, "metadata":Lcom/amazonaws/services/s3/model/ObjectMetadata;
    if-nez v0, :cond_0

    .line 625
    new-instance v1, Lcom/amazonaws/services/s3/model/ObjectMetadata;

    invoke-direct {v1}, Lcom/amazonaws/services/s3/model/ObjectMetadata;-><init>()V

    move-object v0, v1

    .line 629
    :cond_0
    invoke-virtual {v0}, Lcom/amazonaws/services/s3/model/ObjectMetadata;->getContentMD5()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_1

    .line 630
    nop

    .line 631
    invoke-virtual {v0}, Lcom/amazonaws/services/s3/model/ObjectMetadata;->getContentMD5()Ljava/lang/String;

    move-result-object v1

    .line 630
    const-string/jumbo v2, "x-amz-unencrypted-content-md5"

    invoke-virtual {v0, v2, v1}, Lcom/amazonaws/services/s3/model/ObjectMetadata;->addUserMetadata(Ljava/lang/String;Ljava/lang/String;)V

    .line 635
    :cond_1
    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lcom/amazonaws/services/s3/model/ObjectMetadata;->setContentMD5(Ljava/lang/String;)V

    .line 639
    invoke-virtual {p0, p1, v0}, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;->plaintextLength(Lcom/amazonaws/services/s3/model/AbstractPutObjectRequest;Lcom/amazonaws/services/s3/model/ObjectMetadata;)J

    move-result-wide v2

    .line 640
    .local v2, "plaintextLength":J
    const-wide/16 v4, 0x0

    cmp-long v4, v2, v4

    if-ltz v4, :cond_2

    .line 641
    nop

    .line 642
    invoke-static {v2, v3}, Ljava/lang/Long;->toString(J)Ljava/lang/String;

    move-result-object v4

    .line 641
    const-string/jumbo v5, "x-amz-unencrypted-content-length"

    invoke-virtual {v0, v5, v4}, Lcom/amazonaws/services/s3/model/ObjectMetadata;->addUserMetadata(Ljava/lang/String;Ljava/lang/String;)V

    .line 644
    invoke-virtual {p0, v2, v3}, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;->ciphertextLength(J)J

    move-result-wide v4

    invoke-virtual {v0, v4, v5}, Lcom/amazonaws/services/s3/model/ObjectMetadata;->setContentLength(J)V

    .line 646
    :cond_2
    invoke-virtual {p1, v0}, Lcom/amazonaws/services/s3/model/AbstractPutObjectRequest;->setMetadata(Lcom/amazonaws/services/s3/model/ObjectMetadata;)V

    .line 647
    invoke-direct {p0, p1, p2, v2, v3}, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModuleBase;->newS3CipherLiteInputStream(Lcom/amazonaws/services/s3/model/AbstractPutObjectRequest;Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;J)Lcom/amazonaws/services/s3/internal/crypto/CipherLiteInputStream;

    move-result-object v4

    invoke-virtual {p1, v4}, Lcom/amazonaws/services/s3/model/AbstractPutObjectRequest;->setInputStream(Ljava/io/InputStream;)V

    .line 651
    invoke-virtual {p1, v1}, Lcom/amazonaws/services/s3/model/AbstractPutObjectRequest;->setFile(Ljava/io/File;)V

    .line 652
    return-object p1
.end method
