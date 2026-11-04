.class public final Lcom/rokid/security/phone/sdk/api/track/bean/RecogRegion$Companion;
.super Ljava/lang/Object;
.source "TrackModel.kt"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/rokid/security/phone/sdk/api/track/bean/RecogRegion;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "Companion"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000.\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0012\n\u0000\n\u0002\u0010\u0008\n\u0002\u0008\u0003\n\u0002\u0018\u0002\n\u0000\u0008\u0086\u0003\u0018\u00002\u00020\u0001B\u0007\u0008\u0002\u00a2\u0006\u0002\u0010\u0002J\u000e\u0010\u0003\u001a\u00020\u00042\u0006\u0010\u0005\u001a\u00020\u0004J*\u0010\u0006\u001a\u0004\u0018\u00010\u00072\u0008\u0010\u0008\u001a\u0004\u0018\u00010\t2\u0006\u0010\n\u001a\u00020\u000b2\u0006\u0010\u000c\u001a\u00020\u000b2\u0006\u0010\u0005\u001a\u00020\u0004J\u001e\u0010\r\u001a\u00020\u00042\u0006\u0010\u000e\u001a\u00020\u000f2\u0006\u0010\n\u001a\u00020\u000b2\u0006\u0010\u000c\u001a\u00020\u000b\u00a8\u0006\u0010"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/api/track/bean/RecogRegion$Companion;",
        "",
        "()V",
        "alignmentRect",
        "Landroid/graphics/Rect;",
        "rect",
        "nv21ToBitmap",
        "Landroid/graphics/Bitmap;",
        "nv21",
        "",
        "width",
        "",
        "height",
        "toRect",
        "faceRectF",
        "Landroid/graphics/RectF;",
        "sdk-api_release"
    }
    k = 0x1
    mv = {
        0x1,
        0x8,
        0x0
    }
    xi = 0x30
.end annotation


# direct methods
.method private constructor <init>()V
    .locals 0

    .line 50
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public synthetic constructor <init>(Lkotlin/jvm/internal/DefaultConstructorMarker;)V
    .locals 0

    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/api/track/bean/RecogRegion$Companion;-><init>()V

    return-void
.end method


# virtual methods
.method public final alignmentRect(Landroid/graphics/Rect;)Landroid/graphics/Rect;
    .locals 2
    .param p1, "rect"    # Landroid/graphics/Rect;

    const-string v0, "rect"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 59
    sget v0, Lcom/rokid/security/phone/sdk/api/track/bean/FaceParams;->PREVIEW_WIDTH:I

    sget v1, Lcom/rokid/security/phone/sdk/api/track/bean/FaceParams;->PREVIEW_HEIGHT:I

    invoke-static {v0, v1, p1}, Lcom/rokid/security/phone/sdk/api/utils/RokidSystem;->getAlignmentRect(IILandroid/graphics/Rect;)Landroid/graphics/Rect;

    move-result-object v0

    const-string v1, "getAlignmentRect(FacePar\u2026ams.PREVIEW_HEIGHT, rect)"

    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    return-object v0
.end method

.method public final nv21ToBitmap([BIILandroid/graphics/Rect;)Landroid/graphics/Bitmap;
    .locals 8
    .param p1, "nv21"    # [B
    .param p2, "width"    # I
    .param p3, "height"    # I
    .param p4, "rect"    # Landroid/graphics/Rect;

    const-string v0, "rect"

    invoke-static {p4, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 65
    const/4 v0, 0x0

    .line 66
    .local v0, "bitmap":Landroid/graphics/Bitmap;
    nop

    .line 67
    :try_start_0
    new-instance v7, Landroid/graphics/YuvImage;

    const/16 v3, 0x11

    const/4 v6, 0x0

    move-object v1, v7

    move-object v2, p1

    move v4, p2

    move v5, p3

    invoke-direct/range {v1 .. v6}, Landroid/graphics/YuvImage;-><init>([BIII[I)V

    move-object v1, v7

    .line 68
    .local v1, "image":Landroid/graphics/YuvImage;
    new-instance v2, Ljava/io/ByteArrayOutputStream;

    invoke-direct {v2}, Ljava/io/ByteArrayOutputStream;-><init>()V

    .line 69
    .local v2, "stream":Ljava/io/ByteArrayOutputStream;
    iget v3, p4, Landroid/graphics/Rect;->left:I

    const/4 v4, 0x0

    if-gez v3, :cond_0

    .line 70
    iput v4, p4, Landroid/graphics/Rect;->left:I

    .line 72
    :cond_0
    iget v3, p4, Landroid/graphics/Rect;->right:I

    if-le v3, p2, :cond_1

    .line 73
    iput p2, p4, Landroid/graphics/Rect;->right:I

    .line 75
    :cond_1
    iget v3, p4, Landroid/graphics/Rect;->top:I

    if-gez v3, :cond_2

    .line 76
    iput v4, p4, Landroid/graphics/Rect;->top:I

    .line 78
    :cond_2
    iget v3, p4, Landroid/graphics/Rect;->bottom:I

    if-le v3, p3, :cond_3

    .line 79
    iput p3, p4, Landroid/graphics/Rect;->bottom:I

    .line 81
    :cond_3
    move-object v3, v2

    check-cast v3, Ljava/io/OutputStream;

    const/16 v5, 0x64

    invoke-virtual {v1, p4, v5, v3}, Landroid/graphics/YuvImage;->compressToJpeg(Landroid/graphics/Rect;ILjava/io/OutputStream;)Z

    .line 82
    invoke-virtual {v2}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object v3

    invoke-virtual {v2}, Ljava/io/ByteArrayOutputStream;->size()I

    move-result v5

    invoke-static {v3, v4, v5}, Landroid/graphics/BitmapFactory;->decodeByteArray([BII)Landroid/graphics/Bitmap;

    move-result-object v3

    move-object v0, v3

    .line 83
    invoke-virtual {v2}, Ljava/io/ByteArrayOutputStream;->close()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .end local v1    # "image":Landroid/graphics/YuvImage;
    .end local v2    # "stream":Ljava/io/ByteArrayOutputStream;
    goto :goto_0

    .line 84
    :catch_0
    move-exception v1

    .line 85
    .local v1, "e":Ljava/lang/Exception;
    invoke-virtual {v1}, Ljava/lang/Exception;->printStackTrace()V

    .line 87
    .end local v1    # "e":Ljava/lang/Exception;
    :goto_0
    return-object v0
.end method

.method public final toRect(Landroid/graphics/RectF;II)Landroid/graphics/Rect;
    .locals 6
    .param p1, "faceRectF"    # Landroid/graphics/RectF;
    .param p2, "width"    # I
    .param p3, "height"    # I

    const-string v0, "faceRectF"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 51
    new-instance v0, Landroid/graphics/Rect;

    .line 52
    int-to-float v1, p2

    iget v2, p1, Landroid/graphics/RectF;->left:F

    mul-float/2addr v1, v2

    invoke-static {v1}, Ljava/lang/Math;->round(F)I

    move-result v1

    .line 53
    int-to-float v2, p3

    iget v3, p1, Landroid/graphics/RectF;->top:F

    mul-float/2addr v2, v3

    invoke-static {v2}, Ljava/lang/Math;->round(F)I

    move-result v2

    .line 54
    int-to-float v3, p2

    iget v4, p1, Landroid/graphics/RectF;->right:F

    mul-float/2addr v3, v4

    invoke-static {v3}, Ljava/lang/Math;->round(F)I

    move-result v3

    .line 55
    int-to-float v4, p3

    iget v5, p1, Landroid/graphics/RectF;->bottom:F

    mul-float/2addr v4, v5

    invoke-static {v4}, Ljava/lang/Math;->round(F)I

    move-result v4

    .line 51
    invoke-direct {v0, v1, v2, v3, v4}, Landroid/graphics/Rect;-><init>(IIII)V

    .line 56
    return-object v0
.end method
