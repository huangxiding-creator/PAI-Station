.class public final Lcom/rokid/security/phone/sdk/server/media/H264Encoder;
.super Ljava/lang/Object;
.source "H264Encoder.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000F\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u000b\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0010\u0012\n\u0002\u0008\u0002\n\u0002\u0010\u0008\n\u0002\u0008\t\u0018\u00002\u00020\u0001B\u0005\u00a2\u0006\u0002\u0010\u0002J(\u0010\u000f\u001a\u00020\u00102\u0006\u0010\u0011\u001a\u00020\u00122\u0006\u0010\u0013\u001a\u00020\u00122\u0006\u0010\u0014\u001a\u00020\u00152\u0006\u0010\u0016\u001a\u00020\u0015H\u0002J\u001e\u0010\u0017\u001a\u00020\u00102\u0006\u0010\u0018\u001a\u00020\u00122\u0006\u0010\u0014\u001a\u00020\u00152\u0006\u0010\u0016\u001a\u00020\u0015J.\u0010\u0019\u001a\u00020\u00102\u0006\u0010\u0014\u001a\u00020\u00152\u0006\u0010\u0016\u001a\u00020\u00152\u0006\u0010\u001a\u001a\u00020\u00152\u0006\u0010\u001b\u001a\u00020\u00152\u0006\u0010\u001c\u001a\u00020\u000eJ\u0006\u0010\u001d\u001a\u00020\u0010R\u000e\u0010\u0003\u001a\u00020\u0004X\u0082D\u00a2\u0006\u0002\n\u0000R\u0010\u0010\u0005\u001a\u0004\u0018\u00010\u0006X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0007\u001a\u00020\u0008X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0010\u0010\t\u001a\u0004\u0018\u00010\nX\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0010\u0010\u000b\u001a\u0004\u0018\u00010\u000cX\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0010\u0010\r\u001a\u0004\u0018\u00010\u000eX\u0082\u000e\u00a2\u0006\u0002\n\u0000\u00a8\u0006\u001e"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/server/media/H264Encoder;",
        "",
        "()V",
        "TAG",
        "",
        "bufferInfo",
        "Landroid/media/MediaCodec$BufferInfo;",
        "isEncoding",
        "",
        "mediaCodec",
        "Landroid/media/MediaCodec;",
        "outputStream",
        "Ljava/io/FileOutputStream;",
        "videoFile",
        "Ljava/io/File;",
        "NV21toYUV420SemiPlanar",
        "",
        "nv21",
        "",
        "yuv420sp",
        "width",
        "",
        "height",
        "encodeFrame",
        "nv21Data",
        "init",
        "frameRate",
        "bitRate",
        "outputFile",
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

.field private bufferInfo:Landroid/media/MediaCodec$BufferInfo;

.field private isEncoding:Z

.field private mediaCodec:Landroid/media/MediaCodec;

.field private outputStream:Ljava/io/FileOutputStream;

.field private videoFile:Ljava/io/File;


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 11
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 12
    const-string v0, "H264Encoder"

    iput-object v0, p0, Lcom/rokid/security/phone/sdk/server/media/H264Encoder;->TAG:Ljava/lang/String;

    .line 11
    return-void
.end method

.method private final NV21toYUV420SemiPlanar([B[BII)V
    .locals 5
    .param p1, "nv21"    # [B
    .param p2, "yuv420sp"    # [B
    .param p3, "width"    # I
    .param p4, "height"    # I

    .line 103
    mul-int v0, p3, p4

    .line 104
    .local v0, "ySize":I
    div-int/lit8 v1, v0, 0x4

    .line 107
    .local v1, "uvSize":I
    const/4 v2, 0x0

    invoke-static {p1, v2, p2, v2, v0}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 112
    const/4 v2, 0x0

    .local v2, "i":I
    :goto_0
    if-ge v2, v1, :cond_0

    .line 113
    mul-int/lit8 v3, v2, 0x2

    add-int/2addr v3, v0

    mul-int/lit8 v4, v2, 0x2

    add-int/2addr v4, v0

    add-int/lit8 v4, v4, 0x1

    aget-byte v4, p1, v4

    aput-byte v4, p2, v3

    .line 114
    mul-int/lit8 v3, v2, 0x2

    add-int/2addr v3, v0

    add-int/lit8 v3, v3, 0x1

    mul-int/lit8 v4, v2, 0x2

    add-int/2addr v4, v0

    aget-byte v4, p1, v4

    aput-byte v4, p2, v3

    .line 112
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 116
    .end local v2    # "i":I
    :cond_0
    return-void
.end method


# virtual methods
.method public final encodeFrame([BII)V
    .locals 18
    .param p1, "nv21Data"    # [B
    .param p2, "width"    # I
    .param p3, "height"    # I

    move-object/from16 v1, p0

    move-object/from16 v2, p1

    move/from16 v3, p2

    move/from16 v4, p3

    const-string v0, "nv21Data"

    invoke-static {v2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 44
    iget-boolean v0, v1, Lcom/rokid/security/phone/sdk/server/media/H264Encoder;->isEncoding:Z

    if-eqz v0, :cond_12

    iget-object v0, v1, Lcom/rokid/security/phone/sdk/server/media/H264Encoder;->mediaCodec:Landroid/media/MediaCodec;

    if-eqz v0, :cond_12

    iget-object v0, v1, Lcom/rokid/security/phone/sdk/server/media/H264Encoder;->outputStream:Ljava/io/FileOutputStream;

    if-eqz v0, :cond_12

    iget-object v0, v1, Lcom/rokid/security/phone/sdk/server/media/H264Encoder;->bufferInfo:Landroid/media/MediaCodec$BufferInfo;

    if-nez v0, :cond_0

    goto/16 :goto_8

    .line 49
    :cond_0
    nop

    .line 50
    :try_start_0
    iget-object v0, v1, Lcom/rokid/security/phone/sdk/server/media/H264Encoder;->mediaCodec:Landroid/media/MediaCodec;

    if-eqz v0, :cond_1

    invoke-virtual {v0}, Landroid/media/MediaCodec;->getInputBuffers()[Ljava/nio/ByteBuffer;

    move-result-object v0

    goto :goto_0

    :cond_1
    const/4 v0, 0x0

    .line 51
    .local v0, "inputBuffers":[Ljava/nio/ByteBuffer;
    :goto_0
    iget-object v6, v1, Lcom/rokid/security/phone/sdk/server/media/H264Encoder;->mediaCodec:Landroid/media/MediaCodec;

    if-eqz v6, :cond_2

    invoke-virtual {v6}, Landroid/media/MediaCodec;->getOutputBuffers()[Ljava/nio/ByteBuffer;

    move-result-object v6

    goto :goto_1

    :cond_2
    const/4 v6, 0x0

    .line 53
    .local v6, "outputBuffers":[Ljava/nio/ByteBuffer;
    :goto_1
    iget-object v7, v1, Lcom/rokid/security/phone/sdk/server/media/H264Encoder;->mediaCodec:Landroid/media/MediaCodec;

    if-eqz v7, :cond_3

    const-wide/16 v8, -0x1

    invoke-virtual {v7, v8, v9}, Landroid/media/MediaCodec;->dequeueInputBuffer(J)I

    move-result v7

    invoke-static {v7}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v7

    goto :goto_2

    :cond_3
    const/4 v7, 0x0

    .line 54
    .local v7, "inputBufferIndex":Ljava/lang/Integer;
    :goto_2
    if-eqz v7, :cond_8

    invoke-virtual {v7}, Ljava/lang/Integer;->intValue()I

    move-result v8

    if-ltz v8, :cond_8

    .line 55
    if-eqz v0, :cond_4

    invoke-virtual {v7}, Ljava/lang/Integer;->intValue()I

    move-result v8

    aget-object v8, v0, v8

    goto :goto_3

    :cond_4
    const/4 v8, 0x0

    .line 56
    .local v8, "inputBuffer":Ljava/nio/ByteBuffer;
    :goto_3
    if-eqz v8, :cond_5

    invoke-virtual {v8}, Ljava/nio/ByteBuffer;->clear()Ljava/nio/Buffer;

    .line 59
    :cond_5
    mul-int v9, v3, v4

    mul-int/lit8 v9, v9, 0x3

    div-int/lit8 v9, v9, 0x2

    new-array v9, v9, [B

    .line 60
    .local v9, "yuv420sp":[B
    invoke-direct {v1, v2, v9, v3, v4}, Lcom/rokid/security/phone/sdk/server/media/H264Encoder;->NV21toYUV420SemiPlanar([B[BII)V

    .line 62
    if-eqz v8, :cond_6

    invoke-virtual {v8, v9}, Ljava/nio/ByteBuffer;->put([B)Ljava/nio/ByteBuffer;

    .line 64
    :cond_6
    iget-object v10, v1, Lcom/rokid/security/phone/sdk/server/media/H264Encoder;->mediaCodec:Landroid/media/MediaCodec;

    if-eqz v10, :cond_7

    invoke-virtual {v7}, Ljava/lang/Integer;->intValue()I

    move-result v11

    array-length v13, v9

    invoke-static {}, Ljava/lang/System;->nanoTime()J

    move-result-wide v14

    const/16 v12, 0x3e8

    move-object/from16 v17, v6

    .end local v6    # "outputBuffers":[Ljava/nio/ByteBuffer;
    .local v17, "outputBuffers":[Ljava/nio/ByteBuffer;
    int-to-long v5, v12

    div-long/2addr v14, v5

    const/16 v16, 0x0

    const/4 v12, 0x0

    invoke-virtual/range {v10 .. v16}, Landroid/media/MediaCodec;->queueInputBuffer(IIIJI)V

    goto :goto_4

    .end local v17    # "outputBuffers":[Ljava/nio/ByteBuffer;
    .restart local v6    # "outputBuffers":[Ljava/nio/ByteBuffer;
    :cond_7
    move-object/from16 v17, v6

    .end local v6    # "outputBuffers":[Ljava/nio/ByteBuffer;
    .restart local v17    # "outputBuffers":[Ljava/nio/ByteBuffer;
    goto :goto_4

    .line 54
    .end local v8    # "inputBuffer":Ljava/nio/ByteBuffer;
    .end local v9    # "yuv420sp":[B
    .end local v17    # "outputBuffers":[Ljava/nio/ByteBuffer;
    .restart local v6    # "outputBuffers":[Ljava/nio/ByteBuffer;
    :cond_8
    move-object/from16 v17, v6

    .line 67
    .end local v6    # "outputBuffers":[Ljava/nio/ByteBuffer;
    .restart local v17    # "outputBuffers":[Ljava/nio/ByteBuffer;
    :goto_4
    iget-object v5, v1, Lcom/rokid/security/phone/sdk/server/media/H264Encoder;->mediaCodec:Landroid/media/MediaCodec;

    const-wide/16 v8, 0x0

    if-eqz v5, :cond_9

    iget-object v6, v1, Lcom/rokid/security/phone/sdk/server/media/H264Encoder;->bufferInfo:Landroid/media/MediaCodec$BufferInfo;

    invoke-static {v6}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;)V

    invoke-virtual {v5, v6, v8, v9}, Landroid/media/MediaCodec;->dequeueOutputBuffer(Landroid/media/MediaCodec$BufferInfo;J)I

    move-result v5

    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    goto :goto_5

    :cond_9
    const/4 v5, 0x0

    .line 68
    .local v5, "outputBufferIndex":Ljava/lang/Integer;
    :goto_5
    if-eqz v5, :cond_11

    invoke-virtual {v5}, Ljava/lang/Integer;->intValue()I

    move-result v6

    if-ltz v6, :cond_11

    .line 69
    if-eqz v17, :cond_a

    invoke-virtual {v5}, Ljava/lang/Integer;->intValue()I

    move-result v6

    aget-object v6, v17, v6

    goto :goto_6

    :cond_a
    const/4 v6, 0x0

    .line 70
    .local v6, "outputBuffer":Ljava/nio/ByteBuffer;
    :goto_6
    if-eqz v6, :cond_b

    iget-object v10, v1, Lcom/rokid/security/phone/sdk/server/media/H264Encoder;->bufferInfo:Landroid/media/MediaCodec$BufferInfo;

    invoke-static {v10}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;)V

    iget v10, v10, Landroid/media/MediaCodec$BufferInfo;->offset:I

    invoke-virtual {v6, v10}, Ljava/nio/ByteBuffer;->position(I)Ljava/nio/Buffer;

    .line 71
    :cond_b
    if-eqz v6, :cond_c

    iget-object v10, v1, Lcom/rokid/security/phone/sdk/server/media/H264Encoder;->bufferInfo:Landroid/media/MediaCodec$BufferInfo;

    invoke-static {v10}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;)V

    iget v10, v10, Landroid/media/MediaCodec$BufferInfo;->offset:I

    iget-object v11, v1, Lcom/rokid/security/phone/sdk/server/media/H264Encoder;->bufferInfo:Landroid/media/MediaCodec$BufferInfo;

    invoke-static {v11}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;)V

    iget v11, v11, Landroid/media/MediaCodec$BufferInfo;->size:I

    add-int/2addr v10, v11

    invoke-virtual {v6, v10}, Ljava/nio/ByteBuffer;->limit(I)Ljava/nio/Buffer;

    .line 73
    :cond_c
    iget-object v10, v1, Lcom/rokid/security/phone/sdk/server/media/H264Encoder;->bufferInfo:Landroid/media/MediaCodec$BufferInfo;

    invoke-static {v10}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;)V

    iget v10, v10, Landroid/media/MediaCodec$BufferInfo;->size:I

    new-array v10, v10, [B

    .line 74
    .local v10, "chunk":[B
    if-eqz v6, :cond_d

    invoke-virtual {v6, v10}, Ljava/nio/ByteBuffer;->get([B)Ljava/nio/ByteBuffer;

    .line 75
    :cond_d
    iget-object v11, v1, Lcom/rokid/security/phone/sdk/server/media/H264Encoder;->outputStream:Ljava/io/FileOutputStream;

    const/4 v12, 0x0

    if-eqz v11, :cond_e

    array-length v13, v10

    invoke-virtual {v11, v10, v12, v13}, Ljava/io/FileOutputStream;->write([BII)V

    .line 77
    :cond_e
    iget-object v11, v1, Lcom/rokid/security/phone/sdk/server/media/H264Encoder;->mediaCodec:Landroid/media/MediaCodec;

    if-eqz v11, :cond_f

    invoke-virtual {v5}, Ljava/lang/Integer;->intValue()I

    move-result v13

    invoke-virtual {v11, v13, v12}, Landroid/media/MediaCodec;->releaseOutputBuffer(IZ)V

    .line 78
    :cond_f
    iget-object v11, v1, Lcom/rokid/security/phone/sdk/server/media/H264Encoder;->mediaCodec:Landroid/media/MediaCodec;

    if-eqz v11, :cond_10

    iget-object v12, v1, Lcom/rokid/security/phone/sdk/server/media/H264Encoder;->bufferInfo:Landroid/media/MediaCodec$BufferInfo;

    invoke-static {v12}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;)V

    invoke-virtual {v11, v12, v8, v9}, Landroid/media/MediaCodec;->dequeueOutputBuffer(Landroid/media/MediaCodec$BufferInfo;J)I

    move-result v11

    invoke-static {v11}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v11
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_7

    :cond_10
    const/4 v11, 0x0

    :goto_7
    move-object v5, v11

    .end local v6    # "outputBuffer":Ljava/nio/ByteBuffer;
    .end local v10    # "chunk":[B
    goto :goto_5

    .line 80
    .end local v0    # "inputBuffers":[Ljava/nio/ByteBuffer;
    .end local v5    # "outputBufferIndex":Ljava/lang/Integer;
    .end local v7    # "inputBufferIndex":Ljava/lang/Integer;
    .end local v17    # "outputBuffers":[Ljava/nio/ByteBuffer;
    :catch_0
    move-exception v0

    .line 81
    .local v0, "e":Ljava/lang/Exception;
    iget-object v5, v1, Lcom/rokid/security/phone/sdk/server/media/H264Encoder;->TAG:Ljava/lang/String;

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "Error encoding frame: "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    move-object v7, v0

    check-cast v7, Ljava/lang/Throwable;

    invoke-static {v5, v6, v7}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 83
    .end local v0    # "e":Ljava/lang/Exception;
    :cond_11
    return-void

    .line 45
    :cond_12
    :goto_8
    iget-object v0, v1, Lcom/rokid/security/phone/sdk/server/media/H264Encoder;->TAG:Ljava/lang/String;

    const-string v5, "Encoder not initialized or not encoding."

    invoke-static {v0, v5}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 46
    return-void
.end method

.method public final init(IIIILjava/io/File;)V
    .locals 4
    .param p1, "width"    # I
    .param p2, "height"    # I
    .param p3, "frameRate"    # I
    .param p4, "bitRate"    # I
    .param p5, "outputFile"    # Ljava/io/File;

    const-string/jumbo v0, "video/avc"

    const-string v1, "outputFile"

    invoke-static {p5, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 20
    nop

    .line 21
    :try_start_0
    iput-object p5, p0, Lcom/rokid/security/phone/sdk/server/media/H264Encoder;->videoFile:Ljava/io/File;

    .line 22
    new-instance v1, Ljava/io/FileOutputStream;

    invoke-direct {v1, p5}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V

    iput-object v1, p0, Lcom/rokid/security/phone/sdk/server/media/H264Encoder;->outputStream:Ljava/io/FileOutputStream;

    .line 24
    invoke-static {v0, p1, p2}, Landroid/media/MediaFormat;->createVideoFormat(Ljava/lang/String;II)Landroid/media/MediaFormat;

    move-result-object v1

    const-string v2, "createVideoFormat(MediaF\u2026VIDEO_AVC, width, height)"

    invoke-static {v1, v2}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 25
    .local v1, "format":Landroid/media/MediaFormat;
    const-string v2, "color-format"

    const/16 v3, 0x15

    invoke-virtual {v1, v2, v3}, Landroid/media/MediaFormat;->setInteger(Ljava/lang/String;I)V

    .line 26
    const-string v2, "bitrate"

    invoke-virtual {v1, v2, p4}, Landroid/media/MediaFormat;->setInteger(Ljava/lang/String;I)V

    .line 27
    const-string v2, "frame-rate"

    invoke-virtual {v1, v2, p3}, Landroid/media/MediaFormat;->setInteger(Ljava/lang/String;I)V

    .line 28
    const-string v2, "i-frame-interval"

    const/4 v3, 0x1

    invoke-virtual {v1, v2, v3}, Landroid/media/MediaFormat;->setInteger(Ljava/lang/String;I)V

    .line 30
    invoke-static {v0}, Landroid/media/MediaCodec;->createEncoderByType(Ljava/lang/String;)Landroid/media/MediaCodec;

    move-result-object v0

    iput-object v0, p0, Lcom/rokid/security/phone/sdk/server/media/H264Encoder;->mediaCodec:Landroid/media/MediaCodec;

    .line 31
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/media/H264Encoder;->mediaCodec:Landroid/media/MediaCodec;

    if-eqz v0, :cond_0

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2, v2, v3}, Landroid/media/MediaCodec;->configure(Landroid/media/MediaFormat;Landroid/view/Surface;Landroid/media/MediaCrypto;I)V

    .line 32
    :cond_0
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/media/H264Encoder;->mediaCodec:Landroid/media/MediaCodec;

    if-eqz v0, :cond_1

    invoke-virtual {v0}, Landroid/media/MediaCodec;->start()V

    .line 34
    :cond_1
    new-instance v0, Landroid/media/MediaCodec$BufferInfo;

    invoke-direct {v0}, Landroid/media/MediaCodec$BufferInfo;-><init>()V

    iput-object v0, p0, Lcom/rokid/security/phone/sdk/server/media/H264Encoder;->bufferInfo:Landroid/media/MediaCodec$BufferInfo;

    .line 35
    iput-boolean v3, p0, Lcom/rokid/security/phone/sdk/server/media/H264Encoder;->isEncoding:Z

    .line 36
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/media/H264Encoder;->TAG:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "H264Encoder initialized for file: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {p5}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v0, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 37
    .end local v1    # "format":Landroid/media/MediaFormat;
    :catch_0
    move-exception v0

    .line 38
    .local v0, "e":Ljava/lang/Exception;
    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/media/H264Encoder;->TAG:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Error initializing H264Encoder: "

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

    .line 39
    const/4 v1, 0x0

    iput-boolean v1, p0, Lcom/rokid/security/phone/sdk/server/media/H264Encoder;->isEncoding:Z

    .line 41
    .end local v0    # "e":Ljava/lang/Exception;
    :goto_0
    return-void
.end method

.method public final release()V
    .locals 5

    .line 86
    nop

    .line 87
    const/4 v0, 0x0

    const/4 v1, 0x0

    :try_start_0
    iput-boolean v0, p0, Lcom/rokid/security/phone/sdk/server/media/H264Encoder;->isEncoding:Z

    .line 88
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/media/H264Encoder;->mediaCodec:Landroid/media/MediaCodec;

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Landroid/media/MediaCodec;->stop()V

    .line 89
    :cond_0
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/media/H264Encoder;->mediaCodec:Landroid/media/MediaCodec;

    if-eqz v0, :cond_1

    invoke-virtual {v0}, Landroid/media/MediaCodec;->release()V

    .line 90
    :cond_1
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/media/H264Encoder;->outputStream:Ljava/io/FileOutputStream;

    if-eqz v0, :cond_2

    invoke-virtual {v0}, Ljava/io/FileOutputStream;->close()V

    .line 91
    :cond_2
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/media/H264Encoder;->TAG:Ljava/lang/String;

    const-string v2, "H264Encoder released."

    invoke-static {v0, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 95
    goto :goto_0

    :catchall_0
    move-exception v0

    goto :goto_1

    .line 92
    :catch_0
    move-exception v0

    .line 93
    .local v0, "e":Ljava/lang/Exception;
    :try_start_1
    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/media/H264Encoder;->TAG:Ljava/lang/String;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "Error releasing H264Encoder: "

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

    .line 95
    nop

    .end local v0    # "e":Ljava/lang/Exception;
    :goto_0
    iput-object v1, p0, Lcom/rokid/security/phone/sdk/server/media/H264Encoder;->mediaCodec:Landroid/media/MediaCodec;

    .line 96
    iput-object v1, p0, Lcom/rokid/security/phone/sdk/server/media/H264Encoder;->outputStream:Ljava/io/FileOutputStream;

    .line 97
    iput-object v1, p0, Lcom/rokid/security/phone/sdk/server/media/H264Encoder;->bufferInfo:Landroid/media/MediaCodec$BufferInfo;

    .line 98
    iput-object v1, p0, Lcom/rokid/security/phone/sdk/server/media/H264Encoder;->videoFile:Ljava/io/File;

    .line 99
    nop

    .line 100
    return-void

    .line 95
    :goto_1
    iput-object v1, p0, Lcom/rokid/security/phone/sdk/server/media/H264Encoder;->mediaCodec:Landroid/media/MediaCodec;

    .line 96
    iput-object v1, p0, Lcom/rokid/security/phone/sdk/server/media/H264Encoder;->outputStream:Ljava/io/FileOutputStream;

    .line 97
    iput-object v1, p0, Lcom/rokid/security/phone/sdk/server/media/H264Encoder;->bufferInfo:Landroid/media/MediaCodec$BufferInfo;

    .line 98
    iput-object v1, p0, Lcom/rokid/security/phone/sdk/server/media/H264Encoder;->videoFile:Ljava/io/File;

    throw v0
.end method
