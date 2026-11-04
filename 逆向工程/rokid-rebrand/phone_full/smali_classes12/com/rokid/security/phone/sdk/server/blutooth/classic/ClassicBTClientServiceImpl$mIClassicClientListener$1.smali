.class public final Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl$mIClassicClientListener$1;
.super Ljava/lang/Object;
.source "ClassicBTClientServiceImpl.kt"

# interfaces
.implements Lcom/rokid/glasses/transport/sdk/api/bluetooth/client/callback/IClassicClientListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = null
.end annotation

.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nClassicBTClientServiceImpl.kt\nKotlin\n*S Kotlin\n*F\n+ 1 ClassicBTClientServiceImpl.kt\ncom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl$mIClassicClientListener$1\n+ 2 _Collections.kt\nkotlin/collections/CollectionsKt___CollectionsKt\n*L\n1#1,410:1\n1855#2,2:411\n1855#2,2:413\n1855#2,2:415\n*S KotlinDebug\n*F\n+ 1 ClassicBTClientServiceImpl.kt\ncom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl$mIClassicClientListener$1\n*L\n286#1:411,2\n294#1:413,2\n306#1:415,2\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u00007\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0010\u0012\n\u0002\u0008\u0002\n\u0002\u0010\u000b\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0000\n\u0002\u0010\u0008\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0008*\u0001\u0000\u0008\n\u0018\u00002\u00020\u0001J\u0010\u0010\u0002\u001a\u00020\u00032\u0006\u0010\u0004\u001a\u00020\u0005H\u0016J\u0010\u0010\u0006\u001a\u00020\u00032\u0006\u0010\u0007\u001a\u00020\u0008H\u0016J\u0018\u0010\t\u001a\u00020\u00032\u0006\u0010\n\u001a\u00020\u000b2\u0006\u0010\u000c\u001a\u00020\rH\u0016J\u0010\u0010\u000e\u001a\u00020\u00032\u0006\u0010\u000f\u001a\u00020\u0010H\u0016J\u0010\u0010\u0011\u001a\u00020\u00032\u0006\u0010\u0004\u001a\u00020\u0005H\u0016J\u0010\u0010\u0012\u001a\u00020\u00032\u0006\u0010\u0013\u001a\u00020\u000bH\u0016J\u0008\u0010\u0014\u001a\u00020\u0003H\u0016J \u0010\u0015\u001a\u00020\u00032\u0006\u0010\u0016\u001a\u00020\u000b2\u0006\u0010\u0004\u001a\u00020\u00052\u0006\u0010\u0017\u001a\u00020\u000bH\u0016\u00a8\u0006\u0018"
    }
    d2 = {
        "com/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl$mIClassicClientListener$1",
        "Lcom/rokid/glasses/transport/sdk/api/bluetooth/client/callback/IClassicClientListener;",
        "onAudioReceived",
        "",
        "data",
        "",
        "onConnect",
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
        "onFileReceived",
        "onMessageReceived",
        "message",
        "onScanFinished",
        "onStreamReceived",
        "tag",
        "clientId",
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

    .line 268
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onAudioReceived([B)V
    .locals 1
    .param p1, "data"    # [B

    const-string v0, "data"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 270
    invoke-static {}, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->access$getMIClassicBTMessageListener$p()Lcom/rokid/security/phone/sdk/api/bluetooth/classic/listener/IClassicBTMessageListener;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-interface {v0, p1}, Lcom/rokid/security/phone/sdk/api/bluetooth/classic/listener/IClassicBTMessageListener;->onClassicBTAudioStream([B)V

    .line 272
    :cond_0
    return-void
.end method

.method public onConnect(Z)V
    .locals 6
    .param p1, "success"    # Z

    .line 279
    if-eqz p1, :cond_0

    .line 280
    sget-object v0, Lcom/rokid/security/phone/sdk/server/transport/CompanionOwnershipClient;->INSTANCE:Lcom/rokid/security/phone/sdk/server/transport/CompanionOwnershipClient;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/transport/CompanionOwnershipClient;->onTransportSessionStarted()V

    goto :goto_0

    .line 282
    :cond_0
    sget-object v0, Lcom/rokid/security/phone/sdk/server/transport/CompanionOwnershipClient;->INSTANCE:Lcom/rokid/security/phone/sdk/server/transport/CompanionOwnershipClient;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/transport/CompanionOwnershipClient;->onTransportDisconnected()V

    .line 284
    :goto_0
    sget-object v0, Lcom/rokid/security/phone/sdk/server/common/CommonLogicManager;->INSTANCE:Lcom/rokid/security/phone/sdk/server/common/CommonLogicManager;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/common/CommonLogicManager;->syncSystemTime()V

    .line 285
    if-nez p1, :cond_2

    .line 286
    invoke-static {}, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->access$getMIClassicBTClientListeners$p()Ljava/util/Set;

    move-result-object v0

    check-cast v0, Ljava/lang/Iterable;

    .local v0, "$this$forEach$iv":Ljava/lang/Iterable;
    const/4 v1, 0x0

    .line 411
    .local v1, "$i$f$forEach":I
    invoke-interface {v0}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_1
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_1

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    .local v3, "element$iv":Ljava/lang/Object;
    move-object v4, v3

    check-cast v4, Lcom/rokid/security/phone/sdk/api/bluetooth/classic/listener/IClassicBTClientListener;

    .local v4, "it":Lcom/rokid/security/phone/sdk/api/bluetooth/classic/listener/IClassicBTClientListener;
    const/4 v5, 0x0

    .line 287
    .local v5, "$i$a$-forEach-ClassicBTClientServiceImpl$mIClassicClientListener$1$onConnect$1":I
    invoke-interface {v4, p1}, Lcom/rokid/security/phone/sdk/api/bluetooth/classic/listener/IClassicBTClientListener;->onConnect(Z)V

    .line 288
    nop

    .line 411
    .end local v4    # "it":Lcom/rokid/security/phone/sdk/api/bluetooth/classic/listener/IClassicBTClientListener;
    .end local v5    # "$i$a$-forEach-ClassicBTClientServiceImpl$mIClassicClientListener$1$onConnect$1":I
    nop

    .end local v3    # "element$iv":Ljava/lang/Object;
    goto :goto_1

    .line 412
    :cond_1
    nop

    .line 292
    .end local v0    # "$this$forEach$iv":Ljava/lang/Iterable;
    .end local v1    # "$i$f$forEach":I
    :cond_2
    sget-object v0, Lcom/rokid/security/phone/sdk/server/utils/ProtocolVersionUtils;->INSTANCE:Lcom/rokid/security/phone/sdk/server/utils/ProtocolVersionUtils;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/utils/ProtocolVersionUtils;->isGlassLowVersion3()Z

    move-result v0

    if-eqz v0, :cond_4

    .line 293
    invoke-static {}, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->access$getTAG$p()Ljava/lang/String;

    move-result-object v0

    const-string/jumbo v1, "\u517c\u5bb9\u65e7\u7248\u672c"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 294
    invoke-static {}, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->access$getMIClassicBTClientListeners$p()Ljava/util/Set;

    move-result-object v0

    check-cast v0, Ljava/lang/Iterable;

    .restart local v0    # "$this$forEach$iv":Ljava/lang/Iterable;
    const/4 v1, 0x0

    .line 413
    .restart local v1    # "$i$f$forEach":I
    invoke-interface {v0}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_2
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_3

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    .restart local v3    # "element$iv":Ljava/lang/Object;
    move-object v4, v3

    check-cast v4, Lcom/rokid/security/phone/sdk/api/bluetooth/classic/listener/IClassicBTClientListener;

    .restart local v4    # "it":Lcom/rokid/security/phone/sdk/api/bluetooth/classic/listener/IClassicBTClientListener;
    const/4 v5, 0x0

    .line 295
    .local v5, "$i$a$-forEach-ClassicBTClientServiceImpl$mIClassicClientListener$1$onConnect$2":I
    invoke-interface {v4, p1}, Lcom/rokid/security/phone/sdk/api/bluetooth/classic/listener/IClassicBTClientListener;->onConnect(Z)V

    .line 296
    nop

    .line 413
    .end local v4    # "it":Lcom/rokid/security/phone/sdk/api/bluetooth/classic/listener/IClassicBTClientListener;
    .end local v5    # "$i$a$-forEach-ClassicBTClientServiceImpl$mIClassicClientListener$1$onConnect$2":I
    nop

    .end local v3    # "element$iv":Ljava/lang/Object;
    goto :goto_2

    .line 414
    :cond_3
    nop

    .line 297
    .end local v0    # "$this$forEach$iv":Ljava/lang/Iterable;
    .end local v1    # "$i$f$forEach":I
    if-eqz p1, :cond_4

    .line 298
    sget-object v0, Lcom/rokid/security/phone/sdk/server/common/CommonLogicManager;->INSTANCE:Lcom/rokid/security/phone/sdk/server/common/CommonLogicManager;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/common/CommonLogicManager;->sendUserInfo()V

    .line 299
    sget-object v0, Lcom/rokid/security/phone/sdk/server/common/CommonLogicManager;->INSTANCE:Lcom/rokid/security/phone/sdk/server/common/CommonLogicManager;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/common/CommonLogicManager;->sendAppInfo()V

    .line 302
    :cond_4
    return-void
.end method

.method public onConnectionRejected(Ljava/lang/String;I)V
    .locals 6
    .param p1, "reason"    # Ljava/lang/String;
    .param p2, "code"    # I

    const-string v0, "reason"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 305
    sget-object v0, Lcom/rokid/security/phone/sdk/server/transport/CompanionOwnershipClient;->INSTANCE:Lcom/rokid/security/phone/sdk/server/transport/CompanionOwnershipClient;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/transport/CompanionOwnershipClient;->onTransportDisconnected()V

    .line 306
    invoke-static {}, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->access$getMIClassicBTClientListeners$p()Ljava/util/Set;

    move-result-object v0

    check-cast v0, Ljava/lang/Iterable;

    .local v0, "$this$forEach$iv":Ljava/lang/Iterable;
    const/4 v1, 0x0

    .line 415
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

    check-cast v4, Lcom/rokid/security/phone/sdk/api/bluetooth/classic/listener/IClassicBTClientListener;

    .local v4, "it":Lcom/rokid/security/phone/sdk/api/bluetooth/classic/listener/IClassicBTClientListener;
    const/4 v5, 0x0

    .line 307
    .local v5, "$i$a$-forEach-ClassicBTClientServiceImpl$mIClassicClientListener$1$onConnectionRejected$1":I
    invoke-interface {v4, p1, p2}, Lcom/rokid/security/phone/sdk/api/bluetooth/classic/listener/IClassicBTClientListener;->onConnectionRejected(Ljava/lang/String;I)V

    .line 308
    nop

    .line 415
    .end local v4    # "it":Lcom/rokid/security/phone/sdk/api/bluetooth/classic/listener/IClassicBTClientListener;
    .end local v5    # "$i$a$-forEach-ClassicBTClientServiceImpl$mIClassicClientListener$1$onConnectionRejected$1":I
    nop

    .end local v3    # "element$iv":Ljava/lang/Object;
    goto :goto_0

    .line 416
    :cond_0
    nop

    .line 309
    .end local v0    # "$this$forEach$iv":Ljava/lang/Iterable;
    .end local v1    # "$i$f$forEach":I
    return-void
.end method

.method public onDeviceFound(Landroid/bluetooth/BluetoothDevice;)V
    .locals 1
    .param p1, "device"    # Landroid/bluetooth/BluetoothDevice;

    const-string v0, "device"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 314
    return-void
.end method

.method public onFileReceived([B)V
    .locals 1
    .param p1, "data"    # [B

    const-string v0, "data"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 318
    return-void
.end method

.method public onMessageReceived(Ljava/lang/String;)V
    .locals 1
    .param p1, "message"    # Ljava/lang/String;

    const-string v0, "message"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 275
    invoke-static {}, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->access$getMIClassicBTMessageListener$p()Lcom/rokid/security/phone/sdk/api/bluetooth/classic/listener/IClassicBTMessageListener;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-interface {v0, p1}, Lcom/rokid/security/phone/sdk/api/bluetooth/classic/listener/IClassicBTMessageListener;->onClassicBTTextMessage(Ljava/lang/String;)V

    .line 276
    :cond_0
    return-void
.end method

.method public onScanFinished()V
    .locals 1

    .line 322
    sget-object v0, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;

    invoke-static {v0}, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->access$completeScan(Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;)V

    .line 323
    return-void
.end method

.method public onStreamReceived(Ljava/lang/String;[BLjava/lang/String;)V
    .locals 1
    .param p1, "tag"    # Ljava/lang/String;
    .param p2, "data"    # [B
    .param p3, "clientId"    # Ljava/lang/String;

    const-string/jumbo v0, "tag"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "data"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "clientId"

    invoke-static {p3, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 326
    invoke-static {}, Lcom/rokid/security/phone/sdk/server/blutooth/classic/ClassicBTClientServiceImpl;->access$getMIClassicBTMessageListener$p()Lcom/rokid/security/phone/sdk/api/bluetooth/classic/listener/IClassicBTMessageListener;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-interface {v0, p1, p2, p3}, Lcom/rokid/security/phone/sdk/api/bluetooth/classic/listener/IClassicBTMessageListener;->onBTStreamDataReceived(Ljava/lang/String;[BLjava/lang/String;)V

    .line 327
    :cond_0
    return-void
.end method
