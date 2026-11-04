.class public final Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;
.super Landroid/app/Service;
.source "ClassicBluetoothService.kt"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;,
        Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$Companion;,
        Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$LocalBinder;,
        Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ReceiveState;
    }
.end annotation

.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nClassicBluetoothService.kt\nKotlin\n*S Kotlin\n*F\n+ 1 ClassicBluetoothService.kt\ncom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService\n+ 2 Mutex.kt\nkotlinx/coroutines/sync/MutexKt\n+ 3 _Collections.kt\nkotlin/collections/CollectionsKt___CollectionsKt\n+ 4 fake.kt\nkotlin/jvm/internal/FakeKt\n*L\n1#1,1582:1\n120#2,10:1583\n1855#3,2:1593\n1603#3,9:1595\n1855#3:1604\n1856#3:1606\n1612#3:1607\n1855#3,2:1608\n1855#3,2:1610\n1855#3,2:1612\n1855#3,2:1614\n1#4:1605\n*S KotlinDebug\n*F\n+ 1 ClassicBluetoothService.kt\ncom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService\n*L\n312#1:1583,10\n763#1:1593,2\n969#1:1595,9\n969#1:1604\n969#1:1606\n969#1:1607\n1022#1:1608,2\n1024#1:1610,2\n1026#1:1612,2\n1028#1:1614,2\n969#1:1605\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u00c8\u0001\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0005\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0004\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0010\u000b\n\u0002\u0008\u0004\n\u0002\u0018\u0002\n\u0002\u0008\u0006\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0003\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0008\n\u0002\u0008\u0002\n\u0002\u0010\t\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0008\n\u0002\u0010\u0002\n\u0002\u0008\u0002\n\u0002\u0010 \n\u0002\u0018\u0002\n\u0002\u0008\u0003\n\u0002\u0010\u000e\n\u0002\u0008\t\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\n\n\u0002\u0010\u0012\n\u0002\u0008\u0006\n\u0002\u0018\u0002\n\u0002\u0008\u0016\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0006\u0018\u0000 \u0081\u00012\u00020\u0001:\u0008\u0080\u0001\u0081\u0001\u0082\u0001\u0083\u0001B\u0005\u00a2\u0006\u0002\u0010\u0002J\u0008\u0010>\u001a\u00020?H\u0002J\u0008\u0010@\u001a\u00020?H\u0007J\u000c\u0010A\u001a\u0008\u0012\u0004\u0012\u00020C0BJ\u0018\u0010D\u001a\u00020?2\u0006\u0010E\u001a\u00020\r2\u0006\u0010F\u001a\u00020GH\u0002J\u0008\u0010H\u001a\u00020\u0017H\u0002J\u0006\u0010I\u001a\u00020\u0017J\u0006\u0010J\u001a\u00020\u0017J\u0006\u0010K\u001a\u00020\u0017J\u0006\u0010L\u001a\u00020\u0017J\u0010\u0010M\u001a\u00020\u00172\u0006\u0010E\u001a\u00020\rH\u0002J\u0006\u0010N\u001a\u00020\u0017J\u0008\u0010O\u001a\u00020?H\u0007J\u0010\u0010P\u001a\u00020Q2\u0006\u0010R\u001a\u00020SH\u0016J\u0008\u0010T\u001a\u00020?H\u0016J\u0008\u0010U\u001a\u00020?H\u0016J\u0019\u0010V\u001a\u00020?2\u0006\u0010E\u001a\u00020\rH\u0083@\u00f8\u0001\u0000\u00a2\u0006\u0002\u0010WJ\u0008\u0010X\u001a\u00020?H\u0002J\u0006\u0010Y\u001a\u00020?J\u0006\u0010Z\u001a\u00020?J\u0008\u0010[\u001a\u00020?H\u0002J\u000e\u0010\\\u001a\u00020?2\u0006\u0010]\u001a\u00020^J\u000e\u0010_\u001a\u00020?2\u0006\u0010`\u001a\u00020GJ\u000e\u0010a\u001a\u00020?2\u0006\u0010`\u001a\u00020GJ \u0010b\u001a\u00020?2\u0008\u0010c\u001a\u0004\u0018\u00010G2\u0006\u0010d\u001a\u00020e2\u0006\u0010f\u001a\u00020%J\u001e\u0010g\u001a\u00020?2\u0006\u0010h\u001a\u00020G2\u0006\u0010]\u001a\u00020^2\u0006\u0010i\u001a\u00020GJ\u000e\u0010j\u001a\u00020?2\u0006\u0010f\u001a\u00020#J\u000e\u0010k\u001a\u00020?2\u0006\u0010l\u001a\u00020GJ\u000e\u0010m\u001a\u00020?2\u0006\u0010f\u001a\u000206J\u0008\u0010n\u001a\u00020?H\u0003J\u0008\u0010o\u001a\u00020?H\u0002J\u0008\u0010p\u001a\u00020?H\u0002J\u0008\u0010q\u001a\u00020?H\u0003J\u0008\u0010r\u001a\u00020?H\u0002J\u0008\u0010s\u001a\u00020?H\u0003J\u0008\u0010t\u001a\u00020?H\u0003J\u0008\u0010u\u001a\u00020?H\u0002J\u0008\u0010v\u001a\u00020?H\u0003J\u0006\u0010w\u001a\u00020?J=\u0010x\u001a\u0002Hy\"\u0004\u0008\u0000\u0010y2\u0006\u0010z\u001a\u00020(2\u001c\u0010{\u001a\u0018\u0008\u0001\u0012\n\u0012\u0008\u0012\u0004\u0012\u0002Hy0}\u0012\u0006\u0012\u0004\u0018\u00010~0|H\u0082@\u00f8\u0001\u0000\u00a2\u0006\u0002\u0010\u007fR\u0012\u0010\u0003\u001a\u00060\u0004R\u00020\u0000X\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u001d\u0010\u0005\u001a\u0004\u0018\u00010\u00068BX\u0082\u0084\u0002\u00a2\u0006\u000c\n\u0004\u0008\t\u0010\n\u001a\u0004\u0008\u0007\u0010\u0008R\u0014\u0010\u000b\u001a\u0008\u0012\u0004\u0012\u00020\r0\u000cX\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u0014\u0010\u000e\u001a\u0008\u0012\u0004\u0012\u00020\r0\u000cX\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u0014\u0010\u000f\u001a\u0008\u0012\u0004\u0012\u00020\r0\u000cX\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u0014\u0010\u0010\u001a\u0008\u0012\u0004\u0012\u00020\r0\u000cX\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u0010\u0010\u0011\u001a\u0004\u0018\u00010\u0012X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0013\u001a\u00020\u0014X\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0015\u001a\u00020\u0014X\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0016\u001a\u00020\u0017X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0018\u001a\u00020\u0014X\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0019\u001a\u00020\u0017X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u001a\u001a\u00020\u0014X\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u0014\u0010\u001b\u001a\u0008\u0018\u00010\u001cR\u00020\u0000X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0010\u0010\u001d\u001a\u0004\u0018\u00010\rX\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0010\u0010\u001e\u001a\u0004\u0018\u00010\rX\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0010\u0010\u001f\u001a\u0004\u0018\u00010\rX\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0010\u0010 \u001a\u0004\u0018\u00010\rX\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0014\u0010!\u001a\u0008\u0018\u00010\u001cR\u00020\u0000X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0010\u0010\"\u001a\u0004\u0018\u00010#X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0010\u0010$\u001a\u0004\u0018\u00010%X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0014\u0010&\u001a\u0008\u0018\u00010\u001cR\u00020\u0000X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\'\u001a\u00020(X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0014\u0010)\u001a\u0008\u0018\u00010\u001cR\u00020\u0000X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010*\u001a\u00020(X\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u000e\u0010+\u001a\u00020,X\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u000e\u0010-\u001a\u00020.X\u0082D\u00a2\u0006\u0002\n\u0000R\u000e\u0010/\u001a\u00020.X\u0082D\u00a2\u0006\u0002\n\u0000R\u000e\u00100\u001a\u000201X\u0082D\u00a2\u0006\u0002\n\u0000R\u0010\u00102\u001a\u0004\u0018\u000103X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0010\u00104\u001a\u0004\u0018\u000103X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0010\u00105\u001a\u0004\u0018\u000106X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0010\u00107\u001a\u0004\u0018\u000103X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0010\u00108\u001a\u0004\u0018\u00010\u0012X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0010\u00109\u001a\u0004\u0018\u00010\u0012X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0010\u0010:\u001a\u0004\u0018\u00010\u0012X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0010\u0010;\u001a\u0004\u0018\u00010\u0012X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0010\u0010<\u001a\u0004\u0018\u000103X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0010\u0010=\u001a\u0004\u0018\u00010\u0012X\u0082\u000e\u00a2\u0006\u0002\n\u0000\u0082\u0002\u0004\n\u0002\u0008\u0019\u00a8\u0006\u0084\u0001"
    }
    d2 = {
        "Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;",
        "Landroid/app/Service;",
        "()V",
        "binder",
        "Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$LocalBinder;",
        "bluetoothAdapter",
        "Landroid/bluetooth/BluetoothAdapter;",
        "getBluetoothAdapter",
        "()Landroid/bluetooth/BluetoothAdapter;",
        "bluetoothAdapter$delegate",
        "Lkotlin/Lazy;",
        "connectedAudioSockets",
        "Ljava/util/concurrent/CopyOnWriteArrayList;",
        "Landroid/bluetooth/BluetoothSocket;",
        "connectedFileSockets",
        "connectedMessageSockets",
        "connectedStreamSockets",
        "fileSendJob",
        "Lkotlinx/coroutines/Job;",
        "isAudioServerRunning",
        "Ljava/util/concurrent/atomic/AtomicBoolean;",
        "isFileServerRunning",
        "isFirst",
        "",
        "isMessageServerRunning",
        "isMonitorRunning",
        "isStreamServerRunning",
        "mAudioClientHandlerThread",
        "Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;",
        "mConnectedAudioSocket",
        "mConnectedFileSocket",
        "mConnectedMessageSocket",
        "mConnectedStreamSocket",
        "mFileClientHandlerThread",
        "mFileReceiveListener",
        "Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileReceiveListener;",
        "mFileSendListener",
        "Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileSendListener;",
        "mMessageClientHandlerThread",
        "mMutex",
        "Lkotlinx/coroutines/sync/Mutex;",
        "mStreamClientHandlerThread",
        "mWriteMutex",
        "mainHandler",
        "Landroid/os/Handler;",
        "maxBytes",
        "",
        "maxBytes2",
        "monitorInterval",
        "",
        "serverAudioSocket",
        "Landroid/bluetooth/BluetoothServerSocket;",
        "serverFileSocket",
        "serverListener",
        "Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ServerListener;",
        "serverMessageSocket",
        "serverSocketAudioJob",
        "serverSocketFileJob",
        "serverSocketJob",
        "serverSocketStreamJob",
        "serverStreamSocket",
        "socketMonitorJob",
        "createNotificationChannel",
        "",
        "ensureNotDiscoverable",
        "getConnectDevices",
        "",
        "Landroid/bluetooth/BluetoothDevice;",
        "handleConnectedSocket",
        "socket",
        "type",
        "",
        "hasBluetoothPermissions",
        "isAudioChanelConnect",
        "isDiscoverableEnabled",
        "isFileChanelConnect",
        "isMessageChanelConnect",
        "isSocketAlive",
        "isStreamChanelConnect",
        "makeDeviceDiscoverable",
        "onBind",
        "Landroid/os/IBinder;",
        "intent",
        "Landroid/content/Intent;",
        "onCreate",
        "onDestroy",
        "rejectNewConnection",
        "(Landroid/bluetooth/BluetoothSocket;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;",
        "release",
        "resetFileReceiveState",
        "resetStreamReceiveState",
        "restartServer",
        "sendAudioBroadcast",
        "bytes",
        "",
        "sendBroadcast",
        "message",
        "sendBroadcastV2",
        "sendFileBroadcast",
        "dir",
        "file",
        "Ljava/io/File;",
        "listener",
        "sendStreamBroadcast",
        "tag",
        "clientId",
        "setFileReceiverListener",
        "setSaveFileDirectory",
        "directory",
        "setServerListener",
        "startAudioServer",
        "startDiscovery",
        "startDiscovery2",
        "startFileServer",
        "startForegroundService",
        "startMessageServer",
        "startServer",
        "startSocketMonitor",
        "startStreamServer",
        "stopFileSend",
        "withLockSafe",
        "T",
        "mutex",
        "block",
        "Lkotlin/Function1;",
        "Lkotlin/coroutines/Continuation;",
        "",
        "(Lkotlinx/coroutines/sync/Mutex;Lkotlin/jvm/functions/Function1;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;",
        "ClientHandlerThread",
        "Companion",
        "LocalBinder",
        "ReceiveState",
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
.field private static AUDIO_TYPE:Ljava/lang/String; = null

.field private static final CHANNEL_ID:Ljava/lang/String; = "classic_server_channel"

.field public static final Companion:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$Companion;

.field private static final DISCOVERABLE_DURATION:I = 0x12c

.field private static FILE_TYPE:Ljava/lang/String; = null

.field private static MESSAGE_TYPE:Ljava/lang/String; = null

.field private static NAME:Ljava/lang/String; = null

.field private static final SERVICE_NAME:Ljava/lang/String; = "RokidClassicService"

.field private static final SETTINGS_BT_DISCOVERABLE_ENABLED:Ljava/lang/String; = "bt_discoverable_enabled"

.field private static final SETTINGS_ENABLED_DEFAULT:I = 0x1

.field private static final SPP_UUID_AUDIO_STR:Ljava/lang/String;

.field private static final SPP_UUID_FILE_STR:Ljava/lang/String;

.field private static final SPP_UUID_STR:Ljava/lang/String;

.field private static final SPP_UUID_STREAM_STR:Ljava/lang/String;

.field private static STREAM_TYPE:Ljava/lang/String; = null

.field private static final TAG:Ljava/lang/String; = "ClassicBluetoothService "

.field private static saveDirectory:Ljava/lang/String;


# instance fields
.field private final binder:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$LocalBinder;

.field private final bluetoothAdapter$delegate:Lkotlin/Lazy;

.field private final connectedAudioSockets:Ljava/util/concurrent/CopyOnWriteArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/concurrent/CopyOnWriteArrayList<",
            "Landroid/bluetooth/BluetoothSocket;",
            ">;"
        }
    .end annotation
.end field

.field private final connectedFileSockets:Ljava/util/concurrent/CopyOnWriteArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/concurrent/CopyOnWriteArrayList<",
            "Landroid/bluetooth/BluetoothSocket;",
            ">;"
        }
    .end annotation
.end field

.field private final connectedMessageSockets:Ljava/util/concurrent/CopyOnWriteArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/concurrent/CopyOnWriteArrayList<",
            "Landroid/bluetooth/BluetoothSocket;",
            ">;"
        }
    .end annotation
.end field

.field private final connectedStreamSockets:Ljava/util/concurrent/CopyOnWriteArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/concurrent/CopyOnWriteArrayList<",
            "Landroid/bluetooth/BluetoothSocket;",
            ">;"
        }
    .end annotation
.end field

.field private fileSendJob:Lkotlinx/coroutines/Job;

.field private final isAudioServerRunning:Ljava/util/concurrent/atomic/AtomicBoolean;

.field private final isFileServerRunning:Ljava/util/concurrent/atomic/AtomicBoolean;

.field private isFirst:Z

.field private final isMessageServerRunning:Ljava/util/concurrent/atomic/AtomicBoolean;

.field private isMonitorRunning:Z

.field private final isStreamServerRunning:Ljava/util/concurrent/atomic/AtomicBoolean;

.field private mAudioClientHandlerThread:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;

.field private mConnectedAudioSocket:Landroid/bluetooth/BluetoothSocket;

.field private mConnectedFileSocket:Landroid/bluetooth/BluetoothSocket;

.field private mConnectedMessageSocket:Landroid/bluetooth/BluetoothSocket;

.field private mConnectedStreamSocket:Landroid/bluetooth/BluetoothSocket;

.field private mFileClientHandlerThread:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;

.field private mFileReceiveListener:Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileReceiveListener;

.field private mFileSendListener:Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileSendListener;

.field private mMessageClientHandlerThread:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;

.field private mMutex:Lkotlinx/coroutines/sync/Mutex;

.field private mStreamClientHandlerThread:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;

.field private final mWriteMutex:Lkotlinx/coroutines/sync/Mutex;

.field private final mainHandler:Landroid/os/Handler;

.field private final maxBytes:I

.field private final maxBytes2:I

.field private final monitorInterval:J

.field private serverAudioSocket:Landroid/bluetooth/BluetoothServerSocket;

.field private serverFileSocket:Landroid/bluetooth/BluetoothServerSocket;

.field private serverListener:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ServerListener;

.field private serverMessageSocket:Landroid/bluetooth/BluetoothServerSocket;

.field private serverSocketAudioJob:Lkotlinx/coroutines/Job;

.field private serverSocketFileJob:Lkotlinx/coroutines/Job;

.field private serverSocketJob:Lkotlinx/coroutines/Job;

.field private serverSocketStreamJob:Lkotlinx/coroutines/Job;

.field private serverStreamSocket:Landroid/bluetooth/BluetoothServerSocket;

.field private socketMonitorJob:Lkotlinx/coroutines/Job;


# direct methods
.method public static synthetic $r8$lambda$zmqtOSK-yR9A53FV07Bdb16nR-Q(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;Landroid/bluetooth/BluetoothSocket;)V
    .locals 0

    invoke-static {p0, p1}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->rejectNewConnection$lambda$2(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;Landroid/bluetooth/BluetoothSocket;)V

    return-void
.end method

.method static constructor <clinit>()V
    .locals 3

    new-instance v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$Companion;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$Companion;-><init>(Lkotlin/jvm/internal/DefaultConstructorMarker;)V

    sput-object v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->Companion:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$Companion;

    .line 69
    const-string v0, "00001101-0000-1000-8000-00805F8B341C"

    sput-object v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->SPP_UUID_STR:Ljava/lang/String;

    .line 70
    const-string v0, "00001101-0000-1000-8000-00805F9B341D"

    sput-object v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->SPP_UUID_AUDIO_STR:Ljava/lang/String;

    .line 71
    const-string v0, "00001101-0000-1000-8000-00805F7B341E"

    sput-object v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->SPP_UUID_FILE_STR:Ljava/lang/String;

    .line 72
    const-string v0, "00001101-0000-1000-8000-00805F6B341B"

    sput-object v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->SPP_UUID_STREAM_STR:Ljava/lang/String;

    .line 79
    const-string v0, "GlassesBluetooth_Link"

    sput-object v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->NAME:Ljava/lang/String;

    .line 81
    const-string v0, "MESSAGE"

    sput-object v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->MESSAGE_TYPE:Ljava/lang/String;

    .line 82
    const-string v0, "AUDIO"

    sput-object v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->AUDIO_TYPE:Ljava/lang/String;

    .line 83
    const-string v0, "FILE"

    sput-object v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->FILE_TYPE:Ljava/lang/String;

    .line 84
    const-string v0, "STREAM"

    sput-object v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->STREAM_TYPE:Ljava/lang/String;

    .line 87
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-static {}, Lcom/blankj/utilcode/util/Utils;->getApp()Landroid/app/Application;

    move-result-object v2

    invoke-virtual {v2, v1}, Landroid/app/Application;->getExternalFilesDir(Ljava/lang/String;)Ljava/io/File;

    move-result-object v2

    if-eqz v2, :cond_0

    invoke-virtual {v2}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v1

    :cond_0
    if-nez v1, :cond_1

    const-string v1, ""

    :cond_1
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "/receiver"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->saveDirectory:Ljava/lang/String;

    return-void
.end method

.method public constructor <init>()V
    .locals 4

    .line 62
    invoke-direct {p0}, Landroid/app/Service;-><init>()V

    .line 123
    new-instance v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$LocalBinder;

    invoke-direct {v0, p0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$LocalBinder;-><init>(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;)V

    iput-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->binder:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$LocalBinder;

    .line 124
    sget-object v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$bluetoothAdapter$2;->INSTANCE:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$bluetoothAdapter$2;

    check-cast v0, Lkotlin/jvm/functions/Function0;

    invoke-static {v0}, Lkotlin/LazyKt;->lazy(Lkotlin/jvm/functions/Function0;)Lkotlin/Lazy;

    move-result-object v0

    iput-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->bluetoothAdapter$delegate:Lkotlin/Lazy;

    .line 142
    new-instance v0, Ljava/util/concurrent/CopyOnWriteArrayList;

    invoke-direct {v0}, Ljava/util/concurrent/CopyOnWriteArrayList;-><init>()V

    iput-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->connectedMessageSockets:Ljava/util/concurrent/CopyOnWriteArrayList;

    .line 144
    new-instance v0, Ljava/util/concurrent/CopyOnWriteArrayList;

    invoke-direct {v0}, Ljava/util/concurrent/CopyOnWriteArrayList;-><init>()V

    iput-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->connectedAudioSockets:Ljava/util/concurrent/CopyOnWriteArrayList;

    .line 146
    new-instance v0, Ljava/util/concurrent/CopyOnWriteArrayList;

    invoke-direct {v0}, Ljava/util/concurrent/CopyOnWriteArrayList;-><init>()V

    iput-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->connectedFileSockets:Ljava/util/concurrent/CopyOnWriteArrayList;

    .line 148
    new-instance v0, Ljava/util/concurrent/CopyOnWriteArrayList;

    invoke-direct {v0}, Ljava/util/concurrent/CopyOnWriteArrayList;-><init>()V

    iput-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->connectedStreamSockets:Ljava/util/concurrent/CopyOnWriteArrayList;

    .line 154
    new-instance v0, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    iput-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->mainHandler:Landroid/os/Handler;

    .line 156
    new-instance v0, Ljava/util/concurrent/atomic/AtomicBoolean;

    const/4 v1, 0x1

    invoke-direct {v0, v1}, Ljava/util/concurrent/atomic/AtomicBoolean;-><init>(Z)V

    iput-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->isMessageServerRunning:Ljava/util/concurrent/atomic/AtomicBoolean;

    .line 157
    new-instance v0, Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-direct {v0, v1}, Ljava/util/concurrent/atomic/AtomicBoolean;-><init>(Z)V

    iput-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->isAudioServerRunning:Ljava/util/concurrent/atomic/AtomicBoolean;

    .line 158
    new-instance v0, Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-direct {v0, v1}, Ljava/util/concurrent/atomic/AtomicBoolean;-><init>(Z)V

    iput-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->isStreamServerRunning:Ljava/util/concurrent/atomic/AtomicBoolean;

    .line 159
    new-instance v0, Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-direct {v0, v1}, Ljava/util/concurrent/atomic/AtomicBoolean;-><init>(Z)V

    iput-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->isFileServerRunning:Ljava/util/concurrent/atomic/AtomicBoolean;

    .line 161
    const-wide/16 v2, 0x2710

    iput-wide v2, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->monitorInterval:J

    .line 163
    iput-boolean v1, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->isFirst:Z

    .line 164
    const/4 v0, 0x0

    const/4 v2, 0x0

    invoke-static {v0, v1, v2}, Lkotlinx/coroutines/sync/MutexKt;->Mutex$default(ZILjava/lang/Object;)Lkotlinx/coroutines/sync/Mutex;

    move-result-object v3

    iput-object v3, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->mMutex:Lkotlinx/coroutines/sync/Mutex;

    .line 688
    const v3, 0x8000

    iput v3, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->maxBytes:I

    .line 726
    const v3, 0x4b000

    iput v3, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->maxBytes2:I

    .line 780
    invoke-static {v0, v1, v2}, Lkotlinx/coroutines/sync/MutexKt;->Mutex$default(ZILjava/lang/Object;)Lkotlinx/coroutines/sync/Mutex;

    move-result-object v0

    iput-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->mWriteMutex:Lkotlinx/coroutines/sync/Mutex;

    .line 62
    return-void
.end method

.method public static final synthetic access$getAUDIO_TYPE$cp()Ljava/lang/String;
    .locals 1

    .line 62
    sget-object v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->AUDIO_TYPE:Ljava/lang/String;

    return-object v0
.end method

.method public static final synthetic access$getBluetoothAdapter(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;)Landroid/bluetooth/BluetoothAdapter;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    .line 62
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->getBluetoothAdapter()Landroid/bluetooth/BluetoothAdapter;

    move-result-object v0

    return-object v0
.end method

.method public static final synthetic access$getConnectedAudioSockets$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;)Ljava/util/concurrent/CopyOnWriteArrayList;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    .line 62
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->connectedAudioSockets:Ljava/util/concurrent/CopyOnWriteArrayList;

    return-object v0
.end method

.method public static final synthetic access$getConnectedFileSockets$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;)Ljava/util/concurrent/CopyOnWriteArrayList;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    .line 62
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->connectedFileSockets:Ljava/util/concurrent/CopyOnWriteArrayList;

    return-object v0
.end method

.method public static final synthetic access$getConnectedMessageSockets$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;)Ljava/util/concurrent/CopyOnWriteArrayList;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    .line 62
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->connectedMessageSockets:Ljava/util/concurrent/CopyOnWriteArrayList;

    return-object v0
.end method

.method public static final synthetic access$getConnectedStreamSockets$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;)Ljava/util/concurrent/CopyOnWriteArrayList;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    .line 62
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->connectedStreamSockets:Ljava/util/concurrent/CopyOnWriteArrayList;

    return-object v0
.end method

.method public static final synthetic access$getFILE_TYPE$cp()Ljava/lang/String;
    .locals 1

    .line 62
    sget-object v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->FILE_TYPE:Ljava/lang/String;

    return-object v0
.end method

.method public static final synthetic access$getMConnectedAudioSocket$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;)Landroid/bluetooth/BluetoothSocket;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    .line 62
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->mConnectedAudioSocket:Landroid/bluetooth/BluetoothSocket;

    return-object v0
.end method

.method public static final synthetic access$getMConnectedFileSocket$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;)Landroid/bluetooth/BluetoothSocket;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    .line 62
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->mConnectedFileSocket:Landroid/bluetooth/BluetoothSocket;

    return-object v0
.end method

.method public static final synthetic access$getMConnectedMessageSocket$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;)Landroid/bluetooth/BluetoothSocket;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    .line 62
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->mConnectedMessageSocket:Landroid/bluetooth/BluetoothSocket;

    return-object v0
.end method

.method public static final synthetic access$getMConnectedStreamSocket$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;)Landroid/bluetooth/BluetoothSocket;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    .line 62
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->mConnectedStreamSocket:Landroid/bluetooth/BluetoothSocket;

    return-object v0
.end method

.method public static final synthetic access$getMESSAGE_TYPE$cp()Ljava/lang/String;
    .locals 1

    .line 62
    sget-object v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->MESSAGE_TYPE:Ljava/lang/String;

    return-object v0
.end method

.method public static final synthetic access$getMFileReceiveListener$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;)Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileReceiveListener;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    .line 62
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->mFileReceiveListener:Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileReceiveListener;

    return-object v0
.end method

.method public static final synthetic access$getMMutex$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;)Lkotlinx/coroutines/sync/Mutex;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    .line 62
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->mMutex:Lkotlinx/coroutines/sync/Mutex;

    return-object v0
.end method

.method public static final synthetic access$getMWriteMutex$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;)Lkotlinx/coroutines/sync/Mutex;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    .line 62
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->mWriteMutex:Lkotlinx/coroutines/sync/Mutex;

    return-object v0
.end method

.method public static final synthetic access$getMainHandler$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;)Landroid/os/Handler;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    .line 62
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->mainHandler:Landroid/os/Handler;

    return-object v0
.end method

.method public static final synthetic access$getMaxBytes$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;)I
    .locals 1
    .param p0, "$this"    # Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    .line 62
    iget v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->maxBytes:I

    return v0
.end method

.method public static final synthetic access$getMaxBytes2$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;)I
    .locals 1
    .param p0, "$this"    # Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    .line 62
    iget v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->maxBytes2:I

    return v0
.end method

.method public static final synthetic access$getMonitorInterval$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;)J
    .locals 2
    .param p0, "$this"    # Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    .line 62
    iget-wide v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->monitorInterval:J

    return-wide v0
.end method

.method public static final synthetic access$getSPP_UUID_AUDIO_STR$cp()Ljava/lang/String;
    .locals 1

    .line 62
    sget-object v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->SPP_UUID_AUDIO_STR:Ljava/lang/String;

    return-object v0
.end method

.method public static final synthetic access$getSPP_UUID_FILE_STR$cp()Ljava/lang/String;
    .locals 1

    .line 62
    sget-object v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->SPP_UUID_FILE_STR:Ljava/lang/String;

    return-object v0
.end method

.method public static final synthetic access$getSPP_UUID_STR$cp()Ljava/lang/String;
    .locals 1

    .line 62
    sget-object v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->SPP_UUID_STR:Ljava/lang/String;

    return-object v0
.end method

.method public static final synthetic access$getSPP_UUID_STREAM_STR$cp()Ljava/lang/String;
    .locals 1

    .line 62
    sget-object v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->SPP_UUID_STREAM_STR:Ljava/lang/String;

    return-object v0
.end method

.method public static final synthetic access$getSTREAM_TYPE$cp()Ljava/lang/String;
    .locals 1

    .line 62
    sget-object v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->STREAM_TYPE:Ljava/lang/String;

    return-object v0
.end method

.method public static final synthetic access$getSaveDirectory$cp()Ljava/lang/String;
    .locals 1

    .line 62
    sget-object v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->saveDirectory:Ljava/lang/String;

    return-object v0
.end method

.method public static final synthetic access$getServerAudioSocket$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;)Landroid/bluetooth/BluetoothServerSocket;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    .line 62
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->serverAudioSocket:Landroid/bluetooth/BluetoothServerSocket;

    return-object v0
.end method

.method public static final synthetic access$getServerFileSocket$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;)Landroid/bluetooth/BluetoothServerSocket;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    .line 62
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->serverFileSocket:Landroid/bluetooth/BluetoothServerSocket;

    return-object v0
.end method

.method public static final synthetic access$getServerListener$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;)Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ServerListener;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    .line 62
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->serverListener:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ServerListener;

    return-object v0
.end method

.method public static final synthetic access$getServerMessageSocket$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;)Landroid/bluetooth/BluetoothServerSocket;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    .line 62
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->serverMessageSocket:Landroid/bluetooth/BluetoothServerSocket;

    return-object v0
.end method

.method public static final synthetic access$getServerSocketAudioJob$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;)Lkotlinx/coroutines/Job;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    .line 62
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->serverSocketAudioJob:Lkotlinx/coroutines/Job;

    return-object v0
.end method

.method public static final synthetic access$getServerSocketFileJob$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;)Lkotlinx/coroutines/Job;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    .line 62
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->serverSocketFileJob:Lkotlinx/coroutines/Job;

    return-object v0
.end method

.method public static final synthetic access$getServerSocketJob$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;)Lkotlinx/coroutines/Job;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    .line 62
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->serverSocketJob:Lkotlinx/coroutines/Job;

    return-object v0
.end method

.method public static final synthetic access$getServerSocketStreamJob$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;)Lkotlinx/coroutines/Job;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    .line 62
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->serverSocketStreamJob:Lkotlinx/coroutines/Job;

    return-object v0
.end method

.method public static final synthetic access$getServerStreamSocket$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;)Landroid/bluetooth/BluetoothServerSocket;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    .line 62
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->serverStreamSocket:Landroid/bluetooth/BluetoothServerSocket;

    return-object v0
.end method

.method public static final synthetic access$handleConnectedSocket(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;Landroid/bluetooth/BluetoothSocket;Ljava/lang/String;)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;
    .param p1, "socket"    # Landroid/bluetooth/BluetoothSocket;
    .param p2, "type"    # Ljava/lang/String;

    .line 62
    invoke-direct {p0, p1, p2}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->handleConnectedSocket(Landroid/bluetooth/BluetoothSocket;Ljava/lang/String;)V

    return-void
.end method

.method public static final synthetic access$isAudioServerRunning$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;)Ljava/util/concurrent/atomic/AtomicBoolean;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    .line 62
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->isAudioServerRunning:Ljava/util/concurrent/atomic/AtomicBoolean;

    return-object v0
.end method

.method public static final synthetic access$isFileServerRunning$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;)Ljava/util/concurrent/atomic/AtomicBoolean;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    .line 62
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->isFileServerRunning:Ljava/util/concurrent/atomic/AtomicBoolean;

    return-object v0
.end method

.method public static final synthetic access$isFirst$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;)Z
    .locals 1
    .param p0, "$this"    # Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    .line 62
    iget-boolean v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->isFirst:Z

    return v0
.end method

.method public static final synthetic access$isMessageServerRunning$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;)Ljava/util/concurrent/atomic/AtomicBoolean;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    .line 62
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->isMessageServerRunning:Ljava/util/concurrent/atomic/AtomicBoolean;

    return-object v0
.end method

.method public static final synthetic access$isMonitorRunning$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;)Z
    .locals 1
    .param p0, "$this"    # Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    .line 62
    iget-boolean v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->isMonitorRunning:Z

    return v0
.end method

.method public static final synthetic access$isSocketAlive(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;Landroid/bluetooth/BluetoothSocket;)Z
    .locals 1
    .param p0, "$this"    # Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;
    .param p1, "socket"    # Landroid/bluetooth/BluetoothSocket;

    .line 62
    invoke-direct {p0, p1}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->isSocketAlive(Landroid/bluetooth/BluetoothSocket;)Z

    move-result v0

    return v0
.end method

.method public static final synthetic access$isStreamServerRunning$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;)Ljava/util/concurrent/atomic/AtomicBoolean;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    .line 62
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->isStreamServerRunning:Ljava/util/concurrent/atomic/AtomicBoolean;

    return-object v0
.end method

.method public static final synthetic access$rejectNewConnection(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;Landroid/bluetooth/BluetoothSocket;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;
    .param p1, "socket"    # Landroid/bluetooth/BluetoothSocket;
    .param p2, "$completion"    # Lkotlin/coroutines/Continuation;

    .line 62
    invoke-direct {p0, p1, p2}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->rejectNewConnection(Landroid/bluetooth/BluetoothSocket;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public static final synthetic access$release(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    .line 62
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->release()V

    return-void
.end method

.method public static final synthetic access$restartServer(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    .line 62
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->restartServer()V

    return-void
.end method

.method public static final synthetic access$setAUDIO_TYPE$cp(Ljava/lang/String;)V
    .locals 0
    .param p0, "<set-?>"    # Ljava/lang/String;

    .line 62
    sput-object p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->AUDIO_TYPE:Ljava/lang/String;

    return-void
.end method

.method public static final synthetic access$setFILE_TYPE$cp(Ljava/lang/String;)V
    .locals 0
    .param p0, "<set-?>"    # Ljava/lang/String;

    .line 62
    sput-object p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->FILE_TYPE:Ljava/lang/String;

    return-void
.end method

.method public static final synthetic access$setFileSendJob$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;Lkotlinx/coroutines/Job;)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;
    .param p1, "<set-?>"    # Lkotlinx/coroutines/Job;

    .line 62
    iput-object p1, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->fileSendJob:Lkotlinx/coroutines/Job;

    return-void
.end method

.method public static final synthetic access$setFirst$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;Z)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;
    .param p1, "<set-?>"    # Z

    .line 62
    iput-boolean p1, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->isFirst:Z

    return-void
.end method

.method public static final synthetic access$setMConnectedAudioSocket$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;Landroid/bluetooth/BluetoothSocket;)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;
    .param p1, "<set-?>"    # Landroid/bluetooth/BluetoothSocket;

    .line 62
    iput-object p1, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->mConnectedAudioSocket:Landroid/bluetooth/BluetoothSocket;

    return-void
.end method

.method public static final synthetic access$setMConnectedFileSocket$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;Landroid/bluetooth/BluetoothSocket;)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;
    .param p1, "<set-?>"    # Landroid/bluetooth/BluetoothSocket;

    .line 62
    iput-object p1, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->mConnectedFileSocket:Landroid/bluetooth/BluetoothSocket;

    return-void
.end method

.method public static final synthetic access$setMConnectedMessageSocket$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;Landroid/bluetooth/BluetoothSocket;)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;
    .param p1, "<set-?>"    # Landroid/bluetooth/BluetoothSocket;

    .line 62
    iput-object p1, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->mConnectedMessageSocket:Landroid/bluetooth/BluetoothSocket;

    return-void
.end method

.method public static final synthetic access$setMConnectedStreamSocket$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;Landroid/bluetooth/BluetoothSocket;)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;
    .param p1, "<set-?>"    # Landroid/bluetooth/BluetoothSocket;

    .line 62
    iput-object p1, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->mConnectedStreamSocket:Landroid/bluetooth/BluetoothSocket;

    return-void
.end method

.method public static final synthetic access$setMESSAGE_TYPE$cp(Ljava/lang/String;)V
    .locals 0
    .param p0, "<set-?>"    # Ljava/lang/String;

    .line 62
    sput-object p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->MESSAGE_TYPE:Ljava/lang/String;

    return-void
.end method

.method public static final synthetic access$setSTREAM_TYPE$cp(Ljava/lang/String;)V
    .locals 0
    .param p0, "<set-?>"    # Ljava/lang/String;

    .line 62
    sput-object p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->STREAM_TYPE:Ljava/lang/String;

    return-void
.end method

.method public static final synthetic access$setSaveDirectory$cp(Ljava/lang/String;)V
    .locals 0
    .param p0, "<set-?>"    # Ljava/lang/String;

    .line 62
    sput-object p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->saveDirectory:Ljava/lang/String;

    return-void
.end method

.method public static final synthetic access$setServerAudioSocket$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;Landroid/bluetooth/BluetoothServerSocket;)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;
    .param p1, "<set-?>"    # Landroid/bluetooth/BluetoothServerSocket;

    .line 62
    iput-object p1, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->serverAudioSocket:Landroid/bluetooth/BluetoothServerSocket;

    return-void
.end method

.method public static final synthetic access$setServerFileSocket$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;Landroid/bluetooth/BluetoothServerSocket;)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;
    .param p1, "<set-?>"    # Landroid/bluetooth/BluetoothServerSocket;

    .line 62
    iput-object p1, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->serverFileSocket:Landroid/bluetooth/BluetoothServerSocket;

    return-void
.end method

.method public static final synthetic access$setServerMessageSocket$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;Landroid/bluetooth/BluetoothServerSocket;)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;
    .param p1, "<set-?>"    # Landroid/bluetooth/BluetoothServerSocket;

    .line 62
    iput-object p1, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->serverMessageSocket:Landroid/bluetooth/BluetoothServerSocket;

    return-void
.end method

.method public static final synthetic access$setServerStreamSocket$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;Landroid/bluetooth/BluetoothServerSocket;)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;
    .param p1, "<set-?>"    # Landroid/bluetooth/BluetoothServerSocket;

    .line 62
    iput-object p1, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->serverStreamSocket:Landroid/bluetooth/BluetoothServerSocket;

    return-void
.end method

.method public static final synthetic access$startAudioServer(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    .line 62
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->startAudioServer()V

    return-void
.end method

.method public static final synthetic access$startDiscovery(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    .line 62
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->startDiscovery()V

    return-void
.end method

.method public static final synthetic access$startDiscovery2(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    .line 62
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->startDiscovery2()V

    return-void
.end method

.method public static final synthetic access$startFileServer(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    .line 62
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->startFileServer()V

    return-void
.end method

.method public static final synthetic access$startStreamServer(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    .line 62
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->startStreamServer()V

    return-void
.end method

.method public static final synthetic access$withLockSafe(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;Lkotlinx/coroutines/sync/Mutex;Lkotlin/jvm/functions/Function1;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;
    .param p1, "mutex"    # Lkotlinx/coroutines/sync/Mutex;
    .param p2, "block"    # Lkotlin/jvm/functions/Function1;
    .param p3, "$completion"    # Lkotlin/coroutines/Continuation;

    .line 62
    invoke-direct {p0, p1, p2, p3}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->withLockSafe(Lkotlinx/coroutines/sync/Mutex;Lkotlin/jvm/functions/Function1;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method private final createNotificationChannel()V
    .locals 3

    .line 284
    new-instance v0, Landroidx/core/app/NotificationChannelCompat$Builder;

    .line 285
    nop

    .line 286
    nop

    .line 284
    const-string v1, "classic_server_channel"

    const/4 v2, 0x4

    invoke-direct {v0, v1, v2}, Landroidx/core/app/NotificationChannelCompat$Builder;-><init>(Ljava/lang/String;I)V

    .line 288
    const-string v1, "Classic Server channel"

    check-cast v1, Ljava/lang/CharSequence;

    invoke-virtual {v0, v1}, Landroidx/core/app/NotificationChannelCompat$Builder;->setName(Ljava/lang/CharSequence;)Landroidx/core/app/NotificationChannelCompat$Builder;

    move-result-object v0

    .line 289
    const-string v1, "Classic for the Classic server sample"

    invoke-virtual {v0, v1}, Landroidx/core/app/NotificationChannelCompat$Builder;->setDescription(Ljava/lang/String;)Landroidx/core/app/NotificationChannelCompat$Builder;

    move-result-object v0

    .line 290
    invoke-virtual {v0}, Landroidx/core/app/NotificationChannelCompat$Builder;->build()Landroidx/core/app/NotificationChannelCompat;

    move-result-object v0

    const-string v1, "Builder(\n            CHA\u2026le\")\n            .build()"

    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 284
    nop

    .line 291
    .local v0, "channel":Landroidx/core/app/NotificationChannelCompat;
    move-object v1, p0

    check-cast v1, Landroid/content/Context;

    invoke-static {v1}, Landroidx/core/app/NotificationManagerCompat;->from(Landroid/content/Context;)Landroidx/core/app/NotificationManagerCompat;

    move-result-object v1

    invoke-virtual {v1, v0}, Landroidx/core/app/NotificationManagerCompat;->createNotificationChannel(Landroidx/core/app/NotificationChannelCompat;)V

    .line 292
    return-void
.end method

.method private final getBluetoothAdapter()Landroid/bluetooth/BluetoothAdapter;
    .locals 1

    .line 124
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->bluetoothAdapter$delegate:Lkotlin/Lazy;

    invoke-interface {v0}, Lkotlin/Lazy;->getValue()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/bluetooth/BluetoothAdapter;

    return-object v0
.end method

.method private final handleConnectedSocket(Landroid/bluetooth/BluetoothSocket;Ljava/lang/String;)V
    .locals 2
    .param p1, "socket"    # Landroid/bluetooth/BluetoothSocket;
    .param p2, "type"    # Ljava/lang/String;

    .line 654
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " --- Connected   hashcode = "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {p1}, Landroid/bluetooth/BluetoothSocket;->hashCode()I

    move-result v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v0

    const-string v1, "ClassicBluetoothService "

    invoke-static {v1, v0}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 655
    sget-object v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->AUDIO_TYPE:Ljava/lang/String;

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    const/4 v1, 0x0

    if-eqz v0, :cond_1

    .line 656
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->mAudioClientHandlerThread:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->shutdown()V

    .line 657
    :cond_0
    iput-object v1, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->mAudioClientHandlerThread:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;

    .line 658
    new-instance v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;

    invoke-direct {v0, p0, p1, p2}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;-><init>(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;Landroid/bluetooth/BluetoothSocket;Ljava/lang/String;)V

    iput-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->mAudioClientHandlerThread:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;

    .line 659
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->mAudioClientHandlerThread:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;

    if-eqz v0, :cond_7

    invoke-virtual {v0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->start()V

    goto :goto_0

    .line 660
    :cond_1
    sget-object v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->MESSAGE_TYPE:Ljava/lang/String;

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_3

    .line 661
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->mMessageClientHandlerThread:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;

    if-eqz v0, :cond_2

    invoke-virtual {v0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->shutdown()V

    .line 662
    :cond_2
    iput-object v1, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->mMessageClientHandlerThread:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;

    .line 663
    new-instance v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;

    invoke-direct {v0, p0, p1, p2}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;-><init>(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;Landroid/bluetooth/BluetoothSocket;Ljava/lang/String;)V

    iput-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->mMessageClientHandlerThread:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;

    .line 664
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->mMessageClientHandlerThread:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;

    if-eqz v0, :cond_7

    invoke-virtual {v0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->start()V

    goto :goto_0

    .line 665
    :cond_3
    sget-object v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->FILE_TYPE:Ljava/lang/String;

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_5

    .line 666
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->mFileClientHandlerThread:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;

    if-eqz v0, :cond_4

    invoke-virtual {v0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->shutdown()V

    .line 667
    :cond_4
    iput-object v1, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->mFileClientHandlerThread:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;

    .line 668
    new-instance v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;

    invoke-direct {v0, p0, p1, p2}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;-><init>(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;Landroid/bluetooth/BluetoothSocket;Ljava/lang/String;)V

    iput-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->mFileClientHandlerThread:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;

    .line 669
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->mFileClientHandlerThread:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;

    if-eqz v0, :cond_7

    invoke-virtual {v0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->start()V

    goto :goto_0

    .line 671
    :cond_5
    sget-object v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->STREAM_TYPE:Ljava/lang/String;

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_7

    .line 672
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->mStreamClientHandlerThread:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;

    if-eqz v0, :cond_6

    invoke-virtual {v0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->shutdown()V

    .line 673
    :cond_6
    iput-object v1, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->mStreamClientHandlerThread:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;

    .line 674
    new-instance v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;

    invoke-direct {v0, p0, p1, p2}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;-><init>(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;Landroid/bluetooth/BluetoothSocket;Ljava/lang/String;)V

    iput-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->mStreamClientHandlerThread:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;

    .line 675
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->mStreamClientHandlerThread:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;

    if-eqz v0, :cond_7

    invoke-virtual {v0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->start()V

    .line 679
    :cond_7
    :goto_0
    return-void
.end method

.method private final hasBluetoothPermissions()Z
    .locals 3

    .line 645
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x1f

    const/4 v2, 0x1

    if-lt v0, v1, :cond_1

    .line 646
    const-string v0, "android.permission.BLUETOOTH_CONNECT"

    invoke-virtual {p0, v0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->checkSelfPermission(Ljava/lang/String;)I

    move-result v0

    if-nez v0, :cond_0

    goto :goto_0

    :cond_0
    const/4 v2, 0x0

    goto :goto_0

    .line 648
    :cond_1
    nop

    .line 645
    :goto_0
    return v2
.end method

.method private final isSocketAlive(Landroid/bluetooth/BluetoothSocket;)Z
    .locals 6
    .param p1, "socket"    # Landroid/bluetooth/BluetoothSocket;

    .line 382
    const-string v0, "ClassicBluetoothService "

    .line 384
    const/4 v1, 0x0

    :try_start_0
    invoke-virtual {p1}, Landroid/bluetooth/BluetoothSocket;->isConnected()Z

    move-result v2

    .line 386
    .local v2, "isConnected":Z
    if-nez v2, :cond_0

    .line 387
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "isSocketAlive -> \u57fa\u7840\u68c0\u67e5\u5931\u8d25: connected="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    filled-new-array {v3}, [Ljava/lang/Object;

    move-result-object v3

    invoke-static {v0, v3}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 388
    return v1

    .line 391
    :cond_0
    invoke-virtual {p1}, Landroid/bluetooth/BluetoothSocket;->getRemoteDevice()Landroid/bluetooth/BluetoothDevice;

    move-result-object v3

    if-nez v3, :cond_1

    .line 392
    const-string v3, "isSocketAlive -> \u8fdc\u7a0b\u8bbe\u5907\u4e3a\u7a7a"

    filled-new-array {v3}, [Ljava/lang/Object;

    move-result-object v3

    invoke-static {v0, v3}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->i(Ljava/lang/String;[Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_1

    .line 393
    return v1

    .line 397
    :cond_1
    nop

    .line 399
    :try_start_1
    invoke-virtual {p1}, Landroid/bluetooth/BluetoothSocket;->getInputStream()Ljava/io/InputStream;

    move-result-object v3

    invoke-virtual {v3}, Ljava/io/InputStream;->available()I

    move-result v3

    .line 400
    .local v3, "available":I
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "isSocketAlive -> available()\u6210\u529f, \u53ef\u8bfb\u5b57\u8282: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    filled-new-array {v4}, [Ljava/lang/Object;

    move-result-object v4

    invoke-static {v0, v4}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->d(Ljava/lang/String;[Ljava/lang/Object;)V
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_0
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_1

    .line 401
    nop

    .end local v3    # "available":I
    const/4 v3, 0x1

    goto :goto_0

    .line 402
    :catch_0
    move-exception v3

    .line 403
    .local v3, "e":Ljava/io/IOException;
    :try_start_2
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "isSocketAlive -> available()\u5f02\u5e38: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v3}, Ljava/io/IOException;->getMessage()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    filled-new-array {v4}, [Ljava/lang/Object;

    move-result-object v4

    invoke-static {v0, v4}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 404
    move v3, v1

    .line 397
    .end local v3    # "e":Ljava/io/IOException;
    :goto_0
    nop

    .line 407
    .local v3, "connectionOk":Z
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "isSocketAlive -> \u6700\u7ec8\u7ed3\u679c: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v3}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    filled-new-array {v4}, [Ljava/lang/Object;

    move-result-object v4

    invoke-static {v0, v4}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->i(Ljava/lang/String;[Ljava/lang/Object;)V
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_1

    .line 408
    move v1, v3

    .end local v2    # "isConnected":Z
    .end local v3    # "connectionOk":Z
    goto :goto_1

    .line 410
    :catch_1
    move-exception v2

    .line 411
    .local v2, "e":Ljava/lang/Exception;
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "isSocketAlive -> \u5916\u5c42\u5f02\u5e38: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v2}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    filled-new-array {v3}, [Ljava/lang/Object;

    move-result-object v3

    invoke-static {v0, v3}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 412
    nop

    .line 382
    .end local v2    # "e":Ljava/lang/Exception;
    :goto_1
    return v1
.end method

.method private final rejectNewConnection(Landroid/bluetooth/BluetoothSocket;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;
    .locals 11
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/bluetooth/BluetoothSocket;",
            "Lkotlin/coroutines/Continuation<",
            "-",
            "Lkotlin/Unit;",
            ">;)",
            "Ljava/lang/Object;"
        }
    .end annotation

    instance-of v0, p2, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$rejectNewConnection$1;

    if-eqz v0, :cond_0

    move-object v0, p2

    check-cast v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$rejectNewConnection$1;

    iget v1, v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$rejectNewConnection$1;->label:I

    const/high16 v2, -0x80000000

    and-int/2addr v1, v2

    if-eqz v1, :cond_0

    iget p2, v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$rejectNewConnection$1;->label:I

    sub-int/2addr p2, v2

    iput p2, v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$rejectNewConnection$1;->label:I

    goto :goto_0

    :cond_0
    new-instance v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$rejectNewConnection$1;

    invoke-direct {v0, p0, p2}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$rejectNewConnection$1;-><init>(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;Lkotlin/coroutines/Continuation;)V

    :goto_0
    move-object p2, v0

    .local p2, "$continuation":Lkotlin/coroutines/Continuation;
    iget-object v0, p2, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$rejectNewConnection$1;->result:Ljava/lang/Object;

    .local v0, "$result":Ljava/lang/Object;
    invoke-static {}, Lkotlin/coroutines/intrinsics/IntrinsicsKt;->getCOROUTINE_SUSPENDED()Ljava/lang/Object;

    move-result-object v1

    .line 609
    iget v2, p2, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$rejectNewConnection$1;->label:I

    const-string v3, "\u5173\u95ed\u62d2\u7edd\u7684socket\u5931\u8d25: "

    const-string v4, "ClassicBluetoothService "

    packed-switch v2, :pswitch_data_0

    .end local v0    # "$result":Ljava/lang/Object;
    .end local p2    # "$continuation":Lkotlin/coroutines/Continuation;
    new-instance p1, Ljava/lang/IllegalStateException;

    const-string p2, "call to \'resume\' before \'invoke\' with coroutine"

    invoke-direct {p1, p2}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p1

    .restart local v0    # "$result":Ljava/lang/Object;
    .restart local p2    # "$continuation":Lkotlin/coroutines/Continuation;
    :pswitch_0
    iget-object p1, p2, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$rejectNewConnection$1;->L$1:Ljava/lang/Object;

    check-cast p1, Landroid/bluetooth/BluetoothSocket;

    .local p1, "socket":Landroid/bluetooth/BluetoothSocket;
    iget-object v1, p2, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$rejectNewConnection$1;->L$0:Ljava/lang/Object;

    check-cast v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    .local v1, "this":Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;
    :try_start_0
    invoke-static {v0}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto/16 :goto_3

    .line 630
    :catchall_0
    move-exception v2

    goto/16 :goto_9

    .line 626
    :catch_0
    move-exception v2

    goto/16 :goto_6

    .line 609
    .end local v1    # "this":Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;
    .end local p1    # "socket":Landroid/bluetooth/BluetoothSocket;
    :pswitch_1
    invoke-static {v0}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    move-object v2, p0

    .line 610
    .local v2, "this":Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;
    .restart local p1    # "socket":Landroid/bluetooth/BluetoothSocket;
    const-string v5, "rejectNewConnection: "

    filled-new-array {v5}, [Ljava/lang/Object;

    move-result-object v5

    invoke-static {v4, v5}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 611
    nop

    .line 613
    :try_start_1
    invoke-virtual {p1}, Landroid/bluetooth/BluetoothSocket;->getOutputStream()Ljava/io/OutputStream;

    move-result-object v5

    .line 614
    .local v5, "outputStream":Ljava/io/OutputStream;
    iget-object v6, v2, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->mConnectedMessageSocket:Landroid/bluetooth/BluetoothSocket;

    const/4 v7, 0x0

    if-eqz v6, :cond_1

    invoke-virtual {v6}, Landroid/bluetooth/BluetoothSocket;->getRemoteDevice()Landroid/bluetooth/BluetoothDevice;

    move-result-object v6

    if-eqz v6, :cond_1

    invoke-virtual {v6}, Landroid/bluetooth/BluetoothDevice;->getName()Ljava/lang/String;

    move-result-object v6
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_2
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    goto :goto_1

    :cond_1
    move-object v6, v7

    :goto_1
    const-string v8, ""

    if-nez v6, :cond_2

    move-object v6, v8

    .line 615
    .local v6, "currentConnectedName":Ljava/lang/String;
    :cond_2
    :try_start_2
    invoke-virtual {p1}, Landroid/bluetooth/BluetoothSocket;->getRemoteDevice()Landroid/bluetooth/BluetoothDevice;

    move-result-object v9

    if-eqz v9, :cond_3

    invoke-virtual {v9}, Landroid/bluetooth/BluetoothDevice;->getName()Ljava/lang/String;

    move-result-object v7

    :cond_3
    if-nez v7, :cond_4

    goto :goto_2

    :cond_4
    move-object v8, v7

    :goto_2
    move-object v7, v8

    .line 616
    .local v7, "name":Ljava/lang/String;
    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, "\u670d\u52a1\u5668\u5df2\u8fde\u63a5\u5176\u4ed6\u8bbe\u5907"

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    const-string v9, "\uff0c\u65e0\u6cd5\u63a5\u53d7\u65b0\u8fde\u63a5--code = -1"

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    move-object v6, v8

    .line 617
    .local v6, "rejectionMessage":Ljava/lang/String;
    sget-object v8, Lkotlin/text/Charsets;->UTF_8:Ljava/nio/charset/Charset;

    invoke-virtual {v6, v8}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B

    move-result-object v8

    const-string v9, "this as java.lang.String).getBytes(charset)"

    invoke-static {v8, v9}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .end local v6    # "rejectionMessage":Ljava/lang/String;
    move-object v6, v8

    .line 618
    .local v6, "payload":[B
    array-length v8, v6

    add-int/lit8 v8, v8, 0x2

    invoke-static {v8}, Ljava/nio/ByteBuffer;->allocate(I)Ljava/nio/ByteBuffer;

    move-result-object v8

    .line 619
    .local v8, "buffer":Ljava/nio/ByteBuffer;
    array-length v9, v6

    int-to-short v9, v9

    invoke-virtual {v8, v9}, Ljava/nio/ByteBuffer;->putShort(S)Ljava/nio/ByteBuffer;

    .line 620
    invoke-virtual {v8, v6}, Ljava/nio/ByteBuffer;->put([B)Ljava/nio/ByteBuffer;

    .line 621
    nop

    .end local v6    # "payload":[B
    if-eqz v5, :cond_5

    invoke-virtual {v8}, Ljava/nio/ByteBuffer;->array()[B

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/io/OutputStream;->write([B)V

    nop

    .line 622
    .end local v8    # "buffer":Ljava/nio/ByteBuffer;
    :cond_5
    if-eqz v5, :cond_6

    invoke-virtual {v5}, Ljava/io/OutputStream;->flush()V

    nop

    .line 623
    .end local v5    # "outputStream":Ljava/io/OutputStream;
    :cond_6
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "\u670d\u52a1\u5668\u5df2\u8fde\u63a5\u5176\u4ed6\u8bbe\u5907,\u5df2\u62d2\u7edd\u65b0\u8fde\u63a5: "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    filled-new-array {v5}, [Ljava/lang/Object;

    move-result-object v5

    .end local v7    # "name":Ljava/lang/String;
    invoke-static {v4, v5}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 625
    iput-object v2, p2, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$rejectNewConnection$1;->L$0:Ljava/lang/Object;

    iput-object p1, p2, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$rejectNewConnection$1;->L$1:Ljava/lang/Object;

    const/4 v5, 0x1

    iput v5, p2, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$rejectNewConnection$1;->label:I

    const-wide/16 v5, 0x12c

    invoke-static {v5, v6, p2}, Lkotlinx/coroutines/DelayKt;->delay(JLkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v5
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    if-ne v5, v1, :cond_7

    .line 609
    return-object v1

    .line 625
    :cond_7
    move-object v1, v2

    .line 630
    .end local v2    # "this":Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;
    .restart local v1    # "this":Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;
    :goto_3
    nop

    .line 632
    :try_start_3
    invoke-virtual {p1}, Landroid/bluetooth/BluetoothSocket;->close()V
    :try_end_3
    .catch Ljava/io/IOException; {:try_start_3 .. :try_end_3} :catch_1

    goto :goto_4

    .line 633
    :catch_1
    move-exception v2

    .line 634
    .local v2, "e":Ljava/io/IOException;
    invoke-virtual {v2}, Ljava/io/IOException;->printStackTrace()V

    .line 635
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v5, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v2}, Ljava/io/IOException;->getMessage()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v3, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    filled-new-array {v3}, [Ljava/lang/Object;

    move-result-object v3

    invoke-static {v4, v3}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 638
    .end local v2    # "e":Ljava/io/IOException;
    :goto_4
    iget-object v2, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->mainHandler:Landroid/os/Handler;

    new-instance v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$$ExternalSyntheticLambda0;

    invoke-direct {v3, v1, p1}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$$ExternalSyntheticLambda0;-><init>(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;Landroid/bluetooth/BluetoothSocket;)V

    :goto_5
    invoke-virtual {v2, v3}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    .line 641
    .end local v1    # "this":Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;
    .end local p1    # "socket":Landroid/bluetooth/BluetoothSocket;
    goto :goto_8

    .line 630
    .local v2, "this":Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;
    .restart local p1    # "socket":Landroid/bluetooth/BluetoothSocket;
    :catchall_1
    move-exception v1

    move-object v10, v2

    move-object v2, v1

    move-object v1, v10

    goto :goto_9

    .line 626
    :catch_2
    move-exception v1

    move-object v10, v2

    move-object v2, v1

    move-object v1, v10

    .line 627
    .restart local v1    # "this":Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;
    .local v2, "e":Ljava/lang/Exception;
    :goto_6
    :try_start_4
    invoke-virtual {v2}, Ljava/lang/Exception;->printStackTrace()V

    .line 628
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "\u53d1\u9001\u62d2\u7edd\u6d88\u606f\u5931\u8d25: "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v2}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    filled-new-array {v5}, [Ljava/lang/Object;

    move-result-object v5

    invoke-static {v4, v5}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->e(Ljava/lang/String;[Ljava/lang/Object;)V
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    .line 630
    .end local v2    # "e":Ljava/lang/Exception;
    nop

    .line 632
    :try_start_5
    invoke-virtual {p1}, Landroid/bluetooth/BluetoothSocket;->close()V
    :try_end_5
    .catch Ljava/io/IOException; {:try_start_5 .. :try_end_5} :catch_3

    goto :goto_7

    .line 633
    :catch_3
    move-exception v2

    .line 634
    .local v2, "e":Ljava/io/IOException;
    invoke-virtual {v2}, Ljava/io/IOException;->printStackTrace()V

    .line 635
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v5, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v2}, Ljava/io/IOException;->getMessage()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v3, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    filled-new-array {v3}, [Ljava/lang/Object;

    move-result-object v3

    invoke-static {v4, v3}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 638
    .end local v2    # "e":Ljava/io/IOException;
    :goto_7
    iget-object v2, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->mainHandler:Landroid/os/Handler;

    new-instance v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$$ExternalSyntheticLambda0;

    invoke-direct {v3, v1, p1}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$$ExternalSyntheticLambda0;-><init>(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;Landroid/bluetooth/BluetoothSocket;)V

    goto :goto_5

    .line 642
    .end local v1    # "this":Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;
    .end local p1    # "socket":Landroid/bluetooth/BluetoothSocket;
    :goto_8
    sget-object p1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    return-object p1

    .line 632
    .restart local v1    # "this":Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;
    .restart local p1    # "socket":Landroid/bluetooth/BluetoothSocket;
    :goto_9
    :try_start_6
    invoke-virtual {p1}, Landroid/bluetooth/BluetoothSocket;->close()V
    :try_end_6
    .catch Ljava/io/IOException; {:try_start_6 .. :try_end_6} :catch_4

    goto :goto_a

    .line 633
    :catch_4
    move-exception v5

    .line 634
    .local v5, "e":Ljava/io/IOException;
    invoke-virtual {v5}, Ljava/io/IOException;->printStackTrace()V

    .line 635
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v6, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v5}, Ljava/io/IOException;->getMessage()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v3, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    filled-new-array {v3}, [Ljava/lang/Object;

    move-result-object v3

    invoke-static {v4, v3}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 638
    .end local v5    # "e":Ljava/io/IOException;
    :goto_a
    iget-object v3, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->mainHandler:Landroid/os/Handler;

    new-instance v4, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$$ExternalSyntheticLambda0;

    invoke-direct {v4, v1, p1}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$$ExternalSyntheticLambda0;-><init>(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;Landroid/bluetooth/BluetoothSocket;)V

    invoke-virtual {v3, v4}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    .end local v1    # "this":Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;
    .end local p1    # "socket":Landroid/bluetooth/BluetoothSocket;
    throw v2

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method private static final rejectNewConnection$lambda$2(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;Landroid/bluetooth/BluetoothSocket;)V
    .locals 3
    .param p0, "this$0"    # Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;
    .param p1, "$socket"    # Landroid/bluetooth/BluetoothSocket;

    const-string v0, "this$0"

    invoke-static {p0, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "$socket"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 639
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->serverListener:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ServerListener;

    if-eqz v0, :cond_0

    invoke-virtual {p1}, Landroid/bluetooth/BluetoothSocket;->getRemoteDevice()Landroid/bluetooth/BluetoothDevice;

    move-result-object v1

    const-string v2, "socket.remoteDevice"

    invoke-static {v1, v2}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-interface {v0, v1}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ServerListener;->onConnectionRejected(Landroid/bluetooth/BluetoothDevice;)V

    .line 640
    :cond_0
    return-void
.end method

.method private final release()V
    .locals 8

    .line 1005
    nop

    .line 1006
    :try_start_0
    monitor-enter p0
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    const/4 v0, 0x0

    .line 1007
    .local v0, "$i$a$-synchronized-ClassicBluetoothService$release$1":I
    :try_start_1
    iget-object v1, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->isMessageServerRunning:Ljava/util/concurrent/atomic/AtomicBoolean;

    const/4 v2, 0x0

    invoke-virtual {v1, v2}, Ljava/util/concurrent/atomic/AtomicBoolean;->set(Z)V

    .line 1008
    iget-object v1, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->isAudioServerRunning:Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-virtual {v1, v2}, Ljava/util/concurrent/atomic/AtomicBoolean;->set(Z)V

    .line 1009
    iget-object v1, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->isStreamServerRunning:Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-virtual {v1, v2}, Ljava/util/concurrent/atomic/AtomicBoolean;->set(Z)V

    .line 1010
    iget-object v1, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->isFileServerRunning:Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-virtual {v1, v2}, Ljava/util/concurrent/atomic/AtomicBoolean;->set(Z)V

    .line 1012
    iget-object v1, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->serverMessageSocket:Landroid/bluetooth/BluetoothServerSocket;

    if-eqz v1, :cond_0

    invoke-virtual {v1}, Landroid/bluetooth/BluetoothServerSocket;->close()V

    .line 1013
    :cond_0
    iget-object v1, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->serverAudioSocket:Landroid/bluetooth/BluetoothServerSocket;

    if-eqz v1, :cond_1

    invoke-virtual {v1}, Landroid/bluetooth/BluetoothServerSocket;->close()V

    .line 1014
    :cond_1
    iget-object v1, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->serverStreamSocket:Landroid/bluetooth/BluetoothServerSocket;

    if-eqz v1, :cond_2

    invoke-virtual {v1}, Landroid/bluetooth/BluetoothServerSocket;->close()V

    .line 1015
    :cond_2
    iget-object v1, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->serverFileSocket:Landroid/bluetooth/BluetoothServerSocket;

    if-eqz v1, :cond_3

    invoke-virtual {v1}, Landroid/bluetooth/BluetoothServerSocket;->close()V

    .line 1017
    :cond_3
    const/4 v1, 0x0

    iput-object v1, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->serverMessageSocket:Landroid/bluetooth/BluetoothServerSocket;

    .line 1018
    iput-object v1, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->serverAudioSocket:Landroid/bluetooth/BluetoothServerSocket;

    .line 1019
    iput-object v1, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->serverStreamSocket:Landroid/bluetooth/BluetoothServerSocket;

    .line 1020
    iput-object v1, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->serverFileSocket:Landroid/bluetooth/BluetoothServerSocket;

    .line 1022
    iget-object v2, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->connectedMessageSockets:Ljava/util/concurrent/CopyOnWriteArrayList;

    check-cast v2, Ljava/lang/Iterable;

    .local v2, "$this$forEach$iv":Ljava/lang/Iterable;
    const/4 v3, 0x0

    .line 1608
    .local v3, "$i$f$forEach":I
    invoke-interface {v2}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v4

    :goto_0
    invoke-interface {v4}, Ljava/util/Iterator;->hasNext()Z

    move-result v5

    if-eqz v5, :cond_4

    invoke-interface {v4}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v5

    .local v5, "element$iv":Ljava/lang/Object;
    move-object v6, v5

    check-cast v6, Landroid/bluetooth/BluetoothSocket;

    .local v6, "it":Landroid/bluetooth/BluetoothSocket;
    const/4 v7, 0x0

    .line 1022
    .local v7, "$i$a$-forEach-ClassicBluetoothService$release$1$1":I
    invoke-virtual {v6}, Landroid/bluetooth/BluetoothSocket;->close()V

    .line 1608
    .end local v6    # "it":Landroid/bluetooth/BluetoothSocket;
    .end local v7    # "$i$a$-forEach-ClassicBluetoothService$release$1$1":I
    nop

    .end local v5    # "element$iv":Ljava/lang/Object;
    goto :goto_0

    .line 1609
    :cond_4
    nop

    .line 1023
    .end local v2    # "$this$forEach$iv":Ljava/lang/Iterable;
    .end local v3    # "$i$f$forEach":I
    iget-object v2, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->connectedMessageSockets:Ljava/util/concurrent/CopyOnWriteArrayList;

    invoke-virtual {v2}, Ljava/util/concurrent/CopyOnWriteArrayList;->clear()V

    .line 1024
    iget-object v2, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->connectedAudioSockets:Ljava/util/concurrent/CopyOnWriteArrayList;

    check-cast v2, Ljava/lang/Iterable;

    .restart local v2    # "$this$forEach$iv":Ljava/lang/Iterable;
    const/4 v3, 0x0

    .line 1610
    .restart local v3    # "$i$f$forEach":I
    invoke-interface {v2}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v4

    :goto_1
    invoke-interface {v4}, Ljava/util/Iterator;->hasNext()Z

    move-result v5

    if-eqz v5, :cond_5

    invoke-interface {v4}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v5

    .restart local v5    # "element$iv":Ljava/lang/Object;
    move-object v6, v5

    check-cast v6, Landroid/bluetooth/BluetoothSocket;

    .restart local v6    # "it":Landroid/bluetooth/BluetoothSocket;
    const/4 v7, 0x0

    .line 1024
    .local v7, "$i$a$-forEach-ClassicBluetoothService$release$1$2":I
    invoke-virtual {v6}, Landroid/bluetooth/BluetoothSocket;->close()V

    .line 1610
    .end local v6    # "it":Landroid/bluetooth/BluetoothSocket;
    .end local v7    # "$i$a$-forEach-ClassicBluetoothService$release$1$2":I
    nop

    .end local v5    # "element$iv":Ljava/lang/Object;
    goto :goto_1

    .line 1611
    :cond_5
    nop

    .line 1025
    .end local v2    # "$this$forEach$iv":Ljava/lang/Iterable;
    .end local v3    # "$i$f$forEach":I
    iget-object v2, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->connectedAudioSockets:Ljava/util/concurrent/CopyOnWriteArrayList;

    invoke-virtual {v2}, Ljava/util/concurrent/CopyOnWriteArrayList;->clear()V

    .line 1026
    iget-object v2, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->connectedStreamSockets:Ljava/util/concurrent/CopyOnWriteArrayList;

    check-cast v2, Ljava/lang/Iterable;

    .restart local v2    # "$this$forEach$iv":Ljava/lang/Iterable;
    const/4 v3, 0x0

    .line 1612
    .restart local v3    # "$i$f$forEach":I
    invoke-interface {v2}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v4

    :goto_2
    invoke-interface {v4}, Ljava/util/Iterator;->hasNext()Z

    move-result v5

    if-eqz v5, :cond_6

    invoke-interface {v4}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v5

    .restart local v5    # "element$iv":Ljava/lang/Object;
    move-object v6, v5

    check-cast v6, Landroid/bluetooth/BluetoothSocket;

    .restart local v6    # "it":Landroid/bluetooth/BluetoothSocket;
    const/4 v7, 0x0

    .line 1026
    .local v7, "$i$a$-forEach-ClassicBluetoothService$release$1$3":I
    invoke-virtual {v6}, Landroid/bluetooth/BluetoothSocket;->close()V

    .line 1612
    .end local v6    # "it":Landroid/bluetooth/BluetoothSocket;
    .end local v7    # "$i$a$-forEach-ClassicBluetoothService$release$1$3":I
    nop

    .end local v5    # "element$iv":Ljava/lang/Object;
    goto :goto_2

    .line 1613
    :cond_6
    nop

    .line 1027
    .end local v2    # "$this$forEach$iv":Ljava/lang/Iterable;
    .end local v3    # "$i$f$forEach":I
    iget-object v2, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->connectedStreamSockets:Ljava/util/concurrent/CopyOnWriteArrayList;

    invoke-virtual {v2}, Ljava/util/concurrent/CopyOnWriteArrayList;->clear()V

    .line 1028
    iget-object v2, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->connectedFileSockets:Ljava/util/concurrent/CopyOnWriteArrayList;

    check-cast v2, Ljava/lang/Iterable;

    .restart local v2    # "$this$forEach$iv":Ljava/lang/Iterable;
    const/4 v3, 0x0

    .line 1614
    .restart local v3    # "$i$f$forEach":I
    invoke-interface {v2}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v4

    :goto_3
    invoke-interface {v4}, Ljava/util/Iterator;->hasNext()Z

    move-result v5

    if-eqz v5, :cond_7

    invoke-interface {v4}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v5

    .restart local v5    # "element$iv":Ljava/lang/Object;
    move-object v6, v5

    check-cast v6, Landroid/bluetooth/BluetoothSocket;

    .restart local v6    # "it":Landroid/bluetooth/BluetoothSocket;
    const/4 v7, 0x0

    .line 1028
    .local v7, "$i$a$-forEach-ClassicBluetoothService$release$1$4":I
    invoke-virtual {v6}, Landroid/bluetooth/BluetoothSocket;->close()V

    .line 1614
    .end local v6    # "it":Landroid/bluetooth/BluetoothSocket;
    .end local v7    # "$i$a$-forEach-ClassicBluetoothService$release$1$4":I
    nop

    .end local v5    # "element$iv":Ljava/lang/Object;
    goto :goto_3

    .line 1615
    :cond_7
    nop

    .line 1029
    .end local v2    # "$this$forEach$iv":Ljava/lang/Iterable;
    .end local v3    # "$i$f$forEach":I
    iget-object v2, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->connectedFileSockets:Ljava/util/concurrent/CopyOnWriteArrayList;

    invoke-virtual {v2}, Ljava/util/concurrent/CopyOnWriteArrayList;->clear()V

    .line 1031
    iput-object v1, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->mConnectedMessageSocket:Landroid/bluetooth/BluetoothSocket;

    .line 1032
    iput-object v1, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->mConnectedAudioSocket:Landroid/bluetooth/BluetoothSocket;

    .line 1033
    iput-object v1, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->mConnectedStreamSocket:Landroid/bluetooth/BluetoothSocket;

    .line 1034
    iput-object v1, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->mConnectedFileSocket:Landroid/bluetooth/BluetoothSocket;

    .line 1036
    iget-object v2, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->mMessageClientHandlerThread:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;

    if-eqz v2, :cond_8

    invoke-virtual {v2}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->shutdown()V

    .line 1037
    :cond_8
    iput-object v1, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->mMessageClientHandlerThread:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;

    .line 1038
    iget-object v2, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->mAudioClientHandlerThread:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;

    if-eqz v2, :cond_9

    invoke-virtual {v2}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->shutdown()V

    .line 1039
    :cond_9
    iput-object v1, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->mAudioClientHandlerThread:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;

    .line 1040
    iget-object v2, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->mStreamClientHandlerThread:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;

    if-eqz v2, :cond_a

    invoke-virtual {v2}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->shutdown()V

    .line 1041
    :cond_a
    iput-object v1, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->mStreamClientHandlerThread:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;

    .line 1042
    iget-object v2, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->mFileClientHandlerThread:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;

    if-eqz v2, :cond_b

    invoke-virtual {v2}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->shutdown()V

    .line 1043
    :cond_b
    iput-object v1, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->mFileClientHandlerThread:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;

    .line 1045
    iget-object v2, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->serverSocketJob:Lkotlinx/coroutines/Job;

    const/4 v3, 0x1

    if-eqz v2, :cond_c

    invoke-static {v2, v1, v3, v1}, Lkotlinx/coroutines/Job$DefaultImpls;->cancel$default(Lkotlinx/coroutines/Job;Ljava/util/concurrent/CancellationException;ILjava/lang/Object;)V

    .line 1046
    :cond_c
    iget-object v2, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->serverSocketAudioJob:Lkotlinx/coroutines/Job;

    if-eqz v2, :cond_d

    invoke-static {v2, v1, v3, v1}, Lkotlinx/coroutines/Job$DefaultImpls;->cancel$default(Lkotlinx/coroutines/Job;Ljava/util/concurrent/CancellationException;ILjava/lang/Object;)V

    .line 1047
    :cond_d
    iget-object v2, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->serverSocketStreamJob:Lkotlinx/coroutines/Job;

    if-eqz v2, :cond_e

    invoke-static {v2, v1, v3, v1}, Lkotlinx/coroutines/Job$DefaultImpls;->cancel$default(Lkotlinx/coroutines/Job;Ljava/util/concurrent/CancellationException;ILjava/lang/Object;)V

    .line 1048
    :cond_e
    iget-object v2, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->serverSocketFileJob:Lkotlinx/coroutines/Job;

    if-eqz v2, :cond_f

    invoke-static {v2, v1, v3, v1}, Lkotlinx/coroutines/Job$DefaultImpls;->cancel$default(Lkotlinx/coroutines/Job;Ljava/util/concurrent/CancellationException;ILjava/lang/Object;)V

    sget-object v1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 1006
    .end local v0    # "$i$a$-synchronized-ClassicBluetoothService$release$1":I
    :cond_f
    :try_start_2
    monitor-exit p0

    goto :goto_4

    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_0

    .line 1050
    :catch_0
    move-exception v0

    .line 1051
    .local v0, "e":Ljava/lang/Exception;
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    .line 1053
    .end local v0    # "e":Ljava/lang/Exception;
    :goto_4
    return-void
.end method

.method private final restartServer()V
    .locals 2

    .line 535
    const-string v0, "restartServer"

    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v0

    const-string v1, "ClassicBluetoothService "

    invoke-static {v1, v0}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 536
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->release()V

    .line 537
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->startServer()V

    .line 538
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->hasBluetoothPermissions()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 539
    invoke-virtual {p0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->isDiscoverableEnabled()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 540
    invoke-virtual {p0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->makeDeviceDiscoverable()V

    goto :goto_0

    .line 542
    :cond_0
    invoke-virtual {p0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->ensureNotDiscoverable()V

    .line 545
    :cond_1
    :goto_0
    return-void
.end method

.method private final startAudioServer()V
    .locals 7

    .line 422
    invoke-static {}, Lkotlinx/coroutines/Dispatchers;->getIO()Lkotlinx/coroutines/CoroutineDispatcher;

    move-result-object v0

    check-cast v0, Lkotlin/coroutines/CoroutineContext;

    invoke-static {v0}, Lkotlinx/coroutines/CoroutineScopeKt;->CoroutineScope(Lkotlin/coroutines/CoroutineContext;)Lkotlinx/coroutines/CoroutineScope;

    move-result-object v1

    new-instance v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startAudioServer$1;

    const/4 v2, 0x0

    invoke-direct {v0, p0, v2}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startAudioServer$1;-><init>(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;Lkotlin/coroutines/Continuation;)V

    move-object v4, v0

    check-cast v4, Lkotlin/jvm/functions/Function2;

    const/4 v5, 0x3

    const/4 v6, 0x0

    const/4 v3, 0x0

    invoke-static/range {v1 .. v6}, Lkotlinx/coroutines/BuildersKt;->launch$default(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/CoroutineContext;Lkotlinx/coroutines/CoroutineStart;Lkotlin/jvm/functions/Function2;ILjava/lang/Object;)Lkotlinx/coroutines/Job;

    move-result-object v0

    iput-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->serverSocketAudioJob:Lkotlinx/coroutines/Job;

    .line 452
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->serverSocketAudioJob:Lkotlinx/coroutines/Job;

    if-eqz v0, :cond_0

    new-instance v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startAudioServer$2;

    invoke-direct {v1, p0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startAudioServer$2;-><init>(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;)V

    check-cast v1, Lkotlin/jvm/functions/Function1;

    invoke-interface {v0, v1}, Lkotlinx/coroutines/Job;->invokeOnCompletion(Lkotlin/jvm/functions/Function1;)Lkotlinx/coroutines/DisposableHandle;

    .line 456
    :cond_0
    return-void
.end method

.method private final startDiscovery()V
    .locals 5

    .line 228
    new-instance v0, Landroid/content/Intent;

    const-string v1, "android.bluetooth.adapter.action.REQUEST_DISCOVERABLE"

    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    move-object v1, v0

    .local v1, "$this$startDiscovery_u24lambda_u240":Landroid/content/Intent;
    const/4 v2, 0x0

    .line 229
    .local v2, "$i$a$-apply-ClassicBluetoothService$startDiscovery$discoverableIntent$1":I
    const-string v3, "android.bluetooth.adapter.extra.DISCOVERABLE_DURATION"

    const/16 v4, 0x12c

    invoke-virtual {v1, v3, v4}, Landroid/content/Intent;->putExtra(Ljava/lang/String;I)Landroid/content/Intent;

    .line 230
    nop

    .line 228
    .end local v1    # "$this$startDiscovery_u24lambda_u240":Landroid/content/Intent;
    .end local v2    # "$i$a$-apply-ClassicBluetoothService$startDiscovery$discoverableIntent$1":I
    nop

    .line 232
    .local v0, "discoverableIntent":Landroid/content/Intent;
    const/high16 v1, 0x10000000

    invoke-virtual {v0, v1}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;

    .line 236
    invoke-virtual {p0, v0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->startActivity(Landroid/content/Intent;)V

    .line 237
    return-void
.end method

.method private final startDiscovery2()V
    .locals 6

    .line 247
    nop

    .line 249
    :try_start_0
    invoke-static {}, Landroid/bluetooth/BluetoothAdapter;->getDefaultAdapter()Landroid/bluetooth/BluetoothAdapter;

    move-result-object v0

    .line 254
    .local v0, "bluetoothAdapter":Landroid/bluetooth/BluetoothAdapter;
    invoke-virtual {v0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v1

    .line 255
    const-string v2, "setScanMode"

    .line 256
    const/4 v3, 0x1

    new-array v3, v3, [Ljava/lang/Class;

    sget-object v4, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    const/4 v5, 0x0

    aput-object v4, v3, v5

    .line 254
    invoke-virtual {v1, v2, v3}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v1

    .line 258
    .local v1, "method":Ljava/lang/reflect/Method;
    nop

    .line 259
    nop

    .line 260
    const/16 v2, 0x17

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    .line 258
    invoke-virtual {v1, v0, v2}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 262
    .end local v0    # "bluetoothAdapter":Landroid/bluetooth/BluetoothAdapter;
    .end local v1    # "method":Ljava/lang/reflect/Method;
    :catch_0
    move-exception v0

    .line 263
    .local v0, "e":Ljava/lang/Exception;
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    .line 265
    .end local v0    # "e":Ljava/lang/Exception;
    :goto_0
    return-void
.end method

.method private final startFileServer()V
    .locals 7

    .line 498
    invoke-static {}, Lkotlinx/coroutines/Dispatchers;->getIO()Lkotlinx/coroutines/CoroutineDispatcher;

    move-result-object v0

    check-cast v0, Lkotlin/coroutines/CoroutineContext;

    invoke-static {v0}, Lkotlinx/coroutines/CoroutineScopeKt;->CoroutineScope(Lkotlin/coroutines/CoroutineContext;)Lkotlinx/coroutines/CoroutineScope;

    move-result-object v1

    new-instance v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startFileServer$1;

    const/4 v2, 0x0

    invoke-direct {v0, p0, v2}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startFileServer$1;-><init>(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;Lkotlin/coroutines/Continuation;)V

    move-object v4, v0

    check-cast v4, Lkotlin/jvm/functions/Function2;

    const/4 v5, 0x3

    const/4 v6, 0x0

    const/4 v3, 0x0

    invoke-static/range {v1 .. v6}, Lkotlinx/coroutines/BuildersKt;->launch$default(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/CoroutineContext;Lkotlinx/coroutines/CoroutineStart;Lkotlin/jvm/functions/Function2;ILjava/lang/Object;)Lkotlinx/coroutines/Job;

    move-result-object v0

    iput-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->serverSocketFileJob:Lkotlinx/coroutines/Job;

    .line 528
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->serverSocketFileJob:Lkotlinx/coroutines/Job;

    if-eqz v0, :cond_0

    new-instance v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startFileServer$2;

    invoke-direct {v1, p0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startFileServer$2;-><init>(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;)V

    check-cast v1, Lkotlin/jvm/functions/Function1;

    invoke-interface {v0, v1}, Lkotlinx/coroutines/Job;->invokeOnCompletion(Lkotlin/jvm/functions/Function1;)Lkotlinx/coroutines/DisposableHandle;

    .line 532
    :cond_0
    return-void
.end method

.method private final startForegroundService()V
    .locals 4

    .line 268
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->createNotificationChannel()V

    .line 269
    new-instance v0, Landroidx/core/app/NotificationCompat$Builder;

    move-object v1, p0

    check-cast v1, Landroid/content/Context;

    const-string v2, "classic_server_channel"

    invoke-direct {v0, v1, v2}, Landroidx/core/app/NotificationCompat$Builder;-><init>(Landroid/content/Context;Ljava/lang/String;)V

    .line 270
    const-string v1, "Classic Bluetooth Service"

    check-cast v1, Ljava/lang/CharSequence;

    invoke-virtual {v0, v1}, Landroidx/core/app/NotificationCompat$Builder;->setContentTitle(Ljava/lang/CharSequence;)Landroidx/core/app/NotificationCompat$Builder;

    move-result-object v0

    .line 271
    const-string v1, "Listening for connections..."

    check-cast v1, Ljava/lang/CharSequence;

    invoke-virtual {v0, v1}, Landroidx/core/app/NotificationCompat$Builder;->setContentText(Ljava/lang/CharSequence;)Landroidx/core/app/NotificationCompat$Builder;

    move-result-object v0

    .line 272
    const v1, 0x108009b

    invoke-virtual {v0, v1}, Landroidx/core/app/NotificationCompat$Builder;->setSmallIcon(I)Landroidx/core/app/NotificationCompat$Builder;

    move-result-object v0

    .line 273
    invoke-virtual {v0}, Landroidx/core/app/NotificationCompat$Builder;->build()Landroid/app/Notification;

    move-result-object v0

    const-string v1, "Builder(this, CHANNEL_ID\u2026nfo)\n            .build()"

    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 269
    nop

    .line 275
    .local v0, "notification":Landroid/app/Notification;
    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v2, 0x1d

    const/4 v3, 0x1

    if-lt v1, v2, :cond_0

    .line 276
    const/16 v1, 0x10

    invoke-virtual {p0, v3, v0, v1}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->startForeground(ILandroid/app/Notification;I)V

    goto :goto_0

    .line 278
    :cond_0
    invoke-virtual {p0, v3, v0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->startForeground(ILandroid/app/Notification;)V

    .line 280
    :goto_0
    return-void
.end method

.method private final startMessageServer()V
    .locals 7

    .line 322
    invoke-static {}, Lkotlinx/coroutines/Dispatchers;->getIO()Lkotlinx/coroutines/CoroutineDispatcher;

    move-result-object v0

    check-cast v0, Lkotlin/coroutines/CoroutineContext;

    invoke-static {v0}, Lkotlinx/coroutines/CoroutineScopeKt;->CoroutineScope(Lkotlin/coroutines/CoroutineContext;)Lkotlinx/coroutines/CoroutineScope;

    move-result-object v1

    new-instance v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startMessageServer$1;

    const/4 v2, 0x0

    invoke-direct {v0, p0, v2}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startMessageServer$1;-><init>(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;Lkotlin/coroutines/Continuation;)V

    move-object v4, v0

    check-cast v4, Lkotlin/jvm/functions/Function2;

    const/4 v5, 0x3

    const/4 v6, 0x0

    const/4 v3, 0x0

    invoke-static/range {v1 .. v6}, Lkotlinx/coroutines/BuildersKt;->launch$default(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/CoroutineContext;Lkotlinx/coroutines/CoroutineStart;Lkotlin/jvm/functions/Function2;ILjava/lang/Object;)Lkotlinx/coroutines/Job;

    move-result-object v0

    iput-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->serverSocketJob:Lkotlinx/coroutines/Job;

    .line 371
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->serverSocketJob:Lkotlinx/coroutines/Job;

    if-eqz v0, :cond_0

    new-instance v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startMessageServer$2;

    invoke-direct {v1, p0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startMessageServer$2;-><init>(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;)V

    check-cast v1, Lkotlin/jvm/functions/Function1;

    invoke-interface {v0, v1}, Lkotlinx/coroutines/Job;->invokeOnCompletion(Lkotlin/jvm/functions/Function1;)Lkotlinx/coroutines/DisposableHandle;

    .line 375
    :cond_0
    return-void
.end method

.method private final startServer()V
    .locals 7

    .line 296
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->startMessageServer()V

    .line 297
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->startAudioServer()V

    .line 298
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->startStreamServer()V

    .line 299
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->startFileServer()V

    .line 300
    iget-boolean v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->isFirst:Z

    if-eqz v0, :cond_0

    .line 301
    invoke-static {}, Lkotlinx/coroutines/Dispatchers;->getIO()Lkotlinx/coroutines/CoroutineDispatcher;

    move-result-object v0

    check-cast v0, Lkotlin/coroutines/CoroutineContext;

    invoke-static {v0}, Lkotlinx/coroutines/CoroutineScopeKt;->CoroutineScope(Lkotlin/coroutines/CoroutineContext;)Lkotlinx/coroutines/CoroutineScope;

    move-result-object v1

    new-instance v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startServer$1;

    const/4 v2, 0x0

    invoke-direct {v0, p0, v2}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startServer$1;-><init>(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;Lkotlin/coroutines/Continuation;)V

    move-object v4, v0

    check-cast v4, Lkotlin/jvm/functions/Function2;

    const/4 v5, 0x3

    const/4 v6, 0x0

    const/4 v3, 0x0

    invoke-static/range {v1 .. v6}, Lkotlinx/coroutines/BuildersKt;->launch$default(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/CoroutineContext;Lkotlinx/coroutines/CoroutineStart;Lkotlin/jvm/functions/Function2;ILjava/lang/Object;)Lkotlinx/coroutines/Job;

    .line 309
    :cond_0
    return-void
.end method

.method private final startSocketMonitor()V
    .locals 9

    .line 577
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->socketMonitorJob:Lkotlinx/coroutines/Job;

    const/4 v1, 0x1

    const/4 v2, 0x0

    if-eqz v0, :cond_0

    invoke-static {v0, v2, v1, v2}, Lkotlinx/coroutines/Job$DefaultImpls;->cancel$default(Lkotlinx/coroutines/Job;Ljava/util/concurrent/CancellationException;ILjava/lang/Object;)V

    .line 578
    :cond_0
    iput-boolean v1, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->isMonitorRunning:Z

    .line 579
    invoke-static {}, Lkotlinx/coroutines/Dispatchers;->getIO()Lkotlinx/coroutines/CoroutineDispatcher;

    move-result-object v0

    check-cast v0, Lkotlin/coroutines/CoroutineContext;

    invoke-static {v0}, Lkotlinx/coroutines/CoroutineScopeKt;->CoroutineScope(Lkotlin/coroutines/CoroutineContext;)Lkotlinx/coroutines/CoroutineScope;

    move-result-object v3

    new-instance v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startSocketMonitor$1;

    invoke-direct {v0, p0, v2}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startSocketMonitor$1;-><init>(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;Lkotlin/coroutines/Continuation;)V

    move-object v6, v0

    check-cast v6, Lkotlin/jvm/functions/Function2;

    const/4 v7, 0x3

    const/4 v8, 0x0

    const/4 v4, 0x0

    const/4 v5, 0x0

    invoke-static/range {v3 .. v8}, Lkotlinx/coroutines/BuildersKt;->launch$default(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/CoroutineContext;Lkotlinx/coroutines/CoroutineStart;Lkotlin/jvm/functions/Function2;ILjava/lang/Object;)Lkotlinx/coroutines/Job;

    move-result-object v0

    iput-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->socketMonitorJob:Lkotlinx/coroutines/Job;

    .line 603
    return-void
.end method

.method private final startStreamServer()V
    .locals 7

    .line 460
    invoke-static {}, Lkotlinx/coroutines/Dispatchers;->getIO()Lkotlinx/coroutines/CoroutineDispatcher;

    move-result-object v0

    check-cast v0, Lkotlin/coroutines/CoroutineContext;

    invoke-static {v0}, Lkotlinx/coroutines/CoroutineScopeKt;->CoroutineScope(Lkotlin/coroutines/CoroutineContext;)Lkotlinx/coroutines/CoroutineScope;

    move-result-object v1

    new-instance v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startStreamServer$1;

    const/4 v2, 0x0

    invoke-direct {v0, p0, v2}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startStreamServer$1;-><init>(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;Lkotlin/coroutines/Continuation;)V

    move-object v4, v0

    check-cast v4, Lkotlin/jvm/functions/Function2;

    const/4 v5, 0x3

    const/4 v6, 0x0

    const/4 v3, 0x0

    invoke-static/range {v1 .. v6}, Lkotlinx/coroutines/BuildersKt;->launch$default(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/CoroutineContext;Lkotlinx/coroutines/CoroutineStart;Lkotlin/jvm/functions/Function2;ILjava/lang/Object;)Lkotlinx/coroutines/Job;

    move-result-object v0

    iput-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->serverSocketStreamJob:Lkotlinx/coroutines/Job;

    .line 490
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->serverSocketStreamJob:Lkotlinx/coroutines/Job;

    if-eqz v0, :cond_0

    new-instance v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startStreamServer$2;

    invoke-direct {v1, p0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$startStreamServer$2;-><init>(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;)V

    check-cast v1, Lkotlin/jvm/functions/Function1;

    invoke-interface {v0, v1}, Lkotlinx/coroutines/Job;->invokeOnCompletion(Lkotlin/jvm/functions/Function1;)Lkotlinx/coroutines/DisposableHandle;

    .line 494
    :cond_0
    return-void
.end method

.method private final withLockSafe(Lkotlinx/coroutines/sync/Mutex;Lkotlin/jvm/functions/Function1;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;
    .locals 9
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Ljava/lang/Object;",
            ">(",
            "Lkotlinx/coroutines/sync/Mutex;",
            "Lkotlin/jvm/functions/Function1<",
            "-",
            "Lkotlin/coroutines/Continuation<",
            "-TT;>;+",
            "Ljava/lang/Object;",
            ">;",
            "Lkotlin/coroutines/Continuation<",
            "-TT;>;)",
            "Ljava/lang/Object;"
        }
    .end annotation

    instance-of v0, p3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$withLockSafe$1;

    if-eqz v0, :cond_0

    move-object v0, p3

    check-cast v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$withLockSafe$1;

    iget v1, v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$withLockSafe$1;->label:I

    const/high16 v2, -0x80000000

    and-int/2addr v1, v2

    if-eqz v1, :cond_0

    iget p3, v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$withLockSafe$1;->label:I

    sub-int/2addr p3, v2

    iput p3, v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$withLockSafe$1;->label:I

    goto :goto_0

    :cond_0
    new-instance v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$withLockSafe$1;

    invoke-direct {v0, p0, p3}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$withLockSafe$1;-><init>(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;Lkotlin/coroutines/Continuation;)V

    :goto_0
    move-object p3, v0

    .local p3, "$continuation":Lkotlin/coroutines/Continuation;
    iget-object v0, p3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$withLockSafe$1;->result:Ljava/lang/Object;

    .local v0, "$result":Ljava/lang/Object;
    invoke-static {}, Lkotlin/coroutines/intrinsics/IntrinsicsKt;->getCOROUTINE_SUSPENDED()Ljava/lang/Object;

    move-result-object v1

    .line 311
    iget v2, p3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$withLockSafe$1;->label:I

    const/4 v3, 0x0

    packed-switch v2, :pswitch_data_0

    .end local v0    # "$result":Ljava/lang/Object;
    .end local p3    # "$continuation":Lkotlin/coroutines/Continuation;
    new-instance p1, Ljava/lang/IllegalStateException;

    const-string p2, "call to \'resume\' before \'invoke\' with coroutine"

    invoke-direct {p1, p2}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p1

    .restart local v0    # "$result":Ljava/lang/Object;
    .restart local p3    # "$continuation":Lkotlin/coroutines/Continuation;
    :pswitch_0
    const/4 p1, 0x0

    .local p1, "$i$f$withLock":I
    const/4 p2, 0x0

    .local p2, "$i$a$-withLock$default-ClassicBluetoothService$withLockSafe$2":I
    iget-object v1, p3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$withLockSafe$1;->L$0:Ljava/lang/Object;

    check-cast v1, Lkotlinx/coroutines/sync/Mutex;

    .local v1, "$this$withLock_u24default$iv":Lkotlinx/coroutines/sync/Mutex;
    :try_start_0
    invoke-static {v0}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-object v2, v0

    goto :goto_2

    .line 1592
    .end local p2    # "$i$a$-withLock$default-ClassicBluetoothService$withLockSafe$2":I
    :catchall_0
    move-exception p2

    move-object v2, v3

    .local v2, "owner$iv":Ljava/lang/Object;
    goto :goto_3

    .line 311
    .end local v1    # "$this$withLock_u24default$iv":Lkotlinx/coroutines/sync/Mutex;
    .end local v2    # "owner$iv":Ljava/lang/Object;
    .end local p1    # "$i$f$withLock":I
    :pswitch_1
    const/4 p1, 0x0

    .restart local p1    # "$i$f$withLock":I
    const/4 p2, 0x0

    .local p2, "owner$iv":Ljava/lang/Object;
    iget-object v2, p3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$withLockSafe$1;->L$1:Ljava/lang/Object;

    check-cast v2, Lkotlinx/coroutines/sync/Mutex;

    .local v2, "$this$withLock_u24default$iv":Lkotlinx/coroutines/sync/Mutex;
    iget-object v4, p3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$withLockSafe$1;->L$0:Ljava/lang/Object;

    check-cast v4, Lkotlin/jvm/functions/Function1;

    .local v4, "block":Lkotlin/jvm/functions/Function1;
    invoke-static {v0}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    goto :goto_1

    .end local v2    # "$this$withLock_u24default$iv":Lkotlinx/coroutines/sync/Mutex;
    .end local v4    # "block":Lkotlin/jvm/functions/Function1;
    .end local p1    # "$i$f$withLock":I
    .end local p2    # "owner$iv":Ljava/lang/Object;
    :pswitch_2
    invoke-static {v0}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    move-object v4, p2

    .line 312
    .restart local v4    # "block":Lkotlin/jvm/functions/Function1;
    .local p1, "mutex":Lkotlinx/coroutines/sync/Mutex;
    nop

    .line 1583
    .local p1, "$this$withLock_u24default$iv":Lkotlinx/coroutines/sync/Mutex;
    const/4 p2, 0x0

    .restart local p2    # "owner$iv":Ljava/lang/Object;
    const/4 v2, 0x0

    .line 1584
    .local v2, "$i$f$withLock":I
    nop

    .line 1588
    iput-object v4, p3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$withLockSafe$1;->L$0:Ljava/lang/Object;

    iput-object p1, p3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$withLockSafe$1;->L$1:Ljava/lang/Object;

    const/4 v5, 0x1

    iput v5, p3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$withLockSafe$1;->label:I

    invoke-interface {p1, p2, p3}, Lkotlinx/coroutines/sync/Mutex;->lock(Ljava/lang/Object;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v5

    if-ne v5, v1, :cond_1

    .line 311
    return-object v1

    .line 1588
    :cond_1
    move v8, v2

    move-object v2, p1

    move p1, v8

    .line 1589
    .local v2, "$this$withLock_u24default$iv":Lkotlinx/coroutines/sync/Mutex;
    .local p1, "$i$f$withLock":I
    :goto_1
    nop

    .line 1590
    const/4 v5, 0x0

    .line 314
    .local v5, "$i$a$-withLock$default-ClassicBluetoothService$withLockSafe$2":I
    :try_start_1
    sget-object v6, Lkotlinx/coroutines/NonCancellable;->INSTANCE:Lkotlinx/coroutines/NonCancellable;

    check-cast v6, Lkotlin/coroutines/CoroutineContext;

    new-instance v7, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$withLockSafe$2$1;

    invoke-direct {v7, v4, v3}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$withLockSafe$2$1;-><init>(Lkotlin/jvm/functions/Function1;Lkotlin/coroutines/Continuation;)V

    check-cast v7, Lkotlin/jvm/functions/Function2;

    iput-object v2, p3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$withLockSafe$1;->L$0:Ljava/lang/Object;

    iput-object v3, p3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$withLockSafe$1;->L$1:Ljava/lang/Object;

    const/4 v3, 0x2

    iput v3, p3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$withLockSafe$1;->label:I

    invoke-static {v6, v7, p3}, Lkotlinx/coroutines/BuildersKt;->withContext(Lkotlin/coroutines/CoroutineContext;Lkotlin/jvm/functions/Function2;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v3
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    .end local v4    # "block":Lkotlin/jvm/functions/Function1;
    if-ne v3, v1, :cond_2

    .line 311
    return-object v1

    .line 314
    :cond_2
    move-object v1, v2

    move-object v2, v3

    move-object v3, p2

    move p2, v5

    .end local v2    # "$this$withLock_u24default$iv":Lkotlinx/coroutines/sync/Mutex;
    .end local v5    # "$i$a$-withLock$default-ClassicBluetoothService$withLockSafe$2":I
    .restart local v1    # "$this$withLock_u24default$iv":Lkotlinx/coroutines/sync/Mutex;
    .local p2, "$i$a$-withLock$default-ClassicBluetoothService$withLockSafe$2":I
    :goto_2
    nop

    .end local p2    # "$i$a$-withLock$default-ClassicBluetoothService$withLockSafe$2":I
    move-object p2, v3

    .line 1590
    .local p2, "owner$iv":Ljava/lang/Object;
    nop

    .line 1592
    invoke-interface {v1, p2}, Lkotlinx/coroutines/sync/Mutex;->unlock(Ljava/lang/Object;)V

    .line 1590
    .end local v1    # "$this$withLock_u24default$iv":Lkotlinx/coroutines/sync/Mutex;
    .end local p2    # "owner$iv":Ljava/lang/Object;
    nop

    .line 312
    .end local p1    # "$i$f$withLock":I
    return-object v2

    .line 1592
    .restart local v2    # "$this$withLock_u24default$iv":Lkotlinx/coroutines/sync/Mutex;
    .restart local p1    # "$i$f$withLock":I
    .restart local p2    # "owner$iv":Ljava/lang/Object;
    :catchall_1
    move-exception v1

    move-object v8, v2

    move-object v2, p2

    move-object p2, v1

    move-object v1, v8

    .end local p2    # "owner$iv":Ljava/lang/Object;
    .restart local v1    # "$this$withLock_u24default$iv":Lkotlinx/coroutines/sync/Mutex;
    .local v2, "owner$iv":Ljava/lang/Object;
    :goto_3
    invoke-interface {v1, v2}, Lkotlinx/coroutines/sync/Mutex;->unlock(Ljava/lang/Object;)V

    throw p2

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method


# virtual methods
.method public final ensureNotDiscoverable()V
    .locals 7

    .line 562
    const-string v0, "ClassicBluetoothService "

    .line 563
    :try_start_0
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->getBluetoothAdapter()Landroid/bluetooth/BluetoothAdapter;

    move-result-object v1

    if-nez v1, :cond_0

    return-void

    .line 564
    .local v1, "adapter":Landroid/bluetooth/BluetoothAdapter;
    :cond_0
    invoke-virtual {v1}, Landroid/bluetooth/BluetoothAdapter;->isEnabled()Z

    move-result v2

    if-nez v2, :cond_1

    return-void

    .line 565
    :cond_1
    invoke-virtual {v1}, Landroid/bluetooth/BluetoothAdapter;->getScanMode()I

    move-result v2

    const/16 v3, 0x17

    if-ne v2, v3, :cond_2

    .line 566
    invoke-virtual {v1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v2

    const-string v3, "setScanMode"

    const/4 v4, 0x1

    new-array v4, v4, [Ljava/lang/Class;

    sget-object v5, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    const/4 v6, 0x0

    aput-object v5, v4, v6

    invoke-virtual {v2, v3, v4}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v2

    .line 567
    .local v2, "method":Ljava/lang/reflect/Method;
    const/16 v3, 0x15

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    filled-new-array {v3}, [Ljava/lang/Object;

    move-result-object v3

    invoke-virtual {v2, v1, v3}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    .line 568
    const-string v3, "ensureNotDiscoverable: switch to SCAN_MODE_CONNECTABLE"

    filled-new-array {v3}, [Ljava/lang/Object;

    move-result-object v3

    invoke-static {v0, v3}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->i(Ljava/lang/String;[Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .end local v1    # "adapter":Landroid/bluetooth/BluetoothAdapter;
    .end local v2    # "method":Ljava/lang/reflect/Method;
    goto :goto_0

    .line 570
    :catch_0
    move-exception v1

    .line 571
    .local v1, "e":Ljava/lang/Exception;
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "ensureNotDiscoverable failed: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v1}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v0, v2}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 573
    .end local v1    # "e":Ljava/lang/Exception;
    :cond_2
    :goto_0
    return-void
.end method

.method public final getConnectDevices()Ljava/util/List;
    .locals 17
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Landroid/bluetooth/BluetoothDevice;",
            ">;"
        }
    .end annotation

    .line 965
    move-object/from16 v1, p0

    monitor-enter p0

    const/4 v0, 0x0

    .line 966
    .local v0, "$i$a$-synchronized-ClassicBluetoothService$getConnectDevices$1":I
    :try_start_0
    iget-object v2, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->connectedMessageSockets:Ljava/util/concurrent/CopyOnWriteArrayList;

    check-cast v2, Ljava/util/Collection;

    invoke-static {v2}, Lkotlin/collections/CollectionsKt;->toMutableList(Ljava/util/Collection;)Ljava/util/List;

    move-result-object v2

    move-object v3, v2

    .local v3, "$this$getConnectDevices_u24lambda_u247_u24lambda_u245":Ljava/util/List;
    const/4 v4, 0x0

    .line 967
    .local v4, "$i$a$-apply-ClassicBluetoothService$getConnectDevices$1$mutableList$1":I
    iget-object v5, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->connectedMessageSockets:Ljava/util/concurrent/CopyOnWriteArrayList;

    check-cast v5, Ljava/util/Collection;

    invoke-interface {v3, v5}, Ljava/util/List;->addAll(Ljava/util/Collection;)Z

    .line 968
    nop

    .line 966
    .end local v3    # "$this$getConnectDevices_u24lambda_u247_u24lambda_u245":Ljava/util/List;
    .end local v4    # "$i$a$-apply-ClassicBluetoothService$getConnectDevices$1$mutableList$1":I
    nop

    .line 969
    .local v2, "mutableList":Ljava/util/List;
    move-object v3, v2

    check-cast v3, Ljava/lang/Iterable;

    .local v3, "$this$mapNotNull$iv":Ljava/lang/Iterable;
    const/4 v4, 0x0

    .line 1595
    .local v4, "$i$f$mapNotNull":I
    new-instance v5, Ljava/util/ArrayList;

    invoke-direct {v5}, Ljava/util/ArrayList;-><init>()V

    check-cast v5, Ljava/util/Collection;

    .local v5, "destination$iv$iv":Ljava/util/Collection;
    move-object v6, v3

    .local v6, "$this$mapNotNullTo$iv$iv":Ljava/lang/Iterable;
    const/4 v7, 0x0

    .line 1603
    .local v7, "$i$f$mapNotNullTo":I
    move-object v8, v6

    .local v8, "$this$forEach$iv$iv$iv":Ljava/lang/Iterable;
    const/4 v9, 0x0

    .line 1604
    .local v9, "$i$f$forEach":I
    invoke-interface {v8}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v10

    :goto_0
    invoke-interface {v10}, Ljava/util/Iterator;->hasNext()Z

    move-result v11

    if-eqz v11, :cond_1

    invoke-interface {v10}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v11

    .local v11, "element$iv$iv$iv":Ljava/lang/Object;
    move-object v12, v11

    .local v12, "element$iv$iv":Ljava/lang/Object;
    const/4 v13, 0x0

    .line 1603
    .local v13, "$i$a$-forEach-CollectionsKt___CollectionsKt$mapNotNullTo$1$iv$iv":I
    move-object v14, v12

    check-cast v14, Landroid/bluetooth/BluetoothSocket;

    .local v14, "it":Landroid/bluetooth/BluetoothSocket;
    const/4 v15, 0x0

    .line 969
    .local v15, "$i$a$-mapNotNull-ClassicBluetoothService$getConnectDevices$1$1":I
    invoke-virtual {v14}, Landroid/bluetooth/BluetoothSocket;->getRemoteDevice()Landroid/bluetooth/BluetoothDevice;

    move-result-object v16

    .line 1603
    .end local v14    # "it":Landroid/bluetooth/BluetoothSocket;
    .end local v15    # "$i$a$-mapNotNull-ClassicBluetoothService$getConnectDevices$1$1":I
    if-eqz v16, :cond_0

    move-object/from16 v14, v16

    .line 1605
    .local v14, "it$iv$iv":Ljava/lang/Object;
    const/4 v15, 0x0

    .line 1603
    .local v15, "$i$a$-let-CollectionsKt___CollectionsKt$mapNotNullTo$1$1$iv$iv":I
    invoke-interface {v5, v14}, Ljava/util/Collection;->add(Ljava/lang/Object;)Z

    .line 1604
    .end local v12    # "element$iv$iv":Ljava/lang/Object;
    .end local v13    # "$i$a$-forEach-CollectionsKt___CollectionsKt$mapNotNullTo$1$iv$iv":I
    .end local v14    # "it$iv$iv":Ljava/lang/Object;
    .end local v15    # "$i$a$-let-CollectionsKt___CollectionsKt$mapNotNullTo$1$1$iv$iv":I
    :cond_0
    nop

    .end local v11    # "element$iv$iv$iv":Ljava/lang/Object;
    goto :goto_0

    .line 1606
    :cond_1
    nop

    .line 1607
    .end local v8    # "$this$forEach$iv$iv$iv":Ljava/lang/Iterable;
    .end local v9    # "$i$f$forEach":I
    nop

    .end local v5    # "destination$iv$iv":Ljava/util/Collection;
    .end local v6    # "$this$mapNotNullTo$iv$iv":Ljava/lang/Iterable;
    .end local v7    # "$i$f$mapNotNullTo":I
    check-cast v5, Ljava/util/List;

    .line 1595
    nop

    .end local v3    # "$this$mapNotNull$iv":Ljava/lang/Iterable;
    .end local v4    # "$i$f$mapNotNull":I
    check-cast v5, Ljava/lang/Iterable;

    .line 969
    invoke-static {v5}, Lkotlin/collections/CollectionsKt;->toList(Ljava/lang/Iterable;)Ljava/util/List;

    move-result-object v3
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .end local v0    # "$i$a$-synchronized-ClassicBluetoothService$getConnectDevices$1":I
    .end local v2    # "mutableList":Ljava/util/List;
    monitor-exit p0

    return-object v3

    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public final isAudioChanelConnect()Z
    .locals 2

    .line 980
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "isAudioChanelConnect: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->mConnectedAudioSocket:Landroid/bluetooth/BluetoothSocket;

    if-eqz v1, :cond_0

    invoke-virtual {v1}, Landroid/bluetooth/BluetoothSocket;->isConnected()Z

    move-result v1

    invoke-static {v1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v1

    goto :goto_0

    :cond_0
    const/4 v1, 0x0

    :goto_0
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "} "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v0

    const-string v1, "ClassicBluetoothService "

    invoke-static {v1, v0}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 982
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->mConnectedAudioSocket:Landroid/bluetooth/BluetoothSocket;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->mConnectedAudioSocket:Landroid/bluetooth/BluetoothSocket;

    invoke-static {v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;)V

    invoke-virtual {v0}, Landroid/bluetooth/BluetoothSocket;->isConnected()Z

    move-result v0

    if-eqz v0, :cond_1

    const/4 v0, 0x1

    goto :goto_1

    :cond_1
    const/4 v0, 0x0

    :goto_1
    return v0
.end method

.method public final isDiscoverableEnabled()Z
    .locals 4

    .line 548
    nop

    .line 550
    const/4 v0, 0x1

    :try_start_0
    invoke-virtual {p0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v1

    .line 551
    const-string v2, "bt_discoverable_enabled"

    .line 552
    nop

    .line 549
    invoke-static {v1, v2, v0}, Landroid/provider/Settings$System;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I

    move-result v1
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 553
    if-ne v1, v0, :cond_0

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0

    .line 554
    :catch_0
    move-exception v1

    .line 555
    .local v1, "e":Ljava/lang/Exception;
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "isDiscoverableEnabled read failed: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v1}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    const-string v3, "ClassicBluetoothService "

    invoke-static {v3, v2}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 556
    nop

    .line 548
    .end local v1    # "e":Ljava/lang/Exception;
    :goto_0
    return v0
.end method

.method public final isFileChanelConnect()Z
    .locals 2

    .line 986
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "isFileChanelConnect: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->mConnectedFileSocket:Landroid/bluetooth/BluetoothSocket;

    if-eqz v1, :cond_0

    invoke-virtual {v1}, Landroid/bluetooth/BluetoothSocket;->isConnected()Z

    move-result v1

    invoke-static {v1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v1

    goto :goto_0

    :cond_0
    const/4 v1, 0x0

    :goto_0
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    const/16 v1, 0x20

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v0

    const-string v1, "ClassicBluetoothService "

    invoke-static {v1, v0}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 988
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->mConnectedFileSocket:Landroid/bluetooth/BluetoothSocket;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->mConnectedFileSocket:Landroid/bluetooth/BluetoothSocket;

    invoke-static {v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;)V

    invoke-virtual {v0}, Landroid/bluetooth/BluetoothSocket;->isConnected()Z

    move-result v0

    if-eqz v0, :cond_1

    const/4 v0, 0x1

    goto :goto_1

    :cond_1
    const/4 v0, 0x0

    :goto_1
    return v0
.end method

.method public final isMessageChanelConnect()Z
    .locals 2

    .line 974
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "isMessageChanelConnect: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->mConnectedMessageSocket:Landroid/bluetooth/BluetoothSocket;

    if-eqz v1, :cond_0

    invoke-virtual {v1}, Landroid/bluetooth/BluetoothSocket;->isConnected()Z

    move-result v1

    invoke-static {v1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v1

    goto :goto_0

    :cond_0
    const/4 v1, 0x0

    :goto_0
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "} "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v0

    const-string v1, "ClassicBluetoothService "

    invoke-static {v1, v0}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 976
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->mConnectedMessageSocket:Landroid/bluetooth/BluetoothSocket;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->mConnectedMessageSocket:Landroid/bluetooth/BluetoothSocket;

    invoke-static {v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;)V

    invoke-virtual {v0}, Landroid/bluetooth/BluetoothSocket;->isConnected()Z

    move-result v0

    if-eqz v0, :cond_1

    const/4 v0, 0x1

    goto :goto_1

    :cond_1
    const/4 v0, 0x0

    :goto_1
    return v0
.end method

.method public final isStreamChanelConnect()Z
    .locals 2

    .line 992
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "isStreamChanelConnect: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->mConnectedStreamSocket:Landroid/bluetooth/BluetoothSocket;

    if-eqz v1, :cond_0

    invoke-virtual {v1}, Landroid/bluetooth/BluetoothSocket;->isConnected()Z

    move-result v1

    invoke-static {v1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v1

    goto :goto_0

    :cond_0
    const/4 v1, 0x0

    :goto_0
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    const/16 v1, 0x20

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v0

    const-string v1, "ClassicBluetoothService "

    invoke-static {v1, v0}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 994
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->mConnectedStreamSocket:Landroid/bluetooth/BluetoothSocket;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->mConnectedStreamSocket:Landroid/bluetooth/BluetoothSocket;

    invoke-static {v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;)V

    invoke-virtual {v0}, Landroid/bluetooth/BluetoothSocket;->isConnected()Z

    move-result v0

    if-eqz v0, :cond_1

    const/4 v0, 0x1

    goto :goto_1

    :cond_1
    const/4 v0, 0x0

    :goto_1
    return v0
.end method

.method public final makeDeviceDiscoverable()V
    .locals 9

    .line 190
    invoke-virtual {p0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->isDiscoverableEnabled()Z

    move-result v0

    const-string v1, "ClassicBluetoothService "

    if-nez v0, :cond_0

    .line 191
    const-string v0, "makeDeviceDiscoverable skipped, discoverable disabled by user"

    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v0

    invoke-static {v1, v0}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 192
    invoke-virtual {p0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->ensureNotDiscoverable()V

    .line 193
    return-void

    .line 195
    :cond_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "makeDeviceDiscoverable "

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->getBluetoothAdapter()Landroid/bluetooth/BluetoothAdapter;

    move-result-object v2

    const/4 v3, 0x1

    const/4 v4, 0x0

    if-eqz v2, :cond_1

    invoke-virtual {v2}, Landroid/bluetooth/BluetoothAdapter;->isEnabled()Z

    move-result v2

    if-ne v2, v3, :cond_1

    move v2, v3

    goto :goto_0

    :cond_1
    move v2, v4

    :goto_0
    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v0

    invoke-static {v1, v0}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 196
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->getBluetoothAdapter()Landroid/bluetooth/BluetoothAdapter;

    move-result-object v0

    if-eqz v0, :cond_2

    invoke-virtual {v0}, Landroid/bluetooth/BluetoothAdapter;->isEnabled()Z

    move-result v0

    if-ne v0, v3, :cond_2

    move v0, v3

    goto :goto_1

    :cond_2
    move v0, v4

    :goto_1
    if-eqz v0, :cond_7

    .line 197
    move-object v0, p0

    check-cast v0, Landroid/content/Context;

    invoke-static {v0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothServiceKt;->getGlassDeviceName(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v0

    .line 198
    .local v0, "deviceName":Ljava/lang/String;
    if-eqz v0, :cond_5

    move-object v2, v0

    check-cast v2, Ljava/lang/CharSequence;

    invoke-interface {v2}, Ljava/lang/CharSequence;->length()I

    move-result v2

    if-nez v2, :cond_3

    goto :goto_2

    :cond_3
    move v3, v4

    :goto_2
    if-eqz v3, :cond_4

    goto :goto_3

    .line 201
    :cond_4
    sput-object v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->NAME:Ljava/lang/String;

    goto :goto_4

    .line 199
    :cond_5
    :goto_3
    invoke-static {}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothServiceKt;->getDeviceName()Ljava/lang/String;

    move-result-object v2

    sput-object v2, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->NAME:Ljava/lang/String;

    .line 204
    :goto_4
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "NAME->"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    sget-object v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->NAME:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 205
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->getBluetoothAdapter()Landroid/bluetooth/BluetoothAdapter;

    move-result-object v2

    if-eqz v2, :cond_6

    sget-object v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->NAME:Ljava/lang/String;

    invoke-virtual {v2, v3}, Landroid/bluetooth/BluetoothAdapter;->setName(Ljava/lang/String;)Z

    .line 206
    :cond_6
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->getBluetoothAdapter()Landroid/bluetooth/BluetoothAdapter;

    move-result-object v2

    invoke-static {v2}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;)V

    invoke-virtual {v2}, Landroid/bluetooth/BluetoothAdapter;->getScanMode()I

    move-result v2

    const/16 v3, 0x17

    if-eq v2, v3, :cond_7

    .line 207
    const-string v2, "makeDeviceDiscoverable 11111"

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 208
    invoke-static {}, Lcom/rokid/glasses/transport/sdk/server/utils/ScopesKt;->getMainScope()Lkotlinx/coroutines/CoroutineScope;

    move-result-object v3

    new-instance v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$makeDeviceDiscoverable$1;

    const/4 v2, 0x0

    invoke-direct {v1, p0, v2}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$makeDeviceDiscoverable$1;-><init>(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;Lkotlin/coroutines/Continuation;)V

    move-object v6, v1

    check-cast v6, Lkotlin/jvm/functions/Function2;

    const/4 v7, 0x3

    const/4 v8, 0x0

    const/4 v4, 0x0

    const/4 v5, 0x0

    invoke-static/range {v3 .. v8}, Lkotlinx/coroutines/BuildersKt;->launch$default(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/CoroutineContext;Lkotlinx/coroutines/CoroutineStart;Lkotlin/jvm/functions/Function2;ILjava/lang/Object;)Lkotlinx/coroutines/Job;

    .line 218
    .end local v0    # "deviceName":Ljava/lang/String;
    :cond_7
    return-void
.end method

.method public onBind(Landroid/content/Intent;)Landroid/os/IBinder;
    .locals 1
    .param p1, "intent"    # Landroid/content/Intent;

    const-string v0, "intent"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 171
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->binder:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$LocalBinder;

    check-cast v0, Landroid/os/IBinder;

    return-object v0
.end method

.method public onCreate()V
    .locals 1

    .line 174
    invoke-super {p0}, Landroid/app/Service;->onCreate()V

    .line 175
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->startForegroundService()V

    .line 176
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->startServer()V

    .line 177
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->hasBluetoothPermissions()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 178
    invoke-virtual {p0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->isDiscoverableEnabled()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 179
    invoke-virtual {p0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->makeDeviceDiscoverable()V

    goto :goto_0

    .line 181
    :cond_0
    invoke-virtual {p0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->ensureNotDiscoverable()V

    .line 184
    :cond_1
    :goto_0
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->startSocketMonitor()V

    .line 185
    return-void
.end method

.method public onDestroy()V
    .locals 3

    .line 998
    invoke-super {p0}, Landroid/app/Service;->onDestroy()V

    .line 999
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->socketMonitorJob:Lkotlinx/coroutines/Job;

    if-eqz v0, :cond_0

    const/4 v1, 0x1

    const/4 v2, 0x0

    invoke-static {v0, v2, v1, v2}, Lkotlinx/coroutines/Job$DefaultImpls;->cancel$default(Lkotlinx/coroutines/Job;Ljava/util/concurrent/CancellationException;ILjava/lang/Object;)V

    .line 1000
    :cond_0
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->isMonitorRunning:Z

    .line 1001
    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->release()V

    .line 1002
    return-void
.end method

.method public final resetFileReceiveState()V
    .locals 1

    .line 948
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->mFileClientHandlerThread:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->resetFileReceiveState()V

    .line 949
    :cond_0
    return-void
.end method

.method public final resetStreamReceiveState()V
    .locals 1

    .line 952
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->mStreamClientHandlerThread:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->resetStreamReceiveState()V

    .line 953
    :cond_0
    return-void
.end method

.method public final sendAudioBroadcast([B)V
    .locals 11
    .param p1, "bytes"    # [B

    const-string v0, "bytes"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 762
    monitor-enter p0

    const/4 v0, 0x0

    .line 763
    .local v0, "$i$a$-synchronized-ClassicBluetoothService$sendAudioBroadcast$1":I
    :try_start_0
    iget-object v1, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->connectedAudioSockets:Ljava/util/concurrent/CopyOnWriteArrayList;

    check-cast v1, Ljava/lang/Iterable;

    .local v1, "$this$forEach$iv":Ljava/lang/Iterable;
    const/4 v2, 0x0

    .line 1593
    .local v2, "$i$f$forEach":I
    invoke-interface {v1}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :goto_0
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v4

    if-eqz v4, :cond_3

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v4

    .local v4, "element$iv":Ljava/lang/Object;
    move-object v5, v4

    check-cast v5, Landroid/bluetooth/BluetoothSocket;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .local v5, "socket":Landroid/bluetooth/BluetoothSocket;
    const/4 v6, 0x0

    .line 764
    .local v6, "$i$a$-forEach-ClassicBluetoothService$sendAudioBroadcast$1$1":I
    nop

    .line 765
    :try_start_1
    const-string v7, "ClassicBluetoothService "

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, "sendAudioBroadcast-->"

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    iget-object v9, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->mConnectedAudioSocket:Landroid/bluetooth/BluetoothSocket;

    invoke-static {v5, v9}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v9

    const/4 v10, 0x1

    if-eqz v9, :cond_0

    invoke-virtual {v5}, Landroid/bluetooth/BluetoothSocket;->isConnected()Z

    move-result v9

    if-ne v9, v10, :cond_0

    move v9, v10

    goto :goto_1

    :cond_0
    const/4 v9, 0x0

    :goto_1
    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-static {v7, v8}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 766
    iget-object v7, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->mConnectedAudioSocket:Landroid/bluetooth/BluetoothSocket;

    invoke-static {v5, v7}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v7

    if-eqz v7, :cond_2

    invoke-virtual {v5}, Landroid/bluetooth/BluetoothSocket;->isConnected()Z

    move-result v7

    if-ne v7, v10, :cond_2

    .line 767
    invoke-virtual {v5}, Landroid/bluetooth/BluetoothSocket;->getOutputStream()Ljava/io/OutputStream;

    move-result-object v7

    .line 768
    .local v7, "outputStream":Ljava/io/OutputStream;
    if-eqz v7, :cond_1

    invoke-virtual {v7, p1}, Ljava/io/OutputStream;->write([B)V

    .line 769
    :cond_1
    if-eqz v7, :cond_2

    invoke-virtual {v7}, Ljava/io/OutputStream;->flush()V
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_2

    .line 772
    .end local v7    # "outputStream":Ljava/io/OutputStream;
    :catch_0
    move-exception v7

    .line 773
    .local v7, "e":Ljava/io/IOException;
    :try_start_2
    invoke-virtual {v7}, Ljava/io/IOException;->printStackTrace()V

    .line 774
    const-string v8, "ClassicBluetoothService "

    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    const-string v10, "Send Audio failed  errMessag = "

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v7}, Ljava/io/IOException;->getMessage()Ljava/lang/String;

    move-result-object v10

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    filled-new-array {v9}, [Ljava/lang/Object;

    move-result-object v9

    invoke-static {v8, v9}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 776
    .end local v7    # "e":Ljava/io/IOException;
    :cond_2
    :goto_2
    nop

    .line 1593
    .end local v5    # "socket":Landroid/bluetooth/BluetoothSocket;
    .end local v6    # "$i$a$-forEach-ClassicBluetoothService$sendAudioBroadcast$1$1":I
    nop

    .end local v4    # "element$iv":Ljava/lang/Object;
    goto :goto_0

    .line 1594
    :cond_3
    nop

    .line 777
    .end local v1    # "$this$forEach$iv":Ljava/lang/Iterable;
    .end local v2    # "$i$f$forEach":I
    nop

    .end local v0    # "$i$a$-synchronized-ClassicBluetoothService$sendAudioBroadcast$1":I
    sget-object v0, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 762
    monitor-exit p0

    .line 778
    return-void

    .line 762
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public final sendBroadcast(Ljava/lang/String;)V
    .locals 7
    .param p1, "message"    # Ljava/lang/String;

    const-string v0, "message"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 690
    invoke-static {}, Lcom/rokid/glasses/transport/sdk/server/utils/ScopesKt;->getWorkScope()Lkotlinx/coroutines/CoroutineScope;

    move-result-object v1

    new-instance v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendBroadcast$1;

    const/4 v2, 0x0

    invoke-direct {v0, p0, p1, v2}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendBroadcast$1;-><init>(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;Ljava/lang/String;Lkotlin/coroutines/Continuation;)V

    move-object v4, v0

    check-cast v4, Lkotlin/jvm/functions/Function2;

    const/4 v5, 0x3

    const/4 v6, 0x0

    const/4 v3, 0x0

    invoke-static/range {v1 .. v6}, Lkotlinx/coroutines/BuildersKt;->launch$default(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/CoroutineContext;Lkotlinx/coroutines/CoroutineStart;Lkotlin/jvm/functions/Function2;ILjava/lang/Object;)Lkotlinx/coroutines/Job;

    .line 719
    return-void
.end method

.method public final sendBroadcastV2(Ljava/lang/String;)V
    .locals 7
    .param p1, "message"    # Ljava/lang/String;

    const-string v0, "message"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 729
    invoke-static {}, Lcom/rokid/glasses/transport/sdk/server/utils/ScopesKt;->getWorkScope()Lkotlinx/coroutines/CoroutineScope;

    move-result-object v1

    new-instance v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendBroadcastV2$1;

    const/4 v2, 0x0

    invoke-direct {v0, p0, p1, v2}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendBroadcastV2$1;-><init>(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;Ljava/lang/String;Lkotlin/coroutines/Continuation;)V

    move-object v4, v0

    check-cast v4, Lkotlin/jvm/functions/Function2;

    const/4 v5, 0x3

    const/4 v6, 0x0

    const/4 v3, 0x0

    invoke-static/range {v1 .. v6}, Lkotlinx/coroutines/BuildersKt;->launch$default(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/CoroutineContext;Lkotlinx/coroutines/CoroutineStart;Lkotlin/jvm/functions/Function2;ILjava/lang/Object;)Lkotlinx/coroutines/Job;

    .line 757
    return-void
.end method

.method public final sendFileBroadcast(Ljava/lang/String;Ljava/io/File;Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileSendListener;)V
    .locals 19
    .param p1, "dir"    # Ljava/lang/String;
    .param p2, "file"    # Ljava/io/File;
    .param p3, "listener"    # Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileSendListener;

    move-object/from16 v9, p0

    move-object/from16 v10, p3

    const-string v0, "file"

    move-object/from16 v11, p2

    invoke-static {v11, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "listener"

    invoke-static {v10, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 816
    const-string v0, "ClassicBluetoothService "

    const-string v1, "sendFileBroadcast-->0"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 818
    new-instance v4, Lkotlin/jvm/internal/Ref$LongRef;

    invoke-direct {v4}, Lkotlin/jvm/internal/Ref$LongRef;-><init>()V

    .line 819
    .local v4, "lastProgressTime":Lkotlin/jvm/internal/Ref$LongRef;
    const/16 v12, 0xc8

    .line 820
    .local v12, "PROGRESS_INTERVAL":I
    new-instance v6, Lkotlin/jvm/internal/Ref$FloatRef;

    invoke-direct {v6}, Lkotlin/jvm/internal/Ref$FloatRef;-><init>()V

    .line 822
    .local v6, "lastProgressValue":Lkotlin/jvm/internal/Ref$FloatRef;
    iget-object v0, v9, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->fileSendJob:Lkotlinx/coroutines/Job;

    if-eqz v0, :cond_0

    const/4 v1, 0x1

    const/4 v2, 0x0

    invoke-static {v0, v2, v1, v2}, Lkotlinx/coroutines/Job$DefaultImpls;->cancel$default(Lkotlinx/coroutines/Job;Ljava/util/concurrent/CancellationException;ILjava/lang/Object;)V

    .line 823
    :cond_0
    iput-object v10, v9, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->mFileSendListener:Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileSendListener;

    .line 824
    invoke-static {}, Lkotlinx/coroutines/Dispatchers;->getIO()Lkotlinx/coroutines/CoroutineDispatcher;

    move-result-object v0

    check-cast v0, Lkotlin/coroutines/CoroutineContext;

    invoke-static {v0}, Lkotlinx/coroutines/CoroutineScopeKt;->CoroutineScope(Lkotlin/coroutines/CoroutineContext;)Lkotlinx/coroutines/CoroutineScope;

    move-result-object v13

    new-instance v14, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;

    const/4 v8, 0x0

    move-object v0, v14

    move-object/from16 v1, p0

    move-object/from16 v2, p2

    move-object/from16 v3, p1

    move v5, v12

    move-object/from16 v7, p3

    invoke-direct/range {v0 .. v8}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendFileBroadcast$1;-><init>(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;Ljava/io/File;Ljava/lang/String;Lkotlin/jvm/internal/Ref$LongRef;ILkotlin/jvm/internal/Ref$FloatRef;Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileSendListener;Lkotlin/coroutines/Continuation;)V

    move-object/from16 v16, v14

    check-cast v16, Lkotlin/jvm/functions/Function2;

    const/16 v17, 0x3

    const/16 v18, 0x0

    const/4 v14, 0x0

    const/4 v15, 0x0

    invoke-static/range {v13 .. v18}, Lkotlinx/coroutines/BuildersKt;->launch$default(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/CoroutineContext;Lkotlinx/coroutines/CoroutineStart;Lkotlin/jvm/functions/Function2;ILjava/lang/Object;)Lkotlinx/coroutines/Job;

    move-result-object v0

    iput-object v0, v9, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->fileSendJob:Lkotlinx/coroutines/Job;

    .line 937
    return-void
.end method

.method public final sendStreamBroadcast(Ljava/lang/String;[BLjava/lang/String;)V
    .locals 8
    .param p1, "tag"    # Ljava/lang/String;
    .param p2, "bytes"    # [B
    .param p3, "clientId"    # Ljava/lang/String;

    const-string v0, "tag"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "bytes"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "clientId"

    invoke-static {p3, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 782
    invoke-static {}, Lcom/rokid/glasses/transport/sdk/server/utils/ScopesKt;->getDefaultScope()Lkotlinx/coroutines/CoroutineScope;

    move-result-object v1

    new-instance v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendStreamBroadcast$1;

    const/4 v7, 0x0

    move-object v2, v0

    move-object v3, p0

    move-object v4, p1

    move-object v5, p3

    move-object v6, p2

    invoke-direct/range {v2 .. v7}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$sendStreamBroadcast$1;-><init>(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;Ljava/lang/String;Ljava/lang/String;[BLkotlin/coroutines/Continuation;)V

    move-object v4, v0

    check-cast v4, Lkotlin/jvm/functions/Function2;

    const/4 v5, 0x3

    const/4 v6, 0x0

    const/4 v2, 0x0

    const/4 v3, 0x0

    invoke-static/range {v1 .. v6}, Lkotlinx/coroutines/BuildersKt;->launch$default(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/CoroutineContext;Lkotlinx/coroutines/CoroutineStart;Lkotlin/jvm/functions/Function2;ILjava/lang/Object;)Lkotlinx/coroutines/Job;

    .line 810
    return-void
.end method

.method public final setFileReceiverListener(Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileReceiveListener;)V
    .locals 1
    .param p1, "listener"    # Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileReceiveListener;

    const-string v0, "listener"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 961
    iput-object p1, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->mFileReceiveListener:Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileReceiveListener;

    .line 962
    return-void
.end method

.method public final setSaveFileDirectory(Ljava/lang/String;)V
    .locals 1
    .param p1, "directory"    # Ljava/lang/String;

    const-string v0, "directory"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 222
    sput-object p1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->saveDirectory:Ljava/lang/String;

    .line 223
    return-void
.end method

.method public final setServerListener(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ServerListener;)V
    .locals 1
    .param p1, "listener"    # Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ServerListener;

    const-string v0, "listener"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 956
    iput-object p1, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->serverListener:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ServerListener;

    .line 957
    return-void
.end method

.method public final stopFileSend()V
    .locals 3

    .line 940
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "stopFileSend: mFileSendListener = "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->mFileSendListener:Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileSendListener;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v0

    const-string v1, "ClassicBluetoothService "

    invoke-static {v1, v0}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 941
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->fileSendJob:Lkotlinx/coroutines/Job;

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    const/4 v2, 0x1

    invoke-static {v0, v1, v2, v1}, Lkotlinx/coroutines/Job$DefaultImpls;->cancel$default(Lkotlinx/coroutines/Job;Ljava/util/concurrent/CancellationException;ILjava/lang/Object;)V

    .line 942
    :cond_0
    iput-object v1, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->fileSendJob:Lkotlinx/coroutines/Job;

    .line 943
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->mFileSendListener:Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileSendListener;

    if-eqz v0, :cond_1

    invoke-interface {v0}, Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileSendListener;->onCancel()V

    .line 944
    :cond_1
    iput-object v1, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->mFileSendListener:Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileSendListener;

    .line 945
    return-void
.end method
