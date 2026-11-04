.class final Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl$sendConnectP2pRequest$timeoutJob2$1;
.super Lkotlin/coroutines/jvm/internal/SuspendLambda;
.source "P2PConnectControl.kt"

# interfaces
.implements Lkotlin/jvm/functions/Function2;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->sendConnectP2pRequest(Lkotlin/jvm/functions/Function1;)V
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
    value = "SMAP\nP2PConnectControl.kt\nKotlin\n*S Kotlin\n*F\n+ 1 P2PConnectControl.kt\ncom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl$sendConnectP2pRequest$timeoutJob2$1\n+ 2 fake.kt\nkotlin/jvm/internal/FakeKt\n*L\n1#1,493:1\n1#2:494\n*E\n"
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
    c = "com.rokid.security.phone.sdk.server.wifip2p.P2PConnectControl$sendConnectP2pRequest$timeoutJob2$1"
    f = "P2PConnectControl.kt"
    i = {}
    l = {
        0xba
    }
    m = "invokeSuspend"
    n = {}
    s = {}
.end annotation


# instance fields
.field final synthetic $requestId:Ljava/lang/String;

.field label:I

.field final synthetic this$0:Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;


# direct methods
.method constructor <init>(Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;Ljava/lang/String;Lkotlin/coroutines/Continuation;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;",
            "Ljava/lang/String;",
            "Lkotlin/coroutines/Continuation<",
            "-",
            "Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl$sendConnectP2pRequest$timeoutJob2$1;",
            ">;)V"
        }
    .end annotation

    iput-object p1, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl$sendConnectP2pRequest$timeoutJob2$1;->this$0:Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;

    iput-object p2, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl$sendConnectP2pRequest$timeoutJob2$1;->$requestId:Ljava/lang/String;

    const/4 v0, 0x2

    invoke-direct {p0, v0, p3}, Lkotlin/coroutines/jvm/internal/SuspendLambda;-><init>(ILkotlin/coroutines/Continuation;)V

    return-void
.end method


# virtual methods
.method public final create(Ljava/lang/Object;Lkotlin/coroutines/Continuation;)Lkotlin/coroutines/Continuation;
    .locals 3
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

    new-instance v0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl$sendConnectP2pRequest$timeoutJob2$1;

    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl$sendConnectP2pRequest$timeoutJob2$1;->this$0:Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;

    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl$sendConnectP2pRequest$timeoutJob2$1;->$requestId:Ljava/lang/String;

    invoke-direct {v0, v1, v2, p2}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl$sendConnectP2pRequest$timeoutJob2$1;-><init>(Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;Ljava/lang/String;Lkotlin/coroutines/Continuation;)V

    check-cast v0, Lkotlin/coroutines/Continuation;

    return-object v0
.end method

.method public bridge synthetic invoke(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    .locals 1

    check-cast p1, Lkotlinx/coroutines/CoroutineScope;

    check-cast p2, Lkotlin/coroutines/Continuation;

    invoke-virtual {p0, p1, p2}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl$sendConnectP2pRequest$timeoutJob2$1;->invoke(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

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

    invoke-virtual {p0, p1, p2}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl$sendConnectP2pRequest$timeoutJob2$1;->create(Ljava/lang/Object;Lkotlin/coroutines/Continuation;)Lkotlin/coroutines/Continuation;

    move-result-object v0

    check-cast v0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl$sendConnectP2pRequest$timeoutJob2$1;

    sget-object v1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    invoke-virtual {v0, v1}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl$sendConnectP2pRequest$timeoutJob2$1;->invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public final invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 7

    invoke-static {}, Lkotlin/coroutines/intrinsics/IntrinsicsKt;->getCOROUTINE_SUSPENDED()Ljava/lang/Object;

    move-result-object v0

    .line 185
    iget v1, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl$sendConnectP2pRequest$timeoutJob2$1;->label:I

    packed-switch v1, :pswitch_data_0

    new-instance p1, Ljava/lang/IllegalStateException;

    const-string v0, "call to \'resume\' before \'invoke\' with coroutine"

    invoke-direct {p1, v0}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p1

    :pswitch_0
    move-object v0, p0

    .local v0, "this":Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl$sendConnectP2pRequest$timeoutJob2$1;
    .local p1, "$result":Ljava/lang/Object;
    invoke-static {p1}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    goto :goto_0

    .end local v0    # "this":Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl$sendConnectP2pRequest$timeoutJob2$1;
    .end local p1    # "$result":Ljava/lang/Object;
    :pswitch_1
    invoke-static {p1}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    move-object v1, p0

    .line 186
    .local v1, "this":Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl$sendConnectP2pRequest$timeoutJob2$1;
    .restart local p1    # "$result":Ljava/lang/Object;
    move-object v2, v1

    check-cast v2, Lkotlin/coroutines/Continuation;

    const/4 v3, 0x1

    iput v3, v1, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl$sendConnectP2pRequest$timeoutJob2$1;->label:I

    const-wide/16 v3, 0x4e20

    invoke-static {v3, v4, v2}, Lkotlinx/coroutines/DelayKt;->delay(JLkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v2

    if-ne v2, v0, :cond_0

    .line 185
    return-object v0

    .line 186
    :cond_0
    move-object v0, v1

    .line 187
    .end local v1    # "this":Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl$sendConnectP2pRequest$timeoutJob2$1;
    .restart local v0    # "this":Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl$sendConnectP2pRequest$timeoutJob2$1;
    :goto_0
    iget-object v1, v0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl$sendConnectP2pRequest$timeoutJob2$1;->this$0:Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;

    invoke-static {v1}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->access$getConnectP2pActions$p(Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;)Ljava/util/concurrent/ConcurrentHashMap;

    move-result-object v1

    iget-object v2, v0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl$sendConnectP2pRequest$timeoutJob2$1;->$requestId:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/util/concurrent/ConcurrentHashMap;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lkotlin/Pair;

    .line 188
    .local v1, "actionPair":Lkotlin/Pair;
    if-eqz v1, :cond_1

    iget-object v2, v0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl$sendConnectP2pRequest$timeoutJob2$1;->this$0:Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;

    iget-object v3, v0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl$sendConnectP2pRequest$timeoutJob2$1;->$requestId:Ljava/lang/String;

    .line 494
    .end local v1    # "actionPair":Lkotlin/Pair;
    const/4 v4, 0x0

    .line 188
    .local v4, "$i$a$-let-P2PConnectControl$sendConnectP2pRequest$timeoutJob2$1$1":I
    invoke-virtual {v1}, Lkotlin/Pair;->component1()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lkotlin/jvm/functions/Function1;

    .line 189
    .local v1, "storedAction":Lkotlin/jvm/functions/Function1;
    invoke-static {v2}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->access$getTAG$p(Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;)Ljava/lang/String;

    move-result-object v2

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v6, "sendConnectP2pRequest: timeout --- "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    filled-new-array {v3}, [Ljava/lang/Object;

    move-result-object v3

    invoke-static {v2, v3}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 190
    const/4 v2, 0x0

    invoke-static {v2}, Lkotlin/coroutines/jvm/internal/Boxing;->boxBoolean(Z)Ljava/lang/Boolean;

    move-result-object v2

    invoke-interface {v1, v2}, Lkotlin/jvm/functions/Function1;->invoke(Ljava/lang/Object;)Ljava/lang/Object;

    .line 191
    nop

    .line 188
    .end local v1    # "storedAction":Lkotlin/jvm/functions/Function1;
    .end local v4    # "$i$a$-let-P2PConnectControl$sendConnectP2pRequest$timeoutJob2$1$1":I
    nop

    .line 192
    :cond_1
    sget-object v1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    return-object v1

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method
