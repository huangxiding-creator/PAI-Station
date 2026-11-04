.class public Lcom/amazonaws/mobile/auth/core/signin/ui/buttons/SignInButton;
.super Landroid/widget/LinearLayout;
.source "SignInButton.java"


# static fields
.field private static final BORDER_COLOR:I = -0x1000000

.field private static final IMAGE_LEFT_MARGIN:I

.field private static final IMAGE_RIGHT_MARGIN:I

.field private static final MAX_TEXT_SIZE_PX:F

.field private static final MIN_TEXT_SIZE_SP:F = 8.0f

.field private static final TEXT_LEFT_MARGIN:I

.field private static final TEXT_RIGHT_MARGIN:I


# instance fields
.field private final attributes:Lcom/amazonaws/mobile/auth/core/signin/ui/buttons/SignInButtonAttributes;

.field protected bitmap:Landroid/graphics/Bitmap;

.field protected imageView:Landroid/widget/ImageView;

.field protected isSmallStyle:Z

.field protected textView:Landroid/widget/TextView;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .line 52
    const/16 v0, 0x8

    invoke-static {v0}, Lcom/amazonaws/mobile/auth/core/signin/ui/DisplayUtils;->dp(I)I

    move-result v1

    sput v1, Lcom/amazonaws/mobile/auth/core/signin/ui/buttons/SignInButton;->IMAGE_LEFT_MARGIN:I

    .line 55
    invoke-static {v0}, Lcom/amazonaws/mobile/auth/core/signin/ui/DisplayUtils;->dp(I)I

    move-result v1

    sput v1, Lcom/amazonaws/mobile/auth/core/signin/ui/buttons/SignInButton;->IMAGE_RIGHT_MARGIN:I

    .line 58
    const/4 v1, 0x2

    invoke-static {v1}, Lcom/amazonaws/mobile/auth/core/signin/ui/DisplayUtils;->dp(I)I

    move-result v1

    sput v1, Lcom/amazonaws/mobile/auth/core/signin/ui/buttons/SignInButton;->TEXT_LEFT_MARGIN:I

    .line 61
    invoke-static {v0}, Lcom/amazonaws/mobile/auth/core/signin/ui/DisplayUtils;->dp(I)I

    move-result v0

    sput v0, Lcom/amazonaws/mobile/auth/core/signin/ui/buttons/SignInButton;->TEXT_RIGHT_MARGIN:I

    .line 67
    const/16 v0, 0x32

    invoke-static {v0}, Lcom/amazonaws/mobile/auth/core/signin/ui/DisplayUtils;->dp(I)I

    move-result v0

    int-to-float v0, v0

    sput v0, Lcom/amazonaws/mobile/auth/core/signin/ui/buttons/SignInButton;->MAX_TEXT_SIZE_PX:F

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;ILcom/amazonaws/mobile/auth/core/signin/ui/buttons/SignInButtonAttributes;)V
    .locals 7
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "attrs"    # Landroid/util/AttributeSet;
    .param p3, "defStyleAttr"    # I
    .param p4, "buttonAttributes"    # Lcom/amazonaws/mobile/auth/core/signin/ui/buttons/SignInButtonAttributes;

    .line 89
    invoke-direct {p0, p1, p2, p3}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V

    .line 85
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/amazonaws/mobile/auth/core/signin/ui/buttons/SignInButton;->isSmallStyle:Z

    .line 90
    iput-object p4, p0, Lcom/amazonaws/mobile/auth/core/signin/ui/buttons/SignInButton;->attributes:Lcom/amazonaws/mobile/auth/core/signin/ui/buttons/SignInButtonAttributes;

    .line 91
    const/4 v1, 0x1

    invoke-virtual {p0, v1}, Lcom/amazonaws/mobile/auth/core/signin/ui/buttons/SignInButton;->setFocusable(Z)V

    .line 92
    invoke-virtual {p0, v1}, Lcom/amazonaws/mobile/auth/core/signin/ui/buttons/SignInButton;->setClickable(Z)V

    .line 93
    invoke-virtual {p0, v0}, Lcom/amazonaws/mobile/auth/core/signin/ui/buttons/SignInButton;->setOrientation(I)V

    .line 94
    const/16 v2, 0x10

    invoke-virtual {p0, v2}, Lcom/amazonaws/mobile/auth/core/signin/ui/buttons/SignInButton;->setGravity(I)V

    .line 95
    invoke-direct {p0}, Lcom/amazonaws/mobile/auth/core/signin/ui/buttons/SignInButton;->getBackgroundStatesDrawable()Landroid/graphics/drawable/Drawable;

    move-result-object v3

    invoke-virtual {p0, v3}, Lcom/amazonaws/mobile/auth/core/signin/ui/buttons/SignInButton;->setBackgroundDrawable(Landroid/graphics/drawable/Drawable;)V

    .line 97
    new-instance v3, Landroid/widget/ImageView;

    invoke-direct {v3, p1}, Landroid/widget/ImageView;-><init>(Landroid/content/Context;)V

    iput-object v3, p0, Lcom/amazonaws/mobile/auth/core/signin/ui/buttons/SignInButton;->imageView:Landroid/widget/ImageView;

    .line 98
    invoke-virtual {p0}, Lcom/amazonaws/mobile/auth/core/signin/ui/buttons/SignInButton;->getResources()Landroid/content/res/Resources;

    move-result-object v3

    iget-object v4, p0, Lcom/amazonaws/mobile/auth/core/signin/ui/buttons/SignInButton;->attributes:Lcom/amazonaws/mobile/auth/core/signin/ui/buttons/SignInButtonAttributes;

    invoke-virtual {v4}, Lcom/amazonaws/mobile/auth/core/signin/ui/buttons/SignInButtonAttributes;->getImageIconResourceId()I

    move-result v4

    invoke-static {v3, v4}, Landroid/graphics/BitmapFactory;->decodeResource(Landroid/content/res/Resources;I)Landroid/graphics/Bitmap;

    move-result-object v3

    iput-object v3, p0, Lcom/amazonaws/mobile/auth/core/signin/ui/buttons/SignInButton;->bitmap:Landroid/graphics/Bitmap;

    .line 99
    new-instance v3, Landroid/graphics/drawable/BitmapDrawable;

    invoke-virtual {p0}, Lcom/amazonaws/mobile/auth/core/signin/ui/buttons/SignInButton;->getResources()Landroid/content/res/Resources;

    move-result-object v4

    iget-object v5, p0, Lcom/amazonaws/mobile/auth/core/signin/ui/buttons/SignInButton;->bitmap:Landroid/graphics/Bitmap;

    invoke-direct {v3, v4, v5}, Landroid/graphics/drawable/BitmapDrawable;-><init>(Landroid/content/res/Resources;Landroid/graphics/Bitmap;)V

    .line 100
    .local v3, "bitmapDrawable":Landroid/graphics/drawable/BitmapDrawable;
    iget-object v4, p0, Lcom/amazonaws/mobile/auth/core/signin/ui/buttons/SignInButton;->imageView:Landroid/widget/ImageView;

    invoke-virtual {v4, v3}, Landroid/widget/ImageView;->setImageDrawable(Landroid/graphics/drawable/Drawable;)V

    .line 101
    iget-object v4, p0, Lcom/amazonaws/mobile/auth/core/signin/ui/buttons/SignInButton;->imageView:Landroid/widget/ImageView;

    sget-object v5, Landroid/widget/ImageView$ScaleType;->FIT_XY:Landroid/widget/ImageView$ScaleType;

    invoke-virtual {v4, v5}, Landroid/widget/ImageView;->setScaleType(Landroid/widget/ImageView$ScaleType;)V

    .line 102
    iget-object v4, p0, Lcom/amazonaws/mobile/auth/core/signin/ui/buttons/SignInButton;->imageView:Landroid/widget/ImageView;

    invoke-virtual {v4, v1}, Landroid/widget/ImageView;->setAdjustViewBounds(Z)V

    .line 104
    new-instance v4, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v5, -0x2

    invoke-direct {v4, v5, v5}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    .line 106
    .local v4, "imageLayoutParams":Landroid/widget/LinearLayout$LayoutParams;
    sget v5, Lcom/amazonaws/mobile/auth/core/signin/ui/buttons/SignInButton;->IMAGE_LEFT_MARGIN:I

    sget v6, Lcom/amazonaws/mobile/auth/core/signin/ui/buttons/SignInButton;->IMAGE_RIGHT_MARGIN:I

    invoke-virtual {v4, v5, v0, v6, v0}, Landroid/widget/LinearLayout$LayoutParams;->setMargins(IIII)V

    .line 108
    const/4 v5, 0x0

    iput v5, v4, Landroid/widget/LinearLayout$LayoutParams;->weight:F

    .line 109
    iget-object v5, p0, Lcom/amazonaws/mobile/auth/core/signin/ui/buttons/SignInButton;->imageView:Landroid/widget/ImageView;

    invoke-virtual {p0, v5, v4}, Lcom/amazonaws/mobile/auth/core/signin/ui/buttons/SignInButton;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 111
    new-instance v5, Landroid/widget/TextView;

    invoke-direct {v5, p1}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    iput-object v5, p0, Lcom/amazonaws/mobile/auth/core/signin/ui/buttons/SignInButton;->textView:Landroid/widget/TextView;

    .line 112
    iget-object v5, p0, Lcom/amazonaws/mobile/auth/core/signin/ui/buttons/SignInButton;->textView:Landroid/widget/TextView;

    iget-object v6, p0, Lcom/amazonaws/mobile/auth/core/signin/ui/buttons/SignInButton;->attributes:Lcom/amazonaws/mobile/auth/core/signin/ui/buttons/SignInButtonAttributes;

    invoke-virtual {v6}, Lcom/amazonaws/mobile/auth/core/signin/ui/buttons/SignInButtonAttributes;->getTextColor()I

    move-result v6

    invoke-virtual {v5, v6}, Landroid/widget/TextView;->setTextColor(I)V

    .line 113
    iget-object v5, p0, Lcom/amazonaws/mobile/auth/core/signin/ui/buttons/SignInButton;->textView:Landroid/widget/TextView;

    const/4 v6, 0x0

    invoke-virtual {v5, v6, v1}, Landroid/widget/TextView;->setTypeface(Landroid/graphics/Typeface;I)V

    .line 114
    iget-object v5, p0, Lcom/amazonaws/mobile/auth/core/signin/ui/buttons/SignInButton;->textView:Landroid/widget/TextView;

    invoke-virtual {v5, v1}, Landroid/widget/TextView;->setSingleLine(Z)V

    .line 115
    iget-object v5, p0, Lcom/amazonaws/mobile/auth/core/signin/ui/buttons/SignInButton;->textView:Landroid/widget/TextView;

    invoke-virtual {v5, v2}, Landroid/widget/TextView;->setGravity(I)V

    .line 117
    if-eqz p2, :cond_1

    .line 119
    sget-object v2, Lcom/amazonaws/mobile/auth/core/R$styleable;->SignInButton:[I

    invoke-virtual {p1, p2, v2}, Landroid/content/Context;->obtainStyledAttributes(Landroid/util/AttributeSet;[I)Landroid/content/res/TypedArray;

    move-result-object v2

    .line 120
    .local v2, "styledAttributes":Landroid/content/res/TypedArray;
    sget v5, Lcom/amazonaws/mobile/auth/core/R$styleable;->SignInButton_button_style:I

    invoke-virtual {v2, v5, v0}, Landroid/content/res/TypedArray;->getInt(II)I

    move-result v5

    if-lez v5, :cond_0

    .line 121
    iput-boolean v1, p0, Lcom/amazonaws/mobile/auth/core/signin/ui/buttons/SignInButton;->isSmallStyle:Z

    .line 123
    :cond_0
    sget v1, Lcom/amazonaws/mobile/auth/core/R$styleable;->SignInButton_text:I

    invoke-virtual {v2, v1}, Landroid/content/res/TypedArray;->getString(I)Ljava/lang/String;

    move-result-object v1

    .line 124
    .local v1, "buttonText":Ljava/lang/String;
    invoke-virtual {v2}, Landroid/content/res/TypedArray;->recycle()V

    .line 125
    .end local v2    # "styledAttributes":Landroid/content/res/TypedArray;
    goto :goto_0

    .line 126
    .end local v1    # "buttonText":Ljava/lang/String;
    :cond_1
    const/4 v1, 0x0

    .line 129
    .restart local v1    # "buttonText":Ljava/lang/String;
    :goto_0
    if-eqz v1, :cond_2

    .line 130
    iget-object v2, p0, Lcom/amazonaws/mobile/auth/core/signin/ui/buttons/SignInButton;->textView:Landroid/widget/TextView;

    invoke-virtual {v2, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    goto :goto_1

    .line 132
    :cond_2
    iget-object v2, p0, Lcom/amazonaws/mobile/auth/core/signin/ui/buttons/SignInButton;->textView:Landroid/widget/TextView;

    iget-object v5, p0, Lcom/amazonaws/mobile/auth/core/signin/ui/buttons/SignInButton;->attributes:Lcom/amazonaws/mobile/auth/core/signin/ui/buttons/SignInButtonAttributes;

    invoke-virtual {v5}, Lcom/amazonaws/mobile/auth/core/signin/ui/buttons/SignInButtonAttributes;->getDefaultTextResourceId()I

    move-result v5

    invoke-virtual {v2, v5}, Landroid/widget/TextView;->setText(I)V

    .line 135
    :goto_1
    new-instance v2, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v5, -0x1

    invoke-direct {v2, v5, v5}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    .line 137
    .local v2, "textViewLayoutParams":Landroid/widget/LinearLayout$LayoutParams;
    sget v5, Lcom/amazonaws/mobile/auth/core/signin/ui/buttons/SignInButton;->TEXT_LEFT_MARGIN:I

    invoke-static {v5}, Lcom/amazonaws/mobile/auth/core/signin/ui/DisplayUtils;->dp(I)I

    move-result v5

    sget v6, Lcom/amazonaws/mobile/auth/core/signin/ui/buttons/SignInButton;->TEXT_RIGHT_MARGIN:I

    invoke-static {v6}, Lcom/amazonaws/mobile/auth/core/signin/ui/DisplayUtils;->dp(I)I

    move-result v6

    invoke-virtual {v2, v5, v0, v6, v0}, Landroid/widget/LinearLayout$LayoutParams;->setMargins(IIII)V

    .line 140
    const/high16 v0, 0x3f800000    # 1.0f

    iput v0, v2, Landroid/widget/LinearLayout$LayoutParams;->weight:F

    .line 141
    iget-object v0, p0, Lcom/amazonaws/mobile/auth/core/signin/ui/buttons/SignInButton;->textView:Landroid/widget/TextView;

    invoke-virtual {p0, v0, v2}, Lcom/amazonaws/mobile/auth/core/signin/ui/buttons/SignInButton;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 143
    invoke-direct {p0}, Lcom/amazonaws/mobile/auth/core/signin/ui/buttons/SignInButton;->updateStyle()V

    .line 144
    invoke-virtual {p0}, Lcom/amazonaws/mobile/auth/core/signin/ui/buttons/SignInButton;->invalidate()V

    .line 145
    return-void
.end method

.method private doesTextViewFit(FLandroid/graphics/RectF;)Z
    .locals 7
    .param p1, "suggestedSize"    # F
    .param p2, "availableRect"    # Landroid/graphics/RectF;

    .line 252
    new-instance v0, Landroid/text/TextPaint;

    iget-object v1, p0, Lcom/amazonaws/mobile/auth/core/signin/ui/buttons/SignInButton;->textView:Landroid/widget/TextView;

    invoke-virtual {v1}, Landroid/widget/TextView;->getPaint()Landroid/text/TextPaint;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/text/TextPaint;-><init>(Landroid/graphics/Paint;)V

    .line 253
    .local v0, "textPaint":Landroid/text/TextPaint;
    invoke-virtual {v0, p1}, Landroid/text/TextPaint;->setTextSize(F)V

    .line 254
    iget-object v1, p0, Lcom/amazonaws/mobile/auth/core/signin/ui/buttons/SignInButton;->textView:Landroid/widget/TextView;

    invoke-virtual {v1}, Landroid/widget/TextView;->getTransformationMethod()Landroid/text/method/TransformationMethod;

    move-result-object v1

    .line 255
    .local v1, "transformMethod":Landroid/text/method/TransformationMethod;
    iget-object v2, p0, Lcom/amazonaws/mobile/auth/core/signin/ui/buttons/SignInButton;->textView:Landroid/widget/TextView;

    if-nez v1, :cond_0

    invoke-virtual {v2}, Landroid/widget/TextView;->getText()Ljava/lang/CharSequence;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v2

    goto :goto_0

    .line 256
    :cond_0
    invoke-virtual {v2}, Landroid/widget/TextView;->getText()Ljava/lang/CharSequence;

    move-result-object v2

    iget-object v3, p0, Lcom/amazonaws/mobile/auth/core/signin/ui/buttons/SignInButton;->textView:Landroid/widget/TextView;

    invoke-interface {v1, v2, v3}, Landroid/text/method/TransformationMethod;->getTransformation(Ljava/lang/CharSequence;Landroid/view/View;)Ljava/lang/CharSequence;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v2

    :goto_0
    nop

    .line 258
    .local v2, "text":Ljava/lang/String;
    new-instance v3, Landroid/graphics/RectF;

    invoke-virtual {v0, v2}, Landroid/text/TextPaint;->measureText(Ljava/lang/String;)F

    move-result v4

    invoke-virtual {v0}, Landroid/text/TextPaint;->getFontSpacing()F

    move-result v5

    const/4 v6, 0x0

    invoke-direct {v3, v6, v6, v4, v5}, Landroid/graphics/RectF;-><init>(FFFF)V

    .line 261
    .local v3, "textRect":Landroid/graphics/RectF;
    invoke-virtual {p2, v3}, Landroid/graphics/RectF;->contains(Landroid/graphics/RectF;)Z

    move-result v4

    return v4
.end method

.method private findBestSize(FFLandroid/graphics/RectF;)F
    .locals 6
    .param p1, "start"    # F
    .param p2, "end"    # F
    .param p3, "availableSpace"    # Landroid/graphics/RectF;

    .line 265
    move v0, p1

    .line 266
    .local v0, "low":F
    move v1, p2

    .line 268
    .local v1, "high":F
    move v2, v0

    .line 270
    .local v2, "bestFit":F
    :goto_0
    cmpg-float v3, v0, v1

    if-gtz v3, :cond_1

    .line 271
    add-float v3, v0, v1

    const/high16 v4, 0x40000000    # 2.0f

    div-float/2addr v3, v4

    .line 272
    .local v3, "midpoint":F
    invoke-direct {p0, v3, p3}, Lcom/amazonaws/mobile/auth/core/signin/ui/buttons/SignInButton;->doesTextViewFit(FLandroid/graphics/RectF;)Z

    move-result v4

    const/high16 v5, 0x3f000000    # 0.5f

    if-eqz v4, :cond_0

    .line 273
    move v2, v3

    .line 274
    add-float v0, v3, v5

    goto :goto_0

    .line 276
    :cond_0
    sub-float v1, v3, v5

    goto :goto_0

    .line 279
    .end local v3    # "midpoint":F
    :cond_1
    return v2
.end method

.method private getBackgroundStatesDrawable()Landroid/graphics/drawable/Drawable;
    .locals 3

    .line 192
    new-instance v0, Landroid/graphics/drawable/StateListDrawable;

    invoke-direct {v0}, Landroid/graphics/drawable/StateListDrawable;-><init>()V

    .line 193
    .local v0, "states":Landroid/graphics/drawable/StateListDrawable;
    const v1, 0x10100a7

    filled-new-array {v1}, [I

    move-result-object v1

    iget-object v2, p0, Lcom/amazonaws/mobile/auth/core/signin/ui/buttons/SignInButton;->attributes:Lcom/amazonaws/mobile/auth/core/signin/ui/buttons/SignInButtonAttributes;

    .line 194
    invoke-virtual {v2}, Lcom/amazonaws/mobile/auth/core/signin/ui/buttons/SignInButtonAttributes;->getBackgroundColorPressed()I

    move-result v2

    invoke-direct {p0, v2}, Lcom/amazonaws/mobile/auth/core/signin/ui/buttons/SignInButton;->getButtonBackground(I)Landroid/graphics/drawable/Drawable;

    move-result-object v2

    .line 193
    invoke-virtual {v0, v1, v2}, Landroid/graphics/drawable/StateListDrawable;->addState([ILandroid/graphics/drawable/Drawable;)V

    .line 195
    const/4 v1, 0x0

    new-array v1, v1, [I

    iget-object v2, p0, Lcom/amazonaws/mobile/auth/core/signin/ui/buttons/SignInButton;->attributes:Lcom/amazonaws/mobile/auth/core/signin/ui/buttons/SignInButtonAttributes;

    .line 196
    invoke-virtual {v2}, Lcom/amazonaws/mobile/auth/core/signin/ui/buttons/SignInButtonAttributes;->getBackgroundColor()I

    move-result v2

    invoke-direct {p0, v2}, Lcom/amazonaws/mobile/auth/core/signin/ui/buttons/SignInButton;->getButtonBackground(I)Landroid/graphics/drawable/Drawable;

    move-result-object v2

    .line 195
    invoke-virtual {v0, v1, v2}, Landroid/graphics/drawable/StateListDrawable;->addState([ILandroid/graphics/drawable/Drawable;)V

    .line 197
    return-object v0
.end method

.method private getButtonBackground(I)Landroid/graphics/drawable/Drawable;
    .locals 13
    .param p1, "buttonFaceColor"    # I

    .line 153
    iget-object v0, p0, Lcom/amazonaws/mobile/auth/core/signin/ui/buttons/SignInButton;->attributes:Lcom/amazonaws/mobile/auth/core/signin/ui/buttons/SignInButtonAttributes;

    invoke-virtual {v0}, Lcom/amazonaws/mobile/auth/core/signin/ui/buttons/SignInButtonAttributes;->getCornerRadius()I

    move-result v0

    .line 155
    .local v0, "cornerRadius":I
    nop

    .line 156
    invoke-static {v0, p1}, Lcom/amazonaws/mobile/auth/core/signin/ui/DisplayUtils;->getRoundedRectangleBackground(II)Landroid/graphics/drawable/ShapeDrawable;

    move-result-object v1

    .line 159
    .local v1, "insetBackgroundDrawable":Landroid/graphics/drawable/ShapeDrawable;
    new-instance v2, Landroid/graphics/drawable/GradientDrawable;

    sget-object v3, Landroid/graphics/drawable/GradientDrawable$Orientation;->LEFT_RIGHT:Landroid/graphics/drawable/GradientDrawable$Orientation;

    iget-object v4, p0, Lcom/amazonaws/mobile/auth/core/signin/ui/buttons/SignInButton;->attributes:Lcom/amazonaws/mobile/auth/core/signin/ui/buttons/SignInButtonAttributes;

    .line 161
    invoke-virtual {v4}, Lcom/amazonaws/mobile/auth/core/signin/ui/buttons/SignInButtonAttributes;->getTopShadowColor()I

    move-result v4

    iget-object v5, p0, Lcom/amazonaws/mobile/auth/core/signin/ui/buttons/SignInButton;->attributes:Lcom/amazonaws/mobile/auth/core/signin/ui/buttons/SignInButtonAttributes;

    invoke-virtual {v5}, Lcom/amazonaws/mobile/auth/core/signin/ui/buttons/SignInButtonAttributes;->getTopShadowColor()I

    move-result v5

    filled-new-array {v4, v5}, [I

    move-result-object v4

    invoke-direct {v2, v3, v4}, Landroid/graphics/drawable/GradientDrawable;-><init>(Landroid/graphics/drawable/GradientDrawable$Orientation;[I)V

    .line 162
    .local v2, "outerShadowTopDrawable":Landroid/graphics/drawable/GradientDrawable;
    invoke-static {v0}, Lcom/amazonaws/mobile/auth/core/signin/ui/DisplayUtils;->dp(I)I

    move-result v3

    int-to-float v3, v3

    invoke-virtual {v2, v3}, Landroid/graphics/drawable/GradientDrawable;->setCornerRadius(F)V

    .line 165
    new-instance v3, Landroid/graphics/drawable/GradientDrawable;

    sget-object v4, Landroid/graphics/drawable/GradientDrawable$Orientation;->LEFT_RIGHT:Landroid/graphics/drawable/GradientDrawable$Orientation;

    iget-object v5, p0, Lcom/amazonaws/mobile/auth/core/signin/ui/buttons/SignInButton;->attributes:Lcom/amazonaws/mobile/auth/core/signin/ui/buttons/SignInButtonAttributes;

    .line 167
    invoke-virtual {v5}, Lcom/amazonaws/mobile/auth/core/signin/ui/buttons/SignInButtonAttributes;->getBottomShadowColor()I

    move-result v5

    iget-object v6, p0, Lcom/amazonaws/mobile/auth/core/signin/ui/buttons/SignInButton;->attributes:Lcom/amazonaws/mobile/auth/core/signin/ui/buttons/SignInButtonAttributes;

    invoke-virtual {v6}, Lcom/amazonaws/mobile/auth/core/signin/ui/buttons/SignInButtonAttributes;->getBottomShadowColor()I

    move-result v6

    filled-new-array {v5, v6}, [I

    move-result-object v5

    invoke-direct {v3, v4, v5}, Landroid/graphics/drawable/GradientDrawable;-><init>(Landroid/graphics/drawable/GradientDrawable$Orientation;[I)V

    .line 168
    .local v3, "outerShadowBottomDrawable":Landroid/graphics/drawable/GradientDrawable;
    invoke-static {v0}, Lcom/amazonaws/mobile/auth/core/signin/ui/DisplayUtils;->dp(I)I

    move-result v4

    int-to-float v4, v4

    invoke-virtual {v3, v4}, Landroid/graphics/drawable/GradientDrawable;->setCornerRadius(F)V

    .line 170
    new-instance v4, Landroid/graphics/drawable/LayerDrawable;

    const/4 v5, 0x3

    new-array v5, v5, [Landroid/graphics/drawable/Drawable;

    const/4 v6, 0x0

    aput-object v2, v5, v6

    const/4 v6, 0x1

    aput-object v3, v5, v6

    const/4 v6, 0x2

    aput-object v1, v5, v6

    invoke-direct {v4, v5}, Landroid/graphics/drawable/LayerDrawable;-><init>([Landroid/graphics/drawable/Drawable;)V

    .line 176
    .local v4, "layerDrawable":Landroid/graphics/drawable/LayerDrawable;
    const/4 v11, 0x0

    const/4 v12, 0x0

    const/4 v8, 0x0

    const/4 v9, 0x0

    const/4 v10, 0x0

    move-object v7, v4

    invoke-virtual/range {v7 .. v12}, Landroid/graphics/drawable/LayerDrawable;->setLayerInset(IIIII)V

    .line 179
    iget-object v5, p0, Lcom/amazonaws/mobile/auth/core/signin/ui/buttons/SignInButton;->attributes:Lcom/amazonaws/mobile/auth/core/signin/ui/buttons/SignInButtonAttributes;

    invoke-virtual {v5}, Lcom/amazonaws/mobile/auth/core/signin/ui/buttons/SignInButtonAttributes;->getTopShadowThickness()I

    move-result v9

    iget-object v5, p0, Lcom/amazonaws/mobile/auth/core/signin/ui/buttons/SignInButton;->attributes:Lcom/amazonaws/mobile/auth/core/signin/ui/buttons/SignInButtonAttributes;

    invoke-virtual {v5}, Lcom/amazonaws/mobile/auth/core/signin/ui/buttons/SignInButtonAttributes;->getTopShadowThickness()I

    move-result v10

    const/4 v8, 0x1

    invoke-virtual/range {v7 .. v12}, Landroid/graphics/drawable/LayerDrawable;->setLayerInset(IIIII)V

    .line 182
    iget-object v5, p0, Lcom/amazonaws/mobile/auth/core/signin/ui/buttons/SignInButton;->attributes:Lcom/amazonaws/mobile/auth/core/signin/ui/buttons/SignInButtonAttributes;

    invoke-virtual {v5}, Lcom/amazonaws/mobile/auth/core/signin/ui/buttons/SignInButtonAttributes;->getTopShadowThickness()I

    move-result v9

    iget-object v5, p0, Lcom/amazonaws/mobile/auth/core/signin/ui/buttons/SignInButton;->attributes:Lcom/amazonaws/mobile/auth/core/signin/ui/buttons/SignInButtonAttributes;

    invoke-virtual {v5}, Lcom/amazonaws/mobile/auth/core/signin/ui/buttons/SignInButtonAttributes;->getTopShadowThickness()I

    move-result v10

    iget-object v5, p0, Lcom/amazonaws/mobile/auth/core/signin/ui/buttons/SignInButton;->attributes:Lcom/amazonaws/mobile/auth/core/signin/ui/buttons/SignInButtonAttributes;

    .line 183
    invoke-virtual {v5}, Lcom/amazonaws/mobile/auth/core/signin/ui/buttons/SignInButtonAttributes;->getBottomShadowThickness()I

    move-result v11

    iget-object v5, p0, Lcom/amazonaws/mobile/auth/core/signin/ui/buttons/SignInButton;->attributes:Lcom/amazonaws/mobile/auth/core/signin/ui/buttons/SignInButtonAttributes;

    invoke-virtual {v5}, Lcom/amazonaws/mobile/auth/core/signin/ui/buttons/SignInButtonAttributes;->getBottomShadowThickness()I

    move-result v12

    .line 182
    const/4 v8, 0x2

    invoke-virtual/range {v7 .. v12}, Landroid/graphics/drawable/LayerDrawable;->setLayerInset(IIIII)V

    .line 185
    return-object v4
.end method

.method private resizeButtonText()V
    .locals 5

    .line 286
    invoke-virtual {p0}, Lcom/amazonaws/mobile/auth/core/signin/ui/buttons/SignInButton;->getMeasuredWidth()I

    move-result v0

    if-eqz v0, :cond_1

    iget-boolean v0, p0, Lcom/amazonaws/mobile/auth/core/signin/ui/buttons/SignInButton;->isSmallStyle:Z

    if-eqz v0, :cond_0

    goto :goto_0

    .line 290
    :cond_0
    nop

    .line 291
    invoke-virtual {p0}, Lcom/amazonaws/mobile/auth/core/signin/ui/buttons/SignInButton;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v0

    .line 290
    const/4 v1, 0x2

    const/high16 v2, 0x41000000    # 8.0f

    invoke-static {v1, v2, v0}, Landroid/util/TypedValue;->applyDimension(IFLandroid/util/DisplayMetrics;)F

    move-result v0

    .line 292
    .local v0, "minTextSize":F
    new-instance v1, Landroid/graphics/RectF;

    invoke-direct {v1}, Landroid/graphics/RectF;-><init>()V

    .line 293
    .local v1, "availableSpaceRect":Landroid/graphics/RectF;
    iget-object v2, p0, Lcom/amazonaws/mobile/auth/core/signin/ui/buttons/SignInButton;->textView:Landroid/widget/TextView;

    invoke-virtual {v2}, Landroid/widget/TextView;->getMeasuredWidth()I

    move-result v2

    iget-object v3, p0, Lcom/amazonaws/mobile/auth/core/signin/ui/buttons/SignInButton;->textView:Landroid/widget/TextView;

    invoke-virtual {v3}, Landroid/widget/TextView;->getCompoundPaddingLeft()I

    move-result v3

    sub-int/2addr v2, v3

    iget-object v3, p0, Lcom/amazonaws/mobile/auth/core/signin/ui/buttons/SignInButton;->textView:Landroid/widget/TextView;

    .line 294
    invoke-virtual {v3}, Landroid/widget/TextView;->getCompoundPaddingRight()I

    move-result v3

    sub-int/2addr v2, v3

    int-to-float v2, v2

    iput v2, v1, Landroid/graphics/RectF;->right:F

    .line 295
    iget-object v2, p0, Lcom/amazonaws/mobile/auth/core/signin/ui/buttons/SignInButton;->textView:Landroid/widget/TextView;

    invoke-virtual {v2}, Landroid/widget/TextView;->getMeasuredHeight()I

    move-result v2

    iget-object v3, p0, Lcom/amazonaws/mobile/auth/core/signin/ui/buttons/SignInButton;->textView:Landroid/widget/TextView;

    invoke-virtual {v3}, Landroid/widget/TextView;->getCompoundPaddingBottom()I

    move-result v3

    sub-int/2addr v2, v3

    iget-object v3, p0, Lcom/amazonaws/mobile/auth/core/signin/ui/buttons/SignInButton;->textView:Landroid/widget/TextView;

    .line 296
    invoke-virtual {v3}, Landroid/widget/TextView;->getCompoundPaddingTop()I

    move-result v3

    sub-int/2addr v2, v3

    int-to-float v2, v2

    iput v2, v1, Landroid/graphics/RectF;->bottom:F

    .line 298
    iget-object v2, p0, Lcom/amazonaws/mobile/auth/core/signin/ui/buttons/SignInButton;->textView:Landroid/widget/TextView;

    sget v3, Lcom/amazonaws/mobile/auth/core/signin/ui/buttons/SignInButton;->MAX_TEXT_SIZE_PX:F

    .line 299
    invoke-direct {p0, v0, v3, v1}, Lcom/amazonaws/mobile/auth/core/signin/ui/buttons/SignInButton;->findBestSize(FFLandroid/graphics/RectF;)F

    move-result v3

    .line 298
    const/4 v4, 0x0

    invoke-virtual {v2, v4, v3}, Landroid/widget/TextView;->setTextSize(IF)V

    .line 300
    return-void

    .line 287
    .end local v0    # "minTextSize":F
    .end local v1    # "availableSpaceRect":Landroid/graphics/RectF;
    :cond_1
    :goto_0
    return-void
.end method

.method private updateStyle()V
    .locals 2

    .line 201
    iget-boolean v0, p0, Lcom/amazonaws/mobile/auth/core/signin/ui/buttons/SignInButton;->isSmallStyle:Z

    if-eqz v0, :cond_0

    .line 202
    iget-object v0, p0, Lcom/amazonaws/mobile/auth/core/signin/ui/buttons/SignInButton;->textView:Landroid/widget/TextView;

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setVisibility(I)V

    .line 203
    const/16 v0, 0x11

    invoke-virtual {p0, v0}, Lcom/amazonaws/mobile/auth/core/signin/ui/buttons/SignInButton;->setGravity(I)V

    goto :goto_0

    .line 205
    :cond_0
    iget-object v0, p0, Lcom/amazonaws/mobile/auth/core/signin/ui/buttons/SignInButton;->textView:Landroid/widget/TextView;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setVisibility(I)V

    .line 206
    const/16 v0, 0x10

    invoke-virtual {p0, v0}, Lcom/amazonaws/mobile/auth/core/signin/ui/buttons/SignInButton;->setGravity(I)V

    .line 208
    :goto_0
    return-void
.end method


# virtual methods
.method protected onMeasure(II)V
    .locals 5
    .param p1, "widthMeasureSpec"    # I
    .param p2, "heightMeasureSpec"    # I

    .line 239
    invoke-super {p0, p1, p2}, Landroid/widget/LinearLayout;->onMeasure(II)V

    .line 240
    iget-object v0, p0, Lcom/amazonaws/mobile/auth/core/signin/ui/buttons/SignInButton;->imageView:Landroid/widget/ImageView;

    invoke-virtual {v0}, Landroid/widget/ImageView;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v0

    .line 241
    .local v0, "layoutParams":Landroid/view/ViewGroup$LayoutParams;
    invoke-virtual {p0}, Lcom/amazonaws/mobile/auth/core/signin/ui/buttons/SignInButton;->getMeasuredHeight()I

    move-result v1

    int-to-double v1, v1

    const-wide v3, 0x3fe70a3d70a3d70aL    # 0.72

    mul-double/2addr v1, v3

    double-to-int v1, v1

    .line 242
    .local v1, "sideSize":I
    iget-object v2, p0, Lcom/amazonaws/mobile/auth/core/signin/ui/buttons/SignInButton;->bitmap:Landroid/graphics/Bitmap;

    invoke-virtual {v2}, Landroid/graphics/Bitmap;->getHeight()I

    move-result v2

    if-le v1, v2, :cond_0

    .line 243
    iget-object v2, p0, Lcom/amazonaws/mobile/auth/core/signin/ui/buttons/SignInButton;->bitmap:Landroid/graphics/Bitmap;

    invoke-virtual {v2}, Landroid/graphics/Bitmap;->getHeight()I

    move-result v1

    .line 247
    :cond_0
    iput v1, v0, Landroid/view/ViewGroup$LayoutParams;->height:I

    .line 248
    iput v1, v0, Landroid/view/ViewGroup$LayoutParams;->width:I

    .line 249
    return-void
.end method

.method protected onSizeChanged(IIII)V
    .locals 0
    .param p1, "width"    # I
    .param p2, "height"    # I
    .param p3, "oldwidth"    # I
    .param p4, "oldheight"    # I

    .line 304
    invoke-super {p0, p1, p2, p3, p4}, Landroid/widget/LinearLayout;->onSizeChanged(IIII)V

    .line 305
    if-ne p1, p3, :cond_0

    if-eq p2, p4, :cond_1

    .line 306
    :cond_0
    invoke-direct {p0}, Lcom/amazonaws/mobile/auth/core/signin/ui/buttons/SignInButton;->resizeButtonText()V

    .line 307
    :cond_1
    return-void
.end method

.method public setButtonText(I)V
    .locals 1
    .param p1, "resId"    # I

    .line 233
    iget-object v0, p0, Lcom/amazonaws/mobile/auth/core/signin/ui/buttons/SignInButton;->textView:Landroid/widget/TextView;

    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setText(I)V

    .line 234
    invoke-direct {p0}, Lcom/amazonaws/mobile/auth/core/signin/ui/buttons/SignInButton;->resizeButtonText()V

    .line 235
    return-void
.end method

.method public setButtonText(Ljava/lang/String;)V
    .locals 1
    .param p1, "text"    # Ljava/lang/String;

    .line 224
    iget-object v0, p0, Lcom/amazonaws/mobile/auth/core/signin/ui/buttons/SignInButton;->textView:Landroid/widget/TextView;

    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 225
    invoke-direct {p0}, Lcom/amazonaws/mobile/auth/core/signin/ui/buttons/SignInButton;->resizeButtonText()V

    .line 226
    return-void
.end method

.method public setSmallStyle(Z)V
    .locals 0
    .param p1, "shouldSetStyleSmall"    # Z

    .line 215
    iput-boolean p1, p0, Lcom/amazonaws/mobile/auth/core/signin/ui/buttons/SignInButton;->isSmallStyle:Z

    .line 216
    invoke-direct {p0}, Lcom/amazonaws/mobile/auth/core/signin/ui/buttons/SignInButton;->updateStyle()V

    .line 217
    return-void
.end method
