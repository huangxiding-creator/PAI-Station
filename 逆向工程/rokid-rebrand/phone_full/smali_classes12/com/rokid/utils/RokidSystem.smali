.class public Lcom/rokid/utils/RokidSystem;
.super Ljava/lang/Object;
.source "RokidSystem.java"


# static fields
.field private static final ALIGNMENT_BOTTOM:Ljava/lang/String; = "ro.rokid.alignment.bottom"

.field private static final ALIGNMENT_BOTTOM_2K:Ljava/lang/String; = "ro.rokid.2kalignment.bottom"

.field private static final ALIGNMENT_BOTTOM_HD:Ljava/lang/String; = "ro.rokid.fhdalignment.bottom"

.field private static final ALIGNMENT_LEFT:Ljava/lang/String; = "ro.rokid.alignment.left"

.field private static final ALIGNMENT_LEFT_2K:Ljava/lang/String; = "ro.rokid.2kalignment.left"

.field private static final ALIGNMENT_LEFT_HD:Ljava/lang/String; = "ro.rokid.fhdalignment.left"

.field private static final ALIGNMENT_RIGHT:Ljava/lang/String; = "ro.rokid.alignment.right"

.field private static final ALIGNMENT_RIGHT_2K:Ljava/lang/String; = "ro.rokid.2kalignment.right"

.field private static final ALIGNMENT_RIGHT_HD:Ljava/lang/String; = "ro.rokid.fhdalignment.right"

.field private static final ALIGNMENT_TOP:Ljava/lang/String; = "ro.rokid.alignment.top"

.field private static final ALIGNMENT_TOP_2K:Ljava/lang/String; = "ro.rokid.2kalignment.top"

.field private static final ALIGNMENT_TOP_HD:Ljava/lang/String; = "ro.rokid.fhdalignment.top"

.field private static final BASE_HEIGHT:I = 0x2d0

.field private static final BASE_HEIGHT_720P:I = 0x2d0

.field private static final BASE_HEIGHT_HD:I = 0x438

.field private static final BASE_WIDTH:I = 0x500

.field private static final BASE_WIDTH_720P:I = 0x500

.field private static final BASE_WIDTH_HD:I = 0x780

.field private static final HARDWARE_VERSION:Ljava/lang/String; = "ro.rokid.hardware.version"


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 16
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static getAlignmentBaseRect()Landroid/graphics/Rect;
    .locals 5

    .line 195
    new-instance v0, Landroid/graphics/Rect;

    const-string v1, "ro.rokid.alignment.left"

    invoke-static {v1}, Lcom/rokid/utils/SystemPropertyUtil;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lcom/rokid/utils/RokidSystem;->toInt(Ljava/lang/String;)I

    move-result v1

    .line 196
    const-string v2, "ro.rokid.alignment.top"

    invoke-static {v2}, Lcom/rokid/utils/SystemPropertyUtil;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/rokid/utils/RokidSystem;->toInt(Ljava/lang/String;)I

    move-result v2

    .line 197
    const-string v3, "ro.rokid.alignment.right"

    invoke-static {v3}, Lcom/rokid/utils/SystemPropertyUtil;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Lcom/rokid/utils/RokidSystem;->toInt(Ljava/lang/String;)I

    move-result v3

    .line 198
    const-string v4, "ro.rokid.alignment.bottom"

    invoke-static {v4}, Lcom/rokid/utils/SystemPropertyUtil;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    invoke-static {v4}, Lcom/rokid/utils/RokidSystem;->toInt(Ljava/lang/String;)I

    move-result v4

    invoke-direct {v0, v1, v2, v3, v4}, Landroid/graphics/Rect;-><init>(IIII)V

    .line 195
    return-object v0
.end method

.method private static getAlignmentBaseRect2K()Landroid/graphics/Rect;
    .locals 5

    .line 216
    new-instance v0, Landroid/graphics/Rect;

    const-string v1, "ro.rokid.2kalignment.left"

    invoke-static {v1}, Lcom/rokid/utils/SystemPropertyUtil;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lcom/rokid/utils/RokidSystem;->toInt(Ljava/lang/String;)I

    move-result v1

    .line 217
    const-string v2, "ro.rokid.2kalignment.top"

    invoke-static {v2}, Lcom/rokid/utils/SystemPropertyUtil;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/rokid/utils/RokidSystem;->toInt(Ljava/lang/String;)I

    move-result v2

    .line 218
    const-string v3, "ro.rokid.2kalignment.right"

    invoke-static {v3}, Lcom/rokid/utils/SystemPropertyUtil;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Lcom/rokid/utils/RokidSystem;->toInt(Ljava/lang/String;)I

    move-result v3

    .line 219
    const-string v4, "ro.rokid.2kalignment.bottom"

    invoke-static {v4}, Lcom/rokid/utils/SystemPropertyUtil;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    invoke-static {v4}, Lcom/rokid/utils/RokidSystem;->toInt(Ljava/lang/String;)I

    move-result v4

    invoke-direct {v0, v1, v2, v3, v4}, Landroid/graphics/Rect;-><init>(IIII)V

    .line 216
    return-object v0
.end method

.method public static getAlignmentBaseRectHD()Landroid/graphics/Rect;
    .locals 5

    .line 203
    new-instance v0, Landroid/graphics/Rect;

    const-string/jumbo v1, "ro.rokid.fhdalignment.left"

    invoke-static {v1}, Lcom/rokid/utils/SystemPropertyUtil;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lcom/rokid/utils/RokidSystem;->toInt(Ljava/lang/String;)I

    move-result v1

    .line 204
    const-string/jumbo v2, "ro.rokid.fhdalignment.top"

    invoke-static {v2}, Lcom/rokid/utils/SystemPropertyUtil;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/rokid/utils/RokidSystem;->toInt(Ljava/lang/String;)I

    move-result v2

    .line 205
    const-string/jumbo v3, "ro.rokid.fhdalignment.right"

    invoke-static {v3}, Lcom/rokid/utils/SystemPropertyUtil;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Lcom/rokid/utils/RokidSystem;->toInt(Ljava/lang/String;)I

    move-result v3

    .line 206
    const-string v4, "ro.rokid.fhdalignment.bottom"

    invoke-static {v4}, Lcom/rokid/utils/SystemPropertyUtil;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    invoke-static {v4}, Lcom/rokid/utils/RokidSystem;->toInt(Ljava/lang/String;)I

    move-result v4

    invoke-direct {v0, v1, v2, v3, v4}, Landroid/graphics/Rect;-><init>(IIII)V

    .line 203
    return-object v0
.end method

.method public static getAlignmentPercent(II)Landroid/graphics/RectF;
    .locals 7
    .param p0, "width"    # I
    .param p1, "height"    # I

    .line 149
    const/16 v0, 0x780

    if-ne p0, v0, :cond_0

    .line 150
    invoke-static {}, Lcom/rokid/utils/RokidSystem;->getAlignmentBaseRectHD()Landroid/graphics/Rect;

    move-result-object v0

    .local v0, "rect":Landroid/graphics/Rect;
    goto :goto_0

    .line 152
    .end local v0    # "rect":Landroid/graphics/Rect;
    :cond_0
    invoke-static {}, Lcom/rokid/utils/RokidSystem;->getAlignmentBaseRect()Landroid/graphics/Rect;

    move-result-object v0

    .line 154
    .restart local v0    # "rect":Landroid/graphics/Rect;
    :goto_0
    new-instance v1, Landroid/graphics/RectF;

    iget v2, v0, Landroid/graphics/Rect;->left:I

    int-to-float v2, v2

    const/high16 v3, 0x3f800000    # 1.0f

    mul-float/2addr v2, v3

    int-to-float v4, p0

    div-float/2addr v2, v4

    iget v4, v0, Landroid/graphics/Rect;->top:I

    int-to-float v4, v4

    mul-float/2addr v4, v3

    int-to-float v5, p1

    div-float/2addr v4, v5

    iget v5, v0, Landroid/graphics/Rect;->right:I

    int-to-float v5, v5

    mul-float/2addr v5, v3

    int-to-float v6, p0

    div-float/2addr v5, v6

    iget v6, v0, Landroid/graphics/Rect;->bottom:I

    int-to-float v6, v6

    mul-float/2addr v6, v3

    int-to-float v3, p1

    div-float/2addr v6, v3

    invoke-direct {v1, v2, v4, v5, v6}, Landroid/graphics/RectF;-><init>(FFFF)V

    return-object v1
.end method

.method public static getAlignmentRect(Landroid/content/Context;IILandroid/graphics/Rect;)Landroid/graphics/Rect;
    .locals 16
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "previewWidth"    # I
    .param p2, "previewHeight"    # I
    .param p3, "previewRect"    # Landroid/graphics/Rect;

    .line 109
    move/from16 v0, p1

    move/from16 v1, p2

    move-object/from16 v2, p3

    invoke-static/range {p1 .. p1}, Lcom/rokid/utils/RokidSystem;->getAlignmentRectF(I)Landroid/graphics/RectF;

    move-result-object v3

    .line 110
    .local v3, "rectF":Landroid/graphics/RectF;
    if-nez v3, :cond_0

    .line 111
    const/4 v4, 0x0

    return-object v4

    .line 114
    :cond_0
    iget v4, v3, Landroid/graphics/RectF;->right:F

    iget v5, v3, Landroid/graphics/RectF;->left:F

    sub-float/2addr v4, v5

    int-to-float v5, v0

    mul-float/2addr v4, v5

    .line 115
    .local v4, "w":F
    iget v5, v3, Landroid/graphics/RectF;->bottom:F

    iget v6, v3, Landroid/graphics/RectF;->top:F

    sub-float/2addr v5, v6

    int-to-float v6, v1

    mul-float/2addr v5, v6

    .line 117
    .local v5, "h":F
    invoke-static/range {p0 .. p0}, Lcom/rokid/utils/ViewUtils;->getScreenSize(Landroid/content/Context;)Landroid/util/Pair;

    move-result-object v6

    .line 118
    .local v6, "screenSize":Landroid/util/Pair;, "Landroid/util/Pair<Ljava/lang/Integer;Ljava/lang/Integer;>;"
    iget-object v7, v6, Landroid/util/Pair;->first:Ljava/lang/Object;

    check-cast v7, Ljava/lang/Integer;

    invoke-virtual {v7}, Ljava/lang/Integer;->intValue()I

    move-result v7

    .line 119
    .local v7, "width":I
    iget-object v8, v6, Landroid/util/Pair;->second:Ljava/lang/Object;

    check-cast v8, Ljava/lang/Integer;

    invoke-virtual {v8}, Ljava/lang/Integer;->intValue()I

    move-result v8

    .line 129
    .local v8, "height":I
    iget v9, v2, Landroid/graphics/Rect;->left:I

    int-to-float v9, v9

    iget v10, v3, Landroid/graphics/RectF;->left:F

    int-to-float v11, v0

    mul-float/2addr v10, v11

    sub-float/2addr v9, v10

    const/high16 v10, 0x3f800000    # 1.0f

    mul-float/2addr v9, v10

    div-float/2addr v9, v4

    int-to-float v11, v7

    mul-float/2addr v9, v11

    float-to-int v9, v9

    .line 130
    .local v9, "left":I
    iget v11, v2, Landroid/graphics/Rect;->top:I

    int-to-float v11, v11

    iget v12, v3, Landroid/graphics/RectF;->top:F

    int-to-float v13, v1

    mul-float/2addr v12, v13

    sub-float/2addr v11, v12

    mul-float/2addr v11, v10

    div-float/2addr v11, v5

    int-to-float v12, v8

    mul-float/2addr v11, v12

    float-to-int v11, v11

    .line 131
    .local v11, "top":I
    iget v12, v2, Landroid/graphics/Rect;->right:I

    int-to-float v12, v12

    iget v13, v3, Landroid/graphics/RectF;->left:F

    int-to-float v14, v0

    mul-float/2addr v13, v14

    sub-float/2addr v12, v13

    mul-float/2addr v12, v10

    div-float/2addr v12, v4

    int-to-float v13, v7

    mul-float/2addr v12, v13

    float-to-int v12, v12

    .line 132
    .local v12, "right":I
    iget v13, v2, Landroid/graphics/Rect;->bottom:I

    int-to-float v13, v13

    iget v14, v3, Landroid/graphics/RectF;->top:F

    int-to-float v15, v1

    mul-float/2addr v14, v15

    sub-float/2addr v13, v14

    mul-float/2addr v13, v10

    div-float/2addr v13, v5

    int-to-float v10, v8

    mul-float/2addr v13, v10

    float-to-int v10, v13

    .line 134
    .local v10, "bottom":I
    new-instance v13, Landroid/graphics/Rect;

    invoke-direct {v13, v9, v11, v12, v10}, Landroid/graphics/Rect;-><init>(IIII)V

    return-object v13
.end method

.method public static getAlignmentRect2K(Landroid/content/Context;IILandroid/graphics/Rect;)Landroid/graphics/Rect;
    .locals 1
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "previewWidth"    # I
    .param p2, "previewHeight"    # I
    .param p3, "previewRect"    # Landroid/graphics/Rect;
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 97
    invoke-static {p0, p1, p2, p3}, Lcom/rokid/utils/RokidSystem;->getAlignmentRect(Landroid/content/Context;IILandroid/graphics/Rect;)Landroid/graphics/Rect;

    move-result-object v0

    return-object v0
.end method

.method private static getAlignmentRectF(I)Landroid/graphics/RectF;
    .locals 4
    .param p0, "previewWidth"    # I

    .line 159
    invoke-static {p0}, Lcom/rokid/utils/RokidSystem;->getBenefitResolution(I)I

    move-result v0

    .line 163
    .local v0, "type":I
    const/4 v1, 0x1

    const/4 v2, 0x0

    if-ne v0, v1, :cond_1

    .line 164
    invoke-static {}, Lcom/rokid/utils/RokidSystem;->noAlignmentHD()Z

    move-result v1

    if-eqz v1, :cond_0

    .line 165
    return-object v2

    .line 167
    :cond_0
    const/16 v1, 0x780

    .line 168
    .local v1, "width":I
    const/16 v2, 0x438

    .local v2, "height":I
    goto :goto_0

    .line 170
    .end local v1    # "width":I
    .end local v2    # "height":I
    :cond_1
    invoke-static {}, Lcom/rokid/utils/RokidSystem;->noAlignment()Z

    move-result v1

    if-eqz v1, :cond_2

    .line 171
    return-object v2

    .line 173
    :cond_2
    const/16 v1, 0x500

    .line 174
    .restart local v1    # "width":I
    const/16 v2, 0x2d0

    .line 177
    .restart local v2    # "height":I
    :goto_0
    invoke-static {v1, v2}, Lcom/rokid/utils/RokidSystem;->getAlignmentPercent(II)Landroid/graphics/RectF;

    move-result-object v3

    return-object v3
.end method

.method private static getBenefitResolution(I)I
    .locals 3
    .param p0, "width"    # I

    .line 183
    rsub-int v0, p0, 0x780

    invoke-static {v0}, Ljava/lang/Math;->abs(I)I

    move-result v0

    .line 184
    .local v0, "closeHD":I
    rsub-int v1, p0, 0x500

    invoke-static {v1}, Ljava/lang/Math;->abs(I)I

    move-result v1

    .line 186
    .local v1, "close720p":I
    if-ge v0, v1, :cond_0

    const/4 v2, 0x1

    goto :goto_0

    :cond_0
    const/4 v2, 0x0

    :goto_0
    return v2
.end method

.method public static getHardwareVersion()Ljava/lang/String;
    .locals 1

    .line 252
    const-string/jumbo v0, "ro.rokid.hardware.version"

    invoke-static {v0}, Lcom/rokid/utils/SystemPropertyUtil;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static getProjectionMatrix_OpticalSeeThrough()[F
    .locals 9

    .line 231
    const/16 v0, 0x10

    new-array v3, v0, [F

    fill-array-data v3, :array_0

    .line 233
    .local v3, "rawProjectionMatrixGL2":[F
    new-array v1, v0, [D

    fill-array-data v1, :array_1

    move-object v7, v1

    .line 234
    .local v7, "tmp":[D
    new-array v8, v0, [F

    .line 235
    .local v8, "eyeAdjustmentGL2":[F
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_0
    if-ge v1, v0, :cond_0

    .line 236
    aget-wide v4, v7, v1

    double-to-float v2, v4

    aput v2, v8, v1

    .line 235
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 239
    .end local v1    # "i":I
    :cond_0
    new-array v0, v0, [F

    .line 240
    .local v0, "projectionMatrix":[F
    const/4 v4, 0x0

    const/4 v6, 0x0

    const/4 v2, 0x0

    move-object v1, v0

    move-object v5, v8

    invoke-static/range {v1 .. v6}, Landroid/opengl/Matrix;->multiplyMM([FI[FI[FI)V

    .line 242
    return-object v0

    nop

    :array_0
    .array-data 4
        0x40a66666    # 5.2f
        0x0
        0x0
        0x0
        0x0
        0x41100000    # 9.0f
        0x0
        0x0
        0x3a83126f    # 0.001f
        0x3b83126f    # 0.004f
        -0x40800000    # -1.0f
        -0x40800000    # -1.0f
        0x0
        0x0
        -0x435c28f6    # -0.02f
        0x0
    .end array-data

    :array_1
    .array-data 8
        0x3ff0000000000000L    # 1.0
        0x3f86872b020c49baL    # 0.011
        -0x40af9db22d0e5604L    # -0.001
        0x0
        -0x407978d4fdf3b646L    # -0.011
        0x3fefced916872b02L    # 0.994
        0x3fa810624dd2f1aaL    # 0.047
        0x0
        0x3f60624dd2f1a9fcL    # 0.002
        -0x4057ef9db22d0e56L    # -0.047
        0x3fefced916872b02L    # 0.994
        0x0
        -0x3fbe4ccccccccccdL    # -35.4
        0x4024cccccccccccdL    # 10.4
        -0x3fb44ccccccccccdL    # -55.4
        0x3ff0000000000000L    # 1.0
    .end array-data
.end method

.method public static getWindowRect(Landroid/content/Context;IILandroid/graphics/Rect;)Landroid/graphics/Rect;
    .locals 12
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "previewWidth"    # I
    .param p2, "previewHeight"    # I
    .param p3, "windowRect"    # Landroid/graphics/Rect;

    .line 68
    invoke-static {p1}, Lcom/rokid/utils/RokidSystem;->getAlignmentRectF(I)Landroid/graphics/RectF;

    move-result-object v0

    .line 69
    .local v0, "rectF":Landroid/graphics/RectF;
    if-eqz v0, :cond_1

    if-nez p0, :cond_0

    goto :goto_0

    .line 72
    :cond_0
    invoke-static {p0}, Lcom/rokid/utils/ViewUtils;->getScreenSize(Landroid/content/Context;)Landroid/util/Pair;

    move-result-object v1

    .line 73
    .local v1, "screenSize":Landroid/util/Pair;, "Landroid/util/Pair<Ljava/lang/Integer;Ljava/lang/Integer;>;"
    iget-object v2, v1, Landroid/util/Pair;->first:Ljava/lang/Object;

    check-cast v2, Ljava/lang/Integer;

    invoke-virtual {v2}, Ljava/lang/Integer;->intValue()I

    move-result v2

    .line 74
    .local v2, "width":I
    iget-object v3, v1, Landroid/util/Pair;->second:Ljava/lang/Object;

    check-cast v3, Ljava/lang/Integer;

    invoke-virtual {v3}, Ljava/lang/Integer;->intValue()I

    move-result v3

    .line 76
    .local v3, "height":I
    iget v4, v0, Landroid/graphics/RectF;->right:F

    iget v5, v0, Landroid/graphics/RectF;->left:F

    sub-float/2addr v4, v5

    int-to-float v5, p1

    mul-float/2addr v4, v5

    .line 77
    .local v4, "w":F
    iget v5, v0, Landroid/graphics/RectF;->bottom:F

    iget v6, v0, Landroid/graphics/RectF;->top:F

    sub-float/2addr v5, v6

    int-to-float v6, p2

    mul-float/2addr v5, v6

    .line 79
    .local v5, "h":F
    iget v6, p3, Landroid/graphics/Rect;->left:I

    int-to-float v6, v6

    mul-float/2addr v6, v4

    const/high16 v7, 0x3f800000    # 1.0f

    mul-float/2addr v6, v7

    int-to-float v8, v2

    div-float/2addr v6, v8

    iget v8, v0, Landroid/graphics/RectF;->left:F

    int-to-float v9, p1

    mul-float/2addr v8, v9

    add-float/2addr v6, v8

    float-to-int v6, v6

    .line 80
    .local v6, "left":I
    iget v8, p3, Landroid/graphics/Rect;->top:I

    int-to-float v8, v8

    mul-float/2addr v8, v5

    mul-float/2addr v8, v7

    int-to-float v9, v3

    div-float/2addr v8, v9

    iget v9, v0, Landroid/graphics/RectF;->top:F

    int-to-float v10, p2

    mul-float/2addr v9, v10

    add-float/2addr v8, v9

    float-to-int v8, v8

    .line 81
    .local v8, "top":I
    iget v9, p3, Landroid/graphics/Rect;->right:I

    int-to-float v9, v9

    mul-float/2addr v9, v4

    mul-float/2addr v9, v7

    int-to-float v10, v2

    div-float/2addr v9, v10

    iget v10, v0, Landroid/graphics/RectF;->left:F

    int-to-float v11, p1

    mul-float/2addr v10, v11

    add-float/2addr v9, v10

    float-to-int v9, v9

    .line 82
    .local v9, "right":I
    iget v10, p3, Landroid/graphics/Rect;->bottom:I

    int-to-float v10, v10

    mul-float/2addr v10, v5

    mul-float/2addr v10, v7

    int-to-float v7, v3

    div-float/2addr v10, v7

    iget v7, v0, Landroid/graphics/RectF;->top:F

    int-to-float v11, p2

    mul-float/2addr v7, v11

    add-float/2addr v10, v7

    float-to-int v7, v10

    .line 84
    .local v7, "bottom":I
    new-instance v10, Landroid/graphics/Rect;

    invoke-direct {v10, v6, v8, v9, v7}, Landroid/graphics/Rect;-><init>(IIII)V

    return-object v10

    .line 70
    .end local v1    # "screenSize":Landroid/util/Pair;, "Landroid/util/Pair<Ljava/lang/Integer;Ljava/lang/Integer;>;"
    .end local v2    # "width":I
    .end local v3    # "height":I
    .end local v4    # "w":F
    .end local v5    # "h":F
    .end local v6    # "left":I
    .end local v7    # "bottom":I
    .end local v8    # "top":I
    .end local v9    # "right":I
    :cond_1
    :goto_0
    const/4 v1, 0x0

    return-object v1
.end method

.method public static getWindowRect2K(Landroid/content/Context;IILandroid/graphics/Rect;)Landroid/graphics/Rect;
    .locals 1
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "previewWidth"    # I
    .param p2, "previewHeight"    # I
    .param p3, "windowRect"    # Landroid/graphics/Rect;
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 56
    invoke-static {p0, p1, p2, p3}, Lcom/rokid/utils/RokidSystem;->getWindowRect(Landroid/content/Context;IILandroid/graphics/Rect;)Landroid/graphics/Rect;

    move-result-object v0

    return-object v0
.end method

.method private static noAlignment()Z
    .locals 1

    .line 262
    const-string v0, "ro.rokid.alignment.left"

    invoke-static {v0}, Lcom/rokid/utils/SystemPropertyUtil;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    return v0
.end method

.method private static noAlignment2K()Z
    .locals 1

    .line 270
    const-string v0, "ro.rokid.2kalignment.left"

    invoke-static {v0}, Lcom/rokid/utils/SystemPropertyUtil;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    return v0
.end method

.method private static noAlignmentHD()Z
    .locals 1

    .line 266
    const-string/jumbo v0, "ro.rokid.fhdalignment.left"

    invoke-static {v0}, Lcom/rokid/utils/SystemPropertyUtil;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    return v0
.end method

.method private static toInt(Ljava/lang/String;)I
    .locals 1
    .param p0, "value"    # Ljava/lang/String;

    .line 256
    invoke-static {p0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_0

    invoke-static {p0}, Landroid/text/TextUtils;->isDigitsOnly(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 257
    invoke-static {p0}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v0

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    .line 256
    :goto_0
    return v0
.end method
