.class public Lcom/amazonaws/handlers/HandlerChainFactory;
.super Ljava/lang/Object;
.source "HandlerChainFactory.java"


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 32
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private createRequestHandlerChain(Ljava/lang/String;Ljava/lang/Class;)Ljava/util/List;
    .locals 9
    .param p1, "resource"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/lang/Class<",
            "*>;)",
            "Ljava/util/List<",
            "Lcom/amazonaws/handlers/RequestHandler2;",
            ">;"
        }
    .end annotation

    .line 64
    .local p2, "handlerApiClass":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    .line 65
    .local v0, "handlers":Ljava/util/List;, "Ljava/util/List<Lcom/amazonaws/handlers/RequestHandler2;>;"
    const/4 v1, 0x0

    .line 68
    .local v1, "reader":Ljava/io/BufferedReader;
    :try_start_0
    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/Class;->getResourceAsStream(Ljava/lang/String;)Ljava/io/InputStream;

    move-result-object v2
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_2
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 69
    .local v2, "input":Ljava/io/InputStream;
    if-nez v2, :cond_1

    .line 70
    nop

    .line 109
    if-eqz v1, :cond_0

    .line 110
    :try_start_1
    invoke-virtual {v1}, Ljava/io/BufferedReader;->close()V
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_0

    .line 112
    :catch_0
    move-exception v3

    goto :goto_1

    .line 113
    :cond_0
    :goto_0
    nop

    .line 70
    :goto_1
    return-object v0

    .line 72
    :cond_1
    :try_start_2
    new-instance v3, Ljava/io/BufferedReader;

    new-instance v4, Ljava/io/InputStreamReader;

    sget-object v5, Lcom/amazonaws/util/StringUtils;->UTF8:Ljava/nio/charset/Charset;

    invoke-direct {v4, v2, v5}, Ljava/io/InputStreamReader;-><init>(Ljava/io/InputStream;Ljava/nio/charset/Charset;)V

    invoke-direct {v3, v4}, Ljava/io/BufferedReader;-><init>(Ljava/io/Reader;)V

    move-object v1, v3

    .line 74
    :goto_2
    invoke-virtual {v1}, Ljava/io/BufferedReader;->readLine()Ljava/lang/String;

    move-result-object v3
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 75
    .local v3, "requestHandlerClassName":Ljava/lang/String;
    if-nez v3, :cond_2

    .line 76
    nop

    .line 109
    .end local v2    # "input":Ljava/io/InputStream;
    .end local v3    # "requestHandlerClassName":Ljava/lang/String;
    nop

    .line 110
    :try_start_3
    invoke-virtual {v1}, Ljava/io/BufferedReader;->close()V
    :try_end_3
    .catch Ljava/io/IOException; {:try_start_3 .. :try_end_3} :catch_1

    .line 113
    goto :goto_3

    .line 112
    :catch_1
    move-exception v2

    .line 114
    nop

    .line 115
    :goto_3
    return-object v0

    .line 77
    .restart local v2    # "input":Ljava/io/InputStream;
    .restart local v3    # "requestHandlerClassName":Ljava/lang/String;
    :cond_2
    :try_start_4
    invoke-virtual {v3}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v4

    move-object v3, v4

    .line 78
    const-string v4, ""

    invoke-virtual {v4, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_3

    .line 79
    goto :goto_2

    .line 80
    :cond_3
    const/4 v4, 0x2

    new-array v4, v4, [Ljava/lang/Class;

    const/4 v5, 0x0

    aput-object p2, v4, v5

    .line 82
    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v5

    const/4 v6, 0x1

    aput-object v5, v4, v6

    .line 80
    invoke-static {v3, v4}, Lcom/amazonaws/util/ClassLoaderHelper;->loadClass(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/Class;

    move-result-object v4

    .line 83
    .local v4, "requestHandlerClass":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    invoke-virtual {v4}, Ljava/lang/Class;->newInstance()Ljava/lang/Object;

    move-result-object v5

    .line 84
    .local v5, "requestHandlerObject":Ljava/lang/Object;
    invoke-virtual {p2, v5}, Ljava/lang/Class;->isInstance(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_6

    .line 85
    const-class v6, Lcom/amazonaws/handlers/RequestHandler2;

    if-ne p2, v6, :cond_4

    .line 86
    move-object v6, v5

    check-cast v6, Lcom/amazonaws/handlers/RequestHandler2;

    .line 87
    .local v6, "h":Lcom/amazonaws/handlers/RequestHandler2;
    invoke-interface {v0, v6}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 88
    nop

    .end local v6    # "h":Lcom/amazonaws/handlers/RequestHandler2;
    goto :goto_4

    :cond_4
    const-class v6, Lcom/amazonaws/handlers/RequestHandler;

    if-ne p2, v6, :cond_5

    .line 89
    move-object v6, v5

    check-cast v6, Lcom/amazonaws/handlers/RequestHandler;

    .line 90
    .local v6, "h":Lcom/amazonaws/handlers/RequestHandler;
    invoke-static {v6}, Lcom/amazonaws/handlers/RequestHandler2;->adapt(Lcom/amazonaws/handlers/RequestHandler;)Lcom/amazonaws/handlers/RequestHandler2;

    move-result-object v7

    invoke-interface {v0, v7}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 91
    nop

    .line 102
    .end local v3    # "requestHandlerClassName":Ljava/lang/String;
    .end local v4    # "requestHandlerClass":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    .end local v5    # "requestHandlerObject":Ljava/lang/Object;
    .end local v6    # "h":Lcom/amazonaws/handlers/RequestHandler;
    :goto_4
    goto :goto_2

    .line 92
    .restart local v3    # "requestHandlerClassName":Ljava/lang/String;
    .restart local v4    # "requestHandlerClass":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    .restart local v5    # "requestHandlerObject":Ljava/lang/Object;
    :cond_5
    new-instance v6, Ljava/lang/IllegalStateException;

    invoke-direct {v6}, Ljava/lang/IllegalStateException;-><init>()V

    .end local v0    # "handlers":Ljava/util/List;, "Ljava/util/List<Lcom/amazonaws/handlers/RequestHandler2;>;"
    .end local v1    # "reader":Ljava/io/BufferedReader;
    .end local p1    # "resource":Ljava/lang/String;
    .end local p2    # "handlerApiClass":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    throw v6

    .line 95
    .restart local v0    # "handlers":Ljava/util/List;, "Ljava/util/List<Lcom/amazonaws/handlers/RequestHandler2;>;"
    .restart local v1    # "reader":Ljava/io/BufferedReader;
    .restart local p1    # "resource":Ljava/lang/String;
    .restart local p2    # "handlerApiClass":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    :cond_6
    new-instance v6, Lcom/amazonaws/AmazonClientException;

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "Unable to instantiate request handler chain for client.  Listed request handler (\'"

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v8, "\') does not implement the "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v8, " API."

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-direct {v6, v7}, Lcom/amazonaws/AmazonClientException;-><init>(Ljava/lang/String;)V

    .end local v0    # "handlers":Ljava/util/List;, "Ljava/util/List<Lcom/amazonaws/handlers/RequestHandler2;>;"
    .end local v1    # "reader":Ljava/io/BufferedReader;
    .end local p1    # "resource":Ljava/lang/String;
    .end local p2    # "handlerApiClass":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    throw v6
    :try_end_4
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_4} :catch_2
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    .line 108
    .end local v2    # "input":Ljava/io/InputStream;
    .end local v3    # "requestHandlerClassName":Ljava/lang/String;
    .end local v4    # "requestHandlerClass":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    .end local v5    # "requestHandlerObject":Ljava/lang/Object;
    .restart local v0    # "handlers":Ljava/util/List;, "Ljava/util/List<Lcom/amazonaws/handlers/RequestHandler2;>;"
    .restart local v1    # "reader":Ljava/io/BufferedReader;
    .restart local p1    # "resource":Ljava/lang/String;
    .restart local p2    # "handlerApiClass":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    :catchall_0
    move-exception v2

    goto :goto_5

    .line 103
    :catch_2
    move-exception v2

    .line 104
    .local v2, "e":Ljava/lang/Exception;
    :try_start_5
    new-instance v3, Lcom/amazonaws/AmazonClientException;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "Unable to instantiate request handler chain for client: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    .line 106
    invoke-virtual {v2}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-direct {v3, v4, v2}, Lcom/amazonaws/AmazonClientException;-><init>(Ljava/lang/String;Ljava/lang/Throwable;)V

    .end local v0    # "handlers":Ljava/util/List;, "Ljava/util/List<Lcom/amazonaws/handlers/RequestHandler2;>;"
    .end local v1    # "reader":Ljava/io/BufferedReader;
    .end local p1    # "resource":Ljava/lang/String;
    .end local p2    # "handlerApiClass":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    throw v3
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_0

    .line 109
    .end local v2    # "e":Ljava/lang/Exception;
    .restart local v0    # "handlers":Ljava/util/List;, "Ljava/util/List<Lcom/amazonaws/handlers/RequestHandler2;>;"
    .restart local v1    # "reader":Ljava/io/BufferedReader;
    .restart local p1    # "resource":Ljava/lang/String;
    .restart local p2    # "handlerApiClass":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    :goto_5
    if-eqz v1, :cond_7

    .line 110
    :try_start_6
    invoke-virtual {v1}, Ljava/io/BufferedReader;->close()V
    :try_end_6
    .catch Ljava/io/IOException; {:try_start_6 .. :try_end_6} :catch_3

    goto :goto_6

    .line 112
    :catch_3
    move-exception v3

    goto :goto_7

    .line 113
    :cond_7
    :goto_6
    nop

    .line 114
    :goto_7
    throw v2
.end method


# virtual methods
.method public newRequestHandler2Chain(Ljava/lang/String;)Ljava/util/List;
    .locals 1
    .param p1, "resource"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            ")",
            "Ljava/util/List<",
            "Lcom/amazonaws/handlers/RequestHandler2;",
            ">;"
        }
    .end annotation

    .line 58
    const-class v0, Lcom/amazonaws/handlers/RequestHandler2;

    invoke-direct {p0, p1, v0}, Lcom/amazonaws/handlers/HandlerChainFactory;->createRequestHandlerChain(Ljava/lang/String;Ljava/lang/Class;)Ljava/util/List;

    move-result-object v0

    return-object v0
.end method

.method public newRequestHandlerChain(Ljava/lang/String;)Ljava/util/List;
    .locals 1
    .param p1, "resource"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            ")",
            "Ljava/util/List<",
            "Lcom/amazonaws/handlers/RequestHandler2;",
            ">;"
        }
    .end annotation

    .line 45
    const-class v0, Lcom/amazonaws/handlers/RequestHandler;

    invoke-direct {p0, p1, v0}, Lcom/amazonaws/handlers/HandlerChainFactory;->createRequestHandlerChain(Ljava/lang/String;Ljava/lang/Class;)Ljava/util/List;

    move-result-object v0

    return-object v0
.end method
