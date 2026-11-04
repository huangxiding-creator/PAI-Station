.class public final Lcom/rokid/phone/ui/classicbt/repository/ClassicBtRepository$listener$1;
.super Ljava/lang/Object;
.source "ClassicBtRepository.kt"

# interfaces
.implements Lcom/rokid/security/phone/sdk/api/bluetooth/classic/listener/IClassicBTClientListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/phone/ui/classicbt/repository/ClassicBtRepository;-><init>()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = null
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000-\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0003\n\u0002\u0010\u000b\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0000\n\u0002\u0010\u0008\n\u0000*\u0001\u0000\u0008\n\u0018\u00002\u00020\u0001J\u0010\u0010\u0002\u001a\u00020\u00032\u0006\u0010\u0004\u001a\u00020\u0005H\u0016J\u0008\u0010\u0006\u001a\u00020\u0003H\u0016J\u0010\u0010\u0007\u001a\u00020\u00032\u0006\u0010\u0008\u001a\u00020\tH\u0016J\u0018\u0010\n\u001a\u00020\u00032\u0006\u0010\u000b\u001a\u00020\u000c2\u0006\u0010\r\u001a\u00020\u000eH\u0016\u00a8\u0006\u000f"
    }
    d2 = {
        "com/rokid/phone/ui/classicbt/repository/ClassicBtRepository$listener$1",
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


# instance fields
.field final synthetic this$0:Lcom/rokid/phone/ui/classicbt/repository/ClassicBtRepository;


# direct methods
.method constructor <init>(Lcom/rokid/phone/ui/classicbt/repository/ClassicBtRepository;)V
    .locals 0
    .param p1, "$receiver"    # Lcom/rokid/phone/ui/classicbt/repository/ClassicBtRepository;

    iput-object p1, p0, Lcom/rokid/phone/ui/classicbt/repository/ClassicBtRepository$listener$1;->this$0:Lcom/rokid/phone/ui/classicbt/repository/ClassicBtRepository;

    .line 18
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onConnect(Z)V
    .locals 0
    .param p1, "success"    # Z

    .line 31
    return-void
.end method

.method public onConnectionRejected(Ljava/lang/String;I)V
    .locals 1
    .param p1, "reason"    # Ljava/lang/String;
    .param p2, "code"    # I

    const-string v0, "reason"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 33
    return-void
.end method

.method public onDeviceFound(Landroid/bluetooth/BluetoothDevice;)V
    .locals 6
    .param p1, "device"    # Landroid/bluetooth/BluetoothDevice;

    const-string v0, "device"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 20
    invoke-virtual {p1}, Landroid/bluetooth/BluetoothDevice;->getName()Ljava/lang/String;

    move-result-object v0

    .line 21
    .local v0, "name":Ljava/lang/String;
    move-object v1, v0

    check-cast v1, Ljava/lang/CharSequence;

    const/4 v2, 0x0

    if-eqz v1, :cond_1

    invoke-static {v1}, Lkotlin/text/StringsKt;->isBlank(Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_0

    goto :goto_0

    :cond_0
    move v1, v2

    goto :goto_1

    :cond_1
    :goto_0
    const/4 v1, 0x1

    :goto_1
    if-nez v1, :cond_4

    move-object v1, v0

    check-cast v1, Ljava/lang/CharSequence;

    const-string v3, "Glass3"

    check-cast v3, Ljava/lang/CharSequence;

    const/4 v4, 0x0

    const/4 v5, 0x2

    invoke-static {v1, v3, v2, v5, v4}, Lkotlin/text/StringsKt;->contains$default(Ljava/lang/CharSequence;Ljava/lang/CharSequence;ZILjava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_2

    goto :goto_2

    .line 22
    :cond_2
    invoke-virtual {p1}, Landroid/bluetooth/BluetoothDevice;->getType()I

    move-result v1

    if-ne v1, v5, :cond_3

    return-void

    .line 23
    :cond_3
    iget-object v1, p0, Lcom/rokid/phone/ui/classicbt/repository/ClassicBtRepository$listener$1;->this$0:Lcom/rokid/phone/ui/classicbt/repository/ClassicBtRepository;

    invoke-static {v1}, Lcom/rokid/phone/ui/classicbt/repository/ClassicBtRepository;->access$getDevices$p(Lcom/rokid/phone/ui/classicbt/repository/ClassicBtRepository;)Ljava/util/LinkedHashMap;

    move-result-object v1

    check-cast v1, Ljava/util/Map;

    invoke-virtual {p1}, Landroid/bluetooth/BluetoothDevice;->getAddress()Ljava/lang/String;

    move-result-object v2

    new-instance v3, Lcom/rokid/phone/ui/classicbt/model/BluetoothDeviceInfo;

    invoke-virtual {p1}, Landroid/bluetooth/BluetoothDevice;->getAddress()Ljava/lang/String;

    move-result-object v4

    const-string v5, "getAddress(...)"

    invoke-static {v4, v5}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-virtual {p1}, Landroid/bluetooth/BluetoothDevice;->getType()I

    move-result v5

    invoke-direct {v3, v0, v4, v5}, Lcom/rokid/phone/ui/classicbt/model/BluetoothDeviceInfo;-><init>(Ljava/lang/String;Ljava/lang/String;I)V

    invoke-interface {v1, v2, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 24
    iget-object v1, p0, Lcom/rokid/phone/ui/classicbt/repository/ClassicBtRepository$listener$1;->this$0:Lcom/rokid/phone/ui/classicbt/repository/ClassicBtRepository;

    invoke-virtual {v1}, Lcom/rokid/phone/ui/classicbt/repository/ClassicBtRepository;->getEvents()Lkotlinx/coroutines/flow/MutableSharedFlow;

    move-result-object v1

    iget-object v2, p0, Lcom/rokid/phone/ui/classicbt/repository/ClassicBtRepository$listener$1;->this$0:Lcom/rokid/phone/ui/classicbt/repository/ClassicBtRepository;

    invoke-static {v2}, Lcom/rokid/phone/ui/classicbt/repository/ClassicBtRepository;->access$getDevices$p(Lcom/rokid/phone/ui/classicbt/repository/ClassicBtRepository;)Ljava/util/LinkedHashMap;

    move-result-object v2

    invoke-virtual {v2}, Ljava/util/LinkedHashMap;->values()Ljava/util/Collection;

    move-result-object v2

    const-string v3, "<get-values>(...)"

    invoke-static {v2, v3}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    check-cast v2, Ljava/lang/Iterable;

    invoke-static {v2}, Lkotlin/collections/CollectionsKt;->toList(Ljava/lang/Iterable;)Ljava/util/List;

    move-result-object v2

    invoke-interface {v1, v2}, Lkotlinx/coroutines/flow/MutableSharedFlow;->tryEmit(Ljava/lang/Object;)Z

    .line 25
    return-void

    .line 21
    :cond_4
    :goto_2
    return-void
.end method

.method public onScanFinished()V
    .locals 2

    .line 28
    iget-object v0, p0, Lcom/rokid/phone/ui/classicbt/repository/ClassicBtRepository$listener$1;->this$0:Lcom/rokid/phone/ui/classicbt/repository/ClassicBtRepository;

    invoke-virtual {v0}, Lcom/rokid/phone/ui/classicbt/repository/ClassicBtRepository;->getScanFinished()Lkotlinx/coroutines/flow/MutableSharedFlow;

    move-result-object v0

    sget-object v1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    invoke-interface {v0, v1}, Lkotlinx/coroutines/flow/MutableSharedFlow;->tryEmit(Ljava/lang/Object;)Z

    .line 29
    return-void
.end method
