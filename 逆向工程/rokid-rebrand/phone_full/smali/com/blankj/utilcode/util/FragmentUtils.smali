.class public final Lcom/blankj/utilcode/util/FragmentUtils;
.super Ljava/lang/Object;
.source "FragmentUtils.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/blankj/utilcode/util/FragmentUtils$OnBackClickListener;,
        Lcom/blankj/utilcode/util/FragmentUtils$FragmentNode;,
        Lcom/blankj/utilcode/util/FragmentUtils$Args;
    }
.end annotation


# static fields
.field private static final ARGS_ID:Ljava/lang/String; = "args_id"

.field private static final ARGS_IS_ADD_STACK:Ljava/lang/String; = "args_is_add_stack"

.field private static final ARGS_IS_HIDE:Ljava/lang/String; = "args_is_hide"

.field private static final ARGS_TAG:Ljava/lang/String; = "args_tag"

.field private static final TYPE_ADD_FRAGMENT:I = 0x1

.field private static final TYPE_HIDE_FRAGMENT:I = 0x4

.field private static final TYPE_REMOVE_FRAGMENT:I = 0x20

.field private static final TYPE_REMOVE_TO_FRAGMENT:I = 0x40

.field private static final TYPE_REPLACE_FRAGMENT:I = 0x10

.field private static final TYPE_SHOW_FRAGMENT:I = 0x2

.field private static final TYPE_SHOW_HIDE_FRAGMENT:I = 0x8


# direct methods
.method private constructor <init>()V
    .locals 2

    .line 48
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 49
    new-instance v0, Ljava/lang/UnsupportedOperationException;

    const-string/jumbo v1, "u can\'t instantiate me..."

    invoke-direct {v0, v1}, Ljava/lang/UnsupportedOperationException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public static add(Landroidx/fragment/app/FragmentManager;Landroidx/fragment/app/Fragment;I)V
    .locals 6
    .param p0, "fm"    # Landroidx/fragment/app/FragmentManager;
    .param p1, "add"    # Landroidx/fragment/app/Fragment;
    .param p2, "containerId"    # I

    .line 62
    const/4 v4, 0x0

    const/4 v5, 0x0

    const/4 v3, 0x0

    move-object v0, p0

    move-object v1, p1

    move v2, p2

    invoke-static/range {v0 .. v5}, Lcom/blankj/utilcode/util/FragmentUtils;->add(Landroidx/fragment/app/FragmentManager;Landroidx/fragment/app/Fragment;ILjava/lang/String;ZZ)V

    .line 63
    return-void
.end method

.method public static add(Landroidx/fragment/app/FragmentManager;Landroidx/fragment/app/Fragment;III)V
    .locals 9
    .param p0, "fm"    # Landroidx/fragment/app/FragmentManager;
    .param p1, "add"    # Landroidx/fragment/app/Fragment;
    .param p2, "containerId"    # I
    .param p3, "enterAnim"    # I
    .param p4, "exitAnim"    # I

    .line 113
    const/4 v7, 0x0

    const/4 v8, 0x0

    const/4 v3, 0x0

    const/4 v4, 0x0

    move-object v0, p0

    move-object v1, p1

    move v2, p2

    move v5, p3

    move v6, p4

    invoke-static/range {v0 .. v8}, Lcom/blankj/utilcode/util/FragmentUtils;->add(Landroidx/fragment/app/FragmentManager;Landroidx/fragment/app/Fragment;ILjava/lang/String;ZIIII)V

    .line 114
    return-void
.end method

.method public static add(Landroidx/fragment/app/FragmentManager;Landroidx/fragment/app/Fragment;IIIII)V
    .locals 9
    .param p0, "fm"    # Landroidx/fragment/app/FragmentManager;
    .param p1, "add"    # Landroidx/fragment/app/Fragment;
    .param p2, "containerId"    # I
    .param p3, "enterAnim"    # I
    .param p4, "exitAnim"    # I
    .param p5, "popEnterAnim"    # I
    .param p6, "popExitAnim"    # I

    .line 161
    const/4 v3, 0x0

    const/4 v4, 0x0

    move-object v0, p0

    move-object v1, p1

    move v2, p2

    move v5, p3

    move v6, p4

    move v7, p5

    move v8, p6

    invoke-static/range {v0 .. v8}, Lcom/blankj/utilcode/util/FragmentUtils;->add(Landroidx/fragment/app/FragmentManager;Landroidx/fragment/app/Fragment;ILjava/lang/String;ZIIII)V

    .line 162
    return-void
.end method

.method public static add(Landroidx/fragment/app/FragmentManager;Landroidx/fragment/app/Fragment;ILjava/lang/String;)V
    .locals 6
    .param p0, "fm"    # Landroidx/fragment/app/FragmentManager;
    .param p1, "add"    # Landroidx/fragment/app/Fragment;
    .param p2, "containerId"    # I
    .param p3, "tag"    # Ljava/lang/String;

    .line 269
    const/4 v4, 0x0

    const/4 v5, 0x0

    move-object v0, p0

    move-object v1, p1

    move v2, p2

    move-object v3, p3

    invoke-static/range {v0 .. v5}, Lcom/blankj/utilcode/util/FragmentUtils;->add(Landroidx/fragment/app/FragmentManager;Landroidx/fragment/app/Fragment;ILjava/lang/String;ZZ)V

    .line 270
    return-void
.end method

.method public static add(Landroidx/fragment/app/FragmentManager;Landroidx/fragment/app/Fragment;ILjava/lang/String;II)V
    .locals 9
    .param p0, "fm"    # Landroidx/fragment/app/FragmentManager;
    .param p1, "add"    # Landroidx/fragment/app/Fragment;
    .param p2, "containerId"    # I
    .param p3, "tag"    # Ljava/lang/String;
    .param p4, "enterAnim"    # I
    .param p5, "exitAnim"    # I

    .line 327
    const/4 v7, 0x0

    const/4 v8, 0x0

    const/4 v4, 0x0

    move-object v0, p0

    move-object v1, p1

    move v2, p2

    move-object v3, p3

    move v5, p4

    move v6, p5

    invoke-static/range {v0 .. v8}, Lcom/blankj/utilcode/util/FragmentUtils;->add(Landroidx/fragment/app/FragmentManager;Landroidx/fragment/app/Fragment;ILjava/lang/String;ZIIII)V

    .line 328
    return-void
.end method

.method public static add(Landroidx/fragment/app/FragmentManager;Landroidx/fragment/app/Fragment;ILjava/lang/String;IIII)V
    .locals 9
    .param p0, "fm"    # Landroidx/fragment/app/FragmentManager;
    .param p1, "add"    # Landroidx/fragment/app/Fragment;
    .param p2, "containerId"    # I
    .param p3, "tag"    # Ljava/lang/String;
    .param p4, "enterAnim"    # I
    .param p5, "exitAnim"    # I
    .param p6, "popEnterAnim"    # I
    .param p7, "popExitAnim"    # I

    .line 379
    const/4 v4, 0x0

    move-object v0, p0

    move-object v1, p1

    move v2, p2

    move-object v3, p3

    move v5, p4

    move v6, p5

    move v7, p6

    move/from16 v8, p7

    invoke-static/range {v0 .. v8}, Lcom/blankj/utilcode/util/FragmentUtils;->add(Landroidx/fragment/app/FragmentManager;Landroidx/fragment/app/Fragment;ILjava/lang/String;ZIIII)V

    .line 380
    return-void
.end method

.method public static add(Landroidx/fragment/app/FragmentManager;Landroidx/fragment/app/Fragment;ILjava/lang/String;Z)V
    .locals 6
    .param p0, "fm"    # Landroidx/fragment/app/FragmentManager;
    .param p1, "add"    # Landroidx/fragment/app/Fragment;
    .param p2, "containerId"    # I
    .param p3, "tag"    # Ljava/lang/String;
    .param p4, "isHide"    # Z

    .line 286
    const/4 v5, 0x0

    move-object v0, p0

    move-object v1, p1

    move v2, p2

    move-object v3, p3

    move v4, p4

    invoke-static/range {v0 .. v5}, Lcom/blankj/utilcode/util/FragmentUtils;->add(Landroidx/fragment/app/FragmentManager;Landroidx/fragment/app/Fragment;ILjava/lang/String;ZZ)V

    .line 287
    return-void
.end method

.method public static add(Landroidx/fragment/app/FragmentManager;Landroidx/fragment/app/Fragment;ILjava/lang/String;ZII)V
    .locals 9
    .param p0, "fm"    # Landroidx/fragment/app/FragmentManager;
    .param p1, "add"    # Landroidx/fragment/app/Fragment;
    .param p2, "containerId"    # I
    .param p3, "tag"    # Ljava/lang/String;
    .param p4, "isAddStack"    # Z
    .param p5, "enterAnim"    # I
    .param p6, "exitAnim"    # I

    .line 350
    const/4 v7, 0x0

    const/4 v8, 0x0

    move-object v0, p0

    move-object v1, p1

    move v2, p2

    move-object v3, p3

    move v4, p4

    move v5, p5

    move v6, p6

    invoke-static/range {v0 .. v8}, Lcom/blankj/utilcode/util/FragmentUtils;->add(Landroidx/fragment/app/FragmentManager;Landroidx/fragment/app/Fragment;ILjava/lang/String;ZIIII)V

    .line 351
    return-void
.end method

.method public static add(Landroidx/fragment/app/FragmentManager;Landroidx/fragment/app/Fragment;ILjava/lang/String;ZIIII)V
    .locals 4
    .param p0, "fm"    # Landroidx/fragment/app/FragmentManager;
    .param p1, "add"    # Landroidx/fragment/app/Fragment;
    .param p2, "containerId"    # I
    .param p3, "tag"    # Ljava/lang/String;
    .param p4, "isAddStack"    # Z
    .param p5, "enterAnim"    # I
    .param p6, "exitAnim"    # I
    .param p7, "popEnterAnim"    # I
    .param p8, "popExitAnim"    # I

    .line 410
    invoke-virtual {p0}, Landroidx/fragment/app/FragmentManager;->beginTransaction()Landroidx/fragment/app/FragmentTransaction;

    move-result-object v0

    .line 411
    .local v0, "ft":Landroidx/fragment/app/FragmentTransaction;
    new-instance v1, Lcom/blankj/utilcode/util/FragmentUtils$Args;

    const/4 v2, 0x0

    invoke-direct {v1, p2, p3, v2, p4}, Lcom/blankj/utilcode/util/FragmentUtils$Args;-><init>(ILjava/lang/String;ZZ)V

    invoke-static {p1, v1}, Lcom/blankj/utilcode/util/FragmentUtils;->putArgs(Landroidx/fragment/app/Fragment;Lcom/blankj/utilcode/util/FragmentUtils$Args;)V

    .line 412
    invoke-static {v0, p5, p6, p7, p8}, Lcom/blankj/utilcode/util/FragmentUtils;->addAnim(Landroidx/fragment/app/FragmentTransaction;IIII)V

    .line 413
    const/4 v1, 0x1

    new-array v3, v1, [Landroidx/fragment/app/Fragment;

    aput-object p1, v3, v2

    const/4 v2, 0x0

    invoke-static {v1, p0, v0, v2, v3}, Lcom/blankj/utilcode/util/FragmentUtils;->operate(ILandroidx/fragment/app/FragmentManager;Landroidx/fragment/app/FragmentTransaction;Landroidx/fragment/app/Fragment;[Landroidx/fragment/app/Fragment;)V

    .line 414
    return-void
.end method

.method public static add(Landroidx/fragment/app/FragmentManager;Landroidx/fragment/app/Fragment;ILjava/lang/String;ZZ)V
    .locals 3
    .param p0, "fm"    # Landroidx/fragment/app/FragmentManager;
    .param p1, "add"    # Landroidx/fragment/app/Fragment;
    .param p2, "containerId"    # I
    .param p3, "tag"    # Ljava/lang/String;
    .param p4, "isHide"    # Z
    .param p5, "isAddStack"    # Z

    .line 305
    new-instance v0, Lcom/blankj/utilcode/util/FragmentUtils$Args;

    invoke-direct {v0, p2, p3, p4, p5}, Lcom/blankj/utilcode/util/FragmentUtils$Args;-><init>(ILjava/lang/String;ZZ)V

    invoke-static {p1, v0}, Lcom/blankj/utilcode/util/FragmentUtils;->putArgs(Landroidx/fragment/app/Fragment;Lcom/blankj/utilcode/util/FragmentUtils$Args;)V

    .line 306
    const/4 v0, 0x1

    new-array v1, v0, [Landroidx/fragment/app/Fragment;

    const/4 v2, 0x0

    aput-object p1, v1, v2

    const/4 v2, 0x0

    invoke-static {v0, p0, v2, v1}, Lcom/blankj/utilcode/util/FragmentUtils;->operateNoAnim(ILandroidx/fragment/app/FragmentManager;Landroidx/fragment/app/Fragment;[Landroidx/fragment/app/Fragment;)V

    .line 307
    return-void
.end method

.method public static varargs add(Landroidx/fragment/app/FragmentManager;Landroidx/fragment/app/Fragment;ILjava/lang/String;Z[Landroid/view/View;)V
    .locals 4
    .param p0, "fm"    # Landroidx/fragment/app/FragmentManager;
    .param p1, "add"    # Landroidx/fragment/app/Fragment;
    .param p2, "containerId"    # I
    .param p3, "tag"    # Ljava/lang/String;
    .param p4, "isAddStack"    # Z
    .param p5, "sharedElements"    # [Landroid/view/View;

    .line 450
    invoke-virtual {p0}, Landroidx/fragment/app/FragmentManager;->beginTransaction()Landroidx/fragment/app/FragmentTransaction;

    move-result-object v0

    .line 451
    .local v0, "ft":Landroidx/fragment/app/FragmentTransaction;
    new-instance v1, Lcom/blankj/utilcode/util/FragmentUtils$Args;

    const/4 v2, 0x0

    invoke-direct {v1, p2, p3, v2, p4}, Lcom/blankj/utilcode/util/FragmentUtils$Args;-><init>(ILjava/lang/String;ZZ)V

    invoke-static {p1, v1}, Lcom/blankj/utilcode/util/FragmentUtils;->putArgs(Landroidx/fragment/app/Fragment;Lcom/blankj/utilcode/util/FragmentUtils$Args;)V

    .line 452
    invoke-static {v0, p5}, Lcom/blankj/utilcode/util/FragmentUtils;->addSharedElement(Landroidx/fragment/app/FragmentTransaction;[Landroid/view/View;)V

    .line 453
    const/4 v1, 0x1

    new-array v3, v1, [Landroidx/fragment/app/Fragment;

    aput-object p1, v3, v2

    const/4 v2, 0x0

    invoke-static {v1, p0, v0, v2, v3}, Lcom/blankj/utilcode/util/FragmentUtils;->operate(ILandroidx/fragment/app/FragmentManager;Landroidx/fragment/app/FragmentTransaction;Landroidx/fragment/app/Fragment;[Landroidx/fragment/app/Fragment;)V

    .line 454
    return-void
.end method

.method public static varargs add(Landroidx/fragment/app/FragmentManager;Landroidx/fragment/app/Fragment;ILjava/lang/String;[Landroid/view/View;)V
    .locals 6
    .param p0, "fm"    # Landroidx/fragment/app/FragmentManager;
    .param p1, "add"    # Landroidx/fragment/app/Fragment;
    .param p2, "containerId"    # I
    .param p3, "tag"    # Ljava/lang/String;
    .param p4, "sharedElements"    # [Landroid/view/View;

    .line 431
    const/4 v4, 0x0

    move-object v0, p0

    move-object v1, p1

    move v2, p2

    move-object v3, p3

    move-object v5, p4

    invoke-static/range {v0 .. v5}, Lcom/blankj/utilcode/util/FragmentUtils;->add(Landroidx/fragment/app/FragmentManager;Landroidx/fragment/app/Fragment;ILjava/lang/String;Z[Landroid/view/View;)V

    .line 432
    return-void
.end method

.method public static add(Landroidx/fragment/app/FragmentManager;Landroidx/fragment/app/Fragment;IZ)V
    .locals 6
    .param p0, "fm"    # Landroidx/fragment/app/FragmentManager;
    .param p1, "add"    # Landroidx/fragment/app/Fragment;
    .param p2, "containerId"    # I
    .param p3, "isHide"    # Z

    .line 77
    const/4 v3, 0x0

    const/4 v5, 0x0

    move-object v0, p0

    move-object v1, p1

    move v2, p2

    move v4, p3

    invoke-static/range {v0 .. v5}, Lcom/blankj/utilcode/util/FragmentUtils;->add(Landroidx/fragment/app/FragmentManager;Landroidx/fragment/app/Fragment;ILjava/lang/String;ZZ)V

    .line 78
    return-void
.end method

.method public static add(Landroidx/fragment/app/FragmentManager;Landroidx/fragment/app/Fragment;IZII)V
    .locals 9
    .param p0, "fm"    # Landroidx/fragment/app/FragmentManager;
    .param p1, "add"    # Landroidx/fragment/app/Fragment;
    .param p2, "containerId"    # I
    .param p3, "isAddStack"    # Z
    .param p4, "enterAnim"    # I
    .param p5, "exitAnim"    # I

    .line 134
    const/4 v7, 0x0

    const/4 v8, 0x0

    const/4 v3, 0x0

    move-object v0, p0

    move-object v1, p1

    move v2, p2

    move v4, p3

    move v5, p4

    move v6, p5

    invoke-static/range {v0 .. v8}, Lcom/blankj/utilcode/util/FragmentUtils;->add(Landroidx/fragment/app/FragmentManager;Landroidx/fragment/app/Fragment;ILjava/lang/String;ZIIII)V

    .line 135
    return-void
.end method

.method public static add(Landroidx/fragment/app/FragmentManager;Landroidx/fragment/app/Fragment;IZIIII)V
    .locals 9
    .param p0, "fm"    # Landroidx/fragment/app/FragmentManager;
    .param p1, "add"    # Landroidx/fragment/app/Fragment;
    .param p2, "containerId"    # I
    .param p3, "isAddStack"    # Z
    .param p4, "enterAnim"    # I
    .param p5, "exitAnim"    # I
    .param p6, "popEnterAnim"    # I
    .param p7, "popExitAnim"    # I

    .line 190
    const/4 v3, 0x0

    move-object v0, p0

    move-object v1, p1

    move v2, p2

    move v4, p3

    move v5, p4

    move v6, p5

    move v7, p6

    move/from16 v8, p7

    invoke-static/range {v0 .. v8}, Lcom/blankj/utilcode/util/FragmentUtils;->add(Landroidx/fragment/app/FragmentManager;Landroidx/fragment/app/Fragment;ILjava/lang/String;ZIIII)V

    .line 191
    return-void
.end method

.method public static add(Landroidx/fragment/app/FragmentManager;Landroidx/fragment/app/Fragment;IZZ)V
    .locals 6
    .param p0, "fm"    # Landroidx/fragment/app/FragmentManager;
    .param p1, "add"    # Landroidx/fragment/app/Fragment;
    .param p2, "containerId"    # I
    .param p3, "isHide"    # Z
    .param p4, "isAddStack"    # Z

    .line 94
    const/4 v3, 0x0

    move-object v0, p0

    move-object v1, p1

    move v2, p2

    move v4, p3

    move v5, p4

    invoke-static/range {v0 .. v5}, Lcom/blankj/utilcode/util/FragmentUtils;->add(Landroidx/fragment/app/FragmentManager;Landroidx/fragment/app/Fragment;ILjava/lang/String;ZZ)V

    .line 95
    return-void
.end method

.method public static varargs add(Landroidx/fragment/app/FragmentManager;Landroidx/fragment/app/Fragment;IZ[Landroid/view/View;)V
    .locals 6
    .param p0, "fm"    # Landroidx/fragment/app/FragmentManager;
    .param p1, "add"    # Landroidx/fragment/app/Fragment;
    .param p2, "containerId"    # I
    .param p3, "isAddStack"    # Z
    .param p4, "sharedElements"    # [Landroid/view/View;

    .line 224
    const/4 v3, 0x0

    move-object v0, p0

    move-object v1, p1

    move v2, p2

    move v4, p3

    move-object v5, p4

    invoke-static/range {v0 .. v5}, Lcom/blankj/utilcode/util/FragmentUtils;->add(Landroidx/fragment/app/FragmentManager;Landroidx/fragment/app/Fragment;ILjava/lang/String;Z[Landroid/view/View;)V

    .line 225
    return-void
.end method

.method public static varargs add(Landroidx/fragment/app/FragmentManager;Landroidx/fragment/app/Fragment;I[Landroid/view/View;)V
    .locals 6
    .param p0, "fm"    # Landroidx/fragment/app/FragmentManager;
    .param p1, "add"    # Landroidx/fragment/app/Fragment;
    .param p2, "containerId"    # I
    .param p3, "sharedElements"    # [Landroid/view/View;

    .line 206
    const/4 v3, 0x0

    const/4 v4, 0x0

    move-object v0, p0

    move-object v1, p1

    move v2, p2

    move-object v5, p3

    invoke-static/range {v0 .. v5}, Lcom/blankj/utilcode/util/FragmentUtils;->add(Landroidx/fragment/app/FragmentManager;Landroidx/fragment/app/Fragment;ILjava/lang/String;Z[Landroid/view/View;)V

    .line 207
    return-void
.end method

.method public static add(Landroidx/fragment/app/FragmentManager;Ljava/util/List;II)V
    .locals 2
    .param p0, "fm"    # Landroidx/fragment/app/FragmentManager;
    .param p2, "containerId"    # I
    .param p3, "showIndex"    # I
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroidx/fragment/app/FragmentManager;",
            "Ljava/util/List<",
            "Landroidx/fragment/app/Fragment;",
            ">;II)V"
        }
    .end annotation

    .line 239
    .local p1, "adds":Ljava/util/List;, "Ljava/util/List<Landroidx/fragment/app/Fragment;>;"
    const/4 v0, 0x0

    new-array v0, v0, [Landroidx/fragment/app/Fragment;

    invoke-interface {p1, v0}, Ljava/util/List;->toArray([Ljava/lang/Object;)[Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Landroidx/fragment/app/Fragment;

    const/4 v1, 0x0

    invoke-static {p0, v0, p2, v1, p3}, Lcom/blankj/utilcode/util/FragmentUtils;->add(Landroidx/fragment/app/FragmentManager;[Landroidx/fragment/app/Fragment;I[Ljava/lang/String;I)V

    .line 240
    return-void
.end method

.method public static add(Landroidx/fragment/app/FragmentManager;Ljava/util/List;I[Ljava/lang/String;I)V
    .locals 1
    .param p0, "fm"    # Landroidx/fragment/app/FragmentManager;
    .param p2, "containerId"    # I
    .param p3, "tags"    # [Ljava/lang/String;
    .param p4, "showIndex"    # I
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroidx/fragment/app/FragmentManager;",
            "Ljava/util/List<",
            "Landroidx/fragment/app/Fragment;",
            ">;I[",
            "Ljava/lang/String;",
            "I)V"
        }
    .end annotation

    .line 469
    .local p1, "adds":Ljava/util/List;, "Ljava/util/List<Landroidx/fragment/app/Fragment;>;"
    const/4 v0, 0x0

    new-array v0, v0, [Landroidx/fragment/app/Fragment;

    invoke-interface {p1, v0}, Ljava/util/List;->toArray([Ljava/lang/Object;)[Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Landroidx/fragment/app/Fragment;

    invoke-static {p0, v0, p2, p3, p4}, Lcom/blankj/utilcode/util/FragmentUtils;->add(Landroidx/fragment/app/FragmentManager;[Landroidx/fragment/app/Fragment;I[Ljava/lang/String;I)V

    .line 470
    return-void
.end method

.method public static add(Landroidx/fragment/app/FragmentManager;[Landroidx/fragment/app/Fragment;II)V
    .locals 1
    .param p0, "fm"    # Landroidx/fragment/app/FragmentManager;
    .param p1, "adds"    # [Landroidx/fragment/app/Fragment;
    .param p2, "containerId"    # I
    .param p3, "showIndex"    # I

    .line 254
    const/4 v0, 0x0

    invoke-static {p0, p1, p2, v0, p3}, Lcom/blankj/utilcode/util/FragmentUtils;->add(Landroidx/fragment/app/FragmentManager;[Landroidx/fragment/app/Fragment;I[Ljava/lang/String;I)V

    .line 255
    return-void
.end method

.method public static add(Landroidx/fragment/app/FragmentManager;[Landroidx/fragment/app/Fragment;I[Ljava/lang/String;I)V
    .locals 9
    .param p0, "fm"    # Landroidx/fragment/app/FragmentManager;
    .param p1, "adds"    # [Landroidx/fragment/app/Fragment;
    .param p2, "containerId"    # I
    .param p3, "tags"    # [Ljava/lang/String;
    .param p4, "showIndex"    # I

    .line 485
    const/4 v0, 0x0

    const/4 v1, 0x0

    const/4 v2, 0x1

    if-nez p3, :cond_2

    .line 486
    const/4 v3, 0x0

    .local v3, "i":I
    array-length v4, p1

    .local v4, "len":I
    :goto_0
    if-ge v3, v4, :cond_1

    .line 487
    aget-object v5, p1, v3

    new-instance v6, Lcom/blankj/utilcode/util/FragmentUtils$Args;

    if-eq p4, v3, :cond_0

    move v7, v2

    goto :goto_1

    :cond_0
    move v7, v1

    :goto_1
    invoke-direct {v6, p2, v0, v7, v1}, Lcom/blankj/utilcode/util/FragmentUtils$Args;-><init>(ILjava/lang/String;ZZ)V

    invoke-static {v5, v6}, Lcom/blankj/utilcode/util/FragmentUtils;->putArgs(Landroidx/fragment/app/Fragment;Lcom/blankj/utilcode/util/FragmentUtils$Args;)V

    .line 486
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    .end local v3    # "i":I
    .end local v4    # "len":I
    :cond_1
    goto :goto_4

    .line 490
    :cond_2
    const/4 v3, 0x0

    .restart local v3    # "i":I
    array-length v4, p1

    .restart local v4    # "len":I
    :goto_2
    if-ge v3, v4, :cond_4

    .line 491
    aget-object v5, p1, v3

    new-instance v6, Lcom/blankj/utilcode/util/FragmentUtils$Args;

    aget-object v7, p3, v3

    if-eq p4, v3, :cond_3

    move v8, v2

    goto :goto_3

    :cond_3
    move v8, v1

    :goto_3
    invoke-direct {v6, p2, v7, v8, v1}, Lcom/blankj/utilcode/util/FragmentUtils$Args;-><init>(ILjava/lang/String;ZZ)V

    invoke-static {v5, v6}, Lcom/blankj/utilcode/util/FragmentUtils;->putArgs(Landroidx/fragment/app/Fragment;Lcom/blankj/utilcode/util/FragmentUtils$Args;)V

    .line 490
    add-int/lit8 v3, v3, 0x1

    goto :goto_2

    .line 494
    .end local v3    # "i":I
    .end local v4    # "len":I
    :cond_4
    :goto_4
    invoke-static {v2, p0, v0, p1}, Lcom/blankj/utilcode/util/FragmentUtils;->operateNoAnim(ILandroidx/fragment/app/FragmentManager;Landroidx/fragment/app/Fragment;[Landroidx/fragment/app/Fragment;)V

    .line 495
    return-void
.end method

.method private static addAnim(Landroidx/fragment/app/FragmentTransaction;IIII)V
    .locals 0
    .param p0, "ft"    # Landroidx/fragment/app/FragmentTransaction;
    .param p1, "enter"    # I
    .param p2, "exit"    # I
    .param p3, "popEnter"    # I
    .param p4, "popExit"    # I

    .line 1537
    invoke-virtual {p0, p1, p2, p3, p4}, Landroidx/fragment/app/FragmentTransaction;->setCustomAnimations(IIII)Landroidx/fragment/app/FragmentTransaction;

    .line 1538
    return-void
.end method

.method private static varargs addSharedElement(Landroidx/fragment/app/FragmentTransaction;[Landroid/view/View;)V
    .locals 4
    .param p0, "ft"    # Landroidx/fragment/app/FragmentTransaction;
    .param p1, "views"    # [Landroid/view/View;

    .line 1542
    nop

    .line 1543
    array-length v0, p1

    const/4 v1, 0x0

    :goto_0
    if-ge v1, v0, :cond_0

    aget-object v2, p1, v1

    .line 1544
    .local v2, "view":Landroid/view/View;
    invoke-virtual {v2}, Landroid/view/View;->getTransitionName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0, v2, v3}, Landroidx/fragment/app/FragmentTransaction;->addSharedElement(Landroid/view/View;Ljava/lang/String;)Landroidx/fragment/app/FragmentTransaction;

    .line 1543
    .end local v2    # "view":Landroid/view/View;
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 1547
    :cond_0
    return-void
.end method

.method public static dispatchBackPress(Landroidx/fragment/app/Fragment;)Z
    .locals 1
    .param p0, "fragment"    # Landroidx/fragment/app/Fragment;

    .line 1746
    invoke-virtual {p0}, Landroidx/fragment/app/Fragment;->isResumed()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 1747
    invoke-virtual {p0}, Landroidx/fragment/app/Fragment;->isVisible()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 1748
    invoke-virtual {p0}, Landroidx/fragment/app/Fragment;->getUserVisibleHint()Z

    move-result v0

    if-eqz v0, :cond_0

    instance-of v0, p0, Lcom/blankj/utilcode/util/FragmentUtils$OnBackClickListener;

    if-eqz v0, :cond_0

    move-object v0, p0

    check-cast v0, Lcom/blankj/utilcode/util/FragmentUtils$OnBackClickListener;

    .line 1750
    invoke-interface {v0}, Lcom/blankj/utilcode/util/FragmentUtils$OnBackClickListener;->onBackClick()Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    .line 1746
    :goto_0
    return v0
.end method

.method public static dispatchBackPress(Landroidx/fragment/app/FragmentManager;)Z
    .locals 6
    .param p0, "fm"    # Landroidx/fragment/app/FragmentManager;

    .line 1760
    invoke-static {p0}, Lcom/blankj/utilcode/util/FragmentUtils;->getFragments(Landroidx/fragment/app/FragmentManager;)Ljava/util/List;

    move-result-object v0

    .line 1761
    .local v0, "fragments":Ljava/util/List;, "Ljava/util/List<Landroidx/fragment/app/Fragment;>;"
    const/4 v1, 0x0

    if-eqz v0, :cond_3

    invoke-interface {v0}, Ljava/util/List;->isEmpty()Z

    move-result v2

    if-eqz v2, :cond_0

    goto :goto_1

    .line 1762
    :cond_0
    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v2

    const/4 v3, 0x1

    sub-int/2addr v2, v3

    .local v2, "i":I
    :goto_0
    if-ltz v2, :cond_2

    .line 1763
    invoke-interface {v0, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Landroidx/fragment/app/Fragment;

    .line 1764
    .local v4, "fragment":Landroidx/fragment/app/Fragment;
    if-eqz v4, :cond_1

    .line 1765
    invoke-virtual {v4}, Landroidx/fragment/app/Fragment;->isResumed()Z

    move-result v5

    if-eqz v5, :cond_1

    .line 1766
    invoke-virtual {v4}, Landroidx/fragment/app/Fragment;->isVisible()Z

    move-result v5

    if-eqz v5, :cond_1

    .line 1767
    invoke-virtual {v4}, Landroidx/fragment/app/Fragment;->getUserVisibleHint()Z

    move-result v5

    if-eqz v5, :cond_1

    instance-of v5, v4, Lcom/blankj/utilcode/util/FragmentUtils$OnBackClickListener;

    if-eqz v5, :cond_1

    move-object v5, v4

    check-cast v5, Lcom/blankj/utilcode/util/FragmentUtils$OnBackClickListener;

    .line 1769
    invoke-interface {v5}, Lcom/blankj/utilcode/util/FragmentUtils$OnBackClickListener;->onBackClick()Z

    move-result v5

    if-eqz v5, :cond_1

    .line 1770
    return v3

    .line 1762
    .end local v4    # "fragment":Landroidx/fragment/app/Fragment;
    :cond_1
    add-int/lit8 v2, v2, -0x1

    goto :goto_0

    .line 1773
    .end local v2    # "i":I
    :cond_2
    return v1

    .line 1761
    :cond_3
    :goto_1
    return v1
.end method

.method public static findFragment(Landroidx/fragment/app/FragmentManager;Ljava/lang/Class;)Landroidx/fragment/app/Fragment;
    .locals 1
    .param p0, "fm"    # Landroidx/fragment/app/FragmentManager;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroidx/fragment/app/FragmentManager;",
            "Ljava/lang/Class<",
            "+",
            "Landroidx/fragment/app/Fragment;",
            ">;)",
            "Landroidx/fragment/app/Fragment;"
        }
    .end annotation

    .line 1724
    .local p1, "findClz":Ljava/lang/Class;, "Ljava/lang/Class<+Landroidx/fragment/app/Fragment;>;"
    invoke-virtual {p1}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Landroidx/fragment/app/FragmentManager;->findFragmentByTag(Ljava/lang/String;)Landroidx/fragment/app/Fragment;

    move-result-object v0

    return-object v0
.end method

.method public static findFragment(Landroidx/fragment/app/FragmentManager;Ljava/lang/String;)Landroidx/fragment/app/Fragment;
    .locals 1
    .param p0, "fm"    # Landroidx/fragment/app/FragmentManager;
    .param p1, "tag"    # Ljava/lang/String;

    .line 1736
    invoke-virtual {p0, p1}, Landroidx/fragment/app/FragmentManager;->findFragmentByTag(Ljava/lang/String;)Landroidx/fragment/app/Fragment;

    move-result-object v0

    return-object v0
.end method

.method public static getAllFragments(Landroidx/fragment/app/FragmentManager;)Ljava/util/List;
    .locals 1
    .param p0, "fm"    # Landroidx/fragment/app/FragmentManager;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroidx/fragment/app/FragmentManager;",
            ")",
            "Ljava/util/List<",
            "Lcom/blankj/utilcode/util/FragmentUtils$FragmentNode;",
            ">;"
        }
    .end annotation

    .line 1671
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    invoke-static {p0, v0}, Lcom/blankj/utilcode/util/FragmentUtils;->getAllFragments(Landroidx/fragment/app/FragmentManager;Ljava/util/List;)Ljava/util/List;

    move-result-object v0

    return-object v0
.end method

.method private static getAllFragments(Landroidx/fragment/app/FragmentManager;Ljava/util/List;)Ljava/util/List;
    .locals 6
    .param p0, "fm"    # Landroidx/fragment/app/FragmentManager;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroidx/fragment/app/FragmentManager;",
            "Ljava/util/List<",
            "Lcom/blankj/utilcode/util/FragmentUtils$FragmentNode;",
            ">;)",
            "Ljava/util/List<",
            "Lcom/blankj/utilcode/util/FragmentUtils$FragmentNode;",
            ">;"
        }
    .end annotation

    .line 1676
    .local p1, "result":Ljava/util/List;, "Ljava/util/List<Lcom/blankj/utilcode/util/FragmentUtils$FragmentNode;>;"
    invoke-static {p0}, Lcom/blankj/utilcode/util/FragmentUtils;->getFragments(Landroidx/fragment/app/FragmentManager;)Ljava/util/List;

    move-result-object v0

    .line 1677
    .local v0, "fragments":Ljava/util/List;, "Ljava/util/List<Landroidx/fragment/app/Fragment;>;"
    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v1

    add-int/lit8 v1, v1, -0x1

    .local v1, "i":I
    :goto_0
    if-ltz v1, :cond_1

    .line 1678
    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Landroidx/fragment/app/Fragment;

    .line 1679
    .local v2, "fragment":Landroidx/fragment/app/Fragment;
    if-eqz v2, :cond_0

    .line 1680
    new-instance v3, Lcom/blankj/utilcode/util/FragmentUtils$FragmentNode;

    .line 1681
    invoke-virtual {v2}, Landroidx/fragment/app/Fragment;->getChildFragmentManager()Landroidx/fragment/app/FragmentManager;

    move-result-object v4

    new-instance v5, Ljava/util/ArrayList;

    invoke-direct {v5}, Ljava/util/ArrayList;-><init>()V

    invoke-static {v4, v5}, Lcom/blankj/utilcode/util/FragmentUtils;->getAllFragments(Landroidx/fragment/app/FragmentManager;Ljava/util/List;)Ljava/util/List;

    move-result-object v4

    invoke-direct {v3, v2, v4}, Lcom/blankj/utilcode/util/FragmentUtils$FragmentNode;-><init>(Landroidx/fragment/app/Fragment;Ljava/util/List;)V

    .line 1680
    invoke-interface {p1, v3}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 1677
    .end local v2    # "fragment":Landroidx/fragment/app/Fragment;
    :cond_0
    add-int/lit8 v1, v1, -0x1

    goto :goto_0

    .line 1685
    .end local v1    # "i":I
    :cond_1
    return-object p1
.end method

.method public static getAllFragmentsInStack(Landroidx/fragment/app/FragmentManager;)Ljava/util/List;
    .locals 1
    .param p0, "fm"    # Landroidx/fragment/app/FragmentManager;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroidx/fragment/app/FragmentManager;",
            ")",
            "Ljava/util/List<",
            "Lcom/blankj/utilcode/util/FragmentUtils$FragmentNode;",
            ">;"
        }
    .end annotation

    .line 1695
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    invoke-static {p0, v0}, Lcom/blankj/utilcode/util/FragmentUtils;->getAllFragmentsInStack(Landroidx/fragment/app/FragmentManager;Ljava/util/List;)Ljava/util/List;

    move-result-object v0

    return-object v0
.end method

.method private static getAllFragmentsInStack(Landroidx/fragment/app/FragmentManager;Ljava/util/List;)Ljava/util/List;
    .locals 7
    .param p0, "fm"    # Landroidx/fragment/app/FragmentManager;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroidx/fragment/app/FragmentManager;",
            "Ljava/util/List<",
            "Lcom/blankj/utilcode/util/FragmentUtils$FragmentNode;",
            ">;)",
            "Ljava/util/List<",
            "Lcom/blankj/utilcode/util/FragmentUtils$FragmentNode;",
            ">;"
        }
    .end annotation

    .line 1700
    .local p1, "result":Ljava/util/List;, "Ljava/util/List<Lcom/blankj/utilcode/util/FragmentUtils$FragmentNode;>;"
    invoke-static {p0}, Lcom/blankj/utilcode/util/FragmentUtils;->getFragments(Landroidx/fragment/app/FragmentManager;)Ljava/util/List;

    move-result-object v0

    .line 1701
    .local v0, "fragments":Ljava/util/List;, "Ljava/util/List<Landroidx/fragment/app/Fragment;>;"
    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v1

    add-int/lit8 v1, v1, -0x1

    .local v1, "i":I
    :goto_0
    if-ltz v1, :cond_1

    .line 1702
    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Landroidx/fragment/app/Fragment;

    .line 1703
    .local v2, "fragment":Landroidx/fragment/app/Fragment;
    if-eqz v2, :cond_0

    .line 1704
    invoke-virtual {v2}, Landroidx/fragment/app/Fragment;->getArguments()Landroid/os/Bundle;

    move-result-object v3

    .line 1705
    .local v3, "args":Landroid/os/Bundle;
    if-eqz v3, :cond_0

    const-string v4, "args_is_add_stack"

    invoke-virtual {v3, v4}, Landroid/os/Bundle;->getBoolean(Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_0

    .line 1706
    new-instance v4, Lcom/blankj/utilcode/util/FragmentUtils$FragmentNode;

    .line 1707
    invoke-virtual {v2}, Landroidx/fragment/app/Fragment;->getChildFragmentManager()Landroidx/fragment/app/FragmentManager;

    move-result-object v5

    new-instance v6, Ljava/util/ArrayList;

    invoke-direct {v6}, Ljava/util/ArrayList;-><init>()V

    invoke-static {v5, v6}, Lcom/blankj/utilcode/util/FragmentUtils;->getAllFragmentsInStack(Landroidx/fragment/app/FragmentManager;Ljava/util/List;)Ljava/util/List;

    move-result-object v5

    invoke-direct {v4, v2, v5}, Lcom/blankj/utilcode/util/FragmentUtils$FragmentNode;-><init>(Landroidx/fragment/app/Fragment;Ljava/util/List;)V

    .line 1706
    invoke-interface {p1, v4}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 1701
    .end local v2    # "fragment":Landroidx/fragment/app/Fragment;
    .end local v3    # "args":Landroid/os/Bundle;
    :cond_0
    add-int/lit8 v1, v1, -0x1

    goto :goto_0

    .line 1712
    .end local v1    # "i":I
    :cond_1
    return-object p1
.end method

.method private static getArgs(Landroidx/fragment/app/Fragment;)Lcom/blankj/utilcode/util/FragmentUtils$Args;
    .locals 5
    .param p0, "fragment"    # Landroidx/fragment/app/Fragment;

    .line 1444
    invoke-virtual {p0}, Landroidx/fragment/app/Fragment;->getArguments()Landroid/os/Bundle;

    move-result-object v0

    .line 1445
    .local v0, "bundle":Landroid/os/Bundle;
    if-nez v0, :cond_0

    sget-object v0, Landroid/os/Bundle;->EMPTY:Landroid/os/Bundle;

    .line 1446
    :cond_0
    new-instance v1, Lcom/blankj/utilcode/util/FragmentUtils$Args;

    const-string v2, "args_id"

    invoke-virtual {p0}, Landroidx/fragment/app/Fragment;->getId()I

    move-result v3

    invoke-virtual {v0, v2, v3}, Landroid/os/Bundle;->getInt(Ljava/lang/String;I)I

    move-result v2

    .line 1447
    const-string v3, "args_is_hide"

    invoke-virtual {v0, v3}, Landroid/os/Bundle;->getBoolean(Ljava/lang/String;)Z

    move-result v3

    .line 1448
    const-string v4, "args_is_add_stack"

    invoke-virtual {v0, v4}, Landroid/os/Bundle;->getBoolean(Ljava/lang/String;)Z

    move-result v4

    invoke-direct {v1, v2, v3, v4}, Lcom/blankj/utilcode/util/FragmentUtils$Args;-><init>(IZZ)V

    .line 1446
    return-object v1
.end method

.method public static getFragments(Landroidx/fragment/app/FragmentManager;)Ljava/util/List;
    .locals 2
    .param p0, "fm"    # Landroidx/fragment/app/FragmentManager;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroidx/fragment/app/FragmentManager;",
            ")",
            "Ljava/util/List<",
            "Landroidx/fragment/app/Fragment;",
            ">;"
        }
    .end annotation

    .line 1639
    invoke-virtual {p0}, Landroidx/fragment/app/FragmentManager;->getFragments()Ljava/util/List;

    move-result-object v0

    .line 1640
    .local v0, "fragments":Ljava/util/List;, "Ljava/util/List<Landroidx/fragment/app/Fragment;>;"
    if-eqz v0, :cond_1

    invoke-interface {v0}, Ljava/util/List;->isEmpty()Z

    move-result v1

    if-eqz v1, :cond_0

    goto :goto_0

    .line 1641
    :cond_0
    return-object v0

    .line 1640
    :cond_1
    :goto_0
    invoke-static {}, Ljava/util/Collections;->emptyList()Ljava/util/List;

    move-result-object v1

    return-object v1
.end method

.method public static getFragmentsInStack(Landroidx/fragment/app/FragmentManager;)Ljava/util/List;
    .locals 6
    .param p0, "fm"    # Landroidx/fragment/app/FragmentManager;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroidx/fragment/app/FragmentManager;",
            ")",
            "Ljava/util/List<",
            "Landroidx/fragment/app/Fragment;",
            ">;"
        }
    .end annotation

    .line 1651
    invoke-static {p0}, Lcom/blankj/utilcode/util/FragmentUtils;->getFragments(Landroidx/fragment/app/FragmentManager;)Ljava/util/List;

    move-result-object v0

    .line 1652
    .local v0, "fragments":Ljava/util/List;, "Ljava/util/List<Landroidx/fragment/app/Fragment;>;"
    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    .line 1653
    .local v1, "result":Ljava/util/List;, "Ljava/util/List<Landroidx/fragment/app/Fragment;>;"
    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_1

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Landroidx/fragment/app/Fragment;

    .line 1654
    .local v3, "fragment":Landroidx/fragment/app/Fragment;
    if-eqz v3, :cond_0

    .line 1655
    invoke-virtual {v3}, Landroidx/fragment/app/Fragment;->getArguments()Landroid/os/Bundle;

    move-result-object v4

    .line 1656
    .local v4, "args":Landroid/os/Bundle;
    if-eqz v4, :cond_0

    const-string v5, "args_is_add_stack"

    invoke-virtual {v4, v5}, Landroid/os/Bundle;->getBoolean(Ljava/lang/String;)Z

    move-result v5

    if-eqz v5, :cond_0

    .line 1657
    invoke-interface {v1, v3}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 1660
    .end local v3    # "fragment":Landroidx/fragment/app/Fragment;
    .end local v4    # "args":Landroid/os/Bundle;
    :cond_0
    goto :goto_0

    .line 1661
    :cond_1
    return-object v1
.end method

.method public static getSimpleName(Landroidx/fragment/app/Fragment;)Ljava/lang/String;
    .locals 1
    .param p0, "fragment"    # Landroidx/fragment/app/Fragment;

    .line 1827
    if-nez p0, :cond_0

    const-string v0, "null"

    goto :goto_0

    :cond_0
    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v0

    :goto_0
    return-object v0
.end method

.method public static getTop(Landroidx/fragment/app/FragmentManager;)Landroidx/fragment/app/Fragment;
    .locals 2
    .param p0, "fm"    # Landroidx/fragment/app/FragmentManager;

    .line 1556
    const/4 v0, 0x0

    const/4 v1, 0x0

    invoke-static {p0, v0, v1}, Lcom/blankj/utilcode/util/FragmentUtils;->getTopIsInStack(Landroidx/fragment/app/FragmentManager;Landroidx/fragment/app/Fragment;Z)Landroidx/fragment/app/Fragment;

    move-result-object v0

    return-object v0
.end method

.method public static getTopInStack(Landroidx/fragment/app/FragmentManager;)Landroidx/fragment/app/Fragment;
    .locals 2
    .param p0, "fm"    # Landroidx/fragment/app/FragmentManager;

    .line 1566
    const/4 v0, 0x0

    const/4 v1, 0x1

    invoke-static {p0, v0, v1}, Lcom/blankj/utilcode/util/FragmentUtils;->getTopIsInStack(Landroidx/fragment/app/FragmentManager;Landroidx/fragment/app/Fragment;Z)Landroidx/fragment/app/Fragment;

    move-result-object v0

    return-object v0
.end method

.method private static getTopIsInStack(Landroidx/fragment/app/FragmentManager;Landroidx/fragment/app/Fragment;Z)Landroidx/fragment/app/Fragment;
    .locals 6
    .param p0, "fm"    # Landroidx/fragment/app/FragmentManager;
    .param p1, "parentFragment"    # Landroidx/fragment/app/Fragment;
    .param p2, "isInStack"    # Z

    .line 1572
    invoke-static {p0}, Lcom/blankj/utilcode/util/FragmentUtils;->getFragments(Landroidx/fragment/app/FragmentManager;)Ljava/util/List;

    move-result-object v0

    .line 1573
    .local v0, "fragments":Ljava/util/List;, "Ljava/util/List<Landroidx/fragment/app/Fragment;>;"
    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v1

    const/4 v2, 0x1

    sub-int/2addr v1, v2

    .local v1, "i":I
    :goto_0
    if-ltz v1, :cond_3

    .line 1574
    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Landroidx/fragment/app/Fragment;

    .line 1575
    .local v3, "fragment":Landroidx/fragment/app/Fragment;
    if-eqz v3, :cond_2

    .line 1576
    if-eqz p2, :cond_1

    .line 1577
    invoke-virtual {v3}, Landroidx/fragment/app/Fragment;->getArguments()Landroid/os/Bundle;

    move-result-object v4

    .line 1578
    .local v4, "args":Landroid/os/Bundle;
    if-eqz v4, :cond_0

    const-string v5, "args_is_add_stack"

    invoke-virtual {v4, v5}, Landroid/os/Bundle;->getBoolean(Ljava/lang/String;)Z

    move-result v5

    if-eqz v5, :cond_0

    .line 1579
    invoke-virtual {v3}, Landroidx/fragment/app/Fragment;->getChildFragmentManager()Landroidx/fragment/app/FragmentManager;

    move-result-object v5

    invoke-static {v5, v3, v2}, Lcom/blankj/utilcode/util/FragmentUtils;->getTopIsInStack(Landroidx/fragment/app/FragmentManager;Landroidx/fragment/app/Fragment;Z)Landroidx/fragment/app/Fragment;

    move-result-object v2

    return-object v2

    .line 1581
    .end local v4    # "args":Landroid/os/Bundle;
    :cond_0
    goto :goto_1

    .line 1582
    :cond_1
    invoke-virtual {v3}, Landroidx/fragment/app/Fragment;->getChildFragmentManager()Landroidx/fragment/app/FragmentManager;

    move-result-object v2

    const/4 v4, 0x0

    invoke-static {v2, v3, v4}, Lcom/blankj/utilcode/util/FragmentUtils;->getTopIsInStack(Landroidx/fragment/app/FragmentManager;Landroidx/fragment/app/Fragment;Z)Landroidx/fragment/app/Fragment;

    move-result-object v2

    return-object v2

    .line 1573
    .end local v3    # "fragment":Landroidx/fragment/app/Fragment;
    :cond_2
    :goto_1
    add-int/lit8 v1, v1, -0x1

    goto :goto_0

    .line 1586
    .end local v1    # "i":I
    :cond_3
    return-object p1
.end method

.method public static getTopShow(Landroidx/fragment/app/FragmentManager;)Landroidx/fragment/app/Fragment;
    .locals 2
    .param p0, "fm"    # Landroidx/fragment/app/FragmentManager;

    .line 1596
    const/4 v0, 0x0

    const/4 v1, 0x0

    invoke-static {p0, v0, v1}, Lcom/blankj/utilcode/util/FragmentUtils;->getTopShowIsInStack(Landroidx/fragment/app/FragmentManager;Landroidx/fragment/app/Fragment;Z)Landroidx/fragment/app/Fragment;

    move-result-object v0

    return-object v0
.end method

.method public static getTopShowInStack(Landroidx/fragment/app/FragmentManager;)Landroidx/fragment/app/Fragment;
    .locals 2
    .param p0, "fm"    # Landroidx/fragment/app/FragmentManager;

    .line 1606
    const/4 v0, 0x0

    const/4 v1, 0x1

    invoke-static {p0, v0, v1}, Lcom/blankj/utilcode/util/FragmentUtils;->getTopShowIsInStack(Landroidx/fragment/app/FragmentManager;Landroidx/fragment/app/Fragment;Z)Landroidx/fragment/app/Fragment;

    move-result-object v0

    return-object v0
.end method

.method private static getTopShowIsInStack(Landroidx/fragment/app/FragmentManager;Landroidx/fragment/app/Fragment;Z)Landroidx/fragment/app/Fragment;
    .locals 6
    .param p0, "fm"    # Landroidx/fragment/app/FragmentManager;
    .param p1, "parentFragment"    # Landroidx/fragment/app/Fragment;
    .param p2, "isInStack"    # Z

    .line 1612
    invoke-static {p0}, Lcom/blankj/utilcode/util/FragmentUtils;->getFragments(Landroidx/fragment/app/FragmentManager;)Ljava/util/List;

    move-result-object v0

    .line 1613
    .local v0, "fragments":Ljava/util/List;, "Ljava/util/List<Landroidx/fragment/app/Fragment;>;"
    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v1

    const/4 v2, 0x1

    sub-int/2addr v1, v2

    .local v1, "i":I
    :goto_0
    if-ltz v1, :cond_3

    .line 1614
    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Landroidx/fragment/app/Fragment;

    .line 1615
    .local v3, "fragment":Landroidx/fragment/app/Fragment;
    if-eqz v3, :cond_2

    .line 1616
    invoke-virtual {v3}, Landroidx/fragment/app/Fragment;->isResumed()Z

    move-result v4

    if-eqz v4, :cond_2

    .line 1617
    invoke-virtual {v3}, Landroidx/fragment/app/Fragment;->isVisible()Z

    move-result v4

    if-eqz v4, :cond_2

    .line 1618
    invoke-virtual {v3}, Landroidx/fragment/app/Fragment;->getUserVisibleHint()Z

    move-result v4

    if-eqz v4, :cond_2

    .line 1619
    if-eqz p2, :cond_1

    .line 1620
    invoke-virtual {v3}, Landroidx/fragment/app/Fragment;->getArguments()Landroid/os/Bundle;

    move-result-object v4

    .line 1621
    .local v4, "args":Landroid/os/Bundle;
    if-eqz v4, :cond_0

    const-string v5, "args_is_add_stack"

    invoke-virtual {v4, v5}, Landroid/os/Bundle;->getBoolean(Ljava/lang/String;)Z

    move-result v5

    if-eqz v5, :cond_0

    .line 1622
    invoke-virtual {v3}, Landroidx/fragment/app/Fragment;->getChildFragmentManager()Landroidx/fragment/app/FragmentManager;

    move-result-object v5

    invoke-static {v5, v3, v2}, Lcom/blankj/utilcode/util/FragmentUtils;->getTopShowIsInStack(Landroidx/fragment/app/FragmentManager;Landroidx/fragment/app/Fragment;Z)Landroidx/fragment/app/Fragment;

    move-result-object v2

    return-object v2

    .line 1624
    .end local v4    # "args":Landroid/os/Bundle;
    :cond_0
    goto :goto_1

    .line 1625
    :cond_1
    invoke-virtual {v3}, Landroidx/fragment/app/Fragment;->getChildFragmentManager()Landroidx/fragment/app/FragmentManager;

    move-result-object v2

    const/4 v4, 0x0

    invoke-static {v2, v3, v4}, Lcom/blankj/utilcode/util/FragmentUtils;->getTopShowIsInStack(Landroidx/fragment/app/FragmentManager;Landroidx/fragment/app/Fragment;Z)Landroidx/fragment/app/Fragment;

    move-result-object v2

    return-object v2

    .line 1613
    .end local v3    # "fragment":Landroidx/fragment/app/Fragment;
    :cond_2
    :goto_1
    add-int/lit8 v1, v1, -0x1

    goto :goto_0

    .line 1629
    .end local v1    # "i":I
    :cond_3
    return-object p1
.end method

.method public static hide(Landroidx/fragment/app/Fragment;)V
    .locals 4
    .param p0, "hide"    # Landroidx/fragment/app/Fragment;

    .line 526
    const/4 v0, 0x1

    invoke-static {p0, v0}, Lcom/blankj/utilcode/util/FragmentUtils;->putArgs(Landroidx/fragment/app/Fragment;Z)V

    .line 527
    invoke-virtual {p0}, Landroidx/fragment/app/Fragment;->getFragmentManager()Landroidx/fragment/app/FragmentManager;

    move-result-object v1

    new-array v0, v0, [Landroidx/fragment/app/Fragment;

    const/4 v2, 0x0

    aput-object p0, v0, v2

    const/4 v2, 0x4

    const/4 v3, 0x0

    invoke-static {v2, v1, v3, v0}, Lcom/blankj/utilcode/util/FragmentUtils;->operateNoAnim(ILandroidx/fragment/app/FragmentManager;Landroidx/fragment/app/Fragment;[Landroidx/fragment/app/Fragment;)V

    .line 528
    return-void
.end method

.method public static hide(Landroidx/fragment/app/FragmentManager;)V
    .locals 4
    .param p0, "fm"    # Landroidx/fragment/app/FragmentManager;

    .line 536
    invoke-static {p0}, Lcom/blankj/utilcode/util/FragmentUtils;->getFragments(Landroidx/fragment/app/FragmentManager;)Ljava/util/List;

    move-result-object v0

    .line 537
    .local v0, "fragments":Ljava/util/List;, "Ljava/util/List<Landroidx/fragment/app/Fragment;>;"
    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_0

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Landroidx/fragment/app/Fragment;

    .line 538
    .local v2, "hide":Landroidx/fragment/app/Fragment;
    const/4 v3, 0x1

    invoke-static {v2, v3}, Lcom/blankj/utilcode/util/FragmentUtils;->putArgs(Landroidx/fragment/app/Fragment;Z)V

    .line 539
    .end local v2    # "hide":Landroidx/fragment/app/Fragment;
    goto :goto_0

    .line 540
    :cond_0
    const/4 v1, 0x0

    new-array v1, v1, [Landroidx/fragment/app/Fragment;

    invoke-interface {v0, v1}, Ljava/util/List;->toArray([Ljava/lang/Object;)[Ljava/lang/Object;

    move-result-object v1

    check-cast v1, [Landroidx/fragment/app/Fragment;

    const/4 v2, 0x4

    const/4 v3, 0x0

    invoke-static {v2, p0, v3, v1}, Lcom/blankj/utilcode/util/FragmentUtils;->operateNoAnim(ILandroidx/fragment/app/FragmentManager;Landroidx/fragment/app/Fragment;[Landroidx/fragment/app/Fragment;)V

    .line 541
    return-void
.end method

.method private static varargs operate(ILandroidx/fragment/app/FragmentManager;Landroidx/fragment/app/FragmentTransaction;Landroidx/fragment/app/Fragment;[Landroidx/fragment/app/Fragment;)V
    .locals 10
    .param p0, "type"    # I
    .param p1, "fm"    # Landroidx/fragment/app/FragmentManager;
    .param p2, "ft"    # Landroidx/fragment/app/FragmentTransaction;
    .param p3, "src"    # Landroidx/fragment/app/Fragment;
    .param p4, "dest"    # [Landroidx/fragment/app/Fragment;

    .line 1464
    if-eqz p3, :cond_0

    invoke-virtual {p3}, Landroidx/fragment/app/Fragment;->isRemoving()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 1465
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p3}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " is isRemoving"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const-string v1, "FragmentUtils"

    invoke-static {v1, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 1466
    return-void

    .line 1470
    :cond_0
    const-string v0, "args_is_add_stack"

    const-string v1, "args_id"

    const-string v2, "args_tag"

    const/4 v3, 0x0

    sparse-switch p0, :sswitch_data_0

    goto/16 :goto_6

    .line 1518
    :sswitch_0
    array-length v0, p4

    add-int/lit8 v0, v0, -0x1

    .local v0, "i":I
    :goto_0
    if-ltz v0, :cond_e

    .line 1519
    aget-object v1, p4, v0

    .line 1520
    .local v1, "fragment":Landroidx/fragment/app/Fragment;
    aget-object v2, p4, v3

    if-ne v1, v2, :cond_1

    .line 1521
    if-eqz p3, :cond_e

    invoke-virtual {p2, v1}, Landroidx/fragment/app/FragmentTransaction;->remove(Landroidx/fragment/app/Fragment;)Landroidx/fragment/app/FragmentTransaction;

    goto/16 :goto_6

    .line 1524
    :cond_1
    invoke-virtual {p2, v1}, Landroidx/fragment/app/FragmentTransaction;->remove(Landroidx/fragment/app/Fragment;)Landroidx/fragment/app/FragmentTransaction;

    .line 1518
    .end local v1    # "fragment":Landroidx/fragment/app/Fragment;
    add-int/lit8 v0, v0, -0x1

    goto :goto_0

    .line 1511
    .end local v0    # "i":I
    :sswitch_1
    array-length v0, p4

    :goto_1
    if-ge v3, v0, :cond_3

    aget-object v1, p4, v3

    .line 1512
    .restart local v1    # "fragment":Landroidx/fragment/app/Fragment;
    if-eq v1, p3, :cond_2

    .line 1513
    invoke-virtual {p2, v1}, Landroidx/fragment/app/FragmentTransaction;->remove(Landroidx/fragment/app/Fragment;)Landroidx/fragment/app/FragmentTransaction;

    .line 1511
    .end local v1    # "fragment":Landroidx/fragment/app/Fragment;
    :cond_2
    add-int/lit8 v3, v3, 0x1

    goto :goto_1

    .line 1516
    :cond_3
    goto/16 :goto_6

    .line 1504
    :sswitch_2
    aget-object v4, p4, v3

    invoke-virtual {v4}, Landroidx/fragment/app/Fragment;->getArguments()Landroid/os/Bundle;

    move-result-object v4

    .line 1505
    .local v4, "args":Landroid/os/Bundle;
    if-nez v4, :cond_4

    return-void

    .line 1506
    :cond_4
    aget-object v5, p4, v3

    invoke-virtual {v5}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v2, v5}, Landroid/os/Bundle;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 1507
    .local v2, "name":Ljava/lang/String;
    invoke-virtual {v4, v1}, Landroid/os/Bundle;->getInt(Ljava/lang/String;)I

    move-result v1

    aget-object v3, p4, v3

    invoke-virtual {p2, v1, v3, v2}, Landroidx/fragment/app/FragmentTransaction;->replace(ILandroidx/fragment/app/Fragment;Ljava/lang/String;)Landroidx/fragment/app/FragmentTransaction;

    .line 1508
    invoke-virtual {v4, v0}, Landroid/os/Bundle;->getBoolean(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_e

    invoke-virtual {p2, v2}, Landroidx/fragment/app/FragmentTransaction;->addToBackStack(Ljava/lang/String;)Landroidx/fragment/app/FragmentTransaction;

    goto/16 :goto_6

    .line 1496
    .end local v2    # "name":Ljava/lang/String;
    .end local v4    # "args":Landroid/os/Bundle;
    :sswitch_3
    invoke-virtual {p2, p3}, Landroidx/fragment/app/FragmentTransaction;->show(Landroidx/fragment/app/Fragment;)Landroidx/fragment/app/FragmentTransaction;

    .line 1497
    array-length v0, p4

    :goto_2
    if-ge v3, v0, :cond_6

    aget-object v1, p4, v3

    .line 1498
    .restart local v1    # "fragment":Landroidx/fragment/app/Fragment;
    if-eq v1, p3, :cond_5

    .line 1499
    invoke-virtual {p2, v1}, Landroidx/fragment/app/FragmentTransaction;->hide(Landroidx/fragment/app/Fragment;)Landroidx/fragment/app/FragmentTransaction;

    .line 1497
    .end local v1    # "fragment":Landroidx/fragment/app/Fragment;
    :cond_5
    add-int/lit8 v3, v3, 0x1

    goto :goto_2

    .line 1502
    :cond_6
    goto :goto_6

    .line 1486
    :sswitch_4
    array-length v0, p4

    :goto_3
    if-ge v3, v0, :cond_7

    aget-object v1, p4, v3

    .line 1487
    .restart local v1    # "fragment":Landroidx/fragment/app/Fragment;
    invoke-virtual {p2, v1}, Landroidx/fragment/app/FragmentTransaction;->hide(Landroidx/fragment/app/Fragment;)Landroidx/fragment/app/FragmentTransaction;

    .line 1486
    .end local v1    # "fragment":Landroidx/fragment/app/Fragment;
    add-int/lit8 v3, v3, 0x1

    goto :goto_3

    .line 1489
    :cond_7
    goto :goto_6

    .line 1491
    :sswitch_5
    array-length v0, p4

    :goto_4
    if-ge v3, v0, :cond_8

    aget-object v1, p4, v3

    .line 1492
    .restart local v1    # "fragment":Landroidx/fragment/app/Fragment;
    invoke-virtual {p2, v1}, Landroidx/fragment/app/FragmentTransaction;->show(Landroidx/fragment/app/Fragment;)Landroidx/fragment/app/FragmentTransaction;

    .line 1491
    .end local v1    # "fragment":Landroidx/fragment/app/Fragment;
    add-int/lit8 v3, v3, 0x1

    goto :goto_4

    .line 1494
    :cond_8
    goto :goto_6

    .line 1472
    :sswitch_6
    array-length v4, p4

    :goto_5
    if-ge v3, v4, :cond_d

    aget-object v5, p4, v3

    .line 1473
    .local v5, "fragment":Landroidx/fragment/app/Fragment;
    invoke-virtual {v5}, Landroidx/fragment/app/Fragment;->getArguments()Landroid/os/Bundle;

    move-result-object v6

    .line 1474
    .local v6, "args":Landroid/os/Bundle;
    if-nez v6, :cond_9

    return-void

    .line 1475
    :cond_9
    invoke-virtual {v5}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v2, v7}, Landroid/os/Bundle;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    .line 1476
    .local v7, "name":Ljava/lang/String;
    invoke-virtual {p1, v7}, Landroidx/fragment/app/FragmentManager;->findFragmentByTag(Ljava/lang/String;)Landroidx/fragment/app/Fragment;

    move-result-object v8

    .line 1477
    .local v8, "fragmentByTag":Landroidx/fragment/app/Fragment;
    if-eqz v8, :cond_a

    invoke-virtual {v8}, Landroidx/fragment/app/Fragment;->isAdded()Z

    move-result v9

    if-eqz v9, :cond_a

    .line 1478
    invoke-virtual {p2, v8}, Landroidx/fragment/app/FragmentTransaction;->remove(Landroidx/fragment/app/Fragment;)Landroidx/fragment/app/FragmentTransaction;

    .line 1480
    :cond_a
    invoke-virtual {v6, v1}, Landroid/os/Bundle;->getInt(Ljava/lang/String;)I

    move-result v9

    invoke-virtual {p2, v9, v5, v7}, Landroidx/fragment/app/FragmentTransaction;->add(ILandroidx/fragment/app/Fragment;Ljava/lang/String;)Landroidx/fragment/app/FragmentTransaction;

    .line 1481
    const-string v9, "args_is_hide"

    invoke-virtual {v6, v9}, Landroid/os/Bundle;->getBoolean(Ljava/lang/String;)Z

    move-result v9

    if-eqz v9, :cond_b

    invoke-virtual {p2, v5}, Landroidx/fragment/app/FragmentTransaction;->hide(Landroidx/fragment/app/Fragment;)Landroidx/fragment/app/FragmentTransaction;

    .line 1482
    :cond_b
    invoke-virtual {v6, v0}, Landroid/os/Bundle;->getBoolean(Ljava/lang/String;)Z

    move-result v9

    if-eqz v9, :cond_c

    invoke-virtual {p2, v7}, Landroidx/fragment/app/FragmentTransaction;->addToBackStack(Ljava/lang/String;)Landroidx/fragment/app/FragmentTransaction;

    .line 1472
    .end local v5    # "fragment":Landroidx/fragment/app/Fragment;
    .end local v8    # "fragmentByTag":Landroidx/fragment/app/Fragment;
    :cond_c
    add-int/lit8 v3, v3, 0x1

    goto :goto_5

    .line 1484
    .end local v6    # "args":Landroid/os/Bundle;
    .end local v7    # "name":Ljava/lang/String;
    :cond_d
    nop

    .line 1528
    :cond_e
    :goto_6
    invoke-virtual {p2}, Landroidx/fragment/app/FragmentTransaction;->commitAllowingStateLoss()I

    .line 1529
    invoke-virtual {p1}, Landroidx/fragment/app/FragmentManager;->executePendingTransactions()Z

    .line 1530
    return-void

    nop

    :sswitch_data_0
    .sparse-switch
        0x1 -> :sswitch_6
        0x2 -> :sswitch_5
        0x4 -> :sswitch_4
        0x8 -> :sswitch_3
        0x10 -> :sswitch_2
        0x20 -> :sswitch_1
        0x40 -> :sswitch_0
    .end sparse-switch
.end method

.method private static varargs operateNoAnim(ILandroidx/fragment/app/FragmentManager;Landroidx/fragment/app/Fragment;[Landroidx/fragment/app/Fragment;)V
    .locals 1
    .param p0, "type"    # I
    .param p1, "fm"    # Landroidx/fragment/app/FragmentManager;
    .param p2, "src"    # Landroidx/fragment/app/Fragment;
    .param p3, "dest"    # [Landroidx/fragment/app/Fragment;

    .line 1454
    if-nez p1, :cond_0

    return-void

    .line 1455
    :cond_0
    invoke-virtual {p1}, Landroidx/fragment/app/FragmentManager;->beginTransaction()Landroidx/fragment/app/FragmentTransaction;

    move-result-object v0

    .line 1456
    .local v0, "ft":Landroidx/fragment/app/FragmentTransaction;
    invoke-static {p0, p1, v0, p2, p3}, Lcom/blankj/utilcode/util/FragmentUtils;->operate(ILandroidx/fragment/app/FragmentManager;Landroidx/fragment/app/FragmentTransaction;Landroidx/fragment/app/Fragment;[Landroidx/fragment/app/Fragment;)V

    .line 1457
    return-void
.end method

.method public static pop(Landroidx/fragment/app/FragmentManager;)V
    .locals 1
    .param p0, "fm"    # Landroidx/fragment/app/FragmentManager;

    .line 1316
    const/4 v0, 0x1

    invoke-static {p0, v0}, Lcom/blankj/utilcode/util/FragmentUtils;->pop(Landroidx/fragment/app/FragmentManager;Z)V

    .line 1317
    return-void
.end method

.method public static pop(Landroidx/fragment/app/FragmentManager;Z)V
    .locals 0
    .param p0, "fm"    # Landroidx/fragment/app/FragmentManager;
    .param p1, "isImmediate"    # Z

    .line 1327
    if-eqz p1, :cond_0

    .line 1328
    invoke-virtual {p0}, Landroidx/fragment/app/FragmentManager;->popBackStackImmediate()Z

    goto :goto_0

    .line 1330
    :cond_0
    invoke-virtual {p0}, Landroidx/fragment/app/FragmentManager;->popBackStack()V

    .line 1332
    :goto_0
    return-void
.end method

.method public static popAll(Landroidx/fragment/app/FragmentManager;)V
    .locals 1
    .param p0, "fm"    # Landroidx/fragment/app/FragmentManager;

    .line 1374
    const/4 v0, 0x1

    invoke-static {p0, v0}, Lcom/blankj/utilcode/util/FragmentUtils;->popAll(Landroidx/fragment/app/FragmentManager;Z)V

    .line 1375
    return-void
.end method

.method public static popAll(Landroidx/fragment/app/FragmentManager;Z)V
    .locals 3
    .param p0, "fm"    # Landroidx/fragment/app/FragmentManager;
    .param p1, "isImmediate"    # Z

    .line 1383
    invoke-virtual {p0}, Landroidx/fragment/app/FragmentManager;->getBackStackEntryCount()I

    move-result v0

    if-lez v0, :cond_1

    .line 1384
    const/4 v0, 0x0

    invoke-virtual {p0, v0}, Landroidx/fragment/app/FragmentManager;->getBackStackEntryAt(I)Landroidx/fragment/app/FragmentManager$BackStackEntry;

    move-result-object v0

    .line 1385
    .local v0, "entry":Landroidx/fragment/app/FragmentManager$BackStackEntry;
    const/4 v1, 0x1

    if-eqz p1, :cond_0

    .line 1386
    invoke-interface {v0}, Landroidx/fragment/app/FragmentManager$BackStackEntry;->getId()I

    move-result v2

    invoke-virtual {p0, v2, v1}, Landroidx/fragment/app/FragmentManager;->popBackStackImmediate(II)Z

    goto :goto_0

    .line 1388
    :cond_0
    invoke-interface {v0}, Landroidx/fragment/app/FragmentManager$BackStackEntry;->getId()I

    move-result v2

    invoke-virtual {p0, v2, v1}, Landroidx/fragment/app/FragmentManager;->popBackStack(II)V

    .line 1391
    .end local v0    # "entry":Landroidx/fragment/app/FragmentManager$BackStackEntry;
    :cond_1
    :goto_0
    return-void
.end method

.method public static popTo(Landroidx/fragment/app/FragmentManager;Ljava/lang/Class;Z)V
    .locals 1
    .param p0, "fm"    # Landroidx/fragment/app/FragmentManager;
    .param p2, "isIncludeSelf"    # Z
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroidx/fragment/app/FragmentManager;",
            "Ljava/lang/Class<",
            "+",
            "Landroidx/fragment/app/Fragment;",
            ">;Z)V"
        }
    .end annotation

    .line 1344
    .local p1, "popClz":Ljava/lang/Class;, "Ljava/lang/Class<+Landroidx/fragment/app/Fragment;>;"
    const/4 v0, 0x1

    invoke-static {p0, p1, p2, v0}, Lcom/blankj/utilcode/util/FragmentUtils;->popTo(Landroidx/fragment/app/FragmentManager;Ljava/lang/Class;ZZ)V

    .line 1345
    return-void
.end method

.method public static popTo(Landroidx/fragment/app/FragmentManager;Ljava/lang/Class;ZZ)V
    .locals 1
    .param p0, "fm"    # Landroidx/fragment/app/FragmentManager;
    .param p2, "isIncludeSelf"    # Z
    .param p3, "isImmediate"    # Z
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroidx/fragment/app/FragmentManager;",
            "Ljava/lang/Class<",
            "+",
            "Landroidx/fragment/app/Fragment;",
            ">;ZZ)V"
        }
    .end annotation

    .line 1359
    .local p1, "popClz":Ljava/lang/Class;, "Ljava/lang/Class<+Landroidx/fragment/app/Fragment;>;"
    if-eqz p3, :cond_0

    .line 1360
    invoke-virtual {p1}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0, p2}, Landroidx/fragment/app/FragmentManager;->popBackStackImmediate(Ljava/lang/String;I)Z

    goto :goto_0

    .line 1363
    :cond_0
    invoke-virtual {p1}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0, p2}, Landroidx/fragment/app/FragmentManager;->popBackStack(Ljava/lang/String;I)V

    .line 1366
    :goto_0
    return-void
.end method

.method private static putArgs(Landroidx/fragment/app/Fragment;Lcom/blankj/utilcode/util/FragmentUtils$Args;)V
    .locals 3
    .param p0, "fragment"    # Landroidx/fragment/app/Fragment;
    .param p1, "args"    # Lcom/blankj/utilcode/util/FragmentUtils$Args;

    .line 1423
    invoke-virtual {p0}, Landroidx/fragment/app/Fragment;->getArguments()Landroid/os/Bundle;

    move-result-object v0

    .line 1424
    .local v0, "bundle":Landroid/os/Bundle;
    if-nez v0, :cond_0

    .line 1425
    new-instance v1, Landroid/os/Bundle;

    invoke-direct {v1}, Landroid/os/Bundle;-><init>()V

    move-object v0, v1

    .line 1426
    invoke-virtual {p0, v0}, Landroidx/fragment/app/Fragment;->setArguments(Landroid/os/Bundle;)V

    .line 1428
    :cond_0
    const-string v1, "args_id"

    iget v2, p1, Lcom/blankj/utilcode/util/FragmentUtils$Args;->id:I

    invoke-virtual {v0, v1, v2}, Landroid/os/Bundle;->putInt(Ljava/lang/String;I)V

    .line 1429
    const-string v1, "args_is_hide"

    iget-boolean v2, p1, Lcom/blankj/utilcode/util/FragmentUtils$Args;->isHide:Z

    invoke-virtual {v0, v1, v2}, Landroid/os/Bundle;->putBoolean(Ljava/lang/String;Z)V

    .line 1430
    const-string v1, "args_is_add_stack"

    iget-boolean v2, p1, Lcom/blankj/utilcode/util/FragmentUtils$Args;->isAddStack:Z

    invoke-virtual {v0, v1, v2}, Landroid/os/Bundle;->putBoolean(Ljava/lang/String;Z)V

    .line 1431
    const-string v1, "args_tag"

    iget-object v2, p1, Lcom/blankj/utilcode/util/FragmentUtils$Args;->tag:Ljava/lang/String;

    invoke-virtual {v0, v1, v2}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    .line 1432
    return-void
.end method

.method private static putArgs(Landroidx/fragment/app/Fragment;Z)V
    .locals 2
    .param p0, "fragment"    # Landroidx/fragment/app/Fragment;
    .param p1, "isHide"    # Z

    .line 1435
    invoke-virtual {p0}, Landroidx/fragment/app/Fragment;->getArguments()Landroid/os/Bundle;

    move-result-object v0

    .line 1436
    .local v0, "bundle":Landroid/os/Bundle;
    if-nez v0, :cond_0

    .line 1437
    new-instance v1, Landroid/os/Bundle;

    invoke-direct {v1}, Landroid/os/Bundle;-><init>()V

    move-object v0, v1

    .line 1438
    invoke-virtual {p0, v0}, Landroidx/fragment/app/Fragment;->setArguments(Landroid/os/Bundle;)V

    .line 1440
    :cond_0
    const-string v1, "args_is_hide"

    invoke-virtual {v0, v1, p1}, Landroid/os/Bundle;->putBoolean(Ljava/lang/String;Z)V

    .line 1441
    return-void
.end method

.method public static remove(Landroidx/fragment/app/Fragment;)V
    .locals 4
    .param p0, "remove"    # Landroidx/fragment/app/Fragment;

    .line 1399
    invoke-virtual {p0}, Landroidx/fragment/app/Fragment;->getFragmentManager()Landroidx/fragment/app/FragmentManager;

    move-result-object v0

    const/4 v1, 0x1

    new-array v1, v1, [Landroidx/fragment/app/Fragment;

    const/4 v2, 0x0

    aput-object p0, v1, v2

    const/16 v2, 0x20

    const/4 v3, 0x0

    invoke-static {v2, v0, v3, v1}, Lcom/blankj/utilcode/util/FragmentUtils;->operateNoAnim(ILandroidx/fragment/app/FragmentManager;Landroidx/fragment/app/Fragment;[Landroidx/fragment/app/Fragment;)V

    .line 1400
    return-void
.end method

.method public static removeAll(Landroidx/fragment/app/FragmentManager;)V
    .locals 4
    .param p0, "fm"    # Landroidx/fragment/app/FragmentManager;

    .line 1418
    invoke-static {p0}, Lcom/blankj/utilcode/util/FragmentUtils;->getFragments(Landroidx/fragment/app/FragmentManager;)Ljava/util/List;

    move-result-object v0

    .line 1419
    .local v0, "fragments":Ljava/util/List;, "Ljava/util/List<Landroidx/fragment/app/Fragment;>;"
    const/4 v1, 0x0

    new-array v1, v1, [Landroidx/fragment/app/Fragment;

    invoke-interface {v0, v1}, Ljava/util/List;->toArray([Ljava/lang/Object;)[Ljava/lang/Object;

    move-result-object v1

    check-cast v1, [Landroidx/fragment/app/Fragment;

    const/16 v2, 0x20

    const/4 v3, 0x0

    invoke-static {v2, p0, v3, v1}, Lcom/blankj/utilcode/util/FragmentUtils;->operateNoAnim(ILandroidx/fragment/app/FragmentManager;Landroidx/fragment/app/Fragment;[Landroidx/fragment/app/Fragment;)V

    .line 1420
    return-void
.end method

.method public static removeTo(Landroidx/fragment/app/Fragment;Z)V
    .locals 4
    .param p0, "removeTo"    # Landroidx/fragment/app/Fragment;
    .param p1, "isIncludeSelf"    # Z

    .line 1409
    invoke-virtual {p0}, Landroidx/fragment/app/Fragment;->getFragmentManager()Landroidx/fragment/app/FragmentManager;

    move-result-object v0

    if-eqz p1, :cond_0

    move-object v1, p0

    goto :goto_0

    :cond_0
    const/4 v1, 0x0

    :goto_0
    const/4 v2, 0x1

    new-array v2, v2, [Landroidx/fragment/app/Fragment;

    const/4 v3, 0x0

    aput-object p0, v2, v3

    const/16 v3, 0x40

    invoke-static {v3, v0, v1, v2}, Lcom/blankj/utilcode/util/FragmentUtils;->operateNoAnim(ILandroidx/fragment/app/FragmentManager;Landroidx/fragment/app/Fragment;[Landroidx/fragment/app/Fragment;)V

    .line 1410
    return-void
.end method

.method public static replace(Landroidx/fragment/app/Fragment;Landroidx/fragment/app/Fragment;)V
    .locals 2
    .param p0, "srcFragment"    # Landroidx/fragment/app/Fragment;
    .param p1, "destFragment"    # Landroidx/fragment/app/Fragment;

    .line 656
    const/4 v0, 0x0

    const/4 v1, 0x0

    invoke-static {p0, p1, v0, v1}, Lcom/blankj/utilcode/util/FragmentUtils;->replace(Landroidx/fragment/app/Fragment;Landroidx/fragment/app/Fragment;Ljava/lang/String;Z)V

    .line 657
    return-void
.end method

.method public static replace(Landroidx/fragment/app/Fragment;Landroidx/fragment/app/Fragment;II)V
    .locals 8
    .param p0, "srcFragment"    # Landroidx/fragment/app/Fragment;
    .param p1, "destFragment"    # Landroidx/fragment/app/Fragment;
    .param p2, "enterAnim"    # I
    .param p3, "exitAnim"    # I

    .line 686
    const/4 v6, 0x0

    const/4 v7, 0x0

    const/4 v2, 0x0

    const/4 v3, 0x0

    move-object v0, p0

    move-object v1, p1

    move v4, p2

    move v5, p3

    invoke-static/range {v0 .. v7}, Lcom/blankj/utilcode/util/FragmentUtils;->replace(Landroidx/fragment/app/Fragment;Landroidx/fragment/app/Fragment;Ljava/lang/String;ZIIII)V

    .line 687
    return-void
.end method

.method public static replace(Landroidx/fragment/app/Fragment;Landroidx/fragment/app/Fragment;IIII)V
    .locals 8
    .param p0, "srcFragment"    # Landroidx/fragment/app/Fragment;
    .param p1, "destFragment"    # Landroidx/fragment/app/Fragment;
    .param p2, "enterAnim"    # I
    .param p3, "exitAnim"    # I
    .param p4, "popEnterAnim"    # I
    .param p5, "popExitAnim"    # I

    .line 730
    const/4 v2, 0x0

    const/4 v3, 0x0

    move-object v0, p0

    move-object v1, p1

    move v4, p2

    move v5, p3

    move v6, p4

    move v7, p5

    invoke-static/range {v0 .. v7}, Lcom/blankj/utilcode/util/FragmentUtils;->replace(Landroidx/fragment/app/Fragment;Landroidx/fragment/app/Fragment;Ljava/lang/String;ZIIII)V

    .line 732
    return-void
.end method

.method public static replace(Landroidx/fragment/app/Fragment;Landroidx/fragment/app/Fragment;Ljava/lang/String;)V
    .locals 1
    .param p0, "srcFragment"    # Landroidx/fragment/app/Fragment;
    .param p1, "destFragment"    # Landroidx/fragment/app/Fragment;
    .param p2, "destTag"    # Ljava/lang/String;

    .line 962
    const/4 v0, 0x0

    invoke-static {p0, p1, p2, v0}, Lcom/blankj/utilcode/util/FragmentUtils;->replace(Landroidx/fragment/app/Fragment;Landroidx/fragment/app/Fragment;Ljava/lang/String;Z)V

    .line 963
    return-void
.end method

.method public static replace(Landroidx/fragment/app/Fragment;Landroidx/fragment/app/Fragment;Ljava/lang/String;II)V
    .locals 8
    .param p0, "srcFragment"    # Landroidx/fragment/app/Fragment;
    .param p1, "destFragment"    # Landroidx/fragment/app/Fragment;
    .param p2, "destTag"    # Ljava/lang/String;
    .param p3, "enterAnim"    # I
    .param p4, "exitAnim"    # I

    .line 999
    const/4 v6, 0x0

    const/4 v7, 0x0

    const/4 v3, 0x0

    move-object v0, p0

    move-object v1, p1

    move-object v2, p2

    move v4, p3

    move v5, p4

    invoke-static/range {v0 .. v7}, Lcom/blankj/utilcode/util/FragmentUtils;->replace(Landroidx/fragment/app/Fragment;Landroidx/fragment/app/Fragment;Ljava/lang/String;ZIIII)V

    .line 1000
    return-void
.end method

.method public static replace(Landroidx/fragment/app/Fragment;Landroidx/fragment/app/Fragment;Ljava/lang/String;IIII)V
    .locals 8
    .param p0, "srcFragment"    # Landroidx/fragment/app/Fragment;
    .param p1, "destFragment"    # Landroidx/fragment/app/Fragment;
    .param p2, "destTag"    # Ljava/lang/String;
    .param p3, "enterAnim"    # I
    .param p4, "exitAnim"    # I
    .param p5, "popEnterAnim"    # I
    .param p6, "popExitAnim"    # I

    .line 1047
    const/4 v3, 0x0

    move-object v0, p0

    move-object v1, p1

    move-object v2, p2

    move v4, p3

    move v5, p4

    move v6, p5

    move v7, p6

    invoke-static/range {v0 .. v7}, Lcom/blankj/utilcode/util/FragmentUtils;->replace(Landroidx/fragment/app/Fragment;Landroidx/fragment/app/Fragment;Ljava/lang/String;ZIIII)V

    .line 1049
    return-void
.end method

.method public static replace(Landroidx/fragment/app/Fragment;Landroidx/fragment/app/Fragment;Ljava/lang/String;Z)V
    .locals 3
    .param p0, "srcFragment"    # Landroidx/fragment/app/Fragment;
    .param p1, "destFragment"    # Landroidx/fragment/app/Fragment;
    .param p2, "destTag"    # Ljava/lang/String;
    .param p3, "isAddStack"    # Z

    .line 977
    invoke-virtual {p0}, Landroidx/fragment/app/Fragment;->getFragmentManager()Landroidx/fragment/app/FragmentManager;

    move-result-object v0

    .line 978
    .local v0, "fm":Landroidx/fragment/app/FragmentManager;
    if-nez v0, :cond_0

    return-void

    .line 979
    :cond_0
    invoke-static {p0}, Lcom/blankj/utilcode/util/FragmentUtils;->getArgs(Landroidx/fragment/app/Fragment;)Lcom/blankj/utilcode/util/FragmentUtils$Args;

    move-result-object v1

    .line 980
    .local v1, "args":Lcom/blankj/utilcode/util/FragmentUtils$Args;
    iget v2, v1, Lcom/blankj/utilcode/util/FragmentUtils$Args;->id:I

    invoke-static {v0, p1, v2, p2, p3}, Lcom/blankj/utilcode/util/FragmentUtils;->replace(Landroidx/fragment/app/FragmentManager;Landroidx/fragment/app/Fragment;ILjava/lang/String;Z)V

    .line 981
    return-void
.end method

.method public static replace(Landroidx/fragment/app/Fragment;Landroidx/fragment/app/Fragment;Ljava/lang/String;ZII)V
    .locals 8
    .param p0, "srcFragment"    # Landroidx/fragment/app/Fragment;
    .param p1, "destFragment"    # Landroidx/fragment/app/Fragment;
    .param p2, "destTag"    # Ljava/lang/String;
    .param p3, "isAddStack"    # Z
    .param p4, "enterAnim"    # I
    .param p5, "exitAnim"    # I

    .line 1020
    const/4 v6, 0x0

    const/4 v7, 0x0

    move-object v0, p0

    move-object v1, p1

    move-object v2, p2

    move v3, p3

    move v4, p4

    move v5, p5

    invoke-static/range {v0 .. v7}, Lcom/blankj/utilcode/util/FragmentUtils;->replace(Landroidx/fragment/app/Fragment;Landroidx/fragment/app/Fragment;Ljava/lang/String;ZIIII)V

    .line 1021
    return-void
.end method

.method public static replace(Landroidx/fragment/app/Fragment;Landroidx/fragment/app/Fragment;Ljava/lang/String;ZIIII)V
    .locals 11
    .param p0, "srcFragment"    # Landroidx/fragment/app/Fragment;
    .param p1, "destFragment"    # Landroidx/fragment/app/Fragment;
    .param p2, "destTag"    # Ljava/lang/String;
    .param p3, "isAddStack"    # Z
    .param p4, "enterAnim"    # I
    .param p5, "exitAnim"    # I
    .param p6, "popEnterAnim"    # I
    .param p7, "popExitAnim"    # I

    .line 1077
    invoke-virtual {p0}, Landroidx/fragment/app/Fragment;->getFragmentManager()Landroidx/fragment/app/FragmentManager;

    move-result-object v9

    .line 1078
    .local v9, "fm":Landroidx/fragment/app/FragmentManager;
    if-nez v9, :cond_0

    return-void

    .line 1079
    :cond_0
    invoke-static {p0}, Lcom/blankj/utilcode/util/FragmentUtils;->getArgs(Landroidx/fragment/app/Fragment;)Lcom/blankj/utilcode/util/FragmentUtils$Args;

    move-result-object v10

    .line 1080
    .local v10, "args":Lcom/blankj/utilcode/util/FragmentUtils$Args;
    iget v2, v10, Lcom/blankj/utilcode/util/FragmentUtils$Args;->id:I

    move-object v0, v9

    move-object v1, p1

    move-object v3, p2

    move v4, p3

    move v5, p4

    move/from16 v6, p5

    move/from16 v7, p6

    move/from16 v8, p7

    invoke-static/range {v0 .. v8}, Lcom/blankj/utilcode/util/FragmentUtils;->replace(Landroidx/fragment/app/FragmentManager;Landroidx/fragment/app/Fragment;ILjava/lang/String;ZIIII)V

    .line 1082
    return-void
.end method

.method public static varargs replace(Landroidx/fragment/app/Fragment;Landroidx/fragment/app/Fragment;Ljava/lang/String;Z[Landroid/view/View;)V
    .locals 8
    .param p0, "srcFragment"    # Landroidx/fragment/app/Fragment;
    .param p1, "destFragment"    # Landroidx/fragment/app/Fragment;
    .param p2, "destTag"    # Ljava/lang/String;
    .param p3, "isAddStack"    # Z
    .param p4, "sharedElements"    # [Landroid/view/View;

    .line 1115
    invoke-virtual {p0}, Landroidx/fragment/app/Fragment;->getFragmentManager()Landroidx/fragment/app/FragmentManager;

    move-result-object v6

    .line 1116
    .local v6, "fm":Landroidx/fragment/app/FragmentManager;
    if-nez v6, :cond_0

    return-void

    .line 1117
    :cond_0
    invoke-static {p0}, Lcom/blankj/utilcode/util/FragmentUtils;->getArgs(Landroidx/fragment/app/Fragment;)Lcom/blankj/utilcode/util/FragmentUtils$Args;

    move-result-object v7

    .line 1118
    .local v7, "args":Lcom/blankj/utilcode/util/FragmentUtils$Args;
    iget v2, v7, Lcom/blankj/utilcode/util/FragmentUtils$Args;->id:I

    move-object v0, v6

    move-object v1, p1

    move-object v3, p2

    move v4, p3

    move-object v5, p4

    invoke-static/range {v0 .. v5}, Lcom/blankj/utilcode/util/FragmentUtils;->replace(Landroidx/fragment/app/FragmentManager;Landroidx/fragment/app/Fragment;ILjava/lang/String;Z[Landroid/view/View;)V

    .line 1125
    return-void
.end method

.method public static varargs replace(Landroidx/fragment/app/Fragment;Landroidx/fragment/app/Fragment;Ljava/lang/String;[Landroid/view/View;)V
    .locals 1
    .param p0, "srcFragment"    # Landroidx/fragment/app/Fragment;
    .param p1, "destFragment"    # Landroidx/fragment/app/Fragment;
    .param p2, "destTag"    # Ljava/lang/String;
    .param p3, "sharedElements"    # [Landroid/view/View;

    .line 1097
    const/4 v0, 0x0

    invoke-static {p0, p1, p2, v0, p3}, Lcom/blankj/utilcode/util/FragmentUtils;->replace(Landroidx/fragment/app/Fragment;Landroidx/fragment/app/Fragment;Ljava/lang/String;Z[Landroid/view/View;)V

    .line 1098
    return-void
.end method

.method public static replace(Landroidx/fragment/app/Fragment;Landroidx/fragment/app/Fragment;Z)V
    .locals 1
    .param p0, "srcFragment"    # Landroidx/fragment/app/Fragment;
    .param p1, "destFragment"    # Landroidx/fragment/app/Fragment;
    .param p2, "isAddStack"    # Z

    .line 669
    const/4 v0, 0x0

    invoke-static {p0, p1, v0, p2}, Lcom/blankj/utilcode/util/FragmentUtils;->replace(Landroidx/fragment/app/Fragment;Landroidx/fragment/app/Fragment;Ljava/lang/String;Z)V

    .line 670
    return-void
.end method

.method public static replace(Landroidx/fragment/app/Fragment;Landroidx/fragment/app/Fragment;ZII)V
    .locals 8
    .param p0, "srcFragment"    # Landroidx/fragment/app/Fragment;
    .param p1, "destFragment"    # Landroidx/fragment/app/Fragment;
    .param p2, "isAddStack"    # Z
    .param p3, "enterAnim"    # I
    .param p4, "exitAnim"    # I

    .line 705
    const/4 v6, 0x0

    const/4 v7, 0x0

    const/4 v2, 0x0

    move-object v0, p0

    move-object v1, p1

    move v3, p2

    move v4, p3

    move v5, p4

    invoke-static/range {v0 .. v7}, Lcom/blankj/utilcode/util/FragmentUtils;->replace(Landroidx/fragment/app/Fragment;Landroidx/fragment/app/Fragment;Ljava/lang/String;ZIIII)V

    .line 706
    return-void
.end method

.method public static replace(Landroidx/fragment/app/Fragment;Landroidx/fragment/app/Fragment;ZIIII)V
    .locals 8
    .param p0, "srcFragment"    # Landroidx/fragment/app/Fragment;
    .param p1, "destFragment"    # Landroidx/fragment/app/Fragment;
    .param p2, "isAddStack"    # Z
    .param p3, "enterAnim"    # I
    .param p4, "exitAnim"    # I
    .param p5, "popEnterAnim"    # I
    .param p6, "popExitAnim"    # I

    .line 758
    const/4 v2, 0x0

    move-object v0, p0

    move-object v1, p1

    move v3, p2

    move v4, p3

    move v5, p4

    move v6, p5

    move v7, p6

    invoke-static/range {v0 .. v7}, Lcom/blankj/utilcode/util/FragmentUtils;->replace(Landroidx/fragment/app/Fragment;Landroidx/fragment/app/Fragment;Ljava/lang/String;ZIIII)V

    .line 760
    return-void
.end method

.method public static varargs replace(Landroidx/fragment/app/Fragment;Landroidx/fragment/app/Fragment;Z[Landroid/view/View;)V
    .locals 1
    .param p0, "srcFragment"    # Landroidx/fragment/app/Fragment;
    .param p1, "destFragment"    # Landroidx/fragment/app/Fragment;
    .param p2, "isAddStack"    # Z
    .param p3, "sharedElements"    # [Landroid/view/View;

    .line 789
    const/4 v0, 0x0

    invoke-static {p0, p1, v0, p2, p3}, Lcom/blankj/utilcode/util/FragmentUtils;->replace(Landroidx/fragment/app/Fragment;Landroidx/fragment/app/Fragment;Ljava/lang/String;Z[Landroid/view/View;)V

    .line 790
    return-void
.end method

.method public static varargs replace(Landroidx/fragment/app/Fragment;Landroidx/fragment/app/Fragment;[Landroid/view/View;)V
    .locals 2
    .param p0, "srcFragment"    # Landroidx/fragment/app/Fragment;
    .param p1, "destFragment"    # Landroidx/fragment/app/Fragment;
    .param p2, "sharedElements"    # [Landroid/view/View;

    .line 773
    const/4 v0, 0x0

    const/4 v1, 0x0

    invoke-static {p0, p1, v0, v1, p2}, Lcom/blankj/utilcode/util/FragmentUtils;->replace(Landroidx/fragment/app/Fragment;Landroidx/fragment/app/Fragment;Ljava/lang/String;Z[Landroid/view/View;)V

    .line 774
    return-void
.end method

.method public static replace(Landroidx/fragment/app/FragmentManager;Landroidx/fragment/app/Fragment;I)V
    .locals 2
    .param p0, "fm"    # Landroidx/fragment/app/FragmentManager;
    .param p1, "fragment"    # Landroidx/fragment/app/Fragment;
    .param p2, "containerId"    # I

    .line 802
    const/4 v0, 0x0

    const/4 v1, 0x0

    invoke-static {p0, p1, p2, v0, v1}, Lcom/blankj/utilcode/util/FragmentUtils;->replace(Landroidx/fragment/app/FragmentManager;Landroidx/fragment/app/Fragment;ILjava/lang/String;Z)V

    .line 803
    return-void
.end method

.method public static replace(Landroidx/fragment/app/FragmentManager;Landroidx/fragment/app/Fragment;III)V
    .locals 9
    .param p0, "fm"    # Landroidx/fragment/app/FragmentManager;
    .param p1, "fragment"    # Landroidx/fragment/app/Fragment;
    .param p2, "containerId"    # I
    .param p3, "enterAnim"    # I
    .param p4, "exitAnim"    # I

    .line 836
    const/4 v7, 0x0

    const/4 v8, 0x0

    const/4 v3, 0x0

    const/4 v4, 0x0

    move-object v0, p0

    move-object v1, p1

    move v2, p2

    move v5, p3

    move v6, p4

    invoke-static/range {v0 .. v8}, Lcom/blankj/utilcode/util/FragmentUtils;->replace(Landroidx/fragment/app/FragmentManager;Landroidx/fragment/app/Fragment;ILjava/lang/String;ZIIII)V

    .line 837
    return-void
.end method

.method public static replace(Landroidx/fragment/app/FragmentManager;Landroidx/fragment/app/Fragment;IIIII)V
    .locals 9
    .param p0, "fm"    # Landroidx/fragment/app/FragmentManager;
    .param p1, "fragment"    # Landroidx/fragment/app/Fragment;
    .param p2, "containerId"    # I
    .param p3, "enterAnim"    # I
    .param p4, "exitAnim"    # I
    .param p5, "popEnterAnim"    # I
    .param p6, "popExitAnim"    # I

    .line 884
    const/4 v3, 0x0

    const/4 v4, 0x0

    move-object v0, p0

    move-object v1, p1

    move v2, p2

    move v5, p3

    move v6, p4

    move v7, p5

    move v8, p6

    invoke-static/range {v0 .. v8}, Lcom/blankj/utilcode/util/FragmentUtils;->replace(Landroidx/fragment/app/FragmentManager;Landroidx/fragment/app/Fragment;ILjava/lang/String;ZIIII)V

    .line 886
    return-void
.end method

.method public static replace(Landroidx/fragment/app/FragmentManager;Landroidx/fragment/app/Fragment;ILjava/lang/String;)V
    .locals 1
    .param p0, "fm"    # Landroidx/fragment/app/FragmentManager;
    .param p1, "fragment"    # Landroidx/fragment/app/Fragment;
    .param p2, "containerId"    # I
    .param p3, "destTag"    # Ljava/lang/String;

    .line 1139
    const/4 v0, 0x0

    invoke-static {p0, p1, p2, p3, v0}, Lcom/blankj/utilcode/util/FragmentUtils;->replace(Landroidx/fragment/app/FragmentManager;Landroidx/fragment/app/Fragment;ILjava/lang/String;Z)V

    .line 1140
    return-void
.end method

.method public static replace(Landroidx/fragment/app/FragmentManager;Landroidx/fragment/app/Fragment;ILjava/lang/String;II)V
    .locals 9
    .param p0, "fm"    # Landroidx/fragment/app/FragmentManager;
    .param p1, "fragment"    # Landroidx/fragment/app/Fragment;
    .param p2, "containerId"    # I
    .param p3, "destTag"    # Ljava/lang/String;
    .param p4, "enterAnim"    # I
    .param p5, "exitAnim"    # I

    .line 1179
    const/4 v7, 0x0

    const/4 v8, 0x0

    const/4 v4, 0x0

    move-object v0, p0

    move-object v1, p1

    move v2, p2

    move-object v3, p3

    move v5, p4

    move v6, p5

    invoke-static/range {v0 .. v8}, Lcom/blankj/utilcode/util/FragmentUtils;->replace(Landroidx/fragment/app/FragmentManager;Landroidx/fragment/app/Fragment;ILjava/lang/String;ZIIII)V

    .line 1180
    return-void
.end method

.method public static replace(Landroidx/fragment/app/FragmentManager;Landroidx/fragment/app/Fragment;ILjava/lang/String;IIII)V
    .locals 9
    .param p0, "fm"    # Landroidx/fragment/app/FragmentManager;
    .param p1, "fragment"    # Landroidx/fragment/app/Fragment;
    .param p2, "containerId"    # I
    .param p3, "destTag"    # Ljava/lang/String;
    .param p4, "enterAnim"    # I
    .param p5, "exitAnim"    # I
    .param p6, "popEnterAnim"    # I
    .param p7, "popExitAnim"    # I

    .line 1231
    const/4 v4, 0x0

    move-object v0, p0

    move-object v1, p1

    move v2, p2

    move-object v3, p3

    move v5, p4

    move v6, p5

    move v7, p6

    move/from16 v8, p7

    invoke-static/range {v0 .. v8}, Lcom/blankj/utilcode/util/FragmentUtils;->replace(Landroidx/fragment/app/FragmentManager;Landroidx/fragment/app/Fragment;ILjava/lang/String;ZIIII)V

    .line 1233
    return-void
.end method

.method public static replace(Landroidx/fragment/app/FragmentManager;Landroidx/fragment/app/Fragment;ILjava/lang/String;Z)V
    .locals 4
    .param p0, "fm"    # Landroidx/fragment/app/FragmentManager;
    .param p1, "fragment"    # Landroidx/fragment/app/Fragment;
    .param p2, "containerId"    # I
    .param p3, "destTag"    # Ljava/lang/String;
    .param p4, "isAddStack"    # Z

    .line 1156
    invoke-virtual {p0}, Landroidx/fragment/app/FragmentManager;->beginTransaction()Landroidx/fragment/app/FragmentTransaction;

    move-result-object v0

    .line 1157
    .local v0, "ft":Landroidx/fragment/app/FragmentTransaction;
    new-instance v1, Lcom/blankj/utilcode/util/FragmentUtils$Args;

    const/4 v2, 0x0

    invoke-direct {v1, p2, p3, v2, p4}, Lcom/blankj/utilcode/util/FragmentUtils$Args;-><init>(ILjava/lang/String;ZZ)V

    invoke-static {p1, v1}, Lcom/blankj/utilcode/util/FragmentUtils;->putArgs(Landroidx/fragment/app/Fragment;Lcom/blankj/utilcode/util/FragmentUtils$Args;)V

    .line 1158
    const/4 v1, 0x1

    new-array v1, v1, [Landroidx/fragment/app/Fragment;

    aput-object p1, v1, v2

    const/16 v2, 0x10

    const/4 v3, 0x0

    invoke-static {v2, p0, v0, v3, v1}, Lcom/blankj/utilcode/util/FragmentUtils;->operate(ILandroidx/fragment/app/FragmentManager;Landroidx/fragment/app/FragmentTransaction;Landroidx/fragment/app/Fragment;[Landroidx/fragment/app/Fragment;)V

    .line 1159
    return-void
.end method

.method public static replace(Landroidx/fragment/app/FragmentManager;Landroidx/fragment/app/Fragment;ILjava/lang/String;ZII)V
    .locals 9
    .param p0, "fm"    # Landroidx/fragment/app/FragmentManager;
    .param p1, "fragment"    # Landroidx/fragment/app/Fragment;
    .param p2, "containerId"    # I
    .param p3, "destTag"    # Ljava/lang/String;
    .param p4, "isAddStack"    # Z
    .param p5, "enterAnim"    # I
    .param p6, "exitAnim"    # I

    .line 1202
    const/4 v7, 0x0

    const/4 v8, 0x0

    move-object v0, p0

    move-object v1, p1

    move v2, p2

    move-object v3, p3

    move v4, p4

    move v5, p5

    move v6, p6

    invoke-static/range {v0 .. v8}, Lcom/blankj/utilcode/util/FragmentUtils;->replace(Landroidx/fragment/app/FragmentManager;Landroidx/fragment/app/Fragment;ILjava/lang/String;ZIIII)V

    .line 1203
    return-void
.end method

.method public static replace(Landroidx/fragment/app/FragmentManager;Landroidx/fragment/app/Fragment;ILjava/lang/String;ZIIII)V
    .locals 4
    .param p0, "fm"    # Landroidx/fragment/app/FragmentManager;
    .param p1, "fragment"    # Landroidx/fragment/app/Fragment;
    .param p2, "containerId"    # I
    .param p3, "destTag"    # Ljava/lang/String;
    .param p4, "isAddStack"    # Z
    .param p5, "enterAnim"    # I
    .param p6, "exitAnim"    # I
    .param p7, "popEnterAnim"    # I
    .param p8, "popExitAnim"    # I

    .line 1263
    invoke-virtual {p0}, Landroidx/fragment/app/FragmentManager;->beginTransaction()Landroidx/fragment/app/FragmentTransaction;

    move-result-object v0

    .line 1264
    .local v0, "ft":Landroidx/fragment/app/FragmentTransaction;
    new-instance v1, Lcom/blankj/utilcode/util/FragmentUtils$Args;

    const/4 v2, 0x0

    invoke-direct {v1, p2, p3, v2, p4}, Lcom/blankj/utilcode/util/FragmentUtils$Args;-><init>(ILjava/lang/String;ZZ)V

    invoke-static {p1, v1}, Lcom/blankj/utilcode/util/FragmentUtils;->putArgs(Landroidx/fragment/app/Fragment;Lcom/blankj/utilcode/util/FragmentUtils$Args;)V

    .line 1265
    invoke-static {v0, p5, p6, p7, p8}, Lcom/blankj/utilcode/util/FragmentUtils;->addAnim(Landroidx/fragment/app/FragmentTransaction;IIII)V

    .line 1266
    const/4 v1, 0x1

    new-array v1, v1, [Landroidx/fragment/app/Fragment;

    aput-object p1, v1, v2

    const/16 v2, 0x10

    const/4 v3, 0x0

    invoke-static {v2, p0, v0, v3, v1}, Lcom/blankj/utilcode/util/FragmentUtils;->operate(ILandroidx/fragment/app/FragmentManager;Landroidx/fragment/app/FragmentTransaction;Landroidx/fragment/app/Fragment;[Landroidx/fragment/app/Fragment;)V

    .line 1267
    return-void
.end method

.method public static varargs replace(Landroidx/fragment/app/FragmentManager;Landroidx/fragment/app/Fragment;ILjava/lang/String;Z[Landroid/view/View;)V
    .locals 4
    .param p0, "fm"    # Landroidx/fragment/app/FragmentManager;
    .param p1, "fragment"    # Landroidx/fragment/app/Fragment;
    .param p2, "containerId"    # I
    .param p3, "destTag"    # Ljava/lang/String;
    .param p4, "isAddStack"    # Z
    .param p5, "sharedElements"    # [Landroid/view/View;

    .line 1304
    invoke-virtual {p0}, Landroidx/fragment/app/FragmentManager;->beginTransaction()Landroidx/fragment/app/FragmentTransaction;

    move-result-object v0

    .line 1305
    .local v0, "ft":Landroidx/fragment/app/FragmentTransaction;
    new-instance v1, Lcom/blankj/utilcode/util/FragmentUtils$Args;

    const/4 v2, 0x0

    invoke-direct {v1, p2, p3, v2, p4}, Lcom/blankj/utilcode/util/FragmentUtils$Args;-><init>(ILjava/lang/String;ZZ)V

    invoke-static {p1, v1}, Lcom/blankj/utilcode/util/FragmentUtils;->putArgs(Landroidx/fragment/app/Fragment;Lcom/blankj/utilcode/util/FragmentUtils$Args;)V

    .line 1306
    invoke-static {v0, p5}, Lcom/blankj/utilcode/util/FragmentUtils;->addSharedElement(Landroidx/fragment/app/FragmentTransaction;[Landroid/view/View;)V

    .line 1307
    const/4 v1, 0x1

    new-array v1, v1, [Landroidx/fragment/app/Fragment;

    aput-object p1, v1, v2

    const/16 v2, 0x10

    const/4 v3, 0x0

    invoke-static {v2, p0, v0, v3, v1}, Lcom/blankj/utilcode/util/FragmentUtils;->operate(ILandroidx/fragment/app/FragmentManager;Landroidx/fragment/app/FragmentTransaction;Landroidx/fragment/app/Fragment;[Landroidx/fragment/app/Fragment;)V

    .line 1308
    return-void
.end method

.method public static varargs replace(Landroidx/fragment/app/FragmentManager;Landroidx/fragment/app/Fragment;ILjava/lang/String;[Landroid/view/View;)V
    .locals 6
    .param p0, "fm"    # Landroidx/fragment/app/FragmentManager;
    .param p1, "fragment"    # Landroidx/fragment/app/Fragment;
    .param p2, "containerId"    # I
    .param p3, "destTag"    # Ljava/lang/String;
    .param p4, "sharedElements"    # [Landroid/view/View;

    .line 1284
    const/4 v4, 0x0

    move-object v0, p0

    move-object v1, p1

    move v2, p2

    move-object v3, p3

    move-object v5, p4

    invoke-static/range {v0 .. v5}, Lcom/blankj/utilcode/util/FragmentUtils;->replace(Landroidx/fragment/app/FragmentManager;Landroidx/fragment/app/Fragment;ILjava/lang/String;Z[Landroid/view/View;)V

    .line 1285
    return-void
.end method

.method public static replace(Landroidx/fragment/app/FragmentManager;Landroidx/fragment/app/Fragment;IZ)V
    .locals 1
    .param p0, "fm"    # Landroidx/fragment/app/FragmentManager;
    .param p1, "fragment"    # Landroidx/fragment/app/Fragment;
    .param p2, "containerId"    # I
    .param p3, "isAddStack"    # Z

    .line 817
    const/4 v0, 0x0

    invoke-static {p0, p1, p2, v0, p3}, Lcom/blankj/utilcode/util/FragmentUtils;->replace(Landroidx/fragment/app/FragmentManager;Landroidx/fragment/app/Fragment;ILjava/lang/String;Z)V

    .line 818
    return-void
.end method

.method public static replace(Landroidx/fragment/app/FragmentManager;Landroidx/fragment/app/Fragment;IZII)V
    .locals 9
    .param p0, "fm"    # Landroidx/fragment/app/FragmentManager;
    .param p1, "fragment"    # Landroidx/fragment/app/Fragment;
    .param p2, "containerId"    # I
    .param p3, "isAddStack"    # Z
    .param p4, "enterAnim"    # I
    .param p5, "exitAnim"    # I

    .line 857
    const/4 v7, 0x0

    const/4 v8, 0x0

    const/4 v3, 0x0

    move-object v0, p0

    move-object v1, p1

    move v2, p2

    move v4, p3

    move v5, p4

    move v6, p5

    invoke-static/range {v0 .. v8}, Lcom/blankj/utilcode/util/FragmentUtils;->replace(Landroidx/fragment/app/FragmentManager;Landroidx/fragment/app/Fragment;ILjava/lang/String;ZIIII)V

    .line 858
    return-void
.end method

.method public static replace(Landroidx/fragment/app/FragmentManager;Landroidx/fragment/app/Fragment;IZIIII)V
    .locals 9
    .param p0, "fm"    # Landroidx/fragment/app/FragmentManager;
    .param p1, "fragment"    # Landroidx/fragment/app/Fragment;
    .param p2, "containerId"    # I
    .param p3, "isAddStack"    # Z
    .param p4, "enterAnim"    # I
    .param p5, "exitAnim"    # I
    .param p6, "popEnterAnim"    # I
    .param p7, "popExitAnim"    # I

    .line 914
    const/4 v3, 0x0

    move-object v0, p0

    move-object v1, p1

    move v2, p2

    move v4, p3

    move v5, p4

    move v6, p5

    move v7, p6

    move/from16 v8, p7

    invoke-static/range {v0 .. v8}, Lcom/blankj/utilcode/util/FragmentUtils;->replace(Landroidx/fragment/app/FragmentManager;Landroidx/fragment/app/Fragment;ILjava/lang/String;ZIIII)V

    .line 916
    return-void
.end method

.method public static varargs replace(Landroidx/fragment/app/FragmentManager;Landroidx/fragment/app/Fragment;IZ[Landroid/view/View;)V
    .locals 6
    .param p0, "fm"    # Landroidx/fragment/app/FragmentManager;
    .param p1, "fragment"    # Landroidx/fragment/app/Fragment;
    .param p2, "containerId"    # I
    .param p3, "isAddStack"    # Z
    .param p4, "sharedElements"    # [Landroid/view/View;

    .line 949
    const/4 v3, 0x0

    move-object v0, p0

    move-object v1, p1

    move v2, p2

    move v4, p3

    move-object v5, p4

    invoke-static/range {v0 .. v5}, Lcom/blankj/utilcode/util/FragmentUtils;->replace(Landroidx/fragment/app/FragmentManager;Landroidx/fragment/app/Fragment;ILjava/lang/String;Z[Landroid/view/View;)V

    .line 950
    return-void
.end method

.method public static varargs replace(Landroidx/fragment/app/FragmentManager;Landroidx/fragment/app/Fragment;I[Landroid/view/View;)V
    .locals 6
    .param p0, "fm"    # Landroidx/fragment/app/FragmentManager;
    .param p1, "fragment"    # Landroidx/fragment/app/Fragment;
    .param p2, "containerId"    # I
    .param p3, "sharedElements"    # [Landroid/view/View;

    .line 931
    const/4 v3, 0x0

    const/4 v4, 0x0

    move-object v0, p0

    move-object v1, p1

    move v2, p2

    move-object v5, p3

    invoke-static/range {v0 .. v5}, Lcom/blankj/utilcode/util/FragmentUtils;->replace(Landroidx/fragment/app/FragmentManager;Landroidx/fragment/app/Fragment;ILjava/lang/String;Z[Landroid/view/View;)V

    .line 932
    return-void
.end method

.method public static setBackground(Landroidx/fragment/app/Fragment;Landroid/graphics/drawable/Drawable;)V
    .locals 1
    .param p0, "fragment"    # Landroidx/fragment/app/Fragment;
    .param p1, "background"    # Landroid/graphics/drawable/Drawable;

    .line 1811
    invoke-virtual {p0}, Landroidx/fragment/app/Fragment;->getView()Landroid/view/View;

    move-result-object v0

    .line 1812
    .local v0, "view":Landroid/view/View;
    if-nez v0, :cond_0

    return-void

    .line 1813
    :cond_0
    nop

    .line 1814
    invoke-virtual {v0, p1}, Landroid/view/View;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 1818
    return-void
.end method

.method public static setBackgroundColor(Landroidx/fragment/app/Fragment;I)V
    .locals 1
    .param p0, "fragment"    # Landroidx/fragment/app/Fragment;
    .param p1, "color"    # I

    .line 1784
    invoke-virtual {p0}, Landroidx/fragment/app/Fragment;->getView()Landroid/view/View;

    move-result-object v0

    .line 1785
    .local v0, "view":Landroid/view/View;
    if-eqz v0, :cond_0

    .line 1786
    invoke-virtual {v0, p1}, Landroid/view/View;->setBackgroundColor(I)V

    .line 1788
    :cond_0
    return-void
.end method

.method public static setBackgroundResource(Landroidx/fragment/app/Fragment;I)V
    .locals 1
    .param p0, "fragment"    # Landroidx/fragment/app/Fragment;
    .param p1, "resId"    # I

    .line 1798
    invoke-virtual {p0}, Landroidx/fragment/app/Fragment;->getView()Landroid/view/View;

    move-result-object v0

    .line 1799
    .local v0, "view":Landroid/view/View;
    if-eqz v0, :cond_0

    .line 1800
    invoke-virtual {v0, p1}, Landroid/view/View;->setBackgroundResource(I)V

    .line 1802
    :cond_0
    return-void
.end method

.method public static show(Landroidx/fragment/app/Fragment;)V
    .locals 4
    .param p0, "show"    # Landroidx/fragment/app/Fragment;

    .line 503
    const/4 v0, 0x0

    invoke-static {p0, v0}, Lcom/blankj/utilcode/util/FragmentUtils;->putArgs(Landroidx/fragment/app/Fragment;Z)V

    .line 504
    invoke-virtual {p0}, Landroidx/fragment/app/Fragment;->getFragmentManager()Landroidx/fragment/app/FragmentManager;

    move-result-object v1

    const/4 v2, 0x1

    new-array v2, v2, [Landroidx/fragment/app/Fragment;

    aput-object p0, v2, v0

    const/4 v0, 0x2

    const/4 v3, 0x0

    invoke-static {v0, v1, v3, v2}, Lcom/blankj/utilcode/util/FragmentUtils;->operateNoAnim(ILandroidx/fragment/app/FragmentManager;Landroidx/fragment/app/Fragment;[Landroidx/fragment/app/Fragment;)V

    .line 505
    return-void
.end method

.method public static show(Landroidx/fragment/app/FragmentManager;)V
    .locals 4
    .param p0, "fm"    # Landroidx/fragment/app/FragmentManager;

    .line 513
    invoke-static {p0}, Lcom/blankj/utilcode/util/FragmentUtils;->getFragments(Landroidx/fragment/app/FragmentManager;)Ljava/util/List;

    move-result-object v0

    .line 514
    .local v0, "fragments":Ljava/util/List;, "Ljava/util/List<Landroidx/fragment/app/Fragment;>;"
    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    const/4 v3, 0x0

    if-eqz v2, :cond_0

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Landroidx/fragment/app/Fragment;

    .line 515
    .local v2, "show":Landroidx/fragment/app/Fragment;
    invoke-static {v2, v3}, Lcom/blankj/utilcode/util/FragmentUtils;->putArgs(Landroidx/fragment/app/Fragment;Z)V

    .line 516
    .end local v2    # "show":Landroidx/fragment/app/Fragment;
    goto :goto_0

    .line 517
    :cond_0
    new-array v1, v3, [Landroidx/fragment/app/Fragment;

    invoke-interface {v0, v1}, Ljava/util/List;->toArray([Ljava/lang/Object;)[Ljava/lang/Object;

    move-result-object v1

    check-cast v1, [Landroidx/fragment/app/Fragment;

    const/4 v2, 0x2

    const/4 v3, 0x0

    invoke-static {v2, p0, v3, v1}, Lcom/blankj/utilcode/util/FragmentUtils;->operateNoAnim(ILandroidx/fragment/app/FragmentManager;Landroidx/fragment/app/Fragment;[Landroidx/fragment/app/Fragment;)V

    .line 518
    return-void
.end method

.method public static showHide(ILjava/util/List;)V
    .locals 1
    .param p0, "showIndex"    # I
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(I",
            "Ljava/util/List<",
            "Landroidx/fragment/app/Fragment;",
            ">;)V"
        }
    .end annotation

    .line 581
    .local p1, "fragments":Ljava/util/List;, "Ljava/util/List<Landroidx/fragment/app/Fragment;>;"
    invoke-interface {p1, p0}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroidx/fragment/app/Fragment;

    invoke-static {v0, p1}, Lcom/blankj/utilcode/util/FragmentUtils;->showHide(Landroidx/fragment/app/Fragment;Ljava/util/List;)V

    .line 582
    return-void
.end method

.method public static showHide(ILjava/util/List;IIII)V
    .locals 7
    .param p0, "showIndex"    # I
    .param p2, "enterAnim"    # I
    .param p3, "exitAnim"    # I
    .param p4, "popEnterAnim"    # I
    .param p5, "popExitAnim"    # I
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(I",
            "Ljava/util/List<",
            "Landroidx/fragment/app/Fragment;",
            ">;IIII)V"
        }
    .end annotation

    .line 623
    .local p1, "fragments":Ljava/util/List;, "Ljava/util/List<Landroidx/fragment/app/Fragment;>;"
    invoke-interface {p1, p0}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    move-object v1, v0

    check-cast v1, Landroidx/fragment/app/Fragment;

    move-object v2, p1

    move v3, p2

    move v4, p3

    move v5, p4

    move v6, p5

    invoke-static/range {v1 .. v6}, Lcom/blankj/utilcode/util/FragmentUtils;->showHide(Landroidx/fragment/app/Fragment;Ljava/util/List;IIII)V

    .line 624
    return-void
.end method

.method public static varargs showHide(I[Landroidx/fragment/app/Fragment;)V
    .locals 1
    .param p0, "showIndex"    # I
    .param p1, "fragments"    # [Landroidx/fragment/app/Fragment;

    .line 561
    aget-object v0, p1, p0

    invoke-static {v0, p1}, Lcom/blankj/utilcode/util/FragmentUtils;->showHide(Landroidx/fragment/app/Fragment;[Landroidx/fragment/app/Fragment;)V

    .line 562
    return-void
.end method

.method public static showHide(Landroidx/fragment/app/Fragment;Landroidx/fragment/app/Fragment;)V
    .locals 1
    .param p0, "show"    # Landroidx/fragment/app/Fragment;
    .param p1, "hide"    # Landroidx/fragment/app/Fragment;

    .line 551
    invoke-static {p1}, Ljava/util/Collections;->singletonList(Ljava/lang/Object;)Ljava/util/List;

    move-result-object v0

    invoke-static {p0, v0}, Lcom/blankj/utilcode/util/FragmentUtils;->showHide(Landroidx/fragment/app/Fragment;Ljava/util/List;)V

    .line 552
    return-void
.end method

.method public static showHide(Landroidx/fragment/app/Fragment;Landroidx/fragment/app/Fragment;IIII)V
    .locals 6
    .param p0, "show"    # Landroidx/fragment/app/Fragment;
    .param p1, "hide"    # Landroidx/fragment/app/Fragment;
    .param p2, "enterAnim"    # I
    .param p3, "exitAnim"    # I
    .param p4, "popEnterAnim"    # I
    .param p5, "popExitAnim"    # I

    .line 609
    invoke-static {p1}, Ljava/util/Collections;->singletonList(Ljava/lang/Object;)Ljava/util/List;

    move-result-object v1

    move-object v0, p0

    move v2, p2

    move v3, p3

    move v4, p4

    move v5, p5

    invoke-static/range {v0 .. v5}, Lcom/blankj/utilcode/util/FragmentUtils;->showHide(Landroidx/fragment/app/Fragment;Ljava/util/List;IIII)V

    .line 610
    return-void
.end method

.method public static showHide(Landroidx/fragment/app/Fragment;Ljava/util/List;)V
    .locals 3
    .param p0, "show"    # Landroidx/fragment/app/Fragment;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroidx/fragment/app/Fragment;",
            "Ljava/util/List<",
            "Landroidx/fragment/app/Fragment;",
            ">;)V"
        }
    .end annotation

    .line 591
    .local p1, "hide":Ljava/util/List;, "Ljava/util/List<Landroidx/fragment/app/Fragment;>;"
    invoke-interface {p1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    const/4 v2, 0x0

    if-eqz v1, :cond_1

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroidx/fragment/app/Fragment;

    .line 592
    .local v1, "fragment":Landroidx/fragment/app/Fragment;
    if-eq v1, p0, :cond_0

    const/4 v2, 0x1

    :cond_0
    invoke-static {v1, v2}, Lcom/blankj/utilcode/util/FragmentUtils;->putArgs(Landroidx/fragment/app/Fragment;Z)V

    .line 593
    .end local v1    # "fragment":Landroidx/fragment/app/Fragment;
    goto :goto_0

    .line 594
    :cond_1
    invoke-virtual {p0}, Landroidx/fragment/app/Fragment;->getFragmentManager()Landroidx/fragment/app/FragmentManager;

    move-result-object v0

    new-array v1, v2, [Landroidx/fragment/app/Fragment;

    invoke-interface {p1, v1}, Ljava/util/List;->toArray([Ljava/lang/Object;)[Ljava/lang/Object;

    move-result-object v1

    check-cast v1, [Landroidx/fragment/app/Fragment;

    const/16 v2, 0x8

    invoke-static {v2, v0, p0, v1}, Lcom/blankj/utilcode/util/FragmentUtils;->operateNoAnim(ILandroidx/fragment/app/FragmentManager;Landroidx/fragment/app/Fragment;[Landroidx/fragment/app/Fragment;)V

    .line 595
    return-void
.end method

.method public static showHide(Landroidx/fragment/app/Fragment;Ljava/util/List;IIII)V
    .locals 4
    .param p0, "show"    # Landroidx/fragment/app/Fragment;
    .param p2, "enterAnim"    # I
    .param p3, "exitAnim"    # I
    .param p4, "popEnterAnim"    # I
    .param p5, "popExitAnim"    # I
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroidx/fragment/app/Fragment;",
            "Ljava/util/List<",
            "Landroidx/fragment/app/Fragment;",
            ">;IIII)V"
        }
    .end annotation

    .line 637
    .local p1, "hide":Ljava/util/List;, "Ljava/util/List<Landroidx/fragment/app/Fragment;>;"
    invoke-interface {p1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    const/4 v2, 0x0

    if-eqz v1, :cond_1

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroidx/fragment/app/Fragment;

    .line 638
    .local v1, "fragment":Landroidx/fragment/app/Fragment;
    if-eq v1, p0, :cond_0

    const/4 v2, 0x1

    :cond_0
    invoke-static {v1, v2}, Lcom/blankj/utilcode/util/FragmentUtils;->putArgs(Landroidx/fragment/app/Fragment;Z)V

    .line 639
    .end local v1    # "fragment":Landroidx/fragment/app/Fragment;
    goto :goto_0

    .line 640
    :cond_1
    invoke-virtual {p0}, Landroidx/fragment/app/Fragment;->getFragmentManager()Landroidx/fragment/app/FragmentManager;

    move-result-object v0

    .line 641
    .local v0, "fm":Landroidx/fragment/app/FragmentManager;
    if-eqz v0, :cond_2

    .line 642
    invoke-virtual {v0}, Landroidx/fragment/app/FragmentManager;->beginTransaction()Landroidx/fragment/app/FragmentTransaction;

    move-result-object v1

    .line 643
    .local v1, "ft":Landroidx/fragment/app/FragmentTransaction;
    invoke-static {v1, p2, p3, p4, p5}, Lcom/blankj/utilcode/util/FragmentUtils;->addAnim(Landroidx/fragment/app/FragmentTransaction;IIII)V

    .line 644
    new-array v2, v2, [Landroidx/fragment/app/Fragment;

    invoke-interface {p1, v2}, Ljava/util/List;->toArray([Ljava/lang/Object;)[Ljava/lang/Object;

    move-result-object v2

    check-cast v2, [Landroidx/fragment/app/Fragment;

    const/16 v3, 0x8

    invoke-static {v3, v0, v1, p0, v2}, Lcom/blankj/utilcode/util/FragmentUtils;->operate(ILandroidx/fragment/app/FragmentManager;Landroidx/fragment/app/FragmentTransaction;Landroidx/fragment/app/Fragment;[Landroidx/fragment/app/Fragment;)V

    .line 646
    .end local v1    # "ft":Landroidx/fragment/app/FragmentTransaction;
    :cond_2
    return-void
.end method

.method public static varargs showHide(Landroidx/fragment/app/Fragment;[Landroidx/fragment/app/Fragment;)V
    .locals 1
    .param p0, "show"    # Landroidx/fragment/app/Fragment;
    .param p1, "hide"    # [Landroidx/fragment/app/Fragment;

    .line 571
    invoke-static {p1}, Ljava/util/Arrays;->asList([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v0

    invoke-static {p0, v0}, Lcom/blankj/utilcode/util/FragmentUtils;->showHide(Landroidx/fragment/app/Fragment;Ljava/util/List;)V

    .line 572
    return-void
.end method
