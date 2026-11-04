.class final Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender$sendFile$2;
.super Lkotlin/coroutines/jvm/internal/SuspendLambda;
.source "BtFileSender.kt"

# interfaces
.implements Lkotlin/jvm/functions/Function2;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;->sendFile(Ljava/lang/String;Ljava/io/File;Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;Lkotlin/jvm/functions/Function1;)V
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
    c = "com.rokid.security.phone.sdk.server.msg.file.BtFileSender$sendFile$2"
    f = "BtFileSender.kt"
    i = {}
    l = {
        0x6b
    }
    m = "invokeSuspend"
    n = {}
    s = {}
.end annotation


# instance fields
.field final synthetic $appListener:Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;

.field final synthetic $dir:Ljava/lang/String;

.field final synthetic $file:Ljava/io/File;

.field final synthetic $generation:J

.field final synthetic $onResult:Lkotlin/jvm/functions/Function1;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lkotlin/jvm/functions/Function1<",
            "Lcom/rokid/security/phone/sdk/base/data/callback/IResult<",
            "Ljava/lang/Boolean;",
            ">;",
            "Lkotlin/Unit;",
            ">;"
        }
    .end annotation
.end field

.field label:I

.field final synthetic this$0:Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;


# direct methods
.method constructor <init>(Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;Ljava/lang/String;Ljava/io/File;JLcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;Lkotlin/jvm/functions/Function1;Lkotlin/coroutines/Continuation;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;",
            "Ljava/lang/String;",
            "Ljava/io/File;",
            "J",
            "Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;",
            "Lkotlin/jvm/functions/Function1<",
            "-",
            "Lcom/rokid/security/phone/sdk/base/data/callback/IResult<",
            "Ljava/lang/Boolean;",
            ">;",
            "Lkotlin/Unit;",
            ">;",
            "Lkotlin/coroutines/Continuation<",
            "-",
            "Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender$sendFile$2;",
            ">;)V"
        }
    .end annotation

    iput-object p1, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender$sendFile$2;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;

    iput-object p2, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender$sendFile$2;->$dir:Ljava/lang/String;

    iput-object p3, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender$sendFile$2;->$file:Ljava/io/File;

    iput-wide p4, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender$sendFile$2;->$generation:J

    iput-object p6, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender$sendFile$2;->$appListener:Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;

    iput-object p7, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender$sendFile$2;->$onResult:Lkotlin/jvm/functions/Function1;

    const/4 v0, 0x2

    invoke-direct {p0, v0, p8}, Lkotlin/coroutines/jvm/internal/SuspendLambda;-><init>(ILkotlin/coroutines/Continuation;)V

    return-void
.end method


# virtual methods
.method public final create(Ljava/lang/Object;Lkotlin/coroutines/Continuation;)Lkotlin/coroutines/Continuation;
    .locals 10
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

    new-instance v9, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender$sendFile$2;

    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender$sendFile$2;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;

    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender$sendFile$2;->$dir:Ljava/lang/String;

    iget-object v3, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender$sendFile$2;->$file:Ljava/io/File;

    iget-wide v4, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender$sendFile$2;->$generation:J

    iget-object v6, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender$sendFile$2;->$appListener:Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;

    iget-object v7, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender$sendFile$2;->$onResult:Lkotlin/jvm/functions/Function1;

    move-object v0, v9

    move-object v8, p2

    invoke-direct/range {v0 .. v8}, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender$sendFile$2;-><init>(Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;Ljava/lang/String;Ljava/io/File;JLcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;Lkotlin/jvm/functions/Function1;Lkotlin/coroutines/Continuation;)V

    check-cast v9, Lkotlin/coroutines/Continuation;

    return-object v9
.end method

.method public bridge synthetic invoke(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    .locals 1

    check-cast p1, Lkotlinx/coroutines/CoroutineScope;

    check-cast p2, Lkotlin/coroutines/Continuation;

    invoke-virtual {p0, p1, p2}, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender$sendFile$2;->invoke(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

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

    invoke-virtual {p0, p1, p2}, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender$sendFile$2;->create(Ljava/lang/Object;Lkotlin/coroutines/Continuation;)Lkotlin/coroutines/Continuation;

    move-result-object v0

    check-cast v0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender$sendFile$2;

    sget-object v1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    invoke-virtual {v0, v1}, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender$sendFile$2;->invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public final invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 13

    invoke-static {}, Lkotlin/coroutines/intrinsics/IntrinsicsKt;->getCOROUTINE_SUSPENDED()Ljava/lang/Object;

    move-result-object v0

    .line 59
    iget v1, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender$sendFile$2;->label:I

    packed-switch v1, :pswitch_data_0

    new-instance p1, Ljava/lang/IllegalStateException;

    const-string v0, "call to \'resume\' before \'invoke\' with coroutine"

    invoke-direct {p1, v0}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p1

    :pswitch_0
    move-object v0, p0

    .local v0, "this":Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender$sendFile$2;
    .local p1, "$result":Ljava/lang/Object;
    invoke-static {p1}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    goto/16 :goto_0

    .end local v0    # "this":Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender$sendFile$2;
    .end local p1    # "$result":Ljava/lang/Object;
    :pswitch_1
    invoke-static {p1}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    move-object v1, p0

    .line 60
    .local v1, "this":Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender$sendFile$2;
    .restart local p1    # "$result":Ljava/lang/Object;
    iget-object v2, v1, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender$sendFile$2;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;

    invoke-static {v2}, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;->access$getTAG$p(Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;)Ljava/lang/String;

    move-result-object v2

    const-string/jumbo v3, "\u534f\u7a0b\u5df2\u542f\u52a8\uff0c\u5f00\u59cb\u6267\u884c\u6587\u4ef6\u53d1\u9001\u903b\u8f91"

    filled-new-array {v3}, [Ljava/lang/Object;

    move-result-object v3

    invoke-static {v2, v3}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 61
    nop

    .line 62
    :try_start_0
    sget-object v2, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;

    iget-object v3, v1, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender$sendFile$2;->$dir:Ljava/lang/String;

    iget-object v4, v1, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender$sendFile$2;->$file:Ljava/io/File;

    new-instance v12, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender$sendFile$2$1;

    iget-object v6, v1, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender$sendFile$2;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;

    iget-wide v7, v1, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender$sendFile$2;->$generation:J

    iget-object v9, v1, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender$sendFile$2;->$appListener:Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;

    iget-object v10, v1, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender$sendFile$2;->$file:Ljava/io/File;

    iget-object v11, v1, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender$sendFile$2;->$onResult:Lkotlin/jvm/functions/Function1;

    move-object v5, v12

    invoke-direct/range {v5 .. v11}, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender$sendFile$2$1;-><init>(Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;JLcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;Ljava/io/File;Lkotlin/jvm/functions/Function1;)V

    check-cast v12, Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileSendListener;

    invoke-virtual {v2, v3, v4, v12}, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->sendClassBTFileData(Ljava/lang/String;Ljava/io/File;Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileSendListener;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_1

    .line 104
    :catch_0
    move-exception v2

    .line 105
    .local v2, "e":Ljava/lang/Exception;
    iget-object v3, v1, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender$sendFile$2;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;

    invoke-static {v3}, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;->access$getTAG$p(Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;)Ljava/lang/String;

    move-result-object v3

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v5, "\u53d1\u9001\u6587\u4ef6\u5931\u8d25 type="

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v2}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    filled-new-array {v4}, [Ljava/lang/Object;

    move-result-object v4

    .end local v2    # "e":Ljava/lang/Exception;
    invoke-static {v3, v4}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 106
    iget-object v2, v1, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender$sendFile$2;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;

    iget-wide v3, v1, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender$sendFile$2;->$generation:J

    invoke-static {v2, v3, v4}, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;->access$isCurrent(Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;J)Z

    move-result v2

    if-eqz v2, :cond_1

    .line 107
    invoke-static {}, Lkotlinx/coroutines/Dispatchers;->getMain()Lkotlinx/coroutines/MainCoroutineDispatcher;

    move-result-object v2

    check-cast v2, Lkotlin/coroutines/CoroutineContext;

    new-instance v10, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender$sendFile$2$2;

    iget-object v4, v1, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender$sendFile$2;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;

    iget-wide v5, v1, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender$sendFile$2;->$generation:J

    iget-object v7, v1, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender$sendFile$2;->$appListener:Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;

    iget-object v8, v1, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender$sendFile$2;->$onResult:Lkotlin/jvm/functions/Function1;

    const/4 v9, 0x0

    move-object v3, v10

    invoke-direct/range {v3 .. v9}, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender$sendFile$2$2;-><init>(Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;JLcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;Lkotlin/jvm/functions/Function1;Lkotlin/coroutines/Continuation;)V

    check-cast v10, Lkotlin/jvm/functions/Function2;

    move-object v3, v1

    check-cast v3, Lkotlin/coroutines/Continuation;

    const/4 v4, 0x1

    iput v4, v1, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender$sendFile$2;->label:I

    invoke-static {v2, v10, v3}, Lkotlinx/coroutines/BuildersKt;->withContext(Lkotlin/coroutines/CoroutineContext;Lkotlin/jvm/functions/Function2;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v2

    if-ne v2, v0, :cond_0

    .line 59
    return-object v0

    .line 107
    :cond_0
    move-object v0, v1

    .line 113
    .end local v1    # "this":Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender$sendFile$2;
    .restart local v0    # "this":Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender$sendFile$2;
    :goto_0
    iget-object v1, v0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender$sendFile$2;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;

    invoke-virtual {v1}, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;->close()V

    move-object v1, v0

    .line 116
    .end local v0    # "this":Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender$sendFile$2;
    .restart local v1    # "this":Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender$sendFile$2;
    :cond_1
    :goto_1
    sget-object v0, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    return-object v0

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method
