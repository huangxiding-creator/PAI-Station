.class Lcom/rokid/aicore/ncnn/CropBitmapHolder;
.super Ljava/lang/Object;
.source "CropBitmapHolder.java"


# instance fields
.field private bitmap:Landroid/graphics/Bitmap;


# direct methods
.method constructor <init>()V
    .locals 0

    .line 5
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private static roundUp64(I)I
    .locals 1
    .param p0, "v"    # I

    .line 28
    add-int/lit8 v0, p0, 0x3f

    and-int/lit8 v0, v0, -0x40

    return v0
.end method


# virtual methods
.method obtain(II)Landroid/graphics/Bitmap;
    .locals 3
    .param p1, "cropW"    # I
    .param p2, "cropH"    # I

    .line 9
    invoke-static {p1}, Lcom/rokid/aicore/ncnn/CropBitmapHolder;->roundUp64(I)I

    move-result v0

    .line 10
    .local v0, "w":I
    invoke-static {p2}, Lcom/rokid/aicore/ncnn/CropBitmapHolder;->roundUp64(I)I

    move-result v1

    .line 12
    .local v1, "h":I
    iget-object v2, p0, Lcom/rokid/aicore/ncnn/CropBitmapHolder;->bitmap:Landroid/graphics/Bitmap;

    if-eqz v2, :cond_0

    iget-object v2, p0, Lcom/rokid/aicore/ncnn/CropBitmapHolder;->bitmap:Landroid/graphics/Bitmap;

    .line 13
    invoke-virtual {v2}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v2

    if-lt v2, v0, :cond_0

    iget-object v2, p0, Lcom/rokid/aicore/ncnn/CropBitmapHolder;->bitmap:Landroid/graphics/Bitmap;

    .line 14
    invoke-virtual {v2}, Landroid/graphics/Bitmap;->getHeight()I

    move-result v2

    if-ge v2, v1, :cond_2

    .line 16
    :cond_0
    iget-object v2, p0, Lcom/rokid/aicore/ncnn/CropBitmapHolder;->bitmap:Landroid/graphics/Bitmap;

    if-eqz v2, :cond_1

    iget-object v2, p0, Lcom/rokid/aicore/ncnn/CropBitmapHolder;->bitmap:Landroid/graphics/Bitmap;

    invoke-virtual {v2}, Landroid/graphics/Bitmap;->recycle()V

    .line 18
    :cond_1
    sget-object v2, Landroid/graphics/Bitmap$Config;->RGB_565:Landroid/graphics/Bitmap$Config;

    invoke-static {v0, v1, v2}, Landroid/graphics/Bitmap;->createBitmap(IILandroid/graphics/Bitmap$Config;)Landroid/graphics/Bitmap;

    move-result-object v2

    iput-object v2, p0, Lcom/rokid/aicore/ncnn/CropBitmapHolder;->bitmap:Landroid/graphics/Bitmap;

    .line 24
    :cond_2
    iget-object v2, p0, Lcom/rokid/aicore/ncnn/CropBitmapHolder;->bitmap:Landroid/graphics/Bitmap;

    return-object v2
.end method
