.class final Lcom/rokid/security/phone/sdk/server/coreability/p2p/WifiP2PClientWrapper$startDiscoverPeers$onResult2$1;
.super Lkotlin/jvm/internal/Lambda;
.source "WifiP2PClientWrapper.kt"

# interfaces
.implements Lkotlin/jvm/functions/Function1;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/security/phone/sdk/server/coreability/p2p/WifiP2PClientWrapper;->startDiscoverPeers(Lkotlin/jvm/functions/Function1;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x18
    name = null
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lkotlin/jvm/internal/Lambda;",
        "Lkotlin/jvm/functions/Function1<",
        "Lcom/rokid/glasses/transport/sdk/api/callback/IResult<",
        "+",
        "Ljava/lang/Boolean;",
        ">;",
        "Lkotlin/Unit;",
        ">;"
    }
.end annotation

.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nWifiP2PClientWrapper.kt\nKotlin\n*S Kotlin\n*F\n+ 1 WifiP2PClientWrapper.kt\ncom/rokid/security/phone/sdk/server/coreability/p2p/WifiP2PClientWrapper$startDiscoverPeers$onResult2$1\n+ 2 IResult.kt\ncom/rokid/security/phone/sdk/base/data/callback/IResult$Companion\n*L\n1#1,122:1\n84#2:123\n*S KotlinDebug\n*F\n+ 1 WifiP2PClientWrapper.kt\ncom/rokid/security/phone/sdk/server/coreability/p2p/WifiP2PClientWrapper$startDiscoverPeers$onResult2$1\n*L\n74#1:123\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u0014\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0010\u000b\n\u0002\u0008\u0002\u0010\u0000\u001a\u00020\u00012\u000c\u0010\u0002\u001a\u0008\u0012\u0004\u0012\u00020\u00040\u0003H\n\u00a2\u0006\u0004\u0008\u0005\u0010\u0006"
    }
    d2 = {
        "<anonymous>",
        "",
        "result",
        "Lcom/rokid/glasses/transport/sdk/api/callback/IResult;",
        "",
        "invoke-3CeXOB8",
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


# direct methods
.method constructor <init>(Lkotlin/jvm/functions/Function1;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lkotlin/jvm/functions/Function1<",
            "-",
            "Lcom/rokid/security/phone/sdk/base/data/callback/IResult<",
            "Ljava/lang/Boolean;",
            ">;",
            "Lkotlin/Unit;",
            ">;)V"
        }
    .end annotation

    iput-object p1, p0, Lcom/rokid/security/phone/sdk/server/coreability/p2p/WifiP2PClientWrapper$startDiscoverPeers$onResult2$1;->$onResult:Lkotlin/jvm/functions/Function1;

    const/4 v0, 0x1

    invoke-direct {p0, v0}, Lkotlin/jvm/internal/Lambda;-><init>(I)V

    return-void
.end method


# virtual methods
.method public bridge synthetic invoke(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 1
    .param p1, "p1"    # Ljava/lang/Object;

    .line 71
    move-object v0, p1

    check-cast v0, Lcom/rokid/glasses/transport/sdk/api/callback/IResult;

    invoke-virtual {v0}, Lcom/rokid/glasses/transport/sdk/api/callback/IResult;->unbox-impl()Ljava/lang/Object;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/rokid/security/phone/sdk/server/coreability/p2p/WifiP2PClientWrapper$startDiscoverPeers$onResult2$1;->invoke-3CeXOB8(Ljava/lang/Object;)V

    sget-object v0, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    return-object v0
.end method

.method public final invoke-3CeXOB8(Ljava/lang/Object;)V
    .locals 4
    .param p1, "result"    # Ljava/lang/Object;

    .line 73
    invoke-static {p1}, Lcom/rokid/glasses/transport/sdk/api/callback/IResult;->isSuccess-impl(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 74
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/coreability/p2p/WifiP2PClientWrapper$startDiscoverPeers$onResult2$1;->$onResult:Lkotlin/jvm/functions/Function1;

    if-eqz v0, :cond_4

    sget-object v1, Lcom/rokid/security/phone/sdk/base/data/callback/IResult;->Companion:Lcom/rokid/security/phone/sdk/base/data/callback/IResult$Companion;

    .local v1, "this_$iv":Lcom/rokid/security/phone/sdk/base/data/callback/IResult$Companion;
    const/4 v2, 0x1

    invoke-static {v2}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v2

    .local v2, "value$iv":Ljava/lang/Object;
    const/4 v3, 0x0

    .line 123
    .local v3, "$i$f$success":I
    invoke-static {v2}, Lcom/rokid/security/phone/sdk/base/data/callback/IResult;->constructor-impl(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    .end local v1    # "this_$iv":Lcom/rokid/security/phone/sdk/base/data/callback/IResult$Companion;
    .end local v2    # "value$iv":Ljava/lang/Object;
    .end local v3    # "$i$f$success":I
    invoke-static {v1}, Lcom/rokid/security/phone/sdk/base/data/callback/IResult;->box-impl(Ljava/lang/Object;)Lcom/rokid/security/phone/sdk/base/data/callback/IResult;

    move-result-object v1

    .line 74
    invoke-interface {v0, v1}, Lkotlin/jvm/functions/Function1;->invoke(Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_1

    .line 76
    :cond_0
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/coreability/p2p/WifiP2PClientWrapper$startDiscoverPeers$onResult2$1;->$onResult:Lkotlin/jvm/functions/Function1;

    if-eqz v0, :cond_4

    sget-object v1, Lcom/rokid/security/phone/sdk/base/utils/other/ResultUtils;->INSTANCE:Lcom/rokid/security/phone/sdk/base/utils/other/ResultUtils;

    invoke-static {p1}, Lcom/rokid/glasses/transport/sdk/api/callback/IResult;->exceptionOrNull-impl(Ljava/lang/Object;)Lcom/rokid/glasses/transport/sdk/api/callback/IException;

    move-result-object v2

    if-eqz v2, :cond_1

    invoke-virtual {v2}, Lcom/rokid/glasses/transport/sdk/api/callback/IException;->getCode()I

    move-result v2

    goto :goto_0

    :cond_1
    const/4 v2, -0x1

    :goto_0
    invoke-static {p1}, Lcom/rokid/glasses/transport/sdk/api/callback/IResult;->exceptionOrNull-impl(Ljava/lang/Object;)Lcom/rokid/glasses/transport/sdk/api/callback/IException;

    move-result-object v3

    if-eqz v3, :cond_2

    invoke-virtual {v3}, Lcom/rokid/glasses/transport/sdk/api/callback/IException;->getMessage()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_3

    :cond_2
    const-string v3, ""

    :cond_3
    invoke-virtual {v1, v2, v3}, Lcom/rokid/security/phone/sdk/base/utils/other/ResultUtils;->getIFailResult-GMMPgog(ILjava/lang/String;)Ljava/lang/Object;

    move-result-object v1

    invoke-static {v1}, Lcom/rokid/security/phone/sdk/base/data/callback/IResult;->box-impl(Ljava/lang/Object;)Lcom/rokid/security/phone/sdk/base/data/callback/IResult;

    move-result-object v1

    invoke-interface {v0, v1}, Lkotlin/jvm/functions/Function1;->invoke(Ljava/lang/Object;)Ljava/lang/Object;

    .line 78
    :cond_4
    :goto_1
    return-void
.end method
