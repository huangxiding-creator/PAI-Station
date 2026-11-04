.class public Lcom/amazonaws/services/kms/AWSKMSClient;
.super Lcom/amazonaws/AmazonWebServiceClient;
.source "AWSKMSClient.java"

# interfaces
.implements Lcom/amazonaws/services/kms/AWSKMS;


# instance fields
.field private awsCredentialsProvider:Lcom/amazonaws/auth/AWSCredentialsProvider;

.field protected jsonErrorUnmarshallers:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lcom/amazonaws/transform/JsonErrorUnmarshaller;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method public constructor <init>()V
    .locals 2
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 192
    new-instance v0, Lcom/amazonaws/auth/DefaultAWSCredentialsProviderChain;

    invoke-direct {v0}, Lcom/amazonaws/auth/DefaultAWSCredentialsProviderChain;-><init>()V

    new-instance v1, Lcom/amazonaws/ClientConfiguration;

    invoke-direct {v1}, Lcom/amazonaws/ClientConfiguration;-><init>()V

    invoke-direct {p0, v0, v1}, Lcom/amazonaws/services/kms/AWSKMSClient;-><init>(Lcom/amazonaws/auth/AWSCredentialsProvider;Lcom/amazonaws/ClientConfiguration;)V

    .line 193
    return-void
.end method

.method public constructor <init>(Lcom/amazonaws/ClientConfiguration;)V
    .locals 1
    .param p1, "clientConfiguration"    # Lcom/amazonaws/ClientConfiguration;
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 216
    new-instance v0, Lcom/amazonaws/auth/DefaultAWSCredentialsProviderChain;

    invoke-direct {v0}, Lcom/amazonaws/auth/DefaultAWSCredentialsProviderChain;-><init>()V

    invoke-direct {p0, v0, p1}, Lcom/amazonaws/services/kms/AWSKMSClient;-><init>(Lcom/amazonaws/auth/AWSCredentialsProvider;Lcom/amazonaws/ClientConfiguration;)V

    .line 217
    return-void
.end method

.method public constructor <init>(Lcom/amazonaws/auth/AWSCredentials;)V
    .locals 1
    .param p1, "awsCredentials"    # Lcom/amazonaws/auth/AWSCredentials;

    .line 252
    new-instance v0, Lcom/amazonaws/ClientConfiguration;

    invoke-direct {v0}, Lcom/amazonaws/ClientConfiguration;-><init>()V

    invoke-direct {p0, p1, v0}, Lcom/amazonaws/services/kms/AWSKMSClient;-><init>(Lcom/amazonaws/auth/AWSCredentials;Lcom/amazonaws/ClientConfiguration;)V

    .line 253
    return-void
.end method

.method public constructor <init>(Lcom/amazonaws/auth/AWSCredentials;Lcom/amazonaws/ClientConfiguration;)V
    .locals 1
    .param p1, "awsCredentials"    # Lcom/amazonaws/auth/AWSCredentials;
    .param p2, "clientConfiguration"    # Lcom/amazonaws/ClientConfiguration;

    .line 291
    new-instance v0, Lcom/amazonaws/internal/StaticCredentialsProvider;

    invoke-direct {v0, p1}, Lcom/amazonaws/internal/StaticCredentialsProvider;-><init>(Lcom/amazonaws/auth/AWSCredentials;)V

    invoke-direct {p0, v0, p2}, Lcom/amazonaws/services/kms/AWSKMSClient;-><init>(Lcom/amazonaws/auth/AWSCredentialsProvider;Lcom/amazonaws/ClientConfiguration;)V

    .line 292
    return-void
.end method

.method public constructor <init>(Lcom/amazonaws/auth/AWSCredentialsProvider;)V
    .locals 1
    .param p1, "awsCredentialsProvider"    # Lcom/amazonaws/auth/AWSCredentialsProvider;

    .line 328
    new-instance v0, Lcom/amazonaws/ClientConfiguration;

    invoke-direct {v0}, Lcom/amazonaws/ClientConfiguration;-><init>()V

    invoke-direct {p0, p1, v0}, Lcom/amazonaws/services/kms/AWSKMSClient;-><init>(Lcom/amazonaws/auth/AWSCredentialsProvider;Lcom/amazonaws/ClientConfiguration;)V

    .line 329
    return-void
.end method

.method public constructor <init>(Lcom/amazonaws/auth/AWSCredentialsProvider;Lcom/amazonaws/ClientConfiguration;)V
    .locals 1
    .param p1, "awsCredentialsProvider"    # Lcom/amazonaws/auth/AWSCredentialsProvider;
    .param p2, "clientConfiguration"    # Lcom/amazonaws/ClientConfiguration;

    .line 370
    new-instance v0, Lcom/amazonaws/http/UrlHttpClient;

    invoke-direct {v0, p2}, Lcom/amazonaws/http/UrlHttpClient;-><init>(Lcom/amazonaws/ClientConfiguration;)V

    invoke-direct {p0, p1, p2, v0}, Lcom/amazonaws/services/kms/AWSKMSClient;-><init>(Lcom/amazonaws/auth/AWSCredentialsProvider;Lcom/amazonaws/ClientConfiguration;Lcom/amazonaws/http/HttpClient;)V

    .line 371
    return-void
.end method

.method public constructor <init>(Lcom/amazonaws/auth/AWSCredentialsProvider;Lcom/amazonaws/ClientConfiguration;Lcom/amazonaws/http/HttpClient;)V
    .locals 1
    .param p1, "awsCredentialsProvider"    # Lcom/amazonaws/auth/AWSCredentialsProvider;
    .param p2, "clientConfiguration"    # Lcom/amazonaws/ClientConfiguration;
    .param p3, "httpClient"    # Lcom/amazonaws/http/HttpClient;

    .line 440
    invoke-static {p2}, Lcom/amazonaws/services/kms/AWSKMSClient;->adjustClientConfiguration(Lcom/amazonaws/ClientConfiguration;)Lcom/amazonaws/ClientConfiguration;

    move-result-object v0

    invoke-direct {p0, v0, p3}, Lcom/amazonaws/AmazonWebServiceClient;-><init>(Lcom/amazonaws/ClientConfiguration;Lcom/amazonaws/http/HttpClient;)V

    .line 442
    iput-object p1, p0, Lcom/amazonaws/services/kms/AWSKMSClient;->awsCredentialsProvider:Lcom/amazonaws/auth/AWSCredentialsProvider;

    .line 444
    invoke-direct {p0}, Lcom/amazonaws/services/kms/AWSKMSClient;->init()V

    .line 445
    return-void
.end method

.method public constructor <init>(Lcom/amazonaws/auth/AWSCredentialsProvider;Lcom/amazonaws/ClientConfiguration;Lcom/amazonaws/metrics/RequestMetricCollector;)V
    .locals 1
    .param p1, "awsCredentialsProvider"    # Lcom/amazonaws/auth/AWSCredentialsProvider;
    .param p2, "clientConfiguration"    # Lcom/amazonaws/ClientConfiguration;
    .param p3, "requestMetricCollector"    # Lcom/amazonaws/metrics/RequestMetricCollector;
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 393
    invoke-static {p2}, Lcom/amazonaws/services/kms/AWSKMSClient;->adjustClientConfiguration(Lcom/amazonaws/ClientConfiguration;)Lcom/amazonaws/ClientConfiguration;

    move-result-object v0

    invoke-direct {p0, v0, p3}, Lcom/amazonaws/AmazonWebServiceClient;-><init>(Lcom/amazonaws/ClientConfiguration;Lcom/amazonaws/metrics/RequestMetricCollector;)V

    .line 395
    iput-object p1, p0, Lcom/amazonaws/services/kms/AWSKMSClient;->awsCredentialsProvider:Lcom/amazonaws/auth/AWSCredentialsProvider;

    .line 397
    invoke-direct {p0}, Lcom/amazonaws/services/kms/AWSKMSClient;->init()V

    .line 398
    return-void
.end method

.method private static adjustClientConfiguration(Lcom/amazonaws/ClientConfiguration;)Lcom/amazonaws/ClientConfiguration;
    .locals 1
    .param p0, "orig"    # Lcom/amazonaws/ClientConfiguration;

    .line 496
    move-object v0, p0

    .line 498
    .local v0, "config":Lcom/amazonaws/ClientConfiguration;
    return-object v0
.end method

.method private init()V
    .locals 3

    .line 448
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/amazonaws/services/kms/AWSKMSClient;->jsonErrorUnmarshallers:Ljava/util/List;

    .line 449
    iget-object v0, p0, Lcom/amazonaws/services/kms/AWSKMSClient;->jsonErrorUnmarshallers:Ljava/util/List;

    new-instance v1, Lcom/amazonaws/services/kms/model/transform/AlreadyExistsExceptionUnmarshaller;

    invoke-direct {v1}, Lcom/amazonaws/services/kms/model/transform/AlreadyExistsExceptionUnmarshaller;-><init>()V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 450
    iget-object v0, p0, Lcom/amazonaws/services/kms/AWSKMSClient;->jsonErrorUnmarshallers:Ljava/util/List;

    new-instance v1, Lcom/amazonaws/services/kms/model/transform/CloudHsmClusterInUseExceptionUnmarshaller;

    invoke-direct {v1}, Lcom/amazonaws/services/kms/model/transform/CloudHsmClusterInUseExceptionUnmarshaller;-><init>()V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 451
    iget-object v0, p0, Lcom/amazonaws/services/kms/AWSKMSClient;->jsonErrorUnmarshallers:Ljava/util/List;

    new-instance v1, Lcom/amazonaws/services/kms/model/transform/CloudHsmClusterInvalidConfigurationExceptionUnmarshaller;

    invoke-direct {v1}, Lcom/amazonaws/services/kms/model/transform/CloudHsmClusterInvalidConfigurationExceptionUnmarshaller;-><init>()V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 452
    iget-object v0, p0, Lcom/amazonaws/services/kms/AWSKMSClient;->jsonErrorUnmarshallers:Ljava/util/List;

    new-instance v1, Lcom/amazonaws/services/kms/model/transform/CloudHsmClusterNotActiveExceptionUnmarshaller;

    invoke-direct {v1}, Lcom/amazonaws/services/kms/model/transform/CloudHsmClusterNotActiveExceptionUnmarshaller;-><init>()V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 453
    iget-object v0, p0, Lcom/amazonaws/services/kms/AWSKMSClient;->jsonErrorUnmarshallers:Ljava/util/List;

    new-instance v1, Lcom/amazonaws/services/kms/model/transform/CloudHsmClusterNotFoundExceptionUnmarshaller;

    invoke-direct {v1}, Lcom/amazonaws/services/kms/model/transform/CloudHsmClusterNotFoundExceptionUnmarshaller;-><init>()V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 454
    iget-object v0, p0, Lcom/amazonaws/services/kms/AWSKMSClient;->jsonErrorUnmarshallers:Ljava/util/List;

    new-instance v1, Lcom/amazonaws/services/kms/model/transform/CloudHsmClusterNotRelatedExceptionUnmarshaller;

    invoke-direct {v1}, Lcom/amazonaws/services/kms/model/transform/CloudHsmClusterNotRelatedExceptionUnmarshaller;-><init>()V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 455
    iget-object v0, p0, Lcom/amazonaws/services/kms/AWSKMSClient;->jsonErrorUnmarshallers:Ljava/util/List;

    new-instance v1, Lcom/amazonaws/services/kms/model/transform/CustomKeyStoreHasCMKsExceptionUnmarshaller;

    invoke-direct {v1}, Lcom/amazonaws/services/kms/model/transform/CustomKeyStoreHasCMKsExceptionUnmarshaller;-><init>()V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 456
    iget-object v0, p0, Lcom/amazonaws/services/kms/AWSKMSClient;->jsonErrorUnmarshallers:Ljava/util/List;

    new-instance v1, Lcom/amazonaws/services/kms/model/transform/CustomKeyStoreInvalidStateExceptionUnmarshaller;

    invoke-direct {v1}, Lcom/amazonaws/services/kms/model/transform/CustomKeyStoreInvalidStateExceptionUnmarshaller;-><init>()V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 457
    iget-object v0, p0, Lcom/amazonaws/services/kms/AWSKMSClient;->jsonErrorUnmarshallers:Ljava/util/List;

    new-instance v1, Lcom/amazonaws/services/kms/model/transform/CustomKeyStoreNameInUseExceptionUnmarshaller;

    invoke-direct {v1}, Lcom/amazonaws/services/kms/model/transform/CustomKeyStoreNameInUseExceptionUnmarshaller;-><init>()V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 458
    iget-object v0, p0, Lcom/amazonaws/services/kms/AWSKMSClient;->jsonErrorUnmarshallers:Ljava/util/List;

    new-instance v1, Lcom/amazonaws/services/kms/model/transform/CustomKeyStoreNotFoundExceptionUnmarshaller;

    invoke-direct {v1}, Lcom/amazonaws/services/kms/model/transform/CustomKeyStoreNotFoundExceptionUnmarshaller;-><init>()V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 459
    iget-object v0, p0, Lcom/amazonaws/services/kms/AWSKMSClient;->jsonErrorUnmarshallers:Ljava/util/List;

    new-instance v1, Lcom/amazonaws/services/kms/model/transform/DependencyTimeoutExceptionUnmarshaller;

    invoke-direct {v1}, Lcom/amazonaws/services/kms/model/transform/DependencyTimeoutExceptionUnmarshaller;-><init>()V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 460
    iget-object v0, p0, Lcom/amazonaws/services/kms/AWSKMSClient;->jsonErrorUnmarshallers:Ljava/util/List;

    new-instance v1, Lcom/amazonaws/services/kms/model/transform/DisabledExceptionUnmarshaller;

    invoke-direct {v1}, Lcom/amazonaws/services/kms/model/transform/DisabledExceptionUnmarshaller;-><init>()V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 461
    iget-object v0, p0, Lcom/amazonaws/services/kms/AWSKMSClient;->jsonErrorUnmarshallers:Ljava/util/List;

    new-instance v1, Lcom/amazonaws/services/kms/model/transform/ExpiredImportTokenExceptionUnmarshaller;

    invoke-direct {v1}, Lcom/amazonaws/services/kms/model/transform/ExpiredImportTokenExceptionUnmarshaller;-><init>()V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 462
    iget-object v0, p0, Lcom/amazonaws/services/kms/AWSKMSClient;->jsonErrorUnmarshallers:Ljava/util/List;

    new-instance v1, Lcom/amazonaws/services/kms/model/transform/IncorrectKeyExceptionUnmarshaller;

    invoke-direct {v1}, Lcom/amazonaws/services/kms/model/transform/IncorrectKeyExceptionUnmarshaller;-><init>()V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 463
    iget-object v0, p0, Lcom/amazonaws/services/kms/AWSKMSClient;->jsonErrorUnmarshallers:Ljava/util/List;

    new-instance v1, Lcom/amazonaws/services/kms/model/transform/IncorrectKeyMaterialExceptionUnmarshaller;

    invoke-direct {v1}, Lcom/amazonaws/services/kms/model/transform/IncorrectKeyMaterialExceptionUnmarshaller;-><init>()V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 464
    iget-object v0, p0, Lcom/amazonaws/services/kms/AWSKMSClient;->jsonErrorUnmarshallers:Ljava/util/List;

    new-instance v1, Lcom/amazonaws/services/kms/model/transform/IncorrectTrustAnchorExceptionUnmarshaller;

    invoke-direct {v1}, Lcom/amazonaws/services/kms/model/transform/IncorrectTrustAnchorExceptionUnmarshaller;-><init>()V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 465
    iget-object v0, p0, Lcom/amazonaws/services/kms/AWSKMSClient;->jsonErrorUnmarshallers:Ljava/util/List;

    new-instance v1, Lcom/amazonaws/services/kms/model/transform/InvalidAliasNameExceptionUnmarshaller;

    invoke-direct {v1}, Lcom/amazonaws/services/kms/model/transform/InvalidAliasNameExceptionUnmarshaller;-><init>()V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 466
    iget-object v0, p0, Lcom/amazonaws/services/kms/AWSKMSClient;->jsonErrorUnmarshallers:Ljava/util/List;

    new-instance v1, Lcom/amazonaws/services/kms/model/transform/InvalidArnExceptionUnmarshaller;

    invoke-direct {v1}, Lcom/amazonaws/services/kms/model/transform/InvalidArnExceptionUnmarshaller;-><init>()V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 467
    iget-object v0, p0, Lcom/amazonaws/services/kms/AWSKMSClient;->jsonErrorUnmarshallers:Ljava/util/List;

    new-instance v1, Lcom/amazonaws/services/kms/model/transform/InvalidCiphertextExceptionUnmarshaller;

    invoke-direct {v1}, Lcom/amazonaws/services/kms/model/transform/InvalidCiphertextExceptionUnmarshaller;-><init>()V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 468
    iget-object v0, p0, Lcom/amazonaws/services/kms/AWSKMSClient;->jsonErrorUnmarshallers:Ljava/util/List;

    new-instance v1, Lcom/amazonaws/services/kms/model/transform/InvalidGrantIdExceptionUnmarshaller;

    invoke-direct {v1}, Lcom/amazonaws/services/kms/model/transform/InvalidGrantIdExceptionUnmarshaller;-><init>()V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 469
    iget-object v0, p0, Lcom/amazonaws/services/kms/AWSKMSClient;->jsonErrorUnmarshallers:Ljava/util/List;

    new-instance v1, Lcom/amazonaws/services/kms/model/transform/InvalidGrantTokenExceptionUnmarshaller;

    invoke-direct {v1}, Lcom/amazonaws/services/kms/model/transform/InvalidGrantTokenExceptionUnmarshaller;-><init>()V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 470
    iget-object v0, p0, Lcom/amazonaws/services/kms/AWSKMSClient;->jsonErrorUnmarshallers:Ljava/util/List;

    new-instance v1, Lcom/amazonaws/services/kms/model/transform/InvalidImportTokenExceptionUnmarshaller;

    invoke-direct {v1}, Lcom/amazonaws/services/kms/model/transform/InvalidImportTokenExceptionUnmarshaller;-><init>()V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 471
    iget-object v0, p0, Lcom/amazonaws/services/kms/AWSKMSClient;->jsonErrorUnmarshallers:Ljava/util/List;

    new-instance v1, Lcom/amazonaws/services/kms/model/transform/InvalidKeyUsageExceptionUnmarshaller;

    invoke-direct {v1}, Lcom/amazonaws/services/kms/model/transform/InvalidKeyUsageExceptionUnmarshaller;-><init>()V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 472
    iget-object v0, p0, Lcom/amazonaws/services/kms/AWSKMSClient;->jsonErrorUnmarshallers:Ljava/util/List;

    new-instance v1, Lcom/amazonaws/services/kms/model/transform/InvalidMarkerExceptionUnmarshaller;

    invoke-direct {v1}, Lcom/amazonaws/services/kms/model/transform/InvalidMarkerExceptionUnmarshaller;-><init>()V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 473
    iget-object v0, p0, Lcom/amazonaws/services/kms/AWSKMSClient;->jsonErrorUnmarshallers:Ljava/util/List;

    new-instance v1, Lcom/amazonaws/services/kms/model/transform/KMSInternalExceptionUnmarshaller;

    invoke-direct {v1}, Lcom/amazonaws/services/kms/model/transform/KMSInternalExceptionUnmarshaller;-><init>()V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 474
    iget-object v0, p0, Lcom/amazonaws/services/kms/AWSKMSClient;->jsonErrorUnmarshallers:Ljava/util/List;

    new-instance v1, Lcom/amazonaws/services/kms/model/transform/KMSInvalidSignatureExceptionUnmarshaller;

    invoke-direct {v1}, Lcom/amazonaws/services/kms/model/transform/KMSInvalidSignatureExceptionUnmarshaller;-><init>()V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 475
    iget-object v0, p0, Lcom/amazonaws/services/kms/AWSKMSClient;->jsonErrorUnmarshallers:Ljava/util/List;

    new-instance v1, Lcom/amazonaws/services/kms/model/transform/KMSInvalidStateExceptionUnmarshaller;

    invoke-direct {v1}, Lcom/amazonaws/services/kms/model/transform/KMSInvalidStateExceptionUnmarshaller;-><init>()V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 476
    iget-object v0, p0, Lcom/amazonaws/services/kms/AWSKMSClient;->jsonErrorUnmarshallers:Ljava/util/List;

    new-instance v1, Lcom/amazonaws/services/kms/model/transform/KeyUnavailableExceptionUnmarshaller;

    invoke-direct {v1}, Lcom/amazonaws/services/kms/model/transform/KeyUnavailableExceptionUnmarshaller;-><init>()V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 477
    iget-object v0, p0, Lcom/amazonaws/services/kms/AWSKMSClient;->jsonErrorUnmarshallers:Ljava/util/List;

    new-instance v1, Lcom/amazonaws/services/kms/model/transform/LimitExceededExceptionUnmarshaller;

    invoke-direct {v1}, Lcom/amazonaws/services/kms/model/transform/LimitExceededExceptionUnmarshaller;-><init>()V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 478
    iget-object v0, p0, Lcom/amazonaws/services/kms/AWSKMSClient;->jsonErrorUnmarshallers:Ljava/util/List;

    new-instance v1, Lcom/amazonaws/services/kms/model/transform/MalformedPolicyDocumentExceptionUnmarshaller;

    invoke-direct {v1}, Lcom/amazonaws/services/kms/model/transform/MalformedPolicyDocumentExceptionUnmarshaller;-><init>()V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 479
    iget-object v0, p0, Lcom/amazonaws/services/kms/AWSKMSClient;->jsonErrorUnmarshallers:Ljava/util/List;

    new-instance v1, Lcom/amazonaws/services/kms/model/transform/NotFoundExceptionUnmarshaller;

    invoke-direct {v1}, Lcom/amazonaws/services/kms/model/transform/NotFoundExceptionUnmarshaller;-><init>()V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 480
    iget-object v0, p0, Lcom/amazonaws/services/kms/AWSKMSClient;->jsonErrorUnmarshallers:Ljava/util/List;

    new-instance v1, Lcom/amazonaws/services/kms/model/transform/TagExceptionUnmarshaller;

    invoke-direct {v1}, Lcom/amazonaws/services/kms/model/transform/TagExceptionUnmarshaller;-><init>()V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 481
    iget-object v0, p0, Lcom/amazonaws/services/kms/AWSKMSClient;->jsonErrorUnmarshallers:Ljava/util/List;

    new-instance v1, Lcom/amazonaws/services/kms/model/transform/UnsupportedOperationExceptionUnmarshaller;

    invoke-direct {v1}, Lcom/amazonaws/services/kms/model/transform/UnsupportedOperationExceptionUnmarshaller;-><init>()V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 482
    iget-object v0, p0, Lcom/amazonaws/services/kms/AWSKMSClient;->jsonErrorUnmarshallers:Ljava/util/List;

    new-instance v1, Lcom/amazonaws/transform/JsonErrorUnmarshaller;

    invoke-direct {v1}, Lcom/amazonaws/transform/JsonErrorUnmarshaller;-><init>()V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 485
    const-string v0, "kms.us-east-1.amazonaws.com"

    invoke-virtual {p0, v0}, Lcom/amazonaws/services/kms/AWSKMSClient;->setEndpoint(Ljava/lang/String;)V

    .line 486
    const-string v0, "kms"

    iput-object v0, p0, Lcom/amazonaws/services/kms/AWSKMSClient;->endpointPrefix:Ljava/lang/String;

    .line 488
    new-instance v0, Lcom/amazonaws/handlers/HandlerChainFactory;

    invoke-direct {v0}, Lcom/amazonaws/handlers/HandlerChainFactory;-><init>()V

    .line 489
    .local v0, "chainFactory":Lcom/amazonaws/handlers/HandlerChainFactory;
    iget-object v1, p0, Lcom/amazonaws/services/kms/AWSKMSClient;->requestHandler2s:Ljava/util/List;

    const-string v2, "/com/amazonaws/services/kms/request.handlers"

    invoke-virtual {v0, v2}, Lcom/amazonaws/handlers/HandlerChainFactory;->newRequestHandlerChain(Ljava/lang/String;)Ljava/util/List;

    move-result-object v2

    invoke-interface {v1, v2}, Ljava/util/List;->addAll(Ljava/util/Collection;)Z

    .line 491
    iget-object v1, p0, Lcom/amazonaws/services/kms/AWSKMSClient;->requestHandler2s:Ljava/util/List;

    const-string v2, "/com/amazonaws/services/kms/request.handler2s"

    invoke-virtual {v0, v2}, Lcom/amazonaws/handlers/HandlerChainFactory;->newRequestHandler2Chain(Ljava/lang/String;)Ljava/util/List;

    move-result-object v2

    invoke-interface {v1, v2}, Ljava/util/List;->addAll(Ljava/util/Collection;)Z

    .line 493
    return-void
.end method

.method private invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;
    .locals 5
    .param p3, "executionContext"    # Lcom/amazonaws/http/ExecutionContext;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<X:",
            "Ljava/lang/Object;",
            "Y:",
            "Lcom/amazonaws/AmazonWebServiceRequest;",
            ">(",
            "Lcom/amazonaws/Request<",
            "TY;>;",
            "Lcom/amazonaws/http/HttpResponseHandler<",
            "Lcom/amazonaws/AmazonWebServiceResponse<",
            "TX;>;>;",
            "Lcom/amazonaws/http/ExecutionContext;",
            ")",
            "Lcom/amazonaws/Response<",
            "TX;>;"
        }
    .end annotation

    .line 6443
    .local p1, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<TY;>;"
    .local p2, "responseHandler":Lcom/amazonaws/http/HttpResponseHandler;, "Lcom/amazonaws/http/HttpResponseHandler<Lcom/amazonaws/AmazonWebServiceResponse<TX;>;>;"
    iget-object v0, p0, Lcom/amazonaws/services/kms/AWSKMSClient;->endpoint:Ljava/net/URI;

    invoke-interface {p1, v0}, Lcom/amazonaws/Request;->setEndpoint(Ljava/net/URI;)V

    .line 6444
    iget v0, p0, Lcom/amazonaws/services/kms/AWSKMSClient;->timeOffset:I

    invoke-interface {p1, v0}, Lcom/amazonaws/Request;->setTimeOffset(I)V

    .line 6446
    invoke-virtual {p3}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v0

    .line 6448
    .local v0, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v1, Lcom/amazonaws/util/AWSRequestMetrics$Field;->CredentialsRequestTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v0, v1}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 6450
    :try_start_0
    iget-object v1, p0, Lcom/amazonaws/services/kms/AWSKMSClient;->awsCredentialsProvider:Lcom/amazonaws/auth/AWSCredentialsProvider;

    invoke-interface {v1}, Lcom/amazonaws/auth/AWSCredentialsProvider;->getCredentials()Lcom/amazonaws/auth/AWSCredentials;

    move-result-object v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 6452
    .local v1, "credentials":Lcom/amazonaws/auth/AWSCredentials;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->CredentialsRequestTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v0, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 6453
    nop

    .line 6455
    invoke-interface {p1}, Lcom/amazonaws/Request;->getOriginalRequest()Lcom/amazonaws/AmazonWebServiceRequest;

    move-result-object v2

    .line 6456
    .local v2, "originalRequest":Lcom/amazonaws/AmazonWebServiceRequest;
    if-eqz v2, :cond_0

    invoke-virtual {v2}, Lcom/amazonaws/AmazonWebServiceRequest;->getRequestCredentials()Lcom/amazonaws/auth/AWSCredentials;

    move-result-object v3

    if-eqz v3, :cond_0

    .line 6457
    invoke-virtual {v2}, Lcom/amazonaws/AmazonWebServiceRequest;->getRequestCredentials()Lcom/amazonaws/auth/AWSCredentials;

    move-result-object v1

    .line 6460
    :cond_0
    invoke-virtual {p3, v1}, Lcom/amazonaws/http/ExecutionContext;->setCredentials(Lcom/amazonaws/auth/AWSCredentials;)V

    .line 6461
    new-instance v3, Lcom/amazonaws/http/JsonErrorResponseHandler;

    iget-object v4, p0, Lcom/amazonaws/services/kms/AWSKMSClient;->jsonErrorUnmarshallers:Ljava/util/List;

    invoke-direct {v3, v4}, Lcom/amazonaws/http/JsonErrorResponseHandler;-><init>(Ljava/util/List;)V

    .line 6463
    .local v3, "errorResponseHandler":Lcom/amazonaws/http/JsonErrorResponseHandler;
    iget-object v4, p0, Lcom/amazonaws/services/kms/AWSKMSClient;->client:Lcom/amazonaws/http/AmazonHttpClient;

    invoke-virtual {v4, p1, p2, v3, p3}, Lcom/amazonaws/http/AmazonHttpClient;->execute(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v4

    .line 6465
    .local v4, "result":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<TX;>;"
    return-object v4

    .line 6452
    .end local v1    # "credentials":Lcom/amazonaws/auth/AWSCredentials;
    .end local v2    # "originalRequest":Lcom/amazonaws/AmazonWebServiceRequest;
    .end local v3    # "errorResponseHandler":Lcom/amazonaws/http/JsonErrorResponseHandler;
    .end local v4    # "result":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<TX;>;"
    :catchall_0
    move-exception v1

    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->CredentialsRequestTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v0, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 6453
    throw v1
.end method


# virtual methods
.method public cancelKeyDeletion(Lcom/amazonaws/services/kms/model/CancelKeyDeletionRequest;)Lcom/amazonaws/services/kms/model/CancelKeyDeletionResult;
    .locals 9
    .param p1, "cancelKeyDeletionRequest"    # Lcom/amazonaws/services/kms/model/CancelKeyDeletionRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 553
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/kms/AWSKMSClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 554
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 555
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 556
    const/4 v2, 0x0

    .line 557
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/kms/model/CancelKeyDeletionRequest;>;"
    const/4 v3, 0x0

    .line 559
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/kms/model/CancelKeyDeletionResult;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 561
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/kms/model/transform/CancelKeyDeletionRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/kms/model/transform/CancelKeyDeletionRequestMarshaller;-><init>()V

    .line 562
    invoke-virtual {v5, p1}, Lcom/amazonaws/services/kms/model/transform/CancelKeyDeletionRequestMarshaller;->marshall(Lcom/amazonaws/services/kms/model/CancelKeyDeletionRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 564
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 566
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 567
    nop

    .line 568
    new-instance v5, Lcom/amazonaws/services/kms/model/transform/CancelKeyDeletionResultJsonUnmarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/kms/model/transform/CancelKeyDeletionResultJsonUnmarshaller;-><init>()V

    .line 569
    .local v5, "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/kms/model/CancelKeyDeletionResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    new-instance v6, Lcom/amazonaws/http/JsonResponseHandler;

    invoke-direct {v6, v5}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 572
    .local v6, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/kms/model/CancelKeyDeletionResult;>;"
    invoke-direct {p0, v2, v6, v0}, Lcom/amazonaws/services/kms/AWSKMSClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v7

    move-object v3, v7

    .line 574
    invoke-virtual {v3}, Lcom/amazonaws/Response;->getAwsResponse()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/amazonaws/services/kms/model/CancelKeyDeletionResult;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 576
    sget-object v8, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v8}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 577
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/kms/AWSKMSClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 574
    return-object v7

    .line 566
    .end local v5    # "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/kms/model/CancelKeyDeletionResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    .end local v6    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/kms/model/CancelKeyDeletionResult;>;"
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 567
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/kms/model/CancelKeyDeletionRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/kms/model/CancelKeyDeletionResult;>;"
    .end local p1    # "cancelKeyDeletionRequest":Lcom/amazonaws/services/kms/model/CancelKeyDeletionRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 576
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/kms/model/CancelKeyDeletionRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/kms/model/CancelKeyDeletionResult;>;"
    .restart local p1    # "cancelKeyDeletionRequest":Lcom/amazonaws/services/kms/model/CancelKeyDeletionRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 577
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/kms/AWSKMSClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 578
    throw v5
.end method

.method public connectCustomKeyStore(Lcom/amazonaws/services/kms/model/ConnectCustomKeyStoreRequest;)Lcom/amazonaws/services/kms/model/ConnectCustomKeyStoreResult;
    .locals 9
    .param p1, "connectCustomKeyStoreRequest"    # Lcom/amazonaws/services/kms/model/ConnectCustomKeyStoreRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 700
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/kms/AWSKMSClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 701
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 702
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 703
    const/4 v2, 0x0

    .line 704
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/kms/model/ConnectCustomKeyStoreRequest;>;"
    const/4 v3, 0x0

    .line 706
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/kms/model/ConnectCustomKeyStoreResult;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 708
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/kms/model/transform/ConnectCustomKeyStoreRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/kms/model/transform/ConnectCustomKeyStoreRequestMarshaller;-><init>()V

    .line 709
    invoke-virtual {v5, p1}, Lcom/amazonaws/services/kms/model/transform/ConnectCustomKeyStoreRequestMarshaller;->marshall(Lcom/amazonaws/services/kms/model/ConnectCustomKeyStoreRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 711
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 713
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 714
    nop

    .line 715
    new-instance v5, Lcom/amazonaws/services/kms/model/transform/ConnectCustomKeyStoreResultJsonUnmarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/kms/model/transform/ConnectCustomKeyStoreResultJsonUnmarshaller;-><init>()V

    .line 716
    .local v5, "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/kms/model/ConnectCustomKeyStoreResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    new-instance v6, Lcom/amazonaws/http/JsonResponseHandler;

    invoke-direct {v6, v5}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 719
    .local v6, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/kms/model/ConnectCustomKeyStoreResult;>;"
    invoke-direct {p0, v2, v6, v0}, Lcom/amazonaws/services/kms/AWSKMSClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v7

    move-object v3, v7

    .line 721
    invoke-virtual {v3}, Lcom/amazonaws/Response;->getAwsResponse()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/amazonaws/services/kms/model/ConnectCustomKeyStoreResult;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 723
    sget-object v8, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v8}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 724
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/kms/AWSKMSClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 721
    return-object v7

    .line 713
    .end local v5    # "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/kms/model/ConnectCustomKeyStoreResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    .end local v6    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/kms/model/ConnectCustomKeyStoreResult;>;"
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 714
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/kms/model/ConnectCustomKeyStoreRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/kms/model/ConnectCustomKeyStoreResult;>;"
    .end local p1    # "connectCustomKeyStoreRequest":Lcom/amazonaws/services/kms/model/ConnectCustomKeyStoreRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 723
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/kms/model/ConnectCustomKeyStoreRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/kms/model/ConnectCustomKeyStoreResult;>;"
    .restart local p1    # "connectCustomKeyStoreRequest":Lcom/amazonaws/services/kms/model/ConnectCustomKeyStoreRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 724
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/kms/AWSKMSClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 725
    throw v5
.end method

.method public createAlias(Lcom/amazonaws/services/kms/model/CreateAliasRequest;)V
    .locals 7
    .param p1, "createAliasRequest"    # Lcom/amazonaws/services/kms/model/CreateAliasRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 835
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/kms/AWSKMSClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 836
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 837
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 838
    const/4 v2, 0x0

    .line 839
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/kms/model/CreateAliasRequest;>;"
    const/4 v3, 0x0

    .line 841
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Ljava/lang/Void;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 843
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/kms/model/transform/CreateAliasRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/kms/model/transform/CreateAliasRequestMarshaller;-><init>()V

    invoke-virtual {v5, p1}, Lcom/amazonaws/services/kms/model/transform/CreateAliasRequestMarshaller;->marshall(Lcom/amazonaws/services/kms/model/CreateAliasRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 845
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 847
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 848
    nop

    .line 849
    new-instance v5, Lcom/amazonaws/http/JsonResponseHandler;

    const/4 v6, 0x0

    invoke-direct {v5, v6}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 850
    .local v5, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Ljava/lang/Void;>;"
    invoke-direct {p0, v2, v5, v0}, Lcom/amazonaws/services/kms/AWSKMSClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 852
    nop

    .end local v5    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Ljava/lang/Void;>;"
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 853
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/kms/AWSKMSClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 854
    nop

    .line 855
    return-void

    .line 847
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 848
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/kms/model/CreateAliasRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Ljava/lang/Void;>;"
    .end local p1    # "createAliasRequest":Lcom/amazonaws/services/kms/model/CreateAliasRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 852
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/kms/model/CreateAliasRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Ljava/lang/Void;>;"
    .restart local p1    # "createAliasRequest":Lcom/amazonaws/services/kms/model/CreateAliasRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 853
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/kms/AWSKMSClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 854
    throw v5
.end method

.method public createCustomKeyStore(Lcom/amazonaws/services/kms/model/CreateCustomKeyStoreRequest;)Lcom/amazonaws/services/kms/model/CreateCustomKeyStoreResult;
    .locals 9
    .param p1, "createCustomKeyStoreRequest"    # Lcom/amazonaws/services/kms/model/CreateCustomKeyStoreRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 958
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/kms/AWSKMSClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 959
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 960
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 961
    const/4 v2, 0x0

    .line 962
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/kms/model/CreateCustomKeyStoreRequest;>;"
    const/4 v3, 0x0

    .line 964
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/kms/model/CreateCustomKeyStoreResult;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 966
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/kms/model/transform/CreateCustomKeyStoreRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/kms/model/transform/CreateCustomKeyStoreRequestMarshaller;-><init>()V

    .line 967
    invoke-virtual {v5, p1}, Lcom/amazonaws/services/kms/model/transform/CreateCustomKeyStoreRequestMarshaller;->marshall(Lcom/amazonaws/services/kms/model/CreateCustomKeyStoreRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 969
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 971
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 972
    nop

    .line 973
    new-instance v5, Lcom/amazonaws/services/kms/model/transform/CreateCustomKeyStoreResultJsonUnmarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/kms/model/transform/CreateCustomKeyStoreResultJsonUnmarshaller;-><init>()V

    .line 974
    .local v5, "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/kms/model/CreateCustomKeyStoreResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    new-instance v6, Lcom/amazonaws/http/JsonResponseHandler;

    invoke-direct {v6, v5}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 977
    .local v6, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/kms/model/CreateCustomKeyStoreResult;>;"
    invoke-direct {p0, v2, v6, v0}, Lcom/amazonaws/services/kms/AWSKMSClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v7

    move-object v3, v7

    .line 979
    invoke-virtual {v3}, Lcom/amazonaws/Response;->getAwsResponse()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/amazonaws/services/kms/model/CreateCustomKeyStoreResult;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 981
    sget-object v8, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v8}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 982
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/kms/AWSKMSClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 979
    return-object v7

    .line 971
    .end local v5    # "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/kms/model/CreateCustomKeyStoreResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    .end local v6    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/kms/model/CreateCustomKeyStoreResult;>;"
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 972
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/kms/model/CreateCustomKeyStoreRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/kms/model/CreateCustomKeyStoreResult;>;"
    .end local p1    # "createCustomKeyStoreRequest":Lcom/amazonaws/services/kms/model/CreateCustomKeyStoreRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 981
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/kms/model/CreateCustomKeyStoreRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/kms/model/CreateCustomKeyStoreResult;>;"
    .restart local p1    # "createCustomKeyStoreRequest":Lcom/amazonaws/services/kms/model/CreateCustomKeyStoreRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 982
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/kms/AWSKMSClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 983
    throw v5
.end method

.method public createGrant(Lcom/amazonaws/services/kms/model/CreateGrantRequest;)Lcom/amazonaws/services/kms/model/CreateGrantResult;
    .locals 9
    .param p1, "createGrantRequest"    # Lcom/amazonaws/services/kms/model/CreateGrantRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 1121
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/kms/AWSKMSClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 1122
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 1123
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1124
    const/4 v2, 0x0

    .line 1125
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/kms/model/CreateGrantRequest;>;"
    const/4 v3, 0x0

    .line 1127
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/kms/model/CreateGrantResult;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 1129
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/kms/model/transform/CreateGrantRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/kms/model/transform/CreateGrantRequestMarshaller;-><init>()V

    invoke-virtual {v5, p1}, Lcom/amazonaws/services/kms/model/transform/CreateGrantRequestMarshaller;->marshall(Lcom/amazonaws/services/kms/model/CreateGrantRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 1131
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 1133
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1134
    nop

    .line 1135
    new-instance v5, Lcom/amazonaws/services/kms/model/transform/CreateGrantResultJsonUnmarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/kms/model/transform/CreateGrantResultJsonUnmarshaller;-><init>()V

    .line 1136
    .local v5, "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/kms/model/CreateGrantResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    new-instance v6, Lcom/amazonaws/http/JsonResponseHandler;

    invoke-direct {v6, v5}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 1139
    .local v6, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/kms/model/CreateGrantResult;>;"
    invoke-direct {p0, v2, v6, v0}, Lcom/amazonaws/services/kms/AWSKMSClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v7

    move-object v3, v7

    .line 1141
    invoke-virtual {v3}, Lcom/amazonaws/Response;->getAwsResponse()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/amazonaws/services/kms/model/CreateGrantResult;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 1143
    sget-object v8, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v8}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1144
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/kms/AWSKMSClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 1141
    return-object v7

    .line 1133
    .end local v5    # "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/kms/model/CreateGrantResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    .end local v6    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/kms/model/CreateGrantResult;>;"
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1134
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/kms/model/CreateGrantRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/kms/model/CreateGrantResult;>;"
    .end local p1    # "createGrantRequest":Lcom/amazonaws/services/kms/model/CreateGrantRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 1143
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/kms/model/CreateGrantRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/kms/model/CreateGrantResult;>;"
    .restart local p1    # "createGrantRequest":Lcom/amazonaws/services/kms/model/CreateGrantRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1144
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/kms/AWSKMSClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 1145
    throw v5
.end method

.method public createKey()Lcom/amazonaws/services/kms/model/CreateKeyResult;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 6136
    new-instance v0, Lcom/amazonaws/services/kms/model/CreateKeyRequest;

    invoke-direct {v0}, Lcom/amazonaws/services/kms/model/CreateKeyRequest;-><init>()V

    .line 6137
    .local v0, "createKeyRequest":Lcom/amazonaws/services/kms/model/CreateKeyRequest;
    invoke-virtual {p0, v0}, Lcom/amazonaws/services/kms/AWSKMSClient;->createKey(Lcom/amazonaws/services/kms/model/CreateKeyRequest;)Lcom/amazonaws/services/kms/model/CreateKeyResult;

    move-result-object v1

    return-object v1
.end method

.method public createKey(Lcom/amazonaws/services/kms/model/CreateKeyRequest;)Lcom/amazonaws/services/kms/model/CreateKeyResult;
    .locals 9
    .param p1, "createKeyRequest"    # Lcom/amazonaws/services/kms/model/CreateKeyRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 1314
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/kms/AWSKMSClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 1315
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 1316
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1317
    const/4 v2, 0x0

    .line 1318
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/kms/model/CreateKeyRequest;>;"
    const/4 v3, 0x0

    .line 1320
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/kms/model/CreateKeyResult;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 1322
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/kms/model/transform/CreateKeyRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/kms/model/transform/CreateKeyRequestMarshaller;-><init>()V

    invoke-virtual {v5, p1}, Lcom/amazonaws/services/kms/model/transform/CreateKeyRequestMarshaller;->marshall(Lcom/amazonaws/services/kms/model/CreateKeyRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 1324
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 1326
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1327
    nop

    .line 1328
    new-instance v5, Lcom/amazonaws/services/kms/model/transform/CreateKeyResultJsonUnmarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/kms/model/transform/CreateKeyResultJsonUnmarshaller;-><init>()V

    .line 1329
    .local v5, "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/kms/model/CreateKeyResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    new-instance v6, Lcom/amazonaws/http/JsonResponseHandler;

    invoke-direct {v6, v5}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 1332
    .local v6, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/kms/model/CreateKeyResult;>;"
    invoke-direct {p0, v2, v6, v0}, Lcom/amazonaws/services/kms/AWSKMSClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v7

    move-object v3, v7

    .line 1334
    invoke-virtual {v3}, Lcom/amazonaws/Response;->getAwsResponse()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/amazonaws/services/kms/model/CreateKeyResult;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 1336
    sget-object v8, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v8}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1337
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/kms/AWSKMSClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 1334
    return-object v7

    .line 1326
    .end local v5    # "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/kms/model/CreateKeyResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    .end local v6    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/kms/model/CreateKeyResult;>;"
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1327
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/kms/model/CreateKeyRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/kms/model/CreateKeyResult;>;"
    .end local p1    # "createKeyRequest":Lcom/amazonaws/services/kms/model/CreateKeyRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 1336
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/kms/model/CreateKeyRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/kms/model/CreateKeyResult;>;"
    .restart local p1    # "createKeyRequest":Lcom/amazonaws/services/kms/model/CreateKeyRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1337
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/kms/AWSKMSClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 1338
    throw v5
.end method

.method public decrypt(Lcom/amazonaws/services/kms/model/DecryptRequest;)Lcom/amazonaws/services/kms/model/DecryptResult;
    .locals 9
    .param p1, "decryptRequest"    # Lcom/amazonaws/services/kms/model/DecryptRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 1485
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/kms/AWSKMSClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 1486
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 1487
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1488
    const/4 v2, 0x0

    .line 1489
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/kms/model/DecryptRequest;>;"
    const/4 v3, 0x0

    .line 1491
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/kms/model/DecryptResult;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 1493
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/kms/model/transform/DecryptRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/kms/model/transform/DecryptRequestMarshaller;-><init>()V

    invoke-virtual {v5, p1}, Lcom/amazonaws/services/kms/model/transform/DecryptRequestMarshaller;->marshall(Lcom/amazonaws/services/kms/model/DecryptRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 1495
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 1497
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1498
    nop

    .line 1499
    new-instance v5, Lcom/amazonaws/services/kms/model/transform/DecryptResultJsonUnmarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/kms/model/transform/DecryptResultJsonUnmarshaller;-><init>()V

    .line 1500
    .local v5, "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/kms/model/DecryptResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    new-instance v6, Lcom/amazonaws/http/JsonResponseHandler;

    invoke-direct {v6, v5}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 1503
    .local v6, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/kms/model/DecryptResult;>;"
    invoke-direct {p0, v2, v6, v0}, Lcom/amazonaws/services/kms/AWSKMSClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v7

    move-object v3, v7

    .line 1505
    invoke-virtual {v3}, Lcom/amazonaws/Response;->getAwsResponse()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/amazonaws/services/kms/model/DecryptResult;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 1507
    sget-object v8, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v8}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1508
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/kms/AWSKMSClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 1505
    return-object v7

    .line 1497
    .end local v5    # "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/kms/model/DecryptResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    .end local v6    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/kms/model/DecryptResult;>;"
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1498
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/kms/model/DecryptRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/kms/model/DecryptResult;>;"
    .end local p1    # "decryptRequest":Lcom/amazonaws/services/kms/model/DecryptRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 1507
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/kms/model/DecryptRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/kms/model/DecryptResult;>;"
    .restart local p1    # "decryptRequest":Lcom/amazonaws/services/kms/model/DecryptRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1508
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/kms/AWSKMSClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 1509
    throw v5
.end method

.method public deleteAlias(Lcom/amazonaws/services/kms/model/DeleteAliasRequest;)V
    .locals 7
    .param p1, "deleteAliasRequest"    # Lcom/amazonaws/services/kms/model/DeleteAliasRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 1593
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/kms/AWSKMSClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 1594
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 1595
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1596
    const/4 v2, 0x0

    .line 1597
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/kms/model/DeleteAliasRequest;>;"
    const/4 v3, 0x0

    .line 1599
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Ljava/lang/Void;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 1601
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/kms/model/transform/DeleteAliasRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/kms/model/transform/DeleteAliasRequestMarshaller;-><init>()V

    invoke-virtual {v5, p1}, Lcom/amazonaws/services/kms/model/transform/DeleteAliasRequestMarshaller;->marshall(Lcom/amazonaws/services/kms/model/DeleteAliasRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 1603
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 1605
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1606
    nop

    .line 1607
    new-instance v5, Lcom/amazonaws/http/JsonResponseHandler;

    const/4 v6, 0x0

    invoke-direct {v5, v6}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 1608
    .local v5, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Ljava/lang/Void;>;"
    invoke-direct {p0, v2, v5, v0}, Lcom/amazonaws/services/kms/AWSKMSClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 1610
    nop

    .end local v5    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Ljava/lang/Void;>;"
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1611
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/kms/AWSKMSClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 1612
    nop

    .line 1613
    return-void

    .line 1605
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1606
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/kms/model/DeleteAliasRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Ljava/lang/Void;>;"
    .end local p1    # "deleteAliasRequest":Lcom/amazonaws/services/kms/model/DeleteAliasRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 1610
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/kms/model/DeleteAliasRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Ljava/lang/Void;>;"
    .restart local p1    # "deleteAliasRequest":Lcom/amazonaws/services/kms/model/DeleteAliasRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1611
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/kms/AWSKMSClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 1612
    throw v5
.end method

.method public deleteCustomKeyStore(Lcom/amazonaws/services/kms/model/DeleteCustomKeyStoreRequest;)Lcom/amazonaws/services/kms/model/DeleteCustomKeyStoreResult;
    .locals 9
    .param p1, "deleteCustomKeyStoreRequest"    # Lcom/amazonaws/services/kms/model/DeleteCustomKeyStoreRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 1720
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/kms/AWSKMSClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 1721
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 1722
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1723
    const/4 v2, 0x0

    .line 1724
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/kms/model/DeleteCustomKeyStoreRequest;>;"
    const/4 v3, 0x0

    .line 1726
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/kms/model/DeleteCustomKeyStoreResult;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 1728
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/kms/model/transform/DeleteCustomKeyStoreRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/kms/model/transform/DeleteCustomKeyStoreRequestMarshaller;-><init>()V

    .line 1729
    invoke-virtual {v5, p1}, Lcom/amazonaws/services/kms/model/transform/DeleteCustomKeyStoreRequestMarshaller;->marshall(Lcom/amazonaws/services/kms/model/DeleteCustomKeyStoreRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 1731
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 1733
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1734
    nop

    .line 1735
    new-instance v5, Lcom/amazonaws/services/kms/model/transform/DeleteCustomKeyStoreResultJsonUnmarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/kms/model/transform/DeleteCustomKeyStoreResultJsonUnmarshaller;-><init>()V

    .line 1736
    .local v5, "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/kms/model/DeleteCustomKeyStoreResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    new-instance v6, Lcom/amazonaws/http/JsonResponseHandler;

    invoke-direct {v6, v5}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 1739
    .local v6, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/kms/model/DeleteCustomKeyStoreResult;>;"
    invoke-direct {p0, v2, v6, v0}, Lcom/amazonaws/services/kms/AWSKMSClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v7

    move-object v3, v7

    .line 1741
    invoke-virtual {v3}, Lcom/amazonaws/Response;->getAwsResponse()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/amazonaws/services/kms/model/DeleteCustomKeyStoreResult;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 1743
    sget-object v8, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v8}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1744
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/kms/AWSKMSClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 1741
    return-object v7

    .line 1733
    .end local v5    # "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/kms/model/DeleteCustomKeyStoreResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    .end local v6    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/kms/model/DeleteCustomKeyStoreResult;>;"
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1734
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/kms/model/DeleteCustomKeyStoreRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/kms/model/DeleteCustomKeyStoreResult;>;"
    .end local p1    # "deleteCustomKeyStoreRequest":Lcom/amazonaws/services/kms/model/DeleteCustomKeyStoreRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 1743
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/kms/model/DeleteCustomKeyStoreRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/kms/model/DeleteCustomKeyStoreResult;>;"
    .restart local p1    # "deleteCustomKeyStoreRequest":Lcom/amazonaws/services/kms/model/DeleteCustomKeyStoreRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1744
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/kms/AWSKMSClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 1745
    throw v5
.end method

.method public deleteImportedKeyMaterial(Lcom/amazonaws/services/kms/model/DeleteImportedKeyMaterialRequest;)V
    .locals 7
    .param p1, "deleteImportedKeyMaterialRequest"    # Lcom/amazonaws/services/kms/model/DeleteImportedKeyMaterialRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 1816
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/kms/AWSKMSClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 1817
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 1818
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1819
    const/4 v2, 0x0

    .line 1820
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/kms/model/DeleteImportedKeyMaterialRequest;>;"
    const/4 v3, 0x0

    .line 1822
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Ljava/lang/Void;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 1824
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/kms/model/transform/DeleteImportedKeyMaterialRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/kms/model/transform/DeleteImportedKeyMaterialRequestMarshaller;-><init>()V

    .line 1825
    invoke-virtual {v5, p1}, Lcom/amazonaws/services/kms/model/transform/DeleteImportedKeyMaterialRequestMarshaller;->marshall(Lcom/amazonaws/services/kms/model/DeleteImportedKeyMaterialRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 1827
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 1829
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1830
    nop

    .line 1831
    new-instance v5, Lcom/amazonaws/http/JsonResponseHandler;

    const/4 v6, 0x0

    invoke-direct {v5, v6}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 1832
    .local v5, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Ljava/lang/Void;>;"
    invoke-direct {p0, v2, v5, v0}, Lcom/amazonaws/services/kms/AWSKMSClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 1834
    nop

    .end local v5    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Ljava/lang/Void;>;"
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1835
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/kms/AWSKMSClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 1836
    nop

    .line 1837
    return-void

    .line 1829
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1830
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/kms/model/DeleteImportedKeyMaterialRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Ljava/lang/Void;>;"
    .end local p1    # "deleteImportedKeyMaterialRequest":Lcom/amazonaws/services/kms/model/DeleteImportedKeyMaterialRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 1834
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/kms/model/DeleteImportedKeyMaterialRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Ljava/lang/Void;>;"
    .restart local p1    # "deleteImportedKeyMaterialRequest":Lcom/amazonaws/services/kms/model/DeleteImportedKeyMaterialRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1835
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/kms/AWSKMSClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 1836
    throw v5
.end method

.method public describeCustomKeyStores(Lcom/amazonaws/services/kms/model/DescribeCustomKeyStoresRequest;)Lcom/amazonaws/services/kms/model/DescribeCustomKeyStoresResult;
    .locals 9
    .param p1, "describeCustomKeyStoresRequest"    # Lcom/amazonaws/services/kms/model/DescribeCustomKeyStoresRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 1940
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/kms/AWSKMSClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 1941
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 1942
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1943
    const/4 v2, 0x0

    .line 1944
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/kms/model/DescribeCustomKeyStoresRequest;>;"
    const/4 v3, 0x0

    .line 1946
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/kms/model/DescribeCustomKeyStoresResult;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 1948
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/kms/model/transform/DescribeCustomKeyStoresRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/kms/model/transform/DescribeCustomKeyStoresRequestMarshaller;-><init>()V

    .line 1949
    invoke-virtual {v5, p1}, Lcom/amazonaws/services/kms/model/transform/DescribeCustomKeyStoresRequestMarshaller;->marshall(Lcom/amazonaws/services/kms/model/DescribeCustomKeyStoresRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 1951
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 1953
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1954
    nop

    .line 1955
    new-instance v5, Lcom/amazonaws/services/kms/model/transform/DescribeCustomKeyStoresResultJsonUnmarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/kms/model/transform/DescribeCustomKeyStoresResultJsonUnmarshaller;-><init>()V

    .line 1956
    .local v5, "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/kms/model/DescribeCustomKeyStoresResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    new-instance v6, Lcom/amazonaws/http/JsonResponseHandler;

    invoke-direct {v6, v5}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 1959
    .local v6, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/kms/model/DescribeCustomKeyStoresResult;>;"
    invoke-direct {p0, v2, v6, v0}, Lcom/amazonaws/services/kms/AWSKMSClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v7

    move-object v3, v7

    .line 1961
    invoke-virtual {v3}, Lcom/amazonaws/Response;->getAwsResponse()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/amazonaws/services/kms/model/DescribeCustomKeyStoresResult;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 1963
    sget-object v8, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v8}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1964
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/kms/AWSKMSClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 1961
    return-object v7

    .line 1953
    .end local v5    # "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/kms/model/DescribeCustomKeyStoresResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    .end local v6    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/kms/model/DescribeCustomKeyStoresResult;>;"
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1954
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/kms/model/DescribeCustomKeyStoresRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/kms/model/DescribeCustomKeyStoresResult;>;"
    .end local p1    # "describeCustomKeyStoresRequest":Lcom/amazonaws/services/kms/model/DescribeCustomKeyStoresRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 1963
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/kms/model/DescribeCustomKeyStoresRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/kms/model/DescribeCustomKeyStoresResult;>;"
    .restart local p1    # "describeCustomKeyStoresRequest":Lcom/amazonaws/services/kms/model/DescribeCustomKeyStoresRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1964
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/kms/AWSKMSClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 1965
    throw v5
.end method

.method public describeKey(Lcom/amazonaws/services/kms/model/DescribeKeyRequest;)Lcom/amazonaws/services/kms/model/DescribeKeyResult;
    .locals 9
    .param p1, "describeKeyRequest"    # Lcom/amazonaws/services/kms/model/DescribeKeyRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 2097
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/kms/AWSKMSClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 2098
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 2099
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 2100
    const/4 v2, 0x0

    .line 2101
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/kms/model/DescribeKeyRequest;>;"
    const/4 v3, 0x0

    .line 2103
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/kms/model/DescribeKeyResult;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 2105
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/kms/model/transform/DescribeKeyRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/kms/model/transform/DescribeKeyRequestMarshaller;-><init>()V

    invoke-virtual {v5, p1}, Lcom/amazonaws/services/kms/model/transform/DescribeKeyRequestMarshaller;->marshall(Lcom/amazonaws/services/kms/model/DescribeKeyRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 2107
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 2109
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 2110
    nop

    .line 2111
    new-instance v5, Lcom/amazonaws/services/kms/model/transform/DescribeKeyResultJsonUnmarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/kms/model/transform/DescribeKeyResultJsonUnmarshaller;-><init>()V

    .line 2112
    .local v5, "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/kms/model/DescribeKeyResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    new-instance v6, Lcom/amazonaws/http/JsonResponseHandler;

    invoke-direct {v6, v5}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 2115
    .local v6, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/kms/model/DescribeKeyResult;>;"
    invoke-direct {p0, v2, v6, v0}, Lcom/amazonaws/services/kms/AWSKMSClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v7

    move-object v3, v7

    .line 2117
    invoke-virtual {v3}, Lcom/amazonaws/Response;->getAwsResponse()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/amazonaws/services/kms/model/DescribeKeyResult;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 2119
    sget-object v8, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v8}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 2120
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/kms/AWSKMSClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 2117
    return-object v7

    .line 2109
    .end local v5    # "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/kms/model/DescribeKeyResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    .end local v6    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/kms/model/DescribeKeyResult;>;"
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 2110
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/kms/model/DescribeKeyRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/kms/model/DescribeKeyResult;>;"
    .end local p1    # "describeKeyRequest":Lcom/amazonaws/services/kms/model/DescribeKeyRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 2119
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/kms/model/DescribeKeyRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/kms/model/DescribeKeyResult;>;"
    .restart local p1    # "describeKeyRequest":Lcom/amazonaws/services/kms/model/DescribeKeyRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 2120
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/kms/AWSKMSClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 2121
    throw v5
.end method

.method public disableKey(Lcom/amazonaws/services/kms/model/DisableKeyRequest;)V
    .locals 7
    .param p1, "disableKeyRequest"    # Lcom/amazonaws/services/kms/model/DisableKeyRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 2174
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/kms/AWSKMSClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 2175
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 2176
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 2177
    const/4 v2, 0x0

    .line 2178
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/kms/model/DisableKeyRequest;>;"
    const/4 v3, 0x0

    .line 2180
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Ljava/lang/Void;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 2182
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/kms/model/transform/DisableKeyRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/kms/model/transform/DisableKeyRequestMarshaller;-><init>()V

    invoke-virtual {v5, p1}, Lcom/amazonaws/services/kms/model/transform/DisableKeyRequestMarshaller;->marshall(Lcom/amazonaws/services/kms/model/DisableKeyRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 2184
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 2186
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 2187
    nop

    .line 2188
    new-instance v5, Lcom/amazonaws/http/JsonResponseHandler;

    const/4 v6, 0x0

    invoke-direct {v5, v6}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 2189
    .local v5, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Ljava/lang/Void;>;"
    invoke-direct {p0, v2, v5, v0}, Lcom/amazonaws/services/kms/AWSKMSClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 2191
    nop

    .end local v5    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Ljava/lang/Void;>;"
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 2192
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/kms/AWSKMSClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 2193
    nop

    .line 2194
    return-void

    .line 2186
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 2187
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/kms/model/DisableKeyRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Ljava/lang/Void;>;"
    .end local p1    # "disableKeyRequest":Lcom/amazonaws/services/kms/model/DisableKeyRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 2191
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/kms/model/DisableKeyRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Ljava/lang/Void;>;"
    .restart local p1    # "disableKeyRequest":Lcom/amazonaws/services/kms/model/DisableKeyRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 2192
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/kms/AWSKMSClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 2193
    throw v5
.end method

.method public disableKeyRotation(Lcom/amazonaws/services/kms/model/DisableKeyRotationRequest;)V
    .locals 7
    .param p1, "disableKeyRotationRequest"    # Lcom/amazonaws/services/kms/model/DisableKeyRotationRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 2259
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/kms/AWSKMSClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 2260
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 2261
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 2262
    const/4 v2, 0x0

    .line 2263
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/kms/model/DisableKeyRotationRequest;>;"
    const/4 v3, 0x0

    .line 2265
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Ljava/lang/Void;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 2267
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/kms/model/transform/DisableKeyRotationRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/kms/model/transform/DisableKeyRotationRequestMarshaller;-><init>()V

    .line 2268
    invoke-virtual {v5, p1}, Lcom/amazonaws/services/kms/model/transform/DisableKeyRotationRequestMarshaller;->marshall(Lcom/amazonaws/services/kms/model/DisableKeyRotationRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 2270
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 2272
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 2273
    nop

    .line 2274
    new-instance v5, Lcom/amazonaws/http/JsonResponseHandler;

    const/4 v6, 0x0

    invoke-direct {v5, v6}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 2275
    .local v5, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Ljava/lang/Void;>;"
    invoke-direct {p0, v2, v5, v0}, Lcom/amazonaws/services/kms/AWSKMSClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 2277
    nop

    .end local v5    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Ljava/lang/Void;>;"
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 2278
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/kms/AWSKMSClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 2279
    nop

    .line 2280
    return-void

    .line 2272
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 2273
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/kms/model/DisableKeyRotationRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Ljava/lang/Void;>;"
    .end local p1    # "disableKeyRotationRequest":Lcom/amazonaws/services/kms/model/DisableKeyRotationRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 2277
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/kms/model/DisableKeyRotationRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Ljava/lang/Void;>;"
    .restart local p1    # "disableKeyRotationRequest":Lcom/amazonaws/services/kms/model/DisableKeyRotationRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 2278
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/kms/AWSKMSClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 2279
    throw v5
.end method

.method public disconnectCustomKeyStore(Lcom/amazonaws/services/kms/model/DisconnectCustomKeyStoreRequest;)Lcom/amazonaws/services/kms/model/DisconnectCustomKeyStoreResult;
    .locals 9
    .param p1, "disconnectCustomKeyStoreRequest"    # Lcom/amazonaws/services/kms/model/DisconnectCustomKeyStoreRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 2375
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/kms/AWSKMSClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 2376
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 2377
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 2378
    const/4 v2, 0x0

    .line 2379
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/kms/model/DisconnectCustomKeyStoreRequest;>;"
    const/4 v3, 0x0

    .line 2381
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/kms/model/DisconnectCustomKeyStoreResult;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 2383
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/kms/model/transform/DisconnectCustomKeyStoreRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/kms/model/transform/DisconnectCustomKeyStoreRequestMarshaller;-><init>()V

    .line 2384
    invoke-virtual {v5, p1}, Lcom/amazonaws/services/kms/model/transform/DisconnectCustomKeyStoreRequestMarshaller;->marshall(Lcom/amazonaws/services/kms/model/DisconnectCustomKeyStoreRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 2386
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 2388
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 2389
    nop

    .line 2390
    new-instance v5, Lcom/amazonaws/services/kms/model/transform/DisconnectCustomKeyStoreResultJsonUnmarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/kms/model/transform/DisconnectCustomKeyStoreResultJsonUnmarshaller;-><init>()V

    .line 2391
    .local v5, "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/kms/model/DisconnectCustomKeyStoreResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    new-instance v6, Lcom/amazonaws/http/JsonResponseHandler;

    invoke-direct {v6, v5}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 2394
    .local v6, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/kms/model/DisconnectCustomKeyStoreResult;>;"
    invoke-direct {p0, v2, v6, v0}, Lcom/amazonaws/services/kms/AWSKMSClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v7

    move-object v3, v7

    .line 2396
    invoke-virtual {v3}, Lcom/amazonaws/Response;->getAwsResponse()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/amazonaws/services/kms/model/DisconnectCustomKeyStoreResult;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 2398
    sget-object v8, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v8}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 2399
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/kms/AWSKMSClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 2396
    return-object v7

    .line 2388
    .end local v5    # "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/kms/model/DisconnectCustomKeyStoreResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    .end local v6    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/kms/model/DisconnectCustomKeyStoreResult;>;"
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 2389
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/kms/model/DisconnectCustomKeyStoreRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/kms/model/DisconnectCustomKeyStoreResult;>;"
    .end local p1    # "disconnectCustomKeyStoreRequest":Lcom/amazonaws/services/kms/model/DisconnectCustomKeyStoreRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 2398
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/kms/model/DisconnectCustomKeyStoreRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/kms/model/DisconnectCustomKeyStoreResult;>;"
    .restart local p1    # "disconnectCustomKeyStoreRequest":Lcom/amazonaws/services/kms/model/DisconnectCustomKeyStoreRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 2399
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/kms/AWSKMSClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 2400
    throw v5
.end method

.method public enableKey(Lcom/amazonaws/services/kms/model/EnableKeyRequest;)V
    .locals 7
    .param p1, "enableKeyRequest"    # Lcom/amazonaws/services/kms/model/EnableKeyRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 2447
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/kms/AWSKMSClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 2448
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 2449
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 2450
    const/4 v2, 0x0

    .line 2451
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/kms/model/EnableKeyRequest;>;"
    const/4 v3, 0x0

    .line 2453
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Ljava/lang/Void;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 2455
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/kms/model/transform/EnableKeyRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/kms/model/transform/EnableKeyRequestMarshaller;-><init>()V

    invoke-virtual {v5, p1}, Lcom/amazonaws/services/kms/model/transform/EnableKeyRequestMarshaller;->marshall(Lcom/amazonaws/services/kms/model/EnableKeyRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 2457
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 2459
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 2460
    nop

    .line 2461
    new-instance v5, Lcom/amazonaws/http/JsonResponseHandler;

    const/4 v6, 0x0

    invoke-direct {v5, v6}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 2462
    .local v5, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Ljava/lang/Void;>;"
    invoke-direct {p0, v2, v5, v0}, Lcom/amazonaws/services/kms/AWSKMSClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 2464
    nop

    .end local v5    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Ljava/lang/Void;>;"
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 2465
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/kms/AWSKMSClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 2466
    nop

    .line 2467
    return-void

    .line 2459
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 2460
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/kms/model/EnableKeyRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Ljava/lang/Void;>;"
    .end local p1    # "enableKeyRequest":Lcom/amazonaws/services/kms/model/EnableKeyRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 2464
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/kms/model/EnableKeyRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Ljava/lang/Void;>;"
    .restart local p1    # "enableKeyRequest":Lcom/amazonaws/services/kms/model/EnableKeyRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 2465
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/kms/AWSKMSClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 2466
    throw v5
.end method

.method public enableKeyRotation(Lcom/amazonaws/services/kms/model/EnableKeyRotationRequest;)V
    .locals 7
    .param p1, "enableKeyRotationRequest"    # Lcom/amazonaws/services/kms/model/EnableKeyRotationRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 2532
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/kms/AWSKMSClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 2533
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 2534
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 2535
    const/4 v2, 0x0

    .line 2536
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/kms/model/EnableKeyRotationRequest;>;"
    const/4 v3, 0x0

    .line 2538
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Ljava/lang/Void;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 2540
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/kms/model/transform/EnableKeyRotationRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/kms/model/transform/EnableKeyRotationRequestMarshaller;-><init>()V

    .line 2541
    invoke-virtual {v5, p1}, Lcom/amazonaws/services/kms/model/transform/EnableKeyRotationRequestMarshaller;->marshall(Lcom/amazonaws/services/kms/model/EnableKeyRotationRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 2543
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 2545
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 2546
    nop

    .line 2547
    new-instance v5, Lcom/amazonaws/http/JsonResponseHandler;

    const/4 v6, 0x0

    invoke-direct {v5, v6}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 2548
    .local v5, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Ljava/lang/Void;>;"
    invoke-direct {p0, v2, v5, v0}, Lcom/amazonaws/services/kms/AWSKMSClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 2550
    nop

    .end local v5    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Ljava/lang/Void;>;"
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 2551
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/kms/AWSKMSClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 2552
    nop

    .line 2553
    return-void

    .line 2545
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 2546
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/kms/model/EnableKeyRotationRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Ljava/lang/Void;>;"
    .end local p1    # "enableKeyRotationRequest":Lcom/amazonaws/services/kms/model/EnableKeyRotationRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 2550
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/kms/model/EnableKeyRotationRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Ljava/lang/Void;>;"
    .restart local p1    # "enableKeyRotationRequest":Lcom/amazonaws/services/kms/model/EnableKeyRotationRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 2551
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/kms/AWSKMSClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 2552
    throw v5
.end method

.method public encrypt(Lcom/amazonaws/services/kms/model/EncryptRequest;)Lcom/amazonaws/services/kms/model/EncryptResult;
    .locals 9
    .param p1, "encryptRequest"    # Lcom/amazonaws/services/kms/model/EncryptRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 2751
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/kms/AWSKMSClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 2752
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 2753
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 2754
    const/4 v2, 0x0

    .line 2755
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/kms/model/EncryptRequest;>;"
    const/4 v3, 0x0

    .line 2757
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/kms/model/EncryptResult;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 2759
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/kms/model/transform/EncryptRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/kms/model/transform/EncryptRequestMarshaller;-><init>()V

    invoke-virtual {v5, p1}, Lcom/amazonaws/services/kms/model/transform/EncryptRequestMarshaller;->marshall(Lcom/amazonaws/services/kms/model/EncryptRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 2761
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 2763
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 2764
    nop

    .line 2765
    new-instance v5, Lcom/amazonaws/services/kms/model/transform/EncryptResultJsonUnmarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/kms/model/transform/EncryptResultJsonUnmarshaller;-><init>()V

    .line 2766
    .local v5, "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/kms/model/EncryptResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    new-instance v6, Lcom/amazonaws/http/JsonResponseHandler;

    invoke-direct {v6, v5}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 2769
    .local v6, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/kms/model/EncryptResult;>;"
    invoke-direct {p0, v2, v6, v0}, Lcom/amazonaws/services/kms/AWSKMSClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v7

    move-object v3, v7

    .line 2771
    invoke-virtual {v3}, Lcom/amazonaws/Response;->getAwsResponse()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/amazonaws/services/kms/model/EncryptResult;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 2773
    sget-object v8, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v8}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 2774
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/kms/AWSKMSClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 2771
    return-object v7

    .line 2763
    .end local v5    # "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/kms/model/EncryptResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    .end local v6    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/kms/model/EncryptResult;>;"
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 2764
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/kms/model/EncryptRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/kms/model/EncryptResult;>;"
    .end local p1    # "encryptRequest":Lcom/amazonaws/services/kms/model/EncryptRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 2773
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/kms/model/EncryptRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/kms/model/EncryptResult;>;"
    .restart local p1    # "encryptRequest":Lcom/amazonaws/services/kms/model/EncryptRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 2774
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/kms/AWSKMSClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 2775
    throw v5
.end method

.method public generateDataKey(Lcom/amazonaws/services/kms/model/GenerateDataKeyRequest;)Lcom/amazonaws/services/kms/model/GenerateDataKeyResult;
    .locals 9
    .param p1, "generateDataKeyRequest"    # Lcom/amazonaws/services/kms/model/GenerateDataKeyRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 2941
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/kms/AWSKMSClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 2942
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 2943
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 2944
    const/4 v2, 0x0

    .line 2945
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/kms/model/GenerateDataKeyRequest;>;"
    const/4 v3, 0x0

    .line 2947
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/kms/model/GenerateDataKeyResult;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 2949
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/kms/model/transform/GenerateDataKeyRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/kms/model/transform/GenerateDataKeyRequestMarshaller;-><init>()V

    invoke-virtual {v5, p1}, Lcom/amazonaws/services/kms/model/transform/GenerateDataKeyRequestMarshaller;->marshall(Lcom/amazonaws/services/kms/model/GenerateDataKeyRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 2951
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 2953
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 2954
    nop

    .line 2955
    new-instance v5, Lcom/amazonaws/services/kms/model/transform/GenerateDataKeyResultJsonUnmarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/kms/model/transform/GenerateDataKeyResultJsonUnmarshaller;-><init>()V

    .line 2956
    .local v5, "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/kms/model/GenerateDataKeyResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    new-instance v6, Lcom/amazonaws/http/JsonResponseHandler;

    invoke-direct {v6, v5}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 2959
    .local v6, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/kms/model/GenerateDataKeyResult;>;"
    invoke-direct {p0, v2, v6, v0}, Lcom/amazonaws/services/kms/AWSKMSClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v7

    move-object v3, v7

    .line 2961
    invoke-virtual {v3}, Lcom/amazonaws/Response;->getAwsResponse()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/amazonaws/services/kms/model/GenerateDataKeyResult;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 2963
    sget-object v8, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v8}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 2964
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/kms/AWSKMSClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 2961
    return-object v7

    .line 2953
    .end local v5    # "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/kms/model/GenerateDataKeyResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    .end local v6    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/kms/model/GenerateDataKeyResult;>;"
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 2954
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/kms/model/GenerateDataKeyRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/kms/model/GenerateDataKeyResult;>;"
    .end local p1    # "generateDataKeyRequest":Lcom/amazonaws/services/kms/model/GenerateDataKeyRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 2963
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/kms/model/GenerateDataKeyRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/kms/model/GenerateDataKeyResult;>;"
    .restart local p1    # "generateDataKeyRequest":Lcom/amazonaws/services/kms/model/GenerateDataKeyRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 2964
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/kms/AWSKMSClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 2965
    throw v5
.end method

.method public generateDataKeyPair(Lcom/amazonaws/services/kms/model/GenerateDataKeyPairRequest;)Lcom/amazonaws/services/kms/model/GenerateDataKeyPairResult;
    .locals 9
    .param p1, "generateDataKeyPairRequest"    # Lcom/amazonaws/services/kms/model/GenerateDataKeyPairRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 3089
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/kms/AWSKMSClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 3090
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 3091
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 3092
    const/4 v2, 0x0

    .line 3093
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/kms/model/GenerateDataKeyPairRequest;>;"
    const/4 v3, 0x0

    .line 3095
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/kms/model/GenerateDataKeyPairResult;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 3097
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/kms/model/transform/GenerateDataKeyPairRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/kms/model/transform/GenerateDataKeyPairRequestMarshaller;-><init>()V

    .line 3098
    invoke-virtual {v5, p1}, Lcom/amazonaws/services/kms/model/transform/GenerateDataKeyPairRequestMarshaller;->marshall(Lcom/amazonaws/services/kms/model/GenerateDataKeyPairRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 3100
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 3102
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 3103
    nop

    .line 3104
    new-instance v5, Lcom/amazonaws/services/kms/model/transform/GenerateDataKeyPairResultJsonUnmarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/kms/model/transform/GenerateDataKeyPairResultJsonUnmarshaller;-><init>()V

    .line 3105
    .local v5, "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/kms/model/GenerateDataKeyPairResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    new-instance v6, Lcom/amazonaws/http/JsonResponseHandler;

    invoke-direct {v6, v5}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 3108
    .local v6, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/kms/model/GenerateDataKeyPairResult;>;"
    invoke-direct {p0, v2, v6, v0}, Lcom/amazonaws/services/kms/AWSKMSClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v7

    move-object v3, v7

    .line 3110
    invoke-virtual {v3}, Lcom/amazonaws/Response;->getAwsResponse()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/amazonaws/services/kms/model/GenerateDataKeyPairResult;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 3112
    sget-object v8, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v8}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 3113
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/kms/AWSKMSClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 3110
    return-object v7

    .line 3102
    .end local v5    # "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/kms/model/GenerateDataKeyPairResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    .end local v6    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/kms/model/GenerateDataKeyPairResult;>;"
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 3103
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/kms/model/GenerateDataKeyPairRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/kms/model/GenerateDataKeyPairResult;>;"
    .end local p1    # "generateDataKeyPairRequest":Lcom/amazonaws/services/kms/model/GenerateDataKeyPairRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 3112
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/kms/model/GenerateDataKeyPairRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/kms/model/GenerateDataKeyPairResult;>;"
    .restart local p1    # "generateDataKeyPairRequest":Lcom/amazonaws/services/kms/model/GenerateDataKeyPairRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 3113
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/kms/AWSKMSClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 3114
    throw v5
.end method

.method public generateDataKeyPairWithoutPlaintext(Lcom/amazonaws/services/kms/model/GenerateDataKeyPairWithoutPlaintextRequest;)Lcom/amazonaws/services/kms/model/GenerateDataKeyPairWithoutPlaintextResult;
    .locals 9
    .param p1, "generateDataKeyPairWithoutPlaintextRequest"    # Lcom/amazonaws/services/kms/model/GenerateDataKeyPairWithoutPlaintextRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 3229
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/kms/AWSKMSClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 3230
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 3231
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 3232
    const/4 v2, 0x0

    .line 3233
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/kms/model/GenerateDataKeyPairWithoutPlaintextRequest;>;"
    const/4 v3, 0x0

    .line 3235
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/kms/model/GenerateDataKeyPairWithoutPlaintextResult;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 3237
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/kms/model/transform/GenerateDataKeyPairWithoutPlaintextRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/kms/model/transform/GenerateDataKeyPairWithoutPlaintextRequestMarshaller;-><init>()V

    .line 3238
    invoke-virtual {v5, p1}, Lcom/amazonaws/services/kms/model/transform/GenerateDataKeyPairWithoutPlaintextRequestMarshaller;->marshall(Lcom/amazonaws/services/kms/model/GenerateDataKeyPairWithoutPlaintextRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 3240
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 3242
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 3243
    nop

    .line 3244
    new-instance v5, Lcom/amazonaws/services/kms/model/transform/GenerateDataKeyPairWithoutPlaintextResultJsonUnmarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/kms/model/transform/GenerateDataKeyPairWithoutPlaintextResultJsonUnmarshaller;-><init>()V

    .line 3245
    .local v5, "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/kms/model/GenerateDataKeyPairWithoutPlaintextResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    new-instance v6, Lcom/amazonaws/http/JsonResponseHandler;

    invoke-direct {v6, v5}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 3248
    .local v6, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/kms/model/GenerateDataKeyPairWithoutPlaintextResult;>;"
    invoke-direct {p0, v2, v6, v0}, Lcom/amazonaws/services/kms/AWSKMSClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v7

    move-object v3, v7

    .line 3250
    invoke-virtual {v3}, Lcom/amazonaws/Response;->getAwsResponse()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/amazonaws/services/kms/model/GenerateDataKeyPairWithoutPlaintextResult;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 3252
    sget-object v8, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v8}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 3253
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/kms/AWSKMSClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 3250
    return-object v7

    .line 3242
    .end local v5    # "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/kms/model/GenerateDataKeyPairWithoutPlaintextResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    .end local v6    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/kms/model/GenerateDataKeyPairWithoutPlaintextResult;>;"
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 3243
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/kms/model/GenerateDataKeyPairWithoutPlaintextRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/kms/model/GenerateDataKeyPairWithoutPlaintextResult;>;"
    .end local p1    # "generateDataKeyPairWithoutPlaintextRequest":Lcom/amazonaws/services/kms/model/GenerateDataKeyPairWithoutPlaintextRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 3252
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/kms/model/GenerateDataKeyPairWithoutPlaintextRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/kms/model/GenerateDataKeyPairWithoutPlaintextResult;>;"
    .restart local p1    # "generateDataKeyPairWithoutPlaintextRequest":Lcom/amazonaws/services/kms/model/GenerateDataKeyPairWithoutPlaintextRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 3253
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/kms/AWSKMSClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 3254
    throw v5
.end method

.method public generateDataKeyWithoutPlaintext(Lcom/amazonaws/services/kms/model/GenerateDataKeyWithoutPlaintextRequest;)Lcom/amazonaws/services/kms/model/GenerateDataKeyWithoutPlaintextResult;
    .locals 9
    .param p1, "generateDataKeyWithoutPlaintextRequest"    # Lcom/amazonaws/services/kms/model/GenerateDataKeyWithoutPlaintextRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 3380
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/kms/AWSKMSClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 3381
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 3382
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 3383
    const/4 v2, 0x0

    .line 3384
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/kms/model/GenerateDataKeyWithoutPlaintextRequest;>;"
    const/4 v3, 0x0

    .line 3386
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/kms/model/GenerateDataKeyWithoutPlaintextResult;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 3388
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/kms/model/transform/GenerateDataKeyWithoutPlaintextRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/kms/model/transform/GenerateDataKeyWithoutPlaintextRequestMarshaller;-><init>()V

    .line 3389
    invoke-virtual {v5, p1}, Lcom/amazonaws/services/kms/model/transform/GenerateDataKeyWithoutPlaintextRequestMarshaller;->marshall(Lcom/amazonaws/services/kms/model/GenerateDataKeyWithoutPlaintextRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 3391
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 3393
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 3394
    nop

    .line 3395
    new-instance v5, Lcom/amazonaws/services/kms/model/transform/GenerateDataKeyWithoutPlaintextResultJsonUnmarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/kms/model/transform/GenerateDataKeyWithoutPlaintextResultJsonUnmarshaller;-><init>()V

    .line 3396
    .local v5, "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/kms/model/GenerateDataKeyWithoutPlaintextResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    new-instance v6, Lcom/amazonaws/http/JsonResponseHandler;

    invoke-direct {v6, v5}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 3399
    .local v6, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/kms/model/GenerateDataKeyWithoutPlaintextResult;>;"
    invoke-direct {p0, v2, v6, v0}, Lcom/amazonaws/services/kms/AWSKMSClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v7

    move-object v3, v7

    .line 3401
    invoke-virtual {v3}, Lcom/amazonaws/Response;->getAwsResponse()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/amazonaws/services/kms/model/GenerateDataKeyWithoutPlaintextResult;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 3403
    sget-object v8, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v8}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 3404
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/kms/AWSKMSClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 3401
    return-object v7

    .line 3393
    .end local v5    # "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/kms/model/GenerateDataKeyWithoutPlaintextResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    .end local v6    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/kms/model/GenerateDataKeyWithoutPlaintextResult;>;"
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 3394
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/kms/model/GenerateDataKeyWithoutPlaintextRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/kms/model/GenerateDataKeyWithoutPlaintextResult;>;"
    .end local p1    # "generateDataKeyWithoutPlaintextRequest":Lcom/amazonaws/services/kms/model/GenerateDataKeyWithoutPlaintextRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 3403
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/kms/model/GenerateDataKeyWithoutPlaintextRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/kms/model/GenerateDataKeyWithoutPlaintextResult;>;"
    .restart local p1    # "generateDataKeyWithoutPlaintextRequest":Lcom/amazonaws/services/kms/model/GenerateDataKeyWithoutPlaintextRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 3404
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/kms/AWSKMSClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 3405
    throw v5
.end method

.method public generateRandom()Lcom/amazonaws/services/kms/model/GenerateRandomResult;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 6412
    new-instance v0, Lcom/amazonaws/services/kms/model/GenerateRandomRequest;

    invoke-direct {v0}, Lcom/amazonaws/services/kms/model/GenerateRandomRequest;-><init>()V

    .line 6413
    .local v0, "generateRandomRequest":Lcom/amazonaws/services/kms/model/GenerateRandomRequest;
    invoke-virtual {p0, v0}, Lcom/amazonaws/services/kms/AWSKMSClient;->generateRandom(Lcom/amazonaws/services/kms/model/GenerateRandomRequest;)Lcom/amazonaws/services/kms/model/GenerateRandomResult;

    move-result-object v1

    return-object v1
.end method

.method public generateRandom(Lcom/amazonaws/services/kms/model/GenerateRandomRequest;)Lcom/amazonaws/services/kms/model/GenerateRandomResult;
    .locals 9
    .param p1, "generateRandomRequest"    # Lcom/amazonaws/services/kms/model/GenerateRandomRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 3448
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/kms/AWSKMSClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 3449
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 3450
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 3451
    const/4 v2, 0x0

    .line 3452
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/kms/model/GenerateRandomRequest;>;"
    const/4 v3, 0x0

    .line 3454
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/kms/model/GenerateRandomResult;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 3456
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/kms/model/transform/GenerateRandomRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/kms/model/transform/GenerateRandomRequestMarshaller;-><init>()V

    invoke-virtual {v5, p1}, Lcom/amazonaws/services/kms/model/transform/GenerateRandomRequestMarshaller;->marshall(Lcom/amazonaws/services/kms/model/GenerateRandomRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 3458
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 3460
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 3461
    nop

    .line 3462
    new-instance v5, Lcom/amazonaws/services/kms/model/transform/GenerateRandomResultJsonUnmarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/kms/model/transform/GenerateRandomResultJsonUnmarshaller;-><init>()V

    .line 3463
    .local v5, "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/kms/model/GenerateRandomResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    new-instance v6, Lcom/amazonaws/http/JsonResponseHandler;

    invoke-direct {v6, v5}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 3466
    .local v6, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/kms/model/GenerateRandomResult;>;"
    invoke-direct {p0, v2, v6, v0}, Lcom/amazonaws/services/kms/AWSKMSClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v7

    move-object v3, v7

    .line 3468
    invoke-virtual {v3}, Lcom/amazonaws/Response;->getAwsResponse()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/amazonaws/services/kms/model/GenerateRandomResult;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 3470
    sget-object v8, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v8}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 3471
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/kms/AWSKMSClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 3468
    return-object v7

    .line 3460
    .end local v5    # "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/kms/model/GenerateRandomResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    .end local v6    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/kms/model/GenerateRandomResult;>;"
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 3461
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/kms/model/GenerateRandomRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/kms/model/GenerateRandomResult;>;"
    .end local p1    # "generateRandomRequest":Lcom/amazonaws/services/kms/model/GenerateRandomRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 3470
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/kms/model/GenerateRandomRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/kms/model/GenerateRandomResult;>;"
    .restart local p1    # "generateRandomRequest":Lcom/amazonaws/services/kms/model/GenerateRandomRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 3471
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/kms/AWSKMSClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 3472
    throw v5
.end method

.method public getCachedResponseMetadata(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/ResponseMetadata;
    .locals 1
    .param p1, "request"    # Lcom/amazonaws/AmazonWebServiceRequest;
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 6437
    iget-object v0, p0, Lcom/amazonaws/services/kms/AWSKMSClient;->client:Lcom/amazonaws/http/AmazonHttpClient;

    invoke-virtual {v0, p1}, Lcom/amazonaws/http/AmazonHttpClient;->getResponseMetadataForRequest(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/ResponseMetadata;

    move-result-object v0

    return-object v0
.end method

.method public getKeyPolicy(Lcom/amazonaws/services/kms/model/GetKeyPolicyRequest;)Lcom/amazonaws/services/kms/model/GetKeyPolicyResult;
    .locals 9
    .param p1, "getKeyPolicyRequest"    # Lcom/amazonaws/services/kms/model/GetKeyPolicyRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 3510
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/kms/AWSKMSClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 3511
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 3512
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 3513
    const/4 v2, 0x0

    .line 3514
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/kms/model/GetKeyPolicyRequest;>;"
    const/4 v3, 0x0

    .line 3516
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/kms/model/GetKeyPolicyResult;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 3518
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/kms/model/transform/GetKeyPolicyRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/kms/model/transform/GetKeyPolicyRequestMarshaller;-><init>()V

    invoke-virtual {v5, p1}, Lcom/amazonaws/services/kms/model/transform/GetKeyPolicyRequestMarshaller;->marshall(Lcom/amazonaws/services/kms/model/GetKeyPolicyRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 3520
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 3522
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 3523
    nop

    .line 3524
    new-instance v5, Lcom/amazonaws/services/kms/model/transform/GetKeyPolicyResultJsonUnmarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/kms/model/transform/GetKeyPolicyResultJsonUnmarshaller;-><init>()V

    .line 3525
    .local v5, "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/kms/model/GetKeyPolicyResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    new-instance v6, Lcom/amazonaws/http/JsonResponseHandler;

    invoke-direct {v6, v5}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 3528
    .local v6, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/kms/model/GetKeyPolicyResult;>;"
    invoke-direct {p0, v2, v6, v0}, Lcom/amazonaws/services/kms/AWSKMSClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v7

    move-object v3, v7

    .line 3530
    invoke-virtual {v3}, Lcom/amazonaws/Response;->getAwsResponse()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/amazonaws/services/kms/model/GetKeyPolicyResult;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 3532
    sget-object v8, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v8}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 3533
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/kms/AWSKMSClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 3530
    return-object v7

    .line 3522
    .end local v5    # "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/kms/model/GetKeyPolicyResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    .end local v6    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/kms/model/GetKeyPolicyResult;>;"
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 3523
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/kms/model/GetKeyPolicyRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/kms/model/GetKeyPolicyResult;>;"
    .end local p1    # "getKeyPolicyRequest":Lcom/amazonaws/services/kms/model/GetKeyPolicyRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 3532
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/kms/model/GetKeyPolicyRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/kms/model/GetKeyPolicyResult;>;"
    .restart local p1    # "getKeyPolicyRequest":Lcom/amazonaws/services/kms/model/GetKeyPolicyRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 3533
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/kms/AWSKMSClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 3534
    throw v5
.end method

.method public getKeyRotationStatus(Lcom/amazonaws/services/kms/model/GetKeyRotationStatusRequest;)Lcom/amazonaws/services/kms/model/GetKeyRotationStatusResult;
    .locals 9
    .param p1, "getKeyRotationStatusRequest"    # Lcom/amazonaws/services/kms/model/GetKeyRotationStatusRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 3621
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/kms/AWSKMSClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 3622
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 3623
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 3624
    const/4 v2, 0x0

    .line 3625
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/kms/model/GetKeyRotationStatusRequest;>;"
    const/4 v3, 0x0

    .line 3627
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/kms/model/GetKeyRotationStatusResult;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 3629
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/kms/model/transform/GetKeyRotationStatusRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/kms/model/transform/GetKeyRotationStatusRequestMarshaller;-><init>()V

    .line 3630
    invoke-virtual {v5, p1}, Lcom/amazonaws/services/kms/model/transform/GetKeyRotationStatusRequestMarshaller;->marshall(Lcom/amazonaws/services/kms/model/GetKeyRotationStatusRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 3632
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 3634
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 3635
    nop

    .line 3636
    new-instance v5, Lcom/amazonaws/services/kms/model/transform/GetKeyRotationStatusResultJsonUnmarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/kms/model/transform/GetKeyRotationStatusResultJsonUnmarshaller;-><init>()V

    .line 3637
    .local v5, "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/kms/model/GetKeyRotationStatusResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    new-instance v6, Lcom/amazonaws/http/JsonResponseHandler;

    invoke-direct {v6, v5}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 3640
    .local v6, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/kms/model/GetKeyRotationStatusResult;>;"
    invoke-direct {p0, v2, v6, v0}, Lcom/amazonaws/services/kms/AWSKMSClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v7

    move-object v3, v7

    .line 3642
    invoke-virtual {v3}, Lcom/amazonaws/Response;->getAwsResponse()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/amazonaws/services/kms/model/GetKeyRotationStatusResult;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 3644
    sget-object v8, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v8}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 3645
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/kms/AWSKMSClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 3642
    return-object v7

    .line 3634
    .end local v5    # "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/kms/model/GetKeyRotationStatusResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    .end local v6    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/kms/model/GetKeyRotationStatusResult;>;"
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 3635
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/kms/model/GetKeyRotationStatusRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/kms/model/GetKeyRotationStatusResult;>;"
    .end local p1    # "getKeyRotationStatusRequest":Lcom/amazonaws/services/kms/model/GetKeyRotationStatusRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 3644
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/kms/model/GetKeyRotationStatusRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/kms/model/GetKeyRotationStatusResult;>;"
    .restart local p1    # "getKeyRotationStatusRequest":Lcom/amazonaws/services/kms/model/GetKeyRotationStatusRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 3645
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/kms/AWSKMSClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 3646
    throw v5
.end method

.method public getParametersForImport(Lcom/amazonaws/services/kms/model/GetParametersForImportRequest;)Lcom/amazonaws/services/kms/model/GetParametersForImportResult;
    .locals 9
    .param p1, "getParametersForImportRequest"    # Lcom/amazonaws/services/kms/model/GetParametersForImportRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 3732
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/kms/AWSKMSClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 3733
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 3734
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 3735
    const/4 v2, 0x0

    .line 3736
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/kms/model/GetParametersForImportRequest;>;"
    const/4 v3, 0x0

    .line 3738
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/kms/model/GetParametersForImportResult;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 3740
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/kms/model/transform/GetParametersForImportRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/kms/model/transform/GetParametersForImportRequestMarshaller;-><init>()V

    .line 3741
    invoke-virtual {v5, p1}, Lcom/amazonaws/services/kms/model/transform/GetParametersForImportRequestMarshaller;->marshall(Lcom/amazonaws/services/kms/model/GetParametersForImportRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 3743
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 3745
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 3746
    nop

    .line 3747
    new-instance v5, Lcom/amazonaws/services/kms/model/transform/GetParametersForImportResultJsonUnmarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/kms/model/transform/GetParametersForImportResultJsonUnmarshaller;-><init>()V

    .line 3748
    .local v5, "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/kms/model/GetParametersForImportResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    new-instance v6, Lcom/amazonaws/http/JsonResponseHandler;

    invoke-direct {v6, v5}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 3751
    .local v6, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/kms/model/GetParametersForImportResult;>;"
    invoke-direct {p0, v2, v6, v0}, Lcom/amazonaws/services/kms/AWSKMSClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v7

    move-object v3, v7

    .line 3753
    invoke-virtual {v3}, Lcom/amazonaws/Response;->getAwsResponse()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/amazonaws/services/kms/model/GetParametersForImportResult;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 3755
    sget-object v8, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v8}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 3756
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/kms/AWSKMSClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 3753
    return-object v7

    .line 3745
    .end local v5    # "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/kms/model/GetParametersForImportResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    .end local v6    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/kms/model/GetParametersForImportResult;>;"
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 3746
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/kms/model/GetParametersForImportRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/kms/model/GetParametersForImportResult;>;"
    .end local p1    # "getParametersForImportRequest":Lcom/amazonaws/services/kms/model/GetParametersForImportRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 3755
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/kms/model/GetParametersForImportRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/kms/model/GetParametersForImportResult;>;"
    .restart local p1    # "getParametersForImportRequest":Lcom/amazonaws/services/kms/model/GetParametersForImportRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 3756
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/kms/AWSKMSClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 3757
    throw v5
.end method

.method public getPublicKey(Lcom/amazonaws/services/kms/model/GetPublicKeyRequest;)Lcom/amazonaws/services/kms/model/GetPublicKeyResult;
    .locals 9
    .param p1, "getPublicKeyRequest"    # Lcom/amazonaws/services/kms/model/GetPublicKeyRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 3869
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/kms/AWSKMSClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 3870
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 3871
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 3872
    const/4 v2, 0x0

    .line 3873
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/kms/model/GetPublicKeyRequest;>;"
    const/4 v3, 0x0

    .line 3875
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/kms/model/GetPublicKeyResult;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 3877
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/kms/model/transform/GetPublicKeyRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/kms/model/transform/GetPublicKeyRequestMarshaller;-><init>()V

    invoke-virtual {v5, p1}, Lcom/amazonaws/services/kms/model/transform/GetPublicKeyRequestMarshaller;->marshall(Lcom/amazonaws/services/kms/model/GetPublicKeyRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 3879
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 3881
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 3882
    nop

    .line 3883
    new-instance v5, Lcom/amazonaws/services/kms/model/transform/GetPublicKeyResultJsonUnmarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/kms/model/transform/GetPublicKeyResultJsonUnmarshaller;-><init>()V

    .line 3884
    .local v5, "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/kms/model/GetPublicKeyResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    new-instance v6, Lcom/amazonaws/http/JsonResponseHandler;

    invoke-direct {v6, v5}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 3887
    .local v6, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/kms/model/GetPublicKeyResult;>;"
    invoke-direct {p0, v2, v6, v0}, Lcom/amazonaws/services/kms/AWSKMSClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v7

    move-object v3, v7

    .line 3889
    invoke-virtual {v3}, Lcom/amazonaws/Response;->getAwsResponse()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/amazonaws/services/kms/model/GetPublicKeyResult;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 3891
    sget-object v8, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v8}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 3892
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/kms/AWSKMSClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 3889
    return-object v7

    .line 3881
    .end local v5    # "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/kms/model/GetPublicKeyResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    .end local v6    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/kms/model/GetPublicKeyResult;>;"
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 3882
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/kms/model/GetPublicKeyRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/kms/model/GetPublicKeyResult;>;"
    .end local p1    # "getPublicKeyRequest":Lcom/amazonaws/services/kms/model/GetPublicKeyRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 3891
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/kms/model/GetPublicKeyRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/kms/model/GetPublicKeyResult;>;"
    .restart local p1    # "getPublicKeyRequest":Lcom/amazonaws/services/kms/model/GetPublicKeyRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 3892
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/kms/AWSKMSClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 3893
    throw v5
.end method

.method public importKeyMaterial(Lcom/amazonaws/services/kms/model/ImportKeyMaterialRequest;)Lcom/amazonaws/services/kms/model/ImportKeyMaterialResult;
    .locals 9
    .param p1, "importKeyMaterialRequest"    # Lcom/amazonaws/services/kms/model/ImportKeyMaterialRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 4029
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/kms/AWSKMSClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 4030
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 4031
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 4032
    const/4 v2, 0x0

    .line 4033
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/kms/model/ImportKeyMaterialRequest;>;"
    const/4 v3, 0x0

    .line 4035
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/kms/model/ImportKeyMaterialResult;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 4037
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/kms/model/transform/ImportKeyMaterialRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/kms/model/transform/ImportKeyMaterialRequestMarshaller;-><init>()V

    .line 4038
    invoke-virtual {v5, p1}, Lcom/amazonaws/services/kms/model/transform/ImportKeyMaterialRequestMarshaller;->marshall(Lcom/amazonaws/services/kms/model/ImportKeyMaterialRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 4040
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 4042
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 4043
    nop

    .line 4044
    new-instance v5, Lcom/amazonaws/services/kms/model/transform/ImportKeyMaterialResultJsonUnmarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/kms/model/transform/ImportKeyMaterialResultJsonUnmarshaller;-><init>()V

    .line 4045
    .local v5, "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/kms/model/ImportKeyMaterialResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    new-instance v6, Lcom/amazonaws/http/JsonResponseHandler;

    invoke-direct {v6, v5}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 4048
    .local v6, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/kms/model/ImportKeyMaterialResult;>;"
    invoke-direct {p0, v2, v6, v0}, Lcom/amazonaws/services/kms/AWSKMSClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v7

    move-object v3, v7

    .line 4050
    invoke-virtual {v3}, Lcom/amazonaws/Response;->getAwsResponse()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/amazonaws/services/kms/model/ImportKeyMaterialResult;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 4052
    sget-object v8, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v8}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 4053
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/kms/AWSKMSClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 4050
    return-object v7

    .line 4042
    .end local v5    # "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/kms/model/ImportKeyMaterialResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    .end local v6    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/kms/model/ImportKeyMaterialResult;>;"
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 4043
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/kms/model/ImportKeyMaterialRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/kms/model/ImportKeyMaterialResult;>;"
    .end local p1    # "importKeyMaterialRequest":Lcom/amazonaws/services/kms/model/ImportKeyMaterialRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 4052
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/kms/model/ImportKeyMaterialRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/kms/model/ImportKeyMaterialResult;>;"
    .restart local p1    # "importKeyMaterialRequest":Lcom/amazonaws/services/kms/model/ImportKeyMaterialRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 4053
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/kms/AWSKMSClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 4054
    throw v5
.end method

.method public listAliases()Lcom/amazonaws/services/kms/model/ListAliasesResult;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 6279
    new-instance v0, Lcom/amazonaws/services/kms/model/ListAliasesRequest;

    invoke-direct {v0}, Lcom/amazonaws/services/kms/model/ListAliasesRequest;-><init>()V

    .line 6280
    .local v0, "listAliasesRequest":Lcom/amazonaws/services/kms/model/ListAliasesRequest;
    invoke-virtual {p0, v0}, Lcom/amazonaws/services/kms/AWSKMSClient;->listAliases(Lcom/amazonaws/services/kms/model/ListAliasesRequest;)Lcom/amazonaws/services/kms/model/ListAliasesResult;

    move-result-object v1

    return-object v1
.end method

.method public listAliases(Lcom/amazonaws/services/kms/model/ListAliasesRequest;)Lcom/amazonaws/services/kms/model/ListAliasesResult;
    .locals 9
    .param p1, "listAliasesRequest"    # Lcom/amazonaws/services/kms/model/ListAliasesRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 4138
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/kms/AWSKMSClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 4139
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 4140
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 4141
    const/4 v2, 0x0

    .line 4142
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/kms/model/ListAliasesRequest;>;"
    const/4 v3, 0x0

    .line 4144
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/kms/model/ListAliasesResult;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 4146
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/kms/model/transform/ListAliasesRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/kms/model/transform/ListAliasesRequestMarshaller;-><init>()V

    invoke-virtual {v5, p1}, Lcom/amazonaws/services/kms/model/transform/ListAliasesRequestMarshaller;->marshall(Lcom/amazonaws/services/kms/model/ListAliasesRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 4148
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 4150
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 4151
    nop

    .line 4152
    new-instance v5, Lcom/amazonaws/services/kms/model/transform/ListAliasesResultJsonUnmarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/kms/model/transform/ListAliasesResultJsonUnmarshaller;-><init>()V

    .line 4153
    .local v5, "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/kms/model/ListAliasesResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    new-instance v6, Lcom/amazonaws/http/JsonResponseHandler;

    invoke-direct {v6, v5}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 4156
    .local v6, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/kms/model/ListAliasesResult;>;"
    invoke-direct {p0, v2, v6, v0}, Lcom/amazonaws/services/kms/AWSKMSClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v7

    move-object v3, v7

    .line 4158
    invoke-virtual {v3}, Lcom/amazonaws/Response;->getAwsResponse()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/amazonaws/services/kms/model/ListAliasesResult;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 4160
    sget-object v8, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v8}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 4161
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/kms/AWSKMSClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 4158
    return-object v7

    .line 4150
    .end local v5    # "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/kms/model/ListAliasesResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    .end local v6    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/kms/model/ListAliasesResult;>;"
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 4151
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/kms/model/ListAliasesRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/kms/model/ListAliasesResult;>;"
    .end local p1    # "listAliasesRequest":Lcom/amazonaws/services/kms/model/ListAliasesRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 4160
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/kms/model/ListAliasesRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/kms/model/ListAliasesResult;>;"
    .restart local p1    # "listAliasesRequest":Lcom/amazonaws/services/kms/model/ListAliasesRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 4161
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/kms/AWSKMSClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 4162
    throw v5
.end method

.method public listGrants(Lcom/amazonaws/services/kms/model/ListGrantsRequest;)Lcom/amazonaws/services/kms/model/ListGrantsResult;
    .locals 9
    .param p1, "listGrantsRequest"    # Lcom/amazonaws/services/kms/model/ListGrantsRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 4241
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/kms/AWSKMSClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 4242
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 4243
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 4244
    const/4 v2, 0x0

    .line 4245
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/kms/model/ListGrantsRequest;>;"
    const/4 v3, 0x0

    .line 4247
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/kms/model/ListGrantsResult;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 4249
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/kms/model/transform/ListGrantsRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/kms/model/transform/ListGrantsRequestMarshaller;-><init>()V

    invoke-virtual {v5, p1}, Lcom/amazonaws/services/kms/model/transform/ListGrantsRequestMarshaller;->marshall(Lcom/amazonaws/services/kms/model/ListGrantsRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 4251
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 4253
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 4254
    nop

    .line 4255
    new-instance v5, Lcom/amazonaws/services/kms/model/transform/ListGrantsResultJsonUnmarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/kms/model/transform/ListGrantsResultJsonUnmarshaller;-><init>()V

    .line 4256
    .local v5, "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/kms/model/ListGrantsResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    new-instance v6, Lcom/amazonaws/http/JsonResponseHandler;

    invoke-direct {v6, v5}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 4259
    .local v6, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/kms/model/ListGrantsResult;>;"
    invoke-direct {p0, v2, v6, v0}, Lcom/amazonaws/services/kms/AWSKMSClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v7

    move-object v3, v7

    .line 4261
    invoke-virtual {v3}, Lcom/amazonaws/Response;->getAwsResponse()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/amazonaws/services/kms/model/ListGrantsResult;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 4263
    sget-object v8, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v8}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 4264
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/kms/AWSKMSClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 4261
    return-object v7

    .line 4253
    .end local v5    # "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/kms/model/ListGrantsResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    .end local v6    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/kms/model/ListGrantsResult;>;"
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 4254
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/kms/model/ListGrantsRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/kms/model/ListGrantsResult;>;"
    .end local p1    # "listGrantsRequest":Lcom/amazonaws/services/kms/model/ListGrantsRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 4263
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/kms/model/ListGrantsRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/kms/model/ListGrantsResult;>;"
    .restart local p1    # "listGrantsRequest":Lcom/amazonaws/services/kms/model/ListGrantsRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 4264
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/kms/AWSKMSClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 4265
    throw v5
.end method

.method public listKeyPolicies(Lcom/amazonaws/services/kms/model/ListKeyPoliciesRequest;)Lcom/amazonaws/services/kms/model/ListKeyPoliciesResult;
    .locals 9
    .param p1, "listKeyPoliciesRequest"    # Lcom/amazonaws/services/kms/model/ListKeyPoliciesRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 4318
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/kms/AWSKMSClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 4319
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 4320
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 4321
    const/4 v2, 0x0

    .line 4322
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/kms/model/ListKeyPoliciesRequest;>;"
    const/4 v3, 0x0

    .line 4324
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/kms/model/ListKeyPoliciesResult;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 4326
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/kms/model/transform/ListKeyPoliciesRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/kms/model/transform/ListKeyPoliciesRequestMarshaller;-><init>()V

    invoke-virtual {v5, p1}, Lcom/amazonaws/services/kms/model/transform/ListKeyPoliciesRequestMarshaller;->marshall(Lcom/amazonaws/services/kms/model/ListKeyPoliciesRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 4328
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 4330
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 4331
    nop

    .line 4332
    new-instance v5, Lcom/amazonaws/services/kms/model/transform/ListKeyPoliciesResultJsonUnmarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/kms/model/transform/ListKeyPoliciesResultJsonUnmarshaller;-><init>()V

    .line 4333
    .local v5, "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/kms/model/ListKeyPoliciesResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    new-instance v6, Lcom/amazonaws/http/JsonResponseHandler;

    invoke-direct {v6, v5}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 4336
    .local v6, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/kms/model/ListKeyPoliciesResult;>;"
    invoke-direct {p0, v2, v6, v0}, Lcom/amazonaws/services/kms/AWSKMSClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v7

    move-object v3, v7

    .line 4338
    invoke-virtual {v3}, Lcom/amazonaws/Response;->getAwsResponse()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/amazonaws/services/kms/model/ListKeyPoliciesResult;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 4340
    sget-object v8, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v8}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 4341
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/kms/AWSKMSClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 4338
    return-object v7

    .line 4330
    .end local v5    # "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/kms/model/ListKeyPoliciesResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    .end local v6    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/kms/model/ListKeyPoliciesResult;>;"
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 4331
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/kms/model/ListKeyPoliciesRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/kms/model/ListKeyPoliciesResult;>;"
    .end local p1    # "listKeyPoliciesRequest":Lcom/amazonaws/services/kms/model/ListKeyPoliciesRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 4340
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/kms/model/ListKeyPoliciesRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/kms/model/ListKeyPoliciesResult;>;"
    .restart local p1    # "listKeyPoliciesRequest":Lcom/amazonaws/services/kms/model/ListKeyPoliciesRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 4341
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/kms/AWSKMSClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 4342
    throw v5
.end method

.method public listKeys()Lcom/amazonaws/services/kms/model/ListKeysResult;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 6195
    new-instance v0, Lcom/amazonaws/services/kms/model/ListKeysRequest;

    invoke-direct {v0}, Lcom/amazonaws/services/kms/model/ListKeysRequest;-><init>()V

    .line 6196
    .local v0, "listKeysRequest":Lcom/amazonaws/services/kms/model/ListKeysRequest;
    invoke-virtual {p0, v0}, Lcom/amazonaws/services/kms/AWSKMSClient;->listKeys(Lcom/amazonaws/services/kms/model/ListKeysRequest;)Lcom/amazonaws/services/kms/model/ListKeysResult;

    move-result-object v1

    return-object v1
.end method

.method public listKeys(Lcom/amazonaws/services/kms/model/ListKeysRequest;)Lcom/amazonaws/services/kms/model/ListKeysResult;
    .locals 9
    .param p1, "listKeysRequest"    # Lcom/amazonaws/services/kms/model/ListKeysRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 4401
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/kms/AWSKMSClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 4402
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 4403
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 4404
    const/4 v2, 0x0

    .line 4405
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/kms/model/ListKeysRequest;>;"
    const/4 v3, 0x0

    .line 4407
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/kms/model/ListKeysResult;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 4409
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/kms/model/transform/ListKeysRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/kms/model/transform/ListKeysRequestMarshaller;-><init>()V

    invoke-virtual {v5, p1}, Lcom/amazonaws/services/kms/model/transform/ListKeysRequestMarshaller;->marshall(Lcom/amazonaws/services/kms/model/ListKeysRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 4411
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 4413
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 4414
    nop

    .line 4415
    new-instance v5, Lcom/amazonaws/services/kms/model/transform/ListKeysResultJsonUnmarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/kms/model/transform/ListKeysResultJsonUnmarshaller;-><init>()V

    .line 4416
    .local v5, "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/kms/model/ListKeysResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    new-instance v6, Lcom/amazonaws/http/JsonResponseHandler;

    invoke-direct {v6, v5}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 4419
    .local v6, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/kms/model/ListKeysResult;>;"
    invoke-direct {p0, v2, v6, v0}, Lcom/amazonaws/services/kms/AWSKMSClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v7

    move-object v3, v7

    .line 4421
    invoke-virtual {v3}, Lcom/amazonaws/Response;->getAwsResponse()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/amazonaws/services/kms/model/ListKeysResult;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 4423
    sget-object v8, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v8}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 4424
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/kms/AWSKMSClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 4421
    return-object v7

    .line 4413
    .end local v5    # "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/kms/model/ListKeysResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    .end local v6    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/kms/model/ListKeysResult;>;"
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 4414
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/kms/model/ListKeysRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/kms/model/ListKeysResult;>;"
    .end local p1    # "listKeysRequest":Lcom/amazonaws/services/kms/model/ListKeysRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 4423
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/kms/model/ListKeysRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/kms/model/ListKeysResult;>;"
    .restart local p1    # "listKeysRequest":Lcom/amazonaws/services/kms/model/ListKeysRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 4424
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/kms/AWSKMSClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 4425
    throw v5
.end method

.method public listResourceTags(Lcom/amazonaws/services/kms/model/ListResourceTagsRequest;)Lcom/amazonaws/services/kms/model/ListResourceTagsResult;
    .locals 9
    .param p1, "listResourceTagsRequest"    # Lcom/amazonaws/services/kms/model/ListResourceTagsRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 4482
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/kms/AWSKMSClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 4483
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 4484
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 4485
    const/4 v2, 0x0

    .line 4486
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/kms/model/ListResourceTagsRequest;>;"
    const/4 v3, 0x0

    .line 4488
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/kms/model/ListResourceTagsResult;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 4490
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/kms/model/transform/ListResourceTagsRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/kms/model/transform/ListResourceTagsRequestMarshaller;-><init>()V

    invoke-virtual {v5, p1}, Lcom/amazonaws/services/kms/model/transform/ListResourceTagsRequestMarshaller;->marshall(Lcom/amazonaws/services/kms/model/ListResourceTagsRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 4492
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 4494
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 4495
    nop

    .line 4496
    new-instance v5, Lcom/amazonaws/services/kms/model/transform/ListResourceTagsResultJsonUnmarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/kms/model/transform/ListResourceTagsResultJsonUnmarshaller;-><init>()V

    .line 4497
    .local v5, "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/kms/model/ListResourceTagsResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    new-instance v6, Lcom/amazonaws/http/JsonResponseHandler;

    invoke-direct {v6, v5}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 4500
    .local v6, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/kms/model/ListResourceTagsResult;>;"
    invoke-direct {p0, v2, v6, v0}, Lcom/amazonaws/services/kms/AWSKMSClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v7

    move-object v3, v7

    .line 4502
    invoke-virtual {v3}, Lcom/amazonaws/Response;->getAwsResponse()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/amazonaws/services/kms/model/ListResourceTagsResult;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 4504
    sget-object v8, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v8}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 4505
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/kms/AWSKMSClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 4502
    return-object v7

    .line 4494
    .end local v5    # "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/kms/model/ListResourceTagsResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    .end local v6    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/kms/model/ListResourceTagsResult;>;"
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 4495
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/kms/model/ListResourceTagsRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/kms/model/ListResourceTagsResult;>;"
    .end local p1    # "listResourceTagsRequest":Lcom/amazonaws/services/kms/model/ListResourceTagsRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 4504
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/kms/model/ListResourceTagsRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/kms/model/ListResourceTagsResult;>;"
    .restart local p1    # "listResourceTagsRequest":Lcom/amazonaws/services/kms/model/ListResourceTagsRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 4505
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/kms/AWSKMSClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 4506
    throw v5
.end method

.method public listRetirableGrants(Lcom/amazonaws/services/kms/model/ListRetirableGrantsRequest;)Lcom/amazonaws/services/kms/model/ListRetirableGrantsResult;
    .locals 9
    .param p1, "listRetirableGrantsRequest"    # Lcom/amazonaws/services/kms/model/ListRetirableGrantsRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 4580
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/kms/AWSKMSClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 4581
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 4582
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 4583
    const/4 v2, 0x0

    .line 4584
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/kms/model/ListRetirableGrantsRequest;>;"
    const/4 v3, 0x0

    .line 4586
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/kms/model/ListRetirableGrantsResult;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 4588
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/kms/model/transform/ListRetirableGrantsRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/kms/model/transform/ListRetirableGrantsRequestMarshaller;-><init>()V

    .line 4589
    invoke-virtual {v5, p1}, Lcom/amazonaws/services/kms/model/transform/ListRetirableGrantsRequestMarshaller;->marshall(Lcom/amazonaws/services/kms/model/ListRetirableGrantsRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 4591
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 4593
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 4594
    nop

    .line 4595
    new-instance v5, Lcom/amazonaws/services/kms/model/transform/ListRetirableGrantsResultJsonUnmarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/kms/model/transform/ListRetirableGrantsResultJsonUnmarshaller;-><init>()V

    .line 4596
    .local v5, "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/kms/model/ListRetirableGrantsResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    new-instance v6, Lcom/amazonaws/http/JsonResponseHandler;

    invoke-direct {v6, v5}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 4599
    .local v6, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/kms/model/ListRetirableGrantsResult;>;"
    invoke-direct {p0, v2, v6, v0}, Lcom/amazonaws/services/kms/AWSKMSClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v7

    move-object v3, v7

    .line 4601
    invoke-virtual {v3}, Lcom/amazonaws/Response;->getAwsResponse()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/amazonaws/services/kms/model/ListRetirableGrantsResult;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 4603
    sget-object v8, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v8}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 4604
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/kms/AWSKMSClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 4601
    return-object v7

    .line 4593
    .end local v5    # "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/kms/model/ListRetirableGrantsResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    .end local v6    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/kms/model/ListRetirableGrantsResult;>;"
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 4594
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/kms/model/ListRetirableGrantsRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/kms/model/ListRetirableGrantsResult;>;"
    .end local p1    # "listRetirableGrantsRequest":Lcom/amazonaws/services/kms/model/ListRetirableGrantsRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 4603
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/kms/model/ListRetirableGrantsRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/kms/model/ListRetirableGrantsResult;>;"
    .restart local p1    # "listRetirableGrantsRequest":Lcom/amazonaws/services/kms/model/ListRetirableGrantsRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 4604
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/kms/AWSKMSClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 4605
    throw v5
.end method

.method public putKeyPolicy(Lcom/amazonaws/services/kms/model/PutKeyPolicyRequest;)V
    .locals 7
    .param p1, "putKeyPolicyRequest"    # Lcom/amazonaws/services/kms/model/PutKeyPolicyRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 4658
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/kms/AWSKMSClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 4659
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 4660
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 4661
    const/4 v2, 0x0

    .line 4662
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/kms/model/PutKeyPolicyRequest;>;"
    const/4 v3, 0x0

    .line 4664
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Ljava/lang/Void;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 4666
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/kms/model/transform/PutKeyPolicyRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/kms/model/transform/PutKeyPolicyRequestMarshaller;-><init>()V

    invoke-virtual {v5, p1}, Lcom/amazonaws/services/kms/model/transform/PutKeyPolicyRequestMarshaller;->marshall(Lcom/amazonaws/services/kms/model/PutKeyPolicyRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 4668
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 4670
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 4671
    nop

    .line 4672
    new-instance v5, Lcom/amazonaws/http/JsonResponseHandler;

    const/4 v6, 0x0

    invoke-direct {v5, v6}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 4673
    .local v5, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Ljava/lang/Void;>;"
    invoke-direct {p0, v2, v5, v0}, Lcom/amazonaws/services/kms/AWSKMSClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 4675
    nop

    .end local v5    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Ljava/lang/Void;>;"
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 4676
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/kms/AWSKMSClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 4677
    nop

    .line 4678
    return-void

    .line 4670
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 4671
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/kms/model/PutKeyPolicyRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Ljava/lang/Void;>;"
    .end local p1    # "putKeyPolicyRequest":Lcom/amazonaws/services/kms/model/PutKeyPolicyRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 4675
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/kms/model/PutKeyPolicyRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Ljava/lang/Void;>;"
    .restart local p1    # "putKeyPolicyRequest":Lcom/amazonaws/services/kms/model/PutKeyPolicyRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 4676
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/kms/AWSKMSClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 4677
    throw v5
.end method

.method public reEncrypt(Lcom/amazonaws/services/kms/model/ReEncryptRequest;)Lcom/amazonaws/services/kms/model/ReEncryptResult;
    .locals 9
    .param p1, "reEncryptRequest"    # Lcom/amazonaws/services/kms/model/ReEncryptRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 4850
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/kms/AWSKMSClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 4851
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 4852
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 4853
    const/4 v2, 0x0

    .line 4854
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/kms/model/ReEncryptRequest;>;"
    const/4 v3, 0x0

    .line 4856
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/kms/model/ReEncryptResult;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 4858
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/kms/model/transform/ReEncryptRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/kms/model/transform/ReEncryptRequestMarshaller;-><init>()V

    invoke-virtual {v5, p1}, Lcom/amazonaws/services/kms/model/transform/ReEncryptRequestMarshaller;->marshall(Lcom/amazonaws/services/kms/model/ReEncryptRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 4860
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 4862
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 4863
    nop

    .line 4864
    new-instance v5, Lcom/amazonaws/services/kms/model/transform/ReEncryptResultJsonUnmarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/kms/model/transform/ReEncryptResultJsonUnmarshaller;-><init>()V

    .line 4865
    .local v5, "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/kms/model/ReEncryptResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    new-instance v6, Lcom/amazonaws/http/JsonResponseHandler;

    invoke-direct {v6, v5}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 4868
    .local v6, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/kms/model/ReEncryptResult;>;"
    invoke-direct {p0, v2, v6, v0}, Lcom/amazonaws/services/kms/AWSKMSClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v7

    move-object v3, v7

    .line 4870
    invoke-virtual {v3}, Lcom/amazonaws/Response;->getAwsResponse()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/amazonaws/services/kms/model/ReEncryptResult;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 4872
    sget-object v8, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v8}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 4873
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/kms/AWSKMSClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 4870
    return-object v7

    .line 4862
    .end local v5    # "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/kms/model/ReEncryptResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    .end local v6    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/kms/model/ReEncryptResult;>;"
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 4863
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/kms/model/ReEncryptRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/kms/model/ReEncryptResult;>;"
    .end local p1    # "reEncryptRequest":Lcom/amazonaws/services/kms/model/ReEncryptRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 4872
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/kms/model/ReEncryptRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/kms/model/ReEncryptResult;>;"
    .restart local p1    # "reEncryptRequest":Lcom/amazonaws/services/kms/model/ReEncryptRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 4873
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/kms/AWSKMSClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 4874
    throw v5
.end method

.method public retireGrant()V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 6369
    new-instance v0, Lcom/amazonaws/services/kms/model/RetireGrantRequest;

    invoke-direct {v0}, Lcom/amazonaws/services/kms/model/RetireGrantRequest;-><init>()V

    .line 6370
    .local v0, "retireGrantRequest":Lcom/amazonaws/services/kms/model/RetireGrantRequest;
    invoke-virtual {p0, v0}, Lcom/amazonaws/services/kms/AWSKMSClient;->retireGrant(Lcom/amazonaws/services/kms/model/RetireGrantRequest;)V

    .line 6371
    return-void
.end method

.method public retireGrant(Lcom/amazonaws/services/kms/model/RetireGrantRequest;)V
    .locals 7
    .param p1, "retireGrantRequest"    # Lcom/amazonaws/services/kms/model/RetireGrantRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 4964
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/kms/AWSKMSClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 4965
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 4966
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 4967
    const/4 v2, 0x0

    .line 4968
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/kms/model/RetireGrantRequest;>;"
    const/4 v3, 0x0

    .line 4970
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Ljava/lang/Void;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 4972
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/kms/model/transform/RetireGrantRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/kms/model/transform/RetireGrantRequestMarshaller;-><init>()V

    invoke-virtual {v5, p1}, Lcom/amazonaws/services/kms/model/transform/RetireGrantRequestMarshaller;->marshall(Lcom/amazonaws/services/kms/model/RetireGrantRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 4974
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 4976
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 4977
    nop

    .line 4978
    new-instance v5, Lcom/amazonaws/http/JsonResponseHandler;

    const/4 v6, 0x0

    invoke-direct {v5, v6}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 4979
    .local v5, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Ljava/lang/Void;>;"
    invoke-direct {p0, v2, v5, v0}, Lcom/amazonaws/services/kms/AWSKMSClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 4981
    nop

    .end local v5    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Ljava/lang/Void;>;"
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 4982
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/kms/AWSKMSClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 4983
    nop

    .line 4984
    return-void

    .line 4976
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 4977
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/kms/model/RetireGrantRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Ljava/lang/Void;>;"
    .end local p1    # "retireGrantRequest":Lcom/amazonaws/services/kms/model/RetireGrantRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 4981
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/kms/model/RetireGrantRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Ljava/lang/Void;>;"
    .restart local p1    # "retireGrantRequest":Lcom/amazonaws/services/kms/model/RetireGrantRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 4982
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/kms/AWSKMSClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 4983
    throw v5
.end method

.method public revokeGrant(Lcom/amazonaws/services/kms/model/RevokeGrantRequest;)V
    .locals 7
    .param p1, "revokeGrantRequest"    # Lcom/amazonaws/services/kms/model/RevokeGrantRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 5044
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/kms/AWSKMSClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 5045
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 5046
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 5047
    const/4 v2, 0x0

    .line 5048
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/kms/model/RevokeGrantRequest;>;"
    const/4 v3, 0x0

    .line 5050
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Ljava/lang/Void;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 5052
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/kms/model/transform/RevokeGrantRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/kms/model/transform/RevokeGrantRequestMarshaller;-><init>()V

    invoke-virtual {v5, p1}, Lcom/amazonaws/services/kms/model/transform/RevokeGrantRequestMarshaller;->marshall(Lcom/amazonaws/services/kms/model/RevokeGrantRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 5054
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 5056
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 5057
    nop

    .line 5058
    new-instance v5, Lcom/amazonaws/http/JsonResponseHandler;

    const/4 v6, 0x0

    invoke-direct {v5, v6}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 5059
    .local v5, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Ljava/lang/Void;>;"
    invoke-direct {p0, v2, v5, v0}, Lcom/amazonaws/services/kms/AWSKMSClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 5061
    nop

    .end local v5    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Ljava/lang/Void;>;"
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 5062
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/kms/AWSKMSClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 5063
    nop

    .line 5064
    return-void

    .line 5056
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 5057
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/kms/model/RevokeGrantRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Ljava/lang/Void;>;"
    .end local p1    # "revokeGrantRequest":Lcom/amazonaws/services/kms/model/RevokeGrantRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 5061
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/kms/model/RevokeGrantRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Ljava/lang/Void;>;"
    .restart local p1    # "revokeGrantRequest":Lcom/amazonaws/services/kms/model/RevokeGrantRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 5062
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/kms/AWSKMSClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 5063
    throw v5
.end method

.method public scheduleKeyDeletion(Lcom/amazonaws/services/kms/model/ScheduleKeyDeletionRequest;)Lcom/amazonaws/services/kms/model/ScheduleKeyDeletionResult;
    .locals 9
    .param p1, "scheduleKeyDeletionRequest"    # Lcom/amazonaws/services/kms/model/ScheduleKeyDeletionRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 5153
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/kms/AWSKMSClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 5154
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 5155
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 5156
    const/4 v2, 0x0

    .line 5157
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/kms/model/ScheduleKeyDeletionRequest;>;"
    const/4 v3, 0x0

    .line 5159
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/kms/model/ScheduleKeyDeletionResult;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 5161
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/kms/model/transform/ScheduleKeyDeletionRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/kms/model/transform/ScheduleKeyDeletionRequestMarshaller;-><init>()V

    .line 5162
    invoke-virtual {v5, p1}, Lcom/amazonaws/services/kms/model/transform/ScheduleKeyDeletionRequestMarshaller;->marshall(Lcom/amazonaws/services/kms/model/ScheduleKeyDeletionRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 5164
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 5166
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 5167
    nop

    .line 5168
    new-instance v5, Lcom/amazonaws/services/kms/model/transform/ScheduleKeyDeletionResultJsonUnmarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/kms/model/transform/ScheduleKeyDeletionResultJsonUnmarshaller;-><init>()V

    .line 5169
    .local v5, "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/kms/model/ScheduleKeyDeletionResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    new-instance v6, Lcom/amazonaws/http/JsonResponseHandler;

    invoke-direct {v6, v5}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 5172
    .local v6, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/kms/model/ScheduleKeyDeletionResult;>;"
    invoke-direct {p0, v2, v6, v0}, Lcom/amazonaws/services/kms/AWSKMSClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v7

    move-object v3, v7

    .line 5174
    invoke-virtual {v3}, Lcom/amazonaws/Response;->getAwsResponse()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/amazonaws/services/kms/model/ScheduleKeyDeletionResult;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 5176
    sget-object v8, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v8}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 5177
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/kms/AWSKMSClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 5174
    return-object v7

    .line 5166
    .end local v5    # "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/kms/model/ScheduleKeyDeletionResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    .end local v6    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/kms/model/ScheduleKeyDeletionResult;>;"
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 5167
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/kms/model/ScheduleKeyDeletionRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/kms/model/ScheduleKeyDeletionResult;>;"
    .end local p1    # "scheduleKeyDeletionRequest":Lcom/amazonaws/services/kms/model/ScheduleKeyDeletionRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 5176
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/kms/model/ScheduleKeyDeletionRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/kms/model/ScheduleKeyDeletionResult;>;"
    .restart local p1    # "scheduleKeyDeletionRequest":Lcom/amazonaws/services/kms/model/ScheduleKeyDeletionRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 5177
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/kms/AWSKMSClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 5178
    throw v5
.end method

.method public sign(Lcom/amazonaws/services/kms/model/SignRequest;)Lcom/amazonaws/services/kms/model/SignResult;
    .locals 9
    .param p1, "signRequest"    # Lcom/amazonaws/services/kms/model/SignRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 5286
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/kms/AWSKMSClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 5287
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 5288
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 5289
    const/4 v2, 0x0

    .line 5290
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/kms/model/SignRequest;>;"
    const/4 v3, 0x0

    .line 5292
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/kms/model/SignResult;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 5294
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/kms/model/transform/SignRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/kms/model/transform/SignRequestMarshaller;-><init>()V

    invoke-virtual {v5, p1}, Lcom/amazonaws/services/kms/model/transform/SignRequestMarshaller;->marshall(Lcom/amazonaws/services/kms/model/SignRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 5296
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 5298
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 5299
    nop

    .line 5300
    new-instance v5, Lcom/amazonaws/services/kms/model/transform/SignResultJsonUnmarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/kms/model/transform/SignResultJsonUnmarshaller;-><init>()V

    .line 5301
    .local v5, "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/kms/model/SignResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    new-instance v6, Lcom/amazonaws/http/JsonResponseHandler;

    invoke-direct {v6, v5}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 5304
    .local v6, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/kms/model/SignResult;>;"
    invoke-direct {p0, v2, v6, v0}, Lcom/amazonaws/services/kms/AWSKMSClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v7

    move-object v3, v7

    .line 5306
    invoke-virtual {v3}, Lcom/amazonaws/Response;->getAwsResponse()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/amazonaws/services/kms/model/SignResult;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 5308
    sget-object v8, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v8}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 5309
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/kms/AWSKMSClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 5306
    return-object v7

    .line 5298
    .end local v5    # "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/kms/model/SignResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    .end local v6    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/kms/model/SignResult;>;"
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 5299
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/kms/model/SignRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/kms/model/SignResult;>;"
    .end local p1    # "signRequest":Lcom/amazonaws/services/kms/model/SignRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 5308
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/kms/model/SignRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/kms/model/SignResult;>;"
    .restart local p1    # "signRequest":Lcom/amazonaws/services/kms/model/SignRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 5309
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/kms/AWSKMSClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 5310
    throw v5
.end method

.method public tagResource(Lcom/amazonaws/services/kms/model/TagResourceRequest;)V
    .locals 7
    .param p1, "tagResourceRequest"    # Lcom/amazonaws/services/kms/model/TagResourceRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 5393
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/kms/AWSKMSClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 5394
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 5395
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 5396
    const/4 v2, 0x0

    .line 5397
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/kms/model/TagResourceRequest;>;"
    const/4 v3, 0x0

    .line 5399
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Ljava/lang/Void;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 5401
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/kms/model/transform/TagResourceRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/kms/model/transform/TagResourceRequestMarshaller;-><init>()V

    invoke-virtual {v5, p1}, Lcom/amazonaws/services/kms/model/transform/TagResourceRequestMarshaller;->marshall(Lcom/amazonaws/services/kms/model/TagResourceRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 5403
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 5405
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 5406
    nop

    .line 5407
    new-instance v5, Lcom/amazonaws/http/JsonResponseHandler;

    const/4 v6, 0x0

    invoke-direct {v5, v6}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 5408
    .local v5, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Ljava/lang/Void;>;"
    invoke-direct {p0, v2, v5, v0}, Lcom/amazonaws/services/kms/AWSKMSClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 5410
    nop

    .end local v5    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Ljava/lang/Void;>;"
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 5411
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/kms/AWSKMSClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 5412
    nop

    .line 5413
    return-void

    .line 5405
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 5406
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/kms/model/TagResourceRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Ljava/lang/Void;>;"
    .end local p1    # "tagResourceRequest":Lcom/amazonaws/services/kms/model/TagResourceRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 5410
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/kms/model/TagResourceRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Ljava/lang/Void;>;"
    .restart local p1    # "tagResourceRequest":Lcom/amazonaws/services/kms/model/TagResourceRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 5411
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/kms/AWSKMSClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 5412
    throw v5
.end method

.method public untagResource(Lcom/amazonaws/services/kms/model/UntagResourceRequest;)V
    .locals 7
    .param p1, "untagResourceRequest"    # Lcom/amazonaws/services/kms/model/UntagResourceRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 5484
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/kms/AWSKMSClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 5485
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 5486
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 5487
    const/4 v2, 0x0

    .line 5488
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/kms/model/UntagResourceRequest;>;"
    const/4 v3, 0x0

    .line 5490
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Ljava/lang/Void;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 5492
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/kms/model/transform/UntagResourceRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/kms/model/transform/UntagResourceRequestMarshaller;-><init>()V

    invoke-virtual {v5, p1}, Lcom/amazonaws/services/kms/model/transform/UntagResourceRequestMarshaller;->marshall(Lcom/amazonaws/services/kms/model/UntagResourceRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 5494
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 5496
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 5497
    nop

    .line 5498
    new-instance v5, Lcom/amazonaws/http/JsonResponseHandler;

    const/4 v6, 0x0

    invoke-direct {v5, v6}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 5499
    .local v5, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Ljava/lang/Void;>;"
    invoke-direct {p0, v2, v5, v0}, Lcom/amazonaws/services/kms/AWSKMSClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 5501
    nop

    .end local v5    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Ljava/lang/Void;>;"
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 5502
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/kms/AWSKMSClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 5503
    nop

    .line 5504
    return-void

    .line 5496
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 5497
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/kms/model/UntagResourceRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Ljava/lang/Void;>;"
    .end local p1    # "untagResourceRequest":Lcom/amazonaws/services/kms/model/UntagResourceRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 5501
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/kms/model/UntagResourceRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Ljava/lang/Void;>;"
    .restart local p1    # "untagResourceRequest":Lcom/amazonaws/services/kms/model/UntagResourceRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 5502
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/kms/AWSKMSClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 5503
    throw v5
.end method

.method public updateAlias(Lcom/amazonaws/services/kms/model/UpdateAliasRequest;)V
    .locals 7
    .param p1, "updateAliasRequest"    # Lcom/amazonaws/services/kms/model/UpdateAliasRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 5613
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/kms/AWSKMSClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 5614
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 5615
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 5616
    const/4 v2, 0x0

    .line 5617
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/kms/model/UpdateAliasRequest;>;"
    const/4 v3, 0x0

    .line 5619
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Ljava/lang/Void;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 5621
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/kms/model/transform/UpdateAliasRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/kms/model/transform/UpdateAliasRequestMarshaller;-><init>()V

    invoke-virtual {v5, p1}, Lcom/amazonaws/services/kms/model/transform/UpdateAliasRequestMarshaller;->marshall(Lcom/amazonaws/services/kms/model/UpdateAliasRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 5623
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 5625
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 5626
    nop

    .line 5627
    new-instance v5, Lcom/amazonaws/http/JsonResponseHandler;

    const/4 v6, 0x0

    invoke-direct {v5, v6}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 5628
    .local v5, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Ljava/lang/Void;>;"
    invoke-direct {p0, v2, v5, v0}, Lcom/amazonaws/services/kms/AWSKMSClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 5630
    nop

    .end local v5    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Ljava/lang/Void;>;"
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 5631
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/kms/AWSKMSClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 5632
    nop

    .line 5633
    return-void

    .line 5625
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 5626
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/kms/model/UpdateAliasRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Ljava/lang/Void;>;"
    .end local p1    # "updateAliasRequest":Lcom/amazonaws/services/kms/model/UpdateAliasRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 5630
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/kms/model/UpdateAliasRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Ljava/lang/Void;>;"
    .restart local p1    # "updateAliasRequest":Lcom/amazonaws/services/kms/model/UpdateAliasRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 5631
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/kms/AWSKMSClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 5632
    throw v5
.end method

.method public updateCustomKeyStore(Lcom/amazonaws/services/kms/model/UpdateCustomKeyStoreRequest;)Lcom/amazonaws/services/kms/model/UpdateCustomKeyStoreResult;
    .locals 9
    .param p1, "updateCustomKeyStoreRequest"    # Lcom/amazonaws/services/kms/model/UpdateCustomKeyStoreRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 5758
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/kms/AWSKMSClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 5759
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 5760
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 5761
    const/4 v2, 0x0

    .line 5762
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/kms/model/UpdateCustomKeyStoreRequest;>;"
    const/4 v3, 0x0

    .line 5764
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/kms/model/UpdateCustomKeyStoreResult;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 5766
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/kms/model/transform/UpdateCustomKeyStoreRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/kms/model/transform/UpdateCustomKeyStoreRequestMarshaller;-><init>()V

    .line 5767
    invoke-virtual {v5, p1}, Lcom/amazonaws/services/kms/model/transform/UpdateCustomKeyStoreRequestMarshaller;->marshall(Lcom/amazonaws/services/kms/model/UpdateCustomKeyStoreRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 5769
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 5771
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 5772
    nop

    .line 5773
    new-instance v5, Lcom/amazonaws/services/kms/model/transform/UpdateCustomKeyStoreResultJsonUnmarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/kms/model/transform/UpdateCustomKeyStoreResultJsonUnmarshaller;-><init>()V

    .line 5774
    .local v5, "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/kms/model/UpdateCustomKeyStoreResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    new-instance v6, Lcom/amazonaws/http/JsonResponseHandler;

    invoke-direct {v6, v5}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 5777
    .local v6, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/kms/model/UpdateCustomKeyStoreResult;>;"
    invoke-direct {p0, v2, v6, v0}, Lcom/amazonaws/services/kms/AWSKMSClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v7

    move-object v3, v7

    .line 5779
    invoke-virtual {v3}, Lcom/amazonaws/Response;->getAwsResponse()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/amazonaws/services/kms/model/UpdateCustomKeyStoreResult;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 5781
    sget-object v8, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v8}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 5782
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/kms/AWSKMSClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 5779
    return-object v7

    .line 5771
    .end local v5    # "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/kms/model/UpdateCustomKeyStoreResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    .end local v6    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/kms/model/UpdateCustomKeyStoreResult;>;"
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 5772
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/kms/model/UpdateCustomKeyStoreRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/kms/model/UpdateCustomKeyStoreResult;>;"
    .end local p1    # "updateCustomKeyStoreRequest":Lcom/amazonaws/services/kms/model/UpdateCustomKeyStoreRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 5781
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/kms/model/UpdateCustomKeyStoreRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/kms/model/UpdateCustomKeyStoreResult;>;"
    .restart local p1    # "updateCustomKeyStoreRequest":Lcom/amazonaws/services/kms/model/UpdateCustomKeyStoreRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 5782
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/kms/AWSKMSClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 5783
    throw v5
.end method

.method public updateKeyDescription(Lcom/amazonaws/services/kms/model/UpdateKeyDescriptionRequest;)V
    .locals 7
    .param p1, "updateKeyDescriptionRequest"    # Lcom/amazonaws/services/kms/model/UpdateKeyDescriptionRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 5839
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/kms/AWSKMSClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 5840
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 5841
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 5842
    const/4 v2, 0x0

    .line 5843
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/kms/model/UpdateKeyDescriptionRequest;>;"
    const/4 v3, 0x0

    .line 5845
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Ljava/lang/Void;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 5847
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/kms/model/transform/UpdateKeyDescriptionRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/kms/model/transform/UpdateKeyDescriptionRequestMarshaller;-><init>()V

    .line 5848
    invoke-virtual {v5, p1}, Lcom/amazonaws/services/kms/model/transform/UpdateKeyDescriptionRequestMarshaller;->marshall(Lcom/amazonaws/services/kms/model/UpdateKeyDescriptionRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 5850
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 5852
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 5853
    nop

    .line 5854
    new-instance v5, Lcom/amazonaws/http/JsonResponseHandler;

    const/4 v6, 0x0

    invoke-direct {v5, v6}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 5855
    .local v5, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Ljava/lang/Void;>;"
    invoke-direct {p0, v2, v5, v0}, Lcom/amazonaws/services/kms/AWSKMSClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 5857
    nop

    .end local v5    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Ljava/lang/Void;>;"
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 5858
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/kms/AWSKMSClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 5859
    nop

    .line 5860
    return-void

    .line 5852
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 5853
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/kms/model/UpdateKeyDescriptionRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Ljava/lang/Void;>;"
    .end local p1    # "updateKeyDescriptionRequest":Lcom/amazonaws/services/kms/model/UpdateKeyDescriptionRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 5857
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/kms/model/UpdateKeyDescriptionRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Ljava/lang/Void;>;"
    .restart local p1    # "updateKeyDescriptionRequest":Lcom/amazonaws/services/kms/model/UpdateKeyDescriptionRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 5858
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/kms/AWSKMSClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 5859
    throw v5
.end method

.method public verify(Lcom/amazonaws/services/kms/model/VerifyRequest;)Lcom/amazonaws/services/kms/model/VerifyResult;
    .locals 9
    .param p1, "verifyRequest"    # Lcom/amazonaws/services/kms/model/VerifyRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 5944
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/kms/AWSKMSClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 5945
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 5946
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 5947
    const/4 v2, 0x0

    .line 5948
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/kms/model/VerifyRequest;>;"
    const/4 v3, 0x0

    .line 5950
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/kms/model/VerifyResult;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 5952
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/kms/model/transform/VerifyRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/kms/model/transform/VerifyRequestMarshaller;-><init>()V

    invoke-virtual {v5, p1}, Lcom/amazonaws/services/kms/model/transform/VerifyRequestMarshaller;->marshall(Lcom/amazonaws/services/kms/model/VerifyRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 5954
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 5956
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 5957
    nop

    .line 5958
    new-instance v5, Lcom/amazonaws/services/kms/model/transform/VerifyResultJsonUnmarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/kms/model/transform/VerifyResultJsonUnmarshaller;-><init>()V

    .line 5959
    .local v5, "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/kms/model/VerifyResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    new-instance v6, Lcom/amazonaws/http/JsonResponseHandler;

    invoke-direct {v6, v5}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 5962
    .local v6, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/kms/model/VerifyResult;>;"
    invoke-direct {p0, v2, v6, v0}, Lcom/amazonaws/services/kms/AWSKMSClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v7

    move-object v3, v7

    .line 5964
    invoke-virtual {v3}, Lcom/amazonaws/Response;->getAwsResponse()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/amazonaws/services/kms/model/VerifyResult;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 5966
    sget-object v8, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v8}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 5967
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/kms/AWSKMSClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 5964
    return-object v7

    .line 5956
    .end local v5    # "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/kms/model/VerifyResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    .end local v6    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/kms/model/VerifyResult;>;"
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 5957
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/kms/model/VerifyRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/kms/model/VerifyResult;>;"
    .end local p1    # "verifyRequest":Lcom/amazonaws/services/kms/model/VerifyRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 5966
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/kms/model/VerifyRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/kms/model/VerifyResult;>;"
    .restart local p1    # "verifyRequest":Lcom/amazonaws/services/kms/model/VerifyRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 5967
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/kms/AWSKMSClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 5968
    throw v5
.end method
