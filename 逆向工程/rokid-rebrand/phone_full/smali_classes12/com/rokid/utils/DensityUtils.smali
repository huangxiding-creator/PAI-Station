.class public Lcom/rokid/utils/DensityUtils;
.super Ljava/lang/Object;
.source "DensityUtils.java"


# static fields
.field private static sRoncompatDennsity:F

.field private static sRoncompatScaledDensity:F


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 16
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static synthetic access$002(F)F
    .locals 0
    .param p0, "x0"    # F

    .line 16
    sput p0, Lcom/rokid/utils/DensityUtils;->sRoncompatScaledDensity:F

    return p0
.end method

.method public static getDeviation(FF)F
    .locals 4
    .param p0, "value"    # F
    .param p1, "base"    # F

    .line 87
    const/4 v0, 0x0

    cmpl-float v1, p1, v0

    const/high16 v2, 0x43af0000    # 350.0f

    const/high16 v3, 0x43340000    # 180.0f

    if-lez v1, :cond_2

    .line 88
    cmpl-float v0, p0, v0

    if-lez v0, :cond_0

    .line 89
    sub-float v0, p0, p1

    return v0

    .line 91
    :cond_0
    sub-float v0, p0, p1

    invoke-static {v0}, Ljava/lang/Math;->abs(F)F

    move-result v0

    cmpg-float v0, v0, v2

    if-gez v0, :cond_1

    .line 92
    sub-float v0, p0, p1

    return v0

    .line 94
    :cond_1
    add-float v0, p0, v3

    add-float/2addr v0, v3

    sub-float/2addr v0, p1

    return v0

    .line 99
    :cond_2
    cmpg-float v0, p0, v0

    if-gez v0, :cond_3

    .line 100
    sub-float v0, p0, p1

    return v0

    .line 102
    :cond_3
    sub-float v0, p0, p1

    invoke-static {v0}, Ljava/lang/Math;->abs(F)F

    move-result v0

    cmpg-float v0, v0, v2

    if-gez v0, :cond_4

    .line 103
    sub-float v0, p0, p1

    return v0

    .line 105
    :cond_4
    const/high16 v0, -0x3ccc0000    # -180.0f

    add-float/2addr v0, p0

    sub-float/2addr v0, v3

    sub-float/2addr v0, p1

    return v0
.end method

.method public static getHeight(Landroid/content/Context;)I
    .locals 3
    .param p0, "context"    # Landroid/content/Context;

    .line 68
    const-string/jumbo v0, "window"

    invoke-virtual {p0, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/view/WindowManager;

    .line 69
    .local v0, "windowManager":Landroid/view/WindowManager;
    new-instance v1, Landroid/util/DisplayMetrics;

    invoke-direct {v1}, Landroid/util/DisplayMetrics;-><init>()V

    .line 70
    .local v1, "outMetrics":Landroid/util/DisplayMetrics;
    invoke-interface {v0}, Landroid/view/WindowManager;->getDefaultDisplay()Landroid/view/Display;

    move-result-object v2

    invoke-virtual {v2, v1}, Landroid/view/Display;->getMetrics(Landroid/util/DisplayMetrics;)V

    .line 71
    iget v2, v1, Landroid/util/DisplayMetrics;->heightPixels:I

    return v2
.end method

.method public static getMidLocation(IIII)[F
    .locals 6
    .param p0, "leftMargin"    # I
    .param p1, "topMargin"    # I
    .param p2, "width"    # I
    .param p3, "heigh"    # I

    .line 167
    div-int/lit8 v0, p2, 0x2

    sub-int/2addr v0, p0

    .line 168
    .local v0, "middleWidth":I
    div-int/lit8 v1, p3, 0x2

    sub-int/2addr v1, p1

    .line 169
    .local v1, "middleHeith":I
    int-to-float v2, v0

    int-to-float v3, v1

    const/4 v4, 0x2

    new-array v4, v4, [F

    const/4 v5, 0x0

    aput v2, v4, v5

    const/4 v2, 0x1

    aput v3, v4, v2

    return-object v4
.end method

.method public static getScreenSize(Landroid/content/Context;)Landroid/util/Pair;
    .locals 5
    .param p0, "context"    # Landroid/content/Context;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            ")",
            "Landroid/util/Pair<",
            "Ljava/lang/Integer;",
            "Ljava/lang/Integer;",
            ">;"
        }
    .end annotation

    .line 75
    const-string/jumbo v0, "window"

    invoke-virtual {p0, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/view/WindowManager;

    .line 76
    .local v0, "windowManager":Landroid/view/WindowManager;
    new-instance v1, Landroid/util/DisplayMetrics;

    invoke-direct {v1}, Landroid/util/DisplayMetrics;-><init>()V

    .line 77
    .local v1, "outMetrics":Landroid/util/DisplayMetrics;
    invoke-interface {v0}, Landroid/view/WindowManager;->getDefaultDisplay()Landroid/view/Display;

    move-result-object v2

    invoke-virtual {v2, v1}, Landroid/view/Display;->getMetrics(Landroid/util/DisplayMetrics;)V

    .line 78
    new-instance v2, Landroid/util/Pair;

    iget v3, v1, Landroid/util/DisplayMetrics;->widthPixels:I

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    iget v4, v1, Landroid/util/DisplayMetrics;->heightPixels:I

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    invoke-direct {v2, v3, v4}, Landroid/util/Pair;-><init>(Ljava/lang/Object;Ljava/lang/Object;)V

    return-object v2
.end method

.method public static getWidth(Landroid/content/Context;)I
    .locals 3
    .param p0, "context"    # Landroid/content/Context;

    .line 61
    const-string/jumbo v0, "window"

    invoke-virtual {p0, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/view/WindowManager;

    .line 62
    .local v0, "windowManager":Landroid/view/WindowManager;
    new-instance v1, Landroid/util/DisplayMetrics;

    invoke-direct {v1}, Landroid/util/DisplayMetrics;-><init>()V

    .line 63
    .local v1, "outMetrics":Landroid/util/DisplayMetrics;
    invoke-interface {v0}, Landroid/view/WindowManager;->getDefaultDisplay()Landroid/view/Display;

    move-result-object v2

    invoke-virtual {v2, v1}, Landroid/view/Display;->getMetrics(Landroid/util/DisplayMetrics;)V

    .line 64
    iget v2, v1, Landroid/util/DisplayMetrics;->widthPixels:I

    return v2
.end method

.method public static locationInParent(Landroid/view/View;Landroid/view/ViewGroup;)[I
    .locals 4
    .param p0, "view"    # Landroid/view/View;
    .param p1, "parent"    # Landroid/view/ViewGroup;

    .line 120
    const/4 v0, 0x0

    .line 121
    .local v0, "left":I
    const/4 v1, 0x0

    .line 122
    .local v1, "top":I
    :cond_0
    invoke-virtual {p0}, Landroid/view/View;->getParent()Landroid/view/ViewParent;

    move-result-object v2

    if-eqz v2, :cond_1

    .line 123
    invoke-virtual {p0}, Landroid/view/View;->getLeft()I

    move-result v2

    add-int/2addr v0, v2

    .line 124
    invoke-virtual {p0}, Landroid/view/View;->getTop()I

    move-result v2

    add-int/2addr v1, v2

    .line 125
    invoke-virtual {p0}, Landroid/view/View;->getParent()Landroid/view/ViewParent;

    move-result-object v2

    move-object p0, v2

    check-cast p0, Landroid/view/View;

    .line 126
    invoke-virtual {p0}, Landroid/view/View;->getId()I

    move-result v2

    invoke-virtual {p1}, Landroid/view/ViewGroup;->getId()I

    move-result v3

    if-ne v2, v3, :cond_0

    .line 127
    nop

    .line 131
    :cond_1
    filled-new-array {v0, v1}, [I

    move-result-object v2

    return-object v2
.end method

.method public static needCheckFocus(IILandroid/view/View;Landroid/view/ViewGroup;)I
    .locals 7
    .param p0, "midx"    # I
    .param p1, "midy"    # I
    .param p2, "view"    # Landroid/view/View;
    .param p3, "parent"    # Landroid/view/ViewGroup;

    .line 143
    invoke-static {p2, p3}, Lcom/rokid/utils/DensityUtils;->locationInParent(Landroid/view/View;Landroid/view/ViewGroup;)[I

    move-result-object v0

    .line 144
    .local v0, "locationInt":[I
    invoke-virtual {p2}, Landroid/view/View;->getWidth()I

    move-result v1

    .line 145
    .local v1, "width":I
    invoke-virtual {p2}, Landroid/view/View;->getHeight()I

    move-result v2

    .line 146
    .local v2, "height":I
    const/4 v3, 0x0

    .line 147
    .local v3, "needFocus":Z
    const/4 v4, 0x0

    aget v5, v0, v4

    const/4 v6, 0x1

    if-le p0, v5, :cond_0

    aget v5, v0, v4

    add-int/2addr v5, v1

    if-ge p0, v5, :cond_0

    aget v5, v0, v6

    if-le p1, v5, :cond_0

    aget v5, v0, v6

    add-int/2addr v5, v2

    if-ge p1, v5, :cond_0

    .line 148
    const/4 v3, 0x1

    .line 149
    :cond_0
    invoke-virtual {p2}, Landroid/view/View;->isSelected()Z

    move-result v5

    if-nez v5, :cond_1

    if-eqz v3, :cond_1

    .line 150
    invoke-virtual {p2, v6}, Landroid/view/View;->setSelected(Z)V

    .line 151
    invoke-virtual {p2}, Landroid/view/View;->requestFocus()Z

    .line 152
    return v6

    .line 153
    :cond_1
    invoke-virtual {p2}, Landroid/view/View;->isSelected()Z

    move-result v5

    if-eqz v5, :cond_2

    if-nez v3, :cond_2

    .line 154
    invoke-virtual {p2, v4}, Landroid/view/View;->setSelected(Z)V

    .line 155
    invoke-virtual {p2}, Landroid/view/View;->clearFocus()V

    .line 156
    const/4 v4, -0x1

    return v4

    .line 158
    :cond_2
    return v4
.end method

.method public static setCustomDensity(Landroid/content/Context;)V
    .locals 5
    .param p0, "activity"    # Landroid/content/Context;

    .line 24
    invoke-virtual {p0}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v0

    .line 25
    .local v0, "appDisplayMetrics":Landroid/util/DisplayMetrics;
    sget v1, Lcom/rokid/utils/DensityUtils;->sRoncompatDennsity:F

    const/4 v2, 0x0

    cmpl-float v1, v1, v2

    if-nez v1, :cond_0

    .line 26
    iget v1, v0, Landroid/util/DisplayMetrics;->density:F

    sput v1, Lcom/rokid/utils/DensityUtils;->sRoncompatDennsity:F

    .line 27
    iget v1, v0, Landroid/util/DisplayMetrics;->scaledDensity:F

    sput v1, Lcom/rokid/utils/DensityUtils;->sRoncompatScaledDensity:F

    .line 28
    invoke-virtual {p0}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v1

    new-instance v2, Lcom/rokid/utils/DensityUtils$1;

    invoke-direct {v2, p0}, Lcom/rokid/utils/DensityUtils$1;-><init>(Landroid/content/Context;)V

    invoke-virtual {v1, v2}, Landroid/content/Context;->registerComponentCallbacks(Landroid/content/ComponentCallbacks;)V

    .line 44
    :cond_0
    iget v1, v0, Landroid/util/DisplayMetrics;->widthPixels:I

    int-to-float v1, v1

    const v2, 0x4426c000    # 667.0f

    div-float/2addr v1, v2

    .line 45
    .local v1, "targetDensity":F
    sget v2, Lcom/rokid/utils/DensityUtils;->sRoncompatScaledDensity:F

    sget v3, Lcom/rokid/utils/DensityUtils;->sRoncompatDennsity:F

    div-float/2addr v2, v3

    mul-float/2addr v2, v1

    .line 46
    .local v2, "targetScaledDensity":F
    const/high16 v3, 0x43200000    # 160.0f

    mul-float/2addr v3, v1

    float-to-int v3, v3

    .line 48
    .local v3, "targetDensityDpi":I
    iput v1, v0, Landroid/util/DisplayMetrics;->density:F

    .line 49
    iput v3, v0, Landroid/util/DisplayMetrics;->densityDpi:I

    .line 50
    iput v2, v0, Landroid/util/DisplayMetrics;->scaledDensity:F

    .line 53
    invoke-virtual {p0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v4

    invoke-virtual {v4}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v4

    .line 55
    .local v4, "activityDisplayMetrics":Landroid/util/DisplayMetrics;
    iput v1, v4, Landroid/util/DisplayMetrics;->density:F

    .line 56
    iput v3, v4, Landroid/util/DisplayMetrics;->densityDpi:I

    .line 57
    iput v2, v4, Landroid/util/DisplayMetrics;->scaledDensity:F

    .line 58
    return-void
.end method
