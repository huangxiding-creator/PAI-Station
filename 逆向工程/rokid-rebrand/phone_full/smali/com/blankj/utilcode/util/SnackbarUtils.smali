.class public final Lcom/blankj/utilcode/util/SnackbarUtils;
.super Ljava/lang/Object;
.source "SnackbarUtils.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/blankj/utilcode/util/SnackbarUtils$Duration;
    }
.end annotation


# static fields
.field private static final COLOR_DEFAULT:I = -0x1000001

.field private static final COLOR_ERROR:I = -0x10000

.field private static final COLOR_MESSAGE:I = -0x1

.field private static final COLOR_SUCCESS:I = -0xd44a00

.field private static final COLOR_WARNING:I = -0x3f00

.field public static final LENGTH_INDEFINITE:I = -0x2

.field public static final LENGTH_LONG:I = 0x0

.field public static final LENGTH_SHORT:I = -0x1

.field private static sWeakSnackbar:Ljava/lang/ref/WeakReference;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/lang/ref/WeakReference<",
            "Lcom/google/android/material/snackbar/Snackbar;",
            ">;"
        }
    .end annotation
.end field


# instance fields
.field private actionListener:Landroid/view/View$OnClickListener;

.field private actionText:Ljava/lang/CharSequence;

.field private actionTextColor:I

.field private bgColor:I

.field private bgResource:I

.field private bottomMargin:I

.field private duration:I

.field private message:Ljava/lang/CharSequence;

.field private messageColor:I

.field private view:Landroid/view/View;


# direct methods
.method private constructor <init>(Landroid/view/View;)V
    .locals 0
    .param p1, "parent"    # Landroid/view/View;

    .line 65
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 66
    invoke-direct {p0}, Lcom/blankj/utilcode/util/SnackbarUtils;->setDefault()V

    .line 67
    iput-object p1, p0, Lcom/blankj/utilcode/util/SnackbarUtils;->view:Landroid/view/View;

    .line 68
    return-void
.end method

.method public static addView(ILandroid/view/ViewGroup$LayoutParams;)V
    .locals 4
    .param p0, "layoutId"    # I
    .param p1, "params"    # Landroid/view/ViewGroup$LayoutParams;

    .line 347
    invoke-static {}, Lcom/blankj/utilcode/util/SnackbarUtils;->getView()Landroid/view/View;

    move-result-object v0

    .line 348
    .local v0, "view":Landroid/view/View;
    if-eqz v0, :cond_0

    .line 349
    const/4 v1, 0x0

    invoke-virtual {v0, v1, v1, v1, v1}, Landroid/view/View;->setPadding(IIII)V

    .line 350
    move-object v1, v0

    check-cast v1, Lcom/google/android/material/snackbar/Snackbar$SnackbarLayout;

    .line 351
    .local v1, "layout":Lcom/google/android/material/snackbar/Snackbar$SnackbarLayout;
    invoke-virtual {v0}, Landroid/view/View;->getContext()Landroid/content/Context;

    move-result-object v2

    invoke-static {v2}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object v2

    const/4 v3, 0x0

    invoke-virtual {v2, p0, v3}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v2

    .line 352
    .local v2, "child":Landroid/view/View;
    const/4 v3, -0x1

    invoke-virtual {v1, v2, v3, p1}, Lcom/google/android/material/snackbar/Snackbar$SnackbarLayout;->addView(Landroid/view/View;ILandroid/view/ViewGroup$LayoutParams;)V

    .line 354
    .end local v1    # "layout":Lcom/google/android/material/snackbar/Snackbar$SnackbarLayout;
    .end local v2    # "child":Landroid/view/View;
    :cond_0
    return-void
.end method

.method public static addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V
    .locals 2
    .param p0, "child"    # Landroid/view/View;
    .param p1, "params"    # Landroid/view/ViewGroup$LayoutParams;

    .line 365
    invoke-static {}, Lcom/blankj/utilcode/util/SnackbarUtils;->getView()Landroid/view/View;

    move-result-object v0

    .line 366
    .local v0, "view":Landroid/view/View;
    if-eqz v0, :cond_0

    .line 367
    const/4 v1, 0x0

    invoke-virtual {v0, v1, v1, v1, v1}, Landroid/view/View;->setPadding(IIII)V

    .line 368
    move-object v1, v0

    check-cast v1, Lcom/google/android/material/snackbar/Snackbar$SnackbarLayout;

    .line 369
    .local v1, "layout":Lcom/google/android/material/snackbar/Snackbar$SnackbarLayout;
    invoke-virtual {v1, p0, p1}, Lcom/google/android/material/snackbar/Snackbar$SnackbarLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 371
    .end local v1    # "layout":Lcom/google/android/material/snackbar/Snackbar$SnackbarLayout;
    :cond_0
    return-void
.end method

.method public static dismiss()V
    .locals 1

    .line 321
    sget-object v0, Lcom/blankj/utilcode/util/SnackbarUtils;->sWeakSnackbar:Ljava/lang/ref/WeakReference;

    if-eqz v0, :cond_0

    sget-object v0, Lcom/blankj/utilcode/util/SnackbarUtils;->sWeakSnackbar:Ljava/lang/ref/WeakReference;

    invoke-virtual {v0}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v0

    if-eqz v0, :cond_0

    .line 322
    sget-object v0, Lcom/blankj/utilcode/util/SnackbarUtils;->sWeakSnackbar:Ljava/lang/ref/WeakReference;

    invoke-virtual {v0}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/google/android/material/snackbar/Snackbar;

    invoke-virtual {v0}, Lcom/google/android/material/snackbar/Snackbar;->dismiss()V

    .line 323
    const/4 v0, 0x0

    sput-object v0, Lcom/blankj/utilcode/util/SnackbarUtils;->sWeakSnackbar:Ljava/lang/ref/WeakReference;

    .line 325
    :cond_0
    return-void
.end method

.method private static findSuitableParentCopyFromSnackbar(Landroid/view/View;)Landroid/view/ViewGroup;
    .locals 3
    .param p0, "view"    # Landroid/view/View;

    .line 374
    const/4 v0, 0x0

    .line 377
    .local v0, "fallback":Landroid/view/ViewGroup;
    :cond_0
    instance-of v1, p0, Landroidx/coordinatorlayout/widget/CoordinatorLayout;

    if-eqz v1, :cond_1

    .line 378
    move-object v1, p0

    check-cast v1, Landroid/view/ViewGroup;

    return-object v1

    .line 381
    :cond_1
    instance-of v1, p0, Landroid/widget/FrameLayout;

    if-eqz v1, :cond_3

    .line 382
    invoke-virtual {p0}, Landroid/view/View;->getId()I

    move-result v1

    const v2, 0x1020002

    if-ne v1, v2, :cond_2

    .line 383
    move-object v1, p0

    check-cast v1, Landroid/view/ViewGroup;

    return-object v1

    .line 386
    :cond_2
    move-object v0, p0

    check-cast v0, Landroid/view/ViewGroup;

    .line 389
    :cond_3
    if-eqz p0, :cond_5

    .line 390
    invoke-virtual {p0}, Landroid/view/View;->getParent()Landroid/view/ViewParent;

    move-result-object v1

    .line 391
    .local v1, "parent":Landroid/view/ViewParent;
    instance-of v2, v1, Landroid/view/View;

    if-eqz v2, :cond_4

    move-object v2, v1

    check-cast v2, Landroid/view/View;

    goto :goto_0

    :cond_4
    const/4 v2, 0x0

    :goto_0
    move-object p0, v2

    .line 393
    .end local v1    # "parent":Landroid/view/ViewParent;
    :cond_5
    if-nez p0, :cond_0

    .line 395
    return-object v0
.end method

.method public static getView()Landroid/view/View;
    .locals 2

    .line 333
    sget-object v0, Lcom/blankj/utilcode/util/SnackbarUtils;->sWeakSnackbar:Ljava/lang/ref/WeakReference;

    invoke-virtual {v0}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/google/android/material/snackbar/Snackbar;

    .line 334
    .local v0, "snackbar":Lcom/google/android/material/snackbar/Snackbar;
    if-nez v0, :cond_0

    const/4 v1, 0x0

    return-object v1

    .line 335
    :cond_0
    invoke-virtual {v0}, Lcom/google/android/material/snackbar/Snackbar;->getView()Landroid/view/View;

    move-result-object v1

    return-object v1
.end method

.method private setDefault()V
    .locals 3

    .line 71
    const-string v0, ""

    iput-object v0, p0, Lcom/blankj/utilcode/util/SnackbarUtils;->message:Ljava/lang/CharSequence;

    .line 72
    const v1, -0x1000001

    iput v1, p0, Lcom/blankj/utilcode/util/SnackbarUtils;->messageColor:I

    .line 73
    iput v1, p0, Lcom/blankj/utilcode/util/SnackbarUtils;->bgColor:I

    .line 74
    const/4 v2, -0x1

    iput v2, p0, Lcom/blankj/utilcode/util/SnackbarUtils;->bgResource:I

    .line 75
    iput v2, p0, Lcom/blankj/utilcode/util/SnackbarUtils;->duration:I

    .line 76
    iput-object v0, p0, Lcom/blankj/utilcode/util/SnackbarUtils;->actionText:Ljava/lang/CharSequence;

    .line 77
    iput v1, p0, Lcom/blankj/utilcode/util/SnackbarUtils;->actionTextColor:I

    .line 78
    const/4 v0, 0x0

    iput v0, p0, Lcom/blankj/utilcode/util/SnackbarUtils;->bottomMargin:I

    .line 79
    return-void
.end method

.method public static with(Landroid/view/View;)Lcom/blankj/utilcode/util/SnackbarUtils;
    .locals 1
    .param p0, "view"    # Landroid/view/View;

    .line 88
    new-instance v0, Lcom/blankj/utilcode/util/SnackbarUtils;

    invoke-direct {v0, p0}, Lcom/blankj/utilcode/util/SnackbarUtils;-><init>(Landroid/view/View;)V

    return-object v0
.end method


# virtual methods
.method public setAction(Ljava/lang/CharSequence;ILandroid/view/View$OnClickListener;)Lcom/blankj/utilcode/util/SnackbarUtils;
    .locals 0
    .param p1, "text"    # Ljava/lang/CharSequence;
    .param p2, "color"    # I
    .param p3, "listener"    # Landroid/view/View$OnClickListener;

    .line 175
    iput-object p1, p0, Lcom/blankj/utilcode/util/SnackbarUtils;->actionText:Ljava/lang/CharSequence;

    .line 176
    iput p2, p0, Lcom/blankj/utilcode/util/SnackbarUtils;->actionTextColor:I

    .line 177
    iput-object p3, p0, Lcom/blankj/utilcode/util/SnackbarUtils;->actionListener:Landroid/view/View$OnClickListener;

    .line 178
    return-object p0
.end method

.method public setAction(Ljava/lang/CharSequence;Landroid/view/View$OnClickListener;)Lcom/blankj/utilcode/util/SnackbarUtils;
    .locals 1
    .param p1, "text"    # Ljava/lang/CharSequence;
    .param p2, "listener"    # Landroid/view/View$OnClickListener;

    .line 160
    const v0, -0x1000001

    invoke-virtual {p0, p1, v0, p2}, Lcom/blankj/utilcode/util/SnackbarUtils;->setAction(Ljava/lang/CharSequence;ILandroid/view/View$OnClickListener;)Lcom/blankj/utilcode/util/SnackbarUtils;

    move-result-object v0

    return-object v0
.end method

.method public setBgColor(I)Lcom/blankj/utilcode/util/SnackbarUtils;
    .locals 0
    .param p1, "color"    # I

    .line 120
    iput p1, p0, Lcom/blankj/utilcode/util/SnackbarUtils;->bgColor:I

    .line 121
    return-object p0
.end method

.method public setBgResource(I)Lcom/blankj/utilcode/util/SnackbarUtils;
    .locals 0
    .param p1, "bgResource"    # I

    .line 131
    iput p1, p0, Lcom/blankj/utilcode/util/SnackbarUtils;->bgResource:I

    .line 132
    return-object p0
.end method

.method public setBottomMargin(I)Lcom/blankj/utilcode/util/SnackbarUtils;
    .locals 0
    .param p1, "bottomMargin"    # I

    .line 187
    iput p1, p0, Lcom/blankj/utilcode/util/SnackbarUtils;->bottomMargin:I

    .line 188
    return-object p0
.end method

.method public setDuration(I)Lcom/blankj/utilcode/util/SnackbarUtils;
    .locals 0
    .param p1, "duration"    # I

    .line 147
    iput p1, p0, Lcom/blankj/utilcode/util/SnackbarUtils;->duration:I

    .line 148
    return-object p0
.end method

.method public setMessage(Ljava/lang/CharSequence;)Lcom/blankj/utilcode/util/SnackbarUtils;
    .locals 0
    .param p1, "msg"    # Ljava/lang/CharSequence;

    .line 98
    iput-object p1, p0, Lcom/blankj/utilcode/util/SnackbarUtils;->message:Ljava/lang/CharSequence;

    .line 99
    return-object p0
.end method

.method public setMessageColor(I)Lcom/blankj/utilcode/util/SnackbarUtils;
    .locals 0
    .param p1, "color"    # I

    .line 109
    iput p1, p0, Lcom/blankj/utilcode/util/SnackbarUtils;->messageColor:I

    .line 110
    return-object p0
.end method

.method public show()Lcom/google/android/material/snackbar/Snackbar;
    .locals 1

    .line 195
    const/4 v0, 0x0

    invoke-virtual {p0, v0}, Lcom/blankj/utilcode/util/SnackbarUtils;->show(Z)Lcom/google/android/material/snackbar/Snackbar;

    move-result-object v0

    return-object v0
.end method

.method public show(Z)Lcom/google/android/material/snackbar/Snackbar;
    .locals 9
    .param p1, "isShowTop"    # Z

    .line 204
    iget-object v0, p0, Lcom/blankj/utilcode/util/SnackbarUtils;->view:Landroid/view/View;

    .line 205
    .local v0, "view":Landroid/view/View;
    if-nez v0, :cond_0

    const/4 v1, 0x0

    return-object v1

    .line 206
    :cond_0
    const/high16 v1, 0x43340000    # 180.0f

    const/4 v2, -0x1

    if-eqz p1, :cond_2

    .line 207
    invoke-static {v0}, Lcom/blankj/utilcode/util/SnackbarUtils;->findSuitableParentCopyFromSnackbar(Landroid/view/View;)Landroid/view/ViewGroup;

    move-result-object v3

    .line 208
    .local v3, "suitableParent":Landroid/view/ViewGroup;
    const-string/jumbo v4, "topSnackBarCoordinatorLayout"

    invoke-virtual {v3, v4}, Landroid/view/ViewGroup;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v5

    .line 209
    .local v5, "topSnackBarContainer":Landroid/view/View;
    if-nez v5, :cond_1

    .line 210
    new-instance v6, Landroidx/coordinatorlayout/widget/CoordinatorLayout;

    invoke-virtual {v0}, Landroid/view/View;->getContext()Landroid/content/Context;

    move-result-object v7

    invoke-direct {v6, v7}, Landroidx/coordinatorlayout/widget/CoordinatorLayout;-><init>(Landroid/content/Context;)V

    .line 211
    .local v6, "topSnackBarCoordinatorLayout":Landroidx/coordinatorlayout/widget/CoordinatorLayout;
    invoke-virtual {v6, v4}, Landroidx/coordinatorlayout/widget/CoordinatorLayout;->setTag(Ljava/lang/Object;)V

    .line 212
    invoke-virtual {v6, v1}, Landroidx/coordinatorlayout/widget/CoordinatorLayout;->setRotation(F)V

    .line 213
    nop

    .line 215
    const/high16 v4, 0x42c80000    # 100.0f

    invoke-virtual {v6, v4}, Landroidx/coordinatorlayout/widget/CoordinatorLayout;->setElevation(F)V

    .line 217
    invoke-virtual {v3, v6, v2, v2}, Landroid/view/ViewGroup;->addView(Landroid/view/View;II)V

    .line 218
    move-object v5, v6

    .line 220
    .end local v6    # "topSnackBarCoordinatorLayout":Landroidx/coordinatorlayout/widget/CoordinatorLayout;
    :cond_1
    move-object v0, v5

    .line 222
    .end local v3    # "suitableParent":Landroid/view/ViewGroup;
    .end local v5    # "topSnackBarContainer":Landroid/view/View;
    :cond_2
    iget v3, p0, Lcom/blankj/utilcode/util/SnackbarUtils;->messageColor:I

    const v4, -0x1000001

    if-eq v3, v4, :cond_3

    .line 223
    new-instance v3, Landroid/text/SpannableString;

    iget-object v5, p0, Lcom/blankj/utilcode/util/SnackbarUtils;->message:Ljava/lang/CharSequence;

    invoke-direct {v3, v5}, Landroid/text/SpannableString;-><init>(Ljava/lang/CharSequence;)V

    .line 224
    .local v3, "spannableString":Landroid/text/SpannableString;
    new-instance v5, Landroid/text/style/ForegroundColorSpan;

    iget v6, p0, Lcom/blankj/utilcode/util/SnackbarUtils;->messageColor:I

    invoke-direct {v5, v6}, Landroid/text/style/ForegroundColorSpan;-><init>(I)V

    .line 225
    .local v5, "colorSpan":Landroid/text/style/ForegroundColorSpan;
    nop

    .line 226
    invoke-virtual {v3}, Landroid/text/SpannableString;->length()I

    move-result v6

    .line 225
    const/4 v7, 0x0

    const/16 v8, 0x21

    invoke-virtual {v3, v5, v7, v6, v8}, Landroid/text/SpannableString;->setSpan(Ljava/lang/Object;III)V

    .line 228
    new-instance v6, Ljava/lang/ref/WeakReference;

    iget v7, p0, Lcom/blankj/utilcode/util/SnackbarUtils;->duration:I

    invoke-static {v0, v3, v7}, Lcom/google/android/material/snackbar/Snackbar;->make(Landroid/view/View;Ljava/lang/CharSequence;I)Lcom/google/android/material/snackbar/Snackbar;

    move-result-object v7

    invoke-direct {v6, v7}, Ljava/lang/ref/WeakReference;-><init>(Ljava/lang/Object;)V

    sput-object v6, Lcom/blankj/utilcode/util/SnackbarUtils;->sWeakSnackbar:Ljava/lang/ref/WeakReference;

    .line 229
    .end local v3    # "spannableString":Landroid/text/SpannableString;
    .end local v5    # "colorSpan":Landroid/text/style/ForegroundColorSpan;
    goto :goto_0

    .line 230
    :cond_3
    new-instance v3, Ljava/lang/ref/WeakReference;

    iget-object v5, p0, Lcom/blankj/utilcode/util/SnackbarUtils;->message:Ljava/lang/CharSequence;

    iget v6, p0, Lcom/blankj/utilcode/util/SnackbarUtils;->duration:I

    invoke-static {v0, v5, v6}, Lcom/google/android/material/snackbar/Snackbar;->make(Landroid/view/View;Ljava/lang/CharSequence;I)Lcom/google/android/material/snackbar/Snackbar;

    move-result-object v5

    invoke-direct {v3, v5}, Ljava/lang/ref/WeakReference;-><init>(Ljava/lang/Object;)V

    sput-object v3, Lcom/blankj/utilcode/util/SnackbarUtils;->sWeakSnackbar:Ljava/lang/ref/WeakReference;

    .line 232
    :goto_0
    sget-object v3, Lcom/blankj/utilcode/util/SnackbarUtils;->sWeakSnackbar:Ljava/lang/ref/WeakReference;

    invoke-virtual {v3}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lcom/google/android/material/snackbar/Snackbar;

    .line 233
    .local v3, "snackbar":Lcom/google/android/material/snackbar/Snackbar;
    invoke-virtual {v3}, Lcom/google/android/material/snackbar/Snackbar;->getView()Landroid/view/View;

    move-result-object v5

    check-cast v5, Lcom/google/android/material/snackbar/Snackbar$SnackbarLayout;

    .line 234
    .local v5, "snackbarView":Lcom/google/android/material/snackbar/Snackbar$SnackbarLayout;
    if-eqz p1, :cond_4

    .line 235
    const/4 v6, 0x0

    .local v6, "i":I
    :goto_1
    invoke-virtual {v5}, Lcom/google/android/material/snackbar/Snackbar$SnackbarLayout;->getChildCount()I

    move-result v7

    if-ge v6, v7, :cond_4

    .line 236
    invoke-virtual {v5, v6}, Lcom/google/android/material/snackbar/Snackbar$SnackbarLayout;->getChildAt(I)Landroid/view/View;

    move-result-object v7

    .line 237
    .local v7, "child":Landroid/view/View;
    invoke-virtual {v7, v1}, Landroid/view/View;->setRotation(F)V

    .line 235
    .end local v7    # "child":Landroid/view/View;
    add-int/lit8 v6, v6, 0x1

    goto :goto_1

    .line 240
    .end local v6    # "i":I
    :cond_4
    iget v1, p0, Lcom/blankj/utilcode/util/SnackbarUtils;->bgResource:I

    if-eq v1, v2, :cond_5

    .line 241
    iget v1, p0, Lcom/blankj/utilcode/util/SnackbarUtils;->bgResource:I

    invoke-virtual {v5, v1}, Lcom/google/android/material/snackbar/Snackbar$SnackbarLayout;->setBackgroundResource(I)V

    goto :goto_2

    .line 242
    :cond_5
    iget v1, p0, Lcom/blankj/utilcode/util/SnackbarUtils;->bgColor:I

    if-eq v1, v4, :cond_6

    .line 243
    iget v1, p0, Lcom/blankj/utilcode/util/SnackbarUtils;->bgColor:I

    invoke-virtual {v5, v1}, Lcom/google/android/material/snackbar/Snackbar$SnackbarLayout;->setBackgroundColor(I)V

    .line 245
    :cond_6
    :goto_2
    iget v1, p0, Lcom/blankj/utilcode/util/SnackbarUtils;->bottomMargin:I

    if-eqz v1, :cond_7

    .line 246
    nop

    .line 247
    invoke-virtual {v5}, Lcom/google/android/material/snackbar/Snackbar$SnackbarLayout;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v1

    check-cast v1, Landroid/view/ViewGroup$MarginLayoutParams;

    .line 248
    .local v1, "params":Landroid/view/ViewGroup$MarginLayoutParams;
    iget v2, p0, Lcom/blankj/utilcode/util/SnackbarUtils;->bottomMargin:I

    iput v2, v1, Landroid/view/ViewGroup$MarginLayoutParams;->bottomMargin:I

    .line 250
    .end local v1    # "params":Landroid/view/ViewGroup$MarginLayoutParams;
    :cond_7
    iget-object v1, p0, Lcom/blankj/utilcode/util/SnackbarUtils;->actionText:Ljava/lang/CharSequence;

    invoke-interface {v1}, Ljava/lang/CharSequence;->length()I

    move-result v1

    if-lez v1, :cond_9

    iget-object v1, p0, Lcom/blankj/utilcode/util/SnackbarUtils;->actionListener:Landroid/view/View$OnClickListener;

    if-eqz v1, :cond_9

    .line 251
    iget v1, p0, Lcom/blankj/utilcode/util/SnackbarUtils;->actionTextColor:I

    if-eq v1, v4, :cond_8

    .line 252
    iget v1, p0, Lcom/blankj/utilcode/util/SnackbarUtils;->actionTextColor:I

    invoke-virtual {v3, v1}, Lcom/google/android/material/snackbar/Snackbar;->setActionTextColor(I)Lcom/google/android/material/snackbar/Snackbar;

    .line 254
    :cond_8
    iget-object v1, p0, Lcom/blankj/utilcode/util/SnackbarUtils;->actionText:Ljava/lang/CharSequence;

    iget-object v2, p0, Lcom/blankj/utilcode/util/SnackbarUtils;->actionListener:Landroid/view/View$OnClickListener;

    invoke-virtual {v3, v1, v2}, Lcom/google/android/material/snackbar/Snackbar;->setAction(Ljava/lang/CharSequence;Landroid/view/View$OnClickListener;)Lcom/google/android/material/snackbar/Snackbar;

    .line 256
    :cond_9
    invoke-virtual {v3}, Lcom/google/android/material/snackbar/Snackbar;->show()V

    .line 257
    return-object v3
.end method

.method public showError()V
    .locals 1

    .line 302
    const/4 v0, 0x0

    invoke-virtual {p0, v0}, Lcom/blankj/utilcode/util/SnackbarUtils;->showError(Z)V

    .line 303
    return-void
.end method

.method public showError(Z)V
    .locals 1
    .param p1, "isShowTop"    # Z

    .line 311
    const/high16 v0, -0x10000

    iput v0, p0, Lcom/blankj/utilcode/util/SnackbarUtils;->bgColor:I

    .line 312
    const/4 v0, -0x1

    iput v0, p0, Lcom/blankj/utilcode/util/SnackbarUtils;->messageColor:I

    .line 313
    iput v0, p0, Lcom/blankj/utilcode/util/SnackbarUtils;->actionTextColor:I

    .line 314
    invoke-virtual {p0, p1}, Lcom/blankj/utilcode/util/SnackbarUtils;->show(Z)Lcom/google/android/material/snackbar/Snackbar;

    .line 315
    return-void
.end method

.method public showSuccess()V
    .locals 1

    .line 264
    const/4 v0, 0x0

    invoke-virtual {p0, v0}, Lcom/blankj/utilcode/util/SnackbarUtils;->showSuccess(Z)V

    .line 265
    return-void
.end method

.method public showSuccess(Z)V
    .locals 1
    .param p1, "isShowTop"    # Z

    .line 273
    const v0, -0xd44a00

    iput v0, p0, Lcom/blankj/utilcode/util/SnackbarUtils;->bgColor:I

    .line 274
    const/4 v0, -0x1

    iput v0, p0, Lcom/blankj/utilcode/util/SnackbarUtils;->messageColor:I

    .line 275
    iput v0, p0, Lcom/blankj/utilcode/util/SnackbarUtils;->actionTextColor:I

    .line 276
    invoke-virtual {p0, p1}, Lcom/blankj/utilcode/util/SnackbarUtils;->show(Z)Lcom/google/android/material/snackbar/Snackbar;

    .line 277
    return-void
.end method

.method public showWarning()V
    .locals 1

    .line 283
    const/4 v0, 0x0

    invoke-virtual {p0, v0}, Lcom/blankj/utilcode/util/SnackbarUtils;->showWarning(Z)V

    .line 284
    return-void
.end method

.method public showWarning(Z)V
    .locals 1
    .param p1, "isShowTop"    # Z

    .line 292
    const/16 v0, -0x3f00

    iput v0, p0, Lcom/blankj/utilcode/util/SnackbarUtils;->bgColor:I

    .line 293
    const/4 v0, -0x1

    iput v0, p0, Lcom/blankj/utilcode/util/SnackbarUtils;->messageColor:I

    .line 294
    iput v0, p0, Lcom/blankj/utilcode/util/SnackbarUtils;->actionTextColor:I

    .line 295
    invoke-virtual {p0, p1}, Lcom/blankj/utilcode/util/SnackbarUtils;->show(Z)Lcom/google/android/material/snackbar/Snackbar;

    .line 296
    return-void
.end method
