.class final Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$1;
.super Lkotlin/coroutines/jvm/internal/SuspendLambda;
.source "ApkSender.kt"

# interfaces
.implements Lkotlin/jvm/functions/Function2;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;->sendFile(Ljava/lang/String;Ljava/io/File;Lcom/rokid/security/sdk/base/common/apk/TransferProgressListener;)V
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
    c = "com.rokid.security.phone.sdk.server.msg.file.ApkSender$sendFile$1"
    f = "ApkSender.kt"
    i = {}
    l = {
        0x32,
        0x35,
        0x37,
        0x3e
    }
    m = "invokeSuspend"
    n = {}
    s = {}
.end annotation


# instance fields
.field final synthetic $file:Ljava/io/File;

.field final synthetic $host:Ljava/lang/String;

.field final synthetic $listener:Lcom/rokid/security/sdk/base/common/apk/TransferProgressListener;

.field label:I

.field final synthetic this$0:Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;


# direct methods
.method constructor <init>(Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;Ljava/lang/String;Lcom/rokid/security/sdk/base/common/apk/TransferProgressListener;Ljava/io/File;Lkotlin/coroutines/Continuation;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;",
            "Ljava/lang/String;",
            "Lcom/rokid/security/sdk/base/common/apk/TransferProgressListener;",
            "Ljava/io/File;",
            "Lkotlin/coroutines/Continuation<",
            "-",
            "Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$1;",
            ">;)V"
        }
    .end annotation

    iput-object p1, p0, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$1;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;

    iput-object p2, p0, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$1;->$host:Ljava/lang/String;

    iput-object p3, p0, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$1;->$listener:Lcom/rokid/security/sdk/base/common/apk/TransferProgressListener;

    iput-object p4, p0, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$1;->$file:Ljava/io/File;

    const/4 v0, 0x2

    invoke-direct {p0, v0, p5}, Lkotlin/coroutines/jvm/internal/SuspendLambda;-><init>(ILkotlin/coroutines/Continuation;)V

    return-void
.end method


# virtual methods
.method public final create(Ljava/lang/Object;Lkotlin/coroutines/Continuation;)Lkotlin/coroutines/Continuation;
    .locals 7
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

    new-instance v6, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$1;

    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$1;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;

    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$1;->$host:Ljava/lang/String;

    iget-object v3, p0, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$1;->$listener:Lcom/rokid/security/sdk/base/common/apk/TransferProgressListener;

    iget-object v4, p0, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$1;->$file:Ljava/io/File;

    move-object v0, v6

    move-object v5, p2

    invoke-direct/range {v0 .. v5}, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$1;-><init>(Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;Ljava/lang/String;Lcom/rokid/security/sdk/base/common/apk/TransferProgressListener;Ljava/io/File;Lkotlin/coroutines/Continuation;)V

    check-cast v6, Lkotlin/coroutines/Continuation;

    return-object v6
.end method

.method public bridge synthetic invoke(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    .locals 1

    check-cast p1, Lkotlinx/coroutines/CoroutineScope;

    check-cast p2, Lkotlin/coroutines/Continuation;

    invoke-virtual {p0, p1, p2}, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$1;->invoke(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

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

    invoke-virtual {p0, p1, p2}, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$1;->create(Ljava/lang/Object;Lkotlin/coroutines/Continuation;)Lkotlin/coroutines/Continuation;

    move-result-object v0

    check-cast v0, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$1;

    sget-object v1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    invoke-virtual {v0, v1}, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$1;->invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public final invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 9

    invoke-static {}, Lkotlin/coroutines/intrinsics/IntrinsicsKt;->getCOROUTINE_SUSPENDED()Ljava/lang/Object;

    move-result-object v0

    .line 48
    iget v1, p0, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$1;->label:I

    const/4 v2, 0x0

    packed-switch v1, :pswitch_data_0

    new-instance p1, Ljava/lang/IllegalStateException;

    const-string v0, "call to \'resume\' before \'invoke\' with coroutine"

    invoke-direct {p1, v0}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p1

    :pswitch_0
    move-object v0, p0

    .local v0, "this":Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$1;
    .local p1, "$result":Ljava/lang/Object;
    const/4 v1, 0x0

    .local v1, "$i$a$-let-ApkSender$sendFile$1$3":I
    :try_start_0
    invoke-static {p1}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    goto/16 :goto_3

    .end local v0    # "this":Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$1;
    .end local v1    # "$i$a$-let-ApkSender$sendFile$1$3":I
    .end local p1    # "$result":Ljava/lang/Object;
    :pswitch_1
    move-object v0, p0

    .restart local v0    # "this":Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$1;
    .restart local p1    # "$result":Ljava/lang/Object;
    invoke-static {p1}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto/16 :goto_2

    .line 68
    :catchall_0
    move-exception v1

    goto/16 :goto_6

    .line 65
    :catch_0
    move-exception v1

    goto/16 :goto_4

    .line 48
    .end local v0    # "this":Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$1;
    .end local p1    # "$result":Ljava/lang/Object;
    :pswitch_2
    move-object v1, p0

    .local v1, "this":Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$1;
    .restart local p1    # "$result":Ljava/lang/Object;
    :try_start_1
    invoke-static {p1}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    move-object v3, v1

    move-object v1, p1

    goto :goto_1

    .end local v1    # "this":Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$1;
    .end local p1    # "$result":Ljava/lang/Object;
    :pswitch_3
    move-object v1, p0

    .restart local v1    # "this":Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$1;
    .restart local p1    # "$result":Ljava/lang/Object;
    invoke-static {p1}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    goto :goto_0

    .line 68
    :catchall_1
    move-exception v0

    move-object v8, v1

    move-object v1, v0

    move-object v0, v8

    goto/16 :goto_6

    .line 65
    :catch_1
    move-exception v0

    move-object v8, v1

    move-object v1, v0

    move-object v0, v8

    goto/16 :goto_4

    .line 48
    .end local v1    # "this":Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$1;
    .end local p1    # "$result":Ljava/lang/Object;
    :pswitch_4
    invoke-static {p1}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    move-object v1, p0

    .line 49
    .restart local v1    # "this":Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$1;
    .restart local p1    # "$result":Ljava/lang/Object;
    nop

    .line 50
    :try_start_2
    invoke-static {}, Lkotlinx/coroutines/Dispatchers;->getMain()Lkotlinx/coroutines/MainCoroutineDispatcher;

    move-result-object v3

    check-cast v3, Lkotlin/coroutines/CoroutineContext;

    new-instance v4, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$1$1;

    iget-object v5, v1, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$1;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;

    invoke-direct {v4, v5, v2}, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$1$1;-><init>(Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;Lkotlin/coroutines/Continuation;)V

    check-cast v4, Lkotlin/jvm/functions/Function2;

    move-object v5, v1

    check-cast v5, Lkotlin/coroutines/Continuation;

    const/4 v6, 0x1

    iput v6, v1, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$1;->label:I

    invoke-static {v3, v4, v5}, Lkotlinx/coroutines/BuildersKt;->withContext(Lkotlin/coroutines/CoroutineContext;Lkotlin/jvm/functions/Function2;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v3

    if-ne v3, v0, :cond_0

    .line 48
    return-object v0

    .line 53
    :cond_0
    :goto_0
    iget-object v3, v1, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$1;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;

    iget-object v4, v1, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$1;->$host:Ljava/lang/String;

    move-object v5, v1

    check-cast v5, Lkotlin/coroutines/Continuation;

    const/4 v6, 0x2

    iput v6, v1, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$1;->label:I

    invoke-static {v3, v4, v5}, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;->access$connectSocket(Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;Ljava/lang/String;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v3
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_1
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    if-ne v3, v0, :cond_1

    .line 48
    return-object v0

    .line 53
    :cond_1
    move-object v8, v1

    move-object v1, p1

    move-object p1, v3

    move-object v3, v8

    .end local p1    # "$result":Ljava/lang/Object;
    .local v1, "$result":Ljava/lang/Object;
    .local v3, "this":Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$1;
    :goto_1
    :try_start_3
    check-cast p1, Ljava/lang/Boolean;

    invoke-virtual {p1}, Ljava/lang/Boolean;->booleanValue()Z

    move-result p1

    .line 54
    .local p1, "ret":Z
    nop

    .end local p1    # "ret":Z
    if-nez p1, :cond_3

    .line 55
    invoke-static {}, Lkotlinx/coroutines/Dispatchers;->getMain()Lkotlinx/coroutines/MainCoroutineDispatcher;

    move-result-object p1

    check-cast p1, Lkotlin/coroutines/CoroutineContext;

    new-instance v4, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$1$2;

    iget-object v5, v3, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$1;->$listener:Lcom/rokid/security/sdk/base/common/apk/TransferProgressListener;

    invoke-direct {v4, v5, v2}, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$1$2;-><init>(Lcom/rokid/security/sdk/base/common/apk/TransferProgressListener;Lkotlin/coroutines/Continuation;)V

    check-cast v4, Lkotlin/jvm/functions/Function2;

    move-object v2, v3

    check-cast v2, Lkotlin/coroutines/Continuation;

    const/4 v5, 0x3

    iput v5, v3, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$1;->label:I

    invoke-static {p1, v4, v2}, Lkotlinx/coroutines/BuildersKt;->withContext(Lkotlin/coroutines/CoroutineContext;Lkotlin/jvm/functions/Function2;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object p1
    :try_end_3
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_2
    .catchall {:try_start_3 .. :try_end_3} :catchall_2

    if-ne p1, v0, :cond_2

    .line 48
    return-object v0

    .line 55
    :cond_2
    move-object p1, v1

    move-object v0, v3

    .line 58
    .end local v1    # "$result":Ljava/lang/Object;
    .end local v3    # "this":Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$1;
    .restart local v0    # "this":Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$1;
    .local p1, "$result":Ljava/lang/Object;
    :goto_2
    :try_start_4
    sget-object v1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;
    :try_end_4
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_4} :catch_0
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    .line 68
    iget-object v2, v0, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$1;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;

    invoke-virtual {v2}, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;->disconnectSocket()V

    .line 58
    return-object v1

    .line 61
    .end local v0    # "this":Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$1;
    .end local p1    # "$result":Ljava/lang/Object;
    .restart local v1    # "$result":Ljava/lang/Object;
    .restart local v3    # "this":Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$1;
    :cond_3
    :try_start_5
    iget-object p1, v3, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$1;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;

    invoke-static {p1}, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;->access$getSocket$p(Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;)Ljava/net/Socket;

    move-result-object p1

    if-eqz p1, :cond_5

    iget-object v2, v3, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$1;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;

    iget-object v4, v3, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$1;->$file:Ljava/io/File;

    iget-object v5, v3, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$1;->$listener:Lcom/rokid/security/sdk/base/common/apk/TransferProgressListener;

    .local p1, "it":Ljava/net/Socket;
    const/4 v6, 0x0

    .line 62
    .local v6, "$i$a$-let-ApkSender$sendFile$1$3":I
    const/4 v7, 0x4

    iput v7, v3, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$1;->label:I

    invoke-static {v2, p1, v4, v5, v3}, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;->access$sendFile(Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;Ljava/net/Socket;Ljava/io/File;Lcom/rokid/security/sdk/base/common/apk/TransferProgressListener;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v2
    :try_end_5
    .catch Ljava/lang/Exception; {:try_start_5 .. :try_end_5} :catch_2
    .catchall {:try_start_5 .. :try_end_5} :catchall_2

    .end local p1    # "it":Ljava/net/Socket;
    if-ne v2, v0, :cond_4

    .line 48
    return-object v0

    .line 62
    :cond_4
    move-object p1, v1

    move-object v0, v3

    move v1, v6

    .line 63
    .end local v3    # "this":Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$1;
    .end local v6    # "$i$a$-let-ApkSender$sendFile$1$3":I
    .restart local v0    # "this":Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$1;
    .local v1, "$i$a$-let-ApkSender$sendFile$1$3":I
    .local p1, "$result":Ljava/lang/Object;
    :goto_3
    nop

    .line 61
    .end local v1    # "$i$a$-let-ApkSender$sendFile$1$3":I
    move-object v1, p1

    move-object v3, v0

    .line 68
    .end local v0    # "this":Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$1;
    .end local p1    # "$result":Ljava/lang/Object;
    .local v1, "$result":Ljava/lang/Object;
    .restart local v3    # "this":Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$1;
    :cond_5
    iget-object p1, v3, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$1;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;

    invoke-virtual {p1}, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;->disconnectSocket()V

    .line 69
    goto :goto_5

    .line 68
    :catchall_2
    move-exception p1

    move-object v0, v3

    move-object v8, v1

    move-object v1, p1

    move-object p1, v8

    goto :goto_6

    .line 65
    :catch_2
    move-exception p1

    move-object v0, v3

    move-object v8, v1

    move-object v1, p1

    move-object p1, v8

    .line 66
    .end local v3    # "this":Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$1;
    .restart local v0    # "this":Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$1;
    .local v1, "e":Ljava/lang/Exception;
    .restart local p1    # "$result":Ljava/lang/Object;
    :goto_4
    :try_start_6
    iget-object v2, v0, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$1;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;

    invoke-static {v2}, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;->access$getTAG$p(Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;)Ljava/lang/String;

    move-result-object v2

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v4, "sendFile job Exception "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    filled-new-array {v3}, [Ljava/lang/Object;

    move-result-object v3

    invoke-static {v2, v3}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V
    :try_end_6
    .catchall {:try_start_6 .. :try_end_6} :catchall_0

    .line 68
    .end local v1    # "e":Ljava/lang/Exception;
    iget-object v1, v0, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$1;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;

    invoke-virtual {v1}, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;->disconnectSocket()V

    .line 69
    move-object v1, p1

    move-object v3, v0

    .line 70
    .end local v0    # "this":Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$1;
    .end local p1    # "$result":Ljava/lang/Object;
    .local v1, "$result":Ljava/lang/Object;
    .restart local v3    # "this":Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$1;
    :goto_5
    sget-object p1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    return-object p1

    .line 68
    .end local v1    # "$result":Ljava/lang/Object;
    .end local v3    # "this":Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$1;
    .restart local v0    # "this":Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$1;
    .restart local p1    # "$result":Ljava/lang/Object;
    :goto_6
    iget-object v2, v0, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$1;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;

    invoke-virtual {v2}, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;->disconnectSocket()V

    throw v1

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method
