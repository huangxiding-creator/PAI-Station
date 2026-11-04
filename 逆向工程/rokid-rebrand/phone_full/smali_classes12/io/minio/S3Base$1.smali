.class Lio/minio/S3Base$1;
.super Ljava/lang/Object;
.source "S3Base.java"

# interfaces
.implements Lokhttp3/Callback;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lio/minio/S3Base;->executeAsync(Lio/minio/http/Method;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lokhttp3/Headers;Lcom/google/common/collect/Multimap;Ljava/lang/Object;I)Ljava/util/concurrent/CompletableFuture;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lio/minio/S3Base;

.field final synthetic val$bucketName:Ljava/lang/String;

.field final synthetic val$completableFuture:Ljava/util/concurrent/CompletableFuture;

.field final synthetic val$method:Lio/minio/http/Method;

.field final synthetic val$objectName:Ljava/lang/String;

.field final synthetic val$queryParamMap:Lcom/google/common/collect/Multimap;

.field final synthetic val$request:Lokhttp3/Request;

.field final synthetic val$traceBuilder:Ljava/lang/StringBuilder;

.field final synthetic val$traceStream:Ljava/io/PrintWriter;


# direct methods
.method constructor <init>(Lio/minio/S3Base;Ljava/util/concurrent/CompletableFuture;Ljava/lang/StringBuilder;Ljava/io/PrintWriter;Lcom/google/common/collect/Multimap;Lio/minio/http/Method;Ljava/lang/String;Ljava/lang/String;Lokhttp3/Request;)V
    .locals 0
    .param p1, "this$0"    # Lio/minio/S3Base;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 530
    iput-object p1, p0, Lio/minio/S3Base$1;->this$0:Lio/minio/S3Base;

    iput-object p2, p0, Lio/minio/S3Base$1;->val$completableFuture:Ljava/util/concurrent/CompletableFuture;

    iput-object p3, p0, Lio/minio/S3Base$1;->val$traceBuilder:Ljava/lang/StringBuilder;

    iput-object p4, p0, Lio/minio/S3Base$1;->val$traceStream:Ljava/io/PrintWriter;

    iput-object p5, p0, Lio/minio/S3Base$1;->val$queryParamMap:Lcom/google/common/collect/Multimap;

    iput-object p6, p0, Lio/minio/S3Base$1;->val$method:Lio/minio/http/Method;

    iput-object p7, p0, Lio/minio/S3Base$1;->val$objectName:Ljava/lang/String;

    iput-object p8, p0, Lio/minio/S3Base$1;->val$bucketName:Ljava/lang/String;

    iput-object p9, p0, Lio/minio/S3Base$1;->val$request:Lokhttp3/Request;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onFailure(Lokhttp3/Call;Ljava/io/IOException;)V
    .locals 1
    .param p1, "call"    # Lokhttp3/Call;
    .param p2, "e"    # Ljava/io/IOException;

    .line 533
    iget-object v0, p0, Lio/minio/S3Base$1;->val$completableFuture:Ljava/util/concurrent/CompletableFuture;

    invoke-virtual {v0, p2}, Ljava/util/concurrent/CompletableFuture;->completeExceptionally(Ljava/lang/Throwable;)Z

    .line 534
    return-void
.end method

.method public onResponse(Lokhttp3/Call;Lokhttp3/Response;)V
    .locals 17
    .param p1, "call"    # Lokhttp3/Call;
    .param p2, "response"    # Lokhttp3/Response;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 538
    move-object/from16 v1, p0

    move-object/from16 v2, p2

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 539
    invoke-virtual/range {p2 .. p2}, Lokhttp3/Response;->protocol()Lokhttp3/Protocol;

    move-result-object v3

    invoke-virtual {v3}, Lokhttp3/Protocol;->toString()Ljava/lang/String;

    move-result-object v3

    sget-object v4, Ljava/util/Locale;->US:Ljava/util/Locale;

    invoke-virtual {v3, v4}, Ljava/lang/String;->toUpperCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v3, " "

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    .line 541
    invoke-virtual/range {p2 .. p2}, Lokhttp3/Response;->code()I

    move-result v3

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v3, "\n"

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    .line 543
    invoke-virtual/range {p2 .. p2}, Lokhttp3/Response;->headers()Lokhttp3/Headers;

    move-result-object v4

    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    .line 544
    .local v4, "trace":Ljava/lang/String;
    iget-object v0, v1, Lio/minio/S3Base$1;->val$traceBuilder:Ljava/lang/StringBuilder;

    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 545
    iget-object v0, v1, Lio/minio/S3Base$1;->val$traceStream:Ljava/io/PrintWriter;

    if-eqz v0, :cond_0

    iget-object v0, v1, Lio/minio/S3Base$1;->val$traceStream:Ljava/io/PrintWriter;

    invoke-virtual {v0, v4}, Ljava/io/PrintWriter;->println(Ljava/lang/String;)V

    .line 547
    :cond_0
    invoke-virtual/range {p2 .. p2}, Lokhttp3/Response;->isSuccessful()Z

    move-result v0

    const-string v5, "----------END-HTTP----------"

    if-eqz v0, :cond_5

    .line 548
    iget-object v0, v1, Lio/minio/S3Base$1;->val$traceStream:Ljava/io/PrintWriter;

    if-eqz v0, :cond_4

    .line 552
    iget-object v0, v1, Lio/minio/S3Base$1;->val$queryParamMap:Lcom/google/common/collect/Multimap;

    invoke-interface {v0}, Lcom/google/common/collect/Multimap;->keySet()Ljava/util/Set;

    move-result-object v0

    .line 553
    .local v0, "keys":Ljava/util/Set;, "Ljava/util/Set<Ljava/lang/String;>;"
    iget-object v3, v1, Lio/minio/S3Base$1;->val$method:Lio/minio/http/Method;

    sget-object v6, Lio/minio/http/Method;->GET:Lio/minio/http/Method;

    if-ne v3, v6, :cond_1

    iget-object v3, v1, Lio/minio/S3Base$1;->val$objectName:Ljava/lang/String;

    if-eqz v3, :cond_1

    .line 555
    invoke-static {}, Lio/minio/S3Base;->access$000()Ljava/util/Set;

    move-result-object v3

    invoke-static {v0, v3}, Ljava/util/Collections;->disjoint(Ljava/util/Collection;Ljava/util/Collection;)Z

    move-result v3

    if-nez v3, :cond_3

    :cond_1
    nop

    .line 556
    const-string v3, "events"

    invoke-interface {v0, v3}, Ljava/util/Set;->contains(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_2

    .line 557
    const-string v3, "prefix"

    invoke-interface {v0, v3}, Ljava/util/Set;->contains(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_3

    const-string/jumbo v3, "suffix"

    invoke-interface {v0, v3}, Ljava/util/Set;->contains(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_3

    .line 558
    :cond_2
    const-wide/32 v6, 0x100000

    invoke-virtual {v2, v6, v7}, Lokhttp3/Response;->peekBody(J)Lokhttp3/ResponseBody;

    move-result-object v3

    .line 559
    .local v3, "responseBody":Lokhttp3/ResponseBody;
    iget-object v6, v1, Lio/minio/S3Base$1;->val$traceStream:Ljava/io/PrintWriter;

    invoke-virtual {v3}, Lokhttp3/ResponseBody;->string()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/io/PrintWriter;->println(Ljava/lang/String;)V

    .line 561
    .end local v3    # "responseBody":Lokhttp3/ResponseBody;
    :cond_3
    iget-object v3, v1, Lio/minio/S3Base$1;->val$traceStream:Ljava/io/PrintWriter;

    invoke-virtual {v3, v5}, Ljava/io/PrintWriter;->println(Ljava/lang/String;)V

    .line 564
    .end local v0    # "keys":Ljava/util/Set;, "Ljava/util/Set<Ljava/lang/String;>;"
    :cond_4
    iget-object v0, v1, Lio/minio/S3Base$1;->val$completableFuture:Ljava/util/concurrent/CompletableFuture;

    invoke-virtual {v0, v2}, Ljava/util/concurrent/CompletableFuture;->complete(Ljava/lang/Object;)Z

    .line 565
    return-void

    .line 568
    :cond_5
    const/4 v6, 0x0

    .line 569
    .local v6, "errorXml":Ljava/lang/String;
    invoke-virtual/range {p2 .. p2}, Lokhttp3/Response;->body()Lokhttp3/ResponseBody;

    move-result-object v7

    .line 570
    .local v7, "responseBody":Lokhttp3/ResponseBody;
    :try_start_0
    invoke-virtual {v7}, Lokhttp3/ResponseBody;->string()Ljava/lang/String;

    move-result-object v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-object v6, v0

    .line 571
    if-eqz v7, :cond_6

    invoke-virtual {v7}, Lokhttp3/ResponseBody;->close()V

    .line 573
    .end local v7    # "responseBody":Lokhttp3/ResponseBody;
    :cond_6
    const-string v0, ""

    invoke-virtual {v0, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v7

    if-eqz v7, :cond_7

    iget-object v7, v1, Lio/minio/S3Base$1;->val$method:Lio/minio/http/Method;

    sget-object v8, Lio/minio/http/Method;->HEAD:Lio/minio/http/Method;

    invoke-virtual {v7, v8}, Lio/minio/http/Method;->equals(Ljava/lang/Object;)Z

    move-result v7

    if-nez v7, :cond_8

    .line 574
    :cond_7
    iget-object v7, v1, Lio/minio/S3Base$1;->val$traceBuilder:Ljava/lang/StringBuilder;

    invoke-virtual {v7, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 575
    iget-object v7, v1, Lio/minio/S3Base$1;->val$traceStream:Ljava/io/PrintWriter;

    if-eqz v7, :cond_8

    iget-object v7, v1, Lio/minio/S3Base$1;->val$traceStream:Ljava/io/PrintWriter;

    invoke-virtual {v7, v6}, Ljava/io/PrintWriter;->println(Ljava/lang/String;)V

    .line 578
    :cond_8
    iget-object v7, v1, Lio/minio/S3Base$1;->val$traceBuilder:Ljava/lang/StringBuilder;

    invoke-virtual {v7, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 579
    iget-object v3, v1, Lio/minio/S3Base$1;->val$traceStream:Ljava/io/PrintWriter;

    if-eqz v3, :cond_9

    iget-object v3, v1, Lio/minio/S3Base$1;->val$traceStream:Ljava/io/PrintWriter;

    invoke-virtual {v3, v5}, Ljava/io/PrintWriter;->println(Ljava/lang/String;)V

    .line 582
    :cond_9
    invoke-virtual/range {p2 .. p2}, Lokhttp3/Response;->headers()Lokhttp3/Headers;

    move-result-object v3

    const-string v5, "content-type"

    invoke-virtual {v3, v5}, Lokhttp3/Headers;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    .line 583
    .local v3, "contentType":Ljava/lang/String;
    iget-object v5, v1, Lio/minio/S3Base$1;->val$method:Lio/minio/http/Method;

    sget-object v7, Lio/minio/http/Method;->HEAD:Lio/minio/http/Method;

    invoke-virtual {v5, v7}, Lio/minio/http/Method;->equals(Ljava/lang/Object;)Z

    move-result v5

    const-string/jumbo v7, "server failed with HTTP status code "

    const/4 v8, 0x0

    if-nez v5, :cond_d

    if-eqz v3, :cond_a

    .line 585
    const-string v5, ";"

    invoke-virtual {v3, v5}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v5

    invoke-static {v5}, Ljava/util/Arrays;->asList([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v5

    const-string v9, "application/xml"

    invoke-interface {v5, v9}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    move-result v5

    if-nez v5, :cond_d

    .line 586
    :cond_a
    invoke-virtual/range {p2 .. p2}, Lokhttp3/Response;->code()I

    move-result v0

    const/16 v5, 0x130

    if-ne v0, v5, :cond_b

    invoke-virtual/range {p2 .. p2}, Lokhttp3/Response;->body()Lokhttp3/ResponseBody;

    move-result-object v0

    invoke-virtual {v0}, Lokhttp3/ResponseBody;->contentLength()J

    move-result-wide v9

    const-wide/16 v11, 0x0

    cmp-long v0, v9, v11

    if-nez v0, :cond_b

    .line 587
    iget-object v0, v1, Lio/minio/S3Base$1;->val$completableFuture:Ljava/util/concurrent/CompletableFuture;

    new-instance v5, Lio/minio/errors/ServerException;

    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v9, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    .line 589
    invoke-virtual/range {p2 .. p2}, Lokhttp3/Response;->code()I

    move-result v9

    invoke-virtual {v7, v9}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    .line 590
    invoke-virtual/range {p2 .. p2}, Lokhttp3/Response;->code()I

    move-result v9

    iget-object v10, v1, Lio/minio/S3Base$1;->val$traceBuilder:Ljava/lang/StringBuilder;

    .line 591
    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-direct {v5, v7, v9, v10}, Lio/minio/errors/ServerException;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    .line 587
    invoke-virtual {v0, v5}, Ljava/util/concurrent/CompletableFuture;->completeExceptionally(Ljava/lang/Throwable;)Z

    .line 594
    :cond_b
    iget-object v0, v1, Lio/minio/S3Base$1;->val$completableFuture:Ljava/util/concurrent/CompletableFuture;

    new-instance v5, Lio/minio/errors/InvalidResponseException;

    .line 596
    invoke-virtual/range {p2 .. p2}, Lokhttp3/Response;->code()I

    move-result v7

    .line 599
    invoke-virtual {v6}, Ljava/lang/String;->length()I

    move-result v9

    const/16 v10, 0x400

    if-le v9, v10, :cond_c

    goto :goto_0

    :cond_c
    invoke-virtual {v6}, Ljava/lang/String;->length()I

    move-result v10

    .line 598
    :goto_0
    invoke-virtual {v6, v8, v10}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v8

    iget-object v9, v1, Lio/minio/S3Base$1;->val$traceBuilder:Ljava/lang/StringBuilder;

    .line 600
    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-direct {v5, v7, v3, v8, v9}, Lio/minio/errors/InvalidResponseException;-><init>(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 594
    invoke-virtual {v0, v5}, Ljava/util/concurrent/CompletableFuture;->completeExceptionally(Ljava/lang/Throwable;)Z

    .line 601
    return-void

    .line 604
    :cond_d
    const/4 v5, 0x0

    .line 605
    .local v5, "errorResponse":Lio/minio/messages/ErrorResponse;
    invoke-virtual {v0, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_e

    .line 607
    :try_start_1
    const-class v0, Lio/minio/messages/ErrorResponse;

    invoke-static {v0, v6}, Lio/minio/Xml;->unmarshal(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lio/minio/messages/ErrorResponse;
    :try_end_1
    .catch Lio/minio/errors/XmlParserException; {:try_start_1 .. :try_end_1} :catch_0

    move-object v5, v0

    .line 611
    goto :goto_1

    .line 608
    :catch_0
    move-exception v0

    .line 609
    .local v0, "e":Lio/minio/errors/XmlParserException;
    iget-object v7, v1, Lio/minio/S3Base$1;->val$completableFuture:Ljava/util/concurrent/CompletableFuture;

    invoke-virtual {v7, v0}, Ljava/util/concurrent/CompletableFuture;->completeExceptionally(Ljava/lang/Throwable;)Z

    .line 610
    return-void

    .line 612
    .end local v0    # "e":Lio/minio/errors/XmlParserException;
    :cond_e
    iget-object v0, v1, Lio/minio/S3Base$1;->val$method:Lio/minio/http/Method;

    sget-object v9, Lio/minio/http/Method;->HEAD:Lio/minio/http/Method;

    invoke-virtual {v0, v9}, Lio/minio/http/Method;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_f

    .line 613
    iget-object v0, v1, Lio/minio/S3Base$1;->val$completableFuture:Ljava/util/concurrent/CompletableFuture;

    new-instance v7, Lio/minio/errors/InvalidResponseException;

    .line 615
    invoke-virtual/range {p2 .. p2}, Lokhttp3/Response;->code()I

    move-result v8

    iget-object v9, v1, Lio/minio/S3Base$1;->val$traceBuilder:Ljava/lang/StringBuilder;

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-direct {v7, v8, v3, v6, v9}, Lio/minio/errors/InvalidResponseException;-><init>(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 613
    invoke-virtual {v0, v7}, Ljava/util/concurrent/CompletableFuture;->completeExceptionally(Ljava/lang/Throwable;)Z

    .line 616
    return-void

    .line 619
    :cond_f
    :goto_1
    if-nez v5, :cond_13

    .line 620
    const/4 v0, 0x0

    .line 621
    .local v0, "code":Ljava/lang/String;
    const/4 v9, 0x0

    .line 622
    .local v9, "message":Ljava/lang/String;
    invoke-virtual/range {p2 .. p2}, Lokhttp3/Response;->code()I

    move-result v10

    sparse-switch v10, :sswitch_data_0

    .line 669
    iget-object v8, v1, Lio/minio/S3Base$1;->val$completableFuture:Ljava/util/concurrent/CompletableFuture;

    new-instance v10, Lio/minio/errors/ServerException;

    new-instance v11, Ljava/lang/StringBuilder;

    invoke-direct {v11}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v11, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    .line 671
    invoke-virtual/range {p2 .. p2}, Lokhttp3/Response;->code()I

    move-result v11

    invoke-virtual {v7, v11}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    .line 672
    invoke-virtual/range {p2 .. p2}, Lokhttp3/Response;->code()I

    move-result v11

    iget-object v12, v1, Lio/minio/S3Base$1;->val$traceBuilder:Ljava/lang/StringBuilder;

    .line 673
    invoke-virtual {v12}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v12

    invoke-direct {v10, v7, v11, v12}, Lio/minio/errors/ServerException;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    .line 669
    invoke-virtual {v8, v10}, Ljava/util/concurrent/CompletableFuture;->completeExceptionally(Ljava/lang/Throwable;)Z

    .line 674
    return-void

    .line 665
    :sswitch_0
    const-string v0, "InvalidRange"

    .line 666
    const-string v7, "The requested range cannot be satisfied"

    .line 667
    .end local v9    # "message":Ljava/lang/String;
    .local v7, "message":Ljava/lang/String;
    goto :goto_2

    .line 661
    .end local v7    # "message":Ljava/lang/String;
    .restart local v9    # "message":Ljava/lang/String;
    :sswitch_1
    const-string v0, "PreconditionFailed"

    .line 662
    const-string v7, "At least one of the preconditions you specified did not hold"

    .line 663
    .end local v9    # "message":Ljava/lang/String;
    .restart local v7    # "message":Ljava/lang/String;
    goto :goto_2

    .line 648
    .end local v7    # "message":Ljava/lang/String;
    .restart local v9    # "message":Ljava/lang/String;
    :sswitch_2
    iget-object v7, v1, Lio/minio/S3Base$1;->val$bucketName:Ljava/lang/String;

    if-eqz v7, :cond_10

    .line 649
    const-string v0, "NoSuchBucket"

    .line 650
    const-string v7, "Bucket does not exist"

    .end local v9    # "message":Ljava/lang/String;
    .restart local v7    # "message":Ljava/lang/String;
    goto :goto_2

    .line 652
    .end local v7    # "message":Ljava/lang/String;
    .restart local v9    # "message":Ljava/lang/String;
    :cond_10
    const-string v0, "ResourceConflict"

    .line 653
    const-string v7, "Request resource conflicts"

    .line 655
    .end local v9    # "message":Ljava/lang/String;
    .restart local v7    # "message":Ljava/lang/String;
    goto :goto_2

    .line 644
    .end local v7    # "message":Ljava/lang/String;
    .restart local v9    # "message":Ljava/lang/String;
    :sswitch_3
    const-string v0, "MethodNotAllowed"

    .line 645
    const-string v7, "The specified method is not allowed against this resource"

    .line 646
    .end local v9    # "message":Ljava/lang/String;
    .restart local v7    # "message":Ljava/lang/String;
    goto :goto_2

    .line 631
    .end local v7    # "message":Ljava/lang/String;
    .restart local v9    # "message":Ljava/lang/String;
    :sswitch_4
    iget-object v7, v1, Lio/minio/S3Base$1;->val$objectName:Ljava/lang/String;

    if-eqz v7, :cond_11

    .line 632
    const-string v0, "NoSuchKey"

    .line 633
    const-string v7, "Object does not exist"

    .end local v9    # "message":Ljava/lang/String;
    .restart local v7    # "message":Ljava/lang/String;
    goto :goto_2

    .line 634
    .end local v7    # "message":Ljava/lang/String;
    .restart local v9    # "message":Ljava/lang/String;
    :cond_11
    iget-object v7, v1, Lio/minio/S3Base$1;->val$bucketName:Ljava/lang/String;

    if-eqz v7, :cond_12

    .line 635
    const-string v0, "NoSuchBucket"

    .line 636
    const-string v7, "Bucket does not exist"

    .end local v9    # "message":Ljava/lang/String;
    .restart local v7    # "message":Ljava/lang/String;
    goto :goto_2

    .line 638
    .end local v7    # "message":Ljava/lang/String;
    .restart local v9    # "message":Ljava/lang/String;
    :cond_12
    const-string v0, "ResourceNotFound"

    .line 639
    const-string v7, "Request resource not found"

    .line 641
    .end local v9    # "message":Ljava/lang/String;
    .restart local v7    # "message":Ljava/lang/String;
    goto :goto_2

    .line 657
    .end local v7    # "message":Ljava/lang/String;
    .restart local v9    # "message":Ljava/lang/String;
    :sswitch_5
    const-string v0, "AccessDenied"

    .line 658
    const-string v7, "Access denied"

    .line 659
    .end local v9    # "message":Ljava/lang/String;
    .restart local v7    # "message":Ljava/lang/String;
    goto :goto_2

    .line 626
    .end local v7    # "message":Ljava/lang/String;
    .restart local v9    # "message":Ljava/lang/String;
    :sswitch_6
    iget-object v7, v1, Lio/minio/S3Base$1;->this$0:Lio/minio/S3Base;

    iget-object v10, v1, Lio/minio/S3Base$1;->val$method:Lio/minio/http/Method;

    iget-object v11, v1, Lio/minio/S3Base$1;->val$bucketName:Ljava/lang/String;

    const/4 v12, 0x1

    invoke-static {v7, v10, v11, v2, v12}, Lio/minio/S3Base;->access$100(Lio/minio/S3Base;Lio/minio/http/Method;Ljava/lang/String;Lokhttp3/Response;Z)[Ljava/lang/String;

    move-result-object v7

    .line 627
    .local v7, "result":[Ljava/lang/String;
    aget-object v0, v7, v8

    .line 628
    aget-object v8, v7, v12

    .line 629
    .end local v9    # "message":Ljava/lang/String;
    .local v8, "message":Ljava/lang/String;
    move-object v7, v8

    .line 677
    .end local v8    # "message":Ljava/lang/String;
    .local v7, "message":Ljava/lang/String;
    :goto_2
    new-instance v8, Lio/minio/messages/ErrorResponse;

    iget-object v12, v1, Lio/minio/S3Base$1;->val$bucketName:Ljava/lang/String;

    iget-object v13, v1, Lio/minio/S3Base$1;->val$objectName:Ljava/lang/String;

    iget-object v9, v1, Lio/minio/S3Base$1;->val$request:Lokhttp3/Request;

    .line 683
    invoke-virtual {v9}, Lokhttp3/Request;->url()Lokhttp3/HttpUrl;

    move-result-object v9

    invoke-virtual {v9}, Lokhttp3/HttpUrl;->encodedPath()Ljava/lang/String;

    move-result-object v14

    .line 684
    const-string/jumbo v9, "x-amz-request-id"

    invoke-virtual {v2, v9}, Lokhttp3/Response;->header(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v15

    .line 685
    const-string/jumbo v9, "x-amz-id-2"

    invoke-virtual {v2, v9}, Lokhttp3/Response;->header(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v16

    move-object v9, v8

    move-object v10, v0

    move-object v11, v7

    invoke-direct/range {v9 .. v16}, Lio/minio/messages/ErrorResponse;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    move-object v5, v8

    .line 689
    .end local v0    # "code":Ljava/lang/String;
    .end local v7    # "message":Ljava/lang/String;
    :cond_13
    invoke-virtual {v5}, Lio/minio/messages/ErrorResponse;->code()Ljava/lang/String;

    move-result-object v0

    const-string v7, "NoSuchBucket"

    invoke-virtual {v0, v7}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_14

    .line 690
    invoke-virtual {v5}, Lio/minio/messages/ErrorResponse;->code()Ljava/lang/String;

    move-result-object v0

    const-string v7, "RetryHead"

    invoke-virtual {v0, v7}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_15

    .line 691
    :cond_14
    iget-object v0, v1, Lio/minio/S3Base$1;->this$0:Lio/minio/S3Base;

    iget-object v0, v0, Lio/minio/S3Base;->regionCache:Ljava/util/Map;

    iget-object v7, v1, Lio/minio/S3Base$1;->val$bucketName:Ljava/lang/String;

    invoke-interface {v0, v7}, Ljava/util/Map;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    .line 694
    :cond_15
    new-instance v0, Lio/minio/errors/ErrorResponseException;

    iget-object v7, v1, Lio/minio/S3Base$1;->val$traceBuilder:Ljava/lang/StringBuilder;

    .line 695
    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-direct {v0, v5, v2, v7}, Lio/minio/errors/ErrorResponseException;-><init>(Lio/minio/messages/ErrorResponse;Lokhttp3/Response;Ljava/lang/String;)V

    .line 696
    .local v0, "e":Lio/minio/errors/ErrorResponseException;
    iget-object v7, v1, Lio/minio/S3Base$1;->val$completableFuture:Ljava/util/concurrent/CompletableFuture;

    invoke-virtual {v7, v0}, Ljava/util/concurrent/CompletableFuture;->completeExceptionally(Ljava/lang/Throwable;)Z

    .line 697
    return-void

    .line 569
    .end local v0    # "e":Lio/minio/errors/ErrorResponseException;
    .end local v3    # "contentType":Ljava/lang/String;
    .end local v5    # "errorResponse":Lio/minio/messages/ErrorResponse;
    .local v7, "responseBody":Lokhttp3/ResponseBody;
    :catchall_0
    move-exception v0

    move-object v3, v0

    if-eqz v7, :cond_16

    :try_start_2
    invoke-virtual {v7}, Lokhttp3/ResponseBody;->close()V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    goto :goto_3

    :catchall_1
    move-exception v0

    move-object v5, v0

    invoke-virtual {v3, v5}, Ljava/lang/Throwable;->addSuppressed(Ljava/lang/Throwable;)V

    :cond_16
    :goto_3
    throw v3

    :sswitch_data_0
    .sparse-switch
        0x12d -> :sswitch_6
        0x133 -> :sswitch_6
        0x190 -> :sswitch_6
        0x193 -> :sswitch_5
        0x194 -> :sswitch_4
        0x195 -> :sswitch_3
        0x199 -> :sswitch_2
        0x19c -> :sswitch_1
        0x1a0 -> :sswitch_0
        0x1f5 -> :sswitch_3
    .end sparse-switch
.end method
