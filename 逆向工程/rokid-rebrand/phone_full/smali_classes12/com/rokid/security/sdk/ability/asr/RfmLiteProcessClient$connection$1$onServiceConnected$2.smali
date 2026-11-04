.class final Lcom/rokid/security/sdk/ability/asr/RfmLiteProcessClient$connection$1$onServiceConnected$2;
.super Lkotlin/coroutines/jvm/internal/SuspendLambda;
.source "RfmLiteProcessClient.kt"

# interfaces
.implements Lkotlin/jvm/functions/Function2;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/security/sdk/ability/asr/RfmLiteProcessClient$connection$1;->onServiceConnected(Landroid/content/ComponentName;Landroid/os/IBinder;)V
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
    c = "com.rokid.security.sdk.ability.asr.RfmLiteProcessClient$connection$1$onServiceConnected$2"
    f = "RfmLiteProcessClient.kt"
    i = {}
    l = {}
    m = "invokeSuspend"
    n = {}
    s = {}
.end annotation


# instance fields
.field final synthetic $deviceId:Lkotlin/jvm/internal/Ref$ObjectRef;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lkotlin/jvm/internal/Ref$ObjectRef<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field final synthetic $generation:Lkotlin/jvm/internal/Ref$IntRef;

.field final synthetic $service:Landroid/os/IBinder;

.field final synthetic $target:Lcom/rokid/security/sdk/ability/asr/IRfmLiteService;

.field label:I


# direct methods
.method public static synthetic $r8$lambda$C-ryy_7sxL9E8vPbmRmn482_QiE()V
    .locals 0

    invoke-static {}, Lcom/rokid/security/sdk/ability/asr/RfmLiteProcessClient$connection$1$onServiceConnected$2;->invokeSuspend$lambda$1()V

    return-void
.end method

.method constructor <init>(Lcom/rokid/security/sdk/ability/asr/IRfmLiteService;Lkotlin/jvm/internal/Ref$ObjectRef;Landroid/os/IBinder;Lkotlin/jvm/internal/Ref$IntRef;Lkotlin/coroutines/Continuation;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/rokid/security/sdk/ability/asr/IRfmLiteService;",
            "Lkotlin/jvm/internal/Ref$ObjectRef<",
            "Ljava/lang/String;",
            ">;",
            "Landroid/os/IBinder;",
            "Lkotlin/jvm/internal/Ref$IntRef;",
            "Lkotlin/coroutines/Continuation<",
            "-",
            "Lcom/rokid/security/sdk/ability/asr/RfmLiteProcessClient$connection$1$onServiceConnected$2;",
            ">;)V"
        }
    .end annotation

    iput-object p1, p0, Lcom/rokid/security/sdk/ability/asr/RfmLiteProcessClient$connection$1$onServiceConnected$2;->$target:Lcom/rokid/security/sdk/ability/asr/IRfmLiteService;

    iput-object p2, p0, Lcom/rokid/security/sdk/ability/asr/RfmLiteProcessClient$connection$1$onServiceConnected$2;->$deviceId:Lkotlin/jvm/internal/Ref$ObjectRef;

    iput-object p3, p0, Lcom/rokid/security/sdk/ability/asr/RfmLiteProcessClient$connection$1$onServiceConnected$2;->$service:Landroid/os/IBinder;

    iput-object p4, p0, Lcom/rokid/security/sdk/ability/asr/RfmLiteProcessClient$connection$1$onServiceConnected$2;->$generation:Lkotlin/jvm/internal/Ref$IntRef;

    const/4 v0, 0x2

    invoke-direct {p0, v0, p5}, Lkotlin/coroutines/jvm/internal/SuspendLambda;-><init>(ILkotlin/coroutines/Continuation;)V

    return-void
.end method

.method private static final invokeSuspend$lambda$1()V
    .locals 1

    .line 105
    sget-object v0, Lcom/rokid/security/sdk/ability/asr/RfmLiteProcessClient;->INSTANCE:Lcom/rokid/security/sdk/ability/asr/RfmLiteProcessClient;

    invoke-static {v0}, Lcom/rokid/security/sdk/ability/asr/RfmLiteProcessClient;->access$unbindInvalidConnection(Lcom/rokid/security/sdk/ability/asr/RfmLiteProcessClient;)V

    .line 106
    sget-object v0, Lcom/rokid/security/sdk/ability/asr/RfmLiteProcessClient;->INSTANCE:Lcom/rokid/security/sdk/ability/asr/RfmLiteProcessClient;

    invoke-static {v0}, Lcom/rokid/security/sdk/ability/asr/RfmLiteProcessClient;->access$bindIfNeeded(Lcom/rokid/security/sdk/ability/asr/RfmLiteProcessClient;)V

    .line 107
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

    new-instance v6, Lcom/rokid/security/sdk/ability/asr/RfmLiteProcessClient$connection$1$onServiceConnected$2;

    iget-object v1, p0, Lcom/rokid/security/sdk/ability/asr/RfmLiteProcessClient$connection$1$onServiceConnected$2;->$target:Lcom/rokid/security/sdk/ability/asr/IRfmLiteService;

    iget-object v2, p0, Lcom/rokid/security/sdk/ability/asr/RfmLiteProcessClient$connection$1$onServiceConnected$2;->$deviceId:Lkotlin/jvm/internal/Ref$ObjectRef;

    iget-object v3, p0, Lcom/rokid/security/sdk/ability/asr/RfmLiteProcessClient$connection$1$onServiceConnected$2;->$service:Landroid/os/IBinder;

    iget-object v4, p0, Lcom/rokid/security/sdk/ability/asr/RfmLiteProcessClient$connection$1$onServiceConnected$2;->$generation:Lkotlin/jvm/internal/Ref$IntRef;

    move-object v0, v6

    move-object v5, p2

    invoke-direct/range {v0 .. v5}, Lcom/rokid/security/sdk/ability/asr/RfmLiteProcessClient$connection$1$onServiceConnected$2;-><init>(Lcom/rokid/security/sdk/ability/asr/IRfmLiteService;Lkotlin/jvm/internal/Ref$ObjectRef;Landroid/os/IBinder;Lkotlin/jvm/internal/Ref$IntRef;Lkotlin/coroutines/Continuation;)V

    check-cast v6, Lkotlin/coroutines/Continuation;

    return-object v6
.end method

.method public bridge synthetic invoke(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    .locals 1

    check-cast p1, Lkotlinx/coroutines/CoroutineScope;

    check-cast p2, Lkotlin/coroutines/Continuation;

    invoke-virtual {p0, p1, p2}, Lcom/rokid/security/sdk/ability/asr/RfmLiteProcessClient$connection$1$onServiceConnected$2;->invoke(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

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

    invoke-virtual {p0, p1, p2}, Lcom/rokid/security/sdk/ability/asr/RfmLiteProcessClient$connection$1$onServiceConnected$2;->create(Ljava/lang/Object;Lkotlin/coroutines/Continuation;)Lkotlin/coroutines/Continuation;

    move-result-object v0

    check-cast v0, Lcom/rokid/security/sdk/ability/asr/RfmLiteProcessClient$connection$1$onServiceConnected$2;

    sget-object v1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    invoke-virtual {v0, v1}, Lcom/rokid/security/sdk/ability/asr/RfmLiteProcessClient$connection$1$onServiceConnected$2;->invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public final invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 8

    invoke-static {}, Lkotlin/coroutines/intrinsics/IntrinsicsKt;->getCOROUTINE_SUSPENDED()Ljava/lang/Object;

    .line 81
    iget v0, p0, Lcom/rokid/security/sdk/ability/asr/RfmLiteProcessClient$connection$1$onServiceConnected$2;->label:I

    packed-switch v0, :pswitch_data_0

    new-instance p1, Ljava/lang/IllegalStateException;

    const-string v0, "call to \'resume\' before \'invoke\' with coroutine"

    invoke-direct {p1, v0}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p1

    :pswitch_0
    invoke-static {p1}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    move-object v0, p0

    .line 82
    .local v0, "this":Lcom/rokid/security/sdk/ability/asr/RfmLiteProcessClient$connection$1$onServiceConnected$2;
    .local p1, "$result":Ljava/lang/Object;
    nop

    .line 83
    :try_start_0
    iget-object v1, v0, Lcom/rokid/security/sdk/ability/asr/RfmLiteProcessClient$connection$1$onServiceConnected$2;->$target:Lcom/rokid/security/sdk/ability/asr/IRfmLiteService;

    iget-object v2, v0, Lcom/rokid/security/sdk/ability/asr/RfmLiteProcessClient$connection$1$onServiceConnected$2;->$deviceId:Lkotlin/jvm/internal/Ref$ObjectRef;

    iget-object v2, v2, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    check-cast v2, Ljava/lang/String;

    invoke-interface {v1, v2}, Lcom/rokid/security/sdk/ability/asr/IRfmLiteService;->create(Ljava/lang/String;)Z

    .line 84
    invoke-static {}, Lcom/rokid/security/sdk/ability/asr/RfmLiteProcessClient;->access$getLock$p()Ljava/lang/Object;

    move-result-object v1

    iget-object v2, v0, Lcom/rokid/security/sdk/ability/asr/RfmLiteProcessClient$connection$1$onServiceConnected$2;->$generation:Lkotlin/jvm/internal/Ref$IntRef;

    iget-object v3, v0, Lcom/rokid/security/sdk/ability/asr/RfmLiteProcessClient$connection$1$onServiceConnected$2;->$service:Landroid/os/IBinder;

    iget-object v4, v0, Lcom/rokid/security/sdk/ability/asr/RfmLiteProcessClient$connection$1$onServiceConnected$2;->$deviceId:Lkotlin/jvm/internal/Ref$ObjectRef;

    iget-object v5, v0, Lcom/rokid/security/sdk/ability/asr/RfmLiteProcessClient$connection$1$onServiceConnected$2;->$target:Lcom/rokid/security/sdk/ability/asr/IRfmLiteService;

    monitor-enter v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    const/4 v6, 0x0

    .line 85
    .local v6, "$i$a$-synchronized-RfmLiteProcessClient$connection$1$onServiceConnected$2$accepted$1":I
    nop

    .line 86
    :try_start_1
    iget v2, v2, Lkotlin/jvm/internal/Ref$IntRef;->element:I

    invoke-static {}, Lcom/rokid/security/sdk/ability/asr/RfmLiteProcessClient;->access$getConnectionGeneration$p()I

    move-result v7

    if-ne v2, v7, :cond_0

    .line 87
    invoke-static {}, Lcom/rokid/security/sdk/ability/asr/RfmLiteProcessClient;->access$getConnectedBinder$p()Landroid/os/IBinder;

    move-result-object v2

    if-ne v2, v3, :cond_0

    .line 88
    invoke-static {}, Lcom/rokid/security/sdk/ability/asr/RfmLiteProcessClient;->access$getPendingDeviceId$p()Ljava/lang/String;

    move-result-object v2

    iget-object v3, v4, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    invoke-static {v2, v3}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_0

    .line 90
    sget-object v2, Lcom/rokid/security/sdk/ability/asr/RfmLiteProcessClient;->INSTANCE:Lcom/rokid/security/sdk/ability/asr/RfmLiteProcessClient;

    invoke-static {v5}, Lcom/rokid/security/sdk/ability/asr/RfmLiteProcessClient;->access$setRemote$p(Lcom/rokid/security/sdk/ability/asr/IRfmLiteService;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 91
    const/4 v2, 0x1

    goto :goto_0

    .line 93
    :cond_0
    const/4 v2, 0x0

    .line 85
    :goto_0
    nop

    .line 84
    .end local v6    # "$i$a$-synchronized-RfmLiteProcessClient$connection$1$onServiceConnected$2$accepted$1":I
    :try_start_2
    monitor-exit v1

    move v1, v2

    .line 96
    .local v1, "accepted":Z
    nop

    .end local v1    # "accepted":Z
    if-eqz v1, :cond_1

    .line 97
    const-string v1, "RfmLiteProcessClient"

    const-string v2, "remote RFM Lite initialized"

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    goto :goto_1

    .line 99
    :cond_1
    const-string v1, "RfmLiteProcessClient"

    const-string/jumbo v2, "stale remote RFM Lite initialization ignored"

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->w(Ljava/lang/String;[Ljava/lang/Object;)V

    goto :goto_1

    .line 84
    :catchall_0
    move-exception v2

    monitor-exit v1

    .end local v0    # "this":Lcom/rokid/security/sdk/ability/asr/RfmLiteProcessClient$connection$1$onServiceConnected$2;
    .end local p1    # "$result":Ljava/lang/Object;
    throw v2
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 101
    .restart local v0    # "this":Lcom/rokid/security/sdk/ability/asr/RfmLiteProcessClient$connection$1$onServiceConnected$2;
    .restart local p1    # "$result":Ljava/lang/Object;
    :catchall_1
    move-exception v1

    .line 102
    .local v1, "t":Ljava/lang/Throwable;
    sget-object v2, Lcom/rokid/security/sdk/ability/asr/RfmLiteProcessClient;->INSTANCE:Lcom/rokid/security/sdk/ability/asr/RfmLiteProcessClient;

    iget-object v3, v0, Lcom/rokid/security/sdk/ability/asr/RfmLiteProcessClient$connection$1$onServiceConnected$2;->$service:Landroid/os/IBinder;

    iget-object v4, v0, Lcom/rokid/security/sdk/ability/asr/RfmLiteProcessClient$connection$1$onServiceConnected$2;->$generation:Lkotlin/jvm/internal/Ref$IntRef;

    iget v4, v4, Lkotlin/jvm/internal/Ref$IntRef;->element:I

    invoke-static {v4}, Lkotlin/coroutines/jvm/internal/Boxing;->boxInt(I)Ljava/lang/Integer;

    move-result-object v4

    invoke-static {v2, v3, v4}, Lcom/rokid/security/sdk/ability/asr/RfmLiteProcessClient;->access$invalidateRemote(Lcom/rokid/security/sdk/ability/asr/RfmLiteProcessClient;Landroid/os/IBinder;Ljava/lang/Integer;)Z

    move-result v2

    if-eqz v2, :cond_2

    .line 103
    const-string v2, "RfmLiteProcessClient"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "remote RFM Lite initialization failed type="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    filled-new-array {v3}, [Ljava/lang/Object;

    move-result-object v3

    .end local v1    # "t":Ljava/lang/Throwable;
    invoke-static {v2, v3}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 104
    invoke-static {}, Lcom/rokid/security/sdk/ability/asr/RfmLiteProcessClient;->access$getMainHandler$p()Landroid/os/Handler;

    move-result-object v1

    new-instance v2, Lcom/rokid/security/sdk/ability/asr/RfmLiteProcessClient$connection$1$onServiceConnected$2$$ExternalSyntheticLambda0;

    invoke-direct {v2}, Lcom/rokid/security/sdk/ability/asr/RfmLiteProcessClient$connection$1$onServiceConnected$2$$ExternalSyntheticLambda0;-><init>()V

    .line 107
    nop

    .line 104
    const-wide/16 v3, 0xfa0

    invoke-virtual {v1, v2, v3, v4}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    .line 110
    :cond_2
    :goto_1
    sget-object v1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    return-object v1

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_0
    .end packed-switch
.end method
