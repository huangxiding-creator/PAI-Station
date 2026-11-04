.class public final Lcom/blankj/utilcode/util/AdaptScreenUtils;
.super Ljava/lang/Object;
.source "AdaptScreenUtils.java"


# static fields
.field private static sMetricsFields:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Ljava/lang/reflect/Field;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method private constructor <init>()V
    .locals 2

    .line 24
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 25
    new-instance v0, Ljava/lang/UnsupportedOperationException;

    const-string/jumbo v1, "u can\'t instantiate me..."

    invoke-direct {v0, v1}, Ljava/lang/UnsupportedOperationException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method static synthetic access$000()V
    .locals 0

    .line 20
    invoke-static {}, Lcom/blankj/utilcode/util/AdaptScreenUtils;->preLoad()V

    return-void
.end method

.method public static adaptHeight(Landroid/content/res/Resources;I)Landroid/content/res/Resources;
    .locals 1
    .param p0, "resources"    # Landroid/content/res/Resources;
    .param p1, "designHeight"    # I

    .line 43
    const/4 v0, 0x0

    invoke-static {p0, p1, v0}, Lcom/blankj/utilcode/util/AdaptScreenUtils;->adaptHeight(Landroid/content/res/Resources;IZ)Landroid/content/res/Resources;

    move-result-object v0

    return-object v0
.end method

.method public static adaptHeight(Landroid/content/res/Resources;IZ)Landroid/content/res/Resources;
    .locals 2
    .param p0, "resources"    # Landroid/content/res/Resources;
    .param p1, "designHeight"    # I
    .param p2, "includeNavBar"    # Z

    .line 51
    invoke-virtual {p0}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v0

    iget v0, v0, Landroid/util/DisplayMetrics;->heightPixels:I

    if-eqz p2, :cond_0

    .line 52
    invoke-static {p0}, Lcom/blankj/utilcode/util/AdaptScreenUtils;->getNavBarHeight(Landroid/content/res/Resources;)I

    move-result v1

    goto :goto_0

    :cond_0
    const/4 v1, 0x0

    :goto_0
    add-int/2addr v0, v1

    int-to-float v0, v0

    const/high16 v1, 0x42900000    # 72.0f

    mul-float/2addr v0, v1

    .line 53
    .local v0, "screenHeight":F
    int-to-float v1, p1

    div-float v1, v0, v1

    .line 54
    .local v1, "newXdpi":F
    invoke-static {p0, v1}, Lcom/blankj/utilcode/util/AdaptScreenUtils;->applyDisplayMetrics(Landroid/content/res/Resources;F)V

    .line 55
    return-object p0
.end method

.method public static adaptWidth(Landroid/content/res/Resources;I)Landroid/content/res/Resources;
    .locals 2
    .param p0, "resources"    # Landroid/content/res/Resources;
    .param p1, "designWidth"    # I

    .line 33
    invoke-virtual {p0}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v0

    iget v0, v0, Landroid/util/DisplayMetrics;->widthPixels:I

    int-to-float v0, v0

    const/high16 v1, 0x42900000    # 72.0f

    mul-float/2addr v0, v1

    int-to-float v1, p1

    div-float/2addr v0, v1

    .line 34
    .local v0, "newXdpi":F
    invoke-static {p0, v0}, Lcom/blankj/utilcode/util/AdaptScreenUtils;->applyDisplayMetrics(Landroid/content/res/Resources;F)V

    .line 35
    return-object p0
.end method

.method private static applyDisplayMetrics(Landroid/content/res/Resources;F)V
    .locals 1
    .param p0, "resources"    # Landroid/content/res/Resources;
    .param p1, "newXdpi"    # F

    .line 101
    invoke-virtual {p0}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v0

    iput p1, v0, Landroid/util/DisplayMetrics;->xdpi:F

    .line 102
    invoke-static {}, Lcom/blankj/utilcode/util/Utils;->getApp()Landroid/app/Application;

    move-result-object v0

    invoke-virtual {v0}, Landroid/app/Application;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v0

    iput p1, v0, Landroid/util/DisplayMetrics;->xdpi:F

    .line 103
    invoke-static {p0, p1}, Lcom/blankj/utilcode/util/AdaptScreenUtils;->applyOtherDisplayMetrics(Landroid/content/res/Resources;F)V

    .line 104
    return-void
.end method

.method private static applyMetricsFields(Landroid/content/res/Resources;F)V
    .locals 3
    .param p0, "resources"    # Landroid/content/res/Resources;
    .param p1, "newXdpi"    # F

    .line 148
    sget-object v0, Lcom/blankj/utilcode/util/AdaptScreenUtils;->sMetricsFields:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/reflect/Field;

    .line 150
    .local v1, "metricsField":Ljava/lang/reflect/Field;
    :try_start_0
    invoke-virtual {v1, p0}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Landroid/util/DisplayMetrics;

    .line 151
    .local v2, "dm":Landroid/util/DisplayMetrics;
    if-eqz v2, :cond_0

    iput p1, v2, Landroid/util/DisplayMetrics;->xdpi:F
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 154
    .end local v2    # "dm":Landroid/util/DisplayMetrics;
    :cond_0
    goto :goto_1

    .line 152
    :catch_0
    move-exception v2

    .line 153
    .local v2, "e":Ljava/lang/Exception;
    invoke-virtual {v2}, Ljava/lang/Exception;->printStackTrace()V

    .line 155
    .end local v1    # "metricsField":Ljava/lang/reflect/Field;
    .end local v2    # "e":Ljava/lang/Exception;
    :goto_1
    goto :goto_0

    .line 156
    :cond_1
    return-void
.end method

.method private static applyOtherDisplayMetrics(Landroid/content/res/Resources;F)V
    .locals 7
    .param p0, "resources"    # Landroid/content/res/Resources;
    .param p1, "newXdpi"    # F

    .line 120
    sget-object v0, Lcom/blankj/utilcode/util/AdaptScreenUtils;->sMetricsFields:Ljava/util/List;

    if-nez v0, :cond_3

    .line 121
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    sput-object v0, Lcom/blankj/utilcode/util/AdaptScreenUtils;->sMetricsFields:Ljava/util/List;

    .line 122
    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v0

    .line 123
    .local v0, "resCls":Ljava/lang/Class;
    invoke-virtual {v0}, Ljava/lang/Class;->getDeclaredFields()[Ljava/lang/reflect/Field;

    move-result-object v1

    .line 124
    .local v1, "declaredFields":[Ljava/lang/reflect/Field;
    :goto_0
    if-eqz v1, :cond_2

    array-length v2, v1

    if-lez v2, :cond_2

    .line 125
    array-length v2, v1

    const/4 v3, 0x0

    :goto_1
    if-ge v3, v2, :cond_1

    aget-object v4, v1, v3

    .line 126
    .local v4, "field":Ljava/lang/reflect/Field;
    invoke-virtual {v4}, Ljava/lang/reflect/Field;->getType()Ljava/lang/Class;

    move-result-object v5

    const-class v6, Landroid/util/DisplayMetrics;

    invoke-virtual {v5, v6}, Ljava/lang/Class;->isAssignableFrom(Ljava/lang/Class;)Z

    move-result v5

    if-eqz v5, :cond_0

    .line 127
    const/4 v5, 0x1

    invoke-virtual {v4, v5}, Ljava/lang/reflect/Field;->setAccessible(Z)V

    .line 128
    invoke-static {p0, v4}, Lcom/blankj/utilcode/util/AdaptScreenUtils;->getMetricsFromField(Landroid/content/res/Resources;Ljava/lang/reflect/Field;)Landroid/util/DisplayMetrics;

    move-result-object v5

    .line 129
    .local v5, "tmpDm":Landroid/util/DisplayMetrics;
    if-eqz v5, :cond_0

    .line 130
    sget-object v6, Lcom/blankj/utilcode/util/AdaptScreenUtils;->sMetricsFields:Ljava/util/List;

    invoke-interface {v6, v4}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 131
    iput p1, v5, Landroid/util/DisplayMetrics;->xdpi:F

    .line 125
    .end local v4    # "field":Ljava/lang/reflect/Field;
    .end local v5    # "tmpDm":Landroid/util/DisplayMetrics;
    :cond_0
    add-int/lit8 v3, v3, 0x1

    goto :goto_1

    .line 135
    :cond_1
    invoke-virtual {v0}, Ljava/lang/Class;->getSuperclass()Ljava/lang/Class;

    move-result-object v0

    .line 136
    if-eqz v0, :cond_2

    .line 137
    invoke-virtual {v0}, Ljava/lang/Class;->getDeclaredFields()[Ljava/lang/reflect/Field;

    move-result-object v1

    goto :goto_0

    .line 142
    .end local v0    # "resCls":Ljava/lang/Class;
    .end local v1    # "declaredFields":[Ljava/lang/reflect/Field;
    :cond_2
    goto :goto_2

    .line 143
    :cond_3
    invoke-static {p0, p1}, Lcom/blankj/utilcode/util/AdaptScreenUtils;->applyMetricsFields(Landroid/content/res/Resources;F)V

    .line 145
    :goto_2
    return-void
.end method

.method public static closeAdapt(Landroid/content/res/Resources;)Landroid/content/res/Resources;
    .locals 2
    .param p0, "resources"    # Landroid/content/res/Resources;

    .line 73
    invoke-static {}, Landroid/content/res/Resources;->getSystem()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v0

    iget v0, v0, Landroid/util/DisplayMetrics;->density:F

    const/high16 v1, 0x42900000    # 72.0f

    mul-float/2addr v0, v1

    .line 74
    .local v0, "newXdpi":F
    invoke-static {p0, v0}, Lcom/blankj/utilcode/util/AdaptScreenUtils;->applyDisplayMetrics(Landroid/content/res/Resources;F)V

    .line 75
    return-object p0
.end method

.method private static getMetricsFromField(Landroid/content/res/Resources;Ljava/lang/reflect/Field;)Landroid/util/DisplayMetrics;
    .locals 2
    .param p0, "resources"    # Landroid/content/res/Resources;
    .param p1, "field"    # Ljava/lang/reflect/Field;

    .line 160
    :try_start_0
    invoke-virtual {p1, p0}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/util/DisplayMetrics;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    .line 161
    :catch_0
    move-exception v0

    .line 162
    .local v0, "ignore":Ljava/lang/Exception;
    const/4 v1, 0x0

    return-object v1
.end method

.method private static getNavBarHeight(Landroid/content/res/Resources;)I
    .locals 3
    .param p0, "resources"    # Landroid/content/res/Resources;

    .line 59
    const-string v0, "dimen"

    const-string v1, "android"

    const-string v2, "navigation_bar_height"

    invoke-virtual {p0, v2, v0, v1}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    .line 60
    .local v0, "resourceId":I
    if-eqz v0, :cond_0

    .line 61
    invoke-virtual {p0, v0}, Landroid/content/res/Resources;->getDimensionPixelSize(I)I

    move-result v1

    return v1

    .line 63
    :cond_0
    const/4 v1, 0x0

    return v1
.end method

.method static getPreLoadRunnable()Ljava/lang/Runnable;
    .locals 1

    .line 107
    new-instance v0, Lcom/blankj/utilcode/util/AdaptScreenUtils$1;

    invoke-direct {v0}, Lcom/blankj/utilcode/util/AdaptScreenUtils$1;-><init>()V

    return-object v0
.end method

.method private static preLoad()V
    .locals 2

    .line 116
    invoke-static {}, Landroid/content/res/Resources;->getSystem()Landroid/content/res/Resources;

    move-result-object v0

    invoke-static {}, Landroid/content/res/Resources;->getSystem()Landroid/content/res/Resources;

    move-result-object v1

    invoke-virtual {v1}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v1

    iget v1, v1, Landroid/util/DisplayMetrics;->xdpi:F

    invoke-static {v0, v1}, Lcom/blankj/utilcode/util/AdaptScreenUtils;->applyDisplayMetrics(Landroid/content/res/Resources;F)V

    .line 117
    return-void
.end method

.method public static pt2Px(F)I
    .locals 5
    .param p0, "ptValue"    # F

    .line 85
    invoke-static {}, Lcom/blankj/utilcode/util/Utils;->getApp()Landroid/app/Application;

    move-result-object v0

    invoke-virtual {v0}, Landroid/app/Application;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v0

    .line 86
    .local v0, "metrics":Landroid/util/DisplayMetrics;
    iget v1, v0, Landroid/util/DisplayMetrics;->xdpi:F

    mul-float/2addr v1, p0

    const/high16 v2, 0x42900000    # 72.0f

    div-float/2addr v1, v2

    float-to-double v1, v1

    const-wide/high16 v3, 0x3fe0000000000000L    # 0.5

    add-double/2addr v1, v3

    double-to-int v1, v1

    return v1
.end method

.method public static px2Pt(F)I
    .locals 5
    .param p0, "pxValue"    # F

    .line 96
    invoke-static {}, Lcom/blankj/utilcode/util/Utils;->getApp()Landroid/app/Application;

    move-result-object v0

    invoke-virtual {v0}, Landroid/app/Application;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v0

    .line 97
    .local v0, "metrics":Landroid/util/DisplayMetrics;
    const/high16 v1, 0x42900000    # 72.0f

    mul-float/2addr v1, p0

    iget v2, v0, Landroid/util/DisplayMetrics;->xdpi:F

    div-float/2addr v1, v2

    float-to-double v1, v1

    const-wide/high16 v3, 0x3fe0000000000000L    # 0.5

    add-double/2addr v1, v3

    double-to-int v1, v1

    return v1
.end method
