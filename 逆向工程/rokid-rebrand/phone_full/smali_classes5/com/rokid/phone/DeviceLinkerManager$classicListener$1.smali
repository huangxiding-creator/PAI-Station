.class public final Lcom/rokid/phone/DeviceLinkerManager$classicListener$1;
.super Ljava/lang/Object;
.source "DeviceLinkerManager.kt"

# interfaces
.implements Lcom/rokid/security/phone/sdk/api/bluetooth/classic/listener/IClassicBTClientListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/rokid/phone/DeviceLinkerManager;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = null
.end annotation

.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nDeviceLinkerManager.kt\nKotlin\n*S Kotlin\n*F\n+ 1 DeviceLinkerManager.kt\ncom/rokid/phone/DeviceLinkerManager$classicListener$1\n+ 2 fake.kt\nkotlin/jvm/internal/FakeKt\n*L\n1#1,300:1\n1#2:301\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000-\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0003\n\u0002\u0010\u000b\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0000\n\u0002\u0010\u0008\n\u0000*\u0001\u0000\u0008\n\u0018\u00002\u00020\u0001J\u0010\u0010\u0002\u001a\u00020\u00032\u0006\u0010\u0004\u001a\u00020\u0005H\u0016J\u0008\u0010\u0006\u001a\u00020\u0003H\u0016J\u0010\u0010\u0007\u001a\u00020\u00032\u0006\u0010\u0008\u001a\u00020\tH\u0016J\u0018\u0010\n\u001a\u00020\u00032\u0006\u0010\u000b\u001a\u00020\u000c2\u0006\u0010\r\u001a\u00020\u000eH\u0016\u00a8\u0006\u000f"
    }
    d2 = {
        "com/rokid/phone/DeviceLinkerManager$classicListener$1",
        "Lcom/rokid/security/phone/sdk/api/bluetooth/classic/listener/IClassicBTClientListener;",
        "onDeviceFound",
        "",
        "device",
        "Landroid/bluetooth/BluetoothDevice;",
        "onScanFinished",
        "onConnect",
        "success",
        "",
        "onConnectionRejected",
        "reason",
        "",
        "code",
        "",
        "app_debug"
    }
    k = 0x1
    mv = {
        0x2,
        0x2,
        0x0
    }
    xi = 0x30
.end annotation


# direct methods
.method constructor <init>()V
    .locals 0

    .line 57
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onConnect(Z)V
    .locals 3
    .param p1, "success"    # Z

    .line 63
    sget-object v0, Lcom/rokid/phone/data/GlobalData;->INSTANCE:Lcom/rokid/phone/data/GlobalData;

    invoke-virtual {v0, p1}, Lcom/rokid/phone/data/GlobalData;->setBtConnectState(Z)V

    .line 64
    if-eqz p1, :cond_1

    .line 65
    sget-object v0, Lcom/rokid/phone/DeviceLinkerManager;->INSTANCE:Lcom/rokid/phone/DeviceLinkerManager;

    invoke-virtual {v0}, Lcom/rokid/phone/DeviceLinkerManager;->getMConnectingBluetoothDevice()Lcom/rokid/phone/ui/classicbt/model/BluetoothDeviceInfo;

    move-result-object v0

    if-eqz v0, :cond_0

    sget-object v1, Lcom/rokid/phone/DeviceLinkerManager;->INSTANCE:Lcom/rokid/phone/DeviceLinkerManager;

    .line 301
    .local v0, "p0":Lcom/rokid/phone/ui/classicbt/model/BluetoothDeviceInfo;
    const/4 v2, 0x0

    .line 65
    .local v2, "$i$a$-let-DeviceLinkerManager$classicListener$1$onConnect$1":I
    invoke-static {v1, v0}, Lcom/rokid/phone/DeviceLinkerManager;->access$saveDevice(Lcom/rokid/phone/DeviceLinkerManager;Lcom/rokid/phone/ui/classicbt/model/BluetoothDeviceInfo;)V

    .line 66
    .end local v0    # "p0":Lcom/rokid/phone/ui/classicbt/model/BluetoothDeviceInfo;
    .end local v2    # "$i$a$-let-DeviceLinkerManager$classicListener$1$onConnect$1":I
    :cond_0
    sget-object v0, Lcom/rokid/phone/DeviceLinkerManager;->INSTANCE:Lcom/rokid/phone/DeviceLinkerManager;

    invoke-static {v0}, Lcom/rokid/phone/DeviceLinkerManager;->access$requestSystemInfo(Lcom/rokid/phone/DeviceLinkerManager;)V

    .line 67
    sget-object v0, Lcom/rokid/phone/DeviceLinkerManager;->INSTANCE:Lcom/rokid/phone/DeviceLinkerManager;

    invoke-static {v0}, Lcom/rokid/phone/DeviceLinkerManager;->access$startStatusPolling(Lcom/rokid/phone/DeviceLinkerManager;)V

    .line 68
    sget-object v0, Lcom/rokid/phone/DeviceLinkerManager;->INSTANCE:Lcom/rokid/phone/DeviceLinkerManager;

    invoke-virtual {v0}, Lcom/rokid/phone/DeviceLinkerManager;->connectP2p()V

    goto :goto_0

    .line 70
    :cond_1
    sget-object v0, Lcom/rokid/phone/DeviceLinkerManager;->INSTANCE:Lcom/rokid/phone/DeviceLinkerManager;

    invoke-static {v0}, Lcom/rokid/phone/DeviceLinkerManager;->access$stopStatusPolling(Lcom/rokid/phone/DeviceLinkerManager;)V

    .line 72
    :goto_0
    return-void
.end method

.method public onConnectionRejected(Ljava/lang/String;I)V
    .locals 2
    .param p1, "reason"    # Ljava/lang/String;
    .param p2, "code"    # I

    const-string v0, "reason"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 75
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Bluetooth connection rejected: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " ("

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const/16 v1, 0x29

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const-string v1, "DeviceLinkerManager"

    invoke-static {v1, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 76
    return-void
.end method

.method public onDeviceFound(Landroid/bluetooth/BluetoothDevice;)V
    .locals 1
    .param p1, "device"    # Landroid/bluetooth/BluetoothDevice;

    const-string v0, "device"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 58
    return-void
.end method

.method public onScanFinished()V
    .locals 0

    .line 60
    return-void
.end method
