.class public final Lcom/blankj/utilcode/util/SizeUtils;
.super Ljava/lang/Object;
.source "SizeUtils.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/blankj/utilcode/util/SizeUtils$OnGetSizeListener;
    }
.end annotation


# direct methods
.method private constructor <init>()V
    .locals 2

    .line 19
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 20
    new-instance v0, Ljava/lang/UnsupportedOperationException;

    const-string/jumbo v1, "u can\'t instantiate me..."

    invoke-direct {v0, v1}, Ljava/lang/UnsupportedOperationException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public static applyDimension(FI)F
    .locals 3
    .param p0, "value"    # F
    .param p1, "unit"    # I

    .line 78
    invoke-static {}, Landroid/content/res/Resources;->getSystem()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v0

    .line 79
    .local v0, "metrics":Landroid/util/DisplayMetrics;
    packed-switch p1, :pswitch_data_0

    .line 93
    const/4 v1, 0x0

    return v1

    .line 91
    :pswitch_0
    iget v1, v0, Landroid/util/DisplayMetrics;->xdpi:F

    mul-float/2addr v1, p0

    const v2, 0x3d214285

    mul-float/2addr v1, v2

    return v1

    .line 89
    :pswitch_1
    iget v1, v0, Landroid/util/DisplayMetrics;->xdpi:F

    mul-float/2addr v1, p0

    return v1

    .line 87
    :pswitch_2
    iget v1, v0, Landroid/util/DisplayMetrics;->xdpi:F

    mul-float/2addr v1, p0

    const v2, 0x3c638e39

    mul-float/2addr v1, v2

    return v1

    .line 85
    :pswitch_3
    iget v1, v0, Landroid/util/DisplayMetrics;->scaledDensity:F

    mul-float/2addr v1, p0

    return v1

    .line 83
    :pswitch_4
    iget v1, v0, Landroid/util/DisplayMetrics;->density:F

    mul-float/2addr v1, p0

    return v1

    .line 81
    :pswitch_5
    return p0

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_5
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method public static dp2px(F)I
    .locals 3
    .param p0, "dpValue"    # F

    .line 30
    invoke-static {}, Landroid/content/res/Resources;->getSystem()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v0

    iget v0, v0, Landroid/util/DisplayMetrics;->density:F

    .line 31
    .local v0, "scale":F
    mul-float v1, p0, v0

    const/high16 v2, 0x3f000000    # 0.5f

    add-float/2addr v1, v2

    float-to-int v1, v1

    return v1
.end method

.method public static forceGetViewSize(Landroid/view/View;Lcom/blankj/utilcode/util/SizeUtils$OnGetSizeListener;)V
    .locals 1
    .param p0, "view"    # Landroid/view/View;
    .param p1, "listener"    # Lcom/blankj/utilcode/util/SizeUtils$OnGetSizeListener;

    .line 112
    new-instance v0, Lcom/blankj/utilcode/util/SizeUtils$1;

    invoke-direct {v0, p1, p0}, Lcom/blankj/utilcode/util/SizeUtils$1;-><init>(Lcom/blankj/utilcode/util/SizeUtils$OnGetSizeListener;Landroid/view/View;)V

    invoke-virtual {p0, v0}, Landroid/view/View;->post(Ljava/lang/Runnable;)Z

    .line 120
    return-void
.end method

.method public static getMeasuredHeight(Landroid/view/View;)I
    .locals 2
    .param p0, "view"    # Landroid/view/View;

    .line 139
    invoke-static {p0}, Lcom/blankj/utilcode/util/SizeUtils;->measureView(Landroid/view/View;)[I

    move-result-object v0

    const/4 v1, 0x1

    aget v0, v0, v1

    return v0
.end method

.method public static getMeasuredWidth(Landroid/view/View;)I
    .locals 2
    .param p0, "view"    # Landroid/view/View;

    .line 129
    invoke-static {p0}, Lcom/blankj/utilcode/util/SizeUtils;->measureView(Landroid/view/View;)[I

    move-result-object v0

    const/4 v1, 0x0

    aget v0, v0, v1

    return v0
.end method

.method public static measureView(Landroid/view/View;)[I
    .locals 6
    .param p0, "view"    # Landroid/view/View;

    .line 149
    invoke-virtual {p0}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v0

    .line 150
    .local v0, "lp":Landroid/view/ViewGroup$LayoutParams;
    if-nez v0, :cond_0

    .line 151
    new-instance v1, Landroid/view/ViewGroup$LayoutParams;

    const/4 v2, -0x1

    const/4 v3, -0x2

    invoke-direct {v1, v2, v3}, Landroid/view/ViewGroup$LayoutParams;-><init>(II)V

    move-object v0, v1

    .line 156
    :cond_0
    iget v1, v0, Landroid/view/ViewGroup$LayoutParams;->width:I

    const/4 v2, 0x0

    invoke-static {v2, v2, v1}, Landroid/view/ViewGroup;->getChildMeasureSpec(III)I

    move-result v1

    .line 157
    .local v1, "widthSpec":I
    iget v3, v0, Landroid/view/ViewGroup$LayoutParams;->height:I

    .line 159
    .local v3, "lpHeight":I
    if-lez v3, :cond_1

    .line 160
    const/high16 v2, 0x40000000    # 2.0f

    invoke-static {v3, v2}, Landroid/view/View$MeasureSpec;->makeMeasureSpec(II)I

    move-result v2

    .local v2, "heightSpec":I
    goto :goto_0

    .line 162
    .end local v2    # "heightSpec":I
    :cond_1
    invoke-static {v2, v2}, Landroid/view/View$MeasureSpec;->makeMeasureSpec(II)I

    move-result v2

    .line 164
    .restart local v2    # "heightSpec":I
    :goto_0
    invoke-virtual {p0, v1, v2}, Landroid/view/View;->measure(II)V

    .line 165
    invoke-virtual {p0}, Landroid/view/View;->getMeasuredWidth()I

    move-result v4

    invoke-virtual {p0}, Landroid/view/View;->getMeasuredHeight()I

    move-result v5

    filled-new-array {v4, v5}, [I

    move-result-object v4

    return-object v4
.end method

.method public static px2dp(F)I
    .locals 3
    .param p0, "pxValue"    # F

    .line 41
    invoke-static {}, Landroid/content/res/Resources;->getSystem()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v0

    iget v0, v0, Landroid/util/DisplayMetrics;->density:F

    .line 42
    .local v0, "scale":F
    div-float v1, p0, v0

    const/high16 v2, 0x3f000000    # 0.5f

    add-float/2addr v1, v2

    float-to-int v1, v1

    return v1
.end method

.method public static px2sp(F)I
    .locals 3
    .param p0, "pxValue"    # F

    .line 63
    invoke-static {}, Landroid/content/res/Resources;->getSystem()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v0

    iget v0, v0, Landroid/util/DisplayMetrics;->scaledDensity:F

    .line 64
    .local v0, "fontScale":F
    div-float v1, p0, v0

    const/high16 v2, 0x3f000000    # 0.5f

    add-float/2addr v1, v2

    float-to-int v1, v1

    return v1
.end method

.method public static sp2px(F)I
    .locals 3
    .param p0, "spValue"    # F

    .line 52
    invoke-static {}, Landroid/content/res/Resources;->getSystem()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v0

    iget v0, v0, Landroid/util/DisplayMetrics;->scaledDensity:F

    .line 53
    .local v0, "fontScale":F
    mul-float v1, p0, v0

    const/high16 v2, 0x3f000000    # 0.5f

    add-float/2addr v1, v2

    float-to-int v1, v1

    return v1
.end method
