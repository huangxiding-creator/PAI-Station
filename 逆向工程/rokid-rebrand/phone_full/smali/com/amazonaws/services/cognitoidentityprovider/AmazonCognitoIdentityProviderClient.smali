.class public Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;
.super Lcom/amazonaws/AmazonWebServiceClient;
.source "AmazonCognitoIdentityProviderClient.java"

# interfaces
.implements Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProvider;


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

    .line 80
    new-instance v0, Lcom/amazonaws/auth/DefaultAWSCredentialsProviderChain;

    invoke-direct {v0}, Lcom/amazonaws/auth/DefaultAWSCredentialsProviderChain;-><init>()V

    new-instance v1, Lcom/amazonaws/ClientConfiguration;

    invoke-direct {v1}, Lcom/amazonaws/ClientConfiguration;-><init>()V

    invoke-direct {p0, v0, v1}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;-><init>(Lcom/amazonaws/auth/AWSCredentialsProvider;Lcom/amazonaws/ClientConfiguration;)V

    .line 81
    return-void
.end method

.method public constructor <init>(Lcom/amazonaws/ClientConfiguration;)V
    .locals 1
    .param p1, "clientConfiguration"    # Lcom/amazonaws/ClientConfiguration;
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 104
    new-instance v0, Lcom/amazonaws/auth/DefaultAWSCredentialsProviderChain;

    invoke-direct {v0}, Lcom/amazonaws/auth/DefaultAWSCredentialsProviderChain;-><init>()V

    invoke-direct {p0, v0, p1}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;-><init>(Lcom/amazonaws/auth/AWSCredentialsProvider;Lcom/amazonaws/ClientConfiguration;)V

    .line 105
    return-void
.end method

.method public constructor <init>(Lcom/amazonaws/auth/AWSCredentials;)V
    .locals 1
    .param p1, "awsCredentials"    # Lcom/amazonaws/auth/AWSCredentials;

    .line 142
    new-instance v0, Lcom/amazonaws/ClientConfiguration;

    invoke-direct {v0}, Lcom/amazonaws/ClientConfiguration;-><init>()V

    invoke-direct {p0, p1, v0}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;-><init>(Lcom/amazonaws/auth/AWSCredentials;Lcom/amazonaws/ClientConfiguration;)V

    .line 143
    return-void
.end method

.method public constructor <init>(Lcom/amazonaws/auth/AWSCredentials;Lcom/amazonaws/ClientConfiguration;)V
    .locals 1
    .param p1, "awsCredentials"    # Lcom/amazonaws/auth/AWSCredentials;
    .param p2, "clientConfiguration"    # Lcom/amazonaws/ClientConfiguration;

    .line 184
    new-instance v0, Lcom/amazonaws/internal/StaticCredentialsProvider;

    invoke-direct {v0, p1}, Lcom/amazonaws/internal/StaticCredentialsProvider;-><init>(Lcom/amazonaws/auth/AWSCredentials;)V

    invoke-direct {p0, v0, p2}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;-><init>(Lcom/amazonaws/auth/AWSCredentialsProvider;Lcom/amazonaws/ClientConfiguration;)V

    .line 185
    return-void
.end method

.method public constructor <init>(Lcom/amazonaws/auth/AWSCredentialsProvider;)V
    .locals 1
    .param p1, "awsCredentialsProvider"    # Lcom/amazonaws/auth/AWSCredentialsProvider;

    .line 223
    new-instance v0, Lcom/amazonaws/ClientConfiguration;

    invoke-direct {v0}, Lcom/amazonaws/ClientConfiguration;-><init>()V

    invoke-direct {p0, p1, v0}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;-><init>(Lcom/amazonaws/auth/AWSCredentialsProvider;Lcom/amazonaws/ClientConfiguration;)V

    .line 224
    return-void
.end method

.method public constructor <init>(Lcom/amazonaws/auth/AWSCredentialsProvider;Lcom/amazonaws/ClientConfiguration;)V
    .locals 1
    .param p1, "awsCredentialsProvider"    # Lcom/amazonaws/auth/AWSCredentialsProvider;
    .param p2, "clientConfiguration"    # Lcom/amazonaws/ClientConfiguration;

    .line 266
    new-instance v0, Lcom/amazonaws/http/UrlHttpClient;

    invoke-direct {v0, p2}, Lcom/amazonaws/http/UrlHttpClient;-><init>(Lcom/amazonaws/ClientConfiguration;)V

    invoke-direct {p0, p1, p2, v0}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;-><init>(Lcom/amazonaws/auth/AWSCredentialsProvider;Lcom/amazonaws/ClientConfiguration;Lcom/amazonaws/http/HttpClient;)V

    .line 267
    return-void
.end method

.method public constructor <init>(Lcom/amazonaws/auth/AWSCredentialsProvider;Lcom/amazonaws/ClientConfiguration;Lcom/amazonaws/http/HttpClient;)V
    .locals 1
    .param p1, "awsCredentialsProvider"    # Lcom/amazonaws/auth/AWSCredentialsProvider;
    .param p2, "clientConfiguration"    # Lcom/amazonaws/ClientConfiguration;
    .param p3, "httpClient"    # Lcom/amazonaws/http/HttpClient;

    .line 337
    invoke-static {p2}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->adjustClientConfiguration(Lcom/amazonaws/ClientConfiguration;)Lcom/amazonaws/ClientConfiguration;

    move-result-object v0

    invoke-direct {p0, v0, p3}, Lcom/amazonaws/AmazonWebServiceClient;-><init>(Lcom/amazonaws/ClientConfiguration;Lcom/amazonaws/http/HttpClient;)V

    .line 339
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->awsCredentialsProvider:Lcom/amazonaws/auth/AWSCredentialsProvider;

    .line 341
    invoke-direct {p0}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->init()V

    .line 342
    return-void
.end method

.method public constructor <init>(Lcom/amazonaws/auth/AWSCredentialsProvider;Lcom/amazonaws/ClientConfiguration;Lcom/amazonaws/metrics/RequestMetricCollector;)V
    .locals 1
    .param p1, "awsCredentialsProvider"    # Lcom/amazonaws/auth/AWSCredentialsProvider;
    .param p2, "clientConfiguration"    # Lcom/amazonaws/ClientConfiguration;
    .param p3, "requestMetricCollector"    # Lcom/amazonaws/metrics/RequestMetricCollector;
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 289
    invoke-static {p2}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->adjustClientConfiguration(Lcom/amazonaws/ClientConfiguration;)Lcom/amazonaws/ClientConfiguration;

    move-result-object v0

    invoke-direct {p0, v0, p3}, Lcom/amazonaws/AmazonWebServiceClient;-><init>(Lcom/amazonaws/ClientConfiguration;Lcom/amazonaws/metrics/RequestMetricCollector;)V

    .line 291
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->awsCredentialsProvider:Lcom/amazonaws/auth/AWSCredentialsProvider;

    .line 293
    invoke-direct {p0}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->init()V

    .line 294
    return-void
.end method

.method private static adjustClientConfiguration(Lcom/amazonaws/ClientConfiguration;)Lcom/amazonaws/ClientConfiguration;
    .locals 1
    .param p0, "orig"    # Lcom/amazonaws/ClientConfiguration;

    .line 397
    move-object v0, p0

    .line 399
    .local v0, "config":Lcom/amazonaws/ClientConfiguration;
    return-object v0
.end method

.method private init()V
    .locals 3

    .line 345
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->jsonErrorUnmarshallers:Ljava/util/List;

    .line 346
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->jsonErrorUnmarshallers:Ljava/util/List;

    new-instance v1, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/AliasExistsExceptionUnmarshaller;

    invoke-direct {v1}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/AliasExistsExceptionUnmarshaller;-><init>()V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 347
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->jsonErrorUnmarshallers:Ljava/util/List;

    new-instance v1, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/CodeDeliveryFailureExceptionUnmarshaller;

    invoke-direct {v1}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/CodeDeliveryFailureExceptionUnmarshaller;-><init>()V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 348
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->jsonErrorUnmarshallers:Ljava/util/List;

    new-instance v1, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/CodeMismatchExceptionUnmarshaller;

    invoke-direct {v1}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/CodeMismatchExceptionUnmarshaller;-><init>()V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 349
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->jsonErrorUnmarshallers:Ljava/util/List;

    new-instance v1, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/ConcurrentModificationExceptionUnmarshaller;

    invoke-direct {v1}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/ConcurrentModificationExceptionUnmarshaller;-><init>()V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 350
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->jsonErrorUnmarshallers:Ljava/util/List;

    new-instance v1, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/DuplicateProviderExceptionUnmarshaller;

    invoke-direct {v1}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/DuplicateProviderExceptionUnmarshaller;-><init>()V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 351
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->jsonErrorUnmarshallers:Ljava/util/List;

    new-instance v1, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/EnableSoftwareTokenMFAExceptionUnmarshaller;

    invoke-direct {v1}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/EnableSoftwareTokenMFAExceptionUnmarshaller;-><init>()V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 352
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->jsonErrorUnmarshallers:Ljava/util/List;

    new-instance v1, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/ExpiredCodeExceptionUnmarshaller;

    invoke-direct {v1}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/ExpiredCodeExceptionUnmarshaller;-><init>()V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 353
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->jsonErrorUnmarshallers:Ljava/util/List;

    new-instance v1, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/GroupExistsExceptionUnmarshaller;

    invoke-direct {v1}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/GroupExistsExceptionUnmarshaller;-><init>()V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 354
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->jsonErrorUnmarshallers:Ljava/util/List;

    new-instance v1, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/InternalErrorExceptionUnmarshaller;

    invoke-direct {v1}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/InternalErrorExceptionUnmarshaller;-><init>()V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 355
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->jsonErrorUnmarshallers:Ljava/util/List;

    new-instance v1, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/InvalidEmailRoleAccessPolicyExceptionUnmarshaller;

    invoke-direct {v1}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/InvalidEmailRoleAccessPolicyExceptionUnmarshaller;-><init>()V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 356
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->jsonErrorUnmarshallers:Ljava/util/List;

    new-instance v1, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/InvalidLambdaResponseExceptionUnmarshaller;

    invoke-direct {v1}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/InvalidLambdaResponseExceptionUnmarshaller;-><init>()V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 357
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->jsonErrorUnmarshallers:Ljava/util/List;

    new-instance v1, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/InvalidOAuthFlowExceptionUnmarshaller;

    invoke-direct {v1}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/InvalidOAuthFlowExceptionUnmarshaller;-><init>()V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 358
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->jsonErrorUnmarshallers:Ljava/util/List;

    new-instance v1, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/InvalidParameterExceptionUnmarshaller;

    invoke-direct {v1}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/InvalidParameterExceptionUnmarshaller;-><init>()V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 359
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->jsonErrorUnmarshallers:Ljava/util/List;

    new-instance v1, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/InvalidPasswordExceptionUnmarshaller;

    invoke-direct {v1}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/InvalidPasswordExceptionUnmarshaller;-><init>()V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 360
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->jsonErrorUnmarshallers:Ljava/util/List;

    new-instance v1, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/InvalidSmsRoleAccessPolicyExceptionUnmarshaller;

    invoke-direct {v1}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/InvalidSmsRoleAccessPolicyExceptionUnmarshaller;-><init>()V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 361
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->jsonErrorUnmarshallers:Ljava/util/List;

    new-instance v1, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/InvalidSmsRoleTrustRelationshipExceptionUnmarshaller;

    invoke-direct {v1}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/InvalidSmsRoleTrustRelationshipExceptionUnmarshaller;-><init>()V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 362
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->jsonErrorUnmarshallers:Ljava/util/List;

    new-instance v1, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/InvalidUserPoolConfigurationExceptionUnmarshaller;

    invoke-direct {v1}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/InvalidUserPoolConfigurationExceptionUnmarshaller;-><init>()V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 363
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->jsonErrorUnmarshallers:Ljava/util/List;

    new-instance v1, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/LimitExceededExceptionUnmarshaller;

    invoke-direct {v1}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/LimitExceededExceptionUnmarshaller;-><init>()V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 364
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->jsonErrorUnmarshallers:Ljava/util/List;

    new-instance v1, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/MFAMethodNotFoundExceptionUnmarshaller;

    invoke-direct {v1}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/MFAMethodNotFoundExceptionUnmarshaller;-><init>()V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 365
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->jsonErrorUnmarshallers:Ljava/util/List;

    new-instance v1, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/NotAuthorizedExceptionUnmarshaller;

    invoke-direct {v1}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/NotAuthorizedExceptionUnmarshaller;-><init>()V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 366
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->jsonErrorUnmarshallers:Ljava/util/List;

    new-instance v1, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/PasswordResetRequiredExceptionUnmarshaller;

    invoke-direct {v1}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/PasswordResetRequiredExceptionUnmarshaller;-><init>()V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 367
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->jsonErrorUnmarshallers:Ljava/util/List;

    new-instance v1, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/PreconditionNotMetExceptionUnmarshaller;

    invoke-direct {v1}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/PreconditionNotMetExceptionUnmarshaller;-><init>()V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 368
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->jsonErrorUnmarshallers:Ljava/util/List;

    new-instance v1, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/ResourceNotFoundExceptionUnmarshaller;

    invoke-direct {v1}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/ResourceNotFoundExceptionUnmarshaller;-><init>()V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 369
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->jsonErrorUnmarshallers:Ljava/util/List;

    new-instance v1, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/ScopeDoesNotExistExceptionUnmarshaller;

    invoke-direct {v1}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/ScopeDoesNotExistExceptionUnmarshaller;-><init>()V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 370
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->jsonErrorUnmarshallers:Ljava/util/List;

    new-instance v1, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/SoftwareTokenMFANotFoundExceptionUnmarshaller;

    invoke-direct {v1}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/SoftwareTokenMFANotFoundExceptionUnmarshaller;-><init>()V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 371
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->jsonErrorUnmarshallers:Ljava/util/List;

    new-instance v1, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/TooManyFailedAttemptsExceptionUnmarshaller;

    invoke-direct {v1}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/TooManyFailedAttemptsExceptionUnmarshaller;-><init>()V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 372
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->jsonErrorUnmarshallers:Ljava/util/List;

    new-instance v1, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/TooManyRequestsExceptionUnmarshaller;

    invoke-direct {v1}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/TooManyRequestsExceptionUnmarshaller;-><init>()V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 373
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->jsonErrorUnmarshallers:Ljava/util/List;

    new-instance v1, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/UnexpectedLambdaExceptionUnmarshaller;

    invoke-direct {v1}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/UnexpectedLambdaExceptionUnmarshaller;-><init>()V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 374
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->jsonErrorUnmarshallers:Ljava/util/List;

    new-instance v1, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/UnsupportedIdentityProviderExceptionUnmarshaller;

    invoke-direct {v1}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/UnsupportedIdentityProviderExceptionUnmarshaller;-><init>()V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 375
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->jsonErrorUnmarshallers:Ljava/util/List;

    new-instance v1, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/UnsupportedUserStateExceptionUnmarshaller;

    invoke-direct {v1}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/UnsupportedUserStateExceptionUnmarshaller;-><init>()V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 376
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->jsonErrorUnmarshallers:Ljava/util/List;

    new-instance v1, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/UserImportInProgressExceptionUnmarshaller;

    invoke-direct {v1}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/UserImportInProgressExceptionUnmarshaller;-><init>()V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 377
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->jsonErrorUnmarshallers:Ljava/util/List;

    new-instance v1, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/UserLambdaValidationExceptionUnmarshaller;

    invoke-direct {v1}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/UserLambdaValidationExceptionUnmarshaller;-><init>()V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 378
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->jsonErrorUnmarshallers:Ljava/util/List;

    new-instance v1, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/UserNotConfirmedExceptionUnmarshaller;

    invoke-direct {v1}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/UserNotConfirmedExceptionUnmarshaller;-><init>()V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 379
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->jsonErrorUnmarshallers:Ljava/util/List;

    new-instance v1, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/UserNotFoundExceptionUnmarshaller;

    invoke-direct {v1}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/UserNotFoundExceptionUnmarshaller;-><init>()V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 380
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->jsonErrorUnmarshallers:Ljava/util/List;

    new-instance v1, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/UserPoolAddOnNotEnabledExceptionUnmarshaller;

    invoke-direct {v1}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/UserPoolAddOnNotEnabledExceptionUnmarshaller;-><init>()V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 381
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->jsonErrorUnmarshallers:Ljava/util/List;

    new-instance v1, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/UserPoolTaggingExceptionUnmarshaller;

    invoke-direct {v1}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/UserPoolTaggingExceptionUnmarshaller;-><init>()V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 382
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->jsonErrorUnmarshallers:Ljava/util/List;

    new-instance v1, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/UsernameExistsExceptionUnmarshaller;

    invoke-direct {v1}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/UsernameExistsExceptionUnmarshaller;-><init>()V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 383
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->jsonErrorUnmarshallers:Ljava/util/List;

    new-instance v1, Lcom/amazonaws/transform/JsonErrorUnmarshaller;

    invoke-direct {v1}, Lcom/amazonaws/transform/JsonErrorUnmarshaller;-><init>()V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 386
    const-string v0, "cognito-idp.us-east-1.amazonaws.com"

    invoke-virtual {p0, v0}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->setEndpoint(Ljava/lang/String;)V

    .line 387
    const-string v0, "cognito-idp"

    iput-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endpointPrefix:Ljava/lang/String;

    .line 389
    new-instance v0, Lcom/amazonaws/handlers/HandlerChainFactory;

    invoke-direct {v0}, Lcom/amazonaws/handlers/HandlerChainFactory;-><init>()V

    .line 390
    .local v0, "chainFactory":Lcom/amazonaws/handlers/HandlerChainFactory;
    iget-object v1, p0, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->requestHandler2s:Ljava/util/List;

    const-string v2, "/com/amazonaws/services/cognitoidentityprovider/request.handlers"

    invoke-virtual {v0, v2}, Lcom/amazonaws/handlers/HandlerChainFactory;->newRequestHandlerChain(Ljava/lang/String;)Ljava/util/List;

    move-result-object v2

    invoke-interface {v1, v2}, Ljava/util/List;->addAll(Ljava/util/Collection;)Z

    .line 392
    iget-object v1, p0, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->requestHandler2s:Ljava/util/List;

    const-string v2, "/com/amazonaws/services/cognitoidentityprovider/request.handler2s"

    invoke-virtual {v0, v2}, Lcom/amazonaws/handlers/HandlerChainFactory;->newRequestHandler2Chain(Ljava/lang/String;)Ljava/util/List;

    move-result-object v2

    invoke-interface {v1, v2}, Ljava/util/List;->addAll(Ljava/util/Collection;)Z

    .line 394
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

    .line 6314
    .local p1, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<TY;>;"
    .local p2, "responseHandler":Lcom/amazonaws/http/HttpResponseHandler;, "Lcom/amazonaws/http/HttpResponseHandler<Lcom/amazonaws/AmazonWebServiceResponse<TX;>;>;"
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endpoint:Ljava/net/URI;

    invoke-interface {p1, v0}, Lcom/amazonaws/Request;->setEndpoint(Ljava/net/URI;)V

    .line 6315
    iget v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->timeOffset:I

    invoke-interface {p1, v0}, Lcom/amazonaws/Request;->setTimeOffset(I)V

    .line 6317
    invoke-virtual {p3}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v0

    .line 6319
    .local v0, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v1, Lcom/amazonaws/util/AWSRequestMetrics$Field;->CredentialsRequestTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v0, v1}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 6321
    :try_start_0
    iget-object v1, p0, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->awsCredentialsProvider:Lcom/amazonaws/auth/AWSCredentialsProvider;

    invoke-interface {v1}, Lcom/amazonaws/auth/AWSCredentialsProvider;->getCredentials()Lcom/amazonaws/auth/AWSCredentials;

    move-result-object v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 6323
    .local v1, "credentials":Lcom/amazonaws/auth/AWSCredentials;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->CredentialsRequestTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v0, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 6324
    nop

    .line 6326
    invoke-interface {p1}, Lcom/amazonaws/Request;->getOriginalRequest()Lcom/amazonaws/AmazonWebServiceRequest;

    move-result-object v2

    .line 6327
    .local v2, "originalRequest":Lcom/amazonaws/AmazonWebServiceRequest;
    if-eqz v2, :cond_0

    invoke-virtual {v2}, Lcom/amazonaws/AmazonWebServiceRequest;->getRequestCredentials()Lcom/amazonaws/auth/AWSCredentials;

    move-result-object v3

    if-eqz v3, :cond_0

    .line 6328
    invoke-virtual {v2}, Lcom/amazonaws/AmazonWebServiceRequest;->getRequestCredentials()Lcom/amazonaws/auth/AWSCredentials;

    move-result-object v1

    .line 6331
    :cond_0
    invoke-virtual {p3, v1}, Lcom/amazonaws/http/ExecutionContext;->setCredentials(Lcom/amazonaws/auth/AWSCredentials;)V

    .line 6332
    new-instance v3, Lcom/amazonaws/http/JsonErrorResponseHandler;

    iget-object v4, p0, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->jsonErrorUnmarshallers:Ljava/util/List;

    invoke-direct {v3, v4}, Lcom/amazonaws/http/JsonErrorResponseHandler;-><init>(Ljava/util/List;)V

    .line 6334
    .local v3, "errorResponseHandler":Lcom/amazonaws/http/JsonErrorResponseHandler;
    iget-object v4, p0, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->client:Lcom/amazonaws/http/AmazonHttpClient;

    invoke-virtual {v4, p1, p2, v3, p3}, Lcom/amazonaws/http/AmazonHttpClient;->execute(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v4

    .line 6336
    .local v4, "result":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<TX;>;"
    return-object v4

    .line 6323
    .end local v1    # "credentials":Lcom/amazonaws/auth/AWSCredentials;
    .end local v2    # "originalRequest":Lcom/amazonaws/AmazonWebServiceRequest;
    .end local v3    # "errorResponseHandler":Lcom/amazonaws/http/JsonErrorResponseHandler;
    .end local v4    # "result":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<TX;>;"
    :catchall_0
    move-exception v1

    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->CredentialsRequestTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v0, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 6324
    throw v1
.end method


# virtual methods
.method public addCustomAttributes(Lcom/amazonaws/services/cognitoidentityprovider/model/AddCustomAttributesRequest;)Lcom/amazonaws/services/cognitoidentityprovider/model/AddCustomAttributesResult;
    .locals 9
    .param p1, "addCustomAttributesRequest"    # Lcom/amazonaws/services/cognitoidentityprovider/model/AddCustomAttributesRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 430
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 431
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 432
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 433
    const/4 v2, 0x0

    .line 434
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/AddCustomAttributesRequest;>;"
    const/4 v3, 0x0

    .line 436
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/AddCustomAttributesResult;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 438
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/AddCustomAttributesRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/AddCustomAttributesRequestMarshaller;-><init>()V

    .line 439
    invoke-virtual {v5, p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/AddCustomAttributesRequestMarshaller;->marshall(Lcom/amazonaws/services/cognitoidentityprovider/model/AddCustomAttributesRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 441
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 443
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 444
    nop

    .line 445
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/AddCustomAttributesResultJsonUnmarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/AddCustomAttributesResultJsonUnmarshaller;-><init>()V

    .line 446
    .local v5, "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/AddCustomAttributesResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    new-instance v6, Lcom/amazonaws/http/JsonResponseHandler;

    invoke-direct {v6, v5}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 449
    .local v6, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/AddCustomAttributesResult;>;"
    invoke-direct {p0, v2, v6, v0}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v7

    move-object v3, v7

    .line 451
    invoke-virtual {v3}, Lcom/amazonaws/Response;->getAwsResponse()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/amazonaws/services/cognitoidentityprovider/model/AddCustomAttributesResult;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 453
    sget-object v8, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v8}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 454
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 451
    return-object v7

    .line 443
    .end local v5    # "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/AddCustomAttributesResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    .end local v6    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/AddCustomAttributesResult;>;"
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 444
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/AddCustomAttributesRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/AddCustomAttributesResult;>;"
    .end local p1    # "addCustomAttributesRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/AddCustomAttributesRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 453
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/AddCustomAttributesRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/AddCustomAttributesResult;>;"
    .restart local p1    # "addCustomAttributesRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/AddCustomAttributesRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 454
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 455
    throw v5
.end method

.method public adminAddUserToGroup(Lcom/amazonaws/services/cognitoidentityprovider/model/AdminAddUserToGroupRequest;)V
    .locals 7
    .param p1, "adminAddUserToGroupRequest"    # Lcom/amazonaws/services/cognitoidentityprovider/model/AdminAddUserToGroupRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 483
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 484
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 485
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 486
    const/4 v2, 0x0

    .line 487
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminAddUserToGroupRequest;>;"
    const/4 v3, 0x0

    .line 489
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Ljava/lang/Void;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 491
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/AdminAddUserToGroupRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/AdminAddUserToGroupRequestMarshaller;-><init>()V

    .line 492
    invoke-virtual {v5, p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/AdminAddUserToGroupRequestMarshaller;->marshall(Lcom/amazonaws/services/cognitoidentityprovider/model/AdminAddUserToGroupRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 494
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 496
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 497
    nop

    .line 498
    new-instance v5, Lcom/amazonaws/http/JsonResponseHandler;

    const/4 v6, 0x0

    invoke-direct {v5, v6}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 499
    .local v5, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Ljava/lang/Void;>;"
    invoke-direct {p0, v2, v5, v0}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 501
    nop

    .end local v5    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Ljava/lang/Void;>;"
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 502
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 503
    nop

    .line 504
    return-void

    .line 496
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 497
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminAddUserToGroupRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Ljava/lang/Void;>;"
    .end local p1    # "adminAddUserToGroupRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/AdminAddUserToGroupRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 501
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminAddUserToGroupRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Ljava/lang/Void;>;"
    .restart local p1    # "adminAddUserToGroupRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/AdminAddUserToGroupRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 502
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 503
    throw v5
.end method

.method public adminConfirmSignUp(Lcom/amazonaws/services/cognitoidentityprovider/model/AdminConfirmSignUpRequest;)Lcom/amazonaws/services/cognitoidentityprovider/model/AdminConfirmSignUpResult;
    .locals 9
    .param p1, "adminConfirmSignUpRequest"    # Lcom/amazonaws/services/cognitoidentityprovider/model/AdminConfirmSignUpRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 542
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 543
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 544
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 545
    const/4 v2, 0x0

    .line 546
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminConfirmSignUpRequest;>;"
    const/4 v3, 0x0

    .line 548
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminConfirmSignUpResult;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 550
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/AdminConfirmSignUpRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/AdminConfirmSignUpRequestMarshaller;-><init>()V

    .line 551
    invoke-virtual {v5, p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/AdminConfirmSignUpRequestMarshaller;->marshall(Lcom/amazonaws/services/cognitoidentityprovider/model/AdminConfirmSignUpRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 553
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 555
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 556
    nop

    .line 557
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/AdminConfirmSignUpResultJsonUnmarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/AdminConfirmSignUpResultJsonUnmarshaller;-><init>()V

    .line 558
    .local v5, "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminConfirmSignUpResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    new-instance v6, Lcom/amazonaws/http/JsonResponseHandler;

    invoke-direct {v6, v5}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 561
    .local v6, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminConfirmSignUpResult;>;"
    invoke-direct {p0, v2, v6, v0}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v7

    move-object v3, v7

    .line 563
    invoke-virtual {v3}, Lcom/amazonaws/Response;->getAwsResponse()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminConfirmSignUpResult;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 565
    sget-object v8, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v8}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 566
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 563
    return-object v7

    .line 555
    .end local v5    # "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminConfirmSignUpResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    .end local v6    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminConfirmSignUpResult;>;"
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 556
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminConfirmSignUpRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminConfirmSignUpResult;>;"
    .end local p1    # "adminConfirmSignUpRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/AdminConfirmSignUpRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 565
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminConfirmSignUpRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminConfirmSignUpResult;>;"
    .restart local p1    # "adminConfirmSignUpRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/AdminConfirmSignUpRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 566
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 567
    throw v5
.end method

.method public adminCreateUser(Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;)Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserResult;
    .locals 9
    .param p1, "adminCreateUserRequest"    # Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 629
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 630
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 631
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 632
    const/4 v2, 0x0

    .line 633
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;>;"
    const/4 v3, 0x0

    .line 635
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserResult;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 637
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/AdminCreateUserRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/AdminCreateUserRequestMarshaller;-><init>()V

    invoke-virtual {v5, p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/AdminCreateUserRequestMarshaller;->marshall(Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 639
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 641
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 642
    nop

    .line 643
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/AdminCreateUserResultJsonUnmarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/AdminCreateUserResultJsonUnmarshaller;-><init>()V

    .line 644
    .local v5, "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    new-instance v6, Lcom/amazonaws/http/JsonResponseHandler;

    invoke-direct {v6, v5}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 647
    .local v6, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserResult;>;"
    invoke-direct {p0, v2, v6, v0}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v7

    move-object v3, v7

    .line 649
    invoke-virtual {v3}, Lcom/amazonaws/Response;->getAwsResponse()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserResult;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 651
    sget-object v8, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v8}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 652
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 649
    return-object v7

    .line 641
    .end local v5    # "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    .end local v6    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserResult;>;"
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 642
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserResult;>;"
    .end local p1    # "adminCreateUserRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 651
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserResult;>;"
    .restart local p1    # "adminCreateUserRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 652
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 653
    throw v5
.end method

.method public adminDeleteUser(Lcom/amazonaws/services/cognitoidentityprovider/model/AdminDeleteUserRequest;)V
    .locals 7
    .param p1, "adminDeleteUserRequest"    # Lcom/amazonaws/services/cognitoidentityprovider/model/AdminDeleteUserRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 683
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 684
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 685
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 686
    const/4 v2, 0x0

    .line 687
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminDeleteUserRequest;>;"
    const/4 v3, 0x0

    .line 689
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Ljava/lang/Void;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 691
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/AdminDeleteUserRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/AdminDeleteUserRequestMarshaller;-><init>()V

    invoke-virtual {v5, p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/AdminDeleteUserRequestMarshaller;->marshall(Lcom/amazonaws/services/cognitoidentityprovider/model/AdminDeleteUserRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 693
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 695
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 696
    nop

    .line 697
    new-instance v5, Lcom/amazonaws/http/JsonResponseHandler;

    const/4 v6, 0x0

    invoke-direct {v5, v6}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 698
    .local v5, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Ljava/lang/Void;>;"
    invoke-direct {p0, v2, v5, v0}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 700
    nop

    .end local v5    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Ljava/lang/Void;>;"
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 701
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 702
    nop

    .line 703
    return-void

    .line 695
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 696
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminDeleteUserRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Ljava/lang/Void;>;"
    .end local p1    # "adminDeleteUserRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/AdminDeleteUserRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 700
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminDeleteUserRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Ljava/lang/Void;>;"
    .restart local p1    # "adminDeleteUserRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/AdminDeleteUserRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 701
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 702
    throw v5
.end method

.method public adminDeleteUserAttributes(Lcom/amazonaws/services/cognitoidentityprovider/model/AdminDeleteUserAttributesRequest;)Lcom/amazonaws/services/cognitoidentityprovider/model/AdminDeleteUserAttributesResult;
    .locals 9
    .param p1, "adminDeleteUserAttributesRequest"    # Lcom/amazonaws/services/cognitoidentityprovider/model/AdminDeleteUserAttributesRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 738
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 739
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 740
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 741
    const/4 v2, 0x0

    .line 742
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminDeleteUserAttributesRequest;>;"
    const/4 v3, 0x0

    .line 744
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminDeleteUserAttributesResult;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 746
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/AdminDeleteUserAttributesRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/AdminDeleteUserAttributesRequestMarshaller;-><init>()V

    .line 747
    invoke-virtual {v5, p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/AdminDeleteUserAttributesRequestMarshaller;->marshall(Lcom/amazonaws/services/cognitoidentityprovider/model/AdminDeleteUserAttributesRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 749
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 751
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 752
    nop

    .line 753
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/AdminDeleteUserAttributesResultJsonUnmarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/AdminDeleteUserAttributesResultJsonUnmarshaller;-><init>()V

    .line 754
    .local v5, "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminDeleteUserAttributesResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    new-instance v6, Lcom/amazonaws/http/JsonResponseHandler;

    invoke-direct {v6, v5}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 757
    .local v6, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminDeleteUserAttributesResult;>;"
    invoke-direct {p0, v2, v6, v0}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v7

    move-object v3, v7

    .line 759
    invoke-virtual {v3}, Lcom/amazonaws/Response;->getAwsResponse()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminDeleteUserAttributesResult;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 761
    sget-object v8, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v8}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 762
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 759
    return-object v7

    .line 751
    .end local v5    # "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminDeleteUserAttributesResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    .end local v6    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminDeleteUserAttributesResult;>;"
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 752
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminDeleteUserAttributesRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminDeleteUserAttributesResult;>;"
    .end local p1    # "adminDeleteUserAttributesRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/AdminDeleteUserAttributesRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 761
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminDeleteUserAttributesRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminDeleteUserAttributesResult;>;"
    .restart local p1    # "adminDeleteUserAttributesRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/AdminDeleteUserAttributesRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 762
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 763
    throw v5
.end method

.method public adminDisableProviderForUser(Lcom/amazonaws/services/cognitoidentityprovider/model/AdminDisableProviderForUserRequest;)Lcom/amazonaws/services/cognitoidentityprovider/model/AdminDisableProviderForUserResult;
    .locals 9
    .param p1, "adminDisableProviderForUserRequest"    # Lcom/amazonaws/services/cognitoidentityprovider/model/AdminDisableProviderForUserRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 836
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 837
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 838
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 839
    const/4 v2, 0x0

    .line 840
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminDisableProviderForUserRequest;>;"
    const/4 v3, 0x0

    .line 842
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminDisableProviderForUserResult;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 844
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/AdminDisableProviderForUserRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/AdminDisableProviderForUserRequestMarshaller;-><init>()V

    .line 845
    invoke-virtual {v5, p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/AdminDisableProviderForUserRequestMarshaller;->marshall(Lcom/amazonaws/services/cognitoidentityprovider/model/AdminDisableProviderForUserRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 847
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 849
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 850
    nop

    .line 851
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/AdminDisableProviderForUserResultJsonUnmarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/AdminDisableProviderForUserResultJsonUnmarshaller;-><init>()V

    .line 852
    .local v5, "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminDisableProviderForUserResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    new-instance v6, Lcom/amazonaws/http/JsonResponseHandler;

    invoke-direct {v6, v5}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 855
    .local v6, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminDisableProviderForUserResult;>;"
    invoke-direct {p0, v2, v6, v0}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v7

    move-object v3, v7

    .line 857
    invoke-virtual {v3}, Lcom/amazonaws/Response;->getAwsResponse()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminDisableProviderForUserResult;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 859
    sget-object v8, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v8}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 860
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 857
    return-object v7

    .line 849
    .end local v5    # "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminDisableProviderForUserResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    .end local v6    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminDisableProviderForUserResult;>;"
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 850
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminDisableProviderForUserRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminDisableProviderForUserResult;>;"
    .end local p1    # "adminDisableProviderForUserRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/AdminDisableProviderForUserRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 859
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminDisableProviderForUserRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminDisableProviderForUserResult;>;"
    .restart local p1    # "adminDisableProviderForUserRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/AdminDisableProviderForUserRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 860
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 861
    throw v5
.end method

.method public adminDisableUser(Lcom/amazonaws/services/cognitoidentityprovider/model/AdminDisableUserRequest;)Lcom/amazonaws/services/cognitoidentityprovider/model/AdminDisableUserResult;
    .locals 9
    .param p1, "adminDisableUserRequest"    # Lcom/amazonaws/services/cognitoidentityprovider/model/AdminDisableUserRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 894
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 895
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 896
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 897
    const/4 v2, 0x0

    .line 898
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminDisableUserRequest;>;"
    const/4 v3, 0x0

    .line 900
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminDisableUserResult;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 902
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/AdminDisableUserRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/AdminDisableUserRequestMarshaller;-><init>()V

    invoke-virtual {v5, p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/AdminDisableUserRequestMarshaller;->marshall(Lcom/amazonaws/services/cognitoidentityprovider/model/AdminDisableUserRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 904
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 906
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 907
    nop

    .line 908
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/AdminDisableUserResultJsonUnmarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/AdminDisableUserResultJsonUnmarshaller;-><init>()V

    .line 909
    .local v5, "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminDisableUserResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    new-instance v6, Lcom/amazonaws/http/JsonResponseHandler;

    invoke-direct {v6, v5}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 912
    .local v6, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminDisableUserResult;>;"
    invoke-direct {p0, v2, v6, v0}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v7

    move-object v3, v7

    .line 914
    invoke-virtual {v3}, Lcom/amazonaws/Response;->getAwsResponse()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminDisableUserResult;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 916
    sget-object v8, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v8}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 917
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 914
    return-object v7

    .line 906
    .end local v5    # "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminDisableUserResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    .end local v6    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminDisableUserResult;>;"
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 907
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminDisableUserRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminDisableUserResult;>;"
    .end local p1    # "adminDisableUserRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/AdminDisableUserRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 916
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminDisableUserRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminDisableUserResult;>;"
    .restart local p1    # "adminDisableUserRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/AdminDisableUserRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 917
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 918
    throw v5
.end method

.method public adminEnableUser(Lcom/amazonaws/services/cognitoidentityprovider/model/AdminEnableUserRequest;)Lcom/amazonaws/services/cognitoidentityprovider/model/AdminEnableUserResult;
    .locals 9
    .param p1, "adminEnableUserRequest"    # Lcom/amazonaws/services/cognitoidentityprovider/model/AdminEnableUserRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 951
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 952
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 953
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 954
    const/4 v2, 0x0

    .line 955
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminEnableUserRequest;>;"
    const/4 v3, 0x0

    .line 957
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminEnableUserResult;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 959
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/AdminEnableUserRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/AdminEnableUserRequestMarshaller;-><init>()V

    invoke-virtual {v5, p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/AdminEnableUserRequestMarshaller;->marshall(Lcom/amazonaws/services/cognitoidentityprovider/model/AdminEnableUserRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 961
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 963
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 964
    nop

    .line 965
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/AdminEnableUserResultJsonUnmarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/AdminEnableUserResultJsonUnmarshaller;-><init>()V

    .line 966
    .local v5, "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminEnableUserResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    new-instance v6, Lcom/amazonaws/http/JsonResponseHandler;

    invoke-direct {v6, v5}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 969
    .local v6, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminEnableUserResult;>;"
    invoke-direct {p0, v2, v6, v0}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v7

    move-object v3, v7

    .line 971
    invoke-virtual {v3}, Lcom/amazonaws/Response;->getAwsResponse()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminEnableUserResult;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 973
    sget-object v8, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v8}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 974
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 971
    return-object v7

    .line 963
    .end local v5    # "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminEnableUserResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    .end local v6    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminEnableUserResult;>;"
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 964
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminEnableUserRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminEnableUserResult;>;"
    .end local p1    # "adminEnableUserRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/AdminEnableUserRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 973
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminEnableUserRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminEnableUserResult;>;"
    .restart local p1    # "adminEnableUserRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/AdminEnableUserRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 974
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 975
    throw v5
.end method

.method public adminForgetDevice(Lcom/amazonaws/services/cognitoidentityprovider/model/AdminForgetDeviceRequest;)V
    .locals 7
    .param p1, "adminForgetDeviceRequest"    # Lcom/amazonaws/services/cognitoidentityprovider/model/AdminForgetDeviceRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 1006
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 1007
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 1008
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1009
    const/4 v2, 0x0

    .line 1010
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminForgetDeviceRequest;>;"
    const/4 v3, 0x0

    .line 1012
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Ljava/lang/Void;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 1014
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/AdminForgetDeviceRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/AdminForgetDeviceRequestMarshaller;-><init>()V

    .line 1015
    invoke-virtual {v5, p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/AdminForgetDeviceRequestMarshaller;->marshall(Lcom/amazonaws/services/cognitoidentityprovider/model/AdminForgetDeviceRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 1017
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 1019
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1020
    nop

    .line 1021
    new-instance v5, Lcom/amazonaws/http/JsonResponseHandler;

    const/4 v6, 0x0

    invoke-direct {v5, v6}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 1022
    .local v5, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Ljava/lang/Void;>;"
    invoke-direct {p0, v2, v5, v0}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 1024
    nop

    .end local v5    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Ljava/lang/Void;>;"
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1025
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 1026
    nop

    .line 1027
    return-void

    .line 1019
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1020
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminForgetDeviceRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Ljava/lang/Void;>;"
    .end local p1    # "adminForgetDeviceRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/AdminForgetDeviceRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 1024
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminForgetDeviceRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Ljava/lang/Void;>;"
    .restart local p1    # "adminForgetDeviceRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/AdminForgetDeviceRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1025
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 1026
    throw v5
.end method

.method public adminGetDevice(Lcom/amazonaws/services/cognitoidentityprovider/model/AdminGetDeviceRequest;)Lcom/amazonaws/services/cognitoidentityprovider/model/AdminGetDeviceResult;
    .locals 9
    .param p1, "adminGetDeviceRequest"    # Lcom/amazonaws/services/cognitoidentityprovider/model/AdminGetDeviceRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 1058
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 1059
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 1060
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1061
    const/4 v2, 0x0

    .line 1062
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminGetDeviceRequest;>;"
    const/4 v3, 0x0

    .line 1064
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminGetDeviceResult;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 1066
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/AdminGetDeviceRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/AdminGetDeviceRequestMarshaller;-><init>()V

    invoke-virtual {v5, p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/AdminGetDeviceRequestMarshaller;->marshall(Lcom/amazonaws/services/cognitoidentityprovider/model/AdminGetDeviceRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 1068
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 1070
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1071
    nop

    .line 1072
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/AdminGetDeviceResultJsonUnmarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/AdminGetDeviceResultJsonUnmarshaller;-><init>()V

    .line 1073
    .local v5, "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminGetDeviceResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    new-instance v6, Lcom/amazonaws/http/JsonResponseHandler;

    invoke-direct {v6, v5}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 1076
    .local v6, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminGetDeviceResult;>;"
    invoke-direct {p0, v2, v6, v0}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v7

    move-object v3, v7

    .line 1078
    invoke-virtual {v3}, Lcom/amazonaws/Response;->getAwsResponse()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminGetDeviceResult;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 1080
    sget-object v8, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v8}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1081
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 1078
    return-object v7

    .line 1070
    .end local v5    # "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminGetDeviceResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    .end local v6    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminGetDeviceResult;>;"
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1071
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminGetDeviceRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminGetDeviceResult;>;"
    .end local p1    # "adminGetDeviceRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/AdminGetDeviceRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 1080
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminGetDeviceRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminGetDeviceResult;>;"
    .restart local p1    # "adminGetDeviceRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/AdminGetDeviceRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1081
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 1082
    throw v5
.end method

.method public adminGetUser(Lcom/amazonaws/services/cognitoidentityprovider/model/AdminGetUserRequest;)Lcom/amazonaws/services/cognitoidentityprovider/model/AdminGetUserResult;
    .locals 9
    .param p1, "adminGetUserRequest"    # Lcom/amazonaws/services/cognitoidentityprovider/model/AdminGetUserRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 1116
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 1117
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 1118
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1119
    const/4 v2, 0x0

    .line 1120
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminGetUserRequest;>;"
    const/4 v3, 0x0

    .line 1122
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminGetUserResult;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 1124
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/AdminGetUserRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/AdminGetUserRequestMarshaller;-><init>()V

    invoke-virtual {v5, p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/AdminGetUserRequestMarshaller;->marshall(Lcom/amazonaws/services/cognitoidentityprovider/model/AdminGetUserRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 1126
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 1128
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1129
    nop

    .line 1130
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/AdminGetUserResultJsonUnmarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/AdminGetUserResultJsonUnmarshaller;-><init>()V

    .line 1131
    .local v5, "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminGetUserResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    new-instance v6, Lcom/amazonaws/http/JsonResponseHandler;

    invoke-direct {v6, v5}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 1134
    .local v6, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminGetUserResult;>;"
    invoke-direct {p0, v2, v6, v0}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v7

    move-object v3, v7

    .line 1136
    invoke-virtual {v3}, Lcom/amazonaws/Response;->getAwsResponse()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminGetUserResult;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 1138
    sget-object v8, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v8}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1139
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 1136
    return-object v7

    .line 1128
    .end local v5    # "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminGetUserResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    .end local v6    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminGetUserResult;>;"
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1129
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminGetUserRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminGetUserResult;>;"
    .end local p1    # "adminGetUserRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/AdminGetUserRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 1138
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminGetUserRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminGetUserResult;>;"
    .restart local p1    # "adminGetUserRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/AdminGetUserRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1139
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 1140
    throw v5
.end method

.method public adminInitiateAuth(Lcom/amazonaws/services/cognitoidentityprovider/model/AdminInitiateAuthRequest;)Lcom/amazonaws/services/cognitoidentityprovider/model/AdminInitiateAuthResult;
    .locals 9
    .param p1, "adminInitiateAuthRequest"    # Lcom/amazonaws/services/cognitoidentityprovider/model/AdminInitiateAuthRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 1182
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 1183
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 1184
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1185
    const/4 v2, 0x0

    .line 1186
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminInitiateAuthRequest;>;"
    const/4 v3, 0x0

    .line 1188
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminInitiateAuthResult;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 1190
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/AdminInitiateAuthRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/AdminInitiateAuthRequestMarshaller;-><init>()V

    .line 1191
    invoke-virtual {v5, p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/AdminInitiateAuthRequestMarshaller;->marshall(Lcom/amazonaws/services/cognitoidentityprovider/model/AdminInitiateAuthRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 1193
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 1195
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1196
    nop

    .line 1197
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/AdminInitiateAuthResultJsonUnmarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/AdminInitiateAuthResultJsonUnmarshaller;-><init>()V

    .line 1198
    .local v5, "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminInitiateAuthResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    new-instance v6, Lcom/amazonaws/http/JsonResponseHandler;

    invoke-direct {v6, v5}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 1201
    .local v6, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminInitiateAuthResult;>;"
    invoke-direct {p0, v2, v6, v0}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v7

    move-object v3, v7

    .line 1203
    invoke-virtual {v3}, Lcom/amazonaws/Response;->getAwsResponse()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminInitiateAuthResult;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 1205
    sget-object v8, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v8}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1206
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 1203
    return-object v7

    .line 1195
    .end local v5    # "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminInitiateAuthResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    .end local v6    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminInitiateAuthResult;>;"
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1196
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminInitiateAuthRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminInitiateAuthResult;>;"
    .end local p1    # "adminInitiateAuthRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/AdminInitiateAuthRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 1205
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminInitiateAuthRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminInitiateAuthResult;>;"
    .restart local p1    # "adminInitiateAuthRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/AdminInitiateAuthRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1206
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 1207
    throw v5
.end method

.method public adminLinkProviderForUser(Lcom/amazonaws/services/cognitoidentityprovider/model/AdminLinkProviderForUserRequest;)Lcom/amazonaws/services/cognitoidentityprovider/model/AdminLinkProviderForUserResult;
    .locals 9
    .param p1, "adminLinkProviderForUserRequest"    # Lcom/amazonaws/services/cognitoidentityprovider/model/AdminLinkProviderForUserRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 1266
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 1267
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 1268
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1269
    const/4 v2, 0x0

    .line 1270
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminLinkProviderForUserRequest;>;"
    const/4 v3, 0x0

    .line 1272
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminLinkProviderForUserResult;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 1274
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/AdminLinkProviderForUserRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/AdminLinkProviderForUserRequestMarshaller;-><init>()V

    .line 1275
    invoke-virtual {v5, p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/AdminLinkProviderForUserRequestMarshaller;->marshall(Lcom/amazonaws/services/cognitoidentityprovider/model/AdminLinkProviderForUserRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 1277
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 1279
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1280
    nop

    .line 1281
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/AdminLinkProviderForUserResultJsonUnmarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/AdminLinkProviderForUserResultJsonUnmarshaller;-><init>()V

    .line 1282
    .local v5, "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminLinkProviderForUserResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    new-instance v6, Lcom/amazonaws/http/JsonResponseHandler;

    invoke-direct {v6, v5}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 1285
    .local v6, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminLinkProviderForUserResult;>;"
    invoke-direct {p0, v2, v6, v0}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v7

    move-object v3, v7

    .line 1287
    invoke-virtual {v3}, Lcom/amazonaws/Response;->getAwsResponse()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminLinkProviderForUserResult;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 1289
    sget-object v8, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v8}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1290
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 1287
    return-object v7

    .line 1279
    .end local v5    # "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminLinkProviderForUserResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    .end local v6    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminLinkProviderForUserResult;>;"
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1280
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminLinkProviderForUserRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminLinkProviderForUserResult;>;"
    .end local p1    # "adminLinkProviderForUserRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/AdminLinkProviderForUserRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 1289
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminLinkProviderForUserRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminLinkProviderForUserResult;>;"
    .restart local p1    # "adminLinkProviderForUserRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/AdminLinkProviderForUserRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1290
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 1291
    throw v5
.end method

.method public adminListDevices(Lcom/amazonaws/services/cognitoidentityprovider/model/AdminListDevicesRequest;)Lcom/amazonaws/services/cognitoidentityprovider/model/AdminListDevicesResult;
    .locals 9
    .param p1, "adminListDevicesRequest"    # Lcom/amazonaws/services/cognitoidentityprovider/model/AdminListDevicesRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 1323
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 1324
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 1325
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1326
    const/4 v2, 0x0

    .line 1327
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminListDevicesRequest;>;"
    const/4 v3, 0x0

    .line 1329
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminListDevicesResult;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 1331
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/AdminListDevicesRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/AdminListDevicesRequestMarshaller;-><init>()V

    invoke-virtual {v5, p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/AdminListDevicesRequestMarshaller;->marshall(Lcom/amazonaws/services/cognitoidentityprovider/model/AdminListDevicesRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 1333
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 1335
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1336
    nop

    .line 1337
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/AdminListDevicesResultJsonUnmarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/AdminListDevicesResultJsonUnmarshaller;-><init>()V

    .line 1338
    .local v5, "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminListDevicesResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    new-instance v6, Lcom/amazonaws/http/JsonResponseHandler;

    invoke-direct {v6, v5}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 1341
    .local v6, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminListDevicesResult;>;"
    invoke-direct {p0, v2, v6, v0}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v7

    move-object v3, v7

    .line 1343
    invoke-virtual {v3}, Lcom/amazonaws/Response;->getAwsResponse()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminListDevicesResult;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 1345
    sget-object v8, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v8}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1346
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 1343
    return-object v7

    .line 1335
    .end local v5    # "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminListDevicesResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    .end local v6    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminListDevicesResult;>;"
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1336
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminListDevicesRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminListDevicesResult;>;"
    .end local p1    # "adminListDevicesRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/AdminListDevicesRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 1345
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminListDevicesRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminListDevicesResult;>;"
    .restart local p1    # "adminListDevicesRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/AdminListDevicesRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1346
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 1347
    throw v5
.end method

.method public adminListGroupsForUser(Lcom/amazonaws/services/cognitoidentityprovider/model/AdminListGroupsForUserRequest;)Lcom/amazonaws/services/cognitoidentityprovider/model/AdminListGroupsForUserResult;
    .locals 9
    .param p1, "adminListGroupsForUserRequest"    # Lcom/amazonaws/services/cognitoidentityprovider/model/AdminListGroupsForUserRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 1379
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 1380
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 1381
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1382
    const/4 v2, 0x0

    .line 1383
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminListGroupsForUserRequest;>;"
    const/4 v3, 0x0

    .line 1385
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminListGroupsForUserResult;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 1387
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/AdminListGroupsForUserRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/AdminListGroupsForUserRequestMarshaller;-><init>()V

    .line 1388
    invoke-virtual {v5, p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/AdminListGroupsForUserRequestMarshaller;->marshall(Lcom/amazonaws/services/cognitoidentityprovider/model/AdminListGroupsForUserRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 1390
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 1392
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1393
    nop

    .line 1394
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/AdminListGroupsForUserResultJsonUnmarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/AdminListGroupsForUserResultJsonUnmarshaller;-><init>()V

    .line 1395
    .local v5, "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminListGroupsForUserResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    new-instance v6, Lcom/amazonaws/http/JsonResponseHandler;

    invoke-direct {v6, v5}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 1398
    .local v6, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminListGroupsForUserResult;>;"
    invoke-direct {p0, v2, v6, v0}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v7

    move-object v3, v7

    .line 1400
    invoke-virtual {v3}, Lcom/amazonaws/Response;->getAwsResponse()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminListGroupsForUserResult;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 1402
    sget-object v8, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v8}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1403
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 1400
    return-object v7

    .line 1392
    .end local v5    # "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminListGroupsForUserResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    .end local v6    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminListGroupsForUserResult;>;"
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1393
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminListGroupsForUserRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminListGroupsForUserResult;>;"
    .end local p1    # "adminListGroupsForUserRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/AdminListGroupsForUserRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 1402
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminListGroupsForUserRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminListGroupsForUserResult;>;"
    .restart local p1    # "adminListGroupsForUserRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/AdminListGroupsForUserRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1403
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 1404
    throw v5
.end method

.method public adminListUserAuthEvents(Lcom/amazonaws/services/cognitoidentityprovider/model/AdminListUserAuthEventsRequest;)Lcom/amazonaws/services/cognitoidentityprovider/model/AdminListUserAuthEventsResult;
    .locals 9
    .param p1, "adminListUserAuthEventsRequest"    # Lcom/amazonaws/services/cognitoidentityprovider/model/AdminListUserAuthEventsRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 1435
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 1436
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 1437
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1438
    const/4 v2, 0x0

    .line 1439
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminListUserAuthEventsRequest;>;"
    const/4 v3, 0x0

    .line 1441
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminListUserAuthEventsResult;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 1443
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/AdminListUserAuthEventsRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/AdminListUserAuthEventsRequestMarshaller;-><init>()V

    .line 1444
    invoke-virtual {v5, p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/AdminListUserAuthEventsRequestMarshaller;->marshall(Lcom/amazonaws/services/cognitoidentityprovider/model/AdminListUserAuthEventsRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 1446
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 1448
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1449
    nop

    .line 1450
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/AdminListUserAuthEventsResultJsonUnmarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/AdminListUserAuthEventsResultJsonUnmarshaller;-><init>()V

    .line 1451
    .local v5, "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminListUserAuthEventsResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    new-instance v6, Lcom/amazonaws/http/JsonResponseHandler;

    invoke-direct {v6, v5}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 1454
    .local v6, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminListUserAuthEventsResult;>;"
    invoke-direct {p0, v2, v6, v0}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v7

    move-object v3, v7

    .line 1456
    invoke-virtual {v3}, Lcom/amazonaws/Response;->getAwsResponse()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminListUserAuthEventsResult;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 1458
    sget-object v8, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v8}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1459
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 1456
    return-object v7

    .line 1448
    .end local v5    # "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminListUserAuthEventsResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    .end local v6    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminListUserAuthEventsResult;>;"
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1449
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminListUserAuthEventsRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminListUserAuthEventsResult;>;"
    .end local p1    # "adminListUserAuthEventsRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/AdminListUserAuthEventsRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 1458
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminListUserAuthEventsRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminListUserAuthEventsResult;>;"
    .restart local p1    # "adminListUserAuthEventsRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/AdminListUserAuthEventsRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1459
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 1460
    throw v5
.end method

.method public adminRemoveUserFromGroup(Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRemoveUserFromGroupRequest;)V
    .locals 7
    .param p1, "adminRemoveUserFromGroupRequest"    # Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRemoveUserFromGroupRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 1489
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 1490
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 1491
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1492
    const/4 v2, 0x0

    .line 1493
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRemoveUserFromGroupRequest;>;"
    const/4 v3, 0x0

    .line 1495
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Ljava/lang/Void;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 1497
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/AdminRemoveUserFromGroupRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/AdminRemoveUserFromGroupRequestMarshaller;-><init>()V

    .line 1498
    invoke-virtual {v5, p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/AdminRemoveUserFromGroupRequestMarshaller;->marshall(Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRemoveUserFromGroupRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 1500
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 1502
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1503
    nop

    .line 1504
    new-instance v5, Lcom/amazonaws/http/JsonResponseHandler;

    const/4 v6, 0x0

    invoke-direct {v5, v6}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 1505
    .local v5, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Ljava/lang/Void;>;"
    invoke-direct {p0, v2, v5, v0}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 1507
    nop

    .end local v5    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Ljava/lang/Void;>;"
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1508
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 1509
    nop

    .line 1510
    return-void

    .line 1502
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1503
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRemoveUserFromGroupRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Ljava/lang/Void;>;"
    .end local p1    # "adminRemoveUserFromGroupRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRemoveUserFromGroupRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 1507
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRemoveUserFromGroupRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Ljava/lang/Void;>;"
    .restart local p1    # "adminRemoveUserFromGroupRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRemoveUserFromGroupRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1508
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 1509
    throw v5
.end method

.method public adminResetUserPassword(Lcom/amazonaws/services/cognitoidentityprovider/model/AdminResetUserPasswordRequest;)Lcom/amazonaws/services/cognitoidentityprovider/model/AdminResetUserPasswordResult;
    .locals 9
    .param p1, "adminResetUserPasswordRequest"    # Lcom/amazonaws/services/cognitoidentityprovider/model/AdminResetUserPasswordRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 1563
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 1564
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 1565
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1566
    const/4 v2, 0x0

    .line 1567
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminResetUserPasswordRequest;>;"
    const/4 v3, 0x0

    .line 1569
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminResetUserPasswordResult;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 1571
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/AdminResetUserPasswordRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/AdminResetUserPasswordRequestMarshaller;-><init>()V

    .line 1572
    invoke-virtual {v5, p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/AdminResetUserPasswordRequestMarshaller;->marshall(Lcom/amazonaws/services/cognitoidentityprovider/model/AdminResetUserPasswordRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 1574
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 1576
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1577
    nop

    .line 1578
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/AdminResetUserPasswordResultJsonUnmarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/AdminResetUserPasswordResultJsonUnmarshaller;-><init>()V

    .line 1579
    .local v5, "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminResetUserPasswordResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    new-instance v6, Lcom/amazonaws/http/JsonResponseHandler;

    invoke-direct {v6, v5}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 1582
    .local v6, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminResetUserPasswordResult;>;"
    invoke-direct {p0, v2, v6, v0}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v7

    move-object v3, v7

    .line 1584
    invoke-virtual {v3}, Lcom/amazonaws/Response;->getAwsResponse()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminResetUserPasswordResult;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 1586
    sget-object v8, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v8}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1587
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 1584
    return-object v7

    .line 1576
    .end local v5    # "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminResetUserPasswordResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    .end local v6    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminResetUserPasswordResult;>;"
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1577
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminResetUserPasswordRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminResetUserPasswordResult;>;"
    .end local p1    # "adminResetUserPasswordRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/AdminResetUserPasswordRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 1586
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminResetUserPasswordRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminResetUserPasswordResult;>;"
    .restart local p1    # "adminResetUserPasswordRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/AdminResetUserPasswordRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1587
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 1588
    throw v5
.end method

.method public adminRespondToAuthChallenge(Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeRequest;)Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeResult;
    .locals 9
    .param p1, "adminRespondToAuthChallengeRequest"    # Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 1637
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 1638
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 1639
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1640
    const/4 v2, 0x0

    .line 1641
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeRequest;>;"
    const/4 v3, 0x0

    .line 1643
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeResult;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 1645
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/AdminRespondToAuthChallengeRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/AdminRespondToAuthChallengeRequestMarshaller;-><init>()V

    .line 1646
    invoke-virtual {v5, p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/AdminRespondToAuthChallengeRequestMarshaller;->marshall(Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 1648
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 1650
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1651
    nop

    .line 1652
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/AdminRespondToAuthChallengeResultJsonUnmarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/AdminRespondToAuthChallengeResultJsonUnmarshaller;-><init>()V

    .line 1653
    .local v5, "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    new-instance v6, Lcom/amazonaws/http/JsonResponseHandler;

    invoke-direct {v6, v5}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 1656
    .local v6, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeResult;>;"
    invoke-direct {p0, v2, v6, v0}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v7

    move-object v3, v7

    .line 1658
    invoke-virtual {v3}, Lcom/amazonaws/Response;->getAwsResponse()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeResult;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 1660
    sget-object v8, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v8}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1661
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 1658
    return-object v7

    .line 1650
    .end local v5    # "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    .end local v6    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeResult;>;"
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1651
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeResult;>;"
    .end local p1    # "adminRespondToAuthChallengeRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 1660
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeResult;>;"
    .restart local p1    # "adminRespondToAuthChallengeRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1661
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 1662
    throw v5
.end method

.method public adminSetUserMFAPreference(Lcom/amazonaws/services/cognitoidentityprovider/model/AdminSetUserMFAPreferenceRequest;)Lcom/amazonaws/services/cognitoidentityprovider/model/AdminSetUserMFAPreferenceResult;
    .locals 9
    .param p1, "adminSetUserMFAPreferenceRequest"    # Lcom/amazonaws/services/cognitoidentityprovider/model/AdminSetUserMFAPreferenceRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 1697
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 1698
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 1699
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1700
    const/4 v2, 0x0

    .line 1701
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminSetUserMFAPreferenceRequest;>;"
    const/4 v3, 0x0

    .line 1703
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminSetUserMFAPreferenceResult;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 1705
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/AdminSetUserMFAPreferenceRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/AdminSetUserMFAPreferenceRequestMarshaller;-><init>()V

    .line 1706
    invoke-virtual {v5, p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/AdminSetUserMFAPreferenceRequestMarshaller;->marshall(Lcom/amazonaws/services/cognitoidentityprovider/model/AdminSetUserMFAPreferenceRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 1708
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 1710
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1711
    nop

    .line 1712
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/AdminSetUserMFAPreferenceResultJsonUnmarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/AdminSetUserMFAPreferenceResultJsonUnmarshaller;-><init>()V

    .line 1713
    .local v5, "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminSetUserMFAPreferenceResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    new-instance v6, Lcom/amazonaws/http/JsonResponseHandler;

    invoke-direct {v6, v5}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 1716
    .local v6, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminSetUserMFAPreferenceResult;>;"
    invoke-direct {p0, v2, v6, v0}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v7

    move-object v3, v7

    .line 1718
    invoke-virtual {v3}, Lcom/amazonaws/Response;->getAwsResponse()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminSetUserMFAPreferenceResult;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 1720
    sget-object v8, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v8}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1721
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 1718
    return-object v7

    .line 1710
    .end local v5    # "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminSetUserMFAPreferenceResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    .end local v6    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminSetUserMFAPreferenceResult;>;"
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1711
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminSetUserMFAPreferenceRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminSetUserMFAPreferenceResult;>;"
    .end local p1    # "adminSetUserMFAPreferenceRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/AdminSetUserMFAPreferenceRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 1720
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminSetUserMFAPreferenceRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminSetUserMFAPreferenceResult;>;"
    .restart local p1    # "adminSetUserMFAPreferenceRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/AdminSetUserMFAPreferenceRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1721
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 1722
    throw v5
.end method

.method public adminSetUserPassword(Lcom/amazonaws/services/cognitoidentityprovider/model/AdminSetUserPasswordRequest;)Lcom/amazonaws/services/cognitoidentityprovider/model/AdminSetUserPasswordResult;
    .locals 9
    .param p1, "adminSetUserPasswordRequest"    # Lcom/amazonaws/services/cognitoidentityprovider/model/AdminSetUserPasswordRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 1765
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 1766
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 1767
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1768
    const/4 v2, 0x0

    .line 1769
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminSetUserPasswordRequest;>;"
    const/4 v3, 0x0

    .line 1771
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminSetUserPasswordResult;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 1773
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/AdminSetUserPasswordRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/AdminSetUserPasswordRequestMarshaller;-><init>()V

    .line 1774
    invoke-virtual {v5, p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/AdminSetUserPasswordRequestMarshaller;->marshall(Lcom/amazonaws/services/cognitoidentityprovider/model/AdminSetUserPasswordRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 1776
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 1778
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1779
    nop

    .line 1780
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/AdminSetUserPasswordResultJsonUnmarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/AdminSetUserPasswordResultJsonUnmarshaller;-><init>()V

    .line 1781
    .local v5, "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminSetUserPasswordResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    new-instance v6, Lcom/amazonaws/http/JsonResponseHandler;

    invoke-direct {v6, v5}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 1784
    .local v6, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminSetUserPasswordResult;>;"
    invoke-direct {p0, v2, v6, v0}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v7

    move-object v3, v7

    .line 1786
    invoke-virtual {v3}, Lcom/amazonaws/Response;->getAwsResponse()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminSetUserPasswordResult;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 1788
    sget-object v8, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v8}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1789
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 1786
    return-object v7

    .line 1778
    .end local v5    # "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminSetUserPasswordResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    .end local v6    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminSetUserPasswordResult;>;"
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1779
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminSetUserPasswordRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminSetUserPasswordResult;>;"
    .end local p1    # "adminSetUserPasswordRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/AdminSetUserPasswordRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 1788
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminSetUserPasswordRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminSetUserPasswordResult;>;"
    .restart local p1    # "adminSetUserPasswordRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/AdminSetUserPasswordRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1789
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 1790
    throw v5
.end method

.method public adminSetUserSettings(Lcom/amazonaws/services/cognitoidentityprovider/model/AdminSetUserSettingsRequest;)Lcom/amazonaws/services/cognitoidentityprovider/model/AdminSetUserSettingsResult;
    .locals 9
    .param p1, "adminSetUserSettingsRequest"    # Lcom/amazonaws/services/cognitoidentityprovider/model/AdminSetUserSettingsRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 1825
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 1826
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 1827
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1828
    const/4 v2, 0x0

    .line 1829
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminSetUserSettingsRequest;>;"
    const/4 v3, 0x0

    .line 1831
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminSetUserSettingsResult;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 1833
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/AdminSetUserSettingsRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/AdminSetUserSettingsRequestMarshaller;-><init>()V

    .line 1834
    invoke-virtual {v5, p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/AdminSetUserSettingsRequestMarshaller;->marshall(Lcom/amazonaws/services/cognitoidentityprovider/model/AdminSetUserSettingsRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 1836
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 1838
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1839
    nop

    .line 1840
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/AdminSetUserSettingsResultJsonUnmarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/AdminSetUserSettingsResultJsonUnmarshaller;-><init>()V

    .line 1841
    .local v5, "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminSetUserSettingsResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    new-instance v6, Lcom/amazonaws/http/JsonResponseHandler;

    invoke-direct {v6, v5}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 1844
    .local v6, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminSetUserSettingsResult;>;"
    invoke-direct {p0, v2, v6, v0}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v7

    move-object v3, v7

    .line 1846
    invoke-virtual {v3}, Lcom/amazonaws/Response;->getAwsResponse()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminSetUserSettingsResult;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 1848
    sget-object v8, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v8}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1849
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 1846
    return-object v7

    .line 1838
    .end local v5    # "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminSetUserSettingsResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    .end local v6    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminSetUserSettingsResult;>;"
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1839
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminSetUserSettingsRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminSetUserSettingsResult;>;"
    .end local p1    # "adminSetUserSettingsRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/AdminSetUserSettingsRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 1848
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminSetUserSettingsRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminSetUserSettingsResult;>;"
    .restart local p1    # "adminSetUserSettingsRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/AdminSetUserSettingsRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1849
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 1850
    throw v5
.end method

.method public adminUpdateAuthEventFeedback(Lcom/amazonaws/services/cognitoidentityprovider/model/AdminUpdateAuthEventFeedbackRequest;)Lcom/amazonaws/services/cognitoidentityprovider/model/AdminUpdateAuthEventFeedbackResult;
    .locals 9
    .param p1, "adminUpdateAuthEventFeedbackRequest"    # Lcom/amazonaws/services/cognitoidentityprovider/model/AdminUpdateAuthEventFeedbackRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 1882
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 1883
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 1884
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1885
    const/4 v2, 0x0

    .line 1886
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminUpdateAuthEventFeedbackRequest;>;"
    const/4 v3, 0x0

    .line 1888
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminUpdateAuthEventFeedbackResult;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 1890
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/AdminUpdateAuthEventFeedbackRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/AdminUpdateAuthEventFeedbackRequestMarshaller;-><init>()V

    .line 1891
    invoke-virtual {v5, p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/AdminUpdateAuthEventFeedbackRequestMarshaller;->marshall(Lcom/amazonaws/services/cognitoidentityprovider/model/AdminUpdateAuthEventFeedbackRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 1893
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 1895
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1896
    nop

    .line 1897
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/AdminUpdateAuthEventFeedbackResultJsonUnmarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/AdminUpdateAuthEventFeedbackResultJsonUnmarshaller;-><init>()V

    .line 1898
    .local v5, "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminUpdateAuthEventFeedbackResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    new-instance v6, Lcom/amazonaws/http/JsonResponseHandler;

    invoke-direct {v6, v5}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 1901
    .local v6, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminUpdateAuthEventFeedbackResult;>;"
    invoke-direct {p0, v2, v6, v0}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v7

    move-object v3, v7

    .line 1903
    invoke-virtual {v3}, Lcom/amazonaws/Response;->getAwsResponse()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminUpdateAuthEventFeedbackResult;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 1905
    sget-object v8, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v8}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1906
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 1903
    return-object v7

    .line 1895
    .end local v5    # "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminUpdateAuthEventFeedbackResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    .end local v6    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminUpdateAuthEventFeedbackResult;>;"
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1896
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminUpdateAuthEventFeedbackRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminUpdateAuthEventFeedbackResult;>;"
    .end local p1    # "adminUpdateAuthEventFeedbackRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/AdminUpdateAuthEventFeedbackRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 1905
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminUpdateAuthEventFeedbackRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminUpdateAuthEventFeedbackResult;>;"
    .restart local p1    # "adminUpdateAuthEventFeedbackRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/AdminUpdateAuthEventFeedbackRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1906
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 1907
    throw v5
.end method

.method public adminUpdateDeviceStatus(Lcom/amazonaws/services/cognitoidentityprovider/model/AdminUpdateDeviceStatusRequest;)Lcom/amazonaws/services/cognitoidentityprovider/model/AdminUpdateDeviceStatusResult;
    .locals 9
    .param p1, "adminUpdateDeviceStatusRequest"    # Lcom/amazonaws/services/cognitoidentityprovider/model/AdminUpdateDeviceStatusRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 1942
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 1943
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 1944
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1945
    const/4 v2, 0x0

    .line 1946
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminUpdateDeviceStatusRequest;>;"
    const/4 v3, 0x0

    .line 1948
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminUpdateDeviceStatusResult;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 1950
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/AdminUpdateDeviceStatusRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/AdminUpdateDeviceStatusRequestMarshaller;-><init>()V

    .line 1951
    invoke-virtual {v5, p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/AdminUpdateDeviceStatusRequestMarshaller;->marshall(Lcom/amazonaws/services/cognitoidentityprovider/model/AdminUpdateDeviceStatusRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 1953
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 1955
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1956
    nop

    .line 1957
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/AdminUpdateDeviceStatusResultJsonUnmarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/AdminUpdateDeviceStatusResultJsonUnmarshaller;-><init>()V

    .line 1958
    .local v5, "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminUpdateDeviceStatusResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    new-instance v6, Lcom/amazonaws/http/JsonResponseHandler;

    invoke-direct {v6, v5}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 1961
    .local v6, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminUpdateDeviceStatusResult;>;"
    invoke-direct {p0, v2, v6, v0}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v7

    move-object v3, v7

    .line 1963
    invoke-virtual {v3}, Lcom/amazonaws/Response;->getAwsResponse()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminUpdateDeviceStatusResult;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 1965
    sget-object v8, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v8}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1966
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 1963
    return-object v7

    .line 1955
    .end local v5    # "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminUpdateDeviceStatusResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    .end local v6    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminUpdateDeviceStatusResult;>;"
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1956
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminUpdateDeviceStatusRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminUpdateDeviceStatusResult;>;"
    .end local p1    # "adminUpdateDeviceStatusRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/AdminUpdateDeviceStatusRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 1965
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminUpdateDeviceStatusRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminUpdateDeviceStatusResult;>;"
    .restart local p1    # "adminUpdateDeviceStatusRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/AdminUpdateDeviceStatusRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1966
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 1967
    throw v5
.end method

.method public adminUpdateUserAttributes(Lcom/amazonaws/services/cognitoidentityprovider/model/AdminUpdateUserAttributesRequest;)Lcom/amazonaws/services/cognitoidentityprovider/model/AdminUpdateUserAttributesResult;
    .locals 9
    .param p1, "adminUpdateUserAttributesRequest"    # Lcom/amazonaws/services/cognitoidentityprovider/model/AdminUpdateUserAttributesRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 2018
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 2019
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 2020
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 2021
    const/4 v2, 0x0

    .line 2022
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminUpdateUserAttributesRequest;>;"
    const/4 v3, 0x0

    .line 2024
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminUpdateUserAttributesResult;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 2026
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/AdminUpdateUserAttributesRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/AdminUpdateUserAttributesRequestMarshaller;-><init>()V

    .line 2027
    invoke-virtual {v5, p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/AdminUpdateUserAttributesRequestMarshaller;->marshall(Lcom/amazonaws/services/cognitoidentityprovider/model/AdminUpdateUserAttributesRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 2029
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 2031
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 2032
    nop

    .line 2033
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/AdminUpdateUserAttributesResultJsonUnmarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/AdminUpdateUserAttributesResultJsonUnmarshaller;-><init>()V

    .line 2034
    .local v5, "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminUpdateUserAttributesResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    new-instance v6, Lcom/amazonaws/http/JsonResponseHandler;

    invoke-direct {v6, v5}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 2037
    .local v6, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminUpdateUserAttributesResult;>;"
    invoke-direct {p0, v2, v6, v0}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v7

    move-object v3, v7

    .line 2039
    invoke-virtual {v3}, Lcom/amazonaws/Response;->getAwsResponse()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminUpdateUserAttributesResult;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 2041
    sget-object v8, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v8}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 2042
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 2039
    return-object v7

    .line 2031
    .end local v5    # "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminUpdateUserAttributesResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    .end local v6    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminUpdateUserAttributesResult;>;"
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 2032
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminUpdateUserAttributesRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminUpdateUserAttributesResult;>;"
    .end local p1    # "adminUpdateUserAttributesRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/AdminUpdateUserAttributesRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 2041
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminUpdateUserAttributesRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminUpdateUserAttributesResult;>;"
    .restart local p1    # "adminUpdateUserAttributesRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/AdminUpdateUserAttributesRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 2042
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 2043
    throw v5
.end method

.method public adminUserGlobalSignOut(Lcom/amazonaws/services/cognitoidentityprovider/model/AdminUserGlobalSignOutRequest;)Lcom/amazonaws/services/cognitoidentityprovider/model/AdminUserGlobalSignOutResult;
    .locals 9
    .param p1, "adminUserGlobalSignOutRequest"    # Lcom/amazonaws/services/cognitoidentityprovider/model/AdminUserGlobalSignOutRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 2080
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 2081
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 2082
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 2083
    const/4 v2, 0x0

    .line 2084
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminUserGlobalSignOutRequest;>;"
    const/4 v3, 0x0

    .line 2086
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminUserGlobalSignOutResult;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 2088
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/AdminUserGlobalSignOutRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/AdminUserGlobalSignOutRequestMarshaller;-><init>()V

    .line 2089
    invoke-virtual {v5, p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/AdminUserGlobalSignOutRequestMarshaller;->marshall(Lcom/amazonaws/services/cognitoidentityprovider/model/AdminUserGlobalSignOutRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 2091
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 2093
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 2094
    nop

    .line 2095
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/AdminUserGlobalSignOutResultJsonUnmarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/AdminUserGlobalSignOutResultJsonUnmarshaller;-><init>()V

    .line 2096
    .local v5, "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminUserGlobalSignOutResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    new-instance v6, Lcom/amazonaws/http/JsonResponseHandler;

    invoke-direct {v6, v5}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 2099
    .local v6, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminUserGlobalSignOutResult;>;"
    invoke-direct {p0, v2, v6, v0}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v7

    move-object v3, v7

    .line 2101
    invoke-virtual {v3}, Lcom/amazonaws/Response;->getAwsResponse()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminUserGlobalSignOutResult;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 2103
    sget-object v8, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v8}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 2104
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 2101
    return-object v7

    .line 2093
    .end local v5    # "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminUserGlobalSignOutResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    .end local v6    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminUserGlobalSignOutResult;>;"
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 2094
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminUserGlobalSignOutRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminUserGlobalSignOutResult;>;"
    .end local p1    # "adminUserGlobalSignOutRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/AdminUserGlobalSignOutRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 2103
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminUserGlobalSignOutRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/AdminUserGlobalSignOutResult;>;"
    .restart local p1    # "adminUserGlobalSignOutRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/AdminUserGlobalSignOutRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 2104
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 2105
    throw v5
.end method

.method public associateSoftwareToken(Lcom/amazonaws/services/cognitoidentityprovider/model/AssociateSoftwareTokenRequest;)Lcom/amazonaws/services/cognitoidentityprovider/model/AssociateSoftwareTokenResult;
    .locals 9
    .param p1, "associateSoftwareTokenRequest"    # Lcom/amazonaws/services/cognitoidentityprovider/model/AssociateSoftwareTokenRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 2135
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 2136
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 2137
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 2138
    const/4 v2, 0x0

    .line 2139
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/AssociateSoftwareTokenRequest;>;"
    const/4 v3, 0x0

    .line 2141
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/AssociateSoftwareTokenResult;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 2143
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/AssociateSoftwareTokenRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/AssociateSoftwareTokenRequestMarshaller;-><init>()V

    .line 2144
    invoke-virtual {v5, p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/AssociateSoftwareTokenRequestMarshaller;->marshall(Lcom/amazonaws/services/cognitoidentityprovider/model/AssociateSoftwareTokenRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 2146
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 2148
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 2149
    nop

    .line 2150
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/AssociateSoftwareTokenResultJsonUnmarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/AssociateSoftwareTokenResultJsonUnmarshaller;-><init>()V

    .line 2151
    .local v5, "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/AssociateSoftwareTokenResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    new-instance v6, Lcom/amazonaws/http/JsonResponseHandler;

    invoke-direct {v6, v5}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 2154
    .local v6, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/AssociateSoftwareTokenResult;>;"
    invoke-direct {p0, v2, v6, v0}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v7

    move-object v3, v7

    .line 2156
    invoke-virtual {v3}, Lcom/amazonaws/Response;->getAwsResponse()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/amazonaws/services/cognitoidentityprovider/model/AssociateSoftwareTokenResult;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 2158
    sget-object v8, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v8}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 2159
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 2156
    return-object v7

    .line 2148
    .end local v5    # "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/AssociateSoftwareTokenResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    .end local v6    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/AssociateSoftwareTokenResult;>;"
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 2149
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/AssociateSoftwareTokenRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/AssociateSoftwareTokenResult;>;"
    .end local p1    # "associateSoftwareTokenRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/AssociateSoftwareTokenRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 2158
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/AssociateSoftwareTokenRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/AssociateSoftwareTokenResult;>;"
    .restart local p1    # "associateSoftwareTokenRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/AssociateSoftwareTokenRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 2159
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 2160
    throw v5
.end method

.method public changePassword(Lcom/amazonaws/services/cognitoidentityprovider/model/ChangePasswordRequest;)Lcom/amazonaws/services/cognitoidentityprovider/model/ChangePasswordResult;
    .locals 9
    .param p1, "changePasswordRequest"    # Lcom/amazonaws/services/cognitoidentityprovider/model/ChangePasswordRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 2193
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 2194
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 2195
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 2196
    const/4 v2, 0x0

    .line 2197
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/ChangePasswordRequest;>;"
    const/4 v3, 0x0

    .line 2199
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/ChangePasswordResult;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 2201
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/ChangePasswordRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/ChangePasswordRequestMarshaller;-><init>()V

    invoke-virtual {v5, p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/ChangePasswordRequestMarshaller;->marshall(Lcom/amazonaws/services/cognitoidentityprovider/model/ChangePasswordRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 2203
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 2205
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 2206
    nop

    .line 2207
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/ChangePasswordResultJsonUnmarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/ChangePasswordResultJsonUnmarshaller;-><init>()V

    .line 2208
    .local v5, "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/ChangePasswordResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    new-instance v6, Lcom/amazonaws/http/JsonResponseHandler;

    invoke-direct {v6, v5}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 2211
    .local v6, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/ChangePasswordResult;>;"
    invoke-direct {p0, v2, v6, v0}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v7

    move-object v3, v7

    .line 2213
    invoke-virtual {v3}, Lcom/amazonaws/Response;->getAwsResponse()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/amazonaws/services/cognitoidentityprovider/model/ChangePasswordResult;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 2215
    sget-object v8, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v8}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 2216
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 2213
    return-object v7

    .line 2205
    .end local v5    # "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/ChangePasswordResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    .end local v6    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/ChangePasswordResult;>;"
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 2206
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/ChangePasswordRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/ChangePasswordResult;>;"
    .end local p1    # "changePasswordRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/ChangePasswordRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 2215
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/ChangePasswordRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/ChangePasswordResult;>;"
    .restart local p1    # "changePasswordRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/ChangePasswordRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 2216
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 2217
    throw v5
.end method

.method public confirmDevice(Lcom/amazonaws/services/cognitoidentityprovider/model/ConfirmDeviceRequest;)Lcom/amazonaws/services/cognitoidentityprovider/model/ConfirmDeviceResult;
    .locals 9
    .param p1, "confirmDeviceRequest"    # Lcom/amazonaws/services/cognitoidentityprovider/model/ConfirmDeviceRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 2253
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 2254
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 2255
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 2256
    const/4 v2, 0x0

    .line 2257
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/ConfirmDeviceRequest;>;"
    const/4 v3, 0x0

    .line 2259
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/ConfirmDeviceResult;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 2261
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/ConfirmDeviceRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/ConfirmDeviceRequestMarshaller;-><init>()V

    invoke-virtual {v5, p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/ConfirmDeviceRequestMarshaller;->marshall(Lcom/amazonaws/services/cognitoidentityprovider/model/ConfirmDeviceRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 2263
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 2265
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 2266
    nop

    .line 2267
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/ConfirmDeviceResultJsonUnmarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/ConfirmDeviceResultJsonUnmarshaller;-><init>()V

    .line 2268
    .local v5, "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/ConfirmDeviceResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    new-instance v6, Lcom/amazonaws/http/JsonResponseHandler;

    invoke-direct {v6, v5}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 2271
    .local v6, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/ConfirmDeviceResult;>;"
    invoke-direct {p0, v2, v6, v0}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v7

    move-object v3, v7

    .line 2273
    invoke-virtual {v3}, Lcom/amazonaws/Response;->getAwsResponse()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/amazonaws/services/cognitoidentityprovider/model/ConfirmDeviceResult;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 2275
    sget-object v8, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v8}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 2276
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 2273
    return-object v7

    .line 2265
    .end local v5    # "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/ConfirmDeviceResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    .end local v6    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/ConfirmDeviceResult;>;"
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 2266
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/ConfirmDeviceRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/ConfirmDeviceResult;>;"
    .end local p1    # "confirmDeviceRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/ConfirmDeviceRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 2275
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/ConfirmDeviceRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/ConfirmDeviceResult;>;"
    .restart local p1    # "confirmDeviceRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/ConfirmDeviceRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 2276
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 2277
    throw v5
.end method

.method public confirmForgotPassword(Lcom/amazonaws/services/cognitoidentityprovider/model/ConfirmForgotPasswordRequest;)Lcom/amazonaws/services/cognitoidentityprovider/model/ConfirmForgotPasswordResult;
    .locals 9
    .param p1, "confirmForgotPasswordRequest"    # Lcom/amazonaws/services/cognitoidentityprovider/model/ConfirmForgotPasswordRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 2318
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 2319
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 2320
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 2321
    const/4 v2, 0x0

    .line 2322
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/ConfirmForgotPasswordRequest;>;"
    const/4 v3, 0x0

    .line 2324
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/ConfirmForgotPasswordResult;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 2326
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/ConfirmForgotPasswordRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/ConfirmForgotPasswordRequestMarshaller;-><init>()V

    .line 2327
    invoke-virtual {v5, p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/ConfirmForgotPasswordRequestMarshaller;->marshall(Lcom/amazonaws/services/cognitoidentityprovider/model/ConfirmForgotPasswordRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 2329
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 2331
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 2332
    nop

    .line 2333
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/ConfirmForgotPasswordResultJsonUnmarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/ConfirmForgotPasswordResultJsonUnmarshaller;-><init>()V

    .line 2334
    .local v5, "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/ConfirmForgotPasswordResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    new-instance v6, Lcom/amazonaws/http/JsonResponseHandler;

    invoke-direct {v6, v5}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 2337
    .local v6, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/ConfirmForgotPasswordResult;>;"
    invoke-direct {p0, v2, v6, v0}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v7

    move-object v3, v7

    .line 2339
    invoke-virtual {v3}, Lcom/amazonaws/Response;->getAwsResponse()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/amazonaws/services/cognitoidentityprovider/model/ConfirmForgotPasswordResult;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 2341
    sget-object v8, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v8}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 2342
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 2339
    return-object v7

    .line 2331
    .end local v5    # "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/ConfirmForgotPasswordResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    .end local v6    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/ConfirmForgotPasswordResult;>;"
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 2332
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/ConfirmForgotPasswordRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/ConfirmForgotPasswordResult;>;"
    .end local p1    # "confirmForgotPasswordRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/ConfirmForgotPasswordRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 2341
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/ConfirmForgotPasswordRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/ConfirmForgotPasswordResult;>;"
    .restart local p1    # "confirmForgotPasswordRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/ConfirmForgotPasswordRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 2342
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 2343
    throw v5
.end method

.method public confirmSignUp(Lcom/amazonaws/services/cognitoidentityprovider/model/ConfirmSignUpRequest;)Lcom/amazonaws/services/cognitoidentityprovider/model/ConfirmSignUpResult;
    .locals 9
    .param p1, "confirmSignUpRequest"    # Lcom/amazonaws/services/cognitoidentityprovider/model/ConfirmSignUpRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 2381
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 2382
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 2383
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 2384
    const/4 v2, 0x0

    .line 2385
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/ConfirmSignUpRequest;>;"
    const/4 v3, 0x0

    .line 2387
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/ConfirmSignUpResult;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 2389
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/ConfirmSignUpRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/ConfirmSignUpRequestMarshaller;-><init>()V

    invoke-virtual {v5, p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/ConfirmSignUpRequestMarshaller;->marshall(Lcom/amazonaws/services/cognitoidentityprovider/model/ConfirmSignUpRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 2391
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 2393
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 2394
    nop

    .line 2395
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/ConfirmSignUpResultJsonUnmarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/ConfirmSignUpResultJsonUnmarshaller;-><init>()V

    .line 2396
    .local v5, "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/ConfirmSignUpResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    new-instance v6, Lcom/amazonaws/http/JsonResponseHandler;

    invoke-direct {v6, v5}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 2399
    .local v6, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/ConfirmSignUpResult;>;"
    invoke-direct {p0, v2, v6, v0}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v7

    move-object v3, v7

    .line 2401
    invoke-virtual {v3}, Lcom/amazonaws/Response;->getAwsResponse()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/amazonaws/services/cognitoidentityprovider/model/ConfirmSignUpResult;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 2403
    sget-object v8, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v8}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 2404
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 2401
    return-object v7

    .line 2393
    .end local v5    # "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/ConfirmSignUpResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    .end local v6    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/ConfirmSignUpResult;>;"
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 2394
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/ConfirmSignUpRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/ConfirmSignUpResult;>;"
    .end local p1    # "confirmSignUpRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/ConfirmSignUpRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 2403
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/ConfirmSignUpRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/ConfirmSignUpResult;>;"
    .restart local p1    # "confirmSignUpRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/ConfirmSignUpRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 2404
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 2405
    throw v5
.end method

.method public createGroup(Lcom/amazonaws/services/cognitoidentityprovider/model/CreateGroupRequest;)Lcom/amazonaws/services/cognitoidentityprovider/model/CreateGroupResult;
    .locals 9
    .param p1, "createGroupRequest"    # Lcom/amazonaws/services/cognitoidentityprovider/model/CreateGroupRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 2436
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 2437
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 2438
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 2439
    const/4 v2, 0x0

    .line 2440
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/CreateGroupRequest;>;"
    const/4 v3, 0x0

    .line 2442
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/CreateGroupResult;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 2444
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/CreateGroupRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/CreateGroupRequestMarshaller;-><init>()V

    invoke-virtual {v5, p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/CreateGroupRequestMarshaller;->marshall(Lcom/amazonaws/services/cognitoidentityprovider/model/CreateGroupRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 2446
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 2448
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 2449
    nop

    .line 2450
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/CreateGroupResultJsonUnmarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/CreateGroupResultJsonUnmarshaller;-><init>()V

    .line 2451
    .local v5, "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/CreateGroupResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    new-instance v6, Lcom/amazonaws/http/JsonResponseHandler;

    invoke-direct {v6, v5}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 2454
    .local v6, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/CreateGroupResult;>;"
    invoke-direct {p0, v2, v6, v0}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v7

    move-object v3, v7

    .line 2456
    invoke-virtual {v3}, Lcom/amazonaws/Response;->getAwsResponse()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/amazonaws/services/cognitoidentityprovider/model/CreateGroupResult;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 2458
    sget-object v8, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v8}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 2459
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 2456
    return-object v7

    .line 2448
    .end local v5    # "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/CreateGroupResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    .end local v6    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/CreateGroupResult;>;"
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 2449
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/CreateGroupRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/CreateGroupResult;>;"
    .end local p1    # "createGroupRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/CreateGroupRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 2458
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/CreateGroupRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/CreateGroupResult;>;"
    .restart local p1    # "createGroupRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/CreateGroupRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 2459
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 2460
    throw v5
.end method

.method public createIdentityProvider(Lcom/amazonaws/services/cognitoidentityprovider/model/CreateIdentityProviderRequest;)Lcom/amazonaws/services/cognitoidentityprovider/model/CreateIdentityProviderResult;
    .locals 9
    .param p1, "createIdentityProviderRequest"    # Lcom/amazonaws/services/cognitoidentityprovider/model/CreateIdentityProviderRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 2490
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 2491
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 2492
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 2493
    const/4 v2, 0x0

    .line 2494
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/CreateIdentityProviderRequest;>;"
    const/4 v3, 0x0

    .line 2496
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/CreateIdentityProviderResult;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 2498
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/CreateIdentityProviderRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/CreateIdentityProviderRequestMarshaller;-><init>()V

    .line 2499
    invoke-virtual {v5, p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/CreateIdentityProviderRequestMarshaller;->marshall(Lcom/amazonaws/services/cognitoidentityprovider/model/CreateIdentityProviderRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 2501
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 2503
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 2504
    nop

    .line 2505
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/CreateIdentityProviderResultJsonUnmarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/CreateIdentityProviderResultJsonUnmarshaller;-><init>()V

    .line 2506
    .local v5, "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/CreateIdentityProviderResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    new-instance v6, Lcom/amazonaws/http/JsonResponseHandler;

    invoke-direct {v6, v5}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 2509
    .local v6, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/CreateIdentityProviderResult;>;"
    invoke-direct {p0, v2, v6, v0}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v7

    move-object v3, v7

    .line 2511
    invoke-virtual {v3}, Lcom/amazonaws/Response;->getAwsResponse()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/amazonaws/services/cognitoidentityprovider/model/CreateIdentityProviderResult;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 2513
    sget-object v8, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v8}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 2514
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 2511
    return-object v7

    .line 2503
    .end local v5    # "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/CreateIdentityProviderResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    .end local v6    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/CreateIdentityProviderResult;>;"
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 2504
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/CreateIdentityProviderRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/CreateIdentityProviderResult;>;"
    .end local p1    # "createIdentityProviderRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/CreateIdentityProviderRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 2513
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/CreateIdentityProviderRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/CreateIdentityProviderResult;>;"
    .restart local p1    # "createIdentityProviderRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/CreateIdentityProviderRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 2514
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 2515
    throw v5
.end method

.method public createResourceServer(Lcom/amazonaws/services/cognitoidentityprovider/model/CreateResourceServerRequest;)Lcom/amazonaws/services/cognitoidentityprovider/model/CreateResourceServerResult;
    .locals 9
    .param p1, "createResourceServerRequest"    # Lcom/amazonaws/services/cognitoidentityprovider/model/CreateResourceServerRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 2544
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 2545
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 2546
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 2547
    const/4 v2, 0x0

    .line 2548
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/CreateResourceServerRequest;>;"
    const/4 v3, 0x0

    .line 2550
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/CreateResourceServerResult;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 2552
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/CreateResourceServerRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/CreateResourceServerRequestMarshaller;-><init>()V

    .line 2553
    invoke-virtual {v5, p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/CreateResourceServerRequestMarshaller;->marshall(Lcom/amazonaws/services/cognitoidentityprovider/model/CreateResourceServerRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 2555
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 2557
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 2558
    nop

    .line 2559
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/CreateResourceServerResultJsonUnmarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/CreateResourceServerResultJsonUnmarshaller;-><init>()V

    .line 2560
    .local v5, "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/CreateResourceServerResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    new-instance v6, Lcom/amazonaws/http/JsonResponseHandler;

    invoke-direct {v6, v5}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 2563
    .local v6, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/CreateResourceServerResult;>;"
    invoke-direct {p0, v2, v6, v0}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v7

    move-object v3, v7

    .line 2565
    invoke-virtual {v3}, Lcom/amazonaws/Response;->getAwsResponse()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/amazonaws/services/cognitoidentityprovider/model/CreateResourceServerResult;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 2567
    sget-object v8, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v8}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 2568
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 2565
    return-object v7

    .line 2557
    .end local v5    # "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/CreateResourceServerResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    .end local v6    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/CreateResourceServerResult;>;"
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 2558
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/CreateResourceServerRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/CreateResourceServerResult;>;"
    .end local p1    # "createResourceServerRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/CreateResourceServerRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 2567
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/CreateResourceServerRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/CreateResourceServerResult;>;"
    .restart local p1    # "createResourceServerRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/CreateResourceServerRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 2568
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 2569
    throw v5
.end method

.method public createUserImportJob(Lcom/amazonaws/services/cognitoidentityprovider/model/CreateUserImportJobRequest;)Lcom/amazonaws/services/cognitoidentityprovider/model/CreateUserImportJobResult;
    .locals 9
    .param p1, "createUserImportJobRequest"    # Lcom/amazonaws/services/cognitoidentityprovider/model/CreateUserImportJobRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 2601
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 2602
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 2603
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 2604
    const/4 v2, 0x0

    .line 2605
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/CreateUserImportJobRequest;>;"
    const/4 v3, 0x0

    .line 2607
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/CreateUserImportJobResult;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 2609
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/CreateUserImportJobRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/CreateUserImportJobRequestMarshaller;-><init>()V

    .line 2610
    invoke-virtual {v5, p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/CreateUserImportJobRequestMarshaller;->marshall(Lcom/amazonaws/services/cognitoidentityprovider/model/CreateUserImportJobRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 2612
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 2614
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 2615
    nop

    .line 2616
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/CreateUserImportJobResultJsonUnmarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/CreateUserImportJobResultJsonUnmarshaller;-><init>()V

    .line 2617
    .local v5, "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/CreateUserImportJobResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    new-instance v6, Lcom/amazonaws/http/JsonResponseHandler;

    invoke-direct {v6, v5}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 2620
    .local v6, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/CreateUserImportJobResult;>;"
    invoke-direct {p0, v2, v6, v0}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v7

    move-object v3, v7

    .line 2622
    invoke-virtual {v3}, Lcom/amazonaws/Response;->getAwsResponse()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/amazonaws/services/cognitoidentityprovider/model/CreateUserImportJobResult;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 2624
    sget-object v8, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v8}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 2625
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 2622
    return-object v7

    .line 2614
    .end local v5    # "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/CreateUserImportJobResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    .end local v6    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/CreateUserImportJobResult;>;"
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 2615
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/CreateUserImportJobRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/CreateUserImportJobResult;>;"
    .end local p1    # "createUserImportJobRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/CreateUserImportJobRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 2624
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/CreateUserImportJobRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/CreateUserImportJobResult;>;"
    .restart local p1    # "createUserImportJobRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/CreateUserImportJobRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 2625
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 2626
    throw v5
.end method

.method public createUserPool(Lcom/amazonaws/services/cognitoidentityprovider/model/CreateUserPoolRequest;)Lcom/amazonaws/services/cognitoidentityprovider/model/CreateUserPoolResult;
    .locals 9
    .param p1, "createUserPoolRequest"    # Lcom/amazonaws/services/cognitoidentityprovider/model/CreateUserPoolRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 2659
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 2660
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 2661
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 2662
    const/4 v2, 0x0

    .line 2663
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/CreateUserPoolRequest;>;"
    const/4 v3, 0x0

    .line 2665
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/CreateUserPoolResult;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 2667
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/CreateUserPoolRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/CreateUserPoolRequestMarshaller;-><init>()V

    invoke-virtual {v5, p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/CreateUserPoolRequestMarshaller;->marshall(Lcom/amazonaws/services/cognitoidentityprovider/model/CreateUserPoolRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 2669
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 2671
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 2672
    nop

    .line 2673
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/CreateUserPoolResultJsonUnmarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/CreateUserPoolResultJsonUnmarshaller;-><init>()V

    .line 2674
    .local v5, "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/CreateUserPoolResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    new-instance v6, Lcom/amazonaws/http/JsonResponseHandler;

    invoke-direct {v6, v5}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 2677
    .local v6, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/CreateUserPoolResult;>;"
    invoke-direct {p0, v2, v6, v0}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v7

    move-object v3, v7

    .line 2679
    invoke-virtual {v3}, Lcom/amazonaws/Response;->getAwsResponse()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/amazonaws/services/cognitoidentityprovider/model/CreateUserPoolResult;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 2681
    sget-object v8, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v8}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 2682
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 2679
    return-object v7

    .line 2671
    .end local v5    # "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/CreateUserPoolResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    .end local v6    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/CreateUserPoolResult;>;"
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 2672
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/CreateUserPoolRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/CreateUserPoolResult;>;"
    .end local p1    # "createUserPoolRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/CreateUserPoolRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 2681
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/CreateUserPoolRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/CreateUserPoolResult;>;"
    .restart local p1    # "createUserPoolRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/CreateUserPoolRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 2682
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 2683
    throw v5
.end method

.method public createUserPoolClient(Lcom/amazonaws/services/cognitoidentityprovider/model/CreateUserPoolClientRequest;)Lcom/amazonaws/services/cognitoidentityprovider/model/CreateUserPoolClientResult;
    .locals 9
    .param p1, "createUserPoolClientRequest"    # Lcom/amazonaws/services/cognitoidentityprovider/model/CreateUserPoolClientRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 2716
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 2717
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 2718
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 2719
    const/4 v2, 0x0

    .line 2720
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/CreateUserPoolClientRequest;>;"
    const/4 v3, 0x0

    .line 2722
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/CreateUserPoolClientResult;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 2724
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/CreateUserPoolClientRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/CreateUserPoolClientRequestMarshaller;-><init>()V

    .line 2725
    invoke-virtual {v5, p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/CreateUserPoolClientRequestMarshaller;->marshall(Lcom/amazonaws/services/cognitoidentityprovider/model/CreateUserPoolClientRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 2727
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 2729
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 2730
    nop

    .line 2731
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/CreateUserPoolClientResultJsonUnmarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/CreateUserPoolClientResultJsonUnmarshaller;-><init>()V

    .line 2732
    .local v5, "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/CreateUserPoolClientResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    new-instance v6, Lcom/amazonaws/http/JsonResponseHandler;

    invoke-direct {v6, v5}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 2735
    .local v6, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/CreateUserPoolClientResult;>;"
    invoke-direct {p0, v2, v6, v0}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v7

    move-object v3, v7

    .line 2737
    invoke-virtual {v3}, Lcom/amazonaws/Response;->getAwsResponse()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/amazonaws/services/cognitoidentityprovider/model/CreateUserPoolClientResult;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 2739
    sget-object v8, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v8}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 2740
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 2737
    return-object v7

    .line 2729
    .end local v5    # "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/CreateUserPoolClientResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    .end local v6    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/CreateUserPoolClientResult;>;"
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 2730
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/CreateUserPoolClientRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/CreateUserPoolClientResult;>;"
    .end local p1    # "createUserPoolClientRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/CreateUserPoolClientRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 2739
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/CreateUserPoolClientRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/CreateUserPoolClientResult;>;"
    .restart local p1    # "createUserPoolClientRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/CreateUserPoolClientRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 2740
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 2741
    throw v5
.end method

.method public createUserPoolDomain(Lcom/amazonaws/services/cognitoidentityprovider/model/CreateUserPoolDomainRequest;)Lcom/amazonaws/services/cognitoidentityprovider/model/CreateUserPoolDomainResult;
    .locals 9
    .param p1, "createUserPoolDomainRequest"    # Lcom/amazonaws/services/cognitoidentityprovider/model/CreateUserPoolDomainRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 2769
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 2770
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 2771
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 2772
    const/4 v2, 0x0

    .line 2773
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/CreateUserPoolDomainRequest;>;"
    const/4 v3, 0x0

    .line 2775
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/CreateUserPoolDomainResult;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 2777
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/CreateUserPoolDomainRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/CreateUserPoolDomainRequestMarshaller;-><init>()V

    .line 2778
    invoke-virtual {v5, p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/CreateUserPoolDomainRequestMarshaller;->marshall(Lcom/amazonaws/services/cognitoidentityprovider/model/CreateUserPoolDomainRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 2780
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 2782
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 2783
    nop

    .line 2784
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/CreateUserPoolDomainResultJsonUnmarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/CreateUserPoolDomainResultJsonUnmarshaller;-><init>()V

    .line 2785
    .local v5, "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/CreateUserPoolDomainResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    new-instance v6, Lcom/amazonaws/http/JsonResponseHandler;

    invoke-direct {v6, v5}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 2788
    .local v6, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/CreateUserPoolDomainResult;>;"
    invoke-direct {p0, v2, v6, v0}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v7

    move-object v3, v7

    .line 2790
    invoke-virtual {v3}, Lcom/amazonaws/Response;->getAwsResponse()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/amazonaws/services/cognitoidentityprovider/model/CreateUserPoolDomainResult;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 2792
    sget-object v8, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v8}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 2793
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 2790
    return-object v7

    .line 2782
    .end local v5    # "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/CreateUserPoolDomainResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    .end local v6    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/CreateUserPoolDomainResult;>;"
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 2783
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/CreateUserPoolDomainRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/CreateUserPoolDomainResult;>;"
    .end local p1    # "createUserPoolDomainRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/CreateUserPoolDomainRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 2792
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/CreateUserPoolDomainRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/CreateUserPoolDomainResult;>;"
    .restart local p1    # "createUserPoolDomainRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/CreateUserPoolDomainRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 2793
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 2794
    throw v5
.end method

.method public deleteGroup(Lcom/amazonaws/services/cognitoidentityprovider/model/DeleteGroupRequest;)V
    .locals 7
    .param p1, "deleteGroupRequest"    # Lcom/amazonaws/services/cognitoidentityprovider/model/DeleteGroupRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 2821
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 2822
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 2823
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 2824
    const/4 v2, 0x0

    .line 2825
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/DeleteGroupRequest;>;"
    const/4 v3, 0x0

    .line 2827
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Ljava/lang/Void;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 2829
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/DeleteGroupRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/DeleteGroupRequestMarshaller;-><init>()V

    invoke-virtual {v5, p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/DeleteGroupRequestMarshaller;->marshall(Lcom/amazonaws/services/cognitoidentityprovider/model/DeleteGroupRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 2831
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 2833
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 2834
    nop

    .line 2835
    new-instance v5, Lcom/amazonaws/http/JsonResponseHandler;

    const/4 v6, 0x0

    invoke-direct {v5, v6}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 2836
    .local v5, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Ljava/lang/Void;>;"
    invoke-direct {p0, v2, v5, v0}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 2838
    nop

    .end local v5    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Ljava/lang/Void;>;"
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 2839
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 2840
    nop

    .line 2841
    return-void

    .line 2833
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 2834
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/DeleteGroupRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Ljava/lang/Void;>;"
    .end local p1    # "deleteGroupRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/DeleteGroupRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 2838
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/DeleteGroupRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Ljava/lang/Void;>;"
    .restart local p1    # "deleteGroupRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/DeleteGroupRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 2839
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 2840
    throw v5
.end method

.method public deleteIdentityProvider(Lcom/amazonaws/services/cognitoidentityprovider/model/DeleteIdentityProviderRequest;)V
    .locals 7
    .param p1, "deleteIdentityProviderRequest"    # Lcom/amazonaws/services/cognitoidentityprovider/model/DeleteIdentityProviderRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 2865
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 2866
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 2867
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 2868
    const/4 v2, 0x0

    .line 2869
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/DeleteIdentityProviderRequest;>;"
    const/4 v3, 0x0

    .line 2871
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Ljava/lang/Void;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 2873
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/DeleteIdentityProviderRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/DeleteIdentityProviderRequestMarshaller;-><init>()V

    .line 2874
    invoke-virtual {v5, p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/DeleteIdentityProviderRequestMarshaller;->marshall(Lcom/amazonaws/services/cognitoidentityprovider/model/DeleteIdentityProviderRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 2876
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 2878
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 2879
    nop

    .line 2880
    new-instance v5, Lcom/amazonaws/http/JsonResponseHandler;

    const/4 v6, 0x0

    invoke-direct {v5, v6}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 2881
    .local v5, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Ljava/lang/Void;>;"
    invoke-direct {p0, v2, v5, v0}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 2883
    nop

    .end local v5    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Ljava/lang/Void;>;"
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 2884
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 2885
    nop

    .line 2886
    return-void

    .line 2878
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 2879
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/DeleteIdentityProviderRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Ljava/lang/Void;>;"
    .end local p1    # "deleteIdentityProviderRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/DeleteIdentityProviderRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 2883
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/DeleteIdentityProviderRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Ljava/lang/Void;>;"
    .restart local p1    # "deleteIdentityProviderRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/DeleteIdentityProviderRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 2884
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 2885
    throw v5
.end method

.method public deleteResourceServer(Lcom/amazonaws/services/cognitoidentityprovider/model/DeleteResourceServerRequest;)V
    .locals 7
    .param p1, "deleteResourceServerRequest"    # Lcom/amazonaws/services/cognitoidentityprovider/model/DeleteResourceServerRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 2909
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 2910
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 2911
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 2912
    const/4 v2, 0x0

    .line 2913
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/DeleteResourceServerRequest;>;"
    const/4 v3, 0x0

    .line 2915
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Ljava/lang/Void;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 2917
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/DeleteResourceServerRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/DeleteResourceServerRequestMarshaller;-><init>()V

    .line 2918
    invoke-virtual {v5, p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/DeleteResourceServerRequestMarshaller;->marshall(Lcom/amazonaws/services/cognitoidentityprovider/model/DeleteResourceServerRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 2920
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 2922
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 2923
    nop

    .line 2924
    new-instance v5, Lcom/amazonaws/http/JsonResponseHandler;

    const/4 v6, 0x0

    invoke-direct {v5, v6}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 2925
    .local v5, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Ljava/lang/Void;>;"
    invoke-direct {p0, v2, v5, v0}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 2927
    nop

    .end local v5    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Ljava/lang/Void;>;"
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 2928
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 2929
    nop

    .line 2930
    return-void

    .line 2922
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 2923
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/DeleteResourceServerRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Ljava/lang/Void;>;"
    .end local p1    # "deleteResourceServerRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/DeleteResourceServerRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 2927
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/DeleteResourceServerRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Ljava/lang/Void;>;"
    .restart local p1    # "deleteResourceServerRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/DeleteResourceServerRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 2928
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 2929
    throw v5
.end method

.method public deleteUser(Lcom/amazonaws/services/cognitoidentityprovider/model/DeleteUserRequest;)V
    .locals 7
    .param p1, "deleteUserRequest"    # Lcom/amazonaws/services/cognitoidentityprovider/model/DeleteUserRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 2958
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 2959
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 2960
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 2961
    const/4 v2, 0x0

    .line 2962
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/DeleteUserRequest;>;"
    const/4 v3, 0x0

    .line 2964
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Ljava/lang/Void;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 2966
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/DeleteUserRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/DeleteUserRequestMarshaller;-><init>()V

    invoke-virtual {v5, p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/DeleteUserRequestMarshaller;->marshall(Lcom/amazonaws/services/cognitoidentityprovider/model/DeleteUserRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 2968
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 2970
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 2971
    nop

    .line 2972
    new-instance v5, Lcom/amazonaws/http/JsonResponseHandler;

    const/4 v6, 0x0

    invoke-direct {v5, v6}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 2973
    .local v5, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Ljava/lang/Void;>;"
    invoke-direct {p0, v2, v5, v0}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 2975
    nop

    .end local v5    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Ljava/lang/Void;>;"
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 2976
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 2977
    nop

    .line 2978
    return-void

    .line 2970
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 2971
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/DeleteUserRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Ljava/lang/Void;>;"
    .end local p1    # "deleteUserRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/DeleteUserRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 2975
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/DeleteUserRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Ljava/lang/Void;>;"
    .restart local p1    # "deleteUserRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/DeleteUserRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 2976
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 2977
    throw v5
.end method

.method public deleteUserAttributes(Lcom/amazonaws/services/cognitoidentityprovider/model/DeleteUserAttributesRequest;)Lcom/amazonaws/services/cognitoidentityprovider/model/DeleteUserAttributesResult;
    .locals 9
    .param p1, "deleteUserAttributesRequest"    # Lcom/amazonaws/services/cognitoidentityprovider/model/DeleteUserAttributesRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 3010
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 3011
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 3012
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 3013
    const/4 v2, 0x0

    .line 3014
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/DeleteUserAttributesRequest;>;"
    const/4 v3, 0x0

    .line 3016
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/DeleteUserAttributesResult;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 3018
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/DeleteUserAttributesRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/DeleteUserAttributesRequestMarshaller;-><init>()V

    .line 3019
    invoke-virtual {v5, p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/DeleteUserAttributesRequestMarshaller;->marshall(Lcom/amazonaws/services/cognitoidentityprovider/model/DeleteUserAttributesRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 3021
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 3023
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 3024
    nop

    .line 3025
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/DeleteUserAttributesResultJsonUnmarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/DeleteUserAttributesResultJsonUnmarshaller;-><init>()V

    .line 3026
    .local v5, "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/DeleteUserAttributesResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    new-instance v6, Lcom/amazonaws/http/JsonResponseHandler;

    invoke-direct {v6, v5}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 3029
    .local v6, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/DeleteUserAttributesResult;>;"
    invoke-direct {p0, v2, v6, v0}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v7

    move-object v3, v7

    .line 3031
    invoke-virtual {v3}, Lcom/amazonaws/Response;->getAwsResponse()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/amazonaws/services/cognitoidentityprovider/model/DeleteUserAttributesResult;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 3033
    sget-object v8, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v8}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 3034
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 3031
    return-object v7

    .line 3023
    .end local v5    # "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/DeleteUserAttributesResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    .end local v6    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/DeleteUserAttributesResult;>;"
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 3024
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/DeleteUserAttributesRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/DeleteUserAttributesResult;>;"
    .end local p1    # "deleteUserAttributesRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/DeleteUserAttributesRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 3033
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/DeleteUserAttributesRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/DeleteUserAttributesResult;>;"
    .restart local p1    # "deleteUserAttributesRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/DeleteUserAttributesRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 3034
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 3035
    throw v5
.end method

.method public deleteUserPool(Lcom/amazonaws/services/cognitoidentityprovider/model/DeleteUserPoolRequest;)V
    .locals 7
    .param p1, "deleteUserPoolRequest"    # Lcom/amazonaws/services/cognitoidentityprovider/model/DeleteUserPoolRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 3062
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 3063
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 3064
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 3065
    const/4 v2, 0x0

    .line 3066
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/DeleteUserPoolRequest;>;"
    const/4 v3, 0x0

    .line 3068
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Ljava/lang/Void;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 3070
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/DeleteUserPoolRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/DeleteUserPoolRequestMarshaller;-><init>()V

    invoke-virtual {v5, p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/DeleteUserPoolRequestMarshaller;->marshall(Lcom/amazonaws/services/cognitoidentityprovider/model/DeleteUserPoolRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 3072
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 3074
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 3075
    nop

    .line 3076
    new-instance v5, Lcom/amazonaws/http/JsonResponseHandler;

    const/4 v6, 0x0

    invoke-direct {v5, v6}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 3077
    .local v5, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Ljava/lang/Void;>;"
    invoke-direct {p0, v2, v5, v0}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 3079
    nop

    .end local v5    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Ljava/lang/Void;>;"
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 3080
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 3081
    nop

    .line 3082
    return-void

    .line 3074
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 3075
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/DeleteUserPoolRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Ljava/lang/Void;>;"
    .end local p1    # "deleteUserPoolRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/DeleteUserPoolRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 3079
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/DeleteUserPoolRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Ljava/lang/Void;>;"
    .restart local p1    # "deleteUserPoolRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/DeleteUserPoolRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 3080
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 3081
    throw v5
.end method

.method public deleteUserPoolClient(Lcom/amazonaws/services/cognitoidentityprovider/model/DeleteUserPoolClientRequest;)V
    .locals 7
    .param p1, "deleteUserPoolClientRequest"    # Lcom/amazonaws/services/cognitoidentityprovider/model/DeleteUserPoolClientRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 3107
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 3108
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 3109
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 3110
    const/4 v2, 0x0

    .line 3111
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/DeleteUserPoolClientRequest;>;"
    const/4 v3, 0x0

    .line 3113
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Ljava/lang/Void;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 3115
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/DeleteUserPoolClientRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/DeleteUserPoolClientRequestMarshaller;-><init>()V

    .line 3116
    invoke-virtual {v5, p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/DeleteUserPoolClientRequestMarshaller;->marshall(Lcom/amazonaws/services/cognitoidentityprovider/model/DeleteUserPoolClientRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 3118
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 3120
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 3121
    nop

    .line 3122
    new-instance v5, Lcom/amazonaws/http/JsonResponseHandler;

    const/4 v6, 0x0

    invoke-direct {v5, v6}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 3123
    .local v5, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Ljava/lang/Void;>;"
    invoke-direct {p0, v2, v5, v0}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 3125
    nop

    .end local v5    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Ljava/lang/Void;>;"
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 3126
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 3127
    nop

    .line 3128
    return-void

    .line 3120
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 3121
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/DeleteUserPoolClientRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Ljava/lang/Void;>;"
    .end local p1    # "deleteUserPoolClientRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/DeleteUserPoolClientRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 3125
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/DeleteUserPoolClientRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Ljava/lang/Void;>;"
    .restart local p1    # "deleteUserPoolClientRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/DeleteUserPoolClientRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 3126
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 3127
    throw v5
.end method

.method public deleteUserPoolDomain(Lcom/amazonaws/services/cognitoidentityprovider/model/DeleteUserPoolDomainRequest;)Lcom/amazonaws/services/cognitoidentityprovider/model/DeleteUserPoolDomainResult;
    .locals 9
    .param p1, "deleteUserPoolDomainRequest"    # Lcom/amazonaws/services/cognitoidentityprovider/model/DeleteUserPoolDomainRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 3154
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 3155
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 3156
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 3157
    const/4 v2, 0x0

    .line 3158
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/DeleteUserPoolDomainRequest;>;"
    const/4 v3, 0x0

    .line 3160
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/DeleteUserPoolDomainResult;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 3162
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/DeleteUserPoolDomainRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/DeleteUserPoolDomainRequestMarshaller;-><init>()V

    .line 3163
    invoke-virtual {v5, p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/DeleteUserPoolDomainRequestMarshaller;->marshall(Lcom/amazonaws/services/cognitoidentityprovider/model/DeleteUserPoolDomainRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 3165
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 3167
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 3168
    nop

    .line 3169
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/DeleteUserPoolDomainResultJsonUnmarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/DeleteUserPoolDomainResultJsonUnmarshaller;-><init>()V

    .line 3170
    .local v5, "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/DeleteUserPoolDomainResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    new-instance v6, Lcom/amazonaws/http/JsonResponseHandler;

    invoke-direct {v6, v5}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 3173
    .local v6, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/DeleteUserPoolDomainResult;>;"
    invoke-direct {p0, v2, v6, v0}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v7

    move-object v3, v7

    .line 3175
    invoke-virtual {v3}, Lcom/amazonaws/Response;->getAwsResponse()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/amazonaws/services/cognitoidentityprovider/model/DeleteUserPoolDomainResult;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 3177
    sget-object v8, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v8}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 3178
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 3175
    return-object v7

    .line 3167
    .end local v5    # "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/DeleteUserPoolDomainResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    .end local v6    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/DeleteUserPoolDomainResult;>;"
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 3168
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/DeleteUserPoolDomainRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/DeleteUserPoolDomainResult;>;"
    .end local p1    # "deleteUserPoolDomainRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/DeleteUserPoolDomainRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 3177
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/DeleteUserPoolDomainRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/DeleteUserPoolDomainResult;>;"
    .restart local p1    # "deleteUserPoolDomainRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/DeleteUserPoolDomainRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 3178
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 3179
    throw v5
.end method

.method public describeIdentityProvider(Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeIdentityProviderRequest;)Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeIdentityProviderResult;
    .locals 9
    .param p1, "describeIdentityProviderRequest"    # Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeIdentityProviderRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 3207
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 3208
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 3209
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 3210
    const/4 v2, 0x0

    .line 3211
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeIdentityProviderRequest;>;"
    const/4 v3, 0x0

    .line 3213
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeIdentityProviderResult;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 3215
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/DescribeIdentityProviderRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/DescribeIdentityProviderRequestMarshaller;-><init>()V

    .line 3216
    invoke-virtual {v5, p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/DescribeIdentityProviderRequestMarshaller;->marshall(Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeIdentityProviderRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 3218
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 3220
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 3221
    nop

    .line 3222
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/DescribeIdentityProviderResultJsonUnmarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/DescribeIdentityProviderResultJsonUnmarshaller;-><init>()V

    .line 3223
    .local v5, "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeIdentityProviderResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    new-instance v6, Lcom/amazonaws/http/JsonResponseHandler;

    invoke-direct {v6, v5}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 3226
    .local v6, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeIdentityProviderResult;>;"
    invoke-direct {p0, v2, v6, v0}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v7

    move-object v3, v7

    .line 3228
    invoke-virtual {v3}, Lcom/amazonaws/Response;->getAwsResponse()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeIdentityProviderResult;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 3230
    sget-object v8, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v8}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 3231
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 3228
    return-object v7

    .line 3220
    .end local v5    # "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeIdentityProviderResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    .end local v6    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeIdentityProviderResult;>;"
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 3221
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeIdentityProviderRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeIdentityProviderResult;>;"
    .end local p1    # "describeIdentityProviderRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeIdentityProviderRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 3230
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeIdentityProviderRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeIdentityProviderResult;>;"
    .restart local p1    # "describeIdentityProviderRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeIdentityProviderRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 3231
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 3232
    throw v5
.end method

.method public describeResourceServer(Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeResourceServerRequest;)Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeResourceServerResult;
    .locals 9
    .param p1, "describeResourceServerRequest"    # Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeResourceServerRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 3260
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 3261
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 3262
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 3263
    const/4 v2, 0x0

    .line 3264
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeResourceServerRequest;>;"
    const/4 v3, 0x0

    .line 3266
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeResourceServerResult;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 3268
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/DescribeResourceServerRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/DescribeResourceServerRequestMarshaller;-><init>()V

    .line 3269
    invoke-virtual {v5, p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/DescribeResourceServerRequestMarshaller;->marshall(Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeResourceServerRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 3271
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 3273
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 3274
    nop

    .line 3275
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/DescribeResourceServerResultJsonUnmarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/DescribeResourceServerResultJsonUnmarshaller;-><init>()V

    .line 3276
    .local v5, "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeResourceServerResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    new-instance v6, Lcom/amazonaws/http/JsonResponseHandler;

    invoke-direct {v6, v5}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 3279
    .local v6, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeResourceServerResult;>;"
    invoke-direct {p0, v2, v6, v0}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v7

    move-object v3, v7

    .line 3281
    invoke-virtual {v3}, Lcom/amazonaws/Response;->getAwsResponse()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeResourceServerResult;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 3283
    sget-object v8, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v8}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 3284
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 3281
    return-object v7

    .line 3273
    .end local v5    # "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeResourceServerResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    .end local v6    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeResourceServerResult;>;"
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 3274
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeResourceServerRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeResourceServerResult;>;"
    .end local p1    # "describeResourceServerRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeResourceServerRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 3283
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeResourceServerRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeResourceServerResult;>;"
    .restart local p1    # "describeResourceServerRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeResourceServerRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 3284
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 3285
    throw v5
.end method

.method public describeRiskConfiguration(Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeRiskConfigurationRequest;)Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeRiskConfigurationResult;
    .locals 9
    .param p1, "describeRiskConfigurationRequest"    # Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeRiskConfigurationRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 3314
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 3315
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 3316
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 3317
    const/4 v2, 0x0

    .line 3318
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeRiskConfigurationRequest;>;"
    const/4 v3, 0x0

    .line 3320
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeRiskConfigurationResult;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 3322
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/DescribeRiskConfigurationRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/DescribeRiskConfigurationRequestMarshaller;-><init>()V

    .line 3323
    invoke-virtual {v5, p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/DescribeRiskConfigurationRequestMarshaller;->marshall(Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeRiskConfigurationRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 3325
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 3327
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 3328
    nop

    .line 3329
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/DescribeRiskConfigurationResultJsonUnmarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/DescribeRiskConfigurationResultJsonUnmarshaller;-><init>()V

    .line 3330
    .local v5, "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeRiskConfigurationResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    new-instance v6, Lcom/amazonaws/http/JsonResponseHandler;

    invoke-direct {v6, v5}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 3333
    .local v6, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeRiskConfigurationResult;>;"
    invoke-direct {p0, v2, v6, v0}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v7

    move-object v3, v7

    .line 3335
    invoke-virtual {v3}, Lcom/amazonaws/Response;->getAwsResponse()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeRiskConfigurationResult;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 3337
    sget-object v8, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v8}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 3338
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 3335
    return-object v7

    .line 3327
    .end local v5    # "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeRiskConfigurationResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    .end local v6    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeRiskConfigurationResult;>;"
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 3328
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeRiskConfigurationRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeRiskConfigurationResult;>;"
    .end local p1    # "describeRiskConfigurationRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeRiskConfigurationRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 3337
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeRiskConfigurationRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeRiskConfigurationResult;>;"
    .restart local p1    # "describeRiskConfigurationRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeRiskConfigurationRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 3338
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 3339
    throw v5
.end method

.method public describeUserImportJob(Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeUserImportJobRequest;)Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeUserImportJobResult;
    .locals 9
    .param p1, "describeUserImportJobRequest"    # Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeUserImportJobRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 3369
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 3370
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 3371
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 3372
    const/4 v2, 0x0

    .line 3373
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeUserImportJobRequest;>;"
    const/4 v3, 0x0

    .line 3375
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeUserImportJobResult;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 3377
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/DescribeUserImportJobRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/DescribeUserImportJobRequestMarshaller;-><init>()V

    .line 3378
    invoke-virtual {v5, p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/DescribeUserImportJobRequestMarshaller;->marshall(Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeUserImportJobRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 3380
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 3382
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 3383
    nop

    .line 3384
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/DescribeUserImportJobResultJsonUnmarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/DescribeUserImportJobResultJsonUnmarshaller;-><init>()V

    .line 3385
    .local v5, "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeUserImportJobResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    new-instance v6, Lcom/amazonaws/http/JsonResponseHandler;

    invoke-direct {v6, v5}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 3388
    .local v6, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeUserImportJobResult;>;"
    invoke-direct {p0, v2, v6, v0}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v7

    move-object v3, v7

    .line 3390
    invoke-virtual {v3}, Lcom/amazonaws/Response;->getAwsResponse()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeUserImportJobResult;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 3392
    sget-object v8, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v8}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 3393
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 3390
    return-object v7

    .line 3382
    .end local v5    # "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeUserImportJobResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    .end local v6    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeUserImportJobResult;>;"
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 3383
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeUserImportJobRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeUserImportJobResult;>;"
    .end local p1    # "describeUserImportJobRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeUserImportJobRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 3392
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeUserImportJobRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeUserImportJobResult;>;"
    .restart local p1    # "describeUserImportJobRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeUserImportJobRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 3393
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 3394
    throw v5
.end method

.method public describeUserPool(Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeUserPoolRequest;)Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeUserPoolResult;
    .locals 9
    .param p1, "describeUserPoolRequest"    # Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeUserPoolRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 3424
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 3425
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 3426
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 3427
    const/4 v2, 0x0

    .line 3428
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeUserPoolRequest;>;"
    const/4 v3, 0x0

    .line 3430
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeUserPoolResult;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 3432
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/DescribeUserPoolRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/DescribeUserPoolRequestMarshaller;-><init>()V

    invoke-virtual {v5, p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/DescribeUserPoolRequestMarshaller;->marshall(Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeUserPoolRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 3434
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 3436
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 3437
    nop

    .line 3438
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/DescribeUserPoolResultJsonUnmarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/DescribeUserPoolResultJsonUnmarshaller;-><init>()V

    .line 3439
    .local v5, "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeUserPoolResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    new-instance v6, Lcom/amazonaws/http/JsonResponseHandler;

    invoke-direct {v6, v5}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 3442
    .local v6, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeUserPoolResult;>;"
    invoke-direct {p0, v2, v6, v0}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v7

    move-object v3, v7

    .line 3444
    invoke-virtual {v3}, Lcom/amazonaws/Response;->getAwsResponse()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeUserPoolResult;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 3446
    sget-object v8, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v8}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 3447
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 3444
    return-object v7

    .line 3436
    .end local v5    # "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeUserPoolResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    .end local v6    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeUserPoolResult;>;"
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 3437
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeUserPoolRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeUserPoolResult;>;"
    .end local p1    # "describeUserPoolRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeUserPoolRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 3446
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeUserPoolRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeUserPoolResult;>;"
    .restart local p1    # "describeUserPoolRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeUserPoolRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 3447
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 3448
    throw v5
.end method

.method public describeUserPoolClient(Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeUserPoolClientRequest;)Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeUserPoolClientResult;
    .locals 9
    .param p1, "describeUserPoolClientRequest"    # Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeUserPoolClientRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 3479
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 3480
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 3481
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 3482
    const/4 v2, 0x0

    .line 3483
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeUserPoolClientRequest;>;"
    const/4 v3, 0x0

    .line 3485
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeUserPoolClientResult;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 3487
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/DescribeUserPoolClientRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/DescribeUserPoolClientRequestMarshaller;-><init>()V

    .line 3488
    invoke-virtual {v5, p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/DescribeUserPoolClientRequestMarshaller;->marshall(Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeUserPoolClientRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 3490
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 3492
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 3493
    nop

    .line 3494
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/DescribeUserPoolClientResultJsonUnmarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/DescribeUserPoolClientResultJsonUnmarshaller;-><init>()V

    .line 3495
    .local v5, "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeUserPoolClientResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    new-instance v6, Lcom/amazonaws/http/JsonResponseHandler;

    invoke-direct {v6, v5}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 3498
    .local v6, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeUserPoolClientResult;>;"
    invoke-direct {p0, v2, v6, v0}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v7

    move-object v3, v7

    .line 3500
    invoke-virtual {v3}, Lcom/amazonaws/Response;->getAwsResponse()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeUserPoolClientResult;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 3502
    sget-object v8, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v8}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 3503
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 3500
    return-object v7

    .line 3492
    .end local v5    # "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeUserPoolClientResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    .end local v6    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeUserPoolClientResult;>;"
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 3493
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeUserPoolClientRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeUserPoolClientResult;>;"
    .end local p1    # "describeUserPoolClientRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeUserPoolClientRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 3502
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeUserPoolClientRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeUserPoolClientResult;>;"
    .restart local p1    # "describeUserPoolClientRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeUserPoolClientRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 3503
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 3504
    throw v5
.end method

.method public describeUserPoolDomain(Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeUserPoolDomainRequest;)Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeUserPoolDomainResult;
    .locals 9
    .param p1, "describeUserPoolDomainRequest"    # Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeUserPoolDomainRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 3531
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 3532
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 3533
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 3534
    const/4 v2, 0x0

    .line 3535
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeUserPoolDomainRequest;>;"
    const/4 v3, 0x0

    .line 3537
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeUserPoolDomainResult;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 3539
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/DescribeUserPoolDomainRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/DescribeUserPoolDomainRequestMarshaller;-><init>()V

    .line 3540
    invoke-virtual {v5, p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/DescribeUserPoolDomainRequestMarshaller;->marshall(Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeUserPoolDomainRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 3542
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 3544
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 3545
    nop

    .line 3546
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/DescribeUserPoolDomainResultJsonUnmarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/DescribeUserPoolDomainResultJsonUnmarshaller;-><init>()V

    .line 3547
    .local v5, "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeUserPoolDomainResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    new-instance v6, Lcom/amazonaws/http/JsonResponseHandler;

    invoke-direct {v6, v5}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 3550
    .local v6, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeUserPoolDomainResult;>;"
    invoke-direct {p0, v2, v6, v0}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v7

    move-object v3, v7

    .line 3552
    invoke-virtual {v3}, Lcom/amazonaws/Response;->getAwsResponse()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeUserPoolDomainResult;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 3554
    sget-object v8, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v8}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 3555
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 3552
    return-object v7

    .line 3544
    .end local v5    # "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeUserPoolDomainResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    .end local v6    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeUserPoolDomainResult;>;"
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 3545
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeUserPoolDomainRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeUserPoolDomainResult;>;"
    .end local p1    # "describeUserPoolDomainRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeUserPoolDomainRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 3554
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeUserPoolDomainRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeUserPoolDomainResult;>;"
    .restart local p1    # "describeUserPoolDomainRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeUserPoolDomainRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 3555
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 3556
    throw v5
.end method

.method public forgetDevice(Lcom/amazonaws/services/cognitoidentityprovider/model/ForgetDeviceRequest;)V
    .locals 7
    .param p1, "forgetDeviceRequest"    # Lcom/amazonaws/services/cognitoidentityprovider/model/ForgetDeviceRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 3586
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 3587
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 3588
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 3589
    const/4 v2, 0x0

    .line 3590
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/ForgetDeviceRequest;>;"
    const/4 v3, 0x0

    .line 3592
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Ljava/lang/Void;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 3594
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/ForgetDeviceRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/ForgetDeviceRequestMarshaller;-><init>()V

    invoke-virtual {v5, p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/ForgetDeviceRequestMarshaller;->marshall(Lcom/amazonaws/services/cognitoidentityprovider/model/ForgetDeviceRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 3596
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 3598
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 3599
    nop

    .line 3600
    new-instance v5, Lcom/amazonaws/http/JsonResponseHandler;

    const/4 v6, 0x0

    invoke-direct {v5, v6}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 3601
    .local v5, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Ljava/lang/Void;>;"
    invoke-direct {p0, v2, v5, v0}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 3603
    nop

    .end local v5    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Ljava/lang/Void;>;"
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 3604
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 3605
    nop

    .line 3606
    return-void

    .line 3598
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 3599
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/ForgetDeviceRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Ljava/lang/Void;>;"
    .end local p1    # "forgetDeviceRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/ForgetDeviceRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 3603
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/ForgetDeviceRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Ljava/lang/Void;>;"
    .restart local p1    # "forgetDeviceRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/ForgetDeviceRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 3604
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 3605
    throw v5
.end method

.method public forgotPassword(Lcom/amazonaws/services/cognitoidentityprovider/model/ForgotPasswordRequest;)Lcom/amazonaws/services/cognitoidentityprovider/model/ForgotPasswordResult;
    .locals 9
    .param p1, "forgotPasswordRequest"    # Lcom/amazonaws/services/cognitoidentityprovider/model/ForgotPasswordRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 3654
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 3655
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 3656
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 3657
    const/4 v2, 0x0

    .line 3658
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/ForgotPasswordRequest;>;"
    const/4 v3, 0x0

    .line 3660
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/ForgotPasswordResult;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 3662
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/ForgotPasswordRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/ForgotPasswordRequestMarshaller;-><init>()V

    invoke-virtual {v5, p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/ForgotPasswordRequestMarshaller;->marshall(Lcom/amazonaws/services/cognitoidentityprovider/model/ForgotPasswordRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 3664
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 3666
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 3667
    nop

    .line 3668
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/ForgotPasswordResultJsonUnmarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/ForgotPasswordResultJsonUnmarshaller;-><init>()V

    .line 3669
    .local v5, "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/ForgotPasswordResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    new-instance v6, Lcom/amazonaws/http/JsonResponseHandler;

    invoke-direct {v6, v5}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 3672
    .local v6, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/ForgotPasswordResult;>;"
    invoke-direct {p0, v2, v6, v0}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v7

    move-object v3, v7

    .line 3674
    invoke-virtual {v3}, Lcom/amazonaws/Response;->getAwsResponse()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/amazonaws/services/cognitoidentityprovider/model/ForgotPasswordResult;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 3676
    sget-object v8, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v8}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 3677
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 3674
    return-object v7

    .line 3666
    .end local v5    # "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/ForgotPasswordResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    .end local v6    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/ForgotPasswordResult;>;"
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 3667
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/ForgotPasswordRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/ForgotPasswordResult;>;"
    .end local p1    # "forgotPasswordRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/ForgotPasswordRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 3676
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/ForgotPasswordRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/ForgotPasswordResult;>;"
    .restart local p1    # "forgotPasswordRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/ForgotPasswordRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 3677
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 3678
    throw v5
.end method

.method public getCSVHeader(Lcom/amazonaws/services/cognitoidentityprovider/model/GetCSVHeaderRequest;)Lcom/amazonaws/services/cognitoidentityprovider/model/GetCSVHeaderResult;
    .locals 9
    .param p1, "getCSVHeaderRequest"    # Lcom/amazonaws/services/cognitoidentityprovider/model/GetCSVHeaderRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 3708
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 3709
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 3710
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 3711
    const/4 v2, 0x0

    .line 3712
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/GetCSVHeaderRequest;>;"
    const/4 v3, 0x0

    .line 3714
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/GetCSVHeaderResult;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 3716
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/GetCSVHeaderRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/GetCSVHeaderRequestMarshaller;-><init>()V

    invoke-virtual {v5, p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/GetCSVHeaderRequestMarshaller;->marshall(Lcom/amazonaws/services/cognitoidentityprovider/model/GetCSVHeaderRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 3718
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 3720
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 3721
    nop

    .line 3722
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/GetCSVHeaderResultJsonUnmarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/GetCSVHeaderResultJsonUnmarshaller;-><init>()V

    .line 3723
    .local v5, "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/GetCSVHeaderResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    new-instance v6, Lcom/amazonaws/http/JsonResponseHandler;

    invoke-direct {v6, v5}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 3726
    .local v6, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/GetCSVHeaderResult;>;"
    invoke-direct {p0, v2, v6, v0}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v7

    move-object v3, v7

    .line 3728
    invoke-virtual {v3}, Lcom/amazonaws/Response;->getAwsResponse()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/amazonaws/services/cognitoidentityprovider/model/GetCSVHeaderResult;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 3730
    sget-object v8, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v8}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 3731
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 3728
    return-object v7

    .line 3720
    .end local v5    # "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/GetCSVHeaderResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    .end local v6    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/GetCSVHeaderResult;>;"
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 3721
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/GetCSVHeaderRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/GetCSVHeaderResult;>;"
    .end local p1    # "getCSVHeaderRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/GetCSVHeaderRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 3730
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/GetCSVHeaderRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/GetCSVHeaderResult;>;"
    .restart local p1    # "getCSVHeaderRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/GetCSVHeaderRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 3731
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 3732
    throw v5
.end method

.method public getCachedResponseMetadata(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/ResponseMetadata;
    .locals 1
    .param p1, "request"    # Lcom/amazonaws/AmazonWebServiceRequest;
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 6308
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->client:Lcom/amazonaws/http/AmazonHttpClient;

    invoke-virtual {v0, p1}, Lcom/amazonaws/http/AmazonHttpClient;->getResponseMetadataForRequest(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/ResponseMetadata;

    move-result-object v0

    return-object v0
.end method

.method public getDevice(Lcom/amazonaws/services/cognitoidentityprovider/model/GetDeviceRequest;)Lcom/amazonaws/services/cognitoidentityprovider/model/GetDeviceResult;
    .locals 9
    .param p1, "getDeviceRequest"    # Lcom/amazonaws/services/cognitoidentityprovider/model/GetDeviceRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 3764
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 3765
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 3766
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 3767
    const/4 v2, 0x0

    .line 3768
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/GetDeviceRequest;>;"
    const/4 v3, 0x0

    .line 3770
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/GetDeviceResult;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 3772
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/GetDeviceRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/GetDeviceRequestMarshaller;-><init>()V

    invoke-virtual {v5, p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/GetDeviceRequestMarshaller;->marshall(Lcom/amazonaws/services/cognitoidentityprovider/model/GetDeviceRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 3774
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 3776
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 3777
    nop

    .line 3778
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/GetDeviceResultJsonUnmarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/GetDeviceResultJsonUnmarshaller;-><init>()V

    .line 3779
    .local v5, "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/GetDeviceResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    new-instance v6, Lcom/amazonaws/http/JsonResponseHandler;

    invoke-direct {v6, v5}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 3782
    .local v6, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/GetDeviceResult;>;"
    invoke-direct {p0, v2, v6, v0}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v7

    move-object v3, v7

    .line 3784
    invoke-virtual {v3}, Lcom/amazonaws/Response;->getAwsResponse()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/amazonaws/services/cognitoidentityprovider/model/GetDeviceResult;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 3786
    sget-object v8, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v8}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 3787
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 3784
    return-object v7

    .line 3776
    .end local v5    # "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/GetDeviceResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    .end local v6    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/GetDeviceResult;>;"
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 3777
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/GetDeviceRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/GetDeviceResult;>;"
    .end local p1    # "getDeviceRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/GetDeviceRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 3786
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/GetDeviceRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/GetDeviceResult;>;"
    .restart local p1    # "getDeviceRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/GetDeviceRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 3787
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 3788
    throw v5
.end method

.method public getGroup(Lcom/amazonaws/services/cognitoidentityprovider/model/GetGroupRequest;)Lcom/amazonaws/services/cognitoidentityprovider/model/GetGroupResult;
    .locals 9
    .param p1, "getGroupRequest"    # Lcom/amazonaws/services/cognitoidentityprovider/model/GetGroupRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 3817
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 3818
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 3819
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 3820
    const/4 v2, 0x0

    .line 3821
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/GetGroupRequest;>;"
    const/4 v3, 0x0

    .line 3823
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/GetGroupResult;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 3825
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/GetGroupRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/GetGroupRequestMarshaller;-><init>()V

    invoke-virtual {v5, p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/GetGroupRequestMarshaller;->marshall(Lcom/amazonaws/services/cognitoidentityprovider/model/GetGroupRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 3827
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 3829
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 3830
    nop

    .line 3831
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/GetGroupResultJsonUnmarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/GetGroupResultJsonUnmarshaller;-><init>()V

    .line 3832
    .local v5, "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/GetGroupResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    new-instance v6, Lcom/amazonaws/http/JsonResponseHandler;

    invoke-direct {v6, v5}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 3835
    .local v6, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/GetGroupResult;>;"
    invoke-direct {p0, v2, v6, v0}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v7

    move-object v3, v7

    .line 3837
    invoke-virtual {v3}, Lcom/amazonaws/Response;->getAwsResponse()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/amazonaws/services/cognitoidentityprovider/model/GetGroupResult;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 3839
    sget-object v8, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v8}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 3840
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 3837
    return-object v7

    .line 3829
    .end local v5    # "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/GetGroupResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    .end local v6    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/GetGroupResult;>;"
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 3830
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/GetGroupRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/GetGroupResult;>;"
    .end local p1    # "getGroupRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/GetGroupRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 3839
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/GetGroupRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/GetGroupResult;>;"
    .restart local p1    # "getGroupRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/GetGroupRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 3840
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 3841
    throw v5
.end method

.method public getIdentityProviderByIdentifier(Lcom/amazonaws/services/cognitoidentityprovider/model/GetIdentityProviderByIdentifierRequest;)Lcom/amazonaws/services/cognitoidentityprovider/model/GetIdentityProviderByIdentifierResult;
    .locals 9
    .param p1, "getIdentityProviderByIdentifierRequest"    # Lcom/amazonaws/services/cognitoidentityprovider/model/GetIdentityProviderByIdentifierRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 3869
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

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
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/GetIdentityProviderByIdentifierRequest;>;"
    const/4 v3, 0x0

    .line 3875
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/GetIdentityProviderByIdentifierResult;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 3877
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/GetIdentityProviderByIdentifierRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/GetIdentityProviderByIdentifierRequestMarshaller;-><init>()V

    .line 3878
    invoke-virtual {v5, p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/GetIdentityProviderByIdentifierRequestMarshaller;->marshall(Lcom/amazonaws/services/cognitoidentityprovider/model/GetIdentityProviderByIdentifierRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 3880
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 3882
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 3883
    nop

    .line 3884
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/GetIdentityProviderByIdentifierResultJsonUnmarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/GetIdentityProviderByIdentifierResultJsonUnmarshaller;-><init>()V

    .line 3885
    .local v5, "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/GetIdentityProviderByIdentifierResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    new-instance v6, Lcom/amazonaws/http/JsonResponseHandler;

    invoke-direct {v6, v5}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 3888
    .local v6, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/GetIdentityProviderByIdentifierResult;>;"
    invoke-direct {p0, v2, v6, v0}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v7

    move-object v3, v7

    .line 3890
    invoke-virtual {v3}, Lcom/amazonaws/Response;->getAwsResponse()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/amazonaws/services/cognitoidentityprovider/model/GetIdentityProviderByIdentifierResult;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 3892
    sget-object v8, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v8}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 3893
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 3890
    return-object v7

    .line 3882
    .end local v5    # "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/GetIdentityProviderByIdentifierResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    .end local v6    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/GetIdentityProviderByIdentifierResult;>;"
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 3883
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/GetIdentityProviderByIdentifierRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/GetIdentityProviderByIdentifierResult;>;"
    .end local p1    # "getIdentityProviderByIdentifierRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/GetIdentityProviderByIdentifierRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 3892
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/GetIdentityProviderByIdentifierRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/GetIdentityProviderByIdentifierResult;>;"
    .restart local p1    # "getIdentityProviderByIdentifierRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/GetIdentityProviderByIdentifierRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 3893
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 3894
    throw v5
.end method

.method public getSigningCertificate(Lcom/amazonaws/services/cognitoidentityprovider/model/GetSigningCertificateRequest;)Lcom/amazonaws/services/cognitoidentityprovider/model/GetSigningCertificateResult;
    .locals 9
    .param p1, "getSigningCertificateRequest"    # Lcom/amazonaws/services/cognitoidentityprovider/model/GetSigningCertificateRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 3922
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 3923
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 3924
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 3925
    const/4 v2, 0x0

    .line 3926
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/GetSigningCertificateRequest;>;"
    const/4 v3, 0x0

    .line 3928
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/GetSigningCertificateResult;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 3930
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/GetSigningCertificateRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/GetSigningCertificateRequestMarshaller;-><init>()V

    .line 3931
    invoke-virtual {v5, p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/GetSigningCertificateRequestMarshaller;->marshall(Lcom/amazonaws/services/cognitoidentityprovider/model/GetSigningCertificateRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 3933
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 3935
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 3936
    nop

    .line 3937
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/GetSigningCertificateResultJsonUnmarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/GetSigningCertificateResultJsonUnmarshaller;-><init>()V

    .line 3938
    .local v5, "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/GetSigningCertificateResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    new-instance v6, Lcom/amazonaws/http/JsonResponseHandler;

    invoke-direct {v6, v5}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 3941
    .local v6, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/GetSigningCertificateResult;>;"
    invoke-direct {p0, v2, v6, v0}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v7

    move-object v3, v7

    .line 3943
    invoke-virtual {v3}, Lcom/amazonaws/Response;->getAwsResponse()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/amazonaws/services/cognitoidentityprovider/model/GetSigningCertificateResult;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 3945
    sget-object v8, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v8}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 3946
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 3943
    return-object v7

    .line 3935
    .end local v5    # "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/GetSigningCertificateResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    .end local v6    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/GetSigningCertificateResult;>;"
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 3936
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/GetSigningCertificateRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/GetSigningCertificateResult;>;"
    .end local p1    # "getSigningCertificateRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/GetSigningCertificateRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 3945
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/GetSigningCertificateRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/GetSigningCertificateResult;>;"
    .restart local p1    # "getSigningCertificateRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/GetSigningCertificateRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 3946
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 3947
    throw v5
.end method

.method public getUICustomization(Lcom/amazonaws/services/cognitoidentityprovider/model/GetUICustomizationRequest;)Lcom/amazonaws/services/cognitoidentityprovider/model/GetUICustomizationResult;
    .locals 9
    .param p1, "getUICustomizationRequest"    # Lcom/amazonaws/services/cognitoidentityprovider/model/GetUICustomizationRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 3978
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 3979
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 3980
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 3981
    const/4 v2, 0x0

    .line 3982
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/GetUICustomizationRequest;>;"
    const/4 v3, 0x0

    .line 3984
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/GetUICustomizationResult;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 3986
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/GetUICustomizationRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/GetUICustomizationRequestMarshaller;-><init>()V

    .line 3987
    invoke-virtual {v5, p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/GetUICustomizationRequestMarshaller;->marshall(Lcom/amazonaws/services/cognitoidentityprovider/model/GetUICustomizationRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 3989
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 3991
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 3992
    nop

    .line 3993
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/GetUICustomizationResultJsonUnmarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/GetUICustomizationResultJsonUnmarshaller;-><init>()V

    .line 3994
    .local v5, "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/GetUICustomizationResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    new-instance v6, Lcom/amazonaws/http/JsonResponseHandler;

    invoke-direct {v6, v5}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 3997
    .local v6, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/GetUICustomizationResult;>;"
    invoke-direct {p0, v2, v6, v0}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v7

    move-object v3, v7

    .line 3999
    invoke-virtual {v3}, Lcom/amazonaws/Response;->getAwsResponse()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/amazonaws/services/cognitoidentityprovider/model/GetUICustomizationResult;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 4001
    sget-object v8, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v8}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 4002
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 3999
    return-object v7

    .line 3991
    .end local v5    # "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/GetUICustomizationResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    .end local v6    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/GetUICustomizationResult;>;"
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 3992
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/GetUICustomizationRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/GetUICustomizationResult;>;"
    .end local p1    # "getUICustomizationRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/GetUICustomizationRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 4001
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/GetUICustomizationRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/GetUICustomizationResult;>;"
    .restart local p1    # "getUICustomizationRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/GetUICustomizationRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 4002
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 4003
    throw v5
.end method

.method public getUser(Lcom/amazonaws/services/cognitoidentityprovider/model/GetUserRequest;)Lcom/amazonaws/services/cognitoidentityprovider/model/GetUserResult;
    .locals 9
    .param p1, "getUserRequest"    # Lcom/amazonaws/services/cognitoidentityprovider/model/GetUserRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 4034
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 4035
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 4036
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 4037
    const/4 v2, 0x0

    .line 4038
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/GetUserRequest;>;"
    const/4 v3, 0x0

    .line 4040
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/GetUserResult;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 4042
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/GetUserRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/GetUserRequestMarshaller;-><init>()V

    invoke-virtual {v5, p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/GetUserRequestMarshaller;->marshall(Lcom/amazonaws/services/cognitoidentityprovider/model/GetUserRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 4044
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 4046
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 4047
    nop

    .line 4048
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/GetUserResultJsonUnmarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/GetUserResultJsonUnmarshaller;-><init>()V

    .line 4049
    .local v5, "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/GetUserResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    new-instance v6, Lcom/amazonaws/http/JsonResponseHandler;

    invoke-direct {v6, v5}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 4052
    .local v6, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/GetUserResult;>;"
    invoke-direct {p0, v2, v6, v0}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v7

    move-object v3, v7

    .line 4054
    invoke-virtual {v3}, Lcom/amazonaws/Response;->getAwsResponse()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/amazonaws/services/cognitoidentityprovider/model/GetUserResult;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 4056
    sget-object v8, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v8}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 4057
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 4054
    return-object v7

    .line 4046
    .end local v5    # "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/GetUserResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    .end local v6    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/GetUserResult;>;"
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 4047
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/GetUserRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/GetUserResult;>;"
    .end local p1    # "getUserRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/GetUserRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 4056
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/GetUserRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/GetUserResult;>;"
    .restart local p1    # "getUserRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/GetUserRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 4057
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 4058
    throw v5
.end method

.method public getUserAttributeVerificationCode(Lcom/amazonaws/services/cognitoidentityprovider/model/GetUserAttributeVerificationCodeRequest;)Lcom/amazonaws/services/cognitoidentityprovider/model/GetUserAttributeVerificationCodeResult;
    .locals 9
    .param p1, "getUserAttributeVerificationCodeRequest"    # Lcom/amazonaws/services/cognitoidentityprovider/model/GetUserAttributeVerificationCodeRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 4100
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 4101
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 4102
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 4103
    const/4 v2, 0x0

    .line 4104
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/GetUserAttributeVerificationCodeRequest;>;"
    const/4 v3, 0x0

    .line 4106
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/GetUserAttributeVerificationCodeResult;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 4108
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/GetUserAttributeVerificationCodeRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/GetUserAttributeVerificationCodeRequestMarshaller;-><init>()V

    .line 4109
    invoke-virtual {v5, p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/GetUserAttributeVerificationCodeRequestMarshaller;->marshall(Lcom/amazonaws/services/cognitoidentityprovider/model/GetUserAttributeVerificationCodeRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 4111
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 4113
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 4114
    nop

    .line 4115
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/GetUserAttributeVerificationCodeResultJsonUnmarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/GetUserAttributeVerificationCodeResultJsonUnmarshaller;-><init>()V

    .line 4116
    .local v5, "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/GetUserAttributeVerificationCodeResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    new-instance v6, Lcom/amazonaws/http/JsonResponseHandler;

    invoke-direct {v6, v5}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 4119
    .local v6, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/GetUserAttributeVerificationCodeResult;>;"
    invoke-direct {p0, v2, v6, v0}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v7

    move-object v3, v7

    .line 4121
    invoke-virtual {v3}, Lcom/amazonaws/Response;->getAwsResponse()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/amazonaws/services/cognitoidentityprovider/model/GetUserAttributeVerificationCodeResult;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 4123
    sget-object v8, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v8}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 4124
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 4121
    return-object v7

    .line 4113
    .end local v5    # "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/GetUserAttributeVerificationCodeResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    .end local v6    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/GetUserAttributeVerificationCodeResult;>;"
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 4114
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/GetUserAttributeVerificationCodeRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/GetUserAttributeVerificationCodeResult;>;"
    .end local p1    # "getUserAttributeVerificationCodeRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/GetUserAttributeVerificationCodeRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 4123
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/GetUserAttributeVerificationCodeRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/GetUserAttributeVerificationCodeResult;>;"
    .restart local p1    # "getUserAttributeVerificationCodeRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/GetUserAttributeVerificationCodeRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 4124
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 4125
    throw v5
.end method

.method public getUserPoolMfaConfig(Lcom/amazonaws/services/cognitoidentityprovider/model/GetUserPoolMfaConfigRequest;)Lcom/amazonaws/services/cognitoidentityprovider/model/GetUserPoolMfaConfigResult;
    .locals 9
    .param p1, "getUserPoolMfaConfigRequest"    # Lcom/amazonaws/services/cognitoidentityprovider/model/GetUserPoolMfaConfigRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 4153
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 4154
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 4155
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 4156
    const/4 v2, 0x0

    .line 4157
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/GetUserPoolMfaConfigRequest;>;"
    const/4 v3, 0x0

    .line 4159
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/GetUserPoolMfaConfigResult;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 4161
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/GetUserPoolMfaConfigRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/GetUserPoolMfaConfigRequestMarshaller;-><init>()V

    .line 4162
    invoke-virtual {v5, p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/GetUserPoolMfaConfigRequestMarshaller;->marshall(Lcom/amazonaws/services/cognitoidentityprovider/model/GetUserPoolMfaConfigRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 4164
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 4166
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 4167
    nop

    .line 4168
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/GetUserPoolMfaConfigResultJsonUnmarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/GetUserPoolMfaConfigResultJsonUnmarshaller;-><init>()V

    .line 4169
    .local v5, "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/GetUserPoolMfaConfigResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    new-instance v6, Lcom/amazonaws/http/JsonResponseHandler;

    invoke-direct {v6, v5}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 4172
    .local v6, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/GetUserPoolMfaConfigResult;>;"
    invoke-direct {p0, v2, v6, v0}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v7

    move-object v3, v7

    .line 4174
    invoke-virtual {v3}, Lcom/amazonaws/Response;->getAwsResponse()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/amazonaws/services/cognitoidentityprovider/model/GetUserPoolMfaConfigResult;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 4176
    sget-object v8, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v8}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 4177
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 4174
    return-object v7

    .line 4166
    .end local v5    # "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/GetUserPoolMfaConfigResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    .end local v6    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/GetUserPoolMfaConfigResult;>;"
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 4167
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/GetUserPoolMfaConfigRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/GetUserPoolMfaConfigResult;>;"
    .end local p1    # "getUserPoolMfaConfigRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/GetUserPoolMfaConfigRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 4176
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/GetUserPoolMfaConfigRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/GetUserPoolMfaConfigResult;>;"
    .restart local p1    # "getUserPoolMfaConfigRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/GetUserPoolMfaConfigRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 4177
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 4178
    throw v5
.end method

.method public globalSignOut(Lcom/amazonaws/services/cognitoidentityprovider/model/GlobalSignOutRequest;)Lcom/amazonaws/services/cognitoidentityprovider/model/GlobalSignOutResult;
    .locals 9
    .param p1, "globalSignOutRequest"    # Lcom/amazonaws/services/cognitoidentityprovider/model/GlobalSignOutRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 4211
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 4212
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 4213
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 4214
    const/4 v2, 0x0

    .line 4215
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/GlobalSignOutRequest;>;"
    const/4 v3, 0x0

    .line 4217
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/GlobalSignOutResult;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 4219
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/GlobalSignOutRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/GlobalSignOutRequestMarshaller;-><init>()V

    invoke-virtual {v5, p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/GlobalSignOutRequestMarshaller;->marshall(Lcom/amazonaws/services/cognitoidentityprovider/model/GlobalSignOutRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 4221
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 4223
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 4224
    nop

    .line 4225
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/GlobalSignOutResultJsonUnmarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/GlobalSignOutResultJsonUnmarshaller;-><init>()V

    .line 4226
    .local v5, "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/GlobalSignOutResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    new-instance v6, Lcom/amazonaws/http/JsonResponseHandler;

    invoke-direct {v6, v5}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 4229
    .local v6, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/GlobalSignOutResult;>;"
    invoke-direct {p0, v2, v6, v0}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v7

    move-object v3, v7

    .line 4231
    invoke-virtual {v3}, Lcom/amazonaws/Response;->getAwsResponse()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/amazonaws/services/cognitoidentityprovider/model/GlobalSignOutResult;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 4233
    sget-object v8, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v8}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 4234
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 4231
    return-object v7

    .line 4223
    .end local v5    # "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/GlobalSignOutResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    .end local v6    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/GlobalSignOutResult;>;"
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 4224
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/GlobalSignOutRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/GlobalSignOutResult;>;"
    .end local p1    # "globalSignOutRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/GlobalSignOutRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 4233
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/GlobalSignOutRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/GlobalSignOutResult;>;"
    .restart local p1    # "globalSignOutRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/GlobalSignOutRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 4234
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 4235
    throw v5
.end method

.method public initiateAuth(Lcom/amazonaws/services/cognitoidentityprovider/model/InitiateAuthRequest;)Lcom/amazonaws/services/cognitoidentityprovider/model/InitiateAuthResult;
    .locals 9
    .param p1, "initiateAuthRequest"    # Lcom/amazonaws/services/cognitoidentityprovider/model/InitiateAuthRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 4272
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 4273
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 4274
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 4275
    const/4 v2, 0x0

    .line 4276
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/InitiateAuthRequest;>;"
    const/4 v3, 0x0

    .line 4278
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/InitiateAuthResult;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 4280
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/InitiateAuthRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/InitiateAuthRequestMarshaller;-><init>()V

    invoke-virtual {v5, p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/InitiateAuthRequestMarshaller;->marshall(Lcom/amazonaws/services/cognitoidentityprovider/model/InitiateAuthRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 4282
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 4284
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 4285
    nop

    .line 4286
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/InitiateAuthResultJsonUnmarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/InitiateAuthResultJsonUnmarshaller;-><init>()V

    .line 4287
    .local v5, "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/InitiateAuthResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    new-instance v6, Lcom/amazonaws/http/JsonResponseHandler;

    invoke-direct {v6, v5}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 4290
    .local v6, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/InitiateAuthResult;>;"
    invoke-direct {p0, v2, v6, v0}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v7

    move-object v3, v7

    .line 4292
    invoke-virtual {v3}, Lcom/amazonaws/Response;->getAwsResponse()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/amazonaws/services/cognitoidentityprovider/model/InitiateAuthResult;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 4294
    sget-object v8, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v8}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 4295
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 4292
    return-object v7

    .line 4284
    .end local v5    # "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/InitiateAuthResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    .end local v6    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/InitiateAuthResult;>;"
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 4285
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/InitiateAuthRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/InitiateAuthResult;>;"
    .end local p1    # "initiateAuthRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/InitiateAuthRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 4294
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/InitiateAuthRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/InitiateAuthResult;>;"
    .restart local p1    # "initiateAuthRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/InitiateAuthRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 4295
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 4296
    throw v5
.end method

.method public listDevices(Lcom/amazonaws/services/cognitoidentityprovider/model/ListDevicesRequest;)Lcom/amazonaws/services/cognitoidentityprovider/model/ListDevicesResult;
    .locals 9
    .param p1, "listDevicesRequest"    # Lcom/amazonaws/services/cognitoidentityprovider/model/ListDevicesRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 4328
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 4329
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 4330
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 4331
    const/4 v2, 0x0

    .line 4332
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/ListDevicesRequest;>;"
    const/4 v3, 0x0

    .line 4334
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/ListDevicesResult;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 4336
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/ListDevicesRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/ListDevicesRequestMarshaller;-><init>()V

    invoke-virtual {v5, p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/ListDevicesRequestMarshaller;->marshall(Lcom/amazonaws/services/cognitoidentityprovider/model/ListDevicesRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 4338
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 4340
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 4341
    nop

    .line 4342
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/ListDevicesResultJsonUnmarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/ListDevicesResultJsonUnmarshaller;-><init>()V

    .line 4343
    .local v5, "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/ListDevicesResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    new-instance v6, Lcom/amazonaws/http/JsonResponseHandler;

    invoke-direct {v6, v5}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 4346
    .local v6, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/ListDevicesResult;>;"
    invoke-direct {p0, v2, v6, v0}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v7

    move-object v3, v7

    .line 4348
    invoke-virtual {v3}, Lcom/amazonaws/Response;->getAwsResponse()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/amazonaws/services/cognitoidentityprovider/model/ListDevicesResult;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 4350
    sget-object v8, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v8}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 4351
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 4348
    return-object v7

    .line 4340
    .end local v5    # "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/ListDevicesResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    .end local v6    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/ListDevicesResult;>;"
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 4341
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/ListDevicesRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/ListDevicesResult;>;"
    .end local p1    # "listDevicesRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/ListDevicesRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 4350
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/ListDevicesRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/ListDevicesResult;>;"
    .restart local p1    # "listDevicesRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/ListDevicesRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 4351
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 4352
    throw v5
.end method

.method public listGroups(Lcom/amazonaws/services/cognitoidentityprovider/model/ListGroupsRequest;)Lcom/amazonaws/services/cognitoidentityprovider/model/ListGroupsResult;
    .locals 9
    .param p1, "listGroupsRequest"    # Lcom/amazonaws/services/cognitoidentityprovider/model/ListGroupsRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 4381
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 4382
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 4383
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 4384
    const/4 v2, 0x0

    .line 4385
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/ListGroupsRequest;>;"
    const/4 v3, 0x0

    .line 4387
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/ListGroupsResult;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 4389
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/ListGroupsRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/ListGroupsRequestMarshaller;-><init>()V

    invoke-virtual {v5, p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/ListGroupsRequestMarshaller;->marshall(Lcom/amazonaws/services/cognitoidentityprovider/model/ListGroupsRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 4391
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 4393
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 4394
    nop

    .line 4395
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/ListGroupsResultJsonUnmarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/ListGroupsResultJsonUnmarshaller;-><init>()V

    .line 4396
    .local v5, "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/ListGroupsResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    new-instance v6, Lcom/amazonaws/http/JsonResponseHandler;

    invoke-direct {v6, v5}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 4399
    .local v6, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/ListGroupsResult;>;"
    invoke-direct {p0, v2, v6, v0}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v7

    move-object v3, v7

    .line 4401
    invoke-virtual {v3}, Lcom/amazonaws/Response;->getAwsResponse()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/amazonaws/services/cognitoidentityprovider/model/ListGroupsResult;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 4403
    sget-object v8, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v8}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 4404
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 4401
    return-object v7

    .line 4393
    .end local v5    # "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/ListGroupsResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    .end local v6    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/ListGroupsResult;>;"
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 4394
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/ListGroupsRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/ListGroupsResult;>;"
    .end local p1    # "listGroupsRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/ListGroupsRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 4403
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/ListGroupsRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/ListGroupsResult;>;"
    .restart local p1    # "listGroupsRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/ListGroupsRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 4404
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 4405
    throw v5
.end method

.method public listIdentityProviders(Lcom/amazonaws/services/cognitoidentityprovider/model/ListIdentityProvidersRequest;)Lcom/amazonaws/services/cognitoidentityprovider/model/ListIdentityProvidersResult;
    .locals 9
    .param p1, "listIdentityProvidersRequest"    # Lcom/amazonaws/services/cognitoidentityprovider/model/ListIdentityProvidersRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 4433
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 4434
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 4435
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 4436
    const/4 v2, 0x0

    .line 4437
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/ListIdentityProvidersRequest;>;"
    const/4 v3, 0x0

    .line 4439
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/ListIdentityProvidersResult;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 4441
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/ListIdentityProvidersRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/ListIdentityProvidersRequestMarshaller;-><init>()V

    .line 4442
    invoke-virtual {v5, p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/ListIdentityProvidersRequestMarshaller;->marshall(Lcom/amazonaws/services/cognitoidentityprovider/model/ListIdentityProvidersRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 4444
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 4446
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 4447
    nop

    .line 4448
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/ListIdentityProvidersResultJsonUnmarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/ListIdentityProvidersResultJsonUnmarshaller;-><init>()V

    .line 4449
    .local v5, "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/ListIdentityProvidersResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    new-instance v6, Lcom/amazonaws/http/JsonResponseHandler;

    invoke-direct {v6, v5}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 4452
    .local v6, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/ListIdentityProvidersResult;>;"
    invoke-direct {p0, v2, v6, v0}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v7

    move-object v3, v7

    .line 4454
    invoke-virtual {v3}, Lcom/amazonaws/Response;->getAwsResponse()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/amazonaws/services/cognitoidentityprovider/model/ListIdentityProvidersResult;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 4456
    sget-object v8, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v8}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 4457
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 4454
    return-object v7

    .line 4446
    .end local v5    # "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/ListIdentityProvidersResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    .end local v6    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/ListIdentityProvidersResult;>;"
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 4447
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/ListIdentityProvidersRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/ListIdentityProvidersResult;>;"
    .end local p1    # "listIdentityProvidersRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/ListIdentityProvidersRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 4456
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/ListIdentityProvidersRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/ListIdentityProvidersResult;>;"
    .restart local p1    # "listIdentityProvidersRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/ListIdentityProvidersRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 4457
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 4458
    throw v5
.end method

.method public listResourceServers(Lcom/amazonaws/services/cognitoidentityprovider/model/ListResourceServersRequest;)Lcom/amazonaws/services/cognitoidentityprovider/model/ListResourceServersResult;
    .locals 9
    .param p1, "listResourceServersRequest"    # Lcom/amazonaws/services/cognitoidentityprovider/model/ListResourceServersRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 4486
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 4487
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 4488
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 4489
    const/4 v2, 0x0

    .line 4490
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/ListResourceServersRequest;>;"
    const/4 v3, 0x0

    .line 4492
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/ListResourceServersResult;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 4494
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/ListResourceServersRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/ListResourceServersRequestMarshaller;-><init>()V

    .line 4495
    invoke-virtual {v5, p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/ListResourceServersRequestMarshaller;->marshall(Lcom/amazonaws/services/cognitoidentityprovider/model/ListResourceServersRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 4497
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 4499
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 4500
    nop

    .line 4501
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/ListResourceServersResultJsonUnmarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/ListResourceServersResultJsonUnmarshaller;-><init>()V

    .line 4502
    .local v5, "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/ListResourceServersResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    new-instance v6, Lcom/amazonaws/http/JsonResponseHandler;

    invoke-direct {v6, v5}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 4505
    .local v6, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/ListResourceServersResult;>;"
    invoke-direct {p0, v2, v6, v0}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v7

    move-object v3, v7

    .line 4507
    invoke-virtual {v3}, Lcom/amazonaws/Response;->getAwsResponse()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/amazonaws/services/cognitoidentityprovider/model/ListResourceServersResult;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 4509
    sget-object v8, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v8}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 4510
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 4507
    return-object v7

    .line 4499
    .end local v5    # "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/ListResourceServersResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    .end local v6    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/ListResourceServersResult;>;"
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 4500
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/ListResourceServersRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/ListResourceServersResult;>;"
    .end local p1    # "listResourceServersRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/ListResourceServersRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 4509
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/ListResourceServersRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/ListResourceServersResult;>;"
    .restart local p1    # "listResourceServersRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/ListResourceServersRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 4510
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 4511
    throw v5
.end method

.method public listTagsForResource(Lcom/amazonaws/services/cognitoidentityprovider/model/ListTagsForResourceRequest;)Lcom/amazonaws/services/cognitoidentityprovider/model/ListTagsForResourceResult;
    .locals 9
    .param p1, "listTagsForResourceRequest"    # Lcom/amazonaws/services/cognitoidentityprovider/model/ListTagsForResourceRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 4547
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 4548
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 4549
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 4550
    const/4 v2, 0x0

    .line 4551
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/ListTagsForResourceRequest;>;"
    const/4 v3, 0x0

    .line 4553
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/ListTagsForResourceResult;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 4555
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/ListTagsForResourceRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/ListTagsForResourceRequestMarshaller;-><init>()V

    .line 4556
    invoke-virtual {v5, p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/ListTagsForResourceRequestMarshaller;->marshall(Lcom/amazonaws/services/cognitoidentityprovider/model/ListTagsForResourceRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 4558
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 4560
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 4561
    nop

    .line 4562
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/ListTagsForResourceResultJsonUnmarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/ListTagsForResourceResultJsonUnmarshaller;-><init>()V

    .line 4563
    .local v5, "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/ListTagsForResourceResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    new-instance v6, Lcom/amazonaws/http/JsonResponseHandler;

    invoke-direct {v6, v5}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 4566
    .local v6, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/ListTagsForResourceResult;>;"
    invoke-direct {p0, v2, v6, v0}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v7

    move-object v3, v7

    .line 4568
    invoke-virtual {v3}, Lcom/amazonaws/Response;->getAwsResponse()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/amazonaws/services/cognitoidentityprovider/model/ListTagsForResourceResult;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 4570
    sget-object v8, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v8}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 4571
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 4568
    return-object v7

    .line 4560
    .end local v5    # "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/ListTagsForResourceResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    .end local v6    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/ListTagsForResourceResult;>;"
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 4561
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/ListTagsForResourceRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/ListTagsForResourceResult;>;"
    .end local p1    # "listTagsForResourceRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/ListTagsForResourceRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 4570
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/ListTagsForResourceRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/ListTagsForResourceResult;>;"
    .restart local p1    # "listTagsForResourceRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/ListTagsForResourceRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 4571
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 4572
    throw v5
.end method

.method public listUserImportJobs(Lcom/amazonaws/services/cognitoidentityprovider/model/ListUserImportJobsRequest;)Lcom/amazonaws/services/cognitoidentityprovider/model/ListUserImportJobsResult;
    .locals 9
    .param p1, "listUserImportJobsRequest"    # Lcom/amazonaws/services/cognitoidentityprovider/model/ListUserImportJobsRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 4601
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 4602
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 4603
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 4604
    const/4 v2, 0x0

    .line 4605
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/ListUserImportJobsRequest;>;"
    const/4 v3, 0x0

    .line 4607
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/ListUserImportJobsResult;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 4609
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/ListUserImportJobsRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/ListUserImportJobsRequestMarshaller;-><init>()V

    .line 4610
    invoke-virtual {v5, p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/ListUserImportJobsRequestMarshaller;->marshall(Lcom/amazonaws/services/cognitoidentityprovider/model/ListUserImportJobsRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 4612
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 4614
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 4615
    nop

    .line 4616
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/ListUserImportJobsResultJsonUnmarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/ListUserImportJobsResultJsonUnmarshaller;-><init>()V

    .line 4617
    .local v5, "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/ListUserImportJobsResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    new-instance v6, Lcom/amazonaws/http/JsonResponseHandler;

    invoke-direct {v6, v5}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 4620
    .local v6, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/ListUserImportJobsResult;>;"
    invoke-direct {p0, v2, v6, v0}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v7

    move-object v3, v7

    .line 4622
    invoke-virtual {v3}, Lcom/amazonaws/Response;->getAwsResponse()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/amazonaws/services/cognitoidentityprovider/model/ListUserImportJobsResult;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 4624
    sget-object v8, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v8}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 4625
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 4622
    return-object v7

    .line 4614
    .end local v5    # "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/ListUserImportJobsResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    .end local v6    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/ListUserImportJobsResult;>;"
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 4615
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/ListUserImportJobsRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/ListUserImportJobsResult;>;"
    .end local p1    # "listUserImportJobsRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/ListUserImportJobsRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 4624
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/ListUserImportJobsRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/ListUserImportJobsResult;>;"
    .restart local p1    # "listUserImportJobsRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/ListUserImportJobsRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 4625
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 4626
    throw v5
.end method

.method public listUserPoolClients(Lcom/amazonaws/services/cognitoidentityprovider/model/ListUserPoolClientsRequest;)Lcom/amazonaws/services/cognitoidentityprovider/model/ListUserPoolClientsResult;
    .locals 9
    .param p1, "listUserPoolClientsRequest"    # Lcom/amazonaws/services/cognitoidentityprovider/model/ListUserPoolClientsRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 4656
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 4657
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 4658
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 4659
    const/4 v2, 0x0

    .line 4660
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/ListUserPoolClientsRequest;>;"
    const/4 v3, 0x0

    .line 4662
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/ListUserPoolClientsResult;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 4664
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/ListUserPoolClientsRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/ListUserPoolClientsRequestMarshaller;-><init>()V

    .line 4665
    invoke-virtual {v5, p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/ListUserPoolClientsRequestMarshaller;->marshall(Lcom/amazonaws/services/cognitoidentityprovider/model/ListUserPoolClientsRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 4667
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 4669
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 4670
    nop

    .line 4671
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/ListUserPoolClientsResultJsonUnmarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/ListUserPoolClientsResultJsonUnmarshaller;-><init>()V

    .line 4672
    .local v5, "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/ListUserPoolClientsResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    new-instance v6, Lcom/amazonaws/http/JsonResponseHandler;

    invoke-direct {v6, v5}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 4675
    .local v6, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/ListUserPoolClientsResult;>;"
    invoke-direct {p0, v2, v6, v0}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v7

    move-object v3, v7

    .line 4677
    invoke-virtual {v3}, Lcom/amazonaws/Response;->getAwsResponse()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/amazonaws/services/cognitoidentityprovider/model/ListUserPoolClientsResult;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 4679
    sget-object v8, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v8}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 4680
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 4677
    return-object v7

    .line 4669
    .end local v5    # "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/ListUserPoolClientsResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    .end local v6    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/ListUserPoolClientsResult;>;"
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 4670
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/ListUserPoolClientsRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/ListUserPoolClientsResult;>;"
    .end local p1    # "listUserPoolClientsRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/ListUserPoolClientsRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 4679
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/ListUserPoolClientsRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/ListUserPoolClientsResult;>;"
    .restart local p1    # "listUserPoolClientsRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/ListUserPoolClientsRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 4680
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 4681
    throw v5
.end method

.method public listUserPools(Lcom/amazonaws/services/cognitoidentityprovider/model/ListUserPoolsRequest;)Lcom/amazonaws/services/cognitoidentityprovider/model/ListUserPoolsResult;
    .locals 9
    .param p1, "listUserPoolsRequest"    # Lcom/amazonaws/services/cognitoidentityprovider/model/ListUserPoolsRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 4708
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 4709
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 4710
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 4711
    const/4 v2, 0x0

    .line 4712
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/ListUserPoolsRequest;>;"
    const/4 v3, 0x0

    .line 4714
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/ListUserPoolsResult;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 4716
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/ListUserPoolsRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/ListUserPoolsRequestMarshaller;-><init>()V

    invoke-virtual {v5, p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/ListUserPoolsRequestMarshaller;->marshall(Lcom/amazonaws/services/cognitoidentityprovider/model/ListUserPoolsRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 4718
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 4720
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 4721
    nop

    .line 4722
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/ListUserPoolsResultJsonUnmarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/ListUserPoolsResultJsonUnmarshaller;-><init>()V

    .line 4723
    .local v5, "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/ListUserPoolsResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    new-instance v6, Lcom/amazonaws/http/JsonResponseHandler;

    invoke-direct {v6, v5}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 4726
    .local v6, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/ListUserPoolsResult;>;"
    invoke-direct {p0, v2, v6, v0}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v7

    move-object v3, v7

    .line 4728
    invoke-virtual {v3}, Lcom/amazonaws/Response;->getAwsResponse()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/amazonaws/services/cognitoidentityprovider/model/ListUserPoolsResult;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 4730
    sget-object v8, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v8}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 4731
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 4728
    return-object v7

    .line 4720
    .end local v5    # "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/ListUserPoolsResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    .end local v6    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/ListUserPoolsResult;>;"
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 4721
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/ListUserPoolsRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/ListUserPoolsResult;>;"
    .end local p1    # "listUserPoolsRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/ListUserPoolsRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 4730
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/ListUserPoolsRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/ListUserPoolsResult;>;"
    .restart local p1    # "listUserPoolsRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/ListUserPoolsRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 4731
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 4732
    throw v5
.end method

.method public listUsers(Lcom/amazonaws/services/cognitoidentityprovider/model/ListUsersRequest;)Lcom/amazonaws/services/cognitoidentityprovider/model/ListUsersResult;
    .locals 9
    .param p1, "listUsersRequest"    # Lcom/amazonaws/services/cognitoidentityprovider/model/ListUsersRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 4760
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 4761
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 4762
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 4763
    const/4 v2, 0x0

    .line 4764
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/ListUsersRequest;>;"
    const/4 v3, 0x0

    .line 4766
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/ListUsersResult;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 4768
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/ListUsersRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/ListUsersRequestMarshaller;-><init>()V

    invoke-virtual {v5, p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/ListUsersRequestMarshaller;->marshall(Lcom/amazonaws/services/cognitoidentityprovider/model/ListUsersRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 4770
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 4772
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 4773
    nop

    .line 4774
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/ListUsersResultJsonUnmarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/ListUsersResultJsonUnmarshaller;-><init>()V

    .line 4775
    .local v5, "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/ListUsersResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    new-instance v6, Lcom/amazonaws/http/JsonResponseHandler;

    invoke-direct {v6, v5}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 4778
    .local v6, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/ListUsersResult;>;"
    invoke-direct {p0, v2, v6, v0}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v7

    move-object v3, v7

    .line 4780
    invoke-virtual {v3}, Lcom/amazonaws/Response;->getAwsResponse()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/amazonaws/services/cognitoidentityprovider/model/ListUsersResult;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 4782
    sget-object v8, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v8}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 4783
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 4780
    return-object v7

    .line 4772
    .end local v5    # "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/ListUsersResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    .end local v6    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/ListUsersResult;>;"
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 4773
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/ListUsersRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/ListUsersResult;>;"
    .end local p1    # "listUsersRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/ListUsersRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 4782
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/ListUsersRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/ListUsersResult;>;"
    .restart local p1    # "listUsersRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/ListUsersRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 4783
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 4784
    throw v5
.end method

.method public listUsersInGroup(Lcom/amazonaws/services/cognitoidentityprovider/model/ListUsersInGroupRequest;)Lcom/amazonaws/services/cognitoidentityprovider/model/ListUsersInGroupResult;
    .locals 9
    .param p1, "listUsersInGroupRequest"    # Lcom/amazonaws/services/cognitoidentityprovider/model/ListUsersInGroupRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 4813
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 4814
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 4815
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 4816
    const/4 v2, 0x0

    .line 4817
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/ListUsersInGroupRequest;>;"
    const/4 v3, 0x0

    .line 4819
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/ListUsersInGroupResult;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 4821
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/ListUsersInGroupRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/ListUsersInGroupRequestMarshaller;-><init>()V

    invoke-virtual {v5, p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/ListUsersInGroupRequestMarshaller;->marshall(Lcom/amazonaws/services/cognitoidentityprovider/model/ListUsersInGroupRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 4823
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 4825
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 4826
    nop

    .line 4827
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/ListUsersInGroupResultJsonUnmarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/ListUsersInGroupResultJsonUnmarshaller;-><init>()V

    .line 4828
    .local v5, "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/ListUsersInGroupResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    new-instance v6, Lcom/amazonaws/http/JsonResponseHandler;

    invoke-direct {v6, v5}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 4831
    .local v6, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/ListUsersInGroupResult;>;"
    invoke-direct {p0, v2, v6, v0}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v7

    move-object v3, v7

    .line 4833
    invoke-virtual {v3}, Lcom/amazonaws/Response;->getAwsResponse()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/amazonaws/services/cognitoidentityprovider/model/ListUsersInGroupResult;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 4835
    sget-object v8, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v8}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 4836
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 4833
    return-object v7

    .line 4825
    .end local v5    # "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/ListUsersInGroupResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    .end local v6    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/ListUsersInGroupResult;>;"
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 4826
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/ListUsersInGroupRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/ListUsersInGroupResult;>;"
    .end local p1    # "listUsersInGroupRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/ListUsersInGroupRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 4835
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/ListUsersInGroupRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/ListUsersInGroupResult;>;"
    .restart local p1    # "listUsersInGroupRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/ListUsersInGroupRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 4836
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 4837
    throw v5
.end method

.method public resendConfirmationCode(Lcom/amazonaws/services/cognitoidentityprovider/model/ResendConfirmationCodeRequest;)Lcom/amazonaws/services/cognitoidentityprovider/model/ResendConfirmationCodeResult;
    .locals 9
    .param p1, "resendConfirmationCodeRequest"    # Lcom/amazonaws/services/cognitoidentityprovider/model/ResendConfirmationCodeRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 4877
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 4878
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 4879
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 4880
    const/4 v2, 0x0

    .line 4881
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/ResendConfirmationCodeRequest;>;"
    const/4 v3, 0x0

    .line 4883
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/ResendConfirmationCodeResult;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 4885
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/ResendConfirmationCodeRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/ResendConfirmationCodeRequestMarshaller;-><init>()V

    .line 4886
    invoke-virtual {v5, p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/ResendConfirmationCodeRequestMarshaller;->marshall(Lcom/amazonaws/services/cognitoidentityprovider/model/ResendConfirmationCodeRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 4888
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 4890
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 4891
    nop

    .line 4892
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/ResendConfirmationCodeResultJsonUnmarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/ResendConfirmationCodeResultJsonUnmarshaller;-><init>()V

    .line 4893
    .local v5, "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/ResendConfirmationCodeResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    new-instance v6, Lcom/amazonaws/http/JsonResponseHandler;

    invoke-direct {v6, v5}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 4896
    .local v6, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/ResendConfirmationCodeResult;>;"
    invoke-direct {p0, v2, v6, v0}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v7

    move-object v3, v7

    .line 4898
    invoke-virtual {v3}, Lcom/amazonaws/Response;->getAwsResponse()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/amazonaws/services/cognitoidentityprovider/model/ResendConfirmationCodeResult;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 4900
    sget-object v8, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v8}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 4901
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 4898
    return-object v7

    .line 4890
    .end local v5    # "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/ResendConfirmationCodeResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    .end local v6    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/ResendConfirmationCodeResult;>;"
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 4891
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/ResendConfirmationCodeRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/ResendConfirmationCodeResult;>;"
    .end local p1    # "resendConfirmationCodeRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/ResendConfirmationCodeRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 4900
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/ResendConfirmationCodeRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/ResendConfirmationCodeResult;>;"
    .restart local p1    # "resendConfirmationCodeRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/ResendConfirmationCodeRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 4901
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 4902
    throw v5
.end method

.method public respondToAuthChallenge(Lcom/amazonaws/services/cognitoidentityprovider/model/RespondToAuthChallengeRequest;)Lcom/amazonaws/services/cognitoidentityprovider/model/RespondToAuthChallengeResult;
    .locals 9
    .param p1, "respondToAuthChallengeRequest"    # Lcom/amazonaws/services/cognitoidentityprovider/model/RespondToAuthChallengeRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 4947
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 4948
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 4949
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 4950
    const/4 v2, 0x0

    .line 4951
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/RespondToAuthChallengeRequest;>;"
    const/4 v3, 0x0

    .line 4953
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/RespondToAuthChallengeResult;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 4955
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/RespondToAuthChallengeRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/RespondToAuthChallengeRequestMarshaller;-><init>()V

    .line 4956
    invoke-virtual {v5, p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/RespondToAuthChallengeRequestMarshaller;->marshall(Lcom/amazonaws/services/cognitoidentityprovider/model/RespondToAuthChallengeRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 4958
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 4960
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 4961
    nop

    .line 4962
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/RespondToAuthChallengeResultJsonUnmarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/RespondToAuthChallengeResultJsonUnmarshaller;-><init>()V

    .line 4963
    .local v5, "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/RespondToAuthChallengeResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    new-instance v6, Lcom/amazonaws/http/JsonResponseHandler;

    invoke-direct {v6, v5}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 4966
    .local v6, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/RespondToAuthChallengeResult;>;"
    invoke-direct {p0, v2, v6, v0}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v7

    move-object v3, v7

    .line 4968
    invoke-virtual {v3}, Lcom/amazonaws/Response;->getAwsResponse()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/amazonaws/services/cognitoidentityprovider/model/RespondToAuthChallengeResult;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 4970
    sget-object v8, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v8}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 4971
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 4968
    return-object v7

    .line 4960
    .end local v5    # "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/RespondToAuthChallengeResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    .end local v6    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/RespondToAuthChallengeResult;>;"
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 4961
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/RespondToAuthChallengeRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/RespondToAuthChallengeResult;>;"
    .end local p1    # "respondToAuthChallengeRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/RespondToAuthChallengeRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 4970
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/RespondToAuthChallengeRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/RespondToAuthChallengeResult;>;"
    .restart local p1    # "respondToAuthChallengeRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/RespondToAuthChallengeRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 4971
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 4972
    throw v5
.end method

.method public setRiskConfiguration(Lcom/amazonaws/services/cognitoidentityprovider/model/SetRiskConfigurationRequest;)Lcom/amazonaws/services/cognitoidentityprovider/model/SetRiskConfigurationResult;
    .locals 9
    .param p1, "setRiskConfigurationRequest"    # Lcom/amazonaws/services/cognitoidentityprovider/model/SetRiskConfigurationRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 5010
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 5011
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 5012
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 5013
    const/4 v2, 0x0

    .line 5014
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/SetRiskConfigurationRequest;>;"
    const/4 v3, 0x0

    .line 5016
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/SetRiskConfigurationResult;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 5018
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/SetRiskConfigurationRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/SetRiskConfigurationRequestMarshaller;-><init>()V

    .line 5019
    invoke-virtual {v5, p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/SetRiskConfigurationRequestMarshaller;->marshall(Lcom/amazonaws/services/cognitoidentityprovider/model/SetRiskConfigurationRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 5021
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 5023
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 5024
    nop

    .line 5025
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/SetRiskConfigurationResultJsonUnmarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/SetRiskConfigurationResultJsonUnmarshaller;-><init>()V

    .line 5026
    .local v5, "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/SetRiskConfigurationResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    new-instance v6, Lcom/amazonaws/http/JsonResponseHandler;

    invoke-direct {v6, v5}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 5029
    .local v6, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/SetRiskConfigurationResult;>;"
    invoke-direct {p0, v2, v6, v0}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v7

    move-object v3, v7

    .line 5031
    invoke-virtual {v3}, Lcom/amazonaws/Response;->getAwsResponse()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/amazonaws/services/cognitoidentityprovider/model/SetRiskConfigurationResult;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 5033
    sget-object v8, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v8}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 5034
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 5031
    return-object v7

    .line 5023
    .end local v5    # "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/SetRiskConfigurationResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    .end local v6    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/SetRiskConfigurationResult;>;"
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 5024
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/SetRiskConfigurationRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/SetRiskConfigurationResult;>;"
    .end local p1    # "setRiskConfigurationRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/SetRiskConfigurationRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 5033
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/SetRiskConfigurationRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/SetRiskConfigurationResult;>;"
    .restart local p1    # "setRiskConfigurationRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/SetRiskConfigurationRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 5034
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 5035
    throw v5
.end method

.method public setUICustomization(Lcom/amazonaws/services/cognitoidentityprovider/model/SetUICustomizationRequest;)Lcom/amazonaws/services/cognitoidentityprovider/model/SetUICustomizationResult;
    .locals 9
    .param p1, "setUICustomizationRequest"    # Lcom/amazonaws/services/cognitoidentityprovider/model/SetUICustomizationRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 5078
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 5079
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 5080
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 5081
    const/4 v2, 0x0

    .line 5082
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/SetUICustomizationRequest;>;"
    const/4 v3, 0x0

    .line 5084
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/SetUICustomizationResult;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 5086
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/SetUICustomizationRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/SetUICustomizationRequestMarshaller;-><init>()V

    .line 5087
    invoke-virtual {v5, p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/SetUICustomizationRequestMarshaller;->marshall(Lcom/amazonaws/services/cognitoidentityprovider/model/SetUICustomizationRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 5089
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 5091
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 5092
    nop

    .line 5093
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/SetUICustomizationResultJsonUnmarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/SetUICustomizationResultJsonUnmarshaller;-><init>()V

    .line 5094
    .local v5, "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/SetUICustomizationResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    new-instance v6, Lcom/amazonaws/http/JsonResponseHandler;

    invoke-direct {v6, v5}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 5097
    .local v6, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/SetUICustomizationResult;>;"
    invoke-direct {p0, v2, v6, v0}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v7

    move-object v3, v7

    .line 5099
    invoke-virtual {v3}, Lcom/amazonaws/Response;->getAwsResponse()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/amazonaws/services/cognitoidentityprovider/model/SetUICustomizationResult;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 5101
    sget-object v8, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v8}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 5102
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 5099
    return-object v7

    .line 5091
    .end local v5    # "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/SetUICustomizationResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    .end local v6    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/SetUICustomizationResult;>;"
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 5092
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/SetUICustomizationRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/SetUICustomizationResult;>;"
    .end local p1    # "setUICustomizationRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/SetUICustomizationRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 5101
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/SetUICustomizationRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/SetUICustomizationResult;>;"
    .restart local p1    # "setUICustomizationRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/SetUICustomizationRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 5102
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 5103
    throw v5
.end method

.method public setUserMFAPreference(Lcom/amazonaws/services/cognitoidentityprovider/model/SetUserMFAPreferenceRequest;)Lcom/amazonaws/services/cognitoidentityprovider/model/SetUserMFAPreferenceResult;
    .locals 9
    .param p1, "setUserMFAPreferenceRequest"    # Lcom/amazonaws/services/cognitoidentityprovider/model/SetUserMFAPreferenceRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 5143
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 5144
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 5145
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 5146
    const/4 v2, 0x0

    .line 5147
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/SetUserMFAPreferenceRequest;>;"
    const/4 v3, 0x0

    .line 5149
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/SetUserMFAPreferenceResult;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 5151
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/SetUserMFAPreferenceRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/SetUserMFAPreferenceRequestMarshaller;-><init>()V

    .line 5152
    invoke-virtual {v5, p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/SetUserMFAPreferenceRequestMarshaller;->marshall(Lcom/amazonaws/services/cognitoidentityprovider/model/SetUserMFAPreferenceRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 5154
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 5156
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 5157
    nop

    .line 5158
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/SetUserMFAPreferenceResultJsonUnmarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/SetUserMFAPreferenceResultJsonUnmarshaller;-><init>()V

    .line 5159
    .local v5, "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/SetUserMFAPreferenceResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    new-instance v6, Lcom/amazonaws/http/JsonResponseHandler;

    invoke-direct {v6, v5}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 5162
    .local v6, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/SetUserMFAPreferenceResult;>;"
    invoke-direct {p0, v2, v6, v0}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v7

    move-object v3, v7

    .line 5164
    invoke-virtual {v3}, Lcom/amazonaws/Response;->getAwsResponse()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/amazonaws/services/cognitoidentityprovider/model/SetUserMFAPreferenceResult;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 5166
    sget-object v8, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v8}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 5167
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 5164
    return-object v7

    .line 5156
    .end local v5    # "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/SetUserMFAPreferenceResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    .end local v6    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/SetUserMFAPreferenceResult;>;"
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 5157
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/SetUserMFAPreferenceRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/SetUserMFAPreferenceResult;>;"
    .end local p1    # "setUserMFAPreferenceRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/SetUserMFAPreferenceRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 5166
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/SetUserMFAPreferenceRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/SetUserMFAPreferenceResult;>;"
    .restart local p1    # "setUserMFAPreferenceRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/SetUserMFAPreferenceRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 5167
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 5168
    throw v5
.end method

.method public setUserPoolMfaConfig(Lcom/amazonaws/services/cognitoidentityprovider/model/SetUserPoolMfaConfigRequest;)Lcom/amazonaws/services/cognitoidentityprovider/model/SetUserPoolMfaConfigResult;
    .locals 9
    .param p1, "setUserPoolMfaConfigRequest"    # Lcom/amazonaws/services/cognitoidentityprovider/model/SetUserPoolMfaConfigRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 5198
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 5199
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 5200
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 5201
    const/4 v2, 0x0

    .line 5202
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/SetUserPoolMfaConfigRequest;>;"
    const/4 v3, 0x0

    .line 5204
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/SetUserPoolMfaConfigResult;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 5206
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/SetUserPoolMfaConfigRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/SetUserPoolMfaConfigRequestMarshaller;-><init>()V

    .line 5207
    invoke-virtual {v5, p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/SetUserPoolMfaConfigRequestMarshaller;->marshall(Lcom/amazonaws/services/cognitoidentityprovider/model/SetUserPoolMfaConfigRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 5209
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 5211
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 5212
    nop

    .line 5213
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/SetUserPoolMfaConfigResultJsonUnmarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/SetUserPoolMfaConfigResultJsonUnmarshaller;-><init>()V

    .line 5214
    .local v5, "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/SetUserPoolMfaConfigResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    new-instance v6, Lcom/amazonaws/http/JsonResponseHandler;

    invoke-direct {v6, v5}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 5217
    .local v6, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/SetUserPoolMfaConfigResult;>;"
    invoke-direct {p0, v2, v6, v0}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v7

    move-object v3, v7

    .line 5219
    invoke-virtual {v3}, Lcom/amazonaws/Response;->getAwsResponse()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/amazonaws/services/cognitoidentityprovider/model/SetUserPoolMfaConfigResult;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 5221
    sget-object v8, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v8}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 5222
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 5219
    return-object v7

    .line 5211
    .end local v5    # "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/SetUserPoolMfaConfigResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    .end local v6    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/SetUserPoolMfaConfigResult;>;"
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 5212
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/SetUserPoolMfaConfigRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/SetUserPoolMfaConfigResult;>;"
    .end local p1    # "setUserPoolMfaConfigRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/SetUserPoolMfaConfigRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 5221
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/SetUserPoolMfaConfigRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/SetUserPoolMfaConfigResult;>;"
    .restart local p1    # "setUserPoolMfaConfigRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/SetUserPoolMfaConfigRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 5222
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 5223
    throw v5
.end method

.method public setUserSettings(Lcom/amazonaws/services/cognitoidentityprovider/model/SetUserSettingsRequest;)Lcom/amazonaws/services/cognitoidentityprovider/model/SetUserSettingsResult;
    .locals 9
    .param p1, "setUserSettingsRequest"    # Lcom/amazonaws/services/cognitoidentityprovider/model/SetUserSettingsRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 5257
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 5258
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 5259
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 5260
    const/4 v2, 0x0

    .line 5261
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/SetUserSettingsRequest;>;"
    const/4 v3, 0x0

    .line 5263
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/SetUserSettingsResult;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 5265
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/SetUserSettingsRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/SetUserSettingsRequestMarshaller;-><init>()V

    invoke-virtual {v5, p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/SetUserSettingsRequestMarshaller;->marshall(Lcom/amazonaws/services/cognitoidentityprovider/model/SetUserSettingsRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 5267
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 5269
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 5270
    nop

    .line 5271
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/SetUserSettingsResultJsonUnmarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/SetUserSettingsResultJsonUnmarshaller;-><init>()V

    .line 5272
    .local v5, "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/SetUserSettingsResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    new-instance v6, Lcom/amazonaws/http/JsonResponseHandler;

    invoke-direct {v6, v5}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 5275
    .local v6, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/SetUserSettingsResult;>;"
    invoke-direct {p0, v2, v6, v0}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v7

    move-object v3, v7

    .line 5277
    invoke-virtual {v3}, Lcom/amazonaws/Response;->getAwsResponse()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/amazonaws/services/cognitoidentityprovider/model/SetUserSettingsResult;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 5279
    sget-object v8, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v8}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 5280
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 5277
    return-object v7

    .line 5269
    .end local v5    # "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/SetUserSettingsResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    .end local v6    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/SetUserSettingsResult;>;"
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 5270
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/SetUserSettingsRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/SetUserSettingsResult;>;"
    .end local p1    # "setUserSettingsRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/SetUserSettingsRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 5279
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/SetUserSettingsRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/SetUserSettingsResult;>;"
    .restart local p1    # "setUserSettingsRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/SetUserSettingsRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 5280
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 5281
    throw v5
.end method

.method public signUp(Lcom/amazonaws/services/cognitoidentityprovider/model/SignUpRequest;)Lcom/amazonaws/services/cognitoidentityprovider/model/SignUpResult;
    .locals 9
    .param p1, "signUpRequest"    # Lcom/amazonaws/services/cognitoidentityprovider/model/SignUpRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 5319
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 5320
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 5321
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 5322
    const/4 v2, 0x0

    .line 5323
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/SignUpRequest;>;"
    const/4 v3, 0x0

    .line 5325
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/SignUpResult;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 5327
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/SignUpRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/SignUpRequestMarshaller;-><init>()V

    invoke-virtual {v5, p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/SignUpRequestMarshaller;->marshall(Lcom/amazonaws/services/cognitoidentityprovider/model/SignUpRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 5329
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 5331
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 5332
    nop

    .line 5333
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/SignUpResultJsonUnmarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/SignUpResultJsonUnmarshaller;-><init>()V

    .line 5334
    .local v5, "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/SignUpResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    new-instance v6, Lcom/amazonaws/http/JsonResponseHandler;

    invoke-direct {v6, v5}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 5337
    .local v6, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/SignUpResult;>;"
    invoke-direct {p0, v2, v6, v0}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v7

    move-object v3, v7

    .line 5339
    invoke-virtual {v3}, Lcom/amazonaws/Response;->getAwsResponse()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/amazonaws/services/cognitoidentityprovider/model/SignUpResult;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 5341
    sget-object v8, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v8}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 5342
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 5339
    return-object v7

    .line 5331
    .end local v5    # "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/SignUpResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    .end local v6    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/SignUpResult;>;"
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 5332
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/SignUpRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/SignUpResult;>;"
    .end local p1    # "signUpRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/SignUpRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 5341
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/SignUpRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/SignUpResult;>;"
    .restart local p1    # "signUpRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/SignUpRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 5342
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 5343
    throw v5
.end method

.method public startUserImportJob(Lcom/amazonaws/services/cognitoidentityprovider/model/StartUserImportJobRequest;)Lcom/amazonaws/services/cognitoidentityprovider/model/StartUserImportJobResult;
    .locals 9
    .param p1, "startUserImportJobRequest"    # Lcom/amazonaws/services/cognitoidentityprovider/model/StartUserImportJobRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 5373
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 5374
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 5375
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 5376
    const/4 v2, 0x0

    .line 5377
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/StartUserImportJobRequest;>;"
    const/4 v3, 0x0

    .line 5379
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/StartUserImportJobResult;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 5381
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/StartUserImportJobRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/StartUserImportJobRequestMarshaller;-><init>()V

    .line 5382
    invoke-virtual {v5, p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/StartUserImportJobRequestMarshaller;->marshall(Lcom/amazonaws/services/cognitoidentityprovider/model/StartUserImportJobRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 5384
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 5386
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 5387
    nop

    .line 5388
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/StartUserImportJobResultJsonUnmarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/StartUserImportJobResultJsonUnmarshaller;-><init>()V

    .line 5389
    .local v5, "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/StartUserImportJobResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    new-instance v6, Lcom/amazonaws/http/JsonResponseHandler;

    invoke-direct {v6, v5}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 5392
    .local v6, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/StartUserImportJobResult;>;"
    invoke-direct {p0, v2, v6, v0}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v7

    move-object v3, v7

    .line 5394
    invoke-virtual {v3}, Lcom/amazonaws/Response;->getAwsResponse()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/amazonaws/services/cognitoidentityprovider/model/StartUserImportJobResult;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 5396
    sget-object v8, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v8}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 5397
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 5394
    return-object v7

    .line 5386
    .end local v5    # "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/StartUserImportJobResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    .end local v6    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/StartUserImportJobResult;>;"
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 5387
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/StartUserImportJobRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/StartUserImportJobResult;>;"
    .end local p1    # "startUserImportJobRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/StartUserImportJobRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 5396
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/StartUserImportJobRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/StartUserImportJobResult;>;"
    .restart local p1    # "startUserImportJobRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/StartUserImportJobRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 5397
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 5398
    throw v5
.end method

.method public stopUserImportJob(Lcom/amazonaws/services/cognitoidentityprovider/model/StopUserImportJobRequest;)Lcom/amazonaws/services/cognitoidentityprovider/model/StopUserImportJobResult;
    .locals 9
    .param p1, "stopUserImportJobRequest"    # Lcom/amazonaws/services/cognitoidentityprovider/model/StopUserImportJobRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 5428
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 5429
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 5430
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 5431
    const/4 v2, 0x0

    .line 5432
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/StopUserImportJobRequest;>;"
    const/4 v3, 0x0

    .line 5434
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/StopUserImportJobResult;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 5436
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/StopUserImportJobRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/StopUserImportJobRequestMarshaller;-><init>()V

    .line 5437
    invoke-virtual {v5, p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/StopUserImportJobRequestMarshaller;->marshall(Lcom/amazonaws/services/cognitoidentityprovider/model/StopUserImportJobRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 5439
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 5441
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 5442
    nop

    .line 5443
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/StopUserImportJobResultJsonUnmarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/StopUserImportJobResultJsonUnmarshaller;-><init>()V

    .line 5444
    .local v5, "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/StopUserImportJobResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    new-instance v6, Lcom/amazonaws/http/JsonResponseHandler;

    invoke-direct {v6, v5}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 5447
    .local v6, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/StopUserImportJobResult;>;"
    invoke-direct {p0, v2, v6, v0}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v7

    move-object v3, v7

    .line 5449
    invoke-virtual {v3}, Lcom/amazonaws/Response;->getAwsResponse()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/amazonaws/services/cognitoidentityprovider/model/StopUserImportJobResult;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 5451
    sget-object v8, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v8}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 5452
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 5449
    return-object v7

    .line 5441
    .end local v5    # "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/StopUserImportJobResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    .end local v6    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/StopUserImportJobResult;>;"
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 5442
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/StopUserImportJobRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/StopUserImportJobResult;>;"
    .end local p1    # "stopUserImportJobRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/StopUserImportJobRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 5451
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/StopUserImportJobRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/StopUserImportJobResult;>;"
    .restart local p1    # "stopUserImportJobRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/StopUserImportJobRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 5452
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 5453
    throw v5
.end method

.method public tagResource(Lcom/amazonaws/services/cognitoidentityprovider/model/TagResourceRequest;)Lcom/amazonaws/services/cognitoidentityprovider/model/TagResourceResult;
    .locals 9
    .param p1, "tagResourceRequest"    # Lcom/amazonaws/services/cognitoidentityprovider/model/TagResourceRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 5500
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 5501
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 5502
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 5503
    const/4 v2, 0x0

    .line 5504
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/TagResourceRequest;>;"
    const/4 v3, 0x0

    .line 5506
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/TagResourceResult;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 5508
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/TagResourceRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/TagResourceRequestMarshaller;-><init>()V

    invoke-virtual {v5, p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/TagResourceRequestMarshaller;->marshall(Lcom/amazonaws/services/cognitoidentityprovider/model/TagResourceRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 5510
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 5512
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 5513
    nop

    .line 5514
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/TagResourceResultJsonUnmarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/TagResourceResultJsonUnmarshaller;-><init>()V

    .line 5515
    .local v5, "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/TagResourceResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    new-instance v6, Lcom/amazonaws/http/JsonResponseHandler;

    invoke-direct {v6, v5}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 5518
    .local v6, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/TagResourceResult;>;"
    invoke-direct {p0, v2, v6, v0}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v7

    move-object v3, v7

    .line 5520
    invoke-virtual {v3}, Lcom/amazonaws/Response;->getAwsResponse()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/amazonaws/services/cognitoidentityprovider/model/TagResourceResult;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 5522
    sget-object v8, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v8}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 5523
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 5520
    return-object v7

    .line 5512
    .end local v5    # "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/TagResourceResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    .end local v6    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/TagResourceResult;>;"
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 5513
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/TagResourceRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/TagResourceResult;>;"
    .end local p1    # "tagResourceRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/TagResourceRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 5522
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/TagResourceRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/TagResourceResult;>;"
    .restart local p1    # "tagResourceRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/TagResourceRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 5523
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 5524
    throw v5
.end method

.method public untagResource(Lcom/amazonaws/services/cognitoidentityprovider/model/UntagResourceRequest;)Lcom/amazonaws/services/cognitoidentityprovider/model/UntagResourceResult;
    .locals 9
    .param p1, "untagResourceRequest"    # Lcom/amazonaws/services/cognitoidentityprovider/model/UntagResourceRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 5551
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 5552
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 5553
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 5554
    const/4 v2, 0x0

    .line 5555
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/UntagResourceRequest;>;"
    const/4 v3, 0x0

    .line 5557
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/UntagResourceResult;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 5559
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/UntagResourceRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/UntagResourceRequestMarshaller;-><init>()V

    invoke-virtual {v5, p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/UntagResourceRequestMarshaller;->marshall(Lcom/amazonaws/services/cognitoidentityprovider/model/UntagResourceRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 5561
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 5563
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 5564
    nop

    .line 5565
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/UntagResourceResultJsonUnmarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/UntagResourceResultJsonUnmarshaller;-><init>()V

    .line 5566
    .local v5, "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/UntagResourceResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    new-instance v6, Lcom/amazonaws/http/JsonResponseHandler;

    invoke-direct {v6, v5}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 5569
    .local v6, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/UntagResourceResult;>;"
    invoke-direct {p0, v2, v6, v0}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v7

    move-object v3, v7

    .line 5571
    invoke-virtual {v3}, Lcom/amazonaws/Response;->getAwsResponse()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/amazonaws/services/cognitoidentityprovider/model/UntagResourceResult;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 5573
    sget-object v8, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v8}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 5574
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 5571
    return-object v7

    .line 5563
    .end local v5    # "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/UntagResourceResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    .end local v6    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/UntagResourceResult;>;"
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 5564
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/UntagResourceRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/UntagResourceResult;>;"
    .end local p1    # "untagResourceRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/UntagResourceRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 5573
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/UntagResourceRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/UntagResourceResult;>;"
    .restart local p1    # "untagResourceRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/UntagResourceRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 5574
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 5575
    throw v5
.end method

.method public updateAuthEventFeedback(Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateAuthEventFeedbackRequest;)Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateAuthEventFeedbackResult;
    .locals 9
    .param p1, "updateAuthEventFeedbackRequest"    # Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateAuthEventFeedbackRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 5608
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 5609
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 5610
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 5611
    const/4 v2, 0x0

    .line 5612
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateAuthEventFeedbackRequest;>;"
    const/4 v3, 0x0

    .line 5614
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateAuthEventFeedbackResult;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 5616
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/UpdateAuthEventFeedbackRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/UpdateAuthEventFeedbackRequestMarshaller;-><init>()V

    .line 5617
    invoke-virtual {v5, p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/UpdateAuthEventFeedbackRequestMarshaller;->marshall(Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateAuthEventFeedbackRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 5619
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 5621
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 5622
    nop

    .line 5623
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/UpdateAuthEventFeedbackResultJsonUnmarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/UpdateAuthEventFeedbackResultJsonUnmarshaller;-><init>()V

    .line 5624
    .local v5, "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateAuthEventFeedbackResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    new-instance v6, Lcom/amazonaws/http/JsonResponseHandler;

    invoke-direct {v6, v5}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 5627
    .local v6, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateAuthEventFeedbackResult;>;"
    invoke-direct {p0, v2, v6, v0}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v7

    move-object v3, v7

    .line 5629
    invoke-virtual {v3}, Lcom/amazonaws/Response;->getAwsResponse()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateAuthEventFeedbackResult;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 5631
    sget-object v8, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v8}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 5632
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 5629
    return-object v7

    .line 5621
    .end local v5    # "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateAuthEventFeedbackResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    .end local v6    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateAuthEventFeedbackResult;>;"
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 5622
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateAuthEventFeedbackRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateAuthEventFeedbackResult;>;"
    .end local p1    # "updateAuthEventFeedbackRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateAuthEventFeedbackRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 5631
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateAuthEventFeedbackRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateAuthEventFeedbackResult;>;"
    .restart local p1    # "updateAuthEventFeedbackRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateAuthEventFeedbackRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 5632
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 5633
    throw v5
.end method

.method public updateDeviceStatus(Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateDeviceStatusRequest;)Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateDeviceStatusResult;
    .locals 9
    .param p1, "updateDeviceStatusRequest"    # Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateDeviceStatusRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 5666
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 5667
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 5668
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 5669
    const/4 v2, 0x0

    .line 5670
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateDeviceStatusRequest;>;"
    const/4 v3, 0x0

    .line 5672
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateDeviceStatusResult;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 5674
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/UpdateDeviceStatusRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/UpdateDeviceStatusRequestMarshaller;-><init>()V

    .line 5675
    invoke-virtual {v5, p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/UpdateDeviceStatusRequestMarshaller;->marshall(Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateDeviceStatusRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 5677
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 5679
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 5680
    nop

    .line 5681
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/UpdateDeviceStatusResultJsonUnmarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/UpdateDeviceStatusResultJsonUnmarshaller;-><init>()V

    .line 5682
    .local v5, "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateDeviceStatusResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    new-instance v6, Lcom/amazonaws/http/JsonResponseHandler;

    invoke-direct {v6, v5}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 5685
    .local v6, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateDeviceStatusResult;>;"
    invoke-direct {p0, v2, v6, v0}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v7

    move-object v3, v7

    .line 5687
    invoke-virtual {v3}, Lcom/amazonaws/Response;->getAwsResponse()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateDeviceStatusResult;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 5689
    sget-object v8, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v8}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 5690
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 5687
    return-object v7

    .line 5679
    .end local v5    # "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateDeviceStatusResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    .end local v6    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateDeviceStatusResult;>;"
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 5680
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateDeviceStatusRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateDeviceStatusResult;>;"
    .end local p1    # "updateDeviceStatusRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateDeviceStatusRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 5689
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateDeviceStatusRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateDeviceStatusResult;>;"
    .restart local p1    # "updateDeviceStatusRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateDeviceStatusRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 5690
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 5691
    throw v5
.end method

.method public updateGroup(Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateGroupRequest;)Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateGroupResult;
    .locals 9
    .param p1, "updateGroupRequest"    # Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateGroupRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 5726
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 5727
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 5728
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 5729
    const/4 v2, 0x0

    .line 5730
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateGroupRequest;>;"
    const/4 v3, 0x0

    .line 5732
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateGroupResult;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 5734
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/UpdateGroupRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/UpdateGroupRequestMarshaller;-><init>()V

    invoke-virtual {v5, p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/UpdateGroupRequestMarshaller;->marshall(Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateGroupRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 5736
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 5738
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 5739
    nop

    .line 5740
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/UpdateGroupResultJsonUnmarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/UpdateGroupResultJsonUnmarshaller;-><init>()V

    .line 5741
    .local v5, "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateGroupResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    new-instance v6, Lcom/amazonaws/http/JsonResponseHandler;

    invoke-direct {v6, v5}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 5744
    .local v6, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateGroupResult;>;"
    invoke-direct {p0, v2, v6, v0}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v7

    move-object v3, v7

    .line 5746
    invoke-virtual {v3}, Lcom/amazonaws/Response;->getAwsResponse()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateGroupResult;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 5748
    sget-object v8, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v8}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 5749
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 5746
    return-object v7

    .line 5738
    .end local v5    # "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateGroupResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    .end local v6    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateGroupResult;>;"
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 5739
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateGroupRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateGroupResult;>;"
    .end local p1    # "updateGroupRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateGroupRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 5748
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateGroupRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateGroupResult;>;"
    .restart local p1    # "updateGroupRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateGroupRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 5749
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 5750
    throw v5
.end method

.method public updateIdentityProvider(Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateIdentityProviderRequest;)Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateIdentityProviderResult;
    .locals 9
    .param p1, "updateIdentityProviderRequest"    # Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateIdentityProviderRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 5779
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 5780
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 5781
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 5782
    const/4 v2, 0x0

    .line 5783
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateIdentityProviderRequest;>;"
    const/4 v3, 0x0

    .line 5785
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateIdentityProviderResult;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 5787
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/UpdateIdentityProviderRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/UpdateIdentityProviderRequestMarshaller;-><init>()V

    .line 5788
    invoke-virtual {v5, p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/UpdateIdentityProviderRequestMarshaller;->marshall(Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateIdentityProviderRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 5790
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 5792
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 5793
    nop

    .line 5794
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/UpdateIdentityProviderResultJsonUnmarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/UpdateIdentityProviderResultJsonUnmarshaller;-><init>()V

    .line 5795
    .local v5, "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateIdentityProviderResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    new-instance v6, Lcom/amazonaws/http/JsonResponseHandler;

    invoke-direct {v6, v5}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 5798
    .local v6, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateIdentityProviderResult;>;"
    invoke-direct {p0, v2, v6, v0}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v7

    move-object v3, v7

    .line 5800
    invoke-virtual {v3}, Lcom/amazonaws/Response;->getAwsResponse()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateIdentityProviderResult;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 5802
    sget-object v8, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v8}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 5803
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 5800
    return-object v7

    .line 5792
    .end local v5    # "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateIdentityProviderResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    .end local v6    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateIdentityProviderResult;>;"
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 5793
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateIdentityProviderRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateIdentityProviderResult;>;"
    .end local p1    # "updateIdentityProviderRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateIdentityProviderRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 5802
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateIdentityProviderRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateIdentityProviderResult;>;"
    .restart local p1    # "updateIdentityProviderRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateIdentityProviderRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 5803
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 5804
    throw v5
.end method

.method public updateResourceServer(Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateResourceServerRequest;)Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateResourceServerResult;
    .locals 9
    .param p1, "updateResourceServerRequest"    # Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateResourceServerRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 5839
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

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
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateResourceServerRequest;>;"
    const/4 v3, 0x0

    .line 5845
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateResourceServerResult;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 5847
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/UpdateResourceServerRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/UpdateResourceServerRequestMarshaller;-><init>()V

    .line 5848
    invoke-virtual {v5, p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/UpdateResourceServerRequestMarshaller;->marshall(Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateResourceServerRequest;)Lcom/amazonaws/Request;

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
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/UpdateResourceServerResultJsonUnmarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/UpdateResourceServerResultJsonUnmarshaller;-><init>()V

    .line 5855
    .local v5, "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateResourceServerResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    new-instance v6, Lcom/amazonaws/http/JsonResponseHandler;

    invoke-direct {v6, v5}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 5858
    .local v6, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateResourceServerResult;>;"
    invoke-direct {p0, v2, v6, v0}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v7

    move-object v3, v7

    .line 5860
    invoke-virtual {v3}, Lcom/amazonaws/Response;->getAwsResponse()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateResourceServerResult;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 5862
    sget-object v8, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v8}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 5863
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 5860
    return-object v7

    .line 5852
    .end local v5    # "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateResourceServerResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    .end local v6    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateResourceServerResult;>;"
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 5853
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateResourceServerRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateResourceServerResult;>;"
    .end local p1    # "updateResourceServerRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateResourceServerRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 5862
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateResourceServerRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateResourceServerResult;>;"
    .restart local p1    # "updateResourceServerRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateResourceServerRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 5863
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 5864
    throw v5
.end method

.method public updateUserAttributes(Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateUserAttributesRequest;)Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateUserAttributesResult;
    .locals 9
    .param p1, "updateUserAttributesRequest"    # Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateUserAttributesRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 5907
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 5908
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 5909
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 5910
    const/4 v2, 0x0

    .line 5911
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateUserAttributesRequest;>;"
    const/4 v3, 0x0

    .line 5913
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateUserAttributesResult;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 5915
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/UpdateUserAttributesRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/UpdateUserAttributesRequestMarshaller;-><init>()V

    .line 5916
    invoke-virtual {v5, p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/UpdateUserAttributesRequestMarshaller;->marshall(Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateUserAttributesRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 5918
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 5920
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 5921
    nop

    .line 5922
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/UpdateUserAttributesResultJsonUnmarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/UpdateUserAttributesResultJsonUnmarshaller;-><init>()V

    .line 5923
    .local v5, "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateUserAttributesResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    new-instance v6, Lcom/amazonaws/http/JsonResponseHandler;

    invoke-direct {v6, v5}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 5926
    .local v6, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateUserAttributesResult;>;"
    invoke-direct {p0, v2, v6, v0}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v7

    move-object v3, v7

    .line 5928
    invoke-virtual {v3}, Lcom/amazonaws/Response;->getAwsResponse()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateUserAttributesResult;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 5930
    sget-object v8, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v8}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 5931
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 5928
    return-object v7

    .line 5920
    .end local v5    # "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateUserAttributesResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    .end local v6    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateUserAttributesResult;>;"
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 5921
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateUserAttributesRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateUserAttributesResult;>;"
    .end local p1    # "updateUserAttributesRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateUserAttributesRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 5930
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateUserAttributesRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateUserAttributesResult;>;"
    .restart local p1    # "updateUserAttributesRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateUserAttributesRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 5931
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 5932
    throw v5
.end method

.method public updateUserPool(Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateUserPoolRequest;)Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateUserPoolResult;
    .locals 9
    .param p1, "updateUserPoolRequest"    # Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateUserPoolRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 5975
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 5976
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 5977
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 5978
    const/4 v2, 0x0

    .line 5979
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateUserPoolRequest;>;"
    const/4 v3, 0x0

    .line 5981
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateUserPoolResult;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 5983
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/UpdateUserPoolRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/UpdateUserPoolRequestMarshaller;-><init>()V

    invoke-virtual {v5, p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/UpdateUserPoolRequestMarshaller;->marshall(Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateUserPoolRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 5985
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 5987
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 5988
    nop

    .line 5989
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/UpdateUserPoolResultJsonUnmarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/UpdateUserPoolResultJsonUnmarshaller;-><init>()V

    .line 5990
    .local v5, "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateUserPoolResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    new-instance v6, Lcom/amazonaws/http/JsonResponseHandler;

    invoke-direct {v6, v5}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 5993
    .local v6, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateUserPoolResult;>;"
    invoke-direct {p0, v2, v6, v0}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v7

    move-object v3, v7

    .line 5995
    invoke-virtual {v3}, Lcom/amazonaws/Response;->getAwsResponse()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateUserPoolResult;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 5997
    sget-object v8, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v8}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 5998
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 5995
    return-object v7

    .line 5987
    .end local v5    # "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateUserPoolResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    .end local v6    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateUserPoolResult;>;"
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 5988
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateUserPoolRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateUserPoolResult;>;"
    .end local p1    # "updateUserPoolRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateUserPoolRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 5997
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateUserPoolRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateUserPoolResult;>;"
    .restart local p1    # "updateUserPoolRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateUserPoolRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 5998
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 5999
    throw v5
.end method

.method public updateUserPoolClient(Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateUserPoolClientRequest;)Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateUserPoolClientResult;
    .locals 9
    .param p1, "updateUserPoolClientRequest"    # Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateUserPoolClientRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 6042
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 6043
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 6044
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 6045
    const/4 v2, 0x0

    .line 6046
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateUserPoolClientRequest;>;"
    const/4 v3, 0x0

    .line 6048
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateUserPoolClientResult;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 6050
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/UpdateUserPoolClientRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/UpdateUserPoolClientRequestMarshaller;-><init>()V

    .line 6051
    invoke-virtual {v5, p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/UpdateUserPoolClientRequestMarshaller;->marshall(Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateUserPoolClientRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 6053
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 6055
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 6056
    nop

    .line 6057
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/UpdateUserPoolClientResultJsonUnmarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/UpdateUserPoolClientResultJsonUnmarshaller;-><init>()V

    .line 6058
    .local v5, "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateUserPoolClientResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    new-instance v6, Lcom/amazonaws/http/JsonResponseHandler;

    invoke-direct {v6, v5}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 6061
    .local v6, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateUserPoolClientResult;>;"
    invoke-direct {p0, v2, v6, v0}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v7

    move-object v3, v7

    .line 6063
    invoke-virtual {v3}, Lcom/amazonaws/Response;->getAwsResponse()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateUserPoolClientResult;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 6065
    sget-object v8, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v8}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 6066
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 6063
    return-object v7

    .line 6055
    .end local v5    # "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateUserPoolClientResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    .end local v6    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateUserPoolClientResult;>;"
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 6056
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateUserPoolClientRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateUserPoolClientResult;>;"
    .end local p1    # "updateUserPoolClientRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateUserPoolClientRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 6065
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateUserPoolClientRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateUserPoolClientResult;>;"
    .restart local p1    # "updateUserPoolClientRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateUserPoolClientRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 6066
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 6067
    throw v5
.end method

.method public updateUserPoolDomain(Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateUserPoolDomainRequest;)Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateUserPoolDomainResult;
    .locals 9
    .param p1, "updateUserPoolDomainRequest"    # Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateUserPoolDomainRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 6135
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 6136
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 6137
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 6138
    const/4 v2, 0x0

    .line 6139
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateUserPoolDomainRequest;>;"
    const/4 v3, 0x0

    .line 6141
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateUserPoolDomainResult;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 6143
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/UpdateUserPoolDomainRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/UpdateUserPoolDomainRequestMarshaller;-><init>()V

    .line 6144
    invoke-virtual {v5, p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/UpdateUserPoolDomainRequestMarshaller;->marshall(Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateUserPoolDomainRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 6146
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 6148
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 6149
    nop

    .line 6150
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/UpdateUserPoolDomainResultJsonUnmarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/UpdateUserPoolDomainResultJsonUnmarshaller;-><init>()V

    .line 6151
    .local v5, "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateUserPoolDomainResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    new-instance v6, Lcom/amazonaws/http/JsonResponseHandler;

    invoke-direct {v6, v5}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 6154
    .local v6, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateUserPoolDomainResult;>;"
    invoke-direct {p0, v2, v6, v0}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v7

    move-object v3, v7

    .line 6156
    invoke-virtual {v3}, Lcom/amazonaws/Response;->getAwsResponse()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateUserPoolDomainResult;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 6158
    sget-object v8, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v8}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 6159
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 6156
    return-object v7

    .line 6148
    .end local v5    # "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateUserPoolDomainResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    .end local v6    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateUserPoolDomainResult;>;"
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 6149
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateUserPoolDomainRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateUserPoolDomainResult;>;"
    .end local p1    # "updateUserPoolDomainRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateUserPoolDomainRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 6158
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateUserPoolDomainRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateUserPoolDomainResult;>;"
    .restart local p1    # "updateUserPoolDomainRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateUserPoolDomainRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 6159
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 6160
    throw v5
.end method

.method public verifySoftwareToken(Lcom/amazonaws/services/cognitoidentityprovider/model/VerifySoftwareTokenRequest;)Lcom/amazonaws/services/cognitoidentityprovider/model/VerifySoftwareTokenResult;
    .locals 9
    .param p1, "verifySoftwareTokenRequest"    # Lcom/amazonaws/services/cognitoidentityprovider/model/VerifySoftwareTokenRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 6198
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 6199
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 6200
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 6201
    const/4 v2, 0x0

    .line 6202
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/VerifySoftwareTokenRequest;>;"
    const/4 v3, 0x0

    .line 6204
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/VerifySoftwareTokenResult;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 6206
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/VerifySoftwareTokenRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/VerifySoftwareTokenRequestMarshaller;-><init>()V

    .line 6207
    invoke-virtual {v5, p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/VerifySoftwareTokenRequestMarshaller;->marshall(Lcom/amazonaws/services/cognitoidentityprovider/model/VerifySoftwareTokenRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 6209
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 6211
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 6212
    nop

    .line 6213
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/VerifySoftwareTokenResultJsonUnmarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/VerifySoftwareTokenResultJsonUnmarshaller;-><init>()V

    .line 6214
    .local v5, "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/VerifySoftwareTokenResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    new-instance v6, Lcom/amazonaws/http/JsonResponseHandler;

    invoke-direct {v6, v5}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 6217
    .local v6, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/VerifySoftwareTokenResult;>;"
    invoke-direct {p0, v2, v6, v0}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v7

    move-object v3, v7

    .line 6219
    invoke-virtual {v3}, Lcom/amazonaws/Response;->getAwsResponse()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/amazonaws/services/cognitoidentityprovider/model/VerifySoftwareTokenResult;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 6221
    sget-object v8, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v8}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 6222
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 6219
    return-object v7

    .line 6211
    .end local v5    # "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/VerifySoftwareTokenResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    .end local v6    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/VerifySoftwareTokenResult;>;"
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 6212
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/VerifySoftwareTokenRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/VerifySoftwareTokenResult;>;"
    .end local p1    # "verifySoftwareTokenRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/VerifySoftwareTokenRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 6221
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/VerifySoftwareTokenRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/VerifySoftwareTokenResult;>;"
    .restart local p1    # "verifySoftwareTokenRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/VerifySoftwareTokenRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 6222
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 6223
    throw v5
.end method

.method public verifyUserAttribute(Lcom/amazonaws/services/cognitoidentityprovider/model/VerifyUserAttributeRequest;)Lcom/amazonaws/services/cognitoidentityprovider/model/VerifyUserAttributeResult;
    .locals 9
    .param p1, "verifyUserAttributeRequest"    # Lcom/amazonaws/services/cognitoidentityprovider/model/VerifyUserAttributeRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 6259
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 6260
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 6261
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 6262
    const/4 v2, 0x0

    .line 6263
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/VerifyUserAttributeRequest;>;"
    const/4 v3, 0x0

    .line 6265
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/VerifyUserAttributeResult;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 6267
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/VerifyUserAttributeRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/VerifyUserAttributeRequestMarshaller;-><init>()V

    .line 6268
    invoke-virtual {v5, p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/VerifyUserAttributeRequestMarshaller;->marshall(Lcom/amazonaws/services/cognitoidentityprovider/model/VerifyUserAttributeRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 6270
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 6272
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 6273
    nop

    .line 6274
    new-instance v5, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/VerifyUserAttributeResultJsonUnmarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentityprovider/model/transform/VerifyUserAttributeResultJsonUnmarshaller;-><init>()V

    .line 6275
    .local v5, "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/VerifyUserAttributeResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    new-instance v6, Lcom/amazonaws/http/JsonResponseHandler;

    invoke-direct {v6, v5}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 6278
    .local v6, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/VerifyUserAttributeResult;>;"
    invoke-direct {p0, v2, v6, v0}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v7

    move-object v3, v7

    .line 6280
    invoke-virtual {v3}, Lcom/amazonaws/Response;->getAwsResponse()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/amazonaws/services/cognitoidentityprovider/model/VerifyUserAttributeResult;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 6282
    sget-object v8, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v8}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 6283
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 6280
    return-object v7

    .line 6272
    .end local v5    # "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentityprovider/model/VerifyUserAttributeResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    .end local v6    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentityprovider/model/VerifyUserAttributeResult;>;"
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 6273
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/VerifyUserAttributeRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/VerifyUserAttributeResult;>;"
    .end local p1    # "verifyUserAttributeRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/VerifyUserAttributeRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 6282
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentityprovider/model/VerifyUserAttributeRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentityprovider/model/VerifyUserAttributeResult;>;"
    .restart local p1    # "verifyUserAttributeRequest":Lcom/amazonaws/services/cognitoidentityprovider/model/VerifyUserAttributeRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 6283
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/AmazonCognitoIdentityProviderClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 6284
    throw v5
.end method
