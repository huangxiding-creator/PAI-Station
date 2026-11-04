.class public final Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService$gattServerCallback$1;
.super Landroid/bluetooth/BluetoothGattServerCallback;
.source "BleCustomService.kt"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService;-><init>()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = null
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000E\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0008\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0010\u000b\n\u0002\u0008\u0002\n\u0002\u0010\u0012\n\u0002\u0008\u0005\n\u0002\u0018\u0002\n\u0002\u0008\u0006\n\u0002\u0018\u0002\n\u0000*\u0001\u0000\u0008\n\u0018\u00002\u00020\u0001J,\u0010\u0002\u001a\u00020\u00032\u0008\u0010\u0004\u001a\u0004\u0018\u00010\u00052\u0006\u0010\u0006\u001a\u00020\u00072\u0006\u0010\u0008\u001a\u00020\u00072\u0008\u0010\t\u001a\u0004\u0018\u00010\nH\u0017JF\u0010\u000b\u001a\u00020\u00032\u0008\u0010\u0004\u001a\u0004\u0018\u00010\u00052\u0006\u0010\u0006\u001a\u00020\u00072\u0008\u0010\t\u001a\u0004\u0018\u00010\n2\u0006\u0010\u000c\u001a\u00020\r2\u0006\u0010\u000e\u001a\u00020\r2\u0006\u0010\u0008\u001a\u00020\u00072\u0008\u0010\u000f\u001a\u0004\u0018\u00010\u0010H\u0017J\"\u0010\u0011\u001a\u00020\u00032\u0008\u0010\u0004\u001a\u0004\u0018\u00010\u00052\u0006\u0010\u0012\u001a\u00020\u00072\u0006\u0010\u0013\u001a\u00020\u0007H\u0016J,\u0010\u0014\u001a\u00020\u00032\u0008\u0010\u0004\u001a\u0004\u0018\u00010\u00052\u0006\u0010\u0006\u001a\u00020\u00072\u0006\u0010\u0008\u001a\u00020\u00072\u0008\u0010\u0015\u001a\u0004\u0018\u00010\u0016H\u0016JF\u0010\u0017\u001a\u00020\u00032\u0008\u0010\u0004\u001a\u0004\u0018\u00010\u00052\u0006\u0010\u0006\u001a\u00020\u00072\u0008\u0010\u0015\u001a\u0004\u0018\u00010\u00162\u0006\u0010\u000c\u001a\u00020\r2\u0006\u0010\u000e\u001a\u00020\r2\u0006\u0010\u0008\u001a\u00020\u00072\u0008\u0010\u000f\u001a\u0004\u0018\u00010\u0010H\u0017J\u001a\u0010\u0018\u001a\u00020\u00032\u0008\u0010\u0004\u001a\u0004\u0018\u00010\u00052\u0006\u0010\u0019\u001a\u00020\u0007H\u0016J\u001a\u0010\u001a\u001a\u00020\u00032\u0008\u0010\u0004\u001a\u0004\u0018\u00010\u00052\u0006\u0010\u0012\u001a\u00020\u0007H\u0016J\u0018\u0010\u001b\u001a\u00020\u00032\u0006\u0010\u0012\u001a\u00020\u00072\u0006\u0010\u001c\u001a\u00020\u001dH\u0016\u00a8\u0006\u001e"
    }
    d2 = {
        "com/rokid/glasses/transport/sdk/server/ble/server/BleCustomService$gattServerCallback$1",
        "Landroid/bluetooth/BluetoothGattServerCallback;",
        "onCharacteristicReadRequest",
        "",
        "device",
        "Landroid/bluetooth/BluetoothDevice;",
        "requestId",
        "",
        "offset",
        "characteristic",
        "Landroid/bluetooth/BluetoothGattCharacteristic;",
        "onCharacteristicWriteRequest",
        "preparedWrite",
        "",
        "responseNeeded",
        "value",
        "",
        "onConnectionStateChange",
        "status",
        "newState",
        "onDescriptorReadRequest",
        "descriptor",
        "Landroid/bluetooth/BluetoothGattDescriptor;",
        "onDescriptorWriteRequest",
        "onMtuChanged",
        "mtu",
        "onNotificationSent",
        "onServiceAdded",
        "service",
        "Landroid/bluetooth/BluetoothGattService;",
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
.field final synthetic this$0:Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService;


# direct methods
.method constructor <init>(Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService;)V
    .locals 0
    .param p1, "$receiver"    # Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService;

    iput-object p1, p0, Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService$gattServerCallback$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService;

    .line 189
    invoke-direct {p0}, Landroid/bluetooth/BluetoothGattServerCallback;-><init>()V

    return-void
.end method


# virtual methods
.method public onCharacteristicReadRequest(Landroid/bluetooth/BluetoothDevice;IILandroid/bluetooth/BluetoothGattCharacteristic;)V
    .locals 8
    .param p1, "device"    # Landroid/bluetooth/BluetoothDevice;
    .param p2, "requestId"    # I
    .param p3, "offset"    # I
    .param p4, "characteristic"    # Landroid/bluetooth/BluetoothGattCharacteristic;

    .line 238
    const-string v0, " gattServerCallback-----onCharacteristicReadRequest: "

    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v0

    const-string v1, "BleCustomService"

    invoke-static {v1, v0}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 239
    if-eqz p4, :cond_0

    invoke-virtual {p4}, Landroid/bluetooth/BluetoothGattCharacteristic;->getUuid()Ljava/util/UUID;

    move-result-object v0

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    invoke-static {}, Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService;->access$getCHARACTERISTIC_UUID$cp()Ljava/util/UUID;

    move-result-object v1

    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 240
    const-string v0, "Sample read data"

    sget-object v1, Lkotlin/text/Charsets;->UTF_8:Ljava/nio/charset/Charset;

    invoke-virtual {v0, v1}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B

    move-result-object v7

    const-string v0, "this as java.lang.String).getBytes(charset)"

    invoke-static {v7, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 241
    .local v7, "value":[B
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService$gattServerCallback$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService;

    invoke-static {v0}, Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService;->access$getBluetoothGattServer$p(Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService;)Landroid/bluetooth/BluetoothGattServer;

    move-result-object v2

    if-eqz v2, :cond_1

    .line 242
    nop

    .line 243
    nop

    .line 244
    nop

    .line 245
    nop

    .line 246
    nop

    .line 241
    const/4 v5, 0x0

    move-object v3, p1

    move v4, p2

    move v6, p3

    invoke-virtual/range {v2 .. v7}, Landroid/bluetooth/BluetoothGattServer;->sendResponse(Landroid/bluetooth/BluetoothDevice;III[B)Z

    .line 249
    .end local v7    # "value":[B
    :cond_1
    return-void
.end method

.method public onCharacteristicWriteRequest(Landroid/bluetooth/BluetoothDevice;ILandroid/bluetooth/BluetoothGattCharacteristic;ZZI[B)V
    .locals 8
    .param p1, "device"    # Landroid/bluetooth/BluetoothDevice;
    .param p2, "requestId"    # I
    .param p3, "characteristic"    # Landroid/bluetooth/BluetoothGattCharacteristic;
    .param p4, "preparedWrite"    # Z
    .param p5, "responseNeeded"    # Z
    .param p6, "offset"    # I
    .param p7, "value"    # [B

    .line 264
    const-string v0, " gattServerCallback----- onCharacteristicWriteRequest: "

    const-string v1, "BleCustomService"

    invoke-static {v1, v0}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 265
    if-eqz p3, :cond_0

    invoke-virtual {p3}, Landroid/bluetooth/BluetoothGattCharacteristic;->getUuid()Ljava/util/UUID;

    move-result-object v0

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    invoke-static {}, Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService;->access$getCHARACTERISTIC_UUID$cp()Ljava/util/UUID;

    move-result-object v2

    invoke-static {v0, v2}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_2

    new-instance v0, Ljava/lang/String;

    .line 266
    invoke-static {p7}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;)V

    sget-object v2, Lkotlin/text/Charsets;->UTF_8:Ljava/nio/charset/Charset;

    invoke-direct {v0, p7, v2}, Ljava/lang/String;-><init>([BLjava/nio/charset/Charset;)V

    .line 267
    .local v0, "data":Ljava/lang/String;
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, " onCharacteristicWriteRequest:  data = "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 268
    iget-object v1, p0, Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService$gattServerCallback$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService;

    invoke-static {v1}, Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService;->access$getServerListener$p(Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService;)Lcom/rokid/glasses/transport/sdk/server/ble/server/ServerListener;

    move-result-object v1

    if-eqz v1, :cond_1

    invoke-interface {v1, v0}, Lcom/rokid/glasses/transport/sdk/server/ble/server/ServerListener;->onDataReceived(Ljava/lang/String;)V

    .line 269
    :cond_1
    if-eqz p5, :cond_2

    .line 270
    iget-object v1, p0, Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService$gattServerCallback$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService;

    invoke-static {v1}, Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService;->access$getBluetoothGattServer$p(Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService;)Landroid/bluetooth/BluetoothGattServer;

    move-result-object v2

    if-eqz v2, :cond_2

    .line 271
    nop

    .line 272
    nop

    .line 273
    nop

    .line 274
    nop

    .line 275
    nop

    .line 270
    const/4 v5, 0x0

    const/4 v6, 0x0

    const/4 v7, 0x0

    move-object v3, p1

    move v4, p2

    invoke-virtual/range {v2 .. v7}, Landroid/bluetooth/BluetoothGattServer;->sendResponse(Landroid/bluetooth/BluetoothDevice;III[B)Z

    .line 279
    .end local v0    # "data":Ljava/lang/String;
    :cond_2
    return-void
.end method

.method public onConnectionStateChange(Landroid/bluetooth/BluetoothDevice;II)V
    .locals 3
    .param p1, "device"    # Landroid/bluetooth/BluetoothDevice;
    .param p2, "status"    # I
    .param p3, "newState"    # I

    .line 195
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, " gattServerCallback-----onConnectionStateChange: newState = "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v0

    const-string v1, "BleCustomService"

    invoke-static {v1, v0}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 196
    packed-switch p3, :pswitch_data_0

    :pswitch_0
    goto :goto_0

    .line 198
    :pswitch_1
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService$gattServerCallback$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService;

    invoke-static {v0}, Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService;->access$getServerListener$p(Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService;)Lcom/rokid/glasses/transport/sdk/server/ble/server/ServerListener;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-interface {v0}, Lcom/rokid/glasses/transport/sdk/server/ble/server/ServerListener;->onClientConnected()V

    .line 199
    :cond_0
    if-eqz p1, :cond_1

    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService$gattServerCallback$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService;

    move-object v1, p1

    .local v1, "it":Landroid/bluetooth/BluetoothDevice;
    const/4 v2, 0x0

    .line 200
    .local v2, "$i$a$-let-BleCustomService$gattServerCallback$1$onConnectionStateChange$1":I
    invoke-static {v0}, Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService;->access$getConnectedDevices$p(Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService;)Ljava/util/List;

    move-result-object v0

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 199
    .end local v1    # "it":Landroid/bluetooth/BluetoothDevice;
    .end local v2    # "$i$a$-let-BleCustomService$gattServerCallback$1$onConnectionStateChange$1":I
    nop

    .line 202
    :cond_1
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService$gattServerCallback$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService;

    invoke-static {v0}, Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService;->access$stopAdvertising(Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService;)V

    goto :goto_0

    .line 206
    :pswitch_2
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService$gattServerCallback$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService;

    invoke-static {v0}, Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService;->access$getServerListener$p(Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService;)Lcom/rokid/glasses/transport/sdk/server/ble/server/ServerListener;

    move-result-object v0

    if-eqz v0, :cond_2

    invoke-interface {v0}, Lcom/rokid/glasses/transport/sdk/server/ble/server/ServerListener;->onClientDisconnected()V

    .line 207
    :cond_2
    if-eqz p1, :cond_3

    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService$gattServerCallback$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService;

    move-object v1, p1

    .restart local v1    # "it":Landroid/bluetooth/BluetoothDevice;
    const/4 v2, 0x0

    .line 208
    .local v2, "$i$a$-let-BleCustomService$gattServerCallback$1$onConnectionStateChange$2":I
    invoke-static {v0}, Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService;->access$getConnectedDevices$p(Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService;)Ljava/util/List;

    move-result-object v0

    invoke-interface {v0, v1}, Ljava/util/List;->remove(Ljava/lang/Object;)Z

    .line 207
    .end local v1    # "it":Landroid/bluetooth/BluetoothDevice;
    .end local v2    # "$i$a$-let-BleCustomService$gattServerCallback$1$onConnectionStateChange$2":I
    nop

    .line 210
    :cond_3
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService$gattServerCallback$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService;

    invoke-static {v0}, Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService;->access$startAdvertising(Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService;)V

    .line 213
    :goto_0
    return-void

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_2
        :pswitch_0
        :pswitch_1
    .end packed-switch
.end method

.method public onDescriptorReadRequest(Landroid/bluetooth/BluetoothDevice;IILandroid/bluetooth/BluetoothGattDescriptor;)V
    .locals 2
    .param p1, "device"    # Landroid/bluetooth/BluetoothDevice;
    .param p2, "requestId"    # I
    .param p3, "offset"    # I
    .param p4, "descriptor"    # Landroid/bluetooth/BluetoothGattDescriptor;

    .line 290
    invoke-super {p0, p1, p2, p3, p4}, Landroid/bluetooth/BluetoothGattServerCallback;->onDescriptorReadRequest(Landroid/bluetooth/BluetoothDevice;IILandroid/bluetooth/BluetoothGattDescriptor;)V

    .line 291
    const-string v0, " gattServerCallback-----onDescriptorReadRequest: "

    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v0

    const-string v1, "BleCustomService"

    invoke-static {v1, v0}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 292
    return-void
.end method

.method public onDescriptorWriteRequest(Landroid/bluetooth/BluetoothDevice;ILandroid/bluetooth/BluetoothGattDescriptor;ZZI[B)V
    .locals 7
    .param p1, "device"    # Landroid/bluetooth/BluetoothDevice;
    .param p2, "requestId"    # I
    .param p3, "descriptor"    # Landroid/bluetooth/BluetoothGattDescriptor;
    .param p4, "preparedWrite"    # Z
    .param p5, "responseNeeded"    # Z
    .param p6, "offset"    # I
    .param p7, "value"    # [B

    .line 307
    const-string v0, " gattServerCallback-----onDescriptorWriteRequest: "

    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v0

    const-string v1, "BleCustomService"

    invoke-static {v1, v0}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 309
    const/4 v0, 0x0

    if-eqz p3, :cond_0

    invoke-virtual {p3}, Landroid/bluetooth/BluetoothGattDescriptor;->getUuid()Ljava/util/UUID;

    move-result-object v2

    goto :goto_0

    :cond_0
    move-object v2, v0

    :goto_0
    invoke-static {}, Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService;->access$getCCCD_UUID$cp()Ljava/util/UUID;

    move-result-object v3

    invoke-static {v2, v3}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_5

    .line 310
    const-string v2, " gattServerCallback-----onDescriptorWriteRequest:1111 "

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 312
    sget-object v2, Landroid/bluetooth/BluetoothGattDescriptor;->ENABLE_NOTIFICATION_VALUE:[B

    invoke-static {p7, v2}, Ljava/util/Arrays;->equals([B[B)Z

    move-result v2

    if-eqz v2, :cond_2

    .line 314
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, " Notification enabled by client: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    if-eqz p1, :cond_1

    invoke-virtual {p1}, Landroid/bluetooth/BluetoothDevice;->getAddress()Ljava/lang/String;

    move-result-object v0

    :cond_1
    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v0

    invoke-static {v1, v0}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    goto :goto_1

    .line 315
    :cond_2
    sget-object v2, Landroid/bluetooth/BluetoothGattDescriptor;->DISABLE_NOTIFICATION_VALUE:[B

    invoke-static {p7, v2}, Ljava/util/Arrays;->equals([B[B)Z

    move-result v2

    if-eqz v2, :cond_4

    .line 317
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, " Notification disabled by client: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    if-eqz p1, :cond_3

    invoke-virtual {p1}, Landroid/bluetooth/BluetoothDevice;->getAddress()Ljava/lang/String;

    move-result-object v0

    :cond_3
    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v0

    invoke-static {v1, v0}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 320
    :cond_4
    :goto_1
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService$gattServerCallback$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService;

    invoke-static {v0}, Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService;->access$getBluetoothGattServer$p(Lcom/rokid/glasses/transport/sdk/server/ble/server/BleCustomService;)Landroid/bluetooth/BluetoothGattServer;

    move-result-object v1

    if-eqz v1, :cond_5

    .line 321
    nop

    .line 322
    nop

    .line 323
    nop

    .line 324
    nop

    .line 325
    nop

    .line 320
    const/4 v4, 0x0

    const/4 v5, 0x0

    const/4 v6, 0x0

    move-object v2, p1

    move v3, p2

    invoke-virtual/range {v1 .. v6}, Landroid/bluetooth/BluetoothGattServer;->sendResponse(Landroid/bluetooth/BluetoothDevice;III[B)Z

    .line 328
    :cond_5
    return-void
.end method

.method public onMtuChanged(Landroid/bluetooth/BluetoothDevice;I)V
    .locals 2
    .param p1, "device"    # Landroid/bluetooth/BluetoothDevice;
    .param p2, "mtu"    # I

    .line 334
    invoke-super {p0, p1, p2}, Landroid/bluetooth/BluetoothGattServerCallback;->onMtuChanged(Landroid/bluetooth/BluetoothDevice;I)V

    .line 335
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, " gattServerCallback----- onMtuChanged MTU size changed to: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v0

    const-string v1, "BleCustomService"

    invoke-static {v1, v0}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 336
    return-void
.end method

.method public onNotificationSent(Landroid/bluetooth/BluetoothDevice;I)V
    .locals 2
    .param p1, "device"    # Landroid/bluetooth/BluetoothDevice;
    .param p2, "status"    # I

    .line 343
    invoke-super {p0, p1, p2}, Landroid/bluetooth/BluetoothGattServerCallback;->onNotificationSent(Landroid/bluetooth/BluetoothDevice;I)V

    .line 344
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, " gattServerCallback ----- onNotificationSent: status = "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v0

    const-string v1, "BleCustomService"

    invoke-static {v1, v0}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 345
    return-void
.end method

.method public onServiceAdded(ILandroid/bluetooth/BluetoothGattService;)V
    .locals 3
    .param p1, "status"    # I
    .param p2, "service"    # Landroid/bluetooth/BluetoothGattService;

    const-string v0, "service"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 219
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, " gattServerCallback-----onServiceAdded: status = "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v0

    const-string v1, "BleCustomService"

    invoke-static {v1, v0}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 220
    if-nez p1, :cond_0

    .line 221
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, " gattServerCallback----- Service added: "

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {p2}, Landroid/bluetooth/BluetoothGattService;->getUuid()Ljava/util/UUID;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v0

    invoke-static {v1, v0}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    goto :goto_0

    .line 223
    :cond_0
    const-string v0, " gattServerCallback----- Failed to add service"

    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v0

    invoke-static {v1, v0}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 225
    :goto_0
    return-void
.end method
