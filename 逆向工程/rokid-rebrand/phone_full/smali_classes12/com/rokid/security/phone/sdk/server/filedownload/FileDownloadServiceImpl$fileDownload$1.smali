.class final Lcom/rokid/security/phone/sdk/server/filedownload/FileDownloadServiceImpl$fileDownload$1;
.super Lkotlin/coroutines/jvm/internal/SuspendLambda;
.source "FileDownloadServiceImpl.kt"

# interfaces
.implements Lkotlin/jvm/functions/Function2;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/security/phone/sdk/server/filedownload/FileDownloadServiceImpl;->fileDownload(Ljava/lang/String;Ljava/lang/String;Lcom/rokid/security/phone/sdk/api/base/DownloadListener;)V
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
    value = "SMAP\nFileDownloadServiceImpl.kt\nKotlin\n*S Kotlin\n*F\n+ 1 FileDownloadServiceImpl.kt\ncom/rokid/security/phone/sdk/server/filedownload/FileDownloadServiceImpl$fileDownload$1\n+ 2 fake.kt\nkotlin/jvm/internal/FakeKt\n*L\n1#1,116:1\n1#2:117\n*E\n"
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
    c = "com.rokid.security.phone.sdk.server.filedownload.FileDownloadServiceImpl$fileDownload$1"
    f = "FileDownloadServiceImpl.kt"
    i = {}
    l = {
        0x38
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
            "Lcom/rokid/security/phone/sdk/server/filedownload/FileDownloadServiceImpl$fileDownload$1;",
            ">;)V"
        }
    .end annotation

    iput-object p1, p0, Lcom/rokid/security/phone/sdk/server/filedownload/FileDownloadServiceImpl$fileDownload$1;->$url:Ljava/lang/String;

    iput-object p2, p0, Lcom/rokid/security/phone/sdk/server/filedownload/FileDownloadServiceImpl$fileDownload$1;->$listener:Lcom/rokid/security/phone/sdk/api/base/DownloadListener;

    iput-object p3, p0, Lcom/rokid/security/phone/sdk/server/filedownload/FileDownloadServiceImpl$fileDownload$1;->$path:Ljava/lang/String;

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

    new-instance v0, Lcom/rokid/security/phone/sdk/server/filedownload/FileDownloadServiceImpl$fileDownload$1;

    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/filedownload/FileDownloadServiceImpl$fileDownload$1;->$url:Ljava/lang/String;

    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/filedownload/FileDownloadServiceImpl$fileDownload$1;->$listener:Lcom/rokid/security/phone/sdk/api/base/DownloadListener;

    iget-object v3, p0, Lcom/rokid/security/phone/sdk/server/filedownload/FileDownloadServiceImpl$fileDownload$1;->$path:Ljava/lang/String;

    invoke-direct {v0, v1, v2, v3, p2}, Lcom/rokid/security/phone/sdk/server/filedownload/FileDownloadServiceImpl$fileDownload$1;-><init>(Ljava/lang/String;Lcom/rokid/security/phone/sdk/api/base/DownloadListener;Ljava/lang/String;Lkotlin/coroutines/Continuation;)V

    check-cast v0, Lkotlin/coroutines/Continuation;

    return-object v0
.end method

.method public bridge synthetic invoke(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    .locals 1

    check-cast p1, Lkotlinx/coroutines/CoroutineScope;

    check-cast p2, Lkotlin/coroutines/Continuation;

    invoke-virtual {p0, p1, p2}, Lcom/rokid/security/phone/sdk/server/filedownload/FileDownloadServiceImpl$fileDownload$1;->invoke(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

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

    invoke-virtual {p0, p1, p2}, Lcom/rokid/security/phone/sdk/server/filedownload/FileDownloadServiceImpl$fileDownload$1;->create(Ljava/lang/Object;Lkotlin/coroutines/Continuation;)Lkotlin/coroutines/Continuation;

    move-result-object v0

    check-cast v0, Lcom/rokid/security/phone/sdk/server/filedownload/FileDownloadServiceImpl$fileDownload$1;

    sget-object v1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    invoke-virtual {v0, v1}, Lcom/rokid/security/phone/sdk/server/filedownload/FileDownloadServiceImpl$fileDownload$1;->invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public final invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 25

    invoke-static {}, Lkotlin/coroutines/intrinsics/IntrinsicsKt;->getCOROUTINE_SUSPENDED()Ljava/lang/Object;

    move-result-object v0

    .line 44
    move-object/from16 v1, p0

    iget v2, v1, Lcom/rokid/security/phone/sdk/server/filedownload/FileDownloadServiceImpl$fileDownload$1;->label:I

    const/4 v3, 0x1

    packed-switch v2, :pswitch_data_0

    new-instance v0, Ljava/lang/IllegalStateException;

    const-string v1, "call to \'resume\' before \'invoke\' with coroutine"

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0

    :pswitch_0
    move-object/from16 v2, p0

    .local v2, "this":Lcom/rokid/security/phone/sdk/server/filedownload/FileDownloadServiceImpl$fileDownload$1;
    move-object/from16 v5, p1

    .local v5, "$result":Ljava/lang/Object;
    :try_start_0
    invoke-static {v5}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-object v6, v5

    goto :goto_0

    .line 103
    :catch_0
    move-exception v0

    goto/16 :goto_4

    .line 44
    .end local v2    # "this":Lcom/rokid/security/phone/sdk/server/filedownload/FileDownloadServiceImpl$fileDownload$1;
    .end local v5    # "$result":Ljava/lang/Object;
    :pswitch_1
    invoke-static/range {p1 .. p1}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    move-object/from16 v2, p0

    .restart local v2    # "this":Lcom/rokid/security/phone/sdk/server/filedownload/FileDownloadServiceImpl$fileDownload$1;
    move-object/from16 v5, p1

    .line 45
    .restart local v5    # "$result":Ljava/lang/Object;
    nop

    .line 47
    :try_start_1
    sget-object v6, Lcom/rokid/security/phone/sdk/server/net/ApiProvider;->INSTANCE:Lcom/rokid/security/phone/sdk/server/net/ApiProvider;

    new-instance v7, Lcom/rokid/security/phone/sdk/server/filedownload/FileDownloadServiceImpl$fileDownload$1$response$1;

    iget-object v8, v2, Lcom/rokid/security/phone/sdk/server/filedownload/FileDownloadServiceImpl$fileDownload$1;->$listener:Lcom/rokid/security/phone/sdk/api/base/DownloadListener;

    invoke-direct {v7, v8}, Lcom/rokid/security/phone/sdk/server/filedownload/FileDownloadServiceImpl$fileDownload$1$response$1;-><init>(Lcom/rokid/security/phone/sdk/api/base/DownloadListener;)V

    check-cast v7, Lcom/rokid/security/phone/sdk/base/utils/net/DownloadListener;

    invoke-virtual {v6, v7}, Lcom/rokid/security/phone/sdk/server/net/ApiProvider;->getDownloadFileApi(Lcom/rokid/security/phone/sdk/base/utils/net/DownloadListener;)Lcom/rokid/security/phone/sdk/server/net/DownloadApi;

    move-result-object v6

    .line 56
    iget-object v7, v2, Lcom/rokid/security/phone/sdk/server/filedownload/FileDownloadServiceImpl$fileDownload$1;->$url:Ljava/lang/String;

    move-object v8, v2

    check-cast v8, Lkotlin/coroutines/Continuation;

    iput v3, v2, Lcom/rokid/security/phone/sdk/server/filedownload/FileDownloadServiceImpl$fileDownload$1;->label:I

    invoke-interface {v6, v7, v8}, Lcom/rokid/security/phone/sdk/server/net/DownloadApi;->downloadFile(Ljava/lang/String;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v6
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    if-ne v6, v0, :cond_0

    .line 44
    return-object v0

    .line 56
    :cond_0
    move-object/from16 v24, v6

    move-object v6, v5

    move-object/from16 v5, v24

    .line 44
    .end local v5    # "$result":Ljava/lang/Object;
    .local v6, "$result":Ljava/lang/Object;
    :goto_0
    :try_start_2
    check-cast v5, Lretrofit2/Response;

    .line 47
    move-object v0, v5

    .line 58
    .local v0, "response":Lretrofit2/Response;
    invoke-virtual {v0}, Lretrofit2/Response;->isSuccessful()Z

    move-result v5

    if-eqz v5, :cond_5

    .line 59
    invoke-virtual {v0}, Lretrofit2/Response;->body()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Lokhttp3/ResponseBody;

    .end local v0    # "response":Lretrofit2/Response;
    if-eqz v5, :cond_6

    check-cast v5, Ljava/io/Closeable;

    iget-object v0, v2, Lcom/rokid/security/phone/sdk/server/filedownload/FileDownloadServiceImpl$fileDownload$1;->$path:Ljava/lang/String;

    iget-object v7, v2, Lcom/rokid/security/phone/sdk/server/filedownload/FileDownloadServiceImpl$fileDownload$1;->$listener:Lcom/rokid/security/phone/sdk/api/base/DownloadListener;
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_1

    :try_start_3
    move-object v8, v5

    check-cast v8, Lokhttp3/ResponseBody;

    .local v8, "body":Lokhttp3/ResponseBody;
    const/4 v9, 0x0

    .line 60
    .local v9, "$i$a$-use-FileDownloadServiceImpl$fileDownload$1$1":I
    invoke-virtual {v8}, Lokhttp3/ResponseBody;->byteStream()Ljava/io/InputStream;

    move-result-object v10

    .line 61
    .local v10, "inputStream":Ljava/io/InputStream;
    new-instance v11, Ljava/io/File;

    invoke-direct {v11, v0}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    move-object v0, v11

    .line 62
    .local v0, "outputFile":Ljava/io/File;
    invoke-virtual {v8}, Lokhttp3/ResponseBody;->contentLength()J

    move-result-wide v11

    .line 65
    .end local v8    # "body":Lokhttp3/ResponseBody;
    .local v11, "totalBytes":J
    const-wide/16 v13, 0x0

    .line 66
    .local v13, "downloadedBytes":J
    const/4 v8, 0x0

    .local v8, "lastProgress":I
    const/4 v8, -0x1

    .line 68
    new-instance v15, Ljava/io/FileOutputStream;

    invoke-direct {v15, v0}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V

    check-cast v15, Ljava/io/Closeable;
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_2

    .end local v0    # "outputFile":Ljava/io/File;
    :try_start_4
    move-object v0, v15

    check-cast v0, Ljava/io/FileOutputStream;

    .local v0, "output":Ljava/io/FileOutputStream;
    const/16 v16, 0x0

    .line 69
    .local v16, "$i$a$-use-FileDownloadServiceImpl$fileDownload$1$1$1":I
    const/16 v4, 0x2000

    new-array v4, v4, [B

    .line 70
    .local v4, "buffer":[B
    const/16 v17, 0x0

    .line 72
    .local v17, "bytesRead":I
    :goto_1
    invoke-virtual {v10, v4}, Ljava/io/InputStream;->read([B)I

    move-result v3

    move/from16 v18, v3

    .line 117
    .local v18, "it":I
    const/16 v19, 0x0

    .line 72
    .local v19, "$i$a$-also-FileDownloadServiceImpl$fileDownload$1$1$1$1":I
    move/from16 p1, v18

    .end local v17    # "bytesRead":I
    .end local v18    # "it":I
    .end local v19    # "$i$a$-also-FileDownloadServiceImpl$fileDownload$1$1$1$1":I
    .local p1, "bytesRead":I
    const/4 v1, -0x1

    if-eq v3, v1, :cond_4

    sget-object v1, Lcom/rokid/security/phone/sdk/server/filedownload/FileDownloadServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/filedownload/FileDownloadServiceImpl;

    invoke-virtual {v1}, Lcom/rokid/security/phone/sdk/server/filedownload/FileDownloadServiceImpl;->getDownloadJob()Lkotlinx/coroutines/Job;

    move-result-object v1

    if-eqz v1, :cond_1

    invoke-interface {v1}, Lkotlinx/coroutines/Job;->isActive()Z

    move-result v1

    const/4 v3, 0x1

    if-ne v1, v3, :cond_1

    const/4 v3, 0x1

    goto :goto_2

    :cond_1
    const/4 v3, 0x0

    :goto_2
    if-eqz v3, :cond_4

    .line 73
    move/from16 v1, p1

    const/4 v3, 0x0

    .end local p1    # "bytesRead":I
    .local v1, "bytesRead":I
    invoke-virtual {v0, v4, v3, v1}, Ljava/io/FileOutputStream;->write([BII)V

    .line 74
    move-object/from16 p1, v4

    .end local v4    # "buffer":[B
    .local p1, "buffer":[B
    int-to-long v3, v1

    add-long/2addr v13, v3

    .line 77
    const-wide/16 v3, 0x0

    cmp-long v3, v11, v3

    if-lez v3, :cond_2

    .line 78
    const/16 v3, 0x64

    int-to-long v3, v3

    mul-long/2addr v3, v13

    div-long/2addr v3, v11

    long-to-int v3, v3

    goto :goto_3

    .line 79
    :cond_2
    const/4 v3, 0x0

    .line 77
    :goto_3
    nop

    .line 82
    .local v3, "progress":I
    if-eq v3, v8, :cond_3

    .line 83
    move v8, v3

    .line 86
    invoke-static {}, Lcom/rokid/security/phone/sdk/base/utils/other/ScopesKt;->getMainScope()Lkotlinx/coroutines/CoroutineScope;

    move-result-object v18

    new-instance v4, Lcom/rokid/security/phone/sdk/server/filedownload/FileDownloadServiceImpl$fileDownload$1$1$1$2;

    move/from16 v17, v1

    const/4 v1, 0x0

    .end local v1    # "bytesRead":I
    .restart local v17    # "bytesRead":I
    invoke-direct {v4, v3, v7, v1}, Lcom/rokid/security/phone/sdk/server/filedownload/FileDownloadServiceImpl$fileDownload$1$1$1$2;-><init>(ILcom/rokid/security/phone/sdk/api/base/DownloadListener;Lkotlin/coroutines/Continuation;)V

    move-object/from16 v21, v4

    check-cast v21, Lkotlin/jvm/functions/Function2;

    const/16 v22, 0x3

    const/16 v23, 0x0

    const/16 v19, 0x0

    const/16 v20, 0x0

    invoke-static/range {v18 .. v23}, Lkotlinx/coroutines/BuildersKt;->launch$default(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/CoroutineContext;Lkotlinx/coroutines/CoroutineStart;Lkotlin/jvm/functions/Function2;ILjava/lang/Object;)Lkotlinx/coroutines/Job;

    move-object/from16 v1, p0

    move-object/from16 v4, p1

    const/4 v3, 0x1

    goto :goto_1

    .line 82
    .end local v17    # "bytesRead":I
    .restart local v1    # "bytesRead":I
    :cond_3
    move/from16 v17, v1

    .end local v1    # "bytesRead":I
    .restart local v17    # "bytesRead":I
    move-object/from16 v1, p0

    move-object/from16 v4, p1

    const/4 v3, 0x1

    goto :goto_1

    .line 72
    .end local v3    # "progress":I
    .end local v17    # "bytesRead":I
    .restart local v4    # "buffer":[B
    .local p1, "bytesRead":I
    :cond_4
    move/from16 v17, p1

    move-object/from16 p1, v4

    .line 92
    .end local v4    # "buffer":[B
    .end local v8    # "lastProgress":I
    .end local v10    # "inputStream":Ljava/io/InputStream;
    .end local v11    # "totalBytes":J
    .end local v13    # "downloadedBytes":J
    .end local p1    # "bytesRead":I
    const/4 v1, 0x1

    invoke-interface {v7, v1}, Lcom/rokid/security/phone/sdk/api/base/DownloadListener;->onResult(I)V

    .line 93
    invoke-virtual {v0}, Ljava/io/FileOutputStream;->flush()V

    .line 94
    nop

    .end local v0    # "output":Ljava/io/FileOutputStream;
    .end local v16    # "$i$a$-use-FileDownloadServiceImpl$fileDownload$1$1$1":I
    sget-object v0, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    .line 68
    const/4 v1, 0x0

    :try_start_5
    invoke-static {v15, v1}, Lkotlin/io/CloseableKt;->closeFinally(Ljava/io/Closeable;Ljava/lang/Throwable;)V

    .line 95
    nop

    .end local v9    # "$i$a$-use-FileDownloadServiceImpl$fileDownload$1$1":I
    sget-object v0, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_2

    .line 59
    :try_start_6
    invoke-static {v5, v1}, Lkotlin/io/CloseableKt;->closeFinally(Ljava/io/Closeable;Ljava/lang/Throwable;)V
    :try_end_6
    .catch Ljava/lang/Exception; {:try_start_6 .. :try_end_6} :catch_1

    goto/16 :goto_5

    .line 68
    .restart local v9    # "$i$a$-use-FileDownloadServiceImpl$fileDownload$1$1":I
    :catchall_0
    move-exception v0

    move-object v1, v0

    .end local v2    # "this":Lcom/rokid/security/phone/sdk/server/filedownload/FileDownloadServiceImpl$fileDownload$1;
    .end local v6    # "$result":Ljava/lang/Object;
    .end local v9    # "$i$a$-use-FileDownloadServiceImpl$fileDownload$1$1":I
    :try_start_7
    throw v1
    :try_end_7
    .catchall {:try_start_7 .. :try_end_7} :catchall_1

    .restart local v2    # "this":Lcom/rokid/security/phone/sdk/server/filedownload/FileDownloadServiceImpl$fileDownload$1;
    .restart local v6    # "$result":Ljava/lang/Object;
    .restart local v9    # "$i$a$-use-FileDownloadServiceImpl$fileDownload$1$1":I
    :catchall_1
    move-exception v0

    move-object v3, v0

    :try_start_8
    invoke-static {v15, v1}, Lkotlin/io/CloseableKt;->closeFinally(Ljava/io/Closeable;Ljava/lang/Throwable;)V

    .end local v2    # "this":Lcom/rokid/security/phone/sdk/server/filedownload/FileDownloadServiceImpl$fileDownload$1;
    .end local v6    # "$result":Ljava/lang/Object;
    throw v3
    :try_end_8
    .catchall {:try_start_8 .. :try_end_8} :catchall_2

    .line 59
    .end local v9    # "$i$a$-use-FileDownloadServiceImpl$fileDownload$1$1":I
    .restart local v2    # "this":Lcom/rokid/security/phone/sdk/server/filedownload/FileDownloadServiceImpl$fileDownload$1;
    .restart local v6    # "$result":Ljava/lang/Object;
    :catchall_2
    move-exception v0

    move-object v1, v0

    .end local v2    # "this":Lcom/rokid/security/phone/sdk/server/filedownload/FileDownloadServiceImpl$fileDownload$1;
    .end local v6    # "$result":Ljava/lang/Object;
    :try_start_9
    throw v1
    :try_end_9
    .catchall {:try_start_9 .. :try_end_9} :catchall_3

    .restart local v2    # "this":Lcom/rokid/security/phone/sdk/server/filedownload/FileDownloadServiceImpl$fileDownload$1;
    .restart local v6    # "$result":Ljava/lang/Object;
    :catchall_3
    move-exception v0

    move-object v3, v0

    :try_start_a
    invoke-static {v5, v1}, Lkotlin/io/CloseableKt;->closeFinally(Ljava/io/Closeable;Ljava/lang/Throwable;)V

    .end local v2    # "this":Lcom/rokid/security/phone/sdk/server/filedownload/FileDownloadServiceImpl$fileDownload$1;
    .end local v6    # "$result":Ljava/lang/Object;
    throw v3

    .line 97
    .local v0, "response":Lretrofit2/Response;
    .restart local v2    # "this":Lcom/rokid/security/phone/sdk/server/filedownload/FileDownloadServiceImpl$fileDownload$1;
    .restart local v6    # "$result":Ljava/lang/Object;
    :cond_5
    sget-object v1, Lcom/rokid/security/phone/sdk/server/filedownload/FileDownloadServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/filedownload/FileDownloadServiceImpl;

    invoke-virtual {v1}, Lcom/rokid/security/phone/sdk/server/filedownload/FileDownloadServiceImpl;->getTAG()Ljava/lang/String;

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

    .line 98
    invoke-static {}, Lcom/rokid/security/phone/sdk/base/utils/other/ScopesKt;->getMainScope()Lkotlinx/coroutines/CoroutineScope;

    move-result-object v7

    new-instance v0, Lcom/rokid/security/phone/sdk/server/filedownload/FileDownloadServiceImpl$fileDownload$1$2;

    iget-object v1, v2, Lcom/rokid/security/phone/sdk/server/filedownload/FileDownloadServiceImpl$fileDownload$1;->$listener:Lcom/rokid/security/phone/sdk/api/base/DownloadListener;

    const/4 v3, 0x0

    invoke-direct {v0, v1, v3}, Lcom/rokid/security/phone/sdk/server/filedownload/FileDownloadServiceImpl$fileDownload$1$2;-><init>(Lcom/rokid/security/phone/sdk/api/base/DownloadListener;Lkotlin/coroutines/Continuation;)V

    move-object v10, v0

    check-cast v10, Lkotlin/jvm/functions/Function2;

    const/4 v11, 0x3

    const/4 v12, 0x0

    const/4 v8, 0x0

    const/4 v9, 0x0

    invoke-static/range {v7 .. v12}, Lkotlinx/coroutines/BuildersKt;->launch$default(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/CoroutineContext;Lkotlinx/coroutines/CoroutineStart;Lkotlin/jvm/functions/Function2;ILjava/lang/Object;)Lkotlinx/coroutines/Job;
    :try_end_a
    .catch Ljava/lang/Exception; {:try_start_a .. :try_end_a} :catch_1

    goto :goto_5

    .line 103
    :catch_1
    move-exception v0

    move-object v5, v6

    .line 104
    .end local v6    # "$result":Ljava/lang/Object;
    .local v0, "e":Ljava/lang/Exception;
    .restart local v5    # "$result":Ljava/lang/Object;
    :goto_4
    sget-object v1, Lcom/rokid/security/phone/sdk/server/filedownload/FileDownloadServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/filedownload/FileDownloadServiceImpl;

    invoke-virtual {v1}, Lcom/rokid/security/phone/sdk/server/filedownload/FileDownloadServiceImpl;->getTAG()Ljava/lang/String;

    move-result-object v1

    const-string/jumbo v3, "\u4e0b\u8f7d\u5f02\u5e38"

    filled-new-array {v3, v0}, [Ljava/lang/Object;

    move-result-object v3

    invoke-static {v1, v3}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 105
    invoke-static {}, Lcom/rokid/security/phone/sdk/base/utils/other/ScopesKt;->getMainScope()Lkotlinx/coroutines/CoroutineScope;

    move-result-object v6

    new-instance v1, Lcom/rokid/security/phone/sdk/server/filedownload/FileDownloadServiceImpl$fileDownload$1$3;

    iget-object v3, v2, Lcom/rokid/security/phone/sdk/server/filedownload/FileDownloadServiceImpl$fileDownload$1;->$listener:Lcom/rokid/security/phone/sdk/api/base/DownloadListener;

    const/4 v4, 0x0

    invoke-direct {v1, v3, v4}, Lcom/rokid/security/phone/sdk/server/filedownload/FileDownloadServiceImpl$fileDownload$1$3;-><init>(Lcom/rokid/security/phone/sdk/api/base/DownloadListener;Lkotlin/coroutines/Continuation;)V

    move-object v9, v1

    check-cast v9, Lkotlin/jvm/functions/Function2;

    const/4 v10, 0x3

    const/4 v11, 0x0

    const/4 v7, 0x0

    const/4 v8, 0x0

    invoke-static/range {v6 .. v11}, Lkotlinx/coroutines/BuildersKt;->launch$default(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/CoroutineContext;Lkotlinx/coroutines/CoroutineStart;Lkotlin/jvm/functions/Function2;ILjava/lang/Object;)Lkotlinx/coroutines/Job;

    move-object v6, v5

    .line 109
    .end local v0    # "e":Ljava/lang/Exception;
    .end local v5    # "$result":Ljava/lang/Object;
    .restart local v6    # "$result":Ljava/lang/Object;
    :cond_6
    :goto_5
    sget-object v0, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    return-object v0

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method
