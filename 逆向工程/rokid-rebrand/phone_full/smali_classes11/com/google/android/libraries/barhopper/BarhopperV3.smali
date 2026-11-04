.class public Lcom/google/android/libraries/barhopper/BarhopperV3;
.super Ljava/lang/Object;
.source "com.google.mlkit:barcode-scanning@@17.3.0"

# interfaces
.implements Ljava/io/Closeable;


# static fields
.field private static final NULLPTR:J

.field private static final TAG:Ljava/lang/String;


# instance fields
.field private nativePointer:J


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 1
    const-class v0, Lcom/google/android/libraries/barhopper/BarhopperV3;

    invoke-virtual {v0}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/google/android/libraries/barhopper/BarhopperV3;->TAG:Ljava/lang/String;

    return-void
.end method

.method public constructor <init>()V
    .locals 1

    .line 1
    nop

    .end local p0    # "this":Lcom/google/android/libraries/barhopper/BarhopperV3;
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const-string v0, "barhopper_v3"

    invoke-static {v0}, Ljava/lang/System;->loadLibrary(Ljava/lang/String;)V

    return-void
.end method

.method private native closeNative(J)V
.end method

.method private native createNative()J
.end method

.method private native createNativeWithClientOptions([B)J
.end method

.method private native recognizeBitmapNative(JLandroid/graphics/Bitmap;Lcom/google/android/libraries/barhopper/RecognitionOptions;)[B
.end method

.method private native recognizeBufferNative(JIILjava/nio/ByteBuffer;Lcom/google/android/libraries/barhopper/RecognitionOptions;)[B
.end method

.method private native recognizeNative(JII[BLcom/google/android/libraries/barhopper/RecognitionOptions;)[B
.end method

.method private native recognizeStridedBufferNative(JIIILjava/nio/ByteBuffer;Lcom/google/android/libraries/barhopper/RecognitionOptions;)[B
.end method

.method private native recognizeStridedNative(JIII[BLcom/google/android/libraries/barhopper/RecognitionOptions;)[B
.end method

.method private static toProto([B)Lcom/google/photos/vision/barhopper/BarhopperProto$BarhopperResponse;
    .locals 2
    .param p0, "buffer"    # [B

    .line 1
    nop

    .end local p0    # "buffer":[B
    if-eqz p0, :cond_0

    :try_start_0
    invoke-static {}, Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzds;->zza()Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzds;

    move-result-object v0

    invoke-static {p0, v0}, Lcom/google/photos/vision/barhopper/BarhopperProto$BarhopperResponse;->zzb([BLcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzds;)Lcom/google/photos/vision/barhopper/BarhopperProto$BarhopperResponse;

    move-result-object p0
    :try_end_0
    .catch Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzer; {:try_start_0 .. :try_end_0} :catch_0

    .line 3
    return-object p0

    .line 1
    :catch_0
    move-exception p0

    new-instance v0, Ljava/lang/IllegalStateException;

    .line 2
    const-string v1, "Received unexpected BarhopperResponse buffer: {0}"

    invoke-direct {v0, v1, p0}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;Ljava/lang/Throwable;)V

    throw v0

    :cond_0
    nop

    .line 3
    const/4 p0, 0x0

    throw p0
.end method


# virtual methods
.method public close()V
    .locals 5

    .line 1
    nop

    .end local p0    # "this":Lcom/google/android/libraries/barhopper/BarhopperV3;
    iget-wide v0, p0, Lcom/google/android/libraries/barhopper/BarhopperV3;->nativePointer:J

    const-wide/16 v2, 0x0

    cmp-long v4, v0, v2

    if-eqz v4, :cond_0

    invoke-direct {p0, v0, v1}, Lcom/google/android/libraries/barhopper/BarhopperV3;->closeNative(J)V

    iput-wide v2, p0, Lcom/google/android/libraries/barhopper/BarhopperV3;->nativePointer:J

    :cond_0
    return-void
.end method

.method public create()V
    .locals 4

    .line 1
    nop

    .end local p0    # "this":Lcom/google/android/libraries/barhopper/BarhopperV3;
    iget-wide v0, p0, Lcom/google/android/libraries/barhopper/BarhopperV3;->nativePointer:J

    const-wide/16 v2, 0x0

    cmp-long v0, v0, v2

    if-eqz v0, :cond_0

    sget-object v0, Lcom/google/android/libraries/barhopper/BarhopperV3;->TAG:Ljava/lang/String;

    const-string v1, "Native pointer already exists."

    invoke-static {v0, v1}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    return-void

    .line 2
    :cond_0
    invoke-direct {p0}, Lcom/google/android/libraries/barhopper/BarhopperV3;->createNative()J

    move-result-wide v0

    iput-wide v0, p0, Lcom/google/android/libraries/barhopper/BarhopperV3;->nativePointer:J

    cmp-long v0, v0, v2

    if-eqz v0, :cond_1

    .line 3
    return-void

    .line 2
    :cond_1
    new-instance v0, Ljava/lang/IllegalStateException;

    .line 3
    const-string v1, "Failed to create native pointer."

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public create(Lcom/google/barhopper/deeplearning/BarhopperV3Options;)V
    .locals 4
    .param p1, "options"    # Lcom/google/barhopper/deeplearning/BarhopperV3Options;

    .line 4
    nop

    .end local p0    # "this":Lcom/google/android/libraries/barhopper/BarhopperV3;
    .end local p1    # "options":Lcom/google/barhopper/deeplearning/BarhopperV3Options;
    iget-wide v0, p0, Lcom/google/android/libraries/barhopper/BarhopperV3;->nativePointer:J

    const-wide/16 v2, 0x0

    cmp-long v0, v0, v2

    if-eqz v0, :cond_0

    sget-object p1, Lcom/google/android/libraries/barhopper/BarhopperV3;->TAG:Ljava/lang/String;

    const-string v0, "Native pointer already exists."

    invoke-static {p1, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    return-void

    .line 5
    :cond_0
    invoke-virtual {p1}, Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzcq;->zzD()[B

    move-result-object p1

    invoke-direct {p0, p1}, Lcom/google/android/libraries/barhopper/BarhopperV3;->createNativeWithClientOptions([B)J

    move-result-wide v0

    iput-wide v0, p0, Lcom/google/android/libraries/barhopper/BarhopperV3;->nativePointer:J

    cmp-long p1, v0, v2

    if-eqz p1, :cond_1

    .line 6
    return-void

    .line 5
    :cond_1
    new-instance p1, Ljava/lang/IllegalArgumentException;

    .line 6
    const-string v0, "Failed to create native pointer with client options."

    invoke-direct {p1, v0}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p1
.end method

.method public recognize(IIILjava/nio/ByteBuffer;Lcom/google/android/libraries/barhopper/RecognitionOptions;)Lcom/google/photos/vision/barhopper/BarhopperProto$BarhopperResponse;
    .locals 8
    .param p1, "width"    # I
    .param p2, "height"    # I
    .param p3, "rowStride"    # I
    .param p4, "image"    # Ljava/nio/ByteBuffer;
    .param p5, "options"    # Lcom/google/android/libraries/barhopper/RecognitionOptions;

    .line 1
    nop

    .end local p0    # "this":Lcom/google/android/libraries/barhopper/BarhopperV3;
    .end local p1    # "width":I
    .end local p2    # "height":I
    .end local p3    # "rowStride":I
    .end local p4    # "image":Ljava/nio/ByteBuffer;
    .end local p5    # "options":Lcom/google/android/libraries/barhopper/RecognitionOptions;
    iget-wide v1, p0, Lcom/google/android/libraries/barhopper/BarhopperV3;->nativePointer:J

    const-wide/16 v3, 0x0

    cmp-long v0, v1, v3

    if-eqz v0, :cond_0

    .line 2
    move-object v0, p0

    move v3, p1

    move v4, p2

    move v5, p3

    move-object v6, p4

    move-object v7, p5

    invoke-direct/range {v0 .. v7}, Lcom/google/android/libraries/barhopper/BarhopperV3;->recognizeStridedBufferNative(JIIILjava/nio/ByteBuffer;Lcom/google/android/libraries/barhopper/RecognitionOptions;)[B

    move-result-object p1

    .line 3
    invoke-static {p1}, Lcom/google/android/libraries/barhopper/BarhopperV3;->toProto([B)Lcom/google/photos/vision/barhopper/BarhopperProto$BarhopperResponse;

    move-result-object p1

    return-object p1

    .line 1
    :cond_0
    new-instance p1, Ljava/lang/IllegalStateException;

    const-string p2, "Native pointer does not exist."

    invoke-direct {p1, p2}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p1
.end method

.method public recognize(III[BLcom/google/android/libraries/barhopper/RecognitionOptions;)Lcom/google/photos/vision/barhopper/BarhopperProto$BarhopperResponse;
    .locals 8
    .param p1, "width"    # I
    .param p2, "height"    # I
    .param p3, "rowStride"    # I
    .param p4, "image"    # [B
    .param p5, "options"    # Lcom/google/android/libraries/barhopper/RecognitionOptions;

    .line 4
    nop

    .end local p0    # "this":Lcom/google/android/libraries/barhopper/BarhopperV3;
    .end local p1    # "width":I
    .end local p2    # "height":I
    .end local p3    # "rowStride":I
    .end local p4    # "image":[B
    .end local p5    # "options":Lcom/google/android/libraries/barhopper/RecognitionOptions;
    iget-wide v1, p0, Lcom/google/android/libraries/barhopper/BarhopperV3;->nativePointer:J

    const-wide/16 v3, 0x0

    cmp-long v0, v1, v3

    if-eqz v0, :cond_0

    .line 5
    move-object v0, p0

    move v3, p1

    move v4, p2

    move v5, p3

    move-object v6, p4

    move-object v7, p5

    invoke-direct/range {v0 .. v7}, Lcom/google/android/libraries/barhopper/BarhopperV3;->recognizeStridedNative(JIII[BLcom/google/android/libraries/barhopper/RecognitionOptions;)[B

    move-result-object p1

    invoke-static {p1}, Lcom/google/android/libraries/barhopper/BarhopperV3;->toProto([B)Lcom/google/photos/vision/barhopper/BarhopperProto$BarhopperResponse;

    move-result-object p1

    return-object p1

    .line 4
    :cond_0
    new-instance p1, Ljava/lang/IllegalStateException;

    const-string p2, "Native pointer does not exist."

    invoke-direct {p1, p2}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p1
.end method

.method public recognize(IILjava/nio/ByteBuffer;Lcom/google/android/libraries/barhopper/RecognitionOptions;)Lcom/google/photos/vision/barhopper/BarhopperProto$BarhopperResponse;
    .locals 7
    .param p1, "width"    # I
    .param p2, "height"    # I
    .param p3, "image"    # Ljava/nio/ByteBuffer;
    .param p4, "options"    # Lcom/google/android/libraries/barhopper/RecognitionOptions;

    .line 6
    nop

    .end local p0    # "this":Lcom/google/android/libraries/barhopper/BarhopperV3;
    .end local p1    # "width":I
    .end local p2    # "height":I
    .end local p3    # "image":Ljava/nio/ByteBuffer;
    .end local p4    # "options":Lcom/google/android/libraries/barhopper/RecognitionOptions;
    iget-wide v1, p0, Lcom/google/android/libraries/barhopper/BarhopperV3;->nativePointer:J

    const-wide/16 v3, 0x0

    cmp-long v0, v1, v3

    if-eqz v0, :cond_0

    .line 7
    move-object v0, p0

    move v3, p1

    move v4, p2

    move-object v5, p3

    move-object v6, p4

    invoke-direct/range {v0 .. v6}, Lcom/google/android/libraries/barhopper/BarhopperV3;->recognizeBufferNative(JIILjava/nio/ByteBuffer;Lcom/google/android/libraries/barhopper/RecognitionOptions;)[B

    move-result-object p1

    invoke-static {p1}, Lcom/google/android/libraries/barhopper/BarhopperV3;->toProto([B)Lcom/google/photos/vision/barhopper/BarhopperProto$BarhopperResponse;

    move-result-object p1

    return-object p1

    .line 6
    :cond_0
    new-instance p1, Ljava/lang/IllegalStateException;

    const-string p2, "Native pointer does not exist."

    invoke-direct {p1, p2}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p1
.end method

.method public recognize(II[BLcom/google/android/libraries/barhopper/RecognitionOptions;)Lcom/google/photos/vision/barhopper/BarhopperProto$BarhopperResponse;
    .locals 7
    .param p1, "width"    # I
    .param p2, "height"    # I
    .param p3, "image"    # [B
    .param p4, "options"    # Lcom/google/android/libraries/barhopper/RecognitionOptions;

    .line 8
    nop

    .end local p0    # "this":Lcom/google/android/libraries/barhopper/BarhopperV3;
    .end local p1    # "width":I
    .end local p2    # "height":I
    .end local p3    # "image":[B
    .end local p4    # "options":Lcom/google/android/libraries/barhopper/RecognitionOptions;
    iget-wide v1, p0, Lcom/google/android/libraries/barhopper/BarhopperV3;->nativePointer:J

    const-wide/16 v3, 0x0

    cmp-long v0, v1, v3

    if-eqz v0, :cond_0

    .line 9
    move-object v0, p0

    move v3, p1

    move v4, p2

    move-object v5, p3

    move-object v6, p4

    invoke-direct/range {v0 .. v6}, Lcom/google/android/libraries/barhopper/BarhopperV3;->recognizeNative(JII[BLcom/google/android/libraries/barhopper/RecognitionOptions;)[B

    move-result-object p1

    invoke-static {p1}, Lcom/google/android/libraries/barhopper/BarhopperV3;->toProto([B)Lcom/google/photos/vision/barhopper/BarhopperProto$BarhopperResponse;

    move-result-object p1

    return-object p1

    .line 8
    :cond_0
    new-instance p1, Ljava/lang/IllegalStateException;

    const-string p2, "Native pointer does not exist."

    invoke-direct {p1, p2}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p1
.end method

.method public recognize(Landroid/graphics/Bitmap;Lcom/google/android/libraries/barhopper/RecognitionOptions;)Lcom/google/photos/vision/barhopper/BarhopperProto$BarhopperResponse;
    .locals 4
    .param p1, "image"    # Landroid/graphics/Bitmap;
    .param p2, "options"    # Lcom/google/android/libraries/barhopper/RecognitionOptions;

    .line 10
    nop

    .end local p0    # "this":Lcom/google/android/libraries/barhopper/BarhopperV3;
    .end local p1    # "image":Landroid/graphics/Bitmap;
    .end local p2    # "options":Lcom/google/android/libraries/barhopper/RecognitionOptions;
    iget-wide v0, p0, Lcom/google/android/libraries/barhopper/BarhopperV3;->nativePointer:J

    const-wide/16 v2, 0x0

    cmp-long v0, v0, v2

    if-eqz v0, :cond_1

    .line 11
    invoke-virtual {p1}, Landroid/graphics/Bitmap;->getConfig()Landroid/graphics/Bitmap$Config;

    move-result-object v0

    sget-object v1, Landroid/graphics/Bitmap$Config;->ARGB_8888:Landroid/graphics/Bitmap$Config;

    if-eq v0, v1, :cond_0

    sget-object v0, Lcom/google/android/libraries/barhopper/BarhopperV3;->TAG:Ljava/lang/String;

    .line 12
    invoke-virtual {p1}, Landroid/graphics/Bitmap;->getConfig()Landroid/graphics/Bitmap$Config;

    move-result-object v1

    invoke-static {v1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    const-string v2, "Input bitmap config is not ARGB_8888. Converting it to ARGB_8888 from "

    invoke-virtual {v2, v1}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 13
    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    sget-object v0, Landroid/graphics/Bitmap$Config;->ARGB_8888:Landroid/graphics/Bitmap$Config;

    .line 14
    invoke-virtual {p1}, Landroid/graphics/Bitmap;->isMutable()Z

    move-result v1

    invoke-virtual {p1, v0, v1}, Landroid/graphics/Bitmap;->copy(Landroid/graphics/Bitmap$Config;Z)Landroid/graphics/Bitmap;

    move-result-object p1

    :cond_0
    iget-wide v0, p0, Lcom/google/android/libraries/barhopper/BarhopperV3;->nativePointer:J

    .line 15
    invoke-direct {p0, v0, v1, p1, p2}, Lcom/google/android/libraries/barhopper/BarhopperV3;->recognizeBitmapNative(JLandroid/graphics/Bitmap;Lcom/google/android/libraries/barhopper/RecognitionOptions;)[B

    move-result-object p1

    invoke-static {p1}, Lcom/google/android/libraries/barhopper/BarhopperV3;->toProto([B)Lcom/google/photos/vision/barhopper/BarhopperProto$BarhopperResponse;

    move-result-object p1

    return-object p1

    .line 10
    :cond_1
    new-instance p1, Ljava/lang/IllegalStateException;

    const-string p2, "Native pointer does not exist."

    invoke-direct {p1, p2}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p1
.end method
