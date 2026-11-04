.class public Lcom/rokid/security/phone/sdk/api/utils/RokidSystem;
.super Ljava/lang/Object;
.source "RokidSystem.java"


# static fields
.field private static final BASE_HEIGHT:I = 0x2d0

.field private static final BASE_HEIGHT_720P:I = 0x2d0

.field private static final BASE_HEIGHT_HD:I = 0x438

.field private static final BASE_WIDTH:I = 0x500

.field private static final BASE_WIDTH_720P:I = 0x500

.field private static final BASE_WIDTH_HD:I = 0x780

.field private static final DVT_ALIGNMENT:Landroid/graphics/Rect;

.field private static final HARDWARE_VERSION:Ljava/lang/String; = "ro.rokid.hardware.version"

.field public static final HW_OPTICAL_A:I = 0x1

.field public static final HW_OPTICAL_B:I = 0x2

.field public static final HW_OPTICAL_C:I = 0x3

.field private static HW_OPTICAL_TYPE:I

.field private static final PVT_ALIGNMENT:Landroid/graphics/Rect;

.field private static final TAG:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 5

    .line 9
    const-class v0, Lcom/rokid/security/phone/sdk/api/utils/RokidSystem;

    invoke-virtual {v0}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/rokid/security/phone/sdk/api/utils/RokidSystem;->TAG:Ljava/lang/String;

    .line 26
    const/4 v0, 0x3

    sput v0, Lcom/rokid/security/phone/sdk/api/utils/RokidSystem;->HW_OPTICAL_TYPE:I

    .line 28
    new-instance v0, Landroid/graphics/Rect;

    const/16 v1, 0x3aa

    const/16 v2, 0x1f8

    const/16 v3, 0x178

    const/16 v4, 0xae

    invoke-direct {v0, v3, v4, v1, v2}, Landroid/graphics/Rect;-><init>(IIII)V

    sput-object v0, Lcom/rokid/security/phone/sdk/api/utils/RokidSystem;->DVT_ALIGNMENT:Landroid/graphics/Rect;

    .line 31
    new-instance v0, Landroid/graphics/Rect;

    const/16 v1, 0x415

    const/16 v2, 0x2f5

    const/16 v3, 0x1c8

    const/16 v4, 0x180

    invoke-direct {v0, v3, v4, v1, v2}, Landroid/graphics/Rect;-><init>(IIII)V

    sput-object v0, Lcom/rokid/security/phone/sdk/api/utils/RokidSystem;->PVT_ALIGNMENT:Landroid/graphics/Rect;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .line 8
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static getAlignmentBaseRect()Landroid/graphics/Rect;
    .locals 1

    .line 147
    sget-object v0, Lcom/rokid/security/phone/sdk/api/utils/RokidSystem;->PVT_ALIGNMENT:Landroid/graphics/Rect;

    return-object v0
.end method

.method public static getAlignmentBaseRectHD()Landroid/graphics/Rect;
    .locals 5

    .line 152
    new-instance v0, Landroid/graphics/Rect;

    const/16 v1, 0x6a4

    const/16 v2, 0x33e

    const/16 v3, 0x1f4

    const/16 v4, 0xc8

    invoke-direct {v0, v3, v4, v1, v2}, Landroid/graphics/Rect;-><init>(IIII)V

    return-object v0
.end method

.method public static getAlignmentPercent(II)Landroid/graphics/RectF;
    .locals 7
    .param p0, "width"    # I
    .param p1, "height"    # I

    .line 131
    invoke-static {}, Lcom/rokid/security/phone/sdk/api/utils/RokidSystem;->getAlignmentBaseRect()Landroid/graphics/Rect;

    move-result-object v0

    .line 132
    .local v0, "rect":Landroid/graphics/Rect;
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

.method public static getAlignmentRect(IILandroid/graphics/Rect;)Landroid/graphics/Rect;
    .locals 12
    .param p0, "previewWidth"    # I
    .param p1, "previewHeight"    # I
    .param p2, "previewRect"    # Landroid/graphics/Rect;

    .line 101
    invoke-static {p0}, Lcom/rokid/security/phone/sdk/api/utils/RokidSystem;->getAlignmentRectF(I)Landroid/graphics/RectF;

    move-result-object v0

    .line 102
    .local v0, "rectF":Landroid/graphics/RectF;
    if-nez v0, :cond_0

    .line 103
    const/4 v1, 0x0

    return-object v1

    .line 106
    :cond_0
    iget v1, v0, Landroid/graphics/RectF;->right:F

    iget v2, v0, Landroid/graphics/RectF;->left:F

    sub-float/2addr v1, v2

    int-to-float v2, p0

    mul-float/2addr v1, v2

    .line 107
    .local v1, "w":F
    iget v2, v0, Landroid/graphics/RectF;->bottom:F

    iget v3, v0, Landroid/graphics/RectF;->top:F

    sub-float/2addr v2, v3

    int-to-float v3, p1

    mul-float/2addr v2, v3

    .line 109
    .local v2, "h":F
    const/16 v3, 0x500

    .line 110
    .local v3, "width":I
    const/16 v4, 0x2d0

    .line 112
    .local v4, "height":I
    iget v5, p2, Landroid/graphics/Rect;->left:I

    int-to-float v5, v5

    iget v6, v0, Landroid/graphics/RectF;->left:F

    int-to-float v7, p0

    mul-float/2addr v6, v7

    sub-float/2addr v5, v6

    const/high16 v6, 0x3f800000    # 1.0f

    mul-float/2addr v5, v6

    div-float/2addr v5, v1

    int-to-float v7, v3

    mul-float/2addr v5, v7

    float-to-int v5, v5

    .line 113
    .local v5, "left":I
    iget v7, p2, Landroid/graphics/Rect;->top:I

    int-to-float v7, v7

    iget v8, v0, Landroid/graphics/RectF;->top:F

    int-to-float v9, p1

    mul-float/2addr v8, v9

    sub-float/2addr v7, v8

    mul-float/2addr v7, v6

    div-float/2addr v7, v2

    int-to-float v8, v4

    mul-float/2addr v7, v8

    float-to-int v7, v7

    .line 114
    .local v7, "top":I
    iget v8, p2, Landroid/graphics/Rect;->right:I

    int-to-float v8, v8

    iget v9, v0, Landroid/graphics/RectF;->left:F

    int-to-float v10, p0

    mul-float/2addr v9, v10

    sub-float/2addr v8, v9

    mul-float/2addr v8, v6

    div-float/2addr v8, v1

    int-to-float v9, v3

    mul-float/2addr v8, v9

    float-to-int v8, v8

    .line 115
    .local v8, "right":I
    iget v9, p2, Landroid/graphics/Rect;->bottom:I

    int-to-float v9, v9

    iget v10, v0, Landroid/graphics/RectF;->top:F

    int-to-float v11, p1

    mul-float/2addr v10, v11

    sub-float/2addr v9, v10

    mul-float/2addr v9, v6

    div-float/2addr v9, v2

    int-to-float v6, v4

    mul-float/2addr v9, v6

    float-to-int v6, v9

    .line 117
    .local v6, "bottom":I
    new-instance v9, Landroid/graphics/Rect;

    invoke-direct {v9, v5, v7, v8, v6}, Landroid/graphics/Rect;-><init>(IIII)V

    return-object v9
.end method

.method public static getAlignmentRect2K(IILandroid/graphics/Rect;)Landroid/graphics/Rect;
    .locals 1
    .param p0, "previewWidth"    # I
    .param p1, "previewHeight"    # I
    .param p2, "previewRect"    # Landroid/graphics/Rect;
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 89
    invoke-static {p0, p1, p2}, Lcom/rokid/security/phone/sdk/api/utils/RokidSystem;->getAlignmentRect(IILandroid/graphics/Rect;)Landroid/graphics/Rect;

    move-result-object v0

    return-object v0
.end method

.method private static getAlignmentRectF(I)Landroid/graphics/RectF;
    .locals 3
    .param p0, "previewWidth"    # I

    .line 137
    const/16 v0, 0x500

    .line 138
    .local v0, "width":I
    const/16 v1, 0x2d0

    .line 139
    .local v1, "height":I
    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/api/utils/RokidSystem;->getAlignmentPercent(II)Landroid/graphics/RectF;

    move-result-object v2

    return-object v2
.end method

.method public static getHW_OPTICAL_TYPE()I
    .locals 1

    .line 205
    sget v0, Lcom/rokid/security/phone/sdk/api/utils/RokidSystem;->HW_OPTICAL_TYPE:I

    return v0
.end method

.method public static getHardwareVersion()Ljava/lang/String;
    .locals 1

    .line 183
    const-string/jumbo v0, "ro.rokid.hardware.version"

    invoke-static {v0}, Lcom/rokid/security/phone/sdk/api/utils/RokidSystem;->getSystemProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static getProjectionMatrix_OpticalSeeThrough()[F
    .locals 9

    .line 162
    const/16 v0, 0x10

    new-array v3, v0, [F

    fill-array-data v3, :array_0

    .line 164
    .local v3, "rawProjectionMatrixGL2":[F
    new-array v1, v0, [D

    fill-array-data v1, :array_1

    move-object v7, v1

    .line 165
    .local v7, "tmp":[D
    new-array v8, v0, [F

    .line 166
    .local v8, "eyeAdjustmentGL2":[F
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_0
    if-ge v1, v0, :cond_0

    .line 167
    aget-wide v4, v7, v1

    double-to-float v2, v4

    aput v2, v8, v1

    .line 166
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 170
    .end local v1    # "i":I
    :cond_0
    new-array v0, v0, [F

    .line 171
    .local v0, "projectionMatrix":[F
    const/4 v4, 0x0

    const/4 v6, 0x0

    const/4 v2, 0x0

    move-object v1, v0

    move-object v5, v8

    invoke-static/range {v1 .. v6}, Landroid/opengl/Matrix;->multiplyMM([FI[FI[FI)V

    .line 173
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

.method public static getSystemProperty(Ljava/lang/String;)Ljava/lang/String;
    .locals 6
    .param p0, "key"    # Ljava/lang/String;

    .line 192
    const/4 v0, 0x0

    .line 195
    .local v0, "value":Ljava/lang/String;
    :try_start_0
    const-string v1, "android.os.SystemProperties"

    invoke-static {v1}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v1

    const-string v2, "get"

    const/4 v3, 0x1

    new-array v3, v3, [Ljava/lang/Class;

    const-class v4, Ljava/lang/String;

    const/4 v5, 0x0

    aput-object v4, v3, v5

    .line 196
    invoke-virtual {v1, v2, v3}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v1

    filled-new-array {p0}, [Ljava/lang/Object;

    move-result-object v2

    const/4 v3, 0x0

    invoke-virtual {v1, v3, v2}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-object v0, v1

    .line 199
    goto :goto_0

    .line 197
    :catch_0
    move-exception v1

    .line 198
    .local v1, "e":Ljava/lang/Exception;
    invoke-virtual {v1}, Ljava/lang/Exception;->printStackTrace()V

    .line 201
    .end local v1    # "e":Ljava/lang/Exception;
    :goto_0
    return-object v0
.end method

.method public static getWindowRect(IILandroid/graphics/Rect;)Landroid/graphics/Rect;
    .locals 11
    .param p0, "previewWidth"    # I
    .param p1, "previewHeight"    # I
    .param p2, "windowRect"    # Landroid/graphics/Rect;

    .line 55
    invoke-static {p0}, Lcom/rokid/security/phone/sdk/api/utils/RokidSystem;->getAlignmentRectF(I)Landroid/graphics/RectF;

    move-result-object v0

    .line 56
    .local v0, "rectF":Landroid/graphics/RectF;
    if-nez v0, :cond_0

    .line 57
    const/4 v1, 0x0

    return-object v1

    .line 60
    :cond_0
    const/16 v1, 0x500

    .line 61
    .local v1, "width":I
    const/16 v2, 0x2d0

    .line 68
    .local v2, "height":I
    iget v3, v0, Landroid/graphics/RectF;->right:F

    iget v4, v0, Landroid/graphics/RectF;->left:F

    sub-float/2addr v3, v4

    int-to-float v4, p0

    mul-float/2addr v3, v4

    .line 69
    .local v3, "w":F
    iget v4, v0, Landroid/graphics/RectF;->bottom:F

    iget v5, v0, Landroid/graphics/RectF;->top:F

    sub-float/2addr v4, v5

    int-to-float v5, p1

    mul-float/2addr v4, v5

    .line 71
    .local v4, "h":F
    iget v5, p2, Landroid/graphics/Rect;->left:I

    int-to-float v5, v5

    mul-float/2addr v5, v3

    const/high16 v6, 0x3f800000    # 1.0f

    mul-float/2addr v5, v6

    int-to-float v7, v1

    div-float/2addr v5, v7

    iget v7, v0, Landroid/graphics/RectF;->left:F

    int-to-float v8, p0

    mul-float/2addr v7, v8

    add-float/2addr v5, v7

    float-to-int v5, v5

    .line 72
    .local v5, "left":I
    iget v7, p2, Landroid/graphics/Rect;->top:I

    int-to-float v7, v7

    mul-float/2addr v7, v4

    mul-float/2addr v7, v6

    int-to-float v8, v2

    div-float/2addr v7, v8

    iget v8, v0, Landroid/graphics/RectF;->top:F

    int-to-float v9, p1

    mul-float/2addr v8, v9

    add-float/2addr v7, v8

    float-to-int v7, v7

    .line 73
    .local v7, "top":I
    iget v8, p2, Landroid/graphics/Rect;->right:I

    int-to-float v8, v8

    mul-float/2addr v8, v3

    mul-float/2addr v8, v6

    int-to-float v9, v1

    div-float/2addr v8, v9

    iget v9, v0, Landroid/graphics/RectF;->left:F

    int-to-float v10, p0

    mul-float/2addr v9, v10

    add-float/2addr v8, v9

    float-to-int v8, v8

    .line 74
    .local v8, "right":I
    iget v9, p2, Landroid/graphics/Rect;->bottom:I

    int-to-float v9, v9

    mul-float/2addr v9, v4

    mul-float/2addr v9, v6

    int-to-float v6, v2

    div-float/2addr v9, v6

    iget v6, v0, Landroid/graphics/RectF;->top:F

    int-to-float v10, p1

    mul-float/2addr v6, v10

    add-float/2addr v9, v6

    float-to-int v6, v9

    .line 76
    .local v6, "bottom":I
    new-instance v9, Landroid/graphics/Rect;

    invoke-direct {v9, v5, v7, v8, v6}, Landroid/graphics/Rect;-><init>(IIII)V

    return-object v9
.end method

.method public static getWindowRect2K(IILandroid/graphics/Rect;)Landroid/graphics/Rect;
    .locals 1
    .param p0, "previewWidth"    # I
    .param p1, "previewHeight"    # I
    .param p2, "windowRect"    # Landroid/graphics/Rect;
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 43
    invoke-static {p0, p1, p2}, Lcom/rokid/security/phone/sdk/api/utils/RokidSystem;->getWindowRect(IILandroid/graphics/Rect;)Landroid/graphics/Rect;

    move-result-object v0

    return-object v0
.end method

.method public static setHW_OPTICAL_TYPE(I)V
    .locals 0
    .param p0, "type"    # I

    .line 209
    sput p0, Lcom/rokid/security/phone/sdk/api/utils/RokidSystem;->HW_OPTICAL_TYPE:I

    .line 210
    return-void
.end method

.method private static toInt(Ljava/lang/String;)I
    .locals 1
    .param p0, "value"    # Ljava/lang/String;

    .line 187
    invoke-static {p0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_0

    invoke-static {p0}, Landroid/text/TextUtils;->isDigitsOnly(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 188
    invoke-static {p0}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v0

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    .line 187
    :goto_0
    return v0
.end method
