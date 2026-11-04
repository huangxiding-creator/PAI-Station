.class public final Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;
.super Ljava/lang/Object;
.source "InspectMediaRecorderManager.kt"


# annotations
.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nInspectMediaRecorderManager.kt\nKotlin\n*S Kotlin\n*F\n+ 1 InspectMediaRecorderManager.kt\ncom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager\n+ 2 fake.kt\nkotlin/jvm/internal/FakeKt\n*L\n1#1,406:1\n1#2:407\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000r\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0008\n\u0002\u0008\u0003\n\u0002\u0010\u000e\n\u0002\u0008\u0003\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\t\n\u0000\n\u0002\u0010\u000b\n\u0000\n\u0002\u0010\u0012\n\u0002\u0008\u0004\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0003\n\u0002\u0018\u0002\n\u0002\u0008\u0004\n\u0002\u0018\u0002\n\u0002\u0008\n\n\u0002\u0010\u0002\n\u0002\u0008\r\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0002\u0018\u00002\u00020\u0001B\u001d\u0012\u0006\u0010\u0002\u001a\u00020\u0003\u0012\u0006\u0010\u0004\u001a\u00020\u0005\u0012\u0006\u0010\u0006\u001a\u00020\u0005\u00a2\u0006\u0002\u0010\u0007J\u0010\u0010/\u001a\u0002002\u0006\u00101\u001a\u00020\u0013H\u0002J\u0010\u00102\u001a\u0002002\u0006\u00101\u001a\u00020\u0013H\u0002J\u000e\u00103\u001a\u0002002\u0006\u00104\u001a\u00020\u0015J\u000e\u00105\u001a\u0002002\u0006\u00106\u001a\u00020\u0015J\u0008\u00107\u001a\u000200H\u0002J\u0006\u00108\u001a\u00020\tJ(\u00109\u001a\u0002002\u0006\u00106\u001a\u00020\u00152\u0006\u0010:\u001a\u00020\u00152\u0006\u0010\u0004\u001a\u00020\u00052\u0006\u0010\u0006\u001a\u00020\u0005H\u0002J\u0008\u0010;\u001a\u000200H\u0002J)\u0010<\u001a\u0002002!\u0010=\u001a\u001d\u0012\u0013\u0012\u00110\t\u00a2\u0006\u000c\u0008?\u0012\u0008\u0008@\u0012\u0004\u0008\u0008(#\u0012\u0004\u0012\u0002000>R\u000e\u0010\u0008\u001a\u00020\tX\u0082D\u00a2\u0006\u0002\n\u0000R\u000e\u0010\n\u001a\u00020\u0005X\u0082D\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u000b\u001a\u00020\u0005X\u0082D\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u000c\u001a\u00020\rX\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u0010\u0010\u000e\u001a\u0004\u0018\u00010\u000fX\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0010\u001a\u00020\u0011X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0012\u001a\u00020\u0013X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0014\u001a\u00020\u0015X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0016\u001a\u00020\u0005X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0017\u001a\u00020\u0005X\u0082D\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0018\u001a\u00020\u0005X\u0082D\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0002\u001a\u00020\u0003X\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0019\u001a\u00020\u001aX\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u001b\u001a\u00020\u001cX\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u001d\u001a\u00020\u0011X\u0082D\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u001e\u001a\u00020\u0005X\u0082D\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0006\u001a\u00020\u0005X\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u001f\u001a\u00020 X\u0082.\u00a2\u0006\u0002\n\u0000R\u000e\u0010!\u001a\u00020\u0001X\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u000e\u0010\"\u001a\u00020\u0013X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010#\u001a\u00020\tX\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0010\u0010$\u001a\u0004\u0018\u00010%X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0010\u0010&\u001a\u0004\u0018\u00010%X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\'\u001a\u00020\u0005X\u0082D\u00a2\u0006\u0002\n\u0000R\u000e\u0010(\u001a\u00020\u0011X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010)\u001a\u00020\rX\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u0010\u0010*\u001a\u0004\u0018\u00010\u000fX\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010+\u001a\u00020\u0011X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010,\u001a\u00020\u0013X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010-\u001a\u00020\u0005X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0004\u001a\u00020\u0005X\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u000e\u0010.\u001a\u00020\u0015X\u0082\u0004\u00a2\u0006\u0002\n\u0000\u00a8\u0006A"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;",
        "",
        "context",
        "Landroid/content/Context;",
        "width",
        "",
        "height",
        "(Landroid/content/Context;II)V",
        "TAG",
        "",
        "aacFrameBytes",
        "aacFrameSamples",
        "audioBufferInfo",
        "Landroid/media/MediaCodec$BufferInfo;",
        "audioEncoder",
        "Landroid/media/MediaCodec;",
        "audioPtsUs",
        "",
        "audioReady",
        "",
        "audioRemain",
        "",
        "audioTrackIndex",
        "bytesPerSample",
        "channelCount",
        "encodeHandler",
        "Landroid/os/Handler;",
        "encodeThread",
        "Landroid/os/HandlerThread;",
        "frameDurationUs",
        "frameRate",
        "muxer",
        "Landroid/media/MediaMuxer;",
        "muxerLock",
        "muxerStarted",
        "outputPath",
        "pendingAudioFormat",
        "Landroid/media/MediaFormat;",
        "pendingVideoFormat",
        "sampleRate",
        "startTimeUs",
        "videoBufferInfo",
        "videoEncoder",
        "videoPtsUs",
        "videoReady",
        "videoTrackIndex",
        "yuvTemp",
        "drainAudioEncoder",
        "",
        "endOfStream",
        "drainVideoEncoder",
        "encodeAudioFrame",
        "pcm",
        "encodeVideoFrame",
        "nv21",
        "ensureAudioEncoder",
        "getOutputPath",
        "nv21ToNv12",
        "nv12",
        "startMuxerIfReady",
        "stop",
        "onStopped",
        "Lkotlin/Function1;",
        "Lkotlin/ParameterName;",
        "name",
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
.field private final TAG:Ljava/lang/String;

.field private final aacFrameBytes:I

.field private final aacFrameSamples:I

.field private final audioBufferInfo:Landroid/media/MediaCodec$BufferInfo;

.field private audioEncoder:Landroid/media/MediaCodec;

.field private audioPtsUs:J

.field private volatile audioReady:Z

.field private audioRemain:[B

.field private audioTrackIndex:I

.field private final bytesPerSample:I

.field private final channelCount:I

.field private final context:Landroid/content/Context;

.field private final encodeHandler:Landroid/os/Handler;

.field private final encodeThread:Landroid/os/HandlerThread;

.field private final frameDurationUs:J

.field private final frameRate:I

.field private final height:I

.field private muxer:Landroid/media/MediaMuxer;

.field private final muxerLock:Ljava/lang/Object;

.field private muxerStarted:Z

.field private outputPath:Ljava/lang/String;

.field private pendingAudioFormat:Landroid/media/MediaFormat;

.field private pendingVideoFormat:Landroid/media/MediaFormat;

.field private final sampleRate:I

.field private startTimeUs:J

.field private final videoBufferInfo:Landroid/media/MediaCodec$BufferInfo;

.field private videoEncoder:Landroid/media/MediaCodec;

.field private videoPtsUs:J

.field private volatile videoReady:Z

.field private videoTrackIndex:I

.field private final width:I

.field private final yuvTemp:[B


# direct methods
.method public static synthetic $r8$lambda$Q7AXM_8P4gaJEx2qZRtpbxoZP-8(Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;[B)V
    .locals 0

    invoke-static {p0, p1}, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->encodeAudioFrame$lambda$2(Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;[B)V

    return-void
.end method

.method public static synthetic $r8$lambda$VtBeMN-WudYd7IewJ-eyuzcjbs8(Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;[B)V
    .locals 0

    invoke-static {p0, p1}, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->encodeVideoFrame$lambda$1(Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;[B)V

    return-void
.end method

.method public static synthetic $r8$lambda$YZ8CqRCZLFHxf8VY_A1wbdMScWI(Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;Lkotlin/jvm/functions/Function1;)V
    .locals 0

    invoke-static {p0, p1}, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->stop$lambda$9(Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;Lkotlin/jvm/functions/Function1;)V

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;II)V
    .locals 9
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "width"    # I
    .param p3, "height"    # I

    const-string/jumbo v0, "video/avc"

    const-string v1, "context"

    invoke-static {p1, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 22
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 23
    iput-object p1, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->context:Landroid/content/Context;

    .line 24
    iput p2, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->width:I

    .line 25
    iput p3, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->height:I

    .line 27
    const-string v1, "InspectMediaRecorder"

    iput-object v1, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->TAG:Ljava/lang/String;

    .line 33
    const/4 v1, -0x1

    iput v1, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->videoTrackIndex:I

    .line 34
    iput v1, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->audioTrackIndex:I

    .line 36
    new-instance v1, Ljava/lang/Object;

    invoke-direct {v1}, Ljava/lang/Object;-><init>()V

    iput-object v1, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->muxerLock:Ljava/lang/Object;

    .line 40
    new-instance v1, Landroid/media/MediaCodec$BufferInfo;

    invoke-direct {v1}, Landroid/media/MediaCodec$BufferInfo;-><init>()V

    iput-object v1, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->videoBufferInfo:Landroid/media/MediaCodec$BufferInfo;

    .line 41
    new-instance v1, Landroid/media/MediaCodec$BufferInfo;

    invoke-direct {v1}, Landroid/media/MediaCodec$BufferInfo;-><init>()V

    iput-object v1, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->audioBufferInfo:Landroid/media/MediaCodec$BufferInfo;

    .line 43
    iget v1, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->width:I

    iget v2, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->height:I

    mul-int/2addr v1, v2

    mul-int/lit8 v1, v1, 0x3

    const/4 v2, 0x2

    div-int/2addr v1, v2

    new-array v1, v1, [B

    iput-object v1, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->yuvTemp:[B

    .line 45
    const-string v1, ""

    iput-object v1, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->outputPath:Ljava/lang/String;

    .line 47
    new-instance v3, Landroid/os/HandlerThread;

    const-string v4, "EncodeThread"

    invoke-direct {v3, v4}, Landroid/os/HandlerThread;-><init>(Ljava/lang/String;)V

    .line 407
    move-object v4, v3

    .local v4, "$this$encodeThread_u24lambda_u240":Landroid/os/HandlerThread;
    const/4 v5, 0x0

    .line 47
    .local v5, "$i$a$-apply-InspectMediaRecorderManager$encodeThread$1":I
    invoke-virtual {v4}, Landroid/os/HandlerThread;->start()V

    .end local v4    # "$this$encodeThread_u24lambda_u240":Landroid/os/HandlerThread;
    .end local v5    # "$i$a$-apply-InspectMediaRecorderManager$encodeThread$1":I
    iput-object v3, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->encodeThread:Landroid/os/HandlerThread;

    .line 48
    new-instance v3, Landroid/os/Handler;

    iget-object v4, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->encodeThread:Landroid/os/HandlerThread;

    invoke-virtual {v4}, Landroid/os/HandlerThread;->getLooper()Landroid/os/Looper;

    move-result-object v4

    invoke-direct {v3, v4}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    iput-object v3, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->encodeHandler:Landroid/os/Handler;

    .line 53
    const/16 v3, 0x3e80

    iput v3, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->sampleRate:I

    .line 54
    const/4 v3, 0x1

    iput v3, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->channelCount:I

    .line 55
    iput v2, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->bytesPerSample:I

    .line 56
    const/16 v2, 0x400

    iput v2, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->aacFrameSamples:I

    .line 57
    iget v2, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->aacFrameSamples:I

    iget v4, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->bytesPerSample:I

    mul-int/2addr v2, v4

    iget v4, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->channelCount:I

    mul-int/2addr v2, v4

    iput v2, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->aacFrameBytes:I

    .line 59
    const/4 v2, 0x0

    new-array v4, v2, [B

    iput-object v4, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->audioRemain:[B

    .line 60
    const/16 v4, 0x1e

    iput v4, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->frameRate:I

    .line 61
    iget v5, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->frameRate:I

    int-to-long v5, v5

    const-wide/32 v7, 0xf4240

    div-long/2addr v7, v5

    iput-wide v7, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->frameDurationUs:J

    .line 63
    const-wide/16 v5, -0x1

    iput-wide v5, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->startTimeUs:J

    .line 65
    nop

    .line 66
    nop

    .line 68
    :try_start_0
    new-instance v5, Ljava/io/File;

    iget-object v6, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->context:Landroid/content/Context;

    const-string v7, "recordings"

    invoke-virtual {v6, v7}, Landroid/content/Context;->getExternalFilesDir(Ljava/lang/String;)Ljava/io/File;

    move-result-object v6

    invoke-direct {v5, v6, v1}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    move-object v1, v5

    .line 69
    .local v1, "dir":Ljava/io/File;
    invoke-virtual {v1}, Ljava/io/File;->exists()Z

    move-result v5

    if-nez v5, :cond_0

    invoke-virtual {v1}, Ljava/io/File;->mkdirs()Z

    .line 70
    :cond_0
    new-instance v5, Ljava/text/SimpleDateFormat;

    const-string/jumbo v6, "yyyyMMdd_HHmmss"

    sget-object v7, Ljava/util/Locale;->US:Ljava/util/Locale;

    invoke-direct {v5, v6, v7}, Ljava/text/SimpleDateFormat;-><init>(Ljava/lang/String;Ljava/util/Locale;)V

    new-instance v6, Ljava/util/Date;

    invoke-direct {v6}, Ljava/util/Date;-><init>()V

    invoke-virtual {v5, v6}, Ljava/text/SimpleDateFormat;->format(Ljava/util/Date;)Ljava/lang/String;

    move-result-object v5

    .line 71
    .local v5, "timestamp":Ljava/lang/String;
    new-instance v6, Ljava/io/File;

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "record_"

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v8, ".mp4"

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-direct {v6, v1, v7}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    invoke-virtual {v6}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v6

    const-string v7, "File(dir, \"record_$timestamp.mp4\").absolutePath"

    invoke-static {v6, v7}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    iput-object v6, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->outputPath:Ljava/lang/String;

    .line 74
    iget v6, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->width:I

    iget v7, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->height:I

    invoke-static {v0, v6, v7}, Landroid/media/MediaFormat;->createVideoFormat(Ljava/lang/String;II)Landroid/media/MediaFormat;

    move-result-object v6

    const-string v7, "createVideoFormat(MediaF\u2026VIDEO_AVC, width, height)"

    invoke-static {v6, v7}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 75
    .local v6, "videoFormat":Landroid/media/MediaFormat;
    const-string v7, "color-format"

    const/16 v8, 0x15

    invoke-virtual {v6, v7, v8}, Landroid/media/MediaFormat;->setInteger(Ljava/lang/String;I)V

    .line 76
    const-string v7, "bitrate"

    const v8, 0x1e8480

    invoke-virtual {v6, v7, v8}, Landroid/media/MediaFormat;->setInteger(Ljava/lang/String;I)V

    .line 77
    const-string v7, "frame-rate"

    invoke-virtual {v6, v7, v4}, Landroid/media/MediaFormat;->setInteger(Ljava/lang/String;I)V

    .line 78
    const-string v4, "i-frame-interval"

    invoke-virtual {v6, v4, v3}, Landroid/media/MediaFormat;->setInteger(Ljava/lang/String;I)V

    .line 80
    invoke-static {v0}, Landroid/media/MediaCodec;->createEncoderByType(Ljava/lang/String;)Landroid/media/MediaCodec;

    move-result-object v0

    iput-object v0, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->videoEncoder:Landroid/media/MediaCodec;

    .line 81
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->videoEncoder:Landroid/media/MediaCodec;

    if-eqz v0, :cond_1

    const/4 v4, 0x0

    invoke-virtual {v0, v6, v4, v4, v3}, Landroid/media/MediaCodec;->configure(Landroid/media/MediaFormat;Landroid/view/Surface;Landroid/media/MediaCrypto;I)V

    .line 82
    :cond_1
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->videoEncoder:Landroid/media/MediaCodec;

    if-eqz v0, :cond_2

    invoke-virtual {v0}, Landroid/media/MediaCodec;->start()V

    .line 83
    :cond_2
    iput-boolean v3, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->videoReady:Z

    .line 86
    iput-boolean v2, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->audioReady:Z

    .line 89
    new-instance v0, Landroid/media/MediaMuxer;

    iget-object v3, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->outputPath:Ljava/lang/String;

    invoke-direct {v0, v3, v2}, Landroid/media/MediaMuxer;-><init>(Ljava/lang/String;I)V

    iput-object v0, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->muxer:Landroid/media/MediaMuxer;

    .line 91
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->TAG:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Recorder initialized: path="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->outputPath:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v0, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 93
    .end local v1    # "dir":Ljava/io/File;
    .end local v5    # "timestamp":Ljava/lang/String;
    .end local v6    # "videoFormat":Landroid/media/MediaFormat;
    :catch_0
    move-exception v0

    .line 94
    .local v0, "e":Ljava/lang/Exception;
    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->TAG:Ljava/lang/String;

    const-string v2, "init error"

    move-object v3, v0

    check-cast v3, Ljava/lang/Throwable;

    invoke-static {v1, v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 96
    .end local v0    # "e":Ljava/lang/Exception;
    :goto_0
    nop

    .line 22
    return-void
.end method

.method private final drainAudioEncoder(Z)V
    .locals 7
    .param p1, "endOfStream"    # Z

    .line 247
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->audioEncoder:Landroid/media/MediaCodec;

    if-nez v0, :cond_0

    return-void

    .line 248
    .local v0, "encoder":Landroid/media/MediaCodec;
    :cond_0
    :goto_0
    nop

    .line 249
    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->audioBufferInfo:Landroid/media/MediaCodec$BufferInfo;

    const-wide/16 v2, 0x2710

    invoke-virtual {v0, v1, v2, v3}, Landroid/media/MediaCodec;->dequeueOutputBuffer(Landroid/media/MediaCodec$BufferInfo;J)I

    move-result v1

    .line 250
    .local v1, "outputBufferIndex":I
    nop

    .line 251
    const/4 v2, -0x1

    if-eq v1, v2, :cond_8

    .line 252
    const/4 v2, -0x2

    const/4 v3, 0x0

    if-ne v1, v2, :cond_3

    .line 253
    invoke-virtual {v0}, Landroid/media/MediaCodec;->getOutputFormat()Landroid/media/MediaFormat;

    move-result-object v2

    const-string v4, "encoder.outputFormat"

    invoke-static {v2, v4}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 254
    .local v2, "newFormat":Landroid/media/MediaFormat;
    nop

    .line 255
    :try_start_0
    iget-object v4, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->muxerLock:Ljava/lang/Object;

    monitor-enter v4
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    const/4 v5, 0x0

    .line 256
    .local v5, "$i$a$-synchronized-InspectMediaRecorderManager$drainAudioEncoder$1":I
    :try_start_1
    iget-object v6, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->muxer:Landroid/media/MediaMuxer;

    if-eqz v6, :cond_2

    iget-boolean v6, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->muxerStarted:Z

    if-nez v6, :cond_2

    .line 257
    iget-object v6, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->muxer:Landroid/media/MediaMuxer;

    if-nez v6, :cond_1

    const-string v6, "muxer"

    invoke-static {v6}, Lkotlin/jvm/internal/Intrinsics;->throwUninitializedPropertyAccessException(Ljava/lang/String;)V

    goto :goto_1

    :cond_1
    move-object v3, v6

    :goto_1
    invoke-virtual {v3, v2}, Landroid/media/MediaMuxer;->addTrack(Landroid/media/MediaFormat;)I

    move-result v3

    iput v3, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->audioTrackIndex:I

    .line 258
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->startMuxerIfReady()V

    goto :goto_2

    .line 260
    :cond_2
    iput-object v2, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->pendingAudioFormat:Landroid/media/MediaFormat;

    .line 262
    :goto_2
    nop

    .end local v5    # "$i$a$-synchronized-InspectMediaRecorderManager$drainAudioEncoder$1":I
    sget-object v3, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 255
    :try_start_2
    monitor-exit v4

    goto :goto_0

    :catchall_0
    move-exception v3

    monitor-exit v4

    .end local v0    # "encoder":Landroid/media/MediaCodec;
    .end local v1    # "outputBufferIndex":I
    .end local v2    # "newFormat":Landroid/media/MediaFormat;
    .end local p1    # "endOfStream":Z
    throw v3
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_0

    .line 263
    .restart local v0    # "encoder":Landroid/media/MediaCodec;
    .restart local v1    # "outputBufferIndex":I
    .restart local v2    # "newFormat":Landroid/media/MediaFormat;
    .restart local p1    # "endOfStream":Z
    :catch_0
    move-exception v3

    .line 264
    .local v3, "e":Ljava/lang/Exception;
    iget-object v4, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->TAG:Ljava/lang/String;

    const-string v5, "add audio track error"

    move-object v6, v3

    check-cast v6, Ljava/lang/Throwable;

    invoke-static {v4, v5, v6}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_0

    .line 267
    .end local v2    # "newFormat":Landroid/media/MediaFormat;
    .end local v3    # "e":Ljava/lang/Exception;
    :cond_3
    if-ltz v1, :cond_0

    .line 268
    invoke-virtual {v0, v1}, Landroid/media/MediaCodec;->getOutputBuffer(I)Ljava/nio/ByteBuffer;

    move-result-object v2

    if-nez v2, :cond_4

    goto :goto_0

    .line 269
    .local v2, "encodedData":Ljava/nio/ByteBuffer;
    :cond_4
    iget-object v4, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->audioBufferInfo:Landroid/media/MediaCodec$BufferInfo;

    iget v4, v4, Landroid/media/MediaCodec$BufferInfo;->size:I

    if-lez v4, :cond_6

    iget-boolean v4, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->muxerStarted:Z

    if-eqz v4, :cond_6

    .line 270
    iget-object v4, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->audioBufferInfo:Landroid/media/MediaCodec$BufferInfo;

    iget v4, v4, Landroid/media/MediaCodec$BufferInfo;->offset:I

    invoke-virtual {v2, v4}, Ljava/nio/ByteBuffer;->position(I)Ljava/nio/Buffer;

    .line 271
    iget-object v4, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->audioBufferInfo:Landroid/media/MediaCodec$BufferInfo;

    iget v4, v4, Landroid/media/MediaCodec$BufferInfo;->offset:I

    iget-object v5, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->audioBufferInfo:Landroid/media/MediaCodec$BufferInfo;

    iget v5, v5, Landroid/media/MediaCodec$BufferInfo;->size:I

    add-int/2addr v4, v5

    invoke-virtual {v2, v4}, Ljava/nio/ByteBuffer;->limit(I)Ljava/nio/Buffer;

    .line 272
    iget-object v4, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->muxer:Landroid/media/MediaMuxer;

    if-nez v4, :cond_5

    const-string v4, "muxer"

    invoke-static {v4}, Lkotlin/jvm/internal/Intrinsics;->throwUninitializedPropertyAccessException(Ljava/lang/String;)V

    goto :goto_3

    :cond_5
    move-object v3, v4

    :goto_3
    iget v4, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->audioTrackIndex:I

    iget-object v5, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->audioBufferInfo:Landroid/media/MediaCodec$BufferInfo;

    invoke-virtual {v3, v4, v2, v5}, Landroid/media/MediaMuxer;->writeSampleData(ILjava/nio/ByteBuffer;Landroid/media/MediaCodec$BufferInfo;)V

    .line 274
    :cond_6
    iget-object v3, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->audioBufferInfo:Landroid/media/MediaCodec$BufferInfo;

    iget v3, v3, Landroid/media/MediaCodec$BufferInfo;->flags:I

    and-int/lit8 v3, v3, 0x4

    const/4 v4, 0x0

    if-eqz v3, :cond_7

    const/4 v3, 0x1

    goto :goto_4

    :cond_7
    move v3, v4

    .line 275
    .local v3, "eos":Z
    :goto_4
    invoke-virtual {v0, v1, v4}, Landroid/media/MediaCodec;->releaseOutputBuffer(IZ)V

    .line 276
    if-nez v3, :cond_8

    if-eqz p1, :cond_0

    .line 280
    .end local v1    # "outputBufferIndex":I
    .end local v2    # "encodedData":Ljava/nio/ByteBuffer;
    .end local v3    # "eos":Z
    :cond_8
    return-void
.end method

.method private final drainVideoEncoder(Z)V
    .locals 7
    .param p1, "endOfStream"    # Z

    .line 208
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->videoEncoder:Landroid/media/MediaCodec;

    if-nez v0, :cond_0

    return-void

    .line 209
    .local v0, "encoder":Landroid/media/MediaCodec;
    :cond_0
    :goto_0
    nop

    .line 210
    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->videoBufferInfo:Landroid/media/MediaCodec$BufferInfo;

    const-wide/16 v2, 0x2710

    invoke-virtual {v0, v1, v2, v3}, Landroid/media/MediaCodec;->dequeueOutputBuffer(Landroid/media/MediaCodec$BufferInfo;J)I

    move-result v1

    .line 211
    .local v1, "outputBufferIndex":I
    nop

    .line 212
    const/4 v2, -0x1

    if-eq v1, v2, :cond_8

    .line 213
    const/4 v2, -0x2

    const/4 v3, 0x0

    if-ne v1, v2, :cond_3

    .line 214
    invoke-virtual {v0}, Landroid/media/MediaCodec;->getOutputFormat()Landroid/media/MediaFormat;

    move-result-object v2

    const-string v4, "encoder.outputFormat"

    invoke-static {v2, v4}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 215
    .local v2, "newFormat":Landroid/media/MediaFormat;
    nop

    .line 216
    :try_start_0
    iget-object v4, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->muxerLock:Ljava/lang/Object;

    monitor-enter v4
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    const/4 v5, 0x0

    .line 217
    .local v5, "$i$a$-synchronized-InspectMediaRecorderManager$drainVideoEncoder$1":I
    :try_start_1
    iget-object v6, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->muxer:Landroid/media/MediaMuxer;

    if-eqz v6, :cond_2

    iget-boolean v6, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->muxerStarted:Z

    if-nez v6, :cond_2

    .line 218
    iget-object v6, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->muxer:Landroid/media/MediaMuxer;

    if-nez v6, :cond_1

    const-string v6, "muxer"

    invoke-static {v6}, Lkotlin/jvm/internal/Intrinsics;->throwUninitializedPropertyAccessException(Ljava/lang/String;)V

    goto :goto_1

    :cond_1
    move-object v3, v6

    :goto_1
    invoke-virtual {v3, v2}, Landroid/media/MediaMuxer;->addTrack(Landroid/media/MediaFormat;)I

    move-result v3

    iput v3, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->videoTrackIndex:I

    .line 219
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->startMuxerIfReady()V

    goto :goto_2

    .line 221
    :cond_2
    iput-object v2, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->pendingVideoFormat:Landroid/media/MediaFormat;

    .line 223
    :goto_2
    nop

    .end local v5    # "$i$a$-synchronized-InspectMediaRecorderManager$drainVideoEncoder$1":I
    sget-object v3, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 216
    :try_start_2
    monitor-exit v4

    goto :goto_0

    :catchall_0
    move-exception v3

    monitor-exit v4

    .end local v0    # "encoder":Landroid/media/MediaCodec;
    .end local v1    # "outputBufferIndex":I
    .end local v2    # "newFormat":Landroid/media/MediaFormat;
    .end local p1    # "endOfStream":Z
    throw v3
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_0

    .line 224
    .restart local v0    # "encoder":Landroid/media/MediaCodec;
    .restart local v1    # "outputBufferIndex":I
    .restart local v2    # "newFormat":Landroid/media/MediaFormat;
    .restart local p1    # "endOfStream":Z
    :catch_0
    move-exception v3

    .line 225
    .local v3, "e":Ljava/lang/Exception;
    iget-object v4, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->TAG:Ljava/lang/String;

    const-string v5, "add video track error"

    move-object v6, v3

    check-cast v6, Ljava/lang/Throwable;

    invoke-static {v4, v5, v6}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_0

    .line 228
    .end local v2    # "newFormat":Landroid/media/MediaFormat;
    .end local v3    # "e":Ljava/lang/Exception;
    :cond_3
    if-ltz v1, :cond_0

    .line 229
    invoke-virtual {v0, v1}, Landroid/media/MediaCodec;->getOutputBuffer(I)Ljava/nio/ByteBuffer;

    move-result-object v2

    if-nez v2, :cond_4

    goto :goto_0

    .line 230
    .local v2, "encodedData":Ljava/nio/ByteBuffer;
    :cond_4
    iget-object v4, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->videoBufferInfo:Landroid/media/MediaCodec$BufferInfo;

    iget v4, v4, Landroid/media/MediaCodec$BufferInfo;->size:I

    if-lez v4, :cond_6

    iget-boolean v4, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->muxerStarted:Z

    if-eqz v4, :cond_6

    .line 231
    iget-object v4, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->videoBufferInfo:Landroid/media/MediaCodec$BufferInfo;

    iget v4, v4, Landroid/media/MediaCodec$BufferInfo;->offset:I

    invoke-virtual {v2, v4}, Ljava/nio/ByteBuffer;->position(I)Ljava/nio/Buffer;

    .line 232
    iget-object v4, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->videoBufferInfo:Landroid/media/MediaCodec$BufferInfo;

    iget v4, v4, Landroid/media/MediaCodec$BufferInfo;->offset:I

    iget-object v5, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->videoBufferInfo:Landroid/media/MediaCodec$BufferInfo;

    iget v5, v5, Landroid/media/MediaCodec$BufferInfo;->size:I

    add-int/2addr v4, v5

    invoke-virtual {v2, v4}, Ljava/nio/ByteBuffer;->limit(I)Ljava/nio/Buffer;

    .line 233
    iget-object v4, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->muxer:Landroid/media/MediaMuxer;

    if-nez v4, :cond_5

    const-string v4, "muxer"

    invoke-static {v4}, Lkotlin/jvm/internal/Intrinsics;->throwUninitializedPropertyAccessException(Ljava/lang/String;)V

    goto :goto_3

    :cond_5
    move-object v3, v4

    :goto_3
    iget v4, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->videoTrackIndex:I

    iget-object v5, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->videoBufferInfo:Landroid/media/MediaCodec$BufferInfo;

    invoke-virtual {v3, v4, v2, v5}, Landroid/media/MediaMuxer;->writeSampleData(ILjava/nio/ByteBuffer;Landroid/media/MediaCodec$BufferInfo;)V

    .line 235
    :cond_6
    iget-object v3, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->videoBufferInfo:Landroid/media/MediaCodec$BufferInfo;

    iget v3, v3, Landroid/media/MediaCodec$BufferInfo;->flags:I

    and-int/lit8 v3, v3, 0x4

    const/4 v4, 0x0

    if-eqz v3, :cond_7

    const/4 v3, 0x1

    goto :goto_4

    :cond_7
    move v3, v4

    .line 236
    .local v3, "eos":Z
    :goto_4
    invoke-virtual {v0, v1, v4}, Landroid/media/MediaCodec;->releaseOutputBuffer(IZ)V

    .line 237
    if-nez v3, :cond_8

    if-eqz p1, :cond_0

    .line 241
    .end local v1    # "outputBufferIndex":I
    .end local v2    # "encodedData":Ljava/nio/ByteBuffer;
    .end local v3    # "eos":Z
    :cond_8
    return-void
.end method

.method private static final encodeAudioFrame$lambda$2(Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;[B)V
    .locals 14
    .param p0, "this$0"    # Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;
    .param p1, "$pcm"    # [B

    const-string/jumbo v0, "this$0"

    invoke-static {p0, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "$pcm"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 164
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->ensureAudioEncoder()V

    .line 165
    nop

    .line 166
    :try_start_0
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->audioEncoder:Landroid/media/MediaCodec;

    if-nez v0, :cond_0

    return-void

    .line 167
    .local v0, "encoder":Landroid/media/MediaCodec;
    :cond_0
    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->audioRemain:[B

    array-length v1, v1

    array-length v2, p1

    add-int/2addr v1, v2

    new-array v1, v1, [B

    move-object v8, v1

    .line 168
    .local v8, "merged":[B
    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->audioRemain:[B

    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->audioRemain:[B

    array-length v2, v2

    const/4 v9, 0x0

    invoke-static {v1, v9, v8, v9, v2}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 169
    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->audioRemain:[B

    array-length v1, v1

    array-length v2, p1

    invoke-static {p1, v9, v8, v1, v2}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 170
    const/4 v1, 0x0

    move v10, v1

    .line 171
    .local v10, "cursor":I
    :goto_0
    array-length v1, v8

    sub-int/2addr v1, v10

    iget v2, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->aacFrameBytes:I

    if-lt v1, v2, :cond_4

    .line 172
    const-wide/16 v1, 0x2710

    invoke-virtual {v0, v1, v2}, Landroid/media/MediaCodec;->dequeueInputBuffer(J)I

    move-result v1

    move v11, v1

    .line 173
    .local v11, "inputBufferIndex":I
    if-ltz v11, :cond_3

    .line 174
    invoke-virtual {v0, v11}, Landroid/media/MediaCodec;->getInputBuffer(I)Ljava/nio/ByteBuffer;

    move-result-object v1

    if-nez v1, :cond_1

    goto :goto_2

    :cond_1
    move-object v12, v1

    .line 175
    .local v12, "inputBuffer":Ljava/nio/ByteBuffer;
    invoke-virtual {v12}, Ljava/nio/ByteBuffer;->clear()Ljava/nio/Buffer;

    .line 176
    invoke-virtual {v12}, Ljava/nio/ByteBuffer;->capacity()I

    move-result v1

    iget v2, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->aacFrameBytes:I

    if-lt v1, v2, :cond_2

    iget v1, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->aacFrameBytes:I

    goto :goto_1

    :cond_2
    invoke-virtual {v12}, Ljava/nio/ByteBuffer;->capacity()I

    move-result v1

    :goto_1
    move v13, v1

    .line 177
    .local v13, "writeBytes":I
    invoke-virtual {v12, v8, v10, v13}, Ljava/nio/ByteBuffer;->put([BII)Ljava/nio/ByteBuffer;

    .line 178
    nop

    .line 179
    nop

    .line 180
    nop

    .line 181
    nop

    .line 182
    iget-wide v5, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->audioPtsUs:J

    .line 183
    nop

    .line 178
    const/4 v3, 0x0

    const/4 v7, 0x0

    move-object v1, v0

    move v2, v11

    move v4, v13

    invoke-virtual/range {v1 .. v7}, Landroid/media/MediaCodec;->queueInputBuffer(IIIJI)V

    .line 185
    iget-wide v1, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->audioPtsUs:J

    iget v3, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->aacFrameSamples:I

    int-to-long v3, v3

    const-wide/32 v5, 0xf4240

    mul-long/2addr v3, v5

    iget v5, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->sampleRate:I

    int-to-long v5, v5

    div-long/2addr v3, v5

    add-long/2addr v1, v3

    iput-wide v1, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->audioPtsUs:J

    .line 186
    add-int/2addr v10, v13

    .end local v12    # "inputBuffer":Ljava/nio/ByteBuffer;
    .end local v13    # "writeBytes":I
    goto :goto_0

    .line 188
    :cond_3
    nop

    .line 191
    .end local v11    # "inputBufferIndex":I
    :cond_4
    :goto_2
    array-length v1, v8

    sub-int/2addr v1, v10

    .line 192
    .local v1, "remainSize":I
    if-lez v1, :cond_5

    .line 193
    new-array v2, v1, [B

    .line 194
    .local v2, "rem":[B
    invoke-static {v8, v10, v2, v9, v1}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 195
    nop

    .end local v2    # "rem":[B
    goto :goto_3

    .line 196
    :cond_5
    new-array v2, v9, [B

    .line 192
    :goto_3
    iput-object v2, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->audioRemain:[B

    .line 197
    invoke-direct {p0, v9}, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->drainAudioEncoder(Z)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .end local v0    # "encoder":Landroid/media/MediaCodec;
    .end local v1    # "remainSize":I
    .end local v8    # "merged":[B
    .end local v10    # "cursor":I
    goto :goto_4

    .line 198
    :catch_0
    move-exception v0

    .line 199
    .local v0, "e":Ljava/lang/Exception;
    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->TAG:Ljava/lang/String;

    const-string v2, "encodeAudioFrame error"

    move-object v3, v0

    check-cast v3, Ljava/lang/Throwable;

    invoke-static {v1, v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 201
    .end local v0    # "e":Ljava/lang/Exception;
    :goto_4
    return-void
.end method

.method private static final encodeVideoFrame$lambda$1(Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;[B)V
    .locals 14
    .param p0, "this$0"    # Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;
    .param p1, "$nv21"    # [B

    const-string/jumbo v0, "this$0"

    invoke-static {p0, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "$nv21"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 131
    nop

    .line 132
    :try_start_0
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->videoEncoder:Landroid/media/MediaCodec;

    if-nez v0, :cond_0

    return-void

    .line 133
    .local v0, "encoder":Landroid/media/MediaCodec;
    :cond_0
    const-wide/16 v1, 0x2710

    invoke-virtual {v0, v1, v2}, Landroid/media/MediaCodec;->dequeueInputBuffer(J)I

    move-result v1

    move v8, v1

    .line 134
    .local v8, "inputBufferIndex":I
    if-ltz v8, :cond_4

    .line 135
    invoke-virtual {v0, v8}, Landroid/media/MediaCodec;->getInputBuffer(I)Ljava/nio/ByteBuffer;

    move-result-object v1

    if-nez v1, :cond_1

    return-void

    :cond_1
    move-object v9, v1

    .line 136
    .local v9, "inputBuffer":Ljava/nio/ByteBuffer;
    invoke-virtual {v9}, Ljava/nio/ByteBuffer;->clear()Ljava/nio/Buffer;

    .line 138
    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->yuvTemp:[B

    iget v2, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->width:I

    iget v3, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->height:I

    invoke-direct {p0, p1, v1, v2, v3}, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->nv21ToNv12([B[BII)V

    .line 139
    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->yuvTemp:[B

    invoke-virtual {v9, v1}, Ljava/nio/ByteBuffer;->put([B)Ljava/nio/ByteBuffer;

    .line 140
    invoke-static {}, Ljava/lang/System;->nanoTime()J

    move-result-wide v1

    const/16 v3, 0x3e8

    int-to-long v3, v3

    div-long/2addr v1, v3

    move-wide v10, v1

    .line 141
    .local v10, "nowUs":J
    iget-wide v1, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->startTimeUs:J

    const-wide/16 v3, 0x0

    cmp-long v1, v1, v3

    if-gez v1, :cond_2

    iput-wide v10, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->startTimeUs:J

    .line 142
    :cond_2
    iget-wide v1, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->startTimeUs:J

    sub-long v12, v10, v1

    .line 143
    .local v12, "wallUs":J
    iget-wide v1, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->videoPtsUs:J

    cmp-long v1, v12, v1

    if-gtz v1, :cond_3

    iget-wide v1, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->videoPtsUs:J

    iget-wide v3, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->frameDurationUs:J

    add-long/2addr v1, v3

    goto :goto_0

    :cond_3
    move-wide v1, v12

    :goto_0
    iput-wide v1, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->videoPtsUs:J

    .line 144
    nop

    .line 145
    nop

    .line 146
    nop

    .line 147
    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->yuvTemp:[B

    array-length v4, v1

    .line 148
    iget-wide v5, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->videoPtsUs:J

    .line 149
    nop

    .line 144
    const/4 v3, 0x0

    const/4 v7, 0x0

    move-object v1, v0

    move v2, v8

    invoke-virtual/range {v1 .. v7}, Landroid/media/MediaCodec;->queueInputBuffer(IIIJI)V

    .line 152
    .end local v9    # "inputBuffer":Ljava/nio/ByteBuffer;
    .end local v10    # "nowUs":J
    .end local v12    # "wallUs":J
    :cond_4
    const/4 v1, 0x0

    invoke-direct {p0, v1}, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->drainVideoEncoder(Z)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .end local v0    # "encoder":Landroid/media/MediaCodec;
    .end local v8    # "inputBufferIndex":I
    goto :goto_1

    .line 153
    :catch_0
    move-exception v0

    .line 154
    .local v0, "e":Ljava/lang/Exception;
    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->TAG:Ljava/lang/String;

    const-string v2, "encodeVideoFrame error"

    move-object v3, v0

    check-cast v3, Ljava/lang/Throwable;

    invoke-static {v1, v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 156
    .end local v0    # "e":Ljava/lang/Exception;
    :goto_1
    return-void
.end method

.method private final ensureAudioEncoder()V
    .locals 4

    .line 107
    const-string v0, "audio/mp4a-latm"

    iget-boolean v1, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->audioReady:Z

    if-eqz v1, :cond_0

    return-void

    .line 108
    :cond_0
    nop

    .line 109
    :try_start_0
    iget v1, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->sampleRate:I

    iget v2, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->channelCount:I

    invoke-static {v0, v1, v2}, Landroid/media/MediaFormat;->createAudioFormat(Ljava/lang/String;II)Landroid/media/MediaFormat;

    move-result-object v1

    const-string v2, "createAudioFormat(MediaF\u2026sampleRate, channelCount)"

    invoke-static {v1, v2}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 110
    .local v1, "audioFormat":Landroid/media/MediaFormat;
    const-string v2, "aac-profile"

    const/4 v3, 0x2

    invoke-virtual {v1, v2, v3}, Landroid/media/MediaFormat;->setInteger(Ljava/lang/String;I)V

    .line 111
    const-string v2, "bitrate"

    const v3, 0xfa00

    invoke-virtual {v1, v2, v3}, Landroid/media/MediaFormat;->setInteger(Ljava/lang/String;I)V

    .line 112
    const-string v2, "max-input-size"

    iget v3, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->aacFrameBytes:I

    invoke-virtual {v1, v2, v3}, Landroid/media/MediaFormat;->setInteger(Ljava/lang/String;I)V

    .line 114
    invoke-static {v0}, Landroid/media/MediaCodec;->createEncoderByType(Ljava/lang/String;)Landroid/media/MediaCodec;

    move-result-object v0

    iput-object v0, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->audioEncoder:Landroid/media/MediaCodec;

    .line 115
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->audioEncoder:Landroid/media/MediaCodec;

    const/4 v2, 0x1

    if-eqz v0, :cond_1

    const/4 v3, 0x0

    invoke-virtual {v0, v1, v3, v3, v2}, Landroid/media/MediaCodec;->configure(Landroid/media/MediaFormat;Landroid/view/Surface;Landroid/media/MediaCrypto;I)V

    .line 116
    :cond_1
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->audioEncoder:Landroid/media/MediaCodec;

    if-eqz v0, :cond_2

    invoke-virtual {v0}, Landroid/media/MediaCodec;->start()V

    .line 117
    :cond_2
    iput-boolean v2, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->audioReady:Z

    .line 118
    const-wide/16 v2, 0x0

    iput-wide v2, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->audioPtsUs:J

    .line 120
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->TAG:Ljava/lang/String;

    const-string v2, "Audio encoder started"

    invoke-static {v0, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 121
    .end local v1    # "audioFormat":Landroid/media/MediaFormat;
    :catch_0
    move-exception v0

    .line 122
    .local v0, "e":Ljava/lang/Exception;
    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->TAG:Ljava/lang/String;

    const-string v2, "Failed to start audio encoder"

    move-object v3, v0

    check-cast v3, Ljava/lang/Throwable;

    invoke-static {v1, v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 124
    .end local v0    # "e":Ljava/lang/Exception;
    :goto_0
    return-void
.end method

.method private final nv21ToNv12([B[BII)V
    .locals 4
    .param p1, "nv21"    # [B
    .param p2, "nv12"    # [B
    .param p3, "width"    # I
    .param p4, "height"    # I

    .line 396
    mul-int v0, p3, p4

    .line 397
    .local v0, "frameSize":I
    const/4 v1, 0x0

    invoke-static {p1, v1, p2, v1, v0}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 398
    const/4 v1, 0x0

    .line 399
    .local v1, "i":I
    :goto_0
    div-int/lit8 v2, v0, 0x2

    if-ge v1, v2, :cond_0

    .line 400
    add-int v2, v0, v1

    add-int v3, v0, v1

    add-int/lit8 v3, v3, 0x1

    aget-byte v3, p1, v3

    aput-byte v3, p2, v2

    .line 401
    add-int v2, v0, v1

    add-int/lit8 v2, v2, 0x1

    add-int v3, v0, v1

    aget-byte v3, p1, v3

    aput-byte v3, p2, v2

    add-int/lit8 v1, v1, 0x2

    .line 402
    goto :goto_0

    .line 404
    :cond_0
    return-void
.end method

.method private final startMuxerIfReady()V
    .locals 7

    .line 286
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->muxerLock:Ljava/lang/Object;

    monitor-enter v0

    const/4 v1, 0x0

    .line 287
    .local v1, "$i$a$-synchronized-InspectMediaRecorderManager$startMuxerIfReady$1":I
    :try_start_0
    iget-boolean v2, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->muxerStarted:Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-eqz v2, :cond_0

    .end local v1    # "$i$a$-synchronized-InspectMediaRecorderManager$startMuxerIfReady$1":I
    monitor-exit v0

    return-void

    .line 288
    .restart local v1    # "$i$a$-synchronized-InspectMediaRecorderManager$startMuxerIfReady$1":I
    :cond_0
    :try_start_1
    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->muxer:Landroid/media/MediaMuxer;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    if-nez v2, :cond_1

    .end local v1    # "$i$a$-synchronized-InspectMediaRecorderManager$startMuxerIfReady$1":I
    monitor-exit v0

    return-void

    .line 289
    .restart local v1    # "$i$a$-synchronized-InspectMediaRecorderManager$startMuxerIfReady$1":I
    :cond_1
    :try_start_2
    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->pendingVideoFormat:Landroid/media/MediaFormat;

    const/4 v3, 0x0

    if-eqz v2, :cond_3

    iget v2, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->videoTrackIndex:I
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    if-gez v2, :cond_3

    .line 290
    nop

    .line 291
    :try_start_3
    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->muxer:Landroid/media/MediaMuxer;

    if-nez v2, :cond_2

    const-string v2, "muxer"

    invoke-static {v2}, Lkotlin/jvm/internal/Intrinsics;->throwUninitializedPropertyAccessException(Ljava/lang/String;)V

    move-object v2, v3

    :cond_2
    iget-object v4, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->pendingVideoFormat:Landroid/media/MediaFormat;

    invoke-static {v4}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;)V

    invoke-virtual {v2, v4}, Landroid/media/MediaMuxer;->addTrack(Landroid/media/MediaFormat;)I

    move-result v2

    iput v2, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->videoTrackIndex:I
    :try_end_3
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_0
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    goto :goto_0

    .line 292
    :catch_0
    move-exception v2

    .line 294
    :goto_0
    :try_start_4
    iput-object v3, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->pendingVideoFormat:Landroid/media/MediaFormat;

    .line 296
    :cond_3
    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->pendingAudioFormat:Landroid/media/MediaFormat;

    if-eqz v2, :cond_5

    iget v2, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->audioTrackIndex:I
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    if-gez v2, :cond_5

    .line 297
    nop

    .line 298
    :try_start_5
    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->muxer:Landroid/media/MediaMuxer;

    if-nez v2, :cond_4

    const-string v2, "muxer"

    invoke-static {v2}, Lkotlin/jvm/internal/Intrinsics;->throwUninitializedPropertyAccessException(Ljava/lang/String;)V

    move-object v2, v3

    :cond_4
    iget-object v4, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->pendingAudioFormat:Landroid/media/MediaFormat;

    invoke-static {v4}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;)V

    invoke-virtual {v2, v4}, Landroid/media/MediaMuxer;->addTrack(Landroid/media/MediaFormat;)I

    move-result v2

    iput v2, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->audioTrackIndex:I
    :try_end_5
    .catch Ljava/lang/Exception; {:try_start_5 .. :try_end_5} :catch_1
    .catchall {:try_start_5 .. :try_end_5} :catchall_0

    goto :goto_1

    .line 299
    :catch_1
    move-exception v2

    .line 301
    :goto_1
    :try_start_6
    iput-object v3, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->pendingAudioFormat:Landroid/media/MediaFormat;

    .line 303
    :cond_5
    iget v2, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->videoTrackIndex:I

    const/4 v4, 0x1

    if-ltz v2, :cond_6

    iget v2, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->audioTrackIndex:I

    if-gez v2, :cond_8

    .line 304
    :cond_6
    iget v2, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->videoTrackIndex:I

    if-ltz v2, :cond_7

    iget-boolean v2, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->audioReady:Z

    if-eqz v2, :cond_8

    .line 305
    :cond_7
    iget v2, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->audioTrackIndex:I

    if-ltz v2, :cond_9

    iget-boolean v2, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->videoReady:Z
    :try_end_6
    .catchall {:try_start_6 .. :try_end_6} :catchall_0

    if-nez v2, :cond_9

    :cond_8
    move v2, v4

    goto :goto_2

    :cond_9
    const/4 v2, 0x0

    .line 303
    :goto_2
    nop

    .line 306
    .local v2, "canStart":Z
    if-eqz v2, :cond_b

    .line 307
    nop

    .line 308
    :try_start_7
    iget-object v5, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->muxer:Landroid/media/MediaMuxer;

    if-nez v5, :cond_a

    const-string v5, "muxer"

    invoke-static {v5}, Lkotlin/jvm/internal/Intrinsics;->throwUninitializedPropertyAccessException(Ljava/lang/String;)V

    goto :goto_3

    :cond_a
    move-object v3, v5

    :goto_3
    invoke-virtual {v3}, Landroid/media/MediaMuxer;->start()V

    .line 309
    iput-boolean v4, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->muxerStarted:Z

    .line 310
    iget-object v3, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->TAG:Ljava/lang/String;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "Muxer started (video="

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    iget v5, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->videoTrackIndex:I

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, ", audio="

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    iget v5, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->audioTrackIndex:I

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    const/16 v5, 0x29

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_7
    .catch Ljava/lang/Exception; {:try_start_7 .. :try_end_7} :catch_2
    .catchall {:try_start_7 .. :try_end_7} :catchall_0

    goto :goto_4

    .line 311
    :catch_2
    move-exception v3

    .line 312
    .local v3, "e":Ljava/lang/Exception;
    :try_start_8
    iget-object v4, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->TAG:Ljava/lang/String;

    const-string v5, "Muxer start error"

    move-object v6, v3

    check-cast v6, Ljava/lang/Throwable;

    invoke-static {v4, v5, v6}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 315
    .end local v3    # "e":Ljava/lang/Exception;
    :cond_b
    :goto_4
    nop

    .end local v1    # "$i$a$-synchronized-InspectMediaRecorderManager$startMuxerIfReady$1":I
    .end local v2    # "canStart":Z
    sget-object v1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;
    :try_end_8
    .catchall {:try_start_8 .. :try_end_8} :catchall_0

    .line 286
    monitor-exit v0

    .line 316
    return-void

    .line 286
    :catchall_0
    move-exception v1

    monitor-exit v0

    throw v1
.end method

.method private static final stop$lambda$9(Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;Lkotlin/jvm/functions/Function1;)V
    .locals 21
    .param p0, "this$0"    # Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;
    .param p1, "$onStopped"    # Lkotlin/jvm/functions/Function1;

    move-object/from16 v1, p0

    move-object/from16 v2, p1

    const-string/jumbo v0, "this$0"

    invoke-static {v1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "$onStopped"

    invoke-static {v2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 320
    nop

    .line 321
    nop

    .line 322
    const-wide/16 v3, 0x2710

    const/4 v5, 0x1

    :try_start_0
    iget-object v0, v1, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->audioEncoder:Landroid/media/MediaCodec;

    if-eqz v0, :cond_6

    .local v0, "enc":Landroid/media/MediaCodec;
    const/4 v13, 0x0

    .line 323
    .local v13, "$i$a$-let-InspectMediaRecorderManager$stop$1$1":I
    iget-object v6, v1, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->audioRemain:[B

    array-length v6, v6

    const/4 v14, 0x0

    if-nez v6, :cond_0

    move v6, v5

    goto :goto_0

    :cond_0
    move v6, v14

    :goto_0
    xor-int/2addr v6, v5

    if-eqz v6, :cond_5

    .line 324
    iget v6, v1, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->aacFrameBytes:I

    new-array v6, v6, [B

    move-object v15, v6

    .line 325
    .local v15, "pad":[B
    iget-object v6, v1, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->audioRemain:[B

    array-length v6, v6

    iget v7, v1, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->aacFrameBytes:I

    if-ge v6, v7, :cond_1

    iget-object v6, v1, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->audioRemain:[B

    array-length v6, v6

    goto :goto_1

    :cond_1
    iget v6, v1, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->aacFrameBytes:I

    :goto_1
    move v12, v6

    .line 326
    .local v12, "copySize":I
    iget-object v6, v1, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->audioRemain:[B

    invoke-static {v6, v14, v15, v14, v12}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 327
    invoke-virtual {v0, v3, v4}, Landroid/media/MediaCodec;->dequeueInputBuffer(J)I

    move-result v6

    move v10, v6

    .line 328
    .local v10, "idx":I
    if-ltz v10, :cond_4

    .line 329
    invoke-virtual {v0, v10}, Landroid/media/MediaCodec;->getInputBuffer(I)Ljava/nio/ByteBuffer;

    move-result-object v6

    move-object v11, v6

    .line 330
    .local v11, "ib":Ljava/nio/ByteBuffer;
    if-eqz v11, :cond_2

    invoke-virtual {v11}, Ljava/nio/ByteBuffer;->clear()Ljava/nio/Buffer;

    .line 331
    :cond_2
    if-eqz v11, :cond_3

    iget v6, v1, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->aacFrameBytes:I

    invoke-virtual {v11, v15, v14, v6}, Ljava/nio/ByteBuffer;->put([BII)Ljava/nio/ByteBuffer;

    .line 332
    :cond_3
    iget v9, v1, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->aacFrameBytes:I

    iget-wide v7, v1, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->audioPtsUs:J

    const/16 v16, 0x0

    const/16 v17, 0x0

    move-object v6, v0

    move-wide/from16 v18, v7

    move v7, v10

    move/from16 v8, v17

    move/from16 v17, v10

    move-object/from16 v20, v11

    .end local v10    # "idx":I
    .end local v11    # "ib":Ljava/nio/ByteBuffer;
    .local v17, "idx":I
    .local v20, "ib":Ljava/nio/ByteBuffer;
    move-wide/from16 v10, v18

    move/from16 v18, v12

    .end local v12    # "copySize":I
    .local v18, "copySize":I
    move/from16 v12, v16

    invoke-virtual/range {v6 .. v12}, Landroid/media/MediaCodec;->queueInputBuffer(IIIJI)V

    .line 333
    iget-wide v6, v1, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->audioPtsUs:J

    iget v8, v1, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->aacFrameSamples:I

    int-to-long v8, v8

    const-wide/32 v10, 0xf4240

    mul-long/2addr v8, v10

    iget v10, v1, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->sampleRate:I

    int-to-long v10, v10

    div-long/2addr v8, v10

    add-long/2addr v6, v8

    iput-wide v6, v1, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->audioPtsUs:J

    goto :goto_2

    .line 328
    .end local v17    # "idx":I
    .end local v18    # "copySize":I
    .end local v20    # "ib":Ljava/nio/ByteBuffer;
    .restart local v10    # "idx":I
    .restart local v12    # "copySize":I
    :cond_4
    move/from16 v17, v10

    move/from16 v18, v12

    .line 335
    .end local v10    # "idx":I
    .end local v12    # "copySize":I
    .restart local v17    # "idx":I
    .restart local v18    # "copySize":I
    :goto_2
    new-array v6, v14, [B

    iput-object v6, v1, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->audioRemain:[B
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 337
    .end local v15    # "pad":[B
    .end local v17    # "idx":I
    .end local v18    # "copySize":I
    :cond_5
    nop

    .line 322
    .end local v0    # "enc":Landroid/media/MediaCodec;
    .end local v13    # "$i$a$-let-InspectMediaRecorderManager$stop$1$1":I
    :cond_6
    goto :goto_3

    .line 338
    :catch_0
    move-exception v0

    .line 339
    :goto_3
    nop

    .line 340
    :try_start_1
    iget-object v0, v1, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->videoEncoder:Landroid/media/MediaCodec;

    if-eqz v0, :cond_9

    .restart local v0    # "enc":Landroid/media/MediaCodec;
    const/4 v13, 0x0

    .line 341
    .local v13, "$i$a$-let-InspectMediaRecorderManager$stop$1$2":I
    invoke-virtual {v0, v3, v4}, Landroid/media/MediaCodec;->dequeueInputBuffer(J)I

    move-result v6

    move v14, v6

    .line 342
    .local v14, "idx":I
    if-ltz v14, :cond_8

    .line 343
    invoke-virtual {v0, v14}, Landroid/media/MediaCodec;->getInputBuffer(I)Ljava/nio/ByteBuffer;

    move-result-object v6

    move-object v15, v6

    .line 344
    .local v15, "ib":Ljava/nio/ByteBuffer;
    if-eqz v15, :cond_7

    invoke-virtual {v15}, Ljava/nio/ByteBuffer;->clear()Ljava/nio/Buffer;

    .line 345
    :cond_7
    iget-wide v10, v1, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->videoPtsUs:J

    const/4 v12, 0x4

    const/4 v8, 0x0

    const/4 v9, 0x0

    move-object v6, v0

    move v7, v14

    invoke-virtual/range {v6 .. v12}, Landroid/media/MediaCodec;->queueInputBuffer(IIIJI)V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_1

    .line 347
    .end local v15    # "ib":Ljava/nio/ByteBuffer;
    :cond_8
    nop

    .line 340
    .end local v0    # "enc":Landroid/media/MediaCodec;
    .end local v13    # "$i$a$-let-InspectMediaRecorderManager$stop$1$2":I
    .end local v14    # "idx":I
    :cond_9
    goto :goto_4

    .line 348
    :catch_1
    move-exception v0

    .line 349
    :goto_4
    nop

    .line 350
    :try_start_2
    iget-object v0, v1, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->audioEncoder:Landroid/media/MediaCodec;

    if-eqz v0, :cond_c

    .restart local v0    # "enc":Landroid/media/MediaCodec;
    const/4 v13, 0x0

    .line 351
    .local v13, "$i$a$-let-InspectMediaRecorderManager$stop$1$3":I
    invoke-virtual {v0, v3, v4}, Landroid/media/MediaCodec;->dequeueInputBuffer(J)I

    move-result v3

    .line 352
    .local v3, "idx":I
    if-ltz v3, :cond_b

    .line 353
    invoke-virtual {v0, v3}, Landroid/media/MediaCodec;->getInputBuffer(I)Ljava/nio/ByteBuffer;

    move-result-object v4

    .line 354
    .local v4, "ib":Ljava/nio/ByteBuffer;
    if-eqz v4, :cond_a

    invoke-virtual {v4}, Ljava/nio/ByteBuffer;->clear()Ljava/nio/Buffer;

    .line 355
    :cond_a
    iget-wide v10, v1, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->audioPtsUs:J

    const/4 v12, 0x4

    const/4 v8, 0x0

    const/4 v9, 0x0

    move-object v6, v0

    move v7, v3

    invoke-virtual/range {v6 .. v12}, Landroid/media/MediaCodec;->queueInputBuffer(IIIJI)V
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_2

    .line 357
    .end local v4    # "ib":Ljava/nio/ByteBuffer;
    :cond_b
    nop

    .line 350
    .end local v0    # "enc":Landroid/media/MediaCodec;
    .end local v3    # "idx":I
    .end local v13    # "$i$a$-let-InspectMediaRecorderManager$stop$1$3":I
    :cond_c
    goto :goto_5

    .line 358
    :catch_2
    move-exception v0

    .line 359
    :goto_5
    :try_start_3
    invoke-direct {v1, v5}, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->drainVideoEncoder(Z)V

    .line 360
    invoke-direct {v1, v5}, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->drainAudioEncoder(Z)V
    :try_end_3
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_3

    goto :goto_6

    .line 361
    :catch_3
    move-exception v0

    .line 362
    .local v0, "e":Ljava/lang/Exception;
    iget-object v3, v1, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->TAG:Ljava/lang/String;

    const-string v4, "drain error during stop"

    move-object v5, v0

    check-cast v5, Ljava/lang/Throwable;

    invoke-static {v3, v4, v5}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 365
    .end local v0    # "e":Ljava/lang/Exception;
    :goto_6
    nop

    .line 366
    const/4 v3, 0x0

    :try_start_4
    iget-object v0, v1, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->videoEncoder:Landroid/media/MediaCodec;

    if-eqz v0, :cond_d

    invoke-virtual {v0}, Landroid/media/MediaCodec;->stop()V

    .line 367
    :cond_d
    iget-object v0, v1, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->videoEncoder:Landroid/media/MediaCodec;

    if-eqz v0, :cond_e

    invoke-virtual {v0}, Landroid/media/MediaCodec;->release()V

    .line 368
    :cond_e
    iput-object v3, v1, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->videoEncoder:Landroid/media/MediaCodec;
    :try_end_4
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_4} :catch_4

    goto :goto_7

    .line 369
    :catch_4
    move-exception v0

    .line 370
    .restart local v0    # "e":Ljava/lang/Exception;
    iget-object v4, v1, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->TAG:Ljava/lang/String;

    const-string v5, "release video error"

    move-object v6, v0

    check-cast v6, Ljava/lang/Throwable;

    invoke-static {v4, v5, v6}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 373
    .end local v0    # "e":Ljava/lang/Exception;
    :goto_7
    nop

    .line 374
    :try_start_5
    iget-object v0, v1, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->audioEncoder:Landroid/media/MediaCodec;

    if-eqz v0, :cond_f

    invoke-virtual {v0}, Landroid/media/MediaCodec;->stop()V

    .line 375
    :cond_f
    iget-object v0, v1, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->audioEncoder:Landroid/media/MediaCodec;

    if-eqz v0, :cond_10

    invoke-virtual {v0}, Landroid/media/MediaCodec;->release()V

    .line 376
    :cond_10
    iput-object v3, v1, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->audioEncoder:Landroid/media/MediaCodec;
    :try_end_5
    .catch Ljava/lang/Exception; {:try_start_5 .. :try_end_5} :catch_5

    goto :goto_8

    .line 377
    :catch_5
    move-exception v0

    .line 378
    .restart local v0    # "e":Ljava/lang/Exception;
    iget-object v4, v1, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->TAG:Ljava/lang/String;

    const-string v5, "release audio error"

    move-object v6, v0

    check-cast v6, Ljava/lang/Throwable;

    invoke-static {v4, v5, v6}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 381
    .end local v0    # "e":Ljava/lang/Exception;
    :goto_8
    nop

    .line 382
    :try_start_6
    iget-boolean v0, v1, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->muxerStarted:Z
    :try_end_6
    .catch Ljava/lang/Exception; {:try_start_6 .. :try_end_6} :catch_6

    const-string v4, "muxer"

    if-eqz v0, :cond_12

    :try_start_7
    iget-object v0, v1, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->muxer:Landroid/media/MediaMuxer;

    if-nez v0, :cond_11

    invoke-static {v4}, Lkotlin/jvm/internal/Intrinsics;->throwUninitializedPropertyAccessException(Ljava/lang/String;)V

    move-object v0, v3

    :cond_11
    invoke-virtual {v0}, Landroid/media/MediaMuxer;->stop()V

    .line 383
    :cond_12
    iget-object v0, v1, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->muxer:Landroid/media/MediaMuxer;

    if-nez v0, :cond_13

    invoke-static {v4}, Lkotlin/jvm/internal/Intrinsics;->throwUninitializedPropertyAccessException(Ljava/lang/String;)V

    goto :goto_9

    :cond_13
    move-object v3, v0

    :goto_9
    invoke-virtual {v3}, Landroid/media/MediaMuxer;->release()V
    :try_end_7
    .catch Ljava/lang/Exception; {:try_start_7 .. :try_end_7} :catch_6

    goto :goto_a

    .line 384
    :catch_6
    move-exception v0

    .line 385
    .restart local v0    # "e":Ljava/lang/Exception;
    iget-object v3, v1, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->TAG:Ljava/lang/String;

    const-string v4, "muxer release error"

    move-object v5, v0

    check-cast v5, Ljava/lang/Throwable;

    invoke-static {v3, v4, v5}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 388
    .end local v0    # "e":Ljava/lang/Exception;
    :goto_a
    iget-object v0, v1, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->outputPath:Ljava/lang/String;

    invoke-interface {v2, v0}, Lkotlin/jvm/functions/Function1;->invoke(Ljava/lang/Object;)Ljava/lang/Object;

    .line 389
    return-void
.end method


# virtual methods
.method public final encodeAudioFrame([B)V
    .locals 2
    .param p1, "pcm"    # [B

    const-string v0, "pcm"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 163
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->encodeHandler:Landroid/os/Handler;

    new-instance v1, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager$$ExternalSyntheticLambda0;

    invoke-direct {v1, p0, p1}, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager$$ExternalSyntheticLambda0;-><init>(Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;[B)V

    invoke-virtual {v0, v1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    .line 202
    return-void
.end method

.method public final encodeVideoFrame([B)V
    .locals 2
    .param p1, "nv21"    # [B

    const-string v0, "nv21"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 130
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->encodeHandler:Landroid/os/Handler;

    new-instance v1, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager$$ExternalSyntheticLambda1;

    invoke-direct {v1, p0, p1}, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager$$ExternalSyntheticLambda1;-><init>(Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;[B)V

    invoke-virtual {v0, v1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    .line 157
    return-void
.end method

.method public final getOutputPath()Ljava/lang/String;
    .locals 1

    .line 101
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->outputPath:Ljava/lang/String;

    return-object v0
.end method

.method public final stop(Lkotlin/jvm/functions/Function1;)V
    .locals 2
    .param p1, "onStopped"    # Lkotlin/jvm/functions/Function1;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lkotlin/jvm/functions/Function1<",
            "-",
            "Ljava/lang/String;",
            "Lkotlin/Unit;",
            ">;)V"
        }
    .end annotation

    const-string v0, "onStopped"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 319
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;->encodeHandler:Landroid/os/Handler;

    new-instance v1, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager$$ExternalSyntheticLambda2;

    invoke-direct {v1, p0, p1}, Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager$$ExternalSyntheticLambda2;-><init>(Lcom/rokid/security/phone/sdk/server/inspection/InspectMediaRecorderManager;Lkotlin/jvm/functions/Function1;)V

    invoke-virtual {v0, v1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    .line 390
    return-void
.end method
