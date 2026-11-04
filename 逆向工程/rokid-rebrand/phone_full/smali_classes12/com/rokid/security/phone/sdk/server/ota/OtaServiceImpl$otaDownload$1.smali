.class final Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$otaDownload$1;
.super Lkotlin/coroutines/jvm/internal/SuspendLambda;
.source "OtaServiceImpl.kt"

# interfaces
.implements Lkotlin/jvm/functions/Function2;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;->otaDownload(Ljava/lang/String;Ljava/lang/String;Lcom/rokid/security/phone/sdk/api/base/DownloadListener;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x18
    name = null
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lkotlin/coroutines/jvm/internal/SuspendLambda;",
        "Lkotlin/jvm/functions/Function2<",
        "Lkotlinx/coroutines/CoroutineScope;",
        "Lkotlin/coroutines/Continuation<",
        "-",
        "Lkotlin/Unit;",
        ">;",
        "Ljava/lang/Object;",
        ">;"
    }
.end annotation

.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nOtaServiceImpl.kt\nKotlin\n*S Kotlin\n*F\n+ 1 OtaServiceImpl.kt\ncom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$otaDownload$1\n+ 2 fake.kt\nkotlin/jvm/internal/FakeKt\n*L\n1#1,681:1\n1#2:682\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\n\n\u0000\n\u0002\u0010\u0002\n\u0002\u0018\u0002\u0010\u0000\u001a\u00020\u0001*\u00020\u0002H\u008a@"
    }
    d2 = {
        "<anonymous>",
        "",
        "Lkotlinx/coroutines/CoroutineScope;"
    }
    k = 0x3
    mv = {
        0x1,
        0x8,
        0x0
    }
    xi = 0x30
.end annotation

.annotation runtime Lkotlin/coroutines/jvm/internal/DebugMetadata;
    c = "com.rokid.security.phone.sdk.server.ota.OtaServiceImpl$otaDownload$1"
    f = "OtaServiceImpl.kt"
    i = {}
    l = {
        0x260
    }
    m = "invokeSuspend"
    n = {}
    s = {}
.end annotation


# instance fields
.field final synthetic $listener:Lcom/rokid/security/phone/sdk/api/base/DownloadListener;

.field final synthetic $path:Ljava/lang/String;

.field final synthetic $url:Ljava/lang/String;

.field label:I


# direct methods
.method constructor <init>(Ljava/lang/String;Lcom/rokid/security/phone/sdk/api/base/DownloadListener;Ljava/lang/String;Lkotlin/coroutines/Continuation;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Lcom/rokid/security/phone/sdk/api/base/DownloadListener;",
            "Ljava/lang/String;",
            "Lkotlin/coroutines/Continuation<",
            "-",
            "Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$otaDownload$1;",
            ">;)V"
        }
    .end annotation

    iput-object p1, p0, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$otaDownload$1;->$url:Ljava/lang/String;

    iput-object p2, p0, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$otaDownload$1;->$listener:Lcom/rokid/security/phone/sdk/api/base/DownloadListener;

    iput-object p3, p0, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$otaDownload$1;->$path:Ljava/lang/String;

    const/4 v0, 0x2

    invoke-direct {p0, v0, p4}, Lkotlin/coroutines/jvm/internal/SuspendLambda;-><init>(ILkotlin/coroutines/Continuation;)V

    return-void
.end method


# virtual methods
.method public final create(Ljava/lang/Object;Lkotlin/coroutines/Continuation;)Lkotlin/coroutines/Continuation;
    .locals 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Object;",
            "Lkotlin/coroutines/Continuation<",
            "*>;)",
            "Lkotlin/coroutines/Continuation<",
            "Lkotlin/Unit;",
            ">;"
        }
    .end annotation

    new-instance v0, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$otaDownload$1;

    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$otaDownload$1;->$url:Ljava/lang/String;

    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$otaDownload$1;->$listener:Lcom/rokid/security/phone/sdk/api/base/DownloadListener;

    iget-object v3, p0, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$otaDownload$1;->$path:Ljava/lang/String;

    invoke-direct {v0, v1, v2, v3, p2}, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$otaDownload$1;-><init>(Ljava/lang/String;Lcom/rokid/security/phone/sdk/api/base/DownloadListener;Ljava/lang/String;Lkotlin/coroutines/Continuation;)V

    check-cast v0, Lkotlin/coroutines/Continuation;

    return-object v0
.end method

.method public bridge synthetic invoke(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    .locals 1

    check-cast p1, Lkotlinx/coroutines/CoroutineScope;

    check-cast p2, Lkotlin/coroutines/Continuation;

    invoke-virtual {p0, p1, p2}, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$otaDownload$1;->invoke(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public final invoke(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lkotlinx/coroutines/CoroutineScope;",
            "Lkotlin/coroutines/Continuation<",
            "-",
            "Lkotlin/Unit;",
            ">;)",
            "Ljava/lang/Object;"
        }
    .end annotation

    invoke-virtual {p0, p1, p2}, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$otaDownload$1;->create(Ljava/lang/Object;Lkotlin/coroutines/Continuation;)Lkotlin/coroutines/Continuation;

    move-result-object v0

    check-cast v0, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$otaDownload$1;

    sget-object v1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    invoke-virtual {v0, v1}, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$otaDownload$1;->invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public final invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 34

    invoke-static {}, Lkotlin/coroutines/intrinsics/IntrinsicsKt;->getCOROUTINE_SUSPENDED()Ljava/lang/Object;

    move-result-object v0

    .line 596
    move-object/from16 v1, p0

    iget v2, v1, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$otaDownload$1;->label:I

    const/4 v3, 0x1

    packed-switch v2, :pswitch_data_0

    new-instance v0, Ljava/lang/IllegalStateException;

    const-string v1, "call to \'resume\' before \'invoke\' with coroutine"

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0

    :pswitch_0
    move-object/from16 v2, p0

    .local v2, "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$otaDownload$1;
    move-object/from16 v5, p1

    .local v5, "$result":Ljava/lang/Object;
    :try_start_0
    invoke-static {v5}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-object v6, v5

    goto :goto_0

    .line 668
    :catch_0
    move-exception v0

    goto/16 :goto_8

    .line 596
    .end local v2    # "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$otaDownload$1;
    .end local v5    # "$result":Ljava/lang/Object;
    :pswitch_1
    invoke-static/range {p1 .. p1}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    move-object/from16 v2, p0

    .restart local v2    # "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$otaDownload$1;
    move-object/from16 v5, p1

    .line 597
    .restart local v5    # "$result":Ljava/lang/Object;
    nop

    .line 598
    :try_start_1
    sget-object v6, Lcom/rokid/security/phone/sdk/server/net/ApiProvider;->INSTANCE:Lcom/rokid/security/phone/sdk/server/net/ApiProvider;

    new-instance v7, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$otaDownload$1$response$1;

    iget-object v8, v2, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$otaDownload$1;->$listener:Lcom/rokid/security/phone/sdk/api/base/DownloadListener;

    invoke-direct {v7, v8}, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$otaDownload$1$response$1;-><init>(Lcom/rokid/security/phone/sdk/api/base/DownloadListener;)V

    check-cast v7, Lcom/rokid/security/phone/sdk/base/utils/net/DownloadListener;

    invoke-virtual {v6, v7}, Lcom/rokid/security/phone/sdk/server/net/ApiProvider;->getDownloadFileApi(Lcom/rokid/security/phone/sdk/base/utils/net/DownloadListener;)Lcom/rokid/security/phone/sdk/server/net/DownloadApi;

    move-result-object v6

    .line 608
    iget-object v7, v2, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$otaDownload$1;->$url:Ljava/lang/String;

    move-object v8, v2

    check-cast v8, Lkotlin/coroutines/Continuation;

    iput v3, v2, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$otaDownload$1;->label:I

    invoke-interface {v6, v7, v8}, Lcom/rokid/security/phone/sdk/server/net/DownloadApi;->downloadFile(Ljava/lang/String;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v6
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    if-ne v6, v0, :cond_0

    .line 596
    return-object v0

    .line 608
    :cond_0
    move-object/from16 v33, v6

    move-object v6, v5

    move-object/from16 v5, v33

    .line 596
    .end local v5    # "$result":Ljava/lang/Object;
    .local v6, "$result":Ljava/lang/Object;
    :goto_0
    :try_start_2
    check-cast v5, Lretrofit2/Response;

    .line 598
    move-object v0, v5

    .line 610
    .local v0, "response":Lretrofit2/Response;
    invoke-virtual {v0}, Lretrofit2/Response;->isSuccessful()Z

    move-result v5

    if-eqz v5, :cond_8

    .line 611
    invoke-virtual {v0}, Lretrofit2/Response;->body()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Lokhttp3/ResponseBody;

    .end local v0    # "response":Lretrofit2/Response;
    if-eqz v5, :cond_7

    check-cast v5, Ljava/io/Closeable;

    iget-object v0, v2, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$otaDownload$1;->$path:Ljava/lang/String;

    iget-object v7, v2, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$otaDownload$1;->$listener:Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_2

    :try_start_3
    move-object v8, v5

    check-cast v8, Lokhttp3/ResponseBody;

    .local v8, "body":Lokhttp3/ResponseBody;
    const/4 v9, 0x0

    .line 612
    .local v9, "$i$a$-use-OtaServiceImpl$otaDownload$1$1":I
    invoke-virtual {v8}, Lokhttp3/ResponseBody;->byteStream()Ljava/io/InputStream;

    move-result-object v10

    .line 613
    .local v10, "inputStream":Ljava/io/InputStream;
    new-instance v11, Ljava/io/File;

    invoke-direct {v11, v0}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    move-object v0, v11

    .line 614
    .local v0, "outputFile":Ljava/io/File;
    invoke-virtual {v8}, Lokhttp3/ResponseBody;->contentLength()J

    move-result-wide v11

    .line 616
    .end local v8    # "body":Lokhttp3/ResponseBody;
    .local v11, "totalBytes":J
    const-wide/16 v13, 0x0

    .line 617
    .local v13, "downloadedBytes":J
    const/4 v8, 0x0

    .local v8, "lastProgress":I
    const/4 v8, -0x1

    .line 618
    const-wide/16 v15, 0x0

    .local v15, "lastUpdateTime":J
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v17

    move-wide/from16 v15, v17

    .line 619
    const-wide/16 v17, 0x0

    .line 620
    .local v17, "totalBytesRead":J
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v19

    .line 622
    .local v19, "startTime":J
    new-instance v4, Ljava/io/FileOutputStream;

    invoke-direct {v4, v0}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V

    check-cast v4, Ljava/io/Closeable;
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_6

    .end local v0    # "outputFile":Ljava/io/File;
    :try_start_4
    move-object v0, v4

    check-cast v0, Ljava/io/FileOutputStream;

    .local v0, "output":Ljava/io/FileOutputStream;
    const/16 v21, 0x0

    .line 623
    .local v21, "$i$a$-use-OtaServiceImpl$otaDownload$1$1$1":I
    const/16 v3, 0x2000

    new-array v3, v3, [B

    .line 624
    .local v3, "buffer":[B
    const/16 v22, 0x0

    .line 626
    .local v22, "bytesRead":I
    :goto_1
    invoke-virtual {v10, v3}, Ljava/io/InputStream;->read([B)I

    move-result v1
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_3

    move/from16 v23, v1

    .line 682
    .local v23, "it":I
    const/16 v24, 0x0

    .line 626
    .local v24, "$i$a$-also-OtaServiceImpl$otaDownload$1$1$1$1":I
    move/from16 p1, v23

    move-object/from16 v22, v6

    .end local v6    # "$result":Ljava/lang/Object;
    .end local v23    # "it":I
    .end local v24    # "$i$a$-also-OtaServiceImpl$otaDownload$1$1$1$1":I
    .local v22, "$result":Ljava/lang/Object;
    .local p1, "bytesRead":I
    const/4 v6, -0x1

    if-eq v1, v6, :cond_6

    :try_start_5
    sget-object v1, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;

    invoke-virtual {v1}, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;->getDownloadJob()Lkotlinx/coroutines/Job;

    move-result-object v1
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_1

    if-eqz v1, :cond_1

    :try_start_6
    invoke-interface {v1}, Lkotlinx/coroutines/Job;->isActive()Z

    move-result v1
    :try_end_6
    .catchall {:try_start_6 .. :try_end_6} :catchall_0

    const/4 v6, 0x1

    if-ne v1, v6, :cond_1

    const/4 v6, 0x1

    goto :goto_2

    .line 622
    .end local v0    # "output":Ljava/io/FileOutputStream;
    .end local v3    # "buffer":[B
    .end local v8    # "lastProgress":I
    .end local v10    # "inputStream":Ljava/io/InputStream;
    .end local v11    # "totalBytes":J
    .end local v13    # "downloadedBytes":J
    .end local v15    # "lastUpdateTime":J
    .end local v17    # "totalBytesRead":J
    .end local v19    # "startTime":J
    .end local v21    # "$i$a$-use-OtaServiceImpl$otaDownload$1$1$1":I
    .end local p1    # "bytesRead":I
    :catchall_0
    move-exception v0

    move-object v1, v0

    move/from16 p1, v9

    goto/16 :goto_5

    .line 626
    .restart local v0    # "output":Ljava/io/FileOutputStream;
    .restart local v3    # "buffer":[B
    .restart local v8    # "lastProgress":I
    .restart local v10    # "inputStream":Ljava/io/InputStream;
    .restart local v11    # "totalBytes":J
    .restart local v13    # "downloadedBytes":J
    .restart local v15    # "lastUpdateTime":J
    .restart local v17    # "totalBytesRead":J
    .restart local v19    # "startTime":J
    .restart local v21    # "$i$a$-use-OtaServiceImpl$otaDownload$1$1$1":I
    .restart local p1    # "bytesRead":I
    :cond_1
    const/4 v6, 0x0

    :goto_2
    if-eqz v6, :cond_6

    .line 627
    move/from16 v1, p1

    const/4 v6, 0x0

    .end local p1    # "bytesRead":I
    .local v1, "bytesRead":I
    :try_start_7
    invoke-virtual {v0, v3, v6, v1}, Ljava/io/FileOutputStream;->write([BII)V
    :try_end_7
    .catchall {:try_start_7 .. :try_end_7} :catchall_1

    .line 628
    move-object/from16 v23, v7

    int-to-long v6, v1

    add-long/2addr v13, v6

    .line 629
    int-to-long v6, v1

    add-long v17, v17, v6

    .line 632
    const-wide/32 v6, 0x100000

    cmp-long v6, v17, v6

    if-ltz v6, :cond_2

    .line 633
    :try_start_8
    invoke-virtual {v0}, Ljava/io/FileOutputStream;->flush()V
    :try_end_8
    .catchall {:try_start_8 .. :try_end_8} :catchall_0

    .line 634
    const-wide/16 v6, 0x0

    move-wide/from16 v17, v6

    .line 637
    :cond_2
    :try_start_9
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v6
    :try_end_9
    .catchall {:try_start_9 .. :try_end_9} :catchall_1

    .line 638
    .local v6, "currentTime":J
    sub-long v25, v6, v15

    const-wide/16 v27, 0x12c

    cmp-long v25, v25, v27

    if-ltz v25, :cond_5

    .line 639
    const-wide/16 v25, 0x0

    cmp-long v25, v11, v25

    if-lez v25, :cond_3

    .line 640
    move/from16 v25, v1

    .end local v1    # "bytesRead":I
    .local v25, "bytesRead":I
    const/16 v1, 0x64

    move/from16 p1, v9

    move-object/from16 v26, v10

    .end local v9    # "$i$a$-use-OtaServiceImpl$otaDownload$1$1":I
    .end local v10    # "inputStream":Ljava/io/InputStream;
    .local v26, "inputStream":Ljava/io/InputStream;
    .local p1, "$i$a$-use-OtaServiceImpl$otaDownload$1$1":I
    int-to-long v9, v1

    mul-long/2addr v9, v13

    :try_start_a
    div-long/2addr v9, v11

    long-to-int v1, v9

    goto :goto_3

    .line 641
    .end local v25    # "bytesRead":I
    .end local v26    # "inputStream":Ljava/io/InputStream;
    .end local p1    # "$i$a$-use-OtaServiceImpl$otaDownload$1$1":I
    .restart local v1    # "bytesRead":I
    .restart local v9    # "$i$a$-use-OtaServiceImpl$otaDownload$1$1":I
    .restart local v10    # "inputStream":Ljava/io/InputStream;
    :cond_3
    move/from16 v25, v1

    move/from16 p1, v9

    move-object/from16 v26, v10

    .end local v1    # "bytesRead":I
    .end local v9    # "$i$a$-use-OtaServiceImpl$otaDownload$1$1":I
    .end local v10    # "inputStream":Ljava/io/InputStream;
    .restart local v25    # "bytesRead":I
    .restart local v26    # "inputStream":Ljava/io/InputStream;
    .restart local p1    # "$i$a$-use-OtaServiceImpl$otaDownload$1$1":I
    const/4 v1, 0x0

    .line 639
    :goto_3
    nop

    .line 643
    .local v1, "progress":I
    if-eq v1, v8, :cond_4

    .line 644
    move v8, v1

    .line 645
    move-wide v15, v6

    .line 646
    invoke-static {}, Lcom/rokid/security/phone/sdk/base/utils/other/ScopesKt;->getMainScope()Lkotlinx/coroutines/CoroutineScope;

    move-result-object v27

    new-instance v9, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$otaDownload$1$1$1$2;

    move-object/from16 v10, v23

    move-object/from16 v23, v3

    const/4 v3, 0x0

    .end local v3    # "buffer":[B
    .local v23, "buffer":[B
    invoke-direct {v9, v1, v10, v3}, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$otaDownload$1$1$1$2;-><init>(ILcom/rokid/security/phone/sdk/api/base/DownloadListener;Lkotlin/coroutines/Continuation;)V

    move-object/from16 v30, v9

    check-cast v30, Lkotlin/jvm/functions/Function2;

    const/16 v31, 0x3

    const/16 v32, 0x0

    const/16 v28, 0x0

    const/16 v29, 0x0

    invoke-static/range {v27 .. v32}, Lkotlinx/coroutines/BuildersKt;->launch$default(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/CoroutineContext;Lkotlinx/coroutines/CoroutineStart;Lkotlin/jvm/functions/Function2;ILjava/lang/Object;)Lkotlinx/coroutines/Job;

    move-object/from16 v1, p0

    move/from16 v9, p1

    move-object v7, v10

    move-object/from16 v6, v22

    move-object/from16 v3, v23

    move/from16 v22, v25

    move-object/from16 v10, v26

    goto/16 :goto_1

    .line 643
    .end local v23    # "buffer":[B
    .restart local v3    # "buffer":[B
    :cond_4
    move-object/from16 v10, v23

    move-object/from16 v23, v3

    .end local v3    # "buffer":[B
    .restart local v23    # "buffer":[B
    goto :goto_4

    .line 638
    .end local v23    # "buffer":[B
    .end local v25    # "bytesRead":I
    .end local v26    # "inputStream":Ljava/io/InputStream;
    .end local p1    # "$i$a$-use-OtaServiceImpl$otaDownload$1$1":I
    .local v1, "bytesRead":I
    .restart local v3    # "buffer":[B
    .restart local v9    # "$i$a$-use-OtaServiceImpl$otaDownload$1$1":I
    .restart local v10    # "inputStream":Ljava/io/InputStream;
    :cond_5
    move/from16 v25, v1

    move/from16 p1, v9

    move-object/from16 v26, v10

    move-object/from16 v10, v23

    move-object/from16 v23, v3

    .line 626
    .end local v1    # "bytesRead":I
    .end local v3    # "buffer":[B
    .end local v6    # "currentTime":J
    .end local v9    # "$i$a$-use-OtaServiceImpl$otaDownload$1$1":I
    .end local v10    # "inputStream":Ljava/io/InputStream;
    .restart local v23    # "buffer":[B
    .restart local v25    # "bytesRead":I
    .restart local v26    # "inputStream":Ljava/io/InputStream;
    .restart local p1    # "$i$a$-use-OtaServiceImpl$otaDownload$1$1":I
    :goto_4
    move-object/from16 v1, p0

    move/from16 v9, p1

    move-object v7, v10

    move-object/from16 v6, v22

    move-object/from16 v3, v23

    move/from16 v22, v25

    move-object/from16 v10, v26

    goto/16 :goto_1

    .line 622
    .end local v0    # "output":Ljava/io/FileOutputStream;
    .end local v8    # "lastProgress":I
    .end local v11    # "totalBytes":J
    .end local v13    # "downloadedBytes":J
    .end local v15    # "lastUpdateTime":J
    .end local v17    # "totalBytesRead":J
    .end local v19    # "startTime":J
    .end local v21    # "$i$a$-use-OtaServiceImpl$otaDownload$1$1$1":I
    .end local v23    # "buffer":[B
    .end local v25    # "bytesRead":I
    .end local v26    # "inputStream":Ljava/io/InputStream;
    .end local p1    # "$i$a$-use-OtaServiceImpl$otaDownload$1$1":I
    .restart local v9    # "$i$a$-use-OtaServiceImpl$otaDownload$1$1":I
    :catchall_1
    move-exception v0

    move/from16 p1, v9

    move-object v1, v0

    .end local v9    # "$i$a$-use-OtaServiceImpl$otaDownload$1$1":I
    .restart local p1    # "$i$a$-use-OtaServiceImpl$otaDownload$1$1":I
    goto :goto_5

    .line 626
    .restart local v0    # "output":Ljava/io/FileOutputStream;
    .restart local v3    # "buffer":[B
    .restart local v8    # "lastProgress":I
    .restart local v9    # "$i$a$-use-OtaServiceImpl$otaDownload$1$1":I
    .restart local v10    # "inputStream":Ljava/io/InputStream;
    .restart local v11    # "totalBytes":J
    .restart local v13    # "downloadedBytes":J
    .restart local v15    # "lastUpdateTime":J
    .restart local v17    # "totalBytesRead":J
    .restart local v19    # "startTime":J
    .restart local v21    # "$i$a$-use-OtaServiceImpl$otaDownload$1$1$1":I
    .local p1, "bytesRead":I
    :cond_6
    move/from16 v25, p1

    move-object/from16 v23, v3

    move/from16 p1, v9

    move-object/from16 v26, v10

    move-object v10, v7

    .line 653
    .end local v3    # "buffer":[B
    .end local v8    # "lastProgress":I
    .end local v9    # "$i$a$-use-OtaServiceImpl$otaDownload$1$1":I
    .end local v10    # "inputStream":Ljava/io/InputStream;
    .end local v11    # "totalBytes":J
    .end local v13    # "downloadedBytes":J
    .end local v15    # "lastUpdateTime":J
    .end local v17    # "totalBytesRead":J
    .local p1, "$i$a$-use-OtaServiceImpl$otaDownload$1$1":I
    invoke-virtual {v0}, Ljava/io/FileOutputStream;->flush()V

    .line 656
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v6

    sub-long v6, v6, v19

    .line 657
    .end local v19    # "startTime":J
    .local v6, "totalTime":J
    sget-object v1, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;

    invoke-virtual {v1}, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;->getTAG()Ljava/lang/String;

    move-result-object v1

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v8, "\u666e\u901a\u4e0b\u8f7d\u5b8c\u6210\uff0c\u603b\u8017\u65f6: "

    invoke-virtual {v3, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v6, v7}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v8, "ms"

    invoke-virtual {v3, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    filled-new-array {v3}, [Ljava/lang/Object;

    move-result-object v3

    invoke-static {v1, v3}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 659
    const/4 v1, 0x1

    invoke-interface {v10, v1}, Lcom/rokid/security/phone/sdk/api/base/DownloadListener;->onResult(I)V

    .line 660
    nop

    .end local v0    # "output":Ljava/io/FileOutputStream;
    .end local v6    # "totalTime":J
    .end local v21    # "$i$a$-use-OtaServiceImpl$otaDownload$1$1$1":I
    sget-object v0, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;
    :try_end_a
    .catchall {:try_start_a .. :try_end_a} :catchall_2

    .line 622
    const/4 v1, 0x0

    :try_start_b
    invoke-static {v4, v1}, Lkotlin/io/CloseableKt;->closeFinally(Ljava/io/Closeable;Ljava/lang/Throwable;)V

    .line 661
    nop

    .end local p1    # "$i$a$-use-OtaServiceImpl$otaDownload$1$1":I
    sget-object v0, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;
    :try_end_b
    .catchall {:try_start_b .. :try_end_b} :catchall_5

    .line 611
    :try_start_c
    invoke-static {v5, v1}, Lkotlin/io/CloseableKt;->closeFinally(Ljava/io/Closeable;Ljava/lang/Throwable;)V
    :try_end_c
    .catch Ljava/lang/Exception; {:try_start_c .. :try_end_c} :catch_1

    goto :goto_7

    .line 622
    .restart local p1    # "$i$a$-use-OtaServiceImpl$otaDownload$1$1":I
    :catchall_2
    move-exception v0

    move-object v1, v0

    goto :goto_5

    .end local v22    # "$result":Ljava/lang/Object;
    .end local p1    # "$i$a$-use-OtaServiceImpl$otaDownload$1$1":I
    .local v6, "$result":Ljava/lang/Object;
    .restart local v9    # "$i$a$-use-OtaServiceImpl$otaDownload$1$1":I
    :catchall_3
    move-exception v0

    move-object/from16 v22, v6

    move/from16 p1, v9

    move-object v1, v0

    .end local v2    # "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$otaDownload$1;
    .end local v6    # "$result":Ljava/lang/Object;
    .end local v9    # "$i$a$-use-OtaServiceImpl$otaDownload$1$1":I
    :goto_5
    :try_start_d
    throw v1
    :try_end_d
    .catchall {:try_start_d .. :try_end_d} :catchall_4

    .restart local v2    # "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$otaDownload$1;
    .restart local v22    # "$result":Ljava/lang/Object;
    .restart local p1    # "$i$a$-use-OtaServiceImpl$otaDownload$1$1":I
    :catchall_4
    move-exception v0

    move-object v3, v0

    :try_start_e
    invoke-static {v4, v1}, Lkotlin/io/CloseableKt;->closeFinally(Ljava/io/Closeable;Ljava/lang/Throwable;)V

    .end local v2    # "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$otaDownload$1;
    .end local v22    # "$result":Ljava/lang/Object;
    throw v3
    :try_end_e
    .catchall {:try_start_e .. :try_end_e} :catchall_5

    .line 611
    .end local p1    # "$i$a$-use-OtaServiceImpl$otaDownload$1$1":I
    .restart local v2    # "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$otaDownload$1;
    .restart local v22    # "$result":Ljava/lang/Object;
    :catchall_5
    move-exception v0

    move-object v1, v0

    goto :goto_6

    .end local v22    # "$result":Ljava/lang/Object;
    .restart local v6    # "$result":Ljava/lang/Object;
    :catchall_6
    move-exception v0

    move-object/from16 v22, v6

    move-object v1, v0

    .end local v2    # "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$otaDownload$1;
    .end local v6    # "$result":Ljava/lang/Object;
    :goto_6
    :try_start_f
    throw v1
    :try_end_f
    .catchall {:try_start_f .. :try_end_f} :catchall_7

    .restart local v2    # "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$otaDownload$1;
    .restart local v22    # "$result":Ljava/lang/Object;
    :catchall_7
    move-exception v0

    move-object v3, v0

    :try_start_10
    invoke-static {v5, v1}, Lkotlin/io/CloseableKt;->closeFinally(Ljava/io/Closeable;Ljava/lang/Throwable;)V

    .end local v2    # "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$otaDownload$1;
    .end local v22    # "$result":Ljava/lang/Object;
    throw v3

    .restart local v2    # "this":Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$otaDownload$1;
    .restart local v6    # "$result":Ljava/lang/Object;
    :cond_7
    move-object/from16 v22, v6

    .end local v6    # "$result":Ljava/lang/Object;
    .restart local v22    # "$result":Ljava/lang/Object;
    goto :goto_7

    .line 663
    .end local v22    # "$result":Ljava/lang/Object;
    .local v0, "response":Lretrofit2/Response;
    .restart local v6    # "$result":Ljava/lang/Object;
    :cond_8
    move-object/from16 v22, v6

    .end local v6    # "$result":Ljava/lang/Object;
    .restart local v22    # "$result":Ljava/lang/Object;
    sget-object v1, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;

    invoke-virtual {v1}, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;->getTAG()Ljava/lang/String;

    move-result-object v1

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v4, "\u4e0b\u8f7d\u5931\u8d25: HTTP "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v0}, Lretrofit2/Response;->code()I

    move-result v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    filled-new-array {v3}, [Ljava/lang/Object;

    move-result-object v3

    .end local v0    # "response":Lretrofit2/Response;
    invoke-static {v1, v3}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 664
    invoke-static {}, Lcom/rokid/security/phone/sdk/base/utils/other/ScopesKt;->getMainScope()Lkotlinx/coroutines/CoroutineScope;

    move-result-object v4

    new-instance v0, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$otaDownload$1$2;

    iget-object v1, v2, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$otaDownload$1;->$listener:Lcom/rokid/security/phone/sdk/api/base/DownloadListener;

    const/4 v3, 0x0

    invoke-direct {v0, v1, v3}, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$otaDownload$1$2;-><init>(Lcom/rokid/security/phone/sdk/api/base/DownloadListener;Lkotlin/coroutines/Continuation;)V

    move-object v7, v0

    check-cast v7, Lkotlin/jvm/functions/Function2;

    const/4 v8, 0x3

    const/4 v9, 0x0

    const/4 v5, 0x0

    const/4 v6, 0x0

    invoke-static/range {v4 .. v9}, Lkotlinx/coroutines/BuildersKt;->launch$default(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/CoroutineContext;Lkotlinx/coroutines/CoroutineStart;Lkotlin/jvm/functions/Function2;ILjava/lang/Object;)Lkotlinx/coroutines/Job;
    :try_end_10
    .catch Ljava/lang/Exception; {:try_start_10 .. :try_end_10} :catch_1

    .line 674
    :goto_7
    move-object/from16 v6, v22

    goto :goto_9

    .line 668
    :catch_1
    move-exception v0

    move-object/from16 v5, v22

    goto :goto_8

    .end local v22    # "$result":Ljava/lang/Object;
    .restart local v6    # "$result":Ljava/lang/Object;
    :catch_2
    move-exception v0

    move-object/from16 v22, v6

    move-object/from16 v5, v22

    .line 669
    .end local v6    # "$result":Ljava/lang/Object;
    .local v0, "e":Ljava/lang/Exception;
    .restart local v5    # "$result":Ljava/lang/Object;
    :goto_8
    sget-object v1, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;

    invoke-virtual {v1}, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;->getTAG()Ljava/lang/String;

    move-result-object v1

    const-string/jumbo v3, "\u4e0b\u8f7d\u5f02\u5e38 2"

    filled-new-array {v3, v0}, [Ljava/lang/Object;

    move-result-object v3

    invoke-static {v1, v3}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 670
    invoke-static {}, Lcom/rokid/security/phone/sdk/base/utils/other/ScopesKt;->getMainScope()Lkotlinx/coroutines/CoroutineScope;

    move-result-object v6

    new-instance v1, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$otaDownload$1$3;

    iget-object v3, v2, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$otaDownload$1;->$listener:Lcom/rokid/security/phone/sdk/api/base/DownloadListener;

    const/4 v4, 0x0

    invoke-direct {v1, v3, v4}, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$otaDownload$1$3;-><init>(Lcom/rokid/security/phone/sdk/api/base/DownloadListener;Lkotlin/coroutines/Continuation;)V

    move-object v9, v1

    check-cast v9, Lkotlin/jvm/functions/Function2;

    const/4 v10, 0x3

    const/4 v11, 0x0

    const/4 v7, 0x0

    const/4 v8, 0x0

    invoke-static/range {v6 .. v11}, Lkotlinx/coroutines/BuildersKt;->launch$default(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/CoroutineContext;Lkotlinx/coroutines/CoroutineStart;Lkotlin/jvm/functions/Function2;ILjava/lang/Object;)Lkotlinx/coroutines/Job;

    move-object v6, v5

    .line 674
    .end local v0    # "e":Ljava/lang/Exception;
    .end local v5    # "$result":Ljava/lang/Object;
    .restart local v6    # "$result":Ljava/lang/Object;
    :goto_9
    sget-object v0, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    return-object v0

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method
