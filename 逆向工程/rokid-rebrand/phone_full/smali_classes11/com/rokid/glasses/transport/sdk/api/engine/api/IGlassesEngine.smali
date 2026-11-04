.class public interface abstract Lcom/rokid/glasses/transport/sdk/api/engine/api/IGlassesEngine;
.super Ljava/lang/Object;
.source "IGlassesEngine.kt"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/rokid/glasses/transport/sdk/api/engine/api/IGlassesEngine$DefaultImpls;
    }
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000X\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0010\u000b\n\u0000\n\u0002\u0010\u000e\n\u0000\n\u0002\u0010\u0008\n\u0000\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0004\u0008f\u0018\u00002\u00020\u0001J\u0008\u0010\u0002\u001a\u00020\u0003H&J\n\u0010\u0004\u001a\u0004\u0018\u00010\u0005H&J\n\u0010\u0006\u001a\u0004\u0018\u00010\u0007H&J\n\u0010\u0008\u001a\u0004\u0018\u00010\tH&J\n\u0010\n\u001a\u0004\u0018\u00010\u000bH&J\n\u0010\u000c\u001a\u0004\u0018\u00010\rH&J\n\u0010\u000e\u001a\u0004\u0018\u00010\u000fH&JN\u0010\u0010\u001a\u00020\u00032\u0006\u0010\u0011\u001a\u00020\u00122\u0008\u0008\u0002\u0010\u0013\u001a\u00020\u00142\u0006\u0010\u0015\u001a\u00020\u00162\'\u0010\u0017\u001a#\u0012\u0019\u0012\u0017\u0012\u0004\u0012\u00020\u00120\u0019\u00a2\u0006\u000c\u0008\u001a\u0012\u0008\u0008\u001b\u0012\u0004\u0008\u0008(\u001c\u0012\u0004\u0012\u00020\u00030\u0018H&\u00f8\u0001\u0000J\u0008\u0010\u001d\u001a\u00020\u0012H&\u0082\u0002\u0004\n\u0002\u0008\u0019\u00a8\u0006\u001e"
    }
    d2 = {
        "Lcom/rokid/glasses/transport/sdk/api/engine/api/IGlassesEngine;",
        "",
        "destroy",
        "",
        "getAbsBleClientService",
        "Lcom/rokid/glasses/transport/sdk/api/ble/client/api/AbsBleClientService;",
        "getAbsBleService",
        "Lcom/rokid/glasses/transport/sdk/api/ble/server/api/AbsBleService;",
        "getAbsClassicBlueClientService",
        "Lcom/rokid/glasses/transport/sdk/api/bluetooth/client/api/AbsClassicBlueToothClientService;",
        "getAbsClassicBlueService",
        "Lcom/rokid/glasses/transport/sdk/api/bluetooth/server/api/AbsClassicBlueToothServer;",
        "getAbsWifiP2PClientService",
        "Lcom/rokid/glasses/transport/sdk/api/wifip2p/client/api/AbsWifiP2PClientService;",
        "getAbsWifiP2PGoService",
        "Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/api/AbsWifiP2PGoService;",
        "initSDK",
        "isGroupOwner",
        "",
        "ownerId",
        "",
        "port",
        "",
        "onResult",
        "Lkotlin/Function1;",
        "Lcom/rokid/glasses/transport/sdk/api/callback/IResult;",
        "Lkotlin/ParameterName;",
        "name",
        "result",
        "isInit",
        "sdk-api_release"
    }
    k = 0x1
    mv = {
        0x1,
        0x8,
        0x0
    }
    xi = 0x30
.end annotation


# virtual methods
.method public abstract destroy()V
.end method

.method public abstract getAbsBleClientService()Lcom/rokid/glasses/transport/sdk/api/ble/client/api/AbsBleClientService;
.end method

.method public abstract getAbsBleService()Lcom/rokid/glasses/transport/sdk/api/ble/server/api/AbsBleService;
.end method

.method public abstract getAbsClassicBlueClientService()Lcom/rokid/glasses/transport/sdk/api/bluetooth/client/api/AbsClassicBlueToothClientService;
.end method

.method public abstract getAbsClassicBlueService()Lcom/rokid/glasses/transport/sdk/api/bluetooth/server/api/AbsClassicBlueToothServer;
.end method

.method public abstract getAbsWifiP2PClientService()Lcom/rokid/glasses/transport/sdk/api/wifip2p/client/api/AbsWifiP2PClientService;
.end method

.method public abstract getAbsWifiP2PGoService()Lcom/rokid/glasses/transport/sdk/api/wifip2p/groupowner/api/AbsWifiP2PGoService;
.end method

.method public abstract initSDK(ZLjava/lang/String;ILkotlin/jvm/functions/Function1;)V
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(Z",
            "Ljava/lang/String;",
            "I",
            "Lkotlin/jvm/functions/Function1<",
            "-",
            "Lcom/rokid/glasses/transport/sdk/api/callback/IResult<",
            "Ljava/lang/Boolean;",
            ">;",
            "Lkotlin/Unit;",
            ">;)V"
        }
    .end annotation
.end method

.method public abstract isInit()Z
.end method
