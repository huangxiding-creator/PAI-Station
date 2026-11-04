.class final Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater$startSendFile$1;
.super Lkotlin/jvm/internal/Lambda;
.source "FileOperater.kt"

# interfaces
.implements Lkotlin/jvm/functions/Function1;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;->startSendFile(Ljava/lang/String;Ljava/io/File;Lkotlin/jvm/functions/Function1;)V
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
.field final synthetic $dir:Ljava/lang/String;

.field final synthetic $file:Ljava/io/File;

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

.field final synthetic this$0:Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;


# direct methods
.method constructor <init>(Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;Ljava/lang/String;Ljava/io/File;Lkotlin/jvm/functions/Function1;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;",
            "Ljava/lang/String;",
            "Ljava/io/File;",
            "Lkotlin/jvm/functions/Function1<",
            "-",
            "Lcom/rokid/security/phone/sdk/base/data/callback/IResult<",
            "Ljava/lang/Boolean;",
            ">;",
            "Lkotlin/Unit;",
            ">;)V"
        }
    .end annotation

    iput-object p1, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater$startSendFile$1;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;

    iput-object p2, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater$startSendFile$1;->$dir:Ljava/lang/String;

    iput-object p3, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater$startSendFile$1;->$file:Ljava/io/File;

    iput-object p4, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater$startSendFile$1;->$onResult:Lkotlin/jvm/functions/Function1;

    const/4 v0, 0x1

    invoke-direct {p0, v0}, Lkotlin/jvm/internal/Lambda;-><init>(I)V

    return-void
.end method


# virtual methods
.method public bridge synthetic invoke(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 1
    .param p1, "p1"    # Ljava/lang/Object;

    .line 206
    move-object v0, p1

    check-cast v0, Landroid/net/wifi/p2p/WifiP2pInfo;

    invoke-virtual {p0, v0}, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater$startSendFile$1;->invoke(Landroid/net/wifi/p2p/WifiP2pInfo;)V

    sget-object v0, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    return-object v0
.end method

.method public final invoke(Landroid/net/wifi/p2p/WifiP2pInfo;)V
    .locals 9
    .param p1, "it"    # Landroid/net/wifi/p2p/WifiP2pInfo;

    .line 207
    if-nez p1, :cond_0

    .line 208
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater$startSendFile$1;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;

    invoke-static {v0}, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;->access$getTAG$p(Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;)Ljava/lang/String;

    move-result-object v0

    const-string v1, " startSendFile:  requestConnectionInfo is null"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 209
    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater$startSendFile$1;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;

    const/4 v6, 0x6

    const/4 v7, 0x0

    const-string/jumbo v3, "stop_send_file"

    const/4 v4, 0x0

    const/4 v5, 0x0

    invoke-static/range {v2 .. v7}, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;->sendMsg$default(Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;Ljava/lang/String;FLjava/lang/String;ILjava/lang/Object;)V

    goto :goto_2

    .line 211
    :cond_0
    iget-object v0, p1, Landroid/net/wifi/p2p/WifiP2pInfo;->groupOwnerAddress:Ljava/net/InetAddress;

    invoke-virtual {v0}, Ljava/net/InetAddress;->getHostAddress()Ljava/lang/String;

    move-result-object v0

    .line 212
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

    .line 213
    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater$startSendFile$1;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;

    invoke-static {v1}, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;->access$getTAG$p(Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;)Ljava/lang/String;

    move-result-object v1

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, " startSendFile:  hostAddress = "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 214
    iget-object v3, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater$startSendFile$1;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;

    const/4 v7, 0x6

    const/4 v8, 0x0

    const-string/jumbo v4, "stop_send_file"

    const/4 v5, 0x0

    const/4 v6, 0x0

    invoke-static/range {v3 .. v8}, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;->sendMsg$default(Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;Ljava/lang/String;FLjava/lang/String;ILjava/lang/Object;)V

    goto :goto_2

    .line 216
    :cond_3
    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater$startSendFile$1;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;

    invoke-static {v1}, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;->access$getMFileSender(Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;)Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;

    move-result-object v1

    const-string v2, "hostAddress"

    invoke-static {v0, v2}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    iget-object v3, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater$startSendFile$1;->$dir:Ljava/lang/String;

    iget-object v4, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater$startSendFile$1;->$file:Ljava/io/File;

    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater$startSendFile$1;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;

    invoke-static {v2}, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;->access$getMFileReceiveListener$p(Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;)Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;

    move-result-object v5

    iget-object v6, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater$startSendFile$1;->$onResult:Lkotlin/jvm/functions/Function1;

    move-object v2, v0

    invoke-virtual/range {v1 .. v6}, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;->sendFile(Ljava/lang/String;Ljava/lang/String;Ljava/io/File;Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;Lkotlin/jvm/functions/Function1;)V

    .line 219
    .end local v0    # "hostAddress":Ljava/lang/String;
    :goto_2
    return-void
.end method
