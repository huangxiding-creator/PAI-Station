.class public final Lcom/rokid/phone/ui/classicbt/repository/ClassicBtRepository;
.super Ljava/lang/Object;
.source "ClassicBtRepository.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u00009\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0003\n\u0002\u0018\u0002\n\u0002\u0010\u000e\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0010 \n\u0002\u0008\u0003\n\u0002\u0010\u0002\n\u0002\u0008\u0002\n\u0002\u0008\u0007*\u0001\u0012\u0018\u00002\u00020\u0001B\u0007\u00a2\u0006\u0004\u0008\u0002\u0010\u0003J\u0006\u0010\u0014\u001a\u00020\u000fJ\u0006\u0010\u0015\u001a\u00020\u000fJ\u0006\u0010\u0016\u001a\u00020\u000fJ\u0006\u0010\u0017\u001a\u00020\u000fR*\u0010\u0004\u001a\u001e\u0012\u0004\u0012\u00020\u0006\u0012\u0004\u0012\u00020\u00070\u0005j\u000e\u0012\u0004\u0012\u00020\u0006\u0012\u0004\u0012\u00020\u0007`\u0008X\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u001d\u0010\t\u001a\u000e\u0012\n\u0012\u0008\u0012\u0004\u0012\u00020\u00070\u000b0\n\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\u000c\u0010\rR\u0017\u0010\u000e\u001a\u0008\u0012\u0004\u0012\u00020\u000f0\n\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\u0010\u0010\rR\u0010\u0010\u0011\u001a\u00020\u0012X\u0082\u0004\u00a2\u0006\u0004\n\u0002\u0010\u0013\u00a8\u0006\u0018"
    }
    d2 = {
        "Lcom/rokid/phone/ui/classicbt/repository/ClassicBtRepository;",
        "",
        "<init>",
        "()V",
        "devices",
        "Ljava/util/LinkedHashMap;",
        "",
        "Lcom/rokid/phone/ui/classicbt/model/BluetoothDeviceInfo;",
        "Lkotlin/collections/LinkedHashMap;",
        "events",
        "Lkotlinx/coroutines/flow/MutableSharedFlow;",
        "",
        "getEvents",
        "()Lkotlinx/coroutines/flow/MutableSharedFlow;",
        "scanFinished",
        "",
        "getScanFinished",
        "listener",
        "com/rokid/phone/ui/classicbt/repository/ClassicBtRepository$listener$1",
        "Lcom/rokid/phone/ui/classicbt/repository/ClassicBtRepository$listener$1;",
        "addListener",
        "removeListener",
        "startScan",
        "stopScan",
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
.field private final devices:Ljava/util/LinkedHashMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/LinkedHashMap<",
            "Ljava/lang/String;",
            "Lcom/rokid/phone/ui/classicbt/model/BluetoothDeviceInfo;",
            ">;"
        }
    .end annotation
.end field

.field private final events:Lkotlinx/coroutines/flow/MutableSharedFlow;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lkotlinx/coroutines/flow/MutableSharedFlow<",
            "Ljava/util/List<",
            "Lcom/rokid/phone/ui/classicbt/model/BluetoothDeviceInfo;",
            ">;>;"
        }
    .end annotation
.end field

.field private final listener:Lcom/rokid/phone/ui/classicbt/repository/ClassicBtRepository$listener$1;

.field private final scanFinished:Lkotlinx/coroutines/flow/MutableSharedFlow;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lkotlinx/coroutines/flow/MutableSharedFlow<",
            "Lkotlin/Unit;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method public constructor <init>()V
    .locals 4

    .line 12
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 13
    new-instance v0, Ljava/util/LinkedHashMap;

    invoke-direct {v0}, Ljava/util/LinkedHashMap;-><init>()V

    iput-object v0, p0, Lcom/rokid/phone/ui/classicbt/repository/ClassicBtRepository;->devices:Ljava/util/LinkedHashMap;

    .line 15
    const/4 v0, 0x0

    const/16 v1, 0x8

    const/4 v2, 0x0

    const/4 v3, 0x5

    invoke-static {v0, v1, v2, v3, v2}, Lkotlinx/coroutines/flow/SharedFlowKt;->MutableSharedFlow$default(IILkotlinx/coroutines/channels/BufferOverflow;ILjava/lang/Object;)Lkotlinx/coroutines/flow/MutableSharedFlow;

    move-result-object v1

    iput-object v1, p0, Lcom/rokid/phone/ui/classicbt/repository/ClassicBtRepository;->events:Lkotlinx/coroutines/flow/MutableSharedFlow;

    .line 16
    const/4 v1, 0x1

    invoke-static {v0, v1, v2, v3, v2}, Lkotlinx/coroutines/flow/SharedFlowKt;->MutableSharedFlow$default(IILkotlinx/coroutines/channels/BufferOverflow;ILjava/lang/Object;)Lkotlinx/coroutines/flow/MutableSharedFlow;

    move-result-object v0

    iput-object v0, p0, Lcom/rokid/phone/ui/classicbt/repository/ClassicBtRepository;->scanFinished:Lkotlinx/coroutines/flow/MutableSharedFlow;

    .line 18
    new-instance v0, Lcom/rokid/phone/ui/classicbt/repository/ClassicBtRepository$listener$1;

    invoke-direct {v0, p0}, Lcom/rokid/phone/ui/classicbt/repository/ClassicBtRepository$listener$1;-><init>(Lcom/rokid/phone/ui/classicbt/repository/ClassicBtRepository;)V

    iput-object v0, p0, Lcom/rokid/phone/ui/classicbt/repository/ClassicBtRepository;->listener:Lcom/rokid/phone/ui/classicbt/repository/ClassicBtRepository$listener$1;

    .line 12
    return-void
.end method

.method public static final synthetic access$getDevices$p(Lcom/rokid/phone/ui/classicbt/repository/ClassicBtRepository;)Ljava/util/LinkedHashMap;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/phone/ui/classicbt/repository/ClassicBtRepository;

    .line 12
    iget-object v0, p0, Lcom/rokid/phone/ui/classicbt/repository/ClassicBtRepository;->devices:Ljava/util/LinkedHashMap;

    return-object v0
.end method


# virtual methods
.method public final addListener()V
    .locals 2

    .line 37
    invoke-static {}, Lcom/rokid/security/phone/sdk/api/PSecuritySDK;->getClassicBlueToothClientService()Lcom/rokid/security/phone/sdk/api/bluetooth/classic/api/AbsClassicBluetoothClientService;

    move-result-object v0

    if-eqz v0, :cond_0

    iget-object v1, p0, Lcom/rokid/phone/ui/classicbt/repository/ClassicBtRepository;->listener:Lcom/rokid/phone/ui/classicbt/repository/ClassicBtRepository$listener$1;

    check-cast v1, Lcom/rokid/security/phone/sdk/api/bluetooth/classic/listener/IClassicBTClientListener;

    invoke-virtual {v0, v1}, Lcom/rokid/security/phone/sdk/api/bluetooth/classic/api/AbsClassicBluetoothClientService;->addClientListener(Lcom/rokid/security/phone/sdk/api/bluetooth/classic/listener/IClassicBTClientListener;)V

    .line 38
    :cond_0
    return-void
.end method

.method public final getEvents()Lkotlinx/coroutines/flow/MutableSharedFlow;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Lkotlinx/coroutines/flow/MutableSharedFlow<",
            "Ljava/util/List<",
            "Lcom/rokid/phone/ui/classicbt/model/BluetoothDeviceInfo;",
            ">;>;"
        }
    .end annotation

    .line 15
    iget-object v0, p0, Lcom/rokid/phone/ui/classicbt/repository/ClassicBtRepository;->events:Lkotlinx/coroutines/flow/MutableSharedFlow;

    return-object v0
.end method

.method public final getScanFinished()Lkotlinx/coroutines/flow/MutableSharedFlow;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Lkotlinx/coroutines/flow/MutableSharedFlow<",
            "Lkotlin/Unit;",
            ">;"
        }
    .end annotation

    .line 16
    iget-object v0, p0, Lcom/rokid/phone/ui/classicbt/repository/ClassicBtRepository;->scanFinished:Lkotlinx/coroutines/flow/MutableSharedFlow;

    return-object v0
.end method

.method public final removeListener()V
    .locals 2

    .line 41
    invoke-static {}, Lcom/rokid/security/phone/sdk/api/PSecuritySDK;->getClassicBlueToothClientService()Lcom/rokid/security/phone/sdk/api/bluetooth/classic/api/AbsClassicBluetoothClientService;

    move-result-object v0

    if-eqz v0, :cond_0

    iget-object v1, p0, Lcom/rokid/phone/ui/classicbt/repository/ClassicBtRepository;->listener:Lcom/rokid/phone/ui/classicbt/repository/ClassicBtRepository$listener$1;

    check-cast v1, Lcom/rokid/security/phone/sdk/api/bluetooth/classic/listener/IClassicBTClientListener;

    invoke-virtual {v0, v1}, Lcom/rokid/security/phone/sdk/api/bluetooth/classic/api/AbsClassicBluetoothClientService;->removeClientListener(Lcom/rokid/security/phone/sdk/api/bluetooth/classic/listener/IClassicBTClientListener;)V

    .line 42
    :cond_0
    return-void
.end method

.method public final startScan()V
    .locals 3

    .line 45
    iget-object v0, p0, Lcom/rokid/phone/ui/classicbt/repository/ClassicBtRepository;->devices:Ljava/util/LinkedHashMap;

    invoke-virtual {v0}, Ljava/util/LinkedHashMap;->clear()V

    .line 46
    invoke-static {}, Lcom/rokid/security/phone/sdk/api/PSecuritySDK;->getClassicBlueToothClientService()Lcom/rokid/security/phone/sdk/api/bluetooth/classic/api/AbsClassicBluetoothClientService;

    move-result-object v0

    if-eqz v0, :cond_0

    const-wide/16 v1, 0x2710

    invoke-virtual {v0, v1, v2}, Lcom/rokid/security/phone/sdk/api/bluetooth/classic/api/AbsClassicBluetoothClientService;->startScan(J)V

    .line 47
    :cond_0
    return-void
.end method

.method public final stopScan()V
    .locals 1

    .line 50
    invoke-static {}, Lcom/rokid/security/phone/sdk/api/PSecuritySDK;->getClassicBlueToothClientService()Lcom/rokid/security/phone/sdk/api/bluetooth/classic/api/AbsClassicBluetoothClientService;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/api/bluetooth/classic/api/AbsClassicBluetoothClientService;->stopScan()V

    .line 51
    :cond_0
    return-void
.end method
