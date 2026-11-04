.class final Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl$mIWifiP2PClientListener$1$onWifiP2pEnabled$1;
.super Lkotlin/jvm/internal/Lambda;
.source "P2PConnectControl.kt"

# interfaces
.implements Lkotlin/jvm/functions/Function2;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl$mIWifiP2PClientListener$1;->onWifiP2pEnabled(Z)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x18
    name = null
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lkotlin/jvm/internal/Lambda;",
        "Lkotlin/jvm/functions/Function2<",
        "Ljava/lang/String;",
        "Lkotlin/Pair<",
        "+",
        "Lkotlin/jvm/functions/Function1<",
        "-",
        "Ljava/lang/Boolean;",
        "+",
        "Lkotlin/Unit;",
        ">;+",
        "Lkotlinx/coroutines/Job;",
        ">;",
        "Lkotlin/Unit;",
        ">;"
    }
.end annotation

.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nP2PConnectControl.kt\nKotlin\n*S Kotlin\n*F\n+ 1 P2PConnectControl.kt\ncom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl$mIWifiP2PClientListener$1$onWifiP2pEnabled$1\n+ 2 fake.kt\nkotlin/jvm/internal/FakeKt\n*L\n1#1,493:1\n1#2:494\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000(\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0010\u000e\n\u0000\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0010\u000b\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0000\u0010\u0000\u001a\u00020\u00012\u0006\u0010\u0002\u001a\u00020\u00032/\u0010\u0004\u001a+\u0012\u001f\u0012\u001d\u0012\u0013\u0012\u00110\u0007\u00a2\u0006\u000c\u0008\u0008\u0012\u0008\u0008\t\u0012\u0004\u0008\u0008(\n\u0012\u0004\u0012\u00020\u00010\u0006\u0012\u0006\u0012\u0004\u0018\u00010\u000b0\u0005H\n\u00a2\u0006\u0002\u0008\u000c"
    }
    d2 = {
        "<anonymous>",
        "",
        "s",
        "",
        "actionPair",
        "Lkotlin/Pair;",
        "Lkotlin/Function1;",
        "",
        "Lkotlin/ParameterName;",
        "name",
        "isSuccess",
        "Lkotlinx/coroutines/Job;",
        "invoke"
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
.field final synthetic $enabled:Z


# direct methods
.method constructor <init>(Z)V
    .locals 1

    iput-boolean p1, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl$mIWifiP2PClientListener$1$onWifiP2pEnabled$1;->$enabled:Z

    const/4 v0, 0x2

    invoke-direct {p0, v0}, Lkotlin/jvm/internal/Lambda;-><init>(I)V

    return-void
.end method


# virtual methods
.method public bridge synthetic invoke(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    .locals 2
    .param p1, "p1"    # Ljava/lang/Object;
    .param p2, "p2"    # Ljava/lang/Object;

    .line 125
    move-object v0, p1

    check-cast v0, Ljava/lang/String;

    move-object v1, p2

    check-cast v1, Lkotlin/Pair;

    invoke-virtual {p0, v0, v1}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl$mIWifiP2PClientListener$1$onWifiP2pEnabled$1;->invoke(Ljava/lang/String;Lkotlin/Pair;)V

    sget-object v0, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    return-object v0
.end method

.method public final invoke(Ljava/lang/String;Lkotlin/Pair;)V
    .locals 6
    .param p1, "s"    # Ljava/lang/String;
    .param p2, "actionPair"    # Lkotlin/Pair;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Lkotlin/Pair<",
            "+",
            "Lkotlin/jvm/functions/Function1<",
            "-",
            "Ljava/lang/Boolean;",
            "Lkotlin/Unit;",
            ">;+",
            "Lkotlinx/coroutines/Job;",
            ">;)V"
        }
    .end annotation

    .line 126
    const-string/jumbo v0, "s"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "actionPair"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    iget-boolean v0, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PConnectControl$mIWifiP2PClientListener$1$onWifiP2pEnabled$1;->$enabled:Z

    .line 494
    const/4 v1, 0x0

    .line 126
    .local v1, "$i$a$-let-P2PConnectControl$mIWifiP2PClientListener$1$onWifiP2pEnabled$1$1":I
    invoke-virtual {p2}, Lkotlin/Pair;->component1()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lkotlin/jvm/functions/Function1;

    .local v2, "action":Lkotlin/jvm/functions/Function1;
    invoke-virtual {p2}, Lkotlin/Pair;->component2()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lkotlinx/coroutines/Job;

    .line 127
    .local v3, "timeoutJob":Lkotlinx/coroutines/Job;
    if-eqz v3, :cond_0

    const/4 v4, 0x1

    const/4 v5, 0x0

    invoke-static {v3, v5, v4, v5}, Lkotlinx/coroutines/Job$DefaultImpls;->cancel$default(Lkotlinx/coroutines/Job;Ljava/util/concurrent/CancellationException;ILjava/lang/Object;)V

    .line 128
    :cond_0
    invoke-static {v0}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v0

    invoke-interface {v2, v0}, Lkotlin/jvm/functions/Function1;->invoke(Ljava/lang/Object;)Ljava/lang/Object;

    .line 129
    nop

    .line 126
    .end local v1    # "$i$a$-let-P2PConnectControl$mIWifiP2PClientListener$1$onWifiP2pEnabled$1$1":I
    .end local v2    # "action":Lkotlin/jvm/functions/Function1;
    .end local v3    # "timeoutJob":Lkotlinx/coroutines/Job;
    nop

    .line 130
    return-void
.end method
