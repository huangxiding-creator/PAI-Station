.class final Lcom/rokid/security/phone/sdk/server/msg/file/ApkOperator$startSendApk$1;
.super Lkotlin/jvm/internal/Lambda;
.source "ApkOperator.kt"

# interfaces
.implements Lkotlin/jvm/functions/Function1;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/security/phone/sdk/server/msg/file/ApkOperator;->startSendApk(Ljava/io/File;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x18
    name = null
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lkotlin/jvm/internal/Lambda;",
        "Lkotlin/jvm/functions/Function1<",
        "Landroid/net/wifi/p2p/WifiP2pInfo;",
        "Lkotlin/Unit;",
        ">;"
    }
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u000e\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\u0010\u0000\u001a\u00020\u00012\u0008\u0010\u0002\u001a\u0004\u0018\u00010\u0003H\n\u00a2\u0006\u0002\u0008\u0004"
    }
    d2 = {
        "<anonymous>",
        "",
        "it",
        "Landroid/net/wifi/p2p/WifiP2pInfo;",
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
.field final synthetic $file:Ljava/io/File;

.field final synthetic this$0:Lcom/rokid/security/phone/sdk/server/msg/file/ApkOperator;


# direct methods
.method constructor <init>(Lcom/rokid/security/phone/sdk/server/msg/file/ApkOperator;Ljava/io/File;)V
    .locals 1

    iput-object p1, p0, Lcom/rokid/security/phone/sdk/server/msg/file/ApkOperator$startSendApk$1;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/ApkOperator;

    iput-object p2, p0, Lcom/rokid/security/phone/sdk/server/msg/file/ApkOperator$startSendApk$1;->$file:Ljava/io/File;

    const/4 v0, 0x1

    invoke-direct {p0, v0}, Lkotlin/jvm/internal/Lambda;-><init>(I)V

    return-void
.end method


# virtual methods
.method public bridge synthetic invoke(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 1
    .param p1, "p1"    # Ljava/lang/Object;

    .line 39
    move-object v0, p1

    check-cast v0, Landroid/net/wifi/p2p/WifiP2pInfo;

    invoke-virtual {p0, v0}, Lcom/rokid/security/phone/sdk/server/msg/file/ApkOperator$startSendApk$1;->invoke(Landroid/net/wifi/p2p/WifiP2pInfo;)V

    sget-object v0, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    return-object v0
.end method

.method public final invoke(Landroid/net/wifi/p2p/WifiP2pInfo;)V
    .locals 4
    .param p1, "it"    # Landroid/net/wifi/p2p/WifiP2pInfo;

    .line 40
    if-nez p1, :cond_0

    .line 41
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/ApkOperator$startSendApk$1;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/ApkOperator;

    invoke-static {v0}, Lcom/rokid/security/phone/sdk/server/msg/file/ApkOperator;->access$getTAG$p(Lcom/rokid/security/phone/sdk/server/msg/file/ApkOperator;)Ljava/lang/String;

    move-result-object v0

    const-string/jumbo v1, "startSendApk connect is null"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 42
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/ApkOperator$startSendApk$1;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/ApkOperator;

    invoke-static {v0}, Lcom/rokid/security/phone/sdk/server/msg/file/ApkOperator;->access$getMListener$p(Lcom/rokid/security/phone/sdk/server/msg/file/ApkOperator;)Lcom/rokid/security/sdk/base/common/apk/TransferProgressListener;

    move-result-object v0

    if-eqz v0, :cond_4

    const-string v1, " WifiP2pInfo is null"

    invoke-interface {v0, v1}, Lcom/rokid/security/sdk/base/common/apk/TransferProgressListener;->onError(Ljava/lang/String;)V

    goto :goto_2

    .line 44
    :cond_0
    iget-object v0, p1, Landroid/net/wifi/p2p/WifiP2pInfo;->groupOwnerAddress:Ljava/net/InetAddress;

    invoke-virtual {v0}, Ljava/net/InetAddress;->getHostAddress()Ljava/lang/String;

    move-result-object v0

    .line 45
    .local v0, "hostAddress":Ljava/lang/String;
    move-object v1, v0

    check-cast v1, Ljava/lang/CharSequence;

    if-eqz v1, :cond_2

    invoke-interface {v1}, Ljava/lang/CharSequence;->length()I

    move-result v1

    if-nez v1, :cond_1

    goto :goto_0

    :cond_1
    const/4 v1, 0x0

    goto :goto_1

    :cond_2
    :goto_0
    const/4 v1, 0x1

    :goto_1
    if-eqz v1, :cond_3

    .line 46
    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/msg/file/ApkOperator$startSendApk$1;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/ApkOperator;

    invoke-static {v1}, Lcom/rokid/security/phone/sdk/server/msg/file/ApkOperator;->access$getTAG$p(Lcom/rokid/security/phone/sdk/server/msg/file/ApkOperator;)Ljava/lang/String;

    move-result-object v1

    const-string/jumbo v2, "startSendApk hostAddress is null"

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 47
    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/msg/file/ApkOperator$startSendApk$1;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/ApkOperator;

    invoke-static {v1}, Lcom/rokid/security/phone/sdk/server/msg/file/ApkOperator;->access$getMListener$p(Lcom/rokid/security/phone/sdk/server/msg/file/ApkOperator;)Lcom/rokid/security/sdk/base/common/apk/TransferProgressListener;

    move-result-object v1

    if-eqz v1, :cond_4

    const-string v2, "hostAddress is null"

    invoke-interface {v1, v2}, Lcom/rokid/security/sdk/base/common/apk/TransferProgressListener;->onError(Ljava/lang/String;)V

    goto :goto_2

    .line 49
    :cond_3
    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/msg/file/ApkOperator$startSendApk$1;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/ApkOperator;

    invoke-static {v1}, Lcom/rokid/security/phone/sdk/server/msg/file/ApkOperator;->access$getApkSender(Lcom/rokid/security/phone/sdk/server/msg/file/ApkOperator;)Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;

    move-result-object v1

    const-string v2, "hostAddress"

    invoke-static {v0, v2}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/msg/file/ApkOperator$startSendApk$1;->$file:Ljava/io/File;

    iget-object v3, p0, Lcom/rokid/security/phone/sdk/server/msg/file/ApkOperator$startSendApk$1;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/ApkOperator;

    invoke-static {v3}, Lcom/rokid/security/phone/sdk/server/msg/file/ApkOperator;->access$getMListener$p(Lcom/rokid/security/phone/sdk/server/msg/file/ApkOperator;)Lcom/rokid/security/sdk/base/common/apk/TransferProgressListener;

    move-result-object v3

    invoke-virtual {v1, v0, v2, v3}, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;->sendFile(Ljava/lang/String;Ljava/io/File;Lcom/rokid/security/sdk/base/common/apk/TransferProgressListener;)V

    .line 52
    .end local v0    # "hostAddress":Ljava/lang/String;
    :cond_4
    :goto_2
    return-void
.end method
