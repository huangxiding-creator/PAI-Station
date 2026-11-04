.class public final Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager$gattCallback$1;
.super Landroid/bluetooth/BluetoothGattCallback;
.source "BleClientManager.kt"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;-><init>()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = null
.end annotation

.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nBleClientManager.kt\nKotlin\n*S Kotlin\n*F\n+ 1 BleClientManager.kt\ncom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager$gattCallback$1\n+ 2 _Collections.kt\nkotlin/collections/CollectionsKt___CollectionsKt\n*L\n1#1,337:1\n1855#2,2:338\n1855#2,2:340\n1855#2,2:342\n1855#2,2:344\n*S KotlinDebug\n*F\n+ 1 BleClientManager.kt\ncom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager$gattCallback$1\n*L\n212#1:338,2\n230#1:340,2\n280#1:342,2\n291#1:344,2\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u00005\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0012\n\u0002\u0008\u0002\n\u0002\u0010\u0008\n\u0002\u0008\u0005\n\u0002\u0018\u0002\n\u0002\u0008\u0006*\u0001\u0000\u0008\n\u0018\u00002\u00020\u0001J\u0018\u0010\u0002\u001a\u00020\u00032\u0006\u0010\u0004\u001a\u00020\u00052\u0006\u0010\u0006\u001a\u00020\u0007H\u0016J \u0010\u0002\u001a\u00020\u00032\u0006\u0010\u0004\u001a\u00020\u00052\u0006\u0010\u0006\u001a\u00020\u00072\u0006\u0010\u0008\u001a\u00020\tH\u0016J$\u0010\n\u001a\u00020\u00032\u0008\u0010\u0004\u001a\u0004\u0018\u00010\u00052\u0008\u0010\u0006\u001a\u0004\u0018\u00010\u00072\u0006\u0010\u000b\u001a\u00020\u000cH\u0016J$\u0010\r\u001a\u00020\u00032\u0008\u0010\u0004\u001a\u0004\u0018\u00010\u00052\u0008\u0010\u0006\u001a\u0004\u0018\u00010\u00072\u0006\u0010\u000b\u001a\u00020\u000cH\u0016J\"\u0010\u000e\u001a\u00020\u00032\u0008\u0010\u0004\u001a\u0004\u0018\u00010\u00052\u0006\u0010\u000b\u001a\u00020\u000c2\u0006\u0010\u000f\u001a\u00020\u000cH\u0017J(\u0010\u0010\u001a\u00020\u00032\u0006\u0010\u0004\u001a\u00020\u00052\u0006\u0010\u0011\u001a\u00020\u00122\u0006\u0010\u000b\u001a\u00020\u000c2\u0006\u0010\u0008\u001a\u00020\tH\u0016J$\u0010\u0013\u001a\u00020\u00032\u0008\u0010\u0004\u001a\u0004\u0018\u00010\u00052\u0008\u0010\u0011\u001a\u0004\u0018\u00010\u00122\u0006\u0010\u000b\u001a\u00020\u000cH\u0016J\"\u0010\u0014\u001a\u00020\u00032\u0008\u0010\u0004\u001a\u0004\u0018\u00010\u00052\u0006\u0010\u0015\u001a\u00020\u000c2\u0006\u0010\u000b\u001a\u00020\u000cH\u0016J\u0010\u0010\u0016\u001a\u00020\u00032\u0006\u0010\u0004\u001a\u00020\u0005H\u0016J\u001a\u0010\u0017\u001a\u00020\u00032\u0008\u0010\u0004\u001a\u0004\u0018\u00010\u00052\u0006\u0010\u000b\u001a\u00020\u000cH\u0017\u00a8\u0006\u0018"
    }
    d2 = {
        "com/rokid/glasses/transport/sdk/server/ble/client/BleClientManager$gattCallback$1",
        "Landroid/bluetooth/BluetoothGattCallback;",
        "onCharacteristicChanged",
        "",
        "gatt",
        "Landroid/bluetooth/BluetoothGatt;",
        "characteristic",
        "Landroid/bluetooth/BluetoothGattCharacteristic;",
        "value",
        "",
        "onCharacteristicRead",
        "status",
        "",
        "onCharacteristicWrite",
        "onConnectionStateChange",
        "newState",
        "onDescriptorRead",
        "descriptor",
        "Landroid/bluetooth/BluetoothGattDescriptor;",
        "onDescriptorWrite",
        "onMtuChanged",
        "mtu",
        "onServiceChanged",
        "onServicesDiscovered",
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
.field final synthetic this$0:Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;


# direct methods
.method constructor <init>(Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;)V
    .locals 0
    .param p1, "$receiver"    # Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;

    iput-object p1, p0, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager$gattCallback$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;

    .line 198
    invoke-direct {p0}, Landroid/bluetooth/BluetoothGattCallback;-><init>()V

    return-void
.end method


# virtual methods
.method public onCharacteristicChanged(Landroid/bluetooth/BluetoothGatt;Landroid/bluetooth/BluetoothGattCharacteristic;)V
    .locals 7
    .param p1, "gatt"    # Landroid/bluetooth/BluetoothGatt;
    .param p2, "characteristic"    # Landroid/bluetooth/BluetoothGattCharacteristic;

    const-string v0, "gatt"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "characteristic"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 289
    invoke-virtual {p2}, Landroid/bluetooth/BluetoothGattCharacteristic;->getValue()[B

    move-result-object v0

    const-string v1, "characteristic.value"

    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    new-instance v1, Ljava/lang/String;

    sget-object v2, Lkotlin/text/Charsets;->UTF_8:Ljava/nio/charset/Charset;

    invoke-direct {v1, v0, v2}, Ljava/lang/String;-><init>([BLjava/nio/charset/Charset;)V

    move-object v0, v1

    .line 290
    .local v0, "data":Ljava/lang/String;
    iget-object v1, p0, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager$gattCallback$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;

    invoke-static {v1}, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;->access$getTAG$p(Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;)Ljava/lang/String;

    move-result-object v1

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, " gattCallback ---- onCharacteristicChanged2: data =  "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 291
    iget-object v1, p0, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager$gattCallback$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;

    invoke-static {v1}, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;->access$getMBleClientListeners$p(Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;)Ljava/util/List;

    move-result-object v1

    check-cast v1, Ljava/lang/Iterable;

    .local v1, "$this$forEach$iv":Ljava/lang/Iterable;
    const/4 v2, 0x0

    .line 344
    .local v2, "$i$f$forEach":I
    invoke-interface {v1}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :goto_0
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v4

    if-eqz v4, :cond_0

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v4

    .local v4, "element$iv":Ljava/lang/Object;
    move-object v5, v4

    check-cast v5, Lcom/rokid/glasses/transport/sdk/api/ble/client/callback/IBleClientListener;

    .local v5, "it":Lcom/rokid/glasses/transport/sdk/api/ble/client/callback/IBleClientListener;
    const/4 v6, 0x0

    .line 292
    .local v6, "$i$a$-forEach-BleClientManager$gattCallback$1$onCharacteristicChanged$2":I
    invoke-interface {v5, v0}, Lcom/rokid/glasses/transport/sdk/api/ble/client/callback/IBleClientListener;->onTextMessage(Ljava/lang/String;)V

    .line 293
    nop

    .line 344
    .end local v5    # "it":Lcom/rokid/glasses/transport/sdk/api/ble/client/callback/IBleClientListener;
    .end local v6    # "$i$a$-forEach-BleClientManager$gattCallback$1$onCharacteristicChanged$2":I
    nop

    .end local v4    # "element$iv":Ljava/lang/Object;
    goto :goto_0

    .line 345
    :cond_0
    nop

    .line 294
    .end local v1    # "$this$forEach$iv":Ljava/lang/Iterable;
    .end local v2    # "$i$f$forEach":I
    return-void
.end method

.method public onCharacteristicChanged(Landroid/bluetooth/BluetoothGatt;Landroid/bluetooth/BluetoothGattCharacteristic;[B)V
    .locals 7
    .param p1, "gatt"    # Landroid/bluetooth/BluetoothGatt;
    .param p2, "characteristic"    # Landroid/bluetooth/BluetoothGattCharacteristic;
    .param p3, "value"    # [B

    const-string v0, "gatt"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "characteristic"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "value"

    invoke-static {p3, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 278
    new-instance v0, Ljava/lang/String;

    sget-object v1, Lkotlin/text/Charsets;->UTF_8:Ljava/nio/charset/Charset;

    invoke-direct {v0, p3, v1}, Ljava/lang/String;-><init>([BLjava/nio/charset/Charset;)V

    .line 279
    .local v0, "data":Ljava/lang/String;
    iget-object v1, p0, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager$gattCallback$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;

    invoke-static {v1}, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;->access$getTAG$p(Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;)Ljava/lang/String;

    move-result-object v1

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, " gattCallback ---- onCharacteristicChanged: data = "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 280
    iget-object v1, p0, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager$gattCallback$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;

    invoke-static {v1}, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;->access$getMBleClientListeners$p(Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;)Ljava/util/List;

    move-result-object v1

    check-cast v1, Ljava/lang/Iterable;

    .local v1, "$this$forEach$iv":Ljava/lang/Iterable;
    const/4 v2, 0x0

    .line 342
    .local v2, "$i$f$forEach":I
    invoke-interface {v1}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :goto_0
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v4

    if-eqz v4, :cond_0

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v4

    .local v4, "element$iv":Ljava/lang/Object;
    move-object v5, v4

    check-cast v5, Lcom/rokid/glasses/transport/sdk/api/ble/client/callback/IBleClientListener;

    .local v5, "it":Lcom/rokid/glasses/transport/sdk/api/ble/client/callback/IBleClientListener;
    const/4 v6, 0x0

    .line 281
    .local v6, "$i$a$-forEach-BleClientManager$gattCallback$1$onCharacteristicChanged$1":I
    invoke-interface {v5, v0}, Lcom/rokid/glasses/transport/sdk/api/ble/client/callback/IBleClientListener;->onTextMessage(Ljava/lang/String;)V

    .line 282
    nop

    .line 342
    .end local v5    # "it":Lcom/rokid/glasses/transport/sdk/api/ble/client/callback/IBleClientListener;
    .end local v6    # "$i$a$-forEach-BleClientManager$gattCallback$1$onCharacteristicChanged$1":I
    nop

    .end local v4    # "element$iv":Ljava/lang/Object;
    goto :goto_0

    .line 343
    :cond_0
    nop

    .line 283
    .end local v1    # "$this$forEach$iv":Ljava/lang/Iterable;
    .end local v2    # "$i$f$forEach":I
    return-void
.end method

.method public onCharacteristicRead(Landroid/bluetooth/BluetoothGatt;Landroid/bluetooth/BluetoothGattCharacteristic;I)V
    .locals 2
    .param p1, "gatt"    # Landroid/bluetooth/BluetoothGatt;
    .param p2, "characteristic"    # Landroid/bluetooth/BluetoothGattCharacteristic;
    .param p3, "status"    # I

    .line 249
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager$gattCallback$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;

    invoke-static {v0}, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;->access$getTAG$p(Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;)Ljava/lang/String;

    move-result-object v0

    const-string v1, " gattCallback ----  onCharacteristicRead: "

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 253
    return-void
.end method

.method public onCharacteristicWrite(Landroid/bluetooth/BluetoothGatt;Landroid/bluetooth/BluetoothGattCharacteristic;I)V
    .locals 2
    .param p1, "gatt"    # Landroid/bluetooth/BluetoothGatt;
    .param p2, "characteristic"    # Landroid/bluetooth/BluetoothGattCharacteristic;
    .param p3, "status"    # I

    .line 263
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager$gattCallback$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;

    invoke-static {v0}, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;->access$getTAG$p(Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;)Ljava/lang/String;

    move-result-object v0

    const-string v1, " gattCallback ----  onCharacteristicWrite: "

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 268
    return-void
.end method

.method public onConnectionStateChange(Landroid/bluetooth/BluetoothGatt;II)V
    .locals 7
    .param p1, "gatt"    # Landroid/bluetooth/BluetoothGatt;
    .param p2, "status"    # I
    .param p3, "newState"    # I

    .line 204
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager$gattCallback$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;

    invoke-static {v0}, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;->access$getTAG$p(Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;)Ljava/lang/String;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "gattCallback ---- onConnectionStateChange newState = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 205
    packed-switch p3, :pswitch_data_0

    :pswitch_0
    goto :goto_1

    .line 206
    :pswitch_1
    if-eqz p1, :cond_1

    invoke-virtual {p1}, Landroid/bluetooth/BluetoothGatt;->discoverServices()Z

    goto :goto_1

    .line 209
    :pswitch_2
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager$gattCallback$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;

    invoke-static {v0}, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;->access$getTAG$p(Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "gattCallback ----  Disconnected from GATT server."

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 210
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager$gattCallback$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;

    const/4 v1, 0x0

    invoke-static {v0, v1}, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;->access$setConnected$p(Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;Z)V

    .line 211
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager$gattCallback$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;

    const/4 v2, 0x0

    invoke-static {v0, v2}, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;->access$setBluetoothGatt$p(Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;Landroid/bluetooth/BluetoothGatt;)V

    .line 212
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager$gattCallback$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;

    invoke-static {v0}, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;->access$getMBleClientListeners$p(Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;)Ljava/util/List;

    move-result-object v0

    check-cast v0, Ljava/lang/Iterable;

    .local v0, "$this$forEach$iv":Ljava/lang/Iterable;
    const/4 v2, 0x0

    .line 338
    .local v2, "$i$f$forEach":I
    invoke-interface {v0}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :goto_0
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v4

    if-eqz v4, :cond_0

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v4

    .local v4, "element$iv":Ljava/lang/Object;
    move-object v5, v4

    check-cast v5, Lcom/rokid/glasses/transport/sdk/api/ble/client/callback/IBleClientListener;

    .local v5, "it":Lcom/rokid/glasses/transport/sdk/api/ble/client/callback/IBleClientListener;
    const/4 v6, 0x0

    .line 213
    .local v6, "$i$a$-forEach-BleClientManager$gattCallback$1$onConnectionStateChange$1":I
    invoke-interface {v5, v1}, Lcom/rokid/glasses/transport/sdk/api/ble/client/callback/IBleClientListener;->onConnect(Z)V

    .line 214
    nop

    .line 338
    .end local v5    # "it":Lcom/rokid/glasses/transport/sdk/api/ble/client/callback/IBleClientListener;
    .end local v6    # "$i$a$-forEach-BleClientManager$gattCallback$1$onConnectionStateChange$1":I
    nop

    .end local v4    # "element$iv":Ljava/lang/Object;
    goto :goto_0

    .line 339
    :cond_0
    nop

    .line 216
    .end local v0    # "$this$forEach$iv":Ljava/lang/Iterable;
    .end local v2    # "$i$f$forEach":I
    :cond_1
    :goto_1
    return-void

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_2
        :pswitch_0
        :pswitch_1
    .end packed-switch
.end method

.method public onDescriptorRead(Landroid/bluetooth/BluetoothGatt;Landroid/bluetooth/BluetoothGattDescriptor;I[B)V
    .locals 1
    .param p1, "gatt"    # Landroid/bluetooth/BluetoothGatt;
    .param p2, "descriptor"    # Landroid/bluetooth/BluetoothGattDescriptor;
    .param p3, "status"    # I
    .param p4, "value"    # [B

    const-string v0, "gatt"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "descriptor"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "value"

    invoke-static {p4, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 321
    invoke-super {p0, p1, p2, p3, p4}, Landroid/bluetooth/BluetoothGattCallback;->onDescriptorRead(Landroid/bluetooth/BluetoothGatt;Landroid/bluetooth/BluetoothGattDescriptor;I[B)V

    .line 322
    return-void
.end method

.method public onDescriptorWrite(Landroid/bluetooth/BluetoothGatt;Landroid/bluetooth/BluetoothGattDescriptor;I)V
    .locals 3
    .param p1, "gatt"    # Landroid/bluetooth/BluetoothGatt;
    .param p2, "descriptor"    # Landroid/bluetooth/BluetoothGattDescriptor;
    .param p3, "status"    # I

    .line 333
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager$gattCallback$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;

    invoke-static {v0}, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;->access$getTAG$p(Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;)Ljava/lang/String;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, " gattCallback ----  onDescriptorWrite:  status = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 334
    return-void
.end method

.method public onMtuChanged(Landroid/bluetooth/BluetoothGatt;II)V
    .locals 3
    .param p1, "gatt"    # Landroid/bluetooth/BluetoothGatt;
    .param p2, "mtu"    # I
    .param p3, "status"    # I

    .line 309
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager$gattCallback$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;

    invoke-static {v0}, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;->access$getTAG$p(Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;)Ljava/lang/String;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, " gattCallback ---- MTU changed: mtu = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "  status = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 310
    return-void
.end method

.method public onServiceChanged(Landroid/bluetooth/BluetoothGatt;)V
    .locals 2
    .param p1, "gatt"    # Landroid/bluetooth/BluetoothGatt;

    const-string v0, "gatt"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 300
    invoke-super {p0, p1}, Landroid/bluetooth/BluetoothGattCallback;->onServiceChanged(Landroid/bluetooth/BluetoothGatt;)V

    .line 301
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager$gattCallback$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;

    invoke-static {v0}, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;->access$getTAG$p(Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;)Ljava/lang/String;

    move-result-object v0

    const-string v1, " gattCallback ---- onServiceChanged:"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 302
    return-void
.end method

.method public onServicesDiscovered(Landroid/bluetooth/BluetoothGatt;I)V
    .locals 9
    .param p1, "gatt"    # Landroid/bluetooth/BluetoothGatt;
    .param p2, "status"    # I

    .line 223
    if-nez p2, :cond_3

    .line 224
    const/4 v0, 0x0

    if-eqz p1, :cond_0

    iget-object v1, p0, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager$gattCallback$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;

    invoke-static {v1}, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;->access$getSERVICE_UUID$p(Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;)Ljava/util/UUID;

    move-result-object v1

    invoke-virtual {p1, v1}, Landroid/bluetooth/BluetoothGatt;->getService(Ljava/util/UUID;)Landroid/bluetooth/BluetoothGattService;

    move-result-object v1

    goto :goto_0

    :cond_0
    move-object v1, v0

    .line 225
    .local v1, "service":Landroid/bluetooth/BluetoothGattService;
    :goto_0
    if-eqz v1, :cond_1

    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager$gattCallback$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;

    invoke-static {v0}, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;->access$getCHARACTERISTIC_UUID$p(Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;)Ljava/util/UUID;

    move-result-object v0

    invoke-virtual {v1, v0}, Landroid/bluetooth/BluetoothGattService;->getCharacteristic(Ljava/util/UUID;)Landroid/bluetooth/BluetoothGattCharacteristic;

    move-result-object v0

    .line 226
    .local v0, "characteristic":Landroid/bluetooth/BluetoothGattCharacteristic;
    :cond_1
    if-eqz v0, :cond_3

    .line 227
    iget-object v2, p0, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager$gattCallback$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;

    invoke-static {v2}, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;->access$getTAG$p(Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;)Ljava/lang/String;

    move-result-object v2

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "gattCallback ---- onServicesDiscovered: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget-object v4, p0, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager$gattCallback$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;

    invoke-static {v4}, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;->access$getCHARACTERISTIC_UUID$p(Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;)Ljava/util/UUID;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 228
    iget-object v2, p0, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager$gattCallback$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;

    invoke-static {v2, p1, v0}, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;->access$openNotify(Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;Landroid/bluetooth/BluetoothGatt;Landroid/bluetooth/BluetoothGattCharacteristic;)V

    .line 229
    iget-object v2, p0, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager$gattCallback$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;

    const/4 v3, 0x1

    invoke-static {v2, v3}, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;->access$setConnected$p(Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;Z)V

    .line 230
    iget-object v2, p0, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager$gattCallback$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;

    invoke-static {v2}, Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;->access$getMBleClientListeners$p(Lcom/rokid/glasses/transport/sdk/server/ble/client/BleClientManager;)Ljava/util/List;

    move-result-object v2

    check-cast v2, Ljava/lang/Iterable;

    .local v2, "$this$forEach$iv":Ljava/lang/Iterable;
    const/4 v4, 0x0

    .line 340
    .local v4, "$i$f$forEach":I
    invoke-interface {v2}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v5

    :goto_1
    invoke-interface {v5}, Ljava/util/Iterator;->hasNext()Z

    move-result v6

    if-eqz v6, :cond_2

    invoke-interface {v5}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v6

    .local v6, "element$iv":Ljava/lang/Object;
    move-object v7, v6

    check-cast v7, Lcom/rokid/glasses/transport/sdk/api/ble/client/callback/IBleClientListener;

    .local v7, "it":Lcom/rokid/glasses/transport/sdk/api/ble/client/callback/IBleClientListener;
    const/4 v8, 0x0

    .line 231
    .local v8, "$i$a$-forEach-BleClientManager$gattCallback$1$onServicesDiscovered$1":I
    invoke-interface {v7, v3}, Lcom/rokid/glasses/transport/sdk/api/ble/client/callback/IBleClientListener;->onConnect(Z)V

    .line 232
    nop

    .line 340
    .end local v7    # "it":Lcom/rokid/glasses/transport/sdk/api/ble/client/callback/IBleClientListener;
    .end local v8    # "$i$a$-forEach-BleClientManager$gattCallback$1$onServicesDiscovered$1":I
    nop

    .end local v6    # "element$iv":Ljava/lang/Object;
    goto :goto_1

    .line 341
    :cond_2
    nop

    .line 233
    .end local v2    # "$this$forEach$iv":Ljava/lang/Iterable;
    .end local v4    # "$i$f$forEach":I
    if-eqz p1, :cond_3

    const/16 v2, 0x200

    invoke-virtual {p1, v2}, Landroid/bluetooth/BluetoothGatt;->requestMtu(I)Z

    .line 239
    .end local v0    # "characteristic":Landroid/bluetooth/BluetoothGattCharacteristic;
    .end local v1    # "service":Landroid/bluetooth/BluetoothGattService;
    :cond_3
    return-void
.end method
