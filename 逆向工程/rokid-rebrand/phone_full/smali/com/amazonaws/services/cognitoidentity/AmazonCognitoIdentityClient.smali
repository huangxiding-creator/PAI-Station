.class public Lcom/amazonaws/services/cognitoidentity/AmazonCognitoIdentityClient;
.super Lcom/amazonaws/AmazonWebServiceClient;
.source "AmazonCognitoIdentityClient.java"

# interfaces
.implements Lcom/amazonaws/services/cognitoidentity/AmazonCognitoIdentity;


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

    .line 94
    new-instance v0, Lcom/amazonaws/auth/DefaultAWSCredentialsProviderChain;

    invoke-direct {v0}, Lcom/amazonaws/auth/DefaultAWSCredentialsProviderChain;-><init>()V

    new-instance v1, Lcom/amazonaws/ClientConfiguration;

    invoke-direct {v1}, Lcom/amazonaws/ClientConfiguration;-><init>()V

    invoke-direct {p0, v0, v1}, Lcom/amazonaws/services/cognitoidentity/AmazonCognitoIdentityClient;-><init>(Lcom/amazonaws/auth/AWSCredentialsProvider;Lcom/amazonaws/ClientConfiguration;)V

    .line 95
    return-void
.end method

.method public constructor <init>(Lcom/amazonaws/ClientConfiguration;)V
    .locals 1
    .param p1, "clientConfiguration"    # Lcom/amazonaws/ClientConfiguration;
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 118
    new-instance v0, Lcom/amazonaws/auth/DefaultAWSCredentialsProviderChain;

    invoke-direct {v0}, Lcom/amazonaws/auth/DefaultAWSCredentialsProviderChain;-><init>()V

    invoke-direct {p0, v0, p1}, Lcom/amazonaws/services/cognitoidentity/AmazonCognitoIdentityClient;-><init>(Lcom/amazonaws/auth/AWSCredentialsProvider;Lcom/amazonaws/ClientConfiguration;)V

    .line 119
    return-void
.end method

.method public constructor <init>(Lcom/amazonaws/auth/AWSCredentials;)V
    .locals 1
    .param p1, "awsCredentials"    # Lcom/amazonaws/auth/AWSCredentials;

    .line 155
    new-instance v0, Lcom/amazonaws/ClientConfiguration;

    invoke-direct {v0}, Lcom/amazonaws/ClientConfiguration;-><init>()V

    invoke-direct {p0, p1, v0}, Lcom/amazonaws/services/cognitoidentity/AmazonCognitoIdentityClient;-><init>(Lcom/amazonaws/auth/AWSCredentials;Lcom/amazonaws/ClientConfiguration;)V

    .line 156
    return-void
.end method

.method public constructor <init>(Lcom/amazonaws/auth/AWSCredentials;Lcom/amazonaws/ClientConfiguration;)V
    .locals 1
    .param p1, "awsCredentials"    # Lcom/amazonaws/auth/AWSCredentials;
    .param p2, "clientConfiguration"    # Lcom/amazonaws/ClientConfiguration;

    .line 197
    new-instance v0, Lcom/amazonaws/internal/StaticCredentialsProvider;

    invoke-direct {v0, p1}, Lcom/amazonaws/internal/StaticCredentialsProvider;-><init>(Lcom/amazonaws/auth/AWSCredentials;)V

    invoke-direct {p0, v0, p2}, Lcom/amazonaws/services/cognitoidentity/AmazonCognitoIdentityClient;-><init>(Lcom/amazonaws/auth/AWSCredentialsProvider;Lcom/amazonaws/ClientConfiguration;)V

    .line 198
    return-void
.end method

.method public constructor <init>(Lcom/amazonaws/auth/AWSCredentialsProvider;)V
    .locals 1
    .param p1, "awsCredentialsProvider"    # Lcom/amazonaws/auth/AWSCredentialsProvider;

    .line 236
    new-instance v0, Lcom/amazonaws/ClientConfiguration;

    invoke-direct {v0}, Lcom/amazonaws/ClientConfiguration;-><init>()V

    invoke-direct {p0, p1, v0}, Lcom/amazonaws/services/cognitoidentity/AmazonCognitoIdentityClient;-><init>(Lcom/amazonaws/auth/AWSCredentialsProvider;Lcom/amazonaws/ClientConfiguration;)V

    .line 237
    return-void
.end method

.method public constructor <init>(Lcom/amazonaws/auth/AWSCredentialsProvider;Lcom/amazonaws/ClientConfiguration;)V
    .locals 1
    .param p1, "awsCredentialsProvider"    # Lcom/amazonaws/auth/AWSCredentialsProvider;
    .param p2, "clientConfiguration"    # Lcom/amazonaws/ClientConfiguration;

    .line 279
    new-instance v0, Lcom/amazonaws/http/UrlHttpClient;

    invoke-direct {v0, p2}, Lcom/amazonaws/http/UrlHttpClient;-><init>(Lcom/amazonaws/ClientConfiguration;)V

    invoke-direct {p0, p1, p2, v0}, Lcom/amazonaws/services/cognitoidentity/AmazonCognitoIdentityClient;-><init>(Lcom/amazonaws/auth/AWSCredentialsProvider;Lcom/amazonaws/ClientConfiguration;Lcom/amazonaws/http/HttpClient;)V

    .line 280
    return-void
.end method

.method public constructor <init>(Lcom/amazonaws/auth/AWSCredentialsProvider;Lcom/amazonaws/ClientConfiguration;Lcom/amazonaws/http/HttpClient;)V
    .locals 1
    .param p1, "awsCredentialsProvider"    # Lcom/amazonaws/auth/AWSCredentialsProvider;
    .param p2, "clientConfiguration"    # Lcom/amazonaws/ClientConfiguration;
    .param p3, "httpClient"    # Lcom/amazonaws/http/HttpClient;

    .line 350
    invoke-static {p2}, Lcom/amazonaws/services/cognitoidentity/AmazonCognitoIdentityClient;->adjustClientConfiguration(Lcom/amazonaws/ClientConfiguration;)Lcom/amazonaws/ClientConfiguration;

    move-result-object v0

    invoke-direct {p0, v0, p3}, Lcom/amazonaws/AmazonWebServiceClient;-><init>(Lcom/amazonaws/ClientConfiguration;Lcom/amazonaws/http/HttpClient;)V

    .line 352
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentity/AmazonCognitoIdentityClient;->awsCredentialsProvider:Lcom/amazonaws/auth/AWSCredentialsProvider;

    .line 354
    invoke-direct {p0}, Lcom/amazonaws/services/cognitoidentity/AmazonCognitoIdentityClient;->init()V

    .line 355
    return-void
.end method

.method public constructor <init>(Lcom/amazonaws/auth/AWSCredentialsProvider;Lcom/amazonaws/ClientConfiguration;Lcom/amazonaws/metrics/RequestMetricCollector;)V
    .locals 1
    .param p1, "awsCredentialsProvider"    # Lcom/amazonaws/auth/AWSCredentialsProvider;
    .param p2, "clientConfiguration"    # Lcom/amazonaws/ClientConfiguration;
    .param p3, "requestMetricCollector"    # Lcom/amazonaws/metrics/RequestMetricCollector;
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 302
    invoke-static {p2}, Lcom/amazonaws/services/cognitoidentity/AmazonCognitoIdentityClient;->adjustClientConfiguration(Lcom/amazonaws/ClientConfiguration;)Lcom/amazonaws/ClientConfiguration;

    move-result-object v0

    invoke-direct {p0, v0, p3}, Lcom/amazonaws/AmazonWebServiceClient;-><init>(Lcom/amazonaws/ClientConfiguration;Lcom/amazonaws/metrics/RequestMetricCollector;)V

    .line 304
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentity/AmazonCognitoIdentityClient;->awsCredentialsProvider:Lcom/amazonaws/auth/AWSCredentialsProvider;

    .line 306
    invoke-direct {p0}, Lcom/amazonaws/services/cognitoidentity/AmazonCognitoIdentityClient;->init()V

    .line 307
    return-void
.end method

.method private static adjustClientConfiguration(Lcom/amazonaws/ClientConfiguration;)Lcom/amazonaws/ClientConfiguration;
    .locals 1
    .param p0, "orig"    # Lcom/amazonaws/ClientConfiguration;

    .line 384
    move-object v0, p0

    .line 386
    .local v0, "config":Lcom/amazonaws/ClientConfiguration;
    return-object v0
.end method

.method private init()V
    .locals 3

    .line 358
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/amazonaws/services/cognitoidentity/AmazonCognitoIdentityClient;->jsonErrorUnmarshallers:Ljava/util/List;

    .line 359
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentity/AmazonCognitoIdentityClient;->jsonErrorUnmarshallers:Ljava/util/List;

    new-instance v1, Lcom/amazonaws/services/cognitoidentity/model/transform/ConcurrentModificationExceptionUnmarshaller;

    invoke-direct {v1}, Lcom/amazonaws/services/cognitoidentity/model/transform/ConcurrentModificationExceptionUnmarshaller;-><init>()V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 360
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentity/AmazonCognitoIdentityClient;->jsonErrorUnmarshallers:Ljava/util/List;

    new-instance v1, Lcom/amazonaws/services/cognitoidentity/model/transform/DeveloperUserAlreadyRegisteredExceptionUnmarshaller;

    invoke-direct {v1}, Lcom/amazonaws/services/cognitoidentity/model/transform/DeveloperUserAlreadyRegisteredExceptionUnmarshaller;-><init>()V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 361
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentity/AmazonCognitoIdentityClient;->jsonErrorUnmarshallers:Ljava/util/List;

    new-instance v1, Lcom/amazonaws/services/cognitoidentity/model/transform/ExternalServiceExceptionUnmarshaller;

    invoke-direct {v1}, Lcom/amazonaws/services/cognitoidentity/model/transform/ExternalServiceExceptionUnmarshaller;-><init>()V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 362
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentity/AmazonCognitoIdentityClient;->jsonErrorUnmarshallers:Ljava/util/List;

    new-instance v1, Lcom/amazonaws/services/cognitoidentity/model/transform/InternalErrorExceptionUnmarshaller;

    invoke-direct {v1}, Lcom/amazonaws/services/cognitoidentity/model/transform/InternalErrorExceptionUnmarshaller;-><init>()V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 363
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentity/AmazonCognitoIdentityClient;->jsonErrorUnmarshallers:Ljava/util/List;

    new-instance v1, Lcom/amazonaws/services/cognitoidentity/model/transform/InvalidIdentityPoolConfigurationExceptionUnmarshaller;

    invoke-direct {v1}, Lcom/amazonaws/services/cognitoidentity/model/transform/InvalidIdentityPoolConfigurationExceptionUnmarshaller;-><init>()V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 364
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentity/AmazonCognitoIdentityClient;->jsonErrorUnmarshallers:Ljava/util/List;

    new-instance v1, Lcom/amazonaws/services/cognitoidentity/model/transform/InvalidParameterExceptionUnmarshaller;

    invoke-direct {v1}, Lcom/amazonaws/services/cognitoidentity/model/transform/InvalidParameterExceptionUnmarshaller;-><init>()V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 365
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentity/AmazonCognitoIdentityClient;->jsonErrorUnmarshallers:Ljava/util/List;

    new-instance v1, Lcom/amazonaws/services/cognitoidentity/model/transform/LimitExceededExceptionUnmarshaller;

    invoke-direct {v1}, Lcom/amazonaws/services/cognitoidentity/model/transform/LimitExceededExceptionUnmarshaller;-><init>()V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 366
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentity/AmazonCognitoIdentityClient;->jsonErrorUnmarshallers:Ljava/util/List;

    new-instance v1, Lcom/amazonaws/services/cognitoidentity/model/transform/NotAuthorizedExceptionUnmarshaller;

    invoke-direct {v1}, Lcom/amazonaws/services/cognitoidentity/model/transform/NotAuthorizedExceptionUnmarshaller;-><init>()V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 367
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentity/AmazonCognitoIdentityClient;->jsonErrorUnmarshallers:Ljava/util/List;

    new-instance v1, Lcom/amazonaws/services/cognitoidentity/model/transform/ResourceConflictExceptionUnmarshaller;

    invoke-direct {v1}, Lcom/amazonaws/services/cognitoidentity/model/transform/ResourceConflictExceptionUnmarshaller;-><init>()V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 368
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentity/AmazonCognitoIdentityClient;->jsonErrorUnmarshallers:Ljava/util/List;

    new-instance v1, Lcom/amazonaws/services/cognitoidentity/model/transform/ResourceNotFoundExceptionUnmarshaller;

    invoke-direct {v1}, Lcom/amazonaws/services/cognitoidentity/model/transform/ResourceNotFoundExceptionUnmarshaller;-><init>()V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 369
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentity/AmazonCognitoIdentityClient;->jsonErrorUnmarshallers:Ljava/util/List;

    new-instance v1, Lcom/amazonaws/services/cognitoidentity/model/transform/TooManyRequestsExceptionUnmarshaller;

    invoke-direct {v1}, Lcom/amazonaws/services/cognitoidentity/model/transform/TooManyRequestsExceptionUnmarshaller;-><init>()V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 370
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentity/AmazonCognitoIdentityClient;->jsonErrorUnmarshallers:Ljava/util/List;

    new-instance v1, Lcom/amazonaws/transform/JsonErrorUnmarshaller;

    invoke-direct {v1}, Lcom/amazonaws/transform/JsonErrorUnmarshaller;-><init>()V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 373
    const-string v0, "cognito-identity.us-east-1.amazonaws.com"

    invoke-virtual {p0, v0}, Lcom/amazonaws/services/cognitoidentity/AmazonCognitoIdentityClient;->setEndpoint(Ljava/lang/String;)V

    .line 374
    const-string v0, "cognito-identity"

    iput-object v0, p0, Lcom/amazonaws/services/cognitoidentity/AmazonCognitoIdentityClient;->endpointPrefix:Ljava/lang/String;

    .line 376
    new-instance v0, Lcom/amazonaws/handlers/HandlerChainFactory;

    invoke-direct {v0}, Lcom/amazonaws/handlers/HandlerChainFactory;-><init>()V

    .line 377
    .local v0, "chainFactory":Lcom/amazonaws/handlers/HandlerChainFactory;
    iget-object v1, p0, Lcom/amazonaws/services/cognitoidentity/AmazonCognitoIdentityClient;->requestHandler2s:Ljava/util/List;

    const-string v2, "/com/amazonaws/services/cognitoidentity/request.handlers"

    invoke-virtual {v0, v2}, Lcom/amazonaws/handlers/HandlerChainFactory;->newRequestHandlerChain(Ljava/lang/String;)Ljava/util/List;

    move-result-object v2

    invoke-interface {v1, v2}, Ljava/util/List;->addAll(Ljava/util/Collection;)Z

    .line 379
    iget-object v1, p0, Lcom/amazonaws/services/cognitoidentity/AmazonCognitoIdentityClient;->requestHandler2s:Ljava/util/List;

    const-string v2, "/com/amazonaws/services/cognitoidentity/request.handler2s"

    invoke-virtual {v0, v2}, Lcom/amazonaws/handlers/HandlerChainFactory;->newRequestHandler2Chain(Ljava/lang/String;)Ljava/util/List;

    move-result-object v2

    invoke-interface {v1, v2}, Ljava/util/List;->addAll(Ljava/util/Collection;)Z

    .line 381
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

    .line 1816
    .local p1, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<TY;>;"
    .local p2, "responseHandler":Lcom/amazonaws/http/HttpResponseHandler;, "Lcom/amazonaws/http/HttpResponseHandler<Lcom/amazonaws/AmazonWebServiceResponse<TX;>;>;"
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentity/AmazonCognitoIdentityClient;->endpoint:Ljava/net/URI;

    invoke-interface {p1, v0}, Lcom/amazonaws/Request;->setEndpoint(Ljava/net/URI;)V

    .line 1817
    iget v0, p0, Lcom/amazonaws/services/cognitoidentity/AmazonCognitoIdentityClient;->timeOffset:I

    invoke-interface {p1, v0}, Lcom/amazonaws/Request;->setTimeOffset(I)V

    .line 1819
    invoke-virtual {p3}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v0

    .line 1821
    .local v0, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v1, Lcom/amazonaws/util/AWSRequestMetrics$Field;->CredentialsRequestTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v0, v1}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1823
    :try_start_0
    iget-object v1, p0, Lcom/amazonaws/services/cognitoidentity/AmazonCognitoIdentityClient;->awsCredentialsProvider:Lcom/amazonaws/auth/AWSCredentialsProvider;

    invoke-interface {v1}, Lcom/amazonaws/auth/AWSCredentialsProvider;->getCredentials()Lcom/amazonaws/auth/AWSCredentials;

    move-result-object v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 1825
    .local v1, "credentials":Lcom/amazonaws/auth/AWSCredentials;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->CredentialsRequestTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v0, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1826
    nop

    .line 1828
    invoke-interface {p1}, Lcom/amazonaws/Request;->getOriginalRequest()Lcom/amazonaws/AmazonWebServiceRequest;

    move-result-object v2

    .line 1829
    .local v2, "originalRequest":Lcom/amazonaws/AmazonWebServiceRequest;
    if-eqz v2, :cond_0

    invoke-virtual {v2}, Lcom/amazonaws/AmazonWebServiceRequest;->getRequestCredentials()Lcom/amazonaws/auth/AWSCredentials;

    move-result-object v3

    if-eqz v3, :cond_0

    .line 1830
    invoke-virtual {v2}, Lcom/amazonaws/AmazonWebServiceRequest;->getRequestCredentials()Lcom/amazonaws/auth/AWSCredentials;

    move-result-object v1

    .line 1833
    :cond_0
    invoke-virtual {p3, v1}, Lcom/amazonaws/http/ExecutionContext;->setCredentials(Lcom/amazonaws/auth/AWSCredentials;)V

    .line 1834
    new-instance v3, Lcom/amazonaws/http/JsonErrorResponseHandler;

    iget-object v4, p0, Lcom/amazonaws/services/cognitoidentity/AmazonCognitoIdentityClient;->jsonErrorUnmarshallers:Ljava/util/List;

    invoke-direct {v3, v4}, Lcom/amazonaws/http/JsonErrorResponseHandler;-><init>(Ljava/util/List;)V

    .line 1836
    .local v3, "errorResponseHandler":Lcom/amazonaws/http/JsonErrorResponseHandler;
    iget-object v4, p0, Lcom/amazonaws/services/cognitoidentity/AmazonCognitoIdentityClient;->client:Lcom/amazonaws/http/AmazonHttpClient;

    invoke-virtual {v4, p1, p2, v3, p3}, Lcom/amazonaws/http/AmazonHttpClient;->execute(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v4

    .line 1838
    .local v4, "result":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<TX;>;"
    return-object v4

    .line 1825
    .end local v1    # "credentials":Lcom/amazonaws/auth/AWSCredentials;
    .end local v2    # "originalRequest":Lcom/amazonaws/AmazonWebServiceRequest;
    .end local v3    # "errorResponseHandler":Lcom/amazonaws/http/JsonErrorResponseHandler;
    .end local v4    # "result":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<TX;>;"
    :catchall_0
    move-exception v1

    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->CredentialsRequestTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v0, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1826
    throw v1
.end method


# virtual methods
.method public createIdentityPool(Lcom/amazonaws/services/cognitoidentity/model/CreateIdentityPoolRequest;)Lcom/amazonaws/services/cognitoidentity/model/CreateIdentityPoolResult;
    .locals 9
    .param p1, "createIdentityPoolRequest"    # Lcom/amazonaws/services/cognitoidentity/model/CreateIdentityPoolRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 448
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/cognitoidentity/AmazonCognitoIdentityClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 449
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 450
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 451
    const/4 v2, 0x0

    .line 452
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentity/model/CreateIdentityPoolRequest;>;"
    const/4 v3, 0x0

    .line 454
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentity/model/CreateIdentityPoolResult;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 456
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/cognitoidentity/model/transform/CreateIdentityPoolRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentity/model/transform/CreateIdentityPoolRequestMarshaller;-><init>()V

    .line 457
    invoke-virtual {v5, p1}, Lcom/amazonaws/services/cognitoidentity/model/transform/CreateIdentityPoolRequestMarshaller;->marshall(Lcom/amazonaws/services/cognitoidentity/model/CreateIdentityPoolRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 459
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 461
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 462
    nop

    .line 463
    new-instance v5, Lcom/amazonaws/services/cognitoidentity/model/transform/CreateIdentityPoolResultJsonUnmarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentity/model/transform/CreateIdentityPoolResultJsonUnmarshaller;-><init>()V

    .line 464
    .local v5, "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentity/model/CreateIdentityPoolResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    new-instance v6, Lcom/amazonaws/http/JsonResponseHandler;

    invoke-direct {v6, v5}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 467
    .local v6, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentity/model/CreateIdentityPoolResult;>;"
    invoke-direct {p0, v2, v6, v0}, Lcom/amazonaws/services/cognitoidentity/AmazonCognitoIdentityClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v7

    move-object v3, v7

    .line 469
    invoke-virtual {v3}, Lcom/amazonaws/Response;->getAwsResponse()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/amazonaws/services/cognitoidentity/model/CreateIdentityPoolResult;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 471
    sget-object v8, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v8}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 472
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentity/AmazonCognitoIdentityClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 469
    return-object v7

    .line 461
    .end local v5    # "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentity/model/CreateIdentityPoolResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    .end local v6    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentity/model/CreateIdentityPoolResult;>;"
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 462
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentity/model/CreateIdentityPoolRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentity/model/CreateIdentityPoolResult;>;"
    .end local p1    # "createIdentityPoolRequest":Lcom/amazonaws/services/cognitoidentity/model/CreateIdentityPoolRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 471
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentity/model/CreateIdentityPoolRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentity/model/CreateIdentityPoolResult;>;"
    .restart local p1    # "createIdentityPoolRequest":Lcom/amazonaws/services/cognitoidentity/model/CreateIdentityPoolRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 472
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentity/AmazonCognitoIdentityClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 473
    throw v5
.end method

.method public deleteIdentities(Lcom/amazonaws/services/cognitoidentity/model/DeleteIdentitiesRequest;)Lcom/amazonaws/services/cognitoidentity/model/DeleteIdentitiesResult;
    .locals 9
    .param p1, "deleteIdentitiesRequest"    # Lcom/amazonaws/services/cognitoidentity/model/DeleteIdentitiesRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 503
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/cognitoidentity/AmazonCognitoIdentityClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 504
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 505
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 506
    const/4 v2, 0x0

    .line 507
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentity/model/DeleteIdentitiesRequest;>;"
    const/4 v3, 0x0

    .line 509
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentity/model/DeleteIdentitiesResult;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 511
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/cognitoidentity/model/transform/DeleteIdentitiesRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentity/model/transform/DeleteIdentitiesRequestMarshaller;-><init>()V

    invoke-virtual {v5, p1}, Lcom/amazonaws/services/cognitoidentity/model/transform/DeleteIdentitiesRequestMarshaller;->marshall(Lcom/amazonaws/services/cognitoidentity/model/DeleteIdentitiesRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 513
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 515
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 516
    nop

    .line 517
    new-instance v5, Lcom/amazonaws/services/cognitoidentity/model/transform/DeleteIdentitiesResultJsonUnmarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentity/model/transform/DeleteIdentitiesResultJsonUnmarshaller;-><init>()V

    .line 518
    .local v5, "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentity/model/DeleteIdentitiesResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    new-instance v6, Lcom/amazonaws/http/JsonResponseHandler;

    invoke-direct {v6, v5}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 521
    .local v6, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentity/model/DeleteIdentitiesResult;>;"
    invoke-direct {p0, v2, v6, v0}, Lcom/amazonaws/services/cognitoidentity/AmazonCognitoIdentityClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v7

    move-object v3, v7

    .line 523
    invoke-virtual {v3}, Lcom/amazonaws/Response;->getAwsResponse()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/amazonaws/services/cognitoidentity/model/DeleteIdentitiesResult;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 525
    sget-object v8, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v8}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 526
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentity/AmazonCognitoIdentityClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 523
    return-object v7

    .line 515
    .end local v5    # "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentity/model/DeleteIdentitiesResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    .end local v6    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentity/model/DeleteIdentitiesResult;>;"
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 516
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentity/model/DeleteIdentitiesRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentity/model/DeleteIdentitiesResult;>;"
    .end local p1    # "deleteIdentitiesRequest":Lcom/amazonaws/services/cognitoidentity/model/DeleteIdentitiesRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 525
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentity/model/DeleteIdentitiesRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentity/model/DeleteIdentitiesResult;>;"
    .restart local p1    # "deleteIdentitiesRequest":Lcom/amazonaws/services/cognitoidentity/model/DeleteIdentitiesRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 526
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentity/AmazonCognitoIdentityClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 527
    throw v5
.end method

.method public deleteIdentityPool(Lcom/amazonaws/services/cognitoidentity/model/DeleteIdentityPoolRequest;)V
    .locals 7
    .param p1, "deleteIdentityPoolRequest"    # Lcom/amazonaws/services/cognitoidentity/model/DeleteIdentityPoolRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 557
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/cognitoidentity/AmazonCognitoIdentityClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 558
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 559
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 560
    const/4 v2, 0x0

    .line 561
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentity/model/DeleteIdentityPoolRequest;>;"
    const/4 v3, 0x0

    .line 563
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Ljava/lang/Void;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 565
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/cognitoidentity/model/transform/DeleteIdentityPoolRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentity/model/transform/DeleteIdentityPoolRequestMarshaller;-><init>()V

    .line 566
    invoke-virtual {v5, p1}, Lcom/amazonaws/services/cognitoidentity/model/transform/DeleteIdentityPoolRequestMarshaller;->marshall(Lcom/amazonaws/services/cognitoidentity/model/DeleteIdentityPoolRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 568
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 570
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 571
    nop

    .line 572
    new-instance v5, Lcom/amazonaws/http/JsonResponseHandler;

    const/4 v6, 0x0

    invoke-direct {v5, v6}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 573
    .local v5, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Ljava/lang/Void;>;"
    invoke-direct {p0, v2, v5, v0}, Lcom/amazonaws/services/cognitoidentity/AmazonCognitoIdentityClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 575
    nop

    .end local v5    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Ljava/lang/Void;>;"
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 576
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentity/AmazonCognitoIdentityClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 577
    nop

    .line 578
    return-void

    .line 570
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 571
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentity/model/DeleteIdentityPoolRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Ljava/lang/Void;>;"
    .end local p1    # "deleteIdentityPoolRequest":Lcom/amazonaws/services/cognitoidentity/model/DeleteIdentityPoolRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 575
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentity/model/DeleteIdentityPoolRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Ljava/lang/Void;>;"
    .restart local p1    # "deleteIdentityPoolRequest":Lcom/amazonaws/services/cognitoidentity/model/DeleteIdentityPoolRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 576
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentity/AmazonCognitoIdentityClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 577
    throw v5
.end method

.method public describeIdentity(Lcom/amazonaws/services/cognitoidentity/model/DescribeIdentityRequest;)Lcom/amazonaws/services/cognitoidentity/model/DescribeIdentityResult;
    .locals 9
    .param p1, "describeIdentityRequest"    # Lcom/amazonaws/services/cognitoidentity/model/DescribeIdentityRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 609
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/cognitoidentity/AmazonCognitoIdentityClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 610
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 611
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 612
    const/4 v2, 0x0

    .line 613
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentity/model/DescribeIdentityRequest;>;"
    const/4 v3, 0x0

    .line 615
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentity/model/DescribeIdentityResult;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 617
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/cognitoidentity/model/transform/DescribeIdentityRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentity/model/transform/DescribeIdentityRequestMarshaller;-><init>()V

    invoke-virtual {v5, p1}, Lcom/amazonaws/services/cognitoidentity/model/transform/DescribeIdentityRequestMarshaller;->marshall(Lcom/amazonaws/services/cognitoidentity/model/DescribeIdentityRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 619
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 621
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 622
    nop

    .line 623
    new-instance v5, Lcom/amazonaws/services/cognitoidentity/model/transform/DescribeIdentityResultJsonUnmarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentity/model/transform/DescribeIdentityResultJsonUnmarshaller;-><init>()V

    .line 624
    .local v5, "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentity/model/DescribeIdentityResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    new-instance v6, Lcom/amazonaws/http/JsonResponseHandler;

    invoke-direct {v6, v5}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 627
    .local v6, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentity/model/DescribeIdentityResult;>;"
    invoke-direct {p0, v2, v6, v0}, Lcom/amazonaws/services/cognitoidentity/AmazonCognitoIdentityClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v7

    move-object v3, v7

    .line 629
    invoke-virtual {v3}, Lcom/amazonaws/Response;->getAwsResponse()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/amazonaws/services/cognitoidentity/model/DescribeIdentityResult;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 631
    sget-object v8, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v8}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 632
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentity/AmazonCognitoIdentityClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 629
    return-object v7

    .line 621
    .end local v5    # "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentity/model/DescribeIdentityResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    .end local v6    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentity/model/DescribeIdentityResult;>;"
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 622
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentity/model/DescribeIdentityRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentity/model/DescribeIdentityResult;>;"
    .end local p1    # "describeIdentityRequest":Lcom/amazonaws/services/cognitoidentity/model/DescribeIdentityRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 631
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentity/model/DescribeIdentityRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentity/model/DescribeIdentityResult;>;"
    .restart local p1    # "describeIdentityRequest":Lcom/amazonaws/services/cognitoidentity/model/DescribeIdentityRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 632
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentity/AmazonCognitoIdentityClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 633
    throw v5
.end method

.method public describeIdentityPool(Lcom/amazonaws/services/cognitoidentity/model/DescribeIdentityPoolRequest;)Lcom/amazonaws/services/cognitoidentity/model/DescribeIdentityPoolResult;
    .locals 9
    .param p1, "describeIdentityPoolRequest"    # Lcom/amazonaws/services/cognitoidentity/model/DescribeIdentityPoolRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 667
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/cognitoidentity/AmazonCognitoIdentityClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 668
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 669
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 670
    const/4 v2, 0x0

    .line 671
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentity/model/DescribeIdentityPoolRequest;>;"
    const/4 v3, 0x0

    .line 673
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentity/model/DescribeIdentityPoolResult;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 675
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/cognitoidentity/model/transform/DescribeIdentityPoolRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentity/model/transform/DescribeIdentityPoolRequestMarshaller;-><init>()V

    .line 676
    invoke-virtual {v5, p1}, Lcom/amazonaws/services/cognitoidentity/model/transform/DescribeIdentityPoolRequestMarshaller;->marshall(Lcom/amazonaws/services/cognitoidentity/model/DescribeIdentityPoolRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 678
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 680
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 681
    nop

    .line 682
    new-instance v5, Lcom/amazonaws/services/cognitoidentity/model/transform/DescribeIdentityPoolResultJsonUnmarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentity/model/transform/DescribeIdentityPoolResultJsonUnmarshaller;-><init>()V

    .line 683
    .local v5, "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentity/model/DescribeIdentityPoolResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    new-instance v6, Lcom/amazonaws/http/JsonResponseHandler;

    invoke-direct {v6, v5}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 686
    .local v6, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentity/model/DescribeIdentityPoolResult;>;"
    invoke-direct {p0, v2, v6, v0}, Lcom/amazonaws/services/cognitoidentity/AmazonCognitoIdentityClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v7

    move-object v3, v7

    .line 688
    invoke-virtual {v3}, Lcom/amazonaws/Response;->getAwsResponse()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/amazonaws/services/cognitoidentity/model/DescribeIdentityPoolResult;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 690
    sget-object v8, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v8}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 691
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentity/AmazonCognitoIdentityClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 688
    return-object v7

    .line 680
    .end local v5    # "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentity/model/DescribeIdentityPoolResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    .end local v6    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentity/model/DescribeIdentityPoolResult;>;"
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 681
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentity/model/DescribeIdentityPoolRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentity/model/DescribeIdentityPoolResult;>;"
    .end local p1    # "describeIdentityPoolRequest":Lcom/amazonaws/services/cognitoidentity/model/DescribeIdentityPoolRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 690
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentity/model/DescribeIdentityPoolRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentity/model/DescribeIdentityPoolResult;>;"
    .restart local p1    # "describeIdentityPoolRequest":Lcom/amazonaws/services/cognitoidentity/model/DescribeIdentityPoolRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 691
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentity/AmazonCognitoIdentityClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 692
    throw v5
.end method

.method public getCachedResponseMetadata(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/ResponseMetadata;
    .locals 1
    .param p1, "request"    # Lcom/amazonaws/AmazonWebServiceRequest;
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 1810
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentity/AmazonCognitoIdentityClient;->client:Lcom/amazonaws/http/AmazonHttpClient;

    invoke-virtual {v0, p1}, Lcom/amazonaws/http/AmazonHttpClient;->getResponseMetadataForRequest(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/ResponseMetadata;

    move-result-object v0

    return-object v0
.end method

.method public getCredentialsForIdentity(Lcom/amazonaws/services/cognitoidentity/model/GetCredentialsForIdentityRequest;)Lcom/amazonaws/services/cognitoidentity/model/GetCredentialsForIdentityResult;
    .locals 9
    .param p1, "getCredentialsForIdentityRequest"    # Lcom/amazonaws/services/cognitoidentity/model/GetCredentialsForIdentityRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 731
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/cognitoidentity/AmazonCognitoIdentityClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 732
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 733
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 734
    const/4 v2, 0x0

    .line 735
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentity/model/GetCredentialsForIdentityRequest;>;"
    const/4 v3, 0x0

    .line 737
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentity/model/GetCredentialsForIdentityResult;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 739
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/cognitoidentity/model/transform/GetCredentialsForIdentityRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentity/model/transform/GetCredentialsForIdentityRequestMarshaller;-><init>()V

    .line 740
    invoke-virtual {v5, p1}, Lcom/amazonaws/services/cognitoidentity/model/transform/GetCredentialsForIdentityRequestMarshaller;->marshall(Lcom/amazonaws/services/cognitoidentity/model/GetCredentialsForIdentityRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 742
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 744
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 745
    nop

    .line 746
    new-instance v5, Lcom/amazonaws/services/cognitoidentity/model/transform/GetCredentialsForIdentityResultJsonUnmarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentity/model/transform/GetCredentialsForIdentityResultJsonUnmarshaller;-><init>()V

    .line 747
    .local v5, "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentity/model/GetCredentialsForIdentityResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    new-instance v6, Lcom/amazonaws/http/JsonResponseHandler;

    invoke-direct {v6, v5}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 750
    .local v6, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentity/model/GetCredentialsForIdentityResult;>;"
    invoke-direct {p0, v2, v6, v0}, Lcom/amazonaws/services/cognitoidentity/AmazonCognitoIdentityClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v7

    move-object v3, v7

    .line 752
    invoke-virtual {v3}, Lcom/amazonaws/Response;->getAwsResponse()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/amazonaws/services/cognitoidentity/model/GetCredentialsForIdentityResult;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 754
    sget-object v8, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v8}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 755
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentity/AmazonCognitoIdentityClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 752
    return-object v7

    .line 744
    .end local v5    # "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentity/model/GetCredentialsForIdentityResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    .end local v6    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentity/model/GetCredentialsForIdentityResult;>;"
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 745
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentity/model/GetCredentialsForIdentityRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentity/model/GetCredentialsForIdentityResult;>;"
    .end local p1    # "getCredentialsForIdentityRequest":Lcom/amazonaws/services/cognitoidentity/model/GetCredentialsForIdentityRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 754
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentity/model/GetCredentialsForIdentityRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentity/model/GetCredentialsForIdentityResult;>;"
    .restart local p1    # "getCredentialsForIdentityRequest":Lcom/amazonaws/services/cognitoidentity/model/GetCredentialsForIdentityRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 755
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentity/AmazonCognitoIdentityClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 756
    throw v5
.end method

.method public getId(Lcom/amazonaws/services/cognitoidentity/model/GetIdRequest;)Lcom/amazonaws/services/cognitoidentity/model/GetIdResult;
    .locals 9
    .param p1, "getIdRequest"    # Lcom/amazonaws/services/cognitoidentity/model/GetIdRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 791
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/cognitoidentity/AmazonCognitoIdentityClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 792
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 793
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 794
    const/4 v2, 0x0

    .line 795
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentity/model/GetIdRequest;>;"
    const/4 v3, 0x0

    .line 797
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentity/model/GetIdResult;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 799
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/cognitoidentity/model/transform/GetIdRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentity/model/transform/GetIdRequestMarshaller;-><init>()V

    invoke-virtual {v5, p1}, Lcom/amazonaws/services/cognitoidentity/model/transform/GetIdRequestMarshaller;->marshall(Lcom/amazonaws/services/cognitoidentity/model/GetIdRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 801
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 803
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 804
    nop

    .line 805
    new-instance v5, Lcom/amazonaws/services/cognitoidentity/model/transform/GetIdResultJsonUnmarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentity/model/transform/GetIdResultJsonUnmarshaller;-><init>()V

    .line 806
    .local v5, "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentity/model/GetIdResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    new-instance v6, Lcom/amazonaws/http/JsonResponseHandler;

    invoke-direct {v6, v5}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 809
    .local v6, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentity/model/GetIdResult;>;"
    invoke-direct {p0, v2, v6, v0}, Lcom/amazonaws/services/cognitoidentity/AmazonCognitoIdentityClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v7

    move-object v3, v7

    .line 811
    invoke-virtual {v3}, Lcom/amazonaws/Response;->getAwsResponse()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/amazonaws/services/cognitoidentity/model/GetIdResult;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 813
    sget-object v8, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v8}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 814
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentity/AmazonCognitoIdentityClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 811
    return-object v7

    .line 803
    .end local v5    # "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentity/model/GetIdResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    .end local v6    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentity/model/GetIdResult;>;"
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 804
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentity/model/GetIdRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentity/model/GetIdResult;>;"
    .end local p1    # "getIdRequest":Lcom/amazonaws/services/cognitoidentity/model/GetIdRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 813
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentity/model/GetIdRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentity/model/GetIdResult;>;"
    .restart local p1    # "getIdRequest":Lcom/amazonaws/services/cognitoidentity/model/GetIdRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 814
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentity/AmazonCognitoIdentityClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 815
    throw v5
.end method

.method public getIdentityPoolRoles(Lcom/amazonaws/services/cognitoidentity/model/GetIdentityPoolRolesRequest;)Lcom/amazonaws/services/cognitoidentity/model/GetIdentityPoolRolesResult;
    .locals 9
    .param p1, "getIdentityPoolRolesRequest"    # Lcom/amazonaws/services/cognitoidentity/model/GetIdentityPoolRolesRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 849
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/cognitoidentity/AmazonCognitoIdentityClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 850
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 851
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 852
    const/4 v2, 0x0

    .line 853
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentity/model/GetIdentityPoolRolesRequest;>;"
    const/4 v3, 0x0

    .line 855
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentity/model/GetIdentityPoolRolesResult;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 857
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/cognitoidentity/model/transform/GetIdentityPoolRolesRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentity/model/transform/GetIdentityPoolRolesRequestMarshaller;-><init>()V

    .line 858
    invoke-virtual {v5, p1}, Lcom/amazonaws/services/cognitoidentity/model/transform/GetIdentityPoolRolesRequestMarshaller;->marshall(Lcom/amazonaws/services/cognitoidentity/model/GetIdentityPoolRolesRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 860
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 862
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 863
    nop

    .line 864
    new-instance v5, Lcom/amazonaws/services/cognitoidentity/model/transform/GetIdentityPoolRolesResultJsonUnmarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentity/model/transform/GetIdentityPoolRolesResultJsonUnmarshaller;-><init>()V

    .line 865
    .local v5, "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentity/model/GetIdentityPoolRolesResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    new-instance v6, Lcom/amazonaws/http/JsonResponseHandler;

    invoke-direct {v6, v5}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 868
    .local v6, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentity/model/GetIdentityPoolRolesResult;>;"
    invoke-direct {p0, v2, v6, v0}, Lcom/amazonaws/services/cognitoidentity/AmazonCognitoIdentityClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v7

    move-object v3, v7

    .line 870
    invoke-virtual {v3}, Lcom/amazonaws/Response;->getAwsResponse()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/amazonaws/services/cognitoidentity/model/GetIdentityPoolRolesResult;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 872
    sget-object v8, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v8}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 873
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentity/AmazonCognitoIdentityClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 870
    return-object v7

    .line 862
    .end local v5    # "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentity/model/GetIdentityPoolRolesResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    .end local v6    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentity/model/GetIdentityPoolRolesResult;>;"
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 863
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentity/model/GetIdentityPoolRolesRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentity/model/GetIdentityPoolRolesResult;>;"
    .end local p1    # "getIdentityPoolRolesRequest":Lcom/amazonaws/services/cognitoidentity/model/GetIdentityPoolRolesRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 872
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentity/model/GetIdentityPoolRolesRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentity/model/GetIdentityPoolRolesResult;>;"
    .restart local p1    # "getIdentityPoolRolesRequest":Lcom/amazonaws/services/cognitoidentity/model/GetIdentityPoolRolesRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 873
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentity/AmazonCognitoIdentityClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 874
    throw v5
.end method

.method public getOpenIdToken(Lcom/amazonaws/services/cognitoidentity/model/GetOpenIdTokenRequest;)Lcom/amazonaws/services/cognitoidentity/model/GetOpenIdTokenResult;
    .locals 9
    .param p1, "getOpenIdTokenRequest"    # Lcom/amazonaws/services/cognitoidentity/model/GetOpenIdTokenRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 912
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/cognitoidentity/AmazonCognitoIdentityClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 913
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 914
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 915
    const/4 v2, 0x0

    .line 916
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentity/model/GetOpenIdTokenRequest;>;"
    const/4 v3, 0x0

    .line 918
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentity/model/GetOpenIdTokenResult;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 920
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/cognitoidentity/model/transform/GetOpenIdTokenRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentity/model/transform/GetOpenIdTokenRequestMarshaller;-><init>()V

    invoke-virtual {v5, p1}, Lcom/amazonaws/services/cognitoidentity/model/transform/GetOpenIdTokenRequestMarshaller;->marshall(Lcom/amazonaws/services/cognitoidentity/model/GetOpenIdTokenRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 922
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 924
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 925
    nop

    .line 926
    new-instance v5, Lcom/amazonaws/services/cognitoidentity/model/transform/GetOpenIdTokenResultJsonUnmarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentity/model/transform/GetOpenIdTokenResultJsonUnmarshaller;-><init>()V

    .line 927
    .local v5, "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentity/model/GetOpenIdTokenResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    new-instance v6, Lcom/amazonaws/http/JsonResponseHandler;

    invoke-direct {v6, v5}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 930
    .local v6, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentity/model/GetOpenIdTokenResult;>;"
    invoke-direct {p0, v2, v6, v0}, Lcom/amazonaws/services/cognitoidentity/AmazonCognitoIdentityClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v7

    move-object v3, v7

    .line 932
    invoke-virtual {v3}, Lcom/amazonaws/Response;->getAwsResponse()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/amazonaws/services/cognitoidentity/model/GetOpenIdTokenResult;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 934
    sget-object v8, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v8}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 935
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentity/AmazonCognitoIdentityClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 932
    return-object v7

    .line 924
    .end local v5    # "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentity/model/GetOpenIdTokenResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    .end local v6    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentity/model/GetOpenIdTokenResult;>;"
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 925
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentity/model/GetOpenIdTokenRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentity/model/GetOpenIdTokenResult;>;"
    .end local p1    # "getOpenIdTokenRequest":Lcom/amazonaws/services/cognitoidentity/model/GetOpenIdTokenRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 934
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentity/model/GetOpenIdTokenRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentity/model/GetOpenIdTokenResult;>;"
    .restart local p1    # "getOpenIdTokenRequest":Lcom/amazonaws/services/cognitoidentity/model/GetOpenIdTokenRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 935
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentity/AmazonCognitoIdentityClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 936
    throw v5
.end method

.method public getOpenIdTokenForDeveloperIdentity(Lcom/amazonaws/services/cognitoidentity/model/GetOpenIdTokenForDeveloperIdentityRequest;)Lcom/amazonaws/services/cognitoidentity/model/GetOpenIdTokenForDeveloperIdentityResult;
    .locals 9
    .param p1, "getOpenIdTokenForDeveloperIdentityRequest"    # Lcom/amazonaws/services/cognitoidentity/model/GetOpenIdTokenForDeveloperIdentityRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 988
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/cognitoidentity/AmazonCognitoIdentityClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 989
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 990
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 991
    const/4 v2, 0x0

    .line 992
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentity/model/GetOpenIdTokenForDeveloperIdentityRequest;>;"
    const/4 v3, 0x0

    .line 994
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentity/model/GetOpenIdTokenForDeveloperIdentityResult;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 996
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/cognitoidentity/model/transform/GetOpenIdTokenForDeveloperIdentityRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentity/model/transform/GetOpenIdTokenForDeveloperIdentityRequestMarshaller;-><init>()V

    .line 997
    invoke-virtual {v5, p1}, Lcom/amazonaws/services/cognitoidentity/model/transform/GetOpenIdTokenForDeveloperIdentityRequestMarshaller;->marshall(Lcom/amazonaws/services/cognitoidentity/model/GetOpenIdTokenForDeveloperIdentityRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 999
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 1001
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1002
    nop

    .line 1003
    new-instance v5, Lcom/amazonaws/services/cognitoidentity/model/transform/GetOpenIdTokenForDeveloperIdentityResultJsonUnmarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentity/model/transform/GetOpenIdTokenForDeveloperIdentityResultJsonUnmarshaller;-><init>()V

    .line 1004
    .local v5, "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentity/model/GetOpenIdTokenForDeveloperIdentityResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    new-instance v6, Lcom/amazonaws/http/JsonResponseHandler;

    invoke-direct {v6, v5}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 1007
    .local v6, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentity/model/GetOpenIdTokenForDeveloperIdentityResult;>;"
    invoke-direct {p0, v2, v6, v0}, Lcom/amazonaws/services/cognitoidentity/AmazonCognitoIdentityClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v7

    move-object v3, v7

    .line 1009
    invoke-virtual {v3}, Lcom/amazonaws/Response;->getAwsResponse()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/amazonaws/services/cognitoidentity/model/GetOpenIdTokenForDeveloperIdentityResult;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 1011
    sget-object v8, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v8}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1012
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentity/AmazonCognitoIdentityClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 1009
    return-object v7

    .line 1001
    .end local v5    # "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentity/model/GetOpenIdTokenForDeveloperIdentityResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    .end local v6    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentity/model/GetOpenIdTokenForDeveloperIdentityResult;>;"
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1002
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentity/model/GetOpenIdTokenForDeveloperIdentityRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentity/model/GetOpenIdTokenForDeveloperIdentityResult;>;"
    .end local p1    # "getOpenIdTokenForDeveloperIdentityRequest":Lcom/amazonaws/services/cognitoidentity/model/GetOpenIdTokenForDeveloperIdentityRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 1011
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentity/model/GetOpenIdTokenForDeveloperIdentityRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentity/model/GetOpenIdTokenForDeveloperIdentityResult;>;"
    .restart local p1    # "getOpenIdTokenForDeveloperIdentityRequest":Lcom/amazonaws/services/cognitoidentity/model/GetOpenIdTokenForDeveloperIdentityRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1012
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentity/AmazonCognitoIdentityClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 1013
    throw v5
.end method

.method public getPrincipalTagAttributeMap(Lcom/amazonaws/services/cognitoidentity/model/GetPrincipalTagAttributeMapRequest;)Lcom/amazonaws/services/cognitoidentity/model/GetPrincipalTagAttributeMapResult;
    .locals 9
    .param p1, "getPrincipalTagAttributeMapRequest"    # Lcom/amazonaws/services/cognitoidentity/model/GetPrincipalTagAttributeMapRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 1042
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/cognitoidentity/AmazonCognitoIdentityClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 1043
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 1044
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1045
    const/4 v2, 0x0

    .line 1046
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentity/model/GetPrincipalTagAttributeMapRequest;>;"
    const/4 v3, 0x0

    .line 1048
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentity/model/GetPrincipalTagAttributeMapResult;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 1050
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/cognitoidentity/model/transform/GetPrincipalTagAttributeMapRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentity/model/transform/GetPrincipalTagAttributeMapRequestMarshaller;-><init>()V

    .line 1051
    invoke-virtual {v5, p1}, Lcom/amazonaws/services/cognitoidentity/model/transform/GetPrincipalTagAttributeMapRequestMarshaller;->marshall(Lcom/amazonaws/services/cognitoidentity/model/GetPrincipalTagAttributeMapRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 1053
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 1055
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1056
    nop

    .line 1057
    new-instance v5, Lcom/amazonaws/services/cognitoidentity/model/transform/GetPrincipalTagAttributeMapResultJsonUnmarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentity/model/transform/GetPrincipalTagAttributeMapResultJsonUnmarshaller;-><init>()V

    .line 1058
    .local v5, "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentity/model/GetPrincipalTagAttributeMapResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    new-instance v6, Lcom/amazonaws/http/JsonResponseHandler;

    invoke-direct {v6, v5}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 1061
    .local v6, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentity/model/GetPrincipalTagAttributeMapResult;>;"
    invoke-direct {p0, v2, v6, v0}, Lcom/amazonaws/services/cognitoidentity/AmazonCognitoIdentityClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v7

    move-object v3, v7

    .line 1063
    invoke-virtual {v3}, Lcom/amazonaws/Response;->getAwsResponse()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/amazonaws/services/cognitoidentity/model/GetPrincipalTagAttributeMapResult;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 1065
    sget-object v8, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v8}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1066
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentity/AmazonCognitoIdentityClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 1063
    return-object v7

    .line 1055
    .end local v5    # "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentity/model/GetPrincipalTagAttributeMapResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    .end local v6    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentity/model/GetPrincipalTagAttributeMapResult;>;"
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1056
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentity/model/GetPrincipalTagAttributeMapRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentity/model/GetPrincipalTagAttributeMapResult;>;"
    .end local p1    # "getPrincipalTagAttributeMapRequest":Lcom/amazonaws/services/cognitoidentity/model/GetPrincipalTagAttributeMapRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 1065
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentity/model/GetPrincipalTagAttributeMapRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentity/model/GetPrincipalTagAttributeMapResult;>;"
    .restart local p1    # "getPrincipalTagAttributeMapRequest":Lcom/amazonaws/services/cognitoidentity/model/GetPrincipalTagAttributeMapRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1066
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentity/AmazonCognitoIdentityClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 1067
    throw v5
.end method

.method public listIdentities(Lcom/amazonaws/services/cognitoidentity/model/ListIdentitiesRequest;)Lcom/amazonaws/services/cognitoidentity/model/ListIdentitiesResult;
    .locals 9
    .param p1, "listIdentitiesRequest"    # Lcom/amazonaws/services/cognitoidentity/model/ListIdentitiesRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 1098
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/cognitoidentity/AmazonCognitoIdentityClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 1099
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 1100
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1101
    const/4 v2, 0x0

    .line 1102
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentity/model/ListIdentitiesRequest;>;"
    const/4 v3, 0x0

    .line 1104
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentity/model/ListIdentitiesResult;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 1106
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/cognitoidentity/model/transform/ListIdentitiesRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentity/model/transform/ListIdentitiesRequestMarshaller;-><init>()V

    invoke-virtual {v5, p1}, Lcom/amazonaws/services/cognitoidentity/model/transform/ListIdentitiesRequestMarshaller;->marshall(Lcom/amazonaws/services/cognitoidentity/model/ListIdentitiesRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 1108
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 1110
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1111
    nop

    .line 1112
    new-instance v5, Lcom/amazonaws/services/cognitoidentity/model/transform/ListIdentitiesResultJsonUnmarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentity/model/transform/ListIdentitiesResultJsonUnmarshaller;-><init>()V

    .line 1113
    .local v5, "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentity/model/ListIdentitiesResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    new-instance v6, Lcom/amazonaws/http/JsonResponseHandler;

    invoke-direct {v6, v5}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 1116
    .local v6, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentity/model/ListIdentitiesResult;>;"
    invoke-direct {p0, v2, v6, v0}, Lcom/amazonaws/services/cognitoidentity/AmazonCognitoIdentityClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v7

    move-object v3, v7

    .line 1118
    invoke-virtual {v3}, Lcom/amazonaws/Response;->getAwsResponse()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/amazonaws/services/cognitoidentity/model/ListIdentitiesResult;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 1120
    sget-object v8, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v8}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1121
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentity/AmazonCognitoIdentityClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 1118
    return-object v7

    .line 1110
    .end local v5    # "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentity/model/ListIdentitiesResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    .end local v6    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentity/model/ListIdentitiesResult;>;"
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1111
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentity/model/ListIdentitiesRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentity/model/ListIdentitiesResult;>;"
    .end local p1    # "listIdentitiesRequest":Lcom/amazonaws/services/cognitoidentity/model/ListIdentitiesRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 1120
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentity/model/ListIdentitiesRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentity/model/ListIdentitiesResult;>;"
    .restart local p1    # "listIdentitiesRequest":Lcom/amazonaws/services/cognitoidentity/model/ListIdentitiesRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1121
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentity/AmazonCognitoIdentityClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 1122
    throw v5
.end method

.method public listIdentityPools(Lcom/amazonaws/services/cognitoidentity/model/ListIdentityPoolsRequest;)Lcom/amazonaws/services/cognitoidentity/model/ListIdentityPoolsResult;
    .locals 9
    .param p1, "listIdentityPoolsRequest"    # Lcom/amazonaws/services/cognitoidentity/model/ListIdentityPoolsRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 1154
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/cognitoidentity/AmazonCognitoIdentityClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 1155
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 1156
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1157
    const/4 v2, 0x0

    .line 1158
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentity/model/ListIdentityPoolsRequest;>;"
    const/4 v3, 0x0

    .line 1160
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentity/model/ListIdentityPoolsResult;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 1162
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/cognitoidentity/model/transform/ListIdentityPoolsRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentity/model/transform/ListIdentityPoolsRequestMarshaller;-><init>()V

    .line 1163
    invoke-virtual {v5, p1}, Lcom/amazonaws/services/cognitoidentity/model/transform/ListIdentityPoolsRequestMarshaller;->marshall(Lcom/amazonaws/services/cognitoidentity/model/ListIdentityPoolsRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 1165
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 1167
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1168
    nop

    .line 1169
    new-instance v5, Lcom/amazonaws/services/cognitoidentity/model/transform/ListIdentityPoolsResultJsonUnmarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentity/model/transform/ListIdentityPoolsResultJsonUnmarshaller;-><init>()V

    .line 1170
    .local v5, "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentity/model/ListIdentityPoolsResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    new-instance v6, Lcom/amazonaws/http/JsonResponseHandler;

    invoke-direct {v6, v5}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 1173
    .local v6, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentity/model/ListIdentityPoolsResult;>;"
    invoke-direct {p0, v2, v6, v0}, Lcom/amazonaws/services/cognitoidentity/AmazonCognitoIdentityClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v7

    move-object v3, v7

    .line 1175
    invoke-virtual {v3}, Lcom/amazonaws/Response;->getAwsResponse()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/amazonaws/services/cognitoidentity/model/ListIdentityPoolsResult;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 1177
    sget-object v8, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v8}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1178
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentity/AmazonCognitoIdentityClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 1175
    return-object v7

    .line 1167
    .end local v5    # "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentity/model/ListIdentityPoolsResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    .end local v6    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentity/model/ListIdentityPoolsResult;>;"
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1168
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentity/model/ListIdentityPoolsRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentity/model/ListIdentityPoolsResult;>;"
    .end local p1    # "listIdentityPoolsRequest":Lcom/amazonaws/services/cognitoidentity/model/ListIdentityPoolsRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 1177
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentity/model/ListIdentityPoolsRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentity/model/ListIdentityPoolsResult;>;"
    .restart local p1    # "listIdentityPoolsRequest":Lcom/amazonaws/services/cognitoidentity/model/ListIdentityPoolsRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1178
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentity/AmazonCognitoIdentityClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 1179
    throw v5
.end method

.method public listTagsForResource(Lcom/amazonaws/services/cognitoidentity/model/ListTagsForResourceRequest;)Lcom/amazonaws/services/cognitoidentity/model/ListTagsForResourceResult;
    .locals 9
    .param p1, "listTagsForResourceRequest"    # Lcom/amazonaws/services/cognitoidentity/model/ListTagsForResourceRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 1215
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/cognitoidentity/AmazonCognitoIdentityClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 1216
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 1217
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1218
    const/4 v2, 0x0

    .line 1219
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentity/model/ListTagsForResourceRequest;>;"
    const/4 v3, 0x0

    .line 1221
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentity/model/ListTagsForResourceResult;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 1223
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/cognitoidentity/model/transform/ListTagsForResourceRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentity/model/transform/ListTagsForResourceRequestMarshaller;-><init>()V

    .line 1224
    invoke-virtual {v5, p1}, Lcom/amazonaws/services/cognitoidentity/model/transform/ListTagsForResourceRequestMarshaller;->marshall(Lcom/amazonaws/services/cognitoidentity/model/ListTagsForResourceRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 1226
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 1228
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1229
    nop

    .line 1230
    new-instance v5, Lcom/amazonaws/services/cognitoidentity/model/transform/ListTagsForResourceResultJsonUnmarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentity/model/transform/ListTagsForResourceResultJsonUnmarshaller;-><init>()V

    .line 1231
    .local v5, "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentity/model/ListTagsForResourceResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    new-instance v6, Lcom/amazonaws/http/JsonResponseHandler;

    invoke-direct {v6, v5}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 1234
    .local v6, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentity/model/ListTagsForResourceResult;>;"
    invoke-direct {p0, v2, v6, v0}, Lcom/amazonaws/services/cognitoidentity/AmazonCognitoIdentityClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v7

    move-object v3, v7

    .line 1236
    invoke-virtual {v3}, Lcom/amazonaws/Response;->getAwsResponse()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/amazonaws/services/cognitoidentity/model/ListTagsForResourceResult;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 1238
    sget-object v8, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v8}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1239
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentity/AmazonCognitoIdentityClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 1236
    return-object v7

    .line 1228
    .end local v5    # "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentity/model/ListTagsForResourceResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    .end local v6    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentity/model/ListTagsForResourceResult;>;"
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1229
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentity/model/ListTagsForResourceRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentity/model/ListTagsForResourceResult;>;"
    .end local p1    # "listTagsForResourceRequest":Lcom/amazonaws/services/cognitoidentity/model/ListTagsForResourceRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 1238
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentity/model/ListTagsForResourceRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentity/model/ListTagsForResourceResult;>;"
    .restart local p1    # "listTagsForResourceRequest":Lcom/amazonaws/services/cognitoidentity/model/ListTagsForResourceRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1239
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentity/AmazonCognitoIdentityClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 1240
    throw v5
.end method

.method public lookupDeveloperIdentity(Lcom/amazonaws/services/cognitoidentity/model/LookupDeveloperIdentityRequest;)Lcom/amazonaws/services/cognitoidentity/model/LookupDeveloperIdentityResult;
    .locals 9
    .param p1, "lookupDeveloperIdentityRequest"    # Lcom/amazonaws/services/cognitoidentity/model/LookupDeveloperIdentityRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 1292
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/cognitoidentity/AmazonCognitoIdentityClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 1293
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 1294
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1295
    const/4 v2, 0x0

    .line 1296
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentity/model/LookupDeveloperIdentityRequest;>;"
    const/4 v3, 0x0

    .line 1298
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentity/model/LookupDeveloperIdentityResult;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 1300
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/cognitoidentity/model/transform/LookupDeveloperIdentityRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentity/model/transform/LookupDeveloperIdentityRequestMarshaller;-><init>()V

    .line 1301
    invoke-virtual {v5, p1}, Lcom/amazonaws/services/cognitoidentity/model/transform/LookupDeveloperIdentityRequestMarshaller;->marshall(Lcom/amazonaws/services/cognitoidentity/model/LookupDeveloperIdentityRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 1303
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 1305
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1306
    nop

    .line 1307
    new-instance v5, Lcom/amazonaws/services/cognitoidentity/model/transform/LookupDeveloperIdentityResultJsonUnmarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentity/model/transform/LookupDeveloperIdentityResultJsonUnmarshaller;-><init>()V

    .line 1308
    .local v5, "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentity/model/LookupDeveloperIdentityResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    new-instance v6, Lcom/amazonaws/http/JsonResponseHandler;

    invoke-direct {v6, v5}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 1311
    .local v6, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentity/model/LookupDeveloperIdentityResult;>;"
    invoke-direct {p0, v2, v6, v0}, Lcom/amazonaws/services/cognitoidentity/AmazonCognitoIdentityClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v7

    move-object v3, v7

    .line 1313
    invoke-virtual {v3}, Lcom/amazonaws/Response;->getAwsResponse()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/amazonaws/services/cognitoidentity/model/LookupDeveloperIdentityResult;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 1315
    sget-object v8, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v8}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1316
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentity/AmazonCognitoIdentityClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 1313
    return-object v7

    .line 1305
    .end local v5    # "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentity/model/LookupDeveloperIdentityResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    .end local v6    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentity/model/LookupDeveloperIdentityResult;>;"
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1306
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentity/model/LookupDeveloperIdentityRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentity/model/LookupDeveloperIdentityResult;>;"
    .end local p1    # "lookupDeveloperIdentityRequest":Lcom/amazonaws/services/cognitoidentity/model/LookupDeveloperIdentityRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 1315
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentity/model/LookupDeveloperIdentityRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentity/model/LookupDeveloperIdentityResult;>;"
    .restart local p1    # "lookupDeveloperIdentityRequest":Lcom/amazonaws/services/cognitoidentity/model/LookupDeveloperIdentityRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1316
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentity/AmazonCognitoIdentityClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 1317
    throw v5
.end method

.method public mergeDeveloperIdentities(Lcom/amazonaws/services/cognitoidentity/model/MergeDeveloperIdentitiesRequest;)Lcom/amazonaws/services/cognitoidentity/model/MergeDeveloperIdentitiesResult;
    .locals 9
    .param p1, "mergeDeveloperIdentitiesRequest"    # Lcom/amazonaws/services/cognitoidentity/model/MergeDeveloperIdentitiesRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 1365
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/cognitoidentity/AmazonCognitoIdentityClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 1366
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 1367
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1368
    const/4 v2, 0x0

    .line 1369
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentity/model/MergeDeveloperIdentitiesRequest;>;"
    const/4 v3, 0x0

    .line 1371
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentity/model/MergeDeveloperIdentitiesResult;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 1373
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/cognitoidentity/model/transform/MergeDeveloperIdentitiesRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentity/model/transform/MergeDeveloperIdentitiesRequestMarshaller;-><init>()V

    .line 1374
    invoke-virtual {v5, p1}, Lcom/amazonaws/services/cognitoidentity/model/transform/MergeDeveloperIdentitiesRequestMarshaller;->marshall(Lcom/amazonaws/services/cognitoidentity/model/MergeDeveloperIdentitiesRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 1376
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 1378
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1379
    nop

    .line 1380
    new-instance v5, Lcom/amazonaws/services/cognitoidentity/model/transform/MergeDeveloperIdentitiesResultJsonUnmarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentity/model/transform/MergeDeveloperIdentitiesResultJsonUnmarshaller;-><init>()V

    .line 1381
    .local v5, "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentity/model/MergeDeveloperIdentitiesResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    new-instance v6, Lcom/amazonaws/http/JsonResponseHandler;

    invoke-direct {v6, v5}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 1384
    .local v6, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentity/model/MergeDeveloperIdentitiesResult;>;"
    invoke-direct {p0, v2, v6, v0}, Lcom/amazonaws/services/cognitoidentity/AmazonCognitoIdentityClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v7

    move-object v3, v7

    .line 1386
    invoke-virtual {v3}, Lcom/amazonaws/Response;->getAwsResponse()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/amazonaws/services/cognitoidentity/model/MergeDeveloperIdentitiesResult;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 1388
    sget-object v8, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v8}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1389
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentity/AmazonCognitoIdentityClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 1386
    return-object v7

    .line 1378
    .end local v5    # "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentity/model/MergeDeveloperIdentitiesResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    .end local v6    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentity/model/MergeDeveloperIdentitiesResult;>;"
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1379
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentity/model/MergeDeveloperIdentitiesRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentity/model/MergeDeveloperIdentitiesResult;>;"
    .end local p1    # "mergeDeveloperIdentitiesRequest":Lcom/amazonaws/services/cognitoidentity/model/MergeDeveloperIdentitiesRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 1388
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentity/model/MergeDeveloperIdentitiesRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentity/model/MergeDeveloperIdentitiesResult;>;"
    .restart local p1    # "mergeDeveloperIdentitiesRequest":Lcom/amazonaws/services/cognitoidentity/model/MergeDeveloperIdentitiesRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1389
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentity/AmazonCognitoIdentityClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 1390
    throw v5
.end method

.method public setIdentityPoolRoles(Lcom/amazonaws/services/cognitoidentity/model/SetIdentityPoolRolesRequest;)V
    .locals 7
    .param p1, "setIdentityPoolRolesRequest"    # Lcom/amazonaws/services/cognitoidentity/model/SetIdentityPoolRolesRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 1422
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/cognitoidentity/AmazonCognitoIdentityClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 1423
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 1424
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1425
    const/4 v2, 0x0

    .line 1426
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentity/model/SetIdentityPoolRolesRequest;>;"
    const/4 v3, 0x0

    .line 1428
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Ljava/lang/Void;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 1430
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/cognitoidentity/model/transform/SetIdentityPoolRolesRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentity/model/transform/SetIdentityPoolRolesRequestMarshaller;-><init>()V

    .line 1431
    invoke-virtual {v5, p1}, Lcom/amazonaws/services/cognitoidentity/model/transform/SetIdentityPoolRolesRequestMarshaller;->marshall(Lcom/amazonaws/services/cognitoidentity/model/SetIdentityPoolRolesRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 1433
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 1435
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1436
    nop

    .line 1437
    new-instance v5, Lcom/amazonaws/http/JsonResponseHandler;

    const/4 v6, 0x0

    invoke-direct {v5, v6}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 1438
    .local v5, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Ljava/lang/Void;>;"
    invoke-direct {p0, v2, v5, v0}, Lcom/amazonaws/services/cognitoidentity/AmazonCognitoIdentityClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 1440
    nop

    .end local v5    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Ljava/lang/Void;>;"
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1441
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentity/AmazonCognitoIdentityClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 1442
    nop

    .line 1443
    return-void

    .line 1435
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1436
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentity/model/SetIdentityPoolRolesRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Ljava/lang/Void;>;"
    .end local p1    # "setIdentityPoolRolesRequest":Lcom/amazonaws/services/cognitoidentity/model/SetIdentityPoolRolesRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 1440
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentity/model/SetIdentityPoolRolesRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Ljava/lang/Void;>;"
    .restart local p1    # "setIdentityPoolRolesRequest":Lcom/amazonaws/services/cognitoidentity/model/SetIdentityPoolRolesRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1441
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentity/AmazonCognitoIdentityClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 1442
    throw v5
.end method

.method public setPrincipalTagAttributeMap(Lcom/amazonaws/services/cognitoidentity/model/SetPrincipalTagAttributeMapRequest;)Lcom/amazonaws/services/cognitoidentity/model/SetPrincipalTagAttributeMapResult;
    .locals 9
    .param p1, "setPrincipalTagAttributeMapRequest"    # Lcom/amazonaws/services/cognitoidentity/model/SetPrincipalTagAttributeMapRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 1471
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/cognitoidentity/AmazonCognitoIdentityClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 1472
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 1473
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1474
    const/4 v2, 0x0

    .line 1475
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentity/model/SetPrincipalTagAttributeMapRequest;>;"
    const/4 v3, 0x0

    .line 1477
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentity/model/SetPrincipalTagAttributeMapResult;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 1479
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/cognitoidentity/model/transform/SetPrincipalTagAttributeMapRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentity/model/transform/SetPrincipalTagAttributeMapRequestMarshaller;-><init>()V

    .line 1480
    invoke-virtual {v5, p1}, Lcom/amazonaws/services/cognitoidentity/model/transform/SetPrincipalTagAttributeMapRequestMarshaller;->marshall(Lcom/amazonaws/services/cognitoidentity/model/SetPrincipalTagAttributeMapRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 1482
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 1484
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1485
    nop

    .line 1486
    new-instance v5, Lcom/amazonaws/services/cognitoidentity/model/transform/SetPrincipalTagAttributeMapResultJsonUnmarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentity/model/transform/SetPrincipalTagAttributeMapResultJsonUnmarshaller;-><init>()V

    .line 1487
    .local v5, "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentity/model/SetPrincipalTagAttributeMapResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    new-instance v6, Lcom/amazonaws/http/JsonResponseHandler;

    invoke-direct {v6, v5}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 1490
    .local v6, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentity/model/SetPrincipalTagAttributeMapResult;>;"
    invoke-direct {p0, v2, v6, v0}, Lcom/amazonaws/services/cognitoidentity/AmazonCognitoIdentityClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v7

    move-object v3, v7

    .line 1492
    invoke-virtual {v3}, Lcom/amazonaws/Response;->getAwsResponse()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/amazonaws/services/cognitoidentity/model/SetPrincipalTagAttributeMapResult;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 1494
    sget-object v8, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v8}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1495
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentity/AmazonCognitoIdentityClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 1492
    return-object v7

    .line 1484
    .end local v5    # "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentity/model/SetPrincipalTagAttributeMapResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    .end local v6    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentity/model/SetPrincipalTagAttributeMapResult;>;"
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1485
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentity/model/SetPrincipalTagAttributeMapRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentity/model/SetPrincipalTagAttributeMapResult;>;"
    .end local p1    # "setPrincipalTagAttributeMapRequest":Lcom/amazonaws/services/cognitoidentity/model/SetPrincipalTagAttributeMapRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 1494
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentity/model/SetPrincipalTagAttributeMapRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentity/model/SetPrincipalTagAttributeMapResult;>;"
    .restart local p1    # "setPrincipalTagAttributeMapRequest":Lcom/amazonaws/services/cognitoidentity/model/SetPrincipalTagAttributeMapRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1495
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentity/AmazonCognitoIdentityClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 1496
    throw v5
.end method

.method public tagResource(Lcom/amazonaws/services/cognitoidentity/model/TagResourceRequest;)Lcom/amazonaws/services/cognitoidentity/model/TagResourceResult;
    .locals 9
    .param p1, "tagResourceRequest"    # Lcom/amazonaws/services/cognitoidentity/model/TagResourceRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 1544
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/cognitoidentity/AmazonCognitoIdentityClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 1545
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 1546
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1547
    const/4 v2, 0x0

    .line 1548
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentity/model/TagResourceRequest;>;"
    const/4 v3, 0x0

    .line 1550
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentity/model/TagResourceResult;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 1552
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/cognitoidentity/model/transform/TagResourceRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentity/model/transform/TagResourceRequestMarshaller;-><init>()V

    invoke-virtual {v5, p1}, Lcom/amazonaws/services/cognitoidentity/model/transform/TagResourceRequestMarshaller;->marshall(Lcom/amazonaws/services/cognitoidentity/model/TagResourceRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 1554
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 1556
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1557
    nop

    .line 1558
    new-instance v5, Lcom/amazonaws/services/cognitoidentity/model/transform/TagResourceResultJsonUnmarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentity/model/transform/TagResourceResultJsonUnmarshaller;-><init>()V

    .line 1559
    .local v5, "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentity/model/TagResourceResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    new-instance v6, Lcom/amazonaws/http/JsonResponseHandler;

    invoke-direct {v6, v5}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 1562
    .local v6, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentity/model/TagResourceResult;>;"
    invoke-direct {p0, v2, v6, v0}, Lcom/amazonaws/services/cognitoidentity/AmazonCognitoIdentityClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v7

    move-object v3, v7

    .line 1564
    invoke-virtual {v3}, Lcom/amazonaws/Response;->getAwsResponse()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/amazonaws/services/cognitoidentity/model/TagResourceResult;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 1566
    sget-object v8, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v8}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1567
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentity/AmazonCognitoIdentityClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 1564
    return-object v7

    .line 1556
    .end local v5    # "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentity/model/TagResourceResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    .end local v6    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentity/model/TagResourceResult;>;"
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1557
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentity/model/TagResourceRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentity/model/TagResourceResult;>;"
    .end local p1    # "tagResourceRequest":Lcom/amazonaws/services/cognitoidentity/model/TagResourceRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 1566
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentity/model/TagResourceRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentity/model/TagResourceResult;>;"
    .restart local p1    # "tagResourceRequest":Lcom/amazonaws/services/cognitoidentity/model/TagResourceRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1567
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentity/AmazonCognitoIdentityClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 1568
    throw v5
.end method

.method public unlinkDeveloperIdentity(Lcom/amazonaws/services/cognitoidentity/model/UnlinkDeveloperIdentityRequest;)V
    .locals 7
    .param p1, "unlinkDeveloperIdentityRequest"    # Lcom/amazonaws/services/cognitoidentity/model/UnlinkDeveloperIdentityRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 1603
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/cognitoidentity/AmazonCognitoIdentityClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 1604
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 1605
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1606
    const/4 v2, 0x0

    .line 1607
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentity/model/UnlinkDeveloperIdentityRequest;>;"
    const/4 v3, 0x0

    .line 1609
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Ljava/lang/Void;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 1611
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/cognitoidentity/model/transform/UnlinkDeveloperIdentityRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentity/model/transform/UnlinkDeveloperIdentityRequestMarshaller;-><init>()V

    .line 1612
    invoke-virtual {v5, p1}, Lcom/amazonaws/services/cognitoidentity/model/transform/UnlinkDeveloperIdentityRequestMarshaller;->marshall(Lcom/amazonaws/services/cognitoidentity/model/UnlinkDeveloperIdentityRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 1614
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 1616
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1617
    nop

    .line 1618
    new-instance v5, Lcom/amazonaws/http/JsonResponseHandler;

    const/4 v6, 0x0

    invoke-direct {v5, v6}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 1619
    .local v5, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Ljava/lang/Void;>;"
    invoke-direct {p0, v2, v5, v0}, Lcom/amazonaws/services/cognitoidentity/AmazonCognitoIdentityClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 1621
    nop

    .end local v5    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Ljava/lang/Void;>;"
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1622
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentity/AmazonCognitoIdentityClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 1623
    nop

    .line 1624
    return-void

    .line 1616
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1617
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentity/model/UnlinkDeveloperIdentityRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Ljava/lang/Void;>;"
    .end local p1    # "unlinkDeveloperIdentityRequest":Lcom/amazonaws/services/cognitoidentity/model/UnlinkDeveloperIdentityRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 1621
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentity/model/UnlinkDeveloperIdentityRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Ljava/lang/Void;>;"
    .restart local p1    # "unlinkDeveloperIdentityRequest":Lcom/amazonaws/services/cognitoidentity/model/UnlinkDeveloperIdentityRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1622
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentity/AmazonCognitoIdentityClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 1623
    throw v5
.end method

.method public unlinkIdentity(Lcom/amazonaws/services/cognitoidentity/model/UnlinkIdentityRequest;)V
    .locals 7
    .param p1, "unlinkIdentityRequest"    # Lcom/amazonaws/services/cognitoidentity/model/UnlinkIdentityRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 1656
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/cognitoidentity/AmazonCognitoIdentityClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 1657
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 1658
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1659
    const/4 v2, 0x0

    .line 1660
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentity/model/UnlinkIdentityRequest;>;"
    const/4 v3, 0x0

    .line 1662
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Ljava/lang/Void;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 1664
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/cognitoidentity/model/transform/UnlinkIdentityRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentity/model/transform/UnlinkIdentityRequestMarshaller;-><init>()V

    invoke-virtual {v5, p1}, Lcom/amazonaws/services/cognitoidentity/model/transform/UnlinkIdentityRequestMarshaller;->marshall(Lcom/amazonaws/services/cognitoidentity/model/UnlinkIdentityRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 1666
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 1668
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1669
    nop

    .line 1670
    new-instance v5, Lcom/amazonaws/http/JsonResponseHandler;

    const/4 v6, 0x0

    invoke-direct {v5, v6}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 1671
    .local v5, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Ljava/lang/Void;>;"
    invoke-direct {p0, v2, v5, v0}, Lcom/amazonaws/services/cognitoidentity/AmazonCognitoIdentityClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 1673
    nop

    .end local v5    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Ljava/lang/Void;>;"
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1674
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentity/AmazonCognitoIdentityClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 1675
    nop

    .line 1676
    return-void

    .line 1668
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1669
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentity/model/UnlinkIdentityRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Ljava/lang/Void;>;"
    .end local p1    # "unlinkIdentityRequest":Lcom/amazonaws/services/cognitoidentity/model/UnlinkIdentityRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 1673
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentity/model/UnlinkIdentityRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Ljava/lang/Void;>;"
    .restart local p1    # "unlinkIdentityRequest":Lcom/amazonaws/services/cognitoidentity/model/UnlinkIdentityRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1674
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentity/AmazonCognitoIdentityClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 1675
    throw v5
.end method

.method public untagResource(Lcom/amazonaws/services/cognitoidentity/model/UntagResourceRequest;)Lcom/amazonaws/services/cognitoidentity/model/UntagResourceResult;
    .locals 9
    .param p1, "untagResourceRequest"    # Lcom/amazonaws/services/cognitoidentity/model/UntagResourceRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 1702
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/cognitoidentity/AmazonCognitoIdentityClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 1703
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 1704
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1705
    const/4 v2, 0x0

    .line 1706
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentity/model/UntagResourceRequest;>;"
    const/4 v3, 0x0

    .line 1708
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentity/model/UntagResourceResult;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 1710
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/cognitoidentity/model/transform/UntagResourceRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentity/model/transform/UntagResourceRequestMarshaller;-><init>()V

    invoke-virtual {v5, p1}, Lcom/amazonaws/services/cognitoidentity/model/transform/UntagResourceRequestMarshaller;->marshall(Lcom/amazonaws/services/cognitoidentity/model/UntagResourceRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 1712
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 1714
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1715
    nop

    .line 1716
    new-instance v5, Lcom/amazonaws/services/cognitoidentity/model/transform/UntagResourceResultJsonUnmarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentity/model/transform/UntagResourceResultJsonUnmarshaller;-><init>()V

    .line 1717
    .local v5, "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentity/model/UntagResourceResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    new-instance v6, Lcom/amazonaws/http/JsonResponseHandler;

    invoke-direct {v6, v5}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 1720
    .local v6, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentity/model/UntagResourceResult;>;"
    invoke-direct {p0, v2, v6, v0}, Lcom/amazonaws/services/cognitoidentity/AmazonCognitoIdentityClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v7

    move-object v3, v7

    .line 1722
    invoke-virtual {v3}, Lcom/amazonaws/Response;->getAwsResponse()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/amazonaws/services/cognitoidentity/model/UntagResourceResult;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 1724
    sget-object v8, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v8}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1725
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentity/AmazonCognitoIdentityClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 1722
    return-object v7

    .line 1714
    .end local v5    # "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentity/model/UntagResourceResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    .end local v6    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentity/model/UntagResourceResult;>;"
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1715
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentity/model/UntagResourceRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentity/model/UntagResourceResult;>;"
    .end local p1    # "untagResourceRequest":Lcom/amazonaws/services/cognitoidentity/model/UntagResourceRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 1724
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentity/model/UntagResourceRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentity/model/UntagResourceResult;>;"
    .restart local p1    # "untagResourceRequest":Lcom/amazonaws/services/cognitoidentity/model/UntagResourceRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1725
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentity/AmazonCognitoIdentityClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 1726
    throw v5
.end method

.method public updateIdentityPool(Lcom/amazonaws/services/cognitoidentity/model/UpdateIdentityPoolRequest;)Lcom/amazonaws/services/cognitoidentity/model/UpdateIdentityPoolResult;
    .locals 9
    .param p1, "updateIdentityPoolRequest"    # Lcom/amazonaws/services/cognitoidentity/model/UpdateIdentityPoolRequest;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/amazonaws/AmazonServiceException;,
            Lcom/amazonaws/AmazonClientException;
        }
    .end annotation

    .line 1761
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/cognitoidentity/AmazonCognitoIdentityClient;->createExecutionContext(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/http/ExecutionContext;

    move-result-object v0

    .line 1762
    .local v0, "executionContext":Lcom/amazonaws/http/ExecutionContext;
    invoke-virtual {v0}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 1763
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1764
    const/4 v2, 0x0

    .line 1765
    .local v2, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentity/model/UpdateIdentityPoolRequest;>;"
    const/4 v3, 0x0

    .line 1767
    .local v3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentity/model/UpdateIdentityPoolResult;>;"
    const/4 v4, 0x1

    :try_start_0
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 1769
    :try_start_1
    new-instance v5, Lcom/amazonaws/services/cognitoidentity/model/transform/UpdateIdentityPoolRequestMarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentity/model/transform/UpdateIdentityPoolRequestMarshaller;-><init>()V

    .line 1770
    invoke-virtual {v5, p1}, Lcom/amazonaws/services/cognitoidentity/model/transform/UpdateIdentityPoolRequestMarshaller;->marshall(Lcom/amazonaws/services/cognitoidentity/model/UpdateIdentityPoolRequest;)Lcom/amazonaws/Request;

    move-result-object v5

    move-object v2, v5

    .line 1772
    invoke-interface {v2, v1}, Lcom/amazonaws/Request;->setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 1774
    :try_start_2
    sget-object v5, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v5}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1775
    nop

    .line 1776
    new-instance v5, Lcom/amazonaws/services/cognitoidentity/model/transform/UpdateIdentityPoolResultJsonUnmarshaller;

    invoke-direct {v5}, Lcom/amazonaws/services/cognitoidentity/model/transform/UpdateIdentityPoolResultJsonUnmarshaller;-><init>()V

    .line 1777
    .local v5, "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentity/model/UpdateIdentityPoolResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    new-instance v6, Lcom/amazonaws/http/JsonResponseHandler;

    invoke-direct {v6, v5}, Lcom/amazonaws/http/JsonResponseHandler;-><init>(Lcom/amazonaws/transform/Unmarshaller;)V

    .line 1780
    .local v6, "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentity/model/UpdateIdentityPoolResult;>;"
    invoke-direct {p0, v2, v6, v0}, Lcom/amazonaws/services/cognitoidentity/AmazonCognitoIdentityClient;->invoke(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v7

    move-object v3, v7

    .line 1782
    invoke-virtual {v3}, Lcom/amazonaws/Response;->getAwsResponse()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/amazonaws/services/cognitoidentity/model/UpdateIdentityPoolResult;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 1784
    sget-object v8, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v8}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1785
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentity/AmazonCognitoIdentityClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 1782
    return-object v7

    .line 1774
    .end local v5    # "unmarshaller":Lcom/amazonaws/transform/Unmarshaller;, "Lcom/amazonaws/transform/Unmarshaller<Lcom/amazonaws/services/cognitoidentity/model/UpdateIdentityPoolResult;Lcom/amazonaws/transform/JsonUnmarshallerContext;>;"
    .end local v6    # "responseHandler":Lcom/amazonaws/http/JsonResponseHandler;, "Lcom/amazonaws/http/JsonResponseHandler<Lcom/amazonaws/services/cognitoidentity/model/UpdateIdentityPoolResult;>;"
    :catchall_0
    move-exception v5

    :try_start_3
    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestMarshallTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1775
    nop

    .end local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentity/model/UpdateIdentityPoolRequest;>;"
    .end local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentity/model/UpdateIdentityPoolResult;>;"
    .end local p1    # "updateIdentityPoolRequest":Lcom/amazonaws/services/cognitoidentity/model/UpdateIdentityPoolRequest;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 1784
    .restart local v0    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    .restart local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v2    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<Lcom/amazonaws/services/cognitoidentity/model/UpdateIdentityPoolRequest;>;"
    .restart local v3    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<Lcom/amazonaws/services/cognitoidentity/model/UpdateIdentityPoolResult;>;"
    .restart local p1    # "updateIdentityPoolRequest":Lcom/amazonaws/services/cognitoidentity/model/UpdateIdentityPoolRequest;
    :catchall_1
    move-exception v5

    sget-object v6, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ClientExecuteTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v6}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 1785
    invoke-virtual {p0, v1, v2, v3, v4}, Lcom/amazonaws/services/cognitoidentity/AmazonCognitoIdentityClient;->endClientExecution(Lcom/amazonaws/util/AWSRequestMetrics;Lcom/amazonaws/Request;Lcom/amazonaws/Response;Z)V

    .line 1786
    throw v5
.end method
