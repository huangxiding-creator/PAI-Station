.class public final Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBlueToothServiceImpl;
.super Lcom/rokid/glasses/transport/sdk/api/bluetooth/server/api/AbsClassicBlueToothServer;
.source "ClassicBlueToothServiceImpl.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000g\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0000\n\u0002\u0010\u000b\n\u0000\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0008\u0003\n\u0002\u0018\u0002\n\u0000\n\u0002\u0008\u0003\n\u0002\u0008\u0003\n\u0002\u0010\u0002\n\u0002\u0008\u0004\n\u0002\u0010 \n\u0002\u0018\u0002\n\u0002\u0008\r\n\u0002\u0010\u0012\n\u0002\u0008\u0003\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0008\r*\u0003\r\u0012\u0015\u0008\u00c6\u0002\u0018\u00002\u00020\u0001B\u0007\u0008\u0002\u00a2\u0006\u0002\u0010\u0002J\u0010\u0010\u0017\u001a\u00020\u00182\u0006\u0010\u0019\u001a\u00020\tH\u0016J\u0010\u0010\u001a\u001a\u00020\u00182\u0006\u0010\u0019\u001a\u00020\u0010H\u0016J\u0008\u0010\u001b\u001a\u00020\u0018H\u0016J\u000e\u0010\u001c\u001a\u0008\u0012\u0004\u0012\u00020\u001e0\u001dH\u0016J\u0008\u0010\u001f\u001a\u00020\u0006H\u0016J\u0008\u0010 \u001a\u00020\u0006H\u0016J\u0008\u0010!\u001a\u00020\u0006H\u0016J\u0008\u0010\"\u001a\u00020\u0006H\u0016J\u0008\u0010#\u001a\u00020\u0006H\u0016J\u0008\u0010$\u001a\u00020\u0006H\u0016J\u0008\u0010%\u001a\u00020\u0018H\u0016J\u0010\u0010&\u001a\u00020\u00182\u0006\u0010\u0019\u001a\u00020\tH\u0016J\u0010\u0010\'\u001a\u00020\u00182\u0006\u0010\u0019\u001a\u00020\u0010H\u0016J\u0008\u0010(\u001a\u00020\u0018H\u0016J\u0008\u0010)\u001a\u00020\u0018H\u0016J\u0010\u0010*\u001a\u00020\u00182\u0006\u0010+\u001a\u00020,H\u0016J\"\u0010-\u001a\u00020\u00182\u0008\u0010.\u001a\u0004\u0018\u00010\u00042\u0006\u0010/\u001a\u0002002\u0006\u0010\u0019\u001a\u000201H\u0016J \u00102\u001a\u00020\u00182\u0006\u00103\u001a\u00020\u00042\u0006\u00104\u001a\u00020,2\u0006\u00105\u001a\u00020\u0004H\u0016J\u0010\u00106\u001a\u00020\u00182\u0006\u00107\u001a\u00020\u0004H\u0016J\u0010\u00108\u001a\u00020\u00182\u0006\u00107\u001a\u00020\u0004H\u0016J\u0010\u00109\u001a\u00020\u00182\u0006\u0010:\u001a\u00020\u0004H\u0016J\u0008\u0010;\u001a\u00020\u0018H\u0016J\u0008\u0010<\u001a\u00020\u0018H\u0016J\u0008\u0010=\u001a\u00020\u0018H\u0016R\u000e\u0010\u0003\u001a\u00020\u0004X\u0082D\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0005\u001a\u00020\u0006X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0014\u0010\u0007\u001a\u0008\u0012\u0004\u0012\u00020\t0\u0008X\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u0010\u0010\n\u001a\u0004\u0018\u00010\u000bX\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0010\u0010\u000c\u001a\u00020\rX\u0082\u000e\u00a2\u0006\u0004\n\u0002\u0010\u000eR\u0014\u0010\u000f\u001a\u0008\u0012\u0004\u0012\u00020\u00100\u0008X\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u0010\u0010\u0011\u001a\u00020\u0012X\u0082\u000e\u00a2\u0006\u0004\n\u0002\u0010\u0013R\u0010\u0010\u0014\u001a\u00020\u0015X\u0082\u0004\u00a2\u0006\u0004\n\u0002\u0010\u0016\u00a8\u0006>"
    }
    d2 = {
        "Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBlueToothServiceImpl;",
        "Lcom/rokid/glasses/transport/sdk/api/bluetooth/server/api/AbsClassicBlueToothServer;",
        "()V",
        "TAG",
        "",
        "isBluetoothServiceBound",
        "",
        "mBlueToothServerListeners",
        "Ljava/util/concurrent/CopyOnWriteArrayList;",
        "Lcom/rokid/glasses/transport/sdk/api/bluetooth/server/callback/IBlueToothServerListener;",
        "mBluetoothService",
        "Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;",
        "mFileReceiveListener",
        "com/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBlueToothServiceImpl$mFileReceiveListener$1",
        "Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBlueToothServiceImpl$mFileReceiveListener$1;",
        "mFileReceiveListeners",
        "Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileReceiveListener;",
        "mServerListener",
        "com/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBlueToothServiceImpl$mServerListener$1",
        "Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBlueToothServiceImpl$mServerListener$1;",
        "serviceConnection",
        "com/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBlueToothServiceImpl$serviceConnection$1",
        "Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBlueToothServiceImpl$serviceConnection$1;",
        "addBlueToothServerListener",
        "",
        "listener",
        "addFileReceiveListener",
        "ensureNotDiscoverable",
        "getConnectDevices",
        "",
        "Landroid/bluetooth/BluetoothDevice;",
        "isAudioChanelConnect",
        "isConnect",
        "isDiscoverableEnabled",
        "isFileChanelConnect",
        "isMessageChanelConnect",
        "isStreamChanelConnect",
        "makeDeviceDiscoverable",
        "removeBlueToothServerListener",
        "removeFileReceiveListener",
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
        "msg",
        "sendTextMessageV2",
        "setSaveFileDirectory",
        "saveDirectory",
        "startBlueToothService",
        "stopBlueToothService",
        "stopFileSend",
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
.field public static final INSTANCE:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBlueToothServiceImpl;

.field private static final TAG:Ljava/lang/String;

.field private static isBluetoothServiceBound:Z

.field private static final mBlueToothServerListeners:Ljava/util/concurrent/CopyOnWriteArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/concurrent/CopyOnWriteArrayList<",
            "Lcom/rokid/glasses/transport/sdk/api/bluetooth/server/callback/IBlueToothServerListener;",
            ">;"
        }
    .end annotation
.end field

.field private static mBluetoothService:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

.field private static mFileReceiveListener:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBlueToothServiceImpl$mFileReceiveListener$1;

.field private static final mFileReceiveListeners:Ljava/util/concurrent/CopyOnWriteArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/concurrent/CopyOnWriteArrayList<",
            "Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileReceiveListener;",
            ">;"
        }
    .end annotation
.end field

.field private static mServerListener:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBlueToothServiceImpl$mServerListener$1;

.field private static final serviceConnection:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBlueToothServiceImpl$serviceConnection$1;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBlueToothServiceImpl;

    invoke-direct {v0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBlueToothServiceImpl;-><init>()V

    sput-object v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBlueToothServiceImpl;->INSTANCE:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBlueToothServiceImpl;

    .line 22
    const-string v0, "ClassicBlueToothServiceImpl:"

    sput-object v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBlueToothServiceImpl;->TAG:Ljava/lang/String;

    .line 24
    new-instance v0, Ljava/util/concurrent/CopyOnWriteArrayList;

    invoke-direct {v0}, Ljava/util/concurrent/CopyOnWriteArrayList;-><init>()V

    sput-object v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBlueToothServiceImpl;->mBlueToothServerListeners:Ljava/util/concurrent/CopyOnWriteArrayList;

    .line 25
    new-instance v0, Ljava/util/concurrent/CopyOnWriteArrayList;

    invoke-direct {v0}, Ljava/util/concurrent/CopyOnWriteArrayList;-><init>()V

    sput-object v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBlueToothServiceImpl;->mFileReceiveListeners:Ljava/util/concurrent/CopyOnWriteArrayList;

    .line 28
    new-instance v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBlueToothServiceImpl$serviceConnection$1;

    invoke-direct {v0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBlueToothServiceImpl$serviceConnection$1;-><init>()V

    sput-object v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBlueToothServiceImpl;->serviceConnection:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBlueToothServiceImpl$serviceConnection$1;

    .line 159
    new-instance v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBlueToothServiceImpl$mServerListener$1;

    invoke-direct {v0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBlueToothServiceImpl$mServerListener$1;-><init>()V

    sput-object v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBlueToothServiceImpl;->mServerListener:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBlueToothServiceImpl$mServerListener$1;

    .line 258
    new-instance v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBlueToothServiceImpl$mFileReceiveListener$1;

    invoke-direct {v0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBlueToothServiceImpl$mFileReceiveListener$1;-><init>()V

    sput-object v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBlueToothServiceImpl;->mFileReceiveListener:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBlueToothServiceImpl$mFileReceiveListener$1;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 21
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/api/bluetooth/server/api/AbsClassicBlueToothServer;-><init>()V

    return-void
.end method

.method public static final synthetic access$getMBlueToothServerListeners$p()Ljava/util/concurrent/CopyOnWriteArrayList;
    .locals 1

    .line 21
    sget-object v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBlueToothServiceImpl;->mBlueToothServerListeners:Ljava/util/concurrent/CopyOnWriteArrayList;

    return-object v0
.end method

.method public static final synthetic access$getMBluetoothService$p()Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;
    .locals 1

    .line 21
    sget-object v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBlueToothServiceImpl;->mBluetoothService:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    return-object v0
.end method

.method public static final synthetic access$getMFileReceiveListener$p()Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBlueToothServiceImpl$mFileReceiveListener$1;
    .locals 1

    .line 21
    sget-object v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBlueToothServiceImpl;->mFileReceiveListener:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBlueToothServiceImpl$mFileReceiveListener$1;

    return-object v0
.end method

.method public static final synthetic access$getMFileReceiveListeners$p()Ljava/util/concurrent/CopyOnWriteArrayList;
    .locals 1

    .line 21
    sget-object v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBlueToothServiceImpl;->mFileReceiveListeners:Ljava/util/concurrent/CopyOnWriteArrayList;

    return-object v0
.end method

.method public static final synthetic access$getMServerListener$p()Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBlueToothServiceImpl$mServerListener$1;
    .locals 1

    .line 21
    sget-object v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBlueToothServiceImpl;->mServerListener:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBlueToothServiceImpl$mServerListener$1;

    return-object v0
.end method

.method public static final synthetic access$getTAG$p()Ljava/lang/String;
    .locals 1

    .line 21
    sget-object v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBlueToothServiceImpl;->TAG:Ljava/lang/String;

    return-object v0
.end method

.method public static final synthetic access$setMBluetoothService$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;)V
    .locals 0
    .param p0, "<set-?>"    # Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    .line 21
    sput-object p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBlueToothServiceImpl;->mBluetoothService:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    return-void
.end method


# virtual methods
.method public addBlueToothServerListener(Lcom/rokid/glasses/transport/sdk/api/bluetooth/server/callback/IBlueToothServerListener;)V
    .locals 1
    .param p1, "listener"    # Lcom/rokid/glasses/transport/sdk/api/bluetooth/server/callback/IBlueToothServerListener;

    const-string v0, "listener"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 102
    sget-object v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBlueToothServiceImpl;->mBlueToothServerListeners:Ljava/util/concurrent/CopyOnWriteArrayList;

    invoke-virtual {v0, p1}, Ljava/util/concurrent/CopyOnWriteArrayList;->contains(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 103
    sget-object v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBlueToothServiceImpl;->mBlueToothServerListeners:Ljava/util/concurrent/CopyOnWriteArrayList;

    invoke-virtual {v0, p1}, Ljava/util/concurrent/CopyOnWriteArrayList;->add(Ljava/lang/Object;)Z

    .line 105
    :cond_0
    return-void
.end method

.method public addFileReceiveListener(Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileReceiveListener;)V
    .locals 1
    .param p1, "listener"    # Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileReceiveListener;

    const-string v0, "listener"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 112
    sget-object v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBlueToothServiceImpl;->mFileReceiveListeners:Ljava/util/concurrent/CopyOnWriteArrayList;

    invoke-virtual {v0, p1}, Ljava/util/concurrent/CopyOnWriteArrayList;->contains(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 113
    sget-object v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBlueToothServiceImpl;->mFileReceiveListeners:Ljava/util/concurrent/CopyOnWriteArrayList;

    invoke-virtual {v0, p1}, Ljava/util/concurrent/CopyOnWriteArrayList;->add(Ljava/lang/Object;)Z

    .line 115
    :cond_0
    return-void
.end method

.method public ensureNotDiscoverable()V
    .locals 1

    .line 91
    sget-object v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBlueToothServiceImpl;->mBluetoothService:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->ensureNotDiscoverable()V

    .line 92
    :cond_0
    return-void
.end method

.method public getConnectDevices()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Landroid/bluetooth/BluetoothDevice;",
            ">;"
        }
    .end annotation

    .line 122
    sget-object v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBlueToothServiceImpl;->mBluetoothService:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->getConnectDevices()Ljava/util/List;

    move-result-object v0

    if-nez v0, :cond_1

    :cond_0
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    check-cast v0, Ljava/util/List;

    :cond_1
    return-object v0
.end method

.method public isAudioChanelConnect()Z
    .locals 1

    .line 134
    sget-object v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBlueToothServiceImpl;->mBluetoothService:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->isAudioChanelConnect()Z

    move-result v0

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method public isConnect()Z
    .locals 1

    .line 126
    invoke-virtual {p0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBlueToothServiceImpl;->isMessageChanelConnect()Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-virtual {p0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBlueToothServiceImpl;->isAudioChanelConnect()Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-virtual {p0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBlueToothServiceImpl;->isFileChanelConnect()Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-virtual {p0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBlueToothServiceImpl;->isStreamChanelConnect()Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method public isDiscoverableEnabled()Z
    .locals 1

    .line 87
    sget-object v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBlueToothServiceImpl;->mBluetoothService:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->isDiscoverableEnabled()Z

    move-result v0

    goto :goto_0

    :cond_0
    const/4 v0, 0x1

    :goto_0
    return v0
.end method

.method public isFileChanelConnect()Z
    .locals 1

    .line 138
    sget-object v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBlueToothServiceImpl;->mBluetoothService:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->isFileChanelConnect()Z

    move-result v0

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method public isMessageChanelConnect()Z
    .locals 1

    .line 130
    sget-object v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBlueToothServiceImpl;->mBluetoothService:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->isMessageChanelConnect()Z

    move-result v0

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method public isStreamChanelConnect()Z
    .locals 1

    .line 142
    sget-object v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBlueToothServiceImpl;->mBluetoothService:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->isStreamChanelConnect()Z

    move-result v0

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method public makeDeviceDiscoverable()V
    .locals 1

    .line 83
    sget-object v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBlueToothServiceImpl;->mBluetoothService:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->makeDeviceDiscoverable()V

    .line 84
    :cond_0
    return-void
.end method

.method public removeBlueToothServerListener(Lcom/rokid/glasses/transport/sdk/api/bluetooth/server/callback/IBlueToothServerListener;)V
    .locals 1
    .param p1, "listener"    # Lcom/rokid/glasses/transport/sdk/api/bluetooth/server/callback/IBlueToothServerListener;

    const-string v0, "listener"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 108
    sget-object v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBlueToothServiceImpl;->mBlueToothServerListeners:Ljava/util/concurrent/CopyOnWriteArrayList;

    invoke-virtual {v0, p1}, Ljava/util/concurrent/CopyOnWriteArrayList;->remove(Ljava/lang/Object;)Z

    .line 109
    return-void
.end method

.method public removeFileReceiveListener(Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileReceiveListener;)V
    .locals 1
    .param p1, "listener"    # Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileReceiveListener;

    const-string v0, "listener"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 118
    sget-object v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBlueToothServiceImpl;->mFileReceiveListeners:Ljava/util/concurrent/CopyOnWriteArrayList;

    invoke-virtual {v0, p1}, Ljava/util/concurrent/CopyOnWriteArrayList;->remove(Ljava/lang/Object;)Z

    .line 119
    return-void
.end method

.method public resetFileReceiveState()V
    .locals 1

    .line 75
    sget-object v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBlueToothServiceImpl;->mBluetoothService:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->resetFileReceiveState()V

    .line 76
    :cond_0
    return-void
.end method

.method public resetStreamReceiveState()V
    .locals 1

    .line 79
    sget-object v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBlueToothServiceImpl;->mBluetoothService:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->resetStreamReceiveState()V

    .line 80
    :cond_0
    return-void
.end method

.method public sendAudioData([B)V
    .locals 1
    .param p1, "audio"    # [B

    const-string v0, "audio"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 59
    sget-object v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBlueToothServiceImpl;->mBluetoothService:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    if-eqz v0, :cond_0

    invoke-virtual {v0, p1}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->sendAudioBroadcast([B)V

    .line 60
    :cond_0
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

    .line 67
    sget-object v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBlueToothServiceImpl;->mBluetoothService:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    if-eqz v0, :cond_0

    invoke-virtual {v0, p1, p2, p3}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->sendFileBroadcast(Ljava/lang/String;Ljava/io/File;Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileSendListener;)V

    .line 68
    :cond_0
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

    .line 63
    sget-object v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBlueToothServiceImpl;->mBluetoothService:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    if-eqz v0, :cond_0

    invoke-virtual {v0, p1, p2, p3}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->sendStreamBroadcast(Ljava/lang/String;[BLjava/lang/String;)V

    .line 64
    :cond_0
    return-void
.end method

.method public sendTextMessage(Ljava/lang/String;)V
    .locals 1
    .param p1, "msg"    # Ljava/lang/String;

    const-string v0, "msg"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 51
    sget-object v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBlueToothServiceImpl;->mBluetoothService:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    if-eqz v0, :cond_0

    invoke-virtual {v0, p1}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->sendBroadcast(Ljava/lang/String;)V

    .line 52
    :cond_0
    return-void
.end method

.method public sendTextMessageV2(Ljava/lang/String;)V
    .locals 1
    .param p1, "msg"    # Ljava/lang/String;

    const-string v0, "msg"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 55
    sget-object v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBlueToothServiceImpl;->mBluetoothService:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    if-eqz v0, :cond_0

    invoke-virtual {v0, p1}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->sendBroadcastV2(Ljava/lang/String;)V

    .line 56
    :cond_0
    return-void
.end method

.method public setSaveFileDirectory(Ljava/lang/String;)V
    .locals 1
    .param p1, "saveDirectory"    # Ljava/lang/String;

    const-string v0, "saveDirectory"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 97
    sget-object v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBlueToothServiceImpl;->mBluetoothService:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    if-eqz v0, :cond_0

    invoke-virtual {v0, p1}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->setSaveFileDirectory(Ljava/lang/String;)V

    .line 98
    :cond_0
    return-void
.end method

.method public startBlueToothService()V
    .locals 4

    .line 44
    new-instance v0, Landroid/content/Intent;

    invoke-static {}, Lcom/blankj/utilcode/util/Utils;->getApp()Landroid/app/Application;

    move-result-object v1

    check-cast v1, Landroid/content/Context;

    const-class v2, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    invoke-direct {v0, v1, v2}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    .line 45
    .local v0, "intent":Landroid/content/Intent;
    invoke-static {}, Lcom/blankj/utilcode/util/Utils;->getApp()Landroid/app/Application;

    move-result-object v1

    check-cast v1, Landroid/content/Context;

    invoke-static {v1, v0}, Landroidx/core/content/ContextCompat;->startForegroundService(Landroid/content/Context;Landroid/content/Intent;)V

    .line 46
    invoke-static {}, Lcom/blankj/utilcode/util/Utils;->getApp()Landroid/app/Application;

    move-result-object v1

    sget-object v2, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBlueToothServiceImpl;->serviceConnection:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBlueToothServiceImpl$serviceConnection$1;

    check-cast v2, Landroid/content/ServiceConnection;

    const/4 v3, 0x1

    invoke-virtual {v1, v0, v2, v3}, Landroid/app/Application;->bindService(Landroid/content/Intent;Landroid/content/ServiceConnection;I)Z

    .line 47
    sput-boolean v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBlueToothServiceImpl;->isBluetoothServiceBound:Z

    .line 48
    return-void
.end method

.method public stopBlueToothService()V
    .locals 2

    .line 147
    nop

    .line 148
    :try_start_0
    sget-boolean v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBlueToothServiceImpl;->isBluetoothServiceBound:Z

    if-eqz v0, :cond_0

    .line 149
    invoke-static {}, Lcom/blankj/utilcode/util/Utils;->getApp()Landroid/app/Application;

    move-result-object v0

    sget-object v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBlueToothServiceImpl;->serviceConnection:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBlueToothServiceImpl$serviceConnection$1;

    check-cast v1, Landroid/content/ServiceConnection;

    invoke-virtual {v0, v1}, Landroid/app/Application;->unbindService(Landroid/content/ServiceConnection;)V

    .line 150
    const/4 v0, 0x0

    sput-boolean v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBlueToothServiceImpl;->isBluetoothServiceBound:Z

    .line 152
    :cond_0
    sget-object v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBlueToothServiceImpl;->mBluetoothService:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    if-eqz v0, :cond_1

    invoke-virtual {v0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->stopSelf()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 153
    :catch_0
    move-exception v0

    .line 154
    .local v0, "e":Ljava/lang/Exception;
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    .line 156
    .end local v0    # "e":Ljava/lang/Exception;
    :cond_1
    :goto_0
    return-void
.end method

.method public stopFileSend()V
    .locals 1

    .line 71
    sget-object v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBlueToothServiceImpl;->mBluetoothService:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->stopFileSend()V

    .line 72
    :cond_0
    return-void
.end method
