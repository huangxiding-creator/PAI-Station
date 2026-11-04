.class final Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl$init$1;
.super Lkotlin/jvm/internal/Lambda;
.source "P2PClientServiceImpl.kt"

# interfaces
.implements Lkotlin/jvm/functions/Function1;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;->init(Lkotlin/jvm/functions/Function1;)V
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

    iput-object p1, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl$init$1;->$onResult:Lkotlin/jvm/functions/Function1;

    const/4 v0, 0x1

    invoke-direct {p0, v0}, Lkotlin/jvm/internal/Lambda;-><init>(I)V

    return-void
.end method


# virtual methods
.method public bridge synthetic invoke(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 1
    .param p1, "p1"    # Ljava/lang/Object;

    .line 144
    move-object v0, p1

    check-cast v0, Lcom/rokid/security/phone/sdk/base/data/callback/IResult;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/base/data/callback/IResult;->unbox-impl()Ljava/lang/Object;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl$init$1;->invoke-JoRRYb0(Ljava/lang/Object;)V

    sget-object v0, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    return-object v0
.end method

.method public final invoke-JoRRYb0(Ljava/lang/Object;)V
    .locals 3
    .param p1, "it"    # Ljava/lang/Object;

    .line 145
    sget-object v0, Lcom/rokid/security/phone/sdk/server/coreability/p2p/WifiP2PClientWrapper;->INSTANCE:Lcom/rokid/security/phone/sdk/server/coreability/p2p/WifiP2PClientWrapper;

    invoke-static {}, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl;->access$getMIWifiP2PListener$p()Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl$mIWifiP2PListener$1;

    move-result-object v1

    check-cast v1, Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PListener;

    invoke-virtual {v0, v1}, Lcom/rokid/security/phone/sdk/server/coreability/p2p/WifiP2PClientWrapper;->addWifiP2PListener(Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/callback/IWifiP2PListener;)V

    .line 146
    sget-object v0, Lcom/rokid/security/phone/sdk/server/coreability/p2p/WifiP2PClientWrapper;->INSTANCE:Lcom/rokid/security/phone/sdk/server/coreability/p2p/WifiP2PClientWrapper;

    const/4 v1, 0x0

    const/4 v2, 0x1

    invoke-static {v0, v1, v2, v1}, Lcom/rokid/security/phone/sdk/server/coreability/p2p/WifiP2PClientWrapper;->initialize$default(Lcom/rokid/security/phone/sdk/server/coreability/p2p/WifiP2PClientWrapper;Lkotlin/jvm/functions/Function1;ILjava/lang/Object;)V

    .line 147
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/P2PClientServiceImpl$init$1;->$onResult:Lkotlin/jvm/functions/Function1;

    invoke-static {p1}, Lcom/rokid/security/phone/sdk/base/data/callback/IResult;->box-impl(Ljava/lang/Object;)Lcom/rokid/security/phone/sdk/base/data/callback/IResult;

    move-result-object v1

    invoke-interface {v0, v1}, Lkotlin/jvm/functions/Function1;->invoke(Ljava/lang/Object;)Ljava/lang/Object;

    .line 148
    return-void
.end method
