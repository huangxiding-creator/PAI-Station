.class public interface abstract Lcom/rokid/glasses/transport/sdk/api/bluetooth/client/api/IClassicBlueToothClient;
.super Ljava/lang/Object;
.source "IClassicBlueToothClient.kt"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/rokid/glasses/transport/sdk/api/bluetooth/client/api/IClassicBlueToothClient$DefaultImpls;
    }
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000V\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0010\u000b\n\u0002\u0018\u0002\n\u0002\u0008\r\n\u0002\u0010\u0012\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0000\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0008\n\n\u0002\u0010\t\n\u0002\u0008\u0003\u0008f\u0018\u00002\u00020\u0001J\u0010\u0010\u0002\u001a\u00020\u00032\u0006\u0010\u0004\u001a\u00020\u0005H&J\u0010\u0010\u0006\u001a\u00020\u00032\u0006\u0010\u0004\u001a\u00020\u0007H&J3\u0010\u0008\u001a\u00020\u00032\u0006\u0010\t\u001a\u00020\n2!\u0010\u000b\u001a\u001d\u0012\u0013\u0012\u00110\r\u00a2\u0006\u000c\u0008\u000e\u0012\u0008\u0008\u000f\u0012\u0004\u0008\u0008(\u0010\u0012\u0004\u0012\u00020\u00030\u000cH&J\u0008\u0010\u0011\u001a\u00020\u0003H&J\u0008\u0010\u0012\u001a\u00020\rH&J\u0008\u0010\u0013\u001a\u00020\rH&J\u0008\u0010\u0014\u001a\u00020\rH&J\u0008\u0010\u0015\u001a\u00020\rH&J\u0008\u0010\u0016\u001a\u00020\rH&J\u0010\u0010\u0017\u001a\u00020\u00032\u0006\u0010\u0004\u001a\u00020\u0005H&J\u0008\u0010\u0018\u001a\u00020\u0003H&J\u0008\u0010\u0019\u001a\u00020\u0003H&J\u0010\u0010\u001a\u001a\u00020\u00032\u0006\u0010\u001b\u001a\u00020\u001cH&J\"\u0010\u001d\u001a\u00020\u00032\u0008\u0010\u001e\u001a\u0004\u0018\u00010\u001f2\u0006\u0010 \u001a\u00020!2\u0006\u0010\u0004\u001a\u00020\"H&J \u0010#\u001a\u00020\u00032\u0006\u0010$\u001a\u00020\u001f2\u0006\u0010%\u001a\u00020\u001c2\u0006\u0010&\u001a\u00020\u001fH&J\u0010\u0010\'\u001a\u00020\u00032\u0006\u0010%\u001a\u00020\u001fH&J\u0010\u0010(\u001a\u00020\u00032\u0006\u0010%\u001a\u00020\u001fH&J\u0010\u0010)\u001a\u00020\u00032\u0006\u0010*\u001a\u00020\u001fH&J\u0012\u0010+\u001a\u00020\u00032\u0008\u0008\u0002\u0010,\u001a\u00020-H&J\u0008\u0010.\u001a\u00020\u0003H&J\u0008\u0010/\u001a\u00020\u0003H&\u00a8\u00060"
    }
    d2 = {
        "Lcom/rokid/glasses/transport/sdk/api/bluetooth/client/api/IClassicBlueToothClient;",
        "",
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
        "isAudioChanelConnect",
        "isConnected",
        "isFileChanelConnect",
        "isMessageChanelConnect",
        "isStreamChanelConnect",
        "removeClientListener",
        "resetFileReceiveState",
        "resetStreamReceiveState",
        "sendAudioData",
        "audio",
        "",
        "sendFileData",
        "dir",
        "",
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
.method public abstract addClientListener(Lcom/rokid/glasses/transport/sdk/api/bluetooth/client/callback/IClassicClientListener;)V
.end method

.method public abstract addFileReceiveListener(Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileReceiveListener;)V
.end method

.method public abstract connectToServer(Landroid/bluetooth/BluetoothDevice;Lkotlin/jvm/functions/Function1;)V
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
.end method

.method public abstract disconnect()V
.end method

.method public abstract isAudioChanelConnect()Z
.end method

.method public abstract isConnected()Z
.end method

.method public abstract isFileChanelConnect()Z
.end method

.method public abstract isMessageChanelConnect()Z
.end method

.method public abstract isStreamChanelConnect()Z
.end method

.method public abstract removeClientListener(Lcom/rokid/glasses/transport/sdk/api/bluetooth/client/callback/IClassicClientListener;)V
.end method

.method public abstract resetFileReceiveState()V
.end method

.method public abstract resetStreamReceiveState()V
.end method

.method public abstract sendAudioData([B)V
.end method

.method public abstract sendFileData(Ljava/lang/String;Ljava/io/File;Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileSendListener;)V
.end method

.method public abstract sendStreamoData(Ljava/lang/String;[BLjava/lang/String;)V
.end method

.method public abstract sendTextMessage(Ljava/lang/String;)V
.end method

.method public abstract sendTextMessageV2(Ljava/lang/String;)V
.end method

.method public abstract setSaveFileDirectory(Ljava/lang/String;)V
.end method

.method public abstract startScan(J)V
.end method

.method public abstract stopFileSend()V
.end method

.method public abstract stopScan()V
.end method
