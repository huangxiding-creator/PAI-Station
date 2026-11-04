.class public Lorg/checkerframework/checker/signedness/SignednessUtilExtra;
.super Ljava/lang/Object;
.source "SignednessUtilExtra.java"


# direct methods
.method private constructor <init>()V
    .locals 2

    .line 17
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 18
    new-instance v0, Ljava/lang/Error;

    const-string v1, "Do not instantiate"

    invoke-direct {v0, v1}, Ljava/lang/Error;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public static dimensionUnsignedHeight(Ljava/awt/Dimension;)I
    .locals 1
    .param p0, "dim"    # Ljava/awt/Dimension;

    .line 30
    iget v0, p0, Ljava/awt/Dimension;->height:I

    return v0
.end method

.method public static dimensionUnsignedWidth(Ljava/awt/Dimension;)I
    .locals 1
    .param p0, "dim"    # Ljava/awt/Dimension;

    .line 24
    iget v0, p0, Ljava/awt/Dimension;->width:I

    return v0
.end method

.method public static getUnsignedRGB(Ljava/awt/image/BufferedImage;IIII[III)[I
    .locals 1
    .param p0, "b"    # Ljava/awt/image/BufferedImage;
    .param p1, "startX"    # I
    .param p2, "startY"    # I
    .param p3, "w"    # I
    .param p4, "h"    # I
    .param p5, "rgbArray"    # [I
    .param p6, "offset"    # I
    .param p7, "scansize"    # I

    .line 66
    invoke-virtual/range {p0 .. p7}, Ljava/awt/image/BufferedImage;->getRGB(IIII[III)[I

    move-result-object v0

    return-object v0
.end method

.method public static setUnsignedRGB(Ljava/awt/image/BufferedImage;IIII[III)V
    .locals 0
    .param p0, "b"    # Ljava/awt/image/BufferedImage;
    .param p1, "startX"    # I
    .param p2, "startY"    # I
    .param p3, "w"    # I
    .param p4, "h"    # I
    .param p5, "rgbArray"    # [I
    .param p6, "offset"    # I
    .param p7, "scansize"    # I

    .line 48
    invoke-virtual/range {p0 .. p7}, Ljava/awt/image/BufferedImage;->setRGB(IIII[III)V

    .line 49
    return-void
.end method
