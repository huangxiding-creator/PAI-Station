.class public Lcom/amazonaws/http/AmazonHttpClient;
.super Ljava/lang/Object;
.source "AmazonHttpClient.java"


# static fields
.field private static final HEADER_SDK_RETRY_INFO:Ljava/lang/String; = "aws-sdk-retry"

.field private static final HEADER_SDK_TRANSACTION_ID:Ljava/lang/String; = "aws-sdk-invocation-id"

.field private static final HEADER_USER_AGENT:Ljava/lang/String; = "User-Agent"

.field private static final HTTP_STATUS_MULTIPLE_CHOICES:I = 0x12c

.field private static final HTTP_STATUS_OK:I = 0xc8

.field private static final HTTP_STATUS_REQ_TOO_LONG:I = 0x19d

.field private static final HTTP_STATUS_SERVICE_UNAVAILABLE:I = 0x1f7

.field private static final HTTP_STATUS_TEMP_REDIRECT:I = 0x133

.field private static final REQUEST_LOG:Lcom/amazonaws/logging/Log;

.field private static final TIME_MILLISEC:I = 0x3e8

.field static final log:Lcom/amazonaws/logging/Log;


# instance fields
.field final config:Lcom/amazonaws/ClientConfiguration;

.field final httpClient:Lcom/amazonaws/http/HttpClient;

.field private final requestFactory:Lcom/amazonaws/http/HttpRequestFactory;

.field private final requestMetricCollector:Lcom/amazonaws/metrics/RequestMetricCollector;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 82
    const-string v0, "com.amazonaws.request"

    invoke-static {v0}, Lcom/amazonaws/logging/LogFactory;->getLog(Ljava/lang/String;)Lcom/amazonaws/logging/Log;

    move-result-object v0

    sput-object v0, Lcom/amazonaws/http/AmazonHttpClient;->REQUEST_LOG:Lcom/amazonaws/logging/Log;

    .line 88
    const-class v0, Lcom/amazonaws/http/AmazonHttpClient;

    invoke-static {v0}, Lcom/amazonaws/logging/LogFactory;->getLog(Ljava/lang/Class;)Lcom/amazonaws/logging/Log;

    move-result-object v0

    sput-object v0, Lcom/amazonaws/http/AmazonHttpClient;->log:Lcom/amazonaws/logging/Log;

    return-void
.end method

.method public constructor <init>(Lcom/amazonaws/ClientConfiguration;)V
    .locals 1
    .param p1, "config"    # Lcom/amazonaws/ClientConfiguration;

    .line 115
    new-instance v0, Lcom/amazonaws/http/UrlHttpClient;

    invoke-direct {v0, p1}, Lcom/amazonaws/http/UrlHttpClient;-><init>(Lcom/amazonaws/ClientConfiguration;)V

    invoke-direct {p0, p1, v0}, Lcom/amazonaws/http/AmazonHttpClient;-><init>(Lcom/amazonaws/ClientConfiguration;Lcom/amazonaws/http/HttpClient;)V

    .line 116
    return-void
.end method

.method public constructor <init>(Lcom/amazonaws/ClientConfiguration;Lcom/amazonaws/http/HttpClient;)V
    .locals 1
    .param p1, "config"    # Lcom/amazonaws/ClientConfiguration;
    .param p2, "httpClient"    # Lcom/amazonaws/http/HttpClient;

    .line 144
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 105
    new-instance v0, Lcom/amazonaws/http/HttpRequestFactory;

    invoke-direct {v0}, Lcom/amazonaws/http/HttpRequestFactory;-><init>()V

    iput-object v0, p0, Lcom/amazonaws/http/AmazonHttpClient;->requestFactory:Lcom/amazonaws/http/HttpRequestFactory;

    .line 145
    iput-object p1, p0, Lcom/amazonaws/http/AmazonHttpClient;->config:Lcom/amazonaws/ClientConfiguration;

    .line 146
    iput-object p2, p0, Lcom/amazonaws/http/AmazonHttpClient;->httpClient:Lcom/amazonaws/http/HttpClient;

    .line 147
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/amazonaws/http/AmazonHttpClient;->requestMetricCollector:Lcom/amazonaws/metrics/RequestMetricCollector;

    .line 148
    return-void
.end method

.method public constructor <init>(Lcom/amazonaws/ClientConfiguration;Lcom/amazonaws/http/HttpClient;Lcom/amazonaws/metrics/RequestMetricCollector;)V
    .locals 1
    .param p1, "config"    # Lcom/amazonaws/ClientConfiguration;
    .param p2, "httpClient"    # Lcom/amazonaws/http/HttpClient;
    .param p3, "requestMetricCollector"    # Lcom/amazonaws/metrics/RequestMetricCollector;
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 164
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 105
    new-instance v0, Lcom/amazonaws/http/HttpRequestFactory;

    invoke-direct {v0}, Lcom/amazonaws/http/HttpRequestFactory;-><init>()V

    iput-object v0, p0, Lcom/amazonaws/http/AmazonHttpClient;->requestFactory:Lcom/amazonaws/http/HttpRequestFactory;

    .line 165
    iput-object p1, p0, Lcom/amazonaws/http/AmazonHttpClient;->config:Lcom/amazonaws/ClientConfiguration;

    .line 166
    iput-object p2, p0, Lcom/amazonaws/http/AmazonHttpClient;->httpClient:Lcom/amazonaws/http/HttpClient;

    .line 167
    iput-object p3, p0, Lcom/amazonaws/http/AmazonHttpClient;->requestMetricCollector:Lcom/amazonaws/metrics/RequestMetricCollector;

    .line 168
    return-void
.end method

.method public constructor <init>(Lcom/amazonaws/ClientConfiguration;Lcom/amazonaws/metrics/RequestMetricCollector;)V
    .locals 1
    .param p1, "config"    # Lcom/amazonaws/ClientConfiguration;
    .param p2, "requestMetricCollector"    # Lcom/amazonaws/metrics/RequestMetricCollector;
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 132
    new-instance v0, Lcom/amazonaws/http/UrlHttpClient;

    invoke-direct {v0, p1}, Lcom/amazonaws/http/UrlHttpClient;-><init>(Lcom/amazonaws/ClientConfiguration;)V

    invoke-direct {p0, p1, v0, p2}, Lcom/amazonaws/http/AmazonHttpClient;-><init>(Lcom/amazonaws/ClientConfiguration;Lcom/amazonaws/http/HttpClient;Lcom/amazonaws/metrics/RequestMetricCollector;)V

    .line 133
    return-void
.end method

.method static createUserAgentString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .locals 2
    .param p0, "existingUserAgentString"    # Ljava/lang/String;
    .param p1, "userAgent"    # Ljava/lang/String;

    .line 560
    invoke-virtual {p0, p1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 561
    return-object p0

    .line 563
    :cond_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {p1}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method private getServerDateFromException(Ljava/lang/String;)Ljava/lang/String;
    .locals 4
    .param p1, "body"    # Ljava/lang/String;

    .line 795
    const-string v0, "("

    invoke-virtual {p1, v0}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v0

    .line 796
    .local v0, "startPos":I
    const/4 v1, 0x0

    .line 797
    .local v1, "endPos":I
    const-string v2, " + 15"

    invoke-virtual {p1, v2}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v3

    if-eqz v3, :cond_0

    .line 798
    invoke-virtual {p1, v2}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v1

    goto :goto_0

    .line 800
    :cond_0
    const-string v2, " - 15"

    invoke-virtual {p1, v2}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v1

    .line 802
    :goto_0
    add-int/lit8 v2, v0, 0x1

    invoke-virtual {p1, v2, v1}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v2

    .line 803
    .local v2, "msg":Ljava/lang/String;
    return-object v2
.end method

.method private handleUnexpectedFailure(Ljava/lang/Throwable;Lcom/amazonaws/util/AWSRequestMetrics;)Ljava/lang/Throwable;
    .locals 1
    .param p2, "awsRequestMetrics"    # Lcom/amazonaws/util/AWSRequestMetrics;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Ljava/lang/Throwable;",
            ">(TT;",
            "Lcom/amazonaws/util/AWSRequestMetrics;",
            ")TT;"
        }
    .end annotation

    .line 497
    .local p1, "t":Ljava/lang/Throwable;, "TT;"
    sget-object v0, Lcom/amazonaws/util/AWSRequestMetrics$Field;->Exception:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {p2, v0}, Lcom/amazonaws/util/AWSRequestMetrics;->incrementCounter(Lcom/amazonaws/metrics/MetricType;)V

    .line 498
    sget-object v0, Lcom/amazonaws/util/AWSRequestMetrics$Field;->Exception:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {p2, v0, p1}, Lcom/amazonaws/util/AWSRequestMetrics;->addProperty(Lcom/amazonaws/metrics/MetricType;Ljava/lang/Object;)V

    .line 499
    return-object p1
.end method

.method private isRequestSuccessful(Lcom/amazonaws/http/HttpResponse;)Z
    .locals 2
    .param p1, "response"    # Lcom/amazonaws/http/HttpResponse;

    .line 632
    invoke-virtual {p1}, Lcom/amazonaws/http/HttpResponse;->getStatusCode()I

    move-result v0

    .line 633
    .local v0, "statusCode":I
    const/16 v1, 0xc8

    if-lt v0, v1, :cond_0

    const/16 v1, 0x12c

    if-ge v0, v1, :cond_0

    const/4 v1, 0x1

    goto :goto_0

    :cond_0
    const/4 v1, 0x0

    :goto_0
    return v1
.end method

.method private static isTemporaryRedirect(Lcom/amazonaws/http/HttpResponse;)Z
    .locals 3
    .param p0, "response"    # Lcom/amazonaws/http/HttpResponse;

    .line 625
    invoke-virtual {p0}, Lcom/amazonaws/http/HttpResponse;->getStatusCode()I

    move-result v0

    .line 626
    .local v0, "statusCode":I
    invoke-virtual {p0}, Lcom/amazonaws/http/HttpResponse;->getHeaders()Ljava/util/Map;

    move-result-object v1

    const-string v2, "Location"

    invoke-interface {v1, v2}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    .line 627
    .local v1, "location":Ljava/lang/String;
    const/16 v2, 0x133

    if-ne v0, v2, :cond_0

    if-eqz v1, :cond_0

    .line 628
    invoke-virtual {v1}, Ljava/lang/String;->isEmpty()Z

    move-result v2

    if-nez v2, :cond_0

    const/4 v2, 0x1

    goto :goto_0

    :cond_0
    const/4 v2, 0x0

    .line 627
    :goto_0
    return v2
.end method

.method private pauseBeforeNextRetry(Lcom/amazonaws/AmazonWebServiceRequest;Lcom/amazonaws/AmazonClientException;ILcom/amazonaws/retry/RetryPolicy;)J
    .locals 6
    .param p1, "originalRequest"    # Lcom/amazonaws/AmazonWebServiceRequest;
    .param p2, "previousException"    # Lcom/amazonaws/AmazonClientException;
    .param p3, "requestCount"    # I
    .param p4, "retryPolicy"    # Lcom/amazonaws/retry/RetryPolicy;

    .line 762
    add-int/lit8 v0, p3, -0x1

    add-int/lit8 v0, v0, -0x1

    .line 766
    .local v0, "retries":I
    invoke-virtual {p4}, Lcom/amazonaws/retry/RetryPolicy;->getBackoffStrategy()Lcom/amazonaws/retry/RetryPolicy$BackoffStrategy;

    move-result-object v1

    invoke-interface {v1, p1, p2, v0}, Lcom/amazonaws/retry/RetryPolicy$BackoffStrategy;->delayBeforeNextRetry(Lcom/amazonaws/AmazonWebServiceRequest;Lcom/amazonaws/AmazonClientException;I)J

    move-result-wide v1

    .line 769
    .local v1, "delay":J
    sget-object v3, Lcom/amazonaws/http/AmazonHttpClient;->log:Lcom/amazonaws/logging/Log;

    invoke-interface {v3}, Lcom/amazonaws/logging/Log;->isDebugEnabled()Z

    move-result v3

    if-eqz v3, :cond_0

    .line 770
    sget-object v3, Lcom/amazonaws/http/AmazonHttpClient;->log:Lcom/amazonaws/logging/Log;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "Retriable error detected, will retry in "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v1, v2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "ms, attempt number: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-interface {v3, v4}, Lcom/amazonaws/logging/Log;->debug(Ljava/lang/Object;)V

    .line 775
    :cond_0
    :try_start_0
    invoke-static {v1, v2}, Ljava/lang/Thread;->sleep(J)V
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_0

    .line 776
    return-wide v1

    .line 777
    :catch_0
    move-exception v3

    .line 778
    .local v3, "e":Ljava/lang/InterruptedException;
    invoke-static {}, Ljava/lang/Thread;->currentThread()Ljava/lang/Thread;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/Thread;->interrupt()V

    .line 779
    new-instance v4, Lcom/amazonaws/AmazonClientException;

    invoke-virtual {v3}, Ljava/lang/InterruptedException;->getMessage()Ljava/lang/String;

    move-result-object v5

    invoke-direct {v4, v5, v3}, Lcom/amazonaws/AmazonClientException;-><init>(Ljava/lang/String;Ljava/lang/Throwable;)V

    throw v4
.end method

.method private shouldRetry(Lcom/amazonaws/AmazonWebServiceRequest;Ljava/io/InputStream;Lcom/amazonaws/AmazonClientException;ILcom/amazonaws/retry/RetryPolicy;)Z
    .locals 5
    .param p1, "originalRequest"    # Lcom/amazonaws/AmazonWebServiceRequest;
    .param p2, "inputStream"    # Ljava/io/InputStream;
    .param p3, "exception"    # Lcom/amazonaws/AmazonClientException;
    .param p4, "requestCount"    # I
    .param p5, "retryPolicy"    # Lcom/amazonaws/retry/RetryPolicy;

    .line 592
    add-int/lit8 v0, p4, -0x1

    .line 594
    .local v0, "retries":I
    iget-object v1, p0, Lcom/amazonaws/http/AmazonHttpClient;->config:Lcom/amazonaws/ClientConfiguration;

    invoke-virtual {v1}, Lcom/amazonaws/ClientConfiguration;->getMaxErrorRetry()I

    move-result v1

    .line 599
    .local v1, "maxErrorRetry":I
    if-ltz v1, :cond_0

    .line 600
    invoke-virtual {p5}, Lcom/amazonaws/retry/RetryPolicy;->isMaxErrorRetryInClientConfigHonored()Z

    move-result v2

    if-nez v2, :cond_1

    .line 601
    :cond_0
    invoke-virtual {p5}, Lcom/amazonaws/retry/RetryPolicy;->getMaxErrorRetry()I

    move-result v1

    .line 605
    :cond_1
    const/4 v2, 0x0

    if-lt v0, v1, :cond_2

    .line 606
    return v2

    .line 610
    :cond_2
    if-eqz p2, :cond_4

    invoke-virtual {p2}, Ljava/io/InputStream;->markSupported()Z

    move-result v3

    if-nez v3, :cond_4

    .line 611
    sget-object v3, Lcom/amazonaws/http/AmazonHttpClient;->log:Lcom/amazonaws/logging/Log;

    invoke-interface {v3}, Lcom/amazonaws/logging/Log;->isDebugEnabled()Z

    move-result v3

    if-eqz v3, :cond_3

    .line 612
    sget-object v3, Lcom/amazonaws/http/AmazonHttpClient;->log:Lcom/amazonaws/logging/Log;

    const-string v4, "Content not repeatable"

    invoke-interface {v3, v4}, Lcom/amazonaws/logging/Log;->debug(Ljava/lang/Object;)V

    .line 614
    :cond_3
    return v2

    .line 619
    :cond_4
    invoke-virtual {p5}, Lcom/amazonaws/retry/RetryPolicy;->getRetryCondition()Lcom/amazonaws/retry/RetryPolicy$RetryCondition;

    move-result-object v2

    invoke-interface {v2, p1, p3, v0}, Lcom/amazonaws/retry/RetryPolicy$RetryCondition;->shouldRetry(Lcom/amazonaws/AmazonWebServiceRequest;Lcom/amazonaws/AmazonClientException;I)Z

    move-result v2

    return v2
.end method


# virtual methods
.method afterError(Lcom/amazonaws/Request;Lcom/amazonaws/Response;Ljava/util/List;Lcom/amazonaws/AmazonClientException;)V
    .locals 2
    .param p4, "e"    # Lcom/amazonaws/AmazonClientException;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/amazonaws/Request<",
            "*>;",
            "Lcom/amazonaws/Response<",
            "*>;",
            "Ljava/util/List<",
            "Lcom/amazonaws/handlers/RequestHandler2;",
            ">;",
            "Lcom/amazonaws/AmazonClientException;",
            ")V"
        }
    .end annotation

    .line 242
    .local p1, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<*>;"
    .local p2, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<*>;"
    .local p3, "requestHandler2s":Ljava/util/List;, "Ljava/util/List<Lcom/amazonaws/handlers/RequestHandler2;>;"
    invoke-interface {p3}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/amazonaws/handlers/RequestHandler2;

    .line 243
    .local v1, "handler2":Lcom/amazonaws/handlers/RequestHandler2;
    invoke-virtual {v1, p1, p2, p4}, Lcom/amazonaws/handlers/RequestHandler2;->afterError(Lcom/amazonaws/Request;Lcom/amazonaws/Response;Ljava/lang/Exception;)V

    .line 244
    .end local v1    # "handler2":Lcom/amazonaws/handlers/RequestHandler2;
    goto :goto_0

    .line 245
    :cond_0
    return-void
.end method

.method afterResponse(Lcom/amazonaws/Request;Ljava/util/List;Lcom/amazonaws/Response;Lcom/amazonaws/util/TimingInfo;)V
    .locals 2
    .param p4, "timingInfo"    # Lcom/amazonaws/util/TimingInfo;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Ljava/lang/Object;",
            ">(",
            "Lcom/amazonaws/Request<",
            "*>;",
            "Ljava/util/List<",
            "Lcom/amazonaws/handlers/RequestHandler2;",
            ">;",
            "Lcom/amazonaws/Response<",
            "TT;>;",
            "Lcom/amazonaws/util/TimingInfo;",
            ")V"
        }
    .end annotation

    .line 251
    .local p1, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<*>;"
    .local p2, "requestHandler2s":Ljava/util/List;, "Ljava/util/List<Lcom/amazonaws/handlers/RequestHandler2;>;"
    .local p3, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<TT;>;"
    invoke-interface {p2}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/amazonaws/handlers/RequestHandler2;

    .line 252
    .local v1, "handler2":Lcom/amazonaws/handlers/RequestHandler2;
    invoke-virtual {v1, p1, p3}, Lcom/amazonaws/handlers/RequestHandler2;->afterResponse(Lcom/amazonaws/Request;Lcom/amazonaws/Response;)V

    .line 253
    .end local v1    # "handler2":Lcom/amazonaws/handlers/RequestHandler2;
    goto :goto_0

    .line 254
    :cond_0
    return-void
.end method

.method public execute(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;
    .locals 4
    .param p4, "executionContext"    # Lcom/amazonaws/http/ExecutionContext;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Ljava/lang/Object;",
            ">(",
            "Lcom/amazonaws/Request<",
            "*>;",
            "Lcom/amazonaws/http/HttpResponseHandler<",
            "Lcom/amazonaws/AmazonWebServiceResponse<",
            "TT;>;>;",
            "Lcom/amazonaws/http/HttpResponseHandler<",
            "Lcom/amazonaws/AmazonServiceException;",
            ">;",
            "Lcom/amazonaws/http/ExecutionContext;",
            ")",
            "Lcom/amazonaws/Response<",
            "TT;>;"
        }
    .end annotation

    .line 208
    .local p1, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<*>;"
    .local p2, "responseHandler":Lcom/amazonaws/http/HttpResponseHandler;, "Lcom/amazonaws/http/HttpResponseHandler<Lcom/amazonaws/AmazonWebServiceResponse<TT;>;>;"
    .local p3, "errorResponseHandler":Lcom/amazonaws/http/HttpResponseHandler;, "Lcom/amazonaws/http/HttpResponseHandler<Lcom/amazonaws/AmazonServiceException;>;"
    invoke-interface {p1}, Lcom/amazonaws/Request;->getHostPrefix()Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_0

    .line 210
    :try_start_0
    invoke-interface {p1}, Lcom/amazonaws/Request;->getEndpoint()Ljava/net/URI;

    move-result-object v0

    .line 211
    .local v0, "endpoint":Ljava/net/URI;
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-interface {p1}, Lcom/amazonaws/Request;->getHostPrefix()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v0}, Ljava/net/URI;->getHost()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 212
    .local v1, "host":Ljava/lang/String;
    invoke-static {v0}, Lcom/amazonaws/util/URIBuilder;->builder(Ljava/net/URI;)Lcom/amazonaws/util/URIBuilder;

    move-result-object v2

    .line 213
    invoke-virtual {v2, v1}, Lcom/amazonaws/util/URIBuilder;->host(Ljava/lang/String;)Lcom/amazonaws/util/URIBuilder;

    move-result-object v2

    .line 214
    invoke-virtual {v2}, Lcom/amazonaws/util/URIBuilder;->build()Ljava/net/URI;

    move-result-object v2

    .line 212
    invoke-interface {p1, v2}, Lcom/amazonaws/Request;->setEndpoint(Ljava/net/URI;)V
    :try_end_0
    .catch Ljava/net/URISyntaxException; {:try_start_0 .. :try_end_0} :catch_0

    .line 219
    .end local v0    # "endpoint":Ljava/net/URI;
    .end local v1    # "host":Ljava/lang/String;
    goto :goto_0

    .line 215
    :catch_0
    move-exception v0

    .line 216
    .local v0, "error":Ljava/net/URISyntaxException;
    sget-object v1, Lcom/amazonaws/http/AmazonHttpClient;->log:Lcom/amazonaws/logging/Log;

    invoke-interface {v1}, Lcom/amazonaws/logging/Log;->isDebugEnabled()Z

    move-result v1

    if-eqz v1, :cond_0

    .line 217
    sget-object v1, Lcom/amazonaws/http/AmazonHttpClient;->log:Lcom/amazonaws/logging/Log;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Failed to prepend host prefix: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v0}, Ljava/net/URISyntaxException;->getMessage()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-interface {v1, v2, v0}, Lcom/amazonaws/logging/Log;->debug(Ljava/lang/Object;Ljava/lang/Throwable;)V

    .line 221
    .end local v0    # "error":Ljava/net/URISyntaxException;
    :cond_0
    :goto_0
    if-eqz p4, :cond_1

    .line 225
    invoke-virtual {p0, p1, p4}, Lcom/amazonaws/http/AmazonHttpClient;->requestHandler2s(Lcom/amazonaws/Request;Lcom/amazonaws/http/ExecutionContext;)Ljava/util/List;

    move-result-object v0

    .line 226
    .local v0, "requestHandler2s":Ljava/util/List;, "Ljava/util/List<Lcom/amazonaws/handlers/RequestHandler2;>;"
    invoke-virtual {p4}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 227
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    const/4 v2, 0x0

    .line 229
    .local v2, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<TT;>;"
    :try_start_1
    invoke-virtual {p0, p1, p2, p3, p4}, Lcom/amazonaws/http/AmazonHttpClient;->executeHelper(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;

    move-result-object v3

    move-object v2, v3

    .line 231
    invoke-virtual {v1}, Lcom/amazonaws/util/AWSRequestMetrics;->getTimingInfo()Lcom/amazonaws/util/TimingInfo;

    move-result-object v3

    invoke-virtual {v3}, Lcom/amazonaws/util/TimingInfo;->endTiming()Lcom/amazonaws/util/TimingInfo;

    move-result-object v3

    .line 232
    .local v3, "timingInfo":Lcom/amazonaws/util/TimingInfo;
    invoke-virtual {p0, p1, v0, v2, v3}, Lcom/amazonaws/http/AmazonHttpClient;->afterResponse(Lcom/amazonaws/Request;Ljava/util/List;Lcom/amazonaws/Response;Lcom/amazonaws/util/TimingInfo;)V
    :try_end_1
    .catch Lcom/amazonaws/AmazonClientException; {:try_start_1 .. :try_end_1} :catch_1

    .line 233
    return-object v2

    .line 234
    .end local v3    # "timingInfo":Lcom/amazonaws/util/TimingInfo;
    :catch_1
    move-exception v3

    .line 235
    .local v3, "e":Lcom/amazonaws/AmazonClientException;
    invoke-virtual {p0, p1, v2, v0, v3}, Lcom/amazonaws/http/AmazonHttpClient;->afterError(Lcom/amazonaws/Request;Lcom/amazonaws/Response;Ljava/util/List;Lcom/amazonaws/AmazonClientException;)V

    .line 236
    throw v3

    .line 222
    .end local v0    # "requestHandler2s":Ljava/util/List;, "Ljava/util/List<Lcom/amazonaws/handlers/RequestHandler2;>;"
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v2    # "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<TT;>;"
    .end local v3    # "e":Lcom/amazonaws/AmazonClientException;
    :cond_1
    new-instance v0, Lcom/amazonaws/AmazonClientException;

    const-string v1, "Internal SDK Error: No execution context parameter specified."

    invoke-direct {v0, v1}, Lcom/amazonaws/AmazonClientException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method executeHelper(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/Response;
    .locals 28
    .param p4, "executionContext"    # Lcom/amazonaws/http/ExecutionContext;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Ljava/lang/Object;",
            ">(",
            "Lcom/amazonaws/Request<",
            "*>;",
            "Lcom/amazonaws/http/HttpResponseHandler<",
            "Lcom/amazonaws/AmazonWebServiceResponse<",
            "TT;>;>;",
            "Lcom/amazonaws/http/HttpResponseHandler<",
            "Lcom/amazonaws/AmazonServiceException;",
            ">;",
            "Lcom/amazonaws/http/ExecutionContext;",
            ")",
            "Lcom/amazonaws/Response<",
            "TT;>;"
        }
    .end annotation

    .line 295
    .local p1, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<*>;"
    .local p2, "responseHandler":Lcom/amazonaws/http/HttpResponseHandler;, "Lcom/amazonaws/http/HttpResponseHandler<Lcom/amazonaws/AmazonWebServiceResponse<TT;>;>;"
    .local p3, "errorResponseHandler":Lcom/amazonaws/http/HttpResponseHandler;, "Lcom/amazonaws/http/HttpResponseHandler<Lcom/amazonaws/AmazonServiceException;>;"
    move-object/from16 v7, p0

    move-object/from16 v8, p1

    move-object/from16 v9, p4

    const/4 v0, 0x0

    .line 296
    .local v0, "leaveHttpConnectionOpen":Z
    invoke-virtual/range {p4 .. p4}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v10

    .line 301
    .local v10, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v1, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ServiceName:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-interface/range {p1 .. p1}, Lcom/amazonaws/Request;->getServiceName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v10, v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->addProperty(Lcom/amazonaws/metrics/MetricType;Ljava/lang/Object;)V

    .line 302
    sget-object v1, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ServiceEndpoint:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-interface/range {p1 .. p1}, Lcom/amazonaws/Request;->getEndpoint()Ljava/net/URI;

    move-result-object v2

    invoke-virtual {v10, v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->addProperty(Lcom/amazonaws/metrics/MetricType;Ljava/lang/Object;)V

    .line 306
    invoke-virtual/range {p0 .. p1}, Lcom/amazonaws/http/AmazonHttpClient;->setUserAgent(Lcom/amazonaws/Request;)V

    .line 307
    invoke-static {}, Ljava/util/UUID;->randomUUID()Ljava/util/UUID;

    move-result-object v1

    invoke-virtual {v1}, Ljava/util/UUID;->toString()Ljava/lang/String;

    move-result-object v1

    const-string v2, "aws-sdk-invocation-id"

    invoke-interface {v8, v2, v1}, Lcom/amazonaws/Request;->addHeader(Ljava/lang/String;Ljava/lang/String;)V

    .line 308
    const/4 v1, 0x0

    .line 309
    .local v1, "requestCount":I
    const-wide/16 v2, 0x0

    .line 310
    .local v2, "lastBackoffDelay":J
    const/4 v4, 0x0

    .line 311
    .local v4, "redirectedURI":Ljava/net/URI;
    const/4 v5, 0x0

    .line 315
    .local v5, "retriedException":Lcom/amazonaws/AmazonClientException;
    new-instance v6, Ljava/util/LinkedHashMap;

    .line 316
    invoke-interface/range {p1 .. p1}, Lcom/amazonaws/Request;->getParameters()Ljava/util/Map;

    move-result-object v11

    invoke-direct {v6, v11}, Ljava/util/LinkedHashMap;-><init>(Ljava/util/Map;)V

    move-object v11, v6

    .line 317
    .local v11, "originalParameters":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    new-instance v6, Ljava/util/HashMap;

    invoke-interface/range {p1 .. p1}, Lcom/amazonaws/Request;->getHeaders()Ljava/util/Map;

    move-result-object v12

    invoke-direct {v6, v12}, Ljava/util/HashMap;-><init>(Ljava/util/Map;)V

    move-object v12, v6

    .line 319
    .local v12, "originalHeaders":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    invoke-interface/range {p1 .. p1}, Lcom/amazonaws/Request;->getContent()Ljava/io/InputStream;

    move-result-object v13

    .line 320
    .local v13, "originalContent":Ljava/io/InputStream;
    if-eqz v13, :cond_0

    invoke-virtual {v13}, Ljava/io/InputStream;->markSupported()Z

    move-result v6

    if-eqz v6, :cond_0

    .line 321
    const/4 v6, -0x1

    invoke-virtual {v13, v6}, Ljava/io/InputStream;->mark(I)V

    .line 324
    :cond_0
    invoke-virtual/range {p4 .. p4}, Lcom/amazonaws/http/ExecutionContext;->getCredentials()Lcom/amazonaws/auth/AWSCredentials;

    move-result-object v14

    .line 325
    .local v14, "credentials":Lcom/amazonaws/auth/AWSCredentials;
    const/4 v6, 0x0

    .line 326
    .local v6, "signer":Lcom/amazonaws/auth/Signer;
    const/4 v15, 0x0

    .line 327
    .local v15, "httpResponse":Lcom/amazonaws/http/HttpResponse;
    const/16 v16, 0x0

    move/from16 v26, v1

    move v1, v0

    move/from16 v0, v26

    move-object/from16 v27, v15

    move-object v15, v4

    move-object/from16 v4, v27

    .line 330
    .local v0, "requestCount":I
    .local v1, "leaveHttpConnectionOpen":Z
    .local v4, "httpResponse":Lcom/amazonaws/http/HttpResponse;
    .local v15, "redirectedURI":Ljava/net/URI;
    .local v16, "httpRequest":Lcom/amazonaws/http/HttpRequest;
    :goto_0
    move/from16 v17, v1

    .end local v1    # "leaveHttpConnectionOpen":Z
    .local v17, "leaveHttpConnectionOpen":Z
    const/4 v1, 0x1

    move-object/from16 v18, v4

    .end local v4    # "httpResponse":Lcom/amazonaws/http/HttpResponse;
    .local v18, "httpResponse":Lcom/amazonaws/http/HttpResponse;
    add-int/lit8 v4, v0, 0x1

    .line 331
    .end local v0    # "requestCount":I
    .local v4, "requestCount":I
    sget-object v0, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestCount:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    move-wide/from16 v19, v2

    .end local v2    # "lastBackoffDelay":J
    .local v19, "lastBackoffDelay":J
    int-to-long v1, v4

    invoke-virtual {v10, v0, v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->setCounter(Lcom/amazonaws/metrics/MetricType;J)V

    .line 332
    const/4 v0, 0x1

    if-le v4, v0, :cond_1

    .line 333
    invoke-interface {v8, v11}, Lcom/amazonaws/Request;->setParameters(Ljava/util/Map;)V

    .line 334
    invoke-interface {v8, v12}, Lcom/amazonaws/Request;->setHeaders(Ljava/util/Map;)V

    .line 335
    invoke-interface {v8, v13}, Lcom/amazonaws/Request;->setContent(Ljava/io/InputStream;)V

    .line 337
    :cond_1
    if-eqz v15, :cond_2

    invoke-interface/range {p1 .. p1}, Lcom/amazonaws/Request;->getEndpoint()Ljava/net/URI;

    move-result-object v0

    if-nez v0, :cond_2

    .line 338
    invoke-interface/range {p1 .. p1}, Lcom/amazonaws/Request;->getResourcePath()Ljava/lang/String;

    move-result-object v0

    if-nez v0, :cond_2

    .line 339
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 340
    invoke-virtual {v15}, Ljava/net/URI;->getScheme()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "://"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v15}, Ljava/net/URI;->getAuthority()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 339
    invoke-static {v0}, Ljava/net/URI;->create(Ljava/lang/String;)Ljava/net/URI;

    move-result-object v0

    invoke-interface {v8, v0}, Lcom/amazonaws/Request;->setEndpoint(Ljava/net/URI;)V

    .line 341
    invoke-virtual {v15}, Ljava/net/URI;->getPath()Ljava/lang/String;

    move-result-object v0

    invoke-interface {v8, v0}, Lcom/amazonaws/Request;->setResourcePath(Ljava/lang/String;)V

    .line 345
    :cond_2
    const-string v1, "Cannot close the response content."

    const/4 v0, 0x1

    if-le v4, v0, :cond_4

    .line 346
    :try_start_0
    sget-object v0, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RetryPauseTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v10, v0}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_2
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/Error; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 348
    :try_start_1
    invoke-interface/range {p1 .. p1}, Lcom/amazonaws/Request;->getOriginalRequest()Lcom/amazonaws/AmazonWebServiceRequest;

    move-result-object v0

    iget-object v3, v7, Lcom/amazonaws/http/AmazonHttpClient;->config:Lcom/amazonaws/ClientConfiguration;

    .line 351
    invoke-virtual {v3}, Lcom/amazonaws/ClientConfiguration;->getRetryPolicy()Lcom/amazonaws/retry/RetryPolicy;

    move-result-object v3

    .line 348
    invoke-direct {v7, v0, v5, v4, v3}, Lcom/amazonaws/http/AmazonHttpClient;->pauseBeforeNextRetry(Lcom/amazonaws/AmazonWebServiceRequest;Lcom/amazonaws/AmazonClientException;ILcom/amazonaws/retry/RetryPolicy;)J

    move-result-wide v21
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    move-wide/from16 v19, v21

    .line 353
    :try_start_2
    sget-object v0, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RetryPauseTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v10, v0}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 354
    nop

    .line 355
    invoke-interface/range {p1 .. p1}, Lcom/amazonaws/Request;->getContent()Ljava/io/InputStream;

    move-result-object v0

    .line 356
    .local v0, "content":Ljava/io/InputStream;
    if-eqz v0, :cond_3

    invoke-virtual {v0}, Ljava/io/InputStream;->markSupported()Z

    move-result v3

    if-eqz v3, :cond_3

    .line 357
    invoke-virtual {v0}, Ljava/io/InputStream;->reset()V

    .line 360
    .end local v0    # "content":Ljava/io/InputStream;
    :cond_3
    move-wide/from16 v2, v19

    goto :goto_1

    .line 353
    :catchall_0
    move-exception v0

    sget-object v3, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RetryPauseTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v10, v3}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 354
    nop

    .end local v4    # "requestCount":I
    .end local v5    # "retriedException":Lcom/amazonaws/AmazonClientException;
    .end local v6    # "signer":Lcom/amazonaws/auth/Signer;
    .end local v10    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v11    # "originalParameters":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .end local v12    # "originalHeaders":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .end local v13    # "originalContent":Ljava/io/InputStream;
    .end local v14    # "credentials":Lcom/amazonaws/auth/AWSCredentials;
    .end local v15    # "redirectedURI":Ljava/net/URI;
    .end local v16    # "httpRequest":Lcom/amazonaws/http/HttpRequest;
    .end local v17    # "leaveHttpConnectionOpen":Z
    .end local v18    # "httpResponse":Lcom/amazonaws/http/HttpResponse;
    .end local v19    # "lastBackoffDelay":J
    .end local p1    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<*>;"
    .end local p2    # "responseHandler":Lcom/amazonaws/http/HttpResponseHandler;, "Lcom/amazonaws/http/HttpResponseHandler<Lcom/amazonaws/AmazonWebServiceResponse<TT;>;>;"
    .end local p3    # "errorResponseHandler":Lcom/amazonaws/http/HttpResponseHandler;, "Lcom/amazonaws/http/HttpResponseHandler<Lcom/amazonaws/AmazonServiceException;>;"
    .end local p4    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    throw v0
    :try_end_2
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_2
    .catch Ljava/lang/RuntimeException; {:try_start_2 .. :try_end_2} :catch_1
    .catch Ljava/lang/Error; {:try_start_2 .. :try_end_2} :catch_0
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 480
    .restart local v4    # "requestCount":I
    .restart local v5    # "retriedException":Lcom/amazonaws/AmazonClientException;
    .restart local v6    # "signer":Lcom/amazonaws/auth/Signer;
    .restart local v10    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v11    # "originalParameters":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .restart local v12    # "originalHeaders":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .restart local v13    # "originalContent":Ljava/io/InputStream;
    .restart local v14    # "credentials":Lcom/amazonaws/auth/AWSCredentials;
    .restart local v15    # "redirectedURI":Ljava/net/URI;
    .restart local v16    # "httpRequest":Lcom/amazonaws/http/HttpRequest;
    .restart local v17    # "leaveHttpConnectionOpen":Z
    .restart local v18    # "httpResponse":Lcom/amazonaws/http/HttpResponse;
    .restart local v19    # "lastBackoffDelay":J
    .restart local p1    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<*>;"
    .restart local p2    # "responseHandler":Lcom/amazonaws/http/HttpResponseHandler;, "Lcom/amazonaws/http/HttpResponseHandler<Lcom/amazonaws/AmazonWebServiceResponse<TT;>;>;"
    .restart local p3    # "errorResponseHandler":Lcom/amazonaws/http/HttpResponseHandler;, "Lcom/amazonaws/http/HttpResponseHandler<Lcom/amazonaws/AmazonServiceException;>;"
    .restart local p4    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    :catchall_1
    move-exception v0

    move-object v9, v1

    move/from16 v24, v4

    move/from16 v1, v17

    move-object/from16 v4, v18

    move-wide/from16 v2, v19

    move-object/from16 v20, v11

    move-object v11, v0

    goto/16 :goto_11

    .line 470
    :catch_0
    move-exception v0

    move-object v9, v1

    move/from16 v24, v4

    move/from16 v1, v17

    move-object/from16 v4, v18

    move-wide/from16 v2, v19

    move-object/from16 v20, v11

    goto/16 :goto_c

    .line 468
    :catch_1
    move-exception v0

    move-object v9, v1

    move/from16 v24, v4

    move/from16 v1, v17

    move-object/from16 v4, v18

    move-wide/from16 v2, v19

    move-object/from16 v20, v11

    goto/16 :goto_d

    .line 447
    :catch_2
    move-exception v0

    move-object v9, v1

    move/from16 v24, v4

    move-wide/from16 v21, v19

    move-object/from16 v20, v11

    move-object/from16 v19, v16

    move-object/from16 v16, v5

    move-object v11, v6

    goto/16 :goto_e

    .line 345
    :cond_4
    move-wide/from16 v2, v19

    .line 360
    .end local v19    # "lastBackoffDelay":J
    .restart local v2    # "lastBackoffDelay":J
    :goto_1
    :try_start_3
    const-string v0, "aws-sdk-retry"
    :try_end_3
    .catch Ljava/io/IOException; {:try_start_3 .. :try_end_3} :catch_3c
    .catch Ljava/lang/RuntimeException; {:try_start_3 .. :try_end_3} :catch_3b
    .catch Ljava/lang/Error; {:try_start_3 .. :try_end_3} :catch_3a
    .catchall {:try_start_3 .. :try_end_3} :catchall_15

    move-object/from16 v19, v5

    .end local v5    # "retriedException":Lcom/amazonaws/AmazonClientException;
    .local v19, "retriedException":Lcom/amazonaws/AmazonClientException;
    :try_start_4
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V
    :try_end_4
    .catch Ljava/io/IOException; {:try_start_4 .. :try_end_4} :catch_39
    .catch Ljava/lang/RuntimeException; {:try_start_4 .. :try_end_4} :catch_38
    .catch Ljava/lang/Error; {:try_start_4 .. :try_end_4} :catch_37
    .catchall {:try_start_4 .. :try_end_4} :catchall_14

    move-object/from16 v20, v11

    .end local v11    # "originalParameters":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .local v20, "originalParameters":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    add-int/lit8 v11, v4, -0x1

    :try_start_5
    invoke-virtual {v5, v11}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v11, "/"

    invoke-virtual {v5, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v2, v3}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-interface {v8, v0, v5}, Lcom/amazonaws/Request;->addHeader(Ljava/lang/String;Ljava/lang/String;)V
    :try_end_5
    .catch Ljava/io/IOException; {:try_start_5 .. :try_end_5} :catch_36
    .catch Ljava/lang/RuntimeException; {:try_start_5 .. :try_end_5} :catch_35
    .catch Ljava/lang/Error; {:try_start_5 .. :try_end_5} :catch_34
    .catchall {:try_start_5 .. :try_end_5} :catchall_13

    .line 364
    if-nez v6, :cond_5

    .line 365
    :try_start_6
    invoke-interface/range {p1 .. p1}, Lcom/amazonaws/Request;->getEndpoint()Ljava/net/URI;

    move-result-object v0

    invoke-virtual {v9, v0}, Lcom/amazonaws/http/ExecutionContext;->getSignerByURI(Ljava/net/URI;)Lcom/amazonaws/auth/Signer;

    move-result-object v0
    :try_end_6
    .catch Ljava/io/IOException; {:try_start_6 .. :try_end_6} :catch_5
    .catch Ljava/lang/RuntimeException; {:try_start_6 .. :try_end_6} :catch_4
    .catch Ljava/lang/Error; {:try_start_6 .. :try_end_6} :catch_3
    .catchall {:try_start_6 .. :try_end_6} :catchall_2

    move-object v6, v0

    move-object v11, v6

    goto :goto_2

    .line 480
    :catchall_2
    move-exception v0

    move-object v11, v0

    move-object v9, v1

    move/from16 v24, v4

    move/from16 v1, v17

    move-object/from16 v4, v18

    move-object/from16 v5, v19

    goto/16 :goto_11

    .line 470
    :catch_3
    move-exception v0

    move-object v9, v1

    move/from16 v24, v4

    move/from16 v1, v17

    move-object/from16 v4, v18

    move-object/from16 v5, v19

    goto/16 :goto_c

    .line 468
    :catch_4
    move-exception v0

    move-object v9, v1

    move/from16 v24, v4

    move/from16 v1, v17

    move-object/from16 v4, v18

    move-object/from16 v5, v19

    goto/16 :goto_d

    .line 447
    :catch_5
    move-exception v0

    move-object v9, v1

    move-wide/from16 v21, v2

    move/from16 v24, v4

    move-object v11, v6

    move-object/from16 v26, v19

    move-object/from16 v19, v16

    move-object/from16 v16, v26

    goto/16 :goto_e

    .line 364
    :cond_5
    move-object v11, v6

    .line 367
    .end local v6    # "signer":Lcom/amazonaws/auth/Signer;
    .local v11, "signer":Lcom/amazonaws/auth/Signer;
    :goto_2
    if-eqz v11, :cond_6

    if-eqz v14, :cond_6

    .line 368
    :try_start_7
    sget-object v0, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestSigningTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v10, v0}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_7
    .catch Ljava/io/IOException; {:try_start_7 .. :try_end_7} :catch_8
    .catch Ljava/lang/RuntimeException; {:try_start_7 .. :try_end_7} :catch_7
    .catch Ljava/lang/Error; {:try_start_7 .. :try_end_7} :catch_6
    .catchall {:try_start_7 .. :try_end_7} :catchall_4

    .line 370
    :try_start_8
    invoke-interface {v11, v8, v14}, Lcom/amazonaws/auth/Signer;->sign(Lcom/amazonaws/Request;Lcom/amazonaws/auth/AWSCredentials;)V
    :try_end_8
    .catchall {:try_start_8 .. :try_end_8} :catchall_3

    .line 372
    :try_start_9
    sget-object v0, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestSigningTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v10, v0}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 373
    goto :goto_3

    .line 372
    :catchall_3
    move-exception v0

    move-object v5, v0

    sget-object v0, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RequestSigningTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v10, v0}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 373
    nop

    .end local v2    # "lastBackoffDelay":J
    .end local v4    # "requestCount":I
    .end local v10    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v11    # "signer":Lcom/amazonaws/auth/Signer;
    .end local v12    # "originalHeaders":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .end local v13    # "originalContent":Ljava/io/InputStream;
    .end local v14    # "credentials":Lcom/amazonaws/auth/AWSCredentials;
    .end local v15    # "redirectedURI":Ljava/net/URI;
    .end local v16    # "httpRequest":Lcom/amazonaws/http/HttpRequest;
    .end local v17    # "leaveHttpConnectionOpen":Z
    .end local v18    # "httpResponse":Lcom/amazonaws/http/HttpResponse;
    .end local v19    # "retriedException":Lcom/amazonaws/AmazonClientException;
    .end local v20    # "originalParameters":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .end local p1    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<*>;"
    .end local p2    # "responseHandler":Lcom/amazonaws/http/HttpResponseHandler;, "Lcom/amazonaws/http/HttpResponseHandler<Lcom/amazonaws/AmazonWebServiceResponse<TT;>;>;"
    .end local p3    # "errorResponseHandler":Lcom/amazonaws/http/HttpResponseHandler;, "Lcom/amazonaws/http/HttpResponseHandler<Lcom/amazonaws/AmazonServiceException;>;"
    .end local p4    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    throw v5
    :try_end_9
    .catch Ljava/io/IOException; {:try_start_9 .. :try_end_9} :catch_8
    .catch Ljava/lang/RuntimeException; {:try_start_9 .. :try_end_9} :catch_7
    .catch Ljava/lang/Error; {:try_start_9 .. :try_end_9} :catch_6
    .catchall {:try_start_9 .. :try_end_9} :catchall_4

    .line 480
    .restart local v2    # "lastBackoffDelay":J
    .restart local v4    # "requestCount":I
    .restart local v10    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v11    # "signer":Lcom/amazonaws/auth/Signer;
    .restart local v12    # "originalHeaders":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .restart local v13    # "originalContent":Ljava/io/InputStream;
    .restart local v14    # "credentials":Lcom/amazonaws/auth/AWSCredentials;
    .restart local v15    # "redirectedURI":Ljava/net/URI;
    .restart local v16    # "httpRequest":Lcom/amazonaws/http/HttpRequest;
    .restart local v17    # "leaveHttpConnectionOpen":Z
    .restart local v18    # "httpResponse":Lcom/amazonaws/http/HttpResponse;
    .restart local v19    # "retriedException":Lcom/amazonaws/AmazonClientException;
    .restart local v20    # "originalParameters":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .restart local p1    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<*>;"
    .restart local p2    # "responseHandler":Lcom/amazonaws/http/HttpResponseHandler;, "Lcom/amazonaws/http/HttpResponseHandler<Lcom/amazonaws/AmazonWebServiceResponse<TT;>;>;"
    .restart local p3    # "errorResponseHandler":Lcom/amazonaws/http/HttpResponseHandler;, "Lcom/amazonaws/http/HttpResponseHandler<Lcom/amazonaws/AmazonServiceException;>;"
    .restart local p4    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    :catchall_4
    move-exception v0

    move-object v9, v1

    move/from16 v24, v4

    move-object v6, v11

    move/from16 v1, v17

    move-object/from16 v4, v18

    move-object/from16 v5, v19

    move-object v11, v0

    goto/16 :goto_11

    .line 470
    :catch_6
    move-exception v0

    move-object v9, v1

    move/from16 v24, v4

    move-object v6, v11

    move/from16 v1, v17

    move-object/from16 v4, v18

    move-object/from16 v5, v19

    goto/16 :goto_c

    .line 468
    :catch_7
    move-exception v0

    move-object v9, v1

    move/from16 v24, v4

    move-object v6, v11

    move/from16 v1, v17

    move-object/from16 v4, v18

    move-object/from16 v5, v19

    goto/16 :goto_d

    .line 447
    :catch_8
    move-exception v0

    move-object v9, v1

    move-wide/from16 v21, v2

    move/from16 v24, v4

    move-object/from16 v26, v19

    move-object/from16 v19, v16

    move-object/from16 v16, v26

    goto/16 :goto_e

    .line 376
    :cond_6
    :goto_3
    :try_start_a
    sget-object v0, Lcom/amazonaws/http/AmazonHttpClient;->REQUEST_LOG:Lcom/amazonaws/logging/Log;

    invoke-interface {v0}, Lcom/amazonaws/logging/Log;->isDebugEnabled()Z

    move-result v0
    :try_end_a
    .catch Ljava/io/IOException; {:try_start_a .. :try_end_a} :catch_33
    .catch Ljava/lang/RuntimeException; {:try_start_a .. :try_end_a} :catch_32
    .catch Ljava/lang/Error; {:try_start_a .. :try_end_a} :catch_31
    .catchall {:try_start_a .. :try_end_a} :catchall_12

    if-eqz v0, :cond_7

    .line 377
    :try_start_b
    sget-object v0, Lcom/amazonaws/http/AmazonHttpClient;->REQUEST_LOG:Lcom/amazonaws/logging/Log;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "Sending Request: "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual/range {p1 .. p1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-interface {v0, v5}, Lcom/amazonaws/logging/Log;->debug(Ljava/lang/Object;)V
    :try_end_b
    .catch Ljava/io/IOException; {:try_start_b .. :try_end_b} :catch_8
    .catch Ljava/lang/RuntimeException; {:try_start_b .. :try_end_b} :catch_7
    .catch Ljava/lang/Error; {:try_start_b .. :try_end_b} :catch_6
    .catchall {:try_start_b .. :try_end_b} :catchall_4

    .line 380
    :cond_7
    :try_start_c
    iget-object v0, v7, Lcom/amazonaws/http/AmazonHttpClient;->requestFactory:Lcom/amazonaws/http/HttpRequestFactory;

    iget-object v5, v7, Lcom/amazonaws/http/AmazonHttpClient;->config:Lcom/amazonaws/ClientConfiguration;

    invoke-virtual {v0, v8, v5, v9}, Lcom/amazonaws/http/HttpRequestFactory;->createHttpRequest(Lcom/amazonaws/Request;Lcom/amazonaws/ClientConfiguration;Lcom/amazonaws/http/ExecutionContext;)Lcom/amazonaws/http/HttpRequest;

    move-result-object v0
    :try_end_c
    .catch Ljava/io/IOException; {:try_start_c .. :try_end_c} :catch_33
    .catch Ljava/lang/RuntimeException; {:try_start_c .. :try_end_c} :catch_32
    .catch Ljava/lang/Error; {:try_start_c .. :try_end_c} :catch_31
    .catchall {:try_start_c .. :try_end_c} :catchall_12

    move-object v6, v0

    .line 383
    .end local v16    # "httpRequest":Lcom/amazonaws/http/HttpRequest;
    .local v6, "httpRequest":Lcom/amazonaws/http/HttpRequest;
    const/16 v16, 0x0

    .line 384
    .end local v19    # "retriedException":Lcom/amazonaws/AmazonClientException;
    .local v16, "retriedException":Lcom/amazonaws/AmazonClientException;
    :try_start_d
    sget-object v0, Lcom/amazonaws/util/AWSRequestMetrics$Field;->HttpRequestTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v10, v0}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_d
    .catch Ljava/io/IOException; {:try_start_d .. :try_end_d} :catch_30
    .catch Ljava/lang/RuntimeException; {:try_start_d .. :try_end_d} :catch_2f
    .catch Ljava/lang/Error; {:try_start_d .. :try_end_d} :catch_2e
    .catchall {:try_start_d .. :try_end_d} :catchall_11

    .line 386
    :try_start_e
    iget-object v0, v7, Lcom/amazonaws/http/AmazonHttpClient;->httpClient:Lcom/amazonaws/http/HttpClient;

    invoke-interface {v0, v6}, Lcom/amazonaws/http/HttpClient;->execute(Lcom/amazonaws/http/HttpRequest;)Lcom/amazonaws/http/HttpResponse;

    move-result-object v0
    :try_end_e
    .catchall {:try_start_e .. :try_end_e} :catchall_f

    move-object v5, v0

    .line 388
    .end local v18    # "httpResponse":Lcom/amazonaws/http/HttpResponse;
    .local v5, "httpResponse":Lcom/amazonaws/http/HttpResponse;
    :try_start_f
    sget-object v0, Lcom/amazonaws/util/AWSRequestMetrics$Field;->HttpRequestTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v10, v0}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 389
    nop

    .line 391
    invoke-direct {v7, v5}, Lcom/amazonaws/http/AmazonHttpClient;->isRequestSuccessful(Lcom/amazonaws/http/HttpResponse;)Z

    move-result v0
    :try_end_f
    .catch Ljava/io/IOException; {:try_start_f .. :try_end_f} :catch_2a
    .catch Ljava/lang/RuntimeException; {:try_start_f .. :try_end_f} :catch_29
    .catch Ljava/lang/Error; {:try_start_f .. :try_end_f} :catch_28
    .catchall {:try_start_f .. :try_end_f} :catchall_e

    if-eqz v0, :cond_a

    .line 392
    :try_start_10
    sget-object v0, Lcom/amazonaws/util/AWSRequestMetrics$Field;->StatusCode:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v5}, Lcom/amazonaws/http/HttpResponse;->getStatusCode()I

    move-result v18
    :try_end_10
    .catch Ljava/io/IOException; {:try_start_10 .. :try_end_10} :catch_15
    .catch Ljava/lang/RuntimeException; {:try_start_10 .. :try_end_10} :catch_14
    .catch Ljava/lang/Error; {:try_start_10 .. :try_end_10} :catch_13
    .catchall {:try_start_10 .. :try_end_10} :catchall_8

    move-wide/from16 v22, v2

    .end local v2    # "lastBackoffDelay":J
    .local v22, "lastBackoffDelay":J
    :try_start_11
    invoke-static/range {v18 .. v18}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v10, v0, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->addProperty(Lcom/amazonaws/metrics/MetricType;Ljava/lang/Object;)V

    .line 397
    invoke-interface/range {p2 .. p2}, Lcom/amazonaws/http/HttpResponseHandler;->needsConnectionLeftOpen()Z

    move-result v0
    :try_end_11
    .catch Ljava/io/IOException; {:try_start_11 .. :try_end_11} :catch_12
    .catch Ljava/lang/RuntimeException; {:try_start_11 .. :try_end_11} :catch_11
    .catch Ljava/lang/Error; {:try_start_11 .. :try_end_11} :catch_10
    .catchall {:try_start_11 .. :try_end_11} :catchall_7

    move v2, v0

    .line 398
    .end local v17    # "leaveHttpConnectionOpen":Z
    .local v2, "leaveHttpConnectionOpen":Z
    move-object/from16 v3, p2

    :try_start_12
    invoke-virtual {v7, v8, v3, v5, v9}, Lcom/amazonaws/http/AmazonHttpClient;->handleResponse(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/HttpResponse;Lcom/amazonaws/http/ExecutionContext;)Ljava/lang/Object;

    move-result-object v0

    move-object/from16 v17, v0

    .line 401
    .local v17, "response":Ljava/lang/Object;, "TT;"
    new-instance v3, Lcom/amazonaws/Response;
    :try_end_12
    .catch Ljava/io/IOException; {:try_start_12 .. :try_end_12} :catch_f
    .catch Ljava/lang/RuntimeException; {:try_start_12 .. :try_end_12} :catch_e
    .catch Ljava/lang/Error; {:try_start_12 .. :try_end_12} :catch_d
    .catchall {:try_start_12 .. :try_end_12} :catchall_6

    move/from16 v24, v4

    move-object/from16 v4, v17

    .end local v17    # "response":Ljava/lang/Object;, "TT;"
    .local v4, "response":Ljava/lang/Object;, "TT;"
    .local v24, "requestCount":I
    :try_start_13
    invoke-direct {v3, v4, v5}, Lcom/amazonaws/Response;-><init>(Ljava/lang/Object;Lcom/amazonaws/http/HttpResponse;)V
    :try_end_13
    .catch Ljava/io/IOException; {:try_start_13 .. :try_end_13} :catch_c
    .catch Ljava/lang/RuntimeException; {:try_start_13 .. :try_end_13} :catch_b
    .catch Ljava/lang/Error; {:try_start_13 .. :try_end_13} :catch_a
    .catchall {:try_start_13 .. :try_end_13} :catchall_5

    .line 480
    if-nez v2, :cond_9

    if-eqz v5, :cond_9

    .line 482
    :try_start_14
    invoke-virtual {v5}, Lcom/amazonaws/http/HttpResponse;->getRawContent()Ljava/io/InputStream;

    move-result-object v0

    if-eqz v0, :cond_8

    .line 483
    invoke-virtual {v5}, Lcom/amazonaws/http/HttpResponse;->getRawContent()Ljava/io/InputStream;

    move-result-object v0

    invoke-virtual {v0}, Ljava/io/InputStream;->close()V
    :try_end_14
    .catch Ljava/io/IOException; {:try_start_14 .. :try_end_14} :catch_9

    .line 487
    :cond_8
    move/from16 v17, v2

    goto :goto_4

    .line 485
    :catch_9
    move-exception v0

    .line 486
    .local v0, "e":Ljava/io/IOException;
    move/from16 v17, v2

    .end local v2    # "leaveHttpConnectionOpen":Z
    .local v17, "leaveHttpConnectionOpen":Z
    sget-object v2, Lcom/amazonaws/http/AmazonHttpClient;->log:Lcom/amazonaws/logging/Log;

    invoke-interface {v2, v1, v0}, Lcom/amazonaws/logging/Log;->warn(Ljava/lang/Object;Ljava/lang/Throwable;)V

    goto :goto_4

    .line 480
    .end local v0    # "e":Ljava/io/IOException;
    .end local v17    # "leaveHttpConnectionOpen":Z
    .restart local v2    # "leaveHttpConnectionOpen":Z
    :cond_9
    move/from16 v17, v2

    .line 401
    .end local v2    # "leaveHttpConnectionOpen":Z
    .restart local v17    # "leaveHttpConnectionOpen":Z
    :goto_4
    return-object v3

    .line 480
    .end local v4    # "response":Ljava/lang/Object;, "TT;"
    .end local v17    # "leaveHttpConnectionOpen":Z
    .restart local v2    # "leaveHttpConnectionOpen":Z
    :catchall_5
    move-exception v0

    move/from16 v17, v2

    move-object v9, v1

    move-object v4, v5

    move-object/from16 v5, v16

    move/from16 v1, v17

    move-wide/from16 v2, v22

    move-object/from16 v16, v6

    move-object v6, v11

    move-object v11, v0

    .end local v2    # "leaveHttpConnectionOpen":Z
    .restart local v17    # "leaveHttpConnectionOpen":Z
    goto/16 :goto_11

    .line 470
    .end local v17    # "leaveHttpConnectionOpen":Z
    .restart local v2    # "leaveHttpConnectionOpen":Z
    :catch_a
    move-exception v0

    move/from16 v17, v2

    move-object v9, v1

    move-object v4, v5

    move-object/from16 v5, v16

    move/from16 v1, v17

    move-wide/from16 v2, v22

    move-object/from16 v16, v6

    move-object v6, v11

    .end local v2    # "leaveHttpConnectionOpen":Z
    .restart local v17    # "leaveHttpConnectionOpen":Z
    goto/16 :goto_c

    .line 468
    .end local v17    # "leaveHttpConnectionOpen":Z
    .restart local v2    # "leaveHttpConnectionOpen":Z
    :catch_b
    move-exception v0

    move/from16 v17, v2

    move-object v9, v1

    move-object v4, v5

    move-object/from16 v5, v16

    move/from16 v1, v17

    move-wide/from16 v2, v22

    move-object/from16 v16, v6

    move-object v6, v11

    .end local v2    # "leaveHttpConnectionOpen":Z
    .restart local v17    # "leaveHttpConnectionOpen":Z
    goto/16 :goto_d

    .line 447
    .end local v17    # "leaveHttpConnectionOpen":Z
    .restart local v2    # "leaveHttpConnectionOpen":Z
    :catch_c
    move-exception v0

    move/from16 v17, v2

    move-object v9, v1

    move-object/from16 v18, v5

    move-object/from16 v19, v6

    move-wide/from16 v21, v22

    .end local v2    # "leaveHttpConnectionOpen":Z
    .restart local v17    # "leaveHttpConnectionOpen":Z
    goto/16 :goto_e

    .line 480
    .end local v17    # "leaveHttpConnectionOpen":Z
    .end local v24    # "requestCount":I
    .restart local v2    # "leaveHttpConnectionOpen":Z
    .local v4, "requestCount":I
    :catchall_6
    move-exception v0

    move/from16 v17, v2

    move/from16 v24, v4

    move-object v9, v1

    move-object v4, v5

    move-object/from16 v5, v16

    move/from16 v1, v17

    move-wide/from16 v2, v22

    move-object/from16 v16, v6

    move-object v6, v11

    move-object v11, v0

    .end local v2    # "leaveHttpConnectionOpen":Z
    .end local v4    # "requestCount":I
    .restart local v17    # "leaveHttpConnectionOpen":Z
    .restart local v24    # "requestCount":I
    goto/16 :goto_11

    .line 470
    .end local v17    # "leaveHttpConnectionOpen":Z
    .end local v24    # "requestCount":I
    .restart local v2    # "leaveHttpConnectionOpen":Z
    .restart local v4    # "requestCount":I
    :catch_d
    move-exception v0

    move/from16 v17, v2

    move/from16 v24, v4

    move-object v9, v1

    move-object v4, v5

    move-object/from16 v5, v16

    move/from16 v1, v17

    move-wide/from16 v2, v22

    move-object/from16 v16, v6

    move-object v6, v11

    .end local v2    # "leaveHttpConnectionOpen":Z
    .end local v4    # "requestCount":I
    .restart local v17    # "leaveHttpConnectionOpen":Z
    .restart local v24    # "requestCount":I
    goto/16 :goto_c

    .line 468
    .end local v17    # "leaveHttpConnectionOpen":Z
    .end local v24    # "requestCount":I
    .restart local v2    # "leaveHttpConnectionOpen":Z
    .restart local v4    # "requestCount":I
    :catch_e
    move-exception v0

    move/from16 v17, v2

    move/from16 v24, v4

    move-object v9, v1

    move-object v4, v5

    move-object/from16 v5, v16

    move/from16 v1, v17

    move-wide/from16 v2, v22

    move-object/from16 v16, v6

    move-object v6, v11

    .end local v2    # "leaveHttpConnectionOpen":Z
    .end local v4    # "requestCount":I
    .restart local v17    # "leaveHttpConnectionOpen":Z
    .restart local v24    # "requestCount":I
    goto/16 :goto_d

    .line 447
    .end local v17    # "leaveHttpConnectionOpen":Z
    .end local v24    # "requestCount":I
    .restart local v2    # "leaveHttpConnectionOpen":Z
    .restart local v4    # "requestCount":I
    :catch_f
    move-exception v0

    move/from16 v17, v2

    move/from16 v24, v4

    move-object v9, v1

    move-object/from16 v18, v5

    move-object/from16 v19, v6

    move-wide/from16 v21, v22

    .end local v2    # "leaveHttpConnectionOpen":Z
    .end local v4    # "requestCount":I
    .restart local v17    # "leaveHttpConnectionOpen":Z
    .restart local v24    # "requestCount":I
    goto/16 :goto_e

    .line 480
    .end local v24    # "requestCount":I
    .restart local v4    # "requestCount":I
    :catchall_7
    move-exception v0

    move/from16 v24, v4

    move-object v9, v1

    move-object v4, v5

    move-object/from16 v5, v16

    move/from16 v1, v17

    move-wide/from16 v2, v22

    move-object/from16 v16, v6

    move-object v6, v11

    move-object v11, v0

    .end local v4    # "requestCount":I
    .restart local v24    # "requestCount":I
    goto/16 :goto_11

    .line 470
    .end local v24    # "requestCount":I
    .restart local v4    # "requestCount":I
    :catch_10
    move-exception v0

    move/from16 v24, v4

    move-object v9, v1

    move-object v4, v5

    move-object/from16 v5, v16

    move/from16 v1, v17

    move-wide/from16 v2, v22

    move-object/from16 v16, v6

    move-object v6, v11

    .end local v4    # "requestCount":I
    .restart local v24    # "requestCount":I
    goto/16 :goto_c

    .line 468
    .end local v24    # "requestCount":I
    .restart local v4    # "requestCount":I
    :catch_11
    move-exception v0

    move/from16 v24, v4

    move-object v9, v1

    move-object v4, v5

    move-object/from16 v5, v16

    move/from16 v1, v17

    move-wide/from16 v2, v22

    move-object/from16 v16, v6

    move-object v6, v11

    .end local v4    # "requestCount":I
    .restart local v24    # "requestCount":I
    goto/16 :goto_d

    .line 447
    .end local v24    # "requestCount":I
    .restart local v4    # "requestCount":I
    :catch_12
    move-exception v0

    move/from16 v24, v4

    move-object v9, v1

    move-object/from16 v18, v5

    move-object/from16 v19, v6

    move-wide/from16 v21, v22

    .end local v4    # "requestCount":I
    .restart local v24    # "requestCount":I
    goto/16 :goto_e

    .line 480
    .end local v22    # "lastBackoffDelay":J
    .end local v24    # "requestCount":I
    .local v2, "lastBackoffDelay":J
    .restart local v4    # "requestCount":I
    :catchall_8
    move-exception v0

    move-wide/from16 v22, v2

    move/from16 v24, v4

    move-object v9, v1

    move-object v4, v5

    move-object/from16 v5, v16

    move/from16 v1, v17

    move-object/from16 v16, v6

    move-object v6, v11

    move-object v11, v0

    .end local v2    # "lastBackoffDelay":J
    .end local v4    # "requestCount":I
    .restart local v22    # "lastBackoffDelay":J
    .restart local v24    # "requestCount":I
    goto/16 :goto_11

    .line 470
    .end local v22    # "lastBackoffDelay":J
    .end local v24    # "requestCount":I
    .restart local v2    # "lastBackoffDelay":J
    .restart local v4    # "requestCount":I
    :catch_13
    move-exception v0

    move-wide/from16 v22, v2

    move/from16 v24, v4

    move-object v9, v1

    move-object v4, v5

    move-object/from16 v5, v16

    move/from16 v1, v17

    move-object/from16 v16, v6

    move-object v6, v11

    .end local v2    # "lastBackoffDelay":J
    .end local v4    # "requestCount":I
    .restart local v22    # "lastBackoffDelay":J
    .restart local v24    # "requestCount":I
    goto/16 :goto_c

    .line 468
    .end local v22    # "lastBackoffDelay":J
    .end local v24    # "requestCount":I
    .restart local v2    # "lastBackoffDelay":J
    .restart local v4    # "requestCount":I
    :catch_14
    move-exception v0

    move-wide/from16 v22, v2

    move/from16 v24, v4

    move-object v9, v1

    move-object v4, v5

    move-object/from16 v5, v16

    move/from16 v1, v17

    move-object/from16 v16, v6

    move-object v6, v11

    .end local v2    # "lastBackoffDelay":J
    .end local v4    # "requestCount":I
    .restart local v22    # "lastBackoffDelay":J
    .restart local v24    # "requestCount":I
    goto/16 :goto_d

    .line 447
    .end local v22    # "lastBackoffDelay":J
    .end local v24    # "requestCount":I
    .restart local v2    # "lastBackoffDelay":J
    .restart local v4    # "requestCount":I
    :catch_15
    move-exception v0

    move-wide/from16 v22, v2

    move/from16 v24, v4

    move-object v9, v1

    move-object/from16 v18, v5

    move-object/from16 v19, v6

    move-wide/from16 v21, v22

    .end local v2    # "lastBackoffDelay":J
    .end local v4    # "requestCount":I
    .restart local v22    # "lastBackoffDelay":J
    .restart local v24    # "requestCount":I
    goto/16 :goto_e

    .line 402
    .end local v22    # "lastBackoffDelay":J
    .end local v24    # "requestCount":I
    .restart local v2    # "lastBackoffDelay":J
    .restart local v4    # "requestCount":I
    :cond_a
    move-wide/from16 v22, v2

    move/from16 v24, v4

    .end local v2    # "lastBackoffDelay":J
    .end local v4    # "requestCount":I
    .restart local v22    # "lastBackoffDelay":J
    .restart local v24    # "requestCount":I
    :try_start_15
    invoke-static {v5}, Lcom/amazonaws/http/AmazonHttpClient;->isTemporaryRedirect(Lcom/amazonaws/http/HttpResponse;)Z

    move-result v0
    :try_end_15
    .catch Ljava/io/IOException; {:try_start_15 .. :try_end_15} :catch_27
    .catch Ljava/lang/RuntimeException; {:try_start_15 .. :try_end_15} :catch_26
    .catch Ljava/lang/Error; {:try_start_15 .. :try_end_15} :catch_25
    .catchall {:try_start_15 .. :try_end_15} :catchall_d

    if-eqz v0, :cond_b

    .line 409
    :try_start_16
    invoke-virtual {v5}, Lcom/amazonaws/http/HttpResponse;->getHeaders()Ljava/util/Map;

    move-result-object v0

    const-string v2, "Location"

    invoke-interface {v0, v2}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    .line 410
    .local v0, "redirectedLocation":Ljava/lang/String;
    sget-object v2, Lcom/amazonaws/http/AmazonHttpClient;->log:Lcom/amazonaws/logging/Log;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "Redirecting to: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-interface {v2, v3}, Lcom/amazonaws/logging/Log;->debug(Ljava/lang/Object;)V

    .line 412
    invoke-static {v0}, Ljava/net/URI;->create(Ljava/lang/String;)Ljava/net/URI;

    move-result-object v2
    :try_end_16
    .catch Ljava/io/IOException; {:try_start_16 .. :try_end_16} :catch_1a
    .catch Ljava/lang/RuntimeException; {:try_start_16 .. :try_end_16} :catch_19
    .catch Ljava/lang/Error; {:try_start_16 .. :try_end_16} :catch_18
    .catchall {:try_start_16 .. :try_end_16} :catchall_9

    move-object v15, v2

    .line 413
    const/4 v2, 0x0

    :try_start_17
    invoke-interface {v8, v2}, Lcom/amazonaws/Request;->setEndpoint(Ljava/net/URI;)V

    .line 414
    invoke-interface {v8, v2}, Lcom/amazonaws/Request;->setResourcePath(Ljava/lang/String;)V
    :try_end_17
    .catch Ljava/io/IOException; {:try_start_17 .. :try_end_17} :catch_17
    .catch Ljava/lang/RuntimeException; {:try_start_17 .. :try_end_17} :catch_19
    .catch Ljava/lang/Error; {:try_start_17 .. :try_end_17} :catch_18
    .catchall {:try_start_17 .. :try_end_17} :catchall_9

    .line 415
    :try_start_18
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->StatusCode:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v5}, Lcom/amazonaws/http/HttpResponse;->getStatusCode()I

    move-result v3

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-virtual {v10, v2, v3}, Lcom/amazonaws/util/AWSRequestMetrics;->addProperty(Lcom/amazonaws/metrics/MetricType;Ljava/lang/Object;)V

    .line 416
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->RedirectLocation:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v10, v2, v0}, Lcom/amazonaws/util/AWSRequestMetrics;->addProperty(Lcom/amazonaws/metrics/MetricType;Ljava/lang/Object;)V

    .line 417
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->AWSRequestID:Lcom/amazonaws/util/AWSRequestMetrics$Field;
    :try_end_18
    .catch Ljava/io/IOException; {:try_start_18 .. :try_end_18} :catch_1a
    .catch Ljava/lang/RuntimeException; {:try_start_18 .. :try_end_18} :catch_19
    .catch Ljava/lang/Error; {:try_start_18 .. :try_end_18} :catch_18
    .catchall {:try_start_18 .. :try_end_18} :catchall_9

    const/4 v3, 0x0

    :try_start_19
    invoke-virtual {v10, v2, v3}, Lcom/amazonaws/util/AWSRequestMetrics;->addProperty(Lcom/amazonaws/metrics/MetricType;Ljava/lang/Object;)V
    :try_end_19
    .catch Ljava/io/IOException; {:try_start_19 .. :try_end_19} :catch_16
    .catch Ljava/lang/RuntimeException; {:try_start_19 .. :try_end_19} :catch_19
    .catch Ljava/lang/Error; {:try_start_19 .. :try_end_19} :catch_18
    .catchall {:try_start_19 .. :try_end_19} :catchall_9

    .line 418
    .end local v0    # "redirectedLocation":Ljava/lang/String;
    move-object v9, v1

    move-object/from16 v19, v6

    move/from16 v1, v17

    move-wide/from16 v21, v22

    move-object/from16 v23, v11

    move-object v11, v5

    goto/16 :goto_6

    .line 447
    :catch_16
    move-exception v0

    goto :goto_5

    :catch_17
    move-exception v0

    move-object v3, v2

    goto :goto_5

    .line 480
    :catchall_9
    move-exception v0

    move-object v9, v1

    move-object v4, v5

    move-object/from16 v5, v16

    move/from16 v1, v17

    move-wide/from16 v2, v22

    move-object/from16 v16, v6

    move-object v6, v11

    move-object v11, v0

    goto/16 :goto_11

    .line 470
    :catch_18
    move-exception v0

    move-object v9, v1

    move-object v4, v5

    move-object/from16 v5, v16

    move/from16 v1, v17

    move-wide/from16 v2, v22

    move-object/from16 v16, v6

    move-object v6, v11

    goto/16 :goto_c

    .line 468
    :catch_19
    move-exception v0

    move-object v9, v1

    move-object v4, v5

    move-object/from16 v5, v16

    move/from16 v1, v17

    move-wide/from16 v2, v22

    move-object/from16 v16, v6

    move-object v6, v11

    goto/16 :goto_d

    .line 447
    :catch_1a
    move-exception v0

    const/4 v3, 0x0

    :goto_5
    move-object v9, v1

    move-object/from16 v18, v5

    move-object/from16 v19, v6

    move-wide/from16 v21, v22

    goto/16 :goto_e

    .line 419
    :cond_b
    const/4 v3, 0x0

    :try_start_1a
    invoke-interface/range {p3 .. p3}, Lcom/amazonaws/http/HttpResponseHandler;->needsConnectionLeftOpen()Z

    move-result v0

    move/from16 v17, v0

    .line 420
    move-object/from16 v4, p3

    invoke-virtual {v7, v8, v4, v5}, Lcom/amazonaws/http/AmazonHttpClient;->handleErrorResponse(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/HttpResponse;)Lcom/amazonaws/AmazonServiceException;

    move-result-object v0

    .line 422
    .local v0, "ase":Lcom/amazonaws/AmazonServiceException;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->AWSRequestID:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v0}, Lcom/amazonaws/AmazonServiceException;->getRequestId()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v10, v2, v3}, Lcom/amazonaws/util/AWSRequestMetrics;->addProperty(Lcom/amazonaws/metrics/MetricType;Ljava/lang/Object;)V

    .line 423
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->AWSErrorCode:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v0}, Lcom/amazonaws/AmazonServiceException;->getErrorCode()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v10, v2, v3}, Lcom/amazonaws/util/AWSRequestMetrics;->addProperty(Lcom/amazonaws/metrics/MetricType;Ljava/lang/Object;)V

    .line 424
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->StatusCode:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v0}, Lcom/amazonaws/AmazonServiceException;->getStatusCode()I

    move-result v3

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-virtual {v10, v2, v3}, Lcom/amazonaws/util/AWSRequestMetrics;->addProperty(Lcom/amazonaws/metrics/MetricType;Ljava/lang/Object;)V

    .line 426
    invoke-interface/range {p1 .. p1}, Lcom/amazonaws/Request;->getOriginalRequest()Lcom/amazonaws/AmazonWebServiceRequest;

    move-result-object v2

    .line 427
    invoke-virtual {v6}, Lcom/amazonaws/http/HttpRequest;->getContent()Ljava/io/InputStream;

    move-result-object v3
    :try_end_1a
    .catch Ljava/io/IOException; {:try_start_1a .. :try_end_1a} :catch_27
    .catch Ljava/lang/RuntimeException; {:try_start_1a .. :try_end_1a} :catch_26
    .catch Ljava/lang/Error; {:try_start_1a .. :try_end_1a} :catch_25
    .catchall {:try_start_1a .. :try_end_1a} :catchall_d

    move-object/from16 v25, v1

    :try_start_1b
    iget-object v1, v7, Lcom/amazonaws/http/AmazonHttpClient;->config:Lcom/amazonaws/ClientConfiguration;

    .line 430
    invoke-virtual {v1}, Lcom/amazonaws/ClientConfiguration;->getRetryPolicy()Lcom/amazonaws/retry/RetryPolicy;

    move-result-object v18
    :try_end_1b
    .catch Ljava/io/IOException; {:try_start_1b .. :try_end_1b} :catch_24
    .catch Ljava/lang/RuntimeException; {:try_start_1b .. :try_end_1b} :catch_23
    .catch Ljava/lang/Error; {:try_start_1b .. :try_end_1b} :catch_22
    .catchall {:try_start_1b .. :try_end_1b} :catchall_c

    .line 426
    move-object/from16 v9, v25

    move-object/from16 v1, p0

    move-wide/from16 v21, v22

    move-object/from16 v23, v11

    const/4 v11, 0x0

    .end local v11    # "signer":Lcom/amazonaws/auth/Signer;
    .end local v22    # "lastBackoffDelay":J
    .local v21, "lastBackoffDelay":J
    .local v23, "signer":Lcom/amazonaws/auth/Signer;
    move-object v4, v0

    move-object v11, v5

    .end local v5    # "httpResponse":Lcom/amazonaws/http/HttpResponse;
    .local v11, "httpResponse":Lcom/amazonaws/http/HttpResponse;
    move/from16 v5, v24

    move-object/from16 v19, v6

    .end local v6    # "httpRequest":Lcom/amazonaws/http/HttpRequest;
    .local v19, "httpRequest":Lcom/amazonaws/http/HttpRequest;
    move-object/from16 v6, v18

    :try_start_1c
    invoke-direct/range {v1 .. v6}, Lcom/amazonaws/http/AmazonHttpClient;->shouldRetry(Lcom/amazonaws/AmazonWebServiceRequest;Ljava/io/InputStream;Lcom/amazonaws/AmazonClientException;ILcom/amazonaws/retry/RetryPolicy;)Z

    move-result v1
    :try_end_1c
    .catch Ljava/io/IOException; {:try_start_1c .. :try_end_1c} :catch_21
    .catch Ljava/lang/RuntimeException; {:try_start_1c .. :try_end_1c} :catch_20
    .catch Ljava/lang/Error; {:try_start_1c .. :try_end_1c} :catch_1f
    .catchall {:try_start_1c .. :try_end_1c} :catchall_b

    if-eqz v1, :cond_f

    .line 435
    move-object v5, v0

    .line 441
    .end local v16    # "retriedException":Lcom/amazonaws/AmazonClientException;
    .local v5, "retriedException":Lcom/amazonaws/AmazonClientException;
    :try_start_1d
    invoke-static {v0}, Lcom/amazonaws/retry/RetryUtils;->isClockSkewError(Lcom/amazonaws/AmazonServiceException;)Z

    move-result v1

    if-eqz v1, :cond_c

    .line 442
    invoke-virtual {v7, v11, v0}, Lcom/amazonaws/http/AmazonHttpClient;->parseClockSkewOffset(Lcom/amazonaws/http/HttpResponse;Lcom/amazonaws/AmazonServiceException;)I

    move-result v1

    .line 443
    .local v1, "timeOffset":I
    invoke-static {v1}, Lcom/amazonaws/SDKGlobalConfiguration;->setGlobalTimeOffset(I)V

    .line 445
    .end local v1    # "timeOffset":I
    :cond_c
    invoke-virtual {v7, v8, v0}, Lcom/amazonaws/http/AmazonHttpClient;->resetRequestAfterError(Lcom/amazonaws/Request;Ljava/lang/Exception;)V
    :try_end_1d
    .catch Ljava/io/IOException; {:try_start_1d .. :try_end_1d} :catch_1e
    .catch Ljava/lang/RuntimeException; {:try_start_1d .. :try_end_1d} :catch_1d
    .catch Ljava/lang/Error; {:try_start_1d .. :try_end_1d} :catch_1c
    .catchall {:try_start_1d .. :try_end_1d} :catchall_a

    move-object/from16 v16, v5

    move/from16 v1, v17

    .line 480
    .end local v0    # "ase":Lcom/amazonaws/AmazonServiceException;
    .end local v5    # "retriedException":Lcom/amazonaws/AmazonClientException;
    .end local v17    # "leaveHttpConnectionOpen":Z
    .local v1, "leaveHttpConnectionOpen":Z
    .restart local v16    # "retriedException":Lcom/amazonaws/AmazonClientException;
    :goto_6
    if-nez v1, :cond_e

    if-eqz v11, :cond_e

    .line 482
    :try_start_1e
    invoke-virtual {v11}, Lcom/amazonaws/http/HttpResponse;->getRawContent()Ljava/io/InputStream;

    move-result-object v0

    if-eqz v0, :cond_d

    .line 483
    invoke-virtual {v11}, Lcom/amazonaws/http/HttpResponse;->getRawContent()Ljava/io/InputStream;

    move-result-object v0

    invoke-virtual {v0}, Ljava/io/InputStream;->close()V
    :try_end_1e
    .catch Ljava/io/IOException; {:try_start_1e .. :try_end_1e} :catch_1b

    goto :goto_7

    .line 485
    :catch_1b
    move-exception v0

    .line 486
    .local v0, "e":Ljava/io/IOException;
    sget-object v2, Lcom/amazonaws/http/AmazonHttpClient;->log:Lcom/amazonaws/logging/Log;

    invoke-interface {v2, v9, v0}, Lcom/amazonaws/logging/Log;->warn(Ljava/lang/Object;Ljava/lang/Throwable;)V

    .line 487
    .end local v0    # "e":Ljava/io/IOException;
    :cond_d
    :goto_7
    nop

    .line 489
    :cond_e
    move-object v4, v11

    move-object/from16 v5, v16

    move-object/from16 v16, v19

    move-wide/from16 v2, v21

    move-object/from16 v6, v23

    goto/16 :goto_10

    .line 480
    .end local v1    # "leaveHttpConnectionOpen":Z
    .end local v16    # "retriedException":Lcom/amazonaws/AmazonClientException;
    .restart local v5    # "retriedException":Lcom/amazonaws/AmazonClientException;
    .restart local v17    # "leaveHttpConnectionOpen":Z
    :catchall_a
    move-exception v0

    move-object v4, v11

    move/from16 v1, v17

    move-object/from16 v16, v19

    move-wide/from16 v2, v21

    move-object/from16 v6, v23

    move-object v11, v0

    goto/16 :goto_11

    .line 470
    :catch_1c
    move-exception v0

    move-object v4, v11

    move/from16 v1, v17

    move-object/from16 v16, v19

    move-wide/from16 v2, v21

    move-object/from16 v6, v23

    goto/16 :goto_c

    .line 468
    :catch_1d
    move-exception v0

    move-object v4, v11

    move/from16 v1, v17

    move-object/from16 v16, v19

    move-wide/from16 v2, v21

    move-object/from16 v6, v23

    goto/16 :goto_d

    .line 447
    :catch_1e
    move-exception v0

    move-object/from16 v16, v5

    move-object/from16 v18, v11

    move-object/from16 v11, v23

    goto/16 :goto_e

    .line 431
    .end local v5    # "retriedException":Lcom/amazonaws/AmazonClientException;
    .local v0, "ase":Lcom/amazonaws/AmazonServiceException;
    .restart local v16    # "retriedException":Lcom/amazonaws/AmazonClientException;
    :cond_f
    nop

    .end local v10    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v11    # "httpResponse":Lcom/amazonaws/http/HttpResponse;
    .end local v12    # "originalHeaders":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .end local v13    # "originalContent":Ljava/io/InputStream;
    .end local v14    # "credentials":Lcom/amazonaws/auth/AWSCredentials;
    .end local v15    # "redirectedURI":Ljava/net/URI;
    .end local v16    # "retriedException":Lcom/amazonaws/AmazonClientException;
    .end local v17    # "leaveHttpConnectionOpen":Z
    .end local v19    # "httpRequest":Lcom/amazonaws/http/HttpRequest;
    .end local v20    # "originalParameters":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .end local v21    # "lastBackoffDelay":J
    .end local v23    # "signer":Lcom/amazonaws/auth/Signer;
    .end local v24    # "requestCount":I
    .end local p1    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<*>;"
    .end local p2    # "responseHandler":Lcom/amazonaws/http/HttpResponseHandler;, "Lcom/amazonaws/http/HttpResponseHandler<Lcom/amazonaws/AmazonWebServiceResponse<TT;>;>;"
    .end local p3    # "errorResponseHandler":Lcom/amazonaws/http/HttpResponseHandler;, "Lcom/amazonaws/http/HttpResponseHandler<Lcom/amazonaws/AmazonServiceException;>;"
    .end local p4    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    :try_start_1f
    throw v0
    :try_end_1f
    .catch Ljava/io/IOException; {:try_start_1f .. :try_end_1f} :catch_21
    .catch Ljava/lang/RuntimeException; {:try_start_1f .. :try_end_1f} :catch_20
    .catch Ljava/lang/Error; {:try_start_1f .. :try_end_1f} :catch_1f
    .catchall {:try_start_1f .. :try_end_1f} :catchall_b

    .line 480
    .end local v0    # "ase":Lcom/amazonaws/AmazonServiceException;
    .restart local v10    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v11    # "httpResponse":Lcom/amazonaws/http/HttpResponse;
    .restart local v12    # "originalHeaders":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .restart local v13    # "originalContent":Ljava/io/InputStream;
    .restart local v14    # "credentials":Lcom/amazonaws/auth/AWSCredentials;
    .restart local v15    # "redirectedURI":Ljava/net/URI;
    .restart local v16    # "retriedException":Lcom/amazonaws/AmazonClientException;
    .restart local v17    # "leaveHttpConnectionOpen":Z
    .restart local v19    # "httpRequest":Lcom/amazonaws/http/HttpRequest;
    .restart local v20    # "originalParameters":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .restart local v21    # "lastBackoffDelay":J
    .restart local v23    # "signer":Lcom/amazonaws/auth/Signer;
    .restart local v24    # "requestCount":I
    .restart local p1    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<*>;"
    .restart local p2    # "responseHandler":Lcom/amazonaws/http/HttpResponseHandler;, "Lcom/amazonaws/http/HttpResponseHandler<Lcom/amazonaws/AmazonWebServiceResponse<TT;>;>;"
    .restart local p3    # "errorResponseHandler":Lcom/amazonaws/http/HttpResponseHandler;, "Lcom/amazonaws/http/HttpResponseHandler<Lcom/amazonaws/AmazonServiceException;>;"
    .restart local p4    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    :catchall_b
    move-exception v0

    move-object v4, v11

    move-object/from16 v5, v16

    move/from16 v1, v17

    move-object/from16 v16, v19

    move-wide/from16 v2, v21

    move-object/from16 v6, v23

    move-object v11, v0

    goto/16 :goto_11

    .line 470
    :catch_1f
    move-exception v0

    move-object v4, v11

    move-object/from16 v5, v16

    move/from16 v1, v17

    move-object/from16 v16, v19

    move-wide/from16 v2, v21

    move-object/from16 v6, v23

    goto/16 :goto_c

    .line 468
    :catch_20
    move-exception v0

    move-object v4, v11

    move-object/from16 v5, v16

    move/from16 v1, v17

    move-object/from16 v16, v19

    move-wide/from16 v2, v21

    move-object/from16 v6, v23

    goto/16 :goto_d

    .line 447
    :catch_21
    move-exception v0

    move-object/from16 v18, v11

    move-object/from16 v11, v23

    goto/16 :goto_e

    .line 480
    .end local v19    # "httpRequest":Lcom/amazonaws/http/HttpRequest;
    .end local v21    # "lastBackoffDelay":J
    .end local v23    # "signer":Lcom/amazonaws/auth/Signer;
    .local v5, "httpResponse":Lcom/amazonaws/http/HttpResponse;
    .restart local v6    # "httpRequest":Lcom/amazonaws/http/HttpRequest;
    .local v11, "signer":Lcom/amazonaws/auth/Signer;
    .restart local v22    # "lastBackoffDelay":J
    :catchall_c
    move-exception v0

    move-object/from16 v19, v6

    move-wide/from16 v21, v22

    move-object/from16 v9, v25

    goto :goto_8

    .line 470
    :catch_22
    move-exception v0

    move-object/from16 v19, v6

    move-wide/from16 v21, v22

    move-object/from16 v9, v25

    goto :goto_9

    .line 468
    :catch_23
    move-exception v0

    move-object/from16 v19, v6

    move-wide/from16 v21, v22

    move-object/from16 v9, v25

    goto :goto_a

    .line 447
    :catch_24
    move-exception v0

    move-object/from16 v19, v6

    move-wide/from16 v21, v22

    move-object/from16 v9, v25

    goto :goto_b

    .line 480
    :catchall_d
    move-exception v0

    move-object v9, v1

    move-object/from16 v19, v6

    move-wide/from16 v21, v22

    :goto_8
    move-object/from16 v23, v11

    move-object v11, v5

    move-object v4, v11

    move-object/from16 v5, v16

    move/from16 v1, v17

    move-object/from16 v16, v19

    move-wide/from16 v2, v21

    move-object/from16 v6, v23

    move-object v11, v0

    .end local v5    # "httpResponse":Lcom/amazonaws/http/HttpResponse;
    .end local v6    # "httpRequest":Lcom/amazonaws/http/HttpRequest;
    .end local v22    # "lastBackoffDelay":J
    .local v11, "httpResponse":Lcom/amazonaws/http/HttpResponse;
    .restart local v19    # "httpRequest":Lcom/amazonaws/http/HttpRequest;
    .restart local v21    # "lastBackoffDelay":J
    .restart local v23    # "signer":Lcom/amazonaws/auth/Signer;
    goto/16 :goto_11

    .line 470
    .end local v19    # "httpRequest":Lcom/amazonaws/http/HttpRequest;
    .end local v21    # "lastBackoffDelay":J
    .end local v23    # "signer":Lcom/amazonaws/auth/Signer;
    .restart local v5    # "httpResponse":Lcom/amazonaws/http/HttpResponse;
    .restart local v6    # "httpRequest":Lcom/amazonaws/http/HttpRequest;
    .local v11, "signer":Lcom/amazonaws/auth/Signer;
    .restart local v22    # "lastBackoffDelay":J
    :catch_25
    move-exception v0

    move-object v9, v1

    move-object/from16 v19, v6

    move-wide/from16 v21, v22

    :goto_9
    move-object/from16 v23, v11

    move-object v11, v5

    move-object v4, v11

    move-object/from16 v5, v16

    move/from16 v1, v17

    move-object/from16 v16, v19

    move-wide/from16 v2, v21

    move-object/from16 v6, v23

    .end local v5    # "httpResponse":Lcom/amazonaws/http/HttpResponse;
    .end local v6    # "httpRequest":Lcom/amazonaws/http/HttpRequest;
    .end local v22    # "lastBackoffDelay":J
    .local v11, "httpResponse":Lcom/amazonaws/http/HttpResponse;
    .restart local v19    # "httpRequest":Lcom/amazonaws/http/HttpRequest;
    .restart local v21    # "lastBackoffDelay":J
    .restart local v23    # "signer":Lcom/amazonaws/auth/Signer;
    goto/16 :goto_c

    .line 468
    .end local v19    # "httpRequest":Lcom/amazonaws/http/HttpRequest;
    .end local v21    # "lastBackoffDelay":J
    .end local v23    # "signer":Lcom/amazonaws/auth/Signer;
    .restart local v5    # "httpResponse":Lcom/amazonaws/http/HttpResponse;
    .restart local v6    # "httpRequest":Lcom/amazonaws/http/HttpRequest;
    .local v11, "signer":Lcom/amazonaws/auth/Signer;
    .restart local v22    # "lastBackoffDelay":J
    :catch_26
    move-exception v0

    move-object v9, v1

    move-object/from16 v19, v6

    move-wide/from16 v21, v22

    :goto_a
    move-object/from16 v23, v11

    move-object v11, v5

    move-object v4, v11

    move-object/from16 v5, v16

    move/from16 v1, v17

    move-object/from16 v16, v19

    move-wide/from16 v2, v21

    move-object/from16 v6, v23

    .end local v5    # "httpResponse":Lcom/amazonaws/http/HttpResponse;
    .end local v6    # "httpRequest":Lcom/amazonaws/http/HttpRequest;
    .end local v22    # "lastBackoffDelay":J
    .local v11, "httpResponse":Lcom/amazonaws/http/HttpResponse;
    .restart local v19    # "httpRequest":Lcom/amazonaws/http/HttpRequest;
    .restart local v21    # "lastBackoffDelay":J
    .restart local v23    # "signer":Lcom/amazonaws/auth/Signer;
    goto/16 :goto_d

    .line 447
    .end local v19    # "httpRequest":Lcom/amazonaws/http/HttpRequest;
    .end local v21    # "lastBackoffDelay":J
    .end local v23    # "signer":Lcom/amazonaws/auth/Signer;
    .restart local v5    # "httpResponse":Lcom/amazonaws/http/HttpResponse;
    .restart local v6    # "httpRequest":Lcom/amazonaws/http/HttpRequest;
    .local v11, "signer":Lcom/amazonaws/auth/Signer;
    .restart local v22    # "lastBackoffDelay":J
    :catch_27
    move-exception v0

    move-object v9, v1

    move-object/from16 v19, v6

    move-wide/from16 v21, v22

    :goto_b
    move-object/from16 v23, v11

    move-object v11, v5

    move-object/from16 v18, v11

    move-object/from16 v11, v23

    .end local v5    # "httpResponse":Lcom/amazonaws/http/HttpResponse;
    .end local v6    # "httpRequest":Lcom/amazonaws/http/HttpRequest;
    .end local v22    # "lastBackoffDelay":J
    .local v11, "httpResponse":Lcom/amazonaws/http/HttpResponse;
    .restart local v19    # "httpRequest":Lcom/amazonaws/http/HttpRequest;
    .restart local v21    # "lastBackoffDelay":J
    .restart local v23    # "signer":Lcom/amazonaws/auth/Signer;
    goto/16 :goto_e

    .line 480
    .end local v19    # "httpRequest":Lcom/amazonaws/http/HttpRequest;
    .end local v21    # "lastBackoffDelay":J
    .end local v23    # "signer":Lcom/amazonaws/auth/Signer;
    .end local v24    # "requestCount":I
    .restart local v2    # "lastBackoffDelay":J
    .restart local v4    # "requestCount":I
    .restart local v5    # "httpResponse":Lcom/amazonaws/http/HttpResponse;
    .restart local v6    # "httpRequest":Lcom/amazonaws/http/HttpRequest;
    .local v11, "signer":Lcom/amazonaws/auth/Signer;
    :catchall_e
    move-exception v0

    move-object v9, v1

    move-wide/from16 v21, v2

    move/from16 v24, v4

    move-object/from16 v19, v6

    move-object/from16 v23, v11

    move-object v11, v5

    move-object v4, v11

    move-object/from16 v5, v16

    move/from16 v1, v17

    move-object/from16 v16, v19

    move-object/from16 v6, v23

    move-object v11, v0

    .end local v2    # "lastBackoffDelay":J
    .end local v4    # "requestCount":I
    .end local v5    # "httpResponse":Lcom/amazonaws/http/HttpResponse;
    .end local v6    # "httpRequest":Lcom/amazonaws/http/HttpRequest;
    .local v11, "httpResponse":Lcom/amazonaws/http/HttpResponse;
    .restart local v19    # "httpRequest":Lcom/amazonaws/http/HttpRequest;
    .restart local v21    # "lastBackoffDelay":J
    .restart local v23    # "signer":Lcom/amazonaws/auth/Signer;
    .restart local v24    # "requestCount":I
    goto/16 :goto_11

    .line 470
    .end local v19    # "httpRequest":Lcom/amazonaws/http/HttpRequest;
    .end local v21    # "lastBackoffDelay":J
    .end local v23    # "signer":Lcom/amazonaws/auth/Signer;
    .end local v24    # "requestCount":I
    .restart local v2    # "lastBackoffDelay":J
    .restart local v4    # "requestCount":I
    .restart local v5    # "httpResponse":Lcom/amazonaws/http/HttpResponse;
    .restart local v6    # "httpRequest":Lcom/amazonaws/http/HttpRequest;
    .local v11, "signer":Lcom/amazonaws/auth/Signer;
    :catch_28
    move-exception v0

    move-object v9, v1

    move-wide/from16 v21, v2

    move/from16 v24, v4

    move-object/from16 v19, v6

    move-object/from16 v23, v11

    move-object v11, v5

    move-object v4, v11

    move-object/from16 v5, v16

    move/from16 v1, v17

    move-object/from16 v16, v19

    move-object/from16 v6, v23

    .end local v2    # "lastBackoffDelay":J
    .end local v4    # "requestCount":I
    .end local v5    # "httpResponse":Lcom/amazonaws/http/HttpResponse;
    .end local v6    # "httpRequest":Lcom/amazonaws/http/HttpRequest;
    .local v11, "httpResponse":Lcom/amazonaws/http/HttpResponse;
    .restart local v19    # "httpRequest":Lcom/amazonaws/http/HttpRequest;
    .restart local v21    # "lastBackoffDelay":J
    .restart local v23    # "signer":Lcom/amazonaws/auth/Signer;
    .restart local v24    # "requestCount":I
    goto/16 :goto_c

    .line 468
    .end local v19    # "httpRequest":Lcom/amazonaws/http/HttpRequest;
    .end local v21    # "lastBackoffDelay":J
    .end local v23    # "signer":Lcom/amazonaws/auth/Signer;
    .end local v24    # "requestCount":I
    .restart local v2    # "lastBackoffDelay":J
    .restart local v4    # "requestCount":I
    .restart local v5    # "httpResponse":Lcom/amazonaws/http/HttpResponse;
    .restart local v6    # "httpRequest":Lcom/amazonaws/http/HttpRequest;
    .local v11, "signer":Lcom/amazonaws/auth/Signer;
    :catch_29
    move-exception v0

    move-object v9, v1

    move-wide/from16 v21, v2

    move/from16 v24, v4

    move-object/from16 v19, v6

    move-object/from16 v23, v11

    move-object v11, v5

    move-object v4, v11

    move-object/from16 v5, v16

    move/from16 v1, v17

    move-object/from16 v16, v19

    move-object/from16 v6, v23

    .end local v2    # "lastBackoffDelay":J
    .end local v4    # "requestCount":I
    .end local v5    # "httpResponse":Lcom/amazonaws/http/HttpResponse;
    .end local v6    # "httpRequest":Lcom/amazonaws/http/HttpRequest;
    .local v11, "httpResponse":Lcom/amazonaws/http/HttpResponse;
    .restart local v19    # "httpRequest":Lcom/amazonaws/http/HttpRequest;
    .restart local v21    # "lastBackoffDelay":J
    .restart local v23    # "signer":Lcom/amazonaws/auth/Signer;
    .restart local v24    # "requestCount":I
    goto/16 :goto_d

    .line 447
    .end local v19    # "httpRequest":Lcom/amazonaws/http/HttpRequest;
    .end local v21    # "lastBackoffDelay":J
    .end local v23    # "signer":Lcom/amazonaws/auth/Signer;
    .end local v24    # "requestCount":I
    .restart local v2    # "lastBackoffDelay":J
    .restart local v4    # "requestCount":I
    .restart local v5    # "httpResponse":Lcom/amazonaws/http/HttpResponse;
    .restart local v6    # "httpRequest":Lcom/amazonaws/http/HttpRequest;
    .local v11, "signer":Lcom/amazonaws/auth/Signer;
    :catch_2a
    move-exception v0

    move-object v9, v1

    move-wide/from16 v21, v2

    move/from16 v24, v4

    move-object/from16 v19, v6

    move-object/from16 v23, v11

    move-object v11, v5

    move-object/from16 v18, v11

    move-object/from16 v11, v23

    .end local v2    # "lastBackoffDelay":J
    .end local v4    # "requestCount":I
    .end local v5    # "httpResponse":Lcom/amazonaws/http/HttpResponse;
    .end local v6    # "httpRequest":Lcom/amazonaws/http/HttpRequest;
    .local v11, "httpResponse":Lcom/amazonaws/http/HttpResponse;
    .restart local v19    # "httpRequest":Lcom/amazonaws/http/HttpRequest;
    .restart local v21    # "lastBackoffDelay":J
    .restart local v23    # "signer":Lcom/amazonaws/auth/Signer;
    .restart local v24    # "requestCount":I
    goto/16 :goto_e

    .line 388
    .end local v19    # "httpRequest":Lcom/amazonaws/http/HttpRequest;
    .end local v21    # "lastBackoffDelay":J
    .end local v23    # "signer":Lcom/amazonaws/auth/Signer;
    .end local v24    # "requestCount":I
    .restart local v2    # "lastBackoffDelay":J
    .restart local v4    # "requestCount":I
    .restart local v6    # "httpRequest":Lcom/amazonaws/http/HttpRequest;
    .local v11, "signer":Lcom/amazonaws/auth/Signer;
    .restart local v18    # "httpResponse":Lcom/amazonaws/http/HttpResponse;
    :catchall_f
    move-exception v0

    move-object v9, v1

    move-wide/from16 v21, v2

    move/from16 v24, v4

    move-object/from16 v19, v6

    move-object/from16 v23, v11

    .end local v2    # "lastBackoffDelay":J
    .end local v4    # "requestCount":I
    .end local v6    # "httpRequest":Lcom/amazonaws/http/HttpRequest;
    .end local v11    # "signer":Lcom/amazonaws/auth/Signer;
    .restart local v19    # "httpRequest":Lcom/amazonaws/http/HttpRequest;
    .restart local v21    # "lastBackoffDelay":J
    .restart local v23    # "signer":Lcom/amazonaws/auth/Signer;
    .restart local v24    # "requestCount":I
    :try_start_20
    sget-object v1, Lcom/amazonaws/util/AWSRequestMetrics$Field;->HttpRequestTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v10, v1}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 389
    nop

    .end local v10    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v12    # "originalHeaders":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .end local v13    # "originalContent":Ljava/io/InputStream;
    .end local v14    # "credentials":Lcom/amazonaws/auth/AWSCredentials;
    .end local v15    # "redirectedURI":Ljava/net/URI;
    .end local v16    # "retriedException":Lcom/amazonaws/AmazonClientException;
    .end local v17    # "leaveHttpConnectionOpen":Z
    .end local v18    # "httpResponse":Lcom/amazonaws/http/HttpResponse;
    .end local v19    # "httpRequest":Lcom/amazonaws/http/HttpRequest;
    .end local v20    # "originalParameters":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .end local v21    # "lastBackoffDelay":J
    .end local v23    # "signer":Lcom/amazonaws/auth/Signer;
    .end local v24    # "requestCount":I
    .end local p1    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<*>;"
    .end local p2    # "responseHandler":Lcom/amazonaws/http/HttpResponseHandler;, "Lcom/amazonaws/http/HttpResponseHandler<Lcom/amazonaws/AmazonWebServiceResponse<TT;>;>;"
    .end local p3    # "errorResponseHandler":Lcom/amazonaws/http/HttpResponseHandler;, "Lcom/amazonaws/http/HttpResponseHandler<Lcom/amazonaws/AmazonServiceException;>;"
    .end local p4    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    throw v0
    :try_end_20
    .catch Ljava/io/IOException; {:try_start_20 .. :try_end_20} :catch_2d
    .catch Ljava/lang/RuntimeException; {:try_start_20 .. :try_end_20} :catch_2c
    .catch Ljava/lang/Error; {:try_start_20 .. :try_end_20} :catch_2b
    .catchall {:try_start_20 .. :try_end_20} :catchall_10

    .line 480
    .restart local v10    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v12    # "originalHeaders":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .restart local v13    # "originalContent":Ljava/io/InputStream;
    .restart local v14    # "credentials":Lcom/amazonaws/auth/AWSCredentials;
    .restart local v15    # "redirectedURI":Ljava/net/URI;
    .restart local v16    # "retriedException":Lcom/amazonaws/AmazonClientException;
    .restart local v17    # "leaveHttpConnectionOpen":Z
    .restart local v18    # "httpResponse":Lcom/amazonaws/http/HttpResponse;
    .restart local v19    # "httpRequest":Lcom/amazonaws/http/HttpRequest;
    .restart local v20    # "originalParameters":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .restart local v21    # "lastBackoffDelay":J
    .restart local v23    # "signer":Lcom/amazonaws/auth/Signer;
    .restart local v24    # "requestCount":I
    .restart local p1    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<*>;"
    .restart local p2    # "responseHandler":Lcom/amazonaws/http/HttpResponseHandler;, "Lcom/amazonaws/http/HttpResponseHandler<Lcom/amazonaws/AmazonWebServiceResponse<TT;>;>;"
    .restart local p3    # "errorResponseHandler":Lcom/amazonaws/http/HttpResponseHandler;, "Lcom/amazonaws/http/HttpResponseHandler<Lcom/amazonaws/AmazonServiceException;>;"
    .restart local p4    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    :catchall_10
    move-exception v0

    move-object v11, v0

    move-object/from16 v5, v16

    move/from16 v1, v17

    move-object/from16 v4, v18

    move-object/from16 v16, v19

    move-wide/from16 v2, v21

    move-object/from16 v6, v23

    goto/16 :goto_11

    .line 470
    :catch_2b
    move-exception v0

    move-object/from16 v5, v16

    move/from16 v1, v17

    move-object/from16 v4, v18

    move-object/from16 v16, v19

    move-wide/from16 v2, v21

    move-object/from16 v6, v23

    goto/16 :goto_c

    .line 468
    :catch_2c
    move-exception v0

    move-object/from16 v5, v16

    move/from16 v1, v17

    move-object/from16 v4, v18

    move-object/from16 v16, v19

    move-wide/from16 v2, v21

    move-object/from16 v6, v23

    goto/16 :goto_d

    .line 447
    :catch_2d
    move-exception v0

    move-object/from16 v11, v23

    goto/16 :goto_e

    .line 480
    .end local v19    # "httpRequest":Lcom/amazonaws/http/HttpRequest;
    .end local v21    # "lastBackoffDelay":J
    .end local v23    # "signer":Lcom/amazonaws/auth/Signer;
    .end local v24    # "requestCount":I
    .restart local v2    # "lastBackoffDelay":J
    .restart local v4    # "requestCount":I
    .restart local v6    # "httpRequest":Lcom/amazonaws/http/HttpRequest;
    .restart local v11    # "signer":Lcom/amazonaws/auth/Signer;
    :catchall_11
    move-exception v0

    move-object v9, v1

    move-wide/from16 v21, v2

    move/from16 v24, v4

    move-object/from16 v19, v6

    move-object/from16 v23, v11

    move-object v11, v0

    move-object/from16 v5, v16

    move/from16 v1, v17

    move-object/from16 v4, v18

    move-object/from16 v16, v19

    move-object/from16 v6, v23

    .end local v2    # "lastBackoffDelay":J
    .end local v4    # "requestCount":I
    .end local v6    # "httpRequest":Lcom/amazonaws/http/HttpRequest;
    .end local v11    # "signer":Lcom/amazonaws/auth/Signer;
    .restart local v19    # "httpRequest":Lcom/amazonaws/http/HttpRequest;
    .restart local v21    # "lastBackoffDelay":J
    .restart local v23    # "signer":Lcom/amazonaws/auth/Signer;
    .restart local v24    # "requestCount":I
    goto/16 :goto_11

    .line 470
    .end local v19    # "httpRequest":Lcom/amazonaws/http/HttpRequest;
    .end local v21    # "lastBackoffDelay":J
    .end local v23    # "signer":Lcom/amazonaws/auth/Signer;
    .end local v24    # "requestCount":I
    .restart local v2    # "lastBackoffDelay":J
    .restart local v4    # "requestCount":I
    .restart local v6    # "httpRequest":Lcom/amazonaws/http/HttpRequest;
    .restart local v11    # "signer":Lcom/amazonaws/auth/Signer;
    :catch_2e
    move-exception v0

    move-object v9, v1

    move-wide/from16 v21, v2

    move/from16 v24, v4

    move-object/from16 v19, v6

    move-object/from16 v23, v11

    move-object/from16 v5, v16

    move/from16 v1, v17

    move-object/from16 v4, v18

    move-object/from16 v16, v19

    move-object/from16 v6, v23

    .end local v2    # "lastBackoffDelay":J
    .end local v4    # "requestCount":I
    .end local v6    # "httpRequest":Lcom/amazonaws/http/HttpRequest;
    .end local v11    # "signer":Lcom/amazonaws/auth/Signer;
    .restart local v19    # "httpRequest":Lcom/amazonaws/http/HttpRequest;
    .restart local v21    # "lastBackoffDelay":J
    .restart local v23    # "signer":Lcom/amazonaws/auth/Signer;
    .restart local v24    # "requestCount":I
    goto/16 :goto_c

    .line 468
    .end local v19    # "httpRequest":Lcom/amazonaws/http/HttpRequest;
    .end local v21    # "lastBackoffDelay":J
    .end local v23    # "signer":Lcom/amazonaws/auth/Signer;
    .end local v24    # "requestCount":I
    .restart local v2    # "lastBackoffDelay":J
    .restart local v4    # "requestCount":I
    .restart local v6    # "httpRequest":Lcom/amazonaws/http/HttpRequest;
    .restart local v11    # "signer":Lcom/amazonaws/auth/Signer;
    :catch_2f
    move-exception v0

    move-object v9, v1

    move-wide/from16 v21, v2

    move/from16 v24, v4

    move-object/from16 v19, v6

    move-object/from16 v23, v11

    move-object/from16 v5, v16

    move/from16 v1, v17

    move-object/from16 v4, v18

    move-object/from16 v16, v19

    move-object/from16 v6, v23

    .end local v2    # "lastBackoffDelay":J
    .end local v4    # "requestCount":I
    .end local v6    # "httpRequest":Lcom/amazonaws/http/HttpRequest;
    .end local v11    # "signer":Lcom/amazonaws/auth/Signer;
    .restart local v19    # "httpRequest":Lcom/amazonaws/http/HttpRequest;
    .restart local v21    # "lastBackoffDelay":J
    .restart local v23    # "signer":Lcom/amazonaws/auth/Signer;
    .restart local v24    # "requestCount":I
    goto/16 :goto_d

    .line 447
    .end local v19    # "httpRequest":Lcom/amazonaws/http/HttpRequest;
    .end local v21    # "lastBackoffDelay":J
    .end local v23    # "signer":Lcom/amazonaws/auth/Signer;
    .end local v24    # "requestCount":I
    .restart local v2    # "lastBackoffDelay":J
    .restart local v4    # "requestCount":I
    .restart local v6    # "httpRequest":Lcom/amazonaws/http/HttpRequest;
    .restart local v11    # "signer":Lcom/amazonaws/auth/Signer;
    :catch_30
    move-exception v0

    move-object v9, v1

    move-wide/from16 v21, v2

    move/from16 v24, v4

    move-object/from16 v19, v6

    move-object/from16 v23, v11

    .end local v2    # "lastBackoffDelay":J
    .end local v4    # "requestCount":I
    .end local v6    # "httpRequest":Lcom/amazonaws/http/HttpRequest;
    .end local v11    # "signer":Lcom/amazonaws/auth/Signer;
    .restart local v19    # "httpRequest":Lcom/amazonaws/http/HttpRequest;
    .restart local v21    # "lastBackoffDelay":J
    .restart local v23    # "signer":Lcom/amazonaws/auth/Signer;
    .restart local v24    # "requestCount":I
    goto/16 :goto_e

    .line 480
    .end local v21    # "lastBackoffDelay":J
    .end local v23    # "signer":Lcom/amazonaws/auth/Signer;
    .end local v24    # "requestCount":I
    .restart local v2    # "lastBackoffDelay":J
    .restart local v4    # "requestCount":I
    .restart local v11    # "signer":Lcom/amazonaws/auth/Signer;
    .local v16, "httpRequest":Lcom/amazonaws/http/HttpRequest;
    .local v19, "retriedException":Lcom/amazonaws/AmazonClientException;
    :catchall_12
    move-exception v0

    move-object v9, v1

    move-wide/from16 v21, v2

    move/from16 v24, v4

    move-object/from16 v23, v11

    move-object v11, v0

    move/from16 v1, v17

    move-object/from16 v4, v18

    move-object/from16 v5, v19

    move-object/from16 v6, v23

    .end local v2    # "lastBackoffDelay":J
    .end local v4    # "requestCount":I
    .end local v11    # "signer":Lcom/amazonaws/auth/Signer;
    .restart local v21    # "lastBackoffDelay":J
    .restart local v23    # "signer":Lcom/amazonaws/auth/Signer;
    .restart local v24    # "requestCount":I
    goto/16 :goto_11

    .line 470
    .end local v21    # "lastBackoffDelay":J
    .end local v23    # "signer":Lcom/amazonaws/auth/Signer;
    .end local v24    # "requestCount":I
    .restart local v2    # "lastBackoffDelay":J
    .restart local v4    # "requestCount":I
    .restart local v11    # "signer":Lcom/amazonaws/auth/Signer;
    :catch_31
    move-exception v0

    move-object v9, v1

    move-wide/from16 v21, v2

    move/from16 v24, v4

    move-object/from16 v23, v11

    move/from16 v1, v17

    move-object/from16 v4, v18

    move-object/from16 v5, v19

    move-object/from16 v6, v23

    .end local v2    # "lastBackoffDelay":J
    .end local v4    # "requestCount":I
    .end local v11    # "signer":Lcom/amazonaws/auth/Signer;
    .restart local v21    # "lastBackoffDelay":J
    .restart local v23    # "signer":Lcom/amazonaws/auth/Signer;
    .restart local v24    # "requestCount":I
    goto/16 :goto_c

    .line 468
    .end local v21    # "lastBackoffDelay":J
    .end local v23    # "signer":Lcom/amazonaws/auth/Signer;
    .end local v24    # "requestCount":I
    .restart local v2    # "lastBackoffDelay":J
    .restart local v4    # "requestCount":I
    .restart local v11    # "signer":Lcom/amazonaws/auth/Signer;
    :catch_32
    move-exception v0

    move-object v9, v1

    move-wide/from16 v21, v2

    move/from16 v24, v4

    move-object/from16 v23, v11

    move/from16 v1, v17

    move-object/from16 v4, v18

    move-object/from16 v5, v19

    move-object/from16 v6, v23

    .end local v2    # "lastBackoffDelay":J
    .end local v4    # "requestCount":I
    .end local v11    # "signer":Lcom/amazonaws/auth/Signer;
    .restart local v21    # "lastBackoffDelay":J
    .restart local v23    # "signer":Lcom/amazonaws/auth/Signer;
    .restart local v24    # "requestCount":I
    goto/16 :goto_d

    .line 447
    .end local v21    # "lastBackoffDelay":J
    .end local v23    # "signer":Lcom/amazonaws/auth/Signer;
    .end local v24    # "requestCount":I
    .restart local v2    # "lastBackoffDelay":J
    .restart local v4    # "requestCount":I
    .restart local v11    # "signer":Lcom/amazonaws/auth/Signer;
    :catch_33
    move-exception v0

    move-object v9, v1

    move-wide/from16 v21, v2

    move/from16 v24, v4

    move-object/from16 v23, v11

    move-object/from16 v26, v19

    move-object/from16 v19, v16

    move-object/from16 v16, v26

    .end local v2    # "lastBackoffDelay":J
    .end local v4    # "requestCount":I
    .end local v11    # "signer":Lcom/amazonaws/auth/Signer;
    .restart local v21    # "lastBackoffDelay":J
    .restart local v23    # "signer":Lcom/amazonaws/auth/Signer;
    .restart local v24    # "requestCount":I
    goto/16 :goto_e

    .line 480
    .end local v21    # "lastBackoffDelay":J
    .end local v23    # "signer":Lcom/amazonaws/auth/Signer;
    .end local v24    # "requestCount":I
    .restart local v2    # "lastBackoffDelay":J
    .restart local v4    # "requestCount":I
    .local v6, "signer":Lcom/amazonaws/auth/Signer;
    :catchall_13
    move-exception v0

    move-object v9, v1

    move-wide/from16 v21, v2

    move/from16 v24, v4

    move-object v11, v0

    move/from16 v1, v17

    move-object/from16 v4, v18

    move-object/from16 v5, v19

    .end local v2    # "lastBackoffDelay":J
    .end local v4    # "requestCount":I
    .restart local v21    # "lastBackoffDelay":J
    .restart local v24    # "requestCount":I
    goto/16 :goto_11

    .line 470
    .end local v21    # "lastBackoffDelay":J
    .end local v24    # "requestCount":I
    .restart local v2    # "lastBackoffDelay":J
    .restart local v4    # "requestCount":I
    :catch_34
    move-exception v0

    move-object v9, v1

    move-wide/from16 v21, v2

    move/from16 v24, v4

    move/from16 v1, v17

    move-object/from16 v4, v18

    move-object/from16 v5, v19

    .end local v2    # "lastBackoffDelay":J
    .end local v4    # "requestCount":I
    .restart local v21    # "lastBackoffDelay":J
    .restart local v24    # "requestCount":I
    goto/16 :goto_c

    .line 468
    .end local v21    # "lastBackoffDelay":J
    .end local v24    # "requestCount":I
    .restart local v2    # "lastBackoffDelay":J
    .restart local v4    # "requestCount":I
    :catch_35
    move-exception v0

    move-object v9, v1

    move-wide/from16 v21, v2

    move/from16 v24, v4

    move/from16 v1, v17

    move-object/from16 v4, v18

    move-object/from16 v5, v19

    .end local v2    # "lastBackoffDelay":J
    .end local v4    # "requestCount":I
    .restart local v21    # "lastBackoffDelay":J
    .restart local v24    # "requestCount":I
    goto/16 :goto_d

    .line 447
    .end local v21    # "lastBackoffDelay":J
    .end local v24    # "requestCount":I
    .restart local v2    # "lastBackoffDelay":J
    .restart local v4    # "requestCount":I
    :catch_36
    move-exception v0

    move-object v9, v1

    move-wide/from16 v21, v2

    move/from16 v24, v4

    move-object v11, v6

    move-object/from16 v26, v19

    move-object/from16 v19, v16

    move-object/from16 v16, v26

    .end local v2    # "lastBackoffDelay":J
    .end local v4    # "requestCount":I
    .restart local v21    # "lastBackoffDelay":J
    .restart local v24    # "requestCount":I
    goto/16 :goto_e

    .line 480
    .end local v20    # "originalParameters":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .end local v21    # "lastBackoffDelay":J
    .end local v24    # "requestCount":I
    .restart local v2    # "lastBackoffDelay":J
    .restart local v4    # "requestCount":I
    .local v11, "originalParameters":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    :catchall_14
    move-exception v0

    move-object v9, v1

    move-wide/from16 v21, v2

    move/from16 v24, v4

    move-object/from16 v20, v11

    move-object v11, v0

    move/from16 v1, v17

    move-object/from16 v4, v18

    move-object/from16 v5, v19

    .end local v2    # "lastBackoffDelay":J
    .end local v4    # "requestCount":I
    .end local v11    # "originalParameters":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .restart local v20    # "originalParameters":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .restart local v21    # "lastBackoffDelay":J
    .restart local v24    # "requestCount":I
    goto/16 :goto_11

    .line 470
    .end local v20    # "originalParameters":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .end local v21    # "lastBackoffDelay":J
    .end local v24    # "requestCount":I
    .restart local v2    # "lastBackoffDelay":J
    .restart local v4    # "requestCount":I
    .restart local v11    # "originalParameters":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    :catch_37
    move-exception v0

    move-object v9, v1

    move-wide/from16 v21, v2

    move/from16 v24, v4

    move-object/from16 v20, v11

    move/from16 v1, v17

    move-object/from16 v4, v18

    move-object/from16 v5, v19

    .end local v2    # "lastBackoffDelay":J
    .end local v4    # "requestCount":I
    .end local v11    # "originalParameters":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .restart local v20    # "originalParameters":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .restart local v21    # "lastBackoffDelay":J
    .restart local v24    # "requestCount":I
    goto :goto_c

    .line 468
    .end local v20    # "originalParameters":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .end local v21    # "lastBackoffDelay":J
    .end local v24    # "requestCount":I
    .restart local v2    # "lastBackoffDelay":J
    .restart local v4    # "requestCount":I
    .restart local v11    # "originalParameters":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    :catch_38
    move-exception v0

    move-object v9, v1

    move-wide/from16 v21, v2

    move/from16 v24, v4

    move-object/from16 v20, v11

    move/from16 v1, v17

    move-object/from16 v4, v18

    move-object/from16 v5, v19

    .end local v2    # "lastBackoffDelay":J
    .end local v4    # "requestCount":I
    .end local v11    # "originalParameters":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .restart local v20    # "originalParameters":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .restart local v21    # "lastBackoffDelay":J
    .restart local v24    # "requestCount":I
    goto :goto_d

    .line 447
    .end local v20    # "originalParameters":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .end local v21    # "lastBackoffDelay":J
    .end local v24    # "requestCount":I
    .restart local v2    # "lastBackoffDelay":J
    .restart local v4    # "requestCount":I
    .restart local v11    # "originalParameters":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    :catch_39
    move-exception v0

    move-object v9, v1

    move-wide/from16 v21, v2

    move/from16 v24, v4

    move-object/from16 v20, v11

    move-object v11, v6

    move-object/from16 v26, v19

    move-object/from16 v19, v16

    move-object/from16 v16, v26

    .end local v2    # "lastBackoffDelay":J
    .end local v4    # "requestCount":I
    .end local v11    # "originalParameters":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .restart local v20    # "originalParameters":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .restart local v21    # "lastBackoffDelay":J
    .restart local v24    # "requestCount":I
    goto :goto_e

    .line 480
    .end local v19    # "retriedException":Lcom/amazonaws/AmazonClientException;
    .end local v20    # "originalParameters":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .end local v21    # "lastBackoffDelay":J
    .end local v24    # "requestCount":I
    .restart local v2    # "lastBackoffDelay":J
    .restart local v4    # "requestCount":I
    .local v5, "retriedException":Lcom/amazonaws/AmazonClientException;
    .restart local v11    # "originalParameters":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    :catchall_15
    move-exception v0

    move-object v9, v1

    move-wide/from16 v21, v2

    move/from16 v24, v4

    move-object/from16 v19, v5

    move-object/from16 v20, v11

    move-object v11, v0

    move/from16 v1, v17

    move-object/from16 v4, v18

    .end local v2    # "lastBackoffDelay":J
    .end local v4    # "requestCount":I
    .end local v5    # "retriedException":Lcom/amazonaws/AmazonClientException;
    .end local v11    # "originalParameters":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .restart local v19    # "retriedException":Lcom/amazonaws/AmazonClientException;
    .restart local v20    # "originalParameters":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .restart local v21    # "lastBackoffDelay":J
    .restart local v24    # "requestCount":I
    goto/16 :goto_11

    .line 470
    .end local v19    # "retriedException":Lcom/amazonaws/AmazonClientException;
    .end local v20    # "originalParameters":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .end local v21    # "lastBackoffDelay":J
    .end local v24    # "requestCount":I
    .restart local v2    # "lastBackoffDelay":J
    .restart local v4    # "requestCount":I
    .restart local v5    # "retriedException":Lcom/amazonaws/AmazonClientException;
    .restart local v11    # "originalParameters":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    :catch_3a
    move-exception v0

    move-object v9, v1

    move-wide/from16 v21, v2

    move/from16 v24, v4

    move-object/from16 v19, v5

    move-object/from16 v20, v11

    move/from16 v1, v17

    move-object/from16 v4, v18

    .line 471
    .end local v11    # "originalParameters":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .end local v17    # "leaveHttpConnectionOpen":Z
    .end local v18    # "httpResponse":Lcom/amazonaws/http/HttpResponse;
    .local v0, "e":Ljava/lang/Error;
    .restart local v1    # "leaveHttpConnectionOpen":Z
    .local v4, "httpResponse":Lcom/amazonaws/http/HttpResponse;
    .restart local v20    # "originalParameters":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .restart local v24    # "requestCount":I
    :goto_c
    :try_start_21
    invoke-direct {v7, v0, v10}, Lcom/amazonaws/http/AmazonHttpClient;->handleUnexpectedFailure(Ljava/lang/Throwable;Lcom/amazonaws/util/AWSRequestMetrics;)Ljava/lang/Throwable;

    move-result-object v11

    check-cast v11, Ljava/lang/Error;

    .end local v1    # "leaveHttpConnectionOpen":Z
    .end local v2    # "lastBackoffDelay":J
    .end local v4    # "httpResponse":Lcom/amazonaws/http/HttpResponse;
    .end local v5    # "retriedException":Lcom/amazonaws/AmazonClientException;
    .end local v6    # "signer":Lcom/amazonaws/auth/Signer;
    .end local v10    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v12    # "originalHeaders":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .end local v13    # "originalContent":Ljava/io/InputStream;
    .end local v14    # "credentials":Lcom/amazonaws/auth/AWSCredentials;
    .end local v15    # "redirectedURI":Ljava/net/URI;
    .end local v16    # "httpRequest":Lcom/amazonaws/http/HttpRequest;
    .end local v20    # "originalParameters":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .end local v24    # "requestCount":I
    .end local p1    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<*>;"
    .end local p2    # "responseHandler":Lcom/amazonaws/http/HttpResponseHandler;, "Lcom/amazonaws/http/HttpResponseHandler<Lcom/amazonaws/AmazonWebServiceResponse<TT;>;>;"
    .end local p3    # "errorResponseHandler":Lcom/amazonaws/http/HttpResponseHandler;, "Lcom/amazonaws/http/HttpResponseHandler<Lcom/amazonaws/AmazonServiceException;>;"
    .end local p4    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    throw v11

    .line 468
    .end local v0    # "e":Ljava/lang/Error;
    .restart local v2    # "lastBackoffDelay":J
    .local v4, "requestCount":I
    .restart local v5    # "retriedException":Lcom/amazonaws/AmazonClientException;
    .restart local v6    # "signer":Lcom/amazonaws/auth/Signer;
    .restart local v10    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v11    # "originalParameters":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .restart local v12    # "originalHeaders":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .restart local v13    # "originalContent":Ljava/io/InputStream;
    .restart local v14    # "credentials":Lcom/amazonaws/auth/AWSCredentials;
    .restart local v15    # "redirectedURI":Ljava/net/URI;
    .restart local v16    # "httpRequest":Lcom/amazonaws/http/HttpRequest;
    .restart local v17    # "leaveHttpConnectionOpen":Z
    .restart local v18    # "httpResponse":Lcom/amazonaws/http/HttpResponse;
    .restart local p1    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<*>;"
    .restart local p2    # "responseHandler":Lcom/amazonaws/http/HttpResponseHandler;, "Lcom/amazonaws/http/HttpResponseHandler<Lcom/amazonaws/AmazonWebServiceResponse<TT;>;>;"
    .restart local p3    # "errorResponseHandler":Lcom/amazonaws/http/HttpResponseHandler;, "Lcom/amazonaws/http/HttpResponseHandler<Lcom/amazonaws/AmazonServiceException;>;"
    .restart local p4    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    :catch_3b
    move-exception v0

    move-object v9, v1

    move-wide/from16 v21, v2

    move/from16 v24, v4

    move-object/from16 v19, v5

    move-object/from16 v20, v11

    move/from16 v1, v17

    move-object/from16 v4, v18

    .line 469
    .end local v11    # "originalParameters":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .end local v17    # "leaveHttpConnectionOpen":Z
    .end local v18    # "httpResponse":Lcom/amazonaws/http/HttpResponse;
    .local v0, "e":Ljava/lang/RuntimeException;
    .restart local v1    # "leaveHttpConnectionOpen":Z
    .local v4, "httpResponse":Lcom/amazonaws/http/HttpResponse;
    .restart local v20    # "originalParameters":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .restart local v24    # "requestCount":I
    :goto_d
    invoke-direct {v7, v0, v10}, Lcom/amazonaws/http/AmazonHttpClient;->handleUnexpectedFailure(Ljava/lang/Throwable;Lcom/amazonaws/util/AWSRequestMetrics;)Ljava/lang/Throwable;

    move-result-object v11

    check-cast v11, Ljava/lang/RuntimeException;

    .end local v1    # "leaveHttpConnectionOpen":Z
    .end local v2    # "lastBackoffDelay":J
    .end local v4    # "httpResponse":Lcom/amazonaws/http/HttpResponse;
    .end local v5    # "retriedException":Lcom/amazonaws/AmazonClientException;
    .end local v6    # "signer":Lcom/amazonaws/auth/Signer;
    .end local v10    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v12    # "originalHeaders":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .end local v13    # "originalContent":Ljava/io/InputStream;
    .end local v14    # "credentials":Lcom/amazonaws/auth/AWSCredentials;
    .end local v15    # "redirectedURI":Ljava/net/URI;
    .end local v16    # "httpRequest":Lcom/amazonaws/http/HttpRequest;
    .end local v20    # "originalParameters":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .end local v24    # "requestCount":I
    .end local p1    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<*>;"
    .end local p2    # "responseHandler":Lcom/amazonaws/http/HttpResponseHandler;, "Lcom/amazonaws/http/HttpResponseHandler<Lcom/amazonaws/AmazonWebServiceResponse<TT;>;>;"
    .end local p3    # "errorResponseHandler":Lcom/amazonaws/http/HttpResponseHandler;, "Lcom/amazonaws/http/HttpResponseHandler<Lcom/amazonaws/AmazonServiceException;>;"
    .end local p4    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    throw v11
    :try_end_21
    .catchall {:try_start_21 .. :try_end_21} :catchall_16

    .line 480
    .end local v0    # "e":Ljava/lang/RuntimeException;
    .restart local v1    # "leaveHttpConnectionOpen":Z
    .restart local v2    # "lastBackoffDelay":J
    .restart local v4    # "httpResponse":Lcom/amazonaws/http/HttpResponse;
    .restart local v5    # "retriedException":Lcom/amazonaws/AmazonClientException;
    .restart local v6    # "signer":Lcom/amazonaws/auth/Signer;
    .restart local v10    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v12    # "originalHeaders":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .restart local v13    # "originalContent":Ljava/io/InputStream;
    .restart local v14    # "credentials":Lcom/amazonaws/auth/AWSCredentials;
    .restart local v15    # "redirectedURI":Ljava/net/URI;
    .restart local v16    # "httpRequest":Lcom/amazonaws/http/HttpRequest;
    .restart local v20    # "originalParameters":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .restart local v24    # "requestCount":I
    .restart local p1    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<*>;"
    .restart local p2    # "responseHandler":Lcom/amazonaws/http/HttpResponseHandler;, "Lcom/amazonaws/http/HttpResponseHandler<Lcom/amazonaws/AmazonWebServiceResponse<TT;>;>;"
    .restart local p3    # "errorResponseHandler":Lcom/amazonaws/http/HttpResponseHandler;, "Lcom/amazonaws/http/HttpResponseHandler<Lcom/amazonaws/AmazonServiceException;>;"
    .restart local p4    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    :catchall_16
    move-exception v0

    move-object v11, v0

    goto/16 :goto_11

    .line 447
    .end local v1    # "leaveHttpConnectionOpen":Z
    .end local v20    # "originalParameters":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .end local v24    # "requestCount":I
    .local v4, "requestCount":I
    .restart local v11    # "originalParameters":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .restart local v17    # "leaveHttpConnectionOpen":Z
    .restart local v18    # "httpResponse":Lcom/amazonaws/http/HttpResponse;
    :catch_3c
    move-exception v0

    move-object v9, v1

    move-wide/from16 v21, v2

    move/from16 v24, v4

    move-object/from16 v19, v5

    move-object/from16 v20, v11

    move-object v11, v6

    move-object/from16 v26, v19

    move-object/from16 v19, v16

    move-object/from16 v16, v26

    .line 448
    .end local v2    # "lastBackoffDelay":J
    .end local v4    # "requestCount":I
    .end local v5    # "retriedException":Lcom/amazonaws/AmazonClientException;
    .end local v6    # "signer":Lcom/amazonaws/auth/Signer;
    .local v0, "ioe":Ljava/io/IOException;
    .local v11, "signer":Lcom/amazonaws/auth/Signer;
    .local v16, "retriedException":Lcom/amazonaws/AmazonClientException;
    .local v19, "httpRequest":Lcom/amazonaws/http/HttpRequest;
    .restart local v20    # "originalParameters":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .restart local v21    # "lastBackoffDelay":J
    .restart local v24    # "requestCount":I
    :goto_e
    :try_start_22
    sget-object v1, Lcom/amazonaws/http/AmazonHttpClient;->log:Lcom/amazonaws/logging/Log;

    invoke-interface {v1}, Lcom/amazonaws/logging/Log;->isDebugEnabled()Z

    move-result v1
    :try_end_22
    .catchall {:try_start_22 .. :try_end_22} :catchall_18

    const-string v2, "Unable to execute HTTP request: "

    if-eqz v1, :cond_10

    .line 449
    :try_start_23
    sget-object v1, Lcom/amazonaws/http/AmazonHttpClient;->log:Lcom/amazonaws/logging/Log;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v0}, Ljava/io/IOException;->getMessage()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-interface {v1, v3, v0}, Lcom/amazonaws/logging/Log;->debug(Ljava/lang/Object;Ljava/lang/Throwable;)V

    .line 451
    :cond_10
    sget-object v1, Lcom/amazonaws/util/AWSRequestMetrics$Field;->Exception:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v10, v1}, Lcom/amazonaws/util/AWSRequestMetrics;->incrementCounter(Lcom/amazonaws/metrics/MetricType;)V

    .line 452
    sget-object v1, Lcom/amazonaws/util/AWSRequestMetrics$Field;->Exception:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v10, v1, v0}, Lcom/amazonaws/util/AWSRequestMetrics;->addProperty(Lcom/amazonaws/metrics/MetricType;Ljava/lang/Object;)V

    .line 453
    sget-object v1, Lcom/amazonaws/util/AWSRequestMetrics$Field;->AWSRequestID:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    const/4 v3, 0x0

    invoke-virtual {v10, v1, v3}, Lcom/amazonaws/util/AWSRequestMetrics;->addProperty(Lcom/amazonaws/metrics/MetricType;Ljava/lang/Object;)V

    .line 455
    new-instance v1, Lcom/amazonaws/AmazonClientException;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    .line 456
    invoke-virtual {v0}, Ljava/io/IOException;->getMessage()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2, v0}, Lcom/amazonaws/AmazonClientException;-><init>(Ljava/lang/String;Ljava/lang/Throwable;)V

    move-object/from16 v23, v1

    .line 457
    .local v23, "ace":Lcom/amazonaws/AmazonClientException;
    invoke-interface/range {p1 .. p1}, Lcom/amazonaws/Request;->getOriginalRequest()Lcom/amazonaws/AmazonWebServiceRequest;

    move-result-object v2

    .line 458
    invoke-virtual/range {v19 .. v19}, Lcom/amazonaws/http/HttpRequest;->getContent()Ljava/io/InputStream;

    move-result-object v3

    iget-object v1, v7, Lcom/amazonaws/http/AmazonHttpClient;->config:Lcom/amazonaws/ClientConfiguration;

    .line 461
    invoke-virtual {v1}, Lcom/amazonaws/ClientConfiguration;->getRetryPolicy()Lcom/amazonaws/retry/RetryPolicy;

    move-result-object v6

    .line 457
    move-object/from16 v1, p0

    move-object/from16 v4, v23

    move/from16 v5, v24

    invoke-direct/range {v1 .. v6}, Lcom/amazonaws/http/AmazonHttpClient;->shouldRetry(Lcom/amazonaws/AmazonWebServiceRequest;Ljava/io/InputStream;Lcom/amazonaws/AmazonClientException;ILcom/amazonaws/retry/RetryPolicy;)Z

    move-result v1
    :try_end_23
    .catchall {:try_start_23 .. :try_end_23} :catchall_18

    if-eqz v1, :cond_13

    .line 466
    move-object/from16 v5, v23

    .line 467
    .end local v16    # "retriedException":Lcom/amazonaws/AmazonClientException;
    .restart local v5    # "retriedException":Lcom/amazonaws/AmazonClientException;
    :try_start_24
    invoke-virtual {v7, v8, v0}, Lcom/amazonaws/http/AmazonHttpClient;->resetRequestAfterError(Lcom/amazonaws/Request;Ljava/lang/Exception;)V
    :try_end_24
    .catchall {:try_start_24 .. :try_end_24} :catchall_17

    .line 480
    .end local v0    # "ioe":Ljava/io/IOException;
    .end local v23    # "ace":Lcom/amazonaws/AmazonClientException;
    if-nez v17, :cond_12

    if-eqz v18, :cond_12

    .line 482
    :try_start_25
    invoke-virtual/range {v18 .. v18}, Lcom/amazonaws/http/HttpResponse;->getRawContent()Ljava/io/InputStream;

    move-result-object v0

    if-eqz v0, :cond_11

    .line 483
    invoke-virtual/range {v18 .. v18}, Lcom/amazonaws/http/HttpResponse;->getRawContent()Ljava/io/InputStream;

    move-result-object v0

    invoke-virtual {v0}, Ljava/io/InputStream;->close()V
    :try_end_25
    .catch Ljava/io/IOException; {:try_start_25 .. :try_end_25} :catch_3d

    goto :goto_f

    .line 485
    :catch_3d
    move-exception v0

    .line 486
    .local v0, "e":Ljava/io/IOException;
    sget-object v1, Lcom/amazonaws/http/AmazonHttpClient;->log:Lcom/amazonaws/logging/Log;

    invoke-interface {v1, v9, v0}, Lcom/amazonaws/logging/Log;->warn(Ljava/lang/Object;Ljava/lang/Throwable;)V

    .line 487
    .end local v0    # "e":Ljava/io/IOException;
    :cond_11
    :goto_f
    nop

    .line 489
    :cond_12
    move-object v6, v11

    move/from16 v1, v17

    move-object/from16 v4, v18

    move-object/from16 v16, v19

    move-wide/from16 v2, v21

    .end local v11    # "signer":Lcom/amazonaws/auth/Signer;
    .end local v17    # "leaveHttpConnectionOpen":Z
    .end local v18    # "httpResponse":Lcom/amazonaws/http/HttpResponse;
    .end local v19    # "httpRequest":Lcom/amazonaws/http/HttpRequest;
    .end local v21    # "lastBackoffDelay":J
    .restart local v1    # "leaveHttpConnectionOpen":Z
    .restart local v2    # "lastBackoffDelay":J
    .local v4, "httpResponse":Lcom/amazonaws/http/HttpResponse;
    .restart local v6    # "signer":Lcom/amazonaws/auth/Signer;
    .local v16, "httpRequest":Lcom/amazonaws/http/HttpRequest;
    :goto_10
    move-object/from16 v9, p4

    move-object/from16 v11, v20

    move/from16 v0, v24

    goto/16 :goto_0

    .line 480
    .end local v1    # "leaveHttpConnectionOpen":Z
    .end local v2    # "lastBackoffDelay":J
    .end local v4    # "httpResponse":Lcom/amazonaws/http/HttpResponse;
    .end local v6    # "signer":Lcom/amazonaws/auth/Signer;
    .end local v16    # "httpRequest":Lcom/amazonaws/http/HttpRequest;
    .restart local v11    # "signer":Lcom/amazonaws/auth/Signer;
    .restart local v17    # "leaveHttpConnectionOpen":Z
    .restart local v18    # "httpResponse":Lcom/amazonaws/http/HttpResponse;
    .restart local v19    # "httpRequest":Lcom/amazonaws/http/HttpRequest;
    .restart local v21    # "lastBackoffDelay":J
    :catchall_17
    move-exception v0

    move-object v6, v11

    move/from16 v1, v17

    move-object/from16 v4, v18

    move-object/from16 v16, v19

    move-wide/from16 v2, v21

    move-object v11, v0

    goto :goto_11

    .line 462
    .end local v5    # "retriedException":Lcom/amazonaws/AmazonClientException;
    .local v0, "ioe":Ljava/io/IOException;
    .local v16, "retriedException":Lcom/amazonaws/AmazonClientException;
    .restart local v23    # "ace":Lcom/amazonaws/AmazonClientException;
    :cond_13
    nop

    .end local v10    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .end local v11    # "signer":Lcom/amazonaws/auth/Signer;
    .end local v12    # "originalHeaders":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .end local v13    # "originalContent":Ljava/io/InputStream;
    .end local v14    # "credentials":Lcom/amazonaws/auth/AWSCredentials;
    .end local v15    # "redirectedURI":Ljava/net/URI;
    .end local v16    # "retriedException":Lcom/amazonaws/AmazonClientException;
    .end local v17    # "leaveHttpConnectionOpen":Z
    .end local v18    # "httpResponse":Lcom/amazonaws/http/HttpResponse;
    .end local v19    # "httpRequest":Lcom/amazonaws/http/HttpRequest;
    .end local v20    # "originalParameters":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .end local v21    # "lastBackoffDelay":J
    .end local v24    # "requestCount":I
    .end local p1    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<*>;"
    .end local p2    # "responseHandler":Lcom/amazonaws/http/HttpResponseHandler;, "Lcom/amazonaws/http/HttpResponseHandler<Lcom/amazonaws/AmazonWebServiceResponse<TT;>;>;"
    .end local p3    # "errorResponseHandler":Lcom/amazonaws/http/HttpResponseHandler;, "Lcom/amazonaws/http/HttpResponseHandler<Lcom/amazonaws/AmazonServiceException;>;"
    .end local p4    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    :try_start_26
    throw v23
    :try_end_26
    .catchall {:try_start_26 .. :try_end_26} :catchall_18

    .line 480
    .end local v0    # "ioe":Ljava/io/IOException;
    .end local v23    # "ace":Lcom/amazonaws/AmazonClientException;
    .restart local v10    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local v11    # "signer":Lcom/amazonaws/auth/Signer;
    .restart local v12    # "originalHeaders":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .restart local v13    # "originalContent":Ljava/io/InputStream;
    .restart local v14    # "credentials":Lcom/amazonaws/auth/AWSCredentials;
    .restart local v15    # "redirectedURI":Ljava/net/URI;
    .restart local v16    # "retriedException":Lcom/amazonaws/AmazonClientException;
    .restart local v17    # "leaveHttpConnectionOpen":Z
    .restart local v18    # "httpResponse":Lcom/amazonaws/http/HttpResponse;
    .restart local v19    # "httpRequest":Lcom/amazonaws/http/HttpRequest;
    .restart local v20    # "originalParameters":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    .restart local v21    # "lastBackoffDelay":J
    .restart local v24    # "requestCount":I
    .restart local p1    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<*>;"
    .restart local p2    # "responseHandler":Lcom/amazonaws/http/HttpResponseHandler;, "Lcom/amazonaws/http/HttpResponseHandler<Lcom/amazonaws/AmazonWebServiceResponse<TT;>;>;"
    .restart local p3    # "errorResponseHandler":Lcom/amazonaws/http/HttpResponseHandler;, "Lcom/amazonaws/http/HttpResponseHandler<Lcom/amazonaws/AmazonServiceException;>;"
    .restart local p4    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    :catchall_18
    move-exception v0

    move-object v6, v11

    move-object/from16 v5, v16

    move/from16 v1, v17

    move-object/from16 v4, v18

    move-object/from16 v16, v19

    move-wide/from16 v2, v21

    move-object v11, v0

    .end local v11    # "signer":Lcom/amazonaws/auth/Signer;
    .end local v17    # "leaveHttpConnectionOpen":Z
    .end local v18    # "httpResponse":Lcom/amazonaws/http/HttpResponse;
    .end local v19    # "httpRequest":Lcom/amazonaws/http/HttpRequest;
    .end local v21    # "lastBackoffDelay":J
    .restart local v1    # "leaveHttpConnectionOpen":Z
    .restart local v2    # "lastBackoffDelay":J
    .restart local v4    # "httpResponse":Lcom/amazonaws/http/HttpResponse;
    .restart local v5    # "retriedException":Lcom/amazonaws/AmazonClientException;
    .restart local v6    # "signer":Lcom/amazonaws/auth/Signer;
    .local v16, "httpRequest":Lcom/amazonaws/http/HttpRequest;
    :goto_11
    if-nez v1, :cond_15

    if-eqz v4, :cond_15

    .line 482
    :try_start_27
    invoke-virtual {v4}, Lcom/amazonaws/http/HttpResponse;->getRawContent()Ljava/io/InputStream;

    move-result-object v0

    if-eqz v0, :cond_14

    .line 483
    invoke-virtual {v4}, Lcom/amazonaws/http/HttpResponse;->getRawContent()Ljava/io/InputStream;

    move-result-object v0

    invoke-virtual {v0}, Ljava/io/InputStream;->close()V
    :try_end_27
    .catch Ljava/io/IOException; {:try_start_27 .. :try_end_27} :catch_3e

    .line 487
    :cond_14
    move/from16 v17, v1

    goto :goto_12

    .line 485
    :catch_3e
    move-exception v0

    .line 486
    .local v0, "e":Ljava/io/IOException;
    move/from16 v17, v1

    .end local v1    # "leaveHttpConnectionOpen":Z
    .restart local v17    # "leaveHttpConnectionOpen":Z
    sget-object v1, Lcom/amazonaws/http/AmazonHttpClient;->log:Lcom/amazonaws/logging/Log;

    invoke-interface {v1, v9, v0}, Lcom/amazonaws/logging/Log;->warn(Ljava/lang/Object;Ljava/lang/Throwable;)V

    goto :goto_12

    .line 480
    .end local v0    # "e":Ljava/io/IOException;
    .end local v17    # "leaveHttpConnectionOpen":Z
    .restart local v1    # "leaveHttpConnectionOpen":Z
    :cond_15
    move/from16 v17, v1

    .line 489
    .end local v1    # "leaveHttpConnectionOpen":Z
    .restart local v17    # "leaveHttpConnectionOpen":Z
    :goto_12
    throw v11
.end method

.method protected finalize()V
    .locals 0
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Throwable;
        }
    .end annotation

    .line 835
    invoke-virtual {p0}, Lcom/amazonaws/http/AmazonHttpClient;->shutdown()V

    .line 836
    invoke-super {p0}, Ljava/lang/Object;->finalize()V

    .line 837
    return-void
.end method

.method public getRequestMetricCollector()Lcom/amazonaws/metrics/RequestMetricCollector;
    .locals 1

    .line 844
    iget-object v0, p0, Lcom/amazonaws/http/AmazonHttpClient;->requestMetricCollector:Lcom/amazonaws/metrics/RequestMetricCollector;

    return-object v0
.end method

.method public getResponseMetadataForRequest(Lcom/amazonaws/AmazonWebServiceRequest;)Lcom/amazonaws/ResponseMetadata;
    .locals 1
    .param p1, "request"    # Lcom/amazonaws/AmazonWebServiceRequest;
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 187
    const/4 v0, 0x0

    return-object v0
.end method

.method handleErrorResponse(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/HttpResponse;)Lcom/amazonaws/AmazonServiceException;
    .locals 6
    .param p3, "response"    # Lcom/amazonaws/http/HttpResponse;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/amazonaws/Request<",
            "*>;",
            "Lcom/amazonaws/http/HttpResponseHandler<",
            "Lcom/amazonaws/AmazonServiceException;",
            ">;",
            "Lcom/amazonaws/http/HttpResponse;",
            ")",
            "Lcom/amazonaws/AmazonServiceException;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 707
    .local p1, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<*>;"
    .local p2, "errorResponseHandler":Lcom/amazonaws/http/HttpResponseHandler;, "Lcom/amazonaws/http/HttpResponseHandler<Lcom/amazonaws/AmazonServiceException;>;"
    invoke-virtual {p3}, Lcom/amazonaws/http/HttpResponse;->getStatusCode()I

    move-result v0

    .line 709
    .local v0, "status":I
    const/4 v1, 0x0

    .line 711
    .local v1, "exception":Lcom/amazonaws/AmazonServiceException;
    :try_start_0
    invoke-interface {p2, p3}, Lcom/amazonaws/http/HttpResponseHandler;->handle(Lcom/amazonaws/http/HttpResponse;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/amazonaws/AmazonServiceException;

    move-object v1, v2

    .line 712
    sget-object v2, Lcom/amazonaws/http/AmazonHttpClient;->REQUEST_LOG:Lcom/amazonaws/logging/Log;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "Received error response: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v1}, Lcom/amazonaws/AmazonServiceException;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-interface {v2, v3}, Lcom/amazonaws/logging/Log;->debug(Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 738
    goto :goto_0

    .line 713
    :catch_0
    move-exception v2

    .line 716
    .local v2, "e":Ljava/lang/Exception;
    const/16 v3, 0x19d

    if-ne v0, v3, :cond_0

    .line 717
    new-instance v4, Lcom/amazonaws/AmazonServiceException;

    const-string v5, "Request entity too large"

    invoke-direct {v4, v5}, Lcom/amazonaws/AmazonServiceException;-><init>(Ljava/lang/String;)V

    move-object v1, v4

    .line 718
    invoke-interface {p1}, Lcom/amazonaws/Request;->getServiceName()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v1, v4}, Lcom/amazonaws/AmazonServiceException;->setServiceName(Ljava/lang/String;)V

    .line 719
    invoke-virtual {v1, v3}, Lcom/amazonaws/AmazonServiceException;->setStatusCode(I)V

    .line 720
    sget-object v3, Lcom/amazonaws/AmazonServiceException$ErrorType;->Client:Lcom/amazonaws/AmazonServiceException$ErrorType;

    invoke-virtual {v1, v3}, Lcom/amazonaws/AmazonServiceException;->setErrorType(Lcom/amazonaws/AmazonServiceException$ErrorType;)V

    .line 721
    invoke-virtual {v1, v5}, Lcom/amazonaws/AmazonServiceException;->setErrorCode(Ljava/lang/String;)V

    goto :goto_0

    .line 722
    :cond_0
    const/16 v3, 0x1f7

    if-ne v0, v3, :cond_1

    .line 723
    invoke-virtual {p3}, Lcom/amazonaws/http/HttpResponse;->getStatusText()Ljava/lang/String;

    move-result-object v4

    const-string v5, "Service Unavailable"

    invoke-virtual {v5, v4}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_1

    .line 724
    new-instance v4, Lcom/amazonaws/AmazonServiceException;

    const-string v5, "Service unavailable"

    invoke-direct {v4, v5}, Lcom/amazonaws/AmazonServiceException;-><init>(Ljava/lang/String;)V

    move-object v1, v4

    .line 725
    invoke-interface {p1}, Lcom/amazonaws/Request;->getServiceName()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v1, v4}, Lcom/amazonaws/AmazonServiceException;->setServiceName(Ljava/lang/String;)V

    .line 726
    invoke-virtual {v1, v3}, Lcom/amazonaws/AmazonServiceException;->setStatusCode(I)V

    .line 727
    sget-object v3, Lcom/amazonaws/AmazonServiceException$ErrorType;->Service:Lcom/amazonaws/AmazonServiceException$ErrorType;

    invoke-virtual {v1, v3}, Lcom/amazonaws/AmazonServiceException;->setErrorType(Lcom/amazonaws/AmazonServiceException$ErrorType;)V

    .line 728
    invoke-virtual {v1, v5}, Lcom/amazonaws/AmazonServiceException;->setErrorCode(Ljava/lang/String;)V

    .line 740
    .end local v2    # "e":Ljava/lang/Exception;
    :goto_0
    invoke-virtual {v1, v0}, Lcom/amazonaws/AmazonServiceException;->setStatusCode(I)V

    .line 741
    invoke-interface {p1}, Lcom/amazonaws/Request;->getServiceName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Lcom/amazonaws/AmazonServiceException;->setServiceName(Ljava/lang/String;)V

    .line 742
    invoke-virtual {v1}, Lcom/amazonaws/AmazonServiceException;->fillInStackTrace()Ljava/lang/Throwable;

    .line 743
    return-object v1

    .line 729
    .restart local v2    # "e":Ljava/lang/Exception;
    :cond_1
    instance-of v3, v2, Ljava/io/IOException;

    if-eqz v3, :cond_2

    .line 730
    move-object v3, v2

    check-cast v3, Ljava/io/IOException;

    throw v3

    .line 732
    :cond_2
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "Unable to unmarshall error response ("

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v2}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "). Response Code: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, ", Response Text: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    .line 734
    invoke-virtual {p3}, Lcom/amazonaws/http/HttpResponse;->getStatusText()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, ", Response Headers: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    .line 735
    invoke-virtual {p3}, Lcom/amazonaws/http/HttpResponse;->getHeaders()Ljava/util/Map;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    .line 736
    .local v3, "errorMessage":Ljava/lang/String;
    new-instance v4, Lcom/amazonaws/AmazonClientException;

    invoke-direct {v4, v3, v2}, Lcom/amazonaws/AmazonClientException;-><init>(Ljava/lang/String;Ljava/lang/Throwable;)V

    throw v4
.end method

.method handleResponse(Lcom/amazonaws/Request;Lcom/amazonaws/http/HttpResponseHandler;Lcom/amazonaws/http/HttpResponse;Lcom/amazonaws/http/ExecutionContext;)Ljava/lang/Object;
    .locals 6
    .param p3, "response"    # Lcom/amazonaws/http/HttpResponse;
    .param p4, "executionContext"    # Lcom/amazonaws/http/ExecutionContext;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Ljava/lang/Object;",
            ">(",
            "Lcom/amazonaws/Request<",
            "*>;",
            "Lcom/amazonaws/http/HttpResponseHandler<",
            "Lcom/amazonaws/AmazonWebServiceResponse<",
            "TT;>;>;",
            "Lcom/amazonaws/http/HttpResponse;",
            "Lcom/amazonaws/http/ExecutionContext;",
            ")TT;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 657
    .local p1, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<*>;"
    .local p2, "responseHandler":Lcom/amazonaws/http/HttpResponseHandler;, "Lcom/amazonaws/http/HttpResponseHandler<Lcom/amazonaws/AmazonWebServiceResponse<TT;>;>;"
    const-string v0, ", Response Text: "

    :try_start_0
    invoke-virtual {p4}, Lcom/amazonaws/http/ExecutionContext;->getAwsRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    .line 659
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    sget-object v2, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ResponseProcessingTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v2}, Lcom/amazonaws/util/AWSRequestMetrics;->startEvent(Lcom/amazonaws/metrics/MetricType;)V
    :try_end_0
    .catch Lcom/amazonaws/internal/CRC32MismatchException; {:try_start_0 .. :try_end_0} :catch_2
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 661
    :try_start_1
    invoke-interface {p2, p3}, Lcom/amazonaws/http/HttpResponseHandler;->handle(Lcom/amazonaws/http/HttpResponse;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/amazonaws/AmazonWebServiceResponse;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 663
    .local v2, "awsResponse":Lcom/amazonaws/AmazonWebServiceResponse;, "Lcom/amazonaws/AmazonWebServiceResponse<+TT;>;"
    :try_start_2
    sget-object v3, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ResponseProcessingTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v3}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 664
    nop

    .line 666
    if-eqz v2, :cond_1

    .line 673
    sget-object v3, Lcom/amazonaws/http/AmazonHttpClient;->REQUEST_LOG:Lcom/amazonaws/logging/Log;

    invoke-interface {v3}, Lcom/amazonaws/logging/Log;->isDebugEnabled()Z

    move-result v3

    if-eqz v3, :cond_0

    .line 674
    sget-object v3, Lcom/amazonaws/http/AmazonHttpClient;->REQUEST_LOG:Lcom/amazonaws/logging/Log;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "Received successful response: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {p3}, Lcom/amazonaws/http/HttpResponse;->getStatusCode()I

    move-result v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, ", AWS Request ID: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    .line 675
    invoke-virtual {v2}, Lcom/amazonaws/AmazonWebServiceResponse;->getRequestId()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    .line 674
    invoke-interface {v3, v4}, Lcom/amazonaws/logging/Log;->debug(Ljava/lang/Object;)V

    .line 677
    :cond_0
    sget-object v3, Lcom/amazonaws/util/AWSRequestMetrics$Field;->AWSRequestID:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v2}, Lcom/amazonaws/AmazonWebServiceResponse;->getRequestId()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v1, v3, v4}, Lcom/amazonaws/util/AWSRequestMetrics;->addProperty(Lcom/amazonaws/metrics/MetricType;Ljava/lang/Object;)V

    .line 679
    invoke-virtual {v2}, Lcom/amazonaws/AmazonWebServiceResponse;->getResult()Ljava/lang/Object;

    move-result-object v0

    return-object v0

    .line 667
    :cond_1
    new-instance v3, Ljava/lang/RuntimeException;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "Unable to unmarshall response metadata. Response Code: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    .line 669
    invoke-virtual {p3}, Lcom/amazonaws/http/HttpResponse;->getStatusCode()I

    move-result v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    .line 670
    invoke-virtual {p3}, Lcom/amazonaws/http/HttpResponse;->getStatusText()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-direct {v3, v4}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;)V

    .end local p1    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<*>;"
    .end local p2    # "responseHandler":Lcom/amazonaws/http/HttpResponseHandler;, "Lcom/amazonaws/http/HttpResponseHandler<Lcom/amazonaws/AmazonWebServiceResponse<TT;>;>;"
    .end local p3    # "response":Lcom/amazonaws/http/HttpResponse;
    .end local p4    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    throw v3

    .line 663
    .end local v2    # "awsResponse":Lcom/amazonaws/AmazonWebServiceResponse;, "Lcom/amazonaws/AmazonWebServiceResponse<+TT;>;"
    .restart local p1    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<*>;"
    .restart local p2    # "responseHandler":Lcom/amazonaws/http/HttpResponseHandler;, "Lcom/amazonaws/http/HttpResponseHandler<Lcom/amazonaws/AmazonWebServiceResponse<TT;>;>;"
    .restart local p3    # "response":Lcom/amazonaws/http/HttpResponse;
    .restart local p4    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    :catchall_0
    move-exception v2

    sget-object v3, Lcom/amazonaws/util/AWSRequestMetrics$Field;->ResponseProcessingTime:Lcom/amazonaws/util/AWSRequestMetrics$Field;

    invoke-virtual {v1, v3}, Lcom/amazonaws/util/AWSRequestMetrics;->endEvent(Lcom/amazonaws/metrics/MetricType;)V

    .line 664
    nop

    .end local p1    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<*>;"
    .end local p2    # "responseHandler":Lcom/amazonaws/http/HttpResponseHandler;, "Lcom/amazonaws/http/HttpResponseHandler<Lcom/amazonaws/AmazonWebServiceResponse<TT;>;>;"
    .end local p3    # "response":Lcom/amazonaws/http/HttpResponse;
    .end local p4    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    throw v2
    :try_end_2
    .catch Lcom/amazonaws/internal/CRC32MismatchException; {:try_start_2 .. :try_end_2} :catch_2
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_1
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_0

    .line 684
    .end local v1    # "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    .restart local p1    # "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<*>;"
    .restart local p2    # "responseHandler":Lcom/amazonaws/http/HttpResponseHandler;, "Lcom/amazonaws/http/HttpResponseHandler<Lcom/amazonaws/AmazonWebServiceResponse<TT;>;>;"
    .restart local p3    # "response":Lcom/amazonaws/http/HttpResponse;
    .restart local p4    # "executionContext":Lcom/amazonaws/http/ExecutionContext;
    :catch_0
    move-exception v1

    .line 685
    .local v1, "e":Ljava/lang/Exception;
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Unable to unmarshall response ("

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v1}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "). Response Code: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    .line 687
    invoke-virtual {p3}, Lcom/amazonaws/http/HttpResponse;->getStatusCode()I

    move-result v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {p3}, Lcom/amazonaws/http/HttpResponse;->getStatusText()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 688
    .local v0, "errorMessage":Ljava/lang/String;
    new-instance v2, Lcom/amazonaws/AmazonClientException;

    invoke-direct {v2, v0, v1}, Lcom/amazonaws/AmazonClientException;-><init>(Ljava/lang/String;Ljava/lang/Throwable;)V

    throw v2

    .line 682
    .end local v0    # "errorMessage":Ljava/lang/String;
    .end local v1    # "e":Ljava/lang/Exception;
    :catch_1
    move-exception v0

    .line 683
    .local v0, "e":Ljava/io/IOException;
    throw v0

    .line 680
    .end local v0    # "e":Ljava/io/IOException;
    :catch_2
    move-exception v0

    .line 681
    .local v0, "e":Lcom/amazonaws/internal/CRC32MismatchException;
    throw v0
.end method

.method parseClockSkewOffset(Lcom/amazonaws/http/HttpResponse;Lcom/amazonaws/AmazonServiceException;)I
    .locals 8
    .param p1, "response"    # Lcom/amazonaws/http/HttpResponse;
    .param p2, "exception"    # Lcom/amazonaws/AmazonServiceException;

    .line 807
    new-instance v0, Ljava/util/Date;

    invoke-direct {v0}, Ljava/util/Date;-><init>()V

    .line 808
    .local v0, "deviceDate":Ljava/util/Date;
    const/4 v1, 0x0

    .line 809
    .local v1, "serverDate":Ljava/util/Date;
    const/4 v2, 0x0

    .line 810
    .local v2, "serverDateStr":Ljava/lang/String;
    invoke-virtual {p1}, Lcom/amazonaws/http/HttpResponse;->getHeaders()Ljava/util/Map;

    move-result-object v3

    const-string v4, "Date"

    invoke-interface {v3, v4}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/String;

    .line 814
    .local v3, "responseDateHeader":Ljava/lang/String;
    if-eqz v3, :cond_1

    :try_start_0
    invoke-virtual {v3}, Ljava/lang/String;->isEmpty()Z

    move-result v4

    if-eqz v4, :cond_0

    goto :goto_0

    .line 819
    :cond_0
    move-object v2, v3

    .line 820
    invoke-static {v2}, Lcom/amazonaws/util/DateUtils;->parseRFC822Date(Ljava/lang/String;)Ljava/util/Date;

    move-result-object v4

    move-object v1, v4

    goto :goto_1

    .line 816
    :cond_1
    :goto_0
    invoke-virtual {p2}, Lcom/amazonaws/AmazonServiceException;->getMessage()Ljava/lang/String;

    move-result-object v4

    invoke-direct {p0, v4}, Lcom/amazonaws/http/AmazonHttpClient;->getServerDateFromException(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    move-object v2, v4

    .line 817
    invoke-static {v2}, Lcom/amazonaws/util/DateUtils;->parseCompressedISO8601Date(Ljava/lang/String;)Ljava/util/Date;

    move-result-object v4
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    move-object v1, v4

    .line 827
    :goto_1
    nop

    .line 829
    invoke-virtual {v0}, Ljava/util/Date;->getTime()J

    move-result-wide v4

    invoke-virtual {v1}, Ljava/util/Date;->getTime()J

    move-result-wide v6

    sub-long/2addr v4, v6

    .line 830
    .local v4, "diff":J
    const-wide/16 v6, 0x3e8

    div-long v6, v4, v6

    long-to-int v6, v6

    return v6

    .line 822
    .end local v4    # "diff":J
    :catch_0
    move-exception v4

    .line 823
    .local v4, "e":Ljava/lang/RuntimeException;
    sget-object v5, Lcom/amazonaws/http/AmazonHttpClient;->log:Lcom/amazonaws/logging/Log;

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "Unable to parse clock skew offset from response: "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-interface {v5, v6, v4}, Lcom/amazonaws/logging/Log;->warn(Ljava/lang/Object;Ljava/lang/Throwable;)V

    .line 826
    const/4 v5, 0x0

    return v5
.end method

.method requestHandler2s(Lcom/amazonaws/Request;Lcom/amazonaws/http/ExecutionContext;)Ljava/util/List;
    .locals 5
    .param p2, "executionContext"    # Lcom/amazonaws/http/ExecutionContext;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/amazonaws/Request<",
            "*>;",
            "Lcom/amazonaws/http/ExecutionContext;",
            ")",
            "Ljava/util/List<",
            "Lcom/amazonaws/handlers/RequestHandler2;",
            ">;"
        }
    .end annotation

    .line 258
    .local p1, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<*>;"
    nop

    .line 259
    invoke-virtual {p2}, Lcom/amazonaws/http/ExecutionContext;->getRequestHandler2s()Ljava/util/List;

    move-result-object v0

    .line 260
    .local v0, "requestHandler2s":Ljava/util/List;, "Ljava/util/List<Lcom/amazonaws/handlers/RequestHandler2;>;"
    if-nez v0, :cond_0

    .line 261
    invoke-static {}, Ljava/util/Collections;->emptyList()Ljava/util/List;

    move-result-object v1

    return-object v1

    .line 265
    :cond_0
    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_2

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/amazonaws/handlers/RequestHandler2;

    .line 268
    .local v2, "requestHandler2":Lcom/amazonaws/handlers/RequestHandler2;
    instance-of v3, v2, Lcom/amazonaws/handlers/CredentialsRequestHandler;

    if-eqz v3, :cond_1

    .line 269
    move-object v3, v2

    check-cast v3, Lcom/amazonaws/handlers/CredentialsRequestHandler;

    .line 270
    invoke-virtual {p2}, Lcom/amazonaws/http/ExecutionContext;->getCredentials()Lcom/amazonaws/auth/AWSCredentials;

    move-result-object v4

    invoke-virtual {v3, v4}, Lcom/amazonaws/handlers/CredentialsRequestHandler;->setCredentials(Lcom/amazonaws/auth/AWSCredentials;)V

    .line 272
    :cond_1
    invoke-virtual {v2, p1}, Lcom/amazonaws/handlers/RequestHandler2;->beforeRequest(Lcom/amazonaws/Request;)V

    .line 273
    .end local v2    # "requestHandler2":Lcom/amazonaws/handlers/RequestHandler2;
    goto :goto_0

    .line 274
    :cond_2
    return-object v0
.end method

.method resetRequestAfterError(Lcom/amazonaws/Request;Ljava/lang/Exception;)V
    .locals 3
    .param p2, "cause"    # Ljava/lang/Exception;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/amazonaws/Request<",
            "*>;",
            "Ljava/lang/Exception;",
            ")V"
        }
    .end annotation

    .line 514
    .local p1, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<*>;"
    invoke-interface {p1}, Lcom/amazonaws/Request;->getContent()Ljava/io/InputStream;

    move-result-object v0

    if-nez v0, :cond_0

    .line 515
    return-void

    .line 517
    :cond_0
    invoke-interface {p1}, Lcom/amazonaws/Request;->getContent()Ljava/io/InputStream;

    move-result-object v0

    invoke-virtual {v0}, Ljava/io/InputStream;->markSupported()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 522
    :try_start_0
    invoke-interface {p1}, Lcom/amazonaws/Request;->getContent()Ljava/io/InputStream;

    move-result-object v0

    invoke-virtual {v0}, Ljava/io/InputStream;->reset()V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 528
    nop

    .line 529
    return-void

    .line 523
    :catch_0
    move-exception v0

    .line 526
    .local v0, "e":Ljava/io/IOException;
    new-instance v1, Lcom/amazonaws/AmazonClientException;

    const-string v2, "Encountered an exception and couldn\'t reset the stream to retry"

    invoke-direct {v1, v2, p2}, Lcom/amazonaws/AmazonClientException;-><init>(Ljava/lang/String;Ljava/lang/Throwable;)V

    throw v1

    .line 518
    .end local v0    # "e":Ljava/io/IOException;
    :cond_1
    new-instance v0, Lcom/amazonaws/AmazonClientException;

    const-string v1, "Encountered an exception and stream is not resettable"

    invoke-direct {v0, v1, p2}, Lcom/amazonaws/AmazonClientException;-><init>(Ljava/lang/String;Ljava/lang/Throwable;)V

    throw v0
.end method

.method setUserAgent(Lcom/amazonaws/Request;)V
    .locals 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/amazonaws/Request<",
            "*>;)V"
        }
    .end annotation

    .line 536
    .local p1, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<*>;"
    sget-object v0, Lcom/amazonaws/ClientConfiguration;->DEFAULT_USER_AGENT:Ljava/lang/String;

    .line 538
    .local v0, "userAgent":Ljava/lang/String;
    invoke-interface {p1}, Lcom/amazonaws/Request;->getOriginalRequest()Lcom/amazonaws/AmazonWebServiceRequest;

    move-result-object v1

    .line 539
    .local v1, "awsreq":Lcom/amazonaws/AmazonWebServiceRequest;
    if-eqz v1, :cond_0

    .line 540
    invoke-virtual {v1}, Lcom/amazonaws/AmazonWebServiceRequest;->getRequestClientOptions()Lcom/amazonaws/RequestClientOptions;

    move-result-object v2

    .line 541
    .local v2, "opts":Lcom/amazonaws/RequestClientOptions;
    if-eqz v2, :cond_0

    .line 542
    sget-object v3, Lcom/amazonaws/RequestClientOptions$Marker;->USER_AGENT:Lcom/amazonaws/RequestClientOptions$Marker;

    invoke-virtual {v2, v3}, Lcom/amazonaws/RequestClientOptions;->getClientMarker(Lcom/amazonaws/RequestClientOptions$Marker;)Ljava/lang/String;

    move-result-object v3

    .line 543
    .local v3, "userAgentMarker":Ljava/lang/String;
    if-eqz v3, :cond_0

    .line 544
    invoke-static {v0, v3}, Lcom/amazonaws/http/AmazonHttpClient;->createUserAgentString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 549
    .end local v2    # "opts":Lcom/amazonaws/RequestClientOptions;
    .end local v3    # "userAgentMarker":Ljava/lang/String;
    :cond_0
    sget-object v2, Lcom/amazonaws/ClientConfiguration;->DEFAULT_USER_AGENT:Ljava/lang/String;

    iget-object v3, p0, Lcom/amazonaws/http/AmazonHttpClient;->config:Lcom/amazonaws/ClientConfiguration;

    invoke-virtual {v3}, Lcom/amazonaws/ClientConfiguration;->getUserAgent()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_1

    .line 550
    iget-object v2, p0, Lcom/amazonaws/http/AmazonHttpClient;->config:Lcom/amazonaws/ClientConfiguration;

    invoke-virtual {v2}, Lcom/amazonaws/ClientConfiguration;->getUserAgent()Ljava/lang/String;

    move-result-object v2

    invoke-static {v0, v2}, Lcom/amazonaws/http/AmazonHttpClient;->createUserAgentString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 552
    :cond_1
    iget-object v2, p0, Lcom/amazonaws/http/AmazonHttpClient;->config:Lcom/amazonaws/ClientConfiguration;

    .line 553
    invoke-virtual {v2}, Lcom/amazonaws/ClientConfiguration;->getUserAgentOverride()Ljava/lang/String;

    move-result-object v2

    if-eqz v2, :cond_2

    iget-object v2, p0, Lcom/amazonaws/http/AmazonHttpClient;->config:Lcom/amazonaws/ClientConfiguration;

    invoke-virtual {v2}, Lcom/amazonaws/ClientConfiguration;->getUserAgentOverride()Ljava/lang/String;

    move-result-object v2

    goto :goto_0

    :cond_2
    move-object v2, v0

    .line 552
    :goto_0
    const-string v3, "User-Agent"

    invoke-interface {p1, v3, v2}, Lcom/amazonaws/Request;->addHeader(Ljava/lang/String;Ljava/lang/String;)V

    .line 554
    return-void
.end method

.method public shutdown()V
    .locals 1

    .line 574
    iget-object v0, p0, Lcom/amazonaws/http/AmazonHttpClient;->httpClient:Lcom/amazonaws/http/HttpClient;

    invoke-interface {v0}, Lcom/amazonaws/http/HttpClient;->shutdown()V

    .line 575
    return-void
.end method
