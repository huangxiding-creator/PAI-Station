.class public final Lcom/rokid/security/phone/sdk/server/coreability/bluetooth/ClassicBTClientWrapper;
.super Ljava/lang/Object;
.source "ClassicBTClientWrapper.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000b\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u000b\n\u0002\u0008\u0004\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0004\n\u0002\u0018\u0002\n\u0002\u0008\u0008\n\u0002\u0010\u0012\n\u0002\u0008\u0003\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0007\n\u0002\u0010\t\n\u0002\u0008\u0003\u0008\u00c6\u0002\u0018\u00002\u00020\u0001B\u0007\u0008\u0002\u00a2\u0006\u0002\u0010\u0002J\u000e\u0010\u0005\u001a\u00020\u00062\u0006\u0010\u0007\u001a\u00020\u0008J\u000e\u0010\t\u001a\u00020\u00062\u0006\u0010\u0007\u001a\u00020\nJ\u0016\u0010\u000b\u001a\u00020\u000c2\u0006\u0010\r\u001a\u00020\u00082\u0006\u0010\u000e\u001a\u00020\nJ1\u0010\u000f\u001a\u00020\u000c2\u0006\u0010\u0010\u001a\u00020\u00112!\u0010\u0012\u001a\u001d\u0012\u0013\u0012\u00110\u000c\u00a2\u0006\u000c\u0008\u0014\u0012\u0008\u0008\u0015\u0012\u0004\u0008\u0008(\u0016\u0012\u0004\u0012\u00020\u00060\u0013J\u0006\u0010\u0017\u001a\u00020\u0006J\n\u0010\u0018\u001a\u0004\u0018\u00010\u0019H\u0002J\u0006\u0010\u001a\u001a\u00020\u000cJ\u0006\u0010\u001b\u001a\u00020\u000cJ\u0006\u0010\u001c\u001a\u00020\u000cJ\u0006\u0010\u001d\u001a\u00020\u000cJ\u0006\u0010\u001e\u001a\u00020\u000cJ\u000e\u0010\u001f\u001a\u00020\u00062\u0006\u0010\u0007\u001a\u00020\u0008J\u000e\u0010 \u001a\u00020\u00062\u0006\u0010!\u001a\u00020\"J \u0010#\u001a\u00020\u00062\u0008\u0010$\u001a\u0004\u0018\u00010\u00042\u0006\u0010%\u001a\u00020&2\u0006\u0010\u0007\u001a\u00020\'J\u000e\u0010(\u001a\u00020\u00062\u0006\u0010)\u001a\u00020\u0004J\u000e\u0010*\u001a\u00020\u00062\u0006\u0010)\u001a\u00020\u0004J\u000e\u0010+\u001a\u00020\u00062\u0006\u0010,\u001a\u00020\u0004J\u000e\u0010-\u001a\u00020\u00062\u0006\u0010.\u001a\u00020/J\u0006\u00100\u001a\u00020\u0006J\u0006\u00101\u001a\u00020\u0006R\u000e\u0010\u0003\u001a\u00020\u0004X\u0082T\u00a2\u0006\u0002\n\u0000\u00a8\u00062"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/server/coreability/bluetooth/ClassicBTClientWrapper;",
        "",
        "()V",
        "TAG",
        "",
        "addClientListener",
        "",
        "listener",
        "Lcom/rokid/glasses/transport/sdk/api/bluetooth/client/callback/IClassicClientListener;",
        "addFileReceiveListener",
        "Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileReceiveListener;",
        "attachListeners",
        "",
        "clientListener",
        "fileReceiveListener",
        "connectToServer",
        "device",
        "Landroid/bluetooth/BluetoothDevice;",
        "action",
        "Lkotlin/Function1;",
        "Lkotlin/ParameterName;",
        "name",
        "isConnect",
        "disconnect",
        "getService",
        "Lcom/rokid/glasses/transport/sdk/api/bluetooth/client/api/AbsClassicBlueToothClientService;",
        "isAudioChanelConnect",
        "isConnected",
        "isFileChanelConnect",
        "isMessageChanelConnect",
        "isStreamChanelConnect",
        "removeClientListener",
        "sendAudioData",
        "audio",
        "",
        "sendFileData",
        "dir",
        "file",
        "Ljava/io/File;",
        "Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileSendListener;",
        "sendTextMessage",
        "data",
        "sendTextMessageV2",
        "setSaveFileDirectory",
        "saveDirectory",
        "startScan",
        "timeoutMillis",
        "",
        "stopFileSend",
        "stopScan",
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


# static fields
.field public static final INSTANCE:Lcom/rokid/security/phone/sdk/server/coreability/bluetooth/ClassicBTClientWrapper;

.field private static final TAG:Ljava/lang/String; = "ClassicBTClientWrapper"


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lcom/rokid/security/phone/sdk/server/coreability/bluetooth/ClassicBTClientWrapper;

    invoke-direct {v0}, Lcom/rokid/security/phone/sdk/server/coreability/bluetooth/ClassicBTClientWrapper;-><init>()V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/coreability/bluetooth/ClassicBTClientWrapper;->INSTANCE:Lcom/rokid/security/phone/sdk/server/coreability/bluetooth/ClassicBTClientWrapper;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 17
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private final getService()Lcom/rokid/glasses/transport/sdk/api/bluetooth/client/api/AbsClassicBlueToothClientService;
    .locals 5

    .line 27
    :try_start_0
    sget-object v0, Lkotlin/Result;->Companion:Lkotlin/Result$Companion;

    move-object v0, p0

    check-cast v0, Lcom/rokid/security/phone/sdk/server/coreability/bluetooth/ClassicBTClientWrapper;

    .local v0, "$this$getService_u24lambda_u240":Lcom/rokid/security/phone/sdk/server/coreability/bluetooth/ClassicBTClientWrapper;
    const/4 v1, 0x0

    .line 28
    .local v1, "$i$a$-runCatching-ClassicBTClientWrapper$getService$1":I
    invoke-static {}, Lcom/rokid/glasses/transport/sdk/api/TransportSDK;->getGlassesEngineService()Lcom/rokid/glasses/transport/sdk/api/engine/api/AbsGlassesEngineService;

    move-result-object v2

    invoke-virtual {v2}, Lcom/rokid/glasses/transport/sdk/api/engine/api/AbsGlassesEngineService;->getAbsClassicBlueClientService()Lcom/rokid/glasses/transport/sdk/api/bluetooth/client/api/AbsClassicBlueToothClientService;

    move-result-object v2

    .line 27
    .end local v0    # "$this$getService_u24lambda_u240":Lcom/rokid/security/phone/sdk/server/coreability/bluetooth/ClassicBTClientWrapper;
    .end local v1    # "$i$a$-runCatching-ClassicBTClientWrapper$getService$1":I
    invoke-static {v2}, Lkotlin/Result;->constructor-impl(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    :catchall_0
    move-exception v0

    sget-object v1, Lkotlin/Result;->Companion:Lkotlin/Result$Companion;

    invoke-static {v0}, Lkotlin/ResultKt;->createFailure(Ljava/lang/Throwable;)Ljava/lang/Object;

    move-result-object v0

    invoke-static {v0}, Lkotlin/Result;->constructor-impl(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    .line 29
    :goto_0
    invoke-static {v0}, Lkotlin/Result;->exceptionOrNull-impl(Ljava/lang/Object;)Ljava/lang/Throwable;

    move-result-object v1

    if-eqz v1, :cond_0

    .local v1, "it":Ljava/lang/Throwable;
    const/4 v2, 0x0

    .line 30
    .local v2, "$i$a$-onFailure-ClassicBTClientWrapper$getService$2":I
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "classic bluetooth transport unavailable type="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    filled-new-array {v3}, [Ljava/lang/Object;

    move-result-object v3

    const-string v4, "ClassicBTClientWrapper"

    invoke-static {v4, v3}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->w(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 31
    nop

    .line 29
    .end local v1    # "it":Ljava/lang/Throwable;
    .end local v2    # "$i$a$-onFailure-ClassicBTClientWrapper$getService$2":I
    nop

    .line 31
    :cond_0
    invoke-static {v0}, Lkotlin/Result;->isFailure-impl(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_1

    const/4 v0, 0x0

    :cond_1
    check-cast v0, Lcom/rokid/glasses/transport/sdk/api/bluetooth/client/api/AbsClassicBlueToothClientService;

    return-object v0
.end method


# virtual methods
.method public final addClientListener(Lcom/rokid/glasses/transport/sdk/api/bluetooth/client/callback/IClassicClientListener;)V
    .locals 1
    .param p1, "listener"    # Lcom/rokid/glasses/transport/sdk/api/bluetooth/client/callback/IClassicClientListener;

    const-string v0, "listener"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 94
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/coreability/bluetooth/ClassicBTClientWrapper;->getService()Lcom/rokid/glasses/transport/sdk/api/bluetooth/client/api/AbsClassicBlueToothClientService;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-virtual {v0, p1}, Lcom/rokid/glasses/transport/sdk/api/bluetooth/client/api/AbsClassicBlueToothClientService;->addClientListener(Lcom/rokid/glasses/transport/sdk/api/bluetooth/client/callback/IClassicClientListener;)V

    .line 95
    :cond_0
    return-void
.end method

.method public final addFileReceiveListener(Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileReceiveListener;)V
    .locals 1
    .param p1, "listener"    # Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileReceiveListener;

    const-string v0, "listener"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 59
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/coreability/bluetooth/ClassicBTClientWrapper;->getService()Lcom/rokid/glasses/transport/sdk/api/bluetooth/client/api/AbsClassicBlueToothClientService;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-virtual {v0, p1}, Lcom/rokid/glasses/transport/sdk/api/bluetooth/client/api/AbsClassicBlueToothClientService;->addFileReceiveListener(Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileReceiveListener;)V

    .line 60
    :cond_0
    return-void
.end method

.method public final attachListeners(Lcom/rokid/glasses/transport/sdk/api/bluetooth/client/callback/IClassicClientListener;Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileReceiveListener;)Z
    .locals 2
    .param p1, "clientListener"    # Lcom/rokid/glasses/transport/sdk/api/bluetooth/client/callback/IClassicClientListener;
    .param p2, "fileReceiveListener"    # Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileReceiveListener;

    const-string v0, "clientListener"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "fileReceiveListener"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 37
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/coreability/bluetooth/ClassicBTClientWrapper;->getService()Lcom/rokid/glasses/transport/sdk/api/bluetooth/client/api/AbsClassicBlueToothClientService;

    move-result-object v0

    if-nez v0, :cond_0

    const/4 v0, 0x0

    return v0

    .line 38
    .local v0, "service":Lcom/rokid/glasses/transport/sdk/api/bluetooth/client/api/AbsClassicBlueToothClientService;
    :cond_0
    invoke-virtual {v0, p1}, Lcom/rokid/glasses/transport/sdk/api/bluetooth/client/api/AbsClassicBlueToothClientService;->addClientListener(Lcom/rokid/glasses/transport/sdk/api/bluetooth/client/callback/IClassicClientListener;)V

    .line 39
    invoke-virtual {v0, p2}, Lcom/rokid/glasses/transport/sdk/api/bluetooth/client/api/AbsClassicBlueToothClientService;->addFileReceiveListener(Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileReceiveListener;)V

    .line 40
    const/4 v1, 0x1

    return v1
.end method

.method public final connectToServer(Landroid/bluetooth/BluetoothDevice;Lkotlin/jvm/functions/Function1;)Z
    .locals 2
    .param p1, "device"    # Landroid/bluetooth/BluetoothDevice;
    .param p2, "action"    # Lkotlin/jvm/functions/Function1;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/bluetooth/BluetoothDevice;",
            "Lkotlin/jvm/functions/Function1<",
            "-",
            "Ljava/lang/Boolean;",
            "Lkotlin/Unit;",
            ">;)Z"
        }
    .end annotation

    const-string v0, "device"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "action"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 52
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/coreability/bluetooth/ClassicBTClientWrapper;->getService()Lcom/rokid/glasses/transport/sdk/api/bluetooth/client/api/AbsClassicBlueToothClientService;

    move-result-object v0

    if-nez v0, :cond_0

    const/4 v0, 0x0

    return v0

    .line 53
    .local v0, "service":Lcom/rokid/glasses/transport/sdk/api/bluetooth/client/api/AbsClassicBlueToothClientService;
    :cond_0
    invoke-virtual {v0, p1, p2}, Lcom/rokid/glasses/transport/sdk/api/bluetooth/client/api/AbsClassicBlueToothClientService;->connectToServer(Landroid/bluetooth/BluetoothDevice;Lkotlin/jvm/functions/Function1;)V

    .line 54
    const/4 v1, 0x1

    return v1
.end method

.method public final disconnect()V
    .locals 1

    .line 63
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/coreability/bluetooth/ClassicBTClientWrapper;->getService()Lcom/rokid/glasses/transport/sdk/api/bluetooth/client/api/AbsClassicBlueToothClientService;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Lcom/rokid/glasses/transport/sdk/api/bluetooth/client/api/AbsClassicBlueToothClientService;->disconnect()V

    .line 64
    :cond_0
    return-void
.end method

.method public final isAudioChanelConnect()Z
    .locals 1

    .line 110
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/coreability/bluetooth/ClassicBTClientWrapper;->getService()Lcom/rokid/glasses/transport/sdk/api/bluetooth/client/api/AbsClassicBlueToothClientService;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Lcom/rokid/glasses/transport/sdk/api/bluetooth/client/api/AbsClassicBlueToothClientService;->isAudioChanelConnect()Z

    move-result v0

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method public final isConnected()Z
    .locals 3

    .line 102
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/coreability/bluetooth/ClassicBTClientWrapper;->getService()Lcom/rokid/glasses/transport/sdk/api/bluetooth/client/api/AbsClassicBlueToothClientService;

    move-result-object v0

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Lcom/rokid/glasses/transport/sdk/api/bluetooth/client/api/AbsClassicBlueToothClientService;->isConnected()Z

    move-result v0

    const/4 v2, 0x1

    if-ne v0, v2, :cond_0

    move v1, v2

    :cond_0
    return v1
.end method

.method public final isFileChanelConnect()Z
    .locals 1

    .line 114
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/coreability/bluetooth/ClassicBTClientWrapper;->getService()Lcom/rokid/glasses/transport/sdk/api/bluetooth/client/api/AbsClassicBlueToothClientService;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Lcom/rokid/glasses/transport/sdk/api/bluetooth/client/api/AbsClassicBlueToothClientService;->isFileChanelConnect()Z

    move-result v0

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method public final isMessageChanelConnect()Z
    .locals 1

    .line 106
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/coreability/bluetooth/ClassicBTClientWrapper;->getService()Lcom/rokid/glasses/transport/sdk/api/bluetooth/client/api/AbsClassicBlueToothClientService;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Lcom/rokid/glasses/transport/sdk/api/bluetooth/client/api/AbsClassicBlueToothClientService;->isMessageChanelConnect()Z

    move-result v0

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method public final isStreamChanelConnect()Z
    .locals 1

    .line 118
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/coreability/bluetooth/ClassicBTClientWrapper;->getService()Lcom/rokid/glasses/transport/sdk/api/bluetooth/client/api/AbsClassicBlueToothClientService;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Lcom/rokid/glasses/transport/sdk/api/bluetooth/client/api/AbsClassicBlueToothClientService;->isStreamChanelConnect()Z

    move-result v0

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method public final removeClientListener(Lcom/rokid/glasses/transport/sdk/api/bluetooth/client/callback/IClassicClientListener;)V
    .locals 1
    .param p1, "listener"    # Lcom/rokid/glasses/transport/sdk/api/bluetooth/client/callback/IClassicClientListener;

    const-string v0, "listener"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 98
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/coreability/bluetooth/ClassicBTClientWrapper;->getService()Lcom/rokid/glasses/transport/sdk/api/bluetooth/client/api/AbsClassicBlueToothClientService;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-virtual {v0, p1}, Lcom/rokid/glasses/transport/sdk/api/bluetooth/client/api/AbsClassicBlueToothClientService;->removeClientListener(Lcom/rokid/glasses/transport/sdk/api/bluetooth/client/callback/IClassicClientListener;)V

    .line 99
    :cond_0
    return-void
.end method

.method public final sendAudioData([B)V
    .locals 1
    .param p1, "audio"    # [B

    const-string v0, "audio"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 82
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/coreability/bluetooth/ClassicBTClientWrapper;->getService()Lcom/rokid/glasses/transport/sdk/api/bluetooth/client/api/AbsClassicBlueToothClientService;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-virtual {v0, p1}, Lcom/rokid/glasses/transport/sdk/api/bluetooth/client/api/AbsClassicBlueToothClientService;->sendAudioData([B)V

    .line 83
    :cond_0
    return-void
.end method

.method public final sendFileData(Ljava/lang/String;Ljava/io/File;Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileSendListener;)V
    .locals 1
    .param p1, "dir"    # Ljava/lang/String;
    .param p2, "file"    # Ljava/io/File;
    .param p3, "listener"    # Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileSendListener;

    const-string v0, "file"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "listener"

    invoke-static {p3, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 86
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/coreability/bluetooth/ClassicBTClientWrapper;->getService()Lcom/rokid/glasses/transport/sdk/api/bluetooth/client/api/AbsClassicBlueToothClientService;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-virtual {v0, p1, p2, p3}, Lcom/rokid/glasses/transport/sdk/api/bluetooth/client/api/AbsClassicBlueToothClientService;->sendFileData(Ljava/lang/String;Ljava/io/File;Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileSendListener;)V

    .line 87
    :cond_0
    return-void
.end method

.method public final sendTextMessage(Ljava/lang/String;)V
    .locals 1
    .param p1, "data"    # Ljava/lang/String;

    const-string v0, "data"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 67
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/coreability/bluetooth/ClassicBTClientWrapper;->getService()Lcom/rokid/glasses/transport/sdk/api/bluetooth/client/api/AbsClassicBlueToothClientService;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-virtual {v0, p1}, Lcom/rokid/glasses/transport/sdk/api/bluetooth/client/api/AbsClassicBlueToothClientService;->sendTextMessage(Ljava/lang/String;)V

    .line 68
    :cond_0
    return-void
.end method

.method public final sendTextMessageV2(Ljava/lang/String;)V
    .locals 1
    .param p1, "data"    # Ljava/lang/String;

    const-string v0, "data"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 71
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/coreability/bluetooth/ClassicBTClientWrapper;->getService()Lcom/rokid/glasses/transport/sdk/api/bluetooth/client/api/AbsClassicBlueToothClientService;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-virtual {v0, p1}, Lcom/rokid/glasses/transport/sdk/api/bluetooth/client/api/AbsClassicBlueToothClientService;->sendTextMessageV2(Ljava/lang/String;)V

    .line 72
    :cond_0
    return-void
.end method

.method public final setSaveFileDirectory(Ljava/lang/String;)V
    .locals 1
    .param p1, "saveDirectory"    # Ljava/lang/String;

    const-string/jumbo v0, "saveDirectory"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 76
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/coreability/bluetooth/ClassicBTClientWrapper;->getService()Lcom/rokid/glasses/transport/sdk/api/bluetooth/client/api/AbsClassicBlueToothClientService;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-virtual {v0, p1}, Lcom/rokid/glasses/transport/sdk/api/bluetooth/client/api/AbsClassicBlueToothClientService;->setSaveFileDirectory(Ljava/lang/String;)V

    .line 77
    :cond_0
    return-void
.end method

.method public final startScan(J)V
    .locals 1
    .param p1, "timeoutMillis"    # J

    .line 44
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/coreability/bluetooth/ClassicBTClientWrapper;->getService()Lcom/rokid/glasses/transport/sdk/api/bluetooth/client/api/AbsClassicBlueToothClientService;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-virtual {v0, p1, p2}, Lcom/rokid/glasses/transport/sdk/api/bluetooth/client/api/AbsClassicBlueToothClientService;->startScan(J)V

    .line 45
    :cond_0
    return-void
.end method

.method public final stopFileSend()V
    .locals 1

    .line 90
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/coreability/bluetooth/ClassicBTClientWrapper;->getService()Lcom/rokid/glasses/transport/sdk/api/bluetooth/client/api/AbsClassicBlueToothClientService;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Lcom/rokid/glasses/transport/sdk/api/bluetooth/client/api/AbsClassicBlueToothClientService;->stopFileSend()V

    .line 91
    :cond_0
    return-void
.end method

.method public final stopScan()V
    .locals 1

    .line 48
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/coreability/bluetooth/ClassicBTClientWrapper;->getService()Lcom/rokid/glasses/transport/sdk/api/bluetooth/client/api/AbsClassicBlueToothClientService;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Lcom/rokid/glasses/transport/sdk/api/bluetooth/client/api/AbsClassicBlueToothClientService;->stopScan()V

    .line 49
    :cond_0
    return-void
.end method
