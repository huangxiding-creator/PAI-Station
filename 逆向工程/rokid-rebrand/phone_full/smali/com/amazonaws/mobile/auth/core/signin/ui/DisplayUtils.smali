.class public Lcom/amazonaws/mobile/auth/core/signin/ui/DisplayUtils;
.super Ljava/lang/Object;
.source "DisplayUtils.java"


# static fields
.field private static dpMultiplier:I

.field private static final metrics:Landroid/util/DisplayMetrics;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 30
    invoke-static {}, Landroid/content/res/Resources;->getSystem()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v0

    sput-object v0, Lcom/amazonaws/mobile/auth/core/signin/ui/DisplayUtils;->metrics:Landroid/util/DisplayMetrics;

    .line 31
    sget-object v0, Lcom/amazonaws/mobile/auth/core/signin/ui/DisplayUtils;->metrics:Landroid/util/DisplayMetrics;

    iget v0, v0, Landroid/util/DisplayMetrics;->densityDpi:I

    div-int/lit16 v0, v0, 0xa0

    sput v0, Lcom/amazonaws/mobile/auth/core/signin/ui/DisplayUtils;->dpMultiplier:I

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .line 29
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static dp(I)I
    .locals 1
    .param p0, "dp"    # I

    .line 38
    sget v0, Lcom/amazonaws/mobile/auth/core/signin/ui/DisplayUtils;->dpMultiplier:I

    mul-int/2addr v0, p0

    return v0
.end method

.method public static getRoundedRectangleBackground(II)Landroid/graphics/drawable/ShapeDrawable;
    .locals 2
    .param p0, "cornerRadius"    # I
    .param p1, "backgroundColor"    # I

    .line 58
    new-instance v0, Landroid/graphics/drawable/ShapeDrawable;

    .line 59
    invoke-static {p0}, Lcom/amazonaws/mobile/auth/core/signin/ui/DisplayUtils;->getRoundedRectangleShape(I)Landroid/graphics/drawable/shapes/Shape;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/graphics/drawable/ShapeDrawable;-><init>(Landroid/graphics/drawable/shapes/Shape;)V

    .line 60
    .local v0, "drawable":Landroid/graphics/drawable/ShapeDrawable;
    invoke-virtual {v0}, Landroid/graphics/drawable/ShapeDrawable;->getPaint()Landroid/graphics/Paint;

    move-result-object v1

    invoke-virtual {v1, p1}, Landroid/graphics/Paint;->setColor(I)V

    .line 61
    return-object v0
.end method

.method public static getRoundedRectangleShape(I)Landroid/graphics/drawable/shapes/Shape;
    .locals 11
    .param p0, "cornerRadius"    # I

    .line 50
    new-instance v0, Landroid/graphics/drawable/shapes/RoundRectShape;

    int-to-float v1, p0

    int-to-float v2, p0

    int-to-float v3, p0

    int-to-float v4, p0

    int-to-float v5, p0

    int-to-float v6, p0

    int-to-float v7, p0

    int-to-float v8, p0

    const/16 v9, 0x8

    new-array v9, v9, [F

    const/4 v10, 0x0

    aput v1, v9, v10

    const/4 v1, 0x1

    aput v2, v9, v1

    const/4 v1, 0x2

    aput v3, v9, v1

    const/4 v1, 0x3

    aput v4, v9, v1

    const/4 v1, 0x4

    aput v5, v9, v1

    const/4 v1, 0x5

    aput v6, v9, v1

    const/4 v1, 0x6

    aput v7, v9, v1

    const/4 v1, 0x7

    aput v8, v9, v1

    const/4 v1, 0x0

    invoke-direct {v0, v9, v1, v1}, Landroid/graphics/drawable/shapes/RoundRectShape;-><init>([FLandroid/graphics/RectF;[F)V

    return-object v0
.end method
