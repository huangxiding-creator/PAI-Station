.class public final Lcom/rokid/security/phone/sdk/server/inspection/Offline/OfflineAudioRecorder;
.super Ljava/lang/Object;
.source "OfflineAudioRecorder.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u00008\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0000\n\u0002\u0010\u0008\n\u0002\u0008\u0004\n\u0002\u0010\u000e\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0012\n\u0002\u0008\u0002\n\u0002\u0010\u0002\n\u0002\u0008\u0006\u0018\u00002\u00020\u0001B#\u0012\u0008\u0008\u0002\u0010\u0002\u001a\u00020\u0003\u0012\u0008\u0008\u0002\u0010\u0004\u001a\u00020\u0003\u0012\u0008\u0008\u0002\u0010\u0005\u001a\u00020\u0003\u00a2\u0006\u0002\u0010\u0006J \u0010\u000f\u001a\u00020\u00102\u0006\u0010\u0011\u001a\u00020\u00032\u0006\u0010\u0002\u001a\u00020\u00032\u0006\u0010\u0004\u001a\u00020\u0003H\u0002J\u0016\u0010\u0012\u001a\u00020\u00132\u0006\u0010\u0014\u001a\u00020\u00082\u0006\u0010\u0015\u001a\u00020\u0008J\u0008\u0010\u0016\u001a\u0004\u0018\u00010\u0008J\u000e\u0010\u0017\u001a\u00020\u00132\u0006\u0010\u0018\u001a\u00020\u0010R\u000e\u0010\u0007\u001a\u00020\u0008X\u0082D\u00a2\u0006\u0002\n\u0000R\u0010\u0010\t\u001a\u0004\u0018\u00010\u0008X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0005\u001a\u00020\u0003X\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0004\u001a\u00020\u0003X\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u0010\u0010\n\u001a\u0004\u0018\u00010\u000bX\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u000c\u001a\u00020\u0001X\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u0010\u0010\r\u001a\u0004\u0018\u00010\u000eX\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0002\u001a\u00020\u0003X\u0082\u0004\u00a2\u0006\u0002\n\u0000\u00a8\u0006\u0019"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/server/inspection/Offline/OfflineAudioRecorder;",
        "",
        "sampleRate",
        "",
        "channels",
        "bitRate",
        "(III)V",
        "TAG",
        "",
        "aacFilePath",
        "codec",
        "Landroid/media/MediaCodec;",
        "lock",
        "outputStream",
        "Ljava/io/FileOutputStream;",
        "createAdtsHeader",
        "",
        "packetLen",
        "start",
        "",
        "sessionId",
        "taskId",
        "stop",
        "write",
        "buffer",
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

.field private aacFilePath:Ljava/lang/String;

.field private final bitRate:I

.field private final channels:I

.field private codec:Landroid/media/MediaCodec;

.field private final lock:Ljava/lang/Object;

.field private outputStream:Ljava/io/FileOutputStream;

.field private final sampleRate:I


# direct methods
.method public constructor <init>()V
    .locals 6

    const/4 v4, 0x7

    const/4 v5, 0x0

    const/4 v1, 0x0

    const/4 v2, 0x0

    const/4 v3, 0x0

    move-object v0, p0

    invoke-direct/range {v0 .. v5}, Lcom/rokid/security/phone/sdk/server/inspection/Offline/OfflineAudioRecorder;-><init>(IIIILkotlin/jvm/internal/DefaultConstructorMarker;)V

    return-void
.end method

.method public constructor <init>(III)V
    .locals 1
    .param p1, "sampleRate"    # I
    .param p2, "channels"    # I
    .param p3, "bitRate"    # I

    .line 8
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 9
    iput p1, p0, Lcom/rokid/security/phone/sdk/server/inspection/Offline/OfflineAudioRecorder;->sampleRate:I

    .line 10
    iput p2, p0, Lcom/rokid/security/phone/sdk/server/inspection/Offline/OfflineAudioRecorder;->channels:I

    .line 11
    iput p3, p0, Lcom/rokid/security/phone/sdk/server/inspection/Offline/OfflineAudioRecorder;->bitRate:I

    .line 13
    const-string v0, "OfflineAudioRecorder"

    iput-object v0, p0, Lcom/rokid/security/phone/sdk/server/inspection/Offline/OfflineAudioRecorder;->TAG:Ljava/lang/String;

    .line 17
    new-instance v0, Ljava/lang/Object;

    invoke-direct {v0}, Ljava/lang/Object;-><init>()V

    iput-object v0, p0, Lcom/rokid/security/phone/sdk/server/inspection/Offline/OfflineAudioRecorder;->lock:Ljava/lang/Object;

    .line 8
    return-void
.end method

.method public synthetic constructor <init>(IIIILkotlin/jvm/internal/DefaultConstructorMarker;)V
    .locals 0

    .line 8
    and-int/lit8 p5, p4, 0x1

    if-eqz p5, :cond_0

    .line 9
    const/16 p1, 0x3e80

    .line 8
    :cond_0
    and-int/lit8 p5, p4, 0x2

    if-eqz p5, :cond_1

    .line 10
    const/4 p2, 0x1

    .line 8
    :cond_1
    and-int/lit8 p4, p4, 0x4

    if-eqz p4, :cond_2

    .line 11
    const p3, 0xfa00

    .line 8
    :cond_2
    invoke-direct {p0, p1, p2, p3}, Lcom/rokid/security/phone/sdk/server/inspection/Offline/OfflineAudioRecorder;-><init>(III)V

    .line 148
    return-void
.end method

.method private final createAdtsHeader(III)[B
    .locals 14
    .param p1, "packetLen"    # I
    .param p2, "sampleRate"    # I
    .param p3, "channels"    # I

    .line 120
    const/4 v0, 0x2

    .line 121
    .local v0, "profile":I
    const/4 v1, 0x0

    const/4 v2, 0x4

    const/16 v3, 0x8

    const/16 v4, 0xb

    const/4 v5, 0x1

    const/4 v6, 0x5

    const/4 v7, 0x2

    const/4 v8, 0x3

    const/4 v9, 0x6

    const/4 v10, 0x7

    sparse-switch p2, :sswitch_data_0

    .line 134
    goto :goto_0

    .line 122
    :sswitch_0
    move v3, v1

    goto :goto_0

    .line 123
    :sswitch_1
    move v3, v5

    goto :goto_0

    .line 124
    :sswitch_2
    move v3, v7

    goto :goto_0

    .line 125
    :sswitch_3
    move v3, v8

    goto :goto_0

    .line 126
    :sswitch_4
    move v3, v2

    goto :goto_0

    .line 127
    :sswitch_5
    move v3, v6

    goto :goto_0

    .line 128
    :sswitch_6
    move v3, v9

    goto :goto_0

    .line 129
    :sswitch_7
    move v3, v10

    goto :goto_0

    .line 130
    :sswitch_8
    goto :goto_0

    .line 131
    :sswitch_9
    const/16 v3, 0x9

    goto :goto_0

    .line 132
    :sswitch_a
    const/16 v3, 0xa

    goto :goto_0

    .line 133
    :sswitch_b
    move v3, v4

    .line 121
    :goto_0
    nop

    .line 136
    .local v3, "freqIdx":I
    move/from16 v11, p3

    .line 138
    .local v11, "chanCfg":I
    new-array v12, v10, [B

    .line 139
    .local v12, "adtsHeader":[B
    const/4 v13, -0x1

    aput-byte v13, v12, v1

    .line 140
    const/4 v1, -0x7

    aput-byte v1, v12, v5

    .line 141
    add-int/lit8 v1, v0, -0x1

    shl-int/2addr v1, v9

    shl-int/lit8 v5, v3, 0x2

    add-int/2addr v1, v5

    shr-int/lit8 v5, v11, 0x2

    add-int/2addr v1, v5

    int-to-byte v1, v1

    aput-byte v1, v12, v7

    .line 142
    and-int/lit8 v1, v11, 0x3

    shl-int/2addr v1, v9

    add-int/lit8 v5, p1, 0x7

    shr-int/lit8 v4, v5, 0xb

    add-int/2addr v1, v4

    int-to-byte v1, v1

    aput-byte v1, v12, v8

    .line 143
    add-int/lit8 v1, p1, 0x7

    and-int/lit16 v1, v1, 0x7ff

    shr-int/2addr v1, v8

    int-to-byte v1, v1

    aput-byte v1, v12, v2

    .line 144
    add-int/lit8 v1, p1, 0x7

    and-int/2addr v1, v10

    shl-int/2addr v1, v6

    add-int/lit8 v1, v1, 0x1f

    int-to-byte v1, v1

    aput-byte v1, v12, v6

    .line 145
    const/4 v1, -0x4

    aput-byte v1, v12, v9

    .line 146
    return-object v12

    :sswitch_data_0
    .sparse-switch
        0x1f40 -> :sswitch_b
        0x2b11 -> :sswitch_a
        0x2ee0 -> :sswitch_9
        0x3e80 -> :sswitch_8
        0x5622 -> :sswitch_7
        0x5dc0 -> :sswitch_6
        0x7d00 -> :sswitch_5
        0xac44 -> :sswitch_4
        0xbb80 -> :sswitch_3
        0xfa00 -> :sswitch_2
        0x15888 -> :sswitch_1
        0x17700 -> :sswitch_0
    .end sparse-switch
.end method


# virtual methods
.method public final start(Ljava/lang/String;Ljava/lang/String;)V
    .locals 7
    .param p1, "sessionId"    # Ljava/lang/String;
    .param p2, "taskId"    # Ljava/lang/String;

    const-string/jumbo v0, "sessionId"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string/jumbo v0, "taskId"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 25
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/inspection/Offline/OfflineAudioRecorder;->lock:Ljava/lang/Object;

    monitor-enter v0

    const/4 v1, 0x0

    .line 26
    .local v1, "$i$a$-synchronized-OfflineAudioRecorder$start$1":I
    :try_start_0
    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/inspection/Offline/OfflineAudioRecorder;->codec:Landroid/media/MediaCodec;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-eqz v2, :cond_0

    .end local v1    # "$i$a$-synchronized-OfflineAudioRecorder$start$1":I
    monitor-exit v0

    return-void

    .line 28
    .restart local v1    # "$i$a$-synchronized-OfflineAudioRecorder$start$1":I
    :cond_0
    nop

    .line 30
    :try_start_1
    new-instance v2, Ljava/io/File;

    invoke-static {}, Lcom/blankj/utilcode/util/Utils;->getApp()Landroid/app/Application;

    move-result-object v3

    invoke-virtual {v3}, Landroid/app/Application;->getFilesDir()Ljava/io/File;

    move-result-object v3

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "Inspection/"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-direct {v2, v3, v4}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 31
    .local v2, "dir":Ljava/io/File;
    invoke-virtual {v2}, Ljava/io/File;->exists()Z

    move-result v3

    if-nez v3, :cond_1

    invoke-virtual {v2}, Ljava/io/File;->mkdirs()Z

    .line 33
    :cond_1
    new-instance v3, Ljava/io/File;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v4, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const/16 v5, 0x5f

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v5

    invoke-virtual {v4, v5, v6}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, ".aac"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-direct {v3, v2, v4}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    invoke-virtual {v3}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v3

    iput-object v3, p0, Lcom/rokid/security/phone/sdk/server/inspection/Offline/OfflineAudioRecorder;->aacFilePath:Ljava/lang/String;

    .line 34
    new-instance v3, Ljava/io/FileOutputStream;

    iget-object v4, p0, Lcom/rokid/security/phone/sdk/server/inspection/Offline/OfflineAudioRecorder;->aacFilePath:Ljava/lang/String;

    invoke-static {v4}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;)V

    invoke-direct {v3, v4}, Ljava/io/FileOutputStream;-><init>(Ljava/lang/String;)V

    iput-object v3, p0, Lcom/rokid/security/phone/sdk/server/inspection/Offline/OfflineAudioRecorder;->outputStream:Ljava/io/FileOutputStream;

    .line 37
    const-string v3, "audio/mp4a-latm"

    .line 38
    iget v4, p0, Lcom/rokid/security/phone/sdk/server/inspection/Offline/OfflineAudioRecorder;->sampleRate:I

    .line 39
    iget v5, p0, Lcom/rokid/security/phone/sdk/server/inspection/Offline/OfflineAudioRecorder;->channels:I

    .line 36
    invoke-static {v3, v4, v5}, Landroid/media/MediaFormat;->createAudioFormat(Ljava/lang/String;II)Landroid/media/MediaFormat;

    move-result-object v3

    const-string v4, "createAudioFormat(\n     \u2026hannels\n                )"

    invoke-static {v3, v4}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 41
    .local v3, "audioFormat":Landroid/media/MediaFormat;
    nop

    .line 42
    const-string v4, "aac-profile"

    .line 43
    nop

    .line 41
    const/4 v5, 0x2

    invoke-virtual {v3, v4, v5}, Landroid/media/MediaFormat;->setInteger(Ljava/lang/String;I)V

    .line 45
    const-string v4, "bitrate"

    iget v5, p0, Lcom/rokid/security/phone/sdk/server/inspection/Offline/OfflineAudioRecorder;->bitRate:I

    invoke-virtual {v3, v4, v5}, Landroid/media/MediaFormat;->setInteger(Ljava/lang/String;I)V

    .line 46
    const-string v4, "max-input-size"

    const/16 v5, 0x4000

    invoke-virtual {v3, v4, v5}, Landroid/media/MediaFormat;->setInteger(Ljava/lang/String;I)V

    .line 47
    const-string v4, "channel-count"

    iget v5, p0, Lcom/rokid/security/phone/sdk/server/inspection/Offline/OfflineAudioRecorder;->channels:I

    invoke-virtual {v3, v4, v5}, Landroid/media/MediaFormat;->setInteger(Ljava/lang/String;I)V

    .line 49
    const-string v4, "audio/mp4a-latm"

    invoke-static {v4}, Landroid/media/MediaCodec;->createEncoderByType(Ljava/lang/String;)Landroid/media/MediaCodec;

    move-result-object v4

    iput-object v4, p0, Lcom/rokid/security/phone/sdk/server/inspection/Offline/OfflineAudioRecorder;->codec:Landroid/media/MediaCodec;

    .line 50
    iget-object v4, p0, Lcom/rokid/security/phone/sdk/server/inspection/Offline/OfflineAudioRecorder;->codec:Landroid/media/MediaCodec;

    if-eqz v4, :cond_2

    const/4 v5, 0x1

    const/4 v6, 0x0

    invoke-virtual {v4, v3, v6, v6, v5}, Landroid/media/MediaCodec;->configure(Landroid/media/MediaFormat;Landroid/view/Surface;Landroid/media/MediaCrypto;I)V

    .line 51
    :cond_2
    iget-object v4, p0, Lcom/rokid/security/phone/sdk/server/inspection/Offline/OfflineAudioRecorder;->codec:Landroid/media/MediaCodec;

    if-eqz v4, :cond_3

    invoke-virtual {v4}, Landroid/media/MediaCodec;->start()V

    .line 53
    :cond_3
    iget-object v4, p0, Lcom/rokid/security/phone/sdk/server/inspection/Offline/OfflineAudioRecorder;->TAG:Ljava/lang/String;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v6, "\ud83c\udf99\ufe0f \u79bb\u7ebf\u5f55\u97f3\u5f00\u59cb: "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    iget-object v6, p0, Lcom/rokid/security/phone/sdk/server/inspection/Offline/OfflineAudioRecorder;->aacFilePath:Ljava/lang/String;

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .end local v2    # "dir":Ljava/io/File;
    .end local v3    # "audioFormat":Landroid/media/MediaFormat;
    goto :goto_0

    .line 54
    :catch_0
    move-exception v2

    .line 55
    .local v2, "e":Ljava/lang/Exception;
    :try_start_2
    iget-object v3, p0, Lcom/rokid/security/phone/sdk/server/inspection/Offline/OfflineAudioRecorder;->TAG:Ljava/lang/String;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v5, "\u542f\u52a8\u79bb\u7ebf\u5f55\u97f3\u5931\u8d25: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v2}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    move-object v5, v2

    check-cast v5, Ljava/lang/Throwable;

    invoke-static {v3, v4, v5}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 28
    .end local v2    # "e":Ljava/lang/Exception;
    :goto_0
    nop

    .line 25
    .end local v1    # "$i$a$-synchronized-OfflineAudioRecorder$start$1":I
    monitor-exit v0

    .line 58
    return-void

    .line 25
    :catchall_0
    move-exception v1

    monitor-exit v0

    throw v1
.end method

.method public final stop()Ljava/lang/String;
    .locals 7

    .line 99
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/inspection/Offline/OfflineAudioRecorder;->lock:Ljava/lang/Object;

    monitor-enter v0

    const/4 v1, 0x0

    .line 100
    .local v1, "$i$a$-synchronized-OfflineAudioRecorder$stop$1":I
    nop

    .line 101
    const/4 v2, 0x0

    :try_start_0
    iget-object v3, p0, Lcom/rokid/security/phone/sdk/server/inspection/Offline/OfflineAudioRecorder;->codec:Landroid/media/MediaCodec;

    if-eqz v3, :cond_0

    invoke-virtual {v3}, Landroid/media/MediaCodec;->stop()V

    .line 102
    :cond_0
    iget-object v3, p0, Lcom/rokid/security/phone/sdk/server/inspection/Offline/OfflineAudioRecorder;->codec:Landroid/media/MediaCodec;

    if-eqz v3, :cond_1

    invoke-virtual {v3}, Landroid/media/MediaCodec;->release()V

    .line 103
    :cond_1
    iput-object v2, p0, Lcom/rokid/security/phone/sdk/server/inspection/Offline/OfflineAudioRecorder;->codec:Landroid/media/MediaCodec;

    .line 104
    iget-object v3, p0, Lcom/rokid/security/phone/sdk/server/inspection/Offline/OfflineAudioRecorder;->outputStream:Ljava/io/FileOutputStream;

    if-eqz v3, :cond_2

    invoke-virtual {v3}, Ljava/io/FileOutputStream;->flush()V

    .line 105
    :cond_2
    iget-object v3, p0, Lcom/rokid/security/phone/sdk/server/inspection/Offline/OfflineAudioRecorder;->outputStream:Ljava/io/FileOutputStream;

    if-eqz v3, :cond_3

    invoke-virtual {v3}, Ljava/io/FileOutputStream;->close()V

    .line 106
    :cond_3
    iput-object v2, p0, Lcom/rokid/security/phone/sdk/server/inspection/Offline/OfflineAudioRecorder;->outputStream:Ljava/io/FileOutputStream;

    .line 107
    iget-object v3, p0, Lcom/rokid/security/phone/sdk/server/inspection/Offline/OfflineAudioRecorder;->TAG:Ljava/lang/String;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v5, "\u2705 \u79bb\u7ebf\u5f55\u97f3\u5b8c\u6210: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    iget-object v5, p0, Lcom/rokid/security/phone/sdk/server/inspection/Offline/OfflineAudioRecorder;->aacFilePath:Ljava/lang/String;

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 108
    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/inspection/Offline/OfflineAudioRecorder;->aacFilePath:Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .end local v1    # "$i$a$-synchronized-OfflineAudioRecorder$stop$1":I
    monitor-exit v0

    return-object v2

    .line 99
    :catchall_0
    move-exception v1

    goto :goto_0

    .line 109
    .restart local v1    # "$i$a$-synchronized-OfflineAudioRecorder$stop$1":I
    :catch_0
    move-exception v3

    .line 110
    .local v3, "e":Ljava/lang/Exception;
    :try_start_1
    iget-object v4, p0, Lcom/rokid/security/phone/sdk/server/inspection/Offline/OfflineAudioRecorder;->TAG:Ljava/lang/String;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v6, "\u505c\u6b62\u79bb\u7ebf\u5f55\u97f3\u5931\u8d25: "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v3}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    move-object v6, v3

    check-cast v6, Ljava/lang/Throwable;

    invoke-static {v4, v5, v6}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 100
    .end local v3    # "e":Ljava/lang/Exception;
    nop

    .line 99
    .end local v1    # "$i$a$-synchronized-OfflineAudioRecorder$stop$1":I
    monitor-exit v0

    .line 113
    return-object v2

    .line 99
    :goto_0
    monitor-exit v0

    throw v1
.end method

.method public final write([B)V
    .locals 13
    .param p1, "buffer"    # [B

    const-string v0, "buffer"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 64
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/inspection/Offline/OfflineAudioRecorder;->lock:Ljava/lang/Object;

    monitor-enter v0

    const/4 v1, 0x0

    .line 65
    .local v1, "$i$a$-synchronized-OfflineAudioRecorder$write$1":I
    :try_start_0
    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/inspection/Offline/OfflineAudioRecorder;->codec:Landroid/media/MediaCodec;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-nez v2, :cond_0

    .end local v1    # "$i$a$-synchronized-OfflineAudioRecorder$write$1":I
    monitor-exit v0

    return-void

    .line 66
    .restart local v1    # "$i$a$-synchronized-OfflineAudioRecorder$write$1":I
    .local v2, "codec":Landroid/media/MediaCodec;
    :cond_0
    nop

    .line 67
    const-wide/16 v3, 0x2710

    :try_start_1
    invoke-virtual {v2, v3, v4}, Landroid/media/MediaCodec;->dequeueInputBuffer(J)I

    move-result v3

    move v10, v3

    .line 68
    .local v10, "inputIndex":I
    if-ltz v10, :cond_3

    .line 69
    invoke-virtual {v2, v10}, Landroid/media/MediaCodec;->getInputBuffer(I)Ljava/nio/ByteBuffer;

    move-result-object v3

    move-object v11, v3

    .line 70
    .local v11, "inputBuffer":Ljava/nio/ByteBuffer;
    if-eqz v11, :cond_1

    invoke-virtual {v11}, Ljava/nio/ByteBuffer;->clear()Ljava/nio/Buffer;

    .line 71
    :cond_1
    if-eqz v11, :cond_2

    invoke-virtual {v11, p1}, Ljava/nio/ByteBuffer;->put([B)Ljava/nio/ByteBuffer;

    .line 72
    :cond_2
    array-length v6, p1

    invoke-static {}, Ljava/lang/System;->nanoTime()J

    move-result-wide v3

    const/16 v5, 0x3e8

    int-to-long v7, v5

    div-long v7, v3, v7

    const/4 v9, 0x0

    const/4 v5, 0x0

    move-object v3, v2

    move v4, v10

    invoke-virtual/range {v3 .. v9}, Landroid/media/MediaCodec;->queueInputBuffer(IIIJI)V

    .line 75
    .end local v11    # "inputBuffer":Ljava/nio/ByteBuffer;
    :cond_3
    new-instance v3, Landroid/media/MediaCodec$BufferInfo;

    invoke-direct {v3}, Landroid/media/MediaCodec$BufferInfo;-><init>()V

    .line 76
    .local v3, "bufferInfo":Landroid/media/MediaCodec$BufferInfo;
    const-wide/16 v4, 0x0

    invoke-virtual {v2, v3, v4, v5}, Landroid/media/MediaCodec;->dequeueOutputBuffer(Landroid/media/MediaCodec$BufferInfo;J)I

    move-result v6

    .line 77
    .local v6, "outputIndex":I
    :goto_0
    if-ltz v6, :cond_7

    .line 78
    invoke-virtual {v2, v6}, Landroid/media/MediaCodec;->getOutputBuffer(I)Ljava/nio/ByteBuffer;

    move-result-object v7

    .line 79
    .local v7, "outputBuffer":Ljava/nio/ByteBuffer;
    iget v8, v3, Landroid/media/MediaCodec$BufferInfo;->size:I

    new-array v8, v8, [B

    .line 80
    .local v8, "outData":[B
    if-eqz v7, :cond_4

    invoke-virtual {v7, v8}, Ljava/nio/ByteBuffer;->get([B)Ljava/nio/ByteBuffer;

    .line 82
    :cond_4
    array-length v9, v8

    iget v11, p0, Lcom/rokid/security/phone/sdk/server/inspection/Offline/OfflineAudioRecorder;->sampleRate:I

    iget v12, p0, Lcom/rokid/security/phone/sdk/server/inspection/Offline/OfflineAudioRecorder;->channels:I

    invoke-direct {p0, v9, v11, v12}, Lcom/rokid/security/phone/sdk/server/inspection/Offline/OfflineAudioRecorder;->createAdtsHeader(III)[B

    move-result-object v9

    .line 83
    .local v9, "adtsHeader":[B
    iget-object v11, p0, Lcom/rokid/security/phone/sdk/server/inspection/Offline/OfflineAudioRecorder;->outputStream:Ljava/io/FileOutputStream;

    if-eqz v11, :cond_5

    invoke-virtual {v11, v9}, Ljava/io/FileOutputStream;->write([B)V

    .line 84
    :cond_5
    iget-object v11, p0, Lcom/rokid/security/phone/sdk/server/inspection/Offline/OfflineAudioRecorder;->outputStream:Ljava/io/FileOutputStream;

    if-eqz v11, :cond_6

    invoke-virtual {v11, v8}, Ljava/io/FileOutputStream;->write([B)V

    .line 86
    :cond_6
    const/4 v11, 0x0

    invoke-virtual {v2, v6, v11}, Landroid/media/MediaCodec;->releaseOutputBuffer(IZ)V

    .line 87
    invoke-virtual {v2, v3, v4, v5}, Landroid/media/MediaCodec;->dequeueOutputBuffer(Landroid/media/MediaCodec$BufferInfo;J)I

    move-result v11

    move v6, v11

    .end local v7    # "outputBuffer":Ljava/nio/ByteBuffer;
    .end local v8    # "outData":[B
    .end local v9    # "adtsHeader":[B
    goto :goto_0

    .end local v3    # "bufferInfo":Landroid/media/MediaCodec$BufferInfo;
    .end local v6    # "outputIndex":I
    .end local v10    # "inputIndex":I
    :cond_7
    sget-object v3, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_1

    .line 89
    :catch_0
    move-exception v3

    .line 90
    .local v3, "e":Ljava/lang/Exception;
    :try_start_2
    iget-object v4, p0, Lcom/rokid/security/phone/sdk/server/inspection/Offline/OfflineAudioRecorder;->TAG:Ljava/lang/String;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v6, "\u79bb\u7ebf\u5f55\u97f3\u5199\u5165\u5931\u8d25: "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v3}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    move-object v6, v3

    check-cast v6, Ljava/lang/Throwable;

    invoke-static {v4, v5, v6}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    move-result v4

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 66
    .end local v3    # "e":Ljava/lang/Exception;
    :goto_1
    nop

    .line 64
    .end local v1    # "$i$a$-synchronized-OfflineAudioRecorder$write$1":I
    .end local v2    # "codec":Landroid/media/MediaCodec;
    monitor-exit v0

    .line 93
    return-void

    .line 64
    :catchall_0
    move-exception v1

    monitor-exit v0

    throw v1
.end method
