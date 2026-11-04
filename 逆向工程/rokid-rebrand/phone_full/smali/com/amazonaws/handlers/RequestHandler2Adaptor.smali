.class final Lcom/amazonaws/handlers/RequestHandler2Adaptor;
.super Lcom/amazonaws/handlers/RequestHandler2;
.source "RequestHandler2Adaptor.java"


# instance fields
.field private final old:Lcom/amazonaws/handlers/RequestHandler;


# direct methods
.method constructor <init>(Lcom/amazonaws/handlers/RequestHandler;)V
    .locals 1
    .param p1, "old"    # Lcom/amazonaws/handlers/RequestHandler;

    .line 32
    invoke-direct {p0}, Lcom/amazonaws/handlers/RequestHandler2;-><init>()V

    .line 33
    if-eqz p1, :cond_0

    .line 35
    iput-object p1, p0, Lcom/amazonaws/handlers/RequestHandler2Adaptor;->old:Lcom/amazonaws/handlers/RequestHandler;

    .line 36
    return-void

    .line 34
    :cond_0
    new-instance v0, Ljava/lang/IllegalArgumentException;

    invoke-direct {v0}, Ljava/lang/IllegalArgumentException;-><init>()V

    throw v0
.end method


# virtual methods
.method public afterError(Lcom/amazonaws/Request;Lcom/amazonaws/Response;Ljava/lang/Exception;)V
    .locals 1
    .param p3, "e"    # Ljava/lang/Exception;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/amazonaws/Request<",
            "*>;",
            "Lcom/amazonaws/Response<",
            "*>;",
            "Ljava/lang/Exception;",
            ")V"
        }
    .end annotation

    .line 60
    .local p1, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<*>;"
    .local p2, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<*>;"
    iget-object v0, p0, Lcom/amazonaws/handlers/RequestHandler2Adaptor;->old:Lcom/amazonaws/handlers/RequestHandler;

    invoke-interface {v0, p1, p3}, Lcom/amazonaws/handlers/RequestHandler;->afterError(Lcom/amazonaws/Request;Ljava/lang/Exception;)V

    .line 61
    return-void
.end method

.method public afterResponse(Lcom/amazonaws/Request;Lcom/amazonaws/Response;)V
    .locals 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/amazonaws/Request<",
            "*>;",
            "Lcom/amazonaws/Response<",
            "*>;)V"
        }
    .end annotation

    .line 47
    .local p1, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<*>;"
    .local p2, "response":Lcom/amazonaws/Response;, "Lcom/amazonaws/Response<*>;"
    const/4 v0, 0x0

    if-nez p1, :cond_0

    move-object v1, v0

    goto :goto_0

    .line 48
    :cond_0
    invoke-interface {p1}, Lcom/amazonaws/Request;->getAWSRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;

    move-result-object v1

    :goto_0
    nop

    .line 49
    .local v1, "awsRequestMetrics":Lcom/amazonaws/util/AWSRequestMetrics;
    if-nez p2, :cond_1

    move-object v2, v0

    goto :goto_1

    .line 50
    :cond_1
    invoke-virtual {p2}, Lcom/amazonaws/Response;->getAwsResponse()Ljava/lang/Object;

    move-result-object v2

    :goto_1
    nop

    .line 51
    .local v2, "awsResponse":Ljava/lang/Object;
    if-nez v1, :cond_2

    goto :goto_2

    .line 52
    :cond_2
    invoke-virtual {v1}, Lcom/amazonaws/util/AWSRequestMetrics;->getTimingInfo()Lcom/amazonaws/util/TimingInfo;

    move-result-object v0

    :goto_2
    nop

    .line 53
    .local v0, "timingInfo":Lcom/amazonaws/util/TimingInfo;
    iget-object v3, p0, Lcom/amazonaws/handlers/RequestHandler2Adaptor;->old:Lcom/amazonaws/handlers/RequestHandler;

    invoke-interface {v3, p1, v2, v0}, Lcom/amazonaws/handlers/RequestHandler;->afterResponse(Lcom/amazonaws/Request;Ljava/lang/Object;Lcom/amazonaws/util/TimingInfo;)V

    .line 54
    return-void
.end method

.method public beforeRequest(Lcom/amazonaws/Request;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/amazonaws/Request<",
            "*>;)V"
        }
    .end annotation

    .line 41
    .local p1, "request":Lcom/amazonaws/Request;, "Lcom/amazonaws/Request<*>;"
    iget-object v0, p0, Lcom/amazonaws/handlers/RequestHandler2Adaptor;->old:Lcom/amazonaws/handlers/RequestHandler;

    invoke-interface {v0, p1}, Lcom/amazonaws/handlers/RequestHandler;->beforeRequest(Lcom/amazonaws/Request;)V

    .line 42
    return-void
.end method

.method public equals(Ljava/lang/Object;)Z
    .locals 3
    .param p1, "o"    # Ljava/lang/Object;

    .line 70
    instance-of v0, p1, Lcom/amazonaws/handlers/RequestHandler2Adaptor;

    if-nez v0, :cond_0

    .line 71
    const/4 v0, 0x0

    return v0

    .line 72
    :cond_0
    move-object v0, p1

    check-cast v0, Lcom/amazonaws/handlers/RequestHandler2Adaptor;

    .line 73
    .local v0, "that":Lcom/amazonaws/handlers/RequestHandler2Adaptor;
    iget-object v1, p0, Lcom/amazonaws/handlers/RequestHandler2Adaptor;->old:Lcom/amazonaws/handlers/RequestHandler;

    iget-object v2, v0, Lcom/amazonaws/handlers/RequestHandler2Adaptor;->old:Lcom/amazonaws/handlers/RequestHandler;

    invoke-virtual {v1, v2}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v1

    return v1
.end method

.method public hashCode()I
    .locals 1

    .line 65
    iget-object v0, p0, Lcom/amazonaws/handlers/RequestHandler2Adaptor;->old:Lcom/amazonaws/handlers/RequestHandler;

    invoke-virtual {v0}, Ljava/lang/Object;->hashCode()I

    move-result v0

    return v0
.end method
