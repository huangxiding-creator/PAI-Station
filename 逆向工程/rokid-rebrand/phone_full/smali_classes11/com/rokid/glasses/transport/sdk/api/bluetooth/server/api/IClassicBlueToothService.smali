.class public interface abstract Lcom/rokid/glasses/transport/sdk/api/bluetooth/server/api/IClassicBlueToothService;
.super Ljava/lang/Object;
.source "IClassicBlueToothService.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000J\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0010 \n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u000b\n\u0002\u0008\u000c\n\u0002\u0010\u0012\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0000\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0008\r\u0008f\u0018\u00002\u00020\u0001J\u0010\u0010\u0002\u001a\u00020\u00032\u0006\u0010\u0004\u001a\u00020\u0005H&J\u0010\u0010\u0006\u001a\u00020\u00032\u0006\u0010\u0004\u001a\u00020\u0007H&J\u0008\u0010\u0008\u001a\u00020\u0003H&J\u000e\u0010\t\u001a\u0008\u0012\u0004\u0012\u00020\u000b0\nH&J\u0008\u0010\u000c\u001a\u00020\rH&J\u0008\u0010\u000e\u001a\u00020\rH&J\u0008\u0010\u000f\u001a\u00020\rH&J\u0008\u0010\u0010\u001a\u00020\rH&J\u0008\u0010\u0011\u001a\u00020\rH&J\u0008\u0010\u0012\u001a\u00020\rH&J\u0008\u0010\u0013\u001a\u00020\u0003H&J\u0010\u0010\u0014\u001a\u00020\u00032\u0006\u0010\u0004\u001a\u00020\u0005H&J\u0010\u0010\u0015\u001a\u00020\u00032\u0006\u0010\u0004\u001a\u00020\u0007H&J\u0008\u0010\u0016\u001a\u00020\u0003H&J\u0008\u0010\u0017\u001a\u00020\u0003H&J\u0010\u0010\u0018\u001a\u00020\u00032\u0006\u0010\u0019\u001a\u00020\u001aH&J\"\u0010\u001b\u001a\u00020\u00032\u0008\u0010\u001c\u001a\u0004\u0018\u00010\u001d2\u0006\u0010\u001e\u001a\u00020\u001f2\u0006\u0010\u0004\u001a\u00020 H&J \u0010!\u001a\u00020\u00032\u0006\u0010\"\u001a\u00020\u001d2\u0006\u0010#\u001a\u00020\u001a2\u0006\u0010$\u001a\u00020\u001dH&J\u0010\u0010%\u001a\u00020\u00032\u0006\u0010&\u001a\u00020\u001dH&J\u0010\u0010\'\u001a\u00020\u00032\u0006\u0010&\u001a\u00020\u001dH&J\u0010\u0010(\u001a\u00020\u00032\u0006\u0010)\u001a\u00020\u001dH&J\u0008\u0010*\u001a\u00020\u0003H&J\u0008\u0010+\u001a\u00020\u0003H&J\u0008\u0010,\u001a\u00020\u0003H&\u00a8\u0006-"
    }
    d2 = {
        "Lcom/rokid/glasses/transport/sdk/api/bluetooth/server/api/IClassicBlueToothService;",
        "",
        "addBlueToothServerListener",
        "",
        "listener",
        "Lcom/rokid/glasses/transport/sdk/api/bluetooth/server/callback/IBlueToothServerListener;",
        "addFileReceiveListener",
        "Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileReceiveListener;",
        "ensureNotDiscoverable",
        "getConnectDevices",
        "",
        "Landroid/bluetooth/BluetoothDevice;",
        "isAudioChanelConnect",
        "",
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
        "",
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
.method public abstract addBlueToothServerListener(Lcom/rokid/glasses/transport/sdk/api/bluetooth/server/callback/IBlueToothServerListener;)V
.end method

.method public abstract addFileReceiveListener(Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileReceiveListener;)V
.end method

.method public abstract ensureNotDiscoverable()V
.end method

.method public abstract getConnectDevices()Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Landroid/bluetooth/BluetoothDevice;",
            ">;"
        }
    .end annotation
.end method

.method public abstract isAudioChanelConnect()Z
.end method

.method public abstract isConnect()Z
.end method

.method public abstract isDiscoverableEnabled()Z
.end method

.method public abstract isFileChanelConnect()Z
.end method

.method public abstract isMessageChanelConnect()Z
.end method

.method public abstract isStreamChanelConnect()Z
.end method

.method public abstract makeDeviceDiscoverable()V
.end method

.method public abstract removeBlueToothServerListener(Lcom/rokid/glasses/transport/sdk/api/bluetooth/server/callback/IBlueToothServerListener;)V
.end method

.method public abstract removeFileReceiveListener(Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileReceiveListener;)V
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

.method public abstract startBlueToothService()V
.end method

.method public abstract stopBlueToothService()V
.end method

.method public abstract stopFileSend()V
.end method
