.class final Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;
.super Ljava/lang/Thread;
.source "ClassicBlueToothClientManager.kt"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x12
    name = "ConnectedThread"
.end annotation

.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$WhenMappings;
    }
.end annotation

.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nClassicBlueToothClientManager.kt\nKotlin\n*S Kotlin\n*F\n+ 1 ClassicBlueToothClientManager.kt\ncom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread\n+ 2 _Collections.kt\nkotlin/collections/CollectionsKt___CollectionsKt\n*L\n1#1,1451:1\n1855#2,2:1452\n1855#2,2:1454\n1855#2,2:1456\n1855#2,2:1458\n*S KotlinDebug\n*F\n+ 1 ClassicBlueToothClientManager.kt\ncom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread\n*L\n877#1:1452,2\n1133#1:1454,2\n1135#1:1456,2\n1210#1:1458,2\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u008a\u0001\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u000e\n\u0002\u0008\u0002\n\u0002\u0010\t\n\u0000\n\u0002\u0010\u0008\n\u0002\u0008\u0002\n\u0002\u0010\u0012\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0008\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u000b\n\u0002\u0008\u0005\n\u0002\u0010\u0007\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0003\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0004\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0002\n\u0002\u0008\u0005\n\u0002\u0018\u0002\n\u0002\u0008\u0012\u0008\u0082\u0004\u0018\u00002\u00020\u0001B\u0017\u0012\u0008\u0010\u0002\u001a\u0004\u0018\u00010\u0003\u0012\u0006\u0010\u0004\u001a\u00020\u0005\u00a2\u0006\u0002\u0010\u0006J\u0008\u00106\u001a\u000207H\u0002J\u0008\u00108\u001a\u000207H\u0002J\u0008\u00109\u001a\u000207H\u0002J\u0008\u0010:\u001a\u000207H\u0002J\u0010\u0010;\u001a\u0002072\u0006\u0010<\u001a\u00020=H\u0002J\u0010\u0010>\u001a\u0002072\u0006\u0010<\u001a\u00020=H\u0002J\u0010\u0010?\u001a\u0002072\u0006\u0010<\u001a\u00020=H\u0002J\u0010\u0010@\u001a\u0002072\u0006\u0010\u000c\u001a\u00020\u000fH\u0002J\u0010\u0010A\u001a\u0002072\u0006\u0010B\u001a\u00020\u000fH\u0002J*\u0010C\u001a\u00020\n2\u0008\u0010\u001f\u001a\u0004\u0018\u00010 2\u0006\u0010\u000c\u001a\u00020\r2\u0006\u0010D\u001a\u00020\n2\u0006\u0010E\u001a\u00020\nH\u0002J\u0006\u0010F\u001a\u000207J\u0006\u0010G\u001a\u000207J\u0008\u0010H\u001a\u000207H\u0016J\u0006\u0010I\u001a\u000207J\u0006\u0010J\u001a\u000207J\u000e\u0010K\u001a\u0002072\u0006\u0010\u0010\u001a\u00020\rJ\u001e\u0010K\u001a\u0002072\u0006\u00102\u001a\u00020\u00052\u0006\u0010\u0010\u001a\u00020\r2\u0006\u0010\u0015\u001a\u00020\u0005J \u0010K\u001a\u0002072\u0008\u0010L\u001a\u0004\u0018\u00010\u00052\u0006\u0010M\u001a\u0002002\u0006\u0010N\u001a\u00020*R\u000e\u0010\u0007\u001a\u00020\u0008X\u0082D\u00a2\u0006\u0002\n\u0000R\u000e\u0010\t\u001a\u00020\nX\u0082D\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u000b\u001a\u00020\nX\u0082D\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u000c\u001a\u00020\rX\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0010\u0010\u000e\u001a\u0004\u0018\u00010\u000fX\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u001a\u0010\u0010\u001a\u00020\nX\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0011\u0010\u0012\"\u0004\u0008\u0013\u0010\u0014R\u0010\u0010\u0015\u001a\u0004\u0018\u00010\u0005X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0010\u0010\u0016\u001a\u0004\u0018\u00010\u0005X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0010\u0010\u0017\u001a\u0004\u0018\u00010\u0018X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0019\u001a\u00020\u0008X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u001a\u001a\u00020\u001bX\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u001c\u001a\u00020\u0008X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0010\u0010\u001d\u001a\u0004\u0018\u00010\u001eX\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0010\u0010\u001f\u001a\u0004\u0018\u00010 X\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u000e\u0010!\u001a\u00020\"X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u001a\u0010#\u001a\u00020\nX\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008$\u0010\u0012\"\u0004\u0008%\u0010\u0014R\u000e\u0010&\u001a\u00020\u0008X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\'\u001a\u00020(X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0010\u0010)\u001a\u0004\u0018\u00010*X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010+\u001a\u00020\"X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010,\u001a\u00020\u0005X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0010\u0010-\u001a\u0004\u0018\u00010.X\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u0010\u0010/\u001a\u0004\u0018\u000100X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0010\u0010\u0002\u001a\u0004\u0018\u00010\u0003X\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u000e\u00101\u001a\u00020\u0008X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0010\u00102\u001a\u0004\u0018\u00010\u0005X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u00103\u001a\u00020\u0008X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u00104\u001a\u000205X\u0082\u0004\u00a2\u0006\u0002\n\u0000\u00a8\u0006O"
    }
    d2 = {
        "Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;",
        "Ljava/lang/Thread;",
        "socket",
        "Landroid/bluetooth/BluetoothSocket;",
        "type",
        "",
        "(Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;Landroid/bluetooth/BluetoothSocket;Ljava/lang/String;)V",
        "RECEIVE_PROGRESS_INTERVAL",
        "",
        "baseBufferSize",
        "",
        "baseStreamBufferSize",
        "buffer",
        "",
        "byteArrayOutputStream",
        "Ljava/io/ByteArrayOutputStream;",
        "bytes",
        "getBytes",
        "()I",
        "setBytes",
        "(I)V",
        "clientId",
        "currentFileName",
        "currentFileOutputStream",
        "Ljava/io/BufferedOutputStream;",
        "currentFileSize",
        "currentState",
        "Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ReceiveState;",
        "dataSize",
        "fileSendJob",
        "Lkotlinx/coroutines/Job;",
        "inputStream",
        "Ljava/io/InputStream;",
        "isSocketDateRunning",
        "",
        "lastProgress",
        "getLastProgress",
        "setLastProgress",
        "lastReceiveProgressTime",
        "lastReceiveProgressValue",
        "",
        "mFileSendListener",
        "Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileSendListener;",
        "mIsMessage",
        "mType",
        "outputStream",
        "Ljava/io/OutputStream;",
        "saveFile",
        "Ljava/io/File;",
        "startTime",
        "tag",
        "totalReceived",
        "writeMutex",
        "Lkotlinx/coroutines/sync/Mutex;",
        "handleAudioStreamContinuously",
        "",
        "handleMessageTransferContinuously",
        "handleMultiFileTransferContinuously",
        "handleStreamContinuously",
        "onAudioStreamDisconnected",
        "device",
        "Landroid/bluetooth/BluetoothDevice;",
        "onFileStreamDisconnected",
        "onStreamDisconnected",
        "processAudioStreamPackets",
        "processStreamPackets",
        "streamBuffer",
        "readFully",
        "offset",
        "length",
        "resetFileReceiveState",
        "resetStreamReceiveState",
        "run",
        "shutdown",
        "stopFileSend",
        "write",
        "dir",
        "file",
        "listener",
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


# instance fields
.field private final RECEIVE_PROGRESS_INTERVAL:J

.field private final baseBufferSize:I

.field private final baseStreamBufferSize:I

.field private buffer:[B

.field private byteArrayOutputStream:Ljava/io/ByteArrayOutputStream;

.field private bytes:I

.field private clientId:Ljava/lang/String;

.field private currentFileName:Ljava/lang/String;

.field private currentFileOutputStream:Ljava/io/BufferedOutputStream;

.field private currentFileSize:J

.field private currentState:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ReceiveState;

.field private dataSize:J

.field private fileSendJob:Lkotlinx/coroutines/Job;

.field private final inputStream:Ljava/io/InputStream;

.field private isSocketDateRunning:Z

.field private lastProgress:I

.field private lastReceiveProgressTime:J

.field private lastReceiveProgressValue:F

.field private mFileSendListener:Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileSendListener;

.field private mIsMessage:Z

.field private mType:Ljava/lang/String;

.field private final outputStream:Ljava/io/OutputStream;

.field private saveFile:Ljava/io/File;

.field private final socket:Landroid/bluetooth/BluetoothSocket;

.field private startTime:J

.field private tag:Ljava/lang/String;

.field final synthetic this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;

.field private totalReceived:J

.field private final writeMutex:Lkotlinx/coroutines/sync/Mutex;


# direct methods
.method public static synthetic $r8$lambda$i6oesdlVQZAbyLZenmuI2DYO8sU(Ljava/lang/String;Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;)V
    .locals 0

    invoke-static {p0, p1}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->handleMessageTransferContinuously$lambda$5(Ljava/lang/String;Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;)V

    return-void
.end method

.method public static synthetic $r8$lambda$pNILRMI8YUi-TIeHZHGqPRpOE08(Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;[B)V
    .locals 0

    invoke-static {p0, p1, p2}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->processAudioStreamPackets$lambda$7(Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;[B)V

    return-void
.end method

.method public constructor <init>(Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;Landroid/bluetooth/BluetoothSocket;Ljava/lang/String;)V
    .locals 7
    .param p1, "this$0"    # Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;
    .param p2, "socket"    # Landroid/bluetooth/BluetoothSocket;
    .param p3, "type"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/bluetooth/BluetoothSocket;",
            "Ljava/lang/String;",
            ")V"
        }
    .end annotation

    const-string v0, "type"

    invoke-static {p3, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 685
    iput-object p1, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;

    invoke-direct {p0}, Ljava/lang/Thread;-><init>()V

    iput-object p2, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->socket:Landroid/bluetooth/BluetoothSocket;

    .line 688
    sget-object v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->Companion:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$Companion;

    invoke-virtual {v0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$Companion;->getMESSAGE_TYPE()Ljava/lang/String;

    move-result-object v0

    invoke-static {p3, v0}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    iput-boolean v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->mIsMessage:Z

    .line 689
    iput-object p3, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->mType:Ljava/lang/String;

    .line 691
    const/16 v0, 0x1000

    new-array v0, v0, [B

    iput-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->buffer:[B

    .line 692
    const/16 v0, 0x2000

    iput v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->baseBufferSize:I

    .line 693
    const/16 v0, 0x4000

    iput v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->baseStreamBufferSize:I

    .line 695
    sget-object v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ReceiveState;->WAITING_FOR_METADATA:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ReceiveState;

    iput-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->currentState:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ReceiveState;

    .line 705
    const-wide/16 v0, 0xc8

    iput-wide v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->RECEIVE_PROGRESS_INTERVAL:J

    .line 718
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->isSocketDateRunning:Z

    .line 721
    nop

    .line 722
    const/4 v1, 0x0

    .line 723
    .local v1, "tmpIn":Ljava/io/InputStream;
    const/4 v2, 0x0

    .line 725
    .local v2, "tmpOut":Ljava/io/OutputStream;
    nop

    .line 726
    const/4 v3, 0x0

    :try_start_0
    iget-object v4, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->socket:Landroid/bluetooth/BluetoothSocket;

    if-eqz v4, :cond_0

    invoke-virtual {v4}, Landroid/bluetooth/BluetoothSocket;->getInputStream()Ljava/io/InputStream;

    move-result-object v4

    goto :goto_0

    :cond_0
    move-object v4, v3

    :goto_0
    move-object v1, v4

    .line 727
    iget-object v4, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->socket:Landroid/bluetooth/BluetoothSocket;

    if-eqz v4, :cond_1

    invoke-virtual {v4}, Landroid/bluetooth/BluetoothSocket;->getOutputStream()Ljava/io/OutputStream;

    move-result-object v4
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_1

    :cond_1
    move-object v4, v3

    :goto_1
    move-object v2, v4

    goto :goto_2

    .line 728
    :catch_0
    move-exception v4

    .line 729
    .local v4, "e":Ljava/io/IOException;
    iget-object v5, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;

    invoke-static {v5}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;->access$getTAG$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;)Ljava/lang/String;

    move-result-object v5

    const-string v6, "\u83b7\u53d6\u6d41\u5931\u8d25"

    filled-new-array {v6}, [Ljava/lang/Object;

    move-result-object v6

    invoke-static {v5, v6}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 732
    .end local v4    # "e":Ljava/io/IOException;
    :goto_2
    iput-object v1, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->inputStream:Ljava/io/InputStream;

    .line 733
    iput-object v2, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->outputStream:Ljava/io/OutputStream;

    .line 734
    .end local v1    # "tmpIn":Ljava/io/InputStream;
    .end local v2    # "tmpOut":Ljava/io/OutputStream;
    nop

    .line 1241
    const/4 v1, 0x0

    invoke-static {v1, v0, v3}, Lkotlinx/coroutines/sync/MutexKt;->Mutex$default(ZILjava/lang/Object;)Lkotlinx/coroutines/sync/Mutex;

    move-result-object v0

    iput-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->writeMutex:Lkotlinx/coroutines/sync/Mutex;

    .line 685
    return-void
.end method

.method public static final synthetic access$getSocket$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;)Landroid/bluetooth/BluetoothSocket;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;

    .line 685
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->socket:Landroid/bluetooth/BluetoothSocket;

    return-object v0
.end method

.method public static final synthetic access$getWriteMutex$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;)Lkotlinx/coroutines/sync/Mutex;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;

    .line 685
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->writeMutex:Lkotlinx/coroutines/sync/Mutex;

    return-object v0
.end method

.method public static final synthetic access$onAudioStreamDisconnected(Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;Landroid/bluetooth/BluetoothDevice;)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;
    .param p1, "device"    # Landroid/bluetooth/BluetoothDevice;

    .line 685
    invoke-direct {p0, p1}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->onAudioStreamDisconnected(Landroid/bluetooth/BluetoothDevice;)V

    return-void
.end method

.method public static final synthetic access$onFileStreamDisconnected(Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;Landroid/bluetooth/BluetoothDevice;)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;
    .param p1, "device"    # Landroid/bluetooth/BluetoothDevice;

    .line 685
    invoke-direct {p0, p1}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->onFileStreamDisconnected(Landroid/bluetooth/BluetoothDevice;)V

    return-void
.end method

.method public static final synthetic access$onStreamDisconnected(Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;Landroid/bluetooth/BluetoothDevice;)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;
    .param p1, "device"    # Landroid/bluetooth/BluetoothDevice;

    .line 685
    invoke-direct {p0, p1}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->onStreamDisconnected(Landroid/bluetooth/BluetoothDevice;)V

    return-void
.end method

.method public static final synthetic access$setFileSendJob$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;Lkotlinx/coroutines/Job;)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;
    .param p1, "<set-?>"    # Lkotlinx/coroutines/Job;

    .line 685
    iput-object p1, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->fileSendJob:Lkotlinx/coroutines/Job;

    return-void
.end method

.method private final handleAudioStreamContinuously()V
    .locals 11

    .line 1065
    const/16 v0, 0x1000

    new-array v0, v0, [B

    .line 1066
    .local v0, "buffer":[B
    new-instance v1, Ljava/io/ByteArrayOutputStream;

    invoke-direct {v1}, Ljava/io/ByteArrayOutputStream;-><init>()V

    .local v1, "streamBuffer":Ljava/io/ByteArrayOutputStream;
    const/4 v2, 0x0

    .line 1068
    .local v2, "bytes":I
    :goto_0
    iget-boolean v3, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->isSocketDateRunning:Z

    if-eqz v3, :cond_3

    invoke-virtual {p0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->isInterrupted()Z

    move-result v3

    if-nez v3, :cond_3

    .line 1069
    nop

    .line 1070
    const/4 v3, 0x0

    :try_start_0
    iget-object v4, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->socket:Landroid/bluetooth/BluetoothSocket;

    if-eqz v4, :cond_0

    invoke-virtual {v4}, Landroid/bluetooth/BluetoothSocket;->isConnected()Z

    move-result v4

    const/4 v5, 0x1

    if-ne v4, v5, :cond_0

    goto :goto_1

    :cond_0
    move v5, v3

    :goto_1
    if-nez v5, :cond_1

    .line 1071
    return-void

    .line 1073
    :cond_1
    iget-object v4, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->inputStream:Ljava/io/InputStream;

    if-eqz v4, :cond_3

    invoke-virtual {v4, v0}, Ljava/io/InputStream;->read([B)I

    move-result v4

    move v2, v4

    .line 1074
    if-lez v2, :cond_3

    .line 1075
    invoke-virtual {v1, v0, v3, v2}, Ljava/io/ByteArrayOutputStream;->write([BII)V

    .line 1076
    invoke-direct {p0, v1}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->processAudioStreamPackets(Ljava/io/ByteArrayOutputStream;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 1077
    :catch_0
    move-exception v4

    .line 1078
    .local v4, "e":Ljava/lang/Exception;
    invoke-virtual {v4}, Ljava/lang/Exception;->printStackTrace()V

    .line 1079
    iget-object v5, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;

    invoke-static {v5}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;->access$getTAG$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;)Ljava/lang/String;

    move-result-object v5

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "\u97f3\u9891\u6d41\u65ad\u5f00\uff1a"

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v4}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    filled-new-array {v6}, [Ljava/lang/Object;

    move-result-object v6

    invoke-static {v5, v6}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 1080
    iput-boolean v3, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->isSocketDateRunning:Z

    .line 1082
    iget-object v3, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;

    invoke-static {v3}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;->access$getConnectBluetoothDevice$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;)Landroid/bluetooth/BluetoothDevice;

    move-result-object v3

    if-eqz v3, :cond_2

    .line 1083
    invoke-static {}, Lcom/rokid/glasses/transport/sdk/server/utils/ScopesKt;->getMainScope()Lkotlinx/coroutines/CoroutineScope;

    move-result-object v5

    new-instance v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$handleAudioStreamContinuously$1;

    iget-object v6, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;

    const/4 v7, 0x0

    invoke-direct {v3, v6, p0, v7}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$handleAudioStreamContinuously$1;-><init>(Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;Lkotlin/coroutines/Continuation;)V

    move-object v8, v3

    check-cast v8, Lkotlin/jvm/functions/Function2;

    const/4 v9, 0x3

    const/4 v10, 0x0

    const/4 v6, 0x0

    invoke-static/range {v5 .. v10}, Lkotlinx/coroutines/BuildersKt;->launch$default(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/CoroutineContext;Lkotlinx/coroutines/CoroutineStart;Lkotlin/jvm/functions/Function2;ILjava/lang/Object;)Lkotlinx/coroutines/Job;

    .line 1089
    :cond_2
    nop

    .line 1092
    .end local v4    # "e":Ljava/lang/Exception;
    :cond_3
    return-void
.end method

.method private final handleMessageTransferContinuously()V
    .locals 13

    .line 1097
    nop

    .line 1098
    const/4 v0, 0x2

    const/4 v1, 0x0

    :try_start_0
    new-array v2, v0, [B

    .line 1099
    .local v2, "lengthBuf":[B
    const/4 v3, 0x4

    new-array v4, v3, [B

    .line 1100
    .local v4, "lengthBufV2":[B
    :cond_0
    :goto_0
    iget-boolean v5, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->isSocketDateRunning:Z

    if-eqz v5, :cond_5

    invoke-virtual {p0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->isInterrupted()Z

    move-result v5

    if-nez v5, :cond_5

    .line 1101
    iget-object v5, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->socket:Landroid/bluetooth/BluetoothSocket;

    if-eqz v5, :cond_1

    invoke-virtual {v5}, Landroid/bluetooth/BluetoothSocket;->isConnected()Z

    move-result v5

    const/4 v6, 0x1

    if-ne v5, v6, :cond_1

    goto :goto_1

    :cond_1
    move v6, v1

    :goto_1
    if-nez v6, :cond_2

    .line 1102
    return-void

    .line 1104
    :cond_2
    iget-object v5, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->inputStream:Ljava/io/InputStream;

    invoke-direct {p0, v5, v2, v1, v0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->readFully(Ljava/io/InputStream;[BII)I

    move-result v5

    .line 1105
    .local v5, "lenRead":I
    if-ne v5, v0, :cond_5

    .line 1106
    invoke-static {v2}, Ljava/nio/ByteBuffer;->wrap([B)Ljava/nio/ByteBuffer;

    move-result-object v6

    invoke-virtual {v6}, Ljava/nio/ByteBuffer;->getShort()S

    move-result v6

    .line 1107
    .local v6, "len":I
    iget-object v7, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;

    invoke-static {v7}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;->access$getTAG$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;)Ljava/lang/String;

    move-result-object v7

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, "handleMessage len = "

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    filled-new-array {v8}, [Ljava/lang/Object;

    move-result-object v8

    invoke-static {v7, v8}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 1109
    if-gez v6, :cond_4

    .line 1110
    nop

    .line 1111
    const/4 v7, -0x2

    if-ne v6, v7, :cond_3

    .line 1112
    iget-object v7, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;

    invoke-static {v7}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;->access$getTAG$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;)Ljava/lang/String;

    move-result-object v7

    const-string v8, "Message Protocol Version = VERSION_V2"

    filled-new-array {v8}, [Ljava/lang/Object;

    move-result-object v8

    invoke-static {v7, v8}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 1113
    iget-object v7, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->inputStream:Ljava/io/InputStream;

    invoke-direct {p0, v7, v4, v1, v3}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->readFully(Ljava/io/InputStream;[BII)I

    move-result v7

    .line 1114
    .local v7, "lenRead2":I
    invoke-static {v4}, Ljava/nio/ByteBuffer;->wrap([B)Ljava/nio/ByteBuffer;

    move-result-object v8

    invoke-virtual {v8}, Ljava/nio/ByteBuffer;->getInt()I

    move-result v8

    move v6, v8

    .line 1115
    iget-object v8, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;

    invoke-static {v8}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;->access$getTAG$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;)Ljava/lang/String;

    move-result-object v8

    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    const-string v10, "handleMessage2 len = "

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v9

    const-string v10, ",  lenRead2 = "

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, v7}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    filled-new-array {v9}, [Ljava/lang/Object;

    move-result-object v9

    invoke-static {v8, v9}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .end local v7    # "lenRead2":I
    goto :goto_2

    .line 1118
    :cond_3
    iget-object v7, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;

    invoke-static {v7}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;->access$getTAG$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;)Ljava/lang/String;

    move-result-object v7

    const-string v8, "No protocol version matched, data parsing error."

    filled-new-array {v8}, [Ljava/lang/Object;

    move-result-object v8

    invoke-static {v7, v8}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 1123
    :cond_4
    :goto_2
    new-array v7, v6, [B

    .line 1124
    .local v7, "dataBuf":[B
    iget-object v8, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->inputStream:Ljava/io/InputStream;

    invoke-direct {p0, v8, v7, v1, v6}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->readFully(Ljava/io/InputStream;[BII)I

    move-result v8

    .line 1125
    .local v8, "totalRead":I
    if-ne v8, v6, :cond_0

    new-instance v9, Ljava/lang/String;

    .line 1126
    sget-object v10, Lkotlin/text/Charsets;->UTF_8:Ljava/nio/charset/Charset;

    invoke-direct {v9, v7, v10}, Ljava/lang/String;-><init>([BLjava/nio/charset/Charset;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_1

    .line 1127
    .local v9, "msg":Ljava/lang/String;
    nop

    .line 1128
    :try_start_1
    iget-object v10, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;

    invoke-static {v10}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;->access$getMainHandler$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;)Landroid/os/Handler;

    move-result-object v10

    iget-object v11, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;

    new-instance v12, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$$ExternalSyntheticLambda1;

    invoke-direct {v12, v9, v11}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$$ExternalSyntheticLambda1;-><init>(Ljava/lang/String;Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;)V

    invoke-virtual {v10, v12}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    goto/16 :goto_0

    .line 1138
    :catch_0
    move-exception v10

    .line 1139
    .local v10, "e":Ljava/lang/Exception;
    :try_start_2
    invoke-virtual {v10}, Ljava/lang/Exception;->printStackTrace()V

    .line 1140
    iget-object v11, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;

    invoke-static {v11}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;->access$getTAG$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;)Ljava/lang/String;

    move-result-object v11

    const-string v12, "\u4e1a\u52a1\u65b9\u5904\u7406\u6d88\u606f\u903b\u8f91\u51fa\u73b0\u5f02\u5e38"

    filled-new-array {v12}, [Ljava/lang/Object;

    move-result-object v12

    invoke-static {v11, v12}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->e(Ljava/lang/String;[Ljava/lang/Object;)V
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_1

    .end local v5    # "lenRead":I
    .end local v6    # "len":I
    .end local v7    # "dataBuf":[B
    .end local v8    # "totalRead":I
    .end local v9    # "msg":Ljava/lang/String;
    .end local v10    # "e":Ljava/lang/Exception;
    goto/16 :goto_0

    .line 1144
    .end local v2    # "lengthBuf":[B
    .end local v4    # "lengthBufV2":[B
    :catch_1
    move-exception v0

    .line 1145
    .local v0, "e":Ljava/lang/Exception;
    iget-object v2, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;

    invoke-static {v2}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;->access$getTAG$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;)Ljava/lang/String;

    move-result-object v2

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "\u6d88\u606f\u6d41\u65ad\u5f00\uff1a"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    filled-new-array {v3}, [Ljava/lang/Object;

    move-result-object v3

    invoke-static {v2, v3}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 1146
    iput-boolean v1, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->isSocketDateRunning:Z

    .line 1147
    iget-object v1, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;

    invoke-virtual {v1}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;->disconnect()V

    .line 1149
    .end local v0    # "e":Ljava/lang/Exception;
    :cond_5
    return-void
.end method

.method private static final handleMessageTransferContinuously$lambda$5(Ljava/lang/String;Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;)V
    .locals 10
    .param p0, "$msg"    # Ljava/lang/String;
    .param p1, "this$0"    # Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;

    const-string v0, "$msg"

    invoke-static {p0, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "this$0"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 1129
    const-string v0, "\u670d\u52a1\u5668\u5df2\u8fde\u63a5\u5176\u4ed6\u8bbe\u5907"

    const/4 v1, 0x0

    const/4 v2, 0x2

    const/4 v3, 0x0

    invoke-static {p0, v0, v1, v2, v3}, Lkotlin/text/StringsKt;->startsWith$default(Ljava/lang/String;Ljava/lang/String;ZILjava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    move-object v0, p0

    check-cast v0, Ljava/lang/CharSequence;

    const-string v4, "--code ="

    check-cast v4, Ljava/lang/CharSequence;

    invoke-static {v0, v4, v1, v2, v3}, Lkotlin/text/StringsKt;->contains$default(Ljava/lang/CharSequence;Ljava/lang/CharSequence;ZILjava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 1130
    const/4 v0, 0x1

    invoke-static {p1, v0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;->access$setRejected$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;Z)V

    .line 1131
    invoke-static {p1}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;->access$getTAG$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;)Ljava/lang/String;

    move-result-object v2

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "onConnectionRejected reason = "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    filled-new-array {v3}, [Ljava/lang/Object;

    move-result-object v3

    invoke-static {v2, v3}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 1132
    move-object v4, p0

    check-cast v4, Ljava/lang/CharSequence;

    new-array v5, v0, [Ljava/lang/String;

    const-string v0, "--"

    aput-object v0, v5, v1

    const/4 v8, 0x6

    const/4 v9, 0x0

    const/4 v6, 0x0

    const/4 v7, 0x0

    invoke-static/range {v4 .. v9}, Lkotlin/text/StringsKt;->split$default(Ljava/lang/CharSequence;[Ljava/lang/String;ZIILjava/lang/Object;)Ljava/util/List;

    move-result-object v0

    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    .line 1133
    .local v0, "reason":Ljava/lang/String;
    invoke-static {p1}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;->access$getMClientListeners$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;)Ljava/util/concurrent/CopyOnWriteArrayList;

    move-result-object v1

    check-cast v1, Ljava/lang/Iterable;

    .local v1, "$this$forEach$iv":Ljava/lang/Iterable;
    const/4 v2, 0x0

    .line 1454
    .local v2, "$i$f$forEach":I
    invoke-interface {v1}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :goto_0
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v4

    if-eqz v4, :cond_0

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v4

    .local v4, "element$iv":Ljava/lang/Object;
    move-object v5, v4

    check-cast v5, Lcom/rokid/glasses/transport/sdk/api/bluetooth/client/callback/IClassicClientListener;

    .local v5, "it":Lcom/rokid/glasses/transport/sdk/api/bluetooth/client/callback/IClassicClientListener;
    const/4 v6, 0x0

    .line 1133
    .local v6, "$i$a$-forEach-ClassicBlueToothClientManager$ConnectedThread$handleMessageTransferContinuously$1$1":I
    const/4 v7, -0x1

    invoke-interface {v5, v0, v7}, Lcom/rokid/glasses/transport/sdk/api/bluetooth/client/callback/IClassicClientListener;->onConnectionRejected(Ljava/lang/String;I)V

    .line 1454
    .end local v5    # "it":Lcom/rokid/glasses/transport/sdk/api/bluetooth/client/callback/IClassicClientListener;
    .end local v6    # "$i$a$-forEach-ClassicBlueToothClientManager$ConnectedThread$handleMessageTransferContinuously$1$1":I
    nop

    .end local v4    # "element$iv":Ljava/lang/Object;
    goto :goto_0

    .line 1455
    :cond_0
    nop

    .end local v0    # "reason":Ljava/lang/String;
    .end local v1    # "$this$forEach$iv":Ljava/lang/Iterable;
    .end local v2    # "$i$f$forEach":I
    goto :goto_2

    .line 1135
    :cond_1
    invoke-static {p1}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;->access$getMClientListeners$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;)Ljava/util/concurrent/CopyOnWriteArrayList;

    move-result-object v0

    check-cast v0, Ljava/lang/Iterable;

    .local v0, "$this$forEach$iv":Ljava/lang/Iterable;
    const/4 v1, 0x0

    .line 1456
    .local v1, "$i$f$forEach":I
    invoke-interface {v0}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_1
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_2

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    .local v3, "element$iv":Ljava/lang/Object;
    move-object v4, v3

    check-cast v4, Lcom/rokid/glasses/transport/sdk/api/bluetooth/client/callback/IClassicClientListener;

    .local v4, "it":Lcom/rokid/glasses/transport/sdk/api/bluetooth/client/callback/IClassicClientListener;
    const/4 v5, 0x0

    .line 1135
    .local v5, "$i$a$-forEach-ClassicBlueToothClientManager$ConnectedThread$handleMessageTransferContinuously$1$2":I
    invoke-interface {v4, p0}, Lcom/rokid/glasses/transport/sdk/api/bluetooth/client/callback/IClassicClientListener;->onMessageReceived(Ljava/lang/String;)V

    .line 1456
    .end local v4    # "it":Lcom/rokid/glasses/transport/sdk/api/bluetooth/client/callback/IClassicClientListener;
    .end local v5    # "$i$a$-forEach-ClassicBlueToothClientManager$ConnectedThread$handleMessageTransferContinuously$1$2":I
    nop

    .end local v3    # "element$iv":Ljava/lang/Object;
    goto :goto_1

    .line 1457
    :cond_2
    nop

    .line 1137
    .end local v0    # "$this$forEach$iv":Ljava/lang/Iterable;
    .end local v1    # "$i$f$forEach":I
    :goto_2
    return-void
.end method

.method private final handleMultiFileTransferContinuously()V
    .locals 14

    .line 922
    nop

    .line 923
    const/4 v0, 0x0

    const/4 v1, 0x0

    :try_start_0
    iget-object v2, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->inputStream:Ljava/io/InputStream;

    if-nez v2, :cond_0

    iget-object v2, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;

    move-object v3, p0

    check-cast v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;

    .local v3, "$this$handleMultiFileTransferContinuously_u24lambda_u242":Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;
    const/4 v4, 0x0

    .line 924
    .local v4, "$i$a$-run-ClassicBlueToothClientManager$ConnectedThread$handleMultiFileTransferContinuously$input$1":I
    invoke-static {v2}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;->access$getTAG$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;)Ljava/lang/String;

    move-result-object v2

    const-string v5, "\u8f93\u5165\u6d41\u4e3a\u7a7a\uff0c\u65e0\u6cd5\u63a5\u6536\u6587\u4ef6"

    filled-new-array {v5}, [Ljava/lang/Object;

    move-result-object v5

    invoke-static {v2, v5}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 925
    return-void

    .end local v3    # "$this$handleMultiFileTransferContinuously_u24lambda_u242":Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;
    .end local v4    # "$i$a$-run-ClassicBlueToothClientManager$ConnectedThread$handleMultiFileTransferContinuously$input$1":I
    :cond_0
    nop

    .line 927
    .local v2, "input":Ljava/io/InputStream;
    iget-object v3, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;

    invoke-static {v3}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;->access$getTAG$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;)Ljava/lang/String;

    move-result-object v3

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "isRunning = "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    iget-boolean v5, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->isSocketDateRunning:Z

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    filled-new-array {v4}, [Ljava/lang/Object;

    move-result-object v4

    invoke-static {v3, v4}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 929
    :cond_1
    :goto_0
    iget-boolean v3, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->isSocketDateRunning:Z

    if-eqz v3, :cond_16

    invoke-virtual {p0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->isInterrupted()Z

    move-result v3

    if-nez v3, :cond_16

    .line 931
    iget-object v3, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->inputStream:Ljava/io/InputStream;

    const/4 v4, -0x1

    if-eqz v3, :cond_2

    iget-object v5, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->buffer:[B

    invoke-virtual {v3, v5}, Ljava/io/InputStream;->read([B)I

    move-result v3

    goto :goto_1

    :cond_2
    move v3, v4

    :goto_1
    iput v3, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->bytes:I

    .line 933
    iget-object v3, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;

    invoke-static {v3}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;->access$getTAG$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;)Ljava/lang/String;

    move-result-object v3

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "bytes:"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    iget v6, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->bytes:I

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    filled-new-array {v5}, [Ljava/lang/Object;

    move-result-object v5

    invoke-static {v3, v5}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 934
    iget v3, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->bytes:I

    if-ne v3, v4, :cond_3

    .line 936
    goto/16 :goto_c

    .line 938
    :cond_3
    iget-object v3, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->socket:Landroid/bluetooth/BluetoothSocket;

    const/4 v4, 0x1

    if-eqz v3, :cond_4

    invoke-virtual {v3}, Landroid/bluetooth/BluetoothSocket;->isConnected()Z

    move-result v3

    if-ne v3, v4, :cond_4

    move v3, v4

    goto :goto_2

    :cond_4
    move v3, v1

    :goto_2
    if-nez v3, :cond_5

    .line 939
    return-void

    .line 942
    :cond_5
    iget-object v3, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;

    invoke-static {v3}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;->access$getTAG$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;)Ljava/lang/String;

    move-result-object v3

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "currentState:"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    iget-object v6, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->currentState:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ReceiveState;

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    filled-new-array {v5}, [Ljava/lang/Object;

    move-result-object v5

    invoke-static {v3, v5}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 943
    iget-object v3, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->currentState:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ReceiveState;

    sget-object v5, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$WhenMappings;->$EnumSwitchMapping$0:[I

    invoke-virtual {v3}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ReceiveState;->ordinal()I

    move-result v3

    aget v3, v5, v3
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    const-string v5, ""

    const-wide/16 v6, 0x0

    packed-switch v3, :pswitch_data_0

    goto/16 :goto_b

    .line 989
    :pswitch_0
    :try_start_1
    iget-object v3, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->currentFileOutputStream:Ljava/io/BufferedOutputStream;

    if-eqz v3, :cond_1

    iget-wide v3, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->currentFileSize:J

    cmp-long v3, v3, v6

    if-lez v3, :cond_1

    .line 991
    iget-object v3, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->currentFileOutputStream:Ljava/io/BufferedOutputStream;

    if-eqz v3, :cond_6

    iget-object v4, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->buffer:[B

    iget v6, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->bytes:I

    invoke-virtual {v3, v4, v1, v6}, Ljava/io/BufferedOutputStream;->write([BII)V

    .line 992
    :cond_6
    iget-wide v3, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->totalReceived:J

    iget v6, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->bytes:I

    int-to-long v6, v6

    add-long/2addr v3, v6

    iput-wide v3, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->totalReceived:J

    .line 994
    iget-wide v3, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->totalReceived:J

    long-to-float v3, v3

    iget-wide v6, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->currentFileSize:J

    long-to-float v4, v6

    div-float/2addr v3, v4

    const/16 v4, 0x64

    int-to-float v4, v4

    mul-float/2addr v3, v4

    .line 996
    .local v3, "progress":F
    mul-float/2addr v4, v3

    invoke-static {v4}, Lkotlin/math/MathKt;->roundToInt(F)I

    move-result v4

    int-to-float v4, v4

    const/high16 v6, 0x42c80000    # 100.0f

    div-float/2addr v4, v6

    .line 997
    .local v4, "roundedProgress":F
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v7

    .line 998
    .local v7, "currentTime":J
    iget-wide v9, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->lastReceiveProgressTime:J

    sub-long v9, v7, v9

    iget-wide v11, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->RECEIVE_PROGRESS_INTERVAL:J

    cmp-long v9, v9, v11

    if-gez v9, :cond_7

    .line 999
    cmpl-float v6, v4, v6

    if-gez v6, :cond_7

    .line 1000
    iget v6, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->lastReceiveProgressValue:F

    sub-float v6, v4, v6

    const/high16 v9, 0x3f800000    # 1.0f

    cmpl-float v6, v6, v9

    if-ltz v6, :cond_a

    .line 1002
    :cond_7
    iget-object v6, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;

    invoke-static {v6}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;->access$getMFileReceiveListener$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;)Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$mFileReceiveListener$1;

    move-result-object v6

    iget-object v9, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->saveFile:Ljava/io/File;

    if-eqz v9, :cond_8

    invoke-virtual {v9}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v9

    goto :goto_3

    :cond_8
    move-object v9, v0

    :goto_3
    if-nez v9, :cond_9

    move-object v9, v5

    :cond_9
    invoke-virtual {v6, v9, v4}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$mFileReceiveListener$1;->onProgressChanged(Ljava/lang/String;F)V

    .line 1003
    iput-wide v7, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->lastReceiveProgressTime:J

    .line 1004
    iput v4, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->lastReceiveProgressValue:F

    .line 1008
    :cond_a
    iget-wide v9, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->totalReceived:J

    iget-wide v11, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->currentFileSize:J

    cmp-long v6, v9, v11

    if-ltz v6, :cond_1

    .line 1010
    iget-object v6, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->currentFileOutputStream:Ljava/io/BufferedOutputStream;

    if-eqz v6, :cond_b

    invoke-virtual {v6}, Ljava/io/BufferedOutputStream;->flush()V

    .line 1011
    :cond_b
    iget-object v6, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->currentFileOutputStream:Ljava/io/BufferedOutputStream;

    if-eqz v6, :cond_c

    invoke-virtual {v6}, Ljava/io/BufferedOutputStream;->close()V

    .line 1013
    :cond_c
    iget-object v6, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;

    invoke-static {v6}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;->access$getMFileReceiveListener$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;)Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$mFileReceiveListener$1;

    move-result-object v6

    if-eqz v6, :cond_f

    iget-object v9, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->saveFile:Ljava/io/File;

    if-eqz v9, :cond_d

    invoke-virtual {v9}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v9

    goto :goto_4

    :cond_d
    move-object v9, v0

    :goto_4
    if-nez v9, :cond_e

    goto :goto_5

    :cond_e
    move-object v5, v9

    :goto_5
    invoke-virtual {v6, v5}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$mFileReceiveListener$1;->onComplete(Ljava/lang/String;)V

    .line 1015
    :cond_f
    invoke-virtual {p0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->resetFileReceiveState()V

    goto/16 :goto_b

    .line 943
    .end local v3    # "progress":F
    .end local v4    # "roundedProgress":F
    .end local v7    # "currentTime":J
    :pswitch_1
    new-instance v3, Ljava/lang/String;

    .line 946
    iget-object v8, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->buffer:[B

    iget v9, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->bytes:I

    sget-object v10, Lkotlin/text/Charsets;->UTF_8:Ljava/nio/charset/Charset;

    invoke-direct {v3, v8, v1, v9, v10}, Ljava/lang/String;-><init>([BIILjava/nio/charset/Charset;)V

    .line 947
    .local v3, "metadata":Ljava/lang/String;
    move-object v8, v3

    check-cast v8, Ljava/lang/CharSequence;

    new-array v9, v4, [Ljava/lang/String;

    const-string v10, "|"

    aput-object v10, v9, v1

    const/4 v12, 0x6

    const/4 v13, 0x0

    const/4 v10, 0x0

    const/4 v11, 0x0

    invoke-static/range {v8 .. v13}, Lkotlin/text/StringsKt;->split$default(Ljava/lang/CharSequence;[Ljava/lang/String;ZIILjava/lang/Object;)Ljava/util/List;

    move-result-object v8

    .line 949
    .local v8, "parts":Ljava/util/List;
    invoke-interface {v8}, Ljava/util/List;->size()I

    move-result v9

    const/4 v10, 0x2

    if-ne v9, v10, :cond_1

    .line 950
    invoke-interface {v8, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v9

    check-cast v9, Ljava/lang/String;

    iput-object v9, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->currentFileName:Ljava/lang/String;

    .line 951
    invoke-interface {v8, v4}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/lang/String;

    invoke-static {v4}, Lkotlin/text/StringsKt;->toLongOrNull(Ljava/lang/String;)Ljava/lang/Long;

    move-result-object v4

    if-eqz v4, :cond_10

    invoke-virtual {v4}, Ljava/lang/Long;->longValue()J

    move-result-wide v9

    goto :goto_6

    :cond_10
    move-wide v9, v6

    :goto_6
    iput-wide v9, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->currentFileSize:J

    .line 953
    iget-object v4, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;

    invoke-static {v4}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;->access$getTAG$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;)Ljava/lang/String;

    move-result-object v4

    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    const-string v10, "currentFileName:"

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    iget-object v10, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->currentFileName:Ljava/lang/String;

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    const-string v10, " currentFileSize:"

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    iget-wide v10, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->currentFileSize:J

    invoke-virtual {v9, v10, v11}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    filled-new-array {v9}, [Ljava/lang/Object;

    move-result-object v9

    invoke-static {v4, v9}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 955
    iget-wide v9, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->currentFileSize:J

    cmp-long v4, v9, v6

    if-lez v4, :cond_1

    iget-object v4, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->currentFileName:Ljava/lang/String;

    if-eqz v4, :cond_1

    .line 957
    iget-wide v9, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->currentFileSize:J

    const-wide/32 v11, 0x100000

    cmp-long v4, v9, v11

    if-lez v4, :cond_11

    .line 958
    const/high16 v4, 0x10000

    new-array v4, v4, [B

    iput-object v4, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->buffer:[B

    goto :goto_7

    .line 960
    :cond_11
    iget v4, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->baseBufferSize:I

    new-array v4, v4, [B

    iput-object v4, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->buffer:[B

    .line 962
    :goto_7
    new-instance v4, Ljava/io/File;

    iget-object v9, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;

    invoke-virtual {v9}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;->getSaveDirectory()Ljava/lang/String;

    move-result-object v9

    iget-object v10, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->currentFileName:Ljava/lang/String;

    invoke-direct {v4, v9, v10}, Ljava/io/File;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    iput-object v4, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->saveFile:Ljava/io/File;

    .line 963
    iget-object v4, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->saveFile:Ljava/io/File;

    if-eqz v4, :cond_12

    invoke-virtual {v4}, Ljava/io/File;->getParentFile()Ljava/io/File;

    move-result-object v4

    goto :goto_8

    :cond_12
    move-object v4, v0

    .line 964
    .local v4, "parentDir":Ljava/io/File;
    :goto_8
    if-eqz v4, :cond_13

    invoke-virtual {v4}, Ljava/io/File;->exists()Z

    move-result v9

    if-nez v9, :cond_13

    .line 966
    invoke-virtual {v4}, Ljava/io/File;->mkdirs()Z

    move-result v9

    .line 967
    .local v9, "isDirCreated":Z
    if-nez v9, :cond_13

    .line 969
    const-string v5, "FileError"

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "\u65e0\u6cd5\u521b\u5efa\u76ee\u5f55: "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v4}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    filled-new-array {v6}, [Ljava/lang/Object;

    move-result-object v6

    invoke-static {v5, v6}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 970
    return-void

    .line 974
    .end local v9    # "isDirCreated":Z
    :cond_13
    new-instance v9, Ljava/io/BufferedOutputStream;

    new-instance v10, Ljava/io/FileOutputStream;

    iget-object v11, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->saveFile:Ljava/io/File;

    invoke-direct {v10, v11}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V

    check-cast v10, Ljava/io/OutputStream;

    invoke-direct {v9, v10}, Ljava/io/BufferedOutputStream;-><init>(Ljava/io/OutputStream;)V

    iput-object v9, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->currentFileOutputStream:Ljava/io/BufferedOutputStream;

    .line 977
    sget-object v9, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ReceiveState;->RECEIVING_FILE_CONTENT:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ReceiveState;

    iput-object v9, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->currentState:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ReceiveState;

    .line 978
    iput-wide v6, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->totalReceived:J

    .line 981
    iget-object v6, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;

    invoke-static {v6}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;->access$getMFileReceiveListener$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;)Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$mFileReceiveListener$1;

    move-result-object v6

    if-eqz v6, :cond_1

    iget-object v7, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->saveFile:Ljava/io/File;

    if-eqz v7, :cond_14

    invoke-virtual {v7}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v7

    goto :goto_9

    :cond_14
    move-object v7, v0

    :goto_9
    if-nez v7, :cond_15

    goto :goto_a

    :cond_15
    move-object v5, v7

    :goto_a
    invoke-virtual {v6, v5}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$mFileReceiveListener$1;->onStart(Ljava/lang/String;)V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    goto/16 :goto_0

    .line 1015
    .end local v3    # "metadata":Ljava/lang/String;
    .end local v4    # "parentDir":Ljava/io/File;
    .end local v8    # "parts":Ljava/util/List;
    :goto_b
    goto/16 :goto_0

    .line 1021
    .end local v2    # "input":Ljava/io/InputStream;
    :catch_0
    move-exception v2

    .line 1022
    .local v2, "e":Ljava/lang/Exception;
    invoke-virtual {v2}, Ljava/lang/Exception;->printStackTrace()V

    .line 1023
    iget-object v3, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;

    invoke-static {v3}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;->access$getTAG$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;)Ljava/lang/String;

    move-result-object v3

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "Exception->"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v2}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    filled-new-array {v4}, [Ljava/lang/Object;

    move-result-object v4

    invoke-static {v3, v4}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 1024
    iput-boolean v1, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->isSocketDateRunning:Z

    .line 1026
    iget-object v1, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->mType:Ljava/lang/String;

    sget-object v3, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->Companion:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$Companion;

    invoke-virtual {v3}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$Companion;->getFILE_TYPE()Ljava/lang/String;

    move-result-object v3

    invoke-static {v1, v3}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_16

    iget-object v1, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;

    invoke-static {v1}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;->access$getConnectBluetoothDevice$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;)Landroid/bluetooth/BluetoothDevice;

    move-result-object v1

    if-eqz v1, :cond_16

    .line 1027
    invoke-static {}, Lcom/rokid/glasses/transport/sdk/server/utils/ScopesKt;->getMainScope()Lkotlinx/coroutines/CoroutineScope;

    move-result-object v3

    new-instance v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$handleMultiFileTransferContinuously$1;

    iget-object v4, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;

    invoke-direct {v1, v4, p0, v0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$handleMultiFileTransferContinuously$1;-><init>(Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;Lkotlin/coroutines/Continuation;)V

    move-object v6, v1

    check-cast v6, Lkotlin/jvm/functions/Function2;

    const/4 v7, 0x3

    const/4 v8, 0x0

    const/4 v4, 0x0

    const/4 v5, 0x0

    invoke-static/range {v3 .. v8}, Lkotlinx/coroutines/BuildersKt;->launch$default(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/CoroutineContext;Lkotlinx/coroutines/CoroutineStart;Lkotlin/jvm/functions/Function2;ILjava/lang/Object;)Lkotlinx/coroutines/Job;

    .line 1035
    .end local v2    # "e":Ljava/lang/Exception;
    :cond_16
    :goto_c
    return-void

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method private final handleStreamContinuously()V
    .locals 8

    .line 749
    nop

    .line 750
    const/4 v0, 0x0

    :try_start_0
    iget-object v1, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->inputStream:Ljava/io/InputStream;

    if-nez v1, :cond_0

    iget-object v1, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;

    move-object v2, p0

    check-cast v2, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;

    .local v2, "$this$handleStreamContinuously_u24lambda_u240":Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;
    const/4 v3, 0x0

    .line 751
    .local v3, "$i$a$-run-ClassicBlueToothClientManager$ConnectedThread$handleStreamContinuously$input$1":I
    invoke-static {v1}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;->access$getTAG$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;)Ljava/lang/String;

    move-result-object v1

    const-string v4, "\u8f93\u5165\u6d41\u4e3a\u7a7a\uff0c\u65e0\u6cd5\u63a5\u6536\u6587\u4ef6"

    filled-new-array {v4}, [Ljava/lang/Object;

    move-result-object v4

    invoke-static {v1, v4}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 752
    return-void

    .end local v2    # "$this$handleStreamContinuously_u24lambda_u240":Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;
    .end local v3    # "$i$a$-run-ClassicBlueToothClientManager$ConnectedThread$handleStreamContinuously$input$1":I
    :cond_0
    nop

    .line 754
    .local v1, "input":Ljava/io/InputStream;
    new-instance v2, Ljava/io/ByteArrayOutputStream;

    invoke-direct {v2}, Ljava/io/ByteArrayOutputStream;-><init>()V

    .local v2, "streamBuffer":Ljava/io/ByteArrayOutputStream;
    const/4 v3, 0x0

    .line 757
    .local v3, "bytes":I
    iget-object v4, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;

    invoke-static {v4}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;->access$getTAG$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;)Ljava/lang/String;

    move-result-object v4

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "isRunning = "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    iget-boolean v6, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->isSocketDateRunning:Z

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    filled-new-array {v5}, [Ljava/lang/Object;

    move-result-object v5

    invoke-static {v4, v5}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 759
    :goto_0
    iget-boolean v4, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->isSocketDateRunning:Z

    if-eqz v4, :cond_5

    invoke-virtual {p0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->isInterrupted()Z

    move-result v4

    if-nez v4, :cond_5

    .line 761
    iget-object v4, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->inputStream:Ljava/io/InputStream;

    const/4 v5, -0x1

    if-eqz v4, :cond_1

    iget-object v6, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->buffer:[B

    invoke-virtual {v4, v6}, Ljava/io/InputStream;->read([B)I

    move-result v4

    goto :goto_1

    :cond_1
    move v4, v5

    :goto_1
    move v3, v4

    .line 764
    if-ne v3, v5, :cond_2

    .line 766
    goto :goto_3

    .line 768
    :cond_2
    iget-object v4, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->socket:Landroid/bluetooth/BluetoothSocket;

    if-eqz v4, :cond_3

    invoke-virtual {v4}, Landroid/bluetooth/BluetoothSocket;->isConnected()Z

    move-result v4

    const/4 v5, 0x1

    if-ne v4, v5, :cond_3

    goto :goto_2

    :cond_3
    move v5, v0

    :goto_2
    if-nez v5, :cond_4

    .line 769
    return-void

    .line 773
    :cond_4
    iget-object v4, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->buffer:[B

    invoke-virtual {v2, v4, v0, v3}, Ljava/io/ByteArrayOutputStream;->write([BII)V

    .line 775
    invoke-direct {p0, v2}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->processStreamPackets(Ljava/io/ByteArrayOutputStream;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 777
    .end local v1    # "input":Ljava/io/InputStream;
    .end local v2    # "streamBuffer":Ljava/io/ByteArrayOutputStream;
    .end local v3    # "bytes":I
    :catch_0
    move-exception v1

    .line 778
    .local v1, "e":Ljava/lang/Exception;
    invoke-virtual {v1}, Ljava/lang/Exception;->printStackTrace()V

    .line 779
    iget-object v2, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;

    invoke-static {v2}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;->access$getTAG$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;)Ljava/lang/String;

    move-result-object v2

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "Exception->"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v1}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    filled-new-array {v3}, [Ljava/lang/Object;

    move-result-object v3

    invoke-static {v2, v3}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 780
    iput-boolean v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->isSocketDateRunning:Z

    .line 782
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->mType:Ljava/lang/String;

    sget-object v2, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->Companion:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$Companion;

    invoke-virtual {v2}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$Companion;->getSTREAM_TYPE()Ljava/lang/String;

    move-result-object v2

    invoke-static {v0, v2}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_5

    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;

    invoke-static {v0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;->access$getConnectBluetoothDevice$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;)Landroid/bluetooth/BluetoothDevice;

    move-result-object v0

    if-eqz v0, :cond_5

    .line 783
    invoke-static {}, Lcom/rokid/glasses/transport/sdk/server/utils/ScopesKt;->getMainScope()Lkotlinx/coroutines/CoroutineScope;

    move-result-object v2

    new-instance v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$handleStreamContinuously$1;

    iget-object v3, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;

    const/4 v4, 0x0

    invoke-direct {v0, v3, p0, v4}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$handleStreamContinuously$1;-><init>(Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;Lkotlin/coroutines/Continuation;)V

    move-object v5, v0

    check-cast v5, Lkotlin/jvm/functions/Function2;

    const/4 v6, 0x3

    const/4 v7, 0x0

    const/4 v3, 0x0

    invoke-static/range {v2 .. v7}, Lkotlinx/coroutines/BuildersKt;->launch$default(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/CoroutineContext;Lkotlinx/coroutines/CoroutineStart;Lkotlin/jvm/functions/Function2;ILjava/lang/Object;)Lkotlinx/coroutines/Job;

    .line 790
    .end local v1    # "e":Ljava/lang/Exception;
    :cond_5
    :goto_3
    return-void
.end method

.method private final onAudioStreamDisconnected(Landroid/bluetooth/BluetoothDevice;)V
    .locals 1
    .param p1, "device"    # Landroid/bluetooth/BluetoothDevice;

    .line 800
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;

    invoke-virtual {v0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;->isConnected()Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;

    invoke-static {v0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;->access$isAudioRetryEnabled$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 801
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;

    invoke-static {v0, p1}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;->access$startAudioRetry(Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;Landroid/bluetooth/BluetoothDevice;)V

    .line 803
    :cond_0
    return-void
.end method

.method private final onFileStreamDisconnected(Landroid/bluetooth/BluetoothDevice;)V
    .locals 1
    .param p1, "device"    # Landroid/bluetooth/BluetoothDevice;

    .line 1039
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;

    invoke-virtual {v0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;->isConnected()Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;

    invoke-static {v0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;->access$isFileRetryEnabled$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 1040
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;

    invoke-static {v0, p1}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;->access$startFileRetry(Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;Landroid/bluetooth/BluetoothDevice;)V

    .line 1042
    :cond_0
    return-void
.end method

.method private final onStreamDisconnected(Landroid/bluetooth/BluetoothDevice;)V
    .locals 1
    .param p1, "device"    # Landroid/bluetooth/BluetoothDevice;

    .line 793
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;

    invoke-virtual {v0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;->isConnected()Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;

    invoke-static {v0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;->access$isStreamRetryEnabled$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 794
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;

    invoke-static {v0, p1}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;->access$startStreamRetry(Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;Landroid/bluetooth/BluetoothDevice;)V

    .line 796
    :cond_0
    return-void
.end method

.method private final processAudioStreamPackets(Ljava/io/ByteArrayOutputStream;)V
    .locals 6
    .param p1, "buffer"    # Ljava/io/ByteArrayOutputStream;

    .line 1196
    invoke-virtual {p1}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object v0

    .line 1197
    .local v0, "data":[B
    const/4 v1, 0x0

    .line 1200
    .local v1, "offset":I
    :goto_0
    array-length v2, v0

    sub-int/2addr v2, v1

    const/16 v3, 0x400

    if-lt v2, v3, :cond_0

    .line 1201
    new-array v2, v3, [B

    .line 1202
    .local v2, "completePacket":[B
    const/4 v4, 0x0

    invoke-static {v0, v1, v2, v4, v3}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 1203
    add-int/lit16 v1, v1, 0x400

    .line 1206
    iget-object v3, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;

    invoke-static {v3}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;->access$getMainHandler$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;)Landroid/os/Handler;

    move-result-object v3

    iget-object v4, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;

    new-instance v5, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$$ExternalSyntheticLambda0;

    invoke-direct {v5, p0, v4, v2}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$$ExternalSyntheticLambda0;-><init>(Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;[B)V

    invoke-virtual {v3, v5}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    goto :goto_0

    .line 1220
    .end local v2    # "completePacket":[B
    :cond_0
    if-lez v1, :cond_1

    .line 1221
    invoke-virtual {p1}, Ljava/io/ByteArrayOutputStream;->reset()V

    .line 1222
    array-length v2, v0

    if-ge v1, v2, :cond_1

    .line 1223
    array-length v2, v0

    sub-int/2addr v2, v1

    invoke-virtual {p1, v0, v1, v2}, Ljava/io/ByteArrayOutputStream;->write([BII)V

    .line 1226
    :cond_1
    return-void
.end method

.method private static final processAudioStreamPackets$lambda$7(Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;[B)V
    .locals 6
    .param p0, "this$0"    # Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;
    .param p1, "this$1"    # Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;
    .param p2, "$completePacket"    # [B

    const-string v0, "this$0"

    invoke-static {p0, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "this$1"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "$completePacket"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 1207
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->mType:Ljava/lang/String;

    sget-object v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->Companion:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$Companion;

    invoke-virtual {v1}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$Companion;->getAUDIO_TYPE()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 1208
    invoke-static {p1}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;->access$getTAG$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "onAudioReceived: \u5b8c\u6574\u6570\u636e\u5305, size=1024"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 1209
    nop

    .line 1210
    :try_start_0
    invoke-static {p1}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;->access$getMClientListeners$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;)Ljava/util/concurrent/CopyOnWriteArrayList;

    move-result-object v0

    check-cast v0, Ljava/lang/Iterable;

    .local v0, "$this$forEach$iv":Ljava/lang/Iterable;
    const/4 v1, 0x0

    .line 1458
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

    check-cast v4, Lcom/rokid/glasses/transport/sdk/api/bluetooth/client/callback/IClassicClientListener;

    .local v4, "it":Lcom/rokid/glasses/transport/sdk/api/bluetooth/client/callback/IClassicClientListener;
    const/4 v5, 0x0

    .line 1210
    .local v5, "$i$a$-forEach-ClassicBlueToothClientManager$ConnectedThread$processAudioStreamPackets$1$1":I
    invoke-interface {v4, p2}, Lcom/rokid/glasses/transport/sdk/api/bluetooth/client/callback/IClassicClientListener;->onAudioReceived([B)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 1458
    .end local v4    # "it":Lcom/rokid/glasses/transport/sdk/api/bluetooth/client/callback/IClassicClientListener;
    .end local v5    # "$i$a$-forEach-ClassicBlueToothClientManager$ConnectedThread$processAudioStreamPackets$1$1":I
    nop

    .end local v3    # "element$iv":Ljava/lang/Object;
    goto :goto_0

    .line 1459
    :cond_0
    nop

    .end local v0    # "$this$forEach$iv":Ljava/lang/Iterable;
    .end local v1    # "$i$f$forEach":I
    goto :goto_1

    .line 1211
    :catch_0
    move-exception v0

    .line 1212
    .local v0, "e":Ljava/lang/Exception;
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    .line 1213
    invoke-static {p1}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;->access$getTAG$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;)Ljava/lang/String;

    move-result-object v1

    const-string v2, "--\u4e1a\u52a1\u65b9\u5904\u7406\u6d88\u606f\u903b\u8f91\u51fa\u73b0\u5f02\u5e38"

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 1216
    .end local v0    # "e":Ljava/lang/Exception;
    :cond_1
    :goto_1
    return-void
.end method

.method private final processStreamPackets(Ljava/io/ByteArrayOutputStream;)V
    .locals 18
    .param p1, "streamBuffer"    # Ljava/io/ByteArrayOutputStream;

    .line 807
    move-object/from16 v1, p0

    invoke-virtual/range {p1 .. p1}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object v2

    .line 808
    .local v2, "data":[B
    const/4 v0, 0x0

    .line 811
    .local v0, "offset":I
    :goto_0
    array-length v3, v2

    if-ge v0, v3, :cond_d

    .line 812
    iget-object v3, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->currentState:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ReceiveState;

    sget-object v4, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$WhenMappings;->$EnumSwitchMapping$0:[I

    invoke-virtual {v3}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ReceiveState;->ordinal()I

    move-result v3

    aget v3, v4, v3

    const/4 v4, 0x0

    const-wide/16 v5, 0x0

    packed-switch v3, :pswitch_data_0

    goto/16 :goto_7

    .line 857
    :pswitch_0
    iget-object v3, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->tag:Ljava/lang/String;

    if-eqz v3, :cond_8

    iget-object v3, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->clientId:Ljava/lang/String;

    if-eqz v3, :cond_8

    iget-wide v7, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->dataSize:J

    cmp-long v3, v7, v5

    if-lez v3, :cond_8

    .line 858
    array-length v3, v2

    sub-int/2addr v3, v0

    .line 859
    .local v3, "remainingInBuffer":I
    iget-wide v5, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->dataSize:J

    iget-wide v7, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->totalReceived:J

    sub-long/2addr v5, v7

    .line 860
    .local v5, "remainingToRead":J
    long-to-int v7, v5

    invoke-static {v3, v7}, Ljava/lang/Math;->min(II)I

    move-result v7

    .line 862
    .local v7, "bytesToProcess":I
    if-lez v7, :cond_7

    .line 864
    iget-object v8, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->byteArrayOutputStream:Ljava/io/ByteArrayOutputStream;

    if-eqz v8, :cond_0

    invoke-virtual {v8, v2, v0, v7}, Ljava/io/ByteArrayOutputStream;->write([BII)V

    .line 865
    :cond_0
    iget-wide v8, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->totalReceived:J

    int-to-long v10, v7

    add-long/2addr v8, v10

    iput-wide v8, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->totalReceived:J

    .line 866
    add-int v8, v0, v7

    .line 869
    .end local v0    # "offset":I
    .local v8, "offset":I
    iget-wide v9, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->totalReceived:J

    iget-wide v11, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->dataSize:J

    cmp-long v0, v9, v11

    if-ltz v0, :cond_6

    .line 870
    iget-object v0, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->byteArrayOutputStream:Ljava/io/ByteArrayOutputStream;

    if-eqz v0, :cond_1

    invoke-virtual {v0}, Ljava/io/ByteArrayOutputStream;->flush()V

    .line 871
    :cond_1
    iget-object v0, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->byteArrayOutputStream:Ljava/io/ByteArrayOutputStream;

    if-eqz v0, :cond_2

    invoke-virtual {v0}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object v0

    goto :goto_1

    :cond_2
    const/4 v0, 0x0

    :goto_1
    if-nez v0, :cond_3

    new-array v0, v4, [B

    :cond_3
    move-object v4, v0

    .line 872
    .local v4, "packetData":[B
    iget-object v0, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->byteArrayOutputStream:Ljava/io/ByteArrayOutputStream;

    if-eqz v0, :cond_4

    invoke-virtual {v0}, Ljava/io/ByteArrayOutputStream;->close()V

    .line 873
    :cond_4
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v9

    .line 875
    .local v9, "time":J
    iget-object v0, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;

    invoke-static {v0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;->access$getTAG$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;)Ljava/lang/String;

    move-result-object v0

    new-instance v11, Ljava/lang/StringBuilder;

    invoke-direct {v11}, Ljava/lang/StringBuilder;-><init>()V

    const-string v12, "onStreamReceived \u63a5\u6536\u5b8c\u6210 - tag = "

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    iget-object v12, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->tag:Ljava/lang/String;

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    const-string v12, ", clientid = "

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    iget-object v12, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->clientId:Ljava/lang/String;

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    const-string v12, ", size = "

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    array-length v12, v4

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v11

    const-string v12, " \u8017\u65f6:"

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    iget-wide v12, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->startTime:J

    sub-long v12, v9, v12

    invoke-virtual {v11, v12, v13}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v11

    const-string v12, "ms"

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v11

    filled-new-array {v11}, [Ljava/lang/Object;

    move-result-object v11

    invoke-static {v0, v11}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 876
    nop

    .line 877
    :try_start_0
    iget-object v0, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;

    invoke-static {v0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;->access$getMClientListeners$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;)Ljava/util/concurrent/CopyOnWriteArrayList;

    move-result-object v0

    check-cast v0, Ljava/lang/Iterable;

    .local v0, "$this$forEach$iv":Ljava/lang/Iterable;
    const/4 v11, 0x0

    .line 1452
    .local v11, "$i$f$forEach":I
    invoke-interface {v0}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v12

    :goto_2
    invoke-interface {v12}, Ljava/util/Iterator;->hasNext()Z

    move-result v13

    if-eqz v13, :cond_5

    invoke-interface {v12}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v13

    .local v13, "element$iv":Ljava/lang/Object;
    move-object v14, v13

    check-cast v14, Lcom/rokid/glasses/transport/sdk/api/bluetooth/client/callback/IClassicClientListener;

    .local v14, "it":Lcom/rokid/glasses/transport/sdk/api/bluetooth/client/callback/IClassicClientListener;
    const/4 v15, 0x0

    .line 877
    .local v15, "$i$a$-forEach-ClassicBlueToothClientManager$ConnectedThread$processStreamPackets$1":I
    move-object/from16 v16, v0

    .end local v0    # "$this$forEach$iv":Ljava/lang/Iterable;
    .local v16, "$this$forEach$iv":Ljava/lang/Iterable;
    iget-object v0, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->tag:Ljava/lang/String;

    invoke-static {v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_1

    move/from16 v17, v3

    .end local v3    # "remainingInBuffer":I
    .local v17, "remainingInBuffer":I
    :try_start_1
    iget-object v3, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->clientId:Ljava/lang/String;

    invoke-static {v3}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;)V

    invoke-interface {v14, v0, v4, v3}, Lcom/rokid/glasses/transport/sdk/api/bluetooth/client/callback/IClassicClientListener;->onStreamReceived(Ljava/lang/String;[BLjava/lang/String;)V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    .line 1452
    .end local v14    # "it":Lcom/rokid/glasses/transport/sdk/api/bluetooth/client/callback/IClassicClientListener;
    .end local v15    # "$i$a$-forEach-ClassicBlueToothClientManager$ConnectedThread$processStreamPackets$1":I
    move-object/from16 v0, v16

    move/from16 v3, v17

    .end local v13    # "element$iv":Ljava/lang/Object;
    goto :goto_2

    .line 878
    .end local v11    # "$i$f$forEach":I
    .end local v16    # "$this$forEach$iv":Ljava/lang/Iterable;
    :catch_0
    move-exception v0

    goto :goto_3

    .line 1453
    .end local v17    # "remainingInBuffer":I
    .restart local v0    # "$this$forEach$iv":Ljava/lang/Iterable;
    .restart local v3    # "remainingInBuffer":I
    .restart local v11    # "$i$f$forEach":I
    :cond_5
    move-object/from16 v16, v0

    move/from16 v17, v3

    .end local v0    # "$this$forEach$iv":Ljava/lang/Iterable;
    .end local v3    # "remainingInBuffer":I
    .end local v11    # "$i$f$forEach":I
    .restart local v17    # "remainingInBuffer":I
    goto :goto_4

    .line 878
    .end local v17    # "remainingInBuffer":I
    .restart local v3    # "remainingInBuffer":I
    :catch_1
    move-exception v0

    move/from16 v17, v3

    .line 879
    .end local v3    # "remainingInBuffer":I
    .local v0, "e":Ljava/lang/Exception;
    .restart local v17    # "remainingInBuffer":I
    :goto_3
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    .line 880
    iget-object v3, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;

    invoke-static {v3}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;->access$getTAG$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;)Ljava/lang/String;

    move-result-object v3

    const-string v11, "\u4e1a\u52a1\u65b9\u5904\u7406\u6d88\u606f\u903b\u8f91\u51fa\u73b0\u5f02\u5e38"

    filled-new-array {v11}, [Ljava/lang/Object;

    move-result-object v11

    invoke-static {v3, v11}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 884
    .end local v0    # "e":Ljava/lang/Exception;
    :goto_4
    invoke-virtual/range {p0 .. p0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->resetStreamReceiveState()V

    .end local v4    # "packetData":[B
    .end local v9    # "time":J
    goto :goto_5

    .line 869
    .end local v17    # "remainingInBuffer":I
    .restart local v3    # "remainingInBuffer":I
    :cond_6
    move/from16 v17, v3

    .line 811
    .end local v3    # "remainingInBuffer":I
    .end local v5    # "remainingToRead":J
    .end local v7    # "bytesToProcess":I
    :goto_5
    move v0, v8

    goto/16 :goto_0

    .line 888
    .end local v8    # "offset":I
    .local v0, "offset":I
    .restart local v3    # "remainingInBuffer":I
    .restart local v5    # "remainingToRead":J
    .restart local v7    # "bytesToProcess":I
    :cond_7
    move/from16 v17, v3

    .end local v3    # "remainingInBuffer":I
    .restart local v17    # "remainingInBuffer":I
    goto/16 :goto_8

    .line 892
    .end local v5    # "remainingToRead":J
    .end local v7    # "bytesToProcess":I
    .end local v17    # "remainingInBuffer":I
    :cond_8
    invoke-virtual/range {p0 .. p0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->resetStreamReceiveState()V

    goto/16 :goto_7

    .line 815
    :pswitch_1
    sget-object v3, Lcom/rokid/glasses/transport/sdk/server/utils/DataUtils;->INSTANCE:Lcom/rokid/glasses/transport/sdk/server/utils/DataUtils;

    const-string v7, "data"

    invoke-static {v2, v7}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-virtual {v3, v2, v0}, Lcom/rokid/glasses/transport/sdk/server/utils/DataUtils;->findEndMarkerIndex([BI)I

    move-result v3

    .line 816
    .local v3, "endMarkerIndex":I
    const/4 v7, -0x1

    if-eq v3, v7, :cond_c

    .line 818
    sub-int v7, v3, v0

    .local v7, "metadataLength":I
    new-instance v8, Ljava/lang/String;

    .line 819
    sget-object v9, Lkotlin/text/Charsets;->UTF_8:Ljava/nio/charset/Charset;

    invoke-direct {v8, v2, v0, v7, v9}, Ljava/lang/String;-><init>([BIILjava/nio/charset/Charset;)V

    .line 820
    .local v8, "metadata":Ljava/lang/String;
    move-object v9, v8

    check-cast v9, Ljava/lang/CharSequence;

    const/4 v15, 0x1

    new-array v10, v15, [Ljava/lang/String;

    const-string v11, "|"

    aput-object v11, v10, v4

    const/4 v13, 0x6

    const/4 v14, 0x0

    const/4 v11, 0x0

    const/4 v12, 0x0

    invoke-static/range {v9 .. v14}, Lkotlin/text/StringsKt;->split$default(Ljava/lang/CharSequence;[Ljava/lang/String;ZIILjava/lang/Object;)Ljava/util/List;

    move-result-object v9

    .line 822
    .local v9, "parts":Ljava/util/List;
    invoke-interface {v9}, Ljava/util/List;->size()I

    move-result v10

    const/4 v11, 0x3

    if-ne v10, v11, :cond_b

    .line 823
    invoke-interface {v9, v4}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/lang/String;

    iput-object v4, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->tag:Ljava/lang/String;

    .line 824
    invoke-interface {v9, v15}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/lang/String;

    iput-object v4, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->clientId:Ljava/lang/String;

    .line 825
    const/4 v4, 0x2

    invoke-interface {v9, v4}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/lang/String;

    invoke-static {v4}, Lkotlin/text/StringsKt;->toLongOrNull(Ljava/lang/String;)Ljava/lang/Long;

    move-result-object v4

    if-eqz v4, :cond_9

    invoke-virtual {v4}, Ljava/lang/Long;->longValue()J

    move-result-wide v10

    goto :goto_6

    :cond_9
    move-wide v10, v5

    :goto_6
    iput-wide v10, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->dataSize:J

    .line 827
    iget-object v4, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;

    invoke-static {v4}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;->access$getTAG$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;)Ljava/lang/String;

    move-result-object v4

    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    const-string v11, "\u89e3\u6790\u5143\u6570\u636e - tag = "

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    iget-object v11, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->tag:Ljava/lang/String;

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    const-string v11, ", clientId = "

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    iget-object v11, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->clientId:Ljava/lang/String;

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    const-string v11, ", dataSize = "

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    iget-wide v11, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->dataSize:J

    invoke-virtual {v10, v11, v12}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    filled-new-array {v10}, [Ljava/lang/Object;

    move-result-object v10

    invoke-static {v4, v10}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 829
    iget-wide v10, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->dataSize:J

    cmp-long v4, v10, v5

    const-string v10, "this as java.lang.String).getBytes(charset)"

    const-string v11, "\\u2063\\u2064\\u2065"

    if-lez v4, :cond_a

    iget-object v4, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->tag:Ljava/lang/String;

    if-eqz v4, :cond_a

    .line 831
    sget-object v4, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ReceiveState;->RECEIVING_FILE_CONTENT:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ReceiveState;

    iput-object v4, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->currentState:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ReceiveState;

    .line 832
    new-instance v4, Ljava/io/ByteArrayOutputStream;

    invoke-direct {v4}, Ljava/io/ByteArrayOutputStream;-><init>()V

    iput-object v4, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->byteArrayOutputStream:Ljava/io/ByteArrayOutputStream;

    .line 833
    iput-wide v5, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->totalReceived:J

    .line 834
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v4

    iput-wide v4, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->startTime:J

    .line 837
    sget-object v4, Lkotlin/text/Charsets;->UTF_8:Ljava/nio/charset/Charset;

    invoke-virtual {v11, v4}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B

    move-result-object v4

    invoke-static {v4, v10}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    array-length v4, v4

    add-int v0, v3, v4

    goto/16 :goto_0

    .line 840
    :cond_a
    iget-object v4, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;

    invoke-static {v4}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;->access$getTAG$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;)Ljava/lang/String;

    move-result-object v4

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "\u65e0\u6548\u7684\u5143\u6570\u636e\uff0c\u8df3\u8fc7: "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    filled-new-array {v5}, [Ljava/lang/Object;

    move-result-object v5

    invoke-static {v4, v5}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 841
    sget-object v4, Lkotlin/text/Charsets;->UTF_8:Ljava/nio/charset/Charset;

    invoke-virtual {v11, v4}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B

    move-result-object v4

    invoke-static {v4, v10}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    array-length v4, v4

    add-int v0, v3, v4

    .line 842
    invoke-virtual/range {p0 .. p0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->resetStreamReceiveState()V

    goto/16 :goto_0

    .line 846
    :cond_b
    iget-object v4, v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;

    invoke-static {v4}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;->access$getTAG$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;)Ljava/lang/String;

    move-result-object v4

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "\u5143\u6570\u636e\u683c\u5f0f\u9519\u8bef\uff0c\u8df3\u8fc7: "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    filled-new-array {v5}, [Ljava/lang/Object;

    move-result-object v5

    invoke-static {v4, v5}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 847
    add-int/lit8 v0, v3, 0x1

    .line 848
    invoke-virtual/range {p0 .. p0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->resetStreamReceiveState()V

    .end local v7    # "metadataLength":I
    .end local v8    # "metadata":Ljava/lang/String;
    .end local v9    # "parts":Ljava/util/List;
    goto/16 :goto_0

    .line 852
    :cond_c
    goto :goto_8

    .line 892
    .end local v3    # "endMarkerIndex":I
    :goto_7
    goto/16 :goto_0

    .line 899
    :cond_d
    :goto_8
    if-lez v0, :cond_f

    .line 900
    invoke-virtual/range {p1 .. p1}, Ljava/io/ByteArrayOutputStream;->reset()V

    .line 901
    array-length v3, v2

    if-ge v0, v3, :cond_e

    .line 902
    array-length v3, v2

    sub-int/2addr v3, v0

    move-object/from16 v4, p1

    invoke-virtual {v4, v2, v0, v3}, Ljava/io/ByteArrayOutputStream;->write([BII)V

    goto :goto_9

    .line 901
    :cond_e
    move-object/from16 v4, p1

    goto :goto_9

    .line 899
    :cond_f
    move-object/from16 v4, p1

    .line 905
    :goto_9
    return-void

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method private final readFully(Ljava/io/InputStream;[BII)I
    .locals 6
    .param p1, "inputStream"    # Ljava/io/InputStream;
    .param p2, "buffer"    # [B
    .param p3, "offset"    # I
    .param p4, "length"    # I

    .line 1166
    if-ltz p3, :cond_6

    if-ltz p4, :cond_6

    add-int v0, p3, p4

    array-length v1, p2

    if-gt v0, v1, :cond_6

    .line 1169
    const/4 v0, 0x0

    .line 1170
    .local v0, "totalRead":I
    move v1, p4

    .line 1172
    .local v1, "remaining":I
    :goto_0
    if-lez v1, :cond_5

    .line 1173
    if-eqz p1, :cond_0

    add-int v2, p3, v0

    invoke-virtual {p1, p2, v2, v1}, Ljava/io/InputStream;->read([BII)I

    move-result v2

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    goto :goto_1

    :cond_0
    const/4 v2, 0x0

    .line 1174
    .local v2, "read":Ljava/lang/Integer;
    :goto_1
    nop

    .line 1175
    if-nez v2, :cond_1

    goto :goto_2

    :cond_1
    invoke-virtual {v2}, Ljava/lang/Integer;->intValue()I

    move-result v3

    const/4 v4, -0x1

    if-ne v3, v4, :cond_3

    .line 1177
    if-nez v0, :cond_2

    return v4

    .line 1178
    :cond_2
    new-instance v3, Ljava/io/IOException;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "Stream ended unexpectedly. Expected "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, p4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, " bytes but got "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-direct {v3, v4}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v3

    .line 1180
    :cond_3
    :goto_2
    if-eqz v2, :cond_4

    .line 1185
    invoke-virtual {v2}, Ljava/lang/Integer;->intValue()I

    move-result v3

    add-int/2addr v0, v3

    .line 1186
    invoke-virtual {v2}, Ljava/lang/Integer;->intValue()I

    move-result v3

    sub-int/2addr v1, v3

    .end local v2    # "read":Ljava/lang/Integer;
    goto :goto_0

    .line 1182
    .restart local v2    # "read":Ljava/lang/Integer;
    :cond_4
    new-instance v3, Ljava/io/IOException;

    const-string v4, "InputStream is null"

    invoke-direct {v3, v4}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v3

    .line 1191
    .end local v2    # "read":Ljava/lang/Integer;
    :cond_5
    return v0

    .line 1167
    .end local v0    # "totalRead":I
    .end local v1    # "remaining":I
    :cond_6
    new-instance v0, Ljava/io/IOException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Invalid read parameters: offset="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ", length="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ", bufferSize="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    array-length v2, p2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v0
.end method


# virtual methods
.method public final getBytes()I
    .locals 1

    .line 708
    iget v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->bytes:I

    return v0
.end method

.method public final getLastProgress()I
    .locals 1

    .line 709
    iget v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->lastProgress:I

    return v0
.end method

.method public final resetFileReceiveState()V
    .locals 3

    .line 1048
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;

    invoke-static {v0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;->access$getTAG$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "resetFileReceiveState:"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 1049
    sget-object v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ReceiveState;->WAITING_FOR_METADATA:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ReceiveState;

    iput-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->currentState:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ReceiveState;

    .line 1050
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->currentFileName:Ljava/lang/String;

    .line 1051
    const-wide/16 v1, 0x0

    iput-wide v1, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->currentFileSize:J

    .line 1052
    iput-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->currentFileOutputStream:Ljava/io/BufferedOutputStream;

    .line 1053
    iput-wide v1, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->totalReceived:J

    .line 1054
    iput-wide v1, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->lastReceiveProgressTime:J

    .line 1055
    const/4 v0, 0x0

    iput v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->lastReceiveProgressValue:F

    .line 1056
    return-void
.end method

.method public final resetStreamReceiveState()V
    .locals 3

    .line 909
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;

    invoke-static {v0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;->access$getTAG$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "resetStreamReceiveState: "

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 910
    sget-object v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ReceiveState;->WAITING_FOR_METADATA:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ReceiveState;

    iput-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->currentState:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ReceiveState;

    .line 911
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->tag:Ljava/lang/String;

    .line 912
    iput-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->clientId:Ljava/lang/String;

    .line 913
    const-wide/16 v1, 0x0

    iput-wide v1, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->dataSize:J

    .line 914
    iput-wide v1, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->totalReceived:J

    .line 915
    iput-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->saveFile:Ljava/io/File;

    .line 916
    iget-object v1, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->byteArrayOutputStream:Ljava/io/ByteArrayOutputStream;

    if-eqz v1, :cond_0

    invoke-virtual {v1}, Ljava/io/ByteArrayOutputStream;->close()V

    .line 917
    :cond_0
    iput-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->byteArrayOutputStream:Ljava/io/ByteArrayOutputStream;

    .line 918
    return-void
.end method

.method public run()V
    .locals 3

    .line 738
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;

    invoke-static {v0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;->access$getTAG$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;)Ljava/lang/String;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "ConnectedThread --> "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->mType:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 739
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->mType:Ljava/lang/String;

    .line 740
    sget-object v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->Companion:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$Companion;

    invoke-virtual {v1}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$Companion;->getAUDIO_TYPE()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->handleAudioStreamContinuously()V

    goto :goto_0

    .line 741
    :cond_0
    sget-object v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->Companion:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$Companion;

    invoke-virtual {v1}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$Companion;->getFILE_TYPE()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->handleMultiFileTransferContinuously()V

    goto :goto_0

    .line 742
    :cond_1
    sget-object v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->Companion:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$Companion;

    invoke-virtual {v1}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$Companion;->getSTREAM_TYPE()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_2

    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->handleStreamContinuously()V

    goto :goto_0

    .line 743
    :cond_2
    sget-object v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->Companion:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$Companion;

    invoke-virtual {v1}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$Companion;->getMESSAGE_TYPE()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_3

    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->handleMessageTransferContinuously()V

    .line 745
    :cond_3
    :goto_0
    return-void
.end method

.method public final setBytes(I)V
    .locals 0
    .param p1, "<set-?>"    # I

    .line 708
    iput p1, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->bytes:I

    return-void
.end method

.method public final setLastProgress(I)V
    .locals 0
    .param p1, "<set-?>"    # I

    .line 709
    iput p1, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->lastProgress:I

    return-void
.end method

.method public final shutdown()V
    .locals 1

    .line 1400
    iget-boolean v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->isSocketDateRunning:Z

    if-eqz v0, :cond_1

    .line 1401
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->isSocketDateRunning:Z

    .line 1402
    nop

    .line 1403
    :try_start_0
    invoke-virtual {p0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->interrupt()V

    .line 1404
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->socket:Landroid/bluetooth/BluetoothSocket;

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Landroid/bluetooth/BluetoothSocket;->close()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    .line 1409
    :catchall_0
    move-exception v0

    goto :goto_1

    .line 1405
    :catch_0
    move-exception v0

    .line 1406
    .local v0, "e":Ljava/lang/Exception;
    :try_start_1
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 1409
    .end local v0    # "e":Ljava/lang/Exception;
    :cond_0
    :goto_0
    invoke-virtual {p0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->resetStreamReceiveState()V

    .line 1410
    invoke-virtual {p0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->resetFileReceiveState()V

    .line 1411
    goto :goto_2

    .line 1409
    :goto_1
    invoke-virtual {p0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->resetStreamReceiveState()V

    .line 1410
    invoke-virtual {p0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->resetFileReceiveState()V

    throw v0

    .line 1413
    :cond_1
    :goto_2
    return-void
.end method

.method public final stopFileSend()V
    .locals 3

    .line 1392
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;

    invoke-static {v0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;->access$getTAG$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;)Ljava/lang/String;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "stopFileSend: mFileSendListener = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->mFileSendListener:Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileSendListener;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 1393
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->fileSendJob:Lkotlinx/coroutines/Job;

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    const/4 v2, 0x1

    invoke-static {v0, v1, v2, v1}, Lkotlinx/coroutines/Job$DefaultImpls;->cancel$default(Lkotlinx/coroutines/Job;Ljava/util/concurrent/CancellationException;ILjava/lang/Object;)V

    .line 1394
    :cond_0
    iput-object v1, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->fileSendJob:Lkotlinx/coroutines/Job;

    .line 1395
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->mFileSendListener:Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileSendListener;

    if-eqz v0, :cond_1

    invoke-interface {v0}, Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileSendListener;->onCancel()V

    .line 1396
    :cond_1
    iput-object v1, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->mFileSendListener:Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileSendListener;

    .line 1397
    return-void
.end method

.method public final write(Ljava/lang/String;Ljava/io/File;Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileSendListener;)V
    .locals 20
    .param p1, "dir"    # Ljava/lang/String;
    .param p2, "file"    # Ljava/io/File;
    .param p3, "listener"    # Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileSendListener;

    move-object/from16 v10, p0

    move-object/from16 v11, p3

    const-string v0, "file"

    move-object/from16 v12, p2

    invoke-static {v12, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "listener"

    invoke-static {v11, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 1285
    iget-object v0, v10, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;

    invoke-static {v0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;->access$getTAG$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;)Ljava/lang/String;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "write 0 "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, v10, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->socket:Landroid/bluetooth/BluetoothSocket;

    const/4 v3, 0x0

    if-eqz v2, :cond_0

    invoke-virtual {v2}, Landroid/bluetooth/BluetoothSocket;->isConnected()Z

    move-result v2

    invoke-static {v2}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v2

    goto :goto_0

    :cond_0
    move-object v2, v3

    :goto_0
    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 1287
    new-instance v5, Lkotlin/jvm/internal/Ref$LongRef;

    invoke-direct {v5}, Lkotlin/jvm/internal/Ref$LongRef;-><init>()V

    .line 1288
    .local v5, "lastProgressTime":Lkotlin/jvm/internal/Ref$LongRef;
    const/16 v13, 0xc8

    .line 1289
    .local v13, "PROGRESS_INTERVAL":I
    new-instance v7, Lkotlin/jvm/internal/Ref$FloatRef;

    invoke-direct {v7}, Lkotlin/jvm/internal/Ref$FloatRef;-><init>()V

    .line 1291
    .local v7, "lastProgressValue":Lkotlin/jvm/internal/Ref$FloatRef;
    iget-object v0, v10, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->fileSendJob:Lkotlinx/coroutines/Job;

    if-eqz v0, :cond_1

    const/4 v1, 0x1

    invoke-static {v0, v3, v1, v3}, Lkotlinx/coroutines/Job$DefaultImpls;->cancel$default(Lkotlinx/coroutines/Job;Ljava/util/concurrent/CancellationException;ILjava/lang/Object;)V

    .line 1292
    :cond_1
    iput-object v11, v10, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->mFileSendListener:Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileSendListener;

    .line 1293
    invoke-static {}, Lkotlinx/coroutines/Dispatchers;->getIO()Lkotlinx/coroutines/CoroutineDispatcher;

    move-result-object v0

    check-cast v0, Lkotlin/coroutines/CoroutineContext;

    invoke-static {v0}, Lkotlinx/coroutines/CoroutineScopeKt;->CoroutineScope(Lkotlin/coroutines/CoroutineContext;)Lkotlinx/coroutines/CoroutineScope;

    move-result-object v14

    new-instance v15, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;

    iget-object v2, v10, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;

    const/4 v9, 0x0

    move-object v0, v15

    move-object/from16 v1, p0

    move-object/from16 v3, p2

    move-object/from16 v4, p1

    move v6, v13

    move-object/from16 v8, p3

    invoke-direct/range {v0 .. v9}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$2;-><init>(Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;Ljava/io/File;Ljava/lang/String;Lkotlin/jvm/internal/Ref$LongRef;ILkotlin/jvm/internal/Ref$FloatRef;Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileSendListener;Lkotlin/coroutines/Continuation;)V

    move-object/from16 v17, v15

    check-cast v17, Lkotlin/jvm/functions/Function2;

    const/16 v18, 0x3

    const/16 v19, 0x0

    const/4 v15, 0x0

    const/16 v16, 0x0

    invoke-static/range {v14 .. v19}, Lkotlinx/coroutines/BuildersKt;->launch$default(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/CoroutineContext;Lkotlinx/coroutines/CoroutineStart;Lkotlin/jvm/functions/Function2;ILjava/lang/Object;)Lkotlinx/coroutines/Job;

    move-result-object v0

    iput-object v0, v10, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->fileSendJob:Lkotlinx/coroutines/Job;

    .line 1389
    return-void
.end method

.method public final write(Ljava/lang/String;[BLjava/lang/String;)V
    .locals 9
    .param p1, "tag"    # Ljava/lang/String;
    .param p2, "bytes"    # [B
    .param p3, "clientId"    # Ljava/lang/String;

    const-string v0, "tag"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "bytes"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "clientId"

    invoke-static {p3, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 1245
    invoke-static {}, Lkotlinx/coroutines/Dispatchers;->getIO()Lkotlinx/coroutines/CoroutineDispatcher;

    move-result-object v0

    check-cast v0, Lkotlin/coroutines/CoroutineContext;

    invoke-static {v0}, Lkotlinx/coroutines/CoroutineScopeKt;->CoroutineScope(Lkotlin/coroutines/CoroutineContext;)Lkotlinx/coroutines/CoroutineScope;

    move-result-object v1

    new-instance v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$1;

    iget-object v4, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;

    const/4 v8, 0x0

    move-object v2, v0

    move-object v3, p0

    move-object v5, p1

    move-object v6, p3

    move-object v7, p2

    invoke-direct/range {v2 .. v8}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread$write$1;-><init>(Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;Ljava/lang/String;Ljava/lang/String;[BLkotlin/coroutines/Continuation;)V

    move-object v4, v0

    check-cast v4, Lkotlin/jvm/functions/Function2;

    const/4 v5, 0x3

    const/4 v6, 0x0

    const/4 v2, 0x0

    const/4 v3, 0x0

    invoke-static/range {v1 .. v6}, Lkotlinx/coroutines/BuildersKt;->launch$default(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/CoroutineContext;Lkotlinx/coroutines/CoroutineStart;Lkotlin/jvm/functions/Function2;ILjava/lang/Object;)Lkotlinx/coroutines/Job;

    .line 1282
    return-void
.end method

.method public final write([B)V
    .locals 3
    .param p1, "bytes"    # [B

    const-string v0, "bytes"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 1230
    nop

    .line 1231
    :try_start_0
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->socket:Landroid/bluetooth/BluetoothSocket;

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Landroid/bluetooth/BluetoothSocket;->isConnected()Z

    move-result v0

    const/4 v2, 0x1

    if-ne v0, v2, :cond_0

    move v1, v2

    :cond_0
    if-nez v1, :cond_1

    .line 1232
    return-void

    .line 1234
    :cond_1
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->outputStream:Ljava/io/OutputStream;

    if-eqz v0, :cond_2

    invoke-virtual {v0, p1}, Ljava/io/OutputStream;->write([B)V

    .line 1235
    :cond_2
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->outputStream:Ljava/io/OutputStream;

    if-eqz v0, :cond_3

    invoke-virtual {v0}, Ljava/io/OutputStream;->flush()V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 1236
    :catch_0
    move-exception v0

    .line 1237
    .local v0, "e":Ljava/io/IOException;
    iget-object v1, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$ConnectedThread;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;

    invoke-static {v1}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;->access$getTAG$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;)Ljava/lang/String;

    move-result-object v1

    const-string v2, "\u53d1\u9001\u6570\u636e\u5931\u8d25"

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 1239
    .end local v0    # "e":Ljava/io/IOException;
    :cond_3
    :goto_0
    return-void
.end method
