.class public final Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$createGroup$1;
.super Ljava/lang/Object;
.source "P2PClientManager.kt"

# interfaces
.implements Landroid/net/wifi/p2p/WifiP2pManager$ActionListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->createGroup(Lkotlin/jvm/functions/Function1;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = null
.end annotation

.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nP2PClientManager.kt\nKotlin\n*S Kotlin\n*F\n+ 1 P2PClientManager.kt\ncom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$createGroup$1\n+ 2 IResult.kt\ncom/rokid/glasses/transport/sdk/api/callback/IResult$Companion\n*L\n1#1,683:1\n84#2:684\n*S KotlinDebug\n*F\n+ 1 P2PClientManager.kt\ncom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$createGroup$1\n*L\n206#1:684\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u0019\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0010\u0008\n\u0002\u0008\u0002*\u0001\u0000\u0008\n\u0018\u00002\u00020\u0001J\u0010\u0010\u0002\u001a\u00020\u00032\u0006\u0010\u0004\u001a\u00020\u0005H\u0016J\u0008\u0010\u0006\u001a\u00020\u0003H\u0016\u00a8\u0006\u0007"
    }
    d2 = {
        "com/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$createGroup$1",
        "Landroid/net/wifi/p2p/WifiP2pManager$ActionListener;",
        "onFailure",
        "",
        "reason",
        "",
        "onSuccess",
        "sdk-server_release"
    }
    k = 0x1
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
            "Lcom/rokid/glasses/transport/sdk/api/callback/IResult<",
            "Ljava/lang/Boolean;",
            ">;",
            "Lkotlin/Unit;",
            ">;"
        }
    .end annotation
.end field

.field final synthetic this$0:Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;


# direct methods
.method constructor <init>(Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;Lkotlin/jvm/functions/Function1;)V
    .locals 0
    .param p1, "$receiver"    # Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;
    .param p2, "$onResult"    # Lkotlin/jvm/functions/Function1;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;",
            "Lkotlin/jvm/functions/Function1<",
            "-",
            "Lcom/rokid/glasses/transport/sdk/api/callback/IResult<",
            "Ljava/lang/Boolean;",
            ">;",
            "Lkotlin/Unit;",
            ">;)V"
        }
    .end annotation

    iput-object p1, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$createGroup$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;

    iput-object p2, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$createGroup$1;->$onResult:Lkotlin/jvm/functions/Function1;

    .line 203
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onFailure(I)V
    .locals 10
    .param p1, "reason"    # I

    .line 211
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, " createGroup onFailure: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 212
    .local v0, "msg":Ljava/lang/String;
    const/4 v1, 0x0

    new-array v1, v1, [Ljava/lang/Object;

    invoke-static {v0, v1}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 213
    iget-object v7, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$createGroup$1;->$onResult:Lkotlin/jvm/functions/Function1;

    if-eqz v7, :cond_0

    .line 214
    iget-object v8, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$createGroup$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;

    .line 215
    nop

    .line 216
    new-instance v9, Lcom/rokid/glasses/transport/sdk/api/callback/IException;

    const/4 v5, 0x4

    const/4 v6, 0x0

    const/4 v2, -0x1

    const/4 v4, 0x0

    move-object v1, v9

    move-object v3, v0

    invoke-direct/range {v1 .. v6}, Lcom/rokid/glasses/transport/sdk/api/callback/IException;-><init>(ILjava/lang/String;Ljava/lang/Throwable;ILkotlin/jvm/internal/DefaultConstructorMarker;)V

    .line 214
    invoke-static {v8, v0, v9}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->access$getIFailResult-Guu2Vc4(Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;Ljava/lang/String;Lcom/rokid/glasses/transport/sdk/api/callback/IException;)Ljava/lang/Object;

    move-result-object v1

    invoke-static {v1}, Lcom/rokid/glasses/transport/sdk/api/callback/IResult;->box-impl(Ljava/lang/Object;)Lcom/rokid/glasses/transport/sdk/api/callback/IResult;

    move-result-object v1

    .line 213
    invoke-interface {v7, v1}, Lkotlin/jvm/functions/Function1;->invoke(Ljava/lang/Object;)Ljava/lang/Object;

    .line 219
    :cond_0
    return-void
.end method

.method public onSuccess()V
    .locals 4

    .line 205
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$createGroup$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;

    invoke-static {v0}, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;->access$getTAG$p(Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager;)Ljava/lang/String;

    move-result-object v0

    const-string v1, " createGroup onSuccess"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 206
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/wifip2p/client/P2PClientManager$createGroup$1;->$onResult:Lkotlin/jvm/functions/Function1;

    if-eqz v0, :cond_0

    sget-object v1, Lcom/rokid/glasses/transport/sdk/api/callback/IResult;->Companion:Lcom/rokid/glasses/transport/sdk/api/callback/IResult$Companion;

    .local v1, "this_$iv":Lcom/rokid/glasses/transport/sdk/api/callback/IResult$Companion;
    const/4 v2, 0x1

    invoke-static {v2}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v2

    .local v2, "value$iv":Ljava/lang/Object;
    const/4 v3, 0x0

    .line 684
    .local v3, "$i$f$success":I
    invoke-static {v2}, Lcom/rokid/glasses/transport/sdk/api/callback/IResult;->constructor-impl(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    .end local v1    # "this_$iv":Lcom/rokid/glasses/transport/sdk/api/callback/IResult$Companion;
    .end local v2    # "value$iv":Ljava/lang/Object;
    .end local v3    # "$i$f$success":I
    invoke-static {v1}, Lcom/rokid/glasses/transport/sdk/api/callback/IResult;->box-impl(Ljava/lang/Object;)Lcom/rokid/glasses/transport/sdk/api/callback/IResult;

    move-result-object v1

    .line 206
    invoke-interface {v0, v1}, Lkotlin/jvm/functions/Function1;->invoke(Ljava/lang/Object;)Ljava/lang/Object;

    .line 208
    :cond_0
    return-void
.end method
