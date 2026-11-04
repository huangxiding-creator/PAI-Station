.class public final Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater$mIClassicBTClientListener$1;
.super Ljava/lang/Object;
.source "BtFileOperater.kt"

# interfaces
.implements Lcom/rokid/security/phone/sdk/api/bluetooth/classic/listener/IClassicBTClientListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;-><init>()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = null
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000/\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0010\u000b\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0000\n\u0002\u0010\u0008\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0002*\u0001\u0000\u0008\n\u0018\u00002\u00020\u0001J\u0010\u0010\u0002\u001a\u00020\u00032\u0006\u0010\u0004\u001a\u00020\u0005H\u0016J\u0018\u0010\u0006\u001a\u00020\u00032\u0006\u0010\u0007\u001a\u00020\u00082\u0006\u0010\t\u001a\u00020\nH\u0016J\u0010\u0010\u000b\u001a\u00020\u00032\u0006\u0010\u000c\u001a\u00020\rH\u0016J\u0008\u0010\u000e\u001a\u00020\u0003H\u0016\u00a8\u0006\u000f"
    }
    d2 = {
        "com/rokid/security/phone/sdk/server/msg/file/BtFileOperater$mIClassicBTClientListener$1",
        "Lcom/rokid/security/phone/sdk/api/bluetooth/classic/listener/IClassicBTClientListener;",
        "onConnect",
        "",
        "success",
        "",
        "onConnectionRejected",
        "reason",
        "",
        "code",
        "",
        "onDeviceFound",
        "device",
        "Landroid/bluetooth/BluetoothDevice;",
        "onScanFinished",
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
.field final synthetic this$0:Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;


# direct methods
.method constructor <init>(Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;)V
    .locals 0
    .param p1, "$receiver"    # Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;

    iput-object p1, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater$mIClassicBTClientListener$1;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;

    .line 64
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onConnect(Z)V
    .locals 2
    .param p1, "success"    # Z

    .line 74
    if-nez p1, :cond_0

    .line 76
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater$mIClassicBTClientListener$1;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;

    invoke-static {v0}, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;->access$getTAG$p(Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;)Ljava/lang/String;

    move-result-object v0

    const-string/jumbo v1, "\u84dd\u7259\u65ad\u5f00,\u91cd\u7f6e\u72b6\u6001"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 77
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater$mIClassicBTClientListener$1;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;

    const/4 v1, 0x0

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;->access$setAcceptSendCallbacks$p(Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;Z)V

    .line 78
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater$mIClassicBTClientListener$1;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;

    invoke-static {v0}, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;->access$getMFileReceiver(Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;)Lcom/rokid/security/phone/sdk/server/msg/file/BtFileReceiver;

    move-result-object v0

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileReceiver;->resetReceiveState()V

    .line 79
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater$mIClassicBTClientListener$1;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;

    invoke-static {v0}, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;->access$getMFileSender(Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;)Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;

    move-result-object v0

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender;->resetSendState()V

    .line 81
    :cond_0
    return-void
.end method

.method public onConnectionRejected(Ljava/lang/String;I)V
    .locals 1
    .param p1, "reason"    # Ljava/lang/String;
    .param p2, "code"    # I

    const-string v0, "reason"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 85
    return-void
.end method

.method public onDeviceFound(Landroid/bluetooth/BluetoothDevice;)V
    .locals 1
    .param p1, "device"    # Landroid/bluetooth/BluetoothDevice;

    const-string v0, "device"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 67
    return-void
.end method

.method public onScanFinished()V
    .locals 0

    .line 71
    return-void
.end method
