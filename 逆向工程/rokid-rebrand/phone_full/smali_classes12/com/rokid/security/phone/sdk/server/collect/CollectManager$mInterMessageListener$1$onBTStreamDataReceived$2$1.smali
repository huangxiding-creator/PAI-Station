.class public final Lcom/rokid/security/phone/sdk/server/collect/CollectManager$mInterMessageListener$1$onBTStreamDataReceived$2$1;
.super Ljava/lang/Object;
.source "CollectManager.kt"

# interfaces
.implements Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/security/phone/sdk/server/collect/CollectManager$mInterMessageListener$1;->onBTStreamDataReceived(Ljava/lang/String;[BLjava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = null
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Object;",
        "Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback<",
        "Ljava/lang/String;",
        ">;"
    }
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u001d\n\u0000\n\u0002\u0018\u0002\n\u0002\u0010\u000e\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0010\u0008\n\u0002\u0008\u0005*\u0001\u0000\u0008\n\u0018\u00002\u0008\u0012\u0004\u0012\u00020\u00020\u0001J!\u0010\u0003\u001a\u00020\u00042\u0008\u0010\u0005\u001a\u0004\u0018\u00010\u00062\u0008\u0010\u0007\u001a\u0004\u0018\u00010\u0002H\u0016\u00a2\u0006\u0002\u0010\u0008J\u0012\u0010\t\u001a\u00020\u00042\u0008\u0010\n\u001a\u0004\u0018\u00010\u0002H\u0016\u00a8\u0006\u000b"
    }
    d2 = {
        "com/rokid/security/phone/sdk/server/collect/CollectManager$mInterMessageListener$1$onBTStreamDataReceived$2$1",
        "Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;",
        "",
        "onFailed",
        "",
        "code",
        "",
        "errormsg",
        "(Ljava/lang/Integer;Ljava/lang/String;)V",
        "onSuccess",
        "data",
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
.field final synthetic $tag:Ljava/lang/String;

.field final synthetic this$0:Lcom/rokid/security/phone/sdk/server/collect/CollectManager;


# direct methods
.method constructor <init>(Lcom/rokid/security/phone/sdk/server/collect/CollectManager;Ljava/lang/String;)V
    .locals 0
    .param p1, "$receiver"    # Lcom/rokid/security/phone/sdk/server/collect/CollectManager;
    .param p2, "$tag"    # Ljava/lang/String;

    iput-object p1, p0, Lcom/rokid/security/phone/sdk/server/collect/CollectManager$mInterMessageListener$1$onBTStreamDataReceived$2$1;->this$0:Lcom/rokid/security/phone/sdk/server/collect/CollectManager;

    iput-object p2, p0, Lcom/rokid/security/phone/sdk/server/collect/CollectManager$mInterMessageListener$1$onBTStreamDataReceived$2$1;->$tag:Ljava/lang/String;

    .line 76
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onFailed(Ljava/lang/Integer;Ljava/lang/String;)V
    .locals 5
    .param p1, "code"    # Ljava/lang/Integer;
    .param p2, "errormsg"    # Ljava/lang/String;

    .line 83
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/collect/CollectManager$mInterMessageListener$1$onBTStreamDataReceived$2$1;->this$0:Lcom/rokid/security/phone/sdk/server/collect/CollectManager;

    .line 84
    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/collect/CollectManager$mInterMessageListener$1$onBTStreamDataReceived$2$1;->$tag:Ljava/lang/String;

    .line 85
    nop

    .line 86
    if-eqz p1, :cond_0

    invoke-virtual {p1}, Ljava/lang/Integer;->intValue()I

    move-result v2

    goto :goto_0

    :cond_0
    const/4 v2, -0x1

    .line 87
    :goto_0
    if-nez p2, :cond_1

    const-string v3, ""

    goto :goto_1

    :cond_1
    move-object v3, p2

    .line 83
    :goto_1
    const/4 v4, 0x0

    invoke-virtual {v0, v1, v4, v2, v3}, Lcom/rokid/security/phone/sdk/server/collect/CollectManager;->sendCollectResponseMsg(Ljava/lang/String;ZILjava/lang/String;)V

    .line 89
    return-void
.end method

.method public bridge synthetic onSuccess(Ljava/lang/Object;)V
    .locals 1
    .param p1, "data"    # Ljava/lang/Object;

    .line 76
    move-object v0, p1

    check-cast v0, Ljava/lang/String;

    invoke-virtual {p0, v0}, Lcom/rokid/security/phone/sdk/server/collect/CollectManager$mInterMessageListener$1$onBTStreamDataReceived$2$1;->onSuccess(Ljava/lang/String;)V

    return-void
.end method

.method public onSuccess(Ljava/lang/String;)V
    .locals 9
    .param p1, "data"    # Ljava/lang/String;

    .line 78
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/collect/CollectManager$mInterMessageListener$1$onBTStreamDataReceived$2$1;->this$0:Lcom/rokid/security/phone/sdk/server/collect/CollectManager;

    invoke-static {v0}, Lcom/rokid/security/phone/sdk/server/collect/CollectManager;->access$getTAG$p(Lcom/rokid/security/phone/sdk/server/collect/CollectManager;)Ljava/lang/String;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v2, "\u4e91\u7aef\u4e0a\u4f20\u6210\u529f data = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ", tag = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/collect/CollectManager$mInterMessageListener$1$onBTStreamDataReceived$2$1;->$tag:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 79
    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/collect/CollectManager$mInterMessageListener$1$onBTStreamDataReceived$2$1;->this$0:Lcom/rokid/security/phone/sdk/server/collect/CollectManager;

    iget-object v3, p0, Lcom/rokid/security/phone/sdk/server/collect/CollectManager$mInterMessageListener$1$onBTStreamDataReceived$2$1;->$tag:Ljava/lang/String;

    const/16 v7, 0xc

    const/4 v8, 0x0

    const/4 v4, 0x1

    const/4 v5, 0x0

    const/4 v6, 0x0

    invoke-static/range {v2 .. v8}, Lcom/rokid/security/phone/sdk/server/collect/CollectManager;->sendCollectResponseMsg$default(Lcom/rokid/security/phone/sdk/server/collect/CollectManager;Ljava/lang/String;ZILjava/lang/String;ILjava/lang/Object;)V

    .line 80
    return-void
.end method
