.class public Lcom/alibaba/sdk/android/oss/network/OSSRequestTask;
.super Ljava/lang/Object;
.source "OSSRequestTask.java"

# interfaces
.implements Ljava/util/concurrent/Callable;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "<T:",
        "Lcom/alibaba/sdk/android/oss/model/OSSResult;",
        ">",
        "Ljava/lang/Object;",
        "Ljava/util/concurrent/Callable<",
        "TT;>;"
    }
.end annotation


# instance fields
.field private client:Lokhttp3/OkHttpClient;

.field private context:Lcom/alibaba/sdk/android/oss/network/ExecutionContext;

.field private currentRetryCount:I

.field private message:Lcom/alibaba/sdk/android/oss/internal/RequestMessage;

.field private responseParser:Lcom/alibaba/sdk/android/oss/internal/ResponseParser;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lcom/alibaba/sdk/android/oss/internal/ResponseParser<",
            "TT;>;"
        }
    .end annotation
.end field

.field private retryHandler:Lcom/alibaba/sdk/android/oss/internal/OSSRetryHandler;


# direct methods
.method public constructor <init>(Lcom/alibaba/sdk/android/oss/internal/RequestMessage;Lcom/alibaba/sdk/android/oss/internal/ResponseParser;Lcom/alibaba/sdk/android/oss/network/ExecutionContext;I)V
    .locals 1
    .param p1, "message"    # Lcom/alibaba/sdk/android/oss/internal/RequestMessage;
    .param p2, "parser"    # Lcom/alibaba/sdk/android/oss/internal/ResponseParser;
    .param p3, "context"    # Lcom/alibaba/sdk/android/oss/network/ExecutionContext;
    .param p4, "maxRetry"    # I

    .line 61
    .local p0, "this":Lcom/alibaba/sdk/android/oss/network/OSSRequestTask;, "Lcom/alibaba/sdk/android/oss/network/OSSRequestTask<TT;>;"
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 59
    const/4 v0, 0x0

    iput v0, p0, Lcom/alibaba/sdk/android/oss/network/OSSRequestTask;->currentRetryCount:I

    .line 62
    iput-object p2, p0, Lcom/alibaba/sdk/android/oss/network/OSSRequestTask;->responseParser:Lcom/alibaba/sdk/android/oss/internal/ResponseParser;

    .line 63
    iput-object p1, p0, Lcom/alibaba/sdk/android/oss/network/OSSRequestTask;->message:Lcom/alibaba/sdk/android/oss/internal/RequestMessage;

    .line 64
    iput-object p3, p0, Lcom/alibaba/sdk/android/oss/network/OSSRequestTask;->context:Lcom/alibaba/sdk/android/oss/network/ExecutionContext;

    .line 65
    invoke-virtual {p3}, Lcom/alibaba/sdk/android/oss/network/ExecutionContext;->getClient()Lokhttp3/OkHttpClient;

    move-result-object v0

    iput-object v0, p0, Lcom/alibaba/sdk/android/oss/network/OSSRequestTask;->client:Lokhttp3/OkHttpClient;

    .line 66
    new-instance v0, Lcom/alibaba/sdk/android/oss/internal/OSSRetryHandler;

    invoke-direct {v0, p4}, Lcom/alibaba/sdk/android/oss/internal/OSSRetryHandler;-><init>(I)V

    iput-object v0, p0, Lcom/alibaba/sdk/android/oss/network/OSSRequestTask;->retryHandler:Lcom/alibaba/sdk/android/oss/internal/OSSRetryHandler;

    .line 67
    return-void
.end method

.method private buildResponseMessage(Lcom/alibaba/sdk/android/oss/internal/RequestMessage;Lokhttp3/Response;)Lcom/alibaba/sdk/android/oss/internal/ResponseMessage;
    .locals 6
    .param p1, "request"    # Lcom/alibaba/sdk/android/oss/internal/RequestMessage;
    .param p2, "response"    # Lokhttp3/Response;

    .line 289
    .local p0, "this":Lcom/alibaba/sdk/android/oss/network/OSSRequestTask;, "Lcom/alibaba/sdk/android/oss/network/OSSRequestTask<TT;>;"
    new-instance v0, Lcom/alibaba/sdk/android/oss/internal/ResponseMessage;

    invoke-direct {v0}, Lcom/alibaba/sdk/android/oss/internal/ResponseMessage;-><init>()V

    .line 290
    .local v0, "responseMessage":Lcom/alibaba/sdk/android/oss/internal/ResponseMessage;
    invoke-virtual {v0, p1}, Lcom/alibaba/sdk/android/oss/internal/ResponseMessage;->setRequest(Lcom/alibaba/sdk/android/oss/internal/RequestMessage;)V

    .line 291
    invoke-virtual {v0, p2}, Lcom/alibaba/sdk/android/oss/internal/ResponseMessage;->setResponse(Lokhttp3/Response;)V

    .line 292
    new-instance v1, Ljava/util/HashMap;

    invoke-direct {v1}, Ljava/util/HashMap;-><init>()V

    .line 293
    .local v1, "headers":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    invoke-virtual {p2}, Lokhttp3/Response;->headers()Lokhttp3/Headers;

    move-result-object v2

    .line 294
    .local v2, "responseHeaders":Lokhttp3/Headers;
    const/4 v3, 0x0

    .local v3, "i":I
    :goto_0
    invoke-virtual {v2}, Lokhttp3/Headers;->size()I

    move-result v4

    if-ge v3, v4, :cond_0

    .line 295
    invoke-virtual {v2, v3}, Lokhttp3/Headers;->name(I)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v2, v3}, Lokhttp3/Headers;->value(I)Ljava/lang/String;

    move-result-object v5

    invoke-interface {v1, v4, v5}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 294
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    .line 297
    .end local v3    # "i":I
    :cond_0
    invoke-virtual {v0, v1}, Lcom/alibaba/sdk/android/oss/internal/ResponseMessage;->setHeaders(Ljava/util/Map;)V

    .line 298
    invoke-virtual {p2}, Lokhttp3/Response;->code()I

    move-result v3

    invoke-virtual {v0, v3}, Lcom/alibaba/sdk/android/oss/internal/ResponseMessage;->setStatusCode(I)V

    .line 299
    invoke-virtual {p2}, Lokhttp3/Response;->body()Lokhttp3/ResponseBody;

    move-result-object v3

    invoke-virtual {v3}, Lokhttp3/ResponseBody;->contentLength()J

    move-result-wide v3

    invoke-virtual {v0, v3, v4}, Lcom/alibaba/sdk/android/oss/internal/ResponseMessage;->setContentLength(J)V

    .line 300
    invoke-virtual {p2}, Lokhttp3/Response;->body()Lokhttp3/ResponseBody;

    move-result-object v3

    invoke-virtual {v3}, Lokhttp3/ResponseBody;->byteStream()Ljava/io/InputStream;

    move-result-object v3

    invoke-virtual {v0, v3}, Lcom/alibaba/sdk/android/oss/internal/ResponseMessage;->setContent(Ljava/io/InputStream;)V

    .line 301
    return-object v0
.end method


# virtual methods
.method public call()Lcom/alibaba/sdk/android/oss/model/OSSResult;
    .locals 21
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()TT;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 72
    .local p0, "this":Lcom/alibaba/sdk/android/oss/network/OSSRequestTask;, "Lcom/alibaba/sdk/android/oss/network/OSSRequestTask<TT;>;"
    move-object/from16 v1, p0

    const-string v0, "\n"

    const/4 v2, 0x0

    .line 73
    .local v2, "request":Lokhttp3/Request;
    const/4 v3, 0x0

    .line 74
    .local v3, "responseMessage":Lcom/alibaba/sdk/android/oss/internal/ResponseMessage;
    const/4 v4, 0x0

    .line 75
    .local v4, "exception":Ljava/lang/Exception;
    const/4 v5, 0x0

    .line 78
    .local v5, "call":Lokhttp3/Call;
    :try_start_0
    iget-object v8, v1, Lcom/alibaba/sdk/android/oss/network/OSSRequestTask;->context:Lcom/alibaba/sdk/android/oss/network/ExecutionContext;

    invoke-virtual {v8}, Lcom/alibaba/sdk/android/oss/network/ExecutionContext;->getApplicationContext()Landroid/content/Context;

    move-result-object v8
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_9

    if-eqz v8, :cond_0

    .line 79
    :try_start_1
    iget-object v8, v1, Lcom/alibaba/sdk/android/oss/network/OSSRequestTask;->context:Lcom/alibaba/sdk/android/oss/network/ExecutionContext;

    invoke-virtual {v8}, Lcom/alibaba/sdk/android/oss/network/ExecutionContext;->getApplicationContext()Landroid/content/Context;

    move-result-object v8

    invoke-static {v8}, Lcom/alibaba/sdk/android/oss/common/utils/OSSUtils;->buildBaseLogInfo(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v8

    invoke-static {v8}, Lcom/alibaba/sdk/android/oss/common/OSSLog;->logInfo(Ljava/lang/String;)V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_0

    .line 209
    :catch_0
    move-exception v0

    move-object/from16 v19, v3

    move-object/from16 v20, v4

    goto/16 :goto_9

    .line 82
    :cond_0
    :goto_0
    :try_start_2
    const-string v8, "[call] - "

    invoke-static {v8}, Lcom/alibaba/sdk/android/oss/common/OSSLog;->logDebug(Ljava/lang/String;)V

    .line 84
    iget-object v8, v1, Lcom/alibaba/sdk/android/oss/network/OSSRequestTask;->context:Lcom/alibaba/sdk/android/oss/network/ExecutionContext;

    invoke-virtual {v8}, Lcom/alibaba/sdk/android/oss/network/ExecutionContext;->getRequest()Lcom/alibaba/sdk/android/oss/model/OSSRequest;

    move-result-object v8

    .line 87
    .local v8, "ossRequest":Lcom/alibaba/sdk/android/oss/model/OSSRequest;
    iget-object v9, v1, Lcom/alibaba/sdk/android/oss/network/OSSRequestTask;->message:Lcom/alibaba/sdk/android/oss/internal/RequestMessage;

    invoke-static {v8, v9}, Lcom/alibaba/sdk/android/oss/common/utils/OSSUtils;->ensureRequestValid(Lcom/alibaba/sdk/android/oss/model/OSSRequest;Lcom/alibaba/sdk/android/oss/internal/RequestMessage;)V

    .line 89
    iget-object v9, v1, Lcom/alibaba/sdk/android/oss/network/OSSRequestTask;->message:Lcom/alibaba/sdk/android/oss/internal/RequestMessage;

    invoke-virtual {v9}, Lcom/alibaba/sdk/android/oss/internal/RequestMessage;->getSigner()Lcom/alibaba/sdk/android/oss/signer/RequestSigner;

    move-result-object v9

    iget-object v10, v1, Lcom/alibaba/sdk/android/oss/network/OSSRequestTask;->message:Lcom/alibaba/sdk/android/oss/internal/RequestMessage;

    invoke-interface {v9, v10}, Lcom/alibaba/sdk/android/oss/signer/RequestSigner;->sign(Lcom/alibaba/sdk/android/oss/internal/RequestMessage;)V

    .line 91
    iget-object v9, v1, Lcom/alibaba/sdk/android/oss/network/OSSRequestTask;->context:Lcom/alibaba/sdk/android/oss/network/ExecutionContext;

    invoke-virtual {v9}, Lcom/alibaba/sdk/android/oss/network/ExecutionContext;->getCancellationHandler()Lcom/alibaba/sdk/android/oss/network/CancellationHandler;

    move-result-object v9

    invoke-virtual {v9}, Lcom/alibaba/sdk/android/oss/network/CancellationHandler;->isCancelled()Z

    move-result v9

    if-nez v9, :cond_11

    .line 95
    new-instance v9, Lokhttp3/Request$Builder;

    invoke-direct {v9}, Lokhttp3/Request$Builder;-><init>()V

    .line 100
    .local v9, "requestBuilder":Lokhttp3/Request$Builder;
    instance-of v10, v8, Lcom/alibaba/sdk/android/oss/model/ListBucketsRequest;
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_9

    if-eqz v10, :cond_1

    .line 101
    :try_start_3
    iget-object v10, v1, Lcom/alibaba/sdk/android/oss/network/OSSRequestTask;->message:Lcom/alibaba/sdk/android/oss/internal/RequestMessage;

    invoke-virtual {v10}, Lcom/alibaba/sdk/android/oss/internal/RequestMessage;->buildOSSServiceURL()Ljava/lang/String;

    move-result-object v10
    :try_end_3
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_0

    .local v10, "url":Ljava/lang/String;
    goto :goto_1

    .line 103
    .end local v10    # "url":Ljava/lang/String;
    :cond_1
    :try_start_4
    iget-object v10, v1, Lcom/alibaba/sdk/android/oss/network/OSSRequestTask;->message:Lcom/alibaba/sdk/android/oss/internal/RequestMessage;

    invoke-virtual {v10}, Lcom/alibaba/sdk/android/oss/internal/RequestMessage;->buildCanonicalURL()Ljava/lang/String;

    move-result-object v10

    .line 105
    .restart local v10    # "url":Ljava/lang/String;
    :goto_1
    invoke-virtual {v9, v10}, Lokhttp3/Request$Builder;->url(Ljava/lang/String;)Lokhttp3/Request$Builder;

    move-result-object v11

    move-object v9, v11

    .line 108
    iget-object v11, v1, Lcom/alibaba/sdk/android/oss/network/OSSRequestTask;->message:Lcom/alibaba/sdk/android/oss/internal/RequestMessage;

    invoke-virtual {v11}, Lcom/alibaba/sdk/android/oss/internal/RequestMessage;->getHeaders()Ljava/util/Map;

    move-result-object v11

    invoke-interface {v11}, Ljava/util/Map;->keySet()Ljava/util/Set;

    move-result-object v11

    invoke-interface {v11}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v11

    :goto_2
    invoke-interface {v11}, Ljava/util/Iterator;->hasNext()Z

    move-result v12
    :try_end_4
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_4} :catch_9

    if-eqz v12, :cond_2

    :try_start_5
    invoke-interface {v11}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v12

    check-cast v12, Ljava/lang/String;

    .line 109
    .local v12, "key":Ljava/lang/String;
    iget-object v13, v1, Lcom/alibaba/sdk/android/oss/network/OSSRequestTask;->message:Lcom/alibaba/sdk/android/oss/internal/RequestMessage;

    invoke-virtual {v13}, Lcom/alibaba/sdk/android/oss/internal/RequestMessage;->getHeaders()Ljava/util/Map;

    move-result-object v13

    invoke-interface {v13, v12}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v13

    check-cast v13, Ljava/lang/String;

    invoke-virtual {v9, v12, v13}, Lokhttp3/Request$Builder;->addHeader(Ljava/lang/String;Ljava/lang/String;)Lokhttp3/Request$Builder;

    move-result-object v13
    :try_end_5
    .catch Ljava/lang/Exception; {:try_start_5 .. :try_end_5} :catch_0

    move-object v9, v13

    .line 110
    .end local v12    # "key":Ljava/lang/String;
    goto :goto_2

    .line 112
    :cond_2
    :try_start_6
    iget-object v11, v1, Lcom/alibaba/sdk/android/oss/network/OSSRequestTask;->message:Lcom/alibaba/sdk/android/oss/internal/RequestMessage;

    invoke-virtual {v11}, Lcom/alibaba/sdk/android/oss/internal/RequestMessage;->getHeaders()Ljava/util/Map;

    move-result-object v11

    const-string v12, "Content-Type"

    invoke-interface {v11, v12}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v11

    check-cast v11, Ljava/lang/String;

    .line 113
    .local v11, "contentType":Ljava/lang/String;
    new-instance v12, Ljava/lang/StringBuilder;

    invoke-direct {v12}, Ljava/lang/StringBuilder;-><init>()V

    const-string v13, "request method = "

    invoke-virtual {v12, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v12

    iget-object v13, v1, Lcom/alibaba/sdk/android/oss/network/OSSRequestTask;->message:Lcom/alibaba/sdk/android/oss/internal/RequestMessage;

    invoke-virtual {v13}, Lcom/alibaba/sdk/android/oss/internal/RequestMessage;->getMethod()Lcom/alibaba/sdk/android/oss/common/HttpMethod;

    move-result-object v13

    invoke-virtual {v12, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v12

    invoke-virtual {v12}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v12

    invoke-static {v12}, Lcom/alibaba/sdk/android/oss/common/OSSLog;->logDebug(Ljava/lang/String;)V

    .line 115
    sget-object v12, Lcom/alibaba/sdk/android/oss/network/OSSRequestTask$1;->$SwitchMap$com$alibaba$sdk$android$oss$common$HttpMethod:[I

    iget-object v13, v1, Lcom/alibaba/sdk/android/oss/network/OSSRequestTask;->message:Lcom/alibaba/sdk/android/oss/internal/RequestMessage;

    invoke-virtual {v13}, Lcom/alibaba/sdk/android/oss/internal/RequestMessage;->getMethod()Lcom/alibaba/sdk/android/oss/common/HttpMethod;

    move-result-object v13

    invoke-virtual {v13}, Lcom/alibaba/sdk/android/oss/common/HttpMethod;->ordinal()I

    move-result v13

    aget v12, v12, v13
    :try_end_6
    .catch Ljava/lang/Exception; {:try_start_6 .. :try_end_6} :catch_9

    packed-switch v12, :pswitch_data_0

    move-object/from16 v18, v2

    .end local v2    # "request":Lokhttp3/Request;
    .local v18, "request":Lokhttp3/Request;
    goto/16 :goto_6

    .line 173
    .end local v18    # "request":Lokhttp3/Request;
    .restart local v2    # "request":Lokhttp3/Request;
    :pswitch_0
    :try_start_7
    invoke-virtual {v9}, Lokhttp3/Request$Builder;->delete()Lokhttp3/Request$Builder;

    move-result-object v12

    move-object v9, v12

    .line 174
    move-object/from16 v18, v2

    goto/16 :goto_6

    .line 170
    :pswitch_1
    invoke-virtual {v9}, Lokhttp3/Request$Builder;->head()Lokhttp3/Request$Builder;

    move-result-object v12

    move-object v9, v12

    .line 171
    move-object/from16 v18, v2

    goto/16 :goto_6

    .line 167
    :pswitch_2
    invoke-virtual {v9}, Lokhttp3/Request$Builder;->get()Lokhttp3/Request$Builder;

    move-result-object v12
    :try_end_7
    .catch Ljava/lang/Exception; {:try_start_7 .. :try_end_7} :catch_0

    move-object v9, v12

    .line 168
    move-object/from16 v18, v2

    goto/16 :goto_6

    .line 118
    :pswitch_3
    if-eqz v11, :cond_3

    const/4 v12, 0x1

    goto :goto_3

    :cond_3
    const/4 v12, 0x0

    :goto_3
    :try_start_8
    const-string v14, "Content type can\'t be null when upload!"

    invoke-static {v12, v14}, Lcom/alibaba/sdk/android/oss/common/utils/OSSUtils;->assertTrue(ZLjava/lang/String;)V

    .line 119
    const/4 v12, 0x0

    .line 120
    .local v12, "inputStream":Ljava/io/InputStream;
    const/4 v14, 0x0

    .line 121
    .local v14, "stringBody":Ljava/lang/String;
    const-wide/16 v15, 0x0

    .line 122
    .local v15, "length":J
    iget-object v7, v1, Lcom/alibaba/sdk/android/oss/network/OSSRequestTask;->message:Lcom/alibaba/sdk/android/oss/internal/RequestMessage;

    invoke-virtual {v7}, Lcom/alibaba/sdk/android/oss/internal/RequestMessage;->getUploadData()[B

    move-result-object v7
    :try_end_8
    .catch Ljava/lang/Exception; {:try_start_8 .. :try_end_8} :catch_2

    if-eqz v7, :cond_4

    .line 123
    :try_start_9
    new-instance v7, Ljava/io/ByteArrayInputStream;

    iget-object v6, v1, Lcom/alibaba/sdk/android/oss/network/OSSRequestTask;->message:Lcom/alibaba/sdk/android/oss/internal/RequestMessage;

    invoke-virtual {v6}, Lcom/alibaba/sdk/android/oss/internal/RequestMessage;->getUploadData()[B

    move-result-object v6

    invoke-direct {v7, v6}, Ljava/io/ByteArrayInputStream;-><init>([B)V

    move-object v12, v7

    .line 124
    iget-object v6, v1, Lcom/alibaba/sdk/android/oss/network/OSSRequestTask;->message:Lcom/alibaba/sdk/android/oss/internal/RequestMessage;

    invoke-virtual {v6}, Lcom/alibaba/sdk/android/oss/internal/RequestMessage;->getUploadData()[B

    move-result-object v6

    array-length v6, v6
    :try_end_9
    .catch Ljava/lang/Exception; {:try_start_9 .. :try_end_9} :catch_0

    int-to-long v6, v6

    move-object/from16 v18, v2

    .end local v15    # "length":J
    .local v6, "length":J
    goto/16 :goto_5

    .line 125
    .end local v6    # "length":J
    .restart local v15    # "length":J
    :cond_4
    :try_start_a
    iget-object v6, v1, Lcom/alibaba/sdk/android/oss/network/OSSRequestTask;->message:Lcom/alibaba/sdk/android/oss/internal/RequestMessage;

    invoke-virtual {v6}, Lcom/alibaba/sdk/android/oss/internal/RequestMessage;->getUploadFilePath()Ljava/lang/String;

    move-result-object v6
    :try_end_a
    .catch Ljava/lang/Exception; {:try_start_a .. :try_end_a} :catch_2

    if-eqz v6, :cond_6

    .line 126
    :try_start_b
    new-instance v6, Ljava/io/File;

    iget-object v7, v1, Lcom/alibaba/sdk/android/oss/network/OSSRequestTask;->message:Lcom/alibaba/sdk/android/oss/internal/RequestMessage;

    invoke-virtual {v7}, Lcom/alibaba/sdk/android/oss/internal/RequestMessage;->getUploadFilePath()Ljava/lang/String;

    move-result-object v7

    invoke-direct {v6, v7}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 127
    .local v6, "file":Ljava/io/File;
    new-instance v7, Ljava/io/FileInputStream;

    invoke-direct {v7, v6}, Ljava/io/FileInputStream;-><init>(Ljava/io/File;)V

    move-object v12, v7

    .line 128
    invoke-virtual {v6}, Ljava/io/File;->length()J

    move-result-wide v17

    move-wide/from16 v15, v17

    .line 129
    const-wide/16 v17, 0x0

    cmp-long v7, v15, v17

    if-lez v7, :cond_5

    .line 132
    .end local v6    # "file":Ljava/io/File;
    move-object/from16 v18, v2

    move-wide v6, v15

    goto/16 :goto_5

    .line 130
    .restart local v6    # "file":Ljava/io/File;
    :cond_5
    new-instance v0, Lcom/alibaba/sdk/android/oss/ClientException;

    const-string/jumbo v7, "the length of file is 0!"

    invoke-direct {v0, v7}, Lcom/alibaba/sdk/android/oss/ClientException;-><init>(Ljava/lang/String;)V

    .end local v2    # "request":Lokhttp3/Request;
    .end local v3    # "responseMessage":Lcom/alibaba/sdk/android/oss/internal/ResponseMessage;
    .end local v4    # "exception":Ljava/lang/Exception;
    .end local v5    # "call":Lokhttp3/Call;
    throw v0
    :try_end_b
    .catch Ljava/lang/Exception; {:try_start_b .. :try_end_b} :catch_0

    .line 132
    .end local v6    # "file":Ljava/io/File;
    .restart local v2    # "request":Lokhttp3/Request;
    .restart local v3    # "responseMessage":Lcom/alibaba/sdk/android/oss/internal/ResponseMessage;
    .restart local v4    # "exception":Ljava/lang/Exception;
    .restart local v5    # "call":Lokhttp3/Call;
    :cond_6
    :try_start_c
    iget-object v6, v1, Lcom/alibaba/sdk/android/oss/network/OSSRequestTask;->message:Lcom/alibaba/sdk/android/oss/internal/RequestMessage;

    invoke-virtual {v6}, Lcom/alibaba/sdk/android/oss/internal/RequestMessage;->getUploadUri()Landroid/net/Uri;

    move-result-object v6

    if-eqz v6, :cond_9

    .line 133
    iget-object v6, v1, Lcom/alibaba/sdk/android/oss/network/OSSRequestTask;->context:Lcom/alibaba/sdk/android/oss/network/ExecutionContext;

    invoke-virtual {v6}, Lcom/alibaba/sdk/android/oss/network/ExecutionContext;->getApplicationContext()Landroid/content/Context;

    move-result-object v6

    invoke-virtual {v6}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v6

    iget-object v7, v1, Lcom/alibaba/sdk/android/oss/network/OSSRequestTask;->message:Lcom/alibaba/sdk/android/oss/internal/RequestMessage;

    invoke-virtual {v7}, Lcom/alibaba/sdk/android/oss/internal/RequestMessage;->getUploadUri()Landroid/net/Uri;

    move-result-object v7

    invoke-virtual {v6, v7}, Landroid/content/ContentResolver;->openInputStream(Landroid/net/Uri;)Ljava/io/InputStream;

    move-result-object v6
    :try_end_c
    .catch Ljava/lang/Exception; {:try_start_c .. :try_end_c} :catch_2

    move-object v12, v6

    .line 134
    const/4 v6, 0x0

    .line 136
    .local v6, "parcelFileDescriptor":Landroid/os/ParcelFileDescriptor;
    :try_start_d
    iget-object v7, v1, Lcom/alibaba/sdk/android/oss/network/OSSRequestTask;->context:Lcom/alibaba/sdk/android/oss/network/ExecutionContext;

    invoke-virtual {v7}, Lcom/alibaba/sdk/android/oss/network/ExecutionContext;->getApplicationContext()Landroid/content/Context;

    move-result-object v7

    invoke-virtual {v7}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v7

    iget-object v13, v1, Lcom/alibaba/sdk/android/oss/network/OSSRequestTask;->message:Lcom/alibaba/sdk/android/oss/internal/RequestMessage;

    invoke-virtual {v13}, Lcom/alibaba/sdk/android/oss/internal/RequestMessage;->getUploadUri()Landroid/net/Uri;

    move-result-object v13
    :try_end_d
    .catchall {:try_start_d .. :try_end_d} :catchall_1

    move-object/from16 v18, v2

    .end local v2    # "request":Lokhttp3/Request;
    .restart local v18    # "request":Lokhttp3/Request;
    :try_start_e
    const-string v2, "r"

    invoke-virtual {v7, v13, v2}, Landroid/content/ContentResolver;->openFileDescriptor(Landroid/net/Uri;Ljava/lang/String;)Landroid/os/ParcelFileDescriptor;

    move-result-object v2

    move-object v6, v2

    .line 137
    invoke-virtual {v6}, Landroid/os/ParcelFileDescriptor;->getStatSize()J

    move-result-wide v19
    :try_end_e
    .catchall {:try_start_e .. :try_end_e} :catchall_0

    move-wide/from16 v15, v19

    .line 139
    if-eqz v6, :cond_7

    .line 140
    :try_start_f
    invoke-virtual {v6}, Landroid/os/ParcelFileDescriptor;->close()V

    .line 143
    .end local v6    # "parcelFileDescriptor":Landroid/os/ParcelFileDescriptor;
    :cond_7
    move-wide v6, v15

    goto :goto_5

    .line 139
    .restart local v6    # "parcelFileDescriptor":Landroid/os/ParcelFileDescriptor;
    :catchall_0
    move-exception v0

    goto :goto_4

    .end local v18    # "request":Lokhttp3/Request;
    .restart local v2    # "request":Lokhttp3/Request;
    :catchall_1
    move-exception v0

    move-object/from16 v18, v2

    .end local v2    # "request":Lokhttp3/Request;
    .restart local v18    # "request":Lokhttp3/Request;
    :goto_4
    if-eqz v6, :cond_8

    .line 140
    invoke-virtual {v6}, Landroid/os/ParcelFileDescriptor;->close()V

    .line 142
    :cond_8
    nop

    .end local v3    # "responseMessage":Lcom/alibaba/sdk/android/oss/internal/ResponseMessage;
    .end local v4    # "exception":Ljava/lang/Exception;
    .end local v5    # "call":Lokhttp3/Call;
    .end local v18    # "request":Lokhttp3/Request;
    throw v0

    .line 143
    .end local v6    # "parcelFileDescriptor":Landroid/os/ParcelFileDescriptor;
    .restart local v2    # "request":Lokhttp3/Request;
    .restart local v3    # "responseMessage":Lcom/alibaba/sdk/android/oss/internal/ResponseMessage;
    .restart local v4    # "exception":Ljava/lang/Exception;
    .restart local v5    # "call":Lokhttp3/Call;
    :cond_9
    move-object/from16 v18, v2

    .end local v2    # "request":Lokhttp3/Request;
    .restart local v18    # "request":Lokhttp3/Request;
    iget-object v2, v1, Lcom/alibaba/sdk/android/oss/network/OSSRequestTask;->message:Lcom/alibaba/sdk/android/oss/internal/RequestMessage;

    invoke-virtual {v2}, Lcom/alibaba/sdk/android/oss/internal/RequestMessage;->getContent()Ljava/io/InputStream;

    move-result-object v2

    if-eqz v2, :cond_a

    .line 144
    iget-object v2, v1, Lcom/alibaba/sdk/android/oss/network/OSSRequestTask;->message:Lcom/alibaba/sdk/android/oss/internal/RequestMessage;

    invoke-virtual {v2}, Lcom/alibaba/sdk/android/oss/internal/RequestMessage;->getContent()Ljava/io/InputStream;

    move-result-object v2

    move-object v12, v2

    .line 145
    iget-object v2, v1, Lcom/alibaba/sdk/android/oss/network/OSSRequestTask;->message:Lcom/alibaba/sdk/android/oss/internal/RequestMessage;

    invoke-virtual {v2}, Lcom/alibaba/sdk/android/oss/internal/RequestMessage;->getContentLength()J

    move-result-wide v6

    move-wide v15, v6

    goto :goto_5

    .line 147
    :cond_a
    iget-object v2, v1, Lcom/alibaba/sdk/android/oss/network/OSSRequestTask;->message:Lcom/alibaba/sdk/android/oss/internal/RequestMessage;

    invoke-virtual {v2}, Lcom/alibaba/sdk/android/oss/internal/RequestMessage;->getStringBody()Ljava/lang/String;

    move-result-object v2

    move-object v14, v2

    move-wide v6, v15

    .line 150
    .end local v15    # "length":J
    .local v6, "length":J
    :goto_5
    if-eqz v12, :cond_c

    .line 151
    iget-object v2, v1, Lcom/alibaba/sdk/android/oss/network/OSSRequestTask;->message:Lcom/alibaba/sdk/android/oss/internal/RequestMessage;

    invoke-virtual {v2}, Lcom/alibaba/sdk/android/oss/internal/RequestMessage;->isCheckCRC64()Z

    move-result v2

    if-eqz v2, :cond_b

    .line 152
    new-instance v2, Ljava/util/zip/CheckedInputStream;

    new-instance v13, Lcom/alibaba/sdk/android/oss/common/utils/CRC64;

    invoke-direct {v13}, Lcom/alibaba/sdk/android/oss/common/utils/CRC64;-><init>()V

    invoke-direct {v2, v12, v13}, Ljava/util/zip/CheckedInputStream;-><init>(Ljava/io/InputStream;Ljava/util/zip/Checksum;)V

    move-object v12, v2

    .line 154
    :cond_b
    iget-object v2, v1, Lcom/alibaba/sdk/android/oss/network/OSSRequestTask;->message:Lcom/alibaba/sdk/android/oss/internal/RequestMessage;

    invoke-virtual {v2, v12}, Lcom/alibaba/sdk/android/oss/internal/RequestMessage;->setContent(Ljava/io/InputStream;)V

    .line 155
    iget-object v2, v1, Lcom/alibaba/sdk/android/oss/network/OSSRequestTask;->message:Lcom/alibaba/sdk/android/oss/internal/RequestMessage;

    invoke-virtual {v2, v6, v7}, Lcom/alibaba/sdk/android/oss/internal/RequestMessage;->setContentLength(J)V

    .line 156
    iget-object v2, v1, Lcom/alibaba/sdk/android/oss/network/OSSRequestTask;->message:Lcom/alibaba/sdk/android/oss/internal/RequestMessage;

    invoke-virtual {v2}, Lcom/alibaba/sdk/android/oss/internal/RequestMessage;->getMethod()Lcom/alibaba/sdk/android/oss/common/HttpMethod;

    move-result-object v2

    invoke-virtual {v2}, Lcom/alibaba/sdk/android/oss/common/HttpMethod;->toString()Ljava/lang/String;

    move-result-object v2

    iget-object v13, v1, Lcom/alibaba/sdk/android/oss/network/OSSRequestTask;->context:Lcom/alibaba/sdk/android/oss/network/ExecutionContext;

    .line 157
    invoke-static {v12, v6, v7, v11, v13}, Lcom/alibaba/sdk/android/oss/network/NetworkProgressHelper;->addProgressRequestBody(Ljava/io/InputStream;JLjava/lang/String;Lcom/alibaba/sdk/android/oss/network/ExecutionContext;)Lcom/alibaba/sdk/android/oss/network/ProgressTouchableRequestBody;

    move-result-object v13

    .line 156
    invoke-virtual {v9, v2, v13}, Lokhttp3/Request$Builder;->method(Ljava/lang/String;Lokhttp3/RequestBody;)Lokhttp3/Request$Builder;

    move-result-object v2

    move-object v9, v2

    goto :goto_6

    .line 158
    :cond_c
    if-eqz v14, :cond_d

    .line 159
    iget-object v2, v1, Lcom/alibaba/sdk/android/oss/network/OSSRequestTask;->message:Lcom/alibaba/sdk/android/oss/internal/RequestMessage;

    invoke-virtual {v2}, Lcom/alibaba/sdk/android/oss/internal/RequestMessage;->getMethod()Lcom/alibaba/sdk/android/oss/common/HttpMethod;

    move-result-object v2

    invoke-virtual {v2}, Lcom/alibaba/sdk/android/oss/common/HttpMethod;->toString()Ljava/lang/String;

    move-result-object v2

    .line 160
    invoke-static {v11}, Lokhttp3/MediaType;->parse(Ljava/lang/String;)Lokhttp3/MediaType;

    move-result-object v13

    const-string v15, "UTF-8"

    invoke-virtual {v14, v15}, Ljava/lang/String;->getBytes(Ljava/lang/String;)[B

    move-result-object v15

    invoke-static {v13, v15}, Lokhttp3/RequestBody;->create(Lokhttp3/MediaType;[B)Lokhttp3/RequestBody;

    move-result-object v13

    .line 159
    invoke-virtual {v9, v2, v13}, Lokhttp3/Request$Builder;->method(Ljava/lang/String;Lokhttp3/RequestBody;)Lokhttp3/Request$Builder;

    move-result-object v2

    move-object v9, v2

    goto :goto_6

    .line 162
    :cond_d
    iget-object v2, v1, Lcom/alibaba/sdk/android/oss/network/OSSRequestTask;->message:Lcom/alibaba/sdk/android/oss/internal/RequestMessage;

    invoke-virtual {v2}, Lcom/alibaba/sdk/android/oss/internal/RequestMessage;->getMethod()Lcom/alibaba/sdk/android/oss/common/HttpMethod;

    move-result-object v2

    invoke-virtual {v2}, Lcom/alibaba/sdk/android/oss/common/HttpMethod;->toString()Ljava/lang/String;

    move-result-object v2

    const/4 v13, 0x0

    new-array v15, v13, [B

    .line 163
    const/4 v13, 0x0

    invoke-static {v13, v15}, Lokhttp3/RequestBody;->create(Lokhttp3/MediaType;[B)Lokhttp3/RequestBody;

    move-result-object v15

    .line 162
    invoke-virtual {v9, v2, v15}, Lokhttp3/Request$Builder;->method(Ljava/lang/String;Lokhttp3/RequestBody;)Lokhttp3/Request$Builder;

    move-result-object v2
    :try_end_f
    .catch Ljava/lang/Exception; {:try_start_f .. :try_end_f} :catch_1

    move-object v9, v2

    .line 165
    goto :goto_6

    .line 209
    .end local v6    # "length":J
    .end local v8    # "ossRequest":Lcom/alibaba/sdk/android/oss/model/OSSRequest;
    .end local v9    # "requestBuilder":Lokhttp3/Request$Builder;
    .end local v10    # "url":Ljava/lang/String;
    .end local v11    # "contentType":Ljava/lang/String;
    .end local v12    # "inputStream":Ljava/io/InputStream;
    .end local v14    # "stringBody":Ljava/lang/String;
    :catch_1
    move-exception v0

    move-object/from16 v19, v3

    move-object/from16 v20, v4

    move-object/from16 v2, v18

    goto/16 :goto_9

    .end local v18    # "request":Lokhttp3/Request;
    .restart local v2    # "request":Lokhttp3/Request;
    :catch_2
    move-exception v0

    move-object/from16 v18, v2

    move-object/from16 v19, v3

    move-object/from16 v20, v4

    .end local v2    # "request":Lokhttp3/Request;
    .restart local v18    # "request":Lokhttp3/Request;
    goto/16 :goto_9

    .line 179
    .restart local v8    # "ossRequest":Lcom/alibaba/sdk/android/oss/model/OSSRequest;
    .restart local v9    # "requestBuilder":Lokhttp3/Request$Builder;
    .restart local v10    # "url":Ljava/lang/String;
    .restart local v11    # "contentType":Ljava/lang/String;
    :goto_6
    :try_start_10
    invoke-virtual {v9}, Lokhttp3/Request$Builder;->build()Lokhttp3/Request;

    move-result-object v2
    :try_end_10
    .catch Ljava/lang/Exception; {:try_start_10 .. :try_end_10} :catch_7

    .line 181
    .end local v18    # "request":Lokhttp3/Request;
    .restart local v2    # "request":Lokhttp3/Request;
    :try_start_11
    instance-of v6, v8, Lcom/alibaba/sdk/android/oss/model/GetObjectRequest;
    :try_end_11
    .catch Ljava/lang/Exception; {:try_start_11 .. :try_end_11} :catch_6

    if-eqz v6, :cond_e

    .line 182
    :try_start_12
    iget-object v6, v1, Lcom/alibaba/sdk/android/oss/network/OSSRequestTask;->client:Lokhttp3/OkHttpClient;

    iget-object v7, v1, Lcom/alibaba/sdk/android/oss/network/OSSRequestTask;->context:Lcom/alibaba/sdk/android/oss/network/ExecutionContext;

    invoke-static {v6, v7}, Lcom/alibaba/sdk/android/oss/network/NetworkProgressHelper;->addProgressResponseListener(Lokhttp3/OkHttpClient;Lcom/alibaba/sdk/android/oss/network/ExecutionContext;)Lokhttp3/OkHttpClient;

    move-result-object v6

    iput-object v6, v1, Lcom/alibaba/sdk/android/oss/network/OSSRequestTask;->client:Lokhttp3/OkHttpClient;

    .line 183
    const-string v6, "getObject"

    invoke-static {v6}, Lcom/alibaba/sdk/android/oss/common/OSSLog;->logDebug(Ljava/lang/String;)V
    :try_end_12
    .catch Ljava/lang/Exception; {:try_start_12 .. :try_end_12} :catch_0

    .line 186
    :cond_e
    :try_start_13
    iget-object v6, v1, Lcom/alibaba/sdk/android/oss/network/OSSRequestTask;->client:Lokhttp3/OkHttpClient;

    invoke-virtual {v6, v2}, Lokhttp3/OkHttpClient;->newCall(Lokhttp3/Request;)Lokhttp3/Call;

    move-result-object v6

    move-object v5, v6

    .line 188
    iget-object v6, v1, Lcom/alibaba/sdk/android/oss/network/OSSRequestTask;->context:Lcom/alibaba/sdk/android/oss/network/ExecutionContext;

    invoke-virtual {v6}, Lcom/alibaba/sdk/android/oss/network/ExecutionContext;->getCancellationHandler()Lcom/alibaba/sdk/android/oss/network/CancellationHandler;

    move-result-object v6

    invoke-virtual {v6, v5}, Lcom/alibaba/sdk/android/oss/network/CancellationHandler;->setCall(Lokhttp3/Call;)V

    .line 191
    invoke-interface {v5}, Lokhttp3/Call;->execute()Lokhttp3/Response;

    move-result-object v6

    .line 193
    .local v6, "response":Lokhttp3/Response;
    invoke-static {}, Lcom/alibaba/sdk/android/oss/common/OSSLog;->isEnableLog()Z

    move-result v7

    if-eqz v7, :cond_10

    .line 195
    invoke-virtual {v6}, Lokhttp3/Response;->headers()Lokhttp3/Headers;

    move-result-object v7

    invoke-virtual {v7}, Lokhttp3/Headers;->toMultimap()Ljava/util/Map;

    move-result-object v7

    .line 196
    .local v7, "headerMap":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/util/List<Ljava/lang/String;>;>;"
    new-instance v12, Ljava/lang/StringBuilder;

    invoke-direct {v12}, Ljava/lang/StringBuilder;-><init>()V

    .line 197
    .local v12, "printRsp":Ljava/lang/StringBuilder;
    const-string v13, "response:---------------------\n"

    invoke-virtual {v12, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 198
    new-instance v13, Ljava/lang/StringBuilder;

    invoke-direct {v13}, Ljava/lang/StringBuilder;-><init>()V

    const-string v14, "response code: "

    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    invoke-virtual {v6}, Lokhttp3/Response;->code()I

    move-result v14

    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v13

    const-string v14, " for url: "

    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    invoke-virtual {v2}, Lokhttp3/Request;->url()Lokhttp3/HttpUrl;

    move-result-object v14

    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v13

    invoke-virtual {v13, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    invoke-virtual {v13}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v13

    invoke-virtual {v12, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 200
    invoke-interface {v7}, Ljava/util/Map;->keySet()Ljava/util/Set;

    move-result-object v13

    invoke-interface {v13}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v13

    :goto_7
    invoke-interface {v13}, Ljava/util/Iterator;->hasNext()Z

    move-result v14

    if-eqz v14, :cond_f

    invoke-interface {v13}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v14

    check-cast v14, Ljava/lang/String;

    .line 201
    .local v14, "key":Ljava/lang/String;
    new-instance v15, Ljava/lang/StringBuilder;

    invoke-direct {v15}, Ljava/lang/StringBuilder;-><init>()V
    :try_end_13
    .catch Ljava/lang/Exception; {:try_start_13 .. :try_end_13} :catch_6

    move-object/from16 v16, v2

    .end local v2    # "request":Lokhttp3/Request;
    .local v16, "request":Lokhttp3/Request;
    :try_start_14
    const-string v2, "responseHeader ["

    invoke-virtual {v15, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v15, "]: "

    invoke-virtual {v2, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v12, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    new-instance v15, Ljava/lang/StringBuilder;

    invoke-direct {v15}, Ljava/lang/StringBuilder;-><init>()V

    invoke-interface {v7, v14}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v18
    :try_end_14
    .catch Ljava/lang/Exception; {:try_start_14 .. :try_end_14} :catch_4

    move-object/from16 v19, v3

    .end local v3    # "responseMessage":Lcom/alibaba/sdk/android/oss/internal/ResponseMessage;
    .local v19, "responseMessage":Lcom/alibaba/sdk/android/oss/internal/ResponseMessage;
    :try_start_15
    move-object/from16 v3, v18

    check-cast v3, Ljava/util/List;
    :try_end_15
    .catch Ljava/lang/Exception; {:try_start_15 .. :try_end_15} :catch_3

    move-object/from16 v20, v4

    const/4 v4, 0x0

    .end local v4    # "exception":Ljava/lang/Exception;
    .local v20, "exception":Ljava/lang/Exception;
    :try_start_16
    invoke-interface {v3, v4}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/String;

    invoke-virtual {v15, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 202
    move-object/from16 v2, v16

    move-object/from16 v3, v19

    move-object/from16 v4, v20

    .end local v14    # "key":Ljava/lang/String;
    goto :goto_7

    .line 209
    .end local v6    # "response":Lokhttp3/Response;
    .end local v7    # "headerMap":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/util/List<Ljava/lang/String;>;>;"
    .end local v8    # "ossRequest":Lcom/alibaba/sdk/android/oss/model/OSSRequest;
    .end local v9    # "requestBuilder":Lokhttp3/Request$Builder;
    .end local v10    # "url":Ljava/lang/String;
    .end local v11    # "contentType":Ljava/lang/String;
    .end local v12    # "printRsp":Ljava/lang/StringBuilder;
    .end local v20    # "exception":Ljava/lang/Exception;
    .restart local v4    # "exception":Ljava/lang/Exception;
    :catch_3
    move-exception v0

    move-object/from16 v20, v4

    move-object/from16 v2, v16

    .end local v4    # "exception":Ljava/lang/Exception;
    .restart local v20    # "exception":Ljava/lang/Exception;
    goto/16 :goto_9

    .end local v19    # "responseMessage":Lcom/alibaba/sdk/android/oss/internal/ResponseMessage;
    .end local v20    # "exception":Ljava/lang/Exception;
    .restart local v3    # "responseMessage":Lcom/alibaba/sdk/android/oss/internal/ResponseMessage;
    .restart local v4    # "exception":Ljava/lang/Exception;
    :catch_4
    move-exception v0

    move-object/from16 v19, v3

    move-object/from16 v20, v4

    move-object/from16 v2, v16

    .end local v3    # "responseMessage":Lcom/alibaba/sdk/android/oss/internal/ResponseMessage;
    .end local v4    # "exception":Ljava/lang/Exception;
    .restart local v19    # "responseMessage":Lcom/alibaba/sdk/android/oss/internal/ResponseMessage;
    .restart local v20    # "exception":Ljava/lang/Exception;
    goto :goto_9

    .line 203
    .end local v16    # "request":Lokhttp3/Request;
    .end local v19    # "responseMessage":Lcom/alibaba/sdk/android/oss/internal/ResponseMessage;
    .end local v20    # "exception":Ljava/lang/Exception;
    .restart local v2    # "request":Lokhttp3/Request;
    .restart local v3    # "responseMessage":Lcom/alibaba/sdk/android/oss/internal/ResponseMessage;
    .restart local v4    # "exception":Ljava/lang/Exception;
    .restart local v6    # "response":Lokhttp3/Response;
    .restart local v7    # "headerMap":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/util/List<Ljava/lang/String;>;>;"
    .restart local v8    # "ossRequest":Lcom/alibaba/sdk/android/oss/model/OSSRequest;
    .restart local v9    # "requestBuilder":Lokhttp3/Request$Builder;
    .restart local v10    # "url":Ljava/lang/String;
    .restart local v11    # "contentType":Ljava/lang/String;
    .restart local v12    # "printRsp":Ljava/lang/StringBuilder;
    :cond_f
    move-object/from16 v16, v2

    move-object/from16 v19, v3

    move-object/from16 v20, v4

    .end local v2    # "request":Lokhttp3/Request;
    .end local v3    # "responseMessage":Lcom/alibaba/sdk/android/oss/internal/ResponseMessage;
    .end local v4    # "exception":Ljava/lang/Exception;
    .restart local v16    # "request":Lokhttp3/Request;
    .restart local v19    # "responseMessage":Lcom/alibaba/sdk/android/oss/internal/ResponseMessage;
    .restart local v20    # "exception":Ljava/lang/Exception;
    invoke-virtual {v12}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/alibaba/sdk/android/oss/common/OSSLog;->logDebug(Ljava/lang/String;)V

    goto :goto_8

    .line 193
    .end local v7    # "headerMap":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/util/List<Ljava/lang/String;>;>;"
    .end local v12    # "printRsp":Ljava/lang/StringBuilder;
    .end local v16    # "request":Lokhttp3/Request;
    .end local v19    # "responseMessage":Lcom/alibaba/sdk/android/oss/internal/ResponseMessage;
    .end local v20    # "exception":Ljava/lang/Exception;
    .restart local v2    # "request":Lokhttp3/Request;
    .restart local v3    # "responseMessage":Lcom/alibaba/sdk/android/oss/internal/ResponseMessage;
    .restart local v4    # "exception":Ljava/lang/Exception;
    :cond_10
    move-object/from16 v16, v2

    move-object/from16 v19, v3

    move-object/from16 v20, v4

    .line 207
    .end local v2    # "request":Lokhttp3/Request;
    .end local v3    # "responseMessage":Lcom/alibaba/sdk/android/oss/internal/ResponseMessage;
    .end local v4    # "exception":Ljava/lang/Exception;
    .restart local v16    # "request":Lokhttp3/Request;
    .restart local v19    # "responseMessage":Lcom/alibaba/sdk/android/oss/internal/ResponseMessage;
    .restart local v20    # "exception":Ljava/lang/Exception;
    :goto_8
    iget-object v0, v1, Lcom/alibaba/sdk/android/oss/network/OSSRequestTask;->message:Lcom/alibaba/sdk/android/oss/internal/RequestMessage;

    invoke-direct {v1, v0, v6}, Lcom/alibaba/sdk/android/oss/network/OSSRequestTask;->buildResponseMessage(Lcom/alibaba/sdk/android/oss/internal/RequestMessage;Lokhttp3/Response;)Lcom/alibaba/sdk/android/oss/internal/ResponseMessage;

    move-result-object v0
    :try_end_16
    .catch Ljava/lang/Exception; {:try_start_16 .. :try_end_16} :catch_5

    move-object v3, v0

    .line 215
    .end local v6    # "response":Lokhttp3/Response;
    .end local v8    # "ossRequest":Lcom/alibaba/sdk/android/oss/model/OSSRequest;
    .end local v9    # "requestBuilder":Lokhttp3/Request$Builder;
    .end local v10    # "url":Ljava/lang/String;
    .end local v11    # "contentType":Ljava/lang/String;
    .end local v19    # "responseMessage":Lcom/alibaba/sdk/android/oss/internal/ResponseMessage;
    .restart local v3    # "responseMessage":Lcom/alibaba/sdk/android/oss/internal/ResponseMessage;
    move-object/from16 v2, v16

    move-object/from16 v4, v20

    goto :goto_a

    .line 209
    .end local v3    # "responseMessage":Lcom/alibaba/sdk/android/oss/internal/ResponseMessage;
    .restart local v19    # "responseMessage":Lcom/alibaba/sdk/android/oss/internal/ResponseMessage;
    :catch_5
    move-exception v0

    move-object/from16 v2, v16

    goto :goto_9

    .end local v16    # "request":Lokhttp3/Request;
    .end local v19    # "responseMessage":Lcom/alibaba/sdk/android/oss/internal/ResponseMessage;
    .end local v20    # "exception":Ljava/lang/Exception;
    .restart local v2    # "request":Lokhttp3/Request;
    .restart local v3    # "responseMessage":Lcom/alibaba/sdk/android/oss/internal/ResponseMessage;
    .restart local v4    # "exception":Ljava/lang/Exception;
    :catch_6
    move-exception v0

    move-object/from16 v16, v2

    move-object/from16 v19, v3

    move-object/from16 v20, v4

    .end local v2    # "request":Lokhttp3/Request;
    .end local v3    # "responseMessage":Lcom/alibaba/sdk/android/oss/internal/ResponseMessage;
    .end local v4    # "exception":Ljava/lang/Exception;
    .restart local v16    # "request":Lokhttp3/Request;
    .restart local v19    # "responseMessage":Lcom/alibaba/sdk/android/oss/internal/ResponseMessage;
    .restart local v20    # "exception":Ljava/lang/Exception;
    goto :goto_9

    .end local v16    # "request":Lokhttp3/Request;
    .end local v19    # "responseMessage":Lcom/alibaba/sdk/android/oss/internal/ResponseMessage;
    .end local v20    # "exception":Ljava/lang/Exception;
    .restart local v3    # "responseMessage":Lcom/alibaba/sdk/android/oss/internal/ResponseMessage;
    .restart local v4    # "exception":Ljava/lang/Exception;
    .restart local v18    # "request":Lokhttp3/Request;
    :catch_7
    move-exception v0

    move-object/from16 v19, v3

    move-object/from16 v20, v4

    move-object/from16 v2, v18

    .end local v3    # "responseMessage":Lcom/alibaba/sdk/android/oss/internal/ResponseMessage;
    .end local v4    # "exception":Ljava/lang/Exception;
    .restart local v19    # "responseMessage":Lcom/alibaba/sdk/android/oss/internal/ResponseMessage;
    .restart local v20    # "exception":Ljava/lang/Exception;
    goto :goto_9

    .line 92
    .end local v18    # "request":Lokhttp3/Request;
    .end local v19    # "responseMessage":Lcom/alibaba/sdk/android/oss/internal/ResponseMessage;
    .end local v20    # "exception":Ljava/lang/Exception;
    .restart local v2    # "request":Lokhttp3/Request;
    .restart local v3    # "responseMessage":Lcom/alibaba/sdk/android/oss/internal/ResponseMessage;
    .restart local v4    # "exception":Ljava/lang/Exception;
    .restart local v8    # "ossRequest":Lcom/alibaba/sdk/android/oss/model/OSSRequest;
    :cond_11
    move-object/from16 v18, v2

    move-object/from16 v19, v3

    move-object/from16 v20, v4

    .end local v2    # "request":Lokhttp3/Request;
    .end local v3    # "responseMessage":Lcom/alibaba/sdk/android/oss/internal/ResponseMessage;
    .end local v4    # "exception":Ljava/lang/Exception;
    .restart local v18    # "request":Lokhttp3/Request;
    .restart local v19    # "responseMessage":Lcom/alibaba/sdk/android/oss/internal/ResponseMessage;
    .restart local v20    # "exception":Ljava/lang/Exception;
    :try_start_17
    new-instance v0, Ljava/io/InterruptedIOException;

    const-string v2, "This task is cancelled!"

    invoke-direct {v0, v2}, Ljava/io/InterruptedIOException;-><init>(Ljava/lang/String;)V

    .end local v5    # "call":Lokhttp3/Call;
    .end local v18    # "request":Lokhttp3/Request;
    .end local v19    # "responseMessage":Lcom/alibaba/sdk/android/oss/internal/ResponseMessage;
    .end local v20    # "exception":Ljava/lang/Exception;
    throw v0
    :try_end_17
    .catch Ljava/lang/Exception; {:try_start_17 .. :try_end_17} :catch_8

    .line 209
    .end local v8    # "ossRequest":Lcom/alibaba/sdk/android/oss/model/OSSRequest;
    .restart local v5    # "call":Lokhttp3/Call;
    .restart local v18    # "request":Lokhttp3/Request;
    .restart local v19    # "responseMessage":Lcom/alibaba/sdk/android/oss/internal/ResponseMessage;
    .restart local v20    # "exception":Ljava/lang/Exception;
    :catch_8
    move-exception v0

    move-object/from16 v2, v18

    goto :goto_9

    .end local v18    # "request":Lokhttp3/Request;
    .end local v19    # "responseMessage":Lcom/alibaba/sdk/android/oss/internal/ResponseMessage;
    .end local v20    # "exception":Ljava/lang/Exception;
    .restart local v2    # "request":Lokhttp3/Request;
    .restart local v3    # "responseMessage":Lcom/alibaba/sdk/android/oss/internal/ResponseMessage;
    .restart local v4    # "exception":Ljava/lang/Exception;
    :catch_9
    move-exception v0

    move-object/from16 v18, v2

    move-object/from16 v19, v3

    move-object/from16 v20, v4

    .line 210
    .end local v3    # "responseMessage":Lcom/alibaba/sdk/android/oss/internal/ResponseMessage;
    .end local v4    # "exception":Ljava/lang/Exception;
    .local v0, "e":Ljava/lang/Exception;
    .restart local v19    # "responseMessage":Lcom/alibaba/sdk/android/oss/internal/ResponseMessage;
    .restart local v20    # "exception":Ljava/lang/Exception;
    :goto_9
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "Encounter local execpiton: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v0}, Ljava/lang/Exception;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Lcom/alibaba/sdk/android/oss/common/OSSLog;->logError(Ljava/lang/String;)V

    .line 211
    invoke-static {}, Lcom/alibaba/sdk/android/oss/common/OSSLog;->isEnableLog()Z

    move-result v3

    if-eqz v3, :cond_12

    .line 212
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    .line 214
    :cond_12
    new-instance v3, Lcom/alibaba/sdk/android/oss/ClientException;

    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v4

    invoke-direct {v3, v4, v0}, Lcom/alibaba/sdk/android/oss/ClientException;-><init>(Ljava/lang/String;Ljava/lang/Throwable;)V

    move-object v4, v3

    move-object/from16 v3, v19

    .line 217
    .end local v0    # "e":Ljava/lang/Exception;
    .end local v19    # "responseMessage":Lcom/alibaba/sdk/android/oss/internal/ResponseMessage;
    .end local v20    # "exception":Ljava/lang/Exception;
    .restart local v3    # "responseMessage":Lcom/alibaba/sdk/android/oss/internal/ResponseMessage;
    .restart local v4    # "exception":Ljava/lang/Exception;
    :goto_a
    if-nez v4, :cond_14

    invoke-virtual {v3}, Lcom/alibaba/sdk/android/oss/internal/ResponseMessage;->getStatusCode()I

    move-result v0

    const/16 v6, 0xcb

    if-eq v0, v6, :cond_13

    invoke-virtual {v3}, Lcom/alibaba/sdk/android/oss/internal/ResponseMessage;->getStatusCode()I

    move-result v0

    const/16 v6, 0x12c

    if-lt v0, v6, :cond_14

    .line 218
    :cond_13
    invoke-virtual {v2}, Lokhttp3/Request;->method()Ljava/lang/String;

    move-result-object v0

    const-string v6, "HEAD"

    invoke-virtual {v0, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    invoke-static {v3, v0}, Lcom/alibaba/sdk/android/oss/internal/ResponseParsers;->parseResponseErrorXML(Lcom/alibaba/sdk/android/oss/internal/ResponseMessage;Z)Ljava/lang/Exception;

    move-result-object v4

    goto :goto_b

    .line 219
    :cond_14
    if-nez v4, :cond_16

    .line 221
    :try_start_18
    iget-object v0, v1, Lcom/alibaba/sdk/android/oss/network/OSSRequestTask;->responseParser:Lcom/alibaba/sdk/android/oss/internal/ResponseParser;

    invoke-interface {v0, v3}, Lcom/alibaba/sdk/android/oss/internal/ResponseParser;->parse(Lcom/alibaba/sdk/android/oss/internal/ResponseMessage;)Lcom/alibaba/sdk/android/oss/model/OSSResult;

    move-result-object v0

    .line 223
    .local v0, "result":Lcom/alibaba/sdk/android/oss/model/OSSResult;, "TT;"
    iget-object v6, v1, Lcom/alibaba/sdk/android/oss/network/OSSRequestTask;->context:Lcom/alibaba/sdk/android/oss/network/ExecutionContext;

    invoke-virtual {v6}, Lcom/alibaba/sdk/android/oss/network/ExecutionContext;->getCompletedCallback()Lcom/alibaba/sdk/android/oss/callback/OSSCompletedCallback;

    move-result-object v6

    if-eqz v6, :cond_15

    .line 224
    iget-object v6, v1, Lcom/alibaba/sdk/android/oss/network/OSSRequestTask;->context:Lcom/alibaba/sdk/android/oss/network/ExecutionContext;

    invoke-virtual {v6}, Lcom/alibaba/sdk/android/oss/network/ExecutionContext;->getCompletedCallback()Lcom/alibaba/sdk/android/oss/callback/OSSCompletedCallback;

    move-result-object v6

    iget-object v7, v1, Lcom/alibaba/sdk/android/oss/network/OSSRequestTask;->context:Lcom/alibaba/sdk/android/oss/network/ExecutionContext;

    invoke-virtual {v7}, Lcom/alibaba/sdk/android/oss/network/ExecutionContext;->getRequest()Lcom/alibaba/sdk/android/oss/model/OSSRequest;

    move-result-object v7

    invoke-interface {v6, v7, v0}, Lcom/alibaba/sdk/android/oss/callback/OSSCompletedCallback;->onSuccess(Lcom/alibaba/sdk/android/oss/model/OSSRequest;Lcom/alibaba/sdk/android/oss/model/OSSResult;)V
    :try_end_18
    .catch Ljava/io/IOException; {:try_start_18 .. :try_end_18} :catch_a

    .line 226
    :cond_15
    return-object v0

    .line 227
    .end local v0    # "result":Lcom/alibaba/sdk/android/oss/model/OSSResult;, "TT;"
    :catch_a
    move-exception v0

    .line 228
    .local v0, "e":Ljava/io/IOException;
    new-instance v6, Lcom/alibaba/sdk/android/oss/ClientException;

    invoke-virtual {v0}, Ljava/io/IOException;->getMessage()Ljava/lang/String;

    move-result-object v7

    invoke-direct {v6, v7, v0}, Lcom/alibaba/sdk/android/oss/ClientException;-><init>(Ljava/lang/String;Ljava/lang/Throwable;)V

    move-object v4, v6

    .line 233
    .end local v0    # "e":Ljava/io/IOException;
    :cond_16
    :goto_b
    if-eqz v5, :cond_17

    invoke-interface {v5}, Lokhttp3/Call;->isCanceled()Z

    move-result v0

    if-nez v0, :cond_18

    :cond_17
    iget-object v0, v1, Lcom/alibaba/sdk/android/oss/network/OSSRequestTask;->context:Lcom/alibaba/sdk/android/oss/network/ExecutionContext;

    .line 234
    invoke-virtual {v0}, Lcom/alibaba/sdk/android/oss/network/ExecutionContext;->getCancellationHandler()Lcom/alibaba/sdk/android/oss/network/CancellationHandler;

    move-result-object v0

    invoke-virtual {v0}, Lcom/alibaba/sdk/android/oss/network/CancellationHandler;->isCancelled()Z

    move-result v0

    if-eqz v0, :cond_19

    .line 235
    :cond_18
    new-instance v0, Lcom/alibaba/sdk/android/oss/ClientException;

    invoke-virtual {v4}, Ljava/lang/Exception;->getCause()Ljava/lang/Throwable;

    move-result-object v6

    const/4 v7, 0x1

    invoke-static {v7}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v8

    const-string v7, "Task is cancelled!"

    invoke-direct {v0, v7, v6, v8}, Lcom/alibaba/sdk/android/oss/ClientException;-><init>(Ljava/lang/String;Ljava/lang/Throwable;Ljava/lang/Boolean;)V

    move-object v4, v0

    .line 238
    :cond_19
    iget-object v0, v1, Lcom/alibaba/sdk/android/oss/network/OSSRequestTask;->retryHandler:Lcom/alibaba/sdk/android/oss/internal/OSSRetryHandler;

    iget v6, v1, Lcom/alibaba/sdk/android/oss/network/OSSRequestTask;->currentRetryCount:I

    invoke-virtual {v0, v4, v6}, Lcom/alibaba/sdk/android/oss/internal/OSSRetryHandler;->shouldRetry(Ljava/lang/Exception;I)Lcom/alibaba/sdk/android/oss/internal/OSSRetryType;

    move-result-object v6

    .line 239
    .local v6, "retryType":Lcom/alibaba/sdk/android/oss/internal/OSSRetryType;
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "[run] - retry, retry type: "

    invoke-virtual {v0, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/alibaba/sdk/android/oss/common/OSSLog;->logError(Ljava/lang/String;)V

    .line 240
    sget-object v0, Lcom/alibaba/sdk/android/oss/internal/OSSRetryType;->OSSRetryTypeShouldRetry:Lcom/alibaba/sdk/android/oss/internal/OSSRetryType;

    if-ne v6, v0, :cond_1b

    .line 241
    iget v0, v1, Lcom/alibaba/sdk/android/oss/network/OSSRequestTask;->currentRetryCount:I

    const/4 v7, 0x1

    add-int/2addr v0, v7

    iput v0, v1, Lcom/alibaba/sdk/android/oss/network/OSSRequestTask;->currentRetryCount:I

    .line 242
    iget-object v0, v1, Lcom/alibaba/sdk/android/oss/network/OSSRequestTask;->context:Lcom/alibaba/sdk/android/oss/network/ExecutionContext;

    invoke-virtual {v0}, Lcom/alibaba/sdk/android/oss/network/ExecutionContext;->getRetryCallback()Lcom/alibaba/sdk/android/oss/callback/OSSRetryCallback;

    move-result-object v0

    if-eqz v0, :cond_1a

    .line 243
    iget-object v0, v1, Lcom/alibaba/sdk/android/oss/network/OSSRequestTask;->context:Lcom/alibaba/sdk/android/oss/network/ExecutionContext;

    invoke-virtual {v0}, Lcom/alibaba/sdk/android/oss/network/ExecutionContext;->getRetryCallback()Lcom/alibaba/sdk/android/oss/callback/OSSRetryCallback;

    move-result-object v0

    invoke-interface {v0}, Lcom/alibaba/sdk/android/oss/callback/OSSRetryCallback;->onRetryCallback()V

    .line 247
    :cond_1a
    :try_start_19
    iget-object v0, v1, Lcom/alibaba/sdk/android/oss/network/OSSRequestTask;->retryHandler:Lcom/alibaba/sdk/android/oss/internal/OSSRetryHandler;

    iget v7, v1, Lcom/alibaba/sdk/android/oss/network/OSSRequestTask;->currentRetryCount:I

    invoke-virtual {v0, v7, v6}, Lcom/alibaba/sdk/android/oss/internal/OSSRetryHandler;->timeInterval(ILcom/alibaba/sdk/android/oss/internal/OSSRetryType;)J

    move-result-wide v7

    invoke-static {v7, v8}, Ljava/lang/Thread;->sleep(J)V
    :try_end_19
    .catch Ljava/lang/InterruptedException; {:try_start_19 .. :try_end_19} :catch_b

    .line 251
    goto :goto_c

    .line 248
    :catch_b
    move-exception v0

    .line 249
    .local v0, "e":Ljava/lang/InterruptedException;
    invoke-static {}, Ljava/lang/Thread;->currentThread()Ljava/lang/Thread;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/Thread;->interrupt()V

    .line 250
    invoke-virtual {v0}, Ljava/lang/InterruptedException;->printStackTrace()V

    .line 253
    .end local v0    # "e":Ljava/lang/InterruptedException;
    :goto_c
    invoke-virtual/range {p0 .. p0}, Lcom/alibaba/sdk/android/oss/network/OSSRequestTask;->call()Lcom/alibaba/sdk/android/oss/model/OSSResult;

    move-result-object v0

    return-object v0

    .line 254
    :cond_1b
    sget-object v0, Lcom/alibaba/sdk/android/oss/internal/OSSRetryType;->OSSRetryTypeShouldFixedTimeSkewedAndRetry:Lcom/alibaba/sdk/android/oss/internal/OSSRetryType;

    if-ne v6, v0, :cond_1e

    .line 256
    if-eqz v3, :cond_1c

    .line 257
    invoke-virtual {v3}, Lcom/alibaba/sdk/android/oss/internal/ResponseMessage;->getHeaders()Ljava/util/Map;

    move-result-object v0

    const-string v7, "Date"

    invoke-interface {v0, v7}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    move-object v8, v0

    check-cast v8, Ljava/lang/String;

    .line 260
    .local v8, "responseDateString":Ljava/lang/String;
    :try_start_1a
    invoke-static {v8}, Lcom/alibaba/sdk/android/oss/common/utils/DateUtil;->parseRfc822Date(Ljava/lang/String;)Ljava/util/Date;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/Date;->getTime()J

    move-result-wide v9

    .line 261
    .local v9, "serverTime":J
    invoke-static {v9, v10}, Lcom/alibaba/sdk/android/oss/common/utils/DateUtil;->setCurrentServerTime(J)V

    .line 262
    iget-object v0, v1, Lcom/alibaba/sdk/android/oss/network/OSSRequestTask;->message:Lcom/alibaba/sdk/android/oss/internal/RequestMessage;

    invoke-virtual {v0}, Lcom/alibaba/sdk/android/oss/internal/RequestMessage;->getHeaders()Ljava/util/Map;

    move-result-object v0

    invoke-interface {v0, v7, v8}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_1a
    .catch Ljava/lang/Exception; {:try_start_1a .. :try_end_1a} :catch_c

    .line 266
    nop

    .end local v9    # "serverTime":J
    goto :goto_d

    .line 263
    :catch_c
    move-exception v0

    .line 265
    .local v0, "ignore":Ljava/lang/Exception;
    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, "[error] - synchronize time, reponseDate:"

    invoke-virtual {v7, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v7}, Lcom/alibaba/sdk/android/oss/common/OSSLog;->logError(Ljava/lang/String;)V

    .line 269
    .end local v0    # "ignore":Ljava/lang/Exception;
    .end local v8    # "responseDateString":Ljava/lang/String;
    :cond_1c
    :goto_d
    iget v0, v1, Lcom/alibaba/sdk/android/oss/network/OSSRequestTask;->currentRetryCount:I

    const/4 v7, 0x1

    add-int/2addr v0, v7

    iput v0, v1, Lcom/alibaba/sdk/android/oss/network/OSSRequestTask;->currentRetryCount:I

    .line 270
    iget-object v0, v1, Lcom/alibaba/sdk/android/oss/network/OSSRequestTask;->context:Lcom/alibaba/sdk/android/oss/network/ExecutionContext;

    invoke-virtual {v0}, Lcom/alibaba/sdk/android/oss/network/ExecutionContext;->getRetryCallback()Lcom/alibaba/sdk/android/oss/callback/OSSRetryCallback;

    move-result-object v0

    if-eqz v0, :cond_1d

    .line 271
    iget-object v0, v1, Lcom/alibaba/sdk/android/oss/network/OSSRequestTask;->context:Lcom/alibaba/sdk/android/oss/network/ExecutionContext;

    invoke-virtual {v0}, Lcom/alibaba/sdk/android/oss/network/ExecutionContext;->getRetryCallback()Lcom/alibaba/sdk/android/oss/callback/OSSRetryCallback;

    move-result-object v0

    invoke-interface {v0}, Lcom/alibaba/sdk/android/oss/callback/OSSRetryCallback;->onRetryCallback()V

    .line 273
    :cond_1d
    invoke-virtual/range {p0 .. p0}, Lcom/alibaba/sdk/android/oss/network/OSSRequestTask;->call()Lcom/alibaba/sdk/android/oss/model/OSSResult;

    move-result-object v0

    return-object v0

    .line 275
    :cond_1e
    instance-of v0, v4, Lcom/alibaba/sdk/android/oss/ClientException;

    if-eqz v0, :cond_1f

    .line 276
    iget-object v0, v1, Lcom/alibaba/sdk/android/oss/network/OSSRequestTask;->context:Lcom/alibaba/sdk/android/oss/network/ExecutionContext;

    invoke-virtual {v0}, Lcom/alibaba/sdk/android/oss/network/ExecutionContext;->getCompletedCallback()Lcom/alibaba/sdk/android/oss/callback/OSSCompletedCallback;

    move-result-object v0

    if-eqz v0, :cond_20

    .line 277
    iget-object v0, v1, Lcom/alibaba/sdk/android/oss/network/OSSRequestTask;->context:Lcom/alibaba/sdk/android/oss/network/ExecutionContext;

    invoke-virtual {v0}, Lcom/alibaba/sdk/android/oss/network/ExecutionContext;->getCompletedCallback()Lcom/alibaba/sdk/android/oss/callback/OSSCompletedCallback;

    move-result-object v0

    iget-object v7, v1, Lcom/alibaba/sdk/android/oss/network/OSSRequestTask;->context:Lcom/alibaba/sdk/android/oss/network/ExecutionContext;

    invoke-virtual {v7}, Lcom/alibaba/sdk/android/oss/network/ExecutionContext;->getRequest()Lcom/alibaba/sdk/android/oss/model/OSSRequest;

    move-result-object v7

    move-object v8, v4

    check-cast v8, Lcom/alibaba/sdk/android/oss/ClientException;

    const/4 v9, 0x0

    invoke-interface {v0, v7, v8, v9}, Lcom/alibaba/sdk/android/oss/callback/OSSCompletedCallback;->onFailure(Lcom/alibaba/sdk/android/oss/model/OSSRequest;Lcom/alibaba/sdk/android/oss/ClientException;Lcom/alibaba/sdk/android/oss/ServiceException;)V

    goto :goto_e

    .line 280
    :cond_1f
    iget-object v0, v1, Lcom/alibaba/sdk/android/oss/network/OSSRequestTask;->context:Lcom/alibaba/sdk/android/oss/network/ExecutionContext;

    invoke-virtual {v0}, Lcom/alibaba/sdk/android/oss/network/ExecutionContext;->getCompletedCallback()Lcom/alibaba/sdk/android/oss/callback/OSSCompletedCallback;

    move-result-object v0

    if-eqz v0, :cond_20

    .line 281
    iget-object v0, v1, Lcom/alibaba/sdk/android/oss/network/OSSRequestTask;->context:Lcom/alibaba/sdk/android/oss/network/ExecutionContext;

    invoke-virtual {v0}, Lcom/alibaba/sdk/android/oss/network/ExecutionContext;->getCompletedCallback()Lcom/alibaba/sdk/android/oss/callback/OSSCompletedCallback;

    move-result-object v0

    iget-object v7, v1, Lcom/alibaba/sdk/android/oss/network/OSSRequestTask;->context:Lcom/alibaba/sdk/android/oss/network/ExecutionContext;

    invoke-virtual {v7}, Lcom/alibaba/sdk/android/oss/network/ExecutionContext;->getRequest()Lcom/alibaba/sdk/android/oss/model/OSSRequest;

    move-result-object v7

    move-object v8, v4

    check-cast v8, Lcom/alibaba/sdk/android/oss/ServiceException;

    const/4 v9, 0x0

    invoke-interface {v0, v7, v9, v8}, Lcom/alibaba/sdk/android/oss/callback/OSSCompletedCallback;->onFailure(Lcom/alibaba/sdk/android/oss/model/OSSRequest;Lcom/alibaba/sdk/android/oss/ClientException;Lcom/alibaba/sdk/android/oss/ServiceException;)V

    .line 284
    :cond_20
    :goto_e
    throw v4

    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_3
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method public bridge synthetic call()Ljava/lang/Object;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 47
    .local p0, "this":Lcom/alibaba/sdk/android/oss/network/OSSRequestTask;, "Lcom/alibaba/sdk/android/oss/network/OSSRequestTask<TT;>;"
    invoke-virtual {p0}, Lcom/alibaba/sdk/android/oss/network/OSSRequestTask;->call()Lcom/alibaba/sdk/android/oss/model/OSSResult;

    move-result-object v0

    return-object v0
.end method
