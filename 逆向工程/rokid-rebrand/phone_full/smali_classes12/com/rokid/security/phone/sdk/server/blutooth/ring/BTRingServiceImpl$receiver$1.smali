.class public final Lcom/rokid/security/phone/sdk/server/blutooth/ring/BTRingServiceImpl$receiver$1;
.super Landroid/content/BroadcastReceiver;
.source "BTRingServiceImpl.kt"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/rokid/security/phone/sdk/server/blutooth/ring/BTRingServiceImpl;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = null
.end annotation

.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nBTRingServiceImpl.kt\nKotlin\n*S Kotlin\n*F\n+ 1 BTRingServiceImpl.kt\ncom/rokid/security/phone/sdk/server/blutooth/ring/BTRingServiceImpl$receiver$1\n+ 2 _Collections.kt\nkotlin/collections/CollectionsKt___CollectionsKt\n*L\n1#1,257:1\n1855#2,2:258\n*S KotlinDebug\n*F\n+ 1 BTRingServiceImpl.kt\ncom/rokid/security/phone/sdk/server/blutooth/ring/BTRingServiceImpl$receiver$1\n*L\n173#1:258,2\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u001d\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000*\u0001\u0000\u0008\n\u0018\u00002\u00020\u0001J\u0018\u0010\u0002\u001a\u00020\u00032\u0006\u0010\u0004\u001a\u00020\u00052\u0006\u0010\u0006\u001a\u00020\u0007H\u0016\u00a8\u0006\u0008"
    }
    d2 = {
        "com/rokid/security/phone/sdk/server/blutooth/ring/BTRingServiceImpl$receiver$1",
        "Landroid/content/BroadcastReceiver;",
        "onReceive",
        "",
        "context",
        "Landroid/content/Context;",
        "intent",
        "Landroid/content/Intent;",
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


# direct methods
.method constructor <init>()V
    .locals 0

    .line 161
    invoke-direct {p0}, Landroid/content/BroadcastReceiver;-><init>()V

    return-void
.end method


# virtual methods
.method public onReceive(Landroid/content/Context;Landroid/content/Intent;)V
    .locals 9
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "intent"    # Landroid/content/Intent;

    const-string v0, "context"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "intent"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 163
    invoke-virtual {p2}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_5

    invoke-virtual {v0}, Ljava/lang/String;->hashCode()I

    move-result v1

    const/4 v2, 0x0

    sparse-switch v1, :sswitch_data_0

    goto :goto_2

    :sswitch_0
    const-string v1, "android.bluetooth.device.action.FOUND"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_5

    .line 166
    const-string v0, "android.bluetooth.device.extra.DEVICE"

    invoke-virtual {p2, v0}, Landroid/content/Intent;->getParcelableExtra(Ljava/lang/String;)Landroid/os/Parcelable;

    move-result-object v0

    check-cast v0, Landroid/bluetooth/BluetoothDevice;

    .line 167
    .local v0, "device":Landroid/bluetooth/BluetoothDevice;
    if-eqz v0, :cond_3

    move-object v1, v0

    .local v1, "it":Landroid/bluetooth/BluetoothDevice;
    const/4 v3, 0x0

    .line 168
    .local v3, "$i$a$-takeIf-BTRingServiceImpl$receiver$1$onReceive$1":I
    invoke-virtual {v1}, Landroid/bluetooth/BluetoothDevice;->getName()Ljava/lang/String;

    move-result-object v4

    if-eqz v4, :cond_0

    sget-object v4, Lcom/rokid/security/phone/sdk/server/blutooth/ring/RingDeviceClassifier;->INSTANCE:Lcom/rokid/security/phone/sdk/server/blutooth/ring/RingDeviceClassifier;

    .line 169
    nop

    .line 170
    invoke-static {}, Lcom/rokid/security/phone/sdk/server/blutooth/ring/BTRingServiceImpl;->access$getTrustedDeviceNamePrefixes$p()Ljava/util/List;

    move-result-object v5

    .line 168
    invoke-virtual {v4, v1, v5}, Lcom/rokid/security/phone/sdk/server/blutooth/ring/RingDeviceClassifier;->isCandidate(Landroid/bluetooth/BluetoothDevice;Ljava/util/List;)Z

    move-result v4

    if-eqz v4, :cond_0

    const/4 v2, 0x1

    .line 167
    .end local v1    # "it":Landroid/bluetooth/BluetoothDevice;
    .end local v3    # "$i$a$-takeIf-BTRingServiceImpl$receiver$1$onReceive$1":I
    :cond_0
    if-eqz v2, :cond_1

    move-object v1, v0

    goto :goto_0

    :cond_1
    const/4 v1, 0x0

    .line 172
    :goto_0
    if-eqz v1, :cond_3

    .line 167
    nop

    .line 172
    nop

    .restart local v1    # "it":Landroid/bluetooth/BluetoothDevice;
    const/4 v2, 0x0

    .line 173
    .local v2, "$i$a$-let-BTRingServiceImpl$receiver$1$onReceive$2":I
    invoke-static {}, Lcom/rokid/security/phone/sdk/server/blutooth/ring/BTRingServiceImpl;->access$getMIBTRingClientListenerList$p()Ljava/util/List;

    move-result-object v3

    check-cast v3, Ljava/lang/Iterable;

    .local v3, "$this$forEach$iv":Ljava/lang/Iterable;
    const/4 v4, 0x0

    .line 258
    .local v4, "$i$f$forEach":I
    invoke-interface {v3}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v5

    :goto_1
    invoke-interface {v5}, Ljava/util/Iterator;->hasNext()Z

    move-result v6

    if-eqz v6, :cond_2

    invoke-interface {v5}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v6

    .local v6, "element$iv":Ljava/lang/Object;
    move-object v7, v6

    check-cast v7, Lcom/rokid/security/phone/sdk/api/bluetooth/ring/api/IBTRingClientListener;

    .local v7, "listener":Lcom/rokid/security/phone/sdk/api/bluetooth/ring/api/IBTRingClientListener;
    const/4 v8, 0x0

    .line 174
    .local v8, "$i$a$-forEach-BTRingServiceImpl$receiver$1$onReceive$2$1":I
    invoke-interface {v7, v1}, Lcom/rokid/security/phone/sdk/api/bluetooth/ring/api/IBTRingClientListener;->onDeviceFound(Landroid/bluetooth/BluetoothDevice;)V

    .line 175
    nop

    .line 258
    .end local v7    # "listener":Lcom/rokid/security/phone/sdk/api/bluetooth/ring/api/IBTRingClientListener;
    .end local v8    # "$i$a$-forEach-BTRingServiceImpl$receiver$1$onReceive$2$1":I
    nop

    .end local v6    # "element$iv":Ljava/lang/Object;
    goto :goto_1

    .line 259
    :cond_2
    nop

    .line 176
    .end local v3    # "$this$forEach$iv":Ljava/lang/Iterable;
    .end local v4    # "$i$f$forEach":I
    nop

    .line 172
    .end local v1    # "it":Landroid/bluetooth/BluetoothDevice;
    .end local v2    # "$i$a$-let-BTRingServiceImpl$receiver$1$onReceive$2":I
    goto :goto_2

    .line 167
    :cond_3
    nop

    .end local v0    # "device":Landroid/bluetooth/BluetoothDevice;
    goto :goto_2

    .line 163
    :sswitch_1
    const-string v1, "android.bluetooth.adapter.action.DISCOVERY_FINISHED"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_4

    goto :goto_2

    .line 179
    :cond_4
    sget-object v0, Lcom/rokid/security/phone/sdk/server/blutooth/ring/BTRingServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/blutooth/ring/BTRingServiceImpl;

    invoke-static {v0, v2}, Lcom/rokid/security/phone/sdk/server/blutooth/ring/BTRingServiceImpl;->access$finishScan(Lcom/rokid/security/phone/sdk/server/blutooth/ring/BTRingServiceImpl;Z)V

    .line 182
    :cond_5
    :goto_2
    return-void

    :sswitch_data_0
    .sparse-switch
        -0x6a269925 -> :sswitch_1
        0x459717c3 -> :sswitch_0
    .end sparse-switch
.end method
