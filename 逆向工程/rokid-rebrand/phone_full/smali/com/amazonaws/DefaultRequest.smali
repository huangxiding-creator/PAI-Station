.class public Lcom/amazonaws/DefaultRequest;
.super Ljava/lang/Object;
.source "DefaultRequest.java"

# interfaces
.implements Lcom/amazonaws/Request;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "<T:",
        "Ljava/lang/Object;",
        ">",
        "Ljava/lang/Object;",
        "Lcom/amazonaws/Request<",
        "TT;>;"
    }
.end annotation


# instance fields
.field private content:Ljava/io/InputStream;

.field private endpoint:Ljava/net/URI;

.field private final headers:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private hostPrefix:Ljava/lang/String;

.field private httpMethod:Lcom/amazonaws/http/HttpMethodName;

.field private metrics:Lcom/amazonaws/util/AWSRequestMetrics;

.field private final originalRequest:Lcom/amazonaws/AmazonWebServiceRequest;

.field private final parameters:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private resourcePath:Ljava/lang/String;

.field private serviceName:Ljava/lang/String;

.field private streaming:Z

.field private timeOffset:I


# direct methods
.method public constructor <init>(Lcom/amazonaws/AmazonWebServiceRequest;Ljava/lang/String;)V
    .locals 1
    .param p1, "originalRequest"    # Lcom/amazonaws/AmazonWebServiceRequest;
    .param p2, "serviceName"    # Ljava/lang/String;

    .line 88
    .local p0, "this":Lcom/amazonaws/DefaultRequest;, "Lcom/amazonaws/DefaultRequest<TT;>;"
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 39
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/amazonaws/DefaultRequest;->streaming:Z

    .line 47
    new-instance v0, Ljava/util/LinkedHashMap;

    invoke-direct {v0}, Ljava/util/LinkedHashMap;-><init>()V

    iput-object v0, p0, Lcom/amazonaws/DefaultRequest;->parameters:Ljava/util/Map;

    .line 50
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lcom/amazonaws/DefaultRequest;->headers:Ljava/util/Map;

    .line 65
    sget-object v0, Lcom/amazonaws/http/HttpMethodName;->POST:Lcom/amazonaws/http/HttpMethodName;

    iput-object v0, p0, Lcom/amazonaws/DefaultRequest;->httpMethod:Lcom/amazonaws/http/HttpMethodName;

    .line 89
    iput-object p2, p0, Lcom/amazonaws/DefaultRequest;->serviceName:Ljava/lang/String;

    .line 90
    iput-object p1, p0, Lcom/amazonaws/DefaultRequest;->originalRequest:Lcom/amazonaws/AmazonWebServiceRequest;

    .line 91
    return-void
.end method

.method public constructor <init>(Ljava/lang/String;)V
    .locals 1
    .param p1, "serviceName"    # Ljava/lang/String;

    .line 101
    .local p0, "this":Lcom/amazonaws/DefaultRequest;, "Lcom/amazonaws/DefaultRequest<TT;>;"
    const/4 v0, 0x0

    invoke-direct {p0, v0, p1}, Lcom/amazonaws/DefaultRequest;-><init>(Lcom/amazonaws/AmazonWebServiceRequest;Ljava/lang/String;)V

    .line 102
    return-void
.end method


# virtual methods
.method public addHeader(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1
    .param p1, "name"    # Ljava/lang/String;
    .param p2, "value"    # Ljava/lang/String;

    .line 121
    .local p0, "this":Lcom/amazonaws/DefaultRequest;, "Lcom/amazonaws/DefaultRequest<TT;>;"
    iget-object v0, p0, Lcom/amazonaws/DefaultRequest;->headers:Ljava/util/Map;

    invoke-interface {v0, p1, p2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 122
    return-void
.end method

.method public addParameter(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1
    .param p1, "name"    # Ljava/lang/String;
    .param p2, "value"    # Ljava/lang/String;

    .line 153
    .local p0, "this":Lcom/amazonaws/DefaultRequest;, "Lcom/amazonaws/DefaultRequest<TT;>;"
    iget-object v0, p0, Lcom/amazonaws/DefaultRequest;->parameters:Ljava/util/Map;

    invoke-interface {v0, p1, p2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 154
    return-void
.end method

.method public getAWSRequestMetrics()Lcom/amazonaws/util/AWSRequestMetrics;
    .locals 1
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 331
    .local p0, "this":Lcom/amazonaws/DefaultRequest;, "Lcom/amazonaws/DefaultRequest<TT;>;"
    iget-object v0, p0, Lcom/amazonaws/DefaultRequest;->metrics:Lcom/amazonaws/util/AWSRequestMetrics;

    return-object v0
.end method

.method public getContent()Ljava/io/InputStream;
    .locals 1

    .line 218
    .local p0, "this":Lcom/amazonaws/DefaultRequest;, "Lcom/amazonaws/DefaultRequest<TT;>;"
    iget-object v0, p0, Lcom/amazonaws/DefaultRequest;->content:Ljava/io/InputStream;

    return-object v0
.end method

.method public getEndpoint()Ljava/net/URI;
    .locals 1

    .line 202
    .local p0, "this":Lcom/amazonaws/DefaultRequest;, "Lcom/amazonaws/DefaultRequest<TT;>;"
    iget-object v0, p0, Lcom/amazonaws/DefaultRequest;->endpoint:Ljava/net/URI;

    return-object v0
.end method

.method public getHeaders()Ljava/util/Map;
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

    .line 129
    .local p0, "this":Lcom/amazonaws/DefaultRequest;, "Lcom/amazonaws/DefaultRequest<TT;>;"
    iget-object v0, p0, Lcom/amazonaws/DefaultRequest;->headers:Ljava/util/Map;

    return-object v0
.end method

.method public getHostPrefix()Ljava/lang/String;
    .locals 1

    .line 252
    .local p0, "this":Lcom/amazonaws/DefaultRequest;, "Lcom/amazonaws/DefaultRequest<TT;>;"
    iget-object v0, p0, Lcom/amazonaws/DefaultRequest;->hostPrefix:Ljava/lang/String;

    return-object v0
.end method

.method public getHttpMethod()Lcom/amazonaws/http/HttpMethodName;
    .locals 1

    .line 178
    .local p0, "this":Lcom/amazonaws/DefaultRequest;, "Lcom/amazonaws/DefaultRequest<TT;>;"
    iget-object v0, p0, Lcom/amazonaws/DefaultRequest;->httpMethod:Lcom/amazonaws/http/HttpMethodName;

    return-object v0
.end method

.method public getOriginalRequest()Lcom/amazonaws/AmazonWebServiceRequest;
    .locals 1

    .line 113
    .local p0, "this":Lcom/amazonaws/DefaultRequest;, "Lcom/amazonaws/DefaultRequest<TT;>;"
    iget-object v0, p0, Lcom/amazonaws/DefaultRequest;->originalRequest:Lcom/amazonaws/AmazonWebServiceRequest;

    return-object v0
.end method

.method public getParameters()Ljava/util/Map;
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

    .line 161
    .local p0, "this":Lcom/amazonaws/DefaultRequest;, "Lcom/amazonaws/DefaultRequest<TT;>;"
    iget-object v0, p0, Lcom/amazonaws/DefaultRequest;->parameters:Ljava/util/Map;

    return-object v0
.end method

.method public getResourcePath()Ljava/lang/String;
    .locals 1

    .line 145
    .local p0, "this":Lcom/amazonaws/DefaultRequest;, "Lcom/amazonaws/DefaultRequest<TT;>;"
    iget-object v0, p0, Lcom/amazonaws/DefaultRequest;->resourcePath:Ljava/lang/String;

    return-object v0
.end method

.method public getServiceName()Ljava/lang/String;
    .locals 1

    .line 210
    .local p0, "this":Lcom/amazonaws/DefaultRequest;, "Lcom/amazonaws/DefaultRequest<TT;>;"
    iget-object v0, p0, Lcom/amazonaws/DefaultRequest;->serviceName:Ljava/lang/String;

    return-object v0
.end method

.method public getTimeOffset()I
    .locals 1

    .line 268
    .local p0, "this":Lcom/amazonaws/DefaultRequest;, "Lcom/amazonaws/DefaultRequest<TT;>;"
    iget v0, p0, Lcom/amazonaws/DefaultRequest;->timeOffset:I

    return v0
.end method

.method public isStreaming()Z
    .locals 1

    .line 348
    .local p0, "this":Lcom/amazonaws/DefaultRequest;, "Lcom/amazonaws/DefaultRequest<TT;>;"
    iget-boolean v0, p0, Lcom/amazonaws/DefaultRequest;->streaming:Z

    return v0
.end method

.method public setAWSRequestMetrics(Lcom/amazonaws/util/AWSRequestMetrics;)V
    .locals 2
    .param p1, "metrics"    # Lcom/amazonaws/util/AWSRequestMetrics;
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 338
    .local p0, "this":Lcom/amazonaws/DefaultRequest;, "Lcom/amazonaws/DefaultRequest<TT;>;"
    iget-object v0, p0, Lcom/amazonaws/DefaultRequest;->metrics:Lcom/amazonaws/util/AWSRequestMetrics;

    if-nez v0, :cond_0

    .line 339
    iput-object p1, p0, Lcom/amazonaws/DefaultRequest;->metrics:Lcom/amazonaws/util/AWSRequestMetrics;

    .line 344
    return-void

    .line 341
    :cond_0
    new-instance v0, Ljava/lang/IllegalStateException;

    const-string v1, "AWSRequestMetrics has already been set on this request"

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public setContent(Ljava/io/InputStream;)V
    .locals 0
    .param p1, "content"    # Ljava/io/InputStream;

    .line 226
    .local p0, "this":Lcom/amazonaws/DefaultRequest;, "Lcom/amazonaws/DefaultRequest<TT;>;"
    iput-object p1, p0, Lcom/amazonaws/DefaultRequest;->content:Ljava/io/InputStream;

    .line 227
    return-void
.end method

.method public setEndpoint(Ljava/net/URI;)V
    .locals 0
    .param p1, "endpoint"    # Ljava/net/URI;

    .line 194
    .local p0, "this":Lcom/amazonaws/DefaultRequest;, "Lcom/amazonaws/DefaultRequest<TT;>;"
    iput-object p1, p0, Lcom/amazonaws/DefaultRequest;->endpoint:Ljava/net/URI;

    .line 195
    return-void
.end method

.method public setHeaders(Ljava/util/Map;)V
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

    .line 234
    .local p0, "this":Lcom/amazonaws/DefaultRequest;, "Lcom/amazonaws/DefaultRequest<TT;>;"
    .local p1, "headers":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    iget-object v0, p0, Lcom/amazonaws/DefaultRequest;->headers:Ljava/util/Map;

    invoke-interface {v0}, Ljava/util/Map;->clear()V

    .line 235
    iget-object v0, p0, Lcom/amazonaws/DefaultRequest;->headers:Ljava/util/Map;

    invoke-interface {v0, p1}, Ljava/util/Map;->putAll(Ljava/util/Map;)V

    .line 236
    return-void
.end method

.method public setHostPrefix(Ljava/lang/String;)V
    .locals 0
    .param p1, "hostPrefix"    # Ljava/lang/String;

    .line 260
    .local p0, "this":Lcom/amazonaws/DefaultRequest;, "Lcom/amazonaws/DefaultRequest<TT;>;"
    iput-object p1, p0, Lcom/amazonaws/DefaultRequest;->hostPrefix:Ljava/lang/String;

    .line 261
    return-void
.end method

.method public setHttpMethod(Lcom/amazonaws/http/HttpMethodName;)V
    .locals 0
    .param p1, "httpMethod"    # Lcom/amazonaws/http/HttpMethodName;

    .line 186
    .local p0, "this":Lcom/amazonaws/DefaultRequest;, "Lcom/amazonaws/DefaultRequest<TT;>;"
    iput-object p1, p0, Lcom/amazonaws/DefaultRequest;->httpMethod:Lcom/amazonaws/http/HttpMethodName;

    .line 187
    return-void
.end method

.method public setParameters(Ljava/util/Map;)V
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

    .line 243
    .local p0, "this":Lcom/amazonaws/DefaultRequest;, "Lcom/amazonaws/DefaultRequest<TT;>;"
    .local p1, "parameters":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    iget-object v0, p0, Lcom/amazonaws/DefaultRequest;->parameters:Ljava/util/Map;

    invoke-interface {v0}, Ljava/util/Map;->clear()V

    .line 244
    iget-object v0, p0, Lcom/amazonaws/DefaultRequest;->parameters:Ljava/util/Map;

    invoke-interface {v0, p1}, Ljava/util/Map;->putAll(Ljava/util/Map;)V

    .line 245
    return-void
.end method

.method public setResourcePath(Ljava/lang/String;)V
    .locals 0
    .param p1, "resourcePath"    # Ljava/lang/String;

    .line 137
    .local p0, "this":Lcom/amazonaws/DefaultRequest;, "Lcom/amazonaws/DefaultRequest<TT;>;"
    iput-object p1, p0, Lcom/amazonaws/DefaultRequest;->resourcePath:Ljava/lang/String;

    .line 138
    return-void
.end method

.method public setStreaming(Z)V
    .locals 0
    .param p1, "streaming"    # Z

    .line 353
    .local p0, "this":Lcom/amazonaws/DefaultRequest;, "Lcom/amazonaws/DefaultRequest<TT;>;"
    iput-boolean p1, p0, Lcom/amazonaws/DefaultRequest;->streaming:Z

    .line 354
    return-void
.end method

.method public setTimeOffset(I)V
    .locals 0
    .param p1, "timeOffset"    # I

    .line 276
    .local p0, "this":Lcom/amazonaws/DefaultRequest;, "Lcom/amazonaws/DefaultRequest<TT;>;"
    iput p1, p0, Lcom/amazonaws/DefaultRequest;->timeOffset:I

    .line 277
    return-void
.end method

.method public toString()Ljava/lang/String;
    .locals 9

    .line 292
    .local p0, "this":Lcom/amazonaws/DefaultRequest;, "Lcom/amazonaws/DefaultRequest<TT;>;"
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 293
    .local v0, "builder":Ljava/lang/StringBuilder;
    invoke-virtual {p0}, Lcom/amazonaws/DefaultRequest;->getHttpMethod()Lcom/amazonaws/http/HttpMethodName;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 294
    invoke-virtual {p0}, Lcom/amazonaws/DefaultRequest;->getEndpoint()Ljava/net/URI;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 295
    invoke-virtual {p0}, Lcom/amazonaws/DefaultRequest;->getResourcePath()Ljava/lang/String;

    move-result-object v1

    .line 297
    .local v1, "resourcePath":Ljava/lang/String;
    const-string v3, "/"

    if-nez v1, :cond_0

    .line 298
    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    goto :goto_0

    .line 301
    :cond_0
    invoke-virtual {v1, v3}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v4

    if-nez v4, :cond_1

    .line 302
    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 304
    :cond_1
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 306
    :goto_0
    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 307
    invoke-virtual {p0}, Lcom/amazonaws/DefaultRequest;->getParameters()Ljava/util/Map;

    move-result-object v2

    invoke-interface {v2}, Ljava/util/Map;->isEmpty()Z

    move-result v2

    const-string v3, ", "

    const-string v4, ": "

    const-string v5, ") "

    if-nez v2, :cond_3

    .line 308
    const-string v2, "Parameters: ("

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 309
    invoke-virtual {p0}, Lcom/amazonaws/DefaultRequest;->getParameters()Ljava/util/Map;

    move-result-object v2

    invoke-interface {v2}, Ljava/util/Map;->keySet()Ljava/util/Set;

    move-result-object v2

    invoke-interface {v2}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_1
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v6

    if-eqz v6, :cond_2

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Ljava/lang/String;

    .line 310
    .local v6, "key":Ljava/lang/String;
    invoke-virtual {p0}, Lcom/amazonaws/DefaultRequest;->getParameters()Ljava/util/Map;

    move-result-object v7

    invoke-interface {v7, v6}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Ljava/lang/String;

    .line 311
    .local v7, "value":Ljava/lang/String;
    invoke-virtual {v0, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 312
    .end local v6    # "key":Ljava/lang/String;
    .end local v7    # "value":Ljava/lang/String;
    goto :goto_1

    .line 313
    :cond_2
    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 316
    :cond_3
    invoke-virtual {p0}, Lcom/amazonaws/DefaultRequest;->getHeaders()Ljava/util/Map;

    move-result-object v2

    invoke-interface {v2}, Ljava/util/Map;->isEmpty()Z

    move-result v2

    if-nez v2, :cond_5

    .line 317
    const-string v2, "Headers: ("

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 318
    invoke-virtual {p0}, Lcom/amazonaws/DefaultRequest;->getHeaders()Ljava/util/Map;

    move-result-object v2

    invoke-interface {v2}, Ljava/util/Map;->keySet()Ljava/util/Set;

    move-result-object v2

    invoke-interface {v2}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_2
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v6

    if-eqz v6, :cond_4

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Ljava/lang/String;

    .line 319
    .restart local v6    # "key":Ljava/lang/String;
    invoke-virtual {p0}, Lcom/amazonaws/DefaultRequest;->getHeaders()Ljava/util/Map;

    move-result-object v7

    invoke-interface {v7, v6}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Ljava/lang/String;

    .line 320
    .restart local v7    # "value":Ljava/lang/String;
    invoke-virtual {v0, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 321
    .end local v6    # "key":Ljava/lang/String;
    .end local v7    # "value":Ljava/lang/String;
    goto :goto_2

    .line 322
    :cond_4
    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 325
    :cond_5
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    return-object v2
.end method

.method public withParameter(Ljava/lang/String;Ljava/lang/String;)Lcom/amazonaws/Request;
    .locals 0
    .param p1, "name"    # Ljava/lang/String;
    .param p2, "value"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ")",
            "Lcom/amazonaws/Request<",
            "TT;>;"
        }
    .end annotation

    .line 169
    .local p0, "this":Lcom/amazonaws/DefaultRequest;, "Lcom/amazonaws/DefaultRequest<TT;>;"
    invoke-virtual {p0, p1, p2}, Lcom/amazonaws/DefaultRequest;->addParameter(Ljava/lang/String;Ljava/lang/String;)V

    .line 170
    return-object p0
.end method

.method public withTimeOffset(I)Lcom/amazonaws/Request;
    .locals 0
    .param p1, "timeOffset"    # I
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(I)",
            "Lcom/amazonaws/Request<",
            "TT;>;"
        }
    .end annotation

    .line 285
    .local p0, "this":Lcom/amazonaws/DefaultRequest;, "Lcom/amazonaws/DefaultRequest<TT;>;"
    invoke-virtual {p0, p1}, Lcom/amazonaws/DefaultRequest;->setTimeOffset(I)V

    .line 286
    return-object p0
.end method
