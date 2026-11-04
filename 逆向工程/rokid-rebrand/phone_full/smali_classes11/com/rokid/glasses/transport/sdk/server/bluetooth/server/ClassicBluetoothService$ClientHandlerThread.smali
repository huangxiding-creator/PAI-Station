.class final Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;
.super Ljava/lang/Thread;
.source "ClassicBluetoothService.kt"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x12
    name = "ClientHandlerThread"
.end annotation

.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread$WhenMappings;
    }
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000t\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u000e\n\u0002\u0008\u0002\n\u0002\u0010\t\n\u0000\n\u0002\u0010\u0008\n\u0002\u0008\u0002\n\u0002\u0010\u0012\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0008\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u000b\n\u0002\u0008\u0002\n\u0002\u0010\u0007\n\u0002\u0008\u0004\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0004\n\u0002\u0010\u0002\n\u0002\u0008\r\u0008\u0082\u0004\u0018\u00002\u00020\u0001B\u0015\u0012\u0006\u0010\u0002\u001a\u00020\u0003\u0012\u0006\u0010\u0004\u001a\u00020\u0005\u00a2\u0006\u0002\u0010\u0006J\u0008\u0010/\u001a\u000200H\u0007J\u0008\u00101\u001a\u000200H\u0002J\u0008\u00102\u001a\u000200H\u0002J\u0006\u00103\u001a\u000200J\u0010\u00104\u001a\u0002002\u0006\u00105\u001a\u00020\u000fH\u0002J*\u00106\u001a\u00020\n2\u0008\u0010\u001d\u001a\u0004\u0018\u00010\u001e2\u0006\u0010\u000c\u001a\u00020\r2\u0006\u00107\u001a\u00020\n2\u0006\u00108\u001a\u00020\nH\u0002J\u0006\u00109\u001a\u000200J\u0006\u0010:\u001a\u000200J\u0008\u0010;\u001a\u000200H\u0016J\u0006\u0010<\u001a\u000200R\u000e\u0010\u0007\u001a\u00020\u0008X\u0082D\u00a2\u0006\u0002\n\u0000R\u000e\u0010\t\u001a\u00020\nX\u0082D\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u000b\u001a\u00020\nX\u0082D\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u000c\u001a\u00020\rX\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0010\u0010\u000e\u001a\u0004\u0018\u00010\u000fX\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u001a\u0010\u0010\u001a\u00020\nX\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0011\u0010\u0012\"\u0004\u0008\u0013\u0010\u0014R\u0010\u0010\u0015\u001a\u0004\u0018\u00010\u0005X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0010\u0010\u0016\u001a\u0004\u0018\u00010\u0005X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0010\u0010\u0017\u001a\u0004\u0018\u00010\u0018X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0019\u001a\u00020\u0008X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u001a\u001a\u00020\u001bX\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u001c\u001a\u00020\u0008X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0010\u0010\u001d\u001a\u0004\u0018\u00010\u001eX\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u001f\u001a\u00020 X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010!\u001a\u00020\u0008X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\"\u001a\u00020#X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0011\u0010$\u001a\u00020\r\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008%\u0010&R\u0012\u0010\'\u001a\u00060(j\u0002`)X\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u0010\u0010*\u001a\u0004\u0018\u00010+X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0002\u001a\u00020\u0003X\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u000e\u0010,\u001a\u00020\u0008X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0010\u0010-\u001a\u0004\u0018\u00010\u0005X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010.\u001a\u00020\u0008X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0004\u001a\u00020\u0005X\u0082\u0004\u00a2\u0006\u0002\n\u0000\u00a8\u0006="
    }
    d2 = {
        "Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;",
        "Ljava/lang/Thread;",
        "socket",
        "Landroid/bluetooth/BluetoothSocket;",
        "type",
        "",
        "(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;Landroid/bluetooth/BluetoothSocket;Ljava/lang/String;)V",
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
        "inputStream",
        "Ljava/io/InputStream;",
        "isSocketDateRunning",
        "",
        "lastReceiveProgressTime",
        "lastReceiveProgressValue",
        "",
        "lengthBuf",
        "getLengthBuf",
        "()[B",
        "messageBuffer",
        "Ljava/lang/StringBuilder;",
        "Lkotlin/text/StringBuilder;",
        "saveFile",
        "Ljava/io/File;",
        "startTime",
        "tag",
        "totalReceived",
        "handleAudioStreamContinuously",
        "",
        "handleMessageTransferContinuously",
        "handleMultiFileTransferContinuously",
        "handleStreamContinuously",
        "processStreamPackets",
        "streamBuffer",
        "readFully",
        "offset",
        "length",
        "resetFileReceiveState",
        "resetStreamReceiveState",
        "run",
        "shutdown",
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

.field private final inputStream:Ljava/io/InputStream;

.field private isSocketDateRunning:Z

.field private lastReceiveProgressTime:J

.field private lastReceiveProgressValue:F

.field private final lengthBuf:[B

.field private final messageBuffer:Ljava/lang/StringBuilder;

.field private saveFile:Ljava/io/File;

.field private final socket:Landroid/bluetooth/BluetoothSocket;

.field private startTime:J

.field private tag:Ljava/lang/String;

.field final synthetic this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

.field private totalReceived:J

.field private final type:Ljava/lang/String;


# direct methods
.method public static synthetic $r8$lambda$L2IpthcicrwV5rzLFfcy-qvv3n4(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;Ljava/lang/String;)V
    .locals 0

    invoke-static {p0, p1, p2}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->handleMessageTransferContinuously$lambda$3(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;Ljava/lang/String;)V

    return-void
.end method

.method public static synthetic $r8$lambda$Le-rRpdp_9AiAWLTHLjQ5JKfTfw(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;[B)V
    .locals 0

    invoke-static {p0, p1, p2}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->handleAudioStreamContinuously$lambda$2(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;[B)V

    return-void
.end method

.method public static synthetic $r8$lambda$qdlXeZe-wuU0I7cs4b5qFRJuw8o(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;)V
    .locals 0

    invoke-static {p0, p1}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->handleMessageTransferContinuously$lambda$4(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;)V

    return-void
.end method

.method public constructor <init>(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;Landroid/bluetooth/BluetoothSocket;Ljava/lang/String;)V
    .locals 2
    .param p1, "this$0"    # Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;
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

    const-string v0, "socket"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "type"

    invoke-static {p3, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 1060
    iput-object p1, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    .line 1063
    invoke-direct {p0}, Ljava/lang/Thread;-><init>()V

    .line 1061
    iput-object p2, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->socket:Landroid/bluetooth/BluetoothSocket;

    .line 1062
    iput-object p3, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->type:Ljava/lang/String;

    .line 1064
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->socket:Landroid/bluetooth/BluetoothSocket;

    invoke-virtual {v0}, Landroid/bluetooth/BluetoothSocket;->getInputStream()Ljava/io/InputStream;

    move-result-object v0

    iput-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->inputStream:Ljava/io/InputStream;

    .line 1065
    const/16 v0, 0x1000

    new-array v0, v0, [B

    iput-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->buffer:[B

    .line 1066
    const/16 v0, 0x2000

    iput v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->baseBufferSize:I

    .line 1067
    const/16 v0, 0x4000

    iput v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->baseStreamBufferSize:I

    .line 1068
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iput-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->messageBuffer:Ljava/lang/StringBuilder;

    .line 1069
    const/4 v0, 0x2

    new-array v0, v0, [B

    iput-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->lengthBuf:[B

    .line 1070
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->isSocketDateRunning:Z

    .line 1073
    sget-object v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ReceiveState;->WAITING_FOR_METADATA:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ReceiveState;

    iput-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->currentState:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ReceiveState;

    .line 1084
    const-wide/16 v0, 0xc8

    iput-wide v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->RECEIVE_PROGRESS_INTERVAL:J

    .line 1060
    return-void
.end method

.method private static final handleAudioStreamContinuously$lambda$2(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;[B)V
    .locals 3
    .param p0, "this$0"    # Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;
    .param p1, "this$1"    # Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;
    .param p2, "$audioData"    # [B

    const-string v0, "this$0"

    invoke-static {p0, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "this$1"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "$audioData"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 1420
    invoke-static {p0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->access$getServerListener$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;)Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ServerListener;

    move-result-object v0

    if-eqz v0, :cond_0

    .line 1421
    iget-object v1, p1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->socket:Landroid/bluetooth/BluetoothSocket;

    invoke-virtual {v1}, Landroid/bluetooth/BluetoothSocket;->getRemoteDevice()Landroid/bluetooth/BluetoothDevice;

    move-result-object v1

    const-string v2, "socket.remoteDevice"

    invoke-static {v1, v2}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 1422
    nop

    .line 1420
    invoke-interface {v0, v1, p2}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ServerListener;->onAudioDataReceived(Landroid/bluetooth/BluetoothDevice;[B)V

    .line 1424
    :cond_0
    return-void
.end method

.method private final handleMessageTransferContinuously()V
    .locals 14

    .line 1439
    const-string v0, "ClassicBluetoothService "

    const/4 v1, 0x2

    new-array v2, v1, [B

    .line 1440
    .local v2, "lengthBuf":[B
    const/4 v3, 0x4

    new-array v4, v3, [B

    .line 1443
    .local v4, "lengthBufV2":[B
    :cond_0
    :goto_0
    iget-boolean v5, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->isSocketDateRunning:Z

    if-eqz v5, :cond_5

    .line 1444
    nop

    .line 1445
    const/4 v5, 0x0

    :try_start_0
    iget-object v6, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->socket:Landroid/bluetooth/BluetoothSocket;

    invoke-virtual {v6}, Landroid/bluetooth/BluetoothSocket;->isConnected()Z

    move-result v6

    const/4 v7, 0x1

    if-eq v6, v7, :cond_1

    .line 1446
    return-void

    .line 1448
    :cond_1
    iget-object v6, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->inputStream:Ljava/io/InputStream;

    invoke-direct {p0, v6, v2, v5, v1}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->readFully(Ljava/io/InputStream;[BII)I

    move-result v6

    .line 1449
    .local v6, "lenRead":I
    if-ne v6, v1, :cond_5

    .line 1451
    invoke-static {v2}, Ljava/nio/ByteBuffer;->wrap([B)Ljava/nio/ByteBuffer;

    move-result-object v7

    invoke-virtual {v7}, Ljava/nio/ByteBuffer;->getShort()S

    move-result v7

    .line 1452
    .local v7, "len":I
    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, "handleMessage len = "

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v7}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    filled-new-array {v8}, [Ljava/lang/Object;

    move-result-object v8

    invoke-static {v0, v8}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 1454
    if-gez v7, :cond_3

    .line 1455
    nop

    .line 1456
    const/4 v8, -0x2

    if-ne v7, v8, :cond_2

    .line 1457
    const-string v8, "Message Protocol Version = VERSION_V2"

    filled-new-array {v8}, [Ljava/lang/Object;

    move-result-object v8

    invoke-static {v0, v8}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 1458
    iget-object v8, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->inputStream:Ljava/io/InputStream;

    invoke-direct {p0, v8, v4, v5, v3}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->readFully(Ljava/io/InputStream;[BII)I

    move-result v8

    .line 1459
    .local v8, "lenRead2":I
    invoke-static {v4}, Ljava/nio/ByteBuffer;->wrap([B)Ljava/nio/ByteBuffer;

    move-result-object v9

    invoke-virtual {v9}, Ljava/nio/ByteBuffer;->getInt()I

    move-result v9

    move v7, v9

    .line 1460
    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    const-string v10, "handleMessage2 len = "

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, v7}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    filled-new-array {v9}, [Ljava/lang/Object;

    move-result-object v9

    invoke-static {v0, v9}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .end local v8    # "lenRead2":I
    goto :goto_1

    .line 1463
    :cond_2
    const-string v8, "No protocol version matched, data parsing error."

    filled-new-array {v8}, [Ljava/lang/Object;

    move-result-object v8

    invoke-static {v0, v8}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 1468
    :cond_3
    :goto_1
    new-array v8, v7, [B

    .line 1469
    .local v8, "dataBuf":[B
    iget-object v9, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->inputStream:Ljava/io/InputStream;

    invoke-direct {p0, v9, v8, v5, v7}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->readFully(Ljava/io/InputStream;[BII)I

    move-result v9

    .line 1470
    .local v9, "totalRead":I
    if-ne v9, v7, :cond_0

    new-instance v10, Ljava/lang/String;

    .line 1471
    sget-object v11, Lkotlin/text/Charsets;->UTF_8:Ljava/nio/charset/Charset;

    invoke-direct {v10, v8, v11}, Ljava/lang/String;-><init>([BLjava/nio/charset/Charset;)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_1

    .line 1472
    .local v10, "msg":Ljava/lang/String;
    nop

    .line 1473
    :try_start_1
    iget-object v11, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    invoke-static {v11}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->access$getMainHandler$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;)Landroid/os/Handler;

    move-result-object v11

    iget-object v12, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    new-instance v13, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread$$ExternalSyntheticLambda1;

    invoke-direct {v13, v12, p0, v10}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread$$ExternalSyntheticLambda1;-><init>(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;Ljava/lang/String;)V

    invoke-virtual {v11, v13}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_1

    goto/16 :goto_0

    .line 1480
    :catch_0
    move-exception v11

    .line 1481
    .local v11, "e":Ljava/lang/Exception;
    :try_start_2
    invoke-virtual {v11}, Ljava/lang/Exception;->printStackTrace()V

    .line 1482
    const-string v12, "\u4e1a\u52a1\u65b9\u5904\u7406\u6d88\u606f\u903b\u8f91\u51fa\u73b0\u5f02\u5e38"

    filled-new-array {v12}, [Ljava/lang/Object;

    move-result-object v12

    invoke-static {v0, v12}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->e(Ljava/lang/String;[Ljava/lang/Object;)V
    :try_end_2
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_1

    .end local v6    # "lenRead":I
    .end local v7    # "len":I
    .end local v8    # "dataBuf":[B
    .end local v9    # "totalRead":I
    .end local v10    # "msg":Ljava/lang/String;
    .end local v11    # "e":Ljava/lang/Exception;
    goto/16 :goto_0

    .line 1487
    :catch_1
    move-exception v1

    .line 1488
    .local v1, "e":Ljava/io/IOException;
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "onClientDisconnected --- "

    invoke-virtual {v3, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget-object v6, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->socket:Landroid/bluetooth/BluetoothSocket;

    invoke-virtual {v6}, Landroid/bluetooth/BluetoothSocket;->getRemoteDevice()Landroid/bluetooth/BluetoothDevice;

    move-result-object v6

    invoke-virtual {v6}, Landroid/bluetooth/BluetoothDevice;->getName()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v3, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    filled-new-array {v3}, [Ljava/lang/Object;

    move-result-object v3

    invoke-static {v0, v3}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 1489
    iget-object v3, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    invoke-static {v3}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->access$getMainHandler$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;)Landroid/os/Handler;

    move-result-object v3

    iget-object v6, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    new-instance v7, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread$$ExternalSyntheticLambda2;

    invoke-direct {v7, v6, p0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread$$ExternalSyntheticLambda2;-><init>(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;)V

    invoke-virtual {v3, v7}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    .line 1493
    iput-boolean v5, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->isSocketDateRunning:Z

    .line 1494
    iget-object v3, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    invoke-static {v3}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->access$getConnectedMessageSockets$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;)Ljava/util/concurrent/CopyOnWriteArrayList;

    move-result-object v3

    iget-object v5, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->socket:Landroid/bluetooth/BluetoothSocket;

    invoke-virtual {v3, v5}, Ljava/util/concurrent/CopyOnWriteArrayList;->contains(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_4

    .line 1495
    iget-object v3, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    invoke-static {v3}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->access$getConnectedMessageSockets$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;)Ljava/util/concurrent/CopyOnWriteArrayList;

    move-result-object v3

    iget-object v5, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->socket:Landroid/bluetooth/BluetoothSocket;

    invoke-virtual {v3, v5}, Ljava/util/concurrent/CopyOnWriteArrayList;->remove(Ljava/lang/Object;)Z

    .line 1497
    :cond_4
    iget-object v3, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->socket:Landroid/bluetooth/BluetoothSocket;

    invoke-virtual {v3}, Landroid/bluetooth/BluetoothSocket;->close()V

    .line 1498
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "\u6d88\u606f\u6d41\u65ad\u5f00\uff1a"

    invoke-virtual {v3, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v1}, Ljava/io/IOException;->getMessage()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v3, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    filled-new-array {v3}, [Ljava/lang/Object;

    move-result-object v3

    invoke-static {v0, v3}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 1499
    nop

    .line 1502
    .end local v1    # "e":Ljava/io/IOException;
    :cond_5
    return-void
.end method

.method private static final handleMessageTransferContinuously$lambda$3(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;Ljava/lang/String;)V
    .locals 3
    .param p0, "this$0"    # Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;
    .param p1, "this$1"    # Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;
    .param p2, "$msg"    # Ljava/lang/String;

    const-string v0, "this$0"

    invoke-static {p0, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "this$1"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "$msg"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 1475
    invoke-static {p0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->access$getServerListener$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;)Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ServerListener;

    move-result-object v0

    if-eqz v0, :cond_0

    .line 1476
    iget-object v1, p1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->socket:Landroid/bluetooth/BluetoothSocket;

    invoke-virtual {v1}, Landroid/bluetooth/BluetoothSocket;->getRemoteDevice()Landroid/bluetooth/BluetoothDevice;

    move-result-object v1

    const-string v2, "socket.remoteDevice"

    invoke-static {v1, v2}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 1477
    nop

    .line 1475
    invoke-interface {v0, v1, p2}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ServerListener;->onDataReceived(Landroid/bluetooth/BluetoothDevice;Ljava/lang/String;)V

    .line 1479
    :cond_0
    return-void
.end method

.method private static final handleMessageTransferContinuously$lambda$4(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;)V
    .locals 3
    .param p0, "this$0"    # Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;
    .param p1, "this$1"    # Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;

    const-string v0, "this$0"

    invoke-static {p0, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "this$1"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 1490
    invoke-static {p0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->access$getServerListener$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;)Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ServerListener;

    move-result-object v0

    if-eqz v0, :cond_0

    iget-object v1, p1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->socket:Landroid/bluetooth/BluetoothSocket;

    invoke-virtual {v1}, Landroid/bluetooth/BluetoothSocket;->getRemoteDevice()Landroid/bluetooth/BluetoothDevice;

    move-result-object v1

    const-string v2, "socket.remoteDevice"

    invoke-static {v1, v2}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-interface {v0, v1}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ServerListener;->onClientDisconnected(Landroid/bluetooth/BluetoothDevice;)V

    .line 1491
    :cond_0
    return-void
.end method

.method private final handleMultiFileTransferContinuously()V
    .locals 15

    .line 1272
    const-string v0, "ClassicBluetoothService "

    .line 1273
    const/4 v1, 0x0

    :try_start_0
    iget-object v2, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->inputStream:Ljava/io/InputStream;

    if-nez v2, :cond_0

    move-object v2, p0

    check-cast v2, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;

    .local v2, "$this$handleMultiFileTransferContinuously_u24lambda_u241":Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;
    const/4 v3, 0x0

    .line 1274
    .local v3, "$i$a$-run-ClassicBluetoothService$ClientHandlerThread$handleMultiFileTransferContinuously$input$1":I
    const-string v4, "\u8f93\u5165\u6d41\u4e3a\u7a7a\uff0c\u65e0\u6cd5\u63a5\u6536\u6587\u4ef6"

    filled-new-array {v4}, [Ljava/lang/Object;

    move-result-object v4

    invoke-static {v0, v4}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 1275
    return-void

    .end local v2    # "$this$handleMultiFileTransferContinuously_u24lambda_u241":Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;
    .end local v3    # "$i$a$-run-ClassicBluetoothService$ClientHandlerThread$handleMultiFileTransferContinuously$input$1":I
    :cond_0
    nop

    .line 1279
    .local v2, "input":Ljava/io/InputStream;
    :cond_1
    :goto_0
    iget-boolean v3, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->isSocketDateRunning:Z

    if-eqz v3, :cond_16

    .line 1281
    iget-object v3, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->socket:Landroid/bluetooth/BluetoothSocket;

    invoke-virtual {v3}, Landroid/bluetooth/BluetoothSocket;->isConnected()Z

    move-result v3

    const/4 v4, 0x1

    if-eq v3, v4, :cond_2

    .line 1282
    return-void

    .line 1284
    :cond_2
    iget-object v3, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->inputStream:Ljava/io/InputStream;

    iget-object v5, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->buffer:[B

    invoke-virtual {v3, v5}, Ljava/io/InputStream;->read([B)I

    move-result v3

    iput v3, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->bytes:I

    .line 1286
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "bytes:"

    invoke-virtual {v3, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget v5, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->bytes:I

    invoke-virtual {v3, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    filled-new-array {v3}, [Ljava/lang/Object;

    move-result-object v3

    invoke-static {v0, v3}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 1287
    iget v3, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->bytes:I

    const/4 v5, -0x1

    if-ne v3, v5, :cond_3

    .line 1289
    goto/16 :goto_8

    .line 1292
    :cond_3
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "currentState:"

    invoke-virtual {v3, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget-object v5, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->currentState:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ReceiveState;

    invoke-virtual {v3, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    filled-new-array {v3}, [Ljava/lang/Object;

    move-result-object v3

    invoke-static {v0, v3}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 1293
    iget-object v3, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->currentState:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ReceiveState;

    sget-object v5, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread$WhenMappings;->$EnumSwitchMapping$0:[I

    invoke-virtual {v3}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ReceiveState;->ordinal()I

    move-result v3

    aget v3, v5, v3
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    const-string v5, ""

    const/4 v6, 0x0

    const-wide/16 v7, 0x0

    packed-switch v3, :pswitch_data_0

    goto/16 :goto_7

    .line 1346
    :pswitch_0
    :try_start_1
    iget-object v3, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->currentFileOutputStream:Ljava/io/BufferedOutputStream;

    if-eqz v3, :cond_1

    iget-wide v3, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->currentFileSize:J

    cmp-long v3, v3, v7

    if-lez v3, :cond_1

    .line 1348
    iget-object v3, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->currentFileOutputStream:Ljava/io/BufferedOutputStream;

    if-eqz v3, :cond_4

    iget-object v4, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->buffer:[B

    iget v7, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->bytes:I

    invoke-virtual {v3, v4, v1, v7}, Ljava/io/BufferedOutputStream;->write([BII)V

    .line 1349
    :cond_4
    iget-wide v3, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->totalReceived:J

    iget v7, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->bytes:I

    int-to-long v7, v7

    add-long/2addr v3, v7

    iput-wide v3, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->totalReceived:J

    .line 1351
    iget-wide v3, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->totalReceived:J

    long-to-float v3, v3

    iget-wide v7, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->currentFileSize:J

    long-to-float v4, v7

    div-float/2addr v3, v4

    const/16 v4, 0x64

    int-to-float v4, v4

    mul-float/2addr v3, v4

    .line 1353
    .local v3, "progress":F
    mul-float/2addr v4, v3

    invoke-static {v4}, Lkotlin/math/MathKt;->roundToInt(F)I

    move-result v4

    int-to-float v4, v4

    const/high16 v7, 0x42c80000    # 100.0f

    div-float/2addr v4, v7

    .line 1354
    .local v4, "roundedProgress":F
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v8

    .line 1355
    .local v8, "currentTime":J
    iget-wide v10, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->lastReceiveProgressTime:J

    sub-long v10, v8, v10

    iget-wide v12, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->RECEIVE_PROGRESS_INTERVAL:J

    cmp-long v10, v10, v12

    if-gez v10, :cond_5

    .line 1356
    cmpl-float v7, v4, v7

    if-gez v7, :cond_5

    .line 1357
    iget v7, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->lastReceiveProgressValue:F

    sub-float v7, v4, v7

    const/high16 v10, 0x3f800000    # 1.0f

    cmpl-float v7, v7, v10

    if-ltz v7, :cond_9

    .line 1359
    :cond_5
    iget-object v7, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    invoke-static {v7}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->access$getMFileReceiveListener$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;)Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileReceiveListener;

    move-result-object v7

    if-eqz v7, :cond_8

    iget-object v10, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->saveFile:Ljava/io/File;

    if-eqz v10, :cond_6

    invoke-virtual {v10}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v10

    goto :goto_1

    :cond_6
    move-object v10, v6

    :goto_1
    if-nez v10, :cond_7

    move-object v10, v5

    :cond_7
    invoke-interface {v7, v10, v4}, Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileReceiveListener;->onProgressChanged(Ljava/lang/String;F)V

    .line 1360
    :cond_8
    iput-wide v8, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->lastReceiveProgressTime:J

    .line 1361
    iput v4, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->lastReceiveProgressValue:F

    .line 1366
    :cond_9
    iget-wide v10, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->totalReceived:J

    iget-wide v12, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->currentFileSize:J

    cmp-long v7, v10, v12

    if-ltz v7, :cond_1

    .line 1368
    iget-object v7, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->currentFileOutputStream:Ljava/io/BufferedOutputStream;

    if-eqz v7, :cond_a

    invoke-virtual {v7}, Ljava/io/BufferedOutputStream;->flush()V

    .line 1369
    :cond_a
    iget-object v7, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->currentFileOutputStream:Ljava/io/BufferedOutputStream;

    if-eqz v7, :cond_b

    invoke-virtual {v7}, Ljava/io/BufferedOutputStream;->close()V

    .line 1371
    :cond_b
    iget-object v7, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    invoke-static {v7}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->access$getMFileReceiveListener$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;)Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileReceiveListener;

    move-result-object v7

    if-eqz v7, :cond_e

    iget-object v10, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->saveFile:Ljava/io/File;

    if-eqz v10, :cond_c

    invoke-virtual {v10}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v6

    :cond_c
    if-nez v6, :cond_d

    goto :goto_2

    :cond_d
    move-object v5, v6

    :goto_2
    invoke-interface {v7, v5}, Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileReceiveListener;->onComplete(Ljava/lang/String;)V

    .line 1373
    :cond_e
    invoke-virtual {p0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->resetFileReceiveState()V

    goto/16 :goto_7

    .line 1293
    .end local v3    # "progress":F
    .end local v4    # "roundedProgress":F
    .end local v8    # "currentTime":J
    :pswitch_1
    new-instance v3, Ljava/lang/String;

    .line 1296
    iget-object v9, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->buffer:[B

    iget v10, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->bytes:I

    sget-object v11, Lkotlin/text/Charsets;->UTF_8:Ljava/nio/charset/Charset;

    invoke-direct {v3, v9, v1, v10, v11}, Ljava/lang/String;-><init>([BIILjava/nio/charset/Charset;)V

    .line 1297
    .local v3, "metadata":Ljava/lang/String;
    move-object v9, v3

    check-cast v9, Ljava/lang/CharSequence;

    new-array v10, v4, [Ljava/lang/String;

    const-string v11, "|"

    aput-object v11, v10, v1

    const/4 v13, 0x6

    const/4 v14, 0x0

    const/4 v11, 0x0

    const/4 v12, 0x0

    invoke-static/range {v9 .. v14}, Lkotlin/text/StringsKt;->split$default(Ljava/lang/CharSequence;[Ljava/lang/String;ZIILjava/lang/Object;)Ljava/util/List;

    move-result-object v9

    .line 1299
    .local v9, "parts":Ljava/util/List;
    invoke-interface {v9}, Ljava/util/List;->size()I

    move-result v10

    const/4 v11, 0x2

    if-ne v10, v11, :cond_1

    .line 1300
    invoke-interface {v9, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v10

    check-cast v10, Ljava/lang/String;

    iput-object v10, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->currentFileName:Ljava/lang/String;

    .line 1301
    invoke-interface {v9, v4}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/lang/String;

    invoke-static {v4}, Lkotlin/text/StringsKt;->toLongOrNull(Ljava/lang/String;)Ljava/lang/Long;

    move-result-object v4

    if-eqz v4, :cond_f

    invoke-virtual {v4}, Ljava/lang/Long;->longValue()J

    move-result-wide v10

    goto :goto_3

    :cond_f
    move-wide v10, v7

    :goto_3
    iput-wide v10, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->currentFileSize:J

    .line 1304
    nop

    .line 1305
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v10, "currentFileName:"

    invoke-virtual {v4, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    iget-object v10, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->currentFileName:Ljava/lang/String;

    invoke-virtual {v4, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v10, " currentFileSize:"

    invoke-virtual {v4, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    iget-wide v10, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->currentFileSize:J

    invoke-virtual {v4, v10, v11}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    filled-new-array {v4}, [Ljava/lang/Object;

    move-result-object v4

    .line 1303
    invoke-static {v0, v4}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 1308
    iget-wide v10, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->currentFileSize:J

    cmp-long v4, v10, v7

    if-lez v4, :cond_1

    iget-object v4, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->currentFileName:Ljava/lang/String;

    if-eqz v4, :cond_1

    .line 1310
    iget-wide v10, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->currentFileSize:J

    const-wide/32 v12, 0x100000

    cmp-long v4, v10, v12

    if-lez v4, :cond_10

    .line 1311
    const/high16 v4, 0x10000

    new-array v4, v4, [B

    iput-object v4, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->buffer:[B

    goto :goto_4

    .line 1313
    :cond_10
    iget v4, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->baseBufferSize:I

    new-array v4, v4, [B

    iput-object v4, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->buffer:[B

    .line 1315
    :goto_4
    new-instance v4, Ljava/io/File;

    sget-object v10, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->Companion:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$Companion;

    invoke-virtual {v10}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$Companion;->getSaveDirectory()Ljava/lang/String;

    move-result-object v10

    iget-object v11, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->currentFileName:Ljava/lang/String;

    invoke-direct {v4, v10, v11}, Ljava/io/File;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    iput-object v4, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->saveFile:Ljava/io/File;

    .line 1316
    iget-object v4, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->saveFile:Ljava/io/File;

    if-eqz v4, :cond_11

    invoke-virtual {v4}, Ljava/io/File;->getParentFile()Ljava/io/File;

    move-result-object v4

    goto :goto_5

    :cond_11
    move-object v4, v6

    .line 1317
    .local v4, "parentDir":Ljava/io/File;
    :goto_5
    if-eqz v4, :cond_12

    invoke-virtual {v4}, Ljava/io/File;->exists()Z

    move-result v10

    if-nez v10, :cond_12

    .line 1319
    invoke-virtual {v4}, Ljava/io/File;->mkdirs()Z

    move-result v10

    .line 1320
    .local v10, "isDirCreated":Z
    if-nez v10, :cond_12

    .line 1323
    const-string v5, "FileError"

    .line 1324
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

    .line 1322
    invoke-static {v5, v6}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 1326
    return-void

    .line 1330
    .end local v10    # "isDirCreated":Z
    :cond_12
    nop

    .line 1331
    new-instance v10, Ljava/io/BufferedOutputStream;

    new-instance v11, Ljava/io/FileOutputStream;

    iget-object v12, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->saveFile:Ljava/io/File;

    invoke-direct {v11, v12}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V

    check-cast v11, Ljava/io/OutputStream;

    invoke-direct {v10, v11}, Ljava/io/BufferedOutputStream;-><init>(Ljava/io/OutputStream;)V

    .line 1330
    iput-object v10, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->currentFileOutputStream:Ljava/io/BufferedOutputStream;

    .line 1334
    sget-object v10, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ReceiveState;->RECEIVING_FILE_CONTENT:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ReceiveState;

    iput-object v10, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->currentState:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ReceiveState;

    .line 1335
    iput-wide v7, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->totalReceived:J

    .line 1338
    iget-object v7, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    invoke-static {v7}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->access$getMFileReceiveListener$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;)Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileReceiveListener;

    move-result-object v7

    if-eqz v7, :cond_1

    iget-object v8, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->saveFile:Ljava/io/File;

    if-eqz v8, :cond_13

    invoke-virtual {v8}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v6

    :cond_13
    if-nez v6, :cond_14

    goto :goto_6

    :cond_14
    move-object v5, v6

    :goto_6
    invoke-interface {v7, v5}, Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileReceiveListener;->onStart(Ljava/lang/String;)V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    goto/16 :goto_0

    .line 1373
    .end local v3    # "metadata":Ljava/lang/String;
    .end local v4    # "parentDir":Ljava/io/File;
    .end local v9    # "parts":Ljava/util/List;
    :goto_7
    goto/16 :goto_0

    .line 1379
    .end local v2    # "input":Ljava/io/InputStream;
    :catch_0
    move-exception v2

    .line 1380
    .local v2, "e":Ljava/lang/Exception;
    iput-boolean v1, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->isSocketDateRunning:Z

    .line 1381
    iget-object v1, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    invoke-static {v1}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->access$getConnectedFileSockets$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;)Ljava/util/concurrent/CopyOnWriteArrayList;

    move-result-object v1

    iget-object v3, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->socket:Landroid/bluetooth/BluetoothSocket;

    invoke-virtual {v1, v3}, Ljava/util/concurrent/CopyOnWriteArrayList;->contains(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_15

    .line 1382
    iget-object v1, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    invoke-static {v1}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->access$getConnectedFileSockets$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;)Ljava/util/concurrent/CopyOnWriteArrayList;

    move-result-object v1

    iget-object v3, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->socket:Landroid/bluetooth/BluetoothSocket;

    invoke-virtual {v1, v3}, Ljava/util/concurrent/CopyOnWriteArrayList;->remove(Ljava/lang/Object;)Z

    .line 1384
    :cond_15
    iget-object v1, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->socket:Landroid/bluetooth/BluetoothSocket;

    invoke-virtual {v1}, Landroid/bluetooth/BluetoothSocket;->close()V

    .line 1385
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "\u6587\u4ef6\u6d41\u65ad\u5f00\uff1a"

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v2}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 1388
    .end local v2    # "e":Ljava/lang/Exception;
    :cond_16
    :goto_8
    return-void

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method private final processStreamPackets(Ljava/io/ByteArrayOutputStream;)V
    .locals 17
    .param p1, "streamBuffer"    # Ljava/io/ByteArrayOutputStream;

    .line 1161
    move-object/from16 v0, p0

    invoke-virtual/range {p1 .. p1}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object v1

    .line 1162
    .local v1, "data":[B
    const/4 v2, 0x0

    .line 1165
    .local v2, "offset":I
    :cond_0
    :goto_0
    array-length v3, v1

    if-ge v2, v3, :cond_d

    .line 1166
    iget-object v3, v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->currentState:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ReceiveState;

    sget-object v4, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread$WhenMappings;->$EnumSwitchMapping$0:[I

    invoke-virtual {v3}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ReceiveState;->ordinal()I

    move-result v3

    aget v3, v4, v3

    const/4 v4, 0x0

    const-wide/16 v5, 0x0

    const-string v7, "ClassicBluetoothService "

    packed-switch v3, :pswitch_data_0

    goto/16 :goto_3

    .line 1211
    :pswitch_0
    iget-object v3, v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->tag:Ljava/lang/String;

    if-eqz v3, :cond_8

    iget-object v3, v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->clientId:Ljava/lang/String;

    if-eqz v3, :cond_8

    iget-wide v8, v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->dataSize:J

    cmp-long v3, v8, v5

    if-lez v3, :cond_8

    .line 1212
    array-length v3, v1

    sub-int/2addr v3, v2

    .line 1213
    .local v3, "remainingInBuffer":I
    iget-wide v5, v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->dataSize:J

    iget-wide v8, v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->totalReceived:J

    sub-long/2addr v5, v8

    .line 1214
    .local v5, "remainingToRead":J
    long-to-int v8, v5

    invoke-static {v3, v8}, Ljava/lang/Math;->min(II)I

    move-result v8

    .line 1216
    .local v8, "bytesToProcess":I
    if-lez v8, :cond_7

    .line 1218
    iget-object v9, v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->byteArrayOutputStream:Ljava/io/ByteArrayOutputStream;

    if-eqz v9, :cond_1

    invoke-virtual {v9, v1, v2, v8}, Ljava/io/ByteArrayOutputStream;->write([BII)V

    .line 1219
    :cond_1
    iget-wide v9, v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->totalReceived:J

    int-to-long v11, v8

    add-long/2addr v9, v11

    iput-wide v9, v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->totalReceived:J

    .line 1220
    add-int/2addr v2, v8

    .line 1223
    iget-wide v9, v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->totalReceived:J

    iget-wide v11, v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->dataSize:J

    cmp-long v9, v9, v11

    if-ltz v9, :cond_0

    .line 1224
    iget-object v9, v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->byteArrayOutputStream:Ljava/io/ByteArrayOutputStream;

    if-eqz v9, :cond_2

    invoke-virtual {v9}, Ljava/io/ByteArrayOutputStream;->flush()V

    .line 1225
    :cond_2
    iget-object v9, v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->byteArrayOutputStream:Ljava/io/ByteArrayOutputStream;

    if-eqz v9, :cond_3

    invoke-virtual {v9}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object v9

    goto :goto_1

    :cond_3
    const/4 v9, 0x0

    :goto_1
    if-nez v9, :cond_4

    new-array v9, v4, [B

    :cond_4
    move-object v4, v9

    .line 1226
    .local v4, "packetData":[B
    iget-object v9, v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->byteArrayOutputStream:Ljava/io/ByteArrayOutputStream;

    if-eqz v9, :cond_5

    invoke-virtual {v9}, Ljava/io/ByteArrayOutputStream;->close()V

    .line 1227
    :cond_5
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v9

    .line 1229
    .local v9, "time":J
    new-instance v11, Ljava/lang/StringBuilder;

    invoke-direct {v11}, Ljava/lang/StringBuilder;-><init>()V

    const-string v12, "onStreamReceived \u63a5\u6536\u5b8c\u6210 - tag = "

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    iget-object v12, v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->tag:Ljava/lang/String;

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    const-string v12, ", clientid = "

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    iget-object v12, v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->clientId:Ljava/lang/String;

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

    iget-wide v12, v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->startTime:J

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

    invoke-static {v7, v11}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 1230
    iget-object v7, v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    invoke-static {v7}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->access$getServerListener$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;)Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ServerListener;

    move-result-object v7

    if-eqz v7, :cond_6

    iget-object v11, v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->socket:Landroid/bluetooth/BluetoothSocket;

    invoke-virtual {v11}, Landroid/bluetooth/BluetoothSocket;->getRemoteDevice()Landroid/bluetooth/BluetoothDevice;

    move-result-object v11

    const-string v12, "socket.remoteDevice"

    invoke-static {v11, v12}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    iget-object v12, v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->tag:Ljava/lang/String;

    invoke-static {v12}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;)V

    iget-object v13, v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->clientId:Ljava/lang/String;

    invoke-static {v13}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;)V

    invoke-interface {v7, v11, v12, v4, v13}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ServerListener;->onStreamDataReceived(Landroid/bluetooth/BluetoothDevice;Ljava/lang/String;[BLjava/lang/String;)V

    .line 1233
    :cond_6
    invoke-virtual/range {p0 .. p0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->resetStreamReceiveState()V

    .end local v4    # "packetData":[B
    .end local v9    # "time":J
    goto/16 :goto_0

    .line 1237
    :cond_7
    goto/16 :goto_4

    .line 1241
    .end local v3    # "remainingInBuffer":I
    .end local v5    # "remainingToRead":J
    .end local v8    # "bytesToProcess":I
    :cond_8
    invoke-virtual/range {p0 .. p0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->resetStreamReceiveState()V

    goto/16 :goto_3

    .line 1169
    :pswitch_1
    sget-object v3, Lcom/rokid/glasses/transport/sdk/server/utils/DataUtils;->INSTANCE:Lcom/rokid/glasses/transport/sdk/server/utils/DataUtils;

    const-string v8, "data"

    invoke-static {v1, v8}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-virtual {v3, v1, v2}, Lcom/rokid/glasses/transport/sdk/server/utils/DataUtils;->findEndMarkerIndex([BI)I

    move-result v3

    .line 1170
    .local v3, "endMarkerIndex":I
    const/4 v8, -0x1

    if-eq v3, v8, :cond_c

    .line 1172
    sub-int v8, v3, v2

    .local v8, "metadataLength":I
    new-instance v9, Ljava/lang/String;

    .line 1173
    sget-object v10, Lkotlin/text/Charsets;->UTF_8:Ljava/nio/charset/Charset;

    invoke-direct {v9, v1, v2, v8, v10}, Ljava/lang/String;-><init>([BIILjava/nio/charset/Charset;)V

    .line 1174
    .local v9, "metadata":Ljava/lang/String;
    move-object v10, v9

    check-cast v10, Ljava/lang/CharSequence;

    const/4 v15, 0x1

    new-array v11, v15, [Ljava/lang/String;

    const-string v12, "|"

    aput-object v12, v11, v4

    const/4 v14, 0x6

    const/16 v16, 0x0

    const/4 v12, 0x0

    const/4 v13, 0x0

    move v5, v15

    move-object/from16 v15, v16

    invoke-static/range {v10 .. v15}, Lkotlin/text/StringsKt;->split$default(Ljava/lang/CharSequence;[Ljava/lang/String;ZIILjava/lang/Object;)Ljava/util/List;

    move-result-object v6

    .line 1176
    .local v6, "parts":Ljava/util/List;
    invoke-interface {v6}, Ljava/util/List;->size()I

    move-result v10

    const/4 v11, 0x3

    if-ne v10, v11, :cond_b

    .line 1177
    invoke-interface {v6, v4}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/lang/String;

    iput-object v4, v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->tag:Ljava/lang/String;

    .line 1178
    invoke-interface {v6, v5}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/lang/String;

    iput-object v4, v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->clientId:Ljava/lang/String;

    .line 1179
    const/4 v4, 0x2

    invoke-interface {v6, v4}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/lang/String;

    invoke-static {v4}, Lkotlin/text/StringsKt;->toLongOrNull(Ljava/lang/String;)Ljava/lang/Long;

    move-result-object v4

    if-eqz v4, :cond_9

    invoke-virtual {v4}, Ljava/lang/Long;->longValue()J

    move-result-wide v4

    goto :goto_2

    :cond_9
    const-wide/16 v4, 0x0

    :goto_2
    iput-wide v4, v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->dataSize:J

    .line 1181
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "\u89e3\u6790\u5143\u6570\u636e - tag = "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    iget-object v5, v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->tag:Ljava/lang/String;

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, ", clientId = "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    iget-object v5, v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->clientId:Ljava/lang/String;

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, ", dataSize = "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    iget-wide v10, v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->dataSize:J

    invoke-virtual {v4, v10, v11}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    filled-new-array {v4}, [Ljava/lang/Object;

    move-result-object v4

    invoke-static {v7, v4}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 1183
    iget-wide v4, v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->dataSize:J

    const-wide/16 v10, 0x0

    cmp-long v4, v4, v10

    const-string v5, "this as java.lang.String).getBytes(charset)"

    const-string v10, "\\u2063\\u2064\\u2065"

    if-lez v4, :cond_a

    iget-object v4, v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->tag:Ljava/lang/String;

    if-eqz v4, :cond_a

    .line 1185
    sget-object v4, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ReceiveState;->RECEIVING_FILE_CONTENT:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ReceiveState;

    iput-object v4, v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->currentState:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ReceiveState;

    .line 1186
    new-instance v4, Ljava/io/ByteArrayOutputStream;

    invoke-direct {v4}, Ljava/io/ByteArrayOutputStream;-><init>()V

    iput-object v4, v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->byteArrayOutputStream:Ljava/io/ByteArrayOutputStream;

    .line 1187
    const-wide/16 v11, 0x0

    iput-wide v11, v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->totalReceived:J

    .line 1188
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v11

    iput-wide v11, v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->startTime:J

    .line 1191
    sget-object v4, Lkotlin/text/Charsets;->UTF_8:Ljava/nio/charset/Charset;

    invoke-virtual {v10, v4}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B

    move-result-object v4

    invoke-static {v4, v5}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    array-length v4, v4

    add-int v2, v3, v4

    goto/16 :goto_0

    .line 1194
    :cond_a
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v11, "\u65e0\u6548\u7684\u5143\u6570\u636e\uff0c\u8df3\u8fc7: "

    invoke-virtual {v4, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    filled-new-array {v4}, [Ljava/lang/Object;

    move-result-object v4

    invoke-static {v7, v4}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 1195
    sget-object v4, Lkotlin/text/Charsets;->UTF_8:Ljava/nio/charset/Charset;

    invoke-virtual {v10, v4}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B

    move-result-object v4

    invoke-static {v4, v5}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    array-length v4, v4

    add-int v2, v3, v4

    .line 1196
    invoke-virtual/range {p0 .. p0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->resetStreamReceiveState()V

    goto/16 :goto_0

    .line 1200
    :cond_b
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "\u5143\u6570\u636e\u683c\u5f0f\u9519\u8bef\uff0c\u8df3\u8fc7: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    filled-new-array {v4}, [Ljava/lang/Object;

    move-result-object v4

    invoke-static {v7, v4}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 1201
    add-int/lit8 v2, v3, 0x1

    .line 1202
    invoke-virtual/range {p0 .. p0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->resetStreamReceiveState()V

    .end local v6    # "parts":Ljava/util/List;
    .end local v8    # "metadataLength":I
    .end local v9    # "metadata":Ljava/lang/String;
    goto/16 :goto_0

    .line 1206
    :cond_c
    goto :goto_4

    .line 1241
    .end local v3    # "endMarkerIndex":I
    :goto_3
    goto/16 :goto_0

    .line 1248
    :cond_d
    :goto_4
    if-lez v2, :cond_f

    .line 1249
    invoke-virtual/range {p1 .. p1}, Ljava/io/ByteArrayOutputStream;->reset()V

    .line 1250
    array-length v3, v1

    if-ge v2, v3, :cond_e

    .line 1251
    array-length v3, v1

    sub-int/2addr v3, v2

    move-object/from16 v4, p1

    invoke-virtual {v4, v1, v2, v3}, Ljava/io/ByteArrayOutputStream;->write([BII)V

    goto :goto_5

    .line 1250
    :cond_e
    move-object/from16 v4, p1

    goto :goto_5

    .line 1248
    :cond_f
    move-object/from16 v4, p1

    .line 1254
    :goto_5
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

    .line 1519
    if-ltz p3, :cond_6

    if-ltz p4, :cond_6

    add-int v0, p3, p4

    array-length v1, p2

    if-gt v0, v1, :cond_6

    .line 1522
    const/4 v0, 0x0

    .line 1523
    .local v0, "totalRead":I
    move v1, p4

    .line 1525
    .local v1, "remaining":I
    :goto_0
    if-lez v1, :cond_5

    .line 1526
    if-eqz p1, :cond_0

    add-int v2, p3, v0

    invoke-virtual {p1, p2, v2, v1}, Ljava/io/InputStream;->read([BII)I

    move-result v2

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    goto :goto_1

    :cond_0
    const/4 v2, 0x0

    .line 1527
    .local v2, "read":Ljava/lang/Integer;
    :goto_1
    nop

    .line 1528
    if-nez v2, :cond_1

    goto :goto_2

    :cond_1
    invoke-virtual {v2}, Ljava/lang/Integer;->intValue()I

    move-result v3

    const/4 v4, -0x1

    if-ne v3, v4, :cond_3

    .line 1530
    if-nez v0, :cond_2

    return v4

    .line 1531
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

    .line 1533
    :cond_3
    :goto_2
    if-eqz v2, :cond_4

    .line 1538
    invoke-virtual {v2}, Ljava/lang/Integer;->intValue()I

    move-result v3

    add-int/2addr v0, v3

    .line 1539
    invoke-virtual {v2}, Ljava/lang/Integer;->intValue()I

    move-result v3

    sub-int/2addr v1, v3

    .end local v2    # "read":Ljava/lang/Integer;
    goto :goto_0

    .line 1535
    .restart local v2    # "read":Ljava/lang/Integer;
    :cond_4
    new-instance v3, Ljava/io/IOException;

    const-string v4, "InputStream is null"

    invoke-direct {v3, v4}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v3

    .line 1544
    .end local v2    # "read":Ljava/lang/Integer;
    :cond_5
    return v0

    .line 1520
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

    .line 1087
    iget v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->bytes:I

    return v0
.end method

.method public final getLengthBuf()[B
    .locals 1

    .line 1069
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->lengthBuf:[B

    return-object v0
.end method

.method public final handleAudioStreamContinuously()V
    .locals 6

    .line 1407
    const/16 v0, 0x1000

    new-array v0, v0, [B

    .line 1408
    .local v0, "buffer":[B
    nop

    .line 1409
    :goto_0
    :try_start_0
    iget-boolean v1, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->isSocketDateRunning:Z

    if-eqz v1, :cond_3

    .line 1411
    iget-object v1, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->socket:Landroid/bluetooth/BluetoothSocket;

    invoke-virtual {v1}, Landroid/bluetooth/BluetoothSocket;->isConnected()Z

    move-result v1

    const/4 v2, 0x1

    if-eq v1, v2, :cond_0

    .line 1412
    return-void

    .line 1414
    :cond_0
    iget-object v1, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->inputStream:Ljava/io/InputStream;

    if-eqz v1, :cond_3

    invoke-virtual {v1, v0}, Ljava/io/InputStream;->read([B)I

    move-result v1

    .line 1415
    .local v1, "bytes":I
    if-gtz v1, :cond_1

    .line 1416
    goto :goto_1

    .line 1418
    :cond_1
    invoke-static {v0, v1}, Ljava/util/Arrays;->copyOf([BI)[B

    move-result-object v2

    const-string v3, "copyOf(this, newSize)"

    invoke-static {v2, v3}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 1419
    .local v2, "audioData":[B
    iget-object v3, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    invoke-static {v3}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->access$getMainHandler$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;)Landroid/os/Handler;

    move-result-object v3

    iget-object v4, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    new-instance v5, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread$$ExternalSyntheticLambda0;

    invoke-direct {v5, v4, p0, v2}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread$$ExternalSyntheticLambda0;-><init>(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;[B)V

    invoke-virtual {v3, v5}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 1426
    .end local v1    # "bytes":I
    .end local v2    # "audioData":[B
    :catch_0
    move-exception v1

    .line 1427
    .local v1, "e":Ljava/lang/Exception;
    const/4 v2, 0x0

    iput-boolean v2, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->isSocketDateRunning:Z

    .line 1428
    iget-object v2, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    invoke-static {v2}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->access$getConnectedAudioSockets$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;)Ljava/util/concurrent/CopyOnWriteArrayList;

    move-result-object v2

    iget-object v3, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->socket:Landroid/bluetooth/BluetoothSocket;

    invoke-virtual {v2, v3}, Ljava/util/concurrent/CopyOnWriteArrayList;->contains(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_2

    .line 1429
    iget-object v2, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    invoke-static {v2}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->access$getConnectedAudioSockets$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;)Ljava/util/concurrent/CopyOnWriteArrayList;

    move-result-object v2

    iget-object v3, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->socket:Landroid/bluetooth/BluetoothSocket;

    invoke-virtual {v2, v3}, Ljava/util/concurrent/CopyOnWriteArrayList;->remove(Ljava/lang/Object;)Z

    .line 1431
    :cond_2
    iget-object v2, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->socket:Landroid/bluetooth/BluetoothSocket;

    invoke-virtual {v2}, Landroid/bluetooth/BluetoothSocket;->close()V

    .line 1432
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Audio\u6d41\u65ad\u5f00\uff1a"

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

    .line 1434
    .end local v1    # "e":Ljava/lang/Exception;
    :cond_3
    :goto_1
    return-void
.end method

.method public final handleStreamContinuously()V
    .locals 7

    .line 1122
    const-string v0, "ClassicBluetoothService "

    .line 1123
    const/4 v1, 0x0

    :try_start_0
    iget-object v2, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->inputStream:Ljava/io/InputStream;

    if-nez v2, :cond_0

    move-object v2, p0

    check-cast v2, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;

    .local v2, "$this$handleStreamContinuously_u24lambda_u240":Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;
    const/4 v3, 0x0

    .line 1124
    .local v3, "$i$a$-run-ClassicBluetoothService$ClientHandlerThread$handleStreamContinuously$input$1":I
    const-string v4, "\u8f93\u5165\u6d41\u4e3a\u7a7a\uff0c\u65e0\u6cd5\u63a5\u6536Stream"

    filled-new-array {v4}, [Ljava/lang/Object;

    move-result-object v4

    invoke-static {v0, v4}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 1125
    return-void

    .end local v2    # "$this$handleStreamContinuously_u24lambda_u240":Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;
    .end local v3    # "$i$a$-run-ClassicBluetoothService$ClientHandlerThread$handleStreamContinuously$input$1":I
    :cond_0
    nop

    .line 1127
    .local v2, "input":Ljava/io/InputStream;
    new-instance v3, Ljava/io/ByteArrayOutputStream;

    invoke-direct {v3}, Ljava/io/ByteArrayOutputStream;-><init>()V

    .local v3, "streamBuffer":Ljava/io/ByteArrayOutputStream;
    const/4 v4, 0x0

    .line 1131
    .local v4, "bytes":I
    :goto_0
    iget-boolean v5, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->isSocketDateRunning:Z

    if-eqz v5, :cond_4

    .line 1133
    iget-object v5, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->socket:Landroid/bluetooth/BluetoothSocket;

    invoke-virtual {v5}, Landroid/bluetooth/BluetoothSocket;->isConnected()Z

    move-result v5

    const/4 v6, 0x1

    if-eq v5, v6, :cond_1

    .line 1134
    return-void

    .line 1136
    :cond_1
    iget-object v5, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->inputStream:Ljava/io/InputStream;

    iget-object v6, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->buffer:[B

    invoke-virtual {v5, v6}, Ljava/io/InputStream;->read([B)I

    move-result v5

    move v4, v5

    .line 1139
    const/4 v5, -0x1

    if-ne v4, v5, :cond_2

    .line 1141
    goto :goto_1

    .line 1145
    :cond_2
    iget-object v5, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->buffer:[B

    invoke-virtual {v3, v5, v1, v4}, Ljava/io/ByteArrayOutputStream;->write([BII)V

    .line 1147
    invoke-direct {p0, v3}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->processStreamPackets(Ljava/io/ByteArrayOutputStream;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 1149
    .end local v2    # "input":Ljava/io/InputStream;
    .end local v3    # "streamBuffer":Ljava/io/ByteArrayOutputStream;
    .end local v4    # "bytes":I
    :catch_0
    move-exception v2

    .line 1150
    .local v2, "e":Ljava/lang/Exception;
    iput-boolean v1, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->isSocketDateRunning:Z

    .line 1151
    iget-object v1, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    invoke-static {v1}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->access$getConnectedStreamSockets$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;)Ljava/util/concurrent/CopyOnWriteArrayList;

    move-result-object v1

    iget-object v3, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->socket:Landroid/bluetooth/BluetoothSocket;

    invoke-virtual {v1, v3}, Ljava/util/concurrent/CopyOnWriteArrayList;->contains(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_3

    .line 1152
    iget-object v1, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;

    invoke-static {v1}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->access$getConnectedStreamSockets$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;)Ljava/util/concurrent/CopyOnWriteArrayList;

    move-result-object v1

    iget-object v3, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->socket:Landroid/bluetooth/BluetoothSocket;

    invoke-virtual {v1, v3}, Ljava/util/concurrent/CopyOnWriteArrayList;->remove(Ljava/lang/Object;)Z

    .line 1154
    :cond_3
    iget-object v1, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->socket:Landroid/bluetooth/BluetoothSocket;

    invoke-virtual {v1}, Landroid/bluetooth/BluetoothSocket;->close()V

    .line 1155
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "stream\u6d41\u65ad\u5f00\uff1a"

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v2}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 1157
    .end local v2    # "e":Ljava/lang/Exception;
    :cond_4
    :goto_1
    return-void
.end method

.method public final resetFileReceiveState()V
    .locals 3

    .line 1393
    const-string v0, "resetFileReceiveState:"

    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v0

    const-string v1, "ClassicBluetoothService "

    invoke-static {v1, v0}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 1394
    sget-object v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ReceiveState;->WAITING_FOR_METADATA:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ReceiveState;

    iput-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->currentState:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ReceiveState;

    .line 1395
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->currentFileName:Ljava/lang/String;

    .line 1396
    const-wide/16 v1, 0x0

    iput-wide v1, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->currentFileSize:J

    .line 1397
    iput-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->currentFileOutputStream:Ljava/io/BufferedOutputStream;

    .line 1398
    iput-wide v1, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->totalReceived:J

    .line 1399
    iput-wide v1, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->lastReceiveProgressTime:J

    .line 1400
    const/4 v1, 0x0

    iput v1, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->lastReceiveProgressValue:F

    .line 1401
    iput-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->saveFile:Ljava/io/File;

    .line 1402
    return-void
.end method

.method public final resetStreamReceiveState()V
    .locals 3

    .line 1258
    const-string v0, "resetStreamReceiveState: "

    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v0

    const-string v1, "ClassicBluetoothService "

    invoke-static {v1, v0}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 1259
    sget-object v0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ReceiveState;->WAITING_FOR_METADATA:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ReceiveState;

    iput-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->currentState:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ReceiveState;

    .line 1260
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->tag:Ljava/lang/String;

    .line 1261
    iput-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->clientId:Ljava/lang/String;

    .line 1262
    const-wide/16 v1, 0x0

    iput-wide v1, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->dataSize:J

    .line 1263
    iput-wide v1, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->totalReceived:J

    .line 1264
    iget-object v1, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->byteArrayOutputStream:Ljava/io/ByteArrayOutputStream;

    if-eqz v1, :cond_0

    invoke-virtual {v1}, Ljava/io/ByteArrayOutputStream;->close()V

    .line 1265
    :cond_0
    iput-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->byteArrayOutputStream:Ljava/io/ByteArrayOutputStream;

    .line 1266
    return-void
.end method

.method public run()V
    .locals 2

    .line 1094
    iget-boolean v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->isSocketDateRunning:Z

    if-eqz v0, :cond_3

    invoke-virtual {p0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->isInterrupted()Z

    move-result v0

    if-nez v0, :cond_3

    .line 1095
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->type:Ljava/lang/String;

    .line 1096
    sget-object v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->Companion:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$Companion;

    invoke-virtual {v1}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$Companion;->getMESSAGE_TYPE()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->handleMessageTransferContinuously()V

    goto :goto_0

    .line 1097
    :cond_0
    sget-object v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->Companion:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$Companion;

    invoke-virtual {v1}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$Companion;->getAUDIO_TYPE()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-virtual {p0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->handleAudioStreamContinuously()V

    goto :goto_0

    .line 1098
    :cond_1
    sget-object v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->Companion:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$Companion;

    invoke-virtual {v1}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$Companion;->getFILE_TYPE()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_2

    invoke-direct {p0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->handleMultiFileTransferContinuously()V

    goto :goto_0

    .line 1099
    :cond_2
    sget-object v1, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService;->Companion:Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$Companion;

    invoke-virtual {v1}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$Companion;->getSTREAM_TYPE()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_3

    invoke-virtual {p0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->handleStreamContinuously()V

    .line 1102
    :cond_3
    :goto_0
    return-void
.end method

.method public final setBytes(I)V
    .locals 0
    .param p1, "<set-?>"    # I

    .line 1087
    iput p1, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->bytes:I

    return-void
.end method

.method public final shutdown()V
    .locals 1

    .line 1105
    iget-boolean v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->isSocketDateRunning:Z

    if-eqz v0, :cond_0

    .line 1106
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->isSocketDateRunning:Z

    .line 1107
    nop

    .line 1108
    :try_start_0
    invoke-virtual {p0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->interrupt()V

    .line 1109
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->socket:Landroid/bluetooth/BluetoothSocket;

    invoke-virtual {v0}, Landroid/bluetooth/BluetoothSocket;->close()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    .line 1114
    :catchall_0
    move-exception v0

    goto :goto_1

    .line 1110
    :catch_0
    move-exception v0

    .line 1111
    .local v0, "e":Ljava/lang/Exception;
    :try_start_1
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 1114
    .end local v0    # "e":Ljava/lang/Exception;
    :goto_0
    invoke-virtual {p0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->resetStreamReceiveState()V

    .line 1115
    invoke-virtual {p0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->resetFileReceiveState()V

    .line 1116
    goto :goto_2

    .line 1114
    :goto_1
    invoke-virtual {p0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->resetStreamReceiveState()V

    .line 1115
    invoke-virtual {p0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBluetoothService$ClientHandlerThread;->resetFileReceiveState()V

    throw v0

    .line 1118
    :cond_0
    :goto_2
    return-void
.end method
