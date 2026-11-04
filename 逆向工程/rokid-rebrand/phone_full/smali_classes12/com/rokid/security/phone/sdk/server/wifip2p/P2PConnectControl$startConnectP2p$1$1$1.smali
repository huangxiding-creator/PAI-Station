.class final Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl$startConnectP2p$1$1$1;
.super Lkotlin/jvm/internal/Lambda;
.source "P2PConnectControl.kt"

# interfaces
.implements Lkotlin/jvm/functions/Function1;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl$startConnectP2p$1$1;->invoke-JoRRYb0(Ljava/lang/Object;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x18
    name = null
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lkotlin/jvm/internal/Lambda;",
        "Lkotlin/jvm/functions/Function1<",
        "Lcom/rokid/security/phone/sdk/base/data/callback/IResult<",
        "+",
        "Ljava/lang/Boolean;",
        ">;",
        "Lkotlin/Unit;",
        ">;"
    }
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u0014\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0010\u000b\n\u0002\u0008\u0002\u0010\u0000\u001a\u00020\u00012\u000c\u0010\u0002\u001a\u0008\u0012\u0004\u0012\u00020\u00040\u0003H\n\u00a2\u0006\u0004\u0008\u0005\u0010\u0006"
    }
    d2 = {
        "<anonymous>",
        "",
        "it",
        "Lcom/rokid/security/phone/sdk/base/data/callback/IResult;",
        "",
        "invoke-JoRRYb0",
        "(Ljava/lang/Object;)V"
    }
    k = 0x3
    mv = {
        0x1,
        0x8,
        0x0
    }
    xi = 0x30
.end annotation


# instance fields
.field final synthetic this$0:Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;


# direct methods
.method constructor <init>(Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;)V
    .locals 1

    iput-object p1, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl$startConnectP2p$1$1$1;->this$0:Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;

    const/4 v0, 0x1

    invoke-direct {p0, v0}, Lkotlin/jvm/internal/Lambda;-><init>(I)V

    return-void
.end method


# virtual methods
.method public bridge synthetic invoke(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 1
    .param p1, "p1"    # Ljava/lang/Object;

    .line 273
    move-object v0, p1

    check-cast v0, Lcom/rokid/security/phone/sdk/base/data/callback/IResult;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/base/data/callback/IResult;->unbox-impl()Ljava/lang/Object;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl$startConnectP2p$1$1$1;->invoke-JoRRYb0(Ljava/lang/Object;)V

    sget-object v0, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    return-object v0
.end method

.method public final invoke-JoRRYb0(Ljava/lang/Object;)V
    .locals 7
    .param p1, "it"    # Ljava/lang/Object;

    .line 274
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl$startConnectP2p$1$1$1;->this$0:Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;

    invoke-static {v0}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->access$getTAG$p(Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;)Ljava/lang/String;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "connectP2p: startDiscoverPeers "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-static {p1}, Lcom/rokid/security/phone/sdk/base/data/callback/IResult;->isSuccess-impl(Ljava/lang/Object;)Z

    move-result v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 275
    invoke-static {p1}, Lcom/rokid/security/phone/sdk/base/data/callback/IResult;->isFailure-impl(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 276
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl$startConnectP2p$1$1$1;->this$0:Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;

    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl$startConnectP2p$1$1$1;->this$0:Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;

    invoke-static {v1}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->access$getMRequestId$p(Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;)Ljava/lang/String;

    move-result-object v1

    const-string v2, "Discovery failed"

    const/4 v3, -0x6

    const/4 v4, 0x0

    invoke-static {v0, v4, v1, v2, v3}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->access$sendConnectP2pResponseMsg(Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;ZLjava/lang/String;Ljava/lang/String;I)V

    .line 277
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl$startConnectP2p$1$1$1;->this$0:Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;

    invoke-static {v0}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->access$processNextRequest(Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;)V

    .line 278
    return-void

    .line 282
    :cond_0
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl$startConnectP2p$1$1$1;->this$0:Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;

    invoke-static {v0}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->access$scheduleRetryCheck(Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;)V

    .line 284
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl$startConnectP2p$1$1$1;->this$0:Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;

    invoke-static {v0}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->access$cancelTimeoutJob(Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;)V

    .line 285
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl$startConnectP2p$1$1$1;->this$0:Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;

    invoke-static {}, Lcom/rokid/security/phone/sdk/base/utils/other/ScopesKt;->getWorkScope()Lkotlinx/coroutines/CoroutineScope;

    move-result-object v1

    new-instance v2, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl$startConnectP2p$1$1$1$1;

    iget-object v3, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl$startConnectP2p$1$1$1;->this$0:Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;

    const/4 v4, 0x0

    invoke-direct {v2, v3, v4}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl$startConnectP2p$1$1$1$1;-><init>(Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;Lkotlin/coroutines/Continuation;)V

    move-object v4, v2

    check-cast v4, Lkotlin/jvm/functions/Function2;

    const/4 v5, 0x3

    const/4 v6, 0x0

    const/4 v2, 0x0

    const/4 v3, 0x0

    invoke-static/range {v1 .. v6}, Lkotlinx/coroutines/BuildersKt;->launch$default(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/CoroutineContext;Lkotlinx/coroutines/CoroutineStart;Lkotlin/jvm/functions/Function2;ILjava/lang/Object;)Lkotlinx/coroutines/Job;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;->access$setTimeoutJob$p(Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl;Lkotlinx/coroutines/Job;)V

    .line 293
    return-void
.end method
