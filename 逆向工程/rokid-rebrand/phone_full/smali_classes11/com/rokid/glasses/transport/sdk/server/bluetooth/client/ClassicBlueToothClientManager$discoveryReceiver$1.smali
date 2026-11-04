.class public final Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$discoveryReceiver$1;
.super Landroid/content/BroadcastReceiver;
.source "ClassicBlueToothClientManager.kt"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;-><init>()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = null
.end annotation

.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nClassicBlueToothClientManager.kt\nKotlin\n*S Kotlin\n*F\n+ 1 ClassicBlueToothClientManager.kt\ncom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$discoveryReceiver$1\n+ 2 _Collections.kt\nkotlin/collections/CollectionsKt___CollectionsKt\n*L\n1#1,1451:1\n1855#2,2:1452\n1855#2,2:1454\n*S KotlinDebug\n*F\n+ 1 ClassicBlueToothClientManager.kt\ncom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$discoveryReceiver$1\n*L\n124#1:1452,2\n139#1:1454,2\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u001d\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000*\u0001\u0000\u0008\n\u0018\u00002\u00020\u0001J\u0018\u0010\u0002\u001a\u00020\u00032\u0006\u0010\u0004\u001a\u00020\u00052\u0006\u0010\u0006\u001a\u00020\u0007H\u0016\u00a8\u0006\u0008"
    }
    d2 = {
        "com/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$discoveryReceiver$1",
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


# instance fields
.field final synthetic this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;


# direct methods
.method public static synthetic $r8$lambda$fNtCXweCLbJVh_5fmnnnPmGKv9k(Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;Landroid/bluetooth/BluetoothDevice;)V
    .locals 0

    invoke-static {p0, p1}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$discoveryReceiver$1;->onReceive$lambda$2$lambda$1(Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;Landroid/bluetooth/BluetoothDevice;)V

    return-void
.end method

.method public static synthetic $r8$lambda$kXEX0cQY3cw_AYEisC-rdstWto4(Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;)V
    .locals 0

    invoke-static {p0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$discoveryReceiver$1;->onReceive$lambda$4(Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;)V

    return-void
.end method

.method constructor <init>(Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;)V
    .locals 0
    .param p1, "$receiver"    # Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;

    iput-object p1, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$discoveryReceiver$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;

    .line 113
    invoke-direct {p0}, Landroid/content/BroadcastReceiver;-><init>()V

    return-void
.end method

.method private static final onReceive$lambda$2$lambda$1(Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;Landroid/bluetooth/BluetoothDevice;)V
    .locals 6
    .param p0, "this$0"    # Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;
    .param p1, "$it"    # Landroid/bluetooth/BluetoothDevice;

    const-string v0, "this$0"

    invoke-static {p0, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "$it"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 124
    invoke-static {p0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;->access$getMClientListeners$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;)Ljava/util/concurrent/CopyOnWriteArrayList;

    move-result-object v0

    check-cast v0, Ljava/lang/Iterable;

    .local v0, "$this$forEach$iv":Ljava/lang/Iterable;
    const/4 v1, 0x0

    .line 1452
    .local v1, "$i$f$forEach":I
    invoke-interface {v0}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_0

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    .local v3, "element$iv":Ljava/lang/Object;
    move-object v4, v3

    check-cast v4, Lcom/rokid/glasses/transport/sdk/api/bluetooth/client/callback/IClassicClientListener;

    .local v4, "listener":Lcom/rokid/glasses/transport/sdk/api/bluetooth/client/callback/IClassicClientListener;
    const/4 v5, 0x0

    .line 125
    .local v5, "$i$a$-forEach-ClassicBlueToothClientManager$discoveryReceiver$1$onReceive$1$1$1":I
    invoke-interface {v4, p1}, Lcom/rokid/glasses/transport/sdk/api/bluetooth/client/callback/IClassicClientListener;->onDeviceFound(Landroid/bluetooth/BluetoothDevice;)V

    .line 126
    nop

    .line 1452
    .end local v4    # "listener":Lcom/rokid/glasses/transport/sdk/api/bluetooth/client/callback/IClassicClientListener;
    .end local v5    # "$i$a$-forEach-ClassicBlueToothClientManager$discoveryReceiver$1$onReceive$1$1$1":I
    nop

    .end local v3    # "element$iv":Ljava/lang/Object;
    goto :goto_0

    .line 1453
    :cond_0
    nop

    .line 127
    .end local v0    # "$this$forEach$iv":Ljava/lang/Iterable;
    .end local v1    # "$i$f$forEach":I
    return-void
.end method

.method private static final onReceive$lambda$4(Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;)V
    .locals 6
    .param p0, "this$0"    # Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;

    const-string v0, "this$0"

    invoke-static {p0, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 139
    invoke-static {p0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;->access$getMClientListeners$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;)Ljava/util/concurrent/CopyOnWriteArrayList;

    move-result-object v0

    check-cast v0, Ljava/lang/Iterable;

    .local v0, "$this$forEach$iv":Ljava/lang/Iterable;
    const/4 v1, 0x0

    .line 1454
    .local v1, "$i$f$forEach":I
    invoke-interface {v0}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_0

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    .local v3, "element$iv":Ljava/lang/Object;
    move-object v4, v3

    check-cast v4, Lcom/rokid/glasses/transport/sdk/api/bluetooth/client/callback/IClassicClientListener;

    .local v4, "listener":Lcom/rokid/glasses/transport/sdk/api/bluetooth/client/callback/IClassicClientListener;
    const/4 v5, 0x0

    .line 140
    .local v5, "$i$a$-forEach-ClassicBlueToothClientManager$discoveryReceiver$1$onReceive$2$1":I
    invoke-interface {v4}, Lcom/rokid/glasses/transport/sdk/api/bluetooth/client/callback/IClassicClientListener;->onScanFinished()V

    .line 141
    nop

    .line 1454
    .end local v4    # "listener":Lcom/rokid/glasses/transport/sdk/api/bluetooth/client/callback/IClassicClientListener;
    .end local v5    # "$i$a$-forEach-ClassicBlueToothClientManager$discoveryReceiver$1$onReceive$2$1":I
    nop

    .end local v3    # "element$iv":Ljava/lang/Object;
    goto :goto_0

    .line 1455
    :cond_0
    nop

    .line 142
    .end local v0    # "$this$forEach$iv":Ljava/lang/Iterable;
    .end local v1    # "$i$f$forEach":I
    return-void
.end method


# virtual methods
.method public onReceive(Landroid/content/Context;Landroid/content/Intent;)V
    .locals 8
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "intent"    # Landroid/content/Intent;

    const-string v0, "context"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "intent"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 115
    invoke-virtual {p2}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_4

    invoke-virtual {v0}, Ljava/lang/String;->hashCode()I

    move-result v1

    const-string v2, "\u4e1a\u52a1\u65b9\u5904\u7406\u6d88\u606f\u903b\u8f91\u51fa\u73b0\u5f02\u5e38"

    sparse-switch v1, :sswitch_data_0

    goto/16 :goto_1

    :sswitch_0
    const-string v1, "android.bluetooth.device.action.FOUND"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_4

    .line 117
    const-string v0, "android.bluetooth.device.extra.DEVICE"

    invoke-virtual {p2, v0}, Landroid/content/Intent;->getParcelableExtra(Ljava/lang/String;)Landroid/os/Parcelable;

    move-result-object v0

    check-cast v0, Landroid/bluetooth/BluetoothDevice;

    .line 118
    .local v0, "device":Landroid/bluetooth/BluetoothDevice;
    if-eqz v0, :cond_2

    iget-object v1, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$discoveryReceiver$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;

    move-object v3, v0

    .local v3, "it":Landroid/bluetooth/BluetoothDevice;
    const/4 v4, 0x0

    .line 120
    .local v4, "$i$a$-let-ClassicBlueToothClientManager$discoveryReceiver$1$onReceive$1":I
    invoke-static {v1}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;->access$getFoundDevices$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;)Ljava/util/concurrent/CopyOnWriteArrayList;

    move-result-object v5

    invoke-virtual {v5, v3}, Ljava/util/concurrent/CopyOnWriteArrayList;->contains(Ljava/lang/Object;)Z

    move-result v5

    if-nez v5, :cond_1

    invoke-virtual {v3}, Landroid/bluetooth/BluetoothDevice;->getName()Ljava/lang/String;

    move-result-object v5

    const/4 v6, 0x0

    if-eqz v5, :cond_0

    const-string v7, "name"

    invoke-static {v5, v7}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    check-cast v5, Ljava/lang/CharSequence;

    invoke-static {v5}, Lkotlin/text/StringsKt;->isBlank(Ljava/lang/CharSequence;)Z

    move-result v5

    const/4 v7, 0x1

    xor-int/2addr v5, v7

    if-ne v5, v7, :cond_0

    move v6, v7

    :cond_0
    if-eqz v6, :cond_1

    .line 121
    invoke-static {v1}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;->access$getFoundDevices$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;)Ljava/util/concurrent/CopyOnWriteArrayList;

    move-result-object v5

    invoke-virtual {v5, v3}, Ljava/util/concurrent/CopyOnWriteArrayList;->add(Ljava/lang/Object;)Z

    .line 122
    nop

    .line 123
    :try_start_0
    invoke-static {v1}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;->access$getMainHandler$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;)Landroid/os/Handler;

    move-result-object v5

    new-instance v6, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$discoveryReceiver$1$$ExternalSyntheticLambda0;

    invoke-direct {v6, v1, v3}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$discoveryReceiver$1$$ExternalSyntheticLambda0;-><init>(Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;Landroid/bluetooth/BluetoothDevice;)V

    invoke-virtual {v5, v6}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 128
    :catch_0
    move-exception v5

    .line 129
    .local v5, "e":Ljava/lang/Exception;
    invoke-virtual {v5}, Ljava/lang/Exception;->printStackTrace()V

    .line 130
    invoke-static {v1}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;->access$getTAG$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;)Ljava/lang/String;

    move-result-object v1

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 134
    .end local v5    # "e":Ljava/lang/Exception;
    :cond_1
    :goto_0
    nop

    .line 118
    .end local v3    # "it":Landroid/bluetooth/BluetoothDevice;
    .end local v4    # "$i$a$-let-ClassicBlueToothClientManager$discoveryReceiver$1$onReceive$1":I
    goto :goto_1

    .end local v0    # "device":Landroid/bluetooth/BluetoothDevice;
    :cond_2
    goto :goto_1

    .line 115
    :sswitch_1
    const-string v1, "android.bluetooth.adapter.action.DISCOVERY_FINISHED"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_3

    goto :goto_1

    .line 137
    :cond_3
    nop

    .line 138
    :try_start_1
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$discoveryReceiver$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;

    invoke-static {v0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;->access$getMainHandler$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;)Landroid/os/Handler;

    move-result-object v0

    iget-object v1, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$discoveryReceiver$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;

    new-instance v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$discoveryReceiver$1$$ExternalSyntheticLambda1;

    invoke-direct {v3, v1}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$discoveryReceiver$1$$ExternalSyntheticLambda1;-><init>(Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;)V

    invoke-virtual {v0, v3}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_1

    goto :goto_1

    .line 143
    :catch_1
    move-exception v0

    .line 144
    .local v0, "e":Ljava/lang/Exception;
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    .line 145
    iget-object v1, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$discoveryReceiver$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;

    invoke-static {v1}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;->access$getTAG$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;)Ljava/lang/String;

    move-result-object v1

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 150
    .end local v0    # "e":Ljava/lang/Exception;
    :cond_4
    :goto_1
    return-void

    :sswitch_data_0
    .sparse-switch
        -0x6a269925 -> :sswitch_1
        0x459717c3 -> :sswitch_0
    .end sparse-switch
.end method
