.class public final Lcom/rokid/security/phone/sdk/server/inspection/AudioEncoder;
.super Ljava/lang/Object;
.source "AudioEncoder.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000F\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0000\n\u0002\u0010\u000b\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\t\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0010\u0012\n\u0000\n\u0002\u0010\u0008\n\u0002\u0008\u0005\n\u0002\u0018\u0002\n\u0002\u0008\u0002\u0018\u00002\u00020\u0001B\u0005\u00a2\u0006\u0002\u0010\u0002J\u0016\u0010\r\u001a\u00020\u000e2\u0006\u0010\u000f\u001a\u00020\u00102\u0006\u0010\u0011\u001a\u00020\u0012J&\u0010\u0013\u001a\u00020\u000e2\u0006\u0010\u0014\u001a\u00020\u00122\u0006\u0010\u0015\u001a\u00020\u00122\u0006\u0010\u0016\u001a\u00020\u00122\u0006\u0010\u0017\u001a\u00020\u0018J\u0006\u0010\u0019\u001a\u00020\u000eR\u000e\u0010\u0003\u001a\u00020\u0004X\u0082D\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0005\u001a\u00020\u0006X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0010\u0010\u0007\u001a\u0004\u0018\u00010\u0008X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0010\u0010\t\u001a\u0004\u0018\u00010\nX\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u000b\u001a\u00020\u000cX\u0082\u000e\u00a2\u0006\u0002\n\u0000\u00a8\u0006\u001a"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/server/inspection/AudioEncoder;",
        "",
        "()V",
        "TAG",
        "",
        "isEncoding",
        "",
        "mediaCodec",
        "Landroid/media/MediaCodec;",
        "outputStream",
        "Ljava/io/FileOutputStream;",
        "presentationTimeUs",
        "",
        "encodeFrame",
        "",
        "audioData",
        "",
        "size",
        "",
        "init",
        "sampleRate",
        "channelCount",
        "bitRate",
        "outputFile",
        "Ljava/io/File;",
        "release",
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

.field private isEncoding:Z

.field private mediaCodec:Landroid/media/MediaCodec;

.field private outputStream:Ljava/io/FileOutputStream;

.field private presentationTimeUs:J


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 12
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 14
    const-string v0, "AudioEncoder"

    iput-object v0, p0, Lcom/rokid/security/phone/sdk/server/inspection/AudioEncoder;->TAG:Ljava/lang/String;

    .line 12
    return-void
.end method


# virtual methods
.method public final encodeFrame([BI)V
    .locals 13
    .param p1, "audioData"    # [B
    .param p2, "size"    # I

    const-string v0, "audioData"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 42
    iget-boolean v0, p0, Lcom/rokid/security/phone/sdk/server/inspection/AudioEncoder;->isEncoding:Z

    if-eqz v0, :cond_3

    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/inspection/AudioEncoder;->mediaCodec:Landroid/media/MediaCodec;

    if-eqz v0, :cond_3

    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/inspection/AudioEncoder;->outputStream:Ljava/io/FileOutputStream;

    if-nez v0, :cond_0

    goto/16 :goto_1

    .line 47
    :cond_0
    nop

    .line 48
    :try_start_0
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/inspection/AudioEncoder;->mediaCodec:Landroid/media/MediaCodec;

    invoke-static {v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;)V

    invoke-virtual {v0}, Landroid/media/MediaCodec;->getInputBuffers()[Ljava/nio/ByteBuffer;

    move-result-object v0

    const-string v1, "mediaCodec!!.inputBuffers"

    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 49
    .local v0, "inputBuffers":[Ljava/nio/ByteBuffer;
    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/inspection/AudioEncoder;->mediaCodec:Landroid/media/MediaCodec;

    invoke-static {v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;)V

    invoke-virtual {v1}, Landroid/media/MediaCodec;->getOutputBuffers()[Ljava/nio/ByteBuffer;

    move-result-object v1

    const-string v2, "mediaCodec!!.outputBuffers"

    invoke-static {v1, v2}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 50
    .local v1, "outputBuffers":[Ljava/nio/ByteBuffer;
    new-instance v2, Landroid/media/MediaCodec$BufferInfo;

    invoke-direct {v2}, Landroid/media/MediaCodec$BufferInfo;-><init>()V

    .line 52
    .local v2, "bufferInfo":Landroid/media/MediaCodec$BufferInfo;
    iget-object v3, p0, Lcom/rokid/security/phone/sdk/server/inspection/AudioEncoder;->mediaCodec:Landroid/media/MediaCodec;

    invoke-static {v3}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;)V

    const-wide/16 v4, -0x1

    invoke-virtual {v3, v4, v5}, Landroid/media/MediaCodec;->dequeueInputBuffer(J)I

    move-result v3

    .line 53
    .local v3, "inputBufferIndex":I
    const/4 v11, 0x0

    if-ltz v3, :cond_1

    .line 54
    aget-object v4, v0, v3

    move-object v12, v4

    .line 55
    .local v12, "inputBuffer":Ljava/nio/ByteBuffer;
    invoke-virtual {v12}, Ljava/nio/ByteBuffer;->clear()Ljava/nio/Buffer;

    .line 56
    invoke-virtual {v12, p1, v11, p2}, Ljava/nio/ByteBuffer;->put([BII)Ljava/nio/ByteBuffer;

    .line 57
    iget-object v4, p0, Lcom/rokid/security/phone/sdk/server/inspection/AudioEncoder;->mediaCodec:Landroid/media/MediaCodec;

    invoke-static {v4}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;)V

    iget-wide v8, p0, Lcom/rokid/security/phone/sdk/server/inspection/AudioEncoder;->presentationTimeUs:J

    const/4 v10, 0x0

    const/4 v6, 0x0

    move v5, v3

    move v7, p2

    invoke-virtual/range {v4 .. v10}, Landroid/media/MediaCodec;->queueInputBuffer(IIIJI)V

    .line 58
    iget-wide v4, p0, Lcom/rokid/security/phone/sdk/server/inspection/AudioEncoder;->presentationTimeUs:J

    int-to-long v6, p2

    const-wide/32 v8, 0xf4240

    mul-long/2addr v6, v8

    const v8, 0x15888

    int-to-long v8, v8

    div-long/2addr v6, v8

    add-long/2addr v4, v6

    iput-wide v4, p0, Lcom/rokid/security/phone/sdk/server/inspection/AudioEncoder;->presentationTimeUs:J

    .line 61
    .end local v12    # "inputBuffer":Ljava/nio/ByteBuffer;
    :cond_1
    iget-object v4, p0, Lcom/rokid/security/phone/sdk/server/inspection/AudioEncoder;->mediaCodec:Landroid/media/MediaCodec;

    invoke-static {v4}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;)V

    const-wide/16 v5, 0x0

    invoke-virtual {v4, v2, v5, v6}, Landroid/media/MediaCodec;->dequeueOutputBuffer(Landroid/media/MediaCodec$BufferInfo;J)I

    move-result v4

    .line 62
    .local v4, "outputBufferIndex":I
    :goto_0
    if-ltz v4, :cond_2

    .line 63
    aget-object v7, v1, v4

    .line 64
    .local v7, "outputBuffer":Ljava/nio/ByteBuffer;
    iget v8, v2, Landroid/media/MediaCodec$BufferInfo;->size:I

    new-array v8, v8, [B

    .line 65
    .local v8, "chunk":[B
    invoke-virtual {v7, v8}, Ljava/nio/ByteBuffer;->get([B)Ljava/nio/ByteBuffer;

    .line 66
    invoke-virtual {v7}, Ljava/nio/ByteBuffer;->clear()Ljava/nio/Buffer;

    .line 67
    iget-object v9, p0, Lcom/rokid/security/phone/sdk/server/inspection/AudioEncoder;->outputStream:Ljava/io/FileOutputStream;

    invoke-static {v9}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;)V

    array-length v10, v8

    invoke-virtual {v9, v8, v11, v10}, Ljava/io/FileOutputStream;->write([BII)V

    .line 68
    iget-object v9, p0, Lcom/rokid/security/phone/sdk/server/inspection/AudioEncoder;->mediaCodec:Landroid/media/MediaCodec;

    invoke-static {v9}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;)V

    invoke-virtual {v9, v4, v11}, Landroid/media/MediaCodec;->releaseOutputBuffer(IZ)V

    .line 69
    iget-object v9, p0, Lcom/rokid/security/phone/sdk/server/inspection/AudioEncoder;->mediaCodec:Landroid/media/MediaCodec;

    invoke-static {v9}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;)V

    invoke-virtual {v9, v2, v5, v6}, Landroid/media/MediaCodec;->dequeueOutputBuffer(Landroid/media/MediaCodec$BufferInfo;J)I

    move-result v9
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move v4, v9

    .end local v7    # "outputBuffer":Ljava/nio/ByteBuffer;
    .end local v8    # "chunk":[B
    goto :goto_0

    .line 71
    .end local v0    # "inputBuffers":[Ljava/nio/ByteBuffer;
    .end local v1    # "outputBuffers":[Ljava/nio/ByteBuffer;
    .end local v2    # "bufferInfo":Landroid/media/MediaCodec$BufferInfo;
    .end local v3    # "inputBufferIndex":I
    .end local v4    # "outputBufferIndex":I
    :catch_0
    move-exception v0

    .line 72
    .local v0, "e":Ljava/lang/Exception;
    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/inspection/AudioEncoder;->TAG:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Failed to encode audio frame: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    move-object v3, v0

    check-cast v3, Ljava/lang/Throwable;

    invoke-static {v1, v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 74
    .end local v0    # "e":Ljava/lang/Exception;
    :cond_2
    return-void

    .line 43
    :cond_3
    :goto_1
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/inspection/AudioEncoder;->TAG:Ljava/lang/String;

    const-string v1, "AudioEncoder is not initialized or not encoding."

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 44
    return-void
.end method

.method public final init(IIILjava/io/File;)V
    .locals 4
    .param p1, "sampleRate"    # I
    .param p2, "channelCount"    # I
    .param p3, "bitRate"    # I
    .param p4, "outputFile"    # Ljava/io/File;

    const-string v0, "audio/mp4a-latm"

    const-string v1, "outputFile"

    invoke-static {p4, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 21
    nop

    .line 22
    :try_start_0
    invoke-static {v0, p1, p2}, Landroid/media/MediaFormat;->createAudioFormat(Ljava/lang/String;II)Landroid/media/MediaFormat;

    move-result-object v1

    const-string v2, "createAudioFormat(MediaF\u2026sampleRate, channelCount)"

    invoke-static {v1, v2}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 23
    .local v1, "format":Landroid/media/MediaFormat;
    const-string v2, "aac-profile"

    const/4 v3, 0x2

    invoke-virtual {v1, v2, v3}, Landroid/media/MediaFormat;->setInteger(Ljava/lang/String;I)V

    .line 24
    const-string v2, "bitrate"

    invoke-virtual {v1, v2, p3}, Landroid/media/MediaFormat;->setInteger(Ljava/lang/String;I)V

    .line 25
    const-string v2, "max-input-size"

    const/16 v3, 0x4000

    invoke-virtual {v1, v2, v3}, Landroid/media/MediaFormat;->setInteger(Ljava/lang/String;I)V

    .line 27
    invoke-static {v0}, Landroid/media/MediaCodec;->createEncoderByType(Ljava/lang/String;)Landroid/media/MediaCodec;

    move-result-object v0

    iput-object v0, p0, Lcom/rokid/security/phone/sdk/server/inspection/AudioEncoder;->mediaCodec:Landroid/media/MediaCodec;

    .line 28
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/inspection/AudioEncoder;->mediaCodec:Landroid/media/MediaCodec;

    const/4 v2, 0x1

    if-eqz v0, :cond_0

    const/4 v3, 0x0

    invoke-virtual {v0, v1, v3, v3, v2}, Landroid/media/MediaCodec;->configure(Landroid/media/MediaFormat;Landroid/view/Surface;Landroid/media/MediaCrypto;I)V

    .line 29
    :cond_0
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/inspection/AudioEncoder;->mediaCodec:Landroid/media/MediaCodec;

    if-eqz v0, :cond_1

    invoke-virtual {v0}, Landroid/media/MediaCodec;->start()V

    .line 31
    :cond_1
    new-instance v0, Ljava/io/FileOutputStream;

    invoke-direct {v0, p4}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V

    iput-object v0, p0, Lcom/rokid/security/phone/sdk/server/inspection/AudioEncoder;->outputStream:Ljava/io/FileOutputStream;

    .line 32
    iput-boolean v2, p0, Lcom/rokid/security/phone/sdk/server/inspection/AudioEncoder;->isEncoding:Z

    .line 33
    const-wide/16 v2, 0x0

    iput-wide v2, p0, Lcom/rokid/security/phone/sdk/server/inspection/AudioEncoder;->presentationTimeUs:J

    .line 34
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/inspection/AudioEncoder;->TAG:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "AudioEncoder initialized successfully. Output file: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {p4}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v0, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 35
    .end local v1    # "format":Landroid/media/MediaFormat;
    :catch_0
    move-exception v0

    .line 36
    .local v0, "e":Ljava/lang/Exception;
    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/inspection/AudioEncoder;->TAG:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Failed to initialize AudioEncoder: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    move-object v3, v0

    check-cast v3, Ljava/lang/Throwable;

    invoke-static {v1, v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 37
    invoke-virtual {p0}, Lcom/rokid/security/phone/sdk/server/inspection/AudioEncoder;->release()V

    .line 39
    .end local v0    # "e":Ljava/lang/Exception;
    :goto_0
    return-void
.end method

.method public final release()V
    .locals 5

    .line 77
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/inspection/AudioEncoder;->mediaCodec:Landroid/media/MediaCodec;

    const/4 v1, 0x0

    if-eqz v0, :cond_2

    .line 78
    nop

    .line 79
    :try_start_0
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/inspection/AudioEncoder;->mediaCodec:Landroid/media/MediaCodec;

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Landroid/media/MediaCodec;->stop()V

    .line 80
    :cond_0
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/inspection/AudioEncoder;->mediaCodec:Landroid/media/MediaCodec;

    if-eqz v0, :cond_1

    invoke-virtual {v0}, Landroid/media/MediaCodec;->release()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 84
    :cond_1
    nop

    :goto_0
    iput-object v1, p0, Lcom/rokid/security/phone/sdk/server/inspection/AudioEncoder;->mediaCodec:Landroid/media/MediaCodec;

    .line 85
    goto :goto_2

    .line 84
    :catchall_0
    move-exception v0

    goto :goto_1

    .line 81
    :catch_0
    move-exception v0

    .line 82
    .local v0, "e":Ljava/lang/Exception;
    :try_start_1
    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/inspection/AudioEncoder;->TAG:Ljava/lang/String;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "Error stopping or releasing MediaCodec: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    move-object v4, v0

    check-cast v4, Ljava/lang/Throwable;

    invoke-static {v2, v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 84
    nop

    .end local v0    # "e":Ljava/lang/Exception;
    goto :goto_0

    :goto_1
    iput-object v1, p0, Lcom/rokid/security/phone/sdk/server/inspection/AudioEncoder;->mediaCodec:Landroid/media/MediaCodec;

    throw v0

    .line 87
    :cond_2
    :goto_2
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/inspection/AudioEncoder;->outputStream:Ljava/io/FileOutputStream;

    if-eqz v0, :cond_4

    .line 88
    nop

    .line 89
    :try_start_2
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/inspection/AudioEncoder;->outputStream:Ljava/io/FileOutputStream;

    if-eqz v0, :cond_3

    invoke-virtual {v0}, Ljava/io/FileOutputStream;->close()V
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_1
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 93
    :cond_3
    nop

    :goto_3
    iput-object v1, p0, Lcom/rokid/security/phone/sdk/server/inspection/AudioEncoder;->outputStream:Ljava/io/FileOutputStream;

    .line 94
    goto :goto_5

    .line 93
    :catchall_1
    move-exception v0

    goto :goto_4

    .line 90
    :catch_1
    move-exception v0

    .line 91
    .restart local v0    # "e":Ljava/lang/Exception;
    :try_start_3
    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/inspection/AudioEncoder;->TAG:Ljava/lang/String;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "Error closing output stream: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    move-object v4, v0

    check-cast v4, Ljava/lang/Throwable;

    invoke-static {v2, v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 93
    nop

    .end local v0    # "e":Ljava/lang/Exception;
    goto :goto_3

    :goto_4
    iput-object v1, p0, Lcom/rokid/security/phone/sdk/server/inspection/AudioEncoder;->outputStream:Ljava/io/FileOutputStream;

    throw v0

    .line 96
    :cond_4
    :goto_5
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/rokid/security/phone/sdk/server/inspection/AudioEncoder;->isEncoding:Z

    .line 97
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/inspection/AudioEncoder;->TAG:Ljava/lang/String;

    const-string v1, "AudioEncoder released."

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 98
    return-void
.end method
