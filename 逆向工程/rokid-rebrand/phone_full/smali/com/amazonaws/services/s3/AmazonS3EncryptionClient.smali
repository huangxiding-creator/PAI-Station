.class public Lcom/amazonaws/services/s3/AmazonS3EncryptionClient;
.super Lcom/amazonaws/services/s3/AmazonS3Client;
.source "AmazonS3EncryptionClient.java"

# interfaces
.implements Lcom/amazonaws/services/s3/AmazonS3Encryption;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/amazonaws/services/s3/AmazonS3EncryptionClient$S3DirectImpl;
    }
.end annotation

.annotation runtime Ljava/lang/Deprecated;
.end annotation


# static fields
.field public static final USER_AGENT:Ljava/lang/String;


# instance fields
.field private final crypto:Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModule;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModule<",
            "*>;"
        }
    .end annotation
.end field

.field private final isKMSClientInternal:Z

.field private final kms:Lcom/amazonaws/services/kms/AWSKMSClient;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .line 100
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-class v1, Lcom/amazonaws/services/s3/AmazonS3EncryptionClient;

    invoke-virtual {v1}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "/"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    .line 101
    invoke-static {}, Lcom/amazonaws/util/VersionInfoUtils;->getVersion()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/amazonaws/services/s3/AmazonS3EncryptionClient;->USER_AGENT:Ljava/lang/String;

    .line 100
    return-void
.end method

.method public constructor <init>(Lcom/amazonaws/auth/AWSCredentials;Lcom/amazonaws/services/s3/model/EncryptionMaterials;)V
    .locals 1
    .param p1, "credentials"    # Lcom/amazonaws/auth/AWSCredentials;
    .param p2, "encryptionMaterials"    # Lcom/amazonaws/services/s3/model/EncryptionMaterials;

    .line 274
    new-instance v0, Lcom/amazonaws/services/s3/model/StaticEncryptionMaterialsProvider;

    invoke-direct {v0, p2}, Lcom/amazonaws/services/s3/model/StaticEncryptionMaterialsProvider;-><init>(Lcom/amazonaws/services/s3/model/EncryptionMaterials;)V

    invoke-direct {p0, p1, v0}, Lcom/amazonaws/services/s3/AmazonS3EncryptionClient;-><init>(Lcom/amazonaws/auth/AWSCredentials;Lcom/amazonaws/services/s3/model/EncryptionMaterialsProvider;)V

    .line 276
    return-void
.end method

.method public constructor <init>(Lcom/amazonaws/auth/AWSCredentials;Lcom/amazonaws/services/s3/model/EncryptionMaterials;Lcom/amazonaws/ClientConfiguration;Lcom/amazonaws/services/s3/model/CryptoConfiguration;)V
    .locals 1
    .param p1, "credentials"    # Lcom/amazonaws/auth/AWSCredentials;
    .param p2, "encryptionMaterials"    # Lcom/amazonaws/services/s3/model/EncryptionMaterials;
    .param p3, "clientConfig"    # Lcom/amazonaws/ClientConfiguration;
    .param p4, "cryptoConfig"    # Lcom/amazonaws/services/s3/model/CryptoConfiguration;

    .line 411
    new-instance v0, Lcom/amazonaws/services/s3/model/StaticEncryptionMaterialsProvider;

    invoke-direct {v0, p2}, Lcom/amazonaws/services/s3/model/StaticEncryptionMaterialsProvider;-><init>(Lcom/amazonaws/services/s3/model/EncryptionMaterials;)V

    invoke-direct {p0, p1, v0, p3, p4}, Lcom/amazonaws/services/s3/AmazonS3EncryptionClient;-><init>(Lcom/amazonaws/auth/AWSCredentials;Lcom/amazonaws/services/s3/model/EncryptionMaterialsProvider;Lcom/amazonaws/ClientConfiguration;Lcom/amazonaws/services/s3/model/CryptoConfiguration;)V

    .line 413
    return-void
.end method

.method public constructor <init>(Lcom/amazonaws/auth/AWSCredentials;Lcom/amazonaws/services/s3/model/EncryptionMaterials;Lcom/amazonaws/services/s3/model/CryptoConfiguration;)V
    .locals 1
    .param p1, "credentials"    # Lcom/amazonaws/auth/AWSCredentials;
    .param p2, "encryptionMaterials"    # Lcom/amazonaws/services/s3/model/EncryptionMaterials;
    .param p3, "cryptoConfig"    # Lcom/amazonaws/services/s3/model/CryptoConfiguration;

    .line 335
    new-instance v0, Lcom/amazonaws/services/s3/model/StaticEncryptionMaterialsProvider;

    invoke-direct {v0, p2}, Lcom/amazonaws/services/s3/model/StaticEncryptionMaterialsProvider;-><init>(Lcom/amazonaws/services/s3/model/EncryptionMaterials;)V

    invoke-direct {p0, p1, v0, p3}, Lcom/amazonaws/services/s3/AmazonS3EncryptionClient;-><init>(Lcom/amazonaws/auth/AWSCredentials;Lcom/amazonaws/services/s3/model/EncryptionMaterialsProvider;Lcom/amazonaws/services/s3/model/CryptoConfiguration;)V

    .line 337
    return-void
.end method

.method public constructor <init>(Lcom/amazonaws/auth/AWSCredentials;Lcom/amazonaws/services/s3/model/EncryptionMaterialsProvider;)V
    .locals 2
    .param p1, "credentials"    # Lcom/amazonaws/auth/AWSCredentials;
    .param p2, "encryptionMaterialsProvider"    # Lcom/amazonaws/services/s3/model/EncryptionMaterialsProvider;

    .line 292
    new-instance v0, Lcom/amazonaws/ClientConfiguration;

    invoke-direct {v0}, Lcom/amazonaws/ClientConfiguration;-><init>()V

    new-instance v1, Lcom/amazonaws/services/s3/model/CryptoConfiguration;

    invoke-direct {v1}, Lcom/amazonaws/services/s3/model/CryptoConfiguration;-><init>()V

    invoke-direct {p0, p1, p2, v0, v1}, Lcom/amazonaws/services/s3/AmazonS3EncryptionClient;-><init>(Lcom/amazonaws/auth/AWSCredentials;Lcom/amazonaws/services/s3/model/EncryptionMaterialsProvider;Lcom/amazonaws/ClientConfiguration;Lcom/amazonaws/services/s3/model/CryptoConfiguration;)V

    .line 294
    return-void
.end method

.method public constructor <init>(Lcom/amazonaws/auth/AWSCredentials;Lcom/amazonaws/services/s3/model/EncryptionMaterialsProvider;Lcom/amazonaws/ClientConfiguration;Lcom/amazonaws/services/s3/model/CryptoConfiguration;)V
    .locals 1
    .param p1, "credentials"    # Lcom/amazonaws/auth/AWSCredentials;
    .param p2, "encryptionMaterialsProvider"    # Lcom/amazonaws/services/s3/model/EncryptionMaterialsProvider;
    .param p3, "clientConfig"    # Lcom/amazonaws/ClientConfiguration;
    .param p4, "cryptoConfig"    # Lcom/amazonaws/services/s3/model/CryptoConfiguration;

    .line 418
    new-instance v0, Lcom/amazonaws/internal/StaticCredentialsProvider;

    invoke-direct {v0, p1}, Lcom/amazonaws/internal/StaticCredentialsProvider;-><init>(Lcom/amazonaws/auth/AWSCredentials;)V

    invoke-direct {p0, v0, p2, p3, p4}, Lcom/amazonaws/services/s3/AmazonS3EncryptionClient;-><init>(Lcom/amazonaws/auth/AWSCredentialsProvider;Lcom/amazonaws/services/s3/model/EncryptionMaterialsProvider;Lcom/amazonaws/ClientConfiguration;Lcom/amazonaws/services/s3/model/CryptoConfiguration;)V

    .line 420
    return-void
.end method

.method public constructor <init>(Lcom/amazonaws/auth/AWSCredentials;Lcom/amazonaws/services/s3/model/EncryptionMaterialsProvider;Lcom/amazonaws/services/s3/model/CryptoConfiguration;)V
    .locals 1
    .param p1, "credentials"    # Lcom/amazonaws/auth/AWSCredentials;
    .param p2, "encryptionMaterialsProvider"    # Lcom/amazonaws/services/s3/model/EncryptionMaterialsProvider;
    .param p3, "cryptoConfig"    # Lcom/amazonaws/services/s3/model/CryptoConfiguration;

    .line 358
    new-instance v0, Lcom/amazonaws/ClientConfiguration;

    invoke-direct {v0}, Lcom/amazonaws/ClientConfiguration;-><init>()V

    invoke-direct {p0, p1, p2, v0, p3}, Lcom/amazonaws/services/s3/AmazonS3EncryptionClient;-><init>(Lcom/amazonaws/auth/AWSCredentials;Lcom/amazonaws/services/s3/model/EncryptionMaterialsProvider;Lcom/amazonaws/ClientConfiguration;Lcom/amazonaws/services/s3/model/CryptoConfiguration;)V

    .line 360
    return-void
.end method

.method public constructor <init>(Lcom/amazonaws/auth/AWSCredentialsProvider;Lcom/amazonaws/services/s3/model/EncryptionMaterialsProvider;)V
    .locals 2
    .param p1, "credentialsProvider"    # Lcom/amazonaws/auth/AWSCredentialsProvider;
    .param p2, "encryptionMaterialsProvider"    # Lcom/amazonaws/services/s3/model/EncryptionMaterialsProvider;

    .line 312
    new-instance v0, Lcom/amazonaws/ClientConfiguration;

    invoke-direct {v0}, Lcom/amazonaws/ClientConfiguration;-><init>()V

    new-instance v1, Lcom/amazonaws/services/s3/model/CryptoConfiguration;

    invoke-direct {v1}, Lcom/amazonaws/services/s3/model/CryptoConfiguration;-><init>()V

    invoke-direct {p0, p1, p2, v0, v1}, Lcom/amazonaws/services/s3/AmazonS3EncryptionClient;-><init>(Lcom/amazonaws/auth/AWSCredentialsProvider;Lcom/amazonaws/services/s3/model/EncryptionMaterialsProvider;Lcom/amazonaws/ClientConfiguration;Lcom/amazonaws/services/s3/model/CryptoConfiguration;)V

    .line 314
    return-void
.end method

.method public constructor <init>(Lcom/amazonaws/auth/AWSCredentialsProvider;Lcom/amazonaws/services/s3/model/EncryptionMaterialsProvider;Lcom/amazonaws/ClientConfiguration;Lcom/amazonaws/services/s3/model/CryptoConfiguration;)V
    .locals 6
    .param p1, "credentialsProvider"    # Lcom/amazonaws/auth/AWSCredentialsProvider;
    .param p2, "kekMaterialsProvider"    # Lcom/amazonaws/services/s3/model/EncryptionMaterialsProvider;
    .param p3, "clientConfig"    # Lcom/amazonaws/ClientConfiguration;
    .param p4, "cryptoConfig"    # Lcom/amazonaws/services/s3/model/CryptoConfiguration;

    .line 427
    const/4 v5, 0x0

    move-object v0, p0

    move-object v1, p1

    move-object v2, p2

    move-object v3, p3

    move-object v4, p4

    invoke-direct/range {v0 .. v5}, Lcom/amazonaws/services/s3/AmazonS3EncryptionClient;-><init>(Lcom/amazonaws/auth/AWSCredentialsProvider;Lcom/amazonaws/services/s3/model/EncryptionMaterialsProvider;Lcom/amazonaws/ClientConfiguration;Lcom/amazonaws/services/s3/model/CryptoConfiguration;Lcom/amazonaws/metrics/RequestMetricCollector;)V

    .line 431
    return-void
.end method

.method public constructor <init>(Lcom/amazonaws/auth/AWSCredentialsProvider;Lcom/amazonaws/services/s3/model/EncryptionMaterialsProvider;Lcom/amazonaws/ClientConfiguration;Lcom/amazonaws/services/s3/model/CryptoConfiguration;Lcom/amazonaws/metrics/RequestMetricCollector;)V
    .locals 7
    .param p1, "credentialsProvider"    # Lcom/amazonaws/auth/AWSCredentialsProvider;
    .param p2, "kekMaterialsProvider"    # Lcom/amazonaws/services/s3/model/EncryptionMaterialsProvider;
    .param p3, "clientConfig"    # Lcom/amazonaws/ClientConfiguration;
    .param p4, "cryptoConfig"    # Lcom/amazonaws/services/s3/model/CryptoConfiguration;
    .param p5, "requestMetricCollector"    # Lcom/amazonaws/metrics/RequestMetricCollector;

    .line 438
    const/4 v1, 0x0

    move-object v0, p0

    move-object v2, p1

    move-object v3, p2

    move-object v4, p3

    move-object v5, p4

    move-object v6, p5

    invoke-direct/range {v0 .. v6}, Lcom/amazonaws/services/s3/AmazonS3EncryptionClient;-><init>(Lcom/amazonaws/services/kms/AWSKMSClient;Lcom/amazonaws/auth/AWSCredentialsProvider;Lcom/amazonaws/services/s3/model/EncryptionMaterialsProvider;Lcom/amazonaws/ClientConfiguration;Lcom/amazonaws/services/s3/model/CryptoConfiguration;Lcom/amazonaws/metrics/RequestMetricCollector;)V

    .line 441
    return-void
.end method

.method public constructor <init>(Lcom/amazonaws/auth/AWSCredentialsProvider;Lcom/amazonaws/services/s3/model/EncryptionMaterialsProvider;Lcom/amazonaws/services/s3/model/CryptoConfiguration;)V
    .locals 1
    .param p1, "credentialsProvider"    # Lcom/amazonaws/auth/AWSCredentialsProvider;
    .param p2, "encryptionMaterialsProvider"    # Lcom/amazonaws/services/s3/model/EncryptionMaterialsProvider;
    .param p3, "cryptoConfig"    # Lcom/amazonaws/services/s3/model/CryptoConfiguration;

    .line 383
    new-instance v0, Lcom/amazonaws/ClientConfiguration;

    invoke-direct {v0}, Lcom/amazonaws/ClientConfiguration;-><init>()V

    invoke-direct {p0, p1, p2, v0, p3}, Lcom/amazonaws/services/s3/AmazonS3EncryptionClient;-><init>(Lcom/amazonaws/auth/AWSCredentialsProvider;Lcom/amazonaws/services/s3/model/EncryptionMaterialsProvider;Lcom/amazonaws/ClientConfiguration;Lcom/amazonaws/services/s3/model/CryptoConfiguration;)V

    .line 385
    return-void
.end method

.method public constructor <init>(Lcom/amazonaws/services/kms/AWSKMSClient;Lcom/amazonaws/auth/AWSCredentialsProvider;Lcom/amazonaws/services/s3/model/EncryptionMaterialsProvider;Lcom/amazonaws/ClientConfiguration;Lcom/amazonaws/services/s3/model/CryptoConfiguration;Lcom/amazonaws/metrics/RequestMetricCollector;)V
    .locals 7
    .param p1, "kms"    # Lcom/amazonaws/services/kms/AWSKMSClient;
    .param p2, "credentialsProvider"    # Lcom/amazonaws/auth/AWSCredentialsProvider;
    .param p3, "kekMaterialsProvider"    # Lcom/amazonaws/services/s3/model/EncryptionMaterialsProvider;
    .param p4, "clientConfig"    # Lcom/amazonaws/ClientConfiguration;
    .param p5, "cryptoConfig"    # Lcom/amazonaws/services/s3/model/CryptoConfiguration;
    .param p6, "requestMetricCollector"    # Lcom/amazonaws/metrics/RequestMetricCollector;

    .line 449
    invoke-direct {p0, p2, p4, p6}, Lcom/amazonaws/services/s3/AmazonS3Client;-><init>(Lcom/amazonaws/auth/AWSCredentialsProvider;Lcom/amazonaws/ClientConfiguration;Lcom/amazonaws/metrics/RequestMetricCollector;)V

    .line 450
    const-string v0, "EncryptionMaterialsProvider parameter must not be null."

    invoke-direct {p0, p3, v0}, Lcom/amazonaws/services/s3/AmazonS3EncryptionClient;->assertParameterNotNull(Ljava/lang/Object;Ljava/lang/String;)V

    .line 452
    const-string v0, "CryptoConfiguration parameter must not be null."

    invoke-direct {p0, p5, v0}, Lcom/amazonaws/services/s3/AmazonS3EncryptionClient;->assertParameterNotNull(Ljava/lang/Object;Ljava/lang/String;)V

    .line 454
    if-nez p1, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    iput-boolean v0, p0, Lcom/amazonaws/services/s3/AmazonS3EncryptionClient;->isKMSClientInternal:Z

    .line 455
    iget-boolean v0, p0, Lcom/amazonaws/services/s3/AmazonS3EncryptionClient;->isKMSClientInternal:Z

    if-eqz v0, :cond_1

    .line 456
    invoke-direct {p0, p2, p4, p5, p6}, Lcom/amazonaws/services/s3/AmazonS3EncryptionClient;->newAWSKMSClient(Lcom/amazonaws/auth/AWSCredentialsProvider;Lcom/amazonaws/ClientConfiguration;Lcom/amazonaws/services/s3/model/CryptoConfiguration;Lcom/amazonaws/metrics/RequestMetricCollector;)Lcom/amazonaws/services/kms/AWSKMSClient;

    move-result-object v0

    goto :goto_1

    :cond_1
    move-object v0, p1

    :goto_1
    iput-object v0, p0, Lcom/amazonaws/services/s3/AmazonS3EncryptionClient;->kms:Lcom/amazonaws/services/kms/AWSKMSClient;

    .line 459
    new-instance v0, Lcom/amazonaws/services/s3/internal/crypto/CryptoModuleDispatcher;

    iget-object v2, p0, Lcom/amazonaws/services/s3/AmazonS3EncryptionClient;->kms:Lcom/amazonaws/services/kms/AWSKMSClient;

    new-instance v3, Lcom/amazonaws/services/s3/AmazonS3EncryptionClient$S3DirectImpl;

    const/4 v1, 0x0

    invoke-direct {v3, p0, v1}, Lcom/amazonaws/services/s3/AmazonS3EncryptionClient$S3DirectImpl;-><init>(Lcom/amazonaws/services/s3/AmazonS3EncryptionClient;Lcom/amazonaws/services/s3/AmazonS3EncryptionClient$1;)V

    move-object v1, v0

    move-object v4, p2

    move-object v5, p3

    move-object v6, p5

    invoke-direct/range {v1 .. v6}, Lcom/amazonaws/services/s3/internal/crypto/CryptoModuleDispatcher;-><init>(Lcom/amazonaws/services/kms/AWSKMSClient;Lcom/amazonaws/services/s3/internal/S3Direct;Lcom/amazonaws/auth/AWSCredentialsProvider;Lcom/amazonaws/services/s3/model/EncryptionMaterialsProvider;Lcom/amazonaws/services/s3/model/CryptoConfiguration;)V

    iput-object v0, p0, Lcom/amazonaws/services/s3/AmazonS3EncryptionClient;->crypto:Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModule;

    .line 461
    return-void
.end method

.method public constructor <init>(Lcom/amazonaws/services/s3/model/EncryptionMaterials;)V
    .locals 1
    .param p1, "encryptionMaterials"    # Lcom/amazonaws/services/s3/model/EncryptionMaterials;

    .line 143
    new-instance v0, Lcom/amazonaws/services/s3/model/StaticEncryptionMaterialsProvider;

    invoke-direct {v0, p1}, Lcom/amazonaws/services/s3/model/StaticEncryptionMaterialsProvider;-><init>(Lcom/amazonaws/services/s3/model/EncryptionMaterials;)V

    invoke-direct {p0, v0}, Lcom/amazonaws/services/s3/AmazonS3EncryptionClient;-><init>(Lcom/amazonaws/services/s3/model/EncryptionMaterialsProvider;)V

    .line 144
    return-void
.end method

.method public constructor <init>(Lcom/amazonaws/services/s3/model/EncryptionMaterials;Lcom/amazonaws/services/s3/model/CryptoConfiguration;)V
    .locals 1
    .param p1, "encryptionMaterials"    # Lcom/amazonaws/services/s3/model/EncryptionMaterials;
    .param p2, "cryptoConfig"    # Lcom/amazonaws/services/s3/model/CryptoConfiguration;

    .line 216
    new-instance v0, Lcom/amazonaws/services/s3/model/StaticEncryptionMaterialsProvider;

    invoke-direct {v0, p1}, Lcom/amazonaws/services/s3/model/StaticEncryptionMaterialsProvider;-><init>(Lcom/amazonaws/services/s3/model/EncryptionMaterials;)V

    invoke-direct {p0, v0, p2}, Lcom/amazonaws/services/s3/AmazonS3EncryptionClient;-><init>(Lcom/amazonaws/services/s3/model/EncryptionMaterialsProvider;Lcom/amazonaws/services/s3/model/CryptoConfiguration;)V

    .line 218
    return-void
.end method

.method public constructor <init>(Lcom/amazonaws/services/s3/model/EncryptionMaterialsProvider;)V
    .locals 3
    .param p1, "encryptionMaterialsProvider"    # Lcom/amazonaws/services/s3/model/EncryptionMaterialsProvider;

    .line 177
    const/4 v0, 0x0

    move-object v1, v0

    check-cast v1, Lcom/amazonaws/auth/AWSCredentialsProvider;

    new-instance v1, Lcom/amazonaws/ClientConfiguration;

    invoke-direct {v1}, Lcom/amazonaws/ClientConfiguration;-><init>()V

    new-instance v2, Lcom/amazonaws/services/s3/model/CryptoConfiguration;

    invoke-direct {v2}, Lcom/amazonaws/services/s3/model/CryptoConfiguration;-><init>()V

    invoke-direct {p0, v0, p1, v1, v2}, Lcom/amazonaws/services/s3/AmazonS3EncryptionClient;-><init>(Lcom/amazonaws/auth/AWSCredentialsProvider;Lcom/amazonaws/services/s3/model/EncryptionMaterialsProvider;Lcom/amazonaws/ClientConfiguration;Lcom/amazonaws/services/s3/model/CryptoConfiguration;)V

    .line 179
    return-void
.end method

.method public constructor <init>(Lcom/amazonaws/services/s3/model/EncryptionMaterialsProvider;Lcom/amazonaws/services/s3/model/CryptoConfiguration;)V
    .locals 2
    .param p1, "encryptionMaterialsProvider"    # Lcom/amazonaws/services/s3/model/EncryptionMaterialsProvider;
    .param p2, "cryptoConfig"    # Lcom/amazonaws/services/s3/model/CryptoConfiguration;

    .line 256
    const/4 v0, 0x0

    move-object v1, v0

    check-cast v1, Lcom/amazonaws/auth/AWSCredentialsProvider;

    new-instance v1, Lcom/amazonaws/ClientConfiguration;

    invoke-direct {v1}, Lcom/amazonaws/ClientConfiguration;-><init>()V

    invoke-direct {p0, v0, p1, v1, p2}, Lcom/amazonaws/services/s3/AmazonS3EncryptionClient;-><init>(Lcom/amazonaws/auth/AWSCredentialsProvider;Lcom/amazonaws/services/s3/model/EncryptionMaterialsProvider;Lcom/amazonaws/ClientConfiguration;Lcom/amazonaws/services/s3/model/CryptoConfiguration;)V

    .line 258
    return-void
.end method

.method static synthetic access$101(Lcom/amazonaws/services/s3/AmazonS3EncryptionClient;Lcom/amazonaws/services/s3/model/PutObjectRequest;)Lcom/amazonaws/services/s3/model/PutObjectResult;
    .locals 1
    .param p0, "x0"    # Lcom/amazonaws/services/s3/AmazonS3EncryptionClient;
    .param p1, "x1"    # Lcom/amazonaws/services/s3/model/PutObjectRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonClientException;,
            Lcom/amazonaws/AmazonServiceException;
        }
    .end annotation

    .line 98
    invoke-super {p0, p1}, Lcom/amazonaws/services/s3/AmazonS3Client;->putObject(Lcom/amazonaws/services/s3/model/PutObjectRequest;)Lcom/amazonaws/services/s3/model/PutObjectResult;

    move-result-object v0

    return-object v0
.end method

.method static synthetic access$201(Lcom/amazonaws/services/s3/AmazonS3EncryptionClient;Lcom/amazonaws/services/s3/model/GetObjectRequest;)Lcom/amazonaws/services/s3/model/S3Object;
    .locals 1
    .param p0, "x0"    # Lcom/amazonaws/services/s3/AmazonS3EncryptionClient;
    .param p1, "x1"    # Lcom/amazonaws/services/s3/model/GetObjectRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonClientException;,
            Lcom/amazonaws/AmazonServiceException;
        }
    .end annotation

    .line 98
    invoke-super {p0, p1}, Lcom/amazonaws/services/s3/AmazonS3Client;->getObject(Lcom/amazonaws/services/s3/model/GetObjectRequest;)Lcom/amazonaws/services/s3/model/S3Object;

    move-result-object v0

    return-object v0
.end method

.method static synthetic access$301(Lcom/amazonaws/services/s3/AmazonS3EncryptionClient;Lcom/amazonaws/services/s3/model/GetObjectRequest;Ljava/io/File;)Lcom/amazonaws/services/s3/model/ObjectMetadata;
    .locals 1
    .param p0, "x0"    # Lcom/amazonaws/services/s3/AmazonS3EncryptionClient;
    .param p1, "x1"    # Lcom/amazonaws/services/s3/model/GetObjectRequest;
    .param p2, "x2"    # Ljava/io/File;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonClientException;,
            Lcom/amazonaws/AmazonServiceException;
        }
    .end annotation

    .line 98
    invoke-super {p0, p1, p2}, Lcom/amazonaws/services/s3/AmazonS3Client;->getObject(Lcom/amazonaws/services/s3/model/GetObjectRequest;Ljava/io/File;)Lcom/amazonaws/services/s3/model/ObjectMetadata;

    move-result-object v0

    return-object v0
.end method

.method static synthetic access$401(Lcom/amazonaws/services/s3/AmazonS3EncryptionClient;Lcom/amazonaws/services/s3/model/CompleteMultipartUploadRequest;)Lcom/amazonaws/services/s3/model/CompleteMultipartUploadResult;
    .locals 1
    .param p0, "x0"    # Lcom/amazonaws/services/s3/AmazonS3EncryptionClient;
    .param p1, "x1"    # Lcom/amazonaws/services/s3/model/CompleteMultipartUploadRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonClientException;,
            Lcom/amazonaws/AmazonServiceException;
        }
    .end annotation

    .line 98
    invoke-super {p0, p1}, Lcom/amazonaws/services/s3/AmazonS3Client;->completeMultipartUpload(Lcom/amazonaws/services/s3/model/CompleteMultipartUploadRequest;)Lcom/amazonaws/services/s3/model/CompleteMultipartUploadResult;

    move-result-object v0

    return-object v0
.end method

.method static synthetic access$501(Lcom/amazonaws/services/s3/AmazonS3EncryptionClient;Lcom/amazonaws/services/s3/model/InitiateMultipartUploadRequest;)Lcom/amazonaws/services/s3/model/InitiateMultipartUploadResult;
    .locals 1
    .param p0, "x0"    # Lcom/amazonaws/services/s3/AmazonS3EncryptionClient;
    .param p1, "x1"    # Lcom/amazonaws/services/s3/model/InitiateMultipartUploadRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonClientException;,
            Lcom/amazonaws/AmazonServiceException;
        }
    .end annotation

    .line 98
    invoke-super {p0, p1}, Lcom/amazonaws/services/s3/AmazonS3Client;->initiateMultipartUpload(Lcom/amazonaws/services/s3/model/InitiateMultipartUploadRequest;)Lcom/amazonaws/services/s3/model/InitiateMultipartUploadResult;

    move-result-object v0

    return-object v0
.end method

.method static synthetic access$601(Lcom/amazonaws/services/s3/AmazonS3EncryptionClient;Lcom/amazonaws/services/s3/model/UploadPartRequest;)Lcom/amazonaws/services/s3/model/UploadPartResult;
    .locals 1
    .param p0, "x0"    # Lcom/amazonaws/services/s3/AmazonS3EncryptionClient;
    .param p1, "x1"    # Lcom/amazonaws/services/s3/model/UploadPartRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonClientException;,
            Lcom/amazonaws/AmazonServiceException;
        }
    .end annotation

    .line 98
    invoke-super {p0, p1}, Lcom/amazonaws/services/s3/AmazonS3Client;->uploadPart(Lcom/amazonaws/services/s3/model/UploadPartRequest;)Lcom/amazonaws/services/s3/model/UploadPartResult;

    move-result-object v0

    return-object v0
.end method

.method static synthetic access$701(Lcom/amazonaws/services/s3/AmazonS3EncryptionClient;Lcom/amazonaws/services/s3/model/CopyPartRequest;)Lcom/amazonaws/services/s3/model/CopyPartResult;
    .locals 1
    .param p0, "x0"    # Lcom/amazonaws/services/s3/AmazonS3EncryptionClient;
    .param p1, "x1"    # Lcom/amazonaws/services/s3/model/CopyPartRequest;

    .line 98
    invoke-super {p0, p1}, Lcom/amazonaws/services/s3/AmazonS3Client;->copyPart(Lcom/amazonaws/services/s3/model/CopyPartRequest;)Lcom/amazonaws/services/s3/model/CopyPartResult;

    move-result-object v0

    return-object v0
.end method

.method static synthetic access$801(Lcom/amazonaws/services/s3/AmazonS3EncryptionClient;Lcom/amazonaws/services/s3/model/AbortMultipartUploadRequest;)V
    .locals 0
    .param p0, "x0"    # Lcom/amazonaws/services/s3/AmazonS3EncryptionClient;
    .param p1, "x1"    # Lcom/amazonaws/services/s3/model/AbortMultipartUploadRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonClientException;,
            Lcom/amazonaws/AmazonServiceException;
        }
    .end annotation

    .line 98
    invoke-super {p0, p1}, Lcom/amazonaws/services/s3/AmazonS3Client;->abortMultipartUpload(Lcom/amazonaws/services/s3/model/AbortMultipartUploadRequest;)V

    return-void
.end method

.method private assertParameterNotNull(Ljava/lang/Object;Ljava/lang/String;)V
    .locals 1
    .param p1, "parameterValue"    # Ljava/lang/Object;
    .param p2, "errorMessage"    # Ljava/lang/String;

    .line 483
    if-eqz p1, :cond_0

    .line 486
    return-void

    .line 484
    :cond_0
    new-instance v0, Ljava/lang/IllegalArgumentException;

    invoke-direct {v0, p2}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method private newAWSKMSClient(Lcom/amazonaws/auth/AWSCredentialsProvider;Lcom/amazonaws/ClientConfiguration;Lcom/amazonaws/services/s3/model/CryptoConfiguration;Lcom/amazonaws/metrics/RequestMetricCollector;)Lcom/amazonaws/services/kms/AWSKMSClient;
    .locals 2
    .param p1, "credentialsProvider"    # Lcom/amazonaws/auth/AWSCredentialsProvider;
    .param p2, "clientConfig"    # Lcom/amazonaws/ClientConfiguration;
    .param p3, "cryptoConfig"    # Lcom/amazonaws/services/s3/model/CryptoConfiguration;
    .param p4, "requestMetricCollector"    # Lcom/amazonaws/metrics/RequestMetricCollector;

    .line 473
    new-instance v0, Lcom/amazonaws/services/kms/AWSKMSClient;

    invoke-direct {v0, p1, p2, p4}, Lcom/amazonaws/services/kms/AWSKMSClient;-><init>(Lcom/amazonaws/auth/AWSCredentialsProvider;Lcom/amazonaws/ClientConfiguration;Lcom/amazonaws/metrics/RequestMetricCollector;)V

    .line 475
    .local v0, "kmsClient":Lcom/amazonaws/services/kms/AWSKMSClient;
    invoke-virtual {p3}, Lcom/amazonaws/services/s3/model/CryptoConfiguration;->getAwsKmsRegion()Lcom/amazonaws/regions/Region;

    move-result-object v1

    .line 476
    .local v1, "kmsRegion":Lcom/amazonaws/regions/Region;
    if-eqz v1, :cond_0

    .line 477
    invoke-virtual {v0, v1}, Lcom/amazonaws/services/kms/AWSKMSClient;->setRegion(Lcom/amazonaws/regions/Region;)V

    .line 478
    :cond_0
    return-object v0
.end method

.method private onAbort(Lcom/amazonaws/services/s3/UploadObjectObserver;Ljava/lang/Throwable;)Ljava/lang/Throwable;
    .locals 0
    .param p1, "observer"    # Lcom/amazonaws/services/s3/UploadObjectObserver;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Ljava/lang/Throwable;",
            ">(",
            "Lcom/amazonaws/services/s3/UploadObjectObserver;",
            "TT;)TT;"
        }
    .end annotation

    .line 777
    .local p2, "t":Ljava/lang/Throwable;, "TT;"
    invoke-virtual {p1}, Lcom/amazonaws/services/s3/UploadObjectObserver;->onAbort()V

    .line 778
    return-object p2
.end method


# virtual methods
.method public abortMultipartUpload(Lcom/amazonaws/services/s3/model/AbortMultipartUploadRequest;)V
    .locals 1
    .param p1, "req"    # Lcom/amazonaws/services/s3/model/AbortMultipartUploadRequest;

    .line 581
    iget-object v0, p0, Lcom/amazonaws/services/s3/AmazonS3EncryptionClient;->crypto:Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModule;

    invoke-virtual {v0, p1}, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModule;->abortMultipartUploadSecurely(Lcom/amazonaws/services/s3/model/AbortMultipartUploadRequest;)V

    .line 582
    return-void
.end method

.method public completeMultipartUpload(Lcom/amazonaws/services/s3/model/CompleteMultipartUploadRequest;)Lcom/amazonaws/services/s3/model/CompleteMultipartUploadResult;
    .locals 1
    .param p1, "req"    # Lcom/amazonaws/services/s3/model/CompleteMultipartUploadRequest;

    .line 530
    iget-object v0, p0, Lcom/amazonaws/services/s3/AmazonS3EncryptionClient;->crypto:Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModule;

    invoke-virtual {v0, p1}, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModule;->completeMultipartUploadSecurely(Lcom/amazonaws/services/s3/model/CompleteMultipartUploadRequest;)Lcom/amazonaws/services/s3/model/CompleteMultipartUploadResult;

    move-result-object v0

    return-object v0
.end method

.method public copyPart(Lcom/amazonaws/services/s3/model/CopyPartRequest;)Lcom/amazonaws/services/s3/model/CopyPartResult;
    .locals 1
    .param p1, "copyPartRequest"    # Lcom/amazonaws/services/s3/model/CopyPartRequest;

    .line 576
    iget-object v0, p0, Lcom/amazonaws/services/s3/AmazonS3EncryptionClient;->crypto:Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModule;

    invoke-virtual {v0, p1}, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModule;->copyPartSecurely(Lcom/amazonaws/services/s3/model/CopyPartRequest;)Lcom/amazonaws/services/s3/model/CopyPartResult;

    move-result-object v0

    return-object v0
.end method

.method public deleteObject(Lcom/amazonaws/services/s3/model/DeleteObjectRequest;)V
    .locals 4
    .param p1, "req"    # Lcom/amazonaws/services/s3/model/DeleteObjectRequest;

    .line 516
    invoke-virtual {p1}, Lcom/amazonaws/services/s3/model/DeleteObjectRequest;->getRequestClientOptions()Lcom/amazonaws/RequestClientOptions;

    move-result-object v0

    sget-object v1, Lcom/amazonaws/services/s3/AmazonS3EncryptionClient;->USER_AGENT:Ljava/lang/String;

    invoke-virtual {v0, v1}, Lcom/amazonaws/RequestClientOptions;->appendUserAgent(Ljava/lang/String;)V

    .line 518
    invoke-super {p0, p1}, Lcom/amazonaws/services/s3/AmazonS3Client;->deleteObject(Lcom/amazonaws/services/s3/model/DeleteObjectRequest;)V

    .line 520
    new-instance v0, Lcom/amazonaws/services/s3/model/S3ObjectId;

    invoke-virtual {p1}, Lcom/amazonaws/services/s3/model/DeleteObjectRequest;->getBucketName()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p1}, Lcom/amazonaws/services/s3/model/DeleteObjectRequest;->getKey()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v0, v1, v2}, Lcom/amazonaws/services/s3/model/S3ObjectId;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    invoke-virtual {v0}, Lcom/amazonaws/services/s3/model/S3ObjectId;->instructionFileId()Lcom/amazonaws/services/s3/model/InstructionFileId;

    move-result-object v0

    .line 522
    .local v0, "ifid":Lcom/amazonaws/services/s3/model/InstructionFileId;
    invoke-virtual {p1}, Lcom/amazonaws/services/s3/model/DeleteObjectRequest;->clone()Lcom/amazonaws/AmazonWebServiceRequest;

    move-result-object v1

    check-cast v1, Lcom/amazonaws/services/s3/model/DeleteObjectRequest;

    .line 523
    .local v1, "instructionDeleteRequest":Lcom/amazonaws/services/s3/model/DeleteObjectRequest;
    invoke-virtual {v0}, Lcom/amazonaws/services/s3/model/InstructionFileId;->getBucket()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Lcom/amazonaws/services/s3/model/DeleteObjectRequest;->withBucketName(Ljava/lang/String;)Lcom/amazonaws/services/s3/model/DeleteObjectRequest;

    move-result-object v2

    invoke-virtual {v0}, Lcom/amazonaws/services/s3/model/InstructionFileId;->getKey()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Lcom/amazonaws/services/s3/model/DeleteObjectRequest;->withKey(Ljava/lang/String;)Lcom/amazonaws/services/s3/model/DeleteObjectRequest;

    .line 524
    invoke-super {p0, v1}, Lcom/amazonaws/services/s3/AmazonS3Client;->deleteObject(Lcom/amazonaws/services/s3/model/DeleteObjectRequest;)V

    .line 525
    return-void
.end method

.method public getObject(Lcom/amazonaws/services/s3/model/GetObjectRequest;Ljava/io/File;)Lcom/amazonaws/services/s3/model/ObjectMetadata;
    .locals 1
    .param p1, "req"    # Lcom/amazonaws/services/s3/model/GetObjectRequest;
    .param p2, "dest"    # Ljava/io/File;

    .line 511
    iget-object v0, p0, Lcom/amazonaws/services/s3/AmazonS3EncryptionClient;->crypto:Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModule;

    invoke-virtual {v0, p1, p2}, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModule;->getObjectSecurely(Lcom/amazonaws/services/s3/model/GetObjectRequest;Ljava/io/File;)Lcom/amazonaws/services/s3/model/ObjectMetadata;

    move-result-object v0

    return-object v0
.end method

.method public getObject(Lcom/amazonaws/services/s3/model/GetObjectRequest;)Lcom/amazonaws/services/s3/model/S3Object;
    .locals 1
    .param p1, "req"    # Lcom/amazonaws/services/s3/model/GetObjectRequest;

    .line 506
    iget-object v0, p0, Lcom/amazonaws/services/s3/AmazonS3EncryptionClient;->crypto:Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModule;

    invoke-virtual {v0, p1}, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModule;->getObjectSecurely(Lcom/amazonaws/services/s3/model/GetObjectRequest;)Lcom/amazonaws/services/s3/model/S3Object;

    move-result-object v0

    return-object v0
.end method

.method public initiateMultipartUpload(Lcom/amazonaws/services/s3/model/InitiateMultipartUploadRequest;)Lcom/amazonaws/services/s3/model/InitiateMultipartUploadResult;
    .locals 2
    .param p1, "req"    # Lcom/amazonaws/services/s3/model/InitiateMultipartUploadRequest;

    .line 547
    const/4 v0, 0x1

    .line 548
    .local v0, "isCreateEncryptionMaterial":Z
    instance-of v1, p1, Lcom/amazonaws/services/s3/model/EncryptedInitiateMultipartUploadRequest;

    if-eqz v1, :cond_0

    .line 549
    move-object v1, p1

    check-cast v1, Lcom/amazonaws/services/s3/model/EncryptedInitiateMultipartUploadRequest;

    .line 551
    .local v1, "cryptoReq":Lcom/amazonaws/services/s3/model/EncryptedInitiateMultipartUploadRequest;
    invoke-virtual {v1}, Lcom/amazonaws/services/s3/model/EncryptedInitiateMultipartUploadRequest;->isCreateEncryptionMaterial()Z

    move-result v0

    .line 553
    .end local v1    # "cryptoReq":Lcom/amazonaws/services/s3/model/EncryptedInitiateMultipartUploadRequest;
    :cond_0
    if-eqz v0, :cond_1

    iget-object v1, p0, Lcom/amazonaws/services/s3/AmazonS3EncryptionClient;->crypto:Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModule;

    .line 554
    invoke-virtual {v1, p1}, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModule;->initiateMultipartUploadSecurely(Lcom/amazonaws/services/s3/model/InitiateMultipartUploadRequest;)Lcom/amazonaws/services/s3/model/InitiateMultipartUploadResult;

    move-result-object v1

    goto :goto_0

    .line 555
    :cond_1
    invoke-super {p0, p1}, Lcom/amazonaws/services/s3/AmazonS3Client;->initiateMultipartUpload(Lcom/amazonaws/services/s3/model/InitiateMultipartUploadRequest;)Lcom/amazonaws/services/s3/model/InitiateMultipartUploadResult;

    move-result-object v1

    .line 553
    :goto_0
    return-object v1
.end method

.method public putInstructionFile(Lcom/amazonaws/services/s3/model/PutInstructionFileRequest;)Lcom/amazonaws/services/s3/model/PutObjectResult;
    .locals 1
    .param p1, "req"    # Lcom/amazonaws/services/s3/model/PutInstructionFileRequest;

    .line 596
    iget-object v0, p0, Lcom/amazonaws/services/s3/AmazonS3EncryptionClient;->crypto:Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModule;

    invoke-virtual {v0, p1}, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModule;->putInstructionFileSecurely(Lcom/amazonaws/services/s3/model/PutInstructionFileRequest;)Lcom/amazonaws/services/s3/model/PutObjectResult;

    move-result-object v0

    return-object v0
.end method

.method public putObject(Lcom/amazonaws/services/s3/model/PutObjectRequest;)Lcom/amazonaws/services/s3/model/PutObjectResult;
    .locals 2
    .param p1, "req"    # Lcom/amazonaws/services/s3/model/PutObjectRequest;

    .line 501
    iget-object v0, p0, Lcom/amazonaws/services/s3/AmazonS3EncryptionClient;->crypto:Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModule;

    invoke-virtual {p1}, Lcom/amazonaws/services/s3/model/PutObjectRequest;->clone()Lcom/amazonaws/services/s3/model/PutObjectRequest;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModule;->putObjectSecurely(Lcom/amazonaws/services/s3/model/PutObjectRequest;)Lcom/amazonaws/services/s3/model/PutObjectResult;

    move-result-object v0

    return-object v0
.end method

.method public shutdown()V
    .locals 1

    .line 609
    invoke-super {p0}, Lcom/amazonaws/services/s3/AmazonS3Client;->shutdown()V

    .line 610
    iget-boolean v0, p0, Lcom/amazonaws/services/s3/AmazonS3EncryptionClient;->isKMSClientInternal:Z

    if-eqz v0, :cond_0

    .line 611
    iget-object v0, p0, Lcom/amazonaws/services/s3/AmazonS3EncryptionClient;->kms:Lcom/amazonaws/services/kms/AWSKMSClient;

    invoke-virtual {v0}, Lcom/amazonaws/services/kms/AWSKMSClient;->shutdown()V

    .line 612
    :cond_0
    return-void
.end method

.method public uploadObject(Lcom/amazonaws/services/s3/model/UploadObjectRequest;)Lcom/amazonaws/services/s3/model/CompleteMultipartUploadResult;
    .locals 12
    .param p1, "req"    # Lcom/amazonaws/services/s3/model/UploadObjectRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Ljava/lang/InterruptedException;,
            Ljava/util/concurrent/ExecutionException;
        }
    .end annotation

    .line 727
    invoke-virtual {p1}, Lcom/amazonaws/services/s3/model/UploadObjectRequest;->getExecutorService()Ljava/util/concurrent/ExecutorService;

    move-result-object v0

    .line 728
    .local v0, "es":Ljava/util/concurrent/ExecutorService;
    if-nez v0, :cond_0

    const/4 v1, 0x1

    goto :goto_0

    :cond_0
    const/4 v1, 0x0

    .line 729
    .local v1, "defaultExecutorService":Z
    :goto_0
    if-nez v0, :cond_1

    .line 730
    iget-object v2, p0, Lcom/amazonaws/services/s3/AmazonS3EncryptionClient;->clientConfiguration:Lcom/amazonaws/ClientConfiguration;

    invoke-virtual {v2}, Lcom/amazonaws/ClientConfiguration;->getMaxConnections()I

    move-result v2

    invoke-static {v2}, Ljava/util/concurrent/Executors;->newFixedThreadPool(I)Ljava/util/concurrent/ExecutorService;

    move-result-object v0

    .line 731
    :cond_1
    invoke-virtual {p1}, Lcom/amazonaws/services/s3/model/UploadObjectRequest;->getUploadObjectObserver()Lcom/amazonaws/services/s3/UploadObjectObserver;

    move-result-object v2

    .line 732
    .local v2, "observer":Lcom/amazonaws/services/s3/UploadObjectObserver;
    if-nez v2, :cond_2

    .line 733
    new-instance v3, Lcom/amazonaws/services/s3/UploadObjectObserver;

    invoke-direct {v3}, Lcom/amazonaws/services/s3/UploadObjectObserver;-><init>()V

    move-object v2, v3

    .line 735
    :cond_2
    new-instance v3, Lcom/amazonaws/services/s3/AmazonS3EncryptionClient$S3DirectImpl;

    const/4 v4, 0x0

    invoke-direct {v3, p0, v4}, Lcom/amazonaws/services/s3/AmazonS3EncryptionClient$S3DirectImpl;-><init>(Lcom/amazonaws/services/s3/AmazonS3EncryptionClient;Lcom/amazonaws/services/s3/AmazonS3EncryptionClient$1;)V

    invoke-virtual {v2, p1, v3, p0, v0}, Lcom/amazonaws/services/s3/UploadObjectObserver;->init(Lcom/amazonaws/services/s3/model/UploadObjectRequest;Lcom/amazonaws/services/s3/internal/S3DirectSpi;Lcom/amazonaws/services/s3/AmazonS3;Ljava/util/concurrent/ExecutorService;)Lcom/amazonaws/services/s3/UploadObjectObserver;

    .line 737
    invoke-virtual {v2, p1}, Lcom/amazonaws/services/s3/UploadObjectObserver;->onUploadInitiation(Lcom/amazonaws/services/s3/model/UploadObjectRequest;)Ljava/lang/String;

    move-result-object v9

    .line 738
    .local v9, "uploadId":Ljava/lang/String;
    new-instance v3, Ljava/util/ArrayList;

    invoke-direct {v3}, Ljava/util/ArrayList;-><init>()V

    move-object v10, v3

    .line 739
    .local v10, "partETags":Ljava/util/List;, "Ljava/util/List<Lcom/amazonaws/services/s3/model/PartETag;>;"
    invoke-virtual {p1}, Lcom/amazonaws/services/s3/model/UploadObjectRequest;->getMultiFileOutputStream()Lcom/amazonaws/services/s3/internal/MultiFileOutputStream;

    move-result-object v3

    .line 740
    .local v3, "mfos":Lcom/amazonaws/services/s3/internal/MultiFileOutputStream;
    if-nez v3, :cond_3

    .line 741
    new-instance v4, Lcom/amazonaws/services/s3/internal/MultiFileOutputStream;

    invoke-direct {v4}, Lcom/amazonaws/services/s3/internal/MultiFileOutputStream;-><init>()V

    move-object v3, v4

    move-object v11, v3

    goto :goto_1

    .line 740
    :cond_3
    move-object v11, v3

    .line 744
    .end local v3    # "mfos":Lcom/amazonaws/services/s3/internal/MultiFileOutputStream;
    .local v11, "mfos":Lcom/amazonaws/services/s3/internal/MultiFileOutputStream;
    :goto_1
    :try_start_0
    invoke-virtual {p1}, Lcom/amazonaws/services/s3/model/UploadObjectRequest;->getPartSize()J

    move-result-wide v5

    invoke-virtual {p1}, Lcom/amazonaws/services/s3/model/UploadObjectRequest;->getDiskLimit()J

    move-result-wide v7

    move-object v3, v11

    move-object v4, v2

    invoke-virtual/range {v3 .. v8}, Lcom/amazonaws/services/s3/internal/MultiFileOutputStream;->init(Lcom/amazonaws/services/s3/UploadObjectObserver;JJ)Lcom/amazonaws/services/s3/internal/MultiFileOutputStream;

    .line 747
    iget-object v3, p0, Lcom/amazonaws/services/s3/AmazonS3EncryptionClient;->crypto:Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModule;

    invoke-virtual {v3, p1, v9, v11}, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModule;->putLocalObjectSecurely(Lcom/amazonaws/services/s3/model/UploadObjectRequest;Ljava/lang/String;Ljava/io/OutputStream;)V

    .line 749
    invoke-virtual {v2}, Lcom/amazonaws/services/s3/UploadObjectObserver;->getFutures()Ljava/util/List;

    move-result-object v3

    invoke-interface {v3}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :goto_2
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v4

    if-eqz v4, :cond_4

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/util/concurrent/Future;

    .line 750
    .local v4, "future":Ljava/util/concurrent/Future;, "Ljava/util/concurrent/Future<Lcom/amazonaws/services/s3/model/UploadPartResult;>;"
    invoke-interface {v4}, Ljava/util/concurrent/Future;->get()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Lcom/amazonaws/services/s3/model/UploadPartResult;

    .line 751
    .local v5, "partResult":Lcom/amazonaws/services/s3/model/UploadPartResult;
    new-instance v6, Lcom/amazonaws/services/s3/model/PartETag;

    invoke-virtual {v5}, Lcom/amazonaws/services/s3/model/UploadPartResult;->getPartNumber()I

    move-result v7

    invoke-virtual {v5}, Lcom/amazonaws/services/s3/model/UploadPartResult;->getETag()Ljava/lang/String;

    move-result-object v8

    invoke-direct {v6, v7, v8}, Lcom/amazonaws/services/s3/model/PartETag;-><init>(ILjava/lang/String;)V

    invoke-interface {v10, v6}, Ljava/util/List;->add(Ljava/lang/Object;)Z
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_4
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_3
    .catch Ljava/util/concurrent/ExecutionException; {:try_start_0 .. :try_end_0} :catch_2
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/Error; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 752
    nop

    .end local v4    # "future":Ljava/util/concurrent/Future;, "Ljava/util/concurrent/Future<Lcom/amazonaws/services/s3/model/UploadPartResult;>;"
    .end local v5    # "partResult":Lcom/amazonaws/services/s3/model/UploadPartResult;
    goto :goto_2

    .line 764
    :cond_4
    if-eqz v1, :cond_5

    .line 765
    invoke-interface {v0}, Ljava/util/concurrent/ExecutorService;->shutdownNow()Ljava/util/List;

    .line 766
    :cond_5
    invoke-virtual {v11}, Lcom/amazonaws/services/s3/internal/MultiFileOutputStream;->cleanup()V

    .line 767
    nop

    .line 769
    invoke-virtual {v2, v10}, Lcom/amazonaws/services/s3/UploadObjectObserver;->onCompletion(Ljava/util/List;)Lcom/amazonaws/services/s3/model/CompleteMultipartUploadResult;

    move-result-object v3

    return-object v3

    .line 764
    :catchall_0
    move-exception v3

    goto :goto_3

    .line 761
    :catch_0
    move-exception v3

    .line 762
    .local v3, "ex":Ljava/lang/Error;
    :try_start_1
    invoke-direct {p0, v2, v3}, Lcom/amazonaws/services/s3/AmazonS3EncryptionClient;->onAbort(Lcom/amazonaws/services/s3/UploadObjectObserver;Ljava/lang/Throwable;)Ljava/lang/Throwable;

    move-result-object v4

    check-cast v4, Ljava/lang/Error;

    .end local v0    # "es":Ljava/util/concurrent/ExecutorService;
    .end local v1    # "defaultExecutorService":Z
    .end local v2    # "observer":Lcom/amazonaws/services/s3/UploadObjectObserver;
    .end local v9    # "uploadId":Ljava/lang/String;
    .end local v10    # "partETags":Ljava/util/List;, "Ljava/util/List<Lcom/amazonaws/services/s3/model/PartETag;>;"
    .end local v11    # "mfos":Lcom/amazonaws/services/s3/internal/MultiFileOutputStream;
    .end local p1    # "req":Lcom/amazonaws/services/s3/model/UploadObjectRequest;
    throw v4

    .line 759
    .end local v3    # "ex":Ljava/lang/Error;
    .restart local v0    # "es":Ljava/util/concurrent/ExecutorService;
    .restart local v1    # "defaultExecutorService":Z
    .restart local v2    # "observer":Lcom/amazonaws/services/s3/UploadObjectObserver;
    .restart local v9    # "uploadId":Ljava/lang/String;
    .restart local v10    # "partETags":Ljava/util/List;, "Ljava/util/List<Lcom/amazonaws/services/s3/model/PartETag;>;"
    .restart local v11    # "mfos":Lcom/amazonaws/services/s3/internal/MultiFileOutputStream;
    .restart local p1    # "req":Lcom/amazonaws/services/s3/model/UploadObjectRequest;
    :catch_1
    move-exception v3

    .line 760
    .local v3, "ex":Ljava/lang/RuntimeException;
    invoke-direct {p0, v2, v3}, Lcom/amazonaws/services/s3/AmazonS3EncryptionClient;->onAbort(Lcom/amazonaws/services/s3/UploadObjectObserver;Ljava/lang/Throwable;)Ljava/lang/Throwable;

    move-result-object v4

    check-cast v4, Ljava/lang/RuntimeException;

    .end local v0    # "es":Ljava/util/concurrent/ExecutorService;
    .end local v1    # "defaultExecutorService":Z
    .end local v2    # "observer":Lcom/amazonaws/services/s3/UploadObjectObserver;
    .end local v9    # "uploadId":Ljava/lang/String;
    .end local v10    # "partETags":Ljava/util/List;, "Ljava/util/List<Lcom/amazonaws/services/s3/model/PartETag;>;"
    .end local v11    # "mfos":Lcom/amazonaws/services/s3/internal/MultiFileOutputStream;
    .end local p1    # "req":Lcom/amazonaws/services/s3/model/UploadObjectRequest;
    throw v4

    .line 757
    .end local v3    # "ex":Ljava/lang/RuntimeException;
    .restart local v0    # "es":Ljava/util/concurrent/ExecutorService;
    .restart local v1    # "defaultExecutorService":Z
    .restart local v2    # "observer":Lcom/amazonaws/services/s3/UploadObjectObserver;
    .restart local v9    # "uploadId":Ljava/lang/String;
    .restart local v10    # "partETags":Ljava/util/List;, "Ljava/util/List<Lcom/amazonaws/services/s3/model/PartETag;>;"
    .restart local v11    # "mfos":Lcom/amazonaws/services/s3/internal/MultiFileOutputStream;
    .restart local p1    # "req":Lcom/amazonaws/services/s3/model/UploadObjectRequest;
    :catch_2
    move-exception v3

    .line 758
    .local v3, "ex":Ljava/util/concurrent/ExecutionException;
    invoke-direct {p0, v2, v3}, Lcom/amazonaws/services/s3/AmazonS3EncryptionClient;->onAbort(Lcom/amazonaws/services/s3/UploadObjectObserver;Ljava/lang/Throwable;)Ljava/lang/Throwable;

    move-result-object v4

    check-cast v4, Ljava/util/concurrent/ExecutionException;

    .end local v0    # "es":Ljava/util/concurrent/ExecutorService;
    .end local v1    # "defaultExecutorService":Z
    .end local v2    # "observer":Lcom/amazonaws/services/s3/UploadObjectObserver;
    .end local v9    # "uploadId":Ljava/lang/String;
    .end local v10    # "partETags":Ljava/util/List;, "Ljava/util/List<Lcom/amazonaws/services/s3/model/PartETag;>;"
    .end local v11    # "mfos":Lcom/amazonaws/services/s3/internal/MultiFileOutputStream;
    .end local p1    # "req":Lcom/amazonaws/services/s3/model/UploadObjectRequest;
    throw v4

    .line 755
    .end local v3    # "ex":Ljava/util/concurrent/ExecutionException;
    .restart local v0    # "es":Ljava/util/concurrent/ExecutorService;
    .restart local v1    # "defaultExecutorService":Z
    .restart local v2    # "observer":Lcom/amazonaws/services/s3/UploadObjectObserver;
    .restart local v9    # "uploadId":Ljava/lang/String;
    .restart local v10    # "partETags":Ljava/util/List;, "Ljava/util/List<Lcom/amazonaws/services/s3/model/PartETag;>;"
    .restart local v11    # "mfos":Lcom/amazonaws/services/s3/internal/MultiFileOutputStream;
    .restart local p1    # "req":Lcom/amazonaws/services/s3/model/UploadObjectRequest;
    :catch_3
    move-exception v3

    .line 756
    .local v3, "ex":Ljava/lang/InterruptedException;
    invoke-direct {p0, v2, v3}, Lcom/amazonaws/services/s3/AmazonS3EncryptionClient;->onAbort(Lcom/amazonaws/services/s3/UploadObjectObserver;Ljava/lang/Throwable;)Ljava/lang/Throwable;

    move-result-object v4

    check-cast v4, Ljava/lang/InterruptedException;

    .end local v0    # "es":Ljava/util/concurrent/ExecutorService;
    .end local v1    # "defaultExecutorService":Z
    .end local v2    # "observer":Lcom/amazonaws/services/s3/UploadObjectObserver;
    .end local v9    # "uploadId":Ljava/lang/String;
    .end local v10    # "partETags":Ljava/util/List;, "Ljava/util/List<Lcom/amazonaws/services/s3/model/PartETag;>;"
    .end local v11    # "mfos":Lcom/amazonaws/services/s3/internal/MultiFileOutputStream;
    .end local p1    # "req":Lcom/amazonaws/services/s3/model/UploadObjectRequest;
    throw v4

    .line 753
    .end local v3    # "ex":Ljava/lang/InterruptedException;
    .restart local v0    # "es":Ljava/util/concurrent/ExecutorService;
    .restart local v1    # "defaultExecutorService":Z
    .restart local v2    # "observer":Lcom/amazonaws/services/s3/UploadObjectObserver;
    .restart local v9    # "uploadId":Ljava/lang/String;
    .restart local v10    # "partETags":Ljava/util/List;, "Ljava/util/List<Lcom/amazonaws/services/s3/model/PartETag;>;"
    .restart local v11    # "mfos":Lcom/amazonaws/services/s3/internal/MultiFileOutputStream;
    .restart local p1    # "req":Lcom/amazonaws/services/s3/model/UploadObjectRequest;
    :catch_4
    move-exception v3

    .line 754
    .local v3, "ex":Ljava/io/IOException;
    invoke-direct {p0, v2, v3}, Lcom/amazonaws/services/s3/AmazonS3EncryptionClient;->onAbort(Lcom/amazonaws/services/s3/UploadObjectObserver;Ljava/lang/Throwable;)Ljava/lang/Throwable;

    move-result-object v4

    check-cast v4, Ljava/io/IOException;

    .end local v0    # "es":Ljava/util/concurrent/ExecutorService;
    .end local v1    # "defaultExecutorService":Z
    .end local v2    # "observer":Lcom/amazonaws/services/s3/UploadObjectObserver;
    .end local v9    # "uploadId":Ljava/lang/String;
    .end local v10    # "partETags":Ljava/util/List;, "Ljava/util/List<Lcom/amazonaws/services/s3/model/PartETag;>;"
    .end local v11    # "mfos":Lcom/amazonaws/services/s3/internal/MultiFileOutputStream;
    .end local p1    # "req":Lcom/amazonaws/services/s3/model/UploadObjectRequest;
    throw v4
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 764
    .end local v3    # "ex":Ljava/io/IOException;
    .restart local v0    # "es":Ljava/util/concurrent/ExecutorService;
    .restart local v1    # "defaultExecutorService":Z
    .restart local v2    # "observer":Lcom/amazonaws/services/s3/UploadObjectObserver;
    .restart local v9    # "uploadId":Ljava/lang/String;
    .restart local v10    # "partETags":Ljava/util/List;, "Ljava/util/List<Lcom/amazonaws/services/s3/model/PartETag;>;"
    .restart local v11    # "mfos":Lcom/amazonaws/services/s3/internal/MultiFileOutputStream;
    .restart local p1    # "req":Lcom/amazonaws/services/s3/model/UploadObjectRequest;
    :goto_3
    if-eqz v1, :cond_6

    .line 765
    invoke-interface {v0}, Ljava/util/concurrent/ExecutorService;->shutdownNow()Ljava/util/List;

    .line 766
    :cond_6
    invoke-virtual {v11}, Lcom/amazonaws/services/s3/internal/MultiFileOutputStream;->cleanup()V

    .line 767
    throw v3
.end method

.method public uploadPart(Lcom/amazonaws/services/s3/model/UploadPartRequest;)Lcom/amazonaws/services/s3/model/UploadPartResult;
    .locals 1
    .param p1, "uploadPartRequest"    # Lcom/amazonaws/services/s3/model/UploadPartRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonClientException;,
            Lcom/amazonaws/AmazonServiceException;
        }
    .end annotation

    .line 571
    iget-object v0, p0, Lcom/amazonaws/services/s3/AmazonS3EncryptionClient;->crypto:Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModule;

    invoke-virtual {v0, p1}, Lcom/amazonaws/services/s3/internal/crypto/S3CryptoModule;->uploadPartSecurely(Lcom/amazonaws/services/s3/model/UploadPartRequest;)Lcom/amazonaws/services/s3/model/UploadPartResult;

    move-result-object v0

    return-object v0
.end method
