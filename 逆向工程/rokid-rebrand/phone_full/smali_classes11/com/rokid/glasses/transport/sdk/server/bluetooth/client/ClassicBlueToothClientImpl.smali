.class public final Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientImpl;
.super Lcom/rokid/glasses/transport/sdk/api/bluetooth/client/api/AbsClassicBlueToothClientService;
.source "ClassicBlueToothClientImpl.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000`\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0005\n\u0002\u0010\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0010\u000b\n\u0002\u0018\u0002\n\u0002\u0008\u000f\n\u0002\u0010\u0012\n\u0002\u0008\u0003\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0008\n\n\u0002\u0010\t\n\u0002\u0008\u0003\u0008\u00c6\u0002\u0018\u00002\u00020\u0001B\u0007\u0008\u0002\u00a2\u0006\u0002\u0010\u0002J\u0010\u0010\u000b\u001a\u00020\u000c2\u0006\u0010\r\u001a\u00020\u000eH\u0016J\u0010\u0010\u000f\u001a\u00020\u000c2\u0006\u0010\r\u001a\u00020\u0010H\u0016J3\u0010\u0011\u001a\u00020\u000c2\u0006\u0010\u0012\u001a\u00020\u00132!\u0010\u0014\u001a\u001d\u0012\u0013\u0012\u00110\u0016\u00a2\u0006\u000c\u0008\u0017\u0012\u0008\u0008\u0018\u0012\u0004\u0008\u0008(\u0019\u0012\u0004\u0012\u00020\u000c0\u0015H\u0016J\u0008\u0010\u001a\u001a\u00020\u000cH\u0016J\u0006\u0010\u001b\u001a\u00020\u000cJ\u0008\u0010\u001c\u001a\u00020\u0016H\u0016J\u0008\u0010\u001d\u001a\u00020\u0016H\u0016J\u0008\u0010\u001e\u001a\u00020\u0016H\u0016J\u0008\u0010\u001f\u001a\u00020\u0016H\u0016J\u0008\u0010 \u001a\u00020\u0016H\u0016J\u0006\u0010!\u001a\u00020\u000cJ\u0010\u0010\"\u001a\u00020\u000c2\u0006\u0010\r\u001a\u00020\u000eH\u0016J\u0008\u0010#\u001a\u00020\u000cH\u0016J\u0008\u0010$\u001a\u00020\u000cH\u0016J\u0010\u0010%\u001a\u00020\u000c2\u0006\u0010&\u001a\u00020\'H\u0016J\"\u0010(\u001a\u00020\u000c2\u0008\u0010)\u001a\u0004\u0018\u00010\u00042\u0006\u0010*\u001a\u00020+2\u0006\u0010\r\u001a\u00020,H\u0016J \u0010-\u001a\u00020\u000c2\u0006\u0010.\u001a\u00020\u00042\u0006\u0010/\u001a\u00020\'2\u0006\u00100\u001a\u00020\u0004H\u0016J\u0010\u00101\u001a\u00020\u000c2\u0006\u0010/\u001a\u00020\u0004H\u0016J\u0010\u00102\u001a\u00020\u000c2\u0006\u0010/\u001a\u00020\u0004H\u0016J\u0010\u00103\u001a\u00020\u000c2\u0006\u00104\u001a\u00020\u0004H\u0016J\u0010\u00105\u001a\u00020\u000c2\u0006\u00106\u001a\u000207H\u0016J\u0008\u00108\u001a\u00020\u000cH\u0016J\u0008\u00109\u001a\u00020\u000cH\u0016R\u000e\u0010\u0003\u001a\u00020\u0004X\u0082D\u00a2\u0006\u0002\n\u0000R\u001b\u0010\u0005\u001a\u00020\u00068BX\u0082\u0084\u0002\u00a2\u0006\u000c\n\u0004\u0008\t\u0010\n\u001a\u0004\u0008\u0007\u0010\u0008\u00a8\u0006:"
    }
    d2 = {
        "Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientImpl;",
        "Lcom/rokid/glasses/transport/sdk/api/bluetooth/client/api/AbsClassicBlueToothClientService;",
        "()V",
        "TAG",
        "",
        "mClassicBlueToothClientManager",
        "Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;",
        "getMClassicBlueToothClientManager",
        "()Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;",
        "mClassicBlueToothClientManager$delegate",
        "Lkotlin/Lazy;",
        "addClientListener",
        "",
        "listener",
        "Lcom/rokid/glasses/transport/sdk/api/bluetooth/client/callback/IClassicClientListener;",
        "addFileReceiveListener",
        "Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileReceiveListener;",
        "connectToServer",
        "device",
        "Landroid/bluetooth/BluetoothDevice;",
        "action",
        "Lkotlin/Function1;",
        "",
        "Lkotlin/ParameterName;",
        "name",
        "isConnect",
        "disconnect",
        "init",
        "isAudioChanelConnect",
        "isConnected",
        "isFileChanelConnect",
        "isMessageChanelConnect",
        "isStreamChanelConnect",
        "release",
        "removeClientListener",
        "resetFileReceiveState",
        "resetStreamReceiveState",
        "sendAudioData",
        "audio",
        "",
        "sendFileData",
        "dir",
        "file",
        "Ljava/io/File;",
        "Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileSendListener;",
        "sendStreamoData",
        "tag",
        "data",
        "clientId",
        "sendTextMessage",
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
.field public static final INSTANCE:Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientImpl;

.field private static final TAG:Ljava/lang/String;

.field private static final mClassicBlueToothClientManager$delegate:Lkotlin/Lazy;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientImpl;

    invoke-direct {v0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientImpl;-><init>()V

    sput-object v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientImpl;->INSTANCE:Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientImpl;

    .line 12
    const-string v0, "ClassicBlueToothClientImpl"

    sput-object v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientImpl;->TAG:Ljava/lang/String;

    .line 13
    sget-object v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientImpl$mClassicBlueToothClientManager$2;->INSTANCE:Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientImpl$mClassicBlueToothClientManager$2;

    check-cast v0, Lkotlin/jvm/functions/Function0;

    invoke-static {v0}, Lkotlin/LazyKt;->lazy(Lkotlin/jvm/functions/Function0;)Lkotlin/Lazy;

    move-result-object v0

    sput-object v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientImpl;->mClassicBlueToothClientManager$delegate:Lkotlin/Lazy;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 11
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/api/bluetooth/client/api/AbsClassicBlueToothClientService;-><init>()V

    return-void
.end method

.method private final getMClassicBlueToothClientManager()Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;
    .locals 1

    .line 13
    sget-object v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientImpl;->mClassicBlueToothClientManager$delegate:Lkotlin/Lazy;

    invoke-interface {v0}, Lkotlin/Lazy;->getValue()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;

    return-object v0
.end method


# virtual methods
.method public addClientListener(Lcom/rokid/glasses/transport/sdk/api/bluetooth/client/callback/IClassicClientListener;)V
    .locals 1
    .param p1, "listener"    # Lcom/rokid/glasses/transport/sdk/api/bluetooth/client/callback/IClassicClientListener;

    const-string v0, "listener"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 79
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientImpl;->getMClassicBlueToothClientManager()Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;->addClientListener(Lcom/rokid/glasses/transport/sdk/api/bluetooth/client/callback/IClassicClientListener;)V

    .line 80
    return-void
.end method

.method public addFileReceiveListener(Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileReceiveListener;)V
    .locals 1
    .param p1, "listener"    # Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileReceiveListener;

    const-string v0, "listener"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 83
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientImpl;->getMClassicBlueToothClientManager()Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;->addFileReceiveListener(Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileReceiveListener;)V

    .line 84
    return-void
.end method

.method public connectToServer(Landroid/bluetooth/BluetoothDevice;Lkotlin/jvm/functions/Function1;)V
    .locals 1
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
            ">;)V"
        }
    .end annotation

    const-string v0, "device"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "action"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 33
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientImpl;->getMClassicBlueToothClientManager()Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;

    move-result-object v0

    invoke-virtual {v0, p1, p2}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;->connect(Landroid/bluetooth/BluetoothDevice;Lkotlin/jvm/functions/Function1;)V

    .line 34
    return-void
.end method

.method public disconnect()V
    .locals 2

    .line 37
    sget-object v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientImpl;->TAG:Ljava/lang/String;

    const-string v1, " \u7528\u6237\u4e3b\u52a8disconnect"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 38
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientImpl;->getMClassicBlueToothClientManager()Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;

    move-result-object v0

    invoke-virtual {v0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;->disconnect()V

    .line 39
    return-void
.end method

.method public final init()V
    .locals 1

    .line 18
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientImpl;->getMClassicBlueToothClientManager()Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;

    move-result-object v0

    invoke-virtual {v0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;->init()V

    .line 19
    return-void
.end method

.method public isAudioChanelConnect()Z
    .locals 1

    .line 99
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientImpl;->getMClassicBlueToothClientManager()Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;

    move-result-object v0

    invoke-virtual {v0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;->isAudioChanelConnect()Z

    move-result v0

    return v0
.end method

.method public isConnected()Z
    .locals 1

    .line 91
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientImpl;->getMClassicBlueToothClientManager()Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;

    move-result-object v0

    invoke-virtual {v0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;->isConnected()Z

    move-result v0

    return v0
.end method

.method public isFileChanelConnect()Z
    .locals 1

    .line 103
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientImpl;->getMClassicBlueToothClientManager()Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;

    move-result-object v0

    invoke-virtual {v0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;->isFileChanelConnect()Z

    move-result v0

    return v0
.end method

.method public isMessageChanelConnect()Z
    .locals 1

    .line 95
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientImpl;->getMClassicBlueToothClientManager()Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;

    move-result-object v0

    invoke-virtual {v0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;->isMessageChanelConnect()Z

    move-result v0

    return v0
.end method

.method public isStreamChanelConnect()Z
    .locals 1

    .line 107
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientImpl;->getMClassicBlueToothClientManager()Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;

    move-result-object v0

    invoke-virtual {v0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;->isStreamChanelConnect()Z

    move-result v0

    return v0
.end method

.method public final release()V
    .locals 1

    .line 111
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientImpl;->getMClassicBlueToothClientManager()Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;

    move-result-object v0

    invoke-virtual {v0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;->release()V

    .line 112
    return-void
.end method

.method public removeClientListener(Lcom/rokid/glasses/transport/sdk/api/bluetooth/client/callback/IClassicClientListener;)V
    .locals 1
    .param p1, "listener"    # Lcom/rokid/glasses/transport/sdk/api/bluetooth/client/callback/IClassicClientListener;

    const-string v0, "listener"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 87
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientImpl;->getMClassicBlueToothClientManager()Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;->removeClientListener(Lcom/rokid/glasses/transport/sdk/api/bluetooth/client/callback/IClassicClientListener;)V

    .line 88
    return-void
.end method

.method public resetFileReceiveState()V
    .locals 1

    .line 70
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientImpl;->getMClassicBlueToothClientManager()Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;

    move-result-object v0

    invoke-virtual {v0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;->resetFileReceiveState()V

    .line 71
    return-void
.end method

.method public resetStreamReceiveState()V
    .locals 1

    .line 74
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientImpl;->getMClassicBlueToothClientManager()Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;

    move-result-object v0

    invoke-virtual {v0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;->resetStreamReceiveState()V

    .line 75
    return-void
.end method

.method public sendAudioData([B)V
    .locals 1
    .param p1, "audio"    # [B

    const-string v0, "audio"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 50
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientImpl;->getMClassicBlueToothClientManager()Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;->sendAudioData([B)V

    .line 51
    return-void
.end method

.method public sendFileData(Ljava/lang/String;Ljava/io/File;Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileSendListener;)V
    .locals 1
    .param p1, "dir"    # Ljava/lang/String;
    .param p2, "file"    # Ljava/io/File;
    .param p3, "listener"    # Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileSendListener;

    const-string v0, "file"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "listener"

    invoke-static {p3, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 58
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientImpl;->getMClassicBlueToothClientManager()Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;

    move-result-object v0

    invoke-virtual {v0, p1, p2, p3}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;->sendFileData(Ljava/lang/String;Ljava/io/File;Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileSendListener;)V

    .line 59
    return-void
.end method

.method public sendStreamoData(Ljava/lang/String;[BLjava/lang/String;)V
    .locals 1
    .param p1, "tag"    # Ljava/lang/String;
    .param p2, "data"    # [B
    .param p3, "clientId"    # Ljava/lang/String;

    const-string v0, "tag"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "data"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "clientId"

    invoke-static {p3, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 66
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientImpl;->getMClassicBlueToothClientManager()Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;

    move-result-object v0

    invoke-virtual {v0, p1, p2, p3}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;->sendStreamData(Ljava/lang/String;[BLjava/lang/String;)V

    .line 67
    return-void
.end method

.method public sendTextMessage(Ljava/lang/String;)V
    .locals 1
    .param p1, "data"    # Ljava/lang/String;

    const-string v0, "data"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 42
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientImpl;->getMClassicBlueToothClientManager()Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;->sendMessage(Ljava/lang/String;)V

    .line 43
    return-void
.end method

.method public sendTextMessageV2(Ljava/lang/String;)V
    .locals 1
    .param p1, "data"    # Ljava/lang/String;

    const-string v0, "data"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 46
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientImpl;->getMClassicBlueToothClientManager()Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;->sendMessageV2(Ljava/lang/String;)V

    .line 47
    return-void
.end method

.method public setSaveFileDirectory(Ljava/lang/String;)V
    .locals 1
    .param p1, "saveDirectory"    # Ljava/lang/String;

    const-string v0, "saveDirectory"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 54
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientImpl;->getMClassicBlueToothClientManager()Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;->setSaveFileDirectory(Ljava/lang/String;)V

    .line 55
    return-void
.end method

.method public startScan(J)V
    .locals 1
    .param p1, "timeoutMillis"    # J

    .line 24
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientImpl;->getMClassicBlueToothClientManager()Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;

    move-result-object v0

    invoke-virtual {v0, p1, p2}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;->startDiscovery(J)V

    .line 25
    return-void
.end method

.method public stopFileSend()V
    .locals 1

    .line 62
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientImpl;->getMClassicBlueToothClientManager()Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;

    move-result-object v0

    invoke-virtual {v0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;->stopFileSend()V

    .line 63
    return-void
.end method

.method public stopScan()V
    .locals 2

    .line 28
    sget-object v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientImpl;->TAG:Ljava/lang/String;

    const-string v1, "stopScan "

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 29
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientImpl;->getMClassicBlueToothClientManager()Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;

    move-result-object v0

    invoke-virtual {v0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;->cancelDiscovery()V

    .line 30
    return-void
.end method
