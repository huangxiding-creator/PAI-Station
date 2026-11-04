.class public final Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;
.super Ljava/lang/Object;
.source "H264StreamDecoder.kt"


# annotations
.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nH264StreamDecoder.kt\nKotlin\n*S Kotlin\n*F\n+ 1 H264StreamDecoder.kt\ncom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder\n+ 2 fake.kt\nkotlin/jvm/internal/FakeKt\n*L\n1#1,697:1\n1#2:698\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000p\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0000\n\u0002\u0010\u0012\n\u0000\n\u0002\u0010\u0008\n\u0002\u0008\u0004\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u000b\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0003\n\u0002\u0010\u0002\n\u0002\u0008\u0012\n\u0002\u0018\u0002\n\u0002\u0008\u000b\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0005\n\u0002\u0010\u0006\n\u0002\u0008\u0005\n\u0002\u0010 \n\u0002\u0008\u0006\u0018\u00002\u00020\u0001B\u0005\u00a2\u0006\u0002\u0010\u0002J:\u0010\u001d\u001a\u0004\u0018\u00010\u00062\u0006\u0010\u001e\u001a\u00020\u00062\u0006\u0010\u001f\u001a\u00020\u00082\u0006\u0010 \u001a\u00020\u00082\u0006\u0010!\u001a\u00020\u00082\u0006\u0010\"\u001a\u00020\u00082\u0006\u0010#\u001a\u00020\u000fH\u0002J:\u0010$\u001a\u0004\u0018\u00010\u00062\u0006\u0010\u001e\u001a\u00020\u00062\u0006\u0010\u001f\u001a\u00020\u00082\u0006\u0010 \u001a\u00020\u00082\u0006\u0010!\u001a\u00020\u00082\u0006\u0010\"\u001a\u00020\u00082\u0006\u0010#\u001a\u00020\u000fH\u0002J\u001f\u0010%\u001a\u0004\u0018\u00010\u00082\u0006\u0010\u0017\u001a\u00020\u00062\u0006\u0010&\u001a\u00020\u0008H\u0002\u00a2\u0006\u0002\u0010\'J\u001f\u0010(\u001a\u0004\u0018\u00010\u00082\u0006\u0010\u0017\u001a\u00020\u00062\u0006\u0010&\u001a\u00020\u0008H\u0002\u00a2\u0006\u0002\u0010\'J\u0012\u0010)\u001a\u00020\u00192\u0008\u0010\u0017\u001a\u0004\u0018\u00010\u0006H\u0007J\u0018\u0010*\u001a\u00020\u000f2\u0006\u0010+\u001a\u00020,2\u0006\u0010-\u001a\u00020,H\u0002J\u0018\u0010.\u001a\u00020\u000f2\u0006\u0010+\u001a\u00020,2\u0006\u0010-\u001a\u00020,H\u0002J\u0018\u0010/\u001a\u00020\u00062\u0006\u00100\u001a\u00020\u00062\u0006\u00101\u001a\u00020\u0008H\u0002J\u0018\u00102\u001a\u00020\u00082\u0006\u0010\u0017\u001a\u00020\u00062\u0006\u0010&\u001a\u00020\u0008H\u0002J \u00103\u001a\u00020\u00082\u0006\u0010\u0017\u001a\u00020\u00062\u0006\u00104\u001a\u00020\u00082\u0006\u00105\u001a\u00020\u0008H\u0002J\u0010\u00106\u001a\u00020\u00062\u0006\u00107\u001a\u000208H\u0003J\u0006\u00109\u001a\u00020\u0019J\u0006\u0010\u000c\u001a\u00020\u000fJ\u001e\u0010:\u001a\u0010\u0012\u0004\u0012\u00020\u0008\u0012\u0004\u0012\u00020\u0008\u0018\u00010;2\u0006\u0010\u0017\u001a\u00020\u0006H\u0002J&\u0010<\u001a\u0010\u0012\u0004\u0012\u00020\u0008\u0012\u0004\u0012\u00020\u0008\u0018\u00010;2\u0006\u0010=\u001a\u00020\u00062\u0006\u0010>\u001a\u00020\u0008H\u0002J\u0006\u0010?\u001a\u00020\u0019J \u0010@\u001a\u00020A2\u0006\u0010B\u001a\u00020\u00062\u0006\u0010C\u001a\u00020\u00082\u0006\u0010D\u001a\u00020\u0008H\u0002J(\u0010E\u001a\u0004\u0018\u00010\u00062\u000c\u0010F\u001a\u0008\u0012\u0004\u0012\u00020\u00060G2\u0006\u0010C\u001a\u00020\u00082\u0006\u0010D\u001a\u00020\u0008H\u0002J\u0016\u0010H\u001a\u00020\u00192\u0006\u0010C\u001a\u00020\u00082\u0006\u0010D\u001a\u00020\u0008JS\u0010I\u001a\u00020\u00192K\u0010J\u001aG\u0012\u0013\u0012\u00110\u0006\u00a2\u0006\u000c\u0008\u0015\u0012\u0008\u0008\u0016\u0012\u0004\u0008\u0008(\u0017\u0012\u0013\u0012\u00110\u0008\u00a2\u0006\u000c\u0008\u0015\u0012\u0008\u0008\u0016\u0012\u0004\u0008\u0008(\u0018\u0012\u0013\u0012\u00110\u0008\u00a2\u0006\u000c\u0008\u0015\u0012\u0008\u0008\u0016\u0012\u0004\u0008\u0008(\u000b\u0012\u0004\u0012\u00020\u00190\u0014J\u0006\u0010K\u001a\u00020\u0019J\u0006\u0010L\u001a\u00020\u0019R\u000e\u0010\u0003\u001a\u00020\u0004X\u0082D\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0005\u001a\u00020\u0006X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0007\u001a\u00020\u0008X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\t\u001a\u00020\u0008X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\n\u001a\u00020\u0008X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u000b\u001a\u00020\u0008X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u000c\u001a\u00020\rX\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u000e\u001a\u00020\u000fX\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0010\u0010\u0010\u001a\u0004\u0018\u00010\u0011X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0012\u001a\u00020\u0006X\u0082\u000e\u00a2\u0006\u0002\n\u0000RU\u0010\u0013\u001aI\u0012\u0013\u0012\u00110\u0006\u00a2\u0006\u000c\u0008\u0015\u0012\u0008\u0008\u0016\u0012\u0004\u0008\u0008(\u0017\u0012\u0013\u0012\u00110\u0008\u00a2\u0006\u000c\u0008\u0015\u0012\u0008\u0008\u0016\u0012\u0004\u0008\u0008(\u0018\u0012\u0013\u0012\u00110\u0008\u00a2\u0006\u000c\u0008\u0015\u0012\u0008\u0008\u0016\u0012\u0004\u0008\u0008(\u000b\u0012\u0004\u0012\u00020\u0019\u0018\u00010\u0014X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u001a\u001a\u00020\u0008X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u001b\u001a\u00020\u0008X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u001c\u001a\u00020\u0006X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0018\u001a\u00020\u0008X\u0082\u000e\u00a2\u0006\u0002\n\u0000\u00a8\u0006M"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;",
        "",
        "()V",
        "TAG",
        "",
        "codecOutputTmp",
        "",
        "colorFormat",
        "",
        "frameInterval",
        "frameRate",
        "height",
        "isCodecRunning",
        "Ljava/util/concurrent/atomic/AtomicBoolean;",
        "isInit",
        "",
        "mediaCodec",
        "Landroid/media/MediaCodec;",
        "nv21Buffer",
        "nv21DataFun",
        "Lkotlin/Function3;",
        "Lkotlin/ParameterName;",
        "name",
        "data",
        "width",
        "",
        "sliceHeight",
        "stride",
        "uvTmp",
        "convertBulkToNV21",
        "src",
        "srcStride",
        "srcSliceHeight",
        "dstW",
        "dstH",
        "assumeNV12",
        "convertPerRowToNV21",
        "decodeSE",
        "bitOffset",
        "([BI)Ljava/lang/Integer;",
        "decodeUE",
        "decoderH264StreamData",
        "detectIsNV12FromPlanes",
        "uBuffer",
        "Ljava/nio/ByteBuffer;",
        "vBuffer",
        "detectNV12BySampling",
        "ensureCapacity",
        "buf",
        "need",
        "getBit",
        "getBitPosition",
        "startBitOffset",
        "value",
        "imageToNV21",
        "image",
        "Landroid/media/Image;",
        "initDecoder",
        "parseSPSResolution",
        "Lkotlin/Pair;",
        "parseSPSWidthHeight",
        "sps",
        "offset",
        "release",
        "scoreNV21Frame",
        "",
        "nv21",
        "w",
        "h",
        "selectBestCandidate",
        "cands",
        "",
        "setExpectedSize",
        "setNv21DataCallback",
        "callback",
        "start",
        "stop",
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

.field private codecOutputTmp:[B

.field private colorFormat:I

.field private frameInterval:I

.field private frameRate:I

.field private height:I

.field private final isCodecRunning:Ljava/util/concurrent/atomic/AtomicBoolean;

.field private isInit:Z

.field private mediaCodec:Landroid/media/MediaCodec;

.field private nv21Buffer:[B

.field private nv21DataFun:Lkotlin/jvm/functions/Function3;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lkotlin/jvm/functions/Function3<",
            "-[B-",
            "Ljava/lang/Integer;",
            "-",
            "Ljava/lang/Integer;",
            "Lkotlin/Unit;",
            ">;"
        }
    .end annotation
.end field

.field private sliceHeight:I

.field private stride:I

.field private uvTmp:[B

.field private width:I


# direct methods
.method public constructor <init>()V
    .locals 2

    .line 22
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 23
    const-string v0, "H264StreamDecoder"

    iput-object v0, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->TAG:Ljava/lang/String;

    .line 26
    const/16 v0, 0x438

    iput v0, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->width:I

    .line 27
    const/16 v0, 0x780

    iput v0, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->height:I

    .line 28
    const/16 v0, 0x14

    iput v0, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->frameRate:I

    .line 29
    const/4 v0, 0x1

    iput v0, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->frameInterval:I

    .line 31
    new-instance v0, Ljava/util/concurrent/atomic/AtomicBoolean;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Ljava/util/concurrent/atomic/AtomicBoolean;-><init>(Z)V

    iput-object v0, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->isCodecRunning:Ljava/util/concurrent/atomic/AtomicBoolean;

    .line 39
    const v0, 0x7f420888

    iput v0, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->colorFormat:I

    .line 41
    new-array v0, v1, [B

    iput-object v0, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->nv21Buffer:[B

    .line 42
    new-array v0, v1, [B

    iput-object v0, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->codecOutputTmp:[B

    .line 43
    new-array v0, v1, [B

    iput-object v0, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->uvTmp:[B

    .line 22
    return-void
.end method

.method private final convertBulkToNV21([BIIIIZ)[B
    .locals 15
    .param p1, "src"    # [B
    .param p2, "srcStride"    # I
    .param p3, "srcSliceHeight"    # I
    .param p4, "dstW"    # I
    .param p5, "dstH"    # I
    .param p6, "assumeNV12"    # Z

    .line 297
    move-object v0, p0

    move-object/from16 v1, p1

    move/from16 v2, p4

    move/from16 v3, p5

    mul-int v4, v2, v3

    .line 298
    .local v4, "ySize":I
    div-int/lit8 v5, v4, 0x2

    .line 299
    .local v5, "uvSize":I
    iget-object v6, v0, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->nv21Buffer:[B

    array-length v6, v6

    add-int v7, v4, v5

    if-ge v6, v7, :cond_0

    add-int v6, v4, v5

    new-array v6, v6, [B

    iput-object v6, v0, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->nv21Buffer:[B

    .line 300
    :cond_0
    iget-object v6, v0, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->uvTmp:[B

    array-length v6, v6

    if-ge v6, v5, :cond_1

    new-array v6, v5, [B

    iput-object v6, v0, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->uvTmp:[B

    .line 302
    :cond_1
    move/from16 v6, p2

    .line 303
    .local v6, "srcRowStride":I
    mul-int v7, v6, p3

    .line 306
    .local v7, "srcUVOffset":I
    const/4 v8, 0x0

    .local v8, "r":I
    :goto_0
    const/4 v9, 0x0

    if-ge v8, v3, :cond_2

    .line 307
    mul-int v10, v8, v6

    .line 308
    .local v10, "sPos":I
    mul-int v11, v8, v2

    .line 309
    .local v11, "dPos":I
    array-length v12, v1

    sub-int/2addr v12, v10

    invoke-static {v9, v12}, Ljava/lang/Math;->max(II)I

    move-result v9

    invoke-static {v2, v9}, Ljava/lang/Math;->min(II)I

    move-result v9

    .line 310
    .local v9, "copyLen":I
    iget-object v12, v0, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->nv21Buffer:[B

    invoke-static {v1, v10, v12, v11, v9}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 306
    .end local v9    # "copyLen":I
    .end local v10    # "sPos":I
    .end local v11    # "dPos":I
    add-int/lit8 v8, v8, 0x1

    goto :goto_0

    .line 314
    .end local v8    # "r":I
    :cond_2
    array-length v8, v1

    sub-int/2addr v8, v7

    invoke-static {v9, v8}, Ljava/lang/Math;->max(II)I

    move-result v8

    invoke-static {v5, v8}, Ljava/lang/Math;->min(II)I

    move-result v8

    .line 315
    .local v8, "copyLen":I
    if-gtz v8, :cond_3

    const/4 v9, 0x0

    return-object v9

    .line 316
    :cond_3
    iget-object v10, v0, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->uvTmp:[B

    invoke-static {v1, v7, v10, v9, v8}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 319
    const/4 v9, 0x0

    .line 320
    .local v9, "i":I
    move v10, v4

    .line 321
    .local v10, "dstPos":I
    :goto_1
    add-int/lit8 v11, v9, 0x1

    if-ge v11, v8, :cond_5

    add-int/lit8 v11, v10, 0x1

    iget-object v12, v0, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->nv21Buffer:[B

    array-length v12, v12

    if-ge v11, v12, :cond_5

    .line 322
    iget-object v11, v0, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->uvTmp:[B

    aget-byte v11, v11, v9

    .line 323
    .local v11, "b1":B
    iget-object v12, v0, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->uvTmp:[B

    add-int/lit8 v13, v9, 0x1

    aget-byte v12, v12, v13

    .line 324
    .local v12, "b2":B
    if-eqz p6, :cond_4

    .line 326
    iget-object v13, v0, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->nv21Buffer:[B

    add-int/lit8 v14, v10, 0x1

    .end local v10    # "dstPos":I
    .local v14, "dstPos":I
    aput-byte v12, v13, v10

    .line 327
    iget-object v10, v0, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->nv21Buffer:[B

    add-int/lit8 v13, v14, 0x1

    .end local v14    # "dstPos":I
    .local v13, "dstPos":I
    aput-byte v11, v10, v14

    move v10, v13

    goto :goto_2

    .line 330
    .end local v13    # "dstPos":I
    .restart local v10    # "dstPos":I
    :cond_4
    iget-object v13, v0, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->nv21Buffer:[B

    add-int/lit8 v14, v10, 0x1

    .end local v10    # "dstPos":I
    .restart local v14    # "dstPos":I
    aput-byte v11, v13, v10

    .line 331
    iget-object v10, v0, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->nv21Buffer:[B

    add-int/lit8 v13, v14, 0x1

    .end local v14    # "dstPos":I
    .restart local v13    # "dstPos":I
    aput-byte v12, v10, v14

    move v10, v13

    .end local v13    # "dstPos":I
    .restart local v10    # "dstPos":I
    :goto_2
    add-int/lit8 v9, v9, 0x2

    .line 333
    nop

    .end local v11    # "b1":B
    .end local v12    # "b2":B
    goto :goto_1

    .line 335
    :cond_5
    iget-object v11, v0, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->nv21Buffer:[B

    return-object v11
.end method

.method private final convertPerRowToNV21([BIIIIZ)[B
    .locals 17
    .param p1, "src"    # [B
    .param p2, "srcStride"    # I
    .param p3, "srcSliceHeight"    # I
    .param p4, "dstW"    # I
    .param p5, "dstH"    # I
    .param p6, "assumeNV12"    # Z

    .line 340
    move-object/from16 v0, p0

    move-object/from16 v1, p1

    move/from16 v2, p4

    move/from16 v3, p5

    mul-int v4, v2, v3

    .line 341
    .local v4, "ySize":I
    div-int/lit8 v5, v4, 0x2

    .line 342
    .local v5, "uvSize":I
    iget-object v6, v0, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->nv21Buffer:[B

    array-length v6, v6

    add-int v7, v4, v5

    if-ge v6, v7, :cond_0

    add-int v6, v4, v5

    new-array v6, v6, [B

    iput-object v6, v0, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->nv21Buffer:[B

    .line 344
    :cond_0
    move/from16 v6, p2

    .line 345
    .local v6, "srcRowStride":I
    mul-int v7, v6, p3

    .line 346
    .local v7, "srcUVOffset":I
    move v8, v6

    .line 347
    .local v8, "uvRowStride":I
    div-int/lit8 v9, v3, 0x2

    .line 350
    .local v9, "chH":I
    const/4 v10, 0x0

    .local v10, "r":I
    :goto_0
    if-ge v10, v3, :cond_1

    .line 351
    mul-int v11, v10, v6

    .line 352
    .local v11, "sPos":I
    mul-int v12, v10, v2

    .line 353
    .local v12, "dPos":I
    array-length v13, v1

    sub-int/2addr v13, v11

    const/4 v14, 0x0

    invoke-static {v14, v13}, Ljava/lang/Math;->max(II)I

    move-result v13

    invoke-static {v2, v13}, Ljava/lang/Math;->min(II)I

    move-result v13

    .line 354
    .local v13, "copyLen":I
    iget-object v14, v0, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->nv21Buffer:[B

    invoke-static {v1, v11, v14, v12, v13}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 350
    .end local v11    # "sPos":I
    .end local v12    # "dPos":I
    .end local v13    # "copyLen":I
    add-int/lit8 v10, v10, 0x1

    goto :goto_0

    .line 358
    .end local v10    # "r":I
    :cond_1
    move v10, v4

    .line 359
    .local v10, "dstPos":I
    const/4 v11, 0x0

    .local v11, "r":I
    :goto_1
    if-ge v11, v9, :cond_4

    .line 360
    mul-int v12, v11, v8

    add-int/2addr v12, v7

    .line 361
    .local v12, "rowStart":I
    const/4 v13, 0x0

    .line 362
    .local v13, "i":I
    :goto_2
    add-int/lit8 v14, v13, 0x1

    if-ge v14, v2, :cond_3

    add-int v14, v12, v13

    add-int/lit8 v14, v14, 0x1

    array-length v15, v1

    if-ge v14, v15, :cond_3

    add-int/lit8 v14, v10, 0x1

    iget-object v15, v0, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->nv21Buffer:[B

    array-length v15, v15

    if-ge v14, v15, :cond_3

    .line 363
    add-int v14, v12, v13

    aget-byte v14, v1, v14

    .line 364
    .local v14, "bU":B
    add-int v15, v12, v13

    add-int/lit8 v15, v15, 0x1

    aget-byte v15, v1, v15

    .line 365
    .local v15, "bV":B
    if-eqz p6, :cond_2

    .line 366
    iget-object v1, v0, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->nv21Buffer:[B

    add-int/lit8 v16, v10, 0x1

    .end local v10    # "dstPos":I
    .local v16, "dstPos":I
    aput-byte v15, v1, v10

    .line 367
    iget-object v1, v0, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->nv21Buffer:[B

    add-int/lit8 v10, v16, 0x1

    .end local v16    # "dstPos":I
    .restart local v10    # "dstPos":I
    aput-byte v14, v1, v16

    goto :goto_3

    .line 369
    :cond_2
    iget-object v1, v0, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->nv21Buffer:[B

    add-int/lit8 v16, v10, 0x1

    .end local v10    # "dstPos":I
    .restart local v16    # "dstPos":I
    aput-byte v14, v1, v10

    .line 370
    iget-object v1, v0, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->nv21Buffer:[B

    add-int/lit8 v10, v16, 0x1

    .end local v16    # "dstPos":I
    .restart local v10    # "dstPos":I
    aput-byte v15, v1, v16

    :goto_3
    add-int/lit8 v13, v13, 0x2

    .line 372
    move-object/from16 v1, p1

    .end local v14    # "bU":B
    .end local v15    # "bV":B
    goto :goto_2

    .line 359
    .end local v12    # "rowStart":I
    .end local v13    # "i":I
    :cond_3
    add-int/lit8 v11, v11, 0x1

    move-object/from16 v1, p1

    goto :goto_1

    .line 375
    .end local v11    # "r":I
    :cond_4
    iget-object v1, v0, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->nv21Buffer:[B

    return-object v1
.end method

.method private final decodeSE([BI)Ljava/lang/Integer;
    .locals 3
    .param p1, "data"    # [B
    .param p2, "bitOffset"    # I

    .line 665
    invoke-direct {p0, p1, p2}, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->decodeUE([BI)Ljava/lang/Integer;

    move-result-object v0

    if-eqz v0, :cond_1

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    .line 667
    .local v0, "ue":I
    rem-int/lit8 v1, v0, 0x2

    const/4 v2, 0x1

    if-ne v1, v2, :cond_0

    add-int/lit8 v1, v0, 0x1

    div-int/lit8 v1, v1, 0x2

    goto :goto_0

    :cond_0
    div-int/lit8 v1, v0, 0x2

    neg-int v1, v1

    :goto_0
    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    return-object v1

    .line 665
    .end local v0    # "ue":I
    :cond_1
    const/4 v0, 0x0

    return-object v0
.end method

.method private final decodeUE([BI)Ljava/lang/Integer;
    .locals 8
    .param p1, "data"    # [B
    .param p2, "bitOffset"    # I

    .line 636
    move v0, p2

    .line 637
    .local v0, "pos":I
    const/4 v1, 0x0

    .line 640
    .local v1, "leadingZeros":I
    :goto_0
    array-length v2, p1

    mul-int/lit8 v2, v2, 0x8

    if-ge v0, v2, :cond_0

    invoke-direct {p0, p1, v0}, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->getBit([BI)I

    move-result v2

    if-nez v2, :cond_0

    .line 641
    add-int/lit8 v1, v1, 0x1

    .line 642
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 645
    :cond_0
    array-length v2, p1

    mul-int/lit8 v2, v2, 0x8

    const/4 v3, 0x0

    if-lt v0, v2, :cond_1

    return-object v3

    .line 648
    :cond_1
    const/4 v2, 0x1

    add-int/2addr v0, v2

    .line 651
    const/4 v4, 0x0

    .line 652
    .local v4, "value":I
    const/4 v5, 0x0

    .local v5, "i":I
    :goto_1
    if-ge v5, v1, :cond_3

    .line 653
    array-length v6, p1

    mul-int/lit8 v6, v6, 0x8

    if-lt v0, v6, :cond_2

    return-object v3

    .line 654
    :cond_2
    shl-int/lit8 v6, v4, 0x1

    invoke-direct {p0, p1, v0}, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->getBit([BI)I

    move-result v7

    or-int v4, v6, v7

    .line 655
    add-int/lit8 v0, v0, 0x1

    .line 652
    add-int/lit8 v5, v5, 0x1

    goto :goto_1

    .line 658
    .end local v5    # "i":I
    :cond_3
    shl-int v3, v2, v1

    add-int/2addr v3, v4

    sub-int/2addr v3, v2

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    return-object v2
.end method

.method private final detectIsNV12FromPlanes(Ljava/nio/ByteBuffer;Ljava/nio/ByteBuffer;)Z
    .locals 5
    .param p1, "uBuffer"    # Ljava/nio/ByteBuffer;
    .param p2, "vBuffer"    # Ljava/nio/ByteBuffer;

    .line 493
    invoke-virtual {p1}, Ljava/nio/ByteBuffer;->remaining()I

    move-result v0

    invoke-virtual {p2}, Ljava/nio/ByteBuffer;->remaining()I

    move-result v1

    invoke-static {v0, v1}, Ljava/lang/Math;->min(II)I

    move-result v0

    const/16 v1, 0x20

    invoke-static {v1, v0}, Ljava/lang/Math;->min(II)I

    move-result v0

    .line 494
    .local v0, "sample":I
    const/4 v1, 0x0

    .line 495
    .local v1, "uSum":I
    const/4 v2, 0x0

    .line 496
    .local v2, "vSum":I
    const/4 v3, 0x0

    .local v3, "i":I
    :goto_0
    if-ge v3, v0, :cond_0

    .line 497
    invoke-virtual {p1, v3}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v4

    and-int/lit16 v4, v4, 0xff

    add-int/2addr v1, v4

    .line 498
    invoke-virtual {p2, v3}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v4

    and-int/lit16 v4, v4, 0xff

    add-int/2addr v2, v4

    .line 496
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    .line 500
    .end local v3    # "i":I
    :cond_0
    if-le v1, v2, :cond_1

    const/4 v3, 0x1

    goto :goto_1

    :cond_1
    const/4 v3, 0x0

    :goto_1
    return v3
.end method

.method private final detectNV12BySampling(Ljava/nio/ByteBuffer;Ljava/nio/ByteBuffer;)Z
    .locals 6
    .param p1, "uBuffer"    # Ljava/nio/ByteBuffer;
    .param p2, "vBuffer"    # Ljava/nio/ByteBuffer;

    .line 280
    invoke-virtual {p1}, Ljava/nio/ByteBuffer;->rewind()Ljava/nio/Buffer;

    .line 281
    invoke-virtual {p2}, Ljava/nio/ByteBuffer;->rewind()Ljava/nio/Buffer;

    .line 283
    invoke-virtual {p1}, Ljava/nio/ByteBuffer;->remaining()I

    move-result v0

    invoke-virtual {p2}, Ljava/nio/ByteBuffer;->remaining()I

    move-result v1

    const/16 v2, 0x40

    invoke-static {v1, v2}, Ljava/lang/Math;->min(II)I

    move-result v1

    invoke-static {v0, v1}, Ljava/lang/Math;->min(II)I

    move-result v0

    .line 284
    .local v0, "sampleCount":I
    const/4 v1, 0x0

    .line 285
    .local v1, "diffSum":I
    const/4 v2, 0x0

    .local v2, "i":I
    :goto_0
    if-ge v2, v0, :cond_0

    .line 286
    invoke-virtual {p1, v2}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v3

    .line 287
    .local v3, "u":B
    invoke-virtual {p2, v2}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v4

    .line 288
    .local v4, "v":B
    sub-int v5, v3, v4

    add-int/2addr v1, v5

    .line 285
    .end local v3    # "u":B
    .end local v4    # "v":B
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 291
    .end local v2    # "i":I
    :cond_0
    if-lez v1, :cond_1

    const/4 v2, 0x1

    goto :goto_1

    :cond_1
    const/4 v2, 0x0

    :goto_1
    return v2
.end method

.method private final ensureCapacity([BI)[B
    .locals 1
    .param p1, "buf"    # [B
    .param p2, "need"    # I

    .line 223
    array-length v0, p1

    if-ge v0, p2, :cond_0

    new-array v0, p2, [B

    goto :goto_0

    :cond_0
    move-object v0, p1

    :goto_0
    return-object v0
.end method

.method private final getBit([BI)I
    .locals 3
    .param p1, "data"    # [B
    .param p2, "bitOffset"    # I

    .line 674
    div-int/lit8 v0, p2, 0x8

    .line 675
    .local v0, "byteIndex":I
    rem-int/lit8 v1, p2, 0x8

    rsub-int/lit8 v1, v1, 0x7

    .line 676
    .local v1, "bitIndex":I
    array-length v2, p1

    if-lt v0, v2, :cond_0

    const/4 v2, 0x0

    return v2

    .line 677
    :cond_0
    aget-byte v2, p1, v0

    shr-int/2addr v2, v1

    and-int/lit8 v2, v2, 0x1

    return v2
.end method

.method private final getBitPosition([BII)I
    .locals 3
    .param p1, "data"    # [B
    .param p2, "startBitOffset"    # I
    .param p3, "value"    # I

    .line 686
    move v0, p2

    .line 687
    .local v0, "pos":I
    const/4 v1, 0x0

    .line 688
    .local v1, "leadingZeros":I
    :goto_0
    invoke-direct {p0, p1, v0}, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->getBit([BI)I

    move-result v2

    if-nez v2, :cond_0

    array-length v2, p1

    mul-int/lit8 v2, v2, 0x8

    if-ge v0, v2, :cond_0

    .line 689
    add-int/lit8 v1, v1, 0x1

    .line 690
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 692
    :cond_0
    add-int/lit8 v0, v0, 0x1

    .line 693
    add-int/2addr v0, v1

    .line 694
    return v0
.end method

.method private final imageToNV21(Landroid/media/Image;)[B
    .locals 28
    .param p1, "image"    # Landroid/media/Image;

    .line 229
    move-object/from16 v0, p0

    invoke-virtual/range {p1 .. p1}, Landroid/media/Image;->getWidth()I

    move-result v1

    .line 230
    .local v1, "width":I
    invoke-virtual/range {p1 .. p1}, Landroid/media/Image;->getHeight()I

    move-result v2

    .line 231
    .local v2, "height":I
    mul-int v3, v1, v2

    .line 232
    .local v3, "ySize":I
    div-int/lit8 v4, v3, 0x2

    .line 233
    .local v4, "uvSize":I
    iget-object v5, v0, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->nv21Buffer:[B

    array-length v5, v5

    add-int v6, v3, v4

    if-ge v5, v6, :cond_0

    add-int v5, v3, v4

    new-array v5, v5, [B

    iput-object v5, v0, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->nv21Buffer:[B

    .line 235
    :cond_0
    invoke-virtual/range {p1 .. p1}, Landroid/media/Image;->getPlanes()[Landroid/media/Image$Plane;

    move-result-object v5

    .line 236
    .local v5, "planes":[Landroid/media/Image$Plane;
    const/4 v6, 0x0

    aget-object v6, v5, v6

    .line 237
    .local v6, "yPlane":Landroid/media/Image$Plane;
    const/4 v7, 0x1

    aget-object v7, v5, v7

    .line 238
    .local v7, "uPlane":Landroid/media/Image$Plane;
    const/4 v8, 0x2

    aget-object v8, v5, v8

    .line 240
    .local v8, "vPlane":Landroid/media/Image$Plane;
    invoke-virtual {v6}, Landroid/media/Image$Plane;->getBuffer()Ljava/nio/ByteBuffer;

    move-result-object v9

    .line 241
    .local v9, "yBuffer":Ljava/nio/ByteBuffer;
    invoke-virtual {v7}, Landroid/media/Image$Plane;->getBuffer()Ljava/nio/ByteBuffer;

    move-result-object v10

    .line 242
    .local v10, "uBuffer":Ljava/nio/ByteBuffer;
    invoke-virtual {v8}, Landroid/media/Image$Plane;->getBuffer()Ljava/nio/ByteBuffer;

    move-result-object v11

    .line 244
    .local v11, "vBuffer":Ljava/nio/ByteBuffer;
    invoke-virtual {v6}, Landroid/media/Image$Plane;->getRowStride()I

    move-result v12

    .line 245
    .local v12, "yRowStride":I
    invoke-virtual {v7}, Landroid/media/Image$Plane;->getRowStride()I

    move-result v13

    .line 246
    .local v13, "uRowStride":I
    invoke-virtual {v8}, Landroid/media/Image$Plane;->getRowStride()I

    move-result v14

    .line 247
    .local v14, "vRowStride":I
    invoke-virtual {v7}, Landroid/media/Image$Plane;->getPixelStride()I

    move-result v15

    .line 248
    .local v15, "uPixelStride":I
    invoke-virtual {v8}, Landroid/media/Image$Plane;->getPixelStride()I

    move-result v16

    .line 251
    .local v16, "vPixelStride":I
    const/16 v17, 0x0

    .line 252
    .local v17, "pos":I
    const/16 v18, 0x0

    move/from16 v19, v3

    move/from16 v3, v17

    move/from16 v17, v4

    move/from16 v4, v18

    .local v3, "pos":I
    .local v4, "r":I
    .local v17, "uvSize":I
    .local v19, "ySize":I
    :goto_0
    if-ge v4, v2, :cond_1

    .line 253
    move-object/from16 v18, v5

    .end local v5    # "planes":[Landroid/media/Image$Plane;
    .local v18, "planes":[Landroid/media/Image$Plane;
    mul-int v5, v4, v12

    invoke-virtual {v9, v5}, Ljava/nio/ByteBuffer;->position(I)Ljava/nio/Buffer;

    .line 254
    iget-object v5, v0, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->nv21Buffer:[B

    invoke-virtual {v9, v5, v3, v1}, Ljava/nio/ByteBuffer;->get([BII)Ljava/nio/ByteBuffer;

    .line 255
    add-int/2addr v3, v1

    .line 252
    add-int/lit8 v4, v4, 0x1

    move-object/from16 v5, v18

    goto :goto_0

    .end local v18    # "planes":[Landroid/media/Image$Plane;
    .restart local v5    # "planes":[Landroid/media/Image$Plane;
    :cond_1
    move-object/from16 v18, v5

    .line 258
    .end local v4    # "r":I
    .end local v5    # "planes":[Landroid/media/Image$Plane;
    .restart local v18    # "planes":[Landroid/media/Image$Plane;
    div-int/lit8 v4, v2, 0x2

    .line 260
    .local v4, "halfH":I
    const/4 v5, 0x0

    .local v5, "r":I
    :goto_1
    if-ge v5, v4, :cond_3

    .line 261
    const/16 v20, 0x0

    move/from16 v27, v20

    move/from16 v20, v2

    move/from16 v2, v27

    .line 262
    .local v2, "c":I
    .local v20, "height":I
    :goto_2
    move/from16 v21, v4

    .end local v4    # "halfH":I
    .local v21, "halfH":I
    div-int/lit8 v4, v1, 0x2

    if-ge v2, v4, :cond_2

    .line 263
    mul-int v4, v5, v13

    mul-int v22, v2, v15

    add-int v4, v4, v22

    .line 264
    .local v4, "uIndex":I
    mul-int v22, v5, v14

    mul-int v23, v2, v16

    move/from16 v24, v1

    .end local v1    # "width":I
    .local v24, "width":I
    add-int v1, v22, v23

    .line 265
    .local v1, "vIndex":I
    invoke-virtual {v10, v4}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v22

    .line 266
    .local v22, "u":B
    invoke-virtual {v11, v1}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v23

    .line 267
    .local v23, "v":B
    move/from16 v25, v1

    .end local v1    # "vIndex":I
    .local v25, "vIndex":I
    iget-object v1, v0, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->nv21Buffer:[B

    add-int/lit8 v26, v3, 0x1

    .end local v3    # "pos":I
    .local v26, "pos":I
    aput-byte v23, v1, v3

    .line 268
    iget-object v1, v0, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->nv21Buffer:[B

    add-int/lit8 v3, v26, 0x1

    .end local v26    # "pos":I
    .restart local v3    # "pos":I
    aput-byte v22, v1, v26

    .line 269
    nop

    .end local v4    # "uIndex":I
    .end local v22    # "u":B
    .end local v23    # "v":B
    .end local v25    # "vIndex":I
    add-int/lit8 v2, v2, 0x1

    move/from16 v4, v21

    move/from16 v1, v24

    goto :goto_2

    .line 262
    .end local v24    # "width":I
    .local v1, "width":I
    :cond_2
    move/from16 v24, v1

    .line 260
    .end local v1    # "width":I
    .end local v2    # "c":I
    .restart local v24    # "width":I
    add-int/lit8 v5, v5, 0x1

    move/from16 v2, v20

    move/from16 v4, v21

    goto :goto_1

    .end local v20    # "height":I
    .end local v21    # "halfH":I
    .end local v24    # "width":I
    .restart local v1    # "width":I
    .local v2, "height":I
    .local v4, "halfH":I
    :cond_3
    move/from16 v24, v1

    .line 272
    .end local v1    # "width":I
    .end local v5    # "r":I
    .restart local v24    # "width":I
    iget-object v1, v0, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->nv21Buffer:[B

    return-object v1
.end method

.method private final parseSPSResolution([B)Lkotlin/Pair;
    .locals 7
    .param p1, "data"    # [B
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "([B)",
            "Lkotlin/Pair<",
            "Ljava/lang/Integer;",
            "Ljava/lang/Integer;",
            ">;"
        }
    .end annotation

    .line 509
    nop

    .line 511
    const/4 v0, 0x0

    .line 512
    .local v0, "i":I
    :goto_0
    :try_start_0
    array-length v1, p1

    add-int/lit8 v1, v1, -0x4

    if-ge v0, v1, :cond_3

    .line 514
    aget-byte v1, p1, v0

    if-nez v1, :cond_2

    add-int/lit8 v1, v0, 0x1

    aget-byte v1, p1, v1

    if-nez v1, :cond_2

    .line 515
    const/4 v1, 0x0

    .line 516
    .local v1, "startCodeLen":I
    add-int/lit8 v2, v0, 0x2

    aget-byte v2, p1, v2

    const/4 v3, 0x1

    if-nez v2, :cond_0

    add-int/lit8 v2, v0, 0x3

    aget-byte v2, p1, v2

    if-ne v2, v3, :cond_0

    .line 517
    const/4 v1, 0x4

    goto :goto_1

    .line 518
    :cond_0
    add-int/lit8 v2, v0, 0x2

    aget-byte v2, p1, v2

    if-ne v2, v3, :cond_1

    .line 519
    const/4 v1, 0x3

    .line 522
    :cond_1
    :goto_1
    if-lez v1, :cond_2

    .line 523
    add-int v2, v0, v1

    aget-byte v2, p1, v2

    and-int/lit8 v2, v2, 0x1f

    .line 524
    .local v2, "nalType":I
    const/4 v4, 0x7

    if-ne v2, v4, :cond_2

    .line 525
    iget-object v4, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->TAG:Ljava/lang/String;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "Found SPS NALU at offset "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    filled-new-array {v5}, [Ljava/lang/Object;

    move-result-object v5

    invoke-static {v4, v5}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 526
    add-int v4, v0, v1

    add-int/2addr v4, v3

    invoke-direct {p0, p1, v4}, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->parseSPSWidthHeight([BI)Lkotlin/Pair;

    move-result-object v3
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-object v3

    .line 530
    .end local v1    # "startCodeLen":I
    .end local v2    # "nalType":I
    :cond_2
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 532
    .end local v0    # "i":I
    :catch_0
    move-exception v0

    .line 533
    .local v0, "e":Ljava/lang/Exception;
    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->TAG:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "parseSPSResolution error: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->w(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 535
    .end local v0    # "e":Ljava/lang/Exception;
    :cond_3
    const/4 v0, 0x0

    return-object v0
.end method

.method private final parseSPSWidthHeight([BI)Lkotlin/Pair;
    .locals 18
    .param p1, "sps"    # [B
    .param p2, "offset"    # I
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "([BI)",
            "Lkotlin/Pair<",
            "Ljava/lang/Integer;",
            "Ljava/lang/Integer;",
            ">;"
        }
    .end annotation

    .line 543
    move-object/from16 v1, p0

    move-object/from16 v2, p1

    .line 544
    const/4 v3, 0x0

    :try_start_0
    array-length v0, v2

    add-int/lit8 v4, p2, 0x4

    if-ge v0, v4, :cond_0

    return-object v3

    .line 547
    :cond_0
    aget-byte v0, v2, p2

    and-int/lit16 v0, v0, 0xff

    .line 549
    .local v0, "profileIdc":I
    add-int/lit8 v4, p2, 0x1

    aget-byte v4, v2, v4

    and-int/lit16 v4, v4, 0xff

    .line 551
    .local v4, "constraintSet":I
    add-int/lit8 v5, p2, 0x2

    aget-byte v5, v2, v5

    and-int/lit16 v5, v5, 0xff

    .line 554
    .local v5, "levelIdc":I
    add-int/lit8 v6, p2, 0x3

    invoke-direct {v1, v2, v6}, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->decodeUE([BI)Ljava/lang/Integer;

    move-result-object v6

    .line 555
    .local v6, "spsId":Ljava/lang/Integer;
    if-nez v6, :cond_1

    return-object v3

    .line 557
    :cond_1
    add-int/lit8 v7, p2, 0x3

    invoke-virtual {v6}, Ljava/lang/Integer;->intValue()I

    move-result v8

    invoke-direct {v1, v2, v7, v8}, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->getBitPosition([BII)I

    move-result v7

    .line 560
    .local v7, "bitOffset":I
    invoke-direct {v1, v2, v7}, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->decodeUE([BI)Ljava/lang/Integer;

    move-result-object v8

    .line 561
    .local v8, "log2MaxFrameNum":Ljava/lang/Integer;
    if-nez v8, :cond_2

    return-object v3

    .line 562
    :cond_2
    invoke-virtual {v8}, Ljava/lang/Integer;->intValue()I

    move-result v9

    invoke-direct {v1, v2, v7, v9}, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->getBitPosition([BII)I

    move-result v9

    move v7, v9

    .line 565
    invoke-direct {v1, v2, v7}, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->decodeUE([BI)Ljava/lang/Integer;

    move-result-object v9

    .line 566
    .local v9, "pocType":Ljava/lang/Integer;
    if-nez v9, :cond_3

    return-object v3

    .line 567
    :cond_3
    invoke-virtual {v9}, Ljava/lang/Integer;->intValue()I

    move-result v10

    invoke-direct {v1, v2, v7, v10}, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->getBitPosition([BII)I

    move-result v10

    move v7, v10

    .line 569
    invoke-virtual {v9}, Ljava/lang/Integer;->intValue()I

    move-result v10

    const/4 v11, 0x1

    if-nez v10, :cond_5

    .line 570
    invoke-direct {v1, v2, v7}, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->decodeUE([BI)Ljava/lang/Integer;

    move-result-object v10

    .line 571
    .local v10, "log2MaxPocLsb":Ljava/lang/Integer;
    if-nez v10, :cond_4

    return-object v3

    .line 572
    :cond_4
    invoke-virtual {v10}, Ljava/lang/Integer;->intValue()I

    move-result v12

    invoke-direct {v1, v2, v7, v12}, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->getBitPosition([BII)I

    move-result v12

    move v7, v12

    .end local v10    # "log2MaxPocLsb":Ljava/lang/Integer;
    goto :goto_1

    .line 573
    :cond_5
    invoke-virtual {v9}, Ljava/lang/Integer;->intValue()I

    move-result v10

    if-ne v10, v11, :cond_a

    .line 575
    add-int/lit8 v7, v7, 0x1

    .line 577
    invoke-direct {v1, v2, v7}, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->decodeSE([BI)Ljava/lang/Integer;

    move-result-object v10

    .line 578
    .local v10, "offset1":Ljava/lang/Integer;
    if-nez v10, :cond_6

    return-object v3

    .line 579
    :cond_6
    invoke-virtual {v10}, Ljava/lang/Integer;->intValue()I

    move-result v12

    invoke-direct {v1, v2, v7, v12}, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->getBitPosition([BII)I

    move-result v12

    move v7, v12

    .line 581
    invoke-direct {v1, v2, v7}, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->decodeSE([BI)Ljava/lang/Integer;

    move-result-object v12

    .line 582
    .local v12, "offset2":Ljava/lang/Integer;
    if-nez v12, :cond_7

    return-object v3

    .line 583
    :cond_7
    invoke-virtual {v12}, Ljava/lang/Integer;->intValue()I

    move-result v13

    invoke-direct {v1, v2, v7, v13}, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->getBitPosition([BII)I

    move-result v13

    move v7, v13

    .line 585
    invoke-direct {v1, v2, v7}, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->decodeUE([BI)Ljava/lang/Integer;

    move-result-object v13

    .line 586
    .local v13, "numRefFrames":Ljava/lang/Integer;
    if-nez v13, :cond_8

    return-object v3

    .line 587
    :cond_8
    invoke-virtual {v13}, Ljava/lang/Integer;->intValue()I

    move-result v14

    invoke-direct {v1, v2, v7, v14}, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->getBitPosition([BII)I

    move-result v14

    move v7, v14

    .line 588
    const/4 v14, 0x0

    .local v14, "i":I
    invoke-virtual {v13}, Ljava/lang/Integer;->intValue()I

    move-result v15

    :goto_0
    if-ge v14, v15, :cond_a

    .line 589
    invoke-direct {v1, v2, v7}, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->decodeSE([BI)Ljava/lang/Integer;

    move-result-object v16

    .line 590
    .local v16, "offsetForRefFrame":Ljava/lang/Integer;
    if-nez v16, :cond_9

    return-object v3

    .line 591
    :cond_9
    invoke-virtual/range {v16 .. v16}, Ljava/lang/Integer;->intValue()I

    move-result v11

    invoke-direct {v1, v2, v7, v11}, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->getBitPosition([BII)I

    move-result v11

    move v7, v11

    .line 588
    .end local v16    # "offsetForRefFrame":Ljava/lang/Integer;
    add-int/lit8 v14, v14, 0x1

    const/4 v11, 0x1

    goto :goto_0

    .line 596
    .end local v10    # "offset1":Ljava/lang/Integer;
    .end local v12    # "offset2":Ljava/lang/Integer;
    .end local v13    # "numRefFrames":Ljava/lang/Integer;
    .end local v14    # "i":I
    :cond_a
    :goto_1
    invoke-direct {v1, v2, v7}, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->decodeUE([BI)Ljava/lang/Integer;

    move-result-object v10

    .line 597
    .local v10, "numRefFrames":Ljava/lang/Integer;
    if-nez v10, :cond_b

    return-object v3

    .line 598
    :cond_b
    invoke-virtual {v10}, Ljava/lang/Integer;->intValue()I

    move-result v11

    invoke-direct {v1, v2, v7, v11}, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->getBitPosition([BII)I

    move-result v11

    move v7, v11

    .line 601
    const/4 v11, 0x1

    add-int/2addr v7, v11

    .line 604
    invoke-direct {v1, v2, v7}, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->decodeUE([BI)Ljava/lang/Integer;

    move-result-object v11

    .line 605
    .local v11, "picWidthInMbsMinus1":Ljava/lang/Integer;
    if-nez v11, :cond_c

    return-object v3

    .line 606
    :cond_c
    invoke-virtual {v11}, Ljava/lang/Integer;->intValue()I

    move-result v12

    invoke-direct {v1, v2, v7, v12}, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->getBitPosition([BII)I

    move-result v12

    move v7, v12

    .line 609
    invoke-direct {v1, v2, v7}, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->decodeUE([BI)Ljava/lang/Integer;

    move-result-object v12

    .line 610
    .local v12, "picHeightInMapUnitsMinus1":Ljava/lang/Integer;
    if-nez v12, :cond_d

    return-object v3

    .line 611
    :cond_d
    invoke-virtual {v12}, Ljava/lang/Integer;->intValue()I

    move-result v13

    invoke-direct {v1, v2, v7, v13}, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->getBitPosition([BII)I

    move-result v13

    move v7, v13

    .line 614
    invoke-direct {v1, v2, v7}, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->getBit([BI)I

    move-result v13

    .line 615
    .local v13, "frameMbsOnlyFlag":I
    const/4 v14, 0x1

    add-int/2addr v7, v14

    .line 617
    invoke-virtual {v11}, Ljava/lang/Integer;->intValue()I

    move-result v15

    add-int/2addr v15, v14

    mul-int/lit8 v15, v15, 0x10

    .line 618
    .local v15, "width":I
    if-ne v13, v14, :cond_e

    .line 619
    invoke-virtual {v12}, Ljava/lang/Integer;->intValue()I

    move-result v16

    add-int/lit8 v16, v16, 0x1

    mul-int/lit8 v16, v16, 0x10

    goto :goto_2

    .line 621
    :cond_e
    invoke-virtual {v12}, Ljava/lang/Integer;->intValue()I

    move-result v16

    add-int/lit8 v16, v16, 0x1

    mul-int/lit8 v16, v16, 0x10

    mul-int/lit8 v16, v16, 0x2

    .line 618
    :goto_2
    move/from16 v14, v16

    .line 624
    .local v14, "height":I
    iget-object v3, v1, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->TAG:Ljava/lang/String;

    move/from16 v17, v0

    .end local v0    # "profileIdc":I
    .local v17, "profileIdc":I
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Parsed SPS: width="

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v15}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v2, ", height="

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v14}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v2, ", frame_mbs_only="

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v13}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v0

    invoke-static {v3, v0}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 625
    new-instance v0, Lkotlin/Pair;

    invoke-static {v15}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-static {v14}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-direct {v0, v2, v3}, Lkotlin/Pair;-><init>(Ljava/lang/Object;Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    .line 626
    .end local v4    # "constraintSet":I
    .end local v5    # "levelIdc":I
    .end local v6    # "spsId":Ljava/lang/Integer;
    .end local v7    # "bitOffset":I
    .end local v8    # "log2MaxFrameNum":Ljava/lang/Integer;
    .end local v9    # "pocType":Ljava/lang/Integer;
    .end local v10    # "numRefFrames":Ljava/lang/Integer;
    .end local v11    # "picWidthInMbsMinus1":Ljava/lang/Integer;
    .end local v12    # "picHeightInMapUnitsMinus1":Ljava/lang/Integer;
    .end local v13    # "frameMbsOnlyFlag":I
    .end local v14    # "height":I
    .end local v15    # "width":I
    .end local v17    # "profileIdc":I
    :catch_0
    move-exception v0

    .line 627
    .local v0, "e":Ljava/lang/Exception;
    iget-object v2, v1, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->TAG:Ljava/lang/String;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "parseSPSWidthHeight error: "

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

    invoke-static {v2, v3}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->w(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 628
    const/4 v2, 0x0

    return-object v2
.end method

.method private final scoreNV21Frame([BII)D
    .locals 42
    .param p1, "nv21"    # [B
    .param p2, "w"    # I
    .param p3, "h"    # I

    .line 403
    move-object/from16 v0, p1

    mul-int v1, p2, p3

    .line 404
    .local v1, "ySize":I
    div-int/lit8 v2, v1, 0x2

    .line 405
    .local v2, "uvSize":I
    array-length v3, v0

    add-int v4, v1, v2

    const-wide/high16 v5, -0x4010000000000000L    # -1.0

    if-ge v3, v4, :cond_0

    return-wide v5

    .line 408
    :cond_0
    const/16 v3, 0x80

    .line 409
    .local v3, "samples":I
    const-wide/16 v7, 0x0

    .line 410
    .local v7, "uSum":D
    const-wide/16 v9, 0x0

    .line 411
    .local v9, "vSum":D
    const-wide/16 v11, 0x0

    .line 412
    .local v11, "uSq":D
    const-wide/16 v13, 0x0

    .line 413
    .local v13, "vSq":D
    div-int/lit8 v4, v2, 0x2

    invoke-static {v3, v4}, Ljava/lang/Math;->min(II)I

    move-result v4

    .line 414
    .local v4, "maxPairs":I
    const/4 v15, 0x4

    if-gt v4, v15, :cond_1

    return-wide v5

    .line 416
    :cond_1
    div-int/lit8 v15, v2, 0x2

    div-int/2addr v15, v4

    const/4 v5, 0x1

    invoke-static {v5, v15}, Ljava/lang/Math;->max(II)I

    move-result v6

    .line 417
    .local v6, "step":I
    const/4 v15, 0x0

    .line 418
    .local v15, "idx":I
    const/16 v18, 0x0

    move/from16 v5, v18

    .line 419
    .local v5, "count":I
    :goto_0
    if-ge v5, v4, :cond_3

    .line 420
    mul-int/lit8 v19, v15, 0x2

    add-int v19, v1, v19

    .line 421
    .local v19, "pos":I
    move/from16 v20, v1

    .end local v1    # "ySize":I
    .local v20, "ySize":I
    add-int/lit8 v1, v19, 0x1

    move/from16 v21, v2

    .end local v2    # "uvSize":I
    .local v21, "uvSize":I
    array-length v2, v0

    if-ge v1, v2, :cond_2

    .line 422
    aget-byte v1, v0, v19

    and-int/lit16 v1, v1, 0xff

    int-to-double v1, v1

    .line 423
    .local v1, "v":D
    add-int/lit8 v22, v19, 0x1

    move/from16 v23, v3

    .end local v3    # "samples":I
    .local v23, "samples":I
    aget-byte v3, v0, v22

    and-int/lit16 v3, v3, 0xff

    move/from16 v22, v4

    .end local v4    # "maxPairs":I
    .local v22, "maxPairs":I
    int-to-double v3, v3

    .line 424
    .local v3, "u":D
    add-double/2addr v7, v3

    add-double/2addr v9, v1

    .line 425
    mul-double v24, v3, v3

    add-double v11, v11, v24

    mul-double v24, v1, v1

    add-double v13, v13, v24

    .line 426
    add-int/2addr v15, v6

    .line 427
    nop

    .end local v1    # "v":D
    .end local v3    # "u":D
    .end local v19    # "pos":I
    add-int/lit8 v5, v5, 0x1

    move/from16 v1, v20

    move/from16 v2, v21

    move/from16 v4, v22

    move/from16 v3, v23

    goto :goto_0

    .line 421
    .end local v22    # "maxPairs":I
    .end local v23    # "samples":I
    .local v3, "samples":I
    .restart local v4    # "maxPairs":I
    .restart local v19    # "pos":I
    :cond_2
    move/from16 v23, v3

    move/from16 v22, v4

    .end local v3    # "samples":I
    .end local v4    # "maxPairs":I
    .restart local v22    # "maxPairs":I
    .restart local v23    # "samples":I
    goto :goto_1

    .line 419
    .end local v19    # "pos":I
    .end local v20    # "ySize":I
    .end local v21    # "uvSize":I
    .end local v22    # "maxPairs":I
    .end local v23    # "samples":I
    .local v1, "ySize":I
    .restart local v2    # "uvSize":I
    .restart local v3    # "samples":I
    .restart local v4    # "maxPairs":I
    :cond_3
    move/from16 v20, v1

    move/from16 v21, v2

    move/from16 v23, v3

    move/from16 v22, v4

    .line 429
    .end local v1    # "ySize":I
    .end local v2    # "uvSize":I
    .end local v3    # "samples":I
    .end local v4    # "maxPairs":I
    .restart local v20    # "ySize":I
    .restart local v21    # "uvSize":I
    .restart local v22    # "maxPairs":I
    .restart local v23    # "samples":I
    :goto_1
    if-nez v5, :cond_4

    const-wide/high16 v1, -0x4010000000000000L    # -1.0

    return-wide v1

    .line 430
    :cond_4
    int-to-double v1, v5

    div-double v1, v7, v1

    .line 431
    .local v1, "uMean":D
    int-to-double v3, v5

    div-double v3, v9, v3

    .line 432
    .local v3, "vMean":D
    move/from16 v16, v6

    move-wide/from16 v24, v7

    .end local v6    # "step":I
    .end local v7    # "uSum":D
    .local v16, "step":I
    .local v24, "uSum":D
    int-to-double v6, v5

    div-double v6, v11, v6

    mul-double v26, v1, v1

    sub-double v6, v6, v26

    .line 433
    .local v6, "uVar":D
    move-wide/from16 v26, v9

    .end local v9    # "vSum":D
    .local v26, "vSum":D
    int-to-double v8, v5

    div-double v8, v13, v8

    mul-double v28, v3, v3

    sub-double v8, v8, v28

    .line 434
    .local v8, "vVar":D
    move-wide/from16 v28, v11

    .end local v11    # "uSq":D
    .local v28, "uSq":D
    const-wide/16 v10, 0x0

    invoke-static {v10, v11, v6, v7}, Ljava/lang/Math;->max(DD)D

    move-result-wide v30

    invoke-static/range {v30 .. v31}, Ljava/lang/Math;->sqrt(D)D

    move-result-wide v30

    .line 435
    .local v30, "uStd":D
    invoke-static {v10, v11, v8, v9}, Ljava/lang/Math;->max(DD)D

    move-result-wide v10

    invoke-static {v10, v11}, Ljava/lang/Math;->sqrt(D)D

    move-result-wide v10

    .line 440
    .local v10, "vStd":D
    const-wide/16 v32, 0x0

    .line 441
    .local v32, "score":D
    const-wide/high16 v34, 0x4018000000000000L    # 6.0

    sub-double v36, v30, v34

    sub-double v38, v10, v34

    add-double v36, v36, v38

    add-double v32, v32, v36

    .line 442
    cmpl-double v12, v30, v34

    const-wide/high16 v36, 0x4024000000000000L    # 10.0

    if-lez v12, :cond_5

    cmpl-double v12, v10, v34

    if-lez v12, :cond_5

    add-double v32, v32, v36

    .line 443
    :cond_5
    sub-double v34, v1, v3

    invoke-static/range {v34 .. v35}, Ljava/lang/Math;->abs(D)D

    move-result-wide v34

    .line 445
    .local v34, "meanDiff":D
    div-double v36, v34, v36

    sub-double v32, v32, v36

    .line 448
    const-wide/high16 v36, 0x4044000000000000L    # 40.0

    cmpg-double v12, v36, v1

    const-wide v38, 0x406ae00000000000L    # 215.0

    const/16 v17, 0x0

    if-gtz v12, :cond_6

    cmpg-double v12, v1, v38

    if-gtz v12, :cond_6

    const/4 v12, 0x1

    goto :goto_2

    :cond_6
    move/from16 v12, v17

    :goto_2
    const-wide/high16 v40, 0x4000000000000000L    # 2.0

    if-eqz v12, :cond_7

    add-double v32, v32, v40

    .line 449
    :cond_7
    cmpg-double v12, v36, v3

    if-gtz v12, :cond_8

    cmpg-double v12, v3, v38

    if-gtz v12, :cond_8

    const/16 v17, 0x1

    :cond_8
    if-eqz v17, :cond_9

    add-double v32, v32, v40

    .line 451
    :cond_9
    return-wide v32
.end method

.method private final selectBestCandidate(Ljava/util/List;II)[B
    .locals 9
    .param p1, "cands"    # Ljava/util/List;
    .param p2, "w"    # I
    .param p3, "h"    # I
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "[B>;II)[B"
        }
    .end annotation

    .line 380
    invoke-interface {p1}, Ljava/util/List;->isEmpty()Z

    move-result v0

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    return-object v1

    .line 381
    :cond_0
    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v0

    const/4 v2, 0x1

    if-ne v0, v2, :cond_1

    const/4 v0, 0x0

    invoke-interface {p1, v0}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [B

    return-object v0

    .line 384
    :cond_1
    const/4 v0, 0x0

    .line 385
    .local v0, "best":[B
    const-wide/high16 v2, -0x10000000000000L    # Double.NEGATIVE_INFINITY

    .line 386
    .local v2, "bestScore":D
    invoke-interface {p1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v4

    :cond_2
    :goto_0
    invoke-interface {v4}, Ljava/util/Iterator;->hasNext()Z

    move-result v5

    if-eqz v5, :cond_3

    invoke-interface {v4}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, [B

    .line 387
    .local v5, "c":[B
    invoke-direct {p0, v5, p2, p3}, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->scoreNV21Frame([BII)D

    move-result-wide v6

    .line 388
    .local v6, "score":D
    cmpl-double v8, v6, v2

    if-lez v8, :cond_2

    .line 389
    move-wide v2, v6

    .line 390
    move-object v0, v5

    .end local v5    # "c":[B
    .end local v6    # "score":D
    goto :goto_0

    .line 394
    :cond_3
    const-wide/16 v4, 0x0

    cmpg-double v4, v2, v4

    if-gez v4, :cond_4

    .line 395
    iget-object v4, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->TAG:Ljava/lang/String;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "All candidates scored low: "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v2, v3}, Ljava/lang/StringBuilder;->append(D)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    filled-new-array {v5}, [Ljava/lang/Object;

    move-result-object v5

    invoke-static {v4, v5}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->w(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 396
    return-object v1

    .line 398
    :cond_4
    return-object v0
.end method


# virtual methods
.method public final decoderH264StreamData([B)V
    .locals 21
    .param p1, "data"    # [B

    .line 99
    move-object/from16 v8, p0

    move-object/from16 v9, p1

    if-nez v9, :cond_0

    .line 100
    return-void

    .line 102
    :cond_0
    iget-object v0, v8, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->mediaCodec:Landroid/media/MediaCodec;

    if-nez v0, :cond_1

    return-void

    :cond_1
    move-object v10, v0

    .line 103
    .local v10, "codec":Landroid/media/MediaCodec;
    iget-object v0, v8, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->isCodecRunning:Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicBoolean;->get()Z

    move-result v0

    if-nez v0, :cond_2

    .line 104
    return-void

    .line 107
    :cond_2
    nop

    .line 108
    const-wide/16 v11, 0x2710

    :try_start_0
    invoke-virtual {v10, v11, v12}, Landroid/media/MediaCodec;->dequeueInputBuffer(J)I

    move-result v0

    move v13, v0

    .line 110
    .local v13, "inputIndex":I
    if-ltz v13, :cond_f

    .line 111
    invoke-virtual {v10, v13}, Landroid/media/MediaCodec;->getInputBuffer(I)Ljava/nio/ByteBuffer;

    move-result-object v0

    if-eqz v0, :cond_3

    .local v0, "$this$decoderH264StreamData_u24lambda_u240":Ljava/nio/ByteBuffer;
    const/4 v1, 0x0

    .line 112
    .local v1, "$i$a$-apply-H264StreamDecoder$decoderH264StreamData$1":I
    invoke-virtual {v0}, Ljava/nio/ByteBuffer;->clear()Ljava/nio/Buffer;

    .line 113
    invoke-virtual {v0, v9}, Ljava/nio/ByteBuffer;->put([B)Ljava/nio/ByteBuffer;

    .line 114
    nop

    .line 111
    .end local v0    # "$this$decoderH264StreamData_u24lambda_u240":Ljava/nio/ByteBuffer;
    .end local v1    # "$i$a$-apply-H264StreamDecoder$decoderH264StreamData$1":I
    :cond_3
    nop

    .line 115
    array-length v4, v9

    invoke-static {}, Ljava/lang/System;->nanoTime()J

    move-result-wide v0

    const-wide/16 v2, 0x3e8

    div-long v5, v0, v2

    const/4 v7, 0x0

    const/4 v3, 0x0

    move-object v1, v10

    move v2, v13

    invoke-virtual/range {v1 .. v7}, Landroid/media/MediaCodec;->queueInputBuffer(IIIJI)V

    .line 123
    new-instance v0, Landroid/media/MediaCodec$BufferInfo;

    invoke-direct {v0}, Landroid/media/MediaCodec$BufferInfo;-><init>()V

    move-object v14, v0

    .line 124
    .local v14, "bufferInfo":Landroid/media/MediaCodec$BufferInfo;
    invoke-virtual {v10, v14, v11, v12}, Landroid/media/MediaCodec;->dequeueOutputBuffer(Landroid/media/MediaCodec$BufferInfo;J)I

    move-result v0
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_3

    move v11, v0

    .line 126
    .local v11, "outputIndex":I
    :goto_0
    const-string v1, "color-format"

    const-string/jumbo v2, "slice-height"

    const-string/jumbo v3, "stride"

    const-string v4, "height"

    const-string/jumbo v5, "width"

    const-string v6, "codec.outputFormat"

    if-ltz v11, :cond_c

    .line 128
    const/4 v7, 0x0

    .line 129
    .local v7, "processed":Z
    nop

    .line 130
    nop

    .line 131
    nop

    .line 132
    :try_start_1
    invoke-virtual {v10, v11}, Landroid/media/MediaCodec;->getOutputImage(I)Landroid/media/Image;

    move-result-object v0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_1

    .line 133
    :catchall_0
    move-exception v0

    move-object v12, v0

    move-object v0, v12

    .line 134
    .local v0, "t":Ljava/lang/Throwable;
    const/4 v12, 0x0

    move-object v0, v12

    .line 131
    .end local v0    # "t":Ljava/lang/Throwable;
    :goto_1
    move-object v12, v0

    .line 137
    .local v12, "image":Landroid/media/Image;
    if-eqz v12, :cond_6

    .line 138
    :try_start_2
    invoke-direct {v8, v12}, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->imageToNV21(Landroid/media/Image;)[B

    move-result-object v0

    move-object v15, v0

    .line 140
    .local v15, "nv21":[B
    if-eqz v15, :cond_5

    .line 141
    iget-object v0, v8, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->nv21DataFun:Lkotlin/jvm/functions/Function3;

    if-eqz v0, :cond_4

    invoke-virtual {v12}, Landroid/media/Image;->getWidth()I

    move-result v16
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_2

    move/from16 v17, v7

    .end local v7    # "processed":Z
    .local v17, "processed":Z
    :try_start_3
    invoke-static/range {v16 .. v16}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v7

    invoke-virtual {v12}, Landroid/media/Image;->getHeight()I

    move-result v16

    invoke-static/range {v16 .. v16}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v9

    invoke-interface {v0, v15, v7, v9}, Lkotlin/jvm/functions/Function3;->invoke(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_3
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_0

    goto :goto_2

    .line 146
    .end local v12    # "image":Landroid/media/Image;
    .end local v15    # "nv21":[B
    :catch_0
    move-exception v0

    goto :goto_5

    .line 141
    .end local v17    # "processed":Z
    .restart local v7    # "processed":Z
    .restart local v12    # "image":Landroid/media/Image;
    .restart local v15    # "nv21":[B
    :cond_4
    move/from16 v17, v7

    .line 142
    .end local v7    # "processed":Z
    .restart local v17    # "processed":Z
    :goto_2
    const/4 v7, 0x1

    .end local v17    # "processed":Z
    .restart local v7    # "processed":Z
    goto :goto_3

    .line 140
    :cond_5
    move/from16 v17, v7

    .line 144
    :goto_3
    :try_start_4
    invoke-virtual {v12}, Landroid/media/Image;->close()V
    :try_end_4
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_4} :catch_1

    goto :goto_4

    :catch_1
    move-exception v0

    .line 152
    .end local v12    # "image":Landroid/media/Image;
    .end local v15    # "nv21":[B
    :goto_4
    move/from16 v17, v7

    goto :goto_6

    .line 146
    :catch_2
    move-exception v0

    move/from16 v17, v7

    .line 147
    .end local v7    # "processed":Z
    .local v0, "e":Ljava/lang/Exception;
    .restart local v17    # "processed":Z
    :goto_5
    :try_start_5
    iget-object v7, v8, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->TAG:Ljava/lang/String;

    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    const-string v12, "image path failed: "

    invoke-virtual {v9, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v12

    invoke-virtual {v9, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    filled-new-array {v9}, [Ljava/lang/Object;

    move-result-object v9

    invoke-static {v7, v9}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->w(Ljava/lang/String;[Ljava/lang/Object;)V

    goto :goto_6

    .line 137
    .end local v0    # "e":Ljava/lang/Exception;
    .end local v17    # "processed":Z
    .restart local v7    # "processed":Z
    .restart local v12    # "image":Landroid/media/Image;
    :cond_6
    move/from16 v17, v7

    .line 152
    .end local v7    # "processed":Z
    .end local v12    # "image":Landroid/media/Image;
    .restart local v17    # "processed":Z
    :goto_6
    const/4 v0, 0x0

    if-nez v17, :cond_b

    .line 154
    invoke-virtual {v10, v11}, Landroid/media/MediaCodec;->getOutputBuffer(I)Ljava/nio/ByteBuffer;

    move-result-object v7

    move-object v9, v7

    .line 155
    .local v9, "outBuffer":Ljava/nio/ByteBuffer;
    if-eqz v9, :cond_a

    iget v7, v14, Landroid/media/MediaCodec$BufferInfo;->size:I

    if-lez v7, :cond_a

    .line 156
    iget-object v7, v8, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->codecOutputTmp:[B

    iget v12, v14, Landroid/media/MediaCodec$BufferInfo;->size:I

    invoke-direct {v8, v7, v12}, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->ensureCapacity([BI)[B

    move-result-object v7

    iput-object v7, v8, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->codecOutputTmp:[B

    .line 157
    iget-object v7, v8, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->codecOutputTmp:[B

    iget v12, v14, Landroid/media/MediaCodec$BufferInfo;->size:I

    invoke-virtual {v9, v7, v0, v12}, Ljava/nio/ByteBuffer;->get([BII)Ljava/nio/ByteBuffer;

    .line 158
    invoke-virtual {v9}, Ljava/nio/ByteBuffer;->clear()Ljava/nio/Buffer;

    .line 160
    invoke-virtual {v10}, Landroid/media/MediaCodec;->getOutputFormat()Landroid/media/MediaFormat;

    move-result-object v7

    invoke-static {v7, v6}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    move-object v12, v7

    .line 161
    .local v12, "outFormat":Landroid/media/MediaFormat;
    invoke-virtual {v12, v5}, Landroid/media/MediaFormat;->getInteger(Ljava/lang/String;)I

    move-result v5

    move v15, v5

    .line 162
    .local v15, "outW":I
    invoke-virtual {v12, v4}, Landroid/media/MediaFormat;->getInteger(Ljava/lang/String;)I

    move-result v4

    move v7, v4

    .line 163
    .local v7, "outH":I
    invoke-virtual {v12, v3, v15}, Landroid/media/MediaFormat;->getInteger(Ljava/lang/String;I)I

    move-result v3

    iput v3, v8, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->stride:I

    .line 164
    invoke-virtual {v12, v2, v7}, Landroid/media/MediaFormat;->getInteger(Ljava/lang/String;I)I

    move-result v2

    iput v2, v8, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->sliceHeight:I

    .line 165
    iget v2, v8, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->colorFormat:I

    invoke-virtual {v12, v1, v2}, Landroid/media/MediaFormat;->getInteger(Ljava/lang/String;I)I

    move-result v1

    iput v1, v8, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->colorFormat:I

    .line 168
    iget-object v2, v8, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->codecOutputTmp:[B

    iget v3, v8, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->stride:I

    iget v4, v8, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->sliceHeight:I

    const/16 v16, 0x0

    move-object/from16 v1, p0

    move v5, v15

    move v6, v7

    move/from16 v18, v7

    .end local v7    # "outH":I
    .local v18, "outH":I
    move/from16 v7, v16

    invoke-direct/range {v1 .. v7}, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->convertBulkToNV21([BIIIIZ)[B

    move-result-object v1

    move-object v7, v1

    .line 170
    .local v7, "candA":[B
    iget-object v2, v8, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->codecOutputTmp:[B

    iget v3, v8, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->stride:I

    iget v4, v8, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->sliceHeight:I

    const/16 v16, 0x1

    move-object/from16 v1, p0

    move v5, v15

    move/from16 v6, v18

    move-object v0, v7

    .end local v7    # "candA":[B
    .local v0, "candA":[B
    move/from16 v7, v16

    invoke-direct/range {v1 .. v7}, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->convertBulkToNV21([BIIIIZ)[B

    move-result-object v1

    move-object v7, v1

    .line 172
    .local v7, "candB":[B
    iget-object v2, v8, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->codecOutputTmp:[B

    iget v3, v8, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->stride:I

    iget v4, v8, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->sliceHeight:I

    const/16 v16, 0x0

    move-object/from16 v1, p0

    move v5, v15

    move/from16 v6, v18

    move-object/from16 v19, v9

    move-object v9, v7

    .end local v7    # "candB":[B
    .local v9, "candB":[B
    .local v19, "outBuffer":Ljava/nio/ByteBuffer;
    move/from16 v7, v16

    invoke-direct/range {v1 .. v7}, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->convertPerRowToNV21([BIIIIZ)[B

    move-result-object v1

    move-object v7, v1

    .line 173
    .local v7, "candC":[B
    iget-object v2, v8, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->codecOutputTmp:[B

    iget v3, v8, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->stride:I

    iget v4, v8, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->sliceHeight:I

    const/16 v16, 0x1

    move-object/from16 v1, p0

    move v5, v15

    move/from16 v6, v18

    move-object/from16 v20, v12

    move-object v12, v7

    .end local v7    # "candC":[B
    .local v12, "candC":[B
    .local v20, "outFormat":Landroid/media/MediaFormat;
    move/from16 v7, v16

    invoke-direct/range {v1 .. v7}, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->convertPerRowToNV21([BIIIIZ)[B

    move-result-object v1

    .line 176
    .local v1, "candD":[B
    filled-new-array {v0, v9, v12, v1}, [[B

    move-result-object v2

    check-cast v2, [Ljava/lang/Object;

    invoke-static {v2}, Lkotlin/collections/CollectionsKt;->listOfNotNull([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v2

    move/from16 v3, v18

    .end local v18    # "outH":I
    .local v3, "outH":I
    invoke-direct {v8, v2, v15, v3}, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->selectBestCandidate(Ljava/util/List;II)[B

    move-result-object v2

    .line 178
    .local v2, "winner":[B
    if-eqz v2, :cond_7

    .line 179
    iget-object v4, v8, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->nv21DataFun:Lkotlin/jvm/functions/Function3;

    if-eqz v4, :cond_b

    invoke-static {v15}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v6

    invoke-interface {v4, v2, v5, v6}, Lkotlin/jvm/functions/Function3;->invoke(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_8

    .line 182
    :cond_7
    if-eqz v0, :cond_9

    move-object v4, v0

    .line 698
    .local v4, "it":[B
    const/4 v5, 0x0

    .line 182
    .local v5, "$i$a$-let-H264StreamDecoder$decoderH264StreamData$2":I
    iget-object v6, v8, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->nv21DataFun:Lkotlin/jvm/functions/Function3;

    if-eqz v6, :cond_8

    invoke-static {v15}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v7

    move-object/from16 v16, v0

    .end local v0    # "candA":[B
    .local v16, "candA":[B
    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    invoke-interface {v6, v4, v7, v0}, Lkotlin/jvm/functions/Function3;->invoke(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_7

    .end local v16    # "candA":[B
    .restart local v0    # "candA":[B
    :cond_8
    move-object/from16 v16, v0

    .end local v0    # "candA":[B
    .restart local v16    # "candA":[B
    goto :goto_7

    .end local v4    # "it":[B
    .end local v5    # "$i$a$-let-H264StreamDecoder$decoderH264StreamData$2":I
    .end local v16    # "candA":[B
    .restart local v0    # "candA":[B
    :cond_9
    move-object/from16 v16, v0

    .line 183
    .end local v0    # "candA":[B
    .restart local v16    # "candA":[B
    :goto_7
    iget-object v0, v8, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->TAG:Ljava/lang/String;

    const-string v4, "No valid NV21 candidate detected; fell back to candA"

    filled-new-array {v4}, [Ljava/lang/Object;

    move-result-object v4

    invoke-static {v0, v4}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->w(Ljava/lang/String;[Ljava/lang/Object;)V

    goto :goto_8

    .line 155
    .end local v1    # "candD":[B
    .end local v2    # "winner":[B
    .end local v3    # "outH":I
    .end local v12    # "candC":[B
    .end local v15    # "outW":I
    .end local v16    # "candA":[B
    .end local v19    # "outBuffer":Ljava/nio/ByteBuffer;
    .end local v20    # "outFormat":Landroid/media/MediaFormat;
    .local v9, "outBuffer":Ljava/nio/ByteBuffer;
    :cond_a
    move-object/from16 v19, v9

    .line 188
    .end local v9    # "outBuffer":Ljava/nio/ByteBuffer;
    :cond_b
    :goto_8
    const/4 v0, 0x0

    invoke-virtual {v10, v11, v0}, Landroid/media/MediaCodec;->releaseOutputBuffer(IZ)V

    .line 190
    const-wide/16 v0, 0x0

    invoke-virtual {v10, v14, v0, v1}, Landroid/media/MediaCodec;->dequeueOutputBuffer(Landroid/media/MediaCodec$BufferInfo;J)I

    move-result v0

    move v11, v0

    move-object/from16 v9, p1

    .end local v17    # "processed":Z
    goto/16 :goto_0

    .line 194
    :cond_c
    const/4 v0, -0x2

    if-ne v11, v0, :cond_10

    .line 195
    invoke-virtual {v10}, Landroid/media/MediaCodec;->getOutputFormat()Landroid/media/MediaFormat;

    move-result-object v0

    invoke-static {v0, v6}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 196
    .local v0, "newFormat":Landroid/media/MediaFormat;
    invoke-virtual {v0, v5}, Landroid/media/MediaFormat;->getInteger(Ljava/lang/String;)I

    move-result v5

    .line 197
    .local v5, "newWidth":I
    invoke-virtual {v0, v4}, Landroid/media/MediaFormat;->getInteger(Ljava/lang/String;)I

    move-result v4

    .line 198
    .local v4, "newHeight":I
    invoke-virtual {v0, v3, v5}, Landroid/media/MediaFormat;->getInteger(Ljava/lang/String;I)I

    move-result v3

    iput v3, v8, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->stride:I

    .line 199
    invoke-virtual {v0, v2, v4}, Landroid/media/MediaFormat;->getInteger(Ljava/lang/String;I)I

    move-result v2

    iput v2, v8, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->sliceHeight:I

    .line 200
    iget v2, v8, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->colorFormat:I

    invoke-virtual {v0, v1, v2}, Landroid/media/MediaFormat;->getInteger(Ljava/lang/String;I)I

    move-result v1

    iput v1, v8, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->colorFormat:I

    .line 203
    iget v1, v8, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->width:I

    if-ne v5, v1, :cond_d

    iget v1, v8, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->height:I

    if-eq v4, v1, :cond_e

    .line 204
    :cond_d
    iget-object v1, v8, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->TAG:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Resolution changed from "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget v3, v8, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->width:I

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const/16 v3, 0x78

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v2

    iget v6, v8, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->height:I

    invoke-virtual {v2, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v6, " to "

    invoke-virtual {v2, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->w(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 205
    iput v5, v8, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->width:I

    .line 206
    iput v4, v8, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->height:I

    .line 207
    iget v1, v8, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->width:I

    iget v2, v8, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->height:I

    mul-int/2addr v1, v2

    mul-int/lit8 v1, v1, 0x3

    div-int/lit8 v1, v1, 0x2

    .line 208
    .local v1, "cap":I
    new-array v2, v1, [B

    iput-object v2, v8, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->nv21Buffer:[B

    .line 209
    new-array v2, v1, [B

    iput-object v2, v8, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->codecOutputTmp:[B

    .line 210
    div-int/lit8 v2, v1, 0x2

    new-array v2, v2, [B

    iput-object v2, v8, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->uvTmp:[B

    .line 211
    iget-object v2, v8, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->TAG:Ljava/lang/String;

    const-string v3, "Buffers reallocated for new resolution"

    filled-new-array {v3}, [Ljava/lang/Object;

    move-result-object v3

    invoke-static {v2, v3}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 214
    .end local v1    # "cap":I
    :cond_e
    iget-object v1, v8, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->TAG:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Output format changed: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V
    :try_end_5
    .catch Ljava/lang/Exception; {:try_start_5 .. :try_end_5} :catch_3

    .end local v0    # "newFormat":Landroid/media/MediaFormat;
    .end local v4    # "newHeight":I
    .end local v5    # "newWidth":I
    .end local v11    # "outputIndex":I
    .end local v13    # "inputIndex":I
    .end local v14    # "bufferInfo":Landroid/media/MediaCodec$BufferInfo;
    goto :goto_9

    .line 120
    .restart local v13    # "inputIndex":I
    :cond_f
    return-void

    .line 216
    .end local v13    # "inputIndex":I
    :catch_3
    move-exception v0

    .line 217
    .local v0, "e":Ljava/lang/Exception;
    iget-object v1, v8, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->TAG:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Decode error: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 218
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    .line 220
    .end local v0    # "e":Ljava/lang/Exception;
    :cond_10
    :goto_9
    return-void
.end method

.method public final initDecoder()V
    .locals 6

    .line 46
    const-string/jumbo v0, "video/avc"

    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->TAG:Ljava/lang/String;

    const-string v2, "initDecoder"

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 47
    iget-boolean v1, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->isInit:Z

    if-eqz v1, :cond_0

    return-void

    .line 48
    :cond_0
    nop

    .line 51
    :try_start_0
    iget v1, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->width:I

    const/16 v2, 0x78

    if-lez v1, :cond_1

    iget v1, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->height:I

    if-gtz v1, :cond_4

    .line 52
    :cond_1
    sget-object v1, Lcom/rokid/security/phone/sdk/server/utils/ProtocolVersionUtils;->INSTANCE:Lcom/rokid/security/phone/sdk/server/utils/ProtocolVersionUtils;

    invoke-virtual {v1}, Lcom/rokid/security/phone/sdk/server/utils/ProtocolVersionUtils;->is1080PLandDefault()Z

    move-result v1

    const/16 v3, 0x14

    const/16 v4, 0x438

    const/16 v5, 0x780

    if-eqz v1, :cond_2

    .line 53
    iput v5, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->width:I

    .line 54
    iput v4, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->height:I

    .line 55
    iput v3, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->frameRate:I

    goto :goto_0

    .line 56
    :cond_2
    sget-object v1, Lcom/rokid/security/phone/sdk/server/utils/GlassSystemOSUtils;->INSTANCE:Lcom/rokid/security/phone/sdk/server/utils/GlassSystemOSUtils;

    invoke-virtual {v1}, Lcom/rokid/security/phone/sdk/server/utils/GlassSystemOSUtils;->isPoliceOS()Z

    move-result v1

    if-eqz v1, :cond_3

    .line 57
    const/16 v1, 0x500

    iput v1, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->width:I

    .line 58
    const/16 v1, 0x2d0

    iput v1, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->height:I

    .line 59
    const/16 v1, 0x1e

    iput v1, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->frameRate:I

    goto :goto_0

    .line 62
    :cond_3
    iput v5, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->width:I

    .line 63
    iput v4, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->height:I

    .line 64
    iput v3, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->frameRate:I

    .line 65
    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->TAG:Ljava/lang/String;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "Using default fallback resolution: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget v4, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->width:I

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v3

    iget v4, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->height:I

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    filled-new-array {v3}, [Ljava/lang/Object;

    move-result-object v3

    invoke-static {v1, v3}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->w(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 69
    :cond_4
    :goto_0
    invoke-static {v0}, Landroid/media/MediaCodec;->createDecoderByType(Ljava/lang/String;)Landroid/media/MediaCodec;

    move-result-object v1

    iput-object v1, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->mediaCodec:Landroid/media/MediaCodec;

    .line 70
    iget v1, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->width:I

    iget v3, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->height:I

    invoke-static {v0, v1, v3}, Landroid/media/MediaFormat;->createVideoFormat(Ljava/lang/String;II)Landroid/media/MediaFormat;

    move-result-object v0

    const-string v1, "createVideoFormat(MediaF\u2026VIDEO_AVC, width, height)"

    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 71
    .local v0, "format":Landroid/media/MediaFormat;
    const-string v1, "bitrate"

    iget v3, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->width:I

    iget v4, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->height:I

    mul-int/2addr v3, v4

    iget v4, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->frameRate:I

    mul-int/2addr v3, v4

    div-int/lit8 v3, v3, 0x8

    const v4, 0xf4240

    invoke-static {v3, v4}, Lkotlin/ranges/RangesKt;->coerceAtLeast(II)I

    move-result v3

    invoke-virtual {v0, v1, v3}, Landroid/media/MediaFormat;->setInteger(Ljava/lang/String;I)V

    .line 72
    const-string v1, "frame-rate"

    iget v3, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->frameRate:I

    invoke-virtual {v0, v1, v3}, Landroid/media/MediaFormat;->setInteger(Ljava/lang/String;I)V

    .line 73
    const-string v1, "i-frame-interval"

    iget v3, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->frameInterval:I

    invoke-virtual {v0, v1, v3}, Landroid/media/MediaFormat;->setInteger(Ljava/lang/String;I)V

    .line 74
    const-string v1, "color-format"

    const v3, 0x7f420888

    invoke-virtual {v0, v1, v3}, Landroid/media/MediaFormat;->setInteger(Ljava/lang/String;I)V

    .line 75
    const-string v1, "max-input-size"

    iget v3, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->width:I

    iget v4, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->height:I

    mul-int/2addr v3, v4

    invoke-virtual {v0, v1, v3}, Landroid/media/MediaFormat;->setInteger(Ljava/lang/String;I)V

    .line 77
    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->mediaCodec:Landroid/media/MediaCodec;

    invoke-static {v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;)V

    const/4 v3, 0x0

    const/4 v4, 0x0

    invoke-virtual {v1, v0, v4, v4, v3}, Landroid/media/MediaCodec;->configure(Landroid/media/MediaFormat;Landroid/view/Surface;Landroid/media/MediaCrypto;I)V

    .line 78
    const/4 v1, 0x1

    iput-boolean v1, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->isInit:Z

    .line 80
    iget v1, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->width:I

    iget v3, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->height:I

    mul-int/2addr v1, v3

    mul-int/lit8 v1, v1, 0x3

    div-int/lit8 v1, v1, 0x2

    .line 81
    .local v1, "cap":I
    new-array v3, v1, [B

    iput-object v3, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->nv21Buffer:[B

    .line 82
    new-array v3, v1, [B

    iput-object v3, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->codecOutputTmp:[B

    .line 83
    div-int/lit8 v3, v1, 0x2

    new-array v3, v3, [B

    iput-object v3, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->uvTmp:[B

    .line 85
    iget-object v3, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->TAG:Ljava/lang/String;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "Decoder configured: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    iget v5, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->width:I

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v2}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v2

    iget v4, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->height:I

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const/16 v4, 0x40

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v2

    iget v4, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->frameRate:I

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v4, "fps"

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v3, v2}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .end local v0    # "format":Landroid/media/MediaFormat;
    .end local v1    # "cap":I
    goto :goto_1

    .line 86
    :catch_0
    move-exception v0

    .line 87
    .local v0, "e":Ljava/lang/Exception;
    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->TAG:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "initDecoder error: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 88
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    .line 89
    invoke-virtual {p0}, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->release()V

    .line 91
    .end local v0    # "e":Ljava/lang/Exception;
    :goto_1
    return-void
.end method

.method public final isCodecRunning()Z
    .locals 1

    .line 473
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->isCodecRunning:Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicBoolean;->get()Z

    move-result v0

    return v0
.end method

.method public final release()V
    .locals 2

    .line 476
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->isCodecRunning:Ljava/util/concurrent/atomic/AtomicBoolean;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Ljava/util/concurrent/atomic/AtomicBoolean;->set(Z)V

    .line 477
    :try_start_0
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->mediaCodec:Landroid/media/MediaCodec;

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Landroid/media/MediaCodec;->stop()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    .line 478
    :cond_0
    :goto_0
    :try_start_1
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->mediaCodec:Landroid/media/MediaCodec;

    if-eqz v0, :cond_1

    invoke-virtual {v0}, Landroid/media/MediaCodec;->release()V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_1

    goto :goto_1

    :catch_1
    move-exception v0

    .line 479
    :cond_1
    :goto_1
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->mediaCodec:Landroid/media/MediaCodec;

    .line 480
    iput-boolean v1, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->isInit:Z

    .line 481
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->TAG:Ljava/lang/String;

    const-string v1, "Decoder released."

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 482
    return-void
.end method

.method public final setExpectedSize(II)V
    .locals 0
    .param p1, "w"    # I
    .param p2, "h"    # I

    .line 485
    if-lez p1, :cond_0

    if-lez p2, :cond_0

    .line 486
    iput p1, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->width:I

    .line 487
    iput p2, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->height:I

    .line 489
    :cond_0
    return-void
.end method

.method public final setNv21DataCallback(Lkotlin/jvm/functions/Function3;)V
    .locals 1
    .param p1, "callback"    # Lkotlin/jvm/functions/Function3;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lkotlin/jvm/functions/Function3<",
            "-[B-",
            "Ljava/lang/Integer;",
            "-",
            "Ljava/lang/Integer;",
            "Lkotlin/Unit;",
            ">;)V"
        }
    .end annotation

    const-string v0, "callback"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 94
    iput-object p1, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->nv21DataFun:Lkotlin/jvm/functions/Function3;

    .line 95
    return-void
.end method

.method public final start()V
    .locals 4

    .line 455
    nop

    .line 456
    :try_start_0
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->mediaCodec:Landroid/media/MediaCodec;

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Landroid/media/MediaCodec;->start()V

    .line 457
    :cond_0
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->isCodecRunning:Ljava/util/concurrent/atomic/AtomicBoolean;

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Ljava/util/concurrent/atomic/AtomicBoolean;->set(Z)V

    .line 458
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->TAG:Ljava/lang/String;

    const-string v1, "Decoder started."

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 459
    :catch_0
    move-exception v0

    .line 460
    .local v0, "e":Ljava/lang/Exception;
    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->TAG:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v3, "start error: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 462
    .end local v0    # "e":Ljava/lang/Exception;
    :goto_0
    return-void
.end method

.method public final stop()V
    .locals 4

    .line 465
    nop

    .line 466
    :try_start_0
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->isCodecRunning:Ljava/util/concurrent/atomic/AtomicBoolean;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Ljava/util/concurrent/atomic/AtomicBoolean;->set(Z)V

    .line 467
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->mediaCodec:Landroid/media/MediaCodec;

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Landroid/media/MediaCodec;->stop()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 468
    :catch_0
    move-exception v0

    .line 469
    .local v0, "e":Ljava/lang/Exception;
    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/wifip2p/H264StreamDecoder;->TAG:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v3, "stop error: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 471
    .end local v0    # "e":Ljava/lang/Exception;
    :cond_0
    :goto_0
    return-void
.end method
