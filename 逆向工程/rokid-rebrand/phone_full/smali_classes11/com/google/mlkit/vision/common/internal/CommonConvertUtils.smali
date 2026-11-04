.class public Lcom/google/mlkit/vision/common/internal/CommonConvertUtils;
.super Ljava/lang/Object;
.source "com.google.mlkit:vision-common@@17.3.0"


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static convertMlImagetoInputImage(Lcom/google/android/odml/image/MlImage;)Lcom/google/mlkit/vision/common/InputImage;
    .locals 12
    .param p0, "mlImage"    # Lcom/google/android/odml/image/MlImage;

    .line 1
    nop

    .end local p0    # "mlImage":Lcom/google/android/odml/image/MlImage;
    invoke-virtual {p0}, Lcom/google/android/odml/image/MlImage;->getContainedImageProperties()Ljava/util/List;

    move-result-object v0

    const/4 v1, 0x0

    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/google/android/odml/image/ImageProperties;

    .line 2
    invoke-virtual {v0}, Lcom/google/android/odml/image/ImageProperties;->getStorageType()I

    move-result v2

    const/4 v3, 0x0

    packed-switch v2, :pswitch_data_0

    goto/16 :goto_2

    .line 3
    :pswitch_0
    invoke-static {p0}, Lcom/google/android/odml/image/MediaImageExtractor;->extract(Lcom/google/android/odml/image/MlImage;)Landroid/media/Image;

    move-result-object v0

    .line 4
    invoke-virtual {v0}, Landroid/media/Image;->getFormat()I

    move-result v2

    const/16 v3, 0x100

    if-ne v2, v3, :cond_0

    .line 5
    invoke-virtual {v0}, Landroid/media/Image;->getPlanes()[Landroid/media/Image$Plane;

    move-result-object v2

    aget-object v1, v2, v1

    invoke-virtual {v1}, Landroid/media/Image$Plane;->getBuffer()Ljava/nio/ByteBuffer;

    move-result-object v1

    invoke-virtual {v1}, Ljava/nio/ByteBuffer;->limit()I

    move-result v1

    move v8, v1

    goto :goto_0

    .line 6
    :cond_0
    invoke-virtual {v0}, Landroid/media/Image;->getPlanes()[Landroid/media/Image$Plane;

    move-result-object v2

    aget-object v1, v2, v1

    invoke-virtual {v1}, Landroid/media/Image$Plane;->getBuffer()Ljava/nio/ByteBuffer;

    move-result-object v1

    invoke-virtual {v1}, Ljava/nio/ByteBuffer;->limit()I

    move-result v1

    mul-int/lit8 v1, v1, 0x3

    div-int/lit8 v1, v1, 0x2

    move v8, v1

    .line 7
    :goto_0
    invoke-virtual {v0}, Landroid/media/Image;->getFormat()I

    move-result v2

    .line 8
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v4

    .line 9
    invoke-virtual {p0}, Lcom/google/android/odml/image/MlImage;->getHeight()I

    move-result v6

    .line 10
    invoke-virtual {p0}, Lcom/google/android/odml/image/MlImage;->getWidth()I

    move-result v7

    .line 11
    invoke-virtual {p0}, Lcom/google/android/odml/image/MlImage;->getRotation()I

    move-result v9

    .line 12
    const/4 v3, 0x5

    invoke-static/range {v2 .. v9}, Lcom/google/mlkit/vision/common/internal/CommonConvertUtils;->zza(IIJIIII)V

    .line 13
    invoke-virtual {p0}, Lcom/google/android/odml/image/MlImage;->getRotation()I

    move-result p0

    invoke-static {v0, p0}, Lcom/google/mlkit/vision/common/InputImage;->fromMediaImage(Landroid/media/Image;I)Lcom/google/mlkit/vision/common/InputImage;

    move-result-object v3

    goto/16 :goto_2

    .line 14
    :pswitch_1
    invoke-static {p0}, Lcom/google/android/odml/image/ByteBufferExtractor;->extract(Lcom/google/android/odml/image/MlImage;)Ljava/nio/ByteBuffer;

    move-result-object v1

    .line 15
    invoke-virtual {v0}, Lcom/google/android/odml/image/ImageProperties;->getImageFormat()I

    move-result v0

    packed-switch v0, :pswitch_data_1

    move-object v0, v3

    goto :goto_1

    .line 29
    :pswitch_2
    nop

    .line 16
    const v0, 0x32315659

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    goto :goto_1

    :pswitch_3
    nop

    .line 17
    const/16 v0, 0x11

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    .line 15
    :goto_1
    if-eqz v0, :cond_1

    .line 18
    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v4

    .line 19
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v6

    .line 20
    invoke-virtual {p0}, Lcom/google/android/odml/image/MlImage;->getHeight()I

    move-result v8

    .line 21
    invoke-virtual {p0}, Lcom/google/android/odml/image/MlImage;->getWidth()I

    move-result v9

    .line 22
    invoke-virtual {v1}, Ljava/nio/ByteBuffer;->limit()I

    move-result v10

    .line 23
    invoke-virtual {p0}, Lcom/google/android/odml/image/MlImage;->getRotation()I

    move-result v11

    .line 24
    const/4 v5, 0x3

    invoke-static/range {v4 .. v11}, Lcom/google/mlkit/vision/common/internal/CommonConvertUtils;->zza(IIJIIII)V

    .line 25
    invoke-virtual {p0}, Lcom/google/android/odml/image/MlImage;->getWidth()I

    move-result v2

    .line 26
    invoke-virtual {p0}, Lcom/google/android/odml/image/MlImage;->getHeight()I

    move-result v3

    .line 27
    invoke-virtual {p0}, Lcom/google/android/odml/image/MlImage;->getRotation()I

    move-result p0

    .line 28
    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    .line 29
    invoke-static {v1, v2, v3, p0, v0}, Lcom/google/mlkit/vision/common/InputImage;->fromByteBuffer(Ljava/nio/ByteBuffer;IIII)Lcom/google/mlkit/vision/common/InputImage;

    move-result-object v3

    goto :goto_2

    :cond_1
    goto :goto_2

    .line 30
    :pswitch_4
    invoke-static {p0}, Lcom/google/android/odml/image/BitmapExtractor;->extract(Lcom/google/android/odml/image/MlImage;)Landroid/graphics/Bitmap;

    move-result-object v0

    .line 31
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v3

    .line 32
    invoke-virtual {p0}, Lcom/google/android/odml/image/MlImage;->getHeight()I

    move-result v5

    .line 33
    invoke-virtual {p0}, Lcom/google/android/odml/image/MlImage;->getWidth()I

    move-result v6

    .line 34
    invoke-virtual {v0}, Landroid/graphics/Bitmap;->getAllocationByteCount()I

    move-result v7

    .line 35
    invoke-virtual {p0}, Lcom/google/android/odml/image/MlImage;->getRotation()I

    move-result v8

    .line 36
    const/4 v1, -0x1

    const/4 v2, 0x1

    invoke-static/range {v1 .. v8}, Lcom/google/mlkit/vision/common/internal/CommonConvertUtils;->zza(IIJIIII)V

    .line 37
    invoke-virtual {p0}, Lcom/google/android/odml/image/MlImage;->getRotation()I

    move-result p0

    invoke-static {v0, p0}, Lcom/google/mlkit/vision/common/InputImage;->fromBitmap(Landroid/graphics/Bitmap;I)Lcom/google/mlkit/vision/common/InputImage;

    move-result-object v3

    .line 2
    :goto_2
    if-eqz v3, :cond_2

    .line 38
    invoke-static {}, Lcom/google/android/gms/internal/mlkit_vision_common/zzmw;->zza()Lcom/google/android/gms/internal/mlkit_vision_common/zzmw;

    :cond_2
    return-object v3

    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_4
        :pswitch_1
        :pswitch_0
    .end packed-switch

    :pswitch_data_1
    .packed-switch 0x4
        :pswitch_3
        :pswitch_2
    .end packed-switch
.end method

.method public static convertToAndroidImageFormat(I)I
    .locals 0

    sparse-switch p0, :sswitch_data_0

    const/4 p0, 0x0

    return p0

    :sswitch_0
    const p0, 0x32315659

    return p0

    :sswitch_1
    const/16 p0, 0x23

    return p0

    :sswitch_2
    const/16 p0, 0x11

    return p0

    nop

    :sswitch_data_0
    .sparse-switch
        0x11 -> :sswitch_2
        0x23 -> :sswitch_1
        0x32315659 -> :sswitch_0
    .end sparse-switch
.end method

.method public static convertToMVRotation(I)I
    .locals 3
    .param p0, "rotation"    # I

    .line 1
    nop

    .end local p0    # "rotation":I
    sparse-switch p0, :sswitch_data_0

    new-instance v0, Ljava/lang/IllegalArgumentException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Invalid rotation: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-direct {v0, p0}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    :sswitch_0
    const/4 p0, 0x3

    return p0

    :sswitch_1
    const/4 p0, 0x2

    return p0

    :sswitch_2
    const/4 p0, 0x1

    return p0

    :sswitch_3
    const/4 p0, 0x0

    return p0

    nop

    :sswitch_data_0
    .sparse-switch
        0x0 -> :sswitch_3
        0x5a -> :sswitch_2
        0xb4 -> :sswitch_1
        0x10e -> :sswitch_0
    .end sparse-switch
.end method

.method public static transformPointArray([Landroid/graphics/Point;Landroid/graphics/Matrix;)V
    .locals 5
    .param p0, "pointArray"    # [Landroid/graphics/Point;
    .param p1, "matrix"    # Landroid/graphics/Matrix;

    .line 1
    nop

    .end local p0    # "pointArray":[Landroid/graphics/Point;
    .end local p1    # "matrix":Landroid/graphics/Matrix;
    array-length v0, p0

    add-int/2addr v0, v0

    new-array v0, v0, [F

    const/4 v1, 0x0

    move v2, v1

    .line 2
    :goto_0
    array-length v3, p0

    if-ge v2, v3, :cond_0

    .line 3
    aget-object v3, p0, v2

    iget v3, v3, Landroid/graphics/Point;->x:I

    int-to-float v3, v3

    add-int v4, v2, v2

    aput v3, v0, v4

    add-int/lit8 v4, v4, 0x1

    .line 4
    aget-object v3, p0, v2

    iget v3, v3, Landroid/graphics/Point;->y:I

    int-to-float v3, v3

    aput v3, v0, v4

    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 5
    :cond_0
    invoke-virtual {p1, v0}, Landroid/graphics/Matrix;->mapPoints([F)V

    .line 6
    :goto_1
    array-length p1, p0

    if-ge v1, p1, :cond_1

    .line 7
    aget-object p1, p0, v1

    add-int v2, v1, v1

    aget v3, v0, v2

    float-to-int v3, v3

    add-int/lit8 v2, v2, 0x1

    aget v2, v0, v2

    float-to-int v2, v2

    invoke-virtual {p1, v3, v2}, Landroid/graphics/Point;->set(II)V

    add-int/lit8 v1, v1, 0x1

    goto :goto_1

    :cond_1
    return-void
.end method

.method public static transformPointF(Landroid/graphics/PointF;Landroid/graphics/Matrix;)V
    .locals 4
    .param p0, "pointF"    # Landroid/graphics/PointF;
    .param p1, "matrix"    # Landroid/graphics/Matrix;

    .line 1
    nop

    .end local p0    # "pointF":Landroid/graphics/PointF;
    .end local p1    # "matrix":Landroid/graphics/Matrix;
    iget v0, p0, Landroid/graphics/PointF;->x:F

    iget v1, p0, Landroid/graphics/PointF;->y:F

    const/4 v2, 0x2

    new-array v2, v2, [F

    const/4 v3, 0x0

    aput v0, v2, v3

    const/4 v0, 0x1

    aput v1, v2, v0

    .line 2
    invoke-virtual {p1, v2}, Landroid/graphics/Matrix;->mapPoints([F)V

    aget p1, v2, v3

    aget v0, v2, v0

    .line 3
    invoke-virtual {p0, p1, v0}, Landroid/graphics/PointF;->set(FF)V

    return-void
.end method

.method public static transformPointList(Ljava/util/List;Landroid/graphics/Matrix;)V
    .locals 5
    .param p0, "pointList"    # Ljava/util/List;
    .param p1, "matrix"    # Landroid/graphics/Matrix;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Landroid/graphics/PointF;",
            ">;",
            "Landroid/graphics/Matrix;",
            ")V"
        }
    .end annotation

    .line 1
    nop

    .end local p0    # "pointList":Ljava/util/List;
    .end local p1    # "matrix":Landroid/graphics/Matrix;
    invoke-interface {p0}, Ljava/util/List;->size()I

    move-result v0

    add-int/2addr v0, v0

    new-array v0, v0, [F

    const/4 v1, 0x0

    move v2, v1

    .line 2
    :goto_0
    invoke-interface {p0}, Ljava/util/List;->size()I

    move-result v3

    if-ge v2, v3, :cond_0

    .line 3
    invoke-interface {p0, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Landroid/graphics/PointF;

    iget v3, v3, Landroid/graphics/PointF;->x:F

    add-int v4, v2, v2

    aput v3, v0, v4

    add-int/lit8 v4, v4, 0x1

    .line 4
    invoke-interface {p0, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Landroid/graphics/PointF;

    iget v3, v3, Landroid/graphics/PointF;->y:F

    aput v3, v0, v4

    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 5
    :cond_0
    invoke-virtual {p1, v0}, Landroid/graphics/Matrix;->mapPoints([F)V

    .line 6
    :goto_1
    invoke-interface {p0}, Ljava/util/List;->size()I

    move-result p1

    if-ge v1, p1, :cond_1

    .line 7
    invoke-interface {p0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Landroid/graphics/PointF;

    add-int v2, v1, v1

    aget v3, v0, v2

    add-int/lit8 v2, v2, 0x1

    aget v2, v0, v2

    invoke-virtual {p1, v3, v2}, Landroid/graphics/PointF;->set(FF)V

    add-int/lit8 v1, v1, 0x1

    goto :goto_1

    :cond_1
    return-void
.end method

.method public static transformRect(Landroid/graphics/Rect;Landroid/graphics/Matrix;)V
    .locals 3
    .param p0, "rect"    # Landroid/graphics/Rect;
    .param p1, "matrix"    # Landroid/graphics/Matrix;

    .line 1
    new-instance v0, Landroid/graphics/RectF;

    .end local p0    # "rect":Landroid/graphics/Rect;
    .end local p1    # "matrix":Landroid/graphics/Matrix;
    invoke-direct {v0, p0}, Landroid/graphics/RectF;-><init>(Landroid/graphics/Rect;)V

    .line 2
    invoke-virtual {p1, v0}, Landroid/graphics/Matrix;->mapRect(Landroid/graphics/RectF;)Z

    .line 3
    iget p1, v0, Landroid/graphics/RectF;->left:F

    float-to-int p1, p1

    iget v1, v0, Landroid/graphics/RectF;->top:F

    float-to-int v1, v1

    iget v2, v0, Landroid/graphics/RectF;->right:F

    float-to-int v2, v2

    iget v0, v0, Landroid/graphics/RectF;->bottom:F

    float-to-int v0, v0

    invoke-virtual {p0, p1, v1, v2, v0}, Landroid/graphics/Rect;->set(IIII)V

    return-void
.end method

.method private static zza(IIJIIII)V
    .locals 10

    .line 1
    const-string v0, "vision-common"

    invoke-static {v0}, Lcom/google/android/gms/internal/mlkit_vision_common/zzms;->zzb(Ljava/lang/String;)Lcom/google/android/gms/internal/mlkit_vision_common/zzmj;

    move-result-object v1

    .line 2
    move v2, p0

    move v3, p1

    move-wide v4, p2

    move v6, p4

    move v7, p5

    move/from16 v8, p6

    move/from16 v9, p7

    invoke-static/range {v1 .. v9}, Lcom/google/android/gms/internal/mlkit_vision_common/zzmu;->zzb(Lcom/google/android/gms/internal/mlkit_vision_common/zzmj;IIJIIII)V

    return-void
.end method
